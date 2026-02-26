---
name: r-poppr
description: The R package poppr provides specialized tools for the genetic analysis of populations exhibiting mixed sexual and asexual reproduction. Use when user asks to perform clonal analysis, calculate the Index of Association, compute genetic distances like Bruvo's distance, perform AMOVA, or assess genotypic diversity.
homepage: https://cloud.r-project.org/web/packages/poppr/index.html
---


# r-poppr

name: r-poppr
description: Expert guidance for the R package 'poppr' used in genetic analysis of populations with mixed reproduction (sexual and asexual). Use this skill when performing population genetic analyses on partially clonal populations, calculating the Index of Association (Ia and rbarD), computing genetic distances (including Bruvo's distance), performing AMOVA, or assessing genotypic diversity (Shannon, Stoddart & Taylor, Evenness).

## Overview

`poppr` is an R package designed for the analysis of populations that exhibit both sexual and asexual reproduction. It builds upon the `adegenet` framework (using `genind` and `genlight` objects) to provide specialized tools for clonal analysis, linkage disequilibrium detection, and diversity estimation.

## Installation

```R
install.packages("poppr")
library("poppr")
```

## Core Workflows

### 1. Data Import and Preparation
`poppr` uses `genind` (microsatellites/codominant) or `genlight` (SNPs) objects.
- Import from CSV: `read.genalex()` or `df2genind()`.
- Convert to poppr-specific clone object: `as.genclone(my_genind)`.
- Clone correction: `clonecorrect(my_data, strata = ~Population)` to remove redundant genotypes for specific analyses.

### 2. Genotypic Diversity and Summary Statistics
Use the `poppr()` function for a comprehensive summary table of a dataset.
- **Summary Table**: `poppr(my_data)` returns N, number of MLGs, expected heterozygosity (Hexp), Evenness (E.5), and Index of Association.
- **Diversity Indices**: `diversity_stats(my_data)` calculates Shannon-Wiener (H), Stoddart and Taylor (G), and Simpson's (lambda) indices.

### 3. Linkage Disequilibrium (Index of Association)
To test for clonal vs. sexual reproduction:
- **Standard Index**: `ia(my_data, sample = 999)` calculates $I_A$ and $\bar{r}_d$.
- **Interpretation**: A significant $\bar{r}_d$ (p < 0.05) suggests non-random association of alleles (clonality/linkage). $\bar{r}_d$ is preferred over $I_A$ as it is independent of the number of loci.

### 4. Genetic Distances
`poppr` provides several distance measures tailored for different marker types:
- **Bruvo's Distance**: `bruvo.dist(my_data, replen = c(2, 2, 4))` for microsatellites; accounts for stepwise mutation and varying ploidy.
- **Prevosti's Distance**: `prevosti.dist(my_data)` for absolute genetic distance (no evolutionary model assumed).
- **Other Distances**: `nei.dist()`, `edwards.dist()`, `reynolds.dist()`, `rogers.dist()`, and `diss.dist()`.

### 5. Population Structure (AMOVA)
Perform Analysis of Molecular Variance to partition diversity across hierarchical levels:
- **Workflow**:
  1. Define strata: `strata(my_data) <- my_df`
  2. Run AMOVA: `res <- poppr.amova(my_data, ~Region/Population)`
  3. Significance testing: `randtest(res)`

### 6. Clonal Analysis (MLGs and Psex)
- **Assign MLGs**: `mlg.filter(my_data, threshold = 0.05, distance = bitwise.dist)` collapses genotypes within a distance threshold into a single MLG.
- **Probability of Genotypes**: `pgen(my_data)` calculates the probability of a multilocus genotype occurring.
- **Probability of Sex**: `psex(my_data)` calculates the probability that a repeated genotype originated from a sexual event.

## Tips and Best Practices
- **Missing Data**: For Bruvo's distance, use the `add` and `loss` arguments to handle missing alleles in polyploids (default is the Combination Model).
- **Visualization**: Use `plot_poppr_msn()` to create Minimum Spanning Networks, which are highly effective for visualizing relationships between MLGs.
- **Bitwise Distance**: For large SNP datasets (`genlight` objects), use `bitwise.dist()` for high-speed distance calculations.

## Reference documentation
- [Algorithms and equations utilized in poppr](./references/algo.md)