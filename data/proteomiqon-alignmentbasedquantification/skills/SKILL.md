---
name: proteomiqon-alignmentbasedquantification
description: This tool quantifies peptides across multiple MS runs by transferring identities from reference runs to target runs using alignment data. Use when user asks to perform alignment-based quantification, address missing values in DDA data, or extract ion chromatograms for peptides without MS/MS identifications.
homepage: https://csbiology.github.io/ProteomIQon/
metadata:
  docker_image: "quay.io/biocontainers/proteomiqon-alignmentbasedquantification:0.0.2--hdfd78af_0"
---

# proteomiqon-alignmentbasedquantification

## Overview

The `proteomiqon-alignmentbasedquantification` tool is a specialized module within the ProteomIQon ecosystem designed to increase the number of quantified peptides across multiple MS runs. It addresses the "missing value" problem in Data-Dependent Acquisition (DDA) by transferring peptide identities from a reference run to a target run where a successful MS/MS scan might be absent. 

By using scan time estimates from previous alignment steps, the tool extracts Ion Chromatograms (XICs), refines them using local alignment (Dynamic Time Warping), and performs wavelet-based peak detection and Gaussian peak fitting. This results in high-confidence quantification even for peptides not directly identified by MS/MS in a specific run.

## Prerequisites

This tool is part of a multi-stage pipeline and requires specific inputs from preceding ProteomIQon tools:
1. **Peptide Database**: Created via `PeptideDB` (.sqlite).
2. **Quantified Peptides**: Results from `PSMBasedQuantification` (.quant).
3. **Alignment Data**: Deduced peptides and metrics from `QuantBasedAlignment` (.align and .alignmetric).

## Command Line Usage

### Basic Execution
To process a single run, provide the MS data, alignment files, existing quantification, and the peptide database:

```bash
proteomiqon-alignmentbasedquantification \
  -i "path/to/run.mzlite" \
  -ii "path/to/run.align" \
  -iii "path/to/run.alignmetric" \
  -iv "path/to/run.quant" \
  -d "path/to/database.sqlite" \
  -o "path/to/outDirectory" \
  -p "path/to/params.json"
```

### Parallel Processing
For multi-core systems, you can process multiple runs simultaneously by providing lists of files and using the `-c` flag:

```bash
proteomiqon-alignmentbasedquantification \
  -i "run1.mzlite" "run2.mzlite" \
  -ii "run1.align" "run2.align" \
  -iii "run1.alignmetric" "run2.alignmetric" \
  -iv "run1.quant" "run2.quant" \
  -d "database.sqlite" \
  -o "output_dir" \
  -p "params.json" \
  -c 4
```

### File Matching
By default, files are matched by their position in the input lists. Use the `-mf` flag to enable name-based matching, which is safer for large datasets:

```bash
proteomiqon-alignmentbasedquantification -i [MS_FILES] -ii [ALIGN_FILES] ... -mf
```

## Parameter Configuration

The tool requires a `.json` parameter file. Key parameters include:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `PerformLabeledQuantification` | `true` | Set to true for metabolic labeling (e.g., 14N/15N). |
| `PerformLocalWarp` | `true` | Enables Dynamic Time Warping for scan time refinement. |
| `XicExtraction` | - | Configures `ScanTimeWindow` (default 2.0) and `MzWindow_Da` (default 0.07). |
| `BaseLineCorrection` | - | Optional. Configures `MaxIterations`, `Lambda`, and `P`. |

### Example Parameter Structure (JSON)
```json
{
  "PerformLabeledQuantification": true,
  "PerformLocalWarp": true,
  "XicExtraction": {
    "ScanTimeWindow": 2.0,
    "MzWindow_Da": 0.07,
    "XicProcessing": {
      "Case": "Wavelet",
      "Fields": [{ "MinSNR": 0.01, "MaxPeakLength": 1.5 }]
    }
  },
  "BaseLineCorrection": {
    "MaxIterations": 10,
    "Lambda": 6,
    "P": 0.05
  }
}
```

## Expert Tips

- **Local Warping**: Always keep `PerformLocalWarp` enabled unless your chromatography is extremely stable and the initial alignment is perfect; it significantly improves peak picking accuracy.
- **Memory Management**: When using high core counts (`-c`), ensure the system has enough RAM to hold multiple XICs in memory simultaneously.
- **Downstream Integration**: After running this tool, use `AddDeducedPeptides` to update your protein inference results, as the quantification file now contains peptides not present in the original identification files.

## Reference documentation
- [Alignment Based Quantification](./references/csbiology_github_io_ProteomIQon_tools_AlignmentBasedQuantification.html.md)
- [Quantification Based Alignment](./references/csbiology_github_io_ProteomIQon_tools_QuantBasedAlignment.html.md)
- [Add Deduced Peptides](./references/csbiology_github_io_ProteomIQon_tools_AddDeducedPeptides.html.md)