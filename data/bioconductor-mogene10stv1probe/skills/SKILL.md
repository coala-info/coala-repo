---
name: bioconductor-mogene10stv1probe
description: This package provides probe sequence data and spatial coordinates for the Affymetrix Mouse Gene 1.0 ST v1 microarray. Use when user asks to access probe sequences, perform sequence-specific background correction, or map probe coordinates for the mogene10stv1 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene10stv1probe.html
---


# bioconductor-mogene10stv1probe

name: bioconductor-mogene10stv1probe
description: Provides probe sequence data for the Affymetrix Mouse Gene 1.0 ST v1 microarrays. Use this skill when you need to access, analyze, or map specific probe sequences, coordinates (x, y), or interrogation positions for the mogene10stv1 platform in R.

# bioconductor-mogene10stv1probe

## Overview

The `mogene10stv1probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix Mouse Gene 1.0 ST v1 array. This package is essential for low-level analysis of microarray data where probe-level sequences or spatial coordinates on the chip are required, such as calculating GC content, performing sequence-specific background correction, or re-mapping probes to updated genome assemblies.

## Loading and Accessing Data

To use the probe data, you must first load the library and then the dataset.

```R
# Load the package
library(mogene10stv1probe)

# Load the probe data object
data(mogene10stv1probe)

# View the structure of the data
str(mogene10stv1probe)
```

## Data Structure

The `mogene10stv1probe` object is a data frame with 906,259 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence being interrogated (integer).
- `Target.Strandedness`: The orientation of the target (factor).

## Common Workflows

### Subsetting and Inspection
You can treat the object as a standard R data frame for filtering or inspection.

```R
# View the first few rows
head(mogene10stv1probe)

# Extract probes for a specific Probe Set
ps_probes <- subset(mogene10stv1probe, Probe.Set.Name == "some_probe_set_id")

# Convert a slice to a data frame for easier viewing
as.data.frame(mogene10stv1probe[1:10, ])
```

### Sequence Analysis
If you need to perform sequence-based calculations (e.g., GC content), you can use the `sequence` column.

```R
# Example: Calculate GC content for the first 100 probes
probes_100 <- mogene10stv1probe$sequence[1:100]
gc_content <- sapply(probes_100, function(seq) {
  sum(gregexpr("[GC]", seq)[[1]] > 0) / nchar(seq)
})
```

## Usage Tips
- **Memory Management**: This dataset is large (over 900,000 rows). If you are only interested in specific probe sets, subset the data frame early to save memory.
- **Coordinate Mapping**: The `x` and `y` coordinates are useful for identifying spatial artifacts on the microarray chips during quality control.
- **Integration**: This package is often used in conjunction with `mogene10stv1cdf` (the Chip Definition File) or `mogene10stv1.db` (the annotation database).

## Reference documentation

- [mogene10stv1probe Reference Manual](./references/reference_manual.md)