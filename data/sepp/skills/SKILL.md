---
name: sepp
description: Seppuku is a Minecraft 1.12.2 Forge mod that provides an internal command system for managing modules, keybinds, and automation tools in anarchy environments. Use when user asks to configure module keybinds, play MIDI files with NoteBot, build the client from source, or troubleshoot coremod loading issues.
homepage: https://github.com/smirarab/sepp
metadata:
  docker_image: "quay.io/biocontainers/sepp:4.5.6--py312h87e0c26_4"
---

# sepp

## Overview
Seppuku is a lightweight, dependency-free Minecraft 1.12.2 Forge mod designed for anarchy server environments. This skill enables efficient interaction with the client's internal command system, allowing for precise control over module behavior, keybinds, and specialized automation tools like NoteBot. It also covers the technical requirements for building the client from source and debugging coremod loading issues.

## Command Line Usage
Seppuku uses an in-game chat-based command system. By default, all commands are prefixed with a period (`.`).

### Core Configuration
- **Change Command Prefix**: Use `.commands prefix [character]` to change the trigger character.
- **Keybinding**: 
  - Set a bind: `.bind [module] [key]` (e.g., `.bind fly g`).
  - Clear a bind: `.bind [module] none`.
  - Bind the Click GUI: `.bind gui [key]`.
- **Configuration Management**:
  - Save current settings: `.save`.
  - Load a specific config: `.load [name]`.
  - Export settings: `.export [name]`.

### Module Specifics
- **NoteBot**:
  1. Place `.midi` files in `/Seppuku/Config/Songs/`.
  2. Center the player above a 5x5 area of note-blocks.
  3. Enable the NoteBot module and wait for tuning.
  4. Execute: `.play [filename]` (do not include the .midi extension).
- **PacketLogger**: Monitor output via the game console or IDE console to analyze incoming/outgoing packets.
- **Search**: Use `.search` or `SearchModule` to locate specific blocks or entities in the world.

## Development and Troubleshooting
### Building from Source
1. **Environment**: Requires JDK 8 (Adoptium or Corretto recommended).
2. **Setup**: Run `./gradlew clean` followed by `./gradlew setupDecompWorkspace`.
3. **Production Build**: 
   - Edit `build.gradle` and set `buildmode = "RELEASE"`.
   - Run `./gradlew build`.
   - Locate the JAR in `build/libs/`.

### Debugging
If the client fails to load or modules do not appear, ensure the following JVM argument is present to load the coremod:
`-Dfml.coreMods.load=me.rigamortis.seppuku.impl.fml.core.SeppukuLoadingPlugin`

For IDE-based debugging, ensure `buildmode` in `build.gradle` is set to `"IDE"`.

## Best Practices
- **Compatibility**: While Seppuku is designed for compatibility with 1.12.2 modpacks, avoid running it alongside other "hack" clients simultaneously to prevent event-handling conflicts.
- **File Paths**: Always ensure custom scripts or MIDI files are placed in the specific subdirectories within the `/Seppuku/` folder created in your Minecraft directory.
- **Reloading**: Use the `.reload` command when updating capes or external plugin files to apply changes without restarting the game.

## Reference documentation
- [Seppuku Main Repository](./references/github_com_seppukudevelopment_seppuku.md)
- [Seppuku Wiki and FAQ](./references/github_com_seppukudevelopment_seppuku_wiki.md)