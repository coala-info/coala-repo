---
name: bioconductor-condiments
description: Bioconductor-condiments analyzes differential trajectory patterns in single-cell data across multiple experimental conditions. Use when user asks to compare cell trajectories between experimental groups, test for differences in trajectory topology, analyze progression along pseudotime, or evaluate lineage fate selection.
homepage: https://bioconductor.org/packages/release/bioc/html/condiments.html
---


# bioconductor-condiments

name: bioconductor-condiments
description: Analysis of differential trajectory patterns in single-cell data across multiple conditions. Use when comparing cell trajectories between experimental groups to test for differences in topology (structure), progression (density along pseudotime), or fate selection (lineage choice).

# bioconductor-condiments

## Overview

The `condiments` package provides a framework for comparing trajectories across experimental conditions, typically in single-cell RNA-seq data. It allows researchers to determine if conditions share a common differentiation path or if the experimental variables alter the trajectory structure, the rate of differentiation, or the fate decisions at branching points. It integrates closely with `slingshot` for trajectory inference and `tradeSeq` for gene-level differential expression.

## Core Workflow

### 1. Exploratory Imbalance Analysis
Before testing trajectories, use the imbalance score to identify regions of the reduced dimension space where conditions are not well-mixed. This helps identify potential condition-specific populations or integration artifacts.

```r
library(condiments)
# rd: matrix of reduced dimensions; conditions: vector of condition labels
scores <- imbalance_score(Object = rd, conditions = conditions, k = 10)
# scores$scores contains raw scores; scores$scaled_scores contains smoothed scores
```

### 2. Differential Topology
Test whether a common trajectory can be used for all conditions or if separate trajectories must be inferred.

```r
library(slingshot)
# Infer a common trajectory first
sds <- slingshot(rd, cluster_labels)

# Test if the common trajectory is valid across conditions
top_res <- topologyTest(sds = sds, conditions = conditions, rep = 100)
# A significant p-value suggests conditions have different underlying structures
```

### 3. Differential Progression
If a common trajectory is valid, test if cells from different conditions are distributed differently along pseudotime within a specific lineage.

```r
# Test for differences in density along pseudotime
prog_res <- progressionTest(sds, conditions = conditions, global = TRUE, lineages = TRUE)
```

### 4. Differential Fate Selection
For trajectories with multiple lineages (bifurcations), test if cells from one condition preferentially choose one path over another.

```r
# Test for differences in lineage weights between conditions
fate_res <- fateSelectionTest(sds, conditions = conditions, global = TRUE)
```

### 5. Differential Expression
After identifying global trajectory differences, use `tradeSeq` to find specific genes associated with these changes.

```r
library(tradeSeq)
# Fit GAM with conditions
sce <- fitGAM(counts = counts, sds = sds, conditions = conditions)
# Test for condition-specific expression patterns
cond_genes <- conditionTest(sce)
```

## Advanced Usage Tips

- **Parallelization**: `topologyTest` can be slow on large datasets. Use the `parallel = TRUE` argument with a `BPPARAM` object from `BiocParallel`.
- **Test Methods**: Both `progressionTest` and `fateSelectionTest` support different statistical methods (e.g., "KS", "Classifier"). The Classifier test is often more robust for complex distributions.
- **Multiple Testing**: Always correct p-values for multiple testing when dealing with many lineages or pairs of conditions.
- **Integration Check**: High imbalance scores in regions that should be biologically similar may indicate that data integration (e.g., via Seurat or Harmony) was insufficient.

## Reference documentation

- [Overview of the condiments workflow](./references/condiments.md)
- [More controls for the tests used in the condiments workflow](./references/controls.md)
- [Generating toy datasets](./references/examples.md)