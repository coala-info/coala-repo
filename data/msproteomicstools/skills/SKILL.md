---
name: msproteomicstools
description: msproteomicstools is a suite of Python utilities designed for high-throughput proteomics data alignment, conversion, and visualization. Use when user asks to align peptide peak groups across mass spectrometry datasets, convert spectral libraries to TSV format, or visualize chromatograms.
homepage: https://github.com/msproteomicstools/msproteomicstools
metadata:
  docker_image: "quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0"
---

# msproteomicstools

## Overview
The `msproteomicstools` package is a specialized suite of Python-based utilities designed for high-throughput proteomics. Its primary strength lies in the TRIC (Targeted Retention time Invariant Chromatogram) alignment algorithm, which allows for the consistent identification and alignment of peptide peak groups across large-scale mass spectrometry datasets. This skill enables the efficient execution of alignment workflows, data format conversions (such as Spectrast to TSV), and the preparation of data matrices for quantitative proteomics.

## Core Workflows and CLI Patterns

### TRIC Alignment
The TRIC alignment tool is the most common entry point for users of this package. It aligns peak groups across multiple LC-MS/MS runs to reduce missing values and improve quantification consistency.

**Basic TRIC Command Pattern:**
```bash
feature_alignment.py --in input_file.tsv --out aligned_output.tsv --method MST --realign_method lowess --max_rt_diff 30 --target_fdr 0.01
```

**Expert Tips for TRIC:**
*   **Alignment Method:** Use `--method MST` (Minimum Spanning Tree) for complex datasets where a single reference run is not representative of the entire batch.
*   **RT Correction:** For high-performance alignment, ensure `statsmodels` is installed to enable fast lowess RT correction.
*   **FDR Control:** Always specify a `--target_fdr` to ensure that the alignment process maintains the desired statistical confidence across the aligned features.
*   **MST Traversal:** In newer versions, threading is the default for MST traversal. Use `--mst:useRTCorrection` to ensure retention time shifts are accounted for during the tree-based alignment.

### Data Conversion and Preprocessing
Before alignment or visualization, data often needs to be converted into a compatible format.

*   **Spectrast to TSV:** Use the `spectrast2tsv.py` utility to convert spectral libraries into a format suitable for OpenSWATH or other targeted analysis tools.
    ```bash
    spectrast2tsv.py -i library.splib -o library.tsv
    ```
*   **Peakview Preprocessing:** If working with Peakview files, use the provided preprocessor scripts in the `analysis` directory to clean and format the data before attempting alignment.

### Visualization with TAPIR
TAPIR is the graphical component used for inspecting chromatograms. While it is a GUI tool, it is often triggered to validate the results of a CLI-based alignment.

*   **Input Requirements:** TAPIR requires `.mzML` or `.chrom.mzML` files along with the corresponding feature files (TSV/CSV).
*   **Metabolomics Support:** TAPIR can be used for metabolomics data by adjusting the settings to handle non-peptidic features.

## Installation and Environment Best Practices
To ensure the tools run with optimal performance:
1.  **Fast Lowess:** Manually install the fast lowess implementation if processing large batches, as the standard `statsmodels` implementation can be a bottleneck for thousands of runs.
2.  **Dependencies:** Ensure `pymzML` (specifically version 0.7.8 for legacy compatibility), `Biopython`, and `numpy` are present in the environment.
3.  **Python Version:** While the tool has been ported to Python 3, some legacy scripts in the `analysis` folder may still prefer a Python 2.7 environment; check the specific script header if errors occur.



## Subcommands

| Command | Description |
|---------|-------------|
| msproteomicstools_fix_swath_windows.py | Fixes SWATH windows based on a parameter file. |
| msproteomicstools_tsv2spectrast.py | Converts TSV files to Spectrast format. |

## Reference documentation
- [msproteomicstools GitHub Overview](./references/github_com_msproteomicstools_msproteomicstools.md)
- [TRIC Alignment Manual](./references/github_com_msproteomicstools_msproteomicstools_blob_master_TRIC-README.md)
- [TAPIR Installation and Usage](./references/github_com_msproteomicstools_msproteomicstools_blob_master_INSTALL-TAPIR.md)
- [Project Changelog and Version History](./references/github_com_msproteomicstools_msproteomicstools_blob_master_CHANGELOG.md)