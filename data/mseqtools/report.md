# mseqtools CWL Generation Report

## mseqtools_subset

### Tool Description
Subset a fasta/fastq file based on a list of identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/mseqtools:0.9.1--h7132678_1
- **Homepage**: https://github.com/arumugamlab/mseqtools
- **Package**: https://anaconda.org/channels/bioconda/packages/mseqtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mseqtools/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arumugamlab/mseqtools
- **Stars**: N/A
### Original Help Text
```text
Usage:
------

mseqtools subset [-vuph] -i <file> -o <file> -l <file> [-w <int>]

Options:
--------

  -i, --input=<file>        input fasta/fastq file
  -o, --output=<file>       output file (gzipped)
  -l, --list=<file>         file containing list of fasta/fastq identifiers
  -v, --exclude             exclude sequences in this list (default: false)
  -u, --uncompressed        write uncompressed output (default: false)
  -p, --paired              get both reads from a pair corresponding to the entry; needs pairs to be marked with /1 and /2 (default: false)
  -w, --window=<int>        number of chars per line in fasta file (default: 80)
  -h, --help                print this help and exit
```


## Metadata
- **Skill**: generated

## mseqtools

### Tool Description
Sequence manipulation toolkit

### Metadata
- **Docker Image**: quay.io/biocontainers/mseqtools:0.9.1--h7132678_1
- **Homepage**: https://github.com/arumugamlab/mseqtools
- **Package**: https://anaconda.org/channels/bioconda/packages/mseqtools/overview
- **Validation**: PASS
### Original Help Text
```text
Program: mseqtools (Sequence manipulation toolkit)
Version: 0.9.1

Usage:   mseqtools <command> [options]

Commands:
 -- Subsetting
     subset         subset sequences based on a given list
```

