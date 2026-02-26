---
name: perl-math-base-convert
description: This tool performs efficient conversions between different number bases and custom positional notation systems. Use when user asks to convert numbers between standard bases like hex or base64, shorten long numeric IDs, or define custom character sets for number transformation.
homepage: https://metacpan.org/pod/Math::Base::Convert
---


# perl-math-base-convert

## Overview
This skill provides guidance on using the `Math::Base::Convert` Perl module for efficient number system transformations. It is particularly useful for shortening long numeric strings (like database IDs) into higher-base representations (like Base64) or translating between non-standard positional notation systems. It excels in performance compared to manual division-remainder algorithms.

## Basic Usage Patterns

### Standard Base Conversion
The tool comes with several pre-defined character sets. Use these for common computing tasks:
- `bin`: 0,1
- `oct`: 0-7
- `dec`: 0-9
- `hex`: 0-9, a-f
- `HEX`: 0-9, A-F
- `b64`: A-Z, a-z, 0-9, +, / (Standard Base64)
- `m64`: 0-9, A-Z, a-z, _, - (URL-safe/MIME-style)

### One-Liner Execution
To convert a number quickly from the command line without writing a full script:
```bash
perl -MMath::Base::Convert=:all -e 'print cnv("12345", "dec", "hex"), "\n"'
```

### Scripted Implementation
For repetitive conversions, create a converter object to pre-calculate the mapping tables, which significantly improves speed for bulk operations.

```perl
use Math::Base::Convert;

# Define the source and target bases
my $bc = new Math::Base::Convert('dec', 'b64');

# Perform conversions
my $base64_output = $bc->cnv('1000000');
```

## Custom Base Definitions
You can define your own coordinate system by passing an array reference of characters.

```perl
# Define a custom base-4 system using DNA nucleotides
my $dna_conv = new Math::Base::Convert(['0','1','2','3'], ['A','C','G','T']);
print $dna_conv->cnv('3210'); # Converts base-4 numeric to DNA sequence
```

## Best Practices
- **Object Reuse**: Always use the `new` constructor if converting more than a few numbers. The internal bit-mapping is computationally expensive to build but extremely fast to execute once cached in the object.
- **Large Integers**: This module handles strings of arbitrary length, making it safer for 64-bit or 128-bit identifiers that might exceed standard Perl integer limits.
- **Context Awareness**: Ensure input strings do not contain characters outside the source base definition, as this will lead to unexpected results or calculation errors.

## Reference documentation
- [Math::Base::Convert Documentation](./references/metacpan_org_pod_Math__Base__Convert.md)