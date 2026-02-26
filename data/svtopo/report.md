# svtopo CWL Generation Report

## svtopo

### Tool Description
svtopo is a tool for analyzing structural variants from PacBio HiFi sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtopo:0.3.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/HiFi-SVTopo
- **Package**: https://anaconda.org/channels/bioconda/packages/svtopo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svtopo/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/PacificBiosciences/HiFi-SVTopo
- **Stars**: N/A
### Original Help Text
```text
Usage: svtopo [OPTIONS] --bam <BAM> --svtopo-dir <STRING> --prefix <STRING> --exclude-regions <BED>

Options:
      --bam <BAM>                 pbmm2-aligned BAM filename
      --svtopo-dir <STRING>       Output directory path
      --prefix <STRING>           Sample or project ID. No underscores allowed
      --vcf <VCF>                 (Recommended) structual variant VCF filename
      --variant-readnames <JSON>  (Recommended) json with readnames for variant IDs from VCF. Requires `--vcf`
      --exclude-regions <BED>     BED file of regions to exclude from analysis. GZIP files allowed
      --max-coverage <INT>        Filter threshold for maximum coverage, to remove regions with coverage spikes due to e.g. alignment issues [default: 300]
      --verbose                   Optional flag to print verbose output for debugging purposes
  -h, --help                      Print help
  -V, --version                   Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
