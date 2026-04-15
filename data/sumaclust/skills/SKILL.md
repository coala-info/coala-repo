---
name: sumaclust
description: This tool clusters biological sequences using an algorithm similar to UCLUST and CD-HIT. Use when user asks to cluster biological sequences, dereplicate sequence datasets, or perform OTU clustering.
homepage: https://git.metabarcoding.org/obitools/sumaclust/wikis/home
metadata:
  docker_image: "biocontainers/sumaclust:v1.0.31-2-deb_cv1"
---

# sumaclust

Clusters biological sequences using an algorithm similar to UCLUST and CD-HIT.
  Use when you need to efficiently group large sets of DNA or protein sequences based on similarity,
  especially for tasks like OTU clustering in metabarcoding or dereplication of sequence datasets.
  This skill is suitable for command-line usage of the sumaclust tool.
---
## Overview

Sumaclust is a command-line tool designed for rapid and exact clustering of biological sequences. It employs the same clustering algorithm as established tools like UCLUST and CD-HIT, making it ideal for applications such as operational taxonomic unit (OTU) clustering in metabarcoding studies or for de-duplicating large sequence datasets. It is particularly useful when dealing with high-throughput sequencing data where efficient and accurate grouping of similar sequences is paramount.

## Usage Instructions

Sumaclust operates via command-line arguments. The primary function is to take an input sequence file and produce a clustered output.

### Basic Clustering

The most common usage involves specifying an input FASTA file and an output file for the clustered results.

```bash
sumaclust -i input.fasta -o output.fasta
```

### Key Options and Best Practices

*   **`-i` / `--input`**: Specifies the input sequence file in FASTA format. Ensure your input file is correctly formatted.
*   **`-o` / `--output`**: Specifies the output file for the clustered sequences. This file will contain representative sequences for each cluster.
*   **`-s` / `--similarity`**: Sets the similarity threshold for clustering. This is a crucial parameter. Values are typically between 0.90 (90% similarity) and 0.99 (99% similarity). The default is often 0.97.
    *   **Expert Tip**: For OTU clustering in metabarcoding, a common starting point is 0.97. However, the optimal value depends on the biological question and the marker gene. Experiment with different values if results are not as expected.
*   **`-m` / `--method`**: Specifies the clustering method. Common options include `uclust` (default) and `cdhit`.
    *   **Expert Tip**: While both are similar, `uclust` is generally faster. Stick with the default unless you have a specific reason to use `cdhit`.
*   **`-a` / `--all`**: If specified, the output file will contain all sequences, with cluster assignments indicated. Without this, only representative sequences are output.
    *   **Expert Tip**: Use `-a` when you need to know which original sequence belongs to which cluster, not just the cluster representatives.
*   **`-c` / `--clusters`**: Outputs a separate file listing the cluster assignments. This is often used in conjunction with `-a`.
    *   **Example**: `sumaclust -i input.fasta -o output.fasta -c clusters.txt -a`
*   **`-p` / `--prefix`**: Sets a prefix for cluster identifiers in the output.
    *   **Example**: `sumaclust -i input.fasta -o output.fasta --prefix OTU` will result in cluster IDs like `OTU_1`, `OTU_2`, etc.
*   **`-d` / `--derep`**: Enables dereplication of identical sequences before clustering, which can significantly speed up processing for datasets with many exact duplicates.
    *   **Expert Tip**: Always consider using `--derep` if your dataset is expected to have a high proportion of identical sequences.

### Example Workflow for Metabarcoding

A typical workflow for processing 16S rRNA gene sequences for OTU clustering might look like this:

1.  **Dereplication and Clustering**:
    ```bash
    sumaclust -i merged_sequences.fasta -o otu_representatives.fasta -s 0.97 -a -c otu_assignments.txt --prefix OTU
    ```
    This command takes your merged FASTA file, clusters sequences at 97% similarity, outputs the representative sequences for each OTU, includes all sequences with their assignments, and saves the assignments to a separate file.

2.  **Further Processing**: The `otu_representatives.fasta` file can then be used for taxonomic assignment, and `otu_assignments.txt` can be used to map reads to OTUs.

## Reference documentation

- [Sumaclust Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sumaclust_overview.md)