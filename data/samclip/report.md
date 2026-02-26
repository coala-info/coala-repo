# samclip CWL Generation Report

## samclip

### Tool Description
Filter SAM file for soft & hard clipped alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/samclip:0.4.0--hdfd78af_1
- **Homepage**: https://github.com/tseemann/samclip
- **Package**: https://anaconda.org/channels/bioconda/packages/samclip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samclip/overview
- **Total Downloads**: 50.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tseemann/samclip
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
  Filter SAM file for soft & hard clipped alignments
AUTHOR
  Torsten Seemann (@torstenseemann)
USAGE
  % samclip --ref ref.fa < in.sam > out.sam
  % minimap2 ref.fa R1.fq R2.fq | samclip --ref ref.fa | samtools sort > out.bam
OPTIONS
  --help         This help
  --version      Print version and exit
  --ref FASTA    Reference genome - needs FASTA.fai index
  --max NUM      Maximum clip length to allow (default=5)
  --invert       Output rejected SAM lines and ignore good ones
  --debug        Print verbose debug info to stderr
  --progress N   Print progress every NUM records (default=100000,none=0)
HOMEPAGE
  https://github.com/tseemann/samclip
```

