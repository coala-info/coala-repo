---
name: bioconductor-rcwlpipelines
description: This package provides a collection of pre-built Common Workflow Language (CWL) bioinformatics tools and pipelines for use within the R environment. Use when user asks to search for bioinformatics recipes, load standardized workflows, customize pipeline parameters, or execute containerized analysis tools.
homepage: https://bioconductor.org/packages/release/bioc/html/RcwlPipelines.html
---

# bioconductor-rcwlpipelines

## Overview

`RcwlPipelines` is a Bioconductor package that provides a collection of pre-built bioinformatics tools and pipelines based on the Common Workflow Language (CWL). It allows R users to discover, load, and run standardized analysis workflows (like RNA-seq, variant calling, etc.) without needing to write CWL from scratch. It acts as a bridge between R and containerized command-line tools.

## Core Workflow

### 1. Initialize and Update the Hub
The `cwlUpdate` function synchronizes the local cache with the latest recipes from the central repository.

```r
library(RcwlPipelines)
# Sync tools and pipelines (returns a cwlHub object)
atls <- cwlUpdate()
atls
```

### 2. Search for Tools or Pipelines
Use `cwlSearch` with keywords to find specific tools (prefixed with `tl_`) or pipelines (prefixed with `pl_`).

```r
# Search for BWA alignment tools
search_results <- cwlSearch(c("bwa", "mem"))

# View metadata (Type, Command, Container)
mcols(search_results)
```

### 3. Load a Recipe
Load a specific tool or pipeline into the R environment using its title.

```r
# Load by title
bwa <- cwlLoad("tl_bwa")

# Inspect the tool structure (inputs, outputs, base command)
bwa
```

### 4. Customize Parameters
You can modify default arguments or Docker requirements before execution.

```r
# Load a pipeline
rnaseq <- cwlLoad("pl_rnaseq_Sf")

# View/Change arguments for a specific step (e.g., STAR)
arguments(rnaseq, "STAR")
arguments(rnaseq, "STAR")[[6]] <- 5 # Change mismatch max

# Change Docker container version
requirements(rnaseq, "STAR")[[1]] <- requireDocker(docker = "quay.io/biocontainers/star:2.7.8a--0")
```

### 5. Execute the Workflow
Assign values to the input slots and run the process.

```r
# Check required inputs
inputs(rnaseq)

# Assign values
rnaseq$in_seqfiles <- list("sample_R1.fq.gz", "sample_R2.fq.gz")
rnaseq$in_prefix <- "sample1"

# Run locally using Docker
# Note: Requires Docker or Singularity installed on the system
res <- runCWL(rnaseq, outdir = "results/sample1", docker = TRUE)
```

## Batch Execution
For multiple samples, use `runCWLBatch` combined with `BiocParallel`.

```r
library(BiocParallel)
# Define input lists for multiple samples
inputList <- list(
    in_seqfiles = list(s1 = list("s1_R1.fq", "s1_R2.fq"), 
                       s2 = list("s2_R1.fq", "s2_R2.fq")),
    in_prefix = list(s1 = "sample1", s2 = "sample2")
)

# Execute batch
runCWLBatch(rnaseq, outdir = "batch_results", inputList = inputList, docker = TRUE)
```

## Tips
- **Type Filtering**: Use `table(mcols(atls)$Type)` to see the distribution of available tools vs. pipelines.
- **Visualization**: Use `plotCWL(pipeline_object)` to view the workflow graph.
- **Caching**: Recipes are cached locally; you only need to run `cwlUpdate()` when you need to check for new or updated tools.

## Reference documentation
- [RcwlPipelines](./references/RcwlPipelines.md)