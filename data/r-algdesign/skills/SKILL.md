---
name: r-algdesign
description: "Algorithmic experimental designs. Calculates exact and         approximate theory experimental designs for D,A, and I         criteria. Very large designs may be created. Experimental         designs may be blocked or blocked designs created from a         candidate list, using several criteria.  The blocking can be         done when whole and within plot factors interact.</p>"
homepage: https://cloud.r-project.org/web/packages/AlgDesign/index.html
---

# r-algdesign

## Overview
The `AlgDesign` package is used for creating optimal experimental designs. Unlike classical designs found in tables, algorithmic designs are calculated to maximize information (D-optimality), minimize average variance (A-optimality), or minimize average prediction variance (I-optimality). This is particularly useful when the experimental region is constrained, when you have a fixed number of trials that doesn't fit a standard fraction, or when you need to block designs with complex interactions.

## Installation
```R
install.packages("AlgDesign")
library(AlgDesign)
```

## Core Workflow
The general workflow involves two steps:
1.  **Generate a Candidate Set**: Create a large dataframe of all possible experimental points.
2.  **Select Optimal Points**: Use an optimization function to pick a subset of these points that satisfies a specific optimality criterion.

### 1. Generating Candidates
Use `gen.factorial()` for standard factors and `expand.mixture()` for mixture components.
```R
# 3 factors at 3 levels each
candidates <- gen.factorial(levels=3, nVars=3, varNames=c("Temp", "Press", "Time"))

# Mixture candidates (3 components summing to 1)
mix_candidates <- expand.mixture(levels=4, nVars=3)
```

### 2. Finding Exact Designs
Use `optFederov()` to find a specific number of trials (`nTrials`) from the candidate set.
```R
# Find a 12-run D-optimal design for a quadratic model
design <- optFederov(~quad(.), data=candidates, nTrials=12, nRepeats=20)

# View the chosen points
print(design$design)
```

## Key Functions and Criteria

### Optimality Criteria
-   **D-optimality** (`criterion="D"`): Maximizes the determinant of the information matrix. Best for precise parameter estimation. (Default)
-   **A-optimality** (`criterion="A"`): Minimizes the trace of the inverse information matrix. Best for minimizing the average variance of coefficients.
-   **I-optimality** (`criterion="I"`): Minimizes the average prediction variance over the region. Best for response surface modeling.

### Blocking Designs
Use `optBlock()` to group trials into blocks to account for nuisance variables (e.g., days, batches).
```R
# Block a 32-run design into 4 blocks of 8
blocked <- optBlock(~.^2, withinData=candidates, blocksizes=rep(8, 4))
```

### Design Augmentation
If you have already conducted some trials and want to add more optimally:
```R
# 'existing_rows' contains indices of trials already run
augmented <- optFederov(~., data=candidates, nTrials=20, rows=existing_rows, augment=TRUE)
```

### Large Problems (Monte Carlo)
For very large candidate sets that exceed memory, use `optMonteCarlo()`. It samples the design space randomly rather than evaluating every possible candidate.
```R
# 20 variable quadratic design
mc_design <- optMonteCarlo(~quad(.), data=data.frame(var=paste0("X", 1:20), low=-1, high=1))
```

## Specialized Models
-   `quad(A, B, C)`: A helper in formulas to expand to a full quadratic model (linear, interactions, and squares).
-   `~ -1 + .^2`: Common for mixture designs where the intercept is removed due to the sum-to-one constraint.

## Tips for Success
-   **nRepeats**: Algorithmic searches can get stuck in local optima. Always set `nRepeats` to 20 or higher (default is 1) to ensure a more global optimum.
-   **Center and Scale**: For response surfaces, use `center=TRUE` in `gen.factorial()` to keep variables on a comparable scale (e.g., -1 to 1).
-   **Evaluation**: Use `eval.design()` to check the efficiencies and confounding of a design you've already created or imported.

## Reference documentation
- [AlgDesign](./references/AlgDesign.md)