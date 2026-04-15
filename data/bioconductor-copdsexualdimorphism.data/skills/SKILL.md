---
name: bioconductor-copdsexualdimorphism.data
description: This package provides access to clinical, gene expression, and DNA methylation data from the Lung Genomic Research Consortium for studying sexual dimorphism in COPD. Use when user asks to load LGRC datasets, access COPD clinical metadata, or retrieve lung-specific gene expression and methylation profiles.
homepage: https://bioconductor.org/packages/release/data/experiment/html/COPDSexualDimorphism.data.html
---

# bioconductor-copdsexualdimorphism.data

name: bioconductor-copdsexualdimorphism.data
description: Access and utilize the Lung Genomic Research Consortium (LGRC) dataset for studying sexual dimorphism in Chronic Obstructive Pulmonary Disease (COPD). Use this skill to load clinical metadata, gene expression profiles, and DNA methylation data from the LGRC cohort.

## Overview

The `COPDSexualDimorphism.data` package provides processed genomic data from the Lung Genomic Research Consortium (LGRC). It contains clinical, expression, and methylation data for over 200 subjects, specifically curated to support methods for identifying sex-specific genetic determinants of COPD.

## Data Loading and Exploration

The package uses the standard R `data()` mechanism to load datasets.

### Clinical Metadata
The `lgrc.meta` dataset contains clinical phenotypes for 254 samples.
```r
library(COPDSexualDimorphism.data)
data(lgrc.meta)
# The object is named 'meta'
head(meta)
```
Key fields include:
- `GENDER`: Patient sex.
- `age`: Patient age.
- `pkyrs`: Pack-years of smoking.
- `diagmaj`: Major diagnosis (e.g., COPD/Emphysema vs. Control).
- `tissueid` / `newid`: Identifiers for samples and subjects.

### Gene Expression Data
Expression data is split into the numeric matrix and the corresponding sample metadata.
```r
data(lgrc.expr)
data(lgrc.expr.meta)
# 'expr' is a matrix: 14,497 Ensembl genes x 229 samples
# 'expr.meta' contains clinical data for these 229 samples
dim(expr)
head(expr.meta)
```

### Gene Annotations
To map Ensembl IDs to symbols and genomic locations:
```r
data(lgrc.genes)
# Contains hgnc_symbol, description, chromosome, and entrezgene IDs
head(lgrc.genes)
```

### Methylation Data
Percent methylation for 12,094 Variably Methylated Regions (VMRs).
```r
data(lgrc.methp)
# 'methp' contains average MAD, length, and probe counts per VMR
head(methp[, c("name", "ave.mad", "length", "num.probes")])
```

## Typical Workflow

1. **Load Data**: Initialize the library and load the specific data type (expression or methylation).
2. **Filter/Subset**: Use `expr.meta` or `meta` to identify specific cohorts (e.g., only COPD patients or only Females).
3. **Match Samples**: Ensure the columns of the expression matrix match the rows of the metadata.
4. **Analysis**: Pass these objects to the `COPDSexualDimorphism` analysis package or standard Bioconductor differential expression tools (like `limma`).

## Tips
- **Sample IDs**: Note that `tissueid` identifies the specific lung sample (which may include multiple samples per subject from different lobes), while `newid` identifies the unique subject.
- **Data Alignment**: In `lgrc.expr` and `lgrc.expr.meta`, subjects are already arranged in the same order.

## Reference documentation

- [Gene Expression and Methylation from Lung Genomic Research Consortium (LGRC)](./references/lgrc_data.md)