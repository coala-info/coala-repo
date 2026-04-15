---
name: bioconductor-tissueenrich
description: This package performs functional enrichment analysis to identify tissue-specific gene enrichment within a set of input genes using built-in or custom expression datasets. Use when user asks to perform tissue enrichment analysis, identify tissue-specific genes from expression data, or test gene lists against HPA, GTEx, or mouse ENCODE datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/TissueEnrich.html
---

# bioconductor-tissueenrich

## Overview

The `TissueEnrich` package performs functional enrichment analysis to determine if a set of input genes is enriched for tissue-specific genes. It leverages pre-processed datasets from the Human Protein Atlas (HPA), GTEx, and mouse ENCODE. The package classifies genes into categories like "Tissue Enriched," "Group Enriched," and "Tissue Enhanced" based on their expression profiles. It also provides tools to define these categories for custom user-provided expression data.

## Core Workflow

### 1. Enrichment with Built-in Datasets
To test a gene list against standard human or mouse tissue data, use the `teEnrichment` function.

```R
library(TissueEnrich)
library(GSEABase)

# 1. Prepare input genes as a GeneSet object
# Supports SymbolIdentifier() or ENSEMBLIdentifier()
input_genes <- c("CGA", "GCM1", "CYP19A1") 
gs <- GeneSet(geneIds=input_genes, organism="Homo Sapiens", geneIdType=SymbolIdentifier())

# 2. Run enrichment
# rnaSeqDataset: 1 (HPA - default), 2 (GTEx), 3 (Mouse ENCODE)
# tissueSpecificGeneType: 1 (All - default), 2 (Enriched), 3 (Enhanced), 4 (Group)
output <- teEnrichment(inputGenes = gs, rnaSeqDataset = 1)
```

### 2. Defining Tissue-Specific Genes from Custom Data
If you have your own expression matrix (rows=genes, columns=tissues), use `teGeneRetrieval`.

```R
# Input: SummarizedExperiment with expression values (TPM/FPKM)
se <- SummarizedExperiment(assays = SimpleList(as.matrix(expressionData)))

# Identify tissue-specific genes
custom_genes <- teGeneRetrieval(se)
# Result contains Gene, Tissue, and Group (e.g., Tissue-Enriched)
```

### 3. Enrichment with Custom Datasets
Use `teEnrichmentCustom` to test a gene list against the tissue-specific genes defined in the previous step.

```R
# gs: GeneSet of interest
# custom_genes: Output from teGeneRetrieval
output_custom <- teEnrichmentCustom(gs, custom_genes)
```

## Interpreting Results

The output of enrichment functions is a list containing four objects:

1.  **Enrichment Results**: A `SummarizedExperiment` containing `-Log10(P-Value)`, `fold.change`, and the count of `Tissue.Specific.Genes` found in the input.
2.  **Expression Data**: A list of expression values for the identified tissue-specific genes across all tissues (useful for heatmaps).
3.  **Gene Details**: A list containing the specific genes identified for each tissue and their specificity group.
4.  **Unmapped Genes**: A `GeneSet` containing input genes that could not be found in the reference dataset.

## Key Parameters and Tips

*   **Organism**: Ensure the `organism` parameter in the `GeneSet` matches the reference data. The package supports "Homo Sapiens" and "Mus Musculus".
*   **Orthologous Mapping**: The package automatically handles orthologous enrichment (e.g., human gene list against mouse tissues) if the `organism` in the `GeneSet` differs from the `rnaSeqDataset` species.
*   **Background Genes**: You can provide a background gene set to `teEnrichment` to refine the hypergeometric test. The background must contain all genes in the input set.
*   **Multiple Testing**: Benjamini-Hochberg correction is applied by default (`multiHypoCorrection = TRUE`).

## Reference documentation

- [TissueEnrich: A tool to calculate tissue-specific gene enrichment](./references/TissueEnrich.md)