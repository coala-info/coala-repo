# pullseq CWL Generation Report

## pullseq

### Tool Description
a bioinformatics tool for manipulating fasta and fastq files

### Metadata
- **Docker Image**: quay.io/biocontainers/pullseq:1.0.2--h1104d80_11
- **Homepage**: https://github.com/bcthomas/pullseq
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pullseq/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcthomas/pullseq
- **Stars**: N/A
### Original Help Text
```text
pullseq - a bioinformatics tool for manipulating fasta and fastq files

Version: 1.0.2              Name lookup method: UTHASH
(Written by bct - copyright 2012-2015)

Usage:
 pullseq -i <input fasta/fastq file> -n <header names to select>

 pullseq -i <input fasta/fastq file> -m <minimum sequence length>

 pullseq -i <input fasta/fastq file> -g <regex name to match>

 pullseq -i <input fasta/fastq file> -m <minimum sequence length> -a <max sequence length>

 pullseq -i <input fasta/fastq file> -t

 cat <names to select from STDIN> | pullseq -i <input fasta/fastq file> -N

  Options:
    -i, --input,       Input fasta/fastq file (required)
    -n, --names,       File of header id names to search for
    -N, --names_stdin, Use STDIN for header id names
    -g, --regex,       Regular expression to match (PERL compatible; always case-insensitive)
    -m, --min,         Minimum sequence length
    -a, --max,         Maximum sequence length
    -l, --length,      Sequence characters per line (default 50)
    -c, --convert,     Convert input to fastq/fasta (e.g. if input is fastq, output will be fasta)
    -q, --quality,     ASCII code to use for fasta->fastq quality conversions
    -e, --excluded,    Exclude the header id names in the list (-n)
    -t, --count,       Just count the possible output, but don't write it
    -h, --help,        Display this help and exit
    -v, --verbose,     Print extra details during the run
    --version,         Output version information and exit
```

