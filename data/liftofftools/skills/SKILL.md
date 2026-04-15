---
name: liftofftools
description: LiftoffTools evaluates the quality and functional changes of gene annotations transferred between genome assemblies. Use when user asks to identify variant effects in protein-coding genes, compare gene synteny, cluster paralogs to find copy number variations, or perform a comprehensive annotation quality analysis.
homepage: https://github.com/agshumate/LiftoffTools
metadata:
  docker_image: "quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0"
---

# liftofftools

## Overview

LiftoffTools is a specialized bioinformatics toolkit used to evaluate the quality and changes in gene annotations when they are transferred from a reference genome to a target genome assembly. It provides a comparative framework to understand how genomic differences—such as mutations, structural variations, or assembly errors—affect the resulting gene models. This skill assists in executing the four primary modules: variant analysis, synteny comparison, paralog clustering, and a comprehensive "all" mode.

## Core Modules and Usage

### 1. Variant Analysis (`variants`)
Identifies mutations in protein-coding genes and classifies their functional effects.
- **Command**: `liftofftools variants -r <ref.fa> -t <target.fa> -rg <ref.gff> -tg <target.gff>`
- **Key Outputs**: A `variant_effects` file detailing DNA/Protein sequence identity and the most severe variant effect (e.g., frameshift, stop codon gain, synonymous).

### 2. Synteny Comparison (`synteny`)
Evaluates the conservation of gene order between assemblies.
- **Command**: `liftofftools synteny -r <ref.fa> -t <target.fa> -rg <ref.gff> -tg <target.gff>`
- **Advanced Options**:
    - Use `-edit-distance` to quantify the number of genes in a different order.
    - Use `-r-sort` and `-t-sort` with text files containing chromosome names to control the axis ordering in the generated dot plot.
- **Key Outputs**: `gene_order_plot.pdf` (dot plot) and `gene_order` (tab-separated file).

### 3. Paralog Clustering (`clusters`)
Groups genes into paralogs to identify gene copy number gains or losses.
- **Command**: `liftofftools clusters -r <ref.fa> -t <target.fa> -rg <ref.gff> -tg <target.gff>`
- **Requirement**: Requires `MMSeqs2` to be installed and in the system PATH.
- **Parameters**: Customize clustering stringency using `-mmseqs_params` (e.g., `"-mmseqs_params '--min-seq-id 0.8 -c 0.8'"`).

### 4. Comprehensive Analysis (`all`)
Runs all three modules (variants, synteny, and clusters) in a single execution.
- **Command**: `liftofftools all -r <ref.fa> -t <target.fa> -rg <ref.gff> -tg <target.gff>`

## Expert Tips and Best Practices

- **Database Reuse**: If you have already run Liftoff or LiftoffTools, you can provide the generated `.db` file (gffutils database) to the `-rg` or `-tg` arguments instead of the raw GFF/GTF file to speed up initialization.
- **Handling Non-Gene Features**: By default, the tool focuses on genes. Use the `-f` flag followed by a text file listing additional feature types (e.g., pseudogenes, ncRNA) if you need to analyze more than just standard protein-coding genes.
- **Output Management**: Use the `-dir` flag to specify a custom output directory. If you need to re-run an analysis in an existing directory, you must use the `-force` flag, as the tool will not overwrite existing files by default.
- **Protein-Coding Focus**: Use the `-c` flag to restrict the analysis specifically to protein-coding gene clusters, which is often useful for reducing noise in large-scale comparative genomics.



## Subcommands

| Command | Description |
|---------|-------------|
| liftofftools | liftofftools: error: argument subcommand: invalid choice: 'and' (choose from 'clusters', 'variants', 'synteny', 'all') |
| liftofftools | liftofftools: error: argument subcommand: invalid choice: 'be' (choose from 'clusters', 'variants', 'synteny', 'all') |
| liftofftools | liftofftools: error: argument subcommand: invalid choice: 'format' (choose from 'clusters', 'variants', 'synteny', 'all') |
| liftofftools | liftofftools: error: argument subcommand: invalid choice: 'liftoff' (choose from 'clusters', 'variants', 'synteny', 'all') |
| liftofftools | liftofftools: error: argument subcommand: invalid choice: 'mmseqs' (choose from 'clusters', 'variants', 'synteny', 'all') |
| liftofftools | liftofftools: error: argument subcommand: invalid choice: 'to' (choose from 'clusters', 'variants', 'synteny', 'all') |

## Reference documentation
- [LiftoffTools README](./references/github_com_agshumate_LiftoffTools_blob_master_README.md)
- [LiftoffTools Overview](./references/github_com_agshumate_LiftoffTools.md)