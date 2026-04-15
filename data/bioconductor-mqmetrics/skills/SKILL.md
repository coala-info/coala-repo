---
name: bioconductor-mqmetrics
description: MQmetrics performs quality control and visualization of proteomics data processed with MaxQuant. Use when user asks to generate QC reports, visualize protein identification rates, assess instrument performance, or analyze quantitative metrics from MaxQuant output.
homepage: https://bioconductor.org/packages/3.13/bioc/html/MQmetrics.html
---

# bioconductor-mqmetrics

## Overview

MQmetrics (MaxQuant metrics) is a Bioconductor package designed for the quality control (QC) of proteomics data processed via MaxQuant. It automates the extraction of metrics from MaxQuant output tables (the `combined/txt/` and `combined/proc/` folders) to assess run reproducibility, identification rates, and instrument performance.

## Workflow and Data Input

### Data Structure
MQmetrics requires the path to the MaxQuant **combined** folder. This folder must contain:
- `txt/`: Containing standard MaxQuant output tables (e.g., `proteinGroups.txt`, `summary.txt`, `evidence.txt`).
- `proc/`: Containing the `#runningTimes.txt` file.

### Initialization
To begin analysis, load the library and point to your data:

```r
library(MQmetrics)

# Path to the 'combined' folder
MQPathCombined <- "path/to/your/MaxQuant/combined/"

# Load and clean the data (removes contaminants and reverse hits by default)
MQCombined <- make_MQCombined(MQPathCombined, remove_contaminants = TRUE)
```

## Automated Reporting

The fastest way to perform QC is to generate a comprehensive PDF report:

```r
generateReport(
  MQPathCombined = MQPathCombined,
  output_dir = "path/to/output",
  intensity_type = "LFQ", # Or "Intensity"
  long_names = TRUE,      # Set to TRUE if sample names are long
  sep_names = "_"         # Separator used in sample names
)
```

## Individual Visualizations

If you need specific plots rather than a full report, use the following functions with the `MQCombined` object:

### Identification Metrics
- **Proteins/Peptides**: `PlotProteinsIdentified(MQCombined)` and `PlotPeptidesIdentified(MQCombined)`.
- **Efficiency**: `PlotProteinPeptideRatio(MQCombined)` shows the ratio of peptides found per protein.
- **Overlap**: `PlotProteinOverlap(MQCombined)` visualizes how many proteins are shared across samples.

### Instrument Performance
- **MS/MS Scans**: `PlotMsMs(MQCombined)` shows submitted vs. identified MS/MS.
- **TIC**: `PlotTotalIonCurrent(MQCombined)` plots Total Ion Current vs. Retention Time.
- **Cycle Time**: `PlotAcquisitionCycle(MQCombined)` displays cycle time and MS/MS counts.
- **Charge States**: `PlotCharge(MQCombined)` shows the distribution of precursor ion charges.

### Quantitative Metrics
- **Intensity Distributions**: `PlotIntensity(MQCombined, split_violin_intensity = TRUE)` compares LFQ and raw intensities.
- **PCA**: `PlotPCA(MQCombined, intensity_type = "LFQ")` for sample clustering.
- **Dynamic Range**: `PlotCombinedDynamicRange(MQCombined)` or `PlotAllDynamicRange(MQCombined)`.

### Specialized Analysis
- **iRT Peptides**: If Biognosys iRT peptides were spiked in, use `PlotiRT(MQCombined)` and `PlotiRTScore(MQCombined)` to check retention time stability.
- **PTMs**: `PlotPTM(MQCombined)` visualizes modifications found at the peptide level.
- **Protein Coverage**: `PlotProteinCoverage(MQCombined, UniprotID = "P12345")` shows sequence coverage for a specific protein.

## Helper Functions

- **MaxQuantAnalysisInfo(MQCombined)**: Prints a summary of the MaxQuant run parameters (version, machine, FDR settings, fasta files).
- **ReportTables(MQCombined)**: Returns a list of data frames containing the raw values used for the plots (useful for custom downstream analysis).

## Reference documentation

- [MQmetrics](./references/MQmetrics.md)