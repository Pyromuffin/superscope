#import "Basic";
#import "BuildCpp";
#import "File_Utilities";
#import "File";


zlib_path:: "C:\\Users\\Kelly\\Desktop\\jai\\FST\\external\\zlib";
fstlib_path:: "C:\\Users\\Kelly\\Desktop\\jai\\FST\\external\\fst";
zlib_output :: "C:\\Users\\Kelly\\Desktop\\jai\\FST\\windows";

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
    zlib_files := get_c_files(zlib_path);
    fst_files := get_c_files(fstlib_path);


    #if OS == .WINDOWS {
        make_directory_if_it_does_not_exist("windows");
        build_cpp_dynamic_lib("windows/zlib", ..zlib_files);
        //build_cpp_static_lib("windows/zlib", ..zlib_files);
        build_cpp_dynamic_lib("windows/fstlib", ..fst_files, extra = .["/I\"C:\\Users\\Kelly\\Desktop\\jai\\FST\\external\\zlib\"", "C:\\Users\\Kelly\\Desktop\\jai\\FST\\windows\\zlib.lib", "libcmt.lib", "/D \"__MINGW32__\""], link = .["/libpath:\"C:\\Users\\Kelly\\Desktop\\jai\\FST\\windows\""] );
        //build_cpp_static_lib("windows/fstlib", ..fst_files, extra = .["/I\"C:\\Users\\Kelly\\Desktop\\jai\\FST\\external\\zlib\"", "C:\\Users\\Kelly\\Desktop\\jai\\FST\\windows\\zlib.lib", "msvcrt.lib", "/D \"__MINGW32__\""], link = .["/libpath:\"C:\\Users\\Kelly\\Desktop\\jai\\FST\\windows\""] );
    }
}
*/

zlib :: #foreign_library "windows/zlib";
fstlib :: #foreign_library "windows/fstlib";

fstReaderOpen :: (nam : *u8 ) -> *void #foreign fstlib;

main :: () {

    print ("hello world!\n");

    result := fstReaderOpen("test.fst");
    print("%", result);
}