---
name: zol
description: Zol is a bioinformatics toolkit for comparative analysis of co-located gene sets, providing evolutionary insights from genomic data. Use when user asks to identify ortholog groups, assess gene conservation, detect lateral gene transfer, visualize genomic neighborhoods, identify unique genomic features, or analyze BiG-SCAPE gene cluster families.
homepage: https://github.com/Kalan-Lab/zol
metadata:
  docker_image: "quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1"
---

# zol

## Overview

The `zol` suite is a specialized bioinformatics toolkit for the comparative investigation of co-located gene sets. It provides a streamlined workflow to move from raw genomic data to detailed evolutionary insights. Use this skill to identify ortholog groups across multi-species datasets, assess gene conservation, detect lateral gene transfer, and produce publication-ready visualizations of genomic neighborhoods.

## Core Workflow and CLI Patterns

The suite is accessed via the unified `zol-suite` command. The typical order of operations follows a four-step process.

### 1. Database Preparation (prepTG)
Prepare a target genome database for efficient searching. This step performs gene-calling or gene-mapping.
- Use FASTA inputs for default gene calling via Pyrodigal.
- Use GenBank inputs to preserve existing CDS features.
- For eukaryotic genomes, provide a reference proteome to enable `miniprot` mapping.

```bash
zol-suite prepTG --genomes_directory /path/to/fastas/ --output_directory ./target_db
```

### 2. Homolog Searching (fai)
Search for additional instances of a query gene cluster within the prepared database.
- `fai` accounts for scaffold/contig edges, marking incomplete clusters to prevent downstream conservation bias.
- It supports flexible alignment and synteny criteria.

```bash
zol-suite fai --query_gbk query_cluster.gbk --database ./target_db --output_directory ./fai_results
```

### 3. Comparative Analysis (zol)
Perform de novo ortholog group inference and generate detailed reports.
- Produces color-formatted XLSX spreadsheets with evolutionary statistics.
- **Scalability Tip**: For thousands of instances, use the dereplication/reinflation approach or DIAMOND linclust to reduce memory and runtime.

```bash
zol-suite zol --input_fai ./fai_results --output_directory ./zol_analysis
```

### 4. Visualization (cgc & cgcg)
Generate figures from `zol` results.
- **cgc**: Creates a consensus gene cluster representation with bar plots for quantitative stats.
- **cgcg**: Generates a network visualization where nodes are ortholog groups and edges represent syntenic ordering.

```bash
zol-suite cgc --zol_results ./zol_analysis --output_figure consensus_view.pdf
zol-suite cgcg --zol_results ./zol_analysis --output_figure network_view.pdf
```

## Specialized Analysis Modules

- **Lateral Transfer (salt)**: Assess support for horizontal gene transfer by checking codon usage dissimilarity and proximity to transposons or viral proteins.
- **Novelty Assessment (abon, atpoc, apos)**: Compare a focal strain's BGC-ome, phage-ome, or plasmid-ome against its genus to identify unique genomic features.
- **BiG-SCAPE Integration (zol-scape)**: Run `zol` analysis directly on BiG-SCAPE gene cluster families (GCFs).

## Expert Tips and Best Practices

- **Handle Fragmented Assemblies**: Use `fai`'s edge-detection features to filter or flag gene clusters located on scaffold boundaries, which often lead to false reports of gene loss.
- **Resource Management**: While disk space is the primary concern for `prepTG` and `fai` (especially with >1000 genomes), memory is the bottleneck for `zol`. Use the `--cluster_only` or CD-HIT options if InParanoid-style ortholog inference exceeds available RAM.
- **Genomic Region Extraction**: Use the `regex` utility to quickly extract specific GenBank regions based on scaffold coordinates.

## Reference documentation
- [zol Main Documentation](./references/github_com_Kalan-Lab_zol.md)
- [zol Wiki and Tutorials](./references/github_com_Kalan-Lab_zol_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_zol_overview.md)