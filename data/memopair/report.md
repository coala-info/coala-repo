# memopair CWL Generation Report

## memopair

### Tool Description
Methylation Motif Pairs

### Metadata
- **Docker Image**: quay.io/biocontainers/memopair:0.1.6--h4349ce8_0
- **Homepage**: https://github.com/SorenHeidelbach/memopair
- **Package**: https://anaconda.org/channels/bioconda/packages/memopair/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/memopair/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SorenHeidelbach/memopair
- **Stars**: N/A
### Original Help Text
```text
Methylation Motif Pairs

Usage: memopair [OPTIONS] <REFERENCE> <PILEUP> [MOTIFS]...

Arguments:
  <REFERENCE>  File path to the fasta file with references
  <PILEUP>     File path to the pileup file with methylation data
  [MOTIFS]...  Comeplement motif pairs in the format: 'MOTIF_TYPE1_POS1_TYPE2_POS2', e.g. 'ACGT_a_0_m_3' or 'CCWGG_4mC_0_5mC_3'

Options:
  -o, --out <OUT>                Output file path [default: memopair]
      --min-cov <MIN_COV>        Minimum coverage required to consider a position [default: 5]
  -t, --threads <THREADS>        Number of threads to use [default: 5]
      --batch-size <BATCH_SIZE>  Number of contigs to load and process at once [default: 100]
      --verbosity <VERBOSITY>    Verbosity level [default: normal] [possible values: verbose, normal, silent]
  -h, --help                     Print help
  -V, --version                  Print version
```

