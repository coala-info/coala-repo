---
name: r-r4cker
description: The r4cker package provides a pipeline for identifying interaction domains in 4C-Seq data using adaptive windowing and Hidden Markov Models. Use when user asks to identify high-interaction domains near the bait, analyze cis or trans interactions, or perform differential analysis between 4C-Seq conditions.
homepage: https://cran.r-project.org/web/packages/r4cker/index.html
---


# r-r4cker

## Overview
The `r4cker` (4C-ker) package provides a pipeline for the reproducible identification of interaction domains in 4C-Seq experiments. It uses an adaptive windowing strategy and Hidden Markov Models (HMM) to define domains of interaction near the bait, on the same chromosome (*cis*), and across other chromosomes (*trans*).

## Installation
```R
# Install from CRAN
install.packages("r4cker")

# Or install the development version from GitHub
# library(devtools)
# install_github("rr1859/R.4Cker")
```

## Core Workflow

### 1. Data Preparation
Input files should be 4-column tab-delimited count files (`chr`, `start`, `end`, `counts`) representing reads per observed fragment.
*   **Self-ligation removal**: Before analysis, remove fragments corresponding to the bait and undigested/self-ligated sites.

### 2. Creating a 4C-ker Object
Initialize the analysis by loading data frames or files. This step includes quality control (QC) checks for read depth and coverage.

```R
# From Data Frames
my_obj = createR4CkerObjectFromDFs(
  dfs = c("sample1_df", "sample2_df"),
  bait_chr = "chr13",
  bait_coord = 43773612,
  bait_name = "CD83",
  primary_enz = "AAGCTT",
  samples = c("Rep1", "Rep2"),
  conditions = "WT",
  replicates = 2,
  species = "mm",
  output_dir = "results/",
  enz_file = enz_file_df
)
```

### 3. Domain Analysis
Identify high-interaction domains using adaptive windowing (parameter `k`).
*   **Near Bait**: Recommended `k=3-5` (4bp cutters) or `k=10` (6bp cutters).
*   **Cis**: Recommended `k=10`.
*   **Trans**: Recommended `k=20` (6bp) or `k=50+` (4bp).

```R
# Near bait analysis
nb_results = nearBaitAnalysis(my_obj, k = 5)

# Cis analysis
cis_results = cisAnalysis(my_obj, k = 10)

# Trans analysis
trans_results = transAnalysis(my_obj, k = 20)
```

### 4. Differential Interactions
Compare two conditions using DESeq2 on the identified windows.

```R
res_df = differentialAnalysis(
  obj = my_obj,
  norm_counts_avg = nb_results$norm_counts_avg,
  windows = nb_results$window_counts,
  conditions = c("ConditionA", "ConditionB"),
  region = "nearbait", # or "cis"
  pval = 0.05
)
```

## Visualization
The package integrates with `ggplot2` for profile plotting.

```R
library(ggplot2)
ggplot(nb_results$norm_counts_avg, aes(x=Coord, y=Count, colour=Condition)) +
  geom_line() + 
  theme_bw() +
  labs(title="4C-Seq Near Bait Profile", x="Coordinate", y="Normalized Counts")
```

## Tips
*   **QC Criteria**: Samples typically require >1 million reads and >40% of reads on the *cis* chromosome to pass internal validation.
*   **Adaptive Windows**: The `k` parameter determines the number of fragments pooled into a window; higher `k` values provide more smoothing for sparse data (like *trans* interactions).
*   **Output**: The functions automatically save `.bed` files of high-interaction domains to the specified `output_dir`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)