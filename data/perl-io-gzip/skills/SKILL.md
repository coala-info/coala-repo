---
name: perl-io-gzip
description: The `PerlIO::gzip` extension allows Perl to treat Gzip files as standard filehandles by adding a specialized layer to the I/O stack.
homepage: https://metacpan.org/pod/PerlIO::gzip
---

# perl-io-gzip

## Overview

The `PerlIO::gzip` extension allows Perl to treat Gzip files as standard filehandles by adding a specialized layer to the I/O stack. Instead of manually piping to external `gzip` binaries or using complex buffer-based modules, you can use standard `open` and `binmode` calls to decompress or compress data on the fly. This is particularly useful for processing large bioinformatics datasets (like FASTQ or SAM files) or logs where memory efficiency and native Perl filehandle integration are required.

## Usage Patterns

### Basic Reading and Writing
The most common use case is opening a `.gz` file for direct reading or creating one for writing.

```perl
use PerlIO::gzip;

# Reading a compressed file
open(my $fh, "<:gzip", "data.gz") or die "Cannot open: $!";
while (<$fh>) {
    print $_; # Data is automatically uncompressed
}

# Writing to a compressed file
open(my $out, ">:gzip", "output.gz") or die "Cannot open: $!";
print $out "This text will be compressed on disk\n";
close $out;
```

### Layer Arguments
You can fine-tune how the layer handles headers by passing arguments in the form `:gzip(arg)`.

| Argument | Behavior |
| :--- | :--- |
| `gzip` | **Default.** Expects/writes standard Gzip headers. |
| `none` | No headers. Treats the handle as a raw deflate stream (common for ZIP file members). |
| `auto` | Checks first two bytes; if they match `\x1f\x8b`, it uses Gzip mode, otherwise assumes raw deflate. |
| `autopop` | **Transparent mode.** If the file is Gzip, it decompresses. If not, the layer "pops" itself and reads the file as plain text. |
| `lazy` | Defers header checking until the first read/write operation. |

### Handling Raw Deflate Streams
If you are dealing with streams that lack the Gzip wrapper (e.g., data extracted from a database or a network socket), use the `none` argument.

```perl
# Switch an existing handle to raw deflate mode
binmode($socket, ":gzip(none)");
```

### Transparent Decompression (autopop)
Use `autopop` when your script needs to handle a mix of compressed and uncompressed input files without checking extensions manually.

```perl
open(my $fh, "<:gzip(autopop)", $filename);
# If $filename is Gzip, it decompresses. 
# If $filename is plain text, it reads normally.
```

## Expert Tips
- **No Simultaneous R/W**: You cannot open a file for simultaneous reading and writing (`+<:gzip`); the operation will fail.
- **Error Handling with Lazy**: When using `:gzip(lazy)`, the `open` call might succeed even if the file is corrupt. Always check the return value of your first read operation or use `eval` blocks to catch header errors.
- **Performance**: This module is implemented in C and is generally faster than pure-perl decompression modules, making it the preferred choice for high-throughput Perl data pipelines.

## Reference documentation
- [PerlIO::gzip - Perl extension to provide a PerlIO layer to gzip/gunzip](./references/metacpan_org_pod_PerlIO__gzip.md)