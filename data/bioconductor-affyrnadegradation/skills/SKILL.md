---
name: bioconductor-affyrnadegradation
description: This tool assesses and corrects RNA degradation effects in Affymetrix 3' expression arrays by calculating integrity parameters and adjusting probe intensities. Use when user asks to calculate the RNA integrity parameter d, visualize probe positional bias via tongs or degradation plots, or generate corrected AffyBatch objects for microarray analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/AffyRNADegradation.html
---

# bioconductor-affyrnadegradation

name: bioconductor-affyrnadegradation
description: Assessment and correction of RNA degradation effects in Affymetrix 3' expression arrays. Use this skill to calculate the RNA integrity parameter 'd', visualize probe positional bias via tongs plots and degradation plots, and generate corrected AffyBatch objects to improve sample comparability in microarray analysis.

## Overview

The `AffyRNADegradation` package addresses the probe positional bias caused by RNA degradation in Affymetrix 3' GeneChip microarrays. It provides a robust measure of RNA integrity (the $d$ parameter) and a method to correct probe intensities based on their distance from the 3' end of the target transcript. This correction is essential when comparing samples with varying degrees of degradation.

## Core Workflow

### 1. Data Preparation
The package operates on `AffyBatch` objects.

```r
library(AffyRNADegradation)
# Load your AffyBatch object (e.g., from affy::ReadAffy())
# data(AmpData) # Example data
```

### 2. Visualizing Bias (Tongs Plot)
Before correction, visualize the relationship between expression level and the 3'/5' bias.

```r
# chip.idx specifies the sample index in the AffyBatch
tongs <- GetTongs(AmpData, chip.idx = 1)
PlotTongs(tongs)
```

### 3. Performing RNA Degradation Analysis
The `RNADegradation` function is the primary interface. It returns an `AffyDegradationBatch` object.

```r
# Using probe index (default)
rna.deg <- RNADegradation(AmpData, location.type = "index")

# Using absolute nucleotide distances (requires pre-computed location files)
# rna.deg <- RNADegradation(AmpData, location.type = "absolute", location.file.dir = "path/to/files")
```

### 4. Assessing Integrity and Plotting
Extract the degradation parameter $d$ and plot the decay functions.

```r
# Get the d-parameter for all samples (higher values usually indicate more degradation)
degradation_estimates <- d(rna.deg)

# Plot the average probe intensity relative to position x=1
plotDx(rna.deg)
```

### 5. Correcting Data for Downstream Analysis
Extract the corrected `AffyBatch` object to proceed with standard normalization (like RMA).

```r
# Get corrected AffyBatch
corrected_batch <- afbatch(rna.deg)

# Example: Integrate with VSN and median polish summarization
library(vsn)
normalized_data <- do.call(affy:::normalize, c(alist(AmpData, "vsn"), NULL))
corrected_vsn <- afbatch(RNADegradation(normalized_data))
expression_set <- computeExprSet(corrected_vsn, summary.method="medianpolish", pmcorrect.method="pmonly")
```

## Advanced Usage: Custom Probe Locations
If using custom arrays or alternative annotations, you can provide a custom `.Rd` file.
1. Create a data frame `probeDists` with columns: `Probe.Set.Name`, `Probe.X`, `Probe.Y`, `Probe.Distance`, and `Target.Length`.
2. Save it as `[chipName].Rd` where `chipName` matches `affy::cdfName(yourAffyBatch)`.
3. Run `RNADegradation` with `location.type = "absolute"` and point `location.file.dir` to the folder containing your `.Rd` file.

## Tips
- The $d$ parameter is a robust measure of RNA quality derived from the probe signals themselves, often more reflective of transcript-level integrity than generic RIN scores.
- Correction can be performed on raw data or after probe-level normalization (like VSN) but before summarization.
- Use `location.type = "index"` if you do not have specific probe distance files; it uses the relative position of the probe within the probeset (1 to 11-16).

## Reference documentation
- [The AffyRNADegradation Package](./references/vignette.md)