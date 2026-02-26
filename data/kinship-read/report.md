# kinship-read CWL Generation Report

## kinship-read

### Tool Description
Calculate kinship coefficients from genotype data.

### Metadata
- **Docker Image**: quay.io/biocontainers/kinship-read:2.1.1--pyh7cba7a3_0
- **Homepage**: https://bitbucket.org/tguenther/read/src/master/
- **Package**: https://anaconda.org/channels/bioconda/packages/kinship-read/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kinship-read/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: kinship-read [options]

Options:
  -h, --help            show this help message and exit
  -i INFILE, --input=INFILE
                        Prefix of input Plink bed/bim/fam files
  -n NORM_METHOD, --norm_method=NORM_METHOD
                        Normalization method (either 'mean', 'median', 'max'
                        or 'value')
  --norm_value=NORM_VALUE
                        User-specified normalization value
  --window_size=WINDOW_SIZE
                        Window size (default 5000000)
  --window_est          Window based estimate of P0 (as opposed to the genome-
                        wide estimate, default in READv2)
  --2pow                Use alternative classification thresholds
  -v, --version         Print version
```

