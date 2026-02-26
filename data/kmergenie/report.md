# kmergenie CWL Generation Report

## kmergenie

### Tool Description
KmerGenie 1.7051

### Metadata
- **Docker Image**: quay.io/biocontainers/kmergenie:1.7051--py27r40h077b44d_11
- **Homepage**: http://kmergenie.bx.psu.edu
- **Package**: https://anaconda.org/channels/bioconda/packages/kmergenie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmergenie/overview
- **Total Downloads**: 29.2K
- **Last updated**: 2025-07-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
KmerGenie 1.7051

Usage:
    kmergenie <read_file> [options]

Options:
    --diploid    use the diploid model (default: haploid model)
    --one-pass   skip the second pass to estimate k at 2 bp resolution (default: two passes)
    -k <value>   largest k-mer size to consider (default: 121)
    -l <value>   smallest k-mer size to consider (default: 15)
    -s <value>   interval between consecutive kmer sizes (default: 10)
    -e <value>   k-mer sampling value (default: auto-detected to use ~200 MB memory/thread)
    -t <value>   number of threads (default: number of cores minus one)
    -o <prefix>  prefix of the output files (default: histograms)
    --debug      developer output of R scripts
    --orig-hist  legacy histogram estimation method (slower, less accurate)
```

