---
name: metawrap
description: metaWRAP is a comprehensive wrapper suite that streamlines metagenomic workflows from raw read processing and assembly to bin refinement and reassembly. Use when user asks to process metagenomic reads, assemble contigs, perform taxonomic profiling, run multiple binning algorithms, or refine and reassemble genomic bins.
homepage: https://github.com/bxlab/metaWRAP
---


# metawrap

## Overview

metaWRAP is a comprehensive wrapper suite designed to streamline the transition from raw metagenomic sequencing data to refined, annotated draft genomes. It organizes complex bioinformatic workflows into standalone modules for read processing, assembly, binning, and visualization. 

The core strength of metaWRAP lies in its "bin refinement" and "reassemble bins" modules. Unlike standard pipelines that rely on a single binning algorithm, metaWRAP utilizes a hybrid approach to consolidate predictions from multiple binners (like metaBAT2, MaxBin2, and CONCOCT), significantly improving the completion and purity of the resulting genomic bins.

## Core Workflows and CLI Patterns

### 1. Read Pre-processing (read_qc)
Use this module to trim adapters and remove host contamination (e.g., human reads).
```bash
metawrap read_qc -1 raw_1.fastq -2 raw_2.fastq -t 24 -o READ_QC_DIR
```
*   **Tip**: Use `-x` to specify a non-human host genome index if working with other model organisms.
*   **Tip**: Use `--skip-bmtagger` if you only require quality trimming and not host removal.

### 2. Metagenomic Assembly (assembly)
Supports metaSPAdes and MegaHit.
```bash
metawrap assembly -1 reads_1.fastq -2 reads_2.fastq -m 200 -t 96 --use-metaspades -o ASSEMBLY_DIR
```
*   **Expert Tip**: Use `--use-metaspades` for higher quality assemblies in most environments. Switch to `--use-megahit` for extremely large datasets where memory efficiency is critical.

### 3. Taxonomic Profiling (kraken)
Provides a quick overview of community composition using Kraken/Kraken2 and Krona.
```bash
metawrap kraken -o KRAKEN_DIR -t 96 -s 1000000 reads_1.fastq reads_2.fastq assembly.fasta
```
*   **Tip**: The `-s` flag subsets reads to speed up the run; 1 million reads is usually sufficient for a representative profile.

### 4. Genomic Binning (binning)
Runs multiple binning algorithms simultaneously to prepare for refinement.
```bash
metawrap binning -a assembly.fasta -o BINNING_DIR -t 48 --metabat2 --maxbin2 --concoct reads_*.fastq
```
*   **Note**: Providing reads from multiple samples improves binning performance by utilizing differential coverage.

### 5. Bin Refinement (bin_refinement)
The most critical step for high-quality MAGs. It compares and merges bin sets.
```bash
metawrap bin_refinement -o REFINED_DIR -t 48 -A BINNING_DIR/metabat2_bins -B BINNING_DIR/maxbin2_bins -C BINNING_DIR/concoct_bins -c 50 -x 10
```
*   **Parameters**: `-c 50` sets minimum completion (%); `-x 10` sets maximum contamination (%).
*   **Scoring**: metaWRAP uses the formula `Score = Completion - 5*Contamination` to pick the best version of a bin.

### 6. Bin Reassembly (reassemble_bins)
Improves N50 and completion by reassembling reads belonging to specific bins.
```bash
metawrap reassemble_bins -o REASSEMBLED_DIR -1 reads_1.fastq -2 reads_2.fastq -t 48 -b REFINED_DIR/metawrap_50_10_bins
```

## Expert Tips and Best Practices

*   **System Resources**: Metagenomic assembly and Kraken profiling are memory-intensive. Ensure at least 64GB of RAM is available; 128GB+ is recommended for large co-assemblies.
*   **Co-assembly vs. Single-sample**: For analyzing communities across multiple samples, co-assemble the reads (concatenate them first) to recover low-abundance organisms that might not assemble in a single sample.
*   **Database Configuration**: Ensure the `config-metawrap` file is correctly edited to point to your local databases (CheckM, NCBI_nt, Kraken, etc.) before running downstream analysis modules.
*   **Mamba for Speed**: When installing or updating dependencies, use `mamba` instead of `conda` to resolve environments significantly faster.



## Subcommands

| Command | Description |
|---------|-------------|
| bin_refinement | Refine metagenomic bins from multiple sources. |
| binning | Binning module for metagenomic assemblies |
| kraken | Run on any number of fasta assembly files and/or or paired-end reads. |
| metawrap annotate_bins | Annotates metagenomic bins. |
| metawrap assembly | Assemble reads into contigs |
| metawrap blobology | Run blobology on assembly and reads |
| metawrap classify_bins | Classify bins |
| metawrap quant_bins | Quantify abundance of bins in metagenomic datasets |
| read_qc | Performs quality control on raw sequencing reads. |
| reassemble_bins | Reassemble metagenomic bins using provided reads. |

## Reference documentation
- [MetaWRAP Module Descriptions](./references/github_com_bxlab_metaWRAP_blob_master_Module_descriptions.md)
- [MetaWRAP Usage Tutorial](./references/github_com_bxlab_metaWRAP_blob_master_Usage_tutorial.md)
- [MetaWRAP README](./references/github_com_bxlab_metaWRAP_blob_master_README.md)