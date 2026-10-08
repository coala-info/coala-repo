# fasta_windows CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fasta_windows | PASS |  |

## fasta_windows

### Tool Description
Quickly compute statistics over a fasta file in windows.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasta_windows:0.2.4--h7b50bb2_4
- **Homepage**: https://github.com/tolkit/fasta_windows
- **Package**: https://anaconda.org/channels/bioconda/packages/fasta_windows/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fasta_windows/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tolkit/fasta_windows
- **Stars**: N/A
### Original Help Text
```text
Fasta windows 0.2.4
Max Brown <mb39@sanger.ac.uk>
Quickly compute statistics over a fasta file in windows.

USAGE:
    fasta_windows [OPTIONS] --fasta <fasta> --output <output>

OPTIONS:
    -d, --description                  Add an extra column to _windows.tsv output with fasta header
                                       descriptions.
    -f, --fasta <fasta>                The input fasta file.
    -h, --help                         Print help information
    -m, --masked                       Consider only uppercase nucleotides in the calculations.
    -o, --output <output>              Output filename for the TSV's (without extension).
    -V, --version                      Print version information
    -w, --window_size <window_size>    Integer size of window for statistics to be computed over.
                                       [default: 1000]
```

