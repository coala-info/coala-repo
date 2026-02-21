---
name: bioconductor-airway
description: "the package vignette. The citation for the experiment is: Himes BE, Jiang X, Wagner P, Hu R, Wang Q, Klanderman B, Whitaker RM, Duan Q, Lasky-Su J, Nikolos C, Jester W, Johnson M, Panettieri R Jr, Tantisira KG, Weiss ST, Lu Q. 'RNA-Seq Transcriptome Profiling Identifies CRISPLD2 as a Glucocorticoid Responsive Gene that Modulates Cytokine Function in Airway Smooth Muscle Cells.' PLoS One. 2014 Jun 13;9(6):e99625. PMID: 24926665. GEO: GSE52778."
homepage: https://bioconductor.org/packages/release/data/experiment/html/airway.html
---

# bioconductor-airway

name: bioconductor-airway
description: Provides specialized knowledge and workflows for the Bioconductor 'airway' experiment data package. Use this skill when a user needs to load, explore, or analyze the RNA-Seq dataset from Himes et al. (2014) involving human airway smooth muscle cells treated with dexamethasone.

## Overview
The `airway` package provides a `RangedSummarizedExperiment` object containing gene-level read counts for an experiment where four primary human airway smooth muscle (ASM) cell lines were treated with 1 micromolar dexamethasone for 18 hours. This dataset is a standard benchmark in Bioconductor for demonstrating differential expression analysis workflows (e.g., DESeq2, edgeR).

## Loading the Data
To access the primary dataset, use the `data()` function.

```r
library(airway)
data("airway")

# The object is named 'airway'
airway
```

## Key Workflows

### 1. Exploring the SummarizedExperiment
The `airway` object contains counts, sample metadata, and genomic ranges.

```r
# View sample metadata (colData)
colData(airway)

# View gene metadata (rowData)
rowData(airway)

# Access the raw count matrix
assay(airway, "counts")[1:5, 1:5]

# Check library sizes (total counts per sample)
colSums(assay(airway))
```

### 2. Experimental Design
The dataset includes 8 samples. The key variables in `colData(airway)` are:
- `cell`: The cell line ID (N61311, N052611, N080611, N061011).
- `dex`: Treatment status (`trt` for dexamethasone, `untrt` for control).

For differential expression, you typically control for the cell line (paired analysis):
`design = ~ cell + dex`

### 3. Accessing Genomic Information
The object includes GRanges information for the genes based on Ensembl release 75 (GRCh37).

```r
# View genomic coordinates for the features
rowRanges(airway)

# View metadata about the genome build
metadata(rowRanges(airway))
```

### 4. Using the 'gse' Object
Recent versions include a `gse` object, which is the result of `tximeta` and `summarizeToGene` processing, useful for workflows starting from transcript-level quantification.

```r
data("gse")
# This provides a similar SummarizedExperiment structure
```

## Tips for Analysis
- **Filtering**: Before running differential expression, filter out genes with very low counts (e.g., `keep <- rowSums(counts(airway)) >= 10`).
- **Normalization**: Use `DESeq2` or `edgeR` to normalize the counts; do not use raw counts for visualization or clustering.
- **Metadata**: The `metadata(airway)` slot contains MIAME (Minimum Information About a Microarray Experiment) information, including the PubMed ID and abstract.

## Reference documentation
- [Airway smooth muscle cells](./references/airway.md)