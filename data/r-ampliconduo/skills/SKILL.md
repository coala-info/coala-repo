---
name: r-ampliconduo
description: AmpliconDuo analyzes and filters amplicon sequencing data by comparing read frequencies between technical replicates using Fisher's exact test. Use when user asks to identify experimental artifacts, compare taxon frequencies between replicates, visualize replicate discordance, or filter OTUs based on statistical significance between duplicate samples.
homepage: https://cran.r-project.org/web/packages/ampliconduo/index.html
---


# r-ampliconduo

## Overview
The `AmpliconDuo` package is designed for the analysis of amplicon sequencing data where each biological sample has been split into two technical replicates (an "amplicon duo"). By comparing the read frequencies of taxa/OTUs between these replicates using Fisher's exact test, the package helps distinguish true rare species from experimental artifacts.

## Installation
```R
install.packages("AmpliconDuo")
library(AmpliconDuo)
```

## Core Workflow

### 1. Data Preparation
Input data should be a data frame where rows are OTUs/taxa and columns represent the read counts for the two replicates of one or more samples.

### 2. Generating AmpliconDuo Objects
The primary function `ampliconduo()` performs Fisher's exact tests to determine if the difference in read frequencies between replicates is greater than expected by chance.

```R
# For a single pair of replicates
duo <- ampliconduo(sample_df[,1:2], sample_names = "SampleA")

# For multiple pairs (list of data frames)
# Each data frame in the list must have 2 columns
duo_list <- ampliconduo(list(SampleA = df1, SampleB = df2))
```

### 3. Visualization
The package provides specialized plotting functions to inspect the concordance between replicates.

```R
# Discordance plot (log-log plot with color-coded p-values)
plotAmpliconduo(duo)

# Plotting multiple duos in a grid
plotAmpliconduo(duo_list)

# Customizing appearance (using ggplot2 parameters)
plotAmpliconduo(duo, color.limit = 0.05, label.size = 3)
```

### 4. Filtering Artifacts
Use `filterAmpliconduo()` to remove OTUs that show significant discordance between replicates or fall below frequency thresholds.

```R
# Keep only OTUs with p-value > 0.05 (non-significant discordance)
filtered_data <- filterAmpliconduo(duo, p.cutoff = 0.05)

# Apply filters to a list of duos
filtered_list <- filterAmpliconduo(duo_list, p.cutoff = 0.01, q.cutoff = 0.1)
```

### 5. Reporting
Generate LaTeX or HTML tables of the results using `xtable` integration.

```R
# Generate a summary table
data(amplicons)
xtableAmpliconduo(amplicons[1:2])
```

## Key Functions
- `ampliconduo()`: Calculates p-values and odds ratios for replicate pairs.
- `plotAmpliconduo()`: Visualizes read frequency distributions and discordance.
- `filterAmpliconduo()`: Filters OTUs based on p-values, adjusted p-values (q-values), or minimum read frequencies.
- `accepted.filters()`: Lists available filtering criteria.

## Tips for Success
- **Sample Splitting**: This package is specifically intended for "split-sample" protocols where the same amplification and sequencing protocol is applied to two halves of the same sample.
- **P-value Interpretation**: OTUs with very low p-values are highly discordant between replicates and are likely PCR or sequencing artifacts.
- **Data Structure**: Ensure your input data frame has an even number of columns if passing a single data frame representing multiple duos, or use the list input format for clarity.

## Reference documentation
- [AmpliconDuo Home Page](./references/home_page.md)