---
name: bioconductor-bioconcotk
description: BiocOncoTK provides a unified interface for cancer genomics analysis by bridging Bioconductor objects with remote data sources like the TCGA PanCancer Atlas and CCLE. Use when user asks to query BigQuery-backed genomic resources, explore Oncotree ontologies, construct MultiAssayExperiments for integrative cancer research, or access curated single-cell RNA-seq datasets.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BiocOncoTK.html
---


# bioconductor-bioconcotk

name: bioconductor-bioconcotk
description: Expert guidance for the BiocOncoTK R package to analyze cancer genomics data. Use this skill when performing cancer-oriented research involving the TCGA PanCancer Atlas, CCLE (Cancer Cell Line Encyclopedia), TARGET, or CLUE.io platforms. It supports querying BigQuery-backed genomic resources, working with Oncotree ontologies, and accessing curated single-cell RNA-seq datasets (Patel, Darmanis) within the Bioconductor ecosystem.

# bioconductor-bioconcotk

## Overview

BiocOncoTK (Bioconductor OncoToolKit) provides a unified interface for cancer genomics analysis. It bridges Bioconductor objects (like SummarizedExperiment and MultiAssayExperiment) with large-scale remote data sources including Google BigQuery (ISB-CGC), pharmacogenomic databases, and single-cell archives.

## Core Workflows

### 1. Ontology Exploration (Oncotree)
Use `ontoProc` and `ontologyPlot` to visualize cancer types within the NCI Oncotree hierarchy.

```r
library(ontoProc)
library(ontologyPlot)
oto = getOncotreeOnto()
# Find a specific tag (e.g., Glioblastoma)
glioTag = names(grep("Glioblastoma$", oto$name, value=TRUE))
# Get siblings and plot
st = siblings_TAG(glioTag, oto, justSibs=FALSE)
onto_plot(oto, slot(st, "ontoTags"))
```

### 2. PanCancer Atlas via BigQuery
Accessing the PanCancer Atlas requires a Google Cloud Project billing ID set in the `CGC_BILLING` environment variable.

**Connection and Data Retrieval:**
```r
library(BiocOncoTK)
library(restfulSE)

# Establish connection
pcbq = pancan_BQ() 

# Create a SummarizedExperiment for a specific assay and tumor
# Use pancan_longname() to find correct table names
rna_table = pancan_longname("rnaseq")

brca_se = pancan_SE(pcbq, 
                    colDFilterValue = "BRCA", 
                    assayDataTableName = rna_table,
                    assaySampleTypeCode = "TP") # TP = Primary Tumor, NT = Normal
```

**Sample Type Mapping:**
Check `BiocOncoTK::pancan_sampTypeMap` to decode sample type letters (e.g., "TM" for Metastatic, "TR" for Recurrent).

### 3. MultiAssayExperiment Construction
You can combine multiple remote assays into a single `MultiAssayExperiment` for integrative analysis without downloading the full datasets.

```r
library(MultiAssayExperiment)
# Define assays (mRNA, Methylation, RPPA) using pancan_SE
# Then wrap in MultiAssayExperiment
mae = MultiAssayExperiment(
  ExperimentList(rnaseq = BRCA_mrna, meth = BRCA_meth),
  colData = clinDF
)
```

### 4. CCLE and Pharmacogenomics
Query the Cancer Cell Line Encyclopedia for mutations and expression, then link to drug sensitivity.

```r
# Connect to CCLE dataset in BigQuery
con = DBI::dbConnect(bigrquery::bigquery(), project="isb-cgc", dataset="ccle_201602_alpha", billing=your_billing_id)

# Filter for specific mutations (e.g., NRAS)
muts = con %>% tbl("Mutation_calls") %>% 
       filter(Hugo_Symbol == "NRAS") %>% 
       as.data.frame()

# Get expression for a gene (e.g., AHR)
expr = con %>% tbl("AffyU133_RMA_expression") %>%
       filter(HGNC_gene_symbol == "AHR") %>%
       as.data.frame()
```

### 5. CLUE.io (L1000) Interface
Requires an API key from clue.io set as `CLUE_KEY`.

```r
# Query for perturbagens targeting a specific protein
egfr_perts = query_clue(service="perts", filter=list(where=list(target="EGFR")))

# Get signature metadata
sig_info = query_clue(service="sigs", filter=list(where=list(sig_id="some_sig_id")))
```

### 6. Single-Cell Data Access
Access curated GBM datasets (Patel 2014 or Darmanis 2017).

```r
# Patel 2014 (In-memory)
patelSE = loadPatel() 

# Darmanis 2017 (HDF5/DelayedArray - Out-of-memory)
darmSE = BiocOncoTK::darmGBMcls
```

## Tips and Best Practices
- **Billing:** Always ensure `Sys.setenv(CGC_BILLING="your-project-id")` is called before using `pancan_BQ()`.
- **Table Names:** Use `pancan_longname()` with fuzzy matching (e.g., `pancan_longname("rppa")`) to avoid typing long BigQuery table identifiers.
- **Interactive Exploration:** Use `pancan_app()` to launch a Shiny interface for browsing PanCancer Atlas metadata.
- **Memory Management:** When working with `darmGBMcls` or `restfulSE` objects, data is only fetched when `assay()` is called. Subset the object *before* calling `assay()` to minimize network transfer.

## Reference documentation
- [BiocOncoTK](./references/BiocOncoTK.md)