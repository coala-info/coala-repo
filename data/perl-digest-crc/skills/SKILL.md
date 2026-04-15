---
name: perl-digest-crc
description: This tool calculates standard and custom Cyclic Redundancy Check (CRC) checksums using the Perl Digest::CRC module. Use when user asks to calculate CRC sums for data integrity, verify file checksums using algorithms like CRC32 or CRC-CCITT, or define custom CRC parameters for specific bit widths and polynomials.
homepage: http://metacpan.org/pod/Digest::CRC
metadata:
  docker_image: "quay.io/biocontainers/perl-digest-crc:0.23--pl5321h7b50bb2_5"
---

# perl-digest-crc

## Overview
This skill provides guidance on using the `Digest::CRC` Perl module to calculate CRC sums. It supports standard algorithms (like those used in Ethernet, Gzip, or OpenPGP) and allows for the construction of custom CRC functions by defining bit width, initial values, polynomials, and reflection parameters. It is particularly useful for data integrity verification in bioinformatics pipelines or general file processing where specific CRC standards are required.

## Functional Usage Patterns

### Standard CRC Functions
The module provides pre-configured functions for common CRC types. Import them specifically for better performance and clarity.

```perl
use Digest::CRC qw(crc64 crc32 crc16 crcccitt crc8 crcopenpgparmor);

# Simple string hashing
my $checksum = crc32("data string");

# CRC-CCITT (commonly used in Kermit or X.25)
my $ccitt = crcccitt("123456789");
```

### Object-Oriented Interface
Use the OO style for large datasets or when processing files to manage memory efficiently.

```perl
use Digest::CRC;

# Initialize for a specific standard type
my $ctx = Digest::CRC->new(type => "crc32");

# Add data in chunks
$ctx->add($data_part1);
$ctx->add($data_part2);

# Add content directly from a filehandle
open(my $fh, '<', 'data.bin') or die $!;
$ctx->addfile($fh);

# Retrieve result in different formats
my $hex = $ctx->hexdigest;
my $base64 = $ctx->b64digest;
my $raw = $ctx->digest;
```

### Custom CRC Configurations
If a non-standard CRC is required, define the parameters manually in the constructor:

- `width`: Bit length of the CRC.
- `poly`: The generator polynomial.
- `init`: Initial value.
- `xorout`: Value to XOR with the final register.
- `refin` / `refout`: Boolean (0 or 1) to reflect input or output bits.
- `cont`: Boolean to allow continuation of a previous calculation.

```perl
my $custom_ctx = Digest::CRC->new(
    width  => 16,
    init   => 0x2345,
    xorout => 0x0000,
    refout => 1,
    poly   => 0x8005,
    refin  => 1,
    cont   => 1
);
```

## Best Practices
- **Incremental Updates**: When calculating CRCs for very large files, always use `$ctx->addfile(*FILE)` or `$ctx->add($chunk)` to avoid loading the entire file into RAM.
- **Context Reuse**: If calculating a CRC for a stream that was interrupted, ensure `cont => 1` is set to properly resume the state.
- **Installation**: In Bioconda environments, ensure the dependency is present via `conda install bioconda::perl-digest-crc`.

## Reference documentation
- [Digest::CRC - Generic CRC functions](./references/metacpan_org_pod_Digest__CRC.md)
- [perl-digest-crc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-digest-crc_overview.md)