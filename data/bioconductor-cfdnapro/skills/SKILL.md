---
name: bioconductor-cfdnapro
description: This tool analyzes and visualizes cell-free DNA fragmentation patterns from Picard metrics or BAM files. Use when user asks to characterize fragment size distributions, calculate modal sizes, compare fragmentation profiles across cohorts, or quantify 10bp periodic oscillations.
homepage: https://bioconductor.org/packages/release/bioc/html/cfDNAPro.html
---

# bioconductor-cfdnapro

name: bioconductor-cfdnapro
description: Analyze and visualize cell-free DNA (cfDNA) fragmentation patterns. Use this skill to characterize fragment size distributions, calculate modal sizes, and quantify 10bp periodic oscillations (inter-peak/valley distances) from Picard metrics or BAM files.

# bioconductor-cfdnapro

## Overview

The `cfDNAPro` package provides a standardized workflow for analyzing cfDNA fragmentation metrics. It is specifically designed to handle the 10bp periodic oscillations characteristic of cfDNA and to compare fragmentation profiles across different cohorts or clinical groups.

## Core Workflow

### 1. Data Preparation
`cfDNAPro` expects data organized into sub-folders named by cohort/group.
- **Input formats**: Picard `CollectInsertSizeMetrics` text files or Illumina NGS BAM files.
- **Structure**: `project_folder/cohort_A/*.txt`, `project_folder/cohort_B/*.txt`.

```R
library(cfDNAPro)
# Get path to example data
data_path <- examplePath("groups_picard")
```

### 2. Characterizing Fragment Size
Use `callSize` to extract distribution data and `plotSingleGroup` for initial visualization.

```R
# Extract data and plot for a specific cohort
size_data <- callSize(path = data_path)
cohort1_plot <- size_data %>%
  dplyr::filter(group == "cohort_1") %>%
  plotSingleGroup()

# Access specific plots from the returned list:
# cohort1_plot$prop_plot (Proportion)
# cohort1_plot$cdf_plot (Cumulative Distribution)
```

### 3. Group Comparisons (Metrics)
To compare multiple cohorts using median distributions:

```R
# Calculate median metrics across groups
order <- c("cohort_1", "cohort_2", "cohort_3")
compare_grps <- callMetrics(data_path) %>% plotMetrics(order = order)

# Result contains $median_prop_plot and $median_cdf_plot
```

### 4. Modal Size Analysis
Identify the most frequent fragment lengths (modes) per sample or group.

```R
# Bar chart of modes per sample
mode_data <- callMode(data_path)
plotMode(mode_data, order = order, hline = c(167, 111, 81))

# Stacked bar chart for mode partitions (e.g., 166-167 bp)
plotModeSummary(mode_data, order = order, mode_partition = list(c(166, 167)))
```

### 5. Periodic Oscillation (Peak/Valley)
Quantify the distance between peaks and valleys in the 10bp oscillation pattern, typically within the 50-135bp range.

```R
# Inter-peak distance
peaks <- callPeakDistance(path = data_path, limit = c(50, 135))
plotPeakDistance(peaks, order = order)

# Inter-valley distance
valleys <- callValleyDistance(path = data_path, limit = c(50, 135))
plotValleyDistance(valleys, order = order)
```

## Tips and Customization
- **ggplot2 Integration**: All plot functions return `ggplot2` objects or lists of objects. You can extend them using standard `+ theme()` or `+ labs()` syntax.
- **BAM Requirements**: If reading directly from BAMs, `cfDNAPro` filters for proper pairs, mapping quality >= 30, and excludes indels in CIGAR strings.
- **X-axis Limits**: By default, analysis focuses on 30bp-500bp to avoid noise at very short lengths and low signal at very long lengths.

## Reference documentation

- [cfDNAPro Tutorial](./references/cfDNAPro.Rmd)
- [cfDNAPro Vignette](./references/cfDNAPro.md)