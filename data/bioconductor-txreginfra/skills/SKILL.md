---
name: bioconductor-txreginfra
description: TxRegInfra provides infrastructure to query and integrate diverse transcriptional regulatory data modalities from remote MongoDB databases into Bioconductor containers. Use when user asks to connect to regulatory databases, perform genomic range-based queries on eQTL or footprinting data, and convert results into RaggedExperiment objects for downstream analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/TxRegInfra.html
---

# bioconductor-txreginfra

## Overview

TxRegInfra provides the infrastructure to query and integrate diverse transcriptional regulatory data modalities. It leverages MongoDB as a backend to handle the high volume of tissue-specific data (like digital genomic footprinting and eQTLs) without requiring the user to store massive BED files locally. The package primarily facilitates the conversion of remote database queries into standard Bioconductor containers like `RaggedExperiment` for downstream analysis.

## Core Workflows

### 1. Connecting to the Regulatory Database
The package uses `mongolite` to interface with a MongoDB server. A default AWS-hosted instance is often used for testing and general regulatory queries.

```r
library(TxRegInfra)
library(mongolite)

# Connect to the default AWS-hosted txregnet database
con1 <- mongo(url = URL_txregInAWS(), db = "txregnet")

# List available collections (requires local mongo installation)
if (verifyHasMongoCmd()) {
  collections <- listAllCollections(url = URL_txregInAWS(), db = "txregnet")
}
```

### 2. Querying and Aggregation
You can perform raw MongoDB queries or use the package's helper functions to generate JSON-based aggregation pipelines.

```r
# Find a single record from a specific collection
coll_name <- "Adipose_Subcutaneous_allpairs_v7_eQTL"
m1 <- mongo(url = URL_txregInAWS(), db = "txregnet", collection = coll_name)
sample_rec <- m1$find(limit = 1)

# Create an aggregator to compute statistics by chromosome
# Example: Find minimum footprint statistic (stat) by chromosome (chr)
newagg <- makeAggregator(by = "chr", vbl = "stat", op = "$min", opname = "min")
res <- m1$aggregate(newagg)
```

### 3. Using the RaggedMongoExpt Container
The `RaggedMongoExpt` object binds sample metadata to the MongoDB connection, allowing for genomic range-based subsetting.

```r
# Load basic sample metadata
cd <- TxRegInfra::basicColData

# Create the integrative container
rme0 <- RaggedMongoExpt(con1, colData = cd)

# Filter by data type (e.g., Footprinting 'FP')
rme1 <- rme0[, which(cd$type == "FP")]

# Subset by genomic coordinates (returns a RaggedExperiment)
roi <- GRanges("chr17", IRanges(38.07e6, 38.09e6))
se_sub <- sbov(rme1, roi)
```

### 4. Data Extraction and Visualization
Once subsetted into a `RaggedExperiment`, data can be converted into matrices for visualization with `Gviz`.

```r
# Extract a sparse assay (e.g., the 3rd assay containing 'stat')
sa <- sparseAssay(se_sub, 3)

# Example: Prepare for Gviz plotting
# Convert rownames (chr:start-end) back to GRanges
sar <- strsplit(rownames(sa), ":|-")
gr <- GRanges(seqnames(roi), 
              IRanges(as.numeric(sapply(sar, "[", 2)), 
                      as.numeric(sapply(sar, "[", 3))))

# Add scores from the sparse assay
gr$score <- 1 - sa[, 1] # Example transformation
```

## Tips and Best Practices
- **Memory Management**: Use `sbov()` (subset by overlap) to pull only the necessary genomic slices from the remote database into your R session to avoid memory exhaustion.
- **Parallelization**: When performing many queries, register a parallel backend using `BiocParallel`, though `SerialParam()` is safer for initial debugging of database connections.
- **Collection Names**: Collection names typically follow a pattern: `[Tissue]_[Study]_[Build]_[Type]`. Use `basicColData` to explore available tissue/type combinations.

## Reference documentation
- [TxRegInfra](./references/TxRegInfra.md)