# cligv CWL Generation Report

## cligv

### Tool Description
command line Interactive Genome Viewer. Displays FASTA sequence, VCF variants, and BAM alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/cligv:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/jonasfreudig/cligv
- **Package**: https://anaconda.org/channels/bioconda/packages/cligv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cligv/overview
- **Total Downloads**: 102
- **Last updated**: 2025-04-23
- **GitHub**: https://github.com/jonasfreudig/cligv
- **Stars**: N/A
### Original Help Text
```text
usage: cligv [-h] [-v VCF] [-b BAM] [-r REGION] [-t TAG] [--light-mode]
             [--log-level {DEBUG,INFO,WARNING,ERROR}] [--version]
             fasta

clIGV - command line Interactive Genome Viewer. Displays FASTA sequence, VCF variants, and BAM alignments.

positional arguments:
  fasta                 Path to the reference genome FASTA file (indexed with .fai)

options:
  -h, --help            show this help message and exit
  -v VCF, --vcf VCF     Path to VCF file (indexed with tabix)
  -b BAM, --bam BAM     Path to BAM file (indexed with .bai or .csi)
  -r REGION, --region REGION
                        Initial region (e.g., chr1:1000-2000, chrX:50000, chrY)
  -t TAG, --tag TAG     BAM tag name to use for coloring reads (e.g., 'ha' to use haplotype tags of STAR diploid)
  --light-mode          Use light color theme (for light background terminals)
  --log-level {DEBUG,INFO,WARNING,ERROR}
                        Set the logging level.
  --version             show program's version number and exit
Browser closed.
```

