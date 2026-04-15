---
name: perl-unicode-utf8
description: This tool provides a high-performance Perl implementation for encoding and decoding UTF-8 strings with strict validation. Use when user asks to encode or decode UTF-8 bytes, validate UTF-8 sequences, or optimize character encoding performance in Perl.
homepage: http://metacpan.org/pod/Unicode::UTF8
metadata:
  docker_image: "quay.io/biocontainers/perl-unicode-utf8:0.62--pl5321h9948957_8"
---

# perl-unicode-utf8

## Overview
The `perl-unicode-utf8` skill provides guidance on implementing the `Unicode::UTF8` Perl module for efficient character encoding. This tool is essential when performance is a priority or when strict adherence to the Unicode standard is required. It replaces slower, built-in Perl encoding methods with a highly optimized implementation that correctly handles edge cases like surrogates and non-characters.

## Implementation Patterns

### Basic Encoding and Decoding
Use these functions for direct conversion between Perl strings and UTF-8 bytes:

```perl
use Unicode::UTF8 qw(decode_utf8 encode_utf8);

# Convert raw UTF-8 bytes to a Perl Unicode string
my $string = decode_utf8($octets);

# Convert a Perl Unicode string to raw UTF-8 bytes
my $octets = encode_utf8($string);
```

### Validation and Error Handling
To check if a byte sequence is valid UTF-8 without fully decoding it:

```perl
use Unicode::UTF8 qw(is_valid_utf8);

if (is_valid_utf8($data)) {
    # Process data
}
```

### Comparison with Standard Core
- **Performance**: `Unicode::UTF8` is significantly faster than `Encode::encode('utf-8', $str)`.
- **Strictness**: Unlike the core `utf8` pragma, this module strictly validates input according to the Unicode standard (RFC 3629). It will throw an exception on invalid sequences, overlong encodings, or surrogates.

## Best Practices
- **I/O Layers**: Avoid using `:utf8` or `:encoding(UTF-8)` on filehandles if you plan to use this module. Instead, read/write raw bytes (`:raw`) and manually call `decode_utf8` or `encode_utf8` for maximum performance.
- **In-place Modification**: Note that these functions return new strings; they do not modify the input buffer in place.
- **Subroutine Selection**: Only import the specific functions needed (`decode_utf8`, `encode_utf8`, `is_valid_utf8`) to keep the namespace clean.

## Reference documentation
- [Unicode::UTF8 Documentation](./references/metacpan_org_pod_Unicode__UTF8.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-unicode-utf8_overview.md)