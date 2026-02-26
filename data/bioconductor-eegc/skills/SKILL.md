---
name: bioconductor-eegc
description: bioconductor-eegc evaluates cellular engineering processes by comparing gene expression data across input, output, and target reference samples. Use when user asks to categorize gene induction status, evaluate cell fate conversion efficiency, or perform gene regulatory network analysis on engineered cells.
homepage: https://bioconductor.org/packages/3.8/bioc/html/eegc.html
---


# bioconductor-eegc

name: bioconductor-eegc
description: Evaluation of cellular engineering processes (differentiation or transdifferentiation) using gene expression data. Use this skill to compare three sample types—input (somatic/stem cells), output (induced cells), and reference (target primary cells)—to categorize genes into five states (Successful, Inactive, Insufficient, Over, Reversed) and perform functional, tissue-specific, and gene regulatory network (GRN) analyses.

## Overview

The `eegc` package evaluates the efficiency of cell fate conversion by analyzing the transcriptional distance between engineered cells and their target primary counterparts. It moves beyond simple differential expression by categorizing genes based on their "induction status" relative to a starting population and a gold-standard reference.

## Typical Workflow

### 1. Data Preparation
Input data should be a matrix of gene expression (FPKM or counts) with genes in rows and samples in columns. You need samples representing the starting state (from), the engineered state (to), and the target state (target).

```r
library(eegc)
data(SandlerFPKM) # Example dataset
# Samples: DMEC (input), rEChMPP (output), CB (target)
```

### 2. Differential Gene Analysis
Use `diffGene` to perform pair-wise comparisons. It uses `limma` for FPKM/microarray data and `DESeq2` for counts.

```r
diff_results = diffGene(expr = SandlerFPKM, 
                        array = FALSE, fpkm = TRUE, counts = FALSE,
                        from.sample = "DMEC", 
                        to.sample = "rEChMPP", 
                        target.sample = "CB",
                        filter = TRUE, pvalue = 0.05)

expr_filter = diff_results[[3]] # Filtered expression matrix
diff_genes = diff_results[[2]]  # List of differential genes
```

### 3. Gene Categorization
The core of `eegc` is categorizing genes based on the Expression Difference (ED) ratio:
$ED\_ratio = \frac{Output - Input}{Target - Input}$

```r
categories = categorizeGene(expr = expr_filter, 
                            diffGene = diff_genes,
                            from.sample = "DMEC", 
                            to.sample = "rEChMPP", 
                            target.sample = "CB")

# Access categories: categories[[1]]$Successful, categories[[1]]$Inactive, etc.
```

| Category | Description |
| :--- | :--- |
| **Successful** | Induced cells reached target primary cell levels. |
| **Inactive** | Genes failed to change from the input state. |
| **Insufficient** | Genes changed but did not reach target levels. |
| **Over** | Genes induced far beyond the target level. |
| **Reversed** | Genes regulated in the opposite direction of the target. |

### 4. Visualization and Quantification
Visualize the distribution of categories and specific marker genes.

```r
# Density plot of ED ratios to see global engineering success
densityPlot(categories[[2]], proportion = TRUE)

# Scatter plot for specific categories (e.g., Successful, Inactive)
data(markers)
markerScatter(expr = expr_filter, samples = c("CB", "rEChMPP"), 
              cate.gene = categories[[1]][2:4], markers = markers)
```

### 5. Functional and Tissue Enrichment
Identify which biological functions or tissue-specific signatures are missing (Inactive) or successfully acquired.

```r
# GO/KEGG Enrichment
go_enrich = functionEnrich(categories[[1]], organism = "human", GO = TRUE)

# Tissue-specific enrichment (requires tissueGenes and tissueGroup data)
data(tissueGenes); data(tissueGroup)
tissue_enrich = enrichment(cate.gene = categories[[1]], 
                           annotated.gene = tissueGenes, 
                           background.gene = rownames(expr_filter))

# Plot results
heatmapPlot(tissue_enrich, GO = FALSE)
```

### 6. Gene Regulatory Network (GRN) Analysis
Evaluate the importance of specific Transcription Factors (TFs) in the engineering process using CellNet-based GRNs.

```r
data(human.grn); data(human.tf)

# TF Enrichment
tf_enrich = enrichment(cate.gene = categories[[1]], 
                       annotated.gene = human.tf, 
                       background.gene = rownames(expr_filter))

# Network Topological Analysis (Degree Centrality)
degree_scores = networkAnalyze(human.grn[["Hspc"]], 
                               cate.gene = categories[[1]], 
                               centrality = "degree")

# Plot GRN for specific nodes
grnPlot(grn.data = human.grn[["Hspc"]], 
        cate.gene = categories[[1]], 
        nodes = c("ZNF641", "BCL6"))
```

## Reference documentation

- [Engineering Evaluation by Gene Categorization of Microarray and RNA-seq Data with eegc package](./references/eegc.md)