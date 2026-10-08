# gtfsort CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gtfsort | PASS | real GENCODE chr21 and chr1 GTF shuffled; output has the same lines, genes sorted by position; note: orphan exons or gene-only GTF can drop lines or panic |

## gtfsort

### Tool Description
An optimized chr/pos/feature GTF2.5-3 sorter using a lexicographic-based index ordering algorithm written in Rust.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtfsort:0.2.2--ha6fb395_2
- **Homepage**: https://github.com/alejandrogzi/gtfsort
- **Package**: https://anaconda.org/channels/bioconda/packages/gtfsort/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gtfsort/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-08-10
- **GitHub**: https://github.com/alejandrogzi/gtfsort
- **Stars**: N/A
### Original Help Text
```text
An optimized chr/pos/feature GTF2.5-3 sorter using a lexicographic-based index ordering algorithm written in Rust.

Usage: gtfsort [OPTIONS] --input <UNSORTED> --output <OUTPUT>

Options:
  -i, --input <UNSORTED>   Path to unsorted GTF file
  -o, --output <OUTPUT>    Path to output sorted GTF file
  -t, --threads <THREADS>  Number of threads [default: 20]
  -h, --help               Print help
  -V, --version            Print version
```

