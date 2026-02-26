# raptor CWL Generation Report

## raptor_See

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/seqan/raptor
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[Error] You misspelled the subcommand! Please specify which sub-program you want to use: one of [build, layout, prepare, search, upgrade]. Use -h/--help for more information.
```


## raptor_build

### Tool Description
Constructs a Raptor index.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
Raptor-build - A fast and space-efficient pre-filter for querying very large collections of nucleotide sequences.
=================================================================================================================

SYNOPSIS
    raptor build --input <file> --output <file> [--threads <number>] [--quiet]
    [--kmer <number>|--shape <01-pattern>] [--window <number>] [--fpr
    <number>] [--hash <number>] [--parts <number>] [--compressed]

DESCRIPTION
    Constructs a Raptor index.

    The input may be a layout file from raptor layout, a list of minimiser
    files produced from raptor prepare, or a file with a list of files to
    process.

OPTIONS

  General options
    --input (std::filesystem::path)
          A layout file from raptor layout, or a file containing file names.
          The file must contain at least one file path per line, with multiple
          paths being separated by a whitespace. Each line in the file
          corresponds to one bin. Valid extensions for the paths in the file
          are [minimiser] when using preprocessed input from raptor prepare,
          and [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
          possibly followed by [bz2,gz,bgzf]. The input file must exist and
          read permissions must be granted.
    --output (std::filesystem::path)
          A valid path for the output file. Write permissions must be granted.
    --threads (unsigned 8 bit integer)
          The number of threads to use. Default: 1. Value must be a positive
          integer.
    --quiet
          Do not print time and memory usage.

  k-mer options
    --kmer (unsigned 8 bit integer)
          The k-mer size. Default: 20, or read from layout file. Value must be
          in range [1,32].
    --window (unsigned 32 bit integer)
          The window size. Default: k-mer size. Value must be a positive
          integer.
    --shape (std::string)
          The shape to use for k-mers. Mutually exclusive with --kmer. Parsed
          from right to left. Default: 11111111111111111111 (a k-mer of size
          20), or read from layout file. Value must match the pattern '[01]+'.

  Index options
    --fpr (double)
          The false positive rate. Default: 0.050000, or read from layout
          file. Value must be in range [0.000000,1.000000].
    --hash (unsigned 64 bit integer)
          The number of hash functions to use. Default: 2, or read from layout
          file. Value must be in range [1,5].
    --parts (unsigned 8 bit integer)
          Splits the index in this many parts. Not available for the HIBF.
          Default: 1. Value must be a power of two.
    --compressed
          Build a compressed index.

  Common options
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man,
          ctd, cwl].

EXAMPLES
    raptor build --input bins.list --kmer 19 --window 23 --fpr 0.05 --output
    raptor.index

    raptor build --input bins.list --shape 11011 --window 8 --output
    raptor.index

    raptor build --input bins.list --kmer 32 --window 32 --hash 3 --parts 4
    --output raptor.index

    raptor build --input minimiser.list --fpr 0.05 --output raptor.index

    raptor build --input raptor.layout --output raptor.index

    raptor build --input raptor.layout --fpr 0.05 --output raptor.index

VERSION
    Last update: Unavailable
    Raptor-build version: 3.0.1 (commit unavailable)
    Sharg version: 1.1.1
    SeqAn version: 3.3.0

URL
    https://github.com/seqan/raptor

LEGAL
    Raptor-build Copyright: BSD 3-Clause License
    Author: Enrico Seiler
    Contact: enrico.seiler@fu-berlin.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
    In your academic works please cite: Raptor: A fast and space-efficient
    pre-filter for querying very large collections of nucleotide sequences;
    Enrico Seiler, Svenja Mehringer, Mitra Darvish, Etienne Turc, and Knut
    Reinert; iScience 2021 24 (7): 102782. doi:
    https://doi.org/10.1016/j.isci.2021.102782
    For full copyright and/or warranty information see --copyright.
```


## raptor_The

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[Error] You misspelled the subcommand! Please specify which sub-program you want to use: one of [build, layout, prepare, search, upgrade]. Use -h/--help for more information.
```


## raptor_specified

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[Error] You misspelled the subcommand! Please specify which sub-program you want to use: one of [build, layout, prepare, search, upgrade]. Use -h/--help for more information.
```


## raptor_subcommand

### Tool Description
Please specify which sub-program you want to use: one of [build, layout, prepare, search, upgrade].

### Metadata
- **Docker Image**: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
- **Homepage**: https://github.com/seqan/raptor
- **Package**: https://anaconda.org/channels/bioconda/packages/raptor/overview
- **Validation**: PASS

### Original Help Text
```text
[Error] You misspelled the subcommand! Please specify which sub-program you want to use: one of [build, layout, prepare, search, upgrade]. Use -h/--help for more information.
```

