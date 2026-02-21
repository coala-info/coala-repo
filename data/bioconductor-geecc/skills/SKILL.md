---
name: bioconductor-geecc
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/geecc.html
---

# bioconductor-geecc

name: bioconductor-geecc
description: Gene Set Enrichment Analysis (GSEA) using log-linear models for 2x2 and 2x2x2 contingency tables. Use this skill to perform enrichment analysis between two or three categories (e.g., differentially expressed genes, GO terms, and a third variable like sequence length or GC content) to detect mutual independence, joint independence, or three-way interactions.

# bioconductor-geecc

## Overview

The `geecc` package (Gene Set Enrichment with Contingency Tables) extends standard gene set enrichment analysis by allowing the inclusion of a third category. While traditional tools use 2x2 tables (e.g., Gene in List vs. Gene in GO Term), `geecc` uses log-linear models to analyze 2x2x2 tables. This helps identify if enrichment patterns are biased by a third factor, such as sequence length, chromosomal position, or GC content, effectively addressing Simpson's Paradox in genomic data.

## Core Workflow

### 1. Data Preparation
Data must be organized into a named list of lists. Each top-level list represents a category, and the inner lists represent variables (levels) within that category containing gene IDs.

```R
library(geecc)
library(GO.db)

# Category 1: Differential Expression (Variables: up, down)
cat_deg <- list(up = c("gene1", "gene2"), down = c("gene3", "gene4"))

# Category 2: Gene Sets (Variables: GO IDs)
# GO2list is a helper to convert DB mappings to the required list format
cat_go <- GO2list(db = hgu133plus2GO2PROBE, go.cat = "CC")

# Category 3: Sequence Length (Variables: quantiles)
# Split genes into bins (e.g., 0-33%, 33-66%, 66-100%)
cat_len <- split(all_genes, length_factor)

# Combine into a master list
CatList <- list(deg = cat_deg, go = cat_go, len = cat_len)
```

### 2. Initialize Objects
You must define a `concubfilter` (to set thresholds) and a `concub` object (to define the model).

```R
# Define filters
CCF.obj <- new("concubfilter", 
               names = names(CatList), 
               p.value = 0.05, 
               test.direction = "two.sided")

# Define the analysis model
# null.model options: 
# ~deg+go (2-way)
# ~deg+go+len (3-way mutual independence)
# ~deg+go*len (3-way joint independence)
# ~len*go+deg*go+deg*len (3-way no interaction)
CC.obj <- new("concub", 
              categories = CatList, 
              population = all_gene_ids, 
              null.model = ~deg+go+len)
```

### 3. Run and Filter Tests
The `runConCub` function performs the statistical tests (hypergeometric or chi-squared), and `filterConCub` applies the filters and p-value adjustments.

```R
# Run tests (supports parallel processing)
CC.obj2 <- runConCub(obj = CC.obj, filter = CCF.obj, nthreads = 4)

# Apply multiple testing correction (e.g., Benjamini-Hochberg)
CC.obj3 <- filterConCub(obj = CC.obj2, filter = CCF.obj, p.adjust.method = "BH")
```

### 4. Visualization and Results
Results are typically visualized as heatmaps where colors represent log2 odds ratios and stars indicate significance levels.

```R
# Plot heatmap
plotConCub(obj = CC.obj3, filter = CCF.obj, col = list(range = c(-5, 5)))

# Extract results as a data frame
results_table <- getTable(obj = CC.obj3, na.rm = TRUE)
```

## Key Null Models for 3-Way Analysis

| Model Formula | Description |
| :--- | :--- |
| `~A+B+C` | **Mutual Independence**: All three categories are independent. |
| `~A+B*C` | **Joint Independence**: Category A is independent of the joint distribution of B and C. |
| `~A*B+B*C+A*C` | **Homogenous Association**: No three-way interaction; pairwise associations exist but are consistent across the third variable. |

## Tips
- **Test Direction**: Use `"greater"` for over-representation, `"less"` for under-representation, or `"two.sided"` for both.
- **Ordinal Variables**: If a category is ordinal (like sequence length bins), use `options = list(category_name = list(grouping = "cumf"))` in the `concub` object to perform cumulative tests.
- **Small Samples**: The package automatically switches between hypergeometric tests (accurate for small counts) and chi-squared approximations (faster for large tables) based on the `approx` parameter.

## Reference documentation
- [geecc - searching for associations between gene sets](./references/geecc.md)