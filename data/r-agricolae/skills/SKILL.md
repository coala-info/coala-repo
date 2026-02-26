---
name: r-agricolae
description: The r-agricolae package provides statistical procedures for agricultural research, including experimental design, treatment comparisons, and stability analysis. Use when user asks to design agricultural experiments, generate randomized field books, perform post-hoc tests like LSD or Tukey, or conduct AMMI stability analysis.
homepage: https://cloud.r-project.org/web/packages/agricolae/index.html
---


# r-agricolae

name: r-agricolae
description: Statistical procedures for agricultural research, including experimental design (Lattice, Alpha, RCBD, Split-plot), treatment comparisons (LSD, Duncan, Tukey, Waller-Duncan), non-parametric tests, and stability analysis (AMMI). Use this skill when designing agricultural experiments, generating field books, or performing specialized post-hoc analysis on agronomic data.

# r-agricolae

## Overview
The `agricolae` package is a comprehensive toolset for agricultural research and plant breeding. It provides specialized functionality for planning experimental designs, generating randomized field books, and performing advanced statistical analysis including multiple comparison tests, non-parametric analysis, and genotype-by-environment interaction (GEI) models like AMMI.

## Installation
To install the package from CRAN:
```r
install.packages("agricolae")
library(agricolae)
```

## Experimental Design
`agricolae` generates field books and randomization sketches for various designs.

### Common Designs
*   **Completely Randomized (CRD):** `design.crd(trt, r, seed)`
*   **Randomized Complete Block (RCBD):** `design.rcbd(trt, r, seed)`
*   **Latin Square (LSD):** `design.lsd(trt, seed)`
*   **Factorial:** `design.ab(trt, r, design=c("rcbd", "crd", "lsd"))`
*   **Split-plot:** `design.split(trt1, trt2, r, design="rcbd")`

### Specialized Agricultural Designs
*   **Alpha Design:** `design.alpha(trt, k, r, seed)` (Rectangular lattice)
*   **Lattice Design:** `design.lattice(trt, r, seed)` (Simple or Triple)
*   **Augmented Block:** `design.dau(trt1, trt2, r)` (For control vs. new genotypes)
*   **Strip-plot:** `design.strip(trt1, trt2, r)`

### Workflow: Generating a Field Book
```r
trt <- c("Variety_A", "Variety_B", "Variety_C")
# Generate RCBD with 4 blocks
outdesign <- design.rcbd(trt, r = 4, seed = 42, serie = 2)
fieldbook <- outdesign$book
# View field layout
print(outdesign$sketch)
# Serpentine plot numbering
book_zigzag <- zigzag(outdesign)
```

## Multiple Comparisons (Post-hoc)
Most comparison functions accept an `aov` model or `(y, trt, DFerror, MSerror)`.

*   **LSD:** `LSD.test(model, "trt", console=TRUE)`
*   **Tukey (HSD):** `HSD.test(model, "trt", console=TRUE)`
*   **Duncan:** `duncan.test(model, "trt", console=TRUE)`
*   **Waller-Duncan:** `waller.test(model, "trt", console=TRUE)`
*   **SNK:** `SNK.test(model, "trt", console=TRUE)`
*   **Scheffe:** `scheffe.test(model, "trt", console=TRUE)`

**Tip:** Use `group=TRUE` for letter-based grouping (e.g., "a", "ab", "b") or `group=FALSE` for p-value matrices.

## Non-Parametric Tests
For data that does not meet normality assumptions:
*   **Kruskal-Wallis:** `kruskal(y, trt)`
*   **Friedman:** `friedman(judge, trt, evaluation)`
*   **Van der Waerden:** `waerden.test(y, trt)`
*   **Durbin:** `durbin.test(judge, trt, evaluation)` (For BIBD)

## Stability Analysis (Genotype x Environment)
### AMMI Model
The Additive Main Effects and Multiplicative Interaction (AMMI) model is standard for multi-environment trials.
```r
# model <- AMMI(Environment, Genotype, Replication, Yield)
data(plrv)
model <- with(plrv, AMMI(Locality, Genotype, Rep, Yield))
plot(model) # Biplot
# Calculate Stability Indices
index.AMMI(model)
```

### Parametric Stability
`stability.par(data, rep, MSerror)` calculates Shukla's stability variance and Kang's yield-stability statistics.

## Specialized Functions
*   **Path Analysis:** `path.analysis(corr.x, corr.y)` for direct and indirect effects.
*   **Line x Tester:** `lineXtester(replications, females, males, response)` for genetic mating designs.
*   **Biodiversity Indices:** `index.bio(data, method="Shannon")` with bootstrap confidence intervals.
*   **Descriptive Stats:** `graph.freq(data)` for histograms with frequency polygons and ogives.

## Reference documentation
- [agricolae tutorial](./references/tutorial.md)