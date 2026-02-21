---
name: binsanity
description: BinSanity is a suite of scripts designed to transform metagenomic assemblies into high-quality bins.
homepage: https://github.com/edgraham/BinSanity
---

# binsanity

## Overview

BinSanity is a suite of scripts designed to transform metagenomic assemblies into high-quality bins. It distinguishes itself from other binners by using Affinity Propagation (AP), a deterministic clustering algorithm that automatically determines the optimal number of clusters. The tool follows a biphasic workflow: it initially clusters contigs based on coverage depth across samples and subsequently refines these clusters using sequence-based features like tetranucleotide frequencies and GC content. This dual-layer approach typically results in higher completeness and lower contamination for the resulting metagenome-assembled genomes (MAGs).

## Usage Guidance

### Core Workflow Selection
- **Standard Assemblies:** Use `Binsanity-wf` to run the full suite (clustering and refinement) sequentially.
- **Large Assemblies (>100,000 contigs):** Use `Binsanity-lc`. It implements a preliminary K-means step to reduce memory intensity before applying Affinity Propagation.
- **Modern/Automated Workflow:** Use `Binsanity2-beta`. This script merges the standard and large-scale workflows, automatically switching to K-means pre-clustering if the assembly exceeds 75,000 contigs.

### Common CLI Patterns

#### 1. Generating Coverage Profiles
Before binning, you must generate a coverage profile from your BAM files (alignments of reads to contigs).
```bash
Binsanity-profile -i [directory_containing_bam_files] -s [assembly_fasta] -o [output_directory]
```
*Note: This script utilizes featureCounts to calculate depth.*

#### 2. Running the Full Workflow
The most common entry point for users is the automated workflow script.
```bash
Binsanity-wf -f [assembly_fasta] -l [contig_list] -c [coverage_file] -o [output_directory]
```

#### 3. Refinement Only
If you have existing bins from another tool or an initial BinSanity run that need improvement based on composition:
```bash
Binsanity-refine -f [assembly_fasta] -l [contig_list] -c [coverage_file] -o [output_directory]
```

### Expert Tips and Best Practices
- **Deterministic Results:** Because BinSanity uses Affinity Propagation rather than K-means for its core clustering, results are stable across runs given the same input parameters.
- **Memory Management:** For very large datasets, always prefer `Binsanity2-beta` or `Binsanity-lc`. Affinity Propagation has $O(N^2)$ complexity, which can lead to high memory consumption on raw assemblies.
- **Input Preparation:** Ensure your contig names in the FASTA file match the names in the coverage profile exactly. Use the `Binsanity-profile` tool to minimize formatting errors.
- **Dependencies:** If installed via `pip` rather than `conda`, manually verify that `hmmer` and the `subread` package are in your PATH, as these are required for profiling and evaluation.

## Reference documentation
- [BinSanity Wiki](./references/github_com_edgraham_BinSanity_wiki.md)
- [BinSanity GitHub Overview](./references/github_com_edgraham_BinSanity.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_binsanity_overview.md)