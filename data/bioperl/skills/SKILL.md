---
name: bioperl
description: BioPerl is a collection of object-oriented Perl modules used for processing biological data and automating bioinformatics workflows. Use when user asks to parse sequence files, convert between file formats, manipulate sequences, or retrieve data from remote biological databases.
homepage: https://github.com/bioperl/bioperl-live
---

# bioperl

## Overview
BioPerl is a comprehensive collection of object-oriented Perl modules designed for bioinformatics. It provides a standardized interface for representing biological data, allowing developers to focus on analysis rather than file parsing. This skill enables the efficient use of BioPerl's core classes to automate sequence processing, database retrieval, and tool integration.

## Core Usage Patterns

### Sequence Input/Output (Bio::SeqIO)
The most common task is reading and writing sequence files. Always use `Bio::SeqIO` rather than manual regex parsing to ensure format compliance.

```perl
use Bio::SeqIO;

# Reading a file
my $in = Bio::SeqIO->new(-file => "input.fasta", -format => "fasta");
while (my $seq = $in->next_seq) {
    print "ID: ", $seq->display_id, "\n";
    print "Sequence: ", $seq->seq, "\n";
}

# Converting formats (e.g., GenBank to FASTA)
my $out = Bio::SeqIO->new(-file => ">output.fasta", -format => "fasta");
$out->write_seq($seq);
```

### Sequence Manipulation (Bio::Seq)
Once a sequence object is loaded, use built-in methods for common transformations:

*   **Subsequences**: `$seq->subseq(start, end)` (Note: BioPerl uses 1-based indexing).
*   **Translation**: `$seq->translate()` converts DNA/RNA to protein.
*   **Reverse Complement**: `$seq->revcom()`.

### Working with Annotations (Bio::Tools::GFF)
For genomic features, use the GFF parser. Note that `Bio::Tools::GFF` handles different versions (GFF2, GFF3).

```perl
use Bio::Tools::GFF;
my $gffio = Bio::Tools::GFF->new(-file => 'features.gff', -gff_version => 3);
while (my $feature = $gffio->next_feature) {
    # Process Bio::SeqFeatureI compliant objects
    print $feature->primary_tag, "\n";
}
```

### Remote Database Access
Use `Bio::DB::EUtilities` (often a separate distribution) to fetch data directly from NCBI.

```perl
use Bio::DB::EUtilities;
my $factory = Bio::DB::EUtilities->new(-eutil => 'efetch',
                                       -db    => 'protein',
                                       -id    => 'P12345',
                                       -email => 'user@example.com');
```

## Best Practices and Expert Tips

*   **Memory Management**: When processing large files (e.g., whole-genome FASTQ), always use the `next_seq()` iterator pattern. Avoid loading all sequences into an array at once.
*   **Alphabet Specification**: If BioPerl fails to guess the sequence type, explicitly set `-alphabet` (dna, rna, or protein) in the `Bio::PrimarySeq` or `Bio::Seq` constructor.
*   **Error Handling**: Wrap database connections and file I/O in `eval {}` blocks or use `Try::Tiny` to handle network timeouts or malformed files gracefully.
*   **Module Installation**: BioPerl is modular. If a specific functionality is missing (e.g., `Bio::DB::EUtilities`), install it via CPAN: `cpanm Bio::DB::EUtilities`.
*   **CLI Utilities**: Check the `bin/` directory of the BioPerl distribution for pre-built scripts like `bp_fetch.pl` or `bp_seqconvert.pl` before writing custom code for simple tasks.

## Reference documentation
- [BioPerl Core Repository](./references/github_com_bioperl_bioperl-live.md)
- [BioPerl Binaries and Scripts](./references/github_com_bioperl_bioperl-live_tree_master_bin.md)