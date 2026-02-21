---
name: blockclust
description: BlockClust is a specialized bioinformatics tool designed to detect transcripts with similar processing patterns.
homepage: https://github.com/pavanvidem/blockclust
---

# blockclust

## Overview

BlockClust is a specialized bioinformatics tool designed to detect transcripts with similar processing patterns. It encodes expression profiles into compact discrete structures, which are then processed using fast graph-kernel techniques. This approach allows for both the unsupervised clustering of novel ncRNAs and the supervised classification of known ncRNA families. The tool typically operates in a three-stage workflow: pre-processing raw alignments, performing the core clustering/classification, and generating post-processing visualizations.

## Installation and Setup

Install blockclust via Bioconda to ensure all dependencies (including C++ binaries and R dependencies) are correctly configured:

```bash
conda install -c bioconda blockclust
```

## Command Line Usage

The tool is primarily accessed through the `blockclust.py` master script. It supports three distinct operating modes.

### 1. Pre-processing Mode
Converts mapped reads into a BED file of tags with expression values.
- **Input**: Binary Sequence Alignment Map (BAM) file.
- **Output**: BED file of tags.

### 2. Clustering and Classification Mode
The core engine that groups transcripts based on similarity.
- **Prerequisite**: You must first run the `blockbuster` tool on your data to generate a "blockgroups" file.
- **Input**: 
  - Blockgroups file (from blockbuster).
  - Reference genome selection.
- **Outputs**:
  - Hierarchical clustering plot (PDF/PNG).
  - Pairwise similarity matrix.
  - BED file containing predicted clusters.
  - BED file containing SVM-based classifications.

### 3. Post-processing Mode
Generates visual overviews and annotations for the predicted clusters.
- **Input**: 
  - Predicted clusters (BED).
  - Pairwise similarities.
  - Rfam search results (cmsearch output) to annotate clusters.
- **Outputs**:
  - Distribution plots of ncRNA families per cluster.
  - Centroid-based hierarchical clustering of predicted clusters.

## Best Practices and Expert Tips

- **Complete Workflow**: For the most accurate results, always use the full three-mode workflow rather than running clustering in isolation. The pre-processing step ensures expression profiles are encoded correctly for the graph-kernel.
- **Blockbuster Integration**: BlockClust relies on `blockbuster` to define the initial blocks of reads. Ensure your blockbuster parameters (like distance and min-height) are tuned to your specific RNA-seq library depth before passing the output to BlockClust.
- **Reference Genomes**: Ensure the reference genome used in the clustering mode matches the one used for the initial BAM alignment to avoid coordinate mismatches.
- **Rfam Annotation**: To get biological meaning from your clusters in the post-processing phase, you must run `cmsearch` (from the INFERNAL suite) against the Rfam database using the cluster sequences. BlockClust uses this external data to calculate cluster precision and family distribution.
- **Memory Management**: While the graph-kernel technique is efficient, processing very large similarity matrices during the clustering of thousands of blockgroups can be memory-intensive. Monitor RAM usage when working with whole-transcriptome datasets.

## Reference documentation
- [blockclust - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_blockclust_overview.md)
- [GitHub - pavanvidem/blockclust](./references/github_com_pavanvidem_blockclust.md)