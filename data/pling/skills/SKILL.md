---
name: pling
description: Pling computes the rearrangement distance between plasmids and clusters them based on this distance. Use when user asks to analyze plasmid relationships, identify evolutionary distances, or cluster similar plasmids.
homepage: https://github.com/iqbal-lab-org/pling
---


# pling

yaml
name: pling
description: Computes the rearrangement distance between plasmids and clusters them based on this distance. Use when analyzing plasmid relationships, identifying evolutionary distances, or clustering similar plasmids using the DCJ-Indel distance.
```
## Overview
Pling is a bioinformatics tool designed for analyzing plasmid relationships. It calculates the Double Cut and Join Indel (DCJ-Indel) distance between plasmids, which quantifies their evolutionary distance in terms of structural rearrangements. By combining this with containment distance (shared content), pling can effectively cluster related plasmids and identify mobile elements that might otherwise obscure these relationships.

## Usage

Pling is a command-line tool. The primary function involves calculating distances and clustering.

### Basic Usage: Calculating Distances and Clustering

The core functionality of pling involves providing a set of plasmids and then performing analysis.

```bash
pling <input_files> [options]
```

**Input Files:**
Pling typically accepts one or more input files containing plasmid sequences or representations. The exact format will depend on the specific analysis being performed, but common formats include FASTA or specialized formats for genomic data.

**Key Options:**

*   **`--output_dir`**: Specifies the directory where output files will be saved.
*   **`--cluster_threshold`**: Defines the threshold for clustering. Plasmids with a distance below this threshold will be grouped together.
*   **`--containment_threshold`**: Sets the threshold for considering plasmids as having significant shared content.
*   **`--dcj_indel_threshold`**: Sets the threshold for the DCJ-Indel distance.

**Example:**

To compute distances and cluster plasmids from `plasmid1.fasta` and `plasmid2.fasta` with a clustering threshold of 0.5 and a containment threshold of 0.8, saving output to a directory named `results`:

```bash
pling plasmid1.fasta plasmid2.fasta --output_dir results --cluster_threshold 0.5 --containment_threshold 0.8
```

### Advanced Usage and Tips:

*   **Understanding Input Formats**: Refer to the project's documentation for the precise format requirements of input plasmid data. Incorrect formatting is a common source of errors.
*   **Interpreting Output**: The output directory will typically contain files detailing pairwise distances, cluster assignments, and potentially visualizations. Pay close attention to the README or documentation for a full explanation of each output file.
*   **Parameter Tuning**: The `cluster_threshold`, `containment_threshold`, and `dcj_indel_threshold` parameters are crucial for obtaining meaningful results. Experiment with different values based on your biological understanding of the plasmids you are analyzing. Small changes in these thresholds can significantly alter clustering outcomes.
*   **Error Handling**: If pling encounters issues, check the error messages carefully. Common problems include incorrect file paths, unsupported input formats, or insufficient memory for large datasets. The GitHub issues page can be a valuable resource for troubleshooting.

## Reference documentation
- [Pling Overview](https://github.com/iqbal-lab-org/pling)