# gfainject CWL Generation Report

## gfainject

### Tool Description
Injects sequence information from BAM/PAF/GBAM files into a GFA graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfainject:0.2.0--h3ab6199_0
- **Homepage**: https://github.com/AndreaGuarracino/gfainject
- **Package**: https://anaconda.org/channels/bioconda/packages/gfainject/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfainject/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AndreaGuarracino/gfainject
- **Stars**: N/A
### Original Help Text
```text
Usage: gfainject [OPTIONS] --gfa <GFA> <--bam <BAM>|--paf <PAF>|--gbam <GBAM>|--range <RANGE>>

Options:
      --gfa <GFA>            Path to input GFA file
  -b, --bam <BAM>            Path to input BAM file
  -p, --paf <PAF>            Path to input PAF file
  -g, --gbam <GBAM>          Path to input GBAM file
  -r, --range <RANGE>        Range query in format "path_name:start-end"
      --alt-hits <ALT_HITS>  Emit up to ALT_HITS alternative alignments (from XA tag, only for BAM/GBAM input)
  -h, --help                 Print help
  -V, --version              Print version
```

