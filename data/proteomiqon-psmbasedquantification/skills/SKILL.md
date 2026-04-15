---
name: proteomiqon-psmbasedquantification
description: This tool estimates peptide ion abundance by extracting ion chromatograms and fitting Gaussian models to detected peaks. Use when user asks to perform label-free quantification, quantify metabolic labeling, or calculate peptide peak areas from MS/MS data.
homepage: https://csbiology.github.io/ProteomIQon/
metadata:
  docker_image: "quay.io/biocontainers/proteomiqon-psmbasedquantification:0.0.9--hdfd78af_0"
---

# proteomiqon-psmbasedquantification

## Overview

The `proteomiqon-psmbasedquantification` tool is a specialized proteomics utility designed to estimate peptide ion abundance. It works by grouping identified MS/MS scans by their assigned peptide ion and using the scan times to build a reliable estimator for the peptide's retention time. By combining this with the monoisotopic m/z, the tool extracts an ion chromatogram (XIC), detects peaks using wavelet-based techniques, and fits Gaussian models to determine accurate peak areas.

This tool is essential for workflows requiring:
- **Label-free quantification (LFQ)**: Measuring peptide abundance across different samples without isotopic labels.
- **Full metabolic labeling**: Quantifying samples where one peptide ion's identity is known, and the tool calculates the m/z of its differentially labeled counterpart.

## CLI Usage

The basic syntax for executing the quantification tool requires the MS data, the scored PSMs, the peptide database, a directory for output, and a JSON parameter file.

### Basic Command
```bash
proteomiqon -psmbasedquantification \
  -i "path/to/run.mzlite" \
  -ii "path/to/run.qpsm" \
  -d "path/to/database.sqlite" \
  -o "path/to/outputDirectory" \
  -p "path/to/params.json"
```

### Parallel Processing
For large datasets, use the `-c` flag to specify the number of CPU cores to use for parallel processing of multiple runs:
```bash
proteomiqon -psmbasedquantification -i run1.mzlite run2.mzlite -ii run1.qpsm run2.qpsm -d db.sqlite -o ./out -p params.json -c 2
```

### File Matching
By default, input files (`-i`) and PSM files (`-ii`) are matched by their position in the provided lists. To match files based on their filenames instead, use the `-mf` flag:
```bash
proteomiqon -psmbasedquantification -i run1.mzlite run2.mzlite -ii run2.qpsm run1.qpsm -mf ...
```

## Parameter Configuration

The tool behavior is governed by a JSON file. Key sections include:

1.  **PerformLabeledQuantification**: Set to `true` for metabolic labeling (e.g., 14N/15N), `false` for standard label-free runs.
2.  **XicExtraction**:
    *   `ScanTimeWindow`: The time range (in minutes) around the estimated retention time to search for the peptide.
    *   `MzWindow_Da`: The mass tolerance for extracting the chromatogram.
3.  **BaseLineCorrection**: Optional parameters to handle noise and baseline drift in the XIC.

## Best Practices and Tips

- **Input Formats**: While mzML is supported, using the `mzLite` format (SQLite-based) is recommended for better performance in data-intensive scenarios.
- **FDR Control**: Ensure that the input PSMs (`.qpsm` files) have already passed FDR thresholds (typically via the `PSMStatistics` tool) to avoid quantifying false positives.
- **Peak Fitting**: The tool fits two Gaussian models to every detected peak and selects the better fit. This provides a quality metric for how well the signal matches the expected theoretical peak shape.
- **Database Consistency**: The SQLite database provided with `-d` must be the same one used during the initial Peptide Spectrum Matching (PSM) step to ensure peptide-to-protein mappings remain valid.

## Reference documentation
- [PSMBasedQuantification Tool Documentation](./references/csbiology_github_io_ProteomIQon_tools_PSMBasedQuantification.html.md)
- [ProteomIQon General Overview](./references/csbiology_github_io_ProteomIQon.md)