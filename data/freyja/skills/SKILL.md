---
name: freyja
description: Freyja is a specialized tool for "de-mixing" genomic data from samples containing multiple SARS-CoV-2 lineages.
homepage: https://github.com/andersen-lab/Freyja
---

# freyja

---

## Overview
Freyja is a specialized tool for "de-mixing" genomic data from samples containing multiple SARS-CoV-2 lineages. It utilizes a library of lineage-defining mutational barcodes—derived from the UShER global phylogenetic tree—to solve a constrained optimization problem, returning the estimated proportions of variants present in a sample. It is most effective as a post-processing step after alignment (to the Hu-1 reference), primer trimming, and variant calling.

## Installation and Setup
Freyja is available via Bioconda. It is recommended to use Python 3.11 to utilize the Clarabel solver for improved performance.

```bash
# Create environment and install
conda create -n freyja-env
conda config --add channels bioconda
conda config --add channels conda-forge
conda install freyja
```

## Core Workflow
The standard workflow involves updating the barcode library, extracting variants from your alignment, and then performing the de-mixing analysis.

### 1. Update Barcodes
Since lineage definitions evolve rapidly, always ensure you are using the latest barcodes and curation metadata.
```bash
freyja update
```
*Note: To check the current version of your barcodes, use `freyja demix --version`.*

### 2. Variant Calling (Pre-processing)
Freyja requires SNV frequencies and sequencing depth. While it is designed to work with iVar outputs, you can generate the required input directly from a BAM file:
```bash
freyja variants <sample.bam> --variants <output_variants.tsv> --depths <output_depths.file> --ref <reference.fasta>
```

### 3. De-mixing Lineages
This is the primary analysis step. It uses the variants and depth files to calculate lineage abundances.
```bash
freyja demix <output_variants.tsv> --depths <output_depths.file> --output <sample_abundances.tsv>
```

### 4. Aggregation and Visualization
For studies involving multiple samples (e.g., a longitudinal wastewater study), aggregate the results into a single report.
```bash
# Aggregate all tsv files in a directory
freyja aggregate <directory_of_results>/ --output <aggregated_report.tsv>

# Create a standard abundance plot
freyja plot <aggregated_report.tsv> --output <lineage_plot.pdf>
```

## Expert Tips and Best Practices
- **Reference Alignment**: Ensure your BAM files are aligned to the SARS-CoV-2 Hu-1 reference (NC_045512.2).
- **Depth Weighting**: Freyja uses depth-weighted de-mixing. Samples with low coverage or highly uneven depth may produce less reliable abundance estimates.
- **Barcode Formats**: Modern versions of Freyja use a compressed feather format for barcodes to handle the increasing size of the UShER tree.
- **Lineage Dynamics**: Use the `freyja boot` command if you need to perform bootstrapping to estimate confidence intervals for the lineage abundances.
- **Custom Pathogens**: While primarily used for SARS-CoV-2, recent updates have introduced support for other pathogens (e.g., RSV, Dengue) via specific barcode configurations.

## Reference documentation
- [Freyja GitHub Repository](./references/github_com_andersen-lab_Freyja.md)
- [Freyja Wiki and Cookbook](./references/github_com_andersen-lab_Freyja_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_freyja_overview.md)