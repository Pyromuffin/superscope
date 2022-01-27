#scope_file

#import "Math";
#import "Basic";
#import "String";
Simp :: #import "Simp";

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
    // i guess we need to push the jai context to use jai native calls in a c_call
    ctx : Context;
    signals := <<cast(*[..] Signal)user_callback_data_pointer;
    push_context ctx {
        ProcessData(facidx, time, value, signals);
    }
}

TypeForDepth :: ($depth : int) -> Type {
    if(depth <= 8)
        return u8;
    else if (depth <= 16)
        return u16;
    else if (depth <= 32)
        return u32;
    else
        return u64;
}



GetBytesForDepth :: (depth : int) -> int {
    if(depth <= 8)
        return 8;
    else if (depth <= 16)
        return 16;
    else if (depth <= 32)
        return 32;
    else
        return 64;
}





GetSignalTransition :: (using signal : Signal, index : int) -> u64, u64 {
    time := times[index];
    value : u64;
    if(depth <= 8)
        value = xx u8s[index];
    else if (depth <= 16)
        value = xx u16s[index];
    else if (depth <= 32)
        value =  xx u32s[index];
    else
        value = u64s[index];
    
    return time, value;
}



Parse8 :: (depth : int, str : *u8) -> u8 {
    
    result : u8 = 0;
    for 0 .. depth { // vectorize, i beg.
        value := str[it] - 48;
        shift := depth - it - 1;
        result |= (value << shift);
    }

    return result;
}

Parse16 :: (depth : int, str : *u8) -> u16 {
    
    result : u16 = 0;
    for 0 .. depth { // vectorize, i beg.
        value := str[it] - 48;
        shift := depth - it - 1;
        result |= (value << shift);
    }

    return result;
}

Parse32 :: (depth : int, str : *u8) -> u32 {
    
    result : u32 = 0;
    for 0 .. depth { // vectorize, i beg.
        value := str[it] - 48;
        shift := depth - it - 1;
        result |= (value << shift);
    }

    return result;
}


Parse64 :: (depth : int, str : *u8) -> u64 {
    
    result : u64 = 0;
    for 0 .. depth { // vectorize, i beg.
        value := str[it] - 48;
        shift := depth - it - 1;
        result |= (value << shift);
    }

    return result;
}


ProcessData :: (handle : fstHandle, time : u64, c_str : *u8, signals : [..] Signal ) {
    // 48 for zero
    // 49 for one
    // looks like it is stored MSB first
    signal := *signals[handle];
    depth := signal.depth;
    size := GetBytesForDepth(depth);
    if(size == 8) {
        value := Parse8(depth, c_str);
        array_add(*signal.u8s, value);
    }
    else if(size == 16){
        value := Parse16(depth, c_str);
        array_add(*signal.u16s, value);
    }
    else if (size == 32){
        value := Parse32(depth, c_str);
        array_add(*signal.u32s, value);
    }
    else{
        value := Parse64(depth, c_str);
        array_add(*signal.u64s, value);
    }

    array_add(*signal.times, time);
}

#scope_export

clockSignal : *Signal;

Signal :: struct {
    name : string;
    depth : int;

    times : [..] u64;
    union{
        u8s : [..] u8;
        u16s : [..] u16;
        u32s : [..] u32;
        u64s : [..] u64;
    }
}


SignalToString :: (signal : Signal, lengthOfTime : u64) -> string {
    builder : String_Builder;
    init_string_builder(*builder);
    
    transitions := signal.times.count;

    transitionIndex := 0;
    nextT, currentState := GetSignalTransition(signal, transitionIndex);
    zebra : u64;

    for 0 .. lengthOfTime {
        
        if(it == nextT && transitionIndex < transitions){

            nextT, currentState = GetSignalTransition(signal, transitionIndex);
            transitionIndex += 1;
            
            if(transitionIndex < transitions)
            {
                nextT = GetSignalTransition(signal, transitionIndex);
            }


            append(*builder, "|" );
            if(currentState == 0)
                append(*builder, "_" );
            else
                append(*builder, "^");
        }
        else
        {   
            if(currentState == 0)
                append(*builder, "__" );
            else
                append(*builder, "^^");
        }
    }

    return builder_to_string(*builder);
}



LoadSignals :: (path : string) -> [..] Signal {

    ctx := fstReaderOpen( to_c_string(path) );
    version := fstReaderGetVersionString(ctx);
    maxHandle := fstReaderGetMaxHandle(ctx);
    startTime := fstReaderGetStartTime(ctx);
    endTime := fstReaderGetEndTime(ctx);
    signalCount := fstReaderGetScopeCount(ctx);
    waveCount :=  fstReaderGetMaxHandle(ctx);
    signals : [..] Signal;
    scopes : [..] fstHier;
    array_resize(*scopes, xx waveCount);
    array_resize(*signals, xx waveCount + 1);

    hier := fstReaderIterateHier(ctx);
    while(hier != null){
        hierType := hier.htyp;
            //print("% ", hierType);
            if(hierType == fstHierType.SCOPE) {
                scope := hier.u.scope;
                //print("%\n", scope);
            }

            if(hierType == fstHierType.VAR) {
                var := hier.u.var;
                handle := var.handle;
                signals[handle].depth = var.length;
                signals[handle].name = copy_string( to_string(var.name.data) ); 
                if signals[handle].name == "clk" then clockSignal = *signals[handle];

                //print("%\n", var );
                fstReaderClrFacProcessMaskAll(ctx);
                fstReaderSetFacProcessMask(ctx, handle);
                
                fstReaderIterBlocks(ctx, iterate_callback, *signals, null);
            }


        hier = fstReaderIterateHier(ctx);

    }   

    return signals;
}

CalculateSignalVertices :: (signal : Signal, length : u64) -> [..] Vector3 {

    vec3 :: make_vector3;
    output : [..] Vector3;
    //add :: (v : Vector3) -> Vector3 { array_add(*output, v); return v; }

    transitions := signal.times.count;

    t, state := GetSignalTransition(signal, 0);
    state = min(state, 1);


    cursor := vec3(0, xx state, 0);
    array_add(*output, cursor);
    
    for 1 .. transitions -1 {
        previousT := t;
        previousState := state;
        t, state = GetSignalTransition(signal, it);
        state = min(state, 1);
        dist : float = xx (t - previousT);
        cursor += vec3(1,0,0) * dist;
        array_add(*output, cursor);
        cursor.y = xx state;
        array_add(*output, cursor);
    }

    return output;
}


DrawLine :: (start : Vector3, end : Vector3, thickness : float, color : Vector4 = Vector4.{1,1,1,1} ) {
    Simp.set_shader_for_color();

    // only draws vertical or horizontal lines for now
    p0, p1, p2, p3 : Vector3;

   if( start.x - end.x == 0) { // vertical
        p0.x = start.x - thickness /2;
        p0.y = start.y;
        p0.z = 0;

        p1.x = start.x + thickness /2;
        p1.y = start.y;
        p1.z = 0;

        p2.x = start.x + thickness /2;
        p2.y = end.y;
        p2.z = 0;

        p3.x = start.x - thickness /2;
        p3.y = end.y;
        p3.z = 0;

    }
    else { // horizontal
        p0.x = start.x;
        p0.y = start.y + thickness /2;
        p0.z = 0;

        p1.x = end.x;
        p1.y = start.y + thickness /2;
        p1.z = 0;

        p2.x = end.x;
        p2.y = start.y - thickness /2;
        p2.z = 0;

        p3.x = start.x;
        p3.y = start.y - thickness /2;
        p3.z = 0;
    }

    Simp.immediate_quad(p0, p1, p2, p3, color);
}

GetTimeOfLastTransition :: () -> u64 {
    return clockSignal.times[clockSignal.times.count-1];
}


DrawSignalVerts :: ( verts : []Vector3, offset : Vector3, thickness : float, pitch : float, height : float, withFill : bool = true) {
    Simp.set_shader_for_color();

    //immediate_quad:  (p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, color := Vector4.{1,1,1,1}, uv0 := Vector2.{0,0}, uv1 := Vector2.{1,0}, uv2 := Vector2.{1,1}, uv3 := Vector2.{0, 1});

    color := make_vector4(1,1,1,1);
    dist := 0.0;

    //debug_break();

    for 0 .. (verts.count) - 2 {
        start := verts[it];
        end :=   verts[it + 1];

        if( start.x - end.x == 0) { // vertical
            p0, p1, p2, p3 : Vector3;

            p0.x = dist - thickness /2;
            p0.y = start.y * height;
            p0.z = 0;

            p1.x = dist + thickness /2;
            p1.y = start.y * height;
            p1.z = 0;

            p2.x = dist + thickness /2;
            p2.y = end.y * height;
            p2.z = 0;

            p3.x = dist - thickness /2;
            p3.y = end.y * height;
            p3.z = 0;

            Simp.immediate_quad(p0 + offset, p1 + offset, p2 + offset, p3 + offset, color);
        }
        else { // horizontal

            p0, p1, p2, p3 : Vector3;
            startX := dist;
            dist += (end.x - start.x) * pitch;

            if (withFill && start.y == 1) {

                p0.x = startX + thickness / 2;
                p0.y = start.y * height + thickness;
                p0.z = 0;

                p1.x = dist - thickness / 2;
                p1.y = start.y * height + thickness;
                p1.z = 0;

                p2.x = dist - thickness / 2;
                p2.y = -thickness / 2;
                p2.z = 0;

                p3.x = startX + thickness / 2;
                p3.y = -thickness / 2;
                p3.z = 0;

                Simp.immediate_quad(p0 + offset, p1 + offset, p2 + offset, p3 + offset, color * 0.5);
            }


            p0.x = startX;
            p0.y = start.y * height + thickness /2;
            p0.z = 0;

            p1.x = dist;
            p1.y = start.y * height + thickness /2;
            p1.z = 0;

            p2.x = dist;
            p2.y = start.y * height - thickness /2;
            p2.z = 0;

            p3.x = startX;
            p3.y = start.y * height - thickness /2;
            p3.z = 0;

            Simp.immediate_quad(p0 + offset, p1 + offset, p2 + offset, p3 + offset, color);

        }
    }

    // draw last line
    p0, p1, p2, p3 : Vector3;
    start := verts[verts.count -1];
    startX := dist;
    dist += (1000) * pitch;

    p0.x = startX;
    p0.y = start.y * height + thickness /2;
    p0.z = 0;

    p1.x = dist;
    p1.y = start.y * height + thickness /2;
    p1.z = 0;

    p2.x = dist;
    p2.y = start.y * height - thickness /2;
    p2.z = 0;

    p3.x = startX;
    p3.y = start.y * height - thickness /2;
    p3.z = 0;

    Simp.immediate_quad(p0 + offset, p1 + offset, p2 + offset, p3 + offset, color);


    Simp.immediate_flush();

}