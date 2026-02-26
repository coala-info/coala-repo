# derna CWL Generation Report

## derna

### Tool Description
RNA secondary structure prediction and evaluation tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/derna:1.0.4--h503566f_1
- **Homepage**: https://github.com/elkebir-group/derna
- **Package**: https://anaconda.org/channels/bioconda/packages/derna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/derna/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elkebir-group/derna
- **Stars**: N/A
### Original Help Text
```text
Usage:
 -i -- input file path
 -o -- output file path
 -m -- model <0,1,-1> , 0 for Nussinov-based model, 1 for Zuker-based model, -1 for Evaluation
 -s -- mode <1,2,3>, 1 for MFE only, 2 for balancing MFE and CAI at fixed lambda, 3 for lambda sweep
 -l -- lambda <[0,1]>
 -a -- sweep increment <(0,1]>
 -r -- input rna file path
 -O -- sweep output csv file name
 -g -- minimum gap allowed in Nussinov <[0,inf)>
 -t -- threshold tau1 <(0,1)>
 -p -- threshold tau2 <(0,1)>
 -c -- codon usage table file path
 -d -- directory to energy parameters
 ...
```

