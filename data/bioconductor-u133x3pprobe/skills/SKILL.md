---
name: bioconductor-u133x3pprobe
description: This package provides sequence and coordinate data for probes on the Affymetrix u133x3p microarray platform. Use when user asks to retrieve probe sequences, find probe coordinates, or perform sequence-specific analysis for the u133x3p array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/u133x3pprobe.html
---


# bioconductor-u133x3pprobe

name: bioconductor-u133x3pprobe
description: Access and manipulate probe sequence data for the Affymetrix u133x3p microarray platform. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for specific probe sets on the u133x3p array for genomic analysis or quality control in R.

# bioconductor-u133x3pprobe

## Overview
The `u133x3pprobe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix u133x3p microarray. This package is essential for researchers performing sequence-specific analyses, such as re-mapping probes to updated genome assemblies or calculating GC content for normalization.

## Loading the Data
The package contains a single primary data object. To use it, you must load the library and then call the `data()` function.

```r
# Load the package
library(u133x3pprobe)

# Load the probe data object
data(u133x3pprobe)

# View the structure of the data
str(u133x3pprobe)
```

## Data Structure
The `u133x3pprobe` object is a data frame with 673,904 rows and 6 columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence that the probe interrogates (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Filtering by Probe Set
To extract all probes associated with a specific GeneChip probe set:

```r
# Example: Extract probes for a specific probe set
target_probes <- subset(u133x3pprobe, Probe.Set.Name == "200000_s_at")
head(target_probes)
```

### Sequence Analysis
You can use this data to calculate sequence properties, such as GC content, which is often used in background correction algorithms.

```r
# Calculate GC content for the first 10 probes
library(Biostrings)
probes_sample <- u133x3pprobe$sequence[1:10]
gc_content <- letterFrequency(DNAStringSet(probes_sample), "GC", as.prob = TRUE)
print(gc_content)
```

### Spatial Visualization
Since the package provides x and y coordinates, you can visualize the distribution of probes across the physical array.

```r
# Plot the first 1000 probe locations
plot(u133x3pprobe$x[1:1000], u133x3pprobe$y[1:1000], 
     pch = ".", main = "u133x3p Probe Locations")
```

## Tips
- The data frame is large (over 600,000 rows). When performing operations, prefer vectorized functions or `data.table`/`dplyr` for better performance.
- This package provides *probe-level* information. For *gene-level* annotations (symbols, Entrez IDs), use the corresponding annotation package `u133x3p.db`.

## Reference documentation
- [u133x3pprobe Reference Manual](./references/reference_manual.md)