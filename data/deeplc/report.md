# deeplc CWL Generation Report

## deeplc

### Tool Description
Retention time prediction for (modified) peptides using deep learning.

### Metadata
- **Docker Image**: quay.io/biocontainers/deeplc:3.1.13--pyhdfd78af_0
- **Homepage**: http://compomics.github.io/projects/DeepLC
- **Package**: https://anaconda.org/channels/bioconda/packages/deeplc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deeplc/overview
- **Total Downloads**: 105.4K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/compomics/DeepLC
- **Stars**: N/A
### Original Help Text
```text
usage: deeplc [OPTIONS] --file_pred <peptide_file>

Retention time prediction for (modified) peptides using deep learning.

Input and output files:
  --file_pred FILE_PRED  path to peptide CSV file for which to make
                         predictions (required)
  --file_cal             path to peptide CSV file with retention times to use
                         for calibration
  --file_pred_out        path to write output file with predictions

Model and calibration:
  --file_model  [ ...]   path to prediction model(s); leave empty to select
                         the best of the default models based on the
                         calibration peptides
  --transfer_learning    use transfer learning as calibration method
  --split_cal            number of splits in the chromatogram for piecewise
                         linear calibration fit
  --dict_divider         sets precision for fast-lookup of retention times for
                         calibration; e.g. 10 means a precision of 0.1 between
                         the calibration anchor points

Advanced configuration:
  --n_threads            number of CPU threads to use; default=all with max of
                         16
  --log_level            verbosity of logging messages; default=info
  -v, --version          show program's version number and exit
  -h, --help             show this help message and exit
```

