---
name: perl-pod-usage
description: This tool extracts and displays usage messages or full documentation from a Perl script's internal POD sections. Use when user asks to print help messages, display script documentation, or format command-line usage instructions in Perl scripts.
homepage: http://search.cpan.org/~marekr/Pod-Usage-1.69/
---


# perl-pod-usage

## Overview
The `perl-pod-usage` skill provides a standardized way to bridge the gap between script documentation and user interface. Instead of maintaining separate help strings and documentation, this tool allows Perl scripts to parse their own internal POD sections to provide consistent, formatted output to the terminal. It is essential for creating professional Perl CLI tools that follow standard Unix help conventions.

## Usage Guidelines

### Basic Implementation
To use this functionality within a Perl script, use the `Pod::Usage` module. The most common pattern is calling `pod2usage()` when arguments are missing or invalid.

```perl
use Pod::Usage;
use Getopt::Long;

my $help = 0;
my $man  = 0;

GetOptions('help|?' => \$help, man => \$man) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;
```

### Exit Status and Verbosity Levels
Control the amount of documentation displayed using the `-verbose` parameter:

- **Level 0**: Displays only the `SYNOPSIS` section.
- **Level 1**: Displays `SYNOPSIS` along with any `OPTIONS` or `ARGUMENTS` sections.
- **Level 2**: Displays the entire POD documentation (full manpage).

Common exit value conventions:
- **0**: Normal exit (user requested help).
- **1**: Message printed due to minor usage error.
- **2**: Message printed due to command-line parsing error.

### Advanced Formatting
- **-input**: Specify a file other than the current script to read POD from.
- **-output**: Redirect the help message to a specific filehandle (defaults to `STDERR` for levels 0/1 and `STDOUT` for level 2).
- **-sections**: Specify exactly which POD sections to print (e.g., `DESCRIPTION|COMMANDS`).

### Best Practices
- **Standard Headings**: Ensure your Perl script contains standard POD headings like `=head1 NAME`, `=head1 SYNOPSIS`, and `=head1 OPTIONS` for the tool to parse correctly.
- **Error Messages**: Pass a string to `pod2usage` to prepend a specific error message to the help output: `pod2usage("Error: --input file missing")`.
- **Conda Environment**: When working in bioinformatics environments, ensure the package is available via `conda install bioconda::perl-pod-usage`.

## Reference documentation
- [Pod::Usage Documentation](./references/metacpan_org_release_MAREKR_Pod-Usage-1.69.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-pod-usage_overview.md)