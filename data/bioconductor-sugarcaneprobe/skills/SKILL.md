---
name: bioconductor-sugarcaneprobe
description: This package provides probe sequence data and array coordinates for the Affymetrix sugarcane genome microarray. Use when user asks to retrieve probe sequences, access x/y coordinates on the array, or perform probe-level analysis for sugarcane microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/sugarcaneprobe.html
---

# bioconductor-sugarcaneprobe

name: bioconductor-sugarcaneprobe
description: Access and use the sugarcane probe sequence data for Affymetrix microarrays. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for sugarcane (Saccharum officinarum) microarray analysis in R.

# bioconductor-sugarcaneprobe

## Overview
The `sugarcaneprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix Sugarcane genome array. It provides a standardized data frame mapping probe identifiers to their physical sequences and array coordinates, which is essential for tasks such as custom background correction, probe-level analysis, or re-annotation of sugarcane microarray data.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the package and then use the `data()` function to load the specific object into your R environment.

```r
library(sugarcaneprobe)
data(sugarcaneprobe)
```

### Data Structure
The `sugarcaneprobe` object is a data frame containing 92,384 rows. Each row represents a single probe on the array. The columns include:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence being interrogated (integer).
- `Target.Strandedness`: Whether the target is sense or anti-sense (factor).

### Common Operations

**Viewing the first few probes:**
```r
head(sugarcaneprobe)
```

**Subsetting for a specific Probe Set:**
```r
# Replace 'Sbi.1.1.S1_at' with your probe set of interest
specific_probes <- subset(sugarcaneprobe, Probe.Set.Name == "Sbi.1.1.S1_at")
```

**Converting to a standard data frame:**
If you need to perform operations that require a standard data frame structure:
```r
df_probes <- as.data.frame(sugarcaneprobe[1:10, ])
```

## Tips
- **Memory Management**: This dataset is relatively large (92k+ rows). If you only need specific columns (e.g., just sequences and IDs), subset the data frame early to save memory.
- **Integration**: This package is typically used in conjunction with the `affy` or `oligo` packages for low-level microarray processing.
- **Source**: The data is derived from the original Affymetrix `Sugar_Cane_probe_tab` file.

## Reference documentation
- [sugarcaneprobe Reference Manual](./references/reference_manual.md)