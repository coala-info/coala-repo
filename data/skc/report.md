# skc CWL Generation Report

## skc

### Tool Description
Shared k-mer content between two genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/skc:0.1.0--h7b50bb2_1
- **Homepage**: https://github.com/mbhall88/skc
- **Package**: https://anaconda.org/channels/bioconda/packages/skc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/skc/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mbhall88/skc
- **Stars**: N/A
### Original Help Text
```text
Shared k-mer content between two genomes

Usage: skc [OPTIONS] <TARGET> <QUERY>

Arguments:
  <TARGET>
          Target sequence (smallest of the two genomes recommended)
          
          Can be compressed with gzip, bzip2, xz, or zstd

  <QUERY>
          Query sequence
          
          Can be compressed with gzip, bzip2, xz, or zstd

Options:
  -k, --kmer <KMER>
          Size of k-mers (max. 32)
          
          [default: 21]

  -o, --output <OUTPUT>
          Output filepath(s); stdout if not present

  -O, --output-type <u|b|g|l|z>
          u: uncompressed; b: Bzip2; g: Gzip; l: Lzma; z: Zstd
          
          Output compression format is automatically guessed from the filename extension. This option is used to override that
          
          [default: u]

  -l, --compress-level <INT>
          Compression level to use if compressing output
          
          [default: 6]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

