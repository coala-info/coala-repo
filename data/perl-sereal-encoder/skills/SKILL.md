---
name: perl-sereal-encoder
description: This tool encodes Perl data structures into the high-performance Sereal binary serialization format. Use when user asks to serialize complex Perl objects, convert data to a compact binary stream, or optimize data storage speed and size compared to JSON or Storable.
homepage: https://metacpan.org/pod/Sereal::Encoder
---


# perl-sereal-encoder

## Overview
The `perl-sereal-encoder` provides the Perl implementation of the Sereal binary serialization format. It is designed to be a superior alternative to `Storable`, `JSON`, or `MessagePack` by prioritizing both speed and small output size. This skill facilitates the encoding of complex Perl data structures (scalars, hashes, arrays, and objects) into a binary stream that can be efficiently decoded by `Sereal::Decoder`.

## Usage Patterns

### Basic Encoding
To encode a Perl data structure into a Sereal binary string:

```perl
use Sereal::Encoder qw(encode_sereal);

my $data = {
    foo => 'bar',
    list => [1, 2, 3],
    nested => { a => 1 }
};

my $binary = encode_sereal($data);
```

### Object-Oriented Interface
For better performance in tight loops or to specify options, use the functional constructor:

```perl
use Sereal::Encoder;

my $encoder = Sereal::Encoder->new({
    snappy => 1,      # Enable Snappy compression
    dedupe_strings => 1 # Reduce size by deduplicating repeated strings
});

my $binary = $encoder->encode($data);
```

### Performance Optimization Tips
- **Compression**: Use `snappy => 1` or `zlib => 1` for large data structures to significantly reduce the binary size at a small CPU cost.
- **String Deduplication**: Enable `dedupe_strings => 1` if your data contains many repeated keys or string values.
- **Sort Keys**: Use `sort_keys => 1` if you need deterministic output (e.g., for hashing the resulting binary), though this incurs a performance penalty.
- **Aliasing**: By default, Sereal handles circular references and aliases. If you are certain your data is a simple tree, you can disable some checks for maximum speed, though this is rarely necessary.

### Common Options
- `compress`: Set to `Sereal::Encoder::SRL_SNAPPY` or `SRL_ZLIB`.
- `max_recursion_depth`: Protect against stack overflow on deeply nested structures.
- `no_shared_hashkeys`: Disable the internal hash key intern pool if memory is extremely constrained.

## Reference documentation
- [Sereal::Encoder Documentation](./references/metacpan_org_pod_Sereal__Encoder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-sereal-encoder_overview.md)