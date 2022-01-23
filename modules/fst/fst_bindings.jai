//
// This file was auto-generated using the following command:
//
// jai f:/Users/Kelly/Desktop/jai/modules/Bindings_Generator/generate.jai
//


fstHandle :: u32;
fstEnumHandle :: u32;


fstWriterPackType :: enum s32 {
    ZLIB   :: 0;
    FASTLZ :: 1;
    LZ4    :: 2;
}

fstFileType :: enum s32 {
    VERILOG      :: 0;
    VHDL         :: 1;
    VERILOG_VHDL :: 2;
    MAX          :: 2;
}

fstBlockType :: enum s32 {
    HDR               :: 0;
    VCDATA            :: 1;
    BLACKOUT          :: 2;
    GEOM              :: 3;
    HIER              :: 4;
    VCDATA_DYN_ALIAS  :: 5;
    HIER_LZ4          :: 6;
    HIER_LZ4DUO       :: 7;
    VCDATA_DYN_ALIAS2 :: 8;
    ZWRAPPER          :: 254;
    SKIP              :: 255;
}

fstScopeType :: enum u8 {
    VCD_MODULE        :: 0;
    VCD_TASK          :: 1;
    VCD_FUNCTION      :: 2;
    VCD_BEGIN         :: 3;
    VCD_FORK          :: 4;
    VCD_GENERATE      :: 5;
    VCD_STRUCT        :: 6;
    VCD_UNION         :: 7;
    VCD_CLASS         :: 8;
    VCD_INTERFACE     :: 9;
    VCD_PACKAGE       :: 10;
    VCD_PROGRAM       :: 11;
    VHDL_ARCHITECTURE :: 12;
    VHDL_PROCEDURE    :: 13;
    VHDL_FUNCTION     :: 14;
    VHDL_RECORD       :: 15;
    VHDL_PROCESS      :: 16;
    VHDL_BLOCK        :: 17;
    VHDL_FOR_GENERATE :: 18;
    VHDL_IF_GENERATE  :: 19;
    VHDL_GENERATE     :: 20;
    VHDL_PACKAGE      :: 21;
    MAX               :: 21;
    GEN_ATTRBEGIN     :: 252;
    GEN_ATTREND       :: 253;
    VCD_SCOPE         :: 254;
    VCD_UPSCOPE       :: 255;
}

fstVarType :: enum u8 {
    VCD_EVENT          :: 0;
    VCD_INTEGER        :: 1;
    VCD_PARAMETER      :: 2;
    VCD_REAL           :: 3;
    VCD_REAL_PARAMETER :: 4;
    VCD_REG            :: 5;
    VCD_SUPPLY0        :: 6;
    VCD_SUPPLY1        :: 7;
    VCD_TIME           :: 8;
    VCD_TRI            :: 9;
    VCD_TRIAND         :: 10;
    VCD_TRIOR          :: 11;
    VCD_TRIREG         :: 12;
    VCD_TRI0           :: 13;
    VCD_TRI1           :: 14;
    VCD_WAND           :: 15;
    VCD_WIRE           :: 16;
    VCD_WOR            :: 17;
    VCD_PORT           :: 18;
    VCD_SPARRAY        :: 19;
    VCD_REALTIME       :: 20;
    GEN_STRING         :: 21;
    SV_BIT             :: 22;
    SV_LOGIC           :: 23;
    SV_INT             :: 24;
    SV_SHORTINT        :: 25;
    SV_LONGINT         :: 26;
    SV_BYTE            :: 27;
    SV_ENUM            :: 28;
    SV_SHORTREAL       :: 29;
    MAX                :: 29;
}

fstVarDir :: enum s32 {
    IMPLICIT :: 0;
    INPUT    :: 1;
    OUTPUT   :: 2;
    INOUT    :: 3;
    BUFFER   :: 4;
    LINKAGE  :: 5;
    MAX      :: 5;
}

fstHierType :: enum u8 {
    SCOPE     :: 0;
    UPSCOPE   :: 1;
    VAR       :: 2;
    ATTRBEGIN :: 3;
    ATTREND   :: 4;
    TREEBEGIN :: 5;
    TREEEND   :: 6;
    MAX       :: 6;
}

fstAttrType :: enum u8 {
    MISC  :: 0;
    ARRAY :: 1;
    ENUM  :: 2;
    PACK  :: 3;
    MAX   :: 3;
}

fstMiscType :: enum s32 {
    COMMENT     :: 0;
    ENVVAR      :: 1;
    SUPVAR      :: 2;
    PATHNAME    :: 3;
    SOURCESTEM  :: 4;
    SOURCEISTEM :: 5;
    VALUELIST   :: 6;
    ENUMTABLE   :: 7;
    UNKNOWN     :: 8;
    MAX         :: 8;
}

fstArrayType :: enum s32 {
    NONE     :: 0;
    UNPACKED :: 1;
    PACKED   :: 2;
    SPARSE   :: 3;
    MAX      :: 3;
}

fstEnumValueType :: enum s32 {
    SV_INTEGER           :: 0;
    SV_BIT               :: 1;
    SV_LOGIC             :: 2;
    SV_INT               :: 3;
    SV_SHORTINT          :: 4;
    SV_LONGINT           :: 5;
    SV_BYTE              :: 6;
    SV_UNSIGNED_INTEGER  :: 7;
    SV_UNSIGNED_BIT      :: 8;
    SV_UNSIGNED_LOGIC    :: 9;
    SV_UNSIGNED_INT      :: 10;
    SV_UNSIGNED_SHORTINT :: 11;
    SV_UNSIGNED_LONGINT  :: 12;
    SV_UNSIGNED_BYTE     :: 13;
    REG                  :: 14;
    TIME                 :: 15;
    MAX                  :: 15;
}

fstPackType :: enum s32 {
    NONE          :: 0;
    UNPACKED      :: 1;
    PACKED        :: 2;
    TAGGED_PACKED :: 3;
    MAX           :: 3;
}

fstSupplementalVarType :: enum s32 {
    NONE          :: 0;
    VHDL_SIGNAL   :: 1;
    VHDL_VARIABLE :: 2;
    VHDL_CONSTANT :: 3;
    VHDL_FILE     :: 4;
    VHDL_MEMORY   :: 5;
    MAX           :: 5;
}

fstSupplementalDataType :: enum s32 {
    NONE                   :: 0;
    VHDL_BOOLEAN           :: 1;
    VHDL_BIT               :: 2;
    VHDL_BIT_VECTOR        :: 3;
    VHDL_STD_ULOGIC        :: 4;
    VHDL_STD_ULOGIC_VECTOR :: 5;
    VHDL_STD_LOGIC         :: 6;
    VHDL_STD_LOGIC_VECTOR  :: 7;
    VHDL_UNSIGNED          :: 8;
    VHDL_SIGNED            :: 9;
    VHDL_INTEGER           :: 10;
    VHDL_REAL              :: 11;
    VHDL_NATURAL           :: 12;
    VHDL_POSITIVE          :: 13;
    VHDL_TIME              :: 14;
    VHDL_CHARACTER         :: 15;
    VHDL_STRING            :: 16;
    MAX                    :: 16;
    SVT_SHIFT_COUNT        :: 10;
    ABS_MAX                :: 1023;
}

fstHier :: struct {
    htyp: fstHierType;
    u : union {
        fstHierScope :: struct {
            typ:              fstScopeType;
            name:             c_string;
            component:        c_string;
            name_length:      u32;
            component_length: u32;
        }
        scope: fstHierScope;
        fstHierVar :: struct {
            typ:           fstVarType;
            direction:     u8;
            svt_workspace: u8;
            sdt_workspace: u8;
            sxt_workspace: u32;
            name:          c_string;
            length:        u32;
            handle:        fstHandle;
            name_length:   u32;
            is_alias:      u32 = 1; // this might be wrong??
        }
        var:   fstHierVar;
        fstHierAttr :: struct {
            typ:           fstAttrType;
            subtype:       u8;
            name:          c_string;
            arg:           u64;
            arg_from_name: u64;
            name_length:   u32;
        }
        attr:  fstHierAttr;
    }
}

fstETab :: struct {
    name:        *u8;
    elem_count:  u32;
    literal_arr: **u8;
    val_arr:     **u8;
}

value_change_callback :: #type (user_callback_data_pointer : *void, time : u64, facidx : fstHandle, value : *u8) -> void #c_call;
value_change_callback_varlen :: #type (user_callback_data_pointer : *void, time : u64,  facidx : fstHandle, value : *u8,  len : u32) -> void #c_call;

zlib :: #foreign_library "windows/zlib";
fstlib :: #foreign_library "windows/fstlib";

fstReaderClose :: (ctx : *void ) #foreign fstlib;;
fstReaderClrFacProcessMask :: (ctx : *void, facidx : fstHandle) #foreign fstlib;
fstReaderClrFacProcessMaskAll :: (ctx : *void) #foreign fstlib;
fstReaderGetAliasCount :: (ctx : *void) -> u64 #foreign fstlib;
fstReaderGetCurrentFlatScope :: (ctx : *void) -> *u8 #foreign fstlib;
fstReaderGetCurrentScopeUserInfo :: (ctx : *void) -> *void #foreign fstlib;
fstReaderGetCurrentScopeLen :: (ctx : *void) -> s32 #foreign fstlib;
fstReaderGetDateString :: (ctx : *void) -> *u8 #foreign fstlib;
fstReaderGetDoubleEndianMatchState :: (ctx : *void) -> s32 #foreign fstlib;
fstReaderGetDumpActivityChangeTime :: (ctx : *void, idx : u32) -> u64 #foreign fstlib;
fstReaderGetDumpActivityChangeValue :: (ctx : *void, idx : u32) -> u8 #foreign fstlib;
fstReaderGetEndTime :: (ctx : *void) -> u64 #foreign fstlib;
fstReaderGetFacProcessMask :: (ctx : *void,  facidx : fstHandle) -> s32 #foreign fstlib;
fstReaderGetFileType :: (ctx : *void) -> s32 #foreign fstlib;
fstReaderGetFseekFailed :: (ctx : *void) -> s32 #foreign fstlib;
fstReaderGetMaxHandle :: (ctx : *void) -> fstHandle #foreign fstlib;
fstReaderGetMemoryUsedByWriter :: (ctx : *void) -> u64 #foreign fstlib;
fstReaderGetNumberDumpActivityChanges :: (ctx : *void) -> u32 #foreign fstlib;
fstReaderGetScopeCount :: (ctx : *void) -> u64  #foreign fstlib;
fstReaderGetStartTime :: (ctx : *void) -> u64  #foreign fstlib;
fstReaderGetTimescale :: (ctx : *void) -> s8 #foreign fstlib;
fstReaderGetTimezero :: (ctx : *void) -> s64 #foreign fstlib;
fstReaderGetValueChangeSectionCount :: (ctx : *void) -> u64 #foreign fstlib;
fstReaderGetValueFromHandleAtTime :: (ctx : *void, tim : u64,  facidx : fstHandle, buf : *u8)  -> *u8 #foreign fstlib;
fstReaderGetVarCount :: (ctx : *void) -> u64 #foreign fstlib;
fstReaderGetVersionString :: (ctx : *void) -> *u8 #foreign fstlib;
fstReaderIterateHier :: (ctx : *void) -> *fstHier #foreign fstlib;
fstReaderIterateHierRewind :: (ctx : *void) -> s32 #foreign fstlib;
fstReaderIterBlocks :: (ctx : *void, callback : value_change_callback, user_callback_data_pointer : *void, vcdhandle : *u64) -> s32 #foreign fstlib;
fstReaderIterBlocks2 :: (ctx : *void, callback : value_change_callback, varlen_callback : value_change_callback_varlen, user_callback_data_pointer : *void, vcdhandle : *u64) -> s32 #foreign fstlib;
fstReaderIterBlocksSetNativeDoublesOnCallback :: (ctx : *void,  enable : s32) #foreign fstlib;
fstReaderOpen :: (nam : *u8) -> *void #foreign fstlib;
fstReaderOpenForUtilitiesOnly :: () -> *void  #foreign fstlib;
fstReaderPopScope :: (ctx : *void) -> *u8 #foreign fstlib;
fstReaderProcessHier :: (ctx : *void, vcdhandle : *u64) -> s32 #foreign fstlib;
fstReaderPushScope :: (ctx : *void, nam : *u8, user_info : *void) -> *u8 #foreign fstlib;
fstReaderResetScope :: (ctx : *void) #foreign fstlib;
fstReaderSetFacProcessMask :: (ctx : *void, facidx : fstHandle) #foreign fstlib;
fstReaderSetFacProcessMaskAll :: (ctx : *void) #foreign fstlib;
fstReaderSetLimitTimeRange :: (ctx : *void,  start_time : u64,  end_time : u64) #foreign fstlib;
fstReaderSetUnlimitedTimeRange :: (ctx : *void) #foreign fstlib;
fstReaderSetVcdExtensions :: (ctx : *void, enable : s32) #foreign fstlib;

