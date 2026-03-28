# gmsc-mapper CWL Generation Report

## gmsc-mapper_downloaddb

### Tool Description
Download the GMSCMapper database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/GMSC-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Total Downloads**: 613
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BigDataBiology/GMSC-mapper
- **Stars**: N/A
### Original Help Text
```text
usage: gmsc-mapper downloaddb [-h] [--dbdir DBDIR] [--all] [-f]

options:
  -h, --help     show this help message and exit
  --dbdir DBDIR  Path to the database files.
  --all          Download all database
  -f             Force download even if the files exist
```


## gmsc-mapper_createdb

### Tool Description
Create a database for GMSC.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/GMSC-mapper
- **Package**: https://anaconda.org/channels/bioconda/packages/gmsc-mapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gmsc-mapper createdb [-h] -i TARGET_FAA [-o OUTPUT] -m MODE [--quiet]

options:
  -h, --help            show this help message and exit
  -i TARGET_FAA         Path to the GMSC FASTA file.
  -o OUTPUT, --output OUTPUT
                        Path to database output directory.
  -m MODE, --mode MODE  Alignment tool (Diamond / MMseqs2)
  --quiet               Disable alignment console output
```


## Metadata
- **Skill**: generated
