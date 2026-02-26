---
name: bioconductor-cytopipeline
description: Bioconductor-cytopipeline automates and visualizes flow cytometry data preprocessing and quality control workflows using a structured S4 class system. Use when user asks to define sequential processing queues, execute multi-step flow cytometry pipelines with disk-based caching, or compare different quality control methods and transformations.
homepage: https://bioconductor.org/packages/release/bioc/html/CytoPipeline.html
---


# bioconductor-cytopipeline

name: bioconductor-cytopipeline
description: Automation and visualization of flow cytometry data preprocessing and quality control (QC) pipelines. Use this skill when you need to define, execute, and visualize multi-step flow cytometry workflows using the CytoPipeline R package. It is particularly useful for comparing different QC methods (e.g., flowAI vs. PeacoQC), managing scale transformations across multiple samples, and utilizing disk-based caching for large datasets.

# bioconductor-cytopipeline

## Overview

CytoPipeline is a Bioconductor package designed to automate and standardize the preprocessing and quality control (QC) stages of flow cytometry data analysis. It uses a structured S4 class system (`CytoPipeline` and `CytoProcessingStep`) to define workflows that can be executed sequentially. The package supports two distinct processing queues: a global "scale transform" queue for estimating transformations across all samples, and a per-sample "pre-processing" queue. Results are automatically cached using `BiocFileCache`, allowing for efficient inspection and visualization of data at any intermediate step.

## Core Workflow

### 1. Initialize the Pipeline
Create a `CytoPipeline` object by providing an experiment name and a vector of paths to `.fcs` files.

```r
library(CytoPipeline)
experimentName <- "MyExperiment"
sampleFiles <- list.files("path/to/data", pattern = ".fcs", full.names = TRUE)

pipL <- CytoPipeline(experimentName = experimentName, sampleFiles = sampleFiles)
```

### 2. Define Processing Queues
Pipelines are built by adding `CytoProcessingStep` objects to one of two queues:
*   **scale transform**: Executed once using all samples (e.g., for compensation and estimating logicle transforms).
*   **pre-processing**: Executed for each sample individually (e.g., for QC, doublet removal, and gating).

```r
# Add a step to the scale transform queue
pipL <- addProcessingStep(pipL, 
    whichQueue = "scale transform",
    CytoProcessingStep(
        name = "compensate",
        FUN = "compensateFromMatrix",
        ARGS = list(matrixSource = "fcs")
    )
)

# Add a step to the pre-processing queue
pipL <- addProcessingStep(pipL,
    whichQueue = "pre-processing",
    CytoProcessingStep(
        name = "perform_QC",
        FUN = "qualityControlPeacoQC",
        ARGS = list(preTransform = TRUE)
    )
)
```

### 3. Execute the Pipeline
Run the pipeline by specifying a work directory for the cache.

```r
workDir <- "path/to/output"
execute(pipL, path = workDir)
```

## Inspection and Visualization

### Visualizing the Workflow
You can plot the pipeline structure as a graph to verify the sequence of steps.

```r
plotCytoPipelineProcessingQueue(pipL, whichQueue = "pre-processing", sampleFile = 1, path = workDir)
```

### Retrieving Intermediate Results
Access `flowFrame` objects or other data types from any named step in the cache.

```r
# Get flowFrame after a specific step
ff <- getCytoPipelineFlowFrame(pipL, 
                               whichQueue = "pre-processing", 
                               sampleFile = 1, 
                               objectName = "perform_QC_obj", 
                               path = workDir)

# Plot events
ggplotEvents(ff, xChannel = "FSC-A", yChannel = "SSC-A")
```

### Tracking Cell Loss
Monitor how many events are retained after each step to evaluate QC stringency.

```r
ret <- collectNbOfRetainedEvents(experimentName = "MyExperiment", path = workDir)
```

## Tips and Best Practices
*   **JSON Configuration**: Pipelines can be defined in JSON files for better reproducibility and shared across projects. Use `CytoPipeline("pipeline.json")` to load them.
*   **Wrapper Functions**: The `FUN` argument in `CytoProcessingStep` refers to wrapper functions. While many are built-in (e.g., `readSampleFiles`, `removeMarginsPeacoQC`), you can find more in the `CytoPipelineUtils` package or write your own.
*   **QC Method Order**: 
    *   For **flowAI**: Perform QC on raw data before transformations.
    *   For **PeacoQC**: Perform QC on compensated and scale-transformed data.
*   **Caching**: The `path` argument in `execute` and retrieval functions must point to the same directory to leverage the `BiocFileCache`.

## Reference documentation
- [Automation and Visualization of Flow Cytometry Data Analysis Pipelines](./references/CytoPipeline.md)
- [Demonstration of the CytoPipeline R package suite functionalities](./references/Demo.md)