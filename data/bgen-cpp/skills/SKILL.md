---
name: bgen-cpp
description: This tool manages and manipulates BGEN files for large-scale genetic studies through indexing, merging, and metadata editing. Use when user asks to index BGEN files, concatenate multiple datasets, modify file metadata, or extract specific genomic regions.
homepage: https://enkre.net/cgi-bin/code/bgen/
metadata:
  docker_image: "quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0"
---

# bgen-cpp

## Overview
This skill facilitates the management and manipulation of BGEN files, a common format in large-scale genetic studies like the UK Biobank. It covers the core utilities provided by the BGEN reference implementation for indexing, merging, and modifying genetic data. Use this skill to perform high-performance subsetting of genomic variants or to prepare BGEN datasets for downstream association analysis.

## Compilation and Setup
To build the tools from source, a C++11 compatible compiler is required.

```bash
# Basic build sequence
./waf configure
./waf

# To specify a specific compiler
CXX=/path/to/g++ ./waf configure
./waf

# Run unit tests to verify build
./build/test/unit/test_bgen
```

## Core Utilities

### bgenix (Indexing and Retrieval)
`bgenix` is used to create an index file (.bgen.index) which allows for rapid access to specific genomic regions.

*   **Create an index:**
    `bgenix -g example.bgen -index`
*   **List variants in a file:**
    `bgenix -g example.bgen -list`
*   **Extract specific regions:**
    `bgenix -g example.bgen -incl-range 01:10000-20000`

### cat-bgen (Concatenation)
Use `cat-bgen` to combine multiple BGEN files into a single file. This is more efficient than converting to intermediate formats.

*   **Basic concatenation:**
    `cat-bgen -g input1.bgen input2.bgen -og output.bgen`

### edit-bgen (Metadata Editing)
`edit-bgen` allows for the modification of BGEN file headers and metadata without rewriting the entire genetic data blocks.

## Common CLI Patterns
*   **BGEN to VCF Conversion:**
    The example program `bgen_to_vcf` can be used for quick inspection or conversion:
    `./build/example/bgen_to_vcf example.bgen > output.vcf`
*   **Installation Prefix:**
    To install tools to a specific directory:
    `./waf configure --prefix=/path/to/dir`
    `./waf install`

## Best Practices
*   **Indexing:** Always generate an index file immediately after creating or receiving a BGEN file to enable high-performance subsetting.
*   **Self-Contained Binaries:** In most environments, the compiled executables in `build/apps/` are self-contained and can be moved to your `PATH` without running the full install step.
*   **UK Biobank Data:** When working with UK Biobank imputed data, ensure you are using the latest version of these tools to handle the specific BGEN v1.2 features used in that dataset.



## Subcommands

| Command | Description |
|---------|-------------|
| bgenix | OPTIONS: |
| cat-bgen | Concatenate bgen files. |
| edit-bgen | Edit bgen files. |

## Reference documentation
- [BGEN Reference Implementation Overview](./references/enkre_net_cgi-bin_code_bgen_dir_1.md)