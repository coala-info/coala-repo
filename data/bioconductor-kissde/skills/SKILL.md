---
name: bioconductor-kissde
description: This tool performs statistical analysis of differential variant usage, such as alternative splicing and SNVs, from RNA-Seq count data. Use when user asks to analyze differential variant usage, identify alternative splicing events, or detect significant changes in allele frequencies across conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/kissDE.html
---


# bioconductor-kissde

name: bioconductor-kissde
description: Statistical analysis of differential variant usage (alternative splicing, SNVs, indels) from RNA-Seq count data. Use this skill when analyzing pairs of variants (e.g., inclusion/exclusion isoforms or allele A/B) across multiple conditions with replicates.

## Overview
The `kissDE` package is designed for differential analysis of "events" where each event consists of two variants. It is particularly optimized for outputs from KisSplice but supports any count data formatted as pairs of rows per event. It uses a Generalized Linear Model (GLM) with a Negative Binomial distribution (or Poisson for technical replicates) to test for the interaction between variant type and condition.

## Core Workflow

### 1. Data Preparation
Input requires a count table where each event occupies two consecutive rows (Variant 1 and Variant 2) and a condition vector.

```R
library(kissDE)

# Define conditions (must have at least 2 replicates per condition)
conditions <- c(rep("control", 2), rep("treatment", 2))

# Option A: Load from KisSplice/KisSplice2refgenome
counts <- kissplice2counts("output_kissplice.fa", pairedEnd = TRUE, counts = 2)

# Option B: User-defined data frame
# Must have columns: eventsName, eventsLength, and then sample counts
# Each event must have exactly two rows.
```

### 2. Quality Control
Always run QC to visualize sample clustering via Heatmaps and PCA.
```R
qualityControl(counts, conditions)
```

### 3. Differential Analysis
The `diffExpressedVariants` function performs the statistical testing.
```R
results <- diffExpressedVariants(counts, conditions, 
                                 filterLowCountsVariants = 10, 
                                 nbCore = 1)
```
**Key Parameters:**
- `technicalReplicates`: Set to `TRUE` to use Poisson distribution; `FALSE` (default) uses Negative Binomial.
- `filterLowCountsVariants`: Minimum counts required to test an event.
- `nbCore`: Number of cores for parallel processing.

### 4. Output and Interpretation
The results object contains a `finalTable` with adjusted p-values and Delta PSI (Percent Spliced In) or Delta f (allele frequency).

```R
# View top results
head(results$finalTable)

# Save results to file
writeOutputKissDE(results, output = "results.tab", adjPvalMax = 0.05, dPSImin = 0.1)

# Save PSI/f values specifically
writeOutputKissDE(results, output = "psi_values.tab", writePSI = TRUE)
```

## Analysis Types

### Alternative Splicing (AS)
- **Metric**: Delta PSI (Difference in Percent Spliced In).
- **Interpretation**: A negative Delta PSI indicates higher inclusion in the second condition (alphabetically) compared to the first.
- **Effective Length**: Used to normalize counts based on the length of the inclusion/exclusion isoforms.

### SNVs / SNPs
- **Metric**: Delta f (Difference in allele frequency).
- **Interpretation**: Identifies site-specific variations where allele proportions change significantly between populations or treatments.
- **Effective Length**: Usually set to 0 or equal for both variants as length bias is typically absent in SNVs.

## Tips for Success
- **Condition Ordering**: `kissDE` orders conditions alphabetically. Delta PSI/f is calculated as `Condition2 - Condition1`.
- **Replicates**: All conditions must have at least two replicates.
- **Low Counts**: Events with very low counts in $n-1$ conditions are flagged in the `lowcounts` column of the final table. These may be statistically significant but difficult to validate experimentally.
- **Interactive Exploration**: Use `exploreResults(rdsFile = "results.rds")` to launch a Shiny app for interactive visualization of the results.

## Reference documentation
- [The kissDE package](./references/kissDE.md)