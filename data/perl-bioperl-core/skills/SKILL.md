---
name: perl-bioperl-core
description: The perl-bioperl-core package provides an object-oriented framework for processing biological data and managing sequence objects in Perl. Use when user asks to parse biological file formats, manipulate sequence data, or perform bioinformatics tasks like reverse complementation and translation.
homepage: http://metacpan.org/pod/BioPerl
---


# perl-bioperl-core

## Overview
The `perl-bioperl-core` package provides the fundamental objects and modules for computational biology in Perl. It establishes an object-oriented framework where biological entities—such as sequences, features, and alignments—can interact seamlessly. This skill focuses on the core procedural knowledge required to parse biological files, manipulate sequence objects, and navigate the extensive BioPerl API.

## Installation
Install the core toolkit using the Bioconda channel:
```bash
conda install bioconda::perl-bioperl-core
```

## Core Usage Patterns

### Accessing Module Documentation
BioPerl is highly modular. Use `perldoc` to access the detailed documentation for specific objects and methods:
```bash
perldoc Bio::Seq
perldoc Bio::SeqIO
perldoc Bio::SearchIO
```

### Sequence Stream Handling (Bio::SeqIO)
The primary method for reading and writing sequence data is the `Bio::SeqIO` module. It handles format conversion automatically based on the `-format` argument.

**Standard Parsing Template:**
```perl
use Bio::SeqIO;

# Create a stream for input
my $seqin = Bio::SeqIO->new(-file   => "input.fasta",
                            -format => "fasta");

# Create a stream for output
my $seqout = Bio::SeqIO->new(-file   => ">output.genbank",
                             -format => "genbank");

# Process sequences one by one (memory efficient)
while (my $seq = $seqin->next_seq) {
    # $seq is a Bio::Seq object
    print "ID: ", $seq->display_id, "\n";
    print "Length: ", $seq->length, "\n";
    
    $seqout->write_seq($seq);
}
```

### Working with Sequence Objects
Once a sequence is loaded into a `Bio::Seq` object, use these common methods:
- `$seq->seq()`: Returns the sequence as a string.
- `$seq->revcom()`: Returns a new sequence object that is the reverse complement.
- `$seq->translate()`: Returns a `Bio::Seq` object of the protein translation.
- `$seq->subseq(start, end)`: Returns a string of the specified sub-sequence.

## Expert Tips
- **Memory Management**: Always use the `next_seq()` iterator pattern for large genomic files (FASTA/GenBank) rather than loading entire files into arrays to avoid memory exhaustion.
- **Format Support**: BioPerl supports a vast array of formats (SwissProt, EMBL, PIR, etc.). If a format is not recognized, check if the corresponding `Bio::SeqIO::<format>` module is installed.
- **Script Resources**: Check the `scripts/` and `examples/` directories in the BioPerl distribution for pre-built utilities for common tasks like sequence statistics or BLAST parsing.
- **Error Handling**: BioPerl uses a specific error-throwing mechanism. For robust scripts, wrap complex operations in `eval {}` blocks and check `$@`.

## Reference documentation
- [BioPerl - Perl modules for biology](./references/metacpan_org_pod_BioPerl.md)
- [perl-bioperl-core Overview](./references/anaconda_org_channels_bioconda_packages_perl-bioperl-core_overview.md)