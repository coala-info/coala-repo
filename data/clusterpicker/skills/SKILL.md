---
name: clusterpicker
description: Clusterpicker identifies sequence clusters within phylogenetic trees based on genetic distance and bootstrap support thresholds. Use when user asks to identify clusters in phylogenetic trees, group sequences based on evolutionary criteria, or filter clusters by genetic distance and bootstrap support.
homepage: http://hiv.bio.ed.ac.uk/software.html
metadata:
  docker_image: "quay.io/biocontainers/clusterpicker:1.2.5--hdfd78af_1"
---

# clusterpicker

## Overview
The `clusterpicker` skill enables the automated identification of clusters within phylogenetic trees. It is particularly effective for large-scale genomic surveillance and epidemiological studies where researchers need to group sequences that meet specific evolutionary criteria. By processing Newick-formatted trees alongside sequence alignments, the tool filters clusters based on two primary metrics: the maximum genetic distance between sequences and the minimum bootstrap support for the internal node.

## Usage Instructions

### Installation
The tool is available via Bioconda. Ensure you have a Java Runtime Environment (JRE) 1.6.0 or higher installed.
```bash
conda install bioconda::clusterpicker
```

### Basic Command Line Execution
The command-line version of Cluster Picker typically requires the input files and thresholds to be passed as positional arguments. 

**Standard Syntax:**
```bash
java -jar ClusterPicker.jar <tree_file> <alignment_file> <bootstrap_threshold> <distance_threshold> <output_directory>
```

### Parameter Guidance
*   **Tree File:** Must be in Newick format. It is recommended to use trees with support values (bootstrap or aLRT) on the nodes.
*   **Alignment File:** A FASTA or PHYLIP alignment corresponding to the taxa in the tree. This is used to calculate the actual genetic distances between sequences within a potential cluster.
*   **Bootstrap Threshold:** A value (e.g., `0.9` or `90`) representing the minimum support required for a node to be considered the root of a cluster.
*   **Distance Threshold:** The maximum genetic distance (e.g., `0.015` for 1.5% divergence) allowed between sequences in a cluster.

### Best Practices
*   **Data Consistency:** Ensure that the taxon names in your Newick tree exactly match the headers in your alignment file. Discrepancies will cause the tool to fail or skip sequences.
*   **Threshold Selection:** For HIV-1 transmission studies (a common use case), a bootstrap threshold of 90% and a genetic distance of 1.5% to 4.5% are standard starting points, but these should be adjusted based on the specific pathogen and study goals.
*   **Large Datasets:** Cluster Picker is optimized for speed. If processing tens of thousands of sequences, ensure the JVM has sufficient memory allocated (e.g., `java -Xmx4g -jar ...`).
*   **Output Analysis:** The tool generates a principal output file listing each cluster and its constituent sequences. Use the companion tool `ClusterMatcher` if you need to link these clusters to external epidemiological metadata (e.g., age, location, or collection date).

## Reference documentation
- [clusterpicker - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_clusterpicker_overview.md)
- [Leigh Brown HIV Research Group Software](./references/hiv_bio_ed_ac_uk_software.html.md)