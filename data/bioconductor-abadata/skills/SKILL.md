---
name: bioconductor-abadata
description: This package provides gene expression data from the Allen Human Brain Atlas and BrainSpan Atlas for various brain regions and developmental stages. Use when user asks to load adult or developing human brain expression datasets, access developmental effect scores, or retrieve brain-specific gene expression values for protein-coding genes.
homepage: https://bioconductor.org/packages/3.6/data/experiment/html/ABAData.html
---


# bioconductor-abadata

name: bioconductor-abadata
description: Access and utilize gene expression data from the Allen Brain Atlas (ABA) for human brain regions. Use this skill when you need to load averaged gene expression datasets for adults, developing human brains (across five age categories), or developmental effect scores. This data is primarily used as a backend for the 'ABAEnrichment' package but can be used independently for brain-specific gene expression analysis.

## Overview
The `ABAData` package provides processed gene expression data derived from the Allen Human Brain Atlas and the BrainSpan Atlas of the Developing Human Brain. It serves as the data foundation for the `ABAEnrichment` package. The datasets are restricted to protein-coding genes and include HGNC symbols, Entrez IDs, and Ensembl IDs, mapped to specific brain structures using the Allen Brain Atlas ontology.

## Data Loading and Exploration
The package contains three primary datasets that can be loaded using the `data()` function.

### 1. Adult Brain Expression
Contains microarray expression data from six adult individuals, averaged across donors.
```r
library(ABAData)
data(dataset_adult)
head(dataset_adult)
```

### 2. Developing Brain Expression (5 Stages)
Contains RNA-seq data from 42 individuals grouped into five developmental stages, averaged across donors.
```r
data(dataset_5_stages)
head(dataset_5_stages)
```
**Age Categories:**
* 0: All stages
* 1: Prenatal
* 2: Infant (0-2 years)
* 3: Child (3-11 years)
* 4: Adolescent (12-19 years)
* 5: Adult (>19 years)

### 3. Developmental Effect Score
Contains scores measuring the effect of age on gene expression per brain region.
```r
data(dataset_dev_effect)
head(dataset_dev_effect)
```

## Data Structure
All three datasets share a consistent data frame structure:
* `hgnc_symbol`: HGNC gene symbols.
* `entrezgene`: Entrez gene identifiers.
* `ensembl_gene_id`: Ensembl gene identifiers.
* `structure`: Brain region ID (consistent with Allen Brain Atlas ontology).
* `signal`: The value (normalized microarray, RNA-seq, or effect score).
* `age_category`: Numeric code for the developmental stage.

## Typical Workflow
1. **Identify Genes of Interest**: Filter the datasets by Ensembl ID or HGNC symbol to see expression patterns across brain regions.
2. **Filter by Region**: Use the `structure` column to isolate specific brain areas.
3. **Developmental Analysis**: Compare `signal` values across different `age_category` levels in `dataset_5_stages`.
4. **Enrichment Preparation**: Use these datasets to verify or supplement results obtained from the `ABAEnrichment` package.

## Tips
* The `structure` IDs refer to the Allen Brain Atlas ontology. To map these IDs to full names, you typically use the tools provided in the `ABAEnrichment` package.
* All datasets are pre-filtered for protein-coding genes only.
* If you are performing enrichment analysis, ensure your input gene list uses one of the three supported ID types (HGNC, Entrez, or Ensembl).

## Reference documentation
- [ABAData Reference Manual](./references/reference_manual.md)