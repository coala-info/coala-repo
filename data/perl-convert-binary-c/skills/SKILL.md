---
name: perl-convert-binary-c
description: This tool converts between raw binary data and Perl data structures using C header file definitions. Use when user asks to pack or unpack binary data, parse C structs for data conversion, or interface Perl with binary formats using C type definitions.
homepage: http://search.cpan.org/~mhx/Convert-Binary-C/
---


# perl-convert-binary-c

## Overview
This skill facilitates the use of the `Convert::Binary::C` Perl module to bridge the gap between raw binary data and high-level Perl data structures. By leveraging existing C header files (`.h`), it allows for deterministic, alignment-aware packing and unpacking of data without manually calculating offsets or using complex `pack`/`unpack` strings. It is particularly useful for systems programming, reverse engineering, and interfacing with legacy binary formats.

## Core Workflow
To use `Convert::Binary::C` effectively, follow this general pattern:

1.  **Initialize**: Create a new object and configure alignment/byte order.
2.  **Parse**: Load the C definitions (structs, enums, typedefs).
3.  **Unpack**: Convert a binary buffer into a Perl hash reference.
4.  **Pack**: Convert a Perl hash reference back into a binary buffer.

## Usage Patterns

### Basic Initialization and Parsing
```perl
use Convert::Binary::C;

my $c = Convert::Binary::C->new(
    ByteOrder => 'LittleEndian',
    Alignment => 4,
)->parse_file('protocol_defs.h');
```

### Unpacking Binary Data
When you have a raw buffer (e.g., from a file or socket):
```perl
my $data = $c->unpack('MyStructName', $binary_buffer);
# $data is now a hash ref: { field1 => 123, field2 => 'abc' }
```

### Packing Perl Data
To create a binary blob for transmission or storage:
```perl
my $binary_buffer = $c->pack('MyStructName', {
    field1 => 123,
    field2 => 'abc',
});
```

### Handling Dependencies
If your C headers use `#include`, you must specify the include paths:
```perl
$c->Include(['/usr/include', './headers']);
$c->parse_file('main.h');
```

## Expert Tips
- **Alignment and Padding**: Always match the `Alignment` and `ByteOrder` settings to the architecture that produced the binary data. Use `$c->configure` to adjust these at runtime.
- **Member Offsets**: Use `$c->sizeof('MyStruct')` and `$c->offsetof('MyStruct', 'member')` to debug layout issues or verify that the Perl module's interpretation matches your expectations.
- **Typedefs**: The tool handles complex typedefs and nested structs automatically. Ensure all dependent types are present in the parsed code.
- **Performance**: For large-scale processing, pre-parse the C headers and reuse the `Convert::Binary::C` object to avoid the overhead of re-parsing for every record.

## Reference documentation
- [Convert::Binary::C - Binary Data Conversion using C Types](./references/metacpan_org_release_Convert-Binary-C.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-convert-binary-c_overview.md)