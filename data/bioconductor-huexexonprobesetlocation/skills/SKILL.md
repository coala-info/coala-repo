---
name: bioconductor-huexexonprobesetlocation
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HuExExonProbesetLocation.html
---

# bioconductor-huexexonprobesetlocation

name: bioconductor-huexexonprobesetlocation
description: Provides probe sequence and location data for Affymetrix Human Exon (HuEx) microarrays. Use this skill when needing to map HuEx probeset names to genomic coordinates, sequences, or array (x,y) positions for annotation and spatial analysis of exon-level expression data.

# bioconductor-huexexonprobesetlocation

## Overview

The `HuExExonProbesetLocation` package is a Bioconductor annotation data package. It contains a large data frame (over 1.4 million rows) providing the physical and genomic mapping for probes on the HuEx (Human Exon) microarray platform. This is essential for researchers performing exon-level analysis who need to link probe-level signals to specific sequences or coordinates.

## Usage

### Loading the Data

The package primarily provides a single data object. Load it using the standard R `data()` function:

```r
library(HuExExonProbesetLocation)
data(HuExExonProbesetLocation)
```

### Data Structure

The object `HuExExonProbesetLocation` is a data frame with the following columns:

- **sequence**: The actual nucleotide probe sequence (character).
- **x**: The x-coordinate of the probe on the microarray chip (integer).
- **y**: The y-coordinate of the probe on the microarray chip (integer).
- **Probe.Set.Name**: The Affymetrix identifier for the probeset (character).
- **Probe.Interrogation.Position**: The position within the target sequence being interrogated (integer).
- **Target.Strandedness**: The orientation of the target (factor).

### Common Workflows

#### Inspecting the Data
To view the first few entries of the mapping:
```r
head(HuExExonProbesetLocation)
```

#### Filtering by Probeset
To find all probes associated with a specific Exon Probeset ID:
```r
# Replace '1234567' with a valid HuEx Probeset Name
probeset_data <- HuExExonProbesetLocation[HuExExonProbesetLocation$Probe.Set.Name == "1234567", ]
```

#### Converting to Data Frame
While it behaves like a data frame, you can explicitly cast subsets for use in tidyverse or other workflows:
```r
df_subset <- as.data.frame(HuExExonProbesetLocation[1:10, ])
```

## Tips
- **Memory Management**: This dataset is large (1,432,143 rows). If you are only interested in specific probesets, filter the object early to save memory.
- **Annotation Source**: This data was generated via `AnnotationForge` using Netaffx data via `AffyCompatible`. It is specifically designed for exon-level (not just gene-level) resolution.

## Reference documentation

- [HuExExonProbesetLocation Reference Manual](./references/reference_manual.md)