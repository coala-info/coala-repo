# cadd-scripts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cadd-scripts_cadd-install.sh | Not completed | CADD runs a Snakemake pipeline that needs the multi-hundred-GB annotation database and conda or Apptainer environments. |
| cadd-scripts_cadd.sh | Not completed | CADD runs a Snakemake pipeline that needs the multi-hundred-GB annotation database and conda or Apptainer environments. |

## cadd-scripts_cadd-install.sh

### Tool Description
CADD version 1.7

### Metadata
- **Docker Image**: quay.io/biocontainers/cadd-scripts:1.7.3--hdfd78af_0
- **Homepage**: https://github.com/kircherlab/CADD-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/cadd-scripts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cadd-scripts/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-11-02
- **GitHub**: https://github.com/kircherlab/CADD-scripts
- **Stars**: N/A
### Original Help Text
```text
CADD.sh [-o <outfile>] [-g <genomebuild>] [-v <caddversion>] [-a] <infile>  -- CADD version 1.7

where:
    -h  show this help text
    -o  out tsv.gz file (generated from input file name if not set)
    -g  genome build (supported are GRCh37 and GRCh38 [default: GRCh38])
    -v  CADD version (only v1.7 possible with this set of scripts [default: v1.7])
    -a  include annotation in output
        input vcf of vcf.gz file (required)
    -m  use conda only (no apptainer/singularity)
    -r  singularity/apptainer arguments, e.g. "--bind /data/mnt/x --nv" [default "" but will always add "--bind "]
    -q  print basic information about snakemake run
    -p  print full information about the snakemake run
    -d  do not remove temporary directory for debug puroposes
    -c  number of cores that snakemake is allowed to use [default: 1]
```


## cadd-scripts_cadd.sh

### Tool Description
CADD version 1.7

### Metadata
- **Docker Image**: quay.io/biocontainers/cadd-scripts:1.7.3--hdfd78af_0
- **Homepage**: https://github.com/kircherlab/CADD-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/cadd-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
CADD.sh [-o <outfile>] [-g <genomebuild>] [-v <caddversion>] [-a] <infile>  -- CADD version 1.7

where:
    -h  show this help text
    -o  out tsv.gz file (generated from input file name if not set)
    -g  genome build (supported are GRCh37 and GRCh38 [default: GRCh38])
    -v  CADD version (only v1.7 possible with this set of scripts [default: v1.7])
    -a  include annotation in output
        input vcf of vcf.gz file (required)
    -m  use conda only (no apptainer/singularity)
    -r  singularity/apptainer arguments, e.g. "--bind /data/mnt/x --nv" [default "" but will always add "--bind "]
    -q  print basic information about snakemake run
    -p  print full information about the snakemake run
    -d  do not remove temporary directory for debug puroposes
    -c  number of cores that snakemake is allowed to use [default: 1]
```


## Metadata
- **Skill**: generated
