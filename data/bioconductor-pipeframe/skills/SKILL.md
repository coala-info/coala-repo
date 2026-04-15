---
name: bioconductor-pipeframe
description: The bioconductor-pipeframe package provides a framework for building and managing componentized bioinformatics pipelines in R. Use when user asks to create directed acyclic graph workflows, manage genome-specific reference data, implement custom pipeline steps, or handle automatic dependency management and breakpoint restarts.
homepage: https://bioconductor.org/packages/release/bioc/html/pipeFrame.html
---

# bioconductor-pipeframe

name: bioconductor-pipeframe
description: Expert guidance for the pipeFrame Bioconductor package. Use this skill to build, configure, and manage componentized bioinformatics pipelines in R. It supports creating directed acyclic graph (DAG) workflows, managing genome-specific reference data, and implementing custom pipeline steps with automatic dependency handling and breakpoint restart capabilities.

# bioconductor-pipeframe

## Overview

The `pipeFrame` package provides a framework for building componentized bioinformatics pipelines in R. It treats each pipeline step as a discrete object, allowing for seamless data transfer between steps, automatic management of intermediate files, and the ability to restart pipelines from specific breakpoints. It is particularly useful for developers creating complex workflows that require genome-specific reference data and multi-threaded execution.

## Core Workflow

### 1. Initialization and Configuration

Before running any pipeline steps, you must initialize the framework. This sets up the global environment for job names, genome versions, and directory structures.

```r
library(pipeFrame)

# Initialize with available genomes and a job name
initPipeFrame(availableGenome = c("hg19", "hg38", "mm10"),
              defaultJobName = "my_analysis_project")

# Configure specific settings
setGenome("hg19")
setThreads(4)
setTmpDir("./results")
setRefDir("./references")
```

### 2. Managing Reference Data

`pipeFrame` can automate the installation and generation of reference files (like FASTA files or BSgenome objects) based on the configured genome.

```r
# Check if a genome is valid
getValidGenome()

# Access reference resources
# getRefRc returns R objects; getRefFiles returns file paths
bsgenome_obj <- getRefRc("bsgenome")
fasta_path <- getRefFiles("fasta")
```

### 3. Creating Pipeline Steps

Pipeline steps are implemented as S4 classes inheriting from the `Step` class. A typical step involves:
1.  **Defining the Class**: Inherit from `Step`.
2.  **Initialization (`init`)**: Define input, output, and parameter lists.
3.  **Processing (`processing`)**: Implement the actual logic.

#### Example: Defining a Step
```r
setClass("MyStep", contains = "Step")

setMethod("init", "MyStep", function(.Object, prevSteps = list(), ...) {
    allparam <- list(...)
    # Set inputs from previous steps or arguments
    if(length(prevSteps) > 0) {
        input(.Object)$inFile <- getParam(prevSteps[[1]], "outFile")
    }
    # Define automatic output paths
    output(.Object)$outFile <- getStepWorkDir(.Object, "result.txt")
    .Object
})

setMethod("processing", "MyStep", function(.Object, ...) {
    # Logic goes here
    input_file <- getParam(.Object, "inFile")
    output_file <- getParam(.Object, "outFile")
    # ... process ...
    .Object
})
```

### 4. Connecting Steps (Graph Management)

Define the relationships between steps using `addEdges`. This ensures the pipeline follows a Directed Acyclic Graph (DAG).

```r
# Define that StepA flows into StepB
addEdges(edges = c("StepA", "StepB"), argOrder = 1)

# View the pipeline map
printMap()
```

### 5. Executing the Pipeline

Steps can be linked using the pipe operator (`%>%`) for a seamless workflow.

```r
library(magrittr)

# Functional wrappers are typically used to instantiate steps
result <- stepA_function(param1 = "val") %>%
          runStepB_function(param2 = "val")
```

## Key Functions Reference

- `initPipeFrame()`: Global initialization of the pipeline environment.
- `setGenome()` / `getGenome()`: Manage the current reference genome.
- `setJobName()` / `getJobDir()`: Manage the current project workspace.
- `getStepWorkDir(.Object, "filename")`: Generates a path within the specific step's output directory.
- `getParam(.Object, "key")`: Retrieves values from the input, output, or parameter lists.
- `input(.Object)`, `output(.Object)`, `param(.Object)`: Accessors to set step-specific data during `init`.
- `runWithFinishCheck()`: Used within reference installation functions to handle breakpoints.

## Reference documentation

- [Componentized Pipeline Framework](./references/pipeFrame.Rmd)
- [An Introduction to pipeFrame](./references/pipeFrame.md)