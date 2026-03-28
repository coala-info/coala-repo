---
name: vclust
description: vclust is a high-performance alignment-based tool optimized for clustering and classifying viral genomes using LZ-ANI similarity measures. Use when user asks to prefilter genome pairs, calculate ANI or intergenomic similarity, cluster sequences into viral OTUs, or dereplicate redundant viral sequences.
homepage: https://github.com/refresh-bio/vclust
---

# vclust

## Overview
vclust is a high-performance alignment-based tool specifically optimized for viral genomics. It leverages Lempel-Ziv-based pairwise alignment (LZ-ANI) to provide the accuracy of BLASTn with significantly higher throughput. It is designed to handle millions of sequences, making it ideal for large-scale metagenomic studies where traditional alignment tools are computationally prohibitive. The tool follows international standards (ICTV and MIUViG) for viral classification and clustering.

## Core Workflow
The standard vclust pipeline consists of three sequential steps: prefiltering, alignment, and clustering.

### 1. Prefiltering
Identify similar genome pairs to avoid unnecessary all-vs-all alignments.
```bash
vclust prefilter -i input_genomes.fna -o filter_results.txt
```
*   **Tip**: For very large datasets, use `--parts` to split the workload or adjust `--min-kmers` (default 20) to balance sensitivity and speed.

### 2. Alignment
Calculate precise similarity measures for the filtered pairs.
```bash
vclust align -i input_genomes.fna --filter filter_results.txt -o ani_measures.tsv
```
*   **Measures calculated**: ANI, Global ANI (gANI), Total ANI (tANI/VIRIDIC-like), and Coverage.
*   **Optimization**: Use `--threads` to utilize multi-core processors.

### 3. Clustering
Group sequences based on a specific metric and threshold.
```bash
vclust cluster -i ani_measures.tsv --ids ani_measures.ids.tsv -o clusters.tsv --metric ani --ani 0.95
```
*   **Supported Algorithms**: Single-linkage, Complete-linkage, UCLUST, CD-HIT, Greedy set cover, and Leiden.

## Common CLI Patterns

### Viral OTU (vOTU) Assignment
Following MIUViG standards (95% ANI over 85% coverage):
```bash
vclust cluster -i ani.tsv --ids ani.ids.tsv --metric ani --ani 0.95 --cov 0.85 -o votus.tsv
```

### Dereplication
To remove redundant sequences and keep representative genomes:
```bash
vclust deduplicate -i input.fna -o unique_genomes.fna
```

### Species and Genus Classification (ICTV)
*   **Species**: Typically 95% ANI.
*   **Genus**: Typically 70% ANI (or tANI/intergenomic similarity).
```bash
vclust cluster -i ani.tsv --ids ani.ids.tsv --metric tani --ani 0.70 -o genera.tsv
```

## Best Practices
*   **Memory Management**: If running out of memory during the `align` phase, ensure you are using the latest version (v1.2.4+) which includes optimized memory handling for LZ-ANI.
*   **Sensitivity**: If you suspect missing clusters in highly divergent groups, decrease the `--min-kmers` value in the `prefilter` step, though this will increase computation time.
*   **Input Format**: Ensure input FASTA files have unique headers. vclust relies on these identifiers across the pipeline stages.
*   **Metric Selection**: Use `tani` for intergenomic similarity consistent with VIRIDIC, which is the preferred metric for many viral taxonomic applications.



## Subcommands

| Command | Description |
|---------|-------------|
| vclust deduplicate | Output FASTA file with unique, nonredundant sequences, removing duplicates and their reverse complements |
| vclust prefilter | vclust prefilter |
| vclust_align | Align genome pairs |
| vclust_cluster | Cluster genomes based on ANI metrics. |

## Reference documentation
- [Vclust User Guide](./references/github_com_refresh-bio_vclust_wiki.md)
- [Features and Similarity Measures](./references/github_com_refresh-bio_vclust_wiki_1-Features.md)
- [Usage and Command Reference](./references/github_com_refresh-bio_vclust_wiki_4-Usage.md)
- [Use Cases and Standards](./references/github_com_refresh-bio_vclust_wiki_6-Use-cases.md)