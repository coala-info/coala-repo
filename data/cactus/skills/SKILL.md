---
name: cactus
description: Cactus is a high-performance genomic alignment framework that creates reference-free alignments and pangenome graphs using Cactus graphs. Use when user asks to perform inter-species evolutionary alignments, construct pangenome graphs from multiple genomes of the same species, or generate HAL files.
homepage: https://github.com/ComparativeGenomicsToolkit/cactus
---


# cactus

## Overview
Cactus is a high-performance genomic alignment framework that utilizes "Cactus graphs" to represent complex structural relationships between genomes without relying on a single reference sequence. It is the standard tool for creating Hierarchical Alignment Format (HAL) files. The toolkit is divided into two primary workflows: Progressive Cactus, designed for aligning genomes from different species to study evolution, and Minigraph-Cactus, optimized for aligning genomes of the same species to construct pangenome graphs.

## Core CLI Workflows

### Progressive Cactus (Inter-species Alignment)
Use this for evolutionary studies across different species. It requires a Newick-formatted tree to guide the alignment.

```bash
cactus <jobStore> <seqFile> <outputHal>
```
*   **jobStore**: A path to a directory where intermediate files are stored. This directory must not exist before starting.
*   **seqFile**: A text file containing the guide tree and paths to the input FASTA files.
*   **outputHal**: The resulting alignment in HAL format.

### Minigraph-Cactus (Pangenome Construction)
Use this for intra-species analysis to create pangenome graphs (GFA/VCF).

```bash
cactus-pangenome <jobStore> <seqFile> --outDir <outputDir> --outName <pangenomeName> --reference <refName>
```
*   **--reference**: Specifies the genome(s) to use as the "path" or backbone in the graph.
*   **--outDir**: Directory where GFA, VCF, and other graph-related outputs will be saved.

### Format Conversion and Extraction
Cactus alignments are typically stored in HAL format. Use these sub-tools to extract data:

*   **HAL to MAF**: `cactus-hal2maf <jobStore> <halFile> <outputMaf>`
*   **HAL to FASTA**: `hal2fasta <halFile> <genomeName>`

## Expert Tips and Best Practices

### Execution Modes
Cactus relies on many sub-dependencies (LastZ, abPOA, etc.). Manage these using the `--binariesMode` flag:
*   **local**: Uses binaries found in your system PATH.
*   **docker**: Automatically pulls and runs the official Cactus Docker image (requires Docker).
*   **singularity**: Uses Singularity containers (ideal for HPC environments).

### Resource Management
Cactus uses the Toil workflow engine. For large alignments, manage resources and logging:
*   **Cleanup**: If a run fails, you must delete the `<jobStore>` directory before restarting.
*   **Restarting**: Use the `--restart` flag if a job was interrupted and the jobStore is still intact.
*   **GPU Acceleration**: If using the GPU-enabled version (KegAlign), ensure `CACTUS_DOCKER_TAG` is set to a `-gpu` version.

### Input Preparation (seqFile)
The `seqFile` is a simple text format:
```text
# Guide tree in Newick format (required for Progressive Cactus)
((human:0.006,chimp:0.006):0.01,gorilla:0.02);

# Genome names and paths
human /path/to/human.fa
chimp /path/to/chimp.fa
gorilla /path/to/gorilla.fa
```

## Reference documentation
- [Cactus GitHub Repository](./references/github_com_ComparativeGenomicsToolkit_cactus.md)
- [Bioconda Cactus Overview](./references/anaconda_org_channels_bioconda_packages_cactus_overview.md)