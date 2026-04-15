---
name: bioconductor-blma
description: Bioconductor-blma performs bi-level meta-analysis to integrate multiple omics datasets at both intra-experiment and inter-experiment levels. Use when user asks to combine p-values using the Central Limit Theorem, perform bi-level differential expression analysis, or integrate pathway and gene set enrichment results across multiple studies.
homepage: https://bioconductor.org/packages/release/bioc/html/BLMA.html
---

# bioconductor-blma

name: bioconductor-blma
description: Bi-level meta-analysis (BLMA) for integrating multiple omics datasets. Use this skill when you need to perform meta-analysis at both intra-experiment (splitting datasets to increase power) and inter-experiment levels. It supports classical hypothesis testing (t-test, Wilcoxon), differential expression analysis (limma-based), and pathway/gene set enrichment analysis (ORA, GSA, PADOG, Impact Analysis).

## Overview
The BLMA package implements a bi-level meta-analysis framework. It improves statistical power by first analyzing data within an experiment (intra-analysis) and then combining results across multiple independent experiments (inter-analysis). It is particularly useful for integrating heterogeneous datasets from different laboratories or platforms.

## Core Functions and Workflows

### 1. Combining P-values
BLMA provides several methods for combining independent p-values. The default and recommended method is `addCLT`, based on the Central Limit Theorem.
- `addCLT(p_values)`: Combines p-values using the Irwin-Hall distribution.
- `fisherMethod(p_values)`: Classical Fisher's combination.
- `stoufferMethod(p_values)`: Stouffer's Z-score method.

### 2. Classical Hypothesis Testing
Use these functions to apply BLMA to standard tests like `t.test` or `wilcox.test`.

- **Intra-experiment analysis**:
  ```r
  # Performs test by splitting the dataset internally
  intraAnalysisClassic(x, func=t.test, mu=1, alternative="less")
  ```
- **Bi-level meta-analysis**:
  ```r
  # Combines multiple datasets (lists of vectors)
  bilevelAnalysisClassic(x=list_of_x, y=list_of_y, func=t.test, alternative="greater")
  ```

### 3. Gene Set and Pathway Analysis
Integrate enrichment results across multiple studies.

- **Using ORA (Fastest)**:
  ```r
  # dataList and groupList are lists of expression matrices and group labels
  ORAComb <- bilevelAnalysisGeneset(gslist, gs.names, dataList, groupList, enrichment = "ORA")
  ```
- **Using Topology-based Impact Analysis (IA)**:
  ```r
  # Requires pathway graphs (graphNEL)
  IAComb <- bilevelAnalysisPathway(kpg, kpn, dataList, groupList)
  ```
- **Other methods**: Set `enrichment` to "GSA" or "PADOG". Use `mc.cores` for parallel processing on non-ORA methods.

### 4. Differential Expression Analysis
Uses `limma` as the underlying engine for gene-level meta-analysis.

- **Intra-experiment (Single Dataset)**:
  ```r
  # Returns logFC, pLimma, and pIntra (the BLMA p-value)
  res <- intraAnalysisGene(data_matrix, group_vector)
  ```
- **Bi-level (Multiple Datasets)**:
  ```r
  # Combines intra-analysis results across all datasets in the lists
  res_meta <- bilevelAnalysisGene(dataList = dataList, groupList = groupList)
  ```

### 5. Network-based Integrative Analysis
To get comprehensive statistics (effect sizes and p-values) for downstream network tools:
```r
geneStat <- getStatistics(allGenes, dataList = dataList, groupList = groupList)
# Use geneStat$pLeft, geneStat$pRight, and geneStat$ES (Effect Size) for analysis
```

## Tips for Success
- **Data Preparation**: Ensure gene identifiers (e.g., Entrez IDs) are consistent across all datasets in `dataList`.
- **Group Labels**: `groupList` should contain factors or vectors where "1" typically represents the condition/disease and "0" represents control.
- **Pathway Loading**: Use `loadKEGGPathways()` to quickly retrieve human KEGG pathways formatted for BLMA.
- **Method Selection**: While `addCLT` is the default for combining p-values, you can pass `metaMethod=fisherMethod` to most functions if classical Fisher's is required.

## Reference documentation
- [BLMA: A package for bi-level meta-analysis](./references/BLMA.md)