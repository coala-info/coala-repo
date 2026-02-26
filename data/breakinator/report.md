# breakinator CWL Generation Report

## breakinator

### Tool Description
Flag foldbacks and chimeric reads from SAM/BAM/CRAM or PAF input

### Metadata
- **Docker Image**: quay.io/biocontainers/breakinator:1.1.1--h067a5f5_1
- **Homepage**: https://github.com/jheinz27/breakinator
- **Package**: https://anaconda.org/channels/bioconda/packages/breakinator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/breakinator/overview
- **Total Downloads**: 701
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/jheinz27/breakinator
- **Stars**: N/A
### Original Help Text
```text
Flag foldbacks and chimeric reads from SAM/BAM/CRAM or PAF input

Usage: breakinator [OPTIONS] --input <FILE>

Options:
  -i, --input <FILE>       SAM/BAM/CRAM file sorted by read IDs
      --paf                Input file is PAF
  -q, --min-mapq <INT>     Minimum mapping quality [default: 10]
  -a, --min-map-len <INT>  Minimum alignment length (bps) [default: 200]
      --no-sym             Report all foldback reads, not just those with breakpoint within margin of middle of read
  -g, --genome <FASTA>     Reference genome FASTA used (must be provided for CRAM input
  -m, --margin <FLOAT>     [0-1], Proportion from center of read on either side to be considered sym foldback artifact [default: 0.1]
      --rcoord             Print read coordinates of breakpoint in output
  -o, --out <FILE>         Output file name [default: breakinator_out.txt]
  -c, --chim <INT>         Minimum distance to be considered chimeric [default: 1000000]
  -f, --fold <INT>         Max distance to be considered foldback [default: 200]
      --tabular            Print a TSV table instead of the default report (useful if evaluating multiple samples)
  -t, --threads <INT>      Number of threads to use for BAM/CRAM I/O [default: 2]
  -h, --help               Print help
  -V, --version            Print version
```

