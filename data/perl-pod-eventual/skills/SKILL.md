---
name: perl-pod-eventual
description: This tool provides an event-based parser that treats POD documents as a stream of commands, text blocks, and non-POD code. Use when user asks to parse POD documentation line-by-line, extract specific POD headers, or filter documentation from Perl source code.
homepage: https://github.com/rjbs/Pod-Eventual
metadata:
  docker_image: "quay.io/biocontainers/perl-pod-eventual:0.094003--pl5321hdfd78af_0"
---

# perl-pod-eventual

## Overview
The `perl-pod-eventual` tool (based on the `Pod::Eventual` Perl library) provides a low-level, event-based parser for POD documents. Unlike traditional parsers that build a complex tree structure, this tool treats a POD file as a sequence of "trivial events"—such as commands, text blocks, or non-POD code. This "event stream" approach makes it highly efficient for line-by-line processing and for tools that need to selectively filter or modify documentation while preserving the surrounding code.

## Usage and Best Practices

### Installation
Install the package via Bioconda to ensure all Perl dependencies are correctly managed:
```bash
conda install bioconda::perl-pod-eventual
```

### Core Concepts
The parser identifies several distinct event types that you should handle in your processing logic:
- **Command Events**: Lines starting with `=`, such as `=head1`, `=item`, or `=over`.
- **Text Events**: Standard paragraph blocks within the POD.
- **Non-POD Events**: The actual Perl code or data that resides outside of the `=pod` and `=cut` markers.
- **Blank Events**: Explicit events for blank lines, which are crucial for accurately reconstructing verbatim or data paragraphs.

### Implementation Patterns
Since this is primarily a library-based tool, usage typically involves creating a subclass or using the `Pod::Eventual::Simple` interface within a Perl one-liner or script.

#### Extracting POD from a Perl Script
To quickly dump all POD content from a file while ignoring the code:
```bash
perl -MPod::Eventual::Simple -e 'print $_->{content} for @{ Pod::Eventual::Simple->read_file($ARGV[0]) }' script.pl
```

#### Filtering for Specific Commands
If you only need to extract headers (e.g., `=head1` sections):
```bash
perl -MPod::Eventual::Simple -e '
  my $output = Pod::Eventual::Simple->read_file($ARGV[0]);
  for (@$output) {
    print $_->{content} if $_->{type} eq "command" && $_->{command} =~ /^head/;
  }
' Module.pm
```

### Expert Tips
- **Line-Wise Processing**: For very large files, use the `read_handle` method instead of `read_file` to process the stream without loading the entire document into memory.
- **Handling Non-POD**: If you are building a tool that needs to modify code but leave documentation intact (or vice versa), pay close attention to the `nonpod` event type. This allows you to pass through code blocks untouched.
- **Reconstruction**: Because `Pod::Eventual` provides "blank" events, you can perfectly reconstruct the original file by concatenating the `content` of every event in the stream.

## Reference documentation
- [bioconda | perl-pod-eventual](./references/anaconda_org_channels_bioconda_packages_perl-pod-eventual_overview.md)
- [rjbs / Pod-Eventual GitHub](./references/github_com_rjbs_Pod-Eventual.md)