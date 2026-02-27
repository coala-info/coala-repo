---
name: bioconductor-xenopuslaevisprobe
description: "This package provides probe sequence data and spatial coordinates for the Affymetrix Xenopus laevis microarray. Use when user asks to retrieve probe sequences, map probe identifiers to physical coordinates, or perform sequence-specific analysis for African clawed frog microarray data."
homepage: https://bioconductor.org/packages/release/data/annotation/html/xenopuslaevisprobe.html
---


# bioconductor-xenopuslaevisprobe

name: bioconductor-xenopuslaevisprobe
description: Provides probe sequence data for the Affymetrix Xenopus laevis (African clawed frog) microarray. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, coordinates (x, y), or interrogation positions for genomic analysis in R.

# bioconductor-xenopuslaevisprobe

## Overview
The `xenopuslaevisprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Xenopus laevis microarray. This package is essential for low-level analysis of microarray data, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and then loaded into the R session.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("xenopuslaevisprobe")
library(xenopuslaevisprobe)
```

## Usage and Workflows

### Loading the Probe Data
The primary data object is a data frame named `xenopuslaevisprobe`. It is loaded using the `data()` function.

```r
# Load the probe data frame
data(xenopuslaevisprobe)

# View the structure of the object
str(xenopuslaevisprobe)
```

### Data Structure
The `xenopuslaevisprobe` object is a data frame with the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix ID for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation nucleotide (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**1. Previewing the data:**
```r
# View the first few rows
head(xenopuslaevisprobe)

# Access specific rows as a data frame
as.data.frame(xenopuslaevisprobe[1:5, ])
```

**2. Filtering by Probe Set:**
If you have a specific Affymetrix ID and want to retrieve all associated probe sequences:
```r
# Example: Filter for a specific probe set
target_probes <- subset(xenopuslaevisprobe, Probe.Set.Name == "Xl.1.1.S1_at")
```

**3. Calculating Sequence Statistics:**
You can use this data to calculate properties like GC content for specific probes:
```r
# Simple GC content calculation example
probes <- xenopuslaevisprobe$sequence[1:10]
gc_content <- sapply(probes, function(x) {
  tmp <- strsplit(x, "")[[1]]
  sum(tmp %in% c("G", "C")) / length(tmp)
})
```

## Tips
- **Memory Management**: This data frame is large (over 240,000 rows). If you only need specific columns or a subset of probes, filter the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chips when combined with raw intensity data (CEL files).
- **Annotation Consistency**: Ensure that the version of this probe package matches the version of the CDF (Chip Definition File) or platform design you are using for your analysis.

## Reference documentation
- [xenopuslaevisprobe Reference Manual](./references/reference_manual.md)