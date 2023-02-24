//
// This file was auto-generated using the following command:
//
// jai first.jai
//



FST_RDLOAD :: "FSTLOAD | ";

_iobuf :: struct {
    _Placeholder: *void;
}
#run {
    instance: _iobuf;
    assert(((cast(*void)(*instance._Placeholder)) - cast(*void)(*instance)) == 0, "_iobuf._Placeholder has unexpected offset % instead of 0", ((cast(*void)(*instance._Placeholder)) - cast(*void)(*instance)));
    assert(size_of(type_of(_iobuf._Placeholder)) == 8, "_iobuf._Placeholder has unexpected size % instead of 8", size_of(type_of(_iobuf._Placeholder)));
    assert(size_of(_iobuf) == 8, "_iobuf has size % instead of 8", size_of(_iobuf));
}

FILE :: _iobuf;

fstHandle :: u32;
fstEnumHandle :: u32;

fstWriterPackType :: enum s32 {
    ZLIB   :: 0;
    FASTLZ :: 1;
    LZ4    :: 2;

    FST_WR_PT_ZLIB   :: ZLIB;
    FST_WR_PT_FASTLZ :: FASTLZ;
    FST_WR_PT_LZ4    :: LZ4;
}

fstFileType :: enum s32 {
    MIN          :: 0;

    VERILOG      :: 0;
    VHDL         :: 1;
    VERILOG_VHDL :: 2;

    MAX          :: 2;

    FST_FT_MIN          :: MIN;

    FST_FT_VERILOG      :: VERILOG;
    FST_FT_VHDL         :: VHDL;
    FST_FT_VERILOG_VHDL :: VERILOG_VHDL;

    FST_FT_MAX          :: MAX;
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

    FST_BL_HDR               :: HDR;
    FST_BL_VCDATA            :: VCDATA;
    FST_BL_BLACKOUT          :: BLACKOUT;
    FST_BL_GEOM              :: GEOM;
    FST_BL_HIER              :: HIER;
    FST_BL_VCDATA_DYN_ALIAS  :: VCDATA_DYN_ALIAS;
    FST_BL_HIER_LZ4          :: HIER_LZ4;
    FST_BL_HIER_LZ4DUO       :: HIER_LZ4DUO;
    FST_BL_VCDATA_DYN_ALIAS2 :: VCDATA_DYN_ALIAS2;

    FST_BL_ZWRAPPER          :: ZWRAPPER;
    FST_BL_SKIP              :: SKIP;
}

fstScopeType :: enum s32 {
    MIN               :: 0;

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

    FST_ST_MIN               :: MIN;

    FST_ST_VCD_MODULE        :: VCD_MODULE;
    FST_ST_VCD_TASK          :: VCD_TASK;
    FST_ST_VCD_FUNCTION      :: VCD_FUNCTION;
    FST_ST_VCD_BEGIN         :: VCD_BEGIN;
    FST_ST_VCD_FORK          :: VCD_FORK;
    FST_ST_VCD_GENERATE      :: VCD_GENERATE;
    FST_ST_VCD_STRUCT        :: VCD_STRUCT;
    FST_ST_VCD_UNION         :: VCD_UNION;
    FST_ST_VCD_CLASS         :: VCD_CLASS;
    FST_ST_VCD_INTERFACE     :: VCD_INTERFACE;
    FST_ST_VCD_PACKAGE       :: VCD_PACKAGE;
    FST_ST_VCD_PROGRAM       :: VCD_PROGRAM;

    FST_ST_VHDL_ARCHITECTURE :: VHDL_ARCHITECTURE;
    FST_ST_VHDL_PROCEDURE    :: VHDL_PROCEDURE;
    FST_ST_VHDL_FUNCTION     :: VHDL_FUNCTION;
    FST_ST_VHDL_RECORD       :: VHDL_RECORD;
    FST_ST_VHDL_PROCESS      :: VHDL_PROCESS;
    FST_ST_VHDL_BLOCK        :: VHDL_BLOCK;
    FST_ST_VHDL_FOR_GENERATE :: VHDL_FOR_GENERATE;
    FST_ST_VHDL_IF_GENERATE  :: VHDL_IF_GENERATE;
    FST_ST_VHDL_GENERATE     :: VHDL_GENERATE;
    FST_ST_VHDL_PACKAGE      :: VHDL_PACKAGE;

    FST_ST_MAX               :: MAX;

    FST_ST_GEN_ATTRBEGIN     :: GEN_ATTRBEGIN;
    FST_ST_GEN_ATTREND       :: GEN_ATTREND;

    FST_ST_VCD_SCOPE         :: VCD_SCOPE;
    FST_ST_VCD_UPSCOPE       :: VCD_UPSCOPE;
}

fstVarType :: enum s32 {
    MIN                :: 0;

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

    FST_VT_MIN                :: MIN;

    FST_VT_VCD_EVENT          :: VCD_EVENT;
    FST_VT_VCD_INTEGER        :: VCD_INTEGER;
    FST_VT_VCD_PARAMETER      :: VCD_PARAMETER;
    FST_VT_VCD_REAL           :: VCD_REAL;
    FST_VT_VCD_REAL_PARAMETER :: VCD_REAL_PARAMETER;
    FST_VT_VCD_REG            :: VCD_REG;
    FST_VT_VCD_SUPPLY0        :: VCD_SUPPLY0;
    FST_VT_VCD_SUPPLY1        :: VCD_SUPPLY1;
    FST_VT_VCD_TIME           :: VCD_TIME;
    FST_VT_VCD_TRI            :: VCD_TRI;
    FST_VT_VCD_TRIAND         :: VCD_TRIAND;
    FST_VT_VCD_TRIOR          :: VCD_TRIOR;
    FST_VT_VCD_TRIREG         :: VCD_TRIREG;
    FST_VT_VCD_TRI0           :: VCD_TRI0;
    FST_VT_VCD_TRI1           :: VCD_TRI1;
    FST_VT_VCD_WAND           :: VCD_WAND;
    FST_VT_VCD_WIRE           :: VCD_WIRE;
    FST_VT_VCD_WOR            :: VCD_WOR;
    FST_VT_VCD_PORT           :: VCD_PORT;
    FST_VT_VCD_SPARRAY        :: VCD_SPARRAY;
    FST_VT_VCD_REALTIME       :: VCD_REALTIME;

    FST_VT_GEN_STRING         :: GEN_STRING;

    FST_VT_SV_BIT             :: SV_BIT;
    FST_VT_SV_LOGIC           :: SV_LOGIC;
    FST_VT_SV_INT             :: SV_INT;
    FST_VT_SV_SHORTINT        :: SV_SHORTINT;
    FST_VT_SV_LONGINT         :: SV_LONGINT;
    FST_VT_SV_BYTE            :: SV_BYTE;
    FST_VT_SV_ENUM            :: SV_ENUM;
    FST_VT_SV_SHORTREAL       :: SV_SHORTREAL;

    FST_VT_MAX                :: MAX;
}

fstVarDir :: enum s32 {
    MIN      :: 0;

    IMPLICIT :: 0;
    INPUT    :: 1;
    OUTPUT   :: 2;
    INOUT    :: 3;
    BUFFER   :: 4;
    LINKAGE  :: 5;

    MAX      :: 5;

    FST_VD_MIN      :: MIN;

    FST_VD_IMPLICIT :: IMPLICIT;
    FST_VD_INPUT    :: INPUT;
    FST_VD_OUTPUT   :: OUTPUT;
    FST_VD_INOUT    :: INOUT;
    FST_VD_BUFFER   :: BUFFER;
    FST_VD_LINKAGE  :: LINKAGE;

    FST_VD_MAX      :: MAX;
}

fstHierType :: enum s32 {
    MIN       :: 0;

    SCOPE     :: 0;
    UPSCOPE   :: 1;
    VAR       :: 2;
    ATTRBEGIN :: 3;
    ATTREND   :: 4;

    TREEBEGIN :: 5;
    TREEEND   :: 6;

    MAX       :: 6;

    FST_HT_MIN       :: MIN;

    FST_HT_SCOPE     :: SCOPE;
    FST_HT_UPSCOPE   :: UPSCOPE;
    FST_HT_VAR       :: VAR;
    FST_HT_ATTRBEGIN :: ATTRBEGIN;
    FST_HT_ATTREND   :: ATTREND;

    FST_HT_TREEBEGIN :: TREEBEGIN;
    FST_HT_TREEEND   :: TREEEND;

    FST_HT_MAX       :: MAX;
}

fstAttrType :: enum s32 {
    MIN   :: 0;

    MISC  :: 0;
    ARRAY :: 1;
    ENUM  :: 2;
    PACK  :: 3;

    MAX   :: 3;

    FST_AT_MIN   :: MIN;

    FST_AT_MISC  :: MISC;
    FST_AT_ARRAY :: ARRAY;
    FST_AT_ENUM  :: ENUM;
    FST_AT_PACK  :: PACK;

    FST_AT_MAX   :: MAX;
}

fstMiscType :: enum s32 {
    MIN         :: 0;

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

    FST_MT_MIN         :: MIN;

    FST_MT_COMMENT     :: COMMENT;
    FST_MT_ENVVAR      :: ENVVAR;
    FST_MT_SUPVAR      :: SUPVAR;
    FST_MT_PATHNAME    :: PATHNAME;
    FST_MT_SOURCESTEM  :: SOURCESTEM;
    FST_MT_SOURCEISTEM :: SOURCEISTEM;
    FST_MT_VALUELIST   :: VALUELIST;
    FST_MT_ENUMTABLE   :: ENUMTABLE;
    FST_MT_UNKNOWN     :: UNKNOWN;

    FST_MT_MAX         :: MAX;
}

fstArrayType :: enum s32 {
    MIN      :: 0;

    NONE     :: 0;
    UNPACKED :: 1;
    PACKED   :: 2;
    SPARSE   :: 3;

    MAX      :: 3;

    FST_AR_MIN      :: MIN;

    FST_AR_NONE     :: NONE;
    FST_AR_UNPACKED :: UNPACKED;
    FST_AR_PACKED   :: PACKED;
    FST_AR_SPARSE   :: SPARSE;

    FST_AR_MAX      :: MAX;
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

    FST_EV_SV_INTEGER           :: SV_INTEGER;
    FST_EV_SV_BIT               :: SV_BIT;
    FST_EV_SV_LOGIC             :: SV_LOGIC;
    FST_EV_SV_INT               :: SV_INT;
    FST_EV_SV_SHORTINT          :: SV_SHORTINT;
    FST_EV_SV_LONGINT           :: SV_LONGINT;
    FST_EV_SV_BYTE              :: SV_BYTE;
    FST_EV_SV_UNSIGNED_INTEGER  :: SV_UNSIGNED_INTEGER;
    FST_EV_SV_UNSIGNED_BIT      :: SV_UNSIGNED_BIT;
    FST_EV_SV_UNSIGNED_LOGIC    :: SV_UNSIGNED_LOGIC;
    FST_EV_SV_UNSIGNED_INT      :: SV_UNSIGNED_INT;
    FST_EV_SV_UNSIGNED_SHORTINT :: SV_UNSIGNED_SHORTINT;
    FST_EV_SV_UNSIGNED_LONGINT  :: SV_UNSIGNED_LONGINT;
    FST_EV_SV_UNSIGNED_BYTE     :: SV_UNSIGNED_BYTE;

    FST_EV_REG                  :: REG;
    FST_EV_TIME                 :: TIME;

    FST_EV_MAX                  :: MAX;
}

fstPackType :: enum s32 {
    NONE          :: 0;
    UNPACKED      :: 1;
    PACKED        :: 2;
    TAGGED_PACKED :: 3;

    MAX           :: 3;

    FST_PT_NONE          :: NONE;
    FST_PT_UNPACKED      :: UNPACKED;
    FST_PT_PACKED        :: PACKED;
    FST_PT_TAGGED_PACKED :: TAGGED_PACKED;

    FST_PT_MAX           :: MAX;
}

fstSupplementalVarType :: enum s32 {
    MIN           :: 0;

    NONE          :: 0;

    VHDL_SIGNAL   :: 1;
    VHDL_VARIABLE :: 2;
    VHDL_CONSTANT :: 3;
    VHDL_FILE     :: 4;
    VHDL_MEMORY   :: 5;

    MAX           :: 5;

    FST_SVT_MIN           :: MIN;

    FST_SVT_NONE          :: NONE;

    FST_SVT_VHDL_SIGNAL   :: VHDL_SIGNAL;
    FST_SVT_VHDL_VARIABLE :: VHDL_VARIABLE;
    FST_SVT_VHDL_CONSTANT :: VHDL_CONSTANT;
    FST_SVT_VHDL_FILE     :: VHDL_FILE;
    FST_SVT_VHDL_MEMORY   :: VHDL_MEMORY;

    FST_SVT_MAX           :: MAX;
}

fstSupplementalDataType :: enum s32 {
    MIN                    :: 0;

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

    FST_SDT_MIN                    :: MIN;

    FST_SDT_NONE                   :: NONE;

    FST_SDT_VHDL_BOOLEAN           :: VHDL_BOOLEAN;
    FST_SDT_VHDL_BIT               :: VHDL_BIT;
    FST_SDT_VHDL_BIT_VECTOR        :: VHDL_BIT_VECTOR;
    FST_SDT_VHDL_STD_ULOGIC        :: VHDL_STD_ULOGIC;
    FST_SDT_VHDL_STD_ULOGIC_VECTOR :: VHDL_STD_ULOGIC_VECTOR;
    FST_SDT_VHDL_STD_LOGIC         :: VHDL_STD_LOGIC;
    FST_SDT_VHDL_STD_LOGIC_VECTOR  :: VHDL_STD_LOGIC_VECTOR;
    FST_SDT_VHDL_UNSIGNED          :: VHDL_UNSIGNED;
    FST_SDT_VHDL_SIGNED            :: VHDL_SIGNED;
    FST_SDT_VHDL_INTEGER           :: VHDL_INTEGER;
    FST_SDT_VHDL_REAL              :: VHDL_REAL;
    FST_SDT_VHDL_NATURAL           :: VHDL_NATURAL;
    FST_SDT_VHDL_POSITIVE          :: VHDL_POSITIVE;
    FST_SDT_VHDL_TIME              :: VHDL_TIME;
    FST_SDT_VHDL_CHARACTER         :: VHDL_CHARACTER;
    FST_SDT_VHDL_STRING            :: VHDL_STRING;

    FST_SDT_MAX                    :: MAX;

    FST_SDT_SVT_SHIFT_COUNT        :: SVT_SHIFT_COUNT;
    FST_SDT_ABS_MAX                :: ABS_MAX;
}

fstHier :: struct {
    htyp: u8;

    u:    union {
        /* if htyp == FST_HT_SCOPE */
        fstHierScope :: struct {
            typ:              u8; /* FST_ST_MIN ... FST_ST_MAX */
            name:             *u8;
            component:        *u8;
            name_length:      u32; /* strlen(u.scope.name) */
            component_length: u32; /* strlen(u.scope.component) */
        }
        #run {
            instance: fstHierScope;
            assert(((cast(*void)(*instance.typ)) - cast(*void)(*instance)) == 0, "fstHierScope.typ has unexpected offset % instead of 0", ((cast(*void)(*instance.typ)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierScope.typ)) == 1, "fstHierScope.typ has unexpected size % instead of 1", size_of(type_of(fstHierScope.typ)));
            assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 8, "fstHierScope.name has unexpected offset % instead of 8", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierScope.name)) == 8, "fstHierScope.name has unexpected size % instead of 8", size_of(type_of(fstHierScope.name)));
            assert(((cast(*void)(*instance.component)) - cast(*void)(*instance)) == 16, "fstHierScope.component has unexpected offset % instead of 16", ((cast(*void)(*instance.component)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierScope.component)) == 8, "fstHierScope.component has unexpected size % instead of 8", size_of(type_of(fstHierScope.component)));
            assert(((cast(*void)(*instance.name_length)) - cast(*void)(*instance)) == 24, "fstHierScope.name_length has unexpected offset % instead of 24", ((cast(*void)(*instance.name_length)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierScope.name_length)) == 4, "fstHierScope.name_length has unexpected size % instead of 4", size_of(type_of(fstHierScope.name_length)));
            assert(((cast(*void)(*instance.component_length)) - cast(*void)(*instance)) == 28, "fstHierScope.component_length has unexpected offset % instead of 28", ((cast(*void)(*instance.component_length)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierScope.component_length)) == 4, "fstHierScope.component_length has unexpected size % instead of 4", size_of(type_of(fstHierScope.component_length)));
            assert(size_of(fstHierScope) == 32, "fstHierScope has size % instead of 32", size_of(fstHierScope));
        }

        scope: fstHierScope;

        /* if htyp == FST_HT_VAR */
        fstHierVar :: struct {
            typ:           u8; /* FST_VT_MIN ... FST_VT_MAX */
            direction:     u8; /* FST_VD_MIN ... FST_VD_MAX */
            svt_workspace: u8; /* zeroed out by FST reader, for client code use */
            sdt_workspace: u8; /* zeroed out by FST reader, for client code use */
            sxt_workspace: u32; /* zeroed out by FST reader, for client code use */
            name:          *u8;
            length:        u32;
            handle:        fstHandle;
            name_length:   u32; /* strlen(u.var.name) */
            is_alias:      u32;
        }
        #run {
            instance: fstHierVar;
            assert(((cast(*void)(*instance.typ)) - cast(*void)(*instance)) == 0, "fstHierVar.typ has unexpected offset % instead of 0", ((cast(*void)(*instance.typ)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.typ)) == 1, "fstHierVar.typ has unexpected size % instead of 1", size_of(type_of(fstHierVar.typ)));
            assert(((cast(*void)(*instance.direction)) - cast(*void)(*instance)) == 1, "fstHierVar.direction has unexpected offset % instead of 1", ((cast(*void)(*instance.direction)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.direction)) == 1, "fstHierVar.direction has unexpected size % instead of 1", size_of(type_of(fstHierVar.direction)));
            assert(((cast(*void)(*instance.svt_workspace)) - cast(*void)(*instance)) == 2, "fstHierVar.svt_workspace has unexpected offset % instead of 2", ((cast(*void)(*instance.svt_workspace)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.svt_workspace)) == 1, "fstHierVar.svt_workspace has unexpected size % instead of 1", size_of(type_of(fstHierVar.svt_workspace)));
            assert(((cast(*void)(*instance.sdt_workspace)) - cast(*void)(*instance)) == 3, "fstHierVar.sdt_workspace has unexpected offset % instead of 3", ((cast(*void)(*instance.sdt_workspace)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.sdt_workspace)) == 1, "fstHierVar.sdt_workspace has unexpected size % instead of 1", size_of(type_of(fstHierVar.sdt_workspace)));
            assert(((cast(*void)(*instance.sxt_workspace)) - cast(*void)(*instance)) == 4, "fstHierVar.sxt_workspace has unexpected offset % instead of 4", ((cast(*void)(*instance.sxt_workspace)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.sxt_workspace)) == 4, "fstHierVar.sxt_workspace has unexpected size % instead of 4", size_of(type_of(fstHierVar.sxt_workspace)));
            assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 8, "fstHierVar.name has unexpected offset % instead of 8", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.name)) == 8, "fstHierVar.name has unexpected size % instead of 8", size_of(type_of(fstHierVar.name)));
            assert(((cast(*void)(*instance.length)) - cast(*void)(*instance)) == 16, "fstHierVar.length has unexpected offset % instead of 16", ((cast(*void)(*instance.length)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.length)) == 4, "fstHierVar.length has unexpected size % instead of 4", size_of(type_of(fstHierVar.length)));
            assert(((cast(*void)(*instance.handle)) - cast(*void)(*instance)) == 20, "fstHierVar.handle has unexpected offset % instead of 20", ((cast(*void)(*instance.handle)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.handle)) == 4, "fstHierVar.handle has unexpected size % instead of 4", size_of(type_of(fstHierVar.handle)));
            assert(((cast(*void)(*instance.name_length)) - cast(*void)(*instance)) == 24, "fstHierVar.name_length has unexpected offset % instead of 24", ((cast(*void)(*instance.name_length)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.name_length)) == 4, "fstHierVar.name_length has unexpected size % instead of 4", size_of(type_of(fstHierVar.name_length)));
            // Bitfields are currently not correctly aligned
            // assert(((cast(*void)(*instance.is_alias)) - cast(*void)(*instance)) == 28, "fstHierVar.is_alias has unexpected offset % instead of 28", ((cast(*void)(*instance.is_alias)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierVar.is_alias)) == 4, "fstHierVar.is_alias has unexpected size % instead of 4", size_of(type_of(fstHierVar.is_alias)));
            assert(size_of(fstHierVar) == 32, "fstHierVar has size % instead of 32", size_of(fstHierVar));
        }

        var:   fstHierVar;

        /* if htyp == FST_HT_ATTRBEGIN */
        fstHierAttr :: struct {
            typ:           u8; /* FST_AT_MIN ... FST_AT_MAX */
            subtype:       u8; /* from fstMiscType, fstArrayType, fstEnumValueType, fstPackType */
            name:          *u8;
            arg:           u64; /* number of array elements, struct members, or some other payload (possibly ignored) */
            arg_from_name: u64; /* for when name is overloaded as a variable-length integer (FST_AT_MISC + FST_MT_SOURCESTEM) */
            name_length:   u32; /* strlen(u.attr.name) */
        }
        #run {
            instance: fstHierAttr;
            assert(((cast(*void)(*instance.typ)) - cast(*void)(*instance)) == 0, "fstHierAttr.typ has unexpected offset % instead of 0", ((cast(*void)(*instance.typ)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierAttr.typ)) == 1, "fstHierAttr.typ has unexpected size % instead of 1", size_of(type_of(fstHierAttr.typ)));
            assert(((cast(*void)(*instance.subtype)) - cast(*void)(*instance)) == 1, "fstHierAttr.subtype has unexpected offset % instead of 1", ((cast(*void)(*instance.subtype)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierAttr.subtype)) == 1, "fstHierAttr.subtype has unexpected size % instead of 1", size_of(type_of(fstHierAttr.subtype)));
            assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 8, "fstHierAttr.name has unexpected offset % instead of 8", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierAttr.name)) == 8, "fstHierAttr.name has unexpected size % instead of 8", size_of(type_of(fstHierAttr.name)));
            assert(((cast(*void)(*instance.arg)) - cast(*void)(*instance)) == 16, "fstHierAttr.arg has unexpected offset % instead of 16", ((cast(*void)(*instance.arg)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierAttr.arg)) == 8, "fstHierAttr.arg has unexpected size % instead of 8", size_of(type_of(fstHierAttr.arg)));
            assert(((cast(*void)(*instance.arg_from_name)) - cast(*void)(*instance)) == 24, "fstHierAttr.arg_from_name has unexpected offset % instead of 24", ((cast(*void)(*instance.arg_from_name)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierAttr.arg_from_name)) == 8, "fstHierAttr.arg_from_name has unexpected size % instead of 8", size_of(type_of(fstHierAttr.arg_from_name)));
            assert(((cast(*void)(*instance.name_length)) - cast(*void)(*instance)) == 32, "fstHierAttr.name_length has unexpected offset % instead of 32", ((cast(*void)(*instance.name_length)) - cast(*void)(*instance)));
            assert(size_of(type_of(fstHierAttr.name_length)) == 4, "fstHierAttr.name_length has unexpected size % instead of 4", size_of(type_of(fstHierAttr.name_length)));
            assert(size_of(fstHierAttr) == 40, "fstHierAttr has size % instead of 40", size_of(fstHierAttr));
        }

        attr:  fstHierAttr;
    };
}
#run {
    instance: fstHier;
    assert(((cast(*void)(*instance.htyp)) - cast(*void)(*instance)) == 0, "fstHier.htyp has unexpected offset % instead of 0", ((cast(*void)(*instance.htyp)) - cast(*void)(*instance)));
    assert(size_of(type_of(fstHier.htyp)) == 1, "fstHier.htyp has unexpected size % instead of 1", size_of(type_of(fstHier.htyp)));
    assert(((cast(*void)(*instance.u)) - cast(*void)(*instance)) == 8, "fstHier.u has unexpected offset % instead of 8", ((cast(*void)(*instance.u)) - cast(*void)(*instance)));
    assert(size_of(type_of(fstHier.u)) == 40, "fstHier.u has unexpected size % instead of 40", size_of(type_of(fstHier.u)));
    assert(size_of(fstHier) == 48, "fstHier has size % instead of 48", size_of(fstHier));
}

fstETab :: struct {
    name:        *u8;
    elem_count:  u32;
    literal_arr: **u8;
    val_arr:     **u8;
}
#run {
    instance: fstETab;
    assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 0, "fstETab.name has unexpected offset % instead of 0", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
    assert(size_of(type_of(fstETab.name)) == 8, "fstETab.name has unexpected size % instead of 8", size_of(type_of(fstETab.name)));
    assert(((cast(*void)(*instance.elem_count)) - cast(*void)(*instance)) == 8, "fstETab.elem_count has unexpected offset % instead of 8", ((cast(*void)(*instance.elem_count)) - cast(*void)(*instance)));
    assert(size_of(type_of(fstETab.elem_count)) == 4, "fstETab.elem_count has unexpected size % instead of 4", size_of(type_of(fstETab.elem_count)));
    assert(((cast(*void)(*instance.literal_arr)) - cast(*void)(*instance)) == 16, "fstETab.literal_arr has unexpected offset % instead of 16", ((cast(*void)(*instance.literal_arr)) - cast(*void)(*instance)));
    assert(size_of(type_of(fstETab.literal_arr)) == 8, "fstETab.literal_arr has unexpected size % instead of 8", size_of(type_of(fstETab.literal_arr)));
    assert(((cast(*void)(*instance.val_arr)) - cast(*void)(*instance)) == 24, "fstETab.val_arr has unexpected offset % instead of 24", ((cast(*void)(*instance.val_arr)) - cast(*void)(*instance)));
    assert(size_of(type_of(fstETab.val_arr)) == 8, "fstETab.val_arr has unexpected size % instead of 8", size_of(type_of(fstETab.val_arr)));
    assert(size_of(fstETab) == 32, "fstETab has size % instead of 32", size_of(fstETab));
}

/*
* writer functions
*/
fstWriterClose :: (ctx: *void) -> void #foreign fstlib;
fstWriterCreate :: (nam: *u8, use_compressed_hier: s32) -> *void #foreign fstlib;
fstWriterCreateEnumTable :: (ctx: *void, name: *u8, elem_count: u32, min_valbits: u32, literal_arr: **u8, val_arr: **u8) -> fstEnumHandle #foreign fstlib;

/* used for Verilog/SV */
fstWriterCreateVar :: (ctx: *void, vt: fstVarType, vd: fstVarDir, len: u32, nam: *u8, aliasHandle: fstHandle) -> fstHandle #foreign fstlib;

/* future expansion for VHDL and other languages.  The variable type, data type, etc map onto
the current Verilog/SV one.  The "type" string is optional for a more verbose or custom description */
fstWriterCreateVar2 :: (ctx: *void, vt: fstVarType, vd: fstVarDir, len: u32, nam: *u8, aliasHandle: fstHandle, type: *u8, svt: fstSupplementalVarType, sdt: fstSupplementalDataType) -> fstHandle #foreign fstlib;

fstWriterEmitDumpActive :: (ctx: *void, enable: s32) -> void #foreign fstlib;
fstWriterEmitEnumTableRef :: (ctx: *void, handle: fstEnumHandle) -> void #foreign fstlib;
fstWriterEmitValueChange :: (ctx: *void, handle: fstHandle, val: *void) -> void #foreign fstlib;
fstWriterEmitValueChange32 :: (ctx: *void, handle: fstHandle, bits: u32, val: u32) -> void #foreign fstlib;

fstWriterEmitValueChange64 :: (ctx: *void, handle: fstHandle, bits: u32, val: u64) -> void #foreign fstlib;

fstWriterEmitValueChangeVec32 :: (ctx: *void, handle: fstHandle, bits: u32, val: *u32) -> void #foreign fstlib;

fstWriterEmitValueChangeVec64 :: (ctx: *void, handle: fstHandle, bits: u32, val: *u64) -> void #foreign fstlib;

fstWriterEmitVariableLengthValueChange :: (ctx: *void, handle: fstHandle, val: *void, len: u32) -> void #foreign fstlib;
fstWriterEmitTimeChange :: (ctx: *void, tim: u64) -> void #foreign fstlib;
fstWriterFlushContext :: (ctx: *void) -> void #foreign fstlib;
fstWriterGetDumpSizeLimitReached :: (ctx: *void) -> s32 #foreign fstlib;
fstWriterGetFseekFailed :: (ctx: *void) -> s32 #foreign fstlib;
fstWriterSetAttrBegin :: (ctx: *void, attrtype: fstAttrType, subtype: s32, attrname: *u8, arg: u64) -> void #foreign fstlib;

fstWriterSetAttrEnd :: (ctx: *void) -> void #foreign fstlib;
fstWriterSetComment :: (ctx: *void, comm: *u8) -> void #foreign fstlib;
fstWriterSetDate :: (ctx: *void, dat: *u8) -> void #foreign fstlib;
fstWriterSetDumpSizeLimit :: (ctx: *void, numbytes: u64) -> void #foreign fstlib;
fstWriterSetEnvVar :: (ctx: *void, envvar: *u8) -> void #foreign fstlib;
fstWriterSetFileType :: (ctx: *void, filetype: fstFileType) -> void #foreign fstlib;
fstWriterSetPackType :: (ctx: *void, typ: fstWriterPackType) -> void #foreign fstlib;
fstWriterSetParallelMode :: (ctx: *void, enable: s32) -> void #foreign fstlib;
fstWriterSetRepackOnClose :: (ctx: *void, enable: s32) -> void #foreign fstlib;
fstWriterSetScope :: (ctx: *void, scopetype: fstScopeType, scopename: *u8, scopecomp: *u8) -> void #foreign fstlib;

fstWriterSetSourceInstantiationStem :: (ctx: *void, path: *u8, line: u32, use_realpath: u32) -> void #foreign fstlib;
fstWriterSetSourceStem :: (ctx: *void, path: *u8, line: u32, use_realpath: u32) -> void #foreign fstlib;
fstWriterSetTimescale :: (ctx: *void, ts: s32) -> void #foreign fstlib;
fstWriterSetTimescaleFromString :: (ctx: *void, s: *u8) -> void #foreign fstlib;
fstWriterSetTimezero :: (ctx: *void, tim: s64) -> void #foreign fstlib;
fstWriterSetUpscope :: (ctx: *void) -> void #foreign fstlib;
fstWriterSetValueList :: (ctx: *void, vl: *u8) -> void #foreign fstlib;
fstWriterSetVersion :: (ctx: *void, vers: *u8) -> void #foreign fstlib;

/*
* reader functions
*/
fstReaderClose :: (ctx: *void) -> void #foreign fstlib;
fstReaderClrFacProcessMask :: (ctx: *void, facidx: fstHandle) -> void #foreign fstlib;
fstReaderClrFacProcessMaskAll :: (ctx: *void) -> void #foreign fstlib;
fstReaderGetAliasCount :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetCurrentFlatScope :: (ctx: *void) -> *u8 #foreign fstlib;
fstReaderGetCurrentScopeUserInfo :: (ctx: *void) -> *void #foreign fstlib;
fstReaderGetCurrentScopeLen :: (ctx: *void) -> s32 #foreign fstlib;
fstReaderGetDateString :: (ctx: *void) -> *u8 #foreign fstlib;
fstReaderGetDoubleEndianMatchState :: (ctx: *void) -> s32 #foreign fstlib;
fstReaderGetDumpActivityChangeTime :: (ctx: *void, idx: u32) -> u64 #foreign fstlib;
fstReaderGetDumpActivityChangeValue :: (ctx: *void, idx: u32) -> u8 #foreign fstlib;
fstReaderGetEndTime :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetFacProcessMask :: (ctx: *void, facidx: fstHandle) -> s32 #foreign fstlib;
fstReaderGetFileType :: (ctx: *void) -> s32 #foreign fstlib;
fstReaderGetFseekFailed :: (ctx: *void) -> s32 #foreign fstlib;
fstReaderGetMaxHandle :: (ctx: *void) -> fstHandle #foreign fstlib;
fstReaderGetMemoryUsedByWriter :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetNumberDumpActivityChanges :: (ctx: *void) -> u32 #foreign fstlib;
fstReaderGetScopeCount :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetStartTime :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetTimescale :: (ctx: *void) -> s8 #foreign fstlib;
fstReaderGetTimezero :: (ctx: *void) -> s64 #foreign fstlib;
fstReaderGetValueChangeSectionCount :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetValueFromHandleAtTime :: (ctx: *void, tim: u64, facidx: fstHandle, buf: *u8) -> *u8 #foreign fstlib;
fstReaderGetVarCount :: (ctx: *void) -> u64 #foreign fstlib;
fstReaderGetVersionString :: (ctx: *void) -> *u8 #foreign fstlib;
fstReaderIterateHier :: (ctx: *void) -> *fstHier #foreign fstlib;
fstReaderIterateHierRewind :: (ctx: *void) -> s32 #foreign fstlib;
fstReaderIterBlocks :: (ctx: *void, value_change_callback: #type (user_callback_data_pointer: *void, time: u64, facidx: fstHandle, value: *u8) -> void #c_call, user_callback_data_pointer: *void, vcdhandle: *FILE) -> s32 #foreign fstlib;

fstReaderIterBlocks2 :: (ctx: *void, value_change_callback: #type (user_callback_data_pointer: *void, time: u64, facidx: fstHandle, value: *u8) -> void #c_call, value_change_callback_varlen: #type (user_callback_data_pointer: *void, time: u64, facidx: fstHandle, value: *u8, len: u32) -> void #c_call, user_callback_data_pointer: *void, vcdhandle: *FILE) -> s32 #foreign fstlib;

fstReaderIterBlocksSetNativeDoublesOnCallback :: (ctx: *void, enable: s32) -> void #foreign fstlib;
fstReaderOpen :: (nam: *u8) -> *void #foreign fstlib;
fstReaderOpenForUtilitiesOnly :: () -> *void #foreign fstlib;
fstReaderPopScope :: (ctx: *void) -> *u8 #foreign fstlib;
fstReaderProcessHier :: (ctx: *void, vcdhandle: *FILE) -> s32 #foreign fstlib;
fstReaderPushScope :: (ctx: *void, nam: *u8, user_info: *void) -> *u8 #foreign fstlib;
fstReaderResetScope :: (ctx: *void) -> void #foreign fstlib;
fstReaderSetFacProcessMask :: (ctx: *void, facidx: fstHandle) -> void #foreign fstlib;
fstReaderSetFacProcessMaskAll :: (ctx: *void) -> void #foreign fstlib;
fstReaderSetLimitTimeRange :: (ctx: *void, start_time: u64, end_time: u64) -> void #foreign fstlib;
fstReaderSetUnlimitedTimeRange :: (ctx: *void) -> void #foreign fstlib;
fstReaderSetVcdExtensions :: (ctx: *void, enable: s32) -> void #foreign fstlib;

/*
* utility functions
*/
fstUtilityBinToEscConvertedLen :: (s: *u8, len: s32) -> s32 #foreign fstlib;
fstUtilityBinToEsc :: (d: *u8, s: *u8, len: s32) -> s32 #foreign fstlib;
fstUtilityEscToBin :: (d: *u8, s: *u8, len: s32) -> s32 #foreign fstlib;
fstUtilityExtractEnumTableFromString :: (s: *u8) -> *fstETab #foreign fstlib;
fstUtilityFreeEnumTable :: (etab: *fstETab) -> void #foreign fstlib;

#scope_file

#import "Basic"; // For assert

fstlib :: #library,no_dll "modules/fst/external/fst/build/fstlib";
