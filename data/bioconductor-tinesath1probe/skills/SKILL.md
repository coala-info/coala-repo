---
name: bioconductor-tinesath1probe
description: This package provides probe sequence data for the Affymetrix tinesath1 microarray platform. Use when user asks to perform sequence-level analysis, calculate GC content, or map probe sequences to physical locations for Arabidopsis thaliana microarray experiments.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tinesath1probe.html
---

# bioconductor-tinesath1probe

name: bioconductor-tinesath1probe
description: Provides probe sequence data for the Affymetrix tinesath1 microarray platform. Use when performing sequence-level analysis, probe alignment, or GC-content calculations for Arabidopsis thaliana microarray experiments using the tinesath1 chip.

## Overview

The `tinesath1probe` package is a Bioconductor data package containing the sequence information for probes on the Affymetrix tinesath1 microarray. This data is essential for researchers performing probe-level analysis, such as background correction based on sequence composition or re-mapping probes to updated genome assemblies.

The package provides a single data frame object named `tinesath1probe`.

## Usage

### Loading the Data

To use the probe data, load the library and then call the `data()` function:

```r
library(tinesath1probe)
data(tinesath1probe)
```

### Data Structure

The `tinesath1probe` object is a data frame with 221,802 rows and 6 columns. Each row represents a single probe on the array.

The columns include:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position of the interrogation base (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Workflows

#### Inspecting Probe Data
To view the first few entries of the probe sequences:
```r
head(tinesath1probe)
```

#### Filtering by Probe Set
To extract all probes associated with a specific gene or probe set:
```r
target_probes <- tinesath1probe[tinesath1probe$Probe.Set.Name == "244901_at", ]
```

#### Sequence Analysis
You can use this data to calculate GC content for specific probes, which is often used in normalization algorithms:
```r
# Example: Calculate GC count for the first 10 probes
library(Biostrings)
seqs <- DNAStringSet(tinesath1probe$sequence[1:10])
letterFrequency(seqs, letters = "GC")
```

## Tips
- This package is specifically for the `tinesath1` array type. Ensure your CEL files or ExpressionSet objects match this platform before using this sequence data.
- The coordinates (x, y) can be used to map probe sequences back to the physical locations on the microarray chip, which is useful for identifying spatial artifacts.

## Reference documentation

- [tinesath1probe Reference Manual](./references/reference_manual.md)