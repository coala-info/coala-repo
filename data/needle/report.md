# needle CWL Generation Report

## needle_count

### Tool Description
Get expression value depending on minimizers. This function is only used to test the validity of Needle's estimation approach. It estimates the expression value for all sequences in the genome file based on the exact minimiser occurrences of the given sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/needle:1.0.1--h6dccd9a_3
- **Homepage**: https://github.com/seqan/needle
- **Package**: https://anaconda.org/channels/bioconda/packages/needle/overview
- **Validation**: PASS

### Original Help Text
```text
needle-count - Get expression value depending on minimizers. This function is only used to test the validity of Needle's estimation approach. It estimates the expression value for all sequences in the genome file based on the exact minimiser occurrences of the given sequence files.
==========================================================================================================================================================================================================================================================================================

POSITIONAL ARGUMENTS
    ARGUMENT-1 (List of std::filesystem::path)
          Please provide at least one sequence file. Default: [].

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].
    -k, --kmer (unsigned 8 bit integer)
          Define k-mer size for the minimisers. Default: 20. Default: 20.
    -w, --window (unsigned 32 bit integer)
          Define window size for the minimisers. Default: 60. Default: 0.
    --shape (unsigned 64 bit integer)
          Define a shape for the minimisers by the decimal of a bitvector,
          where 0 symbolizes a position to be ignored, 1 a position
          considered. Default: ungapped. Default: 0.
    --seed (unsigned 64 bit integer)
          Define seed for the minimisers. Default: 0.
    -o, --out (std::filesystem::path)
          Directory, where output files should be saved. Default: "./".
    -t, --threads (unsigned 8 bit integer)
          Number of threads to use. Default: 1. Default: 1.
    -g, --genome (std::filesystem::path)
          Please provide one sequence file with transcripts. Default: "".
    --exclude (std::filesystem::path)
          Please provide one sequence file with minimizers to ignore. Default:
          "".
    -p, --paired
          If set, experiments are paired. Default: Not paired.

VERSION
    Last update:
    needle-count version:
    SeqAn version: 3.0.3
```

## Metadata
- **Skill**: generated
