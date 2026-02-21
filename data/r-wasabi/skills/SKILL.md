---
name: r-wasabi
description: R package wasabi (documentation from project home).
homepage: https://cran.r-project.org/web/packages/wasabi/index.html
---

# r-wasabi

name: r-wasabi
description: Use this skill when you need to prepare transcript quantification output from Salmon or Sailfish for downstream differential expression analysis, specifically for use with the 'sleuth' R package. This skill covers converting quantification directories into the required HDF5 format.

## Overview
The `wasabi` package is a utility designed to bridge the gap between fast transcript quantifiers (Salmon and Sailfish) and the `sleuth` differential expression analysis framework. Its primary function is to convert the native output of these tools into a compatible `abundance.h5` format that `sleuth` can ingest, preserving bootstrap samples and inferential variance.

## Installation
To install the package from CRAN:
```R
install.packages("wasabi")
```

## Workflow: Preparing Data for Sleuth
The core workflow involves identifying the directories containing Salmon/Sailfish results and processing them with a single function.

### 1. Identify Quantification Directories
Create a character vector containing the paths to your sample quantification folders.
```R
library(wasabi)

# Example: directories named samp1, samp2, samp3 inside a 'data' folder
sample_dirs <- file.path("data", c("samp1", "samp2", "samp3"))
```

### 2. Convert to Sleuth Format
Use `prepare_fish_for_sleuth()` to generate the `abundance.h5` files.
```R
prepare_fish_for_sleuth(sample_dirs)
```
This function will:
- Read the quantification data and bootstrap samples.
- Create an `abundance.h5` file within each provided directory.
- Output status messages to the console during processing.

## Windows Compatibility Tips
Windows has a known restriction regarding folders named `aux`. Salmon and Sailfish often use an `aux` directory for auxiliary data (like bootstrap samples).

- **Salmon (>= 0.7.0):** Uses `aux_info` by default; no action needed.
- **Older versions/Sailfish:** If you encounter errors on Windows, rename the `aux` folder in each quantification directory to `aux2`. Then, edit the `cmd_info.json` file in that directory to include: `"auxDir" : "aux2"`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)