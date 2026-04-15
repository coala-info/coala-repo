---
name: quota_anchor
description: quota_anchor identifies high-resolution syntenic gene blocks and analyzes comparative genomics data using a WGD-aware longest path algorithm. Use when user asks to identify syntenic gene pairs, perform collinearity analysis with specific duplication ratios, calculate Ks values, classify gene duplication types, or generate synteny visualizations like dotplots and circle plots.
homepage: https://github.com/baoxingsong/quota_Anchor
metadata:
  docker_image: "quay.io/biocontainers/quota_anchor:1.0.2--pyhdfd78af_0"
---

# quota_anchor

## Overview
The `quota_anchor` toolkit is designed for high-resolution syntenic gene identification. It leverages the longest path algorithm (originally implemented in AnchorWave) to provide a robust framework for comparative genomics. This skill is essential when working with species that have undergone polyploidy or complex rearrangements, as it allows users to specify expected duplication ratios (e.g., 2:1 for a WGD event) and handle relative inversions. The tool manages the full pipeline from raw sequence extraction and alignment to collinearity analysis and visualization.

## Core Workflow and CLI Patterns

### 1. Sequence Preparation
Before synteny analysis, you must extract the longest representative sequences for each gene to ensure consistency.

```bash
# Extract longest protein sequences
quota_Anchor longest_pep -f ref.fa,query.fa -g ref.gff3,query.gff3 -p ref.p.fa,query.p.fa -l ref.longest.fa,query.longest.fa -t 2
```

### 2. Metadata Generation
Generate chromosome length files which are required for coordinate mapping in subsequent steps.

```bash
# Generate length files from FAI and GFF
quota_Anchor get_chr_length -f ref.fa.fai,query.fa.fai -g ref.gff3,query.gff3 -o ref.len,query.len
```

### 3. Pre-Collinearity (Alignment)
This step combines sequence alignment (via DIAMOND or BLAST) with gene position data into a single table.

```bash
# Generate the input table for synteny analysis
quota_Anchor pre_col -a diamond -rs ref.longest.fa -qs query.longest.fa -db ref.db -mts 20 -e 1e-10 -b output.blast -rg ref.gff3 -qg query.gff3 -rl ref.len -ql query.len -o combined.table
```

### 4. Syntenic Path Identification (The Core)
The `col` module is where WGD awareness is applied. Use the `-r` and `-q` parameters to define the expected syntenic depth.

*   **WGD-Aware (e.g., Maize vs Sorghum 2:1 ratio):**
    ```bash
    quota_Anchor col -i combined.table -o result.collinearity -r 2 -q 1 -s 0
    ```
*   **Handling Inversions:**
    *   To remove relative inversion gene pairs: `-s 1 -a 1`
    *   To retain relative inversion gene pairs: `-s 0 -a 1`

### 5. Evolutionary Analysis and Classification
After identifying syntenic blocks, you can calculate substitution rates or classify the nature of gene duplications.

*   **Ks Calculation:** Use `quota_Anchor ks` to calculate synonymous/non-synonymous substitution rates for syntenic pairs.
*   **Gene Classification:** Use `quota_Anchor class_gene` to categorize genes into WGD, tandem, proximal, transposed, or dispersed duplications.

### 6. Visualization
`quota_anchor` provides several modules for publication-ready figures:
*   `dotplot`: For homologous gene pair dotplots.
*   `circle`: For Circos-style collinearity visualization.
*   `line`: For chromosome-level dual synteny plots.

## Expert Tips
*   **WGD Ratios:** Always determine the evolutionary history of your species before running `col`. If species A had a WGD after diverging from species B, use `-r 2 -q 1` (assuming A is the reference).
*   **Longest Transcripts:** Always use the `longest_pep` or `longest_cds` modules rather than raw GFF extractions to avoid bias introduced by alternative splicing.
*   **Parallelization:** The `ks` module supports parallel processing; ensure you allocate sufficient threads for large-scale genome comparisons.

## Reference documentation
- [github_com_baoxingsong_quota_Anchor.md](./references/github_com_baoxingsong_quota_Anchor.md)
- [anaconda_org_channels_bioconda_packages_quota_anchor_overview.md](./references/anaconda_org_channels_bioconda_packages_quota_anchor_overview.md)