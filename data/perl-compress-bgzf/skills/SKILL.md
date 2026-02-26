---
name: perl-compress-bgzf
description: This tool provides a Perl interface for reading and writing Blocked GNU Zip Format (BGZF) files with support for random access via virtual offsets. Use when user asks to create indexable compressed files, parse BGZF data like BAM or VCF files, or implement random access on compressed genomic streams.
homepage: http://metacpan.org/pod/Compress::BGZF
---


# perl-compress-bgzf

## Overview
This skill enables the handling of BGZF (Blocked GNU Zip Format) files, which are essential for high-performance genomic data processing. Unlike standard gzip files, BGZF files consist of concatenated 64KB blocks, allowing tools to jump to specific locations without decompressing the entire stream. Use this skill to implement Perl scripts that need to create indexable compressed files or parse existing BGZF data (like BAM or VCF.gz) at the library level.

## Implementation Patterns

### Basic File Handling
The primary interface is through the `Compress::BGZF` object. It mimics standard filehandle behavior but manages the block-level compression automatically.

```perl
use Compress::BGZF;

# Writing a BGZF file
my $bgzf = Compress::BGZF->new(
    file  => "output.gz",
    mode  => "w",
    level => 6 # Compression level 1-9
);

$bgzf->print("Data line 1\n");
$bgzf->write($buffer, $length);
$bgzf->close();

# Reading a BGZF file
my $reader = Compress::BGZF->new(file => "input.gz", mode => "r");
while (my $line = $reader->getline()) {
    print $line;
}
$reader->close();
```

### Random Access with Virtual Offsets
The power of BGZF lies in "virtual offsets"—a 64-bit integer where the upper 48 bits are the file offset to the start of the block, and the lower 16 bits are the offset within the uncompressed block.

- **tell()**: Returns the current virtual offset.
- **seek($offset)**: Jumps to a specific virtual offset.

```perl
# Save a position for later indexing
my $voffset = $bgzf->tell();

# Jump back to a specific record
$bgzf->seek($voffset);
```

### Best Practices
- **Flush Management**: Use `$bgzf->flush()` to force the completion of the current BGZF block. This is useful when creating synchronization points in the file.
- **Memory Efficiency**: When reading large files, prefer `getline()` or `read()` over loading the entire file into memory, as BGZF is designed for stream processing.
- **Compatibility**: Ensure files created with this tool end with an empty BGZF block (automatically handled by `close()`), which serves as the standard End-of-File marker for BGZF-compliant tools like `samtools`.

## Reference documentation
- [Compress::BGZF Documentation](./references/metacpan_org_pod_Compress__BGZF.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-compress-bgzf_overview.md)