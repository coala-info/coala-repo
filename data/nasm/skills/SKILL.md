---
name: nasm
description: NASM is an x86 assembler that translates assembly source code into various executable and object file formats using Intel-like syntax. Use when user asks to assemble source files, generate debug information, preprocess macros, or disassemble raw binary files.
homepage: https://github.com/netwide-assembler/nasm
---


# nasm

## Overview
NASM (Netwide Assembler) is a highly portable and flexible x86 assembler that uses Intel-like syntax. It is designed for modularity and supports a vast range of output formats, including flat binaries, ELF, COFF, and Mach-O. This skill provides the necessary command-line patterns and best practices to effectively translate assembly source code into executable formats or object files for linking.

## Common CLI Patterns

### Basic Assembly
To assemble a source file into a specific output format:
```bash
nasm -f <format> input.asm -o output.obj
```
Common formats (`-f`):
- `bin`: Flat binary (default, used for bootloaders/ROMs)
- `elf32` / `elf64`: Linux object files
- `win32` / `win64`: Windows object files
- `macho32` / `macho64`: macOS object files

### Debugging and Symbols
To include debug information for use with GDB or other debuggers:
```bash
nasm -f elf64 -g -F dwarf input.asm -o output.o
```
- `-g`: Enables generation of debug information.
- `-F <format>`: Selects the debug format (e.g., `dwarf`, `stabs`, `codeview`).

### Preprocessing and Macros
To view the result of the preprocessor (macros, includes, and conditionals) without assembling:
```bash
nasm -E input.asm > preprocessed.asm
```
To define a macro from the command line:
```bash
nasm -DDEBUG_LEVEL=1 -f elf64 input.asm
```

### Listing and Optimization
To generate a listing file showing the generated machine code alongside the source:
```bash
nasm -f elf64 input.asm -l input.lst
```
To control optimization passes (default is usually sufficient):
```bash
nasm -O0 input.asm  # Disable optimization
nasm -Ox input.asm  # Multi-pass optimization (recommmended)
```

## Disassembly with ndisasm
NASM includes `ndisasm`, a companion tool for disassembling raw binary files:
```bash
ndisasm -b 32 binary_file.bin
```
- `-b 16|32|64`: Sets the CPU mode (bits).
- `-o <offset>`: Sets the initial logical address.
- `-z`: (Newer versions) Forces data size handling for specific instruction streams.

## Expert Tips
- **Include Paths**: Use `-i/path/to/includes/` (note the trailing slash is often required by convention) to manage large projects with multiple `%include` files.
- **Response Files**: For projects with many arguments, use the `@filename` syntax to read command-line options from a text file.
- **Strict Typing**: Use the `strict` keyword (e.g., `push strict dword 0`) to force a specific operand size and prevent the assembler from optimizing it to a smaller size, which is useful for maintaining alignment or specific instruction patterns.
- **Section Management**: Always explicitly define your sections (`section .text`, `section .data`, `section .bss`) to ensure the linker places code and data in the correct memory segments.

## Reference documentation
- [NASM Repository Overview](./references/github_com_netwide-assembler_nasm.md)
- [NASM Commits and Version History](./references/github_com_netwide-assembler_nasm_commits_master.md)
- [NASM Issue Tracker](./references/github_com_netwide-assembler_nasm_issues.md)