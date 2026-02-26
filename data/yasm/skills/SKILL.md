---
name: yasm
description: Yasm is a high-performance assembler that transforms assembly source files into linkable object files or flat binaries. Use when user asks to assemble assembly files, create object files, create flat binaries, specify assembly syntax, set machine architecture, generate debug information, preprocess assembly files, define macros, add include paths, or specify output format.
homepage: https://github.com/yasm/yasm
---


# yasm

## Overview

Yasm is a modular, high-performance assembler developed as a complete rewrite of the NASM assembler. It is designed to be flexible, supporting multiple instruction sets (x86 and AMD64), various assembly syntaxes (NASM and GAS), and a wide array of output object formats. This skill provides the necessary command-line patterns and configuration logic to effectively transform assembly source files into linkable object files or flat binaries across different operating systems and debugging environments.

## Common CLI Patterns

### Basic Assembly
The most common usage involves specifying the output format and the output filename.
```bash
yasm -f <format> <source.asm> -o <output.o>
```

### Selecting Syntax (Parsers)
Yasm supports different input syntaxes. Use the `-p` flag to specify the parser (default is `nasm`).
- **NASM Syntax**: `yasm -p nasm ...`
- **GAS (GNU Assembler) Syntax**: `yasm -p gas ...`

### Architecture Specification
While Yasm often detects the architecture from the object format, you can explicitly set the machine architecture using `-m`.
- **32-bit x86**: `yasm -m x86 ...`
- **64-bit AMD64**: `yasm -m amd64 ...`

### Generating Debug Information
To include debugging symbols for use with GDB or Visual Studio, use the `-g` flag.
- **DWARF2 (Linux/Unix)**: `yasm -g dwarf2 -f elf64 source.asm`
- **STABS**: `yasm -g stabs -f elf32 source.asm`
- **CodeView 8 (Windows)**: `yasm -g cv8 -f win64 source.asm`

### Preprocessor Operations
- **Pre-process only**: Use `-e` to send the pre-processed output to stdout without assembling.
- **Include Paths**: Use `-I /path/to/include/` to add directories to the include search path.
- **Define Macros**: Use `-D MACRO_NAME=value` to define preprocessor macros.

## Supported Formats Reference

| Category | Format Codes (`-f`) |
| :--- | :--- |
| **Linux/Unix** | `elf32`, `elf64`, `elfx32` |
| **Windows** | `win32`, `win64`, `coff` |
| **macOS** | `macho32`, `macho64` |
| **Other** | `bin` (Flat binary), `rdoff2` |

## Expert Tips

- **Module Discovery**: Run `yasm --list-formats`, `yasm --list-parsers`, and `yasm --list-debug-formats` to see exactly what your specific build of Yasm supports.
- **NASM Compatibility**: Yasm is designed to be a drop-in replacement for NASM in most build systems. If a Makefile uses `nasm`, you can often simply alias it or change the variable to `yasm`.
- **Optimization**: Yasm generally performs multiple passes to optimize jump offsets automatically.
- **Error Reporting**: Use the `-w` flag to inhibit warnings or `-Werror` to treat warnings as errors for stricter CI/CD pipelines.

## Reference documentation
- [The Yasm Modular Assembler Project](./references/github_com_yasm_yasm.md)
- [Yasm Wiki Home](./references/github_com_yasm_yasm_wiki.md)