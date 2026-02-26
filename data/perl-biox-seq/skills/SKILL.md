---
name: perl-biox-seq
description: BioX::Seq is a lightweight Perl library and command-line toolset for high-speed parsing and manipulation of biological sequences. Use when user asks to parse FASTA or FASTQ files, perform reverse complements, translate sequences, or extract subsequences with low memory overhead.
homepage: http://metacpan.org/pod/BioX::Seq
---


# perl-biox-seq

## Overview
`BioX::Seq` is designed as a lightweight, high-speed alternative to more bloated bioinformatics libraries. It provides a streamlined object-oriented interface for handling biological sequences while maintaining a small memory footprint. This skill focuses on utilizing the library's core parsing capabilities and the associated command-line utilities to handle common sequence manipulation tasks like format conversion, sequence extraction, and basic statistics.

## Core Usage Patterns

### Basic Perl Scripting
To use `BioX::Seq` in a script, initialize the parser and iterate through the sequence objects.

```perl
use BioX::Seq;

my $parser = BioX::Seq->new(filename => "input.fasta");

while (my $seq = $parser->next_seq) {
    print "ID: " . $seq->id . "\n";
    print "Sequence: " . $seq->seq . "\n";
    print "Length: " . $seq->length . "\n";
}
```

### Handling FASTQ Data
The library automatically detects formats, but you can be explicit. For FASTQ, you can access quality scores directly.

```perl
my $parser = BioX::Seq->new(filename => "reads.fastq");
while (my $read = $parser->next_seq) {
    my $qual = $read->qual; # Returns the quality string
    # Perform filtering or trimming here
}
```

### Sequence Transformations
`BioX::Seq` objects include built-in methods for common genomic operations:

- **Reverse Complement**: `$seq->revcom`
- **Translation**: `$seq->translate`
- **Subsequences**: `$seq->subseq(start, end)` (1-based indexing)

## Performance Best Practices
- **Avoid BioPerl for simple loops**: If you only need to read and write FASTA/FASTQ, `BioX::Seq` is significantly faster and uses less RAM than `Bio::SeqIO`.
- **In-place modification**: When processing millions of reads, avoid creating unnecessary copies of the sequence string to keep memory usage low.
- **Filehandles**: You can pass an open filehandle to the constructor instead of a filename for streaming data through pipes.

## Common CLI Operations
While primarily a library, the distribution often includes utility scripts for rapid processing:

- **Reformatting**: Use the parser to quickly convert between FASTA and FASTQ (provided quality scores are handled).
- **Filtering**: Use the `length` attribute in a one-liner to filter small fragments:
  ```bash
  perl -MBioX::Seq -e '$p=BioX::Seq->new(filename=>"in.fa"); while($s=$p->next_seq){print ">".$s->id."\n".$s->seq."\n" if $s->length > 100}'
  ```

## Reference documentation
- [BioX::Seq Documentation](./references/metacpan_org_pod_BioX__Seq.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-biox-seq_overview.md)