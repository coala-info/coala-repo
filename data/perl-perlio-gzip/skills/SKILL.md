---
name: perl-perlio-gzip
description: This tool provides a Perl IO layer for reading and writing gzipped files directly through the open function. Use when user asks to read or write compressed data streams, handle gzipped files in Perl scripts, or push a gzip layer onto an existing filehandle.
homepage: http://metacpan.org/pod/PerlIO-gzip
metadata:
  docker_image: "quay.io/biocontainers/perl-perlio-gzip:0.20--pl5321h577a1d6_7"
---

# perl-perlio-gzip

## Overview

This skill provides guidance on using the `PerlIO::gzip` module to handle compressed data streams in Perl. Unlike external system calls to `gzip` or using `IO::Zlib`, this module integrates directly with Perl's IO layer system (`open`). It is highly efficient for bioinformatics and data processing pipelines where gzipped files (like FASTQ or SAM) are standard, allowing you to treat compressed files as if they were plain text.

## Implementation Patterns

### Basic File Access
The most common use case is opening a filehandle with the `:gzip` layer.

```perl
use PerlIO::gzip;

# Reading a gzipped file
open(my $fh, "<:gzip", "data.gz") or die "Cannot open: $!";
while (<$fh>) {
    print $_;
}
close($fh);

# Writing a gzipped file
open(my $out, ">:gzip", "output.gz") or die "Cannot write: $!";
print $out "Compressed content\n";
close($out);
```

### Appending to Gzip Files
Standard gzip files can be concatenated. To append data to an existing gzip file:
```perl
open(my $fh, ">>:gzip", "data.gz");
```

### Layer Manipulation
You can push the gzip layer onto an already open filehandle (e.g., STDIN or a socket):
```perl
binmode(STDIN, ":gzip");
```

### Compression Levels
You can specify the compression intensity (1-9) using the `${PerlIO::gzip::level}` variable before opening the handle:
```perl
$PerlIO::gzip::level = 9; # Maximum compression
open(my $fh, ">:gzip", "ultra_compressed.gz");
```

## Best Practices

1.  **Error Handling**: Always check the return value of `open`. If the file is not a valid gzip format when reading, the first read operation or the `open` call itself may fail depending on the Perl version and environment.
2.  **Binmode**: When working with binary data through the gzip layer, ensure you don't accidentally apply `:utf8` layers after `:gzip` unless specifically intended, as this can corrupt the byte stream.
3.  **Performance**: `PerlIO::gzip` is generally faster than `IO::Zlib` because it operates at the C/layer level of Perl's IO system rather than as a tied filehandle wrapper.
4.  **Dependencies**: Ensure the module is installed via Bioconda (`perl-perlio-gzip`) or CPAN. In a script, always include `use PerlIO::gzip;` to register the layer.

## Reference documentation
- [PerlIO::gzip Documentation](./references/metacpan_org_pod_PerlIO-gzip.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-perlio-gzip_overview.md)