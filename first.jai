// This is just a small example of compiling a C++ library, generating bindings for it and using them.
// Look at modules/ImGui/generate.jai or modules/d3d11/generate.jai
// for more comprehensive examples of how to use the bindings generator.

#run build();


zlib_path:: "modules/fst/external/zlib";
fstlib_path:: "modules/fst/external/fst";


get_c_files :: (path : string) -> [] string {
    files := file_list(path);
    src_files : [..] string;
    for files {
        if( it[it.count -1] == #char "c" )
            array_add(*src_files, it);
        
    }
    
    return src_files;
}



/*
#run {



    #if OS == .WINDOWS {
        make_directory_if_it_does_not_exist("windows");

        build_cpp_dynamic_lib("windows/zlib", ..zlib_files, extra = .["/D _CRT_SECURE_NO_WARNINGS"] );
        build_cpp_static_lib("windows/zlib", ..zlib_files, extra = .["/D _CRT_SECURE_NO_WARNINGS"]);

        build_cpp_dynamic_lib("windows/fstlib", ..fst_files, extra = .["/D _CRT_SECURE_NO_WARNINGS", "/I\"external\\zlib\"", "windows\\zlib.lib", "libcmt.lib", "/D \"__MINGW32__\""], link = .["/libpath:\"windows\""] );
        build_cpp_static_lib("windows/fstlib", ..fst_files, extra =  .["/D _CRT_SECURE_NO_WARNINGS", "/I\"external\\zlib\"", "windows\\zlib.lib", "msvcrt.lib", "/D \"__MINGW32__\""], link = .["/libpath:\"windows\""] );
    }

    #if OS == .LINUX {



    }
}
*/


build :: () {
    set_build_options_dc(.{do_output=false});

	options := get_build_options();
    

    modules_paths: [..] string;
    array_add(*modules_paths, "modules");
    array_add(*modules_paths, ..options.import_path);  // Put these behind whatever the user specified.
    options.import_path = modules_paths;

    options.additional_linker_arguments = .["modules/fst/external/zlib/build/zlib.lib"];

    do_debug := (options.optimization_level == .RELEASE);

    zlib_files := get_c_files(zlib_path);
    fst_files := get_c_files(fstlib_path);

    make_directory_if_it_does_not_exist("modules/fst/external/zlib/build");
    make_directory_if_it_does_not_exist("modules/fst/external/fst/build");

    success := build_cpp_static_lib("modules/fst/external/zlib/build/zlib", ..zlib_files, debug=do_debug);
    success |= build_cpp_static_lib("modules/fst/external/fst/build/fstlib", ..fst_files, debug=do_debug, extra=.["/Imodules/fst/external/zlib", "modules/fst/external/zlib/build/zlib.lib", "/D__MINGW32__"]);

    if !success {
        compiler_set_workspace_status(.FAILED);
        return;
    }

    
    if !generate_bindings() {
        compiler_set_workspace_status(.FAILED);
        return;
    }
    

    w := compiler_create_workspace("Main program");
    
    options.output_type     = .EXECUTABLE;
    options.output_executable_name = "viewer";
    set_build_options(options, w);
    
    compiler_begin_intercept(w);
    add_build_file("viewer.jai", w);

    while true {
        message := compiler_wait_for_message();
        if message.kind == {
          case .TYPECHECKED;
            do_error_checking(null, message);
            
          case .COMPLETE;
            break;
        }
    }

    compiler_end_intercept(w);
}

generate_bindings :: () -> bool {
    output_filename: string;
    opts: Generate_Bindings_Options;
    {
        using opts;

        #if OS == .WINDOWS {
            output_filename          = "modules/fst/fst_bindings.jai";
            //strip_flags = 0;
        } else #if OS == .LINUX {
            output_filename          = "modules/fst/fst_bindings.jai";
            strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
        } else #if OS == .MACOS {
            // @ToDo: Determine dynamically? Customize?
            array_add(*system_include_paths, "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include");
            output_filename          = "modules/fst/fst_bindings.jai";
            strip_flags = .INLINED_FUNCTIONS; // Inlined constructor doesn't exist in the library
        } else {
            assert(false);
        }

        array_add(*system_types_to_include, "_iobuf");
        array_add(*system_types_to_include, "FILE");
        array_add(*system_types_to_include, "size_t");
        array_add(*libpaths, "modules/fst/external/fst/build");
        array_add(*libpaths, "modules/fst/external/zlib/build");
        //array_add(*libnames, "zlib");
        //array_add(*libnames, "libc");

        array_add(*libnames, "fstlib");
        array_add(*system_include_paths, GENERATOR_DEFAULT_SYSTEM_INCLUDE_PATH);
        array_add(*include_paths, "modules/fst/external/zlib");
        array_add(*source_files,  "modules/fst/external/fst/fstapi.h");
        array_add(*extra_clang_arguments, "-x", "c++");
        generate_library_declarations = false;

        // strip_flags &= ~(Strip_Flags.CONSTRUCTORS | .DESTRUCTORS);
    }

    return generate_bindings(opts, output_filename);
}

#scope_file

#import "Basic";
#import "Compiler";
#import "BuildCpp";
#import "Check";
#import "Bindings_Generator";
#import "File";
#import "File_Utilities";