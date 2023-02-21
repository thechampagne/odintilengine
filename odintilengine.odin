package odintilengine

import "core:c"

when ODIN_OS == .Linux {
    when #config(shared, true) {
        foreign import lib "libTilengine.so" 
    } else {
        foreign import lib "libTilengine.a"
    }
} else when ODIN_OS == .Windows  {
    when #config(shared, true) {
        foreign import lib "Tilengine.dll" 
    } else {
        foreign import lib "Tilengine.lib"
    }
} else when ODIN_OS == .Darwin {
    when #config(shared, true) {
        foreign import lib "libTilengine.dylib" 
    } else {
        foreign import lib "libTilengine.a"
    }
} else {
	foreign import lib "system:Tilengine"
}

TILENGINE_VER_MAJ :: 2
TILENGINE_VER_MIN :: 14
TILENGINE_VER_REV :: 0
TILENGINE_HEADER_VERSION :: ((TILENGINE_VER_MAJ << 16) | (TILENGINE_VER_MIN << 8) | TILENGINE_VER_REV)

TLN_OVERLAY_NONE :: 0
TLN_OVERLAY_SHADOWMASK :: 0
TLN_OVERLAY_APERTURE :: 0
TLN_OVERLAY_SCANLINES :: 0
TLN_OVERLAY_CUSTOM :: 0

CWF_FULLSCREEN :: 1
CWF_VSYNC :: 2
CWF_S1 :: 4
CWF_S2 :: 8
CWF_S3 :: 12
CWF_S4 :: 16
CWF_S5 :: 20
CWF_NEAREST :: 64

TLN_Engine :: ^Engine
TLN_Tile :: ^Tile
TLN_Tileset :: ^Tileset
TLN_Tilemap :: ^Tilemap
TLN_Palette :: ^Palette
TLN_Spriteset :: ^Spriteset
TLN_Sequence :: ^Sequence
TLN_SequencePack :: ^SequencePack
TLN_Bitmap :: ^Bitmap
TLN_ObjectList :: ^ObjectList

SDL_Event :: struct #raw_union {}
TLN_VideoCallback :: #type proc(scanline : c.int)
TLN_BlendFunction :: #type proc(src : u8, dst : u8) -> u8
TLN_SDLCallback :: #type proc(event : ^SDL_Event)

TLN_TileFlags :: enum i32 {
    NONE = 0,
    FLIPX = 32768,
    FLIPY = 16384,
    ROTATE = 8192,
    PRIORITY = 4096,
    MASKED = 2048,
    TILESET = 1792,
    PALETTE = 224,
}

TLN_Blend :: enum i32 {
    NONE,
    MIX25,
    MIX50,
    MIX75,
    ADD,
    SUB,
    MOD,
    CUSTOM,
    MAX_BLEND,
    MIX = 2,
}

TLN_LayerType :: enum i32 {
    NONE,
    TILE,
    OBJECT,
    BITMAP,
}

TLN_CRT :: enum i32 {
    SLOT,
    APERTURE,
    SHADOW,
}

TLN_Player :: enum i32 {
    PLAYER1,
    PLAYER2,
    PLAYER3,
    PLAYER4,
}

TLN_Input :: enum i32 {
    NONE,
    UP,
    DOWN,
    LEFT,
    RIGHT,
    BUTTON1,
    BUTTON2,
    BUTTON3,
    BUTTON4,
    BUTTON5,
    BUTTON6,
    START,
    QUIT,
    CRT,
    P1 = 0,
    P2 = 32,
    P3 = 64,
    P4 = 96,
    A = 5,
    B = 6,
    C = 7,
    D = 8,
    E = 9,
    F = 10,
}


TLN_Error :: enum i32 {
    OK,
    OUT_OF_MEMORY,
    IDX_LAYER,
    IDX_SPRITE,
    IDX_ANIMATION,
    IDX_PICTURE,
    REF_TILESET,
    REF_TILEMAP,
    REF_SPRITESET,
    REF_PALETTE,
    REF_SEQUENCE,
    REF_SEQPACK,
    REF_BITMAP,
    NULL_POINTER,
    FILE_NOT_FOUND,
    WRONG_FORMAT,
    WRONG_SIZE,
    UNSUPPORTED,
    REF_LIST,
    IDX_PALETTE,
    TLN_MAX_ERR,
}

TLN_LogLevel :: enum i32 {
    NONE,
    ERRORS,
    VERBOSE,
}

TLN_Affine :: struct {
    angle : c.float,
    dx : c.float,
    dy : c.float,
    sx : c.float,
    sy : c.float,
}

Anon_struct1 :: struct {
    unused : u8,
    palette : u8,
    tileset : u8,
    masked : bool,
    priority : bool,
    rotated : bool,
    flipy : bool,
    flipx : bool,
}

Anon_union :: struct #raw_union {
    flags : u16,
    anon : Anon_struct1,
}

Anon_struct0 :: struct {
    index : u16,
    anon : Anon_union,
}

Tile :: struct #raw_union {
    value : u32,
    anon : Anon_struct0,
}

TLN_SequenceFrame :: struct {
    index : c.int,
    delay : c.int,
}

TLN_ColorStrip :: struct {
    delay : c.int,
    first : u8,
    count : u8,
    dir : u8,
}

TLN_SequenceInfo :: struct {
    name : [32]c.char,
    num_frames : c.int,
}

TLN_SpriteData :: struct {
    name : [64]c.char,
    x : c.int,
    y : c.int,
    w : c.int,
    h : c.int,
}

TLN_SpriteInfo :: struct {
    w : c.int,
    h : c.int,
}

TLN_TileInfo :: struct {
    index : u16,
    flags : u16,
    row : c.int,
    col : c.int,
    xoffset : c.int,
    yoffset : c.int,
    color : u8,
    type : u8,
    empty : bool,
}

TLN_ObjectInfo :: struct {
    id : u16,
    gid : u16,
    flags : u16,
    x : c.int,
    y : c.int,
    width : c.int,
    height : c.int,
    type : u8,
    visible : bool,
    name : [64]c.char,
}

TLN_TileAttributes :: struct {
    type : u8,
    priority : bool,
}

TLN_PixelMap :: struct {
    dx : i16,
    dy : i16,
}

Engine :: struct {}

Tileset :: struct {}

Tilemap :: struct {}

Palette :: struct {}

Spriteset :: struct {}

Sequence :: struct {}

SequencePack :: struct {}

Bitmap :: struct {}

ObjectList :: struct {}

TLN_TileImage :: struct {
    bitmap : TLN_Bitmap,
    id : u16,
    type : u8,
}

TLN_SpriteState :: struct {
    x : c.int,
    y : c.int,
    w : c.int,
    h : c.int,
    flags : u32,
    palette : TLN_Palette,
    spriteset : TLN_Spriteset,
    index : c.int,
    enabled : bool,
    collision : bool,
}

@(default_calling_convention="c")
foreign lib {

    
    TLN_Init :: proc(hres : c.int, vres : c.int, numlayers : c.int, numsprites : c.int, numanimations : c.int) -> TLN_Engine ---

    
    TLN_Deinit :: proc() ---

    
    TLN_DeleteContext :: proc(_context : TLN_Engine) -> bool ---

    
    TLN_SetContext :: proc(_context : TLN_Engine) -> bool ---

    
    TLN_GetContext :: proc() -> TLN_Engine ---

    
    TLN_GetWidth :: proc() -> c.int ---

    
    TLN_GetHeight :: proc() -> c.int ---

    
    TLN_GetNumObjects :: proc() -> u32 ---

    
    TLN_GetUsedMemory :: proc() -> u32 ---

    
    TLN_GetVersion :: proc() -> u32 ---

    
    TLN_GetNumLayers :: proc() -> c.int ---

    
    TLN_GetNumSprites :: proc() -> c.int ---

    
    TLN_SetBGColor :: proc(r : u8, g : u8, b : u8) ---

    
    TLN_SetBGColorFromTilemap :: proc(tilemap : TLN_Tilemap) -> bool ---

    
    TLN_DisableBGColor :: proc() ---

    
    TLN_SetBGBitmap :: proc(bitmap : TLN_Bitmap) -> bool ---

    
    TLN_SetBGPalette :: proc(palette : TLN_Palette) -> bool ---

    
    TLN_SetGlobalPalette :: proc(index : c.int, palette : TLN_Palette) -> bool ---

    
    TLN_SetRasterCallback :: proc(cb : TLN_VideoCallback) ---

    
    TLN_SetFrameCallback :: proc(cb : TLN_VideoCallback) ---

    
    TLN_SetRenderTarget :: proc(data : ^u8, pitch : c.int) ---

    
    TLN_UpdateFrame :: proc(frame : c.int) ---

    
    TLN_SetLoadPath :: proc(path : cstring) ---

    
    TLN_SetCustomBlendFunction :: proc(blend : TLN_BlendFunction) ---

    
    TLN_SetLogLevel :: proc(log_level : TLN_LogLevel) ---

    
    TLN_OpenResourcePack :: proc(filename : cstring, key : cstring) -> bool ---

    
    TLN_CloseResourcePack :: proc() ---

    
    TLN_GetGlobalPalette :: proc(index : c.int) -> TLN_Palette ---

    
    TLN_SetLastError :: proc(error : TLN_Error) ---

    
    TLN_GetLastError :: proc() -> TLN_Error ---

    
    TLN_GetErrorString :: proc(error : TLN_Error) -> cstring ---

    
    TLN_CreateWindow :: proc(overlay : cstring, flags : c.int) -> bool ---

    
    TLN_CreateWindowThread :: proc(overlay : cstring, flags : c.int) -> bool ---

    
    TLN_SetWindowTitle :: proc(title : cstring) ---

    
    TLN_ProcessWindow :: proc() -> bool ---

    
    TLN_IsWindowActive :: proc() -> bool ---

    
    TLN_GetInput :: proc(id : TLN_Input) -> bool ---

    
    TLN_EnableInput :: proc(player : TLN_Player, enable : bool) ---

    
    TLN_AssignInputJoystick :: proc(player : TLN_Player, index : c.int) ---

    
    TLN_DefineInputKey :: proc(player : TLN_Player, input : TLN_Input, keycode : u32) ---

    
    TLN_DefineInputButton :: proc(player : TLN_Player, input : TLN_Input, joybutton : u8) ---

    
    TLN_DrawFrame :: proc(frame : c.int) ---

    
    TLN_WaitRedraw :: proc() ---

    
    TLN_DeleteWindow :: proc() ---

    
    TLN_EnableBlur :: proc(mode : bool) ---

    
    TLN_ConfigCRTEffect :: proc(type : TLN_CRT, blur : bool) ---

    
    TLN_EnableCRTEffect :: proc(overlay : c.int, overlay_factor : u8, threshold : u8, v0 : u8, v1 : u8, v2 : u8, v3 : u8, blur : bool, glow_factor : u8) ---

    
    TLN_DisableCRTEffect :: proc() ---

    
    TLN_SetSDLCallback :: proc(cb : TLN_SDLCallback) ---

    
    TLN_Delay :: proc(msecs : u32) ---

    
    TLN_GetTicks :: proc() -> u32 ---

    
    TLN_GetWindowWidth :: proc() -> c.int ---

    
    TLN_GetWindowHeight :: proc() -> c.int ---

    
    TLN_CreateSpriteset :: proc(bitmap : TLN_Bitmap, data : ^TLN_SpriteData, num_entries : c.int) -> TLN_Spriteset ---

    
    TLN_LoadSpriteset :: proc(name : cstring) -> TLN_Spriteset ---

    
    TLN_CloneSpriteset :: proc(src : TLN_Spriteset) -> TLN_Spriteset ---

    
    TLN_GetSpriteInfo :: proc(spriteset : TLN_Spriteset, entry : c.int, info : ^TLN_SpriteInfo) -> bool ---

    
    TLN_GetSpritesetPalette :: proc(spriteset : TLN_Spriteset) -> TLN_Palette ---

    
    TLN_FindSpritesetSprite :: proc(spriteset : TLN_Spriteset, name : cstring) -> c.int ---

    
    TLN_SetSpritesetData :: proc(spriteset : TLN_Spriteset, entry : c.int, data : ^TLN_SpriteData, pixels : rawptr, pitch : c.int) -> bool ---

    
    TLN_DeleteSpriteset :: proc(Spriteset : TLN_Spriteset) -> bool ---

    
    TLN_CreateTileset :: proc(numtiles : c.int, width : c.int, height : c.int, palette : TLN_Palette, sp : TLN_SequencePack, attributes : ^TLN_TileAttributes) -> TLN_Tileset ---

    
    TLN_CreateImageTileset :: proc(numtiles : c.int, images : ^TLN_TileImage) -> TLN_Tileset ---

    
    TLN_LoadTileset :: proc(filename : cstring) -> TLN_Tileset ---

    
    TLN_CloneTileset :: proc(src : TLN_Tileset) -> TLN_Tileset ---

    
    TLN_SetTilesetPixels :: proc(tileset : TLN_Tileset, entry : c.int, srcdata : ^u8, srcpitch : c.int) -> bool ---

    
    TLN_GetTileWidth :: proc(tileset : TLN_Tileset) -> c.int ---

    
    TLN_GetTileHeight :: proc(tileset : TLN_Tileset) -> c.int ---

    
    TLN_GetTilesetNumTiles :: proc(tileset : TLN_Tileset) -> c.int ---

    
    TLN_GetTilesetPalette :: proc(tileset : TLN_Tileset) -> TLN_Palette ---

    
    TLN_GetTilesetSequencePack :: proc(tileset : TLN_Tileset) -> TLN_SequencePack ---

    
    TLN_DeleteTileset :: proc(tileset : TLN_Tileset) -> bool ---

    
    TLN_CreateTilemap :: proc(rows : c.int, cols : c.int, tiles : TLN_Tile, bgcolor : u32, tileset : TLN_Tileset) -> TLN_Tilemap ---

    
    TLN_LoadTilemap :: proc(filename : cstring, layername : cstring) -> TLN_Tilemap ---

    
    TLN_CloneTilemap :: proc(src : TLN_Tilemap) -> TLN_Tilemap ---

    
    TLN_GetTilemapRows :: proc(tilemap : TLN_Tilemap) -> c.int ---

    
    TLN_GetTilemapCols :: proc(tilemap : TLN_Tilemap) -> c.int ---

    
    TLN_SetTilemapTileset :: proc(tilemap : TLN_Tilemap, tileset : TLN_Tileset) -> bool ---

    
    TLN_GetTilemapTileset :: proc(tilemap : TLN_Tilemap) -> TLN_Tileset ---

    
    TLN_SetTilemapTileset2 :: proc(tilemap : TLN_Tilemap, tileset : TLN_Tileset, index : c.int) -> bool ---

    
    TLN_GetTilemapTileset2 :: proc(tilemap : TLN_Tilemap, index : c.int) -> TLN_Tileset ---

    
    TLN_GetTilemapTile :: proc(tilemap : TLN_Tilemap, row : c.int, col : c.int, tile : TLN_Tile) -> bool ---

    
    TLN_SetTilemapTile :: proc(tilemap : TLN_Tilemap, row : c.int, col : c.int, tile : TLN_Tile) -> bool ---

    
    TLN_CopyTiles :: proc(src : TLN_Tilemap, srcrow : c.int, srccol : c.int, rows : c.int, cols : c.int, dst : TLN_Tilemap, dstrow : c.int, dstcol : c.int) -> bool ---

    
    TLN_GetTilemapTiles :: proc(tilemap : TLN_Tilemap, row : c.int, col : c.int) -> TLN_Tile ---

    
    TLN_DeleteTilemap :: proc(tilemap : TLN_Tilemap) -> bool ---

    
    TLN_CreatePalette :: proc(entries : c.int) -> TLN_Palette ---

    
    TLN_LoadPalette :: proc(filename : cstring) -> TLN_Palette ---

    
    TLN_ClonePalette :: proc(src : TLN_Palette) -> TLN_Palette ---

    
    TLN_SetPaletteColor :: proc(palette : TLN_Palette, color : c.int, r : u8, g : u8, b : u8) -> bool ---

    
    TLN_MixPalettes :: proc(src1 : TLN_Palette, src2 : TLN_Palette, dst : TLN_Palette, factor : u8) -> bool ---

    
    TLN_AddPaletteColor :: proc(palette : TLN_Palette, r : u8, g : u8, b : u8, start : u8, num : u8) -> bool ---

    
    TLN_SubPaletteColor :: proc(palette : TLN_Palette, r : u8, g : u8, b : u8, start : u8, num : u8) -> bool ---

    
    TLN_ModPaletteColor :: proc(palette : TLN_Palette, r : u8, g : u8, b : u8, start : u8, num : u8) -> bool ---

    
    TLN_GetPaletteData :: proc(palette : TLN_Palette, index : c.int) -> ^u8 ---

    
    TLN_DeletePalette :: proc(palette : TLN_Palette) -> bool ---

    
    TLN_CreateBitmap :: proc(width : c.int, height : c.int, bpp : c.int) -> TLN_Bitmap ---

    
    TLN_LoadBitmap :: proc(filename : cstring) -> TLN_Bitmap ---

    
    TLN_CloneBitmap :: proc(src : TLN_Bitmap) -> TLN_Bitmap ---

    
    TLN_GetBitmapPtr :: proc(bitmap : TLN_Bitmap, x : c.int, y : c.int) -> ^u8 ---

    
    TLN_GetBitmapWidth :: proc(bitmap : TLN_Bitmap) -> c.int ---

    
    TLN_GetBitmapHeight :: proc(bitmap : TLN_Bitmap) -> c.int ---

    
    TLN_GetBitmapDepth :: proc(bitmap : TLN_Bitmap) -> c.int ---

    
    TLN_GetBitmapPitch :: proc(bitmap : TLN_Bitmap) -> c.int ---

    
    TLN_GetBitmapPalette :: proc(bitmap : TLN_Bitmap) -> TLN_Palette ---

    
    TLN_SetBitmapPalette :: proc(bitmap : TLN_Bitmap, palette : TLN_Palette) -> bool ---

    
    TLN_DeleteBitmap :: proc(bitmap : TLN_Bitmap) -> bool ---

    
    TLN_CreateObjectList :: proc() -> TLN_ObjectList ---

    
    TLN_AddTileObjectToList :: proc(list : TLN_ObjectList, id : u16, gid : u16, flags : u16, x : c.int, y : c.int) -> bool ---

    
    TLN_LoadObjectList :: proc(filename : cstring, layername : cstring) -> TLN_ObjectList ---

    
    TLN_CloneObjectList :: proc(src : TLN_ObjectList) -> TLN_ObjectList ---

    
    TLN_GetListNumObjects :: proc(list : TLN_ObjectList) -> c.int ---

    
    TLN_GetListObject :: proc(list : TLN_ObjectList, info : ^TLN_ObjectInfo) -> bool ---

    
    TLN_DeleteObjectList :: proc(list : TLN_ObjectList) -> bool ---

    
    TLN_SetLayer :: proc(nlayer : c.int, tileset : TLN_Tileset, tilemap : TLN_Tilemap) -> bool ---

    
    TLN_SetLayerTilemap :: proc(nlayer : c.int, tilemap : TLN_Tilemap) -> bool ---

    
    TLN_SetLayerBitmap :: proc(nlayer : c.int, bitmap : TLN_Bitmap) -> bool ---

    
    TLN_SetLayerPalette :: proc(nlayer : c.int, palette : TLN_Palette) -> bool ---

    
    TLN_SetLayerPosition :: proc(nlayer : c.int, hstart : c.int, vstart : c.int) -> bool ---

    
    TLN_SetLayerScaling :: proc(nlayer : c.int, xfactor : c.float, yfactor : c.float) -> bool ---

    
    TLN_SetLayerAffineTransform :: proc(nlayer : c.int, affine : ^TLN_Affine) -> bool ---

    
    TLN_SetLayerTransform :: proc(layer : c.int, angle : c.float, dx : c.float, dy : c.float, sx : c.float, sy : c.float) -> bool ---

    
    TLN_SetLayerPixelMapping :: proc(nlayer : c.int, table : ^TLN_PixelMap) -> bool ---

    
    TLN_SetLayerBlendMode :: proc(nlayer : c.int, mode : TLN_Blend, factor : u8) -> bool ---

    
    TLN_SetLayerColumnOffset :: proc(nlayer : c.int, offset : ^c.int) -> bool ---

    
    TLN_SetLayerClip :: proc(nlayer : c.int, x1 : c.int, y1 : c.int, x2 : c.int, y2 : c.int) -> bool ---

    
    TLN_DisableLayerClip :: proc(nlayer : c.int) -> bool ---

    
    TLN_SetLayerWindow :: proc(nlayer : c.int, x1 : c.int, y1 : c.int, x2 : c.int, y2 : c.int, invert : bool) -> bool ---

    
    TLN_SetLayerWindowColor :: proc(nlayer : c.int, r : u8, g : u8, b : u8, blend : TLN_Blend) -> bool ---

    
    TLN_DisableLayerWindow :: proc(nlayer : c.int) -> bool ---

    
    TLN_DisableLayerWindowColor :: proc(nlayer : c.int) -> bool ---

    
    TLN_SetLayerMosaic :: proc(nlayer : c.int, width : c.int, height : c.int) -> bool ---

    
    TLN_DisableLayerMosaic :: proc(nlayer : c.int) -> bool ---

    
    TLN_ResetLayerMode :: proc(nlayer : c.int) -> bool ---

    
    TLN_SetLayerObjects :: proc(nlayer : c.int, objects : TLN_ObjectList, tileset : TLN_Tileset) -> bool ---

    
    TLN_SetLayerPriority :: proc(nlayer : c.int, enable : bool) -> bool ---

    
    TLN_SetLayerParent :: proc(nlayer : c.int, parent : c.int) -> bool ---

    
    TLN_DisableLayerParent :: proc(nlayer : c.int) -> bool ---

    
    TLN_DisableLayer :: proc(nlayer : c.int) -> bool ---

    
    TLN_EnableLayer :: proc(nlayer : c.int) -> bool ---

    
    TLN_GetLayerType :: proc(nlayer : c.int) -> TLN_LayerType ---

    
    TLN_GetLayerPalette :: proc(nlayer : c.int) -> TLN_Palette ---

    
    TLN_GetLayerTileset :: proc(nlayer : c.int) -> TLN_Tileset ---

    
    TLN_GetLayerTilemap :: proc(nlayer : c.int) -> TLN_Tilemap ---

    
    TLN_GetLayerBitmap :: proc(nlayer : c.int) -> TLN_Bitmap ---

    
    TLN_GetLayerObjects :: proc(nlayer : c.int) -> TLN_ObjectList ---

    
    TLN_GetLayerTile :: proc(nlayer : c.int, x : c.int, y : c.int, info : ^TLN_TileInfo) -> bool ---

    
    TLN_GetLayerWidth :: proc(nlayer : c.int) -> c.int ---

    
    TLN_GetLayerHeight :: proc(nlayer : c.int) -> c.int ---

    
    TLN_GetLayerX :: proc(nlayer : c.int) -> c.int ---

    
    TLN_GetLayerY :: proc(nlayer : c.int) -> c.int ---

    
    TLN_ConfigSprite :: proc(nsprite : c.int, spriteset : TLN_Spriteset, flags : u32) -> bool ---

    
    TLN_SetSpriteSet :: proc(nsprite : c.int, spriteset : TLN_Spriteset) -> bool ---

    
    TLN_SetSpriteFlags :: proc(nsprite : c.int, flags : u32) -> bool ---

    
    TLN_EnableSpriteFlag :: proc(nsprite : c.int, flag : u32, enable : bool) -> bool ---

    
    TLN_SetSpritePivot :: proc(nsprite : c.int, px : c.float, py : c.float) -> bool ---

    
    TLN_SetSpritePosition :: proc(nsprite : c.int, x : c.int, y : c.int) -> bool ---

    
    TLN_SetSpritePicture :: proc(nsprite : c.int, entry : c.int) -> bool ---

    
    TLN_SetSpritePalette :: proc(nsprite : c.int, palette : TLN_Palette) -> bool ---

    
    TLN_SetSpriteBlendMode :: proc(nsprite : c.int, mode : TLN_Blend, factor : u8) -> bool ---

    
    TLN_SetSpriteScaling :: proc(nsprite : c.int, sx : c.float, sy : c.float) -> bool ---

    
    TLN_ResetSpriteScaling :: proc(nsprite : c.int) -> bool ---

    
    TLN_GetSpritePicture :: proc(nsprite : c.int) -> c.int ---

    
    TLN_GetSpriteX :: proc(nsprite : c.int) -> c.int ---

    
    TLN_GetSpriteY :: proc(nsprite : c.int) -> c.int ---

    
    TLN_GetAvailableSprite :: proc() -> c.int ---

    
    TLN_EnableSpriteCollision :: proc(nsprite : c.int, enable : bool) -> bool ---

    
    TLN_GetSpriteCollision :: proc(nsprite : c.int) -> bool ---

    
    TLN_GetSpriteState :: proc(nsprite : c.int, state : ^TLN_SpriteState) -> bool ---

    
    TLN_SetFirstSprite :: proc(nsprite : c.int) -> bool ---

    
    TLN_SetNextSprite :: proc(nsprite : c.int, next : c.int) -> bool ---

    
    TLN_EnableSpriteMasking :: proc(nsprite : c.int, enable : bool) -> bool ---

    
    TLN_SetSpritesMaskRegion :: proc(top_line : c.int, bottom_line : c.int) ---

    
    TLN_SetSpriteAnimation :: proc(nsprite : c.int, sequence : TLN_Sequence, loop : c.int) -> bool ---

    
    TLN_DisableSpriteAnimation :: proc(nsprite : c.int) -> bool ---

    
    TLN_PauseSpriteAnimation :: proc(index : c.int) -> bool ---

    
    TLN_ResumeSpriteAnimation :: proc(index : c.int) -> bool ---

    
    TLN_DisableAnimation :: proc(index : c.int) -> bool ---

    
    TLN_DisableSprite :: proc(nsprite : c.int) -> bool ---

    
    TLN_GetSpritePalette :: proc(nsprite : c.int) -> TLN_Palette ---

    
    TLN_CreateSequence :: proc(name : cstring, target : c.int, num_frames : c.int, frames : ^TLN_SequenceFrame) -> TLN_Sequence ---

    
    TLN_CreateCycle :: proc(name : cstring, num_strips : c.int, strips : ^TLN_ColorStrip) -> TLN_Sequence ---

    
    TLN_CreateSpriteSequence :: proc(name : cstring, spriteset : TLN_Spriteset, basename : cstring, delay : c.int) -> TLN_Sequence ---

    
    TLN_CloneSequence :: proc(src : TLN_Sequence) -> TLN_Sequence ---

    
    TLN_GetSequenceInfo :: proc(sequence : TLN_Sequence, info : ^TLN_SequenceInfo) -> bool ---

    
    TLN_DeleteSequence :: proc(sequence : TLN_Sequence) -> bool ---

    
    TLN_CreateSequencePack :: proc() -> TLN_SequencePack ---

    
    TLN_LoadSequencePack :: proc(filename : cstring) -> TLN_SequencePack ---

    
    TLN_GetSequence :: proc(sp : TLN_SequencePack, index : c.int) -> TLN_Sequence ---

    
    TLN_FindSequence :: proc(sp : TLN_SequencePack, name : cstring) -> TLN_Sequence ---

    
    TLN_GetSequencePackCount :: proc(sp : TLN_SequencePack) -> c.int ---

    
    TLN_AddSequenceToPack :: proc(sp : TLN_SequencePack, sequence : TLN_Sequence) -> bool ---

    
    TLN_DeleteSequencePack :: proc(sp : TLN_SequencePack) -> bool ---

    
    TLN_SetPaletteAnimation :: proc(index : c.int, palette : TLN_Palette, sequence : TLN_Sequence, blend : bool) -> bool ---

    
    TLN_SetPaletteAnimationSource :: proc(index : c.int, palette : TLN_Palette) -> bool ---

    
    TLN_GetAnimationState :: proc(index : c.int) -> bool ---

    
    TLN_SetAnimationDelay :: proc(index : c.int, frame : c.int, delay : c.int) -> bool ---

    
    TLN_GetAvailableAnimation :: proc() -> c.int ---

    
    TLN_DisablePaletteAnimation :: proc(index : c.int) -> bool ---

    
    TLN_LoadWorld :: proc(tmxfile : cstring, first_layer : c.int) -> bool ---

    
    TLN_SetWorldPosition :: proc(x : c.int, y : c.int) ---

    
    TLN_SetLayerParallaxFactor :: proc(nlayer : c.int, x : c.float, y : c.float) -> bool ---

    
    TLN_SetSpriteWorldPosition :: proc(nsprite : c.int, x : c.int, y : c.int) -> bool ---

   
    TLN_ReleaseWorld :: proc() ---
}
