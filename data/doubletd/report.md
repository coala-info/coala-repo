# doubletd CWL Generation Report

## doubletd

### Tool Description
Estimates the doublet rate from single-cell sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/doubletd:0.1.0--py_0
- **Homepage**: https://github.com/elkebir-group/doubletD
- **Package**: https://anaconda.org/channels/bioconda/packages/doubletd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/doubletd/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elkebir-group/doubletD
- **Stars**: N/A
### Original Help Text
```text
usage: doubletd [-h] [--inputTotal INPUTTOTAL]
                [--inputAlternate INPUTALTERNATE] [--delta DELTA]
                [--beta BETA] [--mu_hetero MU_HETERO] [--mu_hom MU_HOM]
                [--alpha_fp ALPHA_FP] [--alpha_fn ALPHA_FN] [-o OUTPUTFILE]
                [--noverbose] [--binomial] [--prec PREC] [--missing]

optional arguments:
  -h, --help            show this help message and exit
  --inputTotal INPUTTOTAL
                        csv file with a table of total read counts for each
                        position in each cell
  --inputAlternate INPUTALTERNATE
                        csv file with a table of alternate read counts for
                        each position in each cell
  --delta DELTA         expected doublet rate [0.1]
  --beta BETA           allelic dropout (ADO) rate [0.05]
  --mu_hetero MU_HETERO
                        heterozygous mutation rate [None]
  --mu_hom MU_HOM       homozygous mutation rate [None]
  --alpha_fp ALPHA_FP   copy false positive error rate [None]
  --alpha_fn ALPHA_FN   copy false negative error rate [None]
  -o OUTPUTFILE, --outputfile OUTPUTFILE
                        output file name
  --noverbose           do not output statements from internal solvers
                        [default is false]
  --binomial            use binomial distribution for read count model
                        [default is false]
  --prec PREC           precision for beta-binomial distribution [None]
  --missing             use missing data in the model? [No]
```

