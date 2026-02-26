---
name: bioconductor-illuminahumanmethylationepicv2anno.20a1.hg38
description: This package provides hg38-based genomic annotations for Illumina Methylation EPIC v2.0 BeadChips. Use when user asks to map EPIC v2.0 probes to genomic features, handle duplicated probe IDs, or integrate EPIC v2.0 data with the minfi package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylationEPICv2anno.20a1.hg38.html
---


# bioconductor-illuminahumanmethylationepicv2anno.20a1.hg38

name: bioconductor-illuminahumanmethylationepicv2anno.20a1.hg38
description: Annotation package for Illumina Methylation EPIC v2.0 BeadChips using hg38 coordinates. Use when analyzing EPIC v2.0 methylation data to map probes to genomic features (Islands, Shores, Shelves), handle duplicated probe IDs, or integrate with the minfi package for preprocessing.

## Overview

The `IlluminaHumanMethylationEPICv2anno.20a1.hg38` package provides the hg38-based genomic annotations for the Illumina Methylation EPIC v2.0 array. Unlike the v1 array, the v2 array contains duplicated probes (same sequence, different locations). This package uses "Illumina IDs" (e.g., `cgXXXXXXXX_XXXX`) as unique identifiers and provides tools to aggregate these back to standard probe IDs.

## Integration with minfi

When using this annotation with the `minfi` package, you must manually set the annotation and array elements in your `RGChannelSet`.

```R
library(minfi)
library(IlluminaHumanMethylationEPICv2anno.20a1.hg38)

# Assuming RGset is your loaded RGChannelSet
annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
annotation(RGset)["annotation"] = "20a1.hg38"
```

## Handling Duplicated Probes

In EPIC v2, a single probe ID (e.g., `cg06373096`) may appear multiple times with different suffixes (e.g., `_TC11`, `_TC12`). The package provides `aggregate_to_probes()` to simplify analysis by collapsing these duplicates.

### Aggregating Beta Values
Use this function on a beta matrix to calculate the mean value for duplicated probes, resulting in a matrix indexed by standard probe IDs.

```R
# Get beta values from a minfi object
beta = getBeta(obj)

# Aggregate to standard probe IDs
beta_aggregated = aggregate_to_probes(beta)
```

### Aggregating Annotation Data
You can also aggregate the annotation data frames themselves.

```R
data(Islands.UCSC)
cgi_aggregated = aggregate_to_probes(Islands.UCSC)
```

## Accessing Annotation Data

The package contains several annotation objects. The most common is `Islands.UCSC`, which describes the relationship of probes to CpG islands.

```R
# Load the island annotations
data(Islands.UCSC)

# View the first few rows
head(Islands.UCSC)

# Check distribution of features
table(Islands.UCSC$Relation_to_Island)
```

Note: In this v2 package, features are simplified to "Island", "Shore", "Shelf", and "OpenSea" (v1 packages often split shores/shelves into North and South).

## Workflow Example: From Raw Data to Aggregated Probes

```R
library(minfi)
library(IlluminaHumanMethylationEPICv2anno.20a1.hg38)

# 1. Load data
RGset = read.metharray.exp(base = "path/to/idat/files")

# 2. Set correct annotation metadata
annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
annotation(RGset)["annotation"] = "20a1.hg38"

# 3. Preprocess
MSet = preprocessRaw(RGset)
beta = getBeta(MSet)

# 4. Collapse duplicates for standard probe-level analysis
beta_final = aggregate_to_probes(beta)
```

## Reference documentation

- [Use of IlluminaHumanMethylationEPICv2anno.20a1.hg38](./references/IlluminaHumanMethylationEPICv2anno.20a1.hg38.md)