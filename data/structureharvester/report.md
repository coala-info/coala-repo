# structureharvester CWL Generation Report

## structureharvester_structureHarvester.py

### Tool Description
Takes a STRUCTURE results directory (--dir) and an output directory (--out will be created if it does not exist) and then depending on the other options selected harvests data from the results directory and performs the selected analyses

### Metadata
- **Docker Image**: quay.io/biocontainers/structureharvester:0.6.94--py27_0
- **Homepage**: http://alumni.soe.ucsc.edu/~dearl/software/structureHarvester/
- **Package**: https://anaconda.org/channels/bioconda/packages/structureharvester/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/structureharvester/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: usage: structureHarvester.py --dir=path/to/dir/ --out=path/to/dir/ [options]

structureHarvester.py takes a STRUCTURE results directory (--dir) and an
output directory (--out will be created if it does not exist) and then
depending on the other options selected harvests data from the results
directory and performs the selected analyses

optional arguments:
  -h, --help        show this help message and exit
  -v, --version     show program's version number and exit
  --dir RESULTSDIR  The structure Results/ directory.
  --out OUTDIR      The out directory. If it does not exist, it will be
                    created. Output written to summary.txt
  --evanno          If possible, performs the Evanno 2005 method. Written to
                    evanno.txt. default=False
  --clumpp          Generates one K*.indfile for each value of K run, for use
                    with CLUMPP. default=False
```

