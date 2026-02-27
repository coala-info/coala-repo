---
name: bioconductor-rattoxfxprobe
description: This package provides probe sequence data and physical coordinates for the Affymetrix Rat-ToxFX microarray. Use when user asks to access probe sequences, map probe coordinates, or perform probe-level analysis for rat toxicogenomics studies.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rattoxfxprobe.html
---


# bioconductor-rattoxfxprobe

name: bioconductor-rattoxfxprobe
description: Provides probe sequence data for the Affymetrix Rat-ToxFX microarray. Use this skill when you need to access, analyze, or map probe-level information (sequences, x/y coordinates, and probe set names) for rat toxicogenomics studies using the rattoxfx platform.

# bioconductor-rattoxfxprobe

## Overview
The `rattoxfxprobe` package is a Bioconductor annotation data package containing the probe sequences for the Affymetrix Rat-ToxFX microarray. This array is specifically designed for toxicogenomics applications in rat models. The package provides a data frame mapping each probe to its sequence, physical location on the array, and its corresponding probe set.

## Usage and Workflows

### Loading the Data
To use the probe data, you must first load the library and then call the `data()` function to load the specific object into your R environment.

```r
library(rattoxfxprobe)
data(rattoxfxprobe)
```

### Data Structure
The `rattoxfxprobe` object is a data frame containing 24,535 rows and 6 columns. You can inspect the structure using standard R commands:

```r
# View the first few rows
head(rattoxfxprobe)

# Check column names and types
str(rattoxfxprobe)
```

The columns include:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the probe relative to the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Filtering by Probe Set**
If you are interested in a specific gene or probe set, you can subset the data frame:

```r
# Extract all probes for a specific probe set
specific_probes <- rattoxfxprobe[rattoxfxprobe$Probe.Set.Name == "1367452_at", ]
```

**Sequence Analysis**
You can use the probe sequences for GC content analysis or to verify off-target binding using other Bioconductor tools like `Biostrings`:

```r
library(Biostrings)
# Convert to DNAStringSet for sequence analysis
probe_seqs <- DNAStringSet(rattoxfxprobe$sequence)
# Calculate GC content
gc_content <- letterFrequency(probe_seqs, letters="GC", as.prob=TRUE)
```

**Spatial Mapping**
The `x` and `y` coordinates can be used to visualize the physical distribution of probes on the chip, which is useful for identifying spatial artifacts or "smudges" on the array surface.

## Tips
- This package is a "data-only" package. It does not contain complex functions, but rather provides the raw data required by other packages like `affy` or `gcrma` for probe-level analysis.
- Ensure your Bioconductor version is compatible with the package version to avoid data structure mismatches.

## Reference documentation
- [rattoxfxprobe Reference Manual](./references/reference_manual.md)