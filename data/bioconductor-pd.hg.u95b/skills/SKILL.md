---
name: bioconductor-pd.hg.u95b
description: This package provides annotation and sequence data for the Affymetrix HG-U95B microarray platform. Use when user asks to process HG-U95B CEL files using the oligo package, retrieve probe sequences, or perform feature-level analysis on this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u95b.html
---

# bioconductor-pd.hg.u95b

name: bioconductor-pd.hg.u95b
description: Provides annotation and sequence data for the Affymetrix HG-U95B microarray platform. Use this skill when performing low-level analysis of HG-U95B arrays in R, specifically for retrieving probe sequences (PM, MM, or background) or when using the 'oligo' package to process .CEL files.

# bioconductor-pd.hg.u95b

## Overview

The pd.hg.u95b package is a Platform Design (PD) annotation package for the Affymetrix Human Genome U95B microarray. It was built using the pdInfoBuilder infrastructure and is designed to work seamlessly with the oligo package to provide feature-level information, such as probe sequences and positions.

## Installation and Loading

Install the package using BiocManager:

BiocManager::install("pd.hg.u95b")

Load the package in an R session:

library(pd.hg.u95b)

## Typical Workflows

### Integration with the oligo Package
This package is rarely used in isolation. When reading Affymetrix CEL files for the HG-U95B platform, the oligo package automatically detects and loads this annotation package to create a FeatureStack or ExpressionFeatureSet.

library(oligo)
# Assuming .CEL files for HG-U95B are in the working directory
raw_data <- read.celfiles(list.celfiles())
# The pd.hg.u95b package is used internally here to map probes

### Accessing Probe Sequences
You can manually access the Perfect Match (PM), Mismatch (MM), or Background (BG) sequences stored within the package.

1. Load the sequence data:
   data(pmSequence)

2. Inspect the data structure:
   The sequences are stored in a DataFrame with two columns: 'fid' (feature ID) and 'sequence'.
   
   head(pmSequence)

3. Access other sequence types (if applicable):
   data(mmSequence)
   data(bgSequence)

## Usage Tips

- Feature IDs (fid): Use the 'fid' column to map sequences back to specific coordinates on the microarray grid.
- Memory Management: These annotation objects can be large. Only load the sequence data (data(pmSequence)) if you are performing sequence-specific analysis (e.g., GC-content correction or probe-effect modeling).
- Platform Verification: Ensure your CEL files correspond to the "HG-U95B" array. Using this package with HG-U95A or HG-U95Av2 files will result in incorrect mappings.

## Reference documentation

- [pd.hg.u95b Reference Manual](./references/reference_manual.md)