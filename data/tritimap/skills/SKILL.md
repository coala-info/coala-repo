---
name: tritimap
description: Triti-Map is a bioinformatics pipeline for gene mapping, causal variant identification, and novel gene discovery in Triticeae genomes. Use when user asks to 'map genes', 'identify causal variants', 'discover novel genes', or 'perform bulk-segregant analysis'.
homepage: https://github.com/fei0810/Triti-Map
---


# tritimap

## Overview
Triti-Map is a specialized bioinformatics pipeline designed to handle the unique challenges of gene mapping in the large and complex genomes of the Triticeae tribe. It automates the transition from raw sequencing data—such as WGS, ChIP-Seq, or RNA-Seq—to the identification of causal variants and novel genes. By leveraging Snakemake, it provides a reproducible workflow for bulk-segregant analysis (BSA) and the discovery of functional elements that may be absent from standard reference genomes.

## Core CLI Usage

### Initialization
Before running the pipeline, initialize the working directory to generate the necessary metadata templates.
- `tritimap init`: Generates configuration templates in the current directory.
- `tritimap init -d /path/to/work`: Generates templates in a specific target directory.

### Execution
The pipeline is executed using the `run` command with a specified number of threads and a target module.
- `tritimap run -j 30 all`: Executes both the Interval Mapping and Assembly modules.
- `tritimap run -j 30 only_mapping`: Identifies trait association intervals and mutations only.
- `tritimap run -j 30 only_assembly`: Identifies trait-associated new genes only.

## Workflow Best Practices

### 1. Pre-processing Requirements
Triti-Map requires specific indices to be built manually before execution. Ensure the following are prepared:
- **GATK/Samtools**: Create a sequence dictionary and `.fai` index for your reference genome.
- **DNA-Seq**: Build indices using `bwa-mem2`.
- **RNA-Seq**: Build indices using `STAR` (ensure `--sjdbGTFfile` and memory limits are correctly set for large wheat genomes).

### 2. Metadata Configuration
After running `init`, you must populate the generated CSV files:
- **sample.csv**: Define your sample names and sequencing file paths.
- **region.csv**: Specify chromosome regions to filter raw results (essential when running the Assembly Module independently).

### 3. Execution Management
- **Long-running Processes**: Triticeae gene mapping can take 24–48 hours. Always execute the pipeline within a terminal multiplexer like `GNU Screen` or `tmux` to prevent session disconnection.
- **Resource Allocation**: Use the `-j` flag to match the available CPU cores on your high-performance computing (HPC) node.

### 4. Result Interpretation
The pipeline outputs results into a structured `results/` directory:
- `03_mappingout`: Primary alignment and mapping statistics.
- `05_vcfout`: Variant calling results for mutation identification.
- `06_regionout`: Filtered genomic regions of interest.
- `07_assembleout`: De novo assembly results for novel gene discovery.

## Reference documentation
- [Triti-Map Main Repository](./references/github_com_fei0810_Triti-Map.md)
- [Triti-Map Wiki Home](./references/github_com_fei0810_Triti-Map_wiki.md)