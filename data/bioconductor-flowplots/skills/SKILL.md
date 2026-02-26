---
name: bioconductor-flowplots
description: The flowPlots package provides tools for the graphical display and statistical analysis of gated ICS flow cytometry data. Use when user asks to visualize group comparisons of profile data, compute polyfunctional degree statistics, or generate ternary and boxplots with embedded p-values.
homepage: https://bioconductor.org/packages/release/bioc/html/flowPlots.html
---


# bioconductor-flowplots

## Overview
The `flowPlots` package is designed for the graphical display and statistical analysis of gated ICS flow cytometry data. It specializes in comparing groups (e.g., Adults vs. Neonates) across various data representations:
- **Profile Data**: Percentages of all possible marker combinations.
- **Marginal Data**: Percentages of cells positive for each individual marker.
- **PFD Data**: Polyfunctional degree (number of markers expressed simultaneously).
- **PFD Parts**: The specific composition of combinations within a PFD level.

## Core Workflows

### 1. Data Preparation with StackedData
If starting with raw "stacked" data (where marker combinations are rows), use the `StackedData` class to compute summary statistics.

```r
library(flowPlots)
data(adultsNeonates)

# Initialize object
sData <- new("StackedData", stackedData = adultsNeonates)

# Define markers and compute marker matrix
markerNames <- c("TNFa", "IL6", "IL12", "IFNa")
markers(sData) <- computeMarkers(markerNames, includeAllNegativeRow = TRUE)

# Compute summary data slots
byVars <- c("stim", "concGroup", "cell")
profileData(sData) <- computeProfileData(sData, byVars, "id", "percentAll", "group")
marginalData(sData) <- computeMarginalData(sData, byVars, "id", "percentAll", "group")
pfdData(sData) <- computePFDData(sData, byVars, "id", "percentAll", "group")
pfdPartsData(sData) <- computePFDPartsData(sData, byVars, "id", "percentAll", "group")
```

### 2. Creating Group Comparison Boxplots
The `GroupListBoxplot` function is the primary tool for visualization. It automatically performs statistical tests (Wilcoxon Rank Sum for 2 groups, Kruskal-Wallis for >2 groups) and embeds p-values in the plot.

```r
# 1. Prepare a list of data frames (one per group) using helper
# profileDataSubset should contain columns for combinations and a 'group' column
groupDataList <- makeDataList(profileDataSubset, "group", 1:16)

# 2. Generate labels (optional but recommended for profile data)
data(markerMatrix)
xTickLabels <- cbind(colnames(markerMatrix), t(markerMatrix))

# 3. Plot
GroupListBoxplot(groupDataList, 
                 xlabel = "Marker Category", 
                 ylabel = "Percent of All Cells",
                 xAxisLabels = xTickLabels,
                 legendGroupNames = c("Adults", "Neonates"),
                 pointColor = c(2, 4))
```

### 3. Ternary Plots for PFD Data
Useful for visualizing the relationship between PFD1, PFD2, and PFD3+ categories.

```r
library(vcd)
# Prepare 3-column data (PFD1, PFD2, and sum of PFD3-4)
ternaryData <- makeTernaryData(pfdDataSubset, 1, 2, 3:4)
colnames(ternaryData) <- c("PFD1", "PFD2", "PFD3-4")

ternaryplot(ternaryData, 
            col = as.numeric(pfdDataSubset$group) * 2,
            main = "Ternary Plot of PFD Data")
```

### 4. Bar Plots for Profile Data
Visualizes the composition of marker combinations across groups.

```r
# Prepare data for barplot
barplotData <- makeBarplotData(profileDataSubset, 1:16, groupVariableName = "group")
barColors <- gray(0:15/15)[16:1]

barplot(barplotData, col = barColors, main = "Profile Composition")
```

## Key Functions
- `GroupListBoxplot()`: Main plotting function with integrated stats.
- `makeDataList()`: Converts a data frame into a list format required by `GroupListBoxplot`.
- `computeMarkers()`: Generates the binary matrix representing marker combinations.
- `computePFDData()`: Calculates polyfunctional degree from stacked data.
- `computeMarginalData()`: Calculates individual marker frequencies.

## Tips for Success
- **Sorting**: Ensure `stackedData` is sorted by subject and subset so that rows align correctly with the `markerMatrix`.
- **Point Coloring**: `pointColor` can be a single value, a vector (by group), a matrix (group x category), or a list of matrices for individual subject tracking.
- **PFD Parts**: When analyzing `pfdPartsData`, remember it is a list where each element corresponds to a PFD level (e.g., `[[1]]` for PFD=1, `[[2]]` for PFD=2).

## Reference documentation
- [flowPlots: An R Package for Analyzing Gated ICS Flow Cytometry Data](./references/flowPlots.md)