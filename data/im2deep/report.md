# im2deep CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| im2deep | PASS |  |

## im2deep

### Tool Description
Predict collisional cross section (CCS) values for peptides using deep learning.

### Metadata
- **Docker Image**: quay.io/biocontainers/im2deep:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/compomics/im2deep
- **Package**: https://anaconda.org/channels/bioconda/packages/im2deep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/im2deep/overview
- **Total Downloads**: 54.7K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/compomics/im2deep
- **Stars**: N/A
### Original Help Text
```text
Usage: im2deep [OPTIONS] INPUT_FILE

  IM2Deep: Predict CCS values for peptides using deep learning.

  IM2Deep predicts Collisional Cross Section (CCS) values for peptides,
  including those with post-translational modifications. The tool supports
  both single-conformer and multi-conformer predictions with optional
  calibration using reference datasets.

  INPUT_FILE should be a CSV file with columns:  - seq: Peptide sequence
  (required) - modifications: Modifications in format "position|name"
  (required, can be empty) - charge: Charge state (required)

  For calibration files, an additional 'CCS' column with observed values is
  required.

  Examples:      # Basic prediction     im2deep peptides.csv

      # With calibration (recommended)     im2deep peptides.csv -c
      calibration.csv

      # Multi-conformer prediction     im2deep peptides.csv -c calibration.csv
      -e

      # Ion mobility output     im2deep peptides.csv -c calibration.csv -i

      # Ensemble prediction with custom output     im2deep peptides.csv -c
      calibration.csv -o results.csv --use-single-model False

Options:
  -c, --calibration-file FILE     Path to calibration file with known CCS
                                  values. Highly recommended for accurate
                                  predictions.
  -o, --output-file FILE          Output file path. If not specified, creates
                                  file next to input with '_IM2Deep-
                                  predictions.csv' suffix.
  -m, --model-name [tims]         Neural network model to use for prediction.
  -e, --multi                     Enable multi-conformer prediction. Requires
                                  optional dependencies: pip install
                                  'im2deep[er]'
  -l, --log-level [debug|info|warning|error|critical]
                                  Set logging verbosity level.
  -n, --n-jobs INTEGER RANGE      Number of parallel jobs for model inference.
                                  Default uses all available CPU cores.
                                  [x>=1]
  --calibrate-per-charge BOOLEAN  Apply calibration per charge state for
                                  improved accuracy. Disable for global
                                  calibration.
  --use-charge-state INTEGER RANGE
                                  Charge state for global calibration when
                                  --calibrate-per-charge is disabled.
                                  [1<=x<=6]
  --use-single-model BOOLEAN      Use single model (faster) vs ensemble of
                                  models (potentially slightly more accurate).
  -i, --ion-mobility              Output ion mobility (1/K0) instead of CCS
                                  values.
  --help                          Show this message and exit.
```

