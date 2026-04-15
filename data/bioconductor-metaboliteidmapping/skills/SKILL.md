---
name: bioconductor-metaboliteidmapping
description: This package provides a comprehensive mapping table for converting between nine different metabolite ID formats and common names. Use when user asks to map metabolite identifiers, convert between HMDB, ChEBI, KEGG, or PubChem IDs, and find common names for chemical registry numbers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/metaboliteIDmapping.html
---

# bioconductor-metaboliteidmapping

## Overview

The `metaboliteIDmapping` package provides a comprehensive mapping table for nine different metabolite ID formats and their common names. It aggregates data from HMDB, ChEBI, the EPA's Comptox Chemical Dashboard, and the `graphite` Bioconductor package. This is primarily a data-package where the main utility comes from accessing the `metabolitesMapping` tibble.

## Key ID Formats Supported

The package maps between the following identifiers:
- **CAS**: CAS Registry numbers
- **DTXSID / DTXCID**: Comptox Chemical Dashboard IDs
- **SID / CID**: Pubchem IDs
- **HMDB**: Human Metabolome Database IDs
- **ChEBI**: Chemical Entities of Biological Interest
- **KEGG**: KEGG Compound IDs
- **Drugbank**: Drugbank IDs
- **Name**: Common metabolite names

## Usage Patterns

### Loading the Mapping Table

There are two primary ways to access the data. The direct package load is the most straightforward for general use.

```r
# Method 1: Direct package load
library(metaboliteIDmapping)
# The data is automatically available as a tibble named 'metabolitesMapping'
head(metabolitesMapping)

# Method 2: Via AnnotationHub (recommended for specific versions)
library(AnnotationHub)
ah <- AnnotationHub()
# AH91792 is the current version accounting for tautomers
metabolites <- ah[["AH91792"]]
```

### Common Workflows

#### 1. Converting IDs
To convert a list of IDs (e.g., HMDB to KEGG), use standard `dplyr` operations on the mapping table.

```r
library(metaboliteIDmapping)
library(dplyr)

my_hmdb_ids <- c("HMDB0000001", "HMDB0000122")

mapping_results <- metabolitesMapping %>%
  filter(HMDB %in% my_hmdb_ids) %>%
  select(HMDB, KEGG, Name)
```

#### 2. Finding Names for Chemical IDs
If you have CAS numbers or PubChem CIDs and need the common names:

```r
cas_list <- c("75-05-8", "50-81-7")

names_found <- metabolitesMapping %>%
  filter(CAS %in% cas_list) %>%
  select(CAS, Name) %>%
  distinct()
```

#### 3. Handling Tautomers and Redundancy
The mapping table is large (over 1 million rows) because it accounts for many-to-many relationships and tautomers. Always use `distinct()` if you only need unique mappings to avoid inflating your data frames during joins.

```r
# Example of a clean join with experimental data
experimental_data <- data.frame(id = c("HMDB0000122"), value = 10)

joined_data <- experimental_data %>%
  left_join(metabolitesMapping %>% 
              select(HMDB, KEGG) %>% 
              filter(!is.na(HMDB)) %>%
              distinct(), 
            by = c("id" = "HMDB"))
```

## Tips for Success
- **Memory Management**: The `metabolitesMapping` object is a large tibble. If memory is an issue, filter for the specific columns you need immediately after loading.
- **Missing Values**: Many metabolites do not have mappings across all nine databases. Expect `NA` values in the mapping table.
- **AnnotationHub IDs**: 
    - `AH79817`: Original mapping (9 formats).
    - `AH83115`: Includes common names.
    - `AH91792`: Current version (includes tautomers).

## Reference documentation

- [metaboliteIDmapping](./references/metaboliteIDmapping.md)
- [metaboliteIDmapping Rmd](./references/metaboliteIDmapping.Rmd)