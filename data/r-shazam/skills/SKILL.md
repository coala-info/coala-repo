---
name: r-shazam
description: The r-shazam tool analyzes somatic hypermutation in immunoglobulin sequences using advanced statistical methods. Use when user asks to quantify selection pressure, calculate mutation loads, determine clonal assignment thresholds, build targeting models, or simulate mutated sequences.
homepage: https://cran.r-project.org/web/packages/shazam/index.html
---

# r-shazam

name: r-shazam
description: Analysis of somatic hypermutation (SHM) in immunoglobulin (Ig) sequences using the shazam R package. Use this skill to quantify selection pressure (BASELINe), calculate mutation loads, determine clonal assignment thresholds via nearest-neighbor distances, build SHM targeting models, and simulate mutated sequences.

# r-shazam

## Overview
The `shazam` package is part of the Immcantation framework. It provides advanced statistical methods for analyzing SHM, including the BASELINe method for selection analysis and the S5F method for mutability and substitution modeling.

## Installation
```r
install.packages("shazam")
library(shazam)
```

## Core Workflows

### 1. Mutation Analysis
Quantify the number and frequency of mutations in Ig sequences.

```r
# Calculate mutation frequencies for the whole sequence
db_obs <- observedMutations(db, 
                            sequenceColumn="sequence_alignment",
                            germlineColumn="germline_alignment_d_mask",
                            regionDefinition=NULL,
                            frequency=TRUE, 
                            nproc=1)

# Calculate mutations by region (CDR/FWR)
db_obs_v <- observedMutations(db, 
                              regionDefinition=IMGT_V,
                              frequency=TRUE)
```

### 2. Clonal Threshold Determination
Find the optimal distance threshold for partitioning sequences into clones by analyzing the distance to the nearest neighbor.

```r
# 1. Calculate distances
dist_ham <- distToNearest(db, 
                          vCallColumn="v_call_genotyped", 
                          model="ham", 
                          normalize="len")

# 2. Find threshold automatically (Density or GMM method)
output <- findThreshold(dist_ham$dist_nearest, method="density")
threshold <- output@threshold

# 3. Plot results
plot(output)
```

### 3. Selection Pressure (BASELINe)
Quantify antigen-driven selection using the Bayesian Estimation of Antigen-driven Selection (BASELINe) method.

```r
# 1. Calculate selection scores (one-step)
baseline <- calcBaseline(db, 
                         testStatistic="focused", 
                         regionDefinition=IMGT_V, 
                         nproc=1)

# 2. Group and convolve PDFs
grouped <- groupBaseline(baseline, groupBy="sample_id")

# 3. Test for significance between groups
testBaseline(grouped, groupBy="sample_id")

# 4. Plot summary
plotBaselineSummary(grouped, "sample_id")
```

### 4. SHM Targeting Models
Infer custom substitution and mutability models from your data.

```r
# Create a targeting model using silent mutations
model <- createTargetingModel(db, model="s")

# Visualize hot/cold spots
plotMutability(model, nucleotides="A", style="hedgehog")

# Convert model to a distance matrix for clonal clustering
dist_matrix <- calcTargetingDistance(model)
```

### 5. Sequence Simulation
Simulate SHM in sequences or along lineage trees using specific targeting models.

```r
# Simulate 6 mutations in a sequence
sim_seq <- shmulateSeq(sequence, numMutations=6, targetingModel=HH_S5F)

# Simulate mutations along a lineage tree (igraph object)
sim_tree <- shmulateTree(sequence, graph)
```

## Tips and Best Practices
- **Region Definitions**: Use `IMGT_V` for standard CDR/FWR analysis. Ensure sequences are IMGT-gapped.
- **Clonal Consensus**: Before running selection or targeting analysis, use `collapseClones` to avoid overcounting mutations from expanded clones.
- **Parallelization**: Most heavy functions support the `nproc` argument to speed up calculations using multiple cores.
- **Models**: `HH_S5F` is the default human heavy chain 5-mer model. Use `MK_RS5NF` for mouse data.

## Reference documentation
- [Selection quantification](./references/Baseline-Vignette.Rmd)
- [Tuning clonal assignment thresholds](./references/DistToNearest-Vignette.Rmd)
- [Mutation analysis](./references/Mutation-Vignette.Rmd)
- [Simulating sequence mutations](./references/Shmulate-Vignette.Rmd)
- [Inferring SHM targeting models](./references/Targeting-Vignette.Rmd)