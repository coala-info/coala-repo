---
name: r-qtl
description: R/qtl provides an interactive environment for mapping quantitative trait loci in experimental populations. Use when user asks to estimate genetic maps, perform interval mapping, identify genomic regions contributing to quantitative traits, or analyze genetic data from experimental crosses.
homepage: https://cloud.r-project.org/web/packages/qtl/index.html
---


# r-qtl

name: r-qtl
description: Analysis of experimental crosses to identify quantitative trait loci (QTLs). Use this skill when analyzing genetic data from experimental populations (backcross, intercross, RILs, BCsFt) to estimate genetic maps, perform interval mapping (EM, Haley-Knott, multiple imputation), and identify genomic regions contributing to quantitative traits.

## Overview

The `qtl` package (R/qtl) provides an interactive environment for mapping QTLs in experimental populations. It supports a wide range of cross types and provides tools for data inspection, genetic map construction, and various QTL scanning methods.

## Installation

```R
install.packages("qtl")
library(qtl)
```

## Core Workflow

### 1. Data Import
Data is typically imported as a "cross" object.
- `read.cross(format="csv", file="data.csv", ...)`: Common formats include "csv", "csvs", "csvsr", and "mm".
- **BCsFt Crosses**: For advanced backcrosses followed by selfing, specify `BC.gen` and `F.gen`.
  ```R
  cross <- read.cross("csv", file="listeria.csv", BC.gen=2, F.gen=3)
  ```
- `convert2bcsft(cross, BC.gen, F.gen)`: Converts an existing cross object to the BCsFt type.

### 2. Data Inspection and Cleaning
- `summary(cross)`: Overview of individuals, markers, and phenotypes.
- `plot(cross)`: Visualize missing data and phenotype distributions.
- `est.rf(cross)`: Estimate recombination fractions between all pairs of markers.
- `plotRF(cross)`: Check for linkage and potential marker order issues.
- `drop.nullmarkers(cross)`: Remove markers with no genotype data.

### 3. Genetic Map Construction
- `est.map(cross)`: Estimate genetic distances (recombination frequencies) using the Hidden Markov Model (HMM).
- `replace.map(cross, newmap)`: Update the cross object with a new map.
- `plotMap(cross)`: Visualize the genetic map.

### 4. QTL Analysis
Before scanning, calculate genotype probabilities or perform simulations:
- `calc.genoprob(cross, step=1, error.prob=0.01)`: Calculate conditional genotype probabilities.
- `sim.geno(cross, step=1, n.draws=64)`: Perform multiple imputations.

**Single-QTL Analysis:**
- `scanone(cross, method="em")`: Standard interval mapping via EM algorithm.
- `scanone(cross, method="hk")`: Haley-Knott regression (faster approximation).
- `scanone(cross, method="imp")`: Multiple imputation method.

**Permutation Tests:**
- `operm <- scanone(cross, n.perm=1000)`: Determine LOD thresholds for significance.
- `summary(out, alpha=0.05, perms=operm)`: Identify significant QTLs.

### 5. Advanced Mapping
- `scantwo(cross, ...)`: Two-dimensional, two-QTL scan for epistasis.
- `makeqtl(cross, chr, pos)`: Define a multiple-QTL model.
- `fitqtl(cross, qtl, formula)`: Fit a specific QTL model and estimate effects.
- `refineqtl(cross, qtl)`: Optimize QTL positions in a multiple-QTL model.

## Tips for BCsFt Populations
- The `bcsft` cross type is flexible; the `cross.scheme` attribute stores `(s, t)` where `s` is backcross generations and `t` is selfing generations.
- Map lengths in BCsFt are typically shorter than F2/BC1 because recombination events are attributed across multiple generations.
- Use `calc.genoprob` before `scanone` to ensure the cross history is correctly accounted for in the HMM calculations.

## Reference documentation

- [Users Guide for New BCsFt Tools for R/qtl](./references/bcsft.md)