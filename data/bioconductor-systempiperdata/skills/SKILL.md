---
name: bioconductor-systempiperdata
description: This package provides pre-configured workflow templates and sample data for initializing high-throughput sequencing and cheminformatics analysis environments. Use when user asks to initialize a project directory, list available workflow templates, or generate a starting environment for RNA-Seq, ChIP-Seq, variant calling, or single-cell analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html
---

# bioconductor-systempiperdata

## Overview

The `systemPipeRdata` package is a data companion to the `systemPipeR` workflow management ecosystem. Its primary purpose is to provide a collection of pre-configured workflow templates and their associated sample data. These templates allow users to quickly initialize complex analysis environments for various high-throughput sequencing (HTS) and cheminformatics applications.

## Core Workflow Initialization

The central function of this package is `genWorkenvir()`. It creates a directory structure populated with the necessary files to run a specific workflow.

### Initializing a Project
To start a new project, choose a workflow template and specify a directory name:

```r
library(systemPipeRdata)

# List available workflows
# Options include: "rnaseq", "chipseq", "varseq", "riboseq", "scrnaseq", "SPblast", "SPcheminfo", "new"
genWorkenvir(workflow = "rnaseq", mydirname = "my_rnaseq_project")

# Move into the new project directory
setwd("my_rnaseq_project")
```

### Available Templates
- **rnaseq**: Standard RNA-Seq differential expression workflow.
- **chipseq**: ChIP-Seq peak calling and annotation.
- **varseq**: Variant calling (GATK/BCFtools) workflow.
- **riboseq**: Ribosome profiling analysis.
- **scrnaseq**: Single-cell RNA-Seq (Seurat-based) analysis.
- **SPblast**: Sequence similarity searching using BLAST.
- **SPcheminfo**: Small molecule structural similarity and clustering.
- **new**: A generic "skeleton" template for building custom workflows.

## Typical Workflow Integration

Once the environment is generated, the project is typically managed using `systemPipeR`.

1.  **Initialize Project**: Use `SPRproject()` to create the workflow management container.
2.  **Import Workflow**: Use `importWF()` to load the steps defined in the template's `.Rmd` file.
3.  **Execute**: Use `runWF()` to process the steps.

```r
library(systemPipeR)
sal <- SPRproject()
sal <- importWF(sal, file_path = "systemPipeRNAseq.Rmd")
sal <- runWF(sal)
```

## Usage Tips

- **Template Customization**: The generated `.Rmd` file (e.g., `systemPipeRNAseq.Rmd`) is intended to be edited. Users should modify the text to describe their specific experiment and update code chunks if custom parameters are needed.
- **Data Directory**: By default, templates look for input data in the `./data/` subdirectory and write results to `./results/`.
- **Targets File**: Most templates include a `targets.txt` file in the `./data/` directory. This file defines the experimental design and maps sample names to raw data files. To use custom data, update this file first.
- **Testing**: The templates come with "toy" datasets. This allows users to verify their local installation and software paths (like Bowtie2 or Samtools) before running on full-scale data.

## Reference documentation

- [BLAST Workflow Template](./references/SPblast.md)
- [Cheminformatics Drug Similarity Template](./references/SPcheminfo.md)
- [Single Cell RNAseq Workflow](./references/SPscrna.md)
- [Generic Workflow Template](./references/new.md)
- [ChIP-Seq Workflow Template](./references/systemPipeChIPseq.md)
- [RIBO-Seq Workflow Template](./references/systemPipeRIBOseq.md)
- [RNA-Seq Workflow Template](./references/systemPipeRNAseq.md)
- [VAR-Seq Workflow Template](./references/systemPipeVARseq.md)
- [systemPipeRdata Main Vignette](./references/systemPipeRdata.md)