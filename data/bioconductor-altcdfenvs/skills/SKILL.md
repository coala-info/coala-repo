---
name: bioconductor-altcdfenvs
description: This tool creates and manages alternative Chip Definition File (CDF) environments for re-mapping Affymetrix GeneChip probes to updated genomic information. Use when user asks to re-map probes to new gene targets using FASTA sequences, create subset CDFs for multi-genome chips, or build custom CdfEnvAffy objects for use with AffyBatch data.
homepage: https://bioconductor.org/packages/release/bioc/html/altcdfenvs.html
---

# bioconductor-altcdfenvs

name: bioconductor-altcdfenvs
description: Specialized workflows for creating and using alternative Chip Definition File (CDF) environments for Affymetrix GeneChip arrays. Use this skill when you need to re-map probes to genes based on updated sequence information, create subset CDFs for multi-genome chips (e.g., Plasmodium/Anopheles), or match FASTA sequences to AffyBatch probes using Biostrings.

# bioconductor-altcdfenvs

## Overview
The `altcdfenvs` package allows users to redefine the grouping of probes on Affymetrix GeneChip arrays. This is essential for mitigating the "Dorian Gray" effect, where static chip designs become outdated as genomic knowledge evolves. The package provides tools to read FASTA files, match probe sequences to new targets, and build custom `CdfEnvAffy` objects that can be integrated into standard `affy` workflows.

## Core Workflows

### 1. Creating a CdfEnvAffy from FASTA Sequences
This is the primary workflow for re-mapping probes to updated transcript information.

```r
library(altcdfenvs)
library(hgu133aprobe) # Replace with your specific probe package

# 1. Read FASTA entries
fasta.filename <- "path/to/sequences.fasta"
con <- file(fasta.filename, open="r")
# Use countskip.FASTA.entries and read.n.FASTA.entries.split for large files
n <- countskip.FASTA.entries(con)
close(con)
con <- file(fasta.filename, open="r")
my.entries <- read.n.FASTA.entries.split(con, n)
close(con)

# 2. Match probes to targets
targets <- my.entries$sequences
names(targets) <- my.entries$headers # Clean headers as needed
m <- matchAffyProbes(hgu133aprobe, targets, "HG-U133A")

# 3. Build the alternative CDF environment
# Note: You must provide the chip dimensions (nrow/ncol)
alt.cdf <- buildCdfEnv.biostrings(m, nrow.chip = 712, ncol.chip = 712)
```

### 2. Subsetting Existing CDFs (Multi-genome Chips)
Useful for chips containing probes for multiple organisms where you want to isolate one.

```r
library(plasmodiumanophelescdf)

# Wrap the existing environment
planocdf <- wrapCdfEnvAffy(plasmodiumanophelescdf, 712, 712, "plasmodiumanophelescdf")

# Identify probe sets for a specific organism (e.g., Plasmodium 'Pf')
ids <- geneNames(planocdf)
ids.pf <- ids[grep("^Pf", ids)]

# Create the subset
plcdf <- planocdf[ids.pf]
```

### 3. Applying the Alternative CDF to an AffyBatch
To use the new mapping for normalization (like RMA), you must assign it to your `AffyBatch` object.

```r
# Extract the environment from the CdfEnvAffy object
alt.cdfenv <- alt.cdf@envir # or as(plcdf, "environment")

# Assign to AffyBatch
# Note: The string assigned to cdfName must match the variable name in the global environment
my_alt_env <- alt.cdfenv
abatch@cdfName <- "my_alt_env"

# Verify and proceed with analysis
validAffyBatch(abatch, alt.cdf)
eset <- rma(abatch)
```

## Key Functions
- `read.FASTA.entry(con)`: Reads a single entry from a FASTA connection.
- `matchAffyProbes(probe_pkg, targets, chip_type)`: Matches probe sequences to target sequences.
- `buildCdfEnv.biostrings(match_obj, nrow, ncol)`: Creates the alternative CDF object.
- `wrapCdfEnvAffy(env, nrow, ncol, name)`: Converts a standard CDF environment into a `CdfEnvAffy` class object.
- `toHypergraph(match_obj)` / `toGraphNEL(hg)`: Visualizes probe-to-target relationships.

## Tips and Validation
- **Chip Dimensions**: If you don't know the `nrow` and `ncol` for a chip, call `print(abatch)` on an `AffyBatch` loaded with the default CDF; it will display the dimensions.
- **Validation**: Always use `validCdfEnvAffy(alt.cdf)` and `validAffyBatch(abatch, alt.cdf)` to ensure the new mapping is compatible with your data.
- **Parallelization**: For very large FASTA files, the matching process can be parallelized by splitting the FASTA file and distributing the `matchAffyProbes` task.

## Reference documentation
- [Alternative CDF environments](./references/altcdfenvs.md)
- [Modifying existing CDF environments](./references/modify.md)
- [Alternative CDF environments for 2-genomes chips](./references/ngenomeschips.md)