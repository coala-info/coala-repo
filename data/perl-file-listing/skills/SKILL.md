---
name: perl-file-listing
description: This tool parses directory listing text into structured data such as file names, sizes, and modification times. Use when user asks to parse directory listings, extract file metadata from text, or convert unstructured file lists into structured arrays.
homepage: http://metacpan.org/pod/File-Listing
metadata:
  docker_image: "quay.io/biocontainers/perl-file-listing:6.16--pl5321hdfd78af_0"
---

# perl-file-listing

## Overview

The `perl-file-listing` skill enables the transformation of unstructured text representing directory contents into structured arrays. It leverages the `File::Listing` Perl module to identify file names, sizes, types, and modification times across multiple operating system listing formats. Use this skill to build robust scrapers or automation scripts that need to interpret the output of remote directory indexes without manual regex writing.

## Usage Instructions

### Basic Parsing via Perl One-Liner
To quickly parse a directory listing from a file or pipe, use a Perl one-liner. This is the most efficient way to use the tool from the command line.

```bash
# Parse a saved listing file and print the filename and size
perl -MFile::Listing -e 'for (parse_dir(do { local $/; <> })) { printf "%s: %d bytes\n", $_->[0], $_->[2] }' listing.txt
```

### Handling Different Listing Formats
The tool automatically attempts to guess the format (Unix, DOS, etc.), but you can specify a type if the default fails.

- **Unix (Default):** Standard `ls -l` style.
- **DOS:** Windows/DOS FTP style.
- **VMS:** Virtual Memory System style.

To force a specific type in a script:
```perl
use File::Listing qw(parse_dir);
my @files = parse_dir($listing_text, "+0000", "unix");
```

### Managing Timezones
The second argument to `parse_dir` defines the timezone for modification times.
- Use `"+0000"` for UTC.
- Use `"local"` to use the system's current timezone.
- Modification times are returned as Unix timestamps (seconds since epoch).

### Data Structure Reference
Each element returned by `parse_dir` is an array reference containing:
1. **Name**: The filename or directory name.
2. **Type**: 'f' for file, 'd' for directory, 'l' for symbolic link.
3. **Size**: File size in bytes (undef for directories).
4. **Mtime**: Last modification time (Unix timestamp).
5. **Mode**: File permissions (if available).

## Expert Tips

- **Slurp Input**: When parsing a whole file, ensure you "slurp" the content into a single string variable before passing it to `parse_dir`.
- **Error Handling**: If `parse_dir` returns an empty list, verify that the input string contains valid line breaks (`\n`). The parser relies on line-by-line processing.
- **Integration with LWP**: This tool is often used in conjunction with `LWP::UserAgent` to process the body of an HTTP directory index.

## Reference documentation
- [File::Listing - parse directory listing](./references/metacpan_org_pod_File-Listing.md)
- [perl-file-listing Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-listing_overview.md)