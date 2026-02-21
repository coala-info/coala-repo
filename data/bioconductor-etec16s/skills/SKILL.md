---
name: bioconductor-etec16s
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/etec16s.html
---

# bioconductor-etec16s

## Overview
The `etec16s` package provides a specialized dataset for microbiome research, specifically focusing on the human gut microbiota's response to enterotoxigenic *Escherichia coli* (ETEC) challenge and subsequent ciprofloxacin treatment. The data is stored as an `MRexperiment` object, making it natively compatible with the `metagenomeSeq` analysis framework. It includes 16S rRNA (V1-V2 region) counts for 124 samples across 6,423 features, along with detailed clinical metadata.

## Loading and Exploring Data
To use the dataset, you must load both the data package and `metagenomeSeq` to handle the `MRexperiment` class.

```r
library(metagenomeSeq)
library(etec16s)

# Load the dataset
data(etec16s)

# View summary of the MRexperiment object
etec16s
```

## Accessing Components
The dataset contains three primary components: the count matrix, phenotype data (samples), and feature data (taxa).

### 1. Phenotype Data (Metadata)
Access clinical information such as `SubjectID`, `Dose`, `Day`, and `Diarrhea` status.
```r
# View metadata structure
phenoData(etec16s)

# Access the data frame of sample information
sample_info <- pData(etec16s)
head(sample_info)
```

### 2. Feature Data (Taxonomy)
Access taxonomic classifications from Phylum to Species for the OTUs.
```r
# View feature metadata structure
featureData(etec16s)

# Access taxonomic information
taxa_info <- fData(etec16s)
head(taxa_info)
```

### 3. Count Matrix
Extract raw or normalized counts.
```r
# Extract counts for the first 10 samples
counts_matrix <- MRcounts(etec16s[, 1:10])
head(counts_matrix)
```

## Common Workflows

### Subsetting by Time Point
The dataset tracks volunteers over time. You can subset the object using standard R indexing based on the `Day` variable in `pData`.
```r
# Subset to only include samples from Day 84
etec16s_day84 <- etec16s[, which(pData(etec16s)$Day == 84)]
```

### Filtering by Clinical Status
You can isolate samples from volunteers who experienced diarrhea versus those who did not.
```r
# Subset for samples where diarrhea was present
diarrhea_samples <- etec16s[, which(pData(etec16s)$AnyDayDiarrhea == 1)]
```

### Taxonomic Analysis
Since the data is an `MRexperiment` object, you can use `metagenomeSeq` functions to aggregate counts by taxonomic level (e.g., Genus).
```r
# Example: Aggregating by Genus (requires metagenomeSeq)
genus_level_obj <- aggregateByTaxonomy(etec16s, lvl = "Genus")
```

## Key Metadata Fields
- `Day`: Study day (relative to ETEC challenge).
- `Dose`: The amount of ETEC administered.
- `AnyDayDiarrhea`: Binary indicator (1 = Yes, 0 = No).
- `AntibGiven`: Whether antibiotics were administered.

## Reference documentation
- [ETEC 16S dataset](./references/etec16s.md)