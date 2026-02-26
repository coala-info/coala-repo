---
name: physlr
description: Physlr is a bioinformatics toolset that uses linked-read data to construct physical maps and improve genome assembly quality through scaffolding. Use when user asks to generate a physical map from linked reads, scaffold a draft assembly, or evaluate the quality of a physical map against a reference genome.
homepage: https://github.com/bcgsc/physlr
---


# physlr

## Overview

Physlr is a bioinformatics toolset designed to leverage the long-range information inherent in linked reads to improve genome assembly quality. It operates in two primary modes: constructing a physical map from scratch and using that map to scaffold existing draft assemblies. By identifying shared barcodes across genomic regions, it builds "backbones" that represent the physical structure of the genome, which can then be used to bridge gaps and orient contigs in a draft assembly to reach chromosome-level contiguity.

## Installation and Setup

The most reliable way to install Physlr is via Conda to ensure all C++ and Python dependencies are correctly linked.

```bash
conda install -c bioconda physlr
```

### Performance Optimization
Physlr is computationally intensive. For significant speed improvements, it is highly recommended to use **pypy3** instead of the standard CPython interpreter.

1. Install pypy: `conda install -c conda-forge pypy3.8`
2. Execute Physlr with the pypy flag:
   ```bash
   physlr [COMMAND] python_executable=pypy3
   ```

## Common Workflows

### 1. Generating a Physical Map
To build a physical map from linked reads, you must specify the input reads and the sequencing protocol used.

*   **10X Genomics:**
    ```bash
    physlr physical-map lr=linkedreads.fq.gz protocol=10x
    ```
*   **MGI stLFR:**
    ```bash
    physlr physical-map lr=linkedreads.fq.gz protocol=stlfr
    ```

### 2. Scaffolding a Draft Assembly
To improve an existing assembly (`draft.fa`), use the `scaffolds` command. This integrates the physical map construction and the scaffolding process.

```bash
physlr scaffolds lr=linkedreads.fq.gz draft=draft.fa protocol=10x
```

### 3. Quality Evaluation
If a high-quality reference genome is available for the same or a related species, you can evaluate the physical map's correctness and contiguity.

*   **Integrated Evaluation:** Add `ref=reference.fa` to the `physical-map` command.
*   **Standalone Evaluation:**
    ```bash
    physlr map-quality lr=linkedreads.fq.gz ref=reference.fa
    ```

## Expert Tips and Best Practices

*   **Memory Management:** Physlr relies on `ntCard` and `ntHits`. Ensure your environment has sufficient RAM for k-mer counting, especially for large eukaryotic genomes.
*   **Protocol Defaults:** Always specify `protocol=`. This sets internal heuristics for barcode processing that are specific to the chemistry of 10X or stLFR.
*   **Output Interpretation:**
    *   `*.physical-map.path`: Contains the barcode backbones.
    *   `*.physlr.fa`: The final scaffolded assembly.
    *   `*.map-quality.tsv`: Assembly-like metrics (N50, etc.) for the physical map itself.
*   **Parallelization:** Use the `pigz` utility if available to speed up the processing of compressed fastq files.

## Reference documentation

- [Physlr GitHub Repository](./references/github_com_bcgsc_physlr.md)
- [Physlr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_physlr_overview.md)