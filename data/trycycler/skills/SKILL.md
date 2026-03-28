---
name: trycycler
description: Trycycler is a consensus long-read meta-assembler that reconciles multiple independent bacterial genome assemblies into a single structurally accurate consensus. Use when user asks to generate a consensus assembly from multiple inputs, reconcile circular replicons, or cluster and partition long reads for bacterial genome finishing.
homepage: https://github.com/rrwick/Trycycler
---


# trycycler

## Overview
Trycycler is a consensus long-read assembler specifically designed for bacterial genomes. Rather than attempting to be a standalone assembler, it acts as a "meta-assembler" that reconciles multiple independent assembly inputs (from different tools or read subsets) into a single, structurally accurate consensus. It is particularly effective at handling the "start-end" overlap problems common in circular replicons and ensuring that every plasmid and chromosome is correctly represented.

## Core Workflow and CLI Patterns

The Trycycler pipeline follows a specific sequence of commands. You must complete each step before moving to the next.

### 1. Clustering
Group contigs from all input assemblies into clusters representing individual replicons.
```bash
trycycler cluster --reads reads.fastq.gz --assemblies assemblies/*.fasta --out_dir trycycler_out
```
*   **Expert Tip**: Inspect the generated `cluster.txt` and the phylogenetic tree. If the tree is messy or clusters are fragmented, your input assemblies may be of poor quality.

### 2. Reconciling
Standardize the contigs within a cluster (orientation, starting position, and circularization).
```bash
trycycler reconcile --reads reads.fastq.gz --cluster_dir trycycler_out/cluster_001
```
*   **Note**: This step fixes the common issue where different assemblers start a circular contig at different positions or leave redundant overlaps at the ends.

### 3. Multiple Sequence Alignment (MSA)
Perform alignment of the reconciled sequences to identify variants.
```bash
trycycler msa --cluster_dir trycycler_out/cluster_001
```

### 4. Partitioning
Assign the original long reads to the specific clusters they belong to.
```bash
trycycler partition --reads reads.fastq.gz --cluster_dirs trycycler_out/cluster_*
```

### 5. Consensus Generation
Generate the final consensus sequence for the replicon.
```bash
trycycler consensus --cluster_dir trycycler_out/cluster_001
```

## Best Practices for High-Quality Assemblies

### Input Diversity
To get the most out of Trycycler, provide diverse inputs. A common "Great Dataset" strategy involves:
*   Generating ~12 assemblies total.
*   Using multiple assemblers (e.g., Flye, Raven, and Miniasm/Minipolish).
*   Using different random subsamples of reads (e.g., 80-90% of the data) for each assembly run.

### Read Depth Requirements
*   **Minimum**: 10-25x depth is required for a complete assembly, but accuracy will be low.
*   **Recommended**: 50x depth is the "sweet spot" for reliable structural assembly.
*   **Maximum Benefit**: Up to 250x depth is beneficial if you plan to perform Medaka polishing after Trycycler.

### Post-Trycycler Polishing
Trycycler is designed to fix structural and medium-scale errors. It does not fix systematic small-scale errors (like homopolymer indels). Always follow Trycycler with:
1.  **Long-read polishing**: Use Medaka on the Trycycler consensus.
2.  **Short-read polishing**: Use Polypolish or Pilon if Illumina data is available.

### Handling "Bad" Clusters
If `trycycler cluster` produces dozens of small clusters or a "hideous" tree, do not proceed. This usually indicates:
*   Insufficient read length (reads shorter than the longest repeat).
*   Poor basecalling quality.
*   Contamination in the sample.



## Subcommands

| Command | Description |
|---------|-------------|
| dotplot | draw pairwise dotplots for a cluster |
| trycycler cluster | cluster contigs by similarity |
| trycycler msa | multiple sequence alignment |
| trycycler partition | partition reads by cluster |
| trycycler reconcile | reconcile contig sequences |
| trycycler subsample | subsample a long-read set |
| trycycler_consensus | derive a consensus sequence |

## Reference documentation
- [Trycycler Wiki Home](./references/github_com_rrwick_Trycycler_wiki.md)
- [How to run Trycycler](./references/github_com_rrwick_Trycycler_wiki_How-to-run-Trycycler.md)
- [Accuracy vs Depth Study](./references/github_com_rrwick_Trycycler_wiki_Accuracy-vs-depth.md)
- [Clustering Contigs Guide](./references/github_com_rrwick_Trycycler_wiki_Clustering-contigs.md)
- [Polishing after Trycycler](./references/github_com_rrwick_Trycycler_wiki_Polishing-after-Trycycler.md)