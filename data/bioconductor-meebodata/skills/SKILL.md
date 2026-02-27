---
name: bioconductor-meebodata
description: This package provides annotation and control data for the MEEBO microarray platform, including probe sequences, mismatch information, and tiling control distances. Use when user asks to access MEEBO probe annotations, identify microarray control probes, or retrieve example GenePix Results files for microarray analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MEEBOdata.html
---


# bioconductor-meebodata

name: bioconductor-meebodata
description: Access and use the MEEBO (Microarrays for the Evaluation of Expression in the Breast and Other tissues) annotation and control data. Use this skill when working with MEEBO microarray platforms, requiring probe annotations, mismatch control information, tiling control distances, or example GPR (GenePix Results) files for Stanford-style microarray analysis.

## Overview

The `MEEBOdata` package is an ExperimentData package providing R objects that describe the MEEBO oligonucleotide set. It includes probe annotations, descriptions of mismatch and negative controls, and tiling control information. It also provides example raw data files (GPR) and spike-in control files for testing and demonstration purposes.

## Data Objects

The package provides several key datasets that are loaded into the R environment using the `data()` function.

### MEEBO Annotations and Controls
Load the primary annotation objects:
```r
library(MEEBOdata)
data(MEEBO)
```
This loads three main objects:
- `MEEBOset`: A character matrix containing annotations for all oligos (sequence ID, name, description).
- `MEEBOctrl`: A list of matrices describing mismatch transcripts and negative controls. Includes sequence IDs, array identifiers, mismatch types (Anchored or Distributed), number of mismatched bases, and binding energy.
- `MEEBOtilingres`: A list of 11 vectors for tiling controls, containing unique identifiers and the distance from the 3' end for each control.

### Example Files
The package includes raw example files stored in the package installation directory. These are used to demonstrate microarray data processing workflows.

- `RDI108_n.gpr`: An example GenePix Results file.
- `StanfordDCV1.7complete.txt`: An example spike-type (doping control) file.

To locate these files on your system:
```r
# Get the path to the example GPR file
gpr_path <- system.file("doc", "RDI108_n.gpr", package="MEEBOdata")

# Get the path to the doping control file
spike_path <- system.file("doc", "StanfordDCV1.7complete.txt", package="MEEBOdata")
```

## Typical Workflows

### Annotating Probes
Use `MEEBOset` to map probe identifiers to gene descriptions or sequences:
```r
# View the first few rows of annotations
head(MEEBOset)

# Search for a specific probe by ID
probe_info <- MEEBOset[MEEBOset[, "ID"] == "YOUR_PROBE_ID", ]
```

### Analyzing Controls
Use `MEEBOctrl` to identify and categorize control probes during normalization or quality control:
```r
# Access negative controls
neg_controls <- MEEBOctrl$negative

# Access mismatch control details
mismatch_data <- MEEBOctrl$mismatch
```

### Using Tiling Data
Use `MEEBOtilingres` to analyze signal intensity relative to the distance from the 3' end:
```r
# View tiling controls for a specific sequence
tiling_seq1 <- MEEBOtilingres[[1]]
```

## Reference documentation

- [MEEBOdata Reference Manual](./references/reference_manual.md)