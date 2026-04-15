---
name: perl-slurp
description: This tool provides guidance on using the Slurp Perl module to efficiently load entire file contents into variables. Use when user asks to read a file into a single string, load file lines into an array, or simplify file reading in Perl scripts and one-liners.
homepage: http://metacpan.org/pod/Slurp
metadata:
  docker_image: "quay.io/biocontainers/perl-slurp:0.4--pl526_0"
---

# perl-slurp

## Overview

The `perl-slurp` skill provides guidance on using the `Slurp` Perl module to efficiently load file contents into variables. Instead of manually opening filehandles, looping through lines, and closing handles, this tool allows for a single-function call to "slurp" an entire file. This is ideal for rapid scripting and one-liners where code conciseness is preferred over stream-based processing.

## Usage Instructions

### Basic Perl Scripting
To use the module in a script, import it and use the `slurp` function. The function's behavior changes based on the calling context (scalar vs. list).

**Reading a file into a single string (Scalar Context):**
```perl
use Slurp;

my $filename = "data.txt";
my $content = slurp($filename); 
# $content now contains the entire file including newlines
```

**Reading a file into a list of lines (List Context):**
```perl
use Slurp;

my $filename = "data.txt";
my @lines = slurp($filename);
# Each element in @lines is a line from the file
```

### Common CLI One-Liner Patterns
The `perl-slurp` module is highly effective for quick command-line data manipulation.

**Print the entire content of a file after a transformation:**
```bash
perl -MSlurp -e 'print uc slurp("input.txt")'
```

**Count lines in a file using slurp:**
```bash
perl -MSlurp -e 'my @l = slurp("input.txt"); print scalar @l'
```

## Best Practices and Tips

- **Memory Management**: Only use `slurp` for files that fit comfortably within the available system RAM. For extremely large files (e.g., multi-gigabyte FASTQ files), traditional line-by-line processing is preferred to avoid memory exhaustion.
- **Context Awareness**: Remember that Perl functions are context-sensitive. If you assign the result of `slurp()` to an array, you get lines; if you assign it to a scalar, you get one long string.
- **Bioconda Environment**: Ensure the module is available in your current environment by running `conda install bioconda::perl-slurp`.

## Reference documentation
- [Slurp - MetaCPAN](./references/metacpan_org_pod_Slurp.md)
- [perl-slurp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-slurp_overview.md)