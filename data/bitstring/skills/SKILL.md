---
name: bitstring
description: The bitstring tool provides classes and utilities for the creation, manipulation, and parsing of binary data at the bit level. Use when user asks to handle non-byte-aligned data, parse network packets, pack or unpack binary structures, and perform bitwise slicing or searching.
homepage: https://github.com/scott-griffiths/bitstring
---


# bitstring

## Overview
The bitstring skill enables precise control over binary data at the bit level, moving beyond the byte-oriented limitations of standard Python types. Use this skill to handle low-level data structures, parse network packets, or manipulate file formats where data is not byte-aligned. It provides a suite of classes—`Bits` for immutable data, `BitArray` for mutable data, and `BitStream` for sequential reading—alongside powerful packing and unpacking utilities.

## Core Usage Patterns

### Creation and Conversion
Initialize bitstrings from various formats using a single constructor or specific keywords.

```python
from bitstring import Bits, BitArray, pack

# From formatted strings
a = BitArray('0xff, 0b101, uint6=22')

# From specific types
b = Bits(bin='00101')
c = Bits(hex='deadbeef')
d = Bits(uint=100, length=10)

# Accessing representations
print(a.hex, a.bin, a.uint, a.float, a.bytes)
```

### Binary Packing and Unpacking
Use `pack` for complex binary construction and `unpack` (or `read`) for extraction.

```python
# Packing with mixed formats and endianness
# 'intle16' is a 16-bit little-endian integer
data = pack('intle16, hex=a, 0b1', 100, a='0x34f')

# Unpacking into variables
val1, val2 = data.unpack('intle16, bits13')
```

### Bit-Level Manipulation
Perform slicing, searching, and replacing just like Python lists or strings, but at the bit level.

```python
# Slicing (supports negative steps)
reversed_bits = a[10:3:-1]

# Searching and replacing
indices = a.find('0x48')
a.replace('0b001', '0xabc')

# Insertion and deletion
a.insert('0b0000', pos=3)
del a[12:16]
```

### Sequential Stream Parsing
Use `BitStream` to maintain a read pointer for sequential data processing.

```python
from bitstring import BitStream
s = BitStream('0x160120f')

# Read specific lengths or formats
header = s.read(12)
value = s.read('uint12')
items = s.readlist('uint12, bin3')

# Manage position
s.pos = 0
```

### Fixed-Length Arrays
For performance and memory efficiency with uniform data, use the `Array` class.

```python
from bitstring import Array
# Create an array of 7-bit unsigned integers
arr = Array('uint7', [9, 100, 3, 1])
arr[::2] *= 5  # Supports vectorized-style operations
```

## Expert Tips
- **Immutability**: Use `Bits` instead of `BitArray` when data should not change; it is more memory-efficient and hashable.
- **Endianness**: Always specify endianness for multi-byte types (e.g., `uintbe32` for big-endian, `uintle32` for little-endian) to avoid platform-dependent bugs.
- **Performance**: When dealing with large files, pass a file object to the constructor (e.g., `Bits(filename='data.bin')`) to use memory mapping instead of loading the entire file into RAM.
- **Concatenation**: You can use the `+` operator or `join()` to combine bitstrings, but for building large structures, `BitArray.append()` or `pack()` is generally more readable.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_scott-griffiths_bitstring.md)