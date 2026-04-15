---
name: bioconductor-flames
description: FLAMES is an integrated pipeline for analyzing long-read RNA-seq data to identify and quantify isoforms in single-cell or bulk experiments. Use when user asks to perform full-length isoform analysis, demultiplex long-read single-cell data, or generate isoform-level expression matrices from raw fastq files.
homepage: https://bioconductor.org/packages/release/bioc/html/FLAMES.html
---

# bioconductor-flames

## Overview
FLAMES (Full-Length Analysis of Mutations and Isoforms in Single cells) is an integrated pipeline for long-read RNA-seq analysis. It automates the transition from raw fastq files to quantified isoform-level expression matrices. The package supports single-cell, multi-sample single-cell, and bulk experiments, producing standard Bioconductor objects (`SingleCellExperiment` or `SummarizedExperiment`) for downstream analysis.

## Typical Workflow

### 1. Initialize the Pipeline
Create a pipeline object based on the experiment type. You must provide a configuration file, input fastq, reference genome (FASTA), and annotation (GTF/GFF3).

```r
library(FLAMES)

# Create configuration
config <- create_config(
  outdir = "results_dir",
  pipeline_parameters.demultiplexer = "flexiplex" # or "blaze"
)

# Initialize Single-Cell Pipeline
pipeline <- SingleCellPipeline(
  config_file = config,
  outdir = "results_dir",
  fastq = "reads.fastq.gz",
  annotation = "ref.gtf",
  genome_fa = "genome.fa",
  barcodes_file = "whitelist.tsv" # Optional: known barcodes
)
```

### 2. Execute the Pipeline
The pipeline consists of several steps: demultiplexing, alignment, gene quantification, isoform identification, realignment, and transcript quantification.

*   **Full Run:** `pipeline <- run_FLAMES(pipeline)`
*   **Resume after Error:** If a step fails, fix the issue and use `pipeline <- resume_FLAMES(pipeline)`.
*   **Run Specific Step:** `pipeline <- run_step(pipeline, "genome_alignment")`

### 3. Access Results
Once completed, the results are stored within the pipeline object.

```r
# Extract the SingleCellExperiment or SummarizedExperiment object
sce <- experiment(pipeline)

# View counts
counts(sce)
```

## Visualization and QC
FLAMES provides built-in functions to assess the quality of the run, particularly for demultiplexing.

```r
# Generate QC plots (knee plots, edit distance, etc.)
qc_plots <- plot_demultiplex(pipeline)
qc_plots$knee_plot
qc_plots$reads_count_plot
```

## HPC and Parallelization
FLAMES integrates with the `crew` and `crew.cluster` packages to offload heavy computational steps (like alignment) to HPC schedulers (e.g., Slurm).

```r
# Assign a local controller to all steps
controllers(pipeline) <- crew::crew_controller_local(workers = 4)

# Or assign specific resources to a single step
controllers(pipeline)[["genome_alignment"]] <- crew::crew_controller_local(workers = 8)
```

## Usage Tips
*   **Windows Support:** FLAMES is currently unavailable on Windows due to dependencies on `minimap2` and `pysam`. Use Linux or macOS.
*   **Configuration:** Use `create_config()` to fine-tune parameters for demultiplexing (edit distance) and alignment.
*   **Memory Management:** Alignment and isoform identification are memory-intensive. When using HPC controllers, ensure sufficient memory is requested for the `genome_alignment` and `isoform_identification` steps.

## Reference documentation
- [FLAMES Vignette](./references/FLAMES_vignette.md)