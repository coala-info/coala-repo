---
name: bioconductor-heebodata
description: This package provides annotations, control metadata, and example data files for the Human Exon Evidence-Based Oligonucleotide microarray set. Use when user asks to access HEEBO probe sequences, identify mismatch or tiling controls, or load example Stanford GPR files for microarray analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HEEBOdata.html
---

# bioconductor-heebodata

name: bioconductor-heebodata
description: Access and utilize the HEEBO (Human Exon Evidence-Based Oligonucleotide) set annotations, control data, and example Stanford GPR files. Use this skill when working with HEEBO microarray data, requiring probe sequences, mismatch control information, tiling control distances, or example hybridization files for testing and pipeline development.

# bioconductor-heebodata

## Overview
The `HEEBOdata` package is an experiment data package providing the necessary annotation and control metadata for the HEEBO oligonucleotide set. It includes probe-level annotations, mismatch transcript details, tiling control information, and sample data from the Stanford Shared Genomics Core Facility. This package is primarily used as a reference for normalizing and interpreting HEEBO microarray experiments.

## Loading Data
To use the resources in this package, load the library and use the `data()` function to bring specific objects into the R environment.

```R
library(HEEBOdata)

# Load the main annotation set
data(HEEBO)

# Load example GPR and control files
data(StanfordExampleData)
```

## Key Data Objects

### HEEBO Annotations
The `HEEBO` data call loads several objects into the workspace:

*   **HEEBOset**: A character matrix containing annotations for all oligos (sequence ID, name, description). Note: These are original annotations and are not dynamically updated.
*   **HEEBOctrl**: A list of matrices describing mismatch transcripts and negative controls. It includes:
    *   Mismatch probe annotations (sequence ID, array identifier).
    *   Mismatch type (Anchored or Distributed).
    *   Number of mismatched bases and binding energy.
    *   A list of negative control identifiers.
*   **HEEBOtilingres**: A list of 11 vectors for tiling controls. Each vector contains HEEBO identifiers and the distance from the 3' end for probes recognizing specific sequences.

### Stanford Example Data
The `StanfordExampleData` call provides paths or references to raw data files used for demonstration:
*   **63421.gpr**: An example hybridization file.
*   **hoc.gal**: The Gene Pix Array list file associated with the HEEBO set.
*   **DCV2.0June06.txt**: An example spike-type (doping control) file from SFGF.

## Typical Workflow
1.  **Identify Controls**: Use `HEEBOctrl` to identify which probes on your array are negative controls or mismatch probes for normalization purposes.
2.  **Map Probes**: Use `HEEBOset` to map array identifiers to gene names or descriptions during downstream analysis.
3.  **Analyze Tiling**: Use `HEEBOtilingres` to analyze signal intensity as a function of the distance from the 3' end of the target sequence.
4.  **Testing**: Use the files in `StanfordExampleData` to test GPR parsing scripts or normalization algorithms (e.g., using the `marray` or `limma` packages).

## Reference documentation
- [HEEBOdata Reference Manual](./references/reference_manual.md)