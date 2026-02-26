# gpsw CWL Generation Report

## gpsw_fetch

### Tool Description
Fetch GPSW code from a specific release from https://github.com/niekwit/gps-orfeome.

### Metadata
- **Docker Image**: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
- **Homepage**: https://github.com/niekwit/gps-orfeome
- **Package**: https://anaconda.org/channels/bioconda/packages/gpsw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gpsw/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/niekwit/gps-orfeome
- **Stars**: N/A
### Original Help Text
```text
usage: gpsw fetch [-h] [-t TAG] [--test-data] [-d DIRECTORY]

Fetch GPSW code from a specific release from https://github.com/niekwit/gps-
orfeome.

options:
  -h, --help            show this help message and exit
  -t TAG, --tag TAG     Release tag of the code to download (default: latest)
  --test-data           Include test data in the download (and relating config
                        and resources directories)
  -d DIRECTORY, --directory DIRECTORY
                        Directory to download the code to target directory
                        (default: current directory)
```


## gpsw_run

### Tool Description
Run the GPSW pipeline and create report.

### Metadata
- **Docker Image**: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
- **Homepage**: https://github.com/niekwit/gps-orfeome
- **Package**: https://anaconda.org/channels/bioconda/packages/gpsw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gpsw run [-h] [-p PROFILE] [--snakemake-args SNAKEMAKE_ARGS] [-d] [-q]

Run the GPSW pipeline and create report.

options:
  -h, --help            show this help message and exit
  -p PROFILE, --profile PROFILE
                        Path to Snakemake profile YAML file (only has to be
                        provided at first run) (OPTIONAL, use value None for
                        no profile)
  --snakemake-args SNAKEMAKE_ARGS
                        Extra Snakemake arguments (should be '"double-
                        quoted"')
  -d, --dry-run         Dry-run workflow only
  -q, --quiet           Run GPSW quietly
```


## Metadata
- **Skill**: generated

## gpsw

### Tool Description
GPSW: A tool for analysing and processing Global Protein Stability Profiling data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
- **Homepage**: https://github.com/niekwit/gps-orfeome
- **Package**: https://anaconda.org/channels/bioconda/packages/gpsw/overview
- **Validation**: PASS
### Original Help Text
```text
usage: gpsw [-h] [--version] {fetch,run} ...

GPSW: A tool for analysing and processing Global Protein Stability Profiling
data.

positional arguments:
  {fetch,run}  Sub-command help

options:
  -h, --help   show this help message and exit
  --version    show program's version number and exit
```

