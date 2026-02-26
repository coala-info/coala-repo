---
name: perl-sereal
description: Perl-sereal provides a high-performance binary serialization format for fast and compact data encoding and decoding. Use when user asks to serialize complex Perl data structures, optimize data persistence with compression, or convert between JSON and Sereal formats.
homepage: https://metacpan.org/pod/Sereal
---


# perl-sereal

## Overview

Sereal is a binary serialization format designed for speed and compactness. It serves as a superior alternative to Perl's native `Storable` and common text-based formats like `JSON`. Use this skill to implement efficient data persistence, optimize memory usage through string deduplication, and leverage advanced compression (Snappy, Zlib, Zstd) within Perl-based workflows.

## Installation

Install the package via Bioconda to ensure all C dependencies (XS) are correctly linked:

```bash
conda install bioconda::perl-sereal
```

## Core Usage Patterns

### Functional Interface
For simple, one-off tasks, use the exported functions.

```perl
use Sereal qw(encode_sereal decode_sereal);

# Serialize a complex data structure
my $binary = encode_sereal($data_structure);

# Deserialize back to Perl
my $original_data = decode_sereal($binary);
```

### Object-Oriented Interface (High Performance)
For loops or high-frequency operations, instantiate encoder/decoder objects to reuse internal buffers and reduce allocation overhead.

```perl
use Sereal::Encoder;
use Sereal::Decoder;

my $encoder = Sereal::Encoder->new({ snappy => 1, dedupe_strings => 1 });
my $decoder = Sereal::Decoder->new();

while (my $data = get_next_batch()) {
    my $blob = $encoder->encode($data);
    # ... process or store $blob ...
}
```

## CLI One-Liners for Data Inspection

Sereal is a binary format and cannot be read with `cat` or `less`. Use Perl one-liners to inspect or convert data on the command line.

**Inspect a Sereal file's content:**
```bash
perl -MData::Dumper -MSereal::Decoder=decode_sereal -e 'undef $/; print Dumper(decode_sereal(<>))' < data.sereal
```

**Convert JSON to Sereal (for storage optimization):**
```bash
perl -MJSON -MSereal::Encoder=encode_sereal -e 'undef $/; print encode_sereal(decode_json(<>))' < data.json > data.sereal
```

**Check Sereal version/header of a file:**
```bash
perl -MSereal::Decoder -e 'print Sereal::Decoder->new->get_sereal_version(<>), "\n"' < data.sereal
```

## Expert Tips and Best Practices

- **Enable Compression**: For large datasets, use `snappy => 1` for a good balance of speed and size, or `zstd => 1` (if available) for maximum compression.
- **String Deduplication**: If your data contains many repeated strings or hash keys, enable `dedupe_strings => 1` in the encoder to significantly reduce the output size.
- **Freeze/Thaw Compatibility**: Sereal can be used as a drop-in replacement for `Storable::freeze` and `Storable::thaw` in many frameworks by aliasing the functions.
- **Cross-Language Support**: While primarily a Perl tool, Sereal has implementations in C++, Go, and Python, making it viable for polyglot pipelines where performance is the priority.
- **Avoid Sort Keys**: Unless you need deterministic output for checksumming, keep `sort_keys => 0` (default) to maintain maximum encoding speed.

## Reference documentation
- [Sereal - Fast, compact, powerful binary (de-)serialization](./references/metacpan_org_pod_Sereal.md)
- [Sereal::Encoder - Performance options and compression](./references/metacpan_org_pod_Sereal__Encoder.md)
- [Sereal::Decoder - Deserialization and header inspection](./references/metacpan_org_pod_Sereal__Decoder.md)
- [Sereal::Performance - Comparison with JSON and Storable](./references/metacpan_org_pod_Sereal__Performance.md)