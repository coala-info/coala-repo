---
name: concoct
description: CONCOCT groups metagenomic sequences into bins representing individual microbial genomes by combining sequence composition and differential coverage across samples. Use when user asks to fragment contigs, generate coverage tables, run the CONCOCT clustering algorithm, merge subcontig clusters, or extract bins into individual FASTA files.
homepage: https://github.com/BinPro/CONCOCT
metadata:
  docker_image: "quay.io/biocontainers/concoct:1.1.0--py312hb1d17a5_9"
---

# concoct

## Overview

CONCOCT (Clustering cONtigs with COverage and ComposiTion) is a bioinformatics tool designed to group metagenomic sequences into "bins" that represent individual microbial genomes. It achieves this by combining two independent sources of information: sequence composition (k-mer frequencies) and differential coverage across multiple samples. This dual-approach allows for more accurate binning than methods relying on a single metric.

## Standard Workflow

The CONCOCT pipeline typically follows a five-step process. Ensure you have your original contigs in FASTA format and sorted/indexed BAM files from mapping your samples back to those contigs.

### 1. Fragment Contigs
To improve clustering performance, large contigs are cut into smaller parts (typically 10K bp).

```bash
cut_up_fasta.py original_contigs.fa -c 10000 -o 0 --merge_last -b contigs_10K.bed > contigs_10K.fa
```

### 2. Generate Coverage Table
Calculate the coverage depth per sample for each subcontig. This requires the BED file from the previous step and your BAM files.

```bash
concoct_coverage_table.py contigs_10K.bed mapping/*.sorted.bam > coverage_table.tsv
```

### 3. Run CONCOCT
Execute the main clustering algorithm using the fragmented FASTA and the coverage table.

```bash
concoct --composition_file contigs_10K.fa --coverage_file coverage_table.tsv -b concoct_output/
```

### 4. Merge Subcontig Clusters
Since contigs were fragmented in step 1, the clustering results must be merged back to the original contig level.

```bash
merge_cutup_clustering.py concoct_output/clustering_gt1000.csv > concoct_output/clustering_merged.csv
```

### 5. Extract Bins
Finally, extract the clustered sequences into individual FASTA files for downstream analysis (e.g., checkm, annotation).

```bash
mkdir concoct_output/fasta_bins
extract_fasta_bins.py original_contigs.fa concoct_output/clustering_merged.csv --output_path concoct_output/fasta_bins
```

## Best Practices and Tips

- **BAM Preparation**: All BAM files must be sorted and indexed before running `concoct_coverage_table.py`.
- **Contig Length**: CONCOCT performs best on contigs longer than 1000bp. The default output `clustering_gt1000.csv` automatically filters for these.
- **Thread Management**: While CONCOCT is efficient, ensure your environment has sufficient memory for the coverage table, especially when dealing with many samples or very large metagenomes.
- **Installation**: The most reliable way to install CONCOCT and its dependencies (like `scikit-learn`, `gsl`, and `cython`) is via Bioconda: `conda install bioconda::concoct`.

## Reference documentation
- [CONCOCT GitHub Repository](./references/github_com_BinPro_CONCOCT.md)
- [Bioconda CONCOCT Overview](./references/anaconda_org_channels_bioconda_packages_concoct_overview.md)