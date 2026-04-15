---
name: r-traminer
description: This tool provides expert guidance for the TraMineR R package to analyze, visualize, and mine longitudinal state or event sequence data. Use when user asks to perform sequence analysis, calculate sequence dissimilarities using Optimal Matching, visualize state distributions, or extract frequent subsequences in R.
homepage: https://cran.r-project.org/web/packages/traminer/index.html
---

# r-traminer

name: r-traminer
description: Expert guidance for the TraMineR R package, used for mining, describing, visualizing, and analyzing state or event sequences (longitudinal data). Use this skill when performing sequence analysis, calculating sequence dissimilarities (Optimal Matching), plotting state distributions, or extracting frequent subsequences in R.

## Overview
TraMineR (Life Trajectory Miner for R) is a specialized toolkit for categorical sequence data, primarily used in social sciences for life course analysis (careers, family trajectories). It provides tools for sequence manipulation, visualization (index plots, density plots), longitudinal characteristics (entropy, turbulence), and dissimilarity measures (Optimal Matching, Hamming, LCS).

## Installation
```R
install.packages("TraMineR")
# Recommended companion package for additional utilities
install.packages("TraMineRextras")
```

## Core Workflow

### 1. Data Preparation
Convert data into a `state sequence object` using `seqdef()`. This is the required input for most TraMineR functions.
```R
library(TraMineR)
data(mvad)
# Define states and create sequence object
mvad.labels <- c("employment", "further education", "higher education", "joblessness", "school", "training")
mvad.scodes <- c("EM", "FE", "HE", "JL", "SC", "TR")
mvad.seq <- seqdef(mvad[, 17:86], states = mvad.scodes, labels = mvad.labels, xtstep = 6)
```

### 2. Visualization
TraMineR uses specific plotting functions to reveal patterns:
- `seqiplot(seq_obj)` / `seqIplot()`: Index plots (individual sequences).
- `seqdplot(seq_obj)`: State distribution plots (cross-sectional).
- `seqfplot(seq_obj)`: Sequence frequency plots.
- `seqmsplot(seq_obj)`: Modal state plot.
- `seqmtplot(seq_obj)`: Mean time spent in each state.

### 3. Descriptive Statistics
- `seqtransn(mvad.seq)`: Number of transitions in each sequence.
- `seqindic(mvad.seq, stat=c("entropy", "turbulence", "complexity"))`: Individual longitudinal indicators.
- `seqstatd(mvad.seq)`: Transversal state distributions and entropy.
- `seqtrate(mvad.seq)`: Transition rates between states.

### 4. Dissimilarity and Clustering
Calculate distances between sequences for clustering or ANOVA-like analysis.
```R
# Calculate substitution costs (e.g., based on transition rates)
ccost <- seqsubm(mvad.seq, method = "TRATE")
# Optimal Matching distance
mvad.om <- seqdist(mvad.seq, method = "OM", sm = ccost)

# Representative sequences
mvad.rep <- seqrep(mvad.seq, diss = mvad.om)
plot(mvad.rep)
```

### 5. Event Sequences
For data where timing is precise (not fixed intervals), use event sequence analysis:
- `seqecreate()`: Create event sequences.
- `seqefsub()`: Find frequent event subsequences.
- `seqecmpgroup()`: Identify discriminating subsequences between groups.

## Tips
- **Missing Data**: Use the `left`, `right`, and `gaps` arguments in `seqdef()` to handle missing values (e.g., `nr = "NA"` to treat missing as a specific state).
- **Weights**: Always use the `weights` argument in `seqdef()` if your survey data includes sampling weights; TraMineR functions will respect these automatically.
- **Color Palettes**: Use `cpal(seq_obj) <- my_colors` to standardize colors across different plots.

## Reference documentation
- [TraMineR Home Page](./references/home_page.md)