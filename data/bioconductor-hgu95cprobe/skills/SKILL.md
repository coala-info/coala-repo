---
name: bioconductor-hgu95cprobe
description: This package provides probe sequence data and location information for the Affymetrix HG-U95C microarray chip. Use when user asks to retrieve probe sequences, access x/y coordinates on the array, or perform sequence-specific analysis for the hgu95c platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95cprobe.html
---


# bioconductor-hgu95cprobe

name: bioconductor-hgu95cprobe
description: Access and use probe sequence data for the Affymetrix HG-U95C microarray chip. Use this skill when you need to retrieve probe-level information, including sequences, x/y coordinates, and interrogation positions for the hgu95c platform in R.

# bioconductor-hgu95cprobe

## Overview
The `hgu95cprobe` package is a Bioconductor annotation data package containing the probe sequences and location information for the Affymetrix HG-U95C microarray. This data is essential for low-level analysis, such as calculating GC content of probes, performing sequence-specific background correction, or re-mapping probes to updated genomic coordinates.

## Loading and Accessing Data
The package provides a single primary data object named `hgu95cprobe`.

```r
# Install the package if necessary
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu95cprobe")

# Load the library
library(hgu95cprobe)

# Load the probe data object
data(hgu95cprobe)

# View the structure
str(hgu95cprobe)
```

## Data Structure
The `hgu95cprobe` object is a data frame with the following columns:

- **sequence**: The actual nucleotide sequence of the probe (character).
- **x**: The x-coordinate of the probe on the array (integer).
- **y**: The y-coordinate of the probe on the array (integer).
- **Probe.Set.Name**: The Affymetrix ID for the gene/transcript cluster (character).
- **Probe.Interrogation.Position**: The nucleotide position within the target sequence (integer).
- **Target.Strandedness**: Whether the target is sense or antisense (factor).

## Common Workflows

### Subsetting Probes for a Specific Gene
To extract all probes associated with a specific Affymetrix Probe Set ID:

```r
# Example: Get probes for a specific ID
target_probes <- hgu95cprobe[hgu95cprobe$Probe.Set.Name == "1000_at", ]
print(target_probes)
```

### Analyzing Probe Sequences
You can use this data in conjunction with the `Biostrings` package to perform sequence analysis:

```r
library(Biostrings)

# Convert to DNAStringSet for analysis
dna_seqs <- DNAStringSet(hgu95cprobe$sequence)

# Calculate GC content for the first 10 probes
letterFrequency(dna_seqs[1:10], letters = "GC", as.prob = TRUE)
```

### Spatial Visualization
Since the data includes x and y coordinates, you can check for spatial biases on the chip:

```r
# Plot the layout of a subset of probes
plot(hgu95cprobe$x[1:1000], hgu95cprobe$y[1:1000], 
     main = "Probe Layout (First 1000 probes)",
     xlab = "X-coordinate", ylab = "Y-coordinate", pch = ".")
```

## Tips
- The object is large (over 200,000 rows). When inspecting it, always use `head()` or indexing (e.g., `hgu95cprobe[1:5, ]`) to avoid flooding the console.
- This package is specifically for the **C** version of the HG-U95 array series. Ensure your CEL files match this specific array type before using this annotation.

## Reference documentation
- [hgu95cprobe Reference Manual](./references/reference_manual.md)