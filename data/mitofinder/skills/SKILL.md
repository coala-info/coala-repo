---
name: mitofinder
description: MitoFinder assembles mitochondrial genomes and annotates mitochondrial genes from sequencing data. Use when user asks to assemble mitochondrial genomes or annotate mitochondrial genes.
homepage: https://github.com/parklab/xTea
metadata:
  docker_image: "quay.io/biocontainers/mitofinder:1.4.1--py27h9801fc8_1"
---

# mitofinder

Pipeline for assembling mitochondrial genomes and annotating mitochondrial genes from trimmed sequencing data.
  Use when you need to process sequencing reads to reconstruct and analyze mitochondrial DNA.
---
## Overview

MitoFinder is a bioinformatics pipeline designed to assemble mitochondrial genomes and annotate their genes. It takes trimmed sequencing read data as input and outputs the assembled mitochondrial genome along with annotated genes. This tool is particularly useful for researchers studying mitochondrial DNA in various organisms.

## Usage

MitoFinder is typically installed via Conda from the bioconda channel.

### Installation

```bash
conda install bioconda::mitofinder
```

### Basic Usage

The primary command for running MitoFinder is `mitofinder`. While specific command-line arguments are not detailed in the provided documentation, the general workflow involves providing input sequencing data.

**General Command Structure (Illustrative - actual arguments may vary):**

```bash
mitofinder -1 <forward_reads.fastq.gz> -2 <reverse_reads.fastq.gz> -o <output_directory> -s <sample_name>
```

**Key Considerations:**

*   **Input Data:** Ensure your sequencing reads are trimmed and in a compatible format (e.g., gzipped FASTQ).
*   **Output Directory:** Specify a directory where MitoFinder will store its results.
*   **Sample Name:** Provide a unique identifier for your sample.

**Expert Tips:**

*   **Environment Management:** It is highly recommended to run MitoFinder within a dedicated Conda environment to manage dependencies effectively.
*   **Resource Allocation:** Mitochondrial genome assembly can be computationally intensive. Ensure you have sufficient CPU and memory resources available, especially for large datasets.
*   **Parameter Tuning:** If initial runs do not yield satisfactory results, consult the MitoFinder documentation (if available externally) for advanced parameters that might influence assembly quality or gene annotation.

## Reference documentation

- [MitoFinder Overview](https://anaconda.org/bioconda/mitofinder)