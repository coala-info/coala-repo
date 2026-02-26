# pybarrnap CWL Generation Report

## pybarrnap

### Tool Description
Python implementation of barrnap (Bacterial ribosomal RNA predictor)

### Metadata
- **Docker Image**: quay.io/biocontainers/pybarrnap:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/pybarrnap/
- **Package**: https://anaconda.org/channels/bioconda/packages/pybarrnap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pybarrnap/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moshi4/pybarrnap
- **Stars**: N/A
### Original Help Text
```text
usage: pybarrnap [options] genome.fna[.gz] > genome_rrna.gff

Python implementation of barrnap (Bacterial ribosomal RNA predictor)

positional arguments:
  fasta              Input fasta file (or stdin)

options:
  -e , --evalue      E-value cutoff (default: 1e-06)
  -l , --lencutoff   Proportional length threshold to label as partial (default: 0.8)
  -r , --reject      Proportional length threshold to reject prediction (default: 0.25)
  -t , --threads     Number of threads (default: 1)
  -k , --kingdom     Target kingdom [bac|arc|euk|all] (default: 'bac')
                     kingdom='all' is available only when set with `--accurate` option
  -o , --outseq      Output rRNA hit seqs as fasta file (default: None)
  -i, --incseq       Include FASTA input sequences in GFF output (default: OFF)
  -a, --accurate     Use cmscan instead of pyhmmer.nhmmer (default: OFF)
  -q, --quiet        No print log on screen (default: OFF)
  -v, --version      Print version information
  -h, --help         Show this help message and exit
```

