---
name: picrust
description: PICRUSt predicts the functional profile of a microbial community based on its marker gene composition. Use when user asks to normalize OTU abundances by copy number, predict metagenome functional content, or categorize predicted genes into metabolic pathways.
homepage: http://picrust.github.com
metadata:
  docker_image: "quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0"
---

# picrust

## Overview
PICRUSt is a bioinformatics software package designed to predict the functional profile of a microbial community based on its marker gene composition (typically 16S rRNA). It bridges the gap between amplicon sequencing (which tells you who is there) and shotgun metagenomics (which tells you what they can do) by leveraging ancestral state reconstruction and known genomic databases.

## Core Workflow and CLI Patterns

### 1. OTU Picking and Normalization
Before functional prediction, 16S sequences must be mapped to a reference database (like Greengenes) to produce a "closed-reference" OTU table.
- **Normalize by Copy Number**: Marker gene abundances must be corrected for known variations in gene copy numbers across different taxa.
  ```bash
  normalize_by_copy_number.py -i otu_table.biom -o normalized_otus.biom
  ```

### 2. Functional Prediction
Predict the abundance of functional categories (e.g., KEGG Orthologs) based on the normalized OTU table.
- **Predict Metagenome**:
  ```bash
  predict_metagenome.py -i normalized_otus.biom -o predicted_metagenomes.biom
  ```
- **Expert Tip**: Use the `--accuracy_metrics` flag to generate Weighted Nearest Sequenced Taxon Index (NSTI) values. This helps evaluate the reliability of predictions; high NSTI values indicate that the microbes in your sample are distantly related to available reference genomes.

### 3. Pathway Categorization
Collapse individual gene predictions into higher-level metabolic pathways for easier biological interpretation.
- **Categorize by Function**:
  ```bash
  categorize_by_function.py -i predicted_metagenomes.biom -c KEGG_Pathways -l 3 -o predicted_pathways.biom
  ```

## Best Practices
- **Reference Compatibility**: Ensure your OTU IDs match the IDs in the PICRUSt precalculated files (e.g., Greengenes 13_5 or 13_8).
- **Input Format**: PICRUSt primarily uses the BIOM format. Use `biom convert` if your data is currently in a tab-delimited text format.
- **NSTI Filtering**: Always check the NSTI scores. Samples from environments poorly represented in genomic databases (like soil or deep sea) may yield less accurate predictions than human gut samples.



## Subcommands

| Command | Description |
|---------|-------------|
| metagenome_contributions.py | Partition the predicted contribution to the metagenomes from each organism in the given OTU table |
| normalize_by_copy_number.py | Normalize the OTU abundances for a given OTU table picked against the newest version of Greengenes |
| predict_metagenomes.py | Predict KO abundances for a given OTU table picked against the newest version of GreenGenes. |

## Reference documentation
- [PICRUSt Overview](./references/anaconda_org_channels_bioconda_packages_picrust_overview.md)