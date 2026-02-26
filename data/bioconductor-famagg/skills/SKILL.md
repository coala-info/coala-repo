---
name: bioconductor-famagg
description: The FamAgg package provides a framework for analyzing the familial aggregation of traits and identifying non-random clustering of cases within large pedigrees. Use when user asks to analyze pedigree data, calculate kinship between individuals, visualize family trees, or perform statistical tests like the Genealogical Index of Familiality and Kinship Sum Test to identify genetic clustering.
homepage: https://bioconductor.org/packages/release/bioc/html/FamAgg.html
---


# bioconductor-famagg

## Overview

The `FamAgg` package provides a framework for analyzing familial aggregation of traits in large pedigrees. It extends the `kinship2` package to offer advanced statistical tests for identifying non-random clustering of cases within families. This is particularly useful for selecting individuals for sequencing projects or understanding the genetic architecture of complex traits.

## Core Workflow

### 1. Data Initialization
Pedigree data can be loaded from a `data.frame` or imported from external files (PLINK `.ped`/`.fam` or generic text).

```r
library(FamAgg)

# From a data.frame
# Required columns: family, id, father, mother, sex
fad <- FAData(pedigree = my_ped_df)

# From a PLINK file
fad <- FAData("path/to/data.ped")

# Adding trait information (0 = unaffected, 1 = affected)
trait(fad) <- my_trait_vector # names must match individual IDs
```

### 2. Pedigree Operations and Visualization
`FamAgg` provides utilities to navigate and subset complex family trees.

*   **Plotting**: Use `plotPed` to visualize families. It automatically highlights affected individuals if a trait is set.
    ```r
    plotPed(fad, family = "101")
    # Prune to specific individuals and their ancestors/paths
    plotPed(fad, id = c("ID1", "ID2"), prune = TRUE)
    ```
*   **Navigation**: Retrieve relatives using specific methods.
    ```r
    getAncestors(fad, id = "ID1")
    getChildren(fad, id = "ID1")
    getSiblings(fad, id = "ID1")
    getCommonAncestor(fad, id = c("ID1", "ID2"))
    ```
*   **Kinship**: Calculate individuals sharing kinship above a threshold.
    ```r
    shareKinship(fad, id = "ID1", rmKinship = 0.125) # Exclude beyond first cousins
    ```

### 3. Statistical Tests for Familial Aggregation
The package implements several methods to test if cases cluster more than expected by chance.

*   **Genealogical Index of Familiality (GIF)**: Tests the mean kinship between all affected individuals against random permutations.
    ```r
    gi <- genealogicalIndexTest(fad, nsim = 1000)
    result(gi)
    ```
*   **Familial Incidence Rate (FIR)**: Calculates a per-individual risk score based on kinship to affected individuals and "time at risk" (e.g., age).
    ```r
    fr <- familialIncidenceRateTest(fad, timeAtRisk = fad$age, nsim = 1000)
    ```
*   **Kinship Sum Test**: Identifies specific affected individuals who are significantly more related to other cases than expected.
    ```r
    ks <- kinshipSumTest(fad, strata = fad$sex, nsim = 1000)
    ```
*   **Kinship Group Test**: Identifies highly clustered subgroups of affected individuals within families.
    ```r
    kg <- kinshipGroupTest(fad, nsim = 1000)
    ```
*   **Binomial Test**: A simple test for enrichment of cases in a family, ignoring kinship structure.
    ```r
    bt <- binomialTest(fad, prob = 0.05) # prob = population prevalence
    ```

## Tips for Effective Use
*   **Singletons**: Most kinship-based tests automatically exclude singletons (unconnected individuals). Use `removeSingletons(pedigree(fad))` to clean data manually.
*   **Stratification**: When performing permutation tests (GIF, Kinship Sum), use the `strata` argument (e.g., `strata = fad$sex`) to ensure random samples match the observed distribution of covariates.
*   **Generations**: Use `estimateGenerations(fad)` to determine the depth of a pedigree starting from founders.
*   **Graph Integration**: Convert pedigrees to `igraph` objects using `ped2graph(pedigree(fad))` for advanced network analysis.

## Reference documentation
- [Pedigree Analysis and Familial Aggregation](./references/FamAgg.md)