# ontime CWL Generation Report

## ontime

### Tool Description
Extract subsets of ONT (Nanopore) reads based on time

### Metadata
- **Docker Image**: quay.io/biocontainers/ontime:0.3.1--h031d066_0
- **Homepage**: https://github.com/mbhall88/ontime
- **Package**: https://anaconda.org/channels/bioconda/packages/ontime/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ontime/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-08-01
- **GitHub**: https://github.com/mbhall88/ontime
- **Stars**: N/A
### Original Help Text
```text
Extract subsets of ONT (Nanopore) reads based on time

Usage: ontime [OPTIONS] <FILE>

Arguments:
  <FILE>
          Input fastq/fasta/BAM/SAM file

Options:
  -o, --output <FILE>
          Output file name [default: stdout]
          
          Note: you cannot output a fastq if a BAM/SAM input is given and vice versa. Use samtools for post-processing. However, you can output SAM if the input is BAM and vice versa.

  -O, --output-type <u|b|g|l>
          (fastq/a output only) u: uncompressed; b: Bzip2; g: Gzip; l: Lzma
          
          ontime will attempt to infer the output compression format automatically from the output extension. If writing to stdout, the default is uncompressed (u)

  -L, --compress-level <1-21>
          Compression level to use if compressing fastq output
          
          [default: 6]

  -f, --from <DATE/DURATION>
          Earliest start time; otherwise the earliest time is used
          
          This can be a timestamp - e.g. 2022-11-20T18:00:00 - or a duration from the start - e.g. 2h30m (2 hours and 30 minutes from the start). See the docs for more examples

  -t, --to <DATE/DURATION>
          Latest start time; otherwise the latest time is used
          
          See --from (and docs) for examples

  -s, --show
          Show the earliest and latest start times in the input and exit

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

