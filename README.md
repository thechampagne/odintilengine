# odintilengine

[![](https://img.shields.io/github/v/tag/thechampagne/odintilengine?label=version)](https://github.com/thechampagne/odintilengine/releases/latest) [![](https://img.shields.io/github/license/thechampagne/odintilengine)](https://github.com/thechampagne/odintilengine/blob/main/LICENSE)

Odin binding for **Tilengine** a 2D graphics engine with raster effects for retro/classic style game development.

### Example
```odin
import tile "odintilengine"

main :: proc() {
    foreground: tile.TLN_Tilemap

    tile.TLN_Init(400, 240, 1, 0, 0)
    foreground = tile.TLN_LoadTilemap("assets/sonic/Sonic_md_fg1.tmx", nil)
    tile.TLN_SetLayerTilemap(0, foreground)

    tile.TLN_CreateWindow(nil, 0)
    for tile.TLN_ProcessWindow() {
        tile.TLN_DrawFrame(0)
    }

    tile.TLN_DeleteTilemap(foreground)
    tile.TLN_Deinit()
}
```

### References
 - [Tilengine](https://github.com/megamarc/Tilengine)

### License

This repo is released under the [MPL-2.0](https://github.com/thechampagne/odintilengine/blob/main/LICENSE).
