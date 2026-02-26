---
name: bioconductor-hthgu133bprobe
description: This package provides probe sequence data and array coordinates for the Affymetrix HT_HG-U133B microarray platform. Use when user asks to retrieve probe sequences, identify probe coordinates, or perform sequence-level analysis for the hthgu133b chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133bprobe.html
---


# bioconductor-hthgu133bprobe

name: bioconductor-hthgu133bprobe
description: Access and use probe sequence data for the Affymetrix HT_HG-U133B microarray platform. Use this skill when you need to retrieve probe sequences, x/y coordinates, or interrogation positions for specific probe sets on the hthgu133b chip for genomic analysis or quality control.

# bioconductor-hthgu133bprobe

## Overview
The `hthgu133bprobe` package is a Bioconductor annotation data package containing the probe sequence information for the Affymetrix HT Human Genome U133B (HT_HG-U133B) array. This package is essential for workflows requiring sequence-level analysis, such as calculating GC content, identifying potential cross-hybridization, or re-mapping probes to updated genome assemblies.

## Usage and Workflows

### Loading the Data
The probe data is stored as a data frame. To access it, you must load the library and then use the `data()` function.

```r
library(hthgu133bprobe)
data(hthgu133bprobe)
```

### Data Structure
The `hthgu133bprobe` object is a data frame with 249,453 rows and 6 columns:
- `sequence`: The actual nucleotide sequence (character).
- `x`: The x-coordinate on the array (integer).
- `y`: The y-coordinate on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Operations

**Viewing a subset of probes:**
```r
# View the first few rows
head(hthgu133bprobe)

# View specific columns for the first 5 probes
as.data.frame(hthgu133bprobe[1:5, c("Probe.Set.Name", "sequence")])
```

**Filtering by Probe Set:**
To find all probes associated with a specific gene or Affymetrix ID:
```r
target_probes <- subset(hthgu133bprobe, Probe.Set.Name == "200000_s_at")
```

**Calculating Sequence Statistics:**
If you have the `Biostrings` package, you can perform sequence analysis:
```r
library(Biostrings)
# Calculate GC content for all probes
probes_dna <- DNAStringSet(hthgu133bprobe$sequence)
gc_content <- letterFrequency(probes_dna, letters="GC", as.prob=TRUE)
```

## Tips
- The object is a standard R `data.frame`. You can use `dplyr` or base R subsetting to manipulate it.
- This package provides *probe-level* information. For *gene-level* annotations (symbols, GO terms, etc.), use the corresponding annotation package `hthgu133b.db`.
- Ensure the package is installed via BiocManager: `BiocManager::install("hthgu133bprobe")`.

## Reference documentation
- [hthgu133bprobe Reference Manual](./references/reference_manual.md)