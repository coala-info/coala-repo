---
name: ngslca
description: The `ngslca` tool provides a high-performance implementation of the Lowest Common Ancestor algorithm for DNA read classification.
homepage: https://github.com/miwipe/ngsLCA
---

# ngslca

## Overview

The `ngslca` tool provides a high-performance implementation of the Lowest Common Ancestor algorithm for DNA read classification. It takes alignment files (BAM/SAM) as input and determines the most specific taxonomic rank shared by all reference hits for each read. This approach is essential for resolving ambiguity when a single sequence matches multiple different organisms. The tool is designed to be flexible, allowing users to filter assignments based on strict edit distances or percentage-based similarity scores.

## Installation and Setup

Install `ngslca` via Bioconda for the most stable environment:

```bash
conda install bioconda::ngslca
```

### Required NCBI Resources
Before running the tool, you must provide the NCBI taxonomy database files. Download and prepare them as follows:

1.  **Taxonomy Dumps**: `names.dmp` and `nodes.dmp` (can be gzipped).
2.  **Accession Mapping**: `nucl_gb.accession2taxid.gz` (or the relevant mapping file for your database).

## Command Line Usage

### Critical Input Requirement: Name Sorting
`ngslca` assumes that all alignments for a unique read ID are adjacent in the input file. You **must** sort your BAM files by read name, not coordinate, before processing.

```bash
samtools sort -n -@ 8 -o input.name_sorted.bam input.bam
```

### Basic Taxonomic Assignment
To run a standard classification using a specific edit distance (e.g., allowing 0 mismatches):

```bash
ngslca -editdistmin 0 \
       -editdistmax 0 \
       -names ncbi/names.dmp.gz \
       -nodes ncbi/nodes.dmp.gz \
       -acc2tax ncbi/nucl_gb.accession2taxid.gz \
       -bam input.name_sorted.bam \
       -outnames output_prefix
```

### Filtering by Similarity Score
Use similarity scores (0.0 to 1.0) to define a percentage-based mismatch interval:

```bash
ngslca -simscorelow 0.95 \
       -simscorehigh 1.0 \
       -names ncbi/names.dmp.gz \
       -nodes ncbi/nodes.dmp.gz \
       -acc2tax ncbi/nucl_gb.accession2taxid.gz \
       -bam input.name_sorted.bam \
       -outnames output_sim_95
```

## Expert Tips and Best Practices

*   **Multi-Database Workflows**: If you align reads against multiple separate databases (e.g., RefSeq and a custom database), merge and name-sort the resulting BAM files before running `ngslca` to ensure the LCA is calculated across all potential hits.
*   **Custom Genomes**: For organisms not in the NCBI database, manually append their Accession IDs and corresponding TaxIDs to your `accession2taxid` file.
*   **Ancient DNA (aDNA)**: While `ngslca` is fast, if you require DNA damage estimation (deamination patterns) alongside taxonomic assignment, consider using `metaDMG`, which utilizes `ngslca` internally.
*   **Memory Management**: Ensure your system has enough RAM to load the `accession2taxid` mapping file, which can be several gigabytes for the full NCBI nucleotide database.
*   **Aligner Settings**: When using Bowtie2 or BWA, ensure you use settings that report multiple hits (e.g., `bowtie2 -k 100`) so `ngslca` has the necessary data to perform LCA resolution.

## Reference documentation
- [ngsLCA GitHub Repository](./references/github_com_miwipe_ngsLCA.md)
- [ngslca Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ngslca_overview.md)