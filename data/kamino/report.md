# kamino CWL Generation Report

## kamino

### Tool Description
Build phylogenomic datasets in seconds.

### Metadata
- **Docker Image**: quay.io/biocontainers/kamino:0.7.0--h4349ce8_0
- **Homepage**: https://github.com/rderelle/kamino
- **Package**: https://anaconda.org/channels/bioconda/packages/kamino/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kamino/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/rderelle/kamino
- **Stars**: N/A
### Original Help Text
```text
Build phylogenomic datasets in seconds.

Usage: kamino [OPTIONS] <--input-directory <INPUT>|--input-file <INPUT_FILE>>

Options:
  -i, --input-directory <INPUT>        Input directory with FASTA proteomes (plain or .gz)
  -I, --input-file <INPUT_FILE>        Tab-delimited file mapping species name to proteome path
  -k, --k <K>                          K-mer length [k=14]
  -f, --min-freq <MIN_FREQ>            Minimal fraction of samples with an amino-acid per position [m=0.85]
  -d, --depth <DEPTH>                  Maximum traversal depth from each start node [d=6]
  -o, --output <OUTPUT>                Output prefix [o=kamino] [default: kamino]
  -c, --constant <CONSTANT>            Number of constant positions to keep from the in-bubble k-mer [c=3]
  -l, --length-middle <LENGTH_MIDDLE>  Maximum number of middle positions per variant group [l=2*k]
  -m, --mask <MASK>                    Mask middle segments with long mismatch runs [m=5]
  -t, --threads <THREADS>              Number of threads [t=1]
  -r, --recode <RECODE>                Recoding scheme [r=sr6] [possible values: dayhoff6, sr6, kgb6]
      --nj                             Generate a NJ tree from kamino alignment [nj=false]
  -v, --version                        Display version information
  -h, --help                           Print help
```

