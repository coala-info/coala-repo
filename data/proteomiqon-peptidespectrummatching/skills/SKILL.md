---
name: proteomiqon-peptidespectrummatching
description: This tool identifies peptide spectrum matches by comparing mass spectrometry scans against a pre-constructed peptide database to calculate similarity scores. Use when user asks to identify peptides from mass spectrometry runs, perform peptide spectrum matching, or process mzML files against a peptide database.
homepage: https://csbiology.github.io/ProteomIQon/
---


# proteomiqon-peptidespectrummatching

## Overview

The `proteomiqon-peptidespectrummatching` tool is the central identification engine of the ProteomIQon proteomics pipeline. It processes raw mass spectrometry runs by iterating through all recorded MS/MS scans to determine the charge state of precursor ions. It then queries a pre-constructed SQLite peptide database (generated via `PeptideDB`) to find candidate peptides within a specific mass tolerance. For every candidate, the tool generates a theoretical spectrum and calculates similarity scores to identify the most likely Peptide Spectrum Match (PSM).

## CLI Usage Patterns

### Basic Identification
To process a single mass spectrometry run against a peptide database:

```bash
proteomiqon -peptidespectrummatching -i "path/to/run.mzml" -d "path/to/database.sqlite" -o "path/to/outDirectory" -p "path/to/params.json"
```

### Parallel Processing
If working on a multi-core system, use the `-c` flag to process multiple files in parallel. This significantly reduces the time required for the computationally intensive scoring process:

```bash
proteomiqon -peptidespectrummatching -i "run1.mzml" "run2.mzml" "run3.mzml" -d "db.sqlite" -o "output/" -p "params.json" -c 3
```

## Expert Tips and Best Practices

*   **Database Requirement**: This tool cannot function without a database created by `PeptideDB`. Ensure your SQLite database contains the appropriate decoys for downstream FDR estimation.
*   **Input Formats**: While `.mzML` is supported, using the `.mzLite` format (converted via `MzMLToMzLite`) is recommended for better performance and compliance with FAIR principles within the ProteomIQon ecosystem.
*   **Parameter Tuning**:
    *   **LookUpPPM**: Adjust this based on your instrument's mass accuracy. A default of 30 PPM is common, but high-resolution instruments (like Orbitraps) may benefit from tighter tolerances (e.g., 10-20 PPM).
    *   **Charge State Determination**: If your data has many low-intensity precursors, ensure `MinIntensity` and `DeltaMinIntensity` in the parameters are tuned to avoid missing valid fragmentation events.
    *   **Ion Series**: By default, the tool considers `b` and `y` ions. If using specific fragmentation methods like ETD, ensure the parameters reflect the expected ion series (e.g., `c` and `z`).
*   **Memory Management**: When using high thread counts (`-c`), ensure the system has sufficient RAM to hold the search space for multiple concurrent scans.

## Reference documentation
- [Peptide Spectrum Matching](./references/csbiology_github_io_ProteomIQon_tools_PeptideSpectrumMatching.html.md)
- [PeptideDB](./references/csbiology_github_io_ProteomIQon_tools_PeptideDB.html.md)
- [ProteomIQon Overview](./references/csbiology_github_io_ProteomIQon.md)