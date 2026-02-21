---
name: bioconductor-hgu95dprobe
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95dprobe.html
---

# bioconductor-hgu95dprobe

name: bioconductor-hgu95dprobe
description: Provides probe sequence data for the Affymetrix Human Genome U95D (hgu95d) microarray. Use this skill when you need to map Affymetrix probe set IDs to specific DNA sequences, genomic coordinates (x, y) on the chip, or interrogation positions for the HGU95D platform.

# bioconductor-hgu95dprobe

## Overview
The `hgu95dprobe` package is a Bioconductor annotation data package containing the sequence information for the probes used on the Affymetrix HGU95D microarray. Unlike standard annotation packages that map probes to genes, this package provides the physical properties of the probes themselves, including their sequences and coordinates on the array.

## Loading and Accessing Data
The package contains a single primary data object also named `hgu95dprobe`.

```r
# Load the package
library(hgu95dprobe)

# Load the probe data object
data(hgu95dprobe)

# View the structure of the data
str(hgu95dprobe)
```

## Data Structure
The `hgu95dprobe` object is a data frame with 201,858 rows and 6 columns:

- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the microarray chip (integer).
- `y`: The y-coordinate of the probe on the microarray chip (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence that this probe interrogates (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

## Common Workflows

### Extracting Sequences for a Specific Probe Set
To retrieve all probe sequences associated with a specific Affymetrix ID:

```r
# Example: Get sequences for a specific probe set
ps_name <- "100_g_at" # Replace with your ID of interest
subset_probes <- hgu95dprobe[hgu95dprobe$Probe.Set.Name == ps_name, ]
print(subset_probes$sequence)
```

### Converting to a Biostrings Object
For sequence analysis (e.g., GC content calculation or alignment), convert the character strings to `DNAStringSet`:

```r
library(Biostrings)
probe_sequences <- DNAStringSet(hgu95dprobe$sequence)
names(probe_sequences) <- hgu95dprobe$Probe.Set.Name
```

### Spatial Analysis
The `x` and `y` columns can be used to check for spatial artifacts on the microarray chip by plotting intensity values (from CEL files) against these coordinates.

## Usage Tips
- **Memory**: The data frame is relatively large. If you only need a subset of probe sets, filter the data frame immediately after loading.
- **Matching**: Use this package in conjunction with the `hgu95d.db` package if you need to map these sequences to Entrez Gene IDs or GO terms.
- **Coordinates**: The (x, y) coordinates are 0-indexed, following the standard Affymetrix convention.

## Reference documentation
- [hgu95dprobe Reference Manual](./references/reference_manual.md)