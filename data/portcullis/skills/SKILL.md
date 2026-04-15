---
name: portcullis
description: Portcullis filters unreliable splice junctions from pre-aligned RNA-seq data to distinguish genuine biological splice sites from mapping artifacts. Use when user asks to filter false-positive splice junctions, quantify junction metrics, or create a clean BAM file by removing reads supporting rejected junctions.
homepage: https://github.com/maplesond/portcullis
metadata:
  docker_image: "quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4"
---

# portcullis

## Overview
Portcullis is a "portable" tool designed to "cull" (filter) unreliable splice junctions from pre-aligned RNA-seq data. While most RNA-seq mappers are sensitive, they often produce a high number of false-positive splice junctions, especially in high-coverage datasets. Portcullis addresses this by analyzing the features of every junction in a BAM file and using a rule-based or machine-learning approach to distinguish genuine biological splice sites from mapping artifacts.

## Core Workflows

### 1. The Full Pipeline
For most users, the `full` mode is the most efficient way to process a BAM file. It executes the preparation, quantification, and filtering steps in a single command.

```bash
portcullis full --threads 8 --output ./portcullis_out genome.fasta aligned_reads.bam
```

### 2. Step-by-Step Execution
If you need more control over intermediate files or want to restart from a specific stage, use the individual modes:

- **prep**: Initial processing of the BAM and Reference.
  ```bash
  portcullis prep --output ./prep_dir genome.fasta aligned_reads.bam
  ```
- **junc**: Calculate metrics for all junctions found in the prepared data.
  ```bash
  portcullis junc ./prep_dir
  ```
- **filter**: Apply filtering logic to separate genuine junctions from artifacts.
  ```bash
  portcullis filter ./prep_dir
  ```
- **bamfilt**: Create a new "clean" BAM file by removing reads that support rejected junctions.
  ```bash
  portcullis bamfilt --output filtered_reads.bam ./prep_dir aligned_reads.bam
  ```

### 3. Junction Manipulation with Junctools
Portcullis includes a companion suite called `junctools` for converting and comparing junction files.

- **Convert formats**: Convert between `.tab`, `.bed`, and `.gff`.
  ```bash
  junctools convert --input_format tab --output_format bed input.junctions.tab output.junctions.bed
  ```
- **Compare sets**: Compare two sets of junctions (e.g., Portcullis output vs. a reference annotation).
  ```bash
  junctools compare set1.bed set2.bed
  ```

## Expert Tips and Best Practices

- **Memory Management**: Portcullis can be memory-intensive on very deep datasets. Ensure your environment has sufficient RAM, or process chromosomes individually if resources are limited.
- **Input Requirements**: Input BAM files must be coordinate-sorted and indexed. If using the `full` or `prep` mode, ensure the reference FASTA is also indexed (`samtools faidx`).
- **Strand Analysis**: Portcullis automatically performs strand analysis during the `junc` stage to determine the library's strandedness protocol. Check the logs to verify if it correctly identified your library type (e.g., FR, RF, or unstranded).
- **Filtering Sensitivity**: If the default filtering is too aggressive or too relaxed, you can manually adjust the rules used for the positive and negative training sets during the `filter` stage. Use `portcullis filter --help` to see advanced threshold options.
- **Downstream Integration**: Use the filtered `.bed` or `.tab` files as input for gene predictors like AUGUSTUS or Braker to significantly reduce false-positive gene models.



## Subcommands

| Command | Description |
|---------|-------------|
| portcullis bamfilt | Removes alignments associated with bad junctions from BAM file |
| portcullis filter | Filters out junctions that are unlikely to be genuine or that have too little supporting evidence. The user can control three stages of the filtering process. First the user can perform filtering based on a random forest model self-trained on the provided data, alternatively the user can provide a pre-trained model. Second the user can specify a configuration file describing a set of filtering rules to apply. Third, the user can directly through the command line filter based on junction (intron) length, or the canonical label. |
| portcullis full | Runs prep, junc, filter, and optionally bamfilt, as a complete pipeline. Assumes that the self-trained machine learning approach for filtering is to be used. |
| portcullis prep | Prepares a genome and bam file(s) ready for junction analysis. This involves ensuring the bam file is sorted and indexed and the genome file is indexed. |
| portcullis_junc | Analyses all potential junctions found in the input BAM file. |

## Reference documentation
- [Portcullis Overview](./references/ei-corebioinformatics_github_io_portcullis.md)
- [Installation and Quickstart](./references/github_com_EI-CoreBioinformatics_portcullis.md)
- [Release History and Versioning](./references/github_com_EI-CoreBioinformatics_portcullis_releases.md)