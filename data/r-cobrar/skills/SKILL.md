---
name: r-cobrar
description: This tool performs constraint-based metabolic network analysis and modeling in R. Use when user asks to perform flux balance analysis, read or write SBML files, or manage and manipulate metabolic models.
homepage: https://cran.r-project.org/web/packages/cobrar/index.html
---


# r-cobrar

name: r-cobrar
description: Constraint-based metabolic network analysis in R using the cobrar package. Use this skill when you need to perform Flux Balance Analysis (FBA), read/write SBML files, or manage metabolic models (modelorg objects).

# r-cobrar

## Overview
The `cobrar` package provides a comprehensive framework for COnstraint-based Reconstruction and Analysis (COBRA) of metabolic networks. It is a modern successor to the `sybil` package, offering built-in support for SBML (via libSBML) and linear programming (via GLPK) without requiring external R-interface packages.

## Installation
To install the package from GitHub (as it is currently the primary distribution method):

```r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("Waschina/cobrar")
```

Note: System dependencies `libSBML` and `glpk` must be installed on the host machine.

## Core Workflow

### 1. Loading a Model
Models are typically stored in SBML format. `cobrar` reads these into a `modelorg` class object.

```r
library(cobrar)

# Load an example SBML file
fpath <- system.file("extdata", "e_coli_core.xml", package="cobrar")
model <- readSBMLmod(fpath)

# Inspect the model
print(model)
```

### 2. Flux Balance Analysis (FBA)
Perform standard FBA to predict metabolic fluxes that maximize or minimize a defined objective function (usually biomass production).

```r
# Run FBA
result <- fba(model)

# Access results
result@obj_fct  # Objective value
result@fluxes   # Vector of predicted fluxes
```

### 3. Parsimonious FBA (pFBA)
pFBA (or MTF - Minimization of Total Flux) finds a flux distribution that achieves the optimal objective value while minimizing the total sum of absolute fluxes, representing more efficient enzyme usage.

```r
pfba_res <- pFBA(model)
```

### 4. Model Manipulation
You can modify constraints (lower and upper bounds) or the objective function directly on the `modelorg` object.

```r
# Change bounds for a specific reaction (e.g., index 10)
model@lowbnd[10] <- 0
model@uppbnd[10] <- 1000

# Change objective coefficient
model@obj_coef[which(model@react_id == "EX_glc__D_e")] <- -1
```

## Key Functions
- `readSBMLmod(filename)`: Imports an SBML file into a `modelorg` object.
- `writeSBMLmod(model, filename)`: Exports a `modelorg` object to SBML (Level 3 Version 2).
- `fba(model)`: Executes Flux Balance Analysis.
- `pFBA(model)`: Executes Parsimonious Flux Balance Analysis.
- `findDeadEndMetabolites(model)`: Identifies metabolites that cannot be produced or consumed.

## Tips
- **Memory Management**: Unlike its predecessor, `cobrar` uses R's garbage collector for C++ objects, making it more stable for large-scale simulations.
- **Solvers**: GLPK is the default solver. For high-performance needs, the `cobrarCPLEX` plugin can be used if CPLEX is installed.
- **Annotations**: Use the `CVTerms` columns in `react_attr` or `met_attr` for controlled vocabulary terms.
- **Objectives**: While SBML supports multiple objectives, `cobrar` uses the `activeObjective` defined in the file or the first one found.

## Reference documentation
- [LICENSE](./references/LICENSE.md)
- [README.Rmd](./references/README.Rmd.md)
- [README](./references/README.md)
- [README_WIN](./references/README_WIN.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)