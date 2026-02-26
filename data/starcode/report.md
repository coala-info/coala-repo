# starcode CWL Generation Report

## starcode

### Tool Description
starcode-v1.4 2020-11-02

### Metadata
- **Docker Image**: quay.io/biocontainers/starcode:1.4--h7b50bb2_6
- **Homepage**: https://github.com/gui11aume/starcode
- **Package**: https://anaconda.org/channels/bioconda/packages/starcode/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/starcode/overview
- **Total Downloads**: 70.1K
- **Last updated**: 2025-06-27
- **GitHub**: https://github.com/gui11aume/starcode
- **Stars**: N/A
### Original Help Text
```text
starcode-v1.4 2020-11-02

Usage:  starcode [options]

  general options:
    -d --dist: maximum Levenshtein distance (default auto)
    -t --threads: number of concurrent threads (default 1)
    -q --quiet: quiet output (default verbose)
    -v --version: display version and exit

  cluster options: (default algorithm: message passing)
    -r --cluster-ratio: min size ratio for merging clusters in
               message passing (default 5.0)
    -s --sphere: use sphere clustering algorithm
    -c --connected-comp: cluster connected components

  input/output options (single file, default)
    -i --input: input file (default stdin)
    -o --output: output file (default stdout)

  input options (paired-end fastq files)
    -1 --input1: input file 1
    -2 --input2: input file 2

  output options (paired-end fastq files, --non-redundant only)
       --output1: output file1 (default input1-starcode.fastq)
       --output2: output file2 (default input2-starcode.fastq)

  output format options
       --non-redundant: remove redundant sequences from input file(s)
       --print-clusters: outputs cluster compositions
       --seq-id: print sequence id numbers (1-based)
```

