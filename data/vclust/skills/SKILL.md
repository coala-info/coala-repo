---
name: vclust
description: vclust is a high-performance tool for comparative analysis and clustering of viral genomes. Use when user asks to prefilter genome pairs, calculate ANI measures, cluster viral sequences, deduplicate genomes, assign vOTUs, or classify viral species and genus.
homepage: https://github.com/refresh-bio/vclust
---


# vclust

## Overview

vclust is a high-performance, alignment-based tool designed for the comparative analysis of viral genomes. It utilizes a specialized Lempel-Ziv-based pairwise sequence aligner (LZ-ANI) that provides the sensitivity of BLASTn while operating at much higher speeds. The tool is optimized for processing large-scale metagenomic datasets, allowing users to calculate various similarity measures (ANI, global ANI, total ANI) and apply multiple clustering algorithms to define viral populations or taxonomic groups.

## Core Workflow

The standard vclust pipeline consists of three sequential steps: prefiltering, alignment, and clustering.

### 1. Prefiltering
Before performing expensive pairwise alignments, use `prefilter` to identify potentially similar genome pairs using k-mer analysis.

```bash
vclust prefilter -i input_genomes.fna -o filter_results.txt
```

### 2. Alignment
Calculate precise ANI measures for the pairs identified in the prefilter step.

```bash
vclust align -i input_genomes.fna -o ani_measures.tsv --filter filter_results.txt
```

**Key Similarity Metrics (`--metric`):**
- `ani`: Identical nucleotides divided by alignment length.
- `gani`: Global ANI (divided by query/reference length).
- `tani`: Total ANI (equivalent to VIRIDIC intergenomic similarity).
- `cov`: Alignment fraction/coverage.

### 3. Clustering
Group sequences based on the calculated metrics and a specified threshold.

```bash
vclust cluster -i ani_measures.tsv -o clusters.tsv --ids ani_measures.ids.tsv --metric ani --ani 0.95
```

**Supported Algorithms (`--algorithm`):**
- `single-linkage`, `complete-linkage`
- `uclust`, `cd-hit` (Greedy incremental)
- `set-cover` (Greedy set cover)
- `leiden` (Requires optional installation)

## Common Tasks and Patterns

### Dereplication (Removing Redundancy)
To remove duplicate sequences within or between datasets:
```bash
vclust deduplicate -i input.fna -o unique_sequences.fna
```

### vOTU Assignment (MIUViG Standards)
To assign viral contigs into vOTUs (typically 95% ANI over 85% coverage):
1. Run `align` to get both `ani` and `cov`.
2. Run `cluster` with `--ani 0.95` and `--cov 0.85`.

### Species and Genus Classification (ICTV Standards)
- **Species**: Use a 95% ANI threshold.
- **Genus**: Use a 70% ANI threshold (or as defined by specific viral families).

## Expert Tips

- **Memory Optimization**: If running the `align` step on very large datasets, ensure you are using the latest version (v1.2.4+) which includes significant memory requirement reductions for the LZ-ANI submodule.
- **Sensitivity**: If you are missing expected similarities, adjust the `--min-kmers` parameter in the `prefilter` step. The default is 20.
- **Verification**: Use `vclust info` to verify the availability of submodule binaries (Kmer-db, LZ-ANI, Clusty) and ensure the environment is correctly configured.

## Reference documentation
- [vclust GitHub Repository](./references/github_com_refresh-bio_vclust.md)
- [vclust Wiki/User Guide](./references/github_com_refresh-bio_vclust_wiki.md)
- [Bioconda vclust Overview](./references/anaconda_org_channels_bioconda_packages_vclust_overview.md)