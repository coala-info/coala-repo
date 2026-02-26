---
name: perl-io-zlib
description: "This tool provides an IO-style interface for reading and writing compressed files in Perl. Use when user asks to read or write gzipped files, manage compressed filehandles, or handle transparent decompression in Perl scripts."
homepage: https://metacpan.org/pod/IO::Zlib
---


# perl-io-zlib

## Overview

The `perl-io-zlib` skill provides a streamlined way to manage compressed file I/O in Perl. Instead of manually handling decompression buffers, this tool allows you to treat compressed files as standard filehandles. It is particularly robust because it can automatically fall back to using the system's external `gzip` binary if the `Compress::Zlib` Perl module is unavailable, ensuring scripts remain portable across different environments.

## Basic Usage Patterns

### Object-Oriented Interface
The preferred way to use `IO::Zlib` is through its constructor. This provides a clean, scoped filehandle.

```perl
use IO::Zlib;

# Reading a compressed file
my $fh = IO::Zlib->new("data.gz", "rb");
if (defined $fh) {
    while (<$fh>) {
        print $_;
    }
    $fh->close;
}

# Writing with a specific compression level (1-9)
my $out = IO::Zlib->new("output.gz", "wb9");
if (defined $out) {
    print $out "High compression data\n";
    $out->close;
}
```

### Tied Handle Interface
For legacy code or scripts where you prefer global filehandles, use the `tie` interface.

```perl
use IO::Zlib;

tie *GZ_IN, 'IO::Zlib', "input.gz", "rb";
while (<GZ_IN>) {
    process($_);
}
untie *GZ_IN;
```

## Expert Tips and Best Practices

### Managing External Gzip Dependencies
By default, `IO::Zlib` tries to use `Compress::Zlib`. If performance is a concern or the library is missing, you can force the use of the system's `gzip` binary:

*   **Force External Gzip**: `use IO::Zlib qw(:gzip_external 1);`
*   **Disable External Gzip**: `use IO::Zlib qw(:gzip_external 0);`

### Customizing Gzip Commands
If your environment uses non-standard paths for `gzip` or `gunzip`, you can override the internal command strings during import:

```perl
use IO::Zlib ':gzip_read_open'  => '/usr/local/bin/gunzip -c %s |',
             ':gzip_write_open' => '| /usr/local/bin/gzip > %s';
```
*Note: The `%s` placeholder is mandatory and represents the filename.*

### Mode Strings
`IO::Zlib` uses `fopen()` style mode strings:
*   `rb`: Read binary (standard for reading .gz).
*   `wb`: Write binary.
*   `wb[1-9]`: Write with specific compression level (e.g., `wb1` for speed, `wb9` for size).

## Diagnostics and Troubleshooting

*   **List Context Requirement**: The `getlines` method must be called in a list context (e.g., `@lines = $fh->getlines`). Calling it in a scalar context will cause the script to croak.
*   **Missing Filename**: The `open` method will fail immediately if a filename is not provided; always check if the filehandle is `defined` after a `new` or `open` call.
*   **Pipe Errors**: If using external gzip, ensure the read command ends with `|` and the write command begins with `|`.

## Reference documentation
- [IO::Zlib - IO:: style interface to Compress::Zlib](./references/metacpan_org_pod_IO__Zlib.md)
- [perl-io-zlib Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-zlib_overview.md)