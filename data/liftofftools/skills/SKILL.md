---
name: liftofftools
description: LiftoffTools evaluates and compares gene annotations between reference and target genome assemblies to identify sequence variants, synteny changes, and gene copy number variations. Use when user asks to identify variant effects on protein-coding genes, compare gene order between assemblies, or group genes into clusters to find paralogs.
homepage: https://github.com/agshumate/LiftoffTools
---


# liftofftools

## Overview
LiftoffTools is a specialized bioinformatics toolkit designed to evaluate and compare gene annotations between a reference and a target genome assembly. While optimized for use with the Liftoff tool, it is compatible with any lift-over method (such as UCSC liftOver) provided the feature IDs remain consistent across datasets. It provides three primary analytical modules—variants, synteny, and clusters—to help researchers understand the biological consequences of genome evolution or assembly differences on gene structure and organization.

## Installation
The recommended method for installation is via Bioconda:
```bash
conda install -c bioconda liftofftools
```
Note: The `clusters` module requires `MMSeqs2` to be installed and available in your system PATH.

## Core Modules and Usage

### 1. Comprehensive Analysis
To run all modules (variants, synteny, and clusters) simultaneously:
```bash
liftofftools all -r reference.fa -t target.fa -rg reference.gff3 -tg target.gff3
```

### 2. Variants Module
Identifies sequence identity and the most severe variant effect (e.g., frameshift, stop codon gain, nonsynonymous mutation) for protein-coding genes.
```bash
liftofftools variants -r reference.fa -t target.fa -rg reference.gff3 -tg target.gff3
```
*   **Key Output**: `variant_effects` (TSV) containing DNA/AA identity and the classified variant effect.

### 3. Synteny Module
Compares gene order between assemblies and generates visualization.
```bash
liftofftools synteny -r reference.fa -t target.fa -rg reference.gff3 -tg target.gff3 -edit-distance
```
*   **Key Output**: `gene_order_plot.pdf` (Dot plot) and `gene_order` (TSV).
*   **Expert Tip**: Use `-edit-distance` to get a quantitative estimate of how many genes have changed order between the reference and target.

### 4. Clusters Module
Groups genes into paralogs to identify gene copy number gains or losses.
```bash
liftofftools clusters -r reference.fa -t target.fa -rg reference.gff3 -tg target.gff3
```
*   **Expert Tip**: You can pass custom MMSeqs2 parameters using `-mmseqs_params`. Default is `"--min-seq-id 0.9 -c 0.9"`.

## Common CLI Patterns and Best Practices

### Handling Output
*   **Directory Control**: Use `-dir <name>` to specify an output directory. By default, it uses `liftofftools_output`.
*   **Overwriting**: LiftoffTools will not overwrite existing files by default. Use the `-force` flag to overwrite previous runs in the same directory.

### Filtering and Optimization
*   **Protein-Coding Only**: Use the `-c` flag to restrict analysis to protein-coding gene clusters only, which significantly speeds up processing if non-coding features are not required.
*   **Custom Features**: If you need to analyze features beyond standard "gene" types, provide a text file with the feature names using the `-f` flag.
*   **Gene Inference**: Use `-infer-genes` if your GFF/GTF file lacks explicit gene features but contains transcripts/exons.

### Sorting Synteny Plots
To control the order of chromosomes on the synteny dot plot axes, provide text files containing the desired order:
```bash
liftofftools synteny -r ref.fa -t tar.fa -rg ref.gff -tg tar.gff -r-sort ref_chroms.txt -t-sort tar_chroms.txt
```

## Reference documentation
- [LiftoffTools GitHub Repository](./references/github_com_agshumate_LiftoffTools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_liftofftools_overview.md)