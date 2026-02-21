---
name: lirtmats
description: The `lirtmats` (Liverpool Retention Time Matching Software) skill enables the identification of metabolites by comparing experimental liquid chromatography-mass spectrometry (LC-MS) data against established retention time libraries.
homepage: https://pypi.org/project/lirtmats/
---

# lirtmats

## Overview
The `lirtmats` (Liverpool Retention Time Matching Software) skill enables the identification of metabolites by comparing experimental liquid chromatography-mass spectrometry (LC-MS) data against established retention time libraries. This tool is essential for metabolomics workflows where m/z and MS/MS data are supplemented by chromatographic behavior to increase identification confidence. It supports both a graphical interface for interactive use and a command-line interface for automated data processing pipelines.

## Installation
Install the package via pip or conda:
```bash
pip install lirtmats
# OR
conda install -c bioconda lirtmats
```

## Command Line Interface (CLI) Usage
The CLI is the primary method for batch processing. Use the `cli` positional argument followed by specific flags.

### Common Pattern
```bash
lirtmats cli \
  --input-data "./path/to/data.tsv" \
  --input-sep "tab" \
  --col-idx "1, 2, 3, 4" \
  --rt-path "./path/to/library.tsv" \
  --rt-sep "tab" \
  --rt-tol "5.0" \
  --ion-mode "pos" \
  --save-db \
  --summ-type "xlsx"
```

### Parameter Guidance
- `--input-data`: Path to your experimental LC-MS feature list (typically .tsv or .csv).
- `--input-sep`: Specify the delimiter (`tab`, `comma`, or `semicolon`).
- `--col-idx`: Comma-separated indices of the columns containing the required data (m/z, RT, etc.).
- `--rt-path`: Path to the method-specific RT library. Note: RT libraries are generally not transferable across different LC-MS assays.
- `--rt-tol`: The retention time tolerance (window) for matching, usually in seconds or minutes depending on your library units.
- `--ion-mode`: Set to `pos` or `neg` to match the ionization polarity of your study.
- `--summ-type`: Format for the output summary (e.g., `xlsx` or `csv`).

## Graphical User Interface (GUI)
For users who prefer a visual workflow or need to inspect matches manually:
```bash
lirtmats gui
```

## Best Practices
- **Library Specificity**: Only use RT libraries generated using the exact same LC method and column as your experimental data.
- **Data Preparation**: Ensure your input files use consistent delimiters. If using Excel files, it is often safer to export them to `.tsv` (tab-separated) to avoid encoding issues during CLI execution.
- **Tolerance Tuning**: Start with a wider `--rt-tol` if you observe systematic shifts, then tighten it once you have calibrated your system's stability.

## Reference documentation
- [LiRTMaTS PyPI Project Description](./references/pypi_org_project_lirtmats_1.0.0.md)
- [Bioconda lirtmats Overview](./references/anaconda_org_channels_bioconda_packages_lirtmats_overview.md)