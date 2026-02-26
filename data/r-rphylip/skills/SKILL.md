---
name: r-rphylip
description: The Rphylip package provides an R interface for executing PHYLIP programs to perform phylogenetic analyses directly from the R console. Use when user asks to perform DNA or protein parsimony, calculate maximum likelihood, compute distance matrices, or build trees using neighbor-joining and other phylogenetic methods.
homepage: https://cloud.r-project.org/web/packages/Rphylip/index.html
---


# r-rphylip

## Overview
The `Rphylip` package provides a comprehensive R interface for Joseph Felsenstein's PHYLIP program package. It allows users to execute PHYLIP programs (such as `dnapars`, `protml`, `neighbor`, etc.) directly from the R console, passing data from R objects (like `phylo` or `DNAbin`) and receiving results back into the R environment.

## Installation
To use this package, you must have both the R package and the PHYLIP executables installed on your system.

```r
install.packages("Rphylip")
```

After installing the R package, you must define the path to your PHYLIP executables (e.g., `/usr/local/bin` or `C:/PHYLIP/bin`) so R can find them.

## Core Workflow
The general workflow for any `Rphylip` function follows these steps:
1. **Prepare Data**: Input data is typically an R object (e.g., a matrix of characters or a `DNAbin` object).
2. **Call Function**: Use the R wrapper function corresponding to the PHYLIP program (e.g., `Rdnapars` for `dnapars`).
3. **Specify Path**: If not set globally, provide the `path` argument pointing to the PHYLIP executable directory.
4. **Process Output**: The function returns a phylogenetic tree (usually of class `phylo`) or a specific analysis object.

## Key Functions
`Rphylip` covers approximately 90% of PHYLIP programs. Common functions include:

### DNA Analysis
- `Rdnapars`: DNA parsimony.
- `Rdnaml`: DNA maximum likelihood.
- `Rdnadist`: Computes distance matrix from DNA sequences.

### Protein Analysis
- `Rprotpars`: Protein parsimony.
- `Rprotml`: Protein maximum likelihood.
- `Rprotdist`: Computes distance matrix from protein sequences.

### Distance & Tree Building
- `Rneighbor`: Neighbor-Joining or UPGMA method.
- `Rfitch`: Fitch-Margoliash and least-squares methods.
- `Rkitsch`: Fitch-Margoliash and least-squares methods with molecular clock.

### Discrete Characters
- `Rpars`: Discrete character parsimony.
- `Rmix`: Mixed method parsimony.

## Usage Tips
- **Executable Path**: You can set the path globally for a session using `options(phylip.path = "/path/to/phylip/bin")` to avoid repeating the `path` argument in every function call.
- **Citations**: Any publication using this package should cite both the `Rphylip` package and the specific PHYLIP programs used.
- **Data Formats**: The package handles the conversion of R data structures into the interleaved or sequential formats required by PHYLIP internally.

## Reference documentation
- [Home Page](./references/home_page.md)