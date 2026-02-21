---
name: perl-archive-extract
description: The `perl-archive-extract` skill provides a wrapper-independent way to decompress and unpack files.
homepage: http://metacpan.org/pod/Archive::Extract
---

# perl-archive-extract

## Overview
The `perl-archive-extract` skill provides a wrapper-independent way to decompress and unpack files. Instead of calling specific tools like `unzip`, `tar`, or `bunzip2` individually, this tool detects the archive type by extension and selects the appropriate internal Perl module or system binary to perform the extraction. It simplifies workflows by providing a consistent set of commands for disparate file types.

## Core Usage Patterns

### Basic Extraction
To extract an archive in the current directory using a Perl one-liner:
```bash
perl -MArchive::Extract -e '$ae = Archive::Extract->new(archive => "data.tar.gz"); $ae->extract or die $ae->error'
```

### Extracting to a Specific Location
Specify the `to` parameter to define the output directory:
```bash
perl -MArchive::Extract -e '$ae = Archive::Extract->new(archive => "logs.zip"); $ae->extract(to => "/path/to/output") or die $ae->error'
```

### Identifying Extracted Files
After extraction, you can retrieve the list of files created:
```bash
perl -MArchive::Extract -e '$ae = Archive::Extract->new(archive => "bundle.tbz"); $ae->extract; print join("\n", @{$ae->files})'
```

## Supported Formats and Type Overrides
The tool automatically detects types based on extensions, but you can force a specific type if the file lacks a standard suffix:

| Type | Extensions |
| :--- | :--- |
| `tar` | .tar |
| `tgz` | .tgz, .tar.gz |
| `gz` | .gz |
| `zip` | .zip, .jar, .par |
| `bz2` | .bz2 |
| `tbz` | .tbz, .tar.bz2 |
| `xz` | .xz |
| `txz` | .txz, .tar.xz |

**Manual Type Override:**
```bash
perl -MArchive::Extract -e '$ae = Archive::Extract->new(archive => "unknown_file", type => "zip"); $ae->extract'
```

## Expert Tips and Configuration

### Preferring System Binaries
By default, the tool tries to use Perl modules. For very large files, system binaries (like `/bin/tar`) are often faster and more memory-efficient. Force the use of binaries by setting the global `PREFER_BIN` variable:
```bash
perl -MArchive::Extract -e '$Archive::Extract::PREFER_BIN = 1; $ae = Archive::Extract->new(archive => "large.tar.gz"); $ae->extract'
```

### Debugging Extraction Issues
If an extraction fails without a clear error, enable debug mode to see the internal commands being executed:
```bash
perl -MArchive::Extract -e '$Archive::Extract::DEBUG = 1; $ae = Archive::Extract->new(archive => "file.gz"); $ae->extract'
```

### Handling "Z" (Compress) Files
The tool supports legacy `.Z` files (Lempel-Ziv). These typically require the system `compress` or `uncompress` utility to be present in the environment path.

## Reference documentation
- [Archive::Extract - A generic archive extracting mechanism](./references/metacpan_org_pod_Archive__Extract.md)
- [perl-archive-extract - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-archive-extract_overview.md)