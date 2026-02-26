# dnadotplot CWL Generation Report

## dnadotplot

### Tool Description
A DNA dot plot generator

### Metadata
- **Docker Image**: quay.io/biocontainers/dnadotplot:0.1.4--hc1c3326_0
- **Homepage**: https://github.com/quadram-institute-bioscience/dnadotplot
- **Package**: https://anaconda.org/channels/bioconda/packages/dnadotplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnadotplot/overview
- **Total Downloads**: 241
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/quadram-institute-bioscience/dnadotplot
- **Stars**: N/A
### Original Help Text
```text
A DNA dot plot generator

Usage: dnadotplot [OPTIONS] --first-file <FILE> --output <FILE>

Options:
  -1, --first-file <FILE>   Path to the first FASTA file (can be gzipped)
  -2, --second-file <FILE>  Path to the second FASTA file (if omitted, self alignment of the first)
  -f, --first-name <STR>    Name of the FASTA sequence in the first file
  -n, --second-name <STR>   Name of the FASTA sequence in the second file
  -o, --output <FILE>       Path to the output file (PNG or SVG based on extension)
  -s, --img-size <FLOAT>    Image size: if >1 use as pixels, if <1 use as fraction of longest sequence [default: 0.3]
  -w, --window <INT>        Window size for matching (default: 10) [default: 10]
  -r, --revcompl            Also look for reverse complement matches
      --svg                 Force SVG output (auto-detected from .svg extension)
  -h, --help                Print help
  -V, --version             Print version
```

