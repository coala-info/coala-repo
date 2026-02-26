---
name: picrust
description: This tool predicts functional gene content from 16S rRNA taxonomic profiles by leveraging evolutionary relationships. Use when user asks to predict metagenome functions, normalize OTU tables by copy number, or infer KEGG Orthologs from taxonomic data.
homepage: http://picrust.github.com
---


# picrust

## Overview
This skill enables the prediction of functional gene content (such as KEGG Orthologs or COGs) from taxonomic profiles derived from 1s rRNA sequencing. It bridges the gap between "who is there" (taxonomy) and "what they are doing" (function) by leveraging evolutionary relationships to infer the presence of genes in environmental samples without requiring full shotgun metagenomic sequencing.

## Core Workflow and Best Practices

### 1. Data Preparation
*   **Input Requirement**: Ensure your OTU table is in BIOM format.
*   **Reference Alignment**: OTUs must be picked against a compatible reference database (typically Greengenes) using a "closed-reference" approach to ensure OTU IDs match the pre-calculated PICRUSt files.

### 2. Normalization for 16S Copy Number
Before functional prediction, you must normalize the OTU table to account for varying 16S rRNA gene copy numbers across different taxa.
```bash
normalize_by_copy_number.py -i otu_table.biom -o normalized_otus.biom
```

### 3. Functional Prediction
Predict the abundance of functional categories (e.g., KEGG Orthologs) based on the normalized OTU table.
```bash
predict_metagenomes.py -i normalized_otus.biom -o predicted_metagenomes.biom
```

### 4. Categorizing by Function (Optional)
To make the results more interpretable, collapse the specific gene predictions into higher-level pathways (e.g., KEGG Pathways).
```bash
metagenome_contributions.py -i normalized_otus.biom -l 3 -o categorized_functions.biom
```

## Expert Tips
*   **NSTI Scores**: Always check the Weighted Nearest Sequenced Taxon Index (NSTI) values. High NSTI scores indicate that the microbes in your sample are distantly related to available reference genomes, which decreases prediction accuracy.
*   **Legacy Version**: Note that this skill covers PICRUSt1 (v1.1.4). For newer datasets, ensure compatibility with the Greengenes 13_5 or 13_8 versions.
*   **Platform Support**: While the latest version is `noarch`, older versions (1.1.3) have specific builds for `linux-64` and `macos-64`.

## Reference documentation
- [PICRUSt Overview](./references/anaconda_org_channels_bioconda_packages_picrust_overview.md)