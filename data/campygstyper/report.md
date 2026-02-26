# campygstyper CWL Generation Report

## campygstyper

### Tool Description
CampyGStyper: a tool for rapid and accurate genome-wide SNP calling and cgMLST typing of Campylobacter jejuni.

### Metadata
- **Docker Image**: quay.io/biocontainers/campygstyper:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/LanLab/campygstyper
- **Package**: https://anaconda.org/channels/bioconda/packages/campygstyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/campygstyper/overview
- **Total Downloads**: 601
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LanLab/campygstyper
- **Stars**: N/A
### Original Help Text
```text
usage: campygstyper [-h] -i QUERY -r REFERENCE -o OUTPUT [-t THREAD]

options:
  -h, --help            show this help message and exit
  -i QUERY, --query QUERY
                        folder for the query genomes (default: None)
  -r REFERENCE, --reference REFERENCE
                        folder for the 60 medoid genomes (default: None)
  -o OUTPUT, --output OUTPUT
                        CampyGStyper output csv file (default: None)
  -t THREAD, --thread THREAD
                        number of thread to run fastANI (default: 4)
```

