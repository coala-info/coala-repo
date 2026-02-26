---
name: bioconductor-illuminahumanmethylationepicv2manifest
description: This package provides the manifest data required to process and annotate DNA methylation data from the Illumina EPIC v2.0 array. Use when user asks to load EPIC v2.0 manifest data, manually assign array versions to RGChannelSet objects, retrieve Illumina IDs, or handle duplicated probe sequences.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylationEPICv2manifest.html
---


# bioconductor-illuminahumanmethylationepicv2manifest

## Overview

The IlluminaHumanMethylationEPICv2manifest package provides the necessary manifest data for the Illumina Methylation EPIC v2.0 array. Unlike the v1.0 array, the v2.0 array contains duplicated probe IDs (probes with the same sequence but different physical locations). To maintain uniqueness, this package uses the "Illumina ID" (IlmnID), which combines the standard probe ID with a duplication suffix (e.g., "cg12345678_BC11").

## Integration with minfi

When using the minfi package to process EPIC v2.0 data, the array type is often not automatically detected. Manually assign the array and annotation versions to the RGChannelSet object.

```r
library(minfi)
library(IlluminaHumanMethylationEPICv2manifest)

# Load your data
RGset <- read.metharray.exp(base = "path/to/idat/files")

# Manually set the array to EPICv2
annotation(RGset)["array"] <- "IlluminaHumanMethylationEPICv2"

# Set the annotation (typically used with IlluminaHumanMethylationEPICv2anno.20a1.hg38)
annotation(RGset)["annotation"] <- "20a1.hg38"

# Proceed with preprocessing
mSet <- preprocessRaw(RGset)
```

## Handling Probe IDs

### Accessing Manifest Information
Use `getManifestInfo` to retrieve probe names (IlmnIDs).

```r
# Get all unique Illumina IDs
illumina_IDs <- getManifestInfo(IlluminaHumanMethylationEPICv2manifest, "locusNames")

# Convert Illumina IDs to standard Probe IDs (removing suffixes)
probe_IDs <- gsub("_.*$", "", illumina_IDs)
```

### Managing Duplicated Probes
Because some probe IDs appear multiple times, you may need to aggregate data (e.g., Beta values) to the probe level after processing.

```r
# Example: Averaging Beta values for duplicated probes
beta <- getBeta(mSet)
beta_collapsed <- do.call(rbind, tapply(1:nrow(beta), gsub("_.*$", "", rownames(beta)), function(ind) {
    colMeans(beta[ind, , drop = FALSE])
}, simplify = FALSE))
```

## Comparing v1 and v2 Probes

To compare coverage between EPIC v1 and v2, load both manifest packages and extract unique probe IDs.

```r
library(IlluminaHumanMethylationEPICmanifest)

# Get unique probe IDs for v1
v1_probes <- unique(getManifestInfo(IlluminaHumanMethylationEPICmanifest, "locusNames"))

# Get unique probe IDs for v2 (stripping suffixes)
v2_probes <- unique(gsub("_.*$", "", getManifestInfo(IlluminaHumanMethylationEPICv2manifest, "locusNames")))

# Find common probes
common_probes <- intersect(v1_probes, v2_probes)
```

## Troubleshooting

1. **Low Probe Count**: If you process EPIC v2.0 data using the v1.0 manifest, you will see a significant drop in probe count (e.g., only ~100k probes instead of ~900k). Ensure `annotation(RGset)["array"]` is explicitly set to `"IlluminaHumanMethylationEPICv2"`.
2. **ID Mismatches**: Always check if your downstream analysis tools expect the suffixed IlmnID or the standard cg-style ID. Use `gsub("_.*$", "", rownames(obj))` to convert if necessary.

## Reference documentation

- [Use of IlluminaHumanMethylationEPICv2manifest](./references/IlluminaHumanMethylationEPICv2manifest.md)