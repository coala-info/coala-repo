---
name: mstmap
description: MSTmap constructs accurate genetic linkage maps by calculating a Minimum Spanning Tree to group and order markers. Use when user asks to build linkage maps, group markers into linkage groups, determine marker order, or calculate genetic distances.
homepage: http://mstmap.org/
metadata:
  docker_image: "quay.io/biocontainers/mstmap:1--h4ac6f70_3"
---

# mstmap

## Overview
MSTmap is a tool designed to build accurate genetic linkage maps by calculating a Minimum Spanning Tree (MST) of a graph. It excels at handling datasets with significant missing values or genotyping errors. You should use this skill when you need to group markers into linkage groups (LGs), determine marker order, and calculate genetic distances (cM) using either Kosambi or Haldane mapping functions.

## Input File Format
The input must be a tab-delimited text file representing a genotype matrix of dimension (m+1) * (n+1).
- **First Row**: Mapping line IDs (e.g., individual plant/animal names).
- **First Column**: Marker IDs.
- **Genotype States**: 
  - `A` or `a`: Parent A genotype.
  - `B` or `b`: Parent B genotype.
  - `X`: Heterozygous (only for RIL populations).
  - `U` or `-`: Missing data.

## Parameter Selection
- **Population Type**: Choose between `DH` (also used for BC1 and Haploid) or `RIL` (specify generation 2-10). Using `DH` for a `RIL` population will inflate map distances by approximately 2x.
- **Grouping LOD**: If the chromosome number is known, iterate through LOD scores (3 to 10) until the output matches the expected number of linkage groups. Use "Single LG" to force all markers into one group.
- **Mapping Function**: 
  - `Kosambi`: Accounts for interference (standard for most species).
  - `Haldane`: Assumes no interference.
- **Error Detection**: Set "Try to detect genotyping errors" to `Yes` only for low-quality data. This treats rare recombination events as potential errors, resulting in fewer bins.
- **Bad Marker Detection**: 
  - `No. mapping size threshold`: Set to 1 or 2 to isolate small, problematic marker groups. Set to 0 to disable.
  - `No. mapping distance threshold`: Markers further than this (in cM) from others are considered isolated.

## CLI Usage Patterns
While the tool is often accessed via a web interface, the underlying executable typically requires a parameter file or specific flags.
- **Missing Data**: Use the `No. mapping missing threshold` to automatically filter out markers with more than a specific percentage (e.g., 25%) of missing observations.
- **Refining Maps**: If a map is too fragmented, decrease the LOD score. If multiple chromosomes are merged, increase the LOD score.

## Reference documentation
- [MSTmap Help Information](./references/mstmap_org_help.md)
- [MSTmap Online Parameters](./references/mstmap_org_mstmap_online.md)
- [MSTmap Overview](./references/mstmap_org_index.md)