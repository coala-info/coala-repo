# absense CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| Run_abSENSE.py | PASS |  |

## Metadata
- **Skill**: generated

## Run_abSENSE.py

### Tool Description
abSENSE arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/caraweisman/abSENSE
- **Package**: https://anaconda.org/channels/bioconda/packages/absense/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Run_abSENSE.py [-h] --distfile DISTFILE --scorefile SCOREFILE
                      [--Eval EVAL] [--includeonly INCLUDEONLY]
                      [--genelenfile GENELENFILE] [--dblenfile DBLENFILE]
                      [--predall PREDALL] [--out OUT]

abSENSE arguments:

optional arguments:
  -h, --help            show this help message and exit
  --distfile DISTFILE   Required. Name of file containing pairwise
                        evolutionary distances between focal species and each
                        of the other species
  --scorefile SCOREFILE
                        Required. Name of file containing bitscores between
                        focal species gene and orthologs in other species
  --Eval EVAL           Optional. E-value threshold. Scientific notation (e.g.
                        10E-5) accepted. Default 0.001.
  --includeonly INCLUDEONLY
                        Optional. Species whose orthologs' bitscores will be
                        included in fit; all others will be omitted. Default
                        is all species. Format as species names, exactly as in
                        input files, separated by commas (no spaces).
  --genelenfile GENELENFILE
                        Optional. File containing lengths (aa) of all genes to
                        be analyzed. Used to accurately calculate E-value
                        threshold. Default is 400aa for all genes. Only large
                        deviations will qualitatively affect results.
  --dblenfile DBLENFILE
                        Optional. File containing size (aa) of databases on
                        which the anticipated homology searches will be
                        performed. Species-specific. Used to accurately
                        calculate E-value threshold. Default is 400aa/gene *
                        20,000 genes for each species, intended to be the size
                        of an average proteome. Only large deviations will
                        significantly affect results.
  --predall PREDALL     Optional. True: Predicts bitscores and P(detectable)
                        of homologs in all species, including those in which
                        homologs were actually detected. Default is False:
                        only make predictions for homologs that seem to be
                        absent.
  --out OUT             Optional. Name of directory for output data. Default
                        is date and time when analysis was run.
```
