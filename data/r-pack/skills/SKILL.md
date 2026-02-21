---
name: r-pack
description: Functions to easily convert data to binary formats other programs/machines can understand.</p>
homepage: https://cloud.r-project.org/web/packages/pack/index.html
---

# r-pack

name: r-pack
description: Convert R values to and from raw binary vectors using Perl-style format strings. Use this skill when you need to handle binary data structures, implement network protocols, read/write custom binary file formats, or manage byte-level data representation (endianness and fixed-width types) in R.

# r-pack

## Overview
The `pack` package provides a way to serialize R objects into raw byte vectors and deserialize raw vectors back into R objects. It uses a concise format string syntax similar to Perl's `pack` and `unpack` functions, allowing for precise control over bit-depth and endianness.

## Installation
```R
install.packages("pack")
library(pack)
```

## Core Functions

### pack(fmt, ...)
Converts R values into a raw vector based on the format string `fmt`.
- **fmt**: A string containing format codes (e.g., "i", "n", "v").
- **...**: The values to be packed.

### unpack(fmt, raw)
Converts a raw vector back into R values.
- **fmt**: The format string describing the structure of the raw vector.
- **raw**: The raw vector to be parsed.

## Format Codes
Commonly used codes include:
- `a`: Null-padded string.
- `A`: Space-padded string.
- `b` / `B`: Bit string (ascending/descending order).
- `C` / `c`: Unsigned / Signed char (8-bit).
- `S` / `s`: Unsigned / Signed short (16-bit, machine order).
- `I` / `i`: Unsigned / Signed integer (32-bit, machine order).
- `L` / `l`: Unsigned / Signed long (32-bit, machine order).
- `v` / `V`: Little-endian unsigned short (16-bit) / long (32-bit).
- `n` / `N`: Big-endian unsigned short (16-bit) / long (32-bit).
- `f` / `d`: Single / Double precision float.
- `x`: Null byte (skip/insert).

## Workflows

### Creating a Binary Structure
To pack an integer, a short, and a string:
```R
# Pack a 32-bit big-endian int (N), a 16-bit little-endian int (v), and a 5-char string (a5)
raw_data <- pack("N v a5", 12345, 100, "hello")
# Result is a raw vector
```

### Parsing Binary Data
To read values back from the raw vector created above:
```R
values <- unpack("N v a5", raw_data)
# Returns a list: [[1]] 12345, [[2]] 100, [[3]] "hello"
```

### Handling Endianness
Use specific codes to ensure cross-platform compatibility:
- Use `n` or `N` for network byte order (Big-Endian).
- Use `v` or `V` for Little-Endian (common on x86 systems).

## Tips
- **Repeat Counts**: You can follow a code with a number to repeat it (e.g., `i3` for three integers).
- **Padding**: Use `x` to insert null bytes for alignment or to skip bytes during unpacking.
- **List Output**: `unpack` always returns a list. Use `unlist()` if the data types are homogeneous and you need a vector.

## Reference documentation
- [pack: Convert Values to/from Raw Vectors](./references/home_page.md)