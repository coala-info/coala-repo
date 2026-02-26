# phastaf CWL Generation Report

## phastaf

### Tool Description
Find phage regions in bacterial genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/phastaf:0.1.0--0
- **Homepage**: https://github.com/tseemann/phastaf
- **Package**: https://anaconda.org/channels/bioconda/packages/phastaf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phastaf/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tseemann/phastaf
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
  Find phage regions in bacterial genomes
USAGE
  phastaf [options] --outdir OUTDIR contigs.{fna,gbk,gff}[.gz]
OPTIONS
  --help        This help
  --version     Print version and exit
  --check       Check dependencies are installed
  --force       Force overwite of existing output folder (default: OFF)
  --keepfiles   Keep intermediate files (default: OFF)
  --outdir XXX  Output folder (default: '')
  --db XXX      Diamond database of phage proteins (default: '/usr/local/db/phastaf.dmnd')
  --cpus N      Number of CPUs to use (0=ALL) (default: 1)
  --igff N      Intergenic fuzz factor (default: 2000)
  --mingenes N  Minimum genes in cluster (default: 5)
HOMEPAGE
  https://github.com/tseemann/phastaf
```

