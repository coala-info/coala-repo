---
name: bioconductor-rnu34probe
description: This package provides probe sequence data and array coordinates for the Affymetrix RNU34 microarray platform. Use when user asks to map Affymetrix probe identifiers to sequences, retrieve x/y coordinates on the RNU34 chip, or access probe interrogation positions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rnu34probe.html
---


# bioconductor-rnu34probe

name: bioconductor-rnu34probe
description: Provides probe sequence data for the Affymetrix RNU34 microarray platform. Use this skill when you need to map Affymetrix probe identifiers to their physical sequences, x/y coordinates on the array, or interrogation positions for the rnu34 chip type.

# bioconductor-rnu34probe

## Overview

The `rnu34probe` package is a Bioconductor annotation data package containing the sequence information for the probes on the Affymetrix RNU34 microarray. This package is primarily used in genomic workflows where probe-level analysis is required, such as calculating GC content, performing sequence alignment, or developing custom normalization methods for RNU34 arrays.

## Usage

### Loading the Data

The package contains a single primary data object named `rnu34probe`. To use it, you must first load the library and then call the `data()` function.

```r
# Load the package
library(rnu34probe)

# Load the probe data object
data(rnu34probe)
```

### Data Structure

The `rnu34probe` object is a data frame. You can inspect its structure using standard R functions:

```r
# View the first few rows
head(rnu34probe)

# Check the column names and types
str(rnu34probe)
```

The data frame contains the following columns:
- `sequence`: The actual nucleotide sequence of the probe (character).
- `x`: The x-coordinate of the probe on the array (integer).
- `y`: The y-coordinate of the probe on the array (integer).
- `Probe.Set.Name`: The Affymetrix identifier for the probe set (character).
- `Probe.Interrogation.Position`: The position within the target sequence that the probe interrogates (integer).
- `Target.Strandedness`: Whether the target is sense or antisense (factor).

### Common Workflows

#### Filtering by Probe Set
To extract all probes associated with a specific Affymetrix Probe Set ID:

```r
# Example: Get probes for a specific set
specific_probes <- rnu34probe[rnu34probe$Probe.Set.Name == "some_probe_set_id", ]
```

#### Converting to a Data Frame
While the object is already a data frame, you may want to subset it for specific analysis:

```r
# Create a subset of the first 10 probes
probe_subset <- as.data.frame(rnu34probe[1:10, ])
```

## Tips
- This package is a static annotation dataset. It does not contain functions for normalization or differential expression; it provides the raw sequence mapping used by other packages like `affy` or `gcrma`.
- Ensure your Bioconductor version is compatible with the version of `rnu34probe` you are using to maintain consistency in probe mappings.

## Reference documentation

- [rnu34probe Reference Manual](./references/reference_manual.md)