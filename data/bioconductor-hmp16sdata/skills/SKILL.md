---
name: bioconductor-hmp16sdata
description: This package provides access to Human Microbiome Project 16S rRNA sequencing data as SummarizedExperiment objects for analysis in R. Use when user asks to download HMP 16S data, generate demographic summary tables, subset microbiome samples by body site, or integrate HMP datasets with phyloseq for diversity analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HMP16SData.html
---

# bioconductor-hmp16sdata

name: bioconductor-hmp16sdata
description: Access and analyze Human Microbiome Project (HMP) 16S rRNA sequencing data (variable regions 1-3 and 3-5). Use this skill to download HMP data as SummarizedExperiment objects, perform demographic summaries, subset by body site, and integrate with phyloseq for diversity analysis.

## Overview
The `HMP16SData` package provides streamlined access to the Human Microbiome Project's 16S rRNA sequencing data. It serves processed data as `SummarizedExperiment` objects via `ExperimentHub`, covering two major variable regions (V1-3 and V3-5). The package includes tools for generating publication-ready summary tables and functions to bridge HMP data into the `phyloseq` ecosystem for advanced microbial ecology analysis.

## Core Functions and Data Access

### Loading Data
The package provides two primary functions to retrieve data. These will download the data to a local cache on the first call.

```r
library(HMP16SData)

# Load variable region 1-3 data
se_v13 <- V13()

# Load variable region 3-5 data
se_v35 <- V35()
```

### Data Structure
The returned objects are `SummarizedExperiment` class:
- **Assays**: Contains the 16S rRNA OTU counts.
- **colData**: Sample metadata (e.g., `RSID`, `VISITNO`, `HMP_BODY_SITE`, `HMP_BODY_SUBSITE`).
- **rowData**: Taxonomic lineage (Kingdom through Genus).
- **metadata**: Includes the phylogenetic tree.

## Common Workflows

### 1. Generating Summary Tables
Use `table_one` to create demographic summaries of the HMP cohorts.

```r
# Simple summary of V1-3 data
tab1 <- table_one(se_v13)

# Comparative summary of both regions for HTML output
list(V13 = V13(), V35 = V35()) %>%
    table_one() %>%
    kable_one()
```

### 2. Subsetting by Body Site
Standard Bioconductor subsetting works on these objects.

```r
# Filter for stool samples in the V3-5 region
stool_se <- subset(se_v35, select = HMP_BODY_SUBSITE == "Stool")
```

### 3. Integration with phyloseq
To use `phyloseq` methods (diversity, ordination), coerce the `SummarizedExperiment` using `as_phyloseq`.

```r
library(phyloseq)

# Convert to phyloseq object
ps <- as_phyloseq(se_v13)

# Example: Alpha diversity plot
plot_richness(ps, x = "HMP_BODY_SITE", measures = c("Shannon", "Simpson"))
```

### 4. Accessing Controlled-Access Data (dbGaP)
If you have dbGaP approval for study `phs000228.v4.p1`, you can merge protected participant metadata.

```r
# Requires SRA Toolkit installed on the system
se_protected <- attach_dbGaP(se_v35, "/path/to/your_key.ngc")
```

## Data Export
If you need to move data to other environments (CSV, SAS, STATA), you must flatten the object.

```r
library(dplyr)
library(tibble)

# Extract and merge metadata with OTU counts
participant_data <- as.data.frame(colData(se_v13)) %>% rownames_to_column("PSN")
otu_counts <- as.data.frame(t(assay(se_v13))) %>% rownames_to_column("PSN")
full_data <- left_join(participant_data, otu_counts, by = "PSN")

# Export to CSV
readr::write_csv(full_data, "HMP_V13_data.csv")
```

## Tips for Success
- **Memory Management**: These datasets are large (thousands of samples and tens of thousands of OTUs). When performing intensive visualizations or distance calculations, consider sampling the data using `prune_samples` or `subset_samples`.
- **Taxonomy**: Use `rowData(se)` to inspect the consensus lineage if you need to filter by specific phyla or genera before converting to `phyloseq`.
- **Sample Mapping**: Use the `SRS_SAMPLE_ID` column to map 16S samples to Metagenomic Shotgun (MGX) samples found in packages like `curatedMetagenomicData`.

## Reference documentation
- [HMP16SData](./references/HMP16SData.md)