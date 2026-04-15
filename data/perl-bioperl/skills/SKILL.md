---
name: perl-bioperl
description: BioPerl is a modular framework for processing, transforming, and analyzing biological data using the Perl programming language. Use when user asks to parse sequence files, convert between biological file formats, extract features from genomic annotations, or process search results from tools like BLAST.
homepage: http://metacpan.org/pod/BioPerl
metadata:
  docker_image: "quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1"
---

# perl-bioperl

## Overview

BioPerl is a modular, object-oriented framework for computational biology. It provides a standardized way to represent biological entities such as sequences, alignments, and features. Instead of writing custom parsers for complex file formats, this skill leverages BioPerl's robust modules to handle data ingestion, transformation, and analysis. It is best used for building bioinformatics pipelines where Perl's text-processing strengths are required alongside specialized biological data structures.

## Core Usage Patterns

### Sequence I/O (Bio::SeqIO)
The most common task is reading and writing sequence files. `Bio::SeqIO` handles format detection and provides a consistent interface.

```perl
use Bio::SeqIO;

# Reading a file
my $in = Bio::SeqIO->new(-file => "input.fasta", -format => "fasta");
while (my $seq = $in->next_seq) {
    print "ID: ", $seq->display_id, "\n";
    print "Sequence: ", $seq->seq, "\n";
}

# Converting formats (e.g., FASTA to GenBank)
my $out = Bio::SeqIO->new(-file => ">output.gb", -format => "genbank");
$out->write_seq($seq_object);
```

### Parsing Search Results (Bio::SearchIO)
Use `Bio::SearchIO` to parse output from tools like BLAST, FASTA, or HMMER.

```perl
use Bio::SearchIO;

my $searchio = Bio::SearchIO->new(-format => 'blast', -file => 'report.blast');
while (my $result = $searchio->next_result) {
    while (my $hit = $result->next_hit) {
        while (my $hsp = $hit->next_hsp) {
            if ($hsp->expect < 1e-5) {
                print "Hit: ", $hit->name, " E-value: ", $hsp->expect, "\n";
            }
        }
    }
}
```

### Command Line Utilities
BioPerl installs several standalone scripts (often prefixed with `bp_`) for quick tasks:

- `bp_seqconvert.pl`: Convert between sequence formats.
- `bp_index.pl` / `bp_fetch.pl`: Index a flat file and retrieve sequences by ID.
- `bp_gccalc.pl`: Calculate GC content.
- `bp_extract_full_seq.pl`: Extract sequences from a database using a list of IDs.

## Expert Tips and Best Practices

- **Memory Management**: When processing large genomic files (e.g., multi-gigabyte FASTQ or FASTA), always use the `next_seq()` iterator pattern rather than loading all sequences into an array.
- **Module Documentation**: BioPerl is vast. Use `perldoc` to access specific module details directly from the terminal:
  `perldoc Bio::Seq`
  `perldoc Bio::SeqIO`
- **Format Specifics**: When using `Bio::SeqIO`, explicitly defining the `-format` argument is faster and more reliable than relying on the tool's auto-detection, especially for files with non-standard extensions.
- **Feature Extraction**: For GenBank or GFF files, use `$seq->get_SeqFeatures()` to iterate through annotations like CDS, gene, or tRNA.

## Reference documentation
- [BioPerl - Perl modules for biology](./references/metacpan_org_pod_BioPerl.md)
- [perl-bioperl - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-bioperl_overview.md)