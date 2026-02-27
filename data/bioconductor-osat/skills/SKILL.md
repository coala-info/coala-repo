---
name: bioconductor-osat
description: This tool assigns samples to experimental batches using optimization algorithms to minimize batch effects in genomics studies. Use when user asks to assign samples to plates or chips, balance biological variables across batches, or perform block randomization for experimental design.
homepage: https://bioconductor.org/packages/release/bioc/html/OSAT.html
---


# bioconductor-osat

name: bioconductor-osat
description: Optimal Sample Assignment Tool (OSAT) for minimizing batch effects in genomics studies. Use this skill to assign samples to experimental batches (plates/chips) using block randomization and optimization algorithms to ensure balanced distribution of biological groups and confounding factors.

## Overview
OSAT (Optimal Sample Assignment Tool) is designed to allocate samples across different experimental batches to minimize batch effects. It is particularly useful for observational studies where sample collections are unbalanced or incomplete. The package works by creating a "container" (representing the physical layout of plates and chips) and assigning "samples" to it using algorithms that minimize the correlation between biological variables and batch assignments.

## Core Workflow

### 1. Prepare Sample Data
Load your phenotype data and define which variables are of primary interest and which are confounding factors.

```R
library(OSAT)
# Load your data frame (pheno)
# optimal: variables to be balanced across batches
# strata: (Optional) variables for the initial block randomization
gs <- setup.sample(pheno, optimal=c("SampleType", "Race", "AgeGrp"))
```

### 2. Define the Container
Specify the physical layout of the experiment. OSAT provides predefined layouts for common Illumina platforms.

```R
# Use a predefined layout (e.g., IlluminaBeadChip96Plate)
# n: number of plates
# batch: the level at which to control batch effects ('plates' or 'chips')
gc <- setup.container(IlluminaBeadChip96Plate, n=6, batch='plates')

# To see predefined layouts:
predefined()
```

### 3. Create Optimized Setup
Generate the sample-to-batch assignment. The default method uses `optimal.shuffle`.

```R
set.seed(123) # For reproducibility
# nSim: number of iterations (5000+ recommended for real studies)
gSetup <- create.optimized.setup(sample=gs, container=gc, nSim=1000)
```

### 4. QC and Export
Evaluate the assignment quality and export the results.

```R
# Statistical check (Chi-squared test) and visualization
QC(gSetup)

# Extract the final assignment table
final_assignment <- get.experiment.setup(gSetup)

# Export to CSV
write.csv(final_assignment, file="sample_assignment.csv", row.names=FALSE)
```

## Advanced Features

### Handling Excluded Wells
If specific wells are reserved for controls, define an exclusion data frame.
```R
# Exclude well 1 on every chip
excluded <- data.frame(wells=1)
gc <- setup.container(IlluminaBeadChip96Plate, n=6, batch='plates', exclude=excluded)
```

### Alternative Algorithm: `optimal.block`
Use this when you want to guarantee perfect balancing for a specific variable (strata) while optimizing for others.
```R
gs2 <- setup.sample(pheno, optimal=c("Type", "Age"), strata=c("Type"))
gSetup2 <- create.optimized.setup("optimal.block", sample=gs2, container=gc, nSim=1000)
```

### Custom Layouts
Define your own chip or plate if not predefined.
```R
myChip <- new("BeadChip", nRows=6, nColumns=2, byrow=FALSE)
myPlate <- new("BeadPlate", chip=myChip, nRows=2, nColumns=4)
```

## Tips for Success
- **Primary Variable First**: In `setup.sample`, list your most important biological variable first in the `optimal` vector.
- **Batch Level**: For large studies, set `batch='plates'`. For smaller studies where chip-to-chip variation is a concern, use `batch='chips'`.
- **Randomness**: Always use `set.seed()` before `create.optimized.setup` to ensure your assignment can be recreated.
- **Robotic Loaders**: Use `map.to.MSA(gSetup)` to format the output for MSA-4 robotic loaders.

## Reference documentation
- [An introduction to OSAT](./references/OSAT.md)