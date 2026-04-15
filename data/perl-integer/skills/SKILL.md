---
name: perl-integer
description: The perl-integer tool performs efficient character, word, and byte n-gram analysis using a Ternary Search Tree for frequency counting. Use when user asks to analyze word sequences, perform character-level pattern matching, or identify recurring byte sequences in binary files.
homepage: https://github.com/jerry2yu/ngrams
metadata:
  docker_image: "quay.io/biocontainers/perl-integer:1.01--pl526_1"
---

# perl-integer

## Overview

The perl-integer (ngrams) tool is a C++ implementation designed for efficient character and word n-gram analysis. It distinguishes itself from traditional hash-table-based counters by utilizing a Ternary Search Tree (TST), which offers faster frequency counting and better memory management. The tool is particularly effective for large-scale text processing because it converts words into unique IDs and encodes them into compact base-256 integers. It supports three primary modes of analysis: word-level, character-level, and raw byte-level for binary files.

## Installation and Setup

Before using the tool, it must be compiled from the source code using the provided Makefile.

```bash
make
```

This generates the `ngrams` executable used in the patterns below.

## Common CLI Patterns

### Word N-gram Analysis
Use this pattern to analyze sequences of words (e.g., trigrams). This is the most common use case for natural language processing.

```bash
ngrams --type=word --n=3 --in=input_file.txt
```

### Character N-gram Analysis
Use this pattern for language identification or sub-word pattern matching by analyzing sequences of characters.

```bash
ngrams --type=character -n=3 --in=input_file.txt
```

### Byte N-gram Analysis
Use this pattern when working with binary files or non-textual data where you need to identify recurring sequences of raw bytes.

```bash
ngrams --type=byte -n=3 --in=binary_file.bin
```

## Expert Tips and Best Practices

- **Performance Advantage**: Prefer this tool over Python-based counters when dealing with extremely large datasets or deep n-gram sizes (high `n` values), as the Ternary Search Tree structure minimizes the overhead typically associated with hash collisions.
- **Binary Inspection**: The `byte` type is specifically useful for malware analysis or file format reverse engineering, as it treats the input as a raw stream without attempting to parse character encoding.
- **Memory Efficiency**: Because words are mapped to unique IDs and encoded as base-256 integers, the tool maintains a smaller memory footprint than tools that store raw strings in the frequency table.
- **Output Sorting**: By default, the tool provides output sorted by both frequency and the n-gram content, making it easy to identify the most common patterns immediately.

## Reference documentation
- [Main Repository and Usage](./references/github_com_jerry2yu_ngrams.md)
- [Byte N-gram Implementation](./references/github_com_jerry2yu_ngrams_blob_master_ByteNgrams.cpp.md)