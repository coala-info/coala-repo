# orsum CWL Generation Report

## orsum_orsum.py

### Tool Description
orsum summarizes enrichment results

### Metadata
- **Docker Image**: quay.io/biocontainers/orsum:1.8.0--hdfd78af_0
- **Homepage**: https://github.com/ozanozisik/orsum/
- **Package**: https://anaconda.org/channels/bioconda/packages/orsum/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/orsum/overview
- **Total Downloads**: 12.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ozanozisik/orsum
- **Stars**: N/A
### Original Help Text
```text
usage: orsum.py [-h] [-v] --gmt GMT --files FILES [FILES ...]
                [--fileAliases FILEALIASES [FILEALIASES ...]]
                [--outputFolder OUTPUTFOLDER] [--maxRepSize MAXREPSIZE]
                [--maxTermSize MAXTERMSIZE] [--minTermSize MINTERMSIZE]
                [--numberOfTermsToPlot NUMBEROFTERMSTOPLOT]

orsum summarizes enrichment results

required arguments:
  --gmt GMT             Path of the GMT file.
  --files FILES [FILES ...]
                        Paths of the enrichment result files.

optional arguments:
  -h, --help            Show this help message and exit
  -v, --version         show program's version number and exit
  --fileAliases FILEALIASES [FILEALIASES ...]
                        Aliases for input enrichment result files to be used
                        in orsum results
  --outputFolder OUTPUTFOLDER
                        Path for the output result files. If it is not
                        specified, results are written to the current
                        directory.
  --maxRepSize MAXREPSIZE
                        The maximum size of a representative term. Terms
                        larger than this will not be discarded but also will
                        not be used to represent other terms. By default, it
                        is larger than any annotation term (1E6), which means
                        that it has no effect.
  --maxTermSize MAXTERMSIZE
                        The maximum size of the terms to be processed. Larger
                        terms will be discarded. By default, it is larger than
                        any annotation term (1E6), which means that it has no
                        effect.
  --minTermSize MINTERMSIZE
                        The minimum size of the terms to be processed. Smaller
                        terms will be discarded. By default, minTermSize = 10
  --numberOfTermsToPlot NUMBEROFTERMSTOPLOT
                        The number of representative terms to be presented in
                        barplot and heatmap. By default (and maximum),
                        numberOfTermsToPlot = 50
```

