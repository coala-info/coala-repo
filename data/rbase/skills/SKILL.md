---
name: rbase
description: The rbasefind tool identifies the correct memory base address for raw binary blobs by correlating internal pointers with ASCII strings. Use when user asks to find the loading address of a firmware dump, resolve pointers in a raw binary, or solve the base address problem in reverse engineering.
homepage: https://github.com/sgayou/rbasefind
---


# rbase

## Overview

The `rbasefind` tool is a high-performance utility designed to solve the "base address problem" in reverse engineering. When dealing with a raw binary blob that lacks header information (like a flash dump), you must determine the memory address where the code expects to be loaded to resolve pointers correctly. This skill uses a heuristic approach: it identifies ASCII strings within the binary and then searches for 32-bit words that, when adjusted by a candidate base address, point exactly to those strings. The address with the highest number of correlations is likely the correct base address.

## Usage Patterns

### Basic Discovery
To perform a standard scan on a 32-bit little-endian binary:
```bash
rbasefind firmware.bin
```

### Handling Large Binaries
For large files, the default string search (minimum length of 10) can produce many false positives and slow down the scan. Increase the minimum string length to significantly improve speed and accuracy:
```bash
rbasefind firmware.bin -m 100
```

### Endianness and Alignment
If the target architecture is Big-Endian (e.g., some PowerPC or MIPS systems), you must specify the flag:
```bash
rbasefind -b firmware.bin
```

If you suspect the binary is loaded at a specific alignment other than the default 0x1000 (4KB), use the offset option:
```bash
rbasefind firmware.bin -o 0x100
```

### Performance Tuning
The tool automatically uses all available CPU cores. If you need to limit resource usage in a shared environment:
```bash
rbasefind firmware.bin -t 4
```

## Expert Tips

- **Interpret the Results**: The output displays a list of candidate addresses followed by a "score" (the number of pointer-to-string intersections). A clear winner (e.g., one address having 2000 matches while others have <100) is a high-confidence result.
- **ARM Binaries**: This tool is specifically optimized for ARM (non-thumb) binaries. If you are working with Thumb mode code, the pointer correlations may be less reliable.
- **False Positives**: If the top results have very low scores (e.g., single digits), the tool may be failing to find valid pointers. Try toggling the endianness or decreasing the minimum string length (`-m`).
- **Progress Tracking**: For long-running scans on massive binaries, use the `-p` flag to see a progress bar.

## Reference documentation
- [rbasefind README](./references/github_com_sgayou_rbasefind.md)