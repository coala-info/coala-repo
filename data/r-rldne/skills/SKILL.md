---
name: r-rldne
description: This tool interfaces with NeEstimator 2.1 to estimate contemporary effective population size using the linkage disequilibrium method within R. Use when user asks to estimate effective population size, automate NeEstimator workflows, or process genetic data for linkage disequilibrium analysis.
homepage: https://cran.r-project.org/web/packages/rldne/index.html
---

# r-rldne

name: r-rldne
description: Interface with NeEstimator 2.1 for estimating contemporary effective population size (Ne) using the Linkage Disequilibrium (LD) method. Use this skill when you need to automate Ne estimation, perform downsampling/simulations, or process genetic data for LD-based Ne analysis within R.

# r-rldne

## Overview
The `rldne` package provides an R interface for NeEstimator 2.1, specifically focusing on the Linkage Disequilibrium (LD) method. It streamlines the workflow of preparing genetic data, configuring parameters, executing the NeEstimator engine, and parsing the results back into R data frames. This is particularly useful for iterative simulations or large-scale genomic downsampling studies.

## Installation
```R
# Install from GitHub as it is the primary distribution point
devtools::install_github("zakrobinson/RLDNe")
```

## Core Workflow
The standard analysis pipeline follows a specific sequence of function calls:

1.  **Data Preparation**: Load your genotype data. The package expects specific formatting, often requiring conversion between allele-per-column and genotype-per-column formats.
2.  **Object Initialization**: Use `readInData` to create the base object.
3.  **Genepop Export**: Convert the data into the Genepop format required by NeEstimator using `exportGenePop_RLDNe`.
4.  **Parameter Creation**: Generate the necessary control files using `create_LDNe_params`.
5.  **Execution**: Run the NeEstimator executable via `run_LDNe`.
6.  **Parsing**: Import the results into R using `read_LDNeOutFile`.

## Main Functions

### Data Conversion
- `alleles2genotypes()`: Converts data from two columns per locus (alleles) to one column per locus (genotypes).
- `genotypes2alleles()`: Converts data from one column per locus to two columns per locus.

### Analysis Pipeline
- `readInData(data, genotypeStart, pedigreeColumn, nameColumn)`: Initializes the data object.
- `exportGenePop_RLDNe(EFGLdata)`: Repurposed from `EFGLmh` to create the input file for the LDNe engine.
- `create_LDNe_params(rldne_obj)`: Sets up the parameters for the LD method.
- `run_LDNe(rldne_obj)`: Calls the NeEstimator 2.1 binary.
- `read_LDNeOutFile(rldne_obj)`: Reads the output text file and returns a structured data frame of Ne estimates and confidence intervals.

## Example Usage
```R
library(RLDNe)

# Load example data
data("wgp_example_2col")

# Format column names for the parser (Locus.A1, Locus.A2 style)
colnames(wgp_example_2col) <- gsub("_(\\d)$", replacement = "\\.A\\1", colnames(wgp_example_2col))

# 1. Initialize
efgl <- readInData(wgp_example_2col, genotypeStart = 3, pedigreeColumn = 1, nameColumn = 2)

# 2. Export to Genepop format
rldne <- exportGenePop_RLDNe(EFGLdata = efgl)

# 3. Create parameters
rldne <- create_LDNe_params(rldne)

# 4. Run NeEstimator
std_out <- run_LDNe(rldne)

# 5. Retrieve results
results_df <- read_LDNeOutFile(rldne)
```

## Tips
- **Column Naming**: Ensure your allele columns follow the `.A1` and `.A2` suffix convention before calling `readInData`.
- **Dependencies**: This package relies on the `EFGLmh` package logic for data handling.
- **Iterative Runs**: Because `run_LDNe` handles the file system operations, it is highly effective for use within `lapply` or `for` loops when performing sensitivity analyses or jackknifing.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)