#import "Basic";
#import "String";
#load "fst_bindings.jai";


/*
#import "BuildCpp";
#import "File_Utilities";
#import "File";

zlib_path:: "C:\\Users\\pyrom\\Desktop\\jai\\FST\\external\\zlib";
fstlib_path:: "C:\\Users\\pyrom\\Desktop\\jai\\FST\\external\\fst";
zlib_output :: "C:\\Users\\pyrom\\Desktop\\jai\\FST\\windows";

get_c_files :: (path : string) -> [] string {
    files := file_list(path);
    src_files : [..] string;
    for files {
        if( it[it.count -1] == #char "c" )
            array_add(*src_files, it);
        
    }
    
    return src_files;
}




#run {
    zlib_files := get_c_files(zlib_path);
    fst_files := get_c_files(fstlib_path);


    #if OS == .WINDOWS {
        make_directory_if_it_does_not_exist("windows");
        //build_cpp_dynamic_lib("windows/zlib", ..zlib_files, extra = .["/D _CRT_SECURE_NO_WARNINGS"] );
        //build_cpp_static_lib("windows/zlib", ..zlib_files, extra = .["/D _CRT_SECURE_NO_WARNINGS"]);



        build_cpp_dynamic_lib("windows/fstlib", ..fst_files, extra = .["/D _CRT_SECURE_NO_WARNINGS", "/I\"C:\\Users\\pyrom\\Desktop\\jai\\FST\\external\\zlib\"", "C:\\Users\\pyrom\\Desktop\\jai\\FST\\windows\\zlib.lib", "libcmt.lib", "/D \"__MINGW32__\""], link = .["/libpath:\"C:\\Users\\pyrom\\Desktop\\jai\\FST\\windows\""] );
        //build_cpp_static_lib("windows/fstlib", ..fst_files, extra = .["/D _CRT_SECURE_NO_WARNINGS", "/I\"F:\\Users\\Kelly\\Desktop\\jai\\FST\\external\\zlib\"", "F:\\Users\\Kelly\\Desktop\\jai\\FST\\windows\\zlib.lib", "msvcrt.lib", "/D \"__MINGW32__\""], link = .["/libpath:\"F:\\Users\\Kelly\\Desktop\\jai\\FST\\windows\""] );
    }
}
*/

iterate_callback :: (user_callback_data_pointer : *void, time : u64, facidx : fstHandle, value : *u8) -> void #c_call
{
    ctx := <<cast(*Context)user_callback_data_pointer;
    push_context ctx{
        str := to_string(value);
        print("value changed at time % to %\n", time, str);
    }
}


main :: () {
    ctx := fstReaderOpen("C:\\Users\\pyrom\\Desktop\\jai\\FST\\test.fst");
    version := fstReaderGetVersionString(ctx);
    maxHandle := fstReaderGetMaxHandle(ctx);
    startTime := fstReaderGetStartTime(ctx);
    endTime := fstReaderGetEndTime(ctx);
    print("max handle: %\n", maxHandle);
    

    hier := fstReaderIterateHier(ctx);
    while(hier != null){
        hierType := hier.htyp;
            print("% ", hierType);
            if(hierType == fstHierType.SCOPE) {
                scope := hier.u.scope;
                print("%\n", scope);
            }

            if(hierType == fstHierType.VAR) {
                var := hier.u.var;
                handle := var.handle;
                print("%\n", var );
                fstReaderClrFacProcessMaskAll(ctx);
                fstReaderSetFacProcessMask(ctx, handle);
                fstReaderIterBlocks(ctx, iterate_callback, *context, null);
            }


        hier = fstReaderIterateHier(ctx);

    }   
  
}