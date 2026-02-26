# distle CWL Generation Report

## distle

### Tool Description
Calculate pairwise distances between sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/distle:0.3.0--h54198d6_1
- **Homepage**: https://github.com/KHajji/distle
- **Package**: https://anaconda.org/channels/bioconda/packages/distle/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/distle/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/KHajji/distle
- **Stars**: N/A
### Original Help Text
```text
Usage: distle [OPTIONS] <INPUT> <OUTPUT>

Arguments:
  <INPUT>
          The input file or '-' for stdin

  <OUTPUT>
          The output file or '-' for stdout

Options:
  -i, --input-format <INPUT_FORMAT>
          The format of the input file

          Possible values:
          - cgmlst:      A cgmlst table with allele numbers. Optimized for ChewBBACA output
          - cgmlst-hash: A cgmlst table with SHA1 hashes of the nucleotide of the alleles
          - fasta:       An alignment of nucleotide sequences in FASTA format
          - fasta-all:   An alignment of nucleotide sequences in FASTA format. Counts all differences and not just [ACTG]
          
          [default: fasta]

  -o, --output-format <OUTPUT_FORMAT>
          The format of the output file

          Possible values:
          - tabular: Output the distances in a tabular long format
          - phylip:  Output the distances in a Phylip format
          
          [default: tabular]

      --precomputed-distances <PRECOMPUTED_DISTANCES>
          A file with precomputed distances that don't have to be calculated again. The file should be in tabular long format and have the separator as specified by the output-sep flag

      --input-sep <INPUT_SEP>
          The separator character for the input file. Relevant for tabular input files
          
          [default: "\t"]

      --output-sep <OUTPUT_SEP>
          The separator character for the output file
          
          [default: "\t"]

  -m, --output-mode <OUTPUT_MODE>
          The output mode

          Possible values:
          - lower-triangle: Only output the lower triangle of the distance matrix since it is diagonally symmetric
          - full:           Output the full distance matrix
          
          [default: lower-triangle]

  -d, --maxdist <MAXDIST>
          If set, distance calculations will be stopped when this distance is reached. Useful for large datasets

  -t, --threads <THREADS>
          Number of threads to use. If not set, all available threads will be used

  -s, --skip-header
          Skip the header line of the input file. Relevant for tabular input files

  -v, --verbose
          Enable verbose mode. Outputs debug messages and calculation times

  -q, --quiet
          Quiet mode. Suppresses all output except for errors

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

