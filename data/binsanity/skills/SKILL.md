---
name: binsanity
description: BinSanity transforms metagenomic assemblies into putative genomes using unsupervised clustering based on coverage profiles and sequence composition. Use when user asks to bin metagenomic contigs, generate coverage profiles from BAM files, or refine genomic bins using tetranucleotide frequencies and GC content.
homepage: https://github.com/edgraham/BinSanity
---

# binsanity

## Overview

BinSanity is a suite of scripts designed to transform metagenomic assemblies into putative genomes through unsupervised clustering. Unlike many binners that require a pre-defined number of clusters (k), BinSanity utilizes Affinity Propagation (AP), a deterministic algorithm that identifies "exemplars" within the data to form clusters naturally. 

The tool employs a biphasic workflow: it initially clusters contigs based on coverage profiles across multiple samples and subsequently refines these clusters using tetranucleotide frequencies and GC content. This separation of coverage and composition metrics helps minimize the impact of horizontal gene transfer or varying evolutionary pressures on binning accuracy.

## Core Workflow and CLI Usage

### 1. Generating Coverage Profiles
Before binning, you must generate a coverage profile from your alignment files (BAM).
- **Tool**: `Binsanity-profile`
- **Function**: Uses `featureCounts` to calculate contig coverage across samples.
- **Requirement**: Requires the assembly FASTA and sorted BAM files.

### 2. Executing the Binning Workflow
For most standard datasets, use the automated workflow script.
- **Command**: `Binsanity-wf`
- **Process**: Runs `Binsanity` (coverage-based) followed by `Binsanity-refine` (composition-based) sequentially.

### 3. Handling Large Assemblies
Affinity Propagation is memory-intensive and scales linearly with the number of similarities. For assemblies exceeding 75,000–100,000 contigs:
- **Tool**: `Binsanity-lc` or `Binsanity2-beta`.
- **Strategy**: These tools use K-means to subset contigs into smaller groups based on coverage before applying the more intensive AP algorithm.
- **Tip**: Use `Binsanity2-beta` for modern datasets as it merges the workflows and automatically triggers K-means subsetting for assemblies larger than 75,000 contigs.

### 4. Post-Binning Evaluation and Sorting
After generating bins and running CheckM for quality assessment:
- **Command**: `checkm_analysis -checkM <checkm_qa_output> -f .fna`
- **Function**: Automatically sorts bins into subdirectories based on quality:
    - **High Completion**: >95% complete (<10% redundancy) or >80% complete (<5% redundancy).
    - **Low Completion**: <50% complete (<2% redundancy).
    - **High Redundancy**: Bins failing the contamination/redundancy thresholds.

## Expert Tips and Best Practices

- **Deterministic Results**: Because Affinity Propagation is deterministic, running the same command on the same dataset will yield identical results, unlike K-means which varies by initialization.
- **Memory Management**: If you encounter a `MemoryError` or "Unable to allocate GiB" error, your assembly is too large for the standard `Binsanity` script. Switch to `Binsanity-lc` or increase the contig length cutoff during assembly/preprocessing to reduce the total contig count.
- **Refinement Parameters**: `Binsanity-refine` can optionally incorporate the coverage profile again during the composition phase. This is recommended if the initial coverage-based clusters appear over-split.
- **Evaluation**: If you have a "gold standard" or reference set for your environment, use `bin_evaluation` to calculate Precision, Recall, and V-measure (the harmonic mean of precision and recall) to tune your parameters.



## Subcommands

| Command | Description |
|---------|-------------|
| Binsanity-lc | Binsanity-lc is a workflow script that will subset assemblies larger than 100,000 contigs using coverage prior to running Binsanity and Binsanity-refine sequentially. |
| Binsanity-lc | Binsanity2 is a workflow script that will subset assemblies using kmeans and subsequently binning the resultant clusters of contigs using coverage and affinity propagation (AP) followed by a compositional based refinement. |
| Binsanity-profile | Binsanity-profile is used to generate coverage files for input to BinSanity. This uses Featurecounts to generate a a coverage profile and transforms data for input into Binsanity, Binsanity-refine, and Binsanity-wf |
| Binsanity-refine | Binsanity-refine uses combined coverage and composition (in the form of tetramer frequencies and GC%) to cluster contigs. The published workflow uses this to refine bins initially clustered soley on coverage. Binsanity-refine can be used as a stand alone script if you don't have more than 2 sample replicates |
| Binsanity-wf | Binsanity-wf is a workflow script that runs Binsanity and Binsanity-refine sequentially. |

## Reference documentation
- [BinSanity Wiki Home](./references/github_com_edgraham_BinSanity_wiki.md)
- [Bin Evaluation and CheckM Analysis](./references/github_com_edgraham_BinSanity_wiki_Bin-Evaluation.md)
- [FAQ and Memory Requirements](./references/github_com_edgraham_BinSanity_wiki_FAQ.md)