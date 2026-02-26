---
name: perl-compress-raw-bzip2
description: This tool provides a low-level Perl interface to the bzlib library for high-performance, in-memory bzip2 compression and decompression. Use when user asks to compress data blocks using Perl, decompress bzip2 streams, or manage memory-efficient data transformation within bioinformatics pipelines.
homepage: http://metacpan.org/pod/Compress::Raw::Bzip2
---


# perl-compress-raw-bzip2

## Overview
The `perl-compress-raw-bzip2` skill provides procedural knowledge for utilizing the `Compress::Raw::Bzip2` Perl module. This module serves as a low-level interface to the `bzlib` library, allowing for efficient, in-memory compression and decompression. It is particularly useful when you need to handle bzip2 data streams where high performance and memory management are critical, or when working within bioinformatics pipelines (via Bioconda) that rely on Perl-based data transformation.

## Installation
To use this module in a Conda-managed environment:
```bash
conda install bioconda::perl-compress-raw-bzip2
```

## Core Usage Patterns

### 1. In-Memory Compression
To compress a string or data block, initialize a `Compress::Raw::Bzip2` object and use the `bzdeflate` method.

```perl
use Compress::Raw::Bzip2;

my ($bz, $status) = new Compress::Raw::Bzip2(1, 9, 30); 
# Parameters: $appendOutput, $blockSize100k, $workfactor

my $input = "Data to compress";
my $output;
$status = $bz->bzdeflate($input, $output);
$status = $bz->bzclose($output); # Finalize the stream
```

### 2. In-Memory Decompression
To decompress bzip2 data, use the `Compress::Raw::Bunzip2` class.

```perl
use Compress::Raw::Bzip2;

my ($bz, $status) = new Compress::Raw::Bunzip2(1, 0, 0, 0);
# Parameters: $appendOutput, $consumeInput, $small, $verbosity

my $compressed_data = "..."; # bzip2 data
my $uncompressed;
$status = $bz->bzinflate($compressed_data, $uncompressed);
```

### 3. Perl One-Liner for Quick Compression
You can use the module directly from the command line for quick stream processing:

```bash
echo "text" | perl -MCompress::Raw::Bzip2 -e '
    $bz = new Compress::Raw::Bzip2(1);
    while(<STDIN>){ $bz->bzdeflate($_, $out) }
    $bz->bzclose($out);
    print $out;' > output.bz2
```

## Expert Tips and Best Practices

- **Buffer Management**: The `$appendOutput` parameter (the first argument in the constructor) is crucial. When set to 1, the module appends processed data to the output variable rather than overwriting it, which is essential for multi-step processing.
- **Block Size**: For compression, `$blockSize100k` ranges from 1 to 9. Use 9 for maximum compression ratio at the cost of higher memory usage during both compression and decompression.
- **Memory Constraints**: If working in a memory-constrained environment during decompression, set the `$small` parameter to 1 in the `Bunzip2` constructor. This uses an algorithm that requires less memory but is slower.
- **Status Checking**: Always check the `$status` returned by methods. A successful operation returns `BZ_OK` (or `BZ_STREAM_END` at the end of a stream).
- **Flushing**: Use `$bz->bzflush($output)` if you need to force all pending output to be generated without closing the compression object, which is useful for network socket streams.

## Reference documentation
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-compress-raw-bzip2_overview.md)
- [MetaCPAN Module Documentation](./references/metacpan_org_pod_Compress__Raw__Bzip2.md)