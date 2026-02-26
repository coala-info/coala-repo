---
name: perl-compress-raw-zlib
description: This tool provides a low-level Perl interface to the zlib and zlib-ng libraries for manual management of compressed data streams. Use when user asks to compress or decompress raw data, handle gzip headers, or tune performance parameters for zlib-based data processing in Perl.
homepage: http://metacpan.org/pod/Compress::Raw::Zlib
---


# perl-compress-raw-zlib

## Overview
The `perl-compress-raw-zlib` skill provides procedural knowledge for interacting with the `Compress::Raw::Zlib` Perl module. This tool serves as a low-level interface to the zlib and zlib-ng libraries. Unlike higher-level modules, it allows developers to manage the compression state manually, handle raw data streams without headers, and tune performance parameters like compression levels and strategy. It is commonly used in bioinformatics pipelines (via Bioconda) and system-level Perl scripting for handling compressed data formats.

## Implementation Patterns

### Basic Compression (Deflate)
To compress data, initialize a `Deflate` object and use the `deflate` method.

```perl
use Compress::Raw::Zlib;

# Initialize with optional parameters (Level 1-9, Strategy, etc.)
my ($d, $status) = new Compress::Raw::Zlib::Deflate(
    -Level => Z_BEST_COMPRESSION,
    -WindowBits => WANT_GZIP # Use WANT_GZIP for gzip headers
);

my $input = "data to compress";
my $output;
$status = $d->deflate($input, $output);

# Always flush to ensure all data is written to the output buffer
$status = $d->flush($output);
```

### Basic Decompression (Inflate)
To decompress raw streams, use the `Inflate` object.

```perl
use Compress::Raw::Zlib;

my ($i, $status) = new Compress::Raw::Zlib::Inflate(
    -WindowBits => WANT_GZIP_OR_ZLIB
);

my $compressed_data = "...";
my $uncompressed;
$status = $i->inflate($compressed_data, $uncompressed);
```

### Stream Handling and Buffers
When processing large files, use a loop to deflate/inflate chunks to keep memory usage low.

```perl
while (read(INPUT, $buffer, 4096)) {
    $status = $d->deflate($buffer, $output);
    print OUTPUT $output;
}
$d->flush($output);
print OUTPUT $output;
```

## Expert Tips and Best Practices

- **Status Codes**: Always check the `$status` returned by methods. `Z_OK` (0) indicates success, while `Z_STREAM_END` indicates the end of a compressed stream.
- **WindowBits**: This is the most critical parameter for compatibility.
    - `15`: Standard zlib.
    - `-15`: Raw deflate (no headers).
    - `16 + 15` (or `WANT_GZIP`): Gzip format.
- **Memory Efficiency**: The `deflate` and `inflate` methods append to the output variable. If reusing the output variable in a loop, clear it (e.g., `$output = ""`) or ensure you are handling the accumulation correctly to avoid memory bloat.
- **Flushing**: Use `Z_FINISH` during the final `flush` call to ensure the compressed stream is properly terminated. For interactive streams, `Z_SYNC_FLUSH` can be used to make data available to the reader immediately.

## Reference documentation
- [Compress::Raw::Zlib - Low-Level Interface to zlib or zlib-ng compression library](./references/metacpan_org_pod_Compress__Raw__Zlib.md)
- [perl-compress-raw-zlib - bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-compress-raw-zlib_overview.md)