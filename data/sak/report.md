# sak CWL Generation Report

## sak

### Tool Description
Slicing and dicing of FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sak:0.4.8--h9948957_0
- **Homepage**: https://github.com/seqan/seqan/tree/master/apps/sak
- **Package**: https://anaconda.org/channels/bioconda/packages/sak/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sak/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/seqan/seqan
- **Stars**: N/A
### Original Help Text
```text
sak - Slicing and dicing of FASTA/FASTQ files..
===============================================

SYNOPSIS
    sak [OPTIONS] [-o OUT.{fa,fq}] IN.{fa,fq}

DESCRIPTION
    "It slices, it dices and it makes the laundry!"

    Original SAK tool by David Weese. Rewrite by Manuel Holtgrewe.

REQUIRED ARGUMENTS
    IN INPUT_FILE
          Valid filetypes are: .sam, .raw, .gbk, .frn, .fq, .fna, .ffn,
          .fastq, .fasta, .faa, .fa, and .embl.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.

  Output Options:
    -o, --out-path OUTPUT_FILE
          Path to the resulting file. If omitted, result is printed to stdout
          in FastQ format. Valid filetypes are: .sam, .raw, .frn, .fq, .fna,
          .ffn, .fastq, .fasta, .faa, and .fa.
    -rc, --revcomp
          Reverse-complement output.
    -l, --max-length INTEGER
          Maximal number of sequence characters to write out.

  Filter Options:
    -s, --sequence List of INTEGER's
          Select the given sequence for extraction by 0-based index.
    -sn, --sequence-name List of STRING's
          Select sequence with name prefix being NAME.
    -ss, --sequences List of STRING's
          Select sequences from-to where from and to are 0-based indices.
    -i, --infix List of STRING's
          Select characters from-to where from and to are 0-based indices.
    -ll, --line-length INTEGER
          Set line length in output file. See section Line Length for details.
          In range [-1..inf].

LINE LENGTH
    You can use the setting --line-length for setting the resulting line
    length. By default, sequences in FASTA files are written with at most 70
    characters per line and sequences in FASTQ files are written without any
    line breaks. The quality sequence in FASTQ file is written in the same way
    as the residue sequence.

    The default is selected with a --line-length value of -1 and line breaks
    can be disabled with a value of 0.

USAGE EXAMPLES
    sak -s 10 IN.fa
          Cut out 11th sequence from IN.fa and write to stdout as FASTA.
    sak -ss 10-12 -ss 100-200 IN.fq
          Cut out 11th up to and including 12th and 101th up to and including
          199th sequence from IN.fq and write to stdout as FASTA.

VERSION
    Last update: 2018-02-02_13:03:05_+0100
    sak version: 0.4.8 [e165baf]
    SeqAn version: 2.4.0
```

