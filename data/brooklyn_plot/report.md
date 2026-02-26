# brooklyn_plot CWL Generation Report

## brooklyn_plot

### Tool Description
Gene co-expression and transcriptional bursting pattern recognition tool in single cell/nucleus RNA-sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/brooklyn_plot:0.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/arunhpatil/brooklyn/
- **Package**: https://anaconda.org/channels/bioconda/packages/brooklyn_plot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/brooklyn_plot/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arunhpatil/brooklyn
- **Stars**: N/A
### Original Help Text
```text
usage: brooklyn_plot [options]

Brooklyn (Gene co-expression and transcriptional bursting pattern recognition tool in single cell/nucleus RNA-sequencing data)

options:
  -h, --help  show this help message and exit
  --version   show program's version number and exit

Options:
  
  -h5,   --h5ad               input file in .h5ad format (accepts .h5ad) 
  -ba,   --biomart            the reference gene annotations (in .csv format) 
  -od,   --outDir             the directory of the outputs (Default: brooklyn-date-hh-mm-ss) 
  -of,   --outFile            the name of summarized brooklyn file as CSV file and a brooklyn plot in PDF (Default: brooklyn)
  -ql,   --query              the list of genes to be queried upon (one gene per line and in .csv format)
  -sl,   --subject            the list of genes to be compared with (one gene per line and in .csv format)
  -cm,   --corMethod          the statistical approach for correlation measures (options: [pr, kt, bc] for pearsonr, kendalltau and bayesian correlation respectively. Default: pr) 
  -cpu,  --threads            the number of processors to use for trimming, qc, and alignment (Default: 1)
```


## Metadata
- **Skill**: generated
