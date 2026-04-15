---
name: mapsembler2
description: Mapsembler2 is a targeted sequence assembly tool that extends user-provided starter sequences into their local genomic neighborhood using NGS read sets. Use when user asks to perform targeted assembly, extend sequence starters, validate assembly gaps, or identify structural variants and SNPs within a specific sequence context.
homepage: https://colibread.inria.fr/software/mapsembler2/
metadata:
  docker_image: "quay.io/biocontainers/mapsembler2:2.2.4--2"
---

# mapsembler2

## Overview
Mapsembler2 is a specialized tool for targeted sequence assembly. Unlike de novo assemblers that attempt to reconstruct an entire genome, Mapsembler2 focuses on "starters"—user-provided sequences of interest. It indexes NGS read sets using an efficient de Bruijn graph structure and extends these starters into their local sequence neighborhood. This approach is highly efficient for validating assemblies, checking for specific SNPs or structural variants, and extending unmappable reads to find their genomic context.

## Usage Patterns and Best Practices

### Core Workflow
1.  **Input Preparation**: Gather your NGS raw reads (FASTA/FASTQ, can be gzipped) and your "starter" sequences (FASTA).
2.  **Indexing**: Mapsembler2 uses the Minia data structure for indexing. It reads the input files only once to build the graph, which is memory-efficient but requires a few Gigabytes of RAM.
3.  **Extension**: The tool extends the starters based on the read evidence.
4.  **Output Selection**: Choose between a linear sequence output (consensus) or a graph output (showing branching paths/variants).

### Common CLI Options and Tuning
*   **Memory Management**: By default, Mapsembler2 uses 4GB of memory. Ensure your environment has sufficient RAM for the Minia indexing process.
*   **K-mer Size**: The k-mer size is a critical parameter for assembly. While the default is often sufficient, larger k-mer values can be used to resolve repeats at the cost of sensitivity.
*   **Early Termination (`-m`)**: Use the `-m` option to stop the process earlier if no substarter is generated, which can save time in large-scale searches.
*   **Graph Constraints**: In version 2.1.5 and later, you can set the maximum graph depth and the maximum number of nodes to prevent the assembly from exploding in complex or repetitive regions.

### Expert Tips
*   **Metagenomics**: Mapsembler2 is particularly effective for checking if a known enzyme or gene is present in a metagenomic NGS read set without the computational overhead of a full metagenome assembly.
*   **Contig Extremities**: If you have a fragmented assembly, use the ends of your contigs as starters to see if Mapsembler2 can find overlapping reads to bridge gaps.
*   **Variant Detection**: By outputting the sequence neighborhood as a graph, you can visually or computationally inspect the presence of SNPs or splicing events (in RNA-seq) that appear as bubbles or branches in the graph.
*   **Visualization**: Use the "Graph of Sequence Viewer" (GSV) to inspect the output graphs. This is especially useful for understanding structural variations or complex splicing patterns.

## Reference documentation
- [Mapsembler2 - ANR Colib'read](./references/colibread_inria_fr_software_mapsembler2.md)
- [mapsembler2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mapsembler2_overview.md)