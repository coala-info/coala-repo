# bcool CWL Generation Report

## bcool

### Tool Description
De Bruijn graph based read corrector

### Metadata
- **Docker Image**: quay.io/biocontainers/bcool:1.0.0--py35_0
- **Homepage**: https://github.com/Malfoy/BCOOL
- **Package**: https://anaconda.org/channels/bioconda/packages/bcool/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcool/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Malfoy/BCOOL
- **Stars**: N/A
### Original Help Text
```text
*** This is Bcool - de Bruin graph based corrector  ***

The command line was: /usr/local/bin/bcool
[Warning] / directory already exists, BCOOL will use it.
Results will be stored in:  //
usage: bcool [-h] [-u SINGLE_READFILES] [-o OUT_DIR] [-t NB_CORES] [-k KSIZE]
             [-s MIN_COV] [-S UNITIG_COVERAGE] [-m MISSMATCH_ALLOWED]
             [-i SUBSAMBLE_ANCHOR] [-n MAXIMUM_OCCURENCE] [-d DEBUG]

BCOOL - De Bruijn graph based read corrector 

optional arguments:
  -h, --help            show this help message and exit
  -u SINGLE_READFILES   (MANDATORY) input fasta read files. Several read files must be concatenated
  -o OUT_DIR            Path to store the results (Default = current directory)
  -t NB_CORES           Number of cores used (Default = 1)
                         
  -k KSIZE              k-mer size (Default = AUTO)
  -s MIN_COV            k-mers present strictly less than this number of times in the dataset will be discarded (Default = 2)
  -S UNITIG_COVERAGE    Unitig Coverage for cleaning (Default = AUTO)
                         
  -m MISSMATCH_ALLOWED  (ADVANCED) Maximum number of corrected bases (Default = 10)
  -i SUBSAMBLE_ANCHOR   (ADVANCED) index one out of i anchors to reduce memory consumption (Default = 1)
  -n MAXIMUM_OCCURENCE  (ADVANCED) Maximum occurence of an anchor (Default = 1), better correction for repetitive genome but slower
  -d DEBUG              (ADVANCED) Print command lines
                         
Bcool need a need file to correct...
```

