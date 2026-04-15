---
name: bioconductor-eir
description: This tool performs accelerated similarity searching and clustering of small molecules using geometric embedding and Locality Sensitive Hashing. Use when user asks to manage large chemical compound databases, perform fast nearest neighbor lookups, or execute Jarvis-Patrick clustering on chemical structures.
homepage: https://bioconductor.org/packages/release/bioc/html/eiR.html
---

# bioconductor-eir

name: bioconductor-eir
description: Accelerated similarity searching and clustering of small molecules using geometric embedding and Locality Sensitive Hashing (LSH). Use this skill to manage large chemical compound databases, perform sub-linear time nearest neighbor lookups, and execute fast Jarvis-Patrick clustering on chemical structures (SDF or SMILES).

## Overview

The `eiR` package enables efficient similarity searching in massive chemical compound databases. It works by selecting reference compounds and embedding the entire database into a d-dimensional space based on distances to these references. This approach, combined with Locality Sensitive Hashing (LSH), allows for extremely fast queries that avoid linear scans of the entire dataset. It uses an SQL backend (typically SQLite) to store compound definitions and descriptors.

## Core Workflow

### 1. Initialization
Create a database and compute descriptors (atom-pair "ap" or fingerprint "fp").

```r
library(eiR)
library(ChemmineR)
data(sdfsample)

# Initialize database with first 99 compounds
# Creates a 'data' directory in the current working directory
eiInit(sdfsample[1:99], priorityFn=randomPriorities)
```

### 2. Creating the Searchable Index
Embed the compounds into a searchable space. This creates a `run-r-d` directory.

```r
# r: number of reference compounds
# d: number of dimensions
r <- 60
d <- 40
runId <- eiMakeDb(r, d, descriptorType = "ap")
```

### 3. Similarity Queries
Search for compounds similar to a query structure.

```r
# Search for top 10 matches for the 45th compound in the sample
# asSimilarity=TRUE returns Tanimoto-like scores (0 to 1)
result <- eiQuery(runId, sdfsample[45], K=10, asSimilarity=TRUE)

# result is a data frame: query, target, similarity, target_ids
print(result)
```

### 4. Adding Compounds
Add new structures to an existing index without re-embedding the entire database.

```r
eiAdd(runId, sdfsample[100])
```

### 5. Clustering
Perform Jarvis-Patrick clustering using the LSH index for speed.

```r
# K: neighbors to fetch; minNbrs: required shared neighbors
clustering <- eiCluster(runId, K=5, minNbrs=2, cutoff=0.5)

# View results
byCluster(clustering)
```

## Advanced Customization

### Custom Distance Functions
You can override default distance measures (1-Tanimoto) for specific descriptor types.

```r
setDefaultDistance("ap", function(d1, d2) 1 - cmp.similarity(d1, d2))
```

### Custom Descriptors (Transforms)
Use `addTransform` to define how to convert chemical formats to descriptors and how to serialize them for the SQL backend.

```r
addTransform("ap", "sdf", toObject = function(input, conn=NULL, dir=".") {
    # Logic to convert input to APset object
    sdfset <- if(inherits(input, "SDFset")) input else read.SDFset(input)
    list(names=sdfid(sdfset), descriptors=sdf2ap(sdfset))
})
```

## Tips and Best Practices
- **Directory Management**: `eiR` creates local directories (`data/` and `run-r-d/`). Always run scripts from the same parent directory or specify the path using the `dir` argument.
- **Parameter Tuning**: For large databases, `d=100` is a recommended starting point for dimensions.
- **Parallelization**: `eiInit` and `eiMakeDb` support SNOW clusters for parallel processing, provided the backend (like PostgreSQL) supports parallel writes.
- **LSH Accuracy**: LSH is an approximate algorithm. If you receive fewer than `K` results or unexpected matches, try increasing the expansion ratio or `K` value.

## Reference documentation
- [eiR: Accelerated Similarity Searching of Small Molecules](./references/eiR.Rmd)
- [eiR: Accelerated Similarity Searching of Small Molecules (Markdown)](./references/eiR.md)