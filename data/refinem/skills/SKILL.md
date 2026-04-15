---
name: refinem
description: RefineM is a bioinformatics toolkit used to improve the quality of metagenome-assembled genomes by identifying and removing contaminating scaffolds. Use when user asks to refine genomic bins, identify outliers based on GC content or tetranucleotide signatures, and filter scaffolds using taxonomic profiling.
homepage: http://pypi.python.org/pypi/refinem/
metadata:
  docker_image: "quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0"
---

# refinem

## Overview
RefineM is a specialized bioinformatics toolkit used to improve the quality of metagenome-assembled genomes (MAGs). It identifies scaffolds that are likely contaminants within a bin by analyzing internal consistency. The tool operates on the principle that scaffolds belonging to the same genome should share similar genomic properties—specifically GC content and tetranucleotide signatures (TNS)—and should ideally be assigned to the same or related taxonomic lineages.

## Core CLI Usage

The standard RefineM workflow follows a three-step process: calculating statistics, identifying outliers, and filtering the bins.

### 1. Calculate Scaffold Statistics
Generate the base statistics (GC and TNS) for your bins.
```bash
refinem scaffold_stats <input_fasta_dir> <bin_ext> <output_dir> <bam_files> <reference_fasta>
```
*   `<input_fasta_dir>`: Directory containing your genomic bins.
*   `<bam_files>`: Mapping files (BAM) used to calculate coverage.

### 2. Identify Outliers
Identify scaffolds that deviate significantly from the bin's average properties.
```bash
refinem outliers <scaffold_stats_file> <output_dir>
```
*   This produces an `outliers.tsv` file listing scaffolds that exceed the default thresholds (typically 3 standard deviations).

### 3. Filter Bins
Create a new set of "refined" bins by removing the identified outliers.
```bash
refinem filter <input_fasta_dir> <outliers_file> <output_dir>
```

## Taxonomic Refinement

To further refine bins based on taxonomic classification, use the following sequence:

### 1. Gene Calling
Predict genes for the scaffolds in your bins.
```bash
refinem call_genes <input_fasta_dir> <bin_ext> <output_dir>
```

### 2. Taxonomic Profiling
Assign taxonomy to the predicted genes using a reference database (e.g., GTDB).
```bash
refinem taxon_profile <gene_file> <reference_db> <taxonomy_map> <output_dir>
```

### 3. Taxonomic Filtering
Identify and remove scaffolds that belong to a different phylum or class than the majority of the bin.
```bash
refinem taxon_filter <taxon_profile_file> <output_dir>
```

## Expert Tips and Best Practices

*   **Iterative Refinement**: It is often beneficial to run the genomic signature refinement (GC/TNS) before the taxonomic refinement to simplify the taxonomic profile.
*   **Threshold Adjustment**: If the default 3 standard deviations are too aggressive or too relaxed, use the `--threshold` flag in the `outliers` command to tune sensitivity.
*   **Reference Data**: Ensure you have sufficient disk space for the reference databases required by `taxon_profile`, as these can be quite large.
*   **Input Extensions**: Always specify the correct file extension for your bins (e.g., `.fna`, `.fasta`, `.bin`) using the extension parameter to avoid "file not found" errors.



## Subcommands

| Command | Description |
|---------|-------------|
| refinem call_genes | Identify genes within genomes. |
| refinem filter_bins | Remove scaffolds across a set of bins. |
| refinem modify_bin | Modify scaffolds in a single bin. |
| refinem scaffold_stats | Calculate statistics for scaffolds. |
| refinem ssu_erroneous | Identify scaffolds with erroneous 16S rRNA genes. |
| refinem taxon_filter | Identify scaffolds with divergent taxonomic classification. |
| refinem taxon_profile | Generate taxonomic profile of genes across scaffolds within a genome. |
| refinem_genome_stats | Calculate statistics for genomes. |
| refinem_outliers | Identify scaffolds with divergent genomic characteristics. |

## Reference documentation
- [RefineM Overview](./references/anaconda_org_channels_bioconda_packages_refinem_overview.md)
- [RefineM PyPI Project](./references/pypi_org_project_refinem.md)