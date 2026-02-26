---
name: perl-fastx-reader
description: This tool provides a high-performance interface and command-line utility for reading and counting FASTA and FASTQ sequence files. Use when user asks to count sequences in FASTA or FASTQ files, iterate through sequence records in Perl scripts, or process compressed biological sequence data.
homepage: https://github.com/telatin/FASTQ-Parser
---


# perl-fastx-reader

## Overview
The `perl-fastx-reader` package provides a high-performance, dependency-light way to handle biological sequence files. It is particularly useful for bioinformatics workflows where you need to iterate through large FASTA/FASTQ files without the overhead of BioPerl. The skill covers both the `fqc` command-line tool for rapid sequence counting and the `FASTX::Reader` Perl API for custom script development.

## Command Line Usage (fqc)
The `fqc` (FASTQ Counter) utility is the primary CLI tool included in this package. It supports FASTA and FASTQ formats, including compressed `.gz` files.

### Basic Counting
Count sequences in one or more files:
```bash
fqc file1.fastq file2.fasta.gz
```

### Output Formats
By default, `fqc` prints a simple filename and count. Use these flags for structured data:
- `-t`: Tab-separated values (TSV)
- `-c`: Comma-separated values (CSV)
- `-j`: JSON format
- `-x`: ASCII table format (human-readable)

## Perl API Integration
Use the `FASTX::Reader` module within Perl scripts for custom sequence processing.

### Basic Iterator Pattern
```perl
use FASTX::Reader;

my $filepath = 'data/sample.fastq.gz';
my $reader = FASTX::Reader->new({ filename => $filepath });

while ( my $seq = $reader->getRead() ) {
    # $seq is a hash reference containing:
    # $seq->{name}    : Sequence ID
    # $seq->{seq}     : Nucleotide sequence
    # $seq->{qual}    : Quality scores (empty for FASTA)
    # $seq->{comment} : Header comment/description
    
    print "Processing: " . $seq->{name} . "\n";
}
```

### Best Practices
- **File Validation**: Always check if the input file exists before initializing the reader to avoid runtime exceptions.
- **Memory Efficiency**: The `getRead()` method acts as an iterator, loading only one record into memory at a time, making it suitable for very large datasets.
- **Format Autodetection**: The module automatically handles FASTA, FASTQ, and Gzip compression based on file content/extension.

## Reference documentation
- [FASTX-Reader GitHub Repository](./references/github_com_telatin_FASTX-Reader.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-fastx-reader_overview.md)