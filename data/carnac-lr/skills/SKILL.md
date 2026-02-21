---
name: carnac-lr
description: CARNAC-LR (Clustering coefficient-based Acquisition of RNA Communities in Long Reads) is a tool designed to cluster long-read RNA sequences into groups representing distinct transcripts or gene families.
homepage: https://github.com/kamimrcht/CARNAC-LR
---

# carnac-lr

## Overview
CARNAC-LR (Clustering coefficient-based Acquisition of RNA Communities in Long Reads) is a tool designed to cluster long-read RNA sequences into groups representing distinct transcripts or gene families. It utilizes a clustering coefficient-based approach to handle the high error rates and chimeric reads often found in long-read sequencing data. The workflow typically involves generating read overlaps with minimap2, converting those overlaps into a specific input format, and then running the clustering algorithm to produce groups of read indices.

## Installation and Environment Setup
Install via Bioconda for the most stable environment:
```bash
conda install bioconda::carnac-lr
```

If building from source, ensure C++11 and GCC 4.9+ (or Clang 3.9+) are available. For macOS users, the `-fopenmp` flag must be removed from the Makefile if using a Clang version that does not support OpenMP, though this will disable multi-threading.

**Critical System Configuration:**
Before running the clustering step, increase the stack size to prevent segmentation faults on large datasets:
```bash
ulimit -s unlimited
```

## Standard Workflow

### 1. Generate Overlaps
Use `minimap2` to find overlaps between reads. It is recommended to use the `-X` option to find more read connections and prevent reads from only mapping to themselves as primary alignments.
```bash
minimap2 -x ava-ont -X reads.fq reads.fq > overlaps.paf
```

### 2. Convert to CARNAC Format
Convert the Pairwise mApping Format (PAF) output into the native CARNAC-LR input format. This requires the original fastq/fasta file.
```bash
python scripts/paf_to_CARNAC.py overlaps.paf reads.fq input_carnac.txt
```

### 3. Execute Clustering
Run the main CARNAC-LR binary.
```bash
CARNAC-LR -f input_carnac.txt -o output_clusters.txt -t 8
```
*   `-f`: Path to the converted input file (mandatory).
*   `-o`: Output filename (default: `final_g_clusters.txt`).
*   `-t`: Number of threads (default: 2).

### 4. Generate Fasta Files from Clusters
To extract the actual sequences for each cluster, use the provided conversion script.
```bash
python scripts/CARNAC_to_fasta.py reads.fq output_clusters.txt [min_cluster_size]
```
This will generate individual Fasta files for each cluster meeting the minimum size requirement.

## Best Practices and Troubleshooting
*   **Memory Management:** If encountering segmentation faults even after setting `ulimit`, check if the dataset size exceeds available RAM, as CARNAC-LR loads the overlap graph into memory.
*   **Read Naming:** Ensure read names in the FASTQ file do not contain spaces or special characters that might break the PAF parsing script.
*   **Thread Scaling:** While CARNAC-LR supports multi-threading, the performance gain may plateau depending on the density of the overlap graph. Monitor CPU usage to find the optimal `-t` value for your specific dataset.
*   **Primary Alignments:** The `-X` flag in minimap2 is essential because standard transcriptomic mapping settings often filter out the redundant overlaps needed by CARNAC-LR to calculate clustering coefficients.

## Reference documentation
- [CARNAC-LR Overview](./references/anaconda_org_channels_bioconda_packages_carnac-lr_overview.md)
- [CARNAC-LR GitHub Repository](./references/github_com_kamimrcht_CARNAC-LR.md)