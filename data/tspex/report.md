# tspex CWL Generation Report

## tspex

### Tool Description
Compute gene tissue-specificity from an expression matrix and save the output.

### Metadata
- **Docker Image**: quay.io/biocontainers/tspex:0.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/apcamargo/tspex
- **Package**: https://anaconda.org/channels/bioconda/packages/tspex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tspex/overview
- **Total Downloads**: 29.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/apcamargo/tspex
- **Stars**: N/A
### Original Help Text
```text
usage: tspex [-h] [--version] [-l] [-d] [-t THRESHOLD]
             input_file output_file method

Compute gene tissue-specificity from an expression matrix and save the output.

positional arguments:
  input_file            Expression matrix file in the TSV, CSV or Excel
                        formats.
  output_file           Output TSV file containing tissue-specificity values.
  method                Tissue-specificity metric. Allowed values are:
                        "counts", "tau", "gini", "simpson",
                        "shannon_specificity", "roku_specificity", "tsi",
                        "zscore", "spm", "spm_dpm", "js_specificity",
                        "js_specificity_dpm".

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -l, --log             Log-transform expression values. (default: False)
  -d, --disable_transformation
                        By default, tissue-specificity values are transformed
                        so that they range from 0 (perfectly ubiquitous) to 1
                        (perfectly tissue-specific). If this parameter is
                        used, transformation will be disabled and each metric
                        will have have a diferent range of possible values.
                        (default: False)
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold to be used with the "counts" metric. If
                        another method is chosen, this parameter will be
                        ignored. (default: 0)
```

