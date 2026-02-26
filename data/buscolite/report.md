# buscolite CWL Generation Report

## buscolite

### Tool Description
BUSCOlite: simplified BUSCO analysis for genome annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/buscolite:26.1.26--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/buscolite
- **Package**: https://anaconda.org/channels/bioconda/packages/buscolite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/buscolite/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2026-02-08
- **GitHub**: https://github.com/nextgenusfs/buscolite
- **Stars**: N/A
### Original Help Text
```text
usage: buscolite -i  -o  -m  -l  [-c ] [-s ] [-f ] [-h] [--version]

BUSCOlite: simplified BUSCO analysis for genome annotation

Required arguments:
  -i, --input     Input sequence file in FASTA format (genome or proteome)
  -o, --out       Give your analysis run a recognisable short name
  -m, --mode      Specify which BUSCO analysis mode to run. [genome, proteins
  -l, --lineage   Specify location of the BUSCO lineage data to be used (full
                  path).

Optional arguments:
  -c, --cpus      Specify the number (N=integer) of threads/cores to use.
                  (default: 1)
  -s, --species   Name of existing Augustus species gene finding parameters.
                  (default: anidulans)
  -f, --flanks    Length of flanking region to use for augustus prediction
                  from miniprot hits. (default: 2000)

Help:
  -h, --help      Show this help message and exit
  --version       show program's version number and exit
```

