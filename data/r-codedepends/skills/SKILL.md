---
name: r-codedepends
description: This tool performs static analysis of R code to identify variable dependencies, inputs, and outputs across scripts. Use when user asks to analyze R script workflows, track variable relationships, identify minimal code for specific results, or visualize dependency graphs.
homepage: https://cran.r-project.org/web/packages/codedepends/index.html
---

# r-codedepends

name: r-codedepends
description: Analyze R code dependencies, track variable relationships, and visualize script workflows. Use when you need to understand which parts of an R script depend on others, identify the minimal code needed to compute a specific variable, or generate dependency graphs for reproducible research.

# r-codedepends

## Overview
The `CodeDepends` package provides tools for the static analysis of R code. It identifies the inputs (variables read) and outputs (variables assigned) for each expression in a script. This allows users to build dependency graphs, identify "dead code," and determine the exact sequence of commands required to compute a specific result. It is particularly useful for auditing long scripts and ensuring reproducibility.

## Installation
To install the package from CRAN:
`install.packages("CodeDepends")`

## Core Workflows

### Analyze a Script
The primary workflow involves reading a script and extracting its dependency information.

```r
library(CodeDepends)

# Read an R script or a directory of scripts
sc = readScript("analysis_script.R")

# Extract inputs and outputs for each code block
info = getInputs(sc)

# View variables defined in the script
names(info)
```

### Trace Variable Dependencies
Find which expressions or variables are required to produce a specific target variable.

```r
# Find what 'final_model' depends on
deps = getVariableDepends("final_model", info)

# Get the indices of the code blocks needed to compute 'final_model'
thread_idx = getDependsThread("final_model", info)

# Extract the actual code for those blocks
needed_code = sc[thread_idx]
```

### Visualize Code Structure
Generate graphs to see how data flows through the script.

```r
# Create a dependency graph object
g = makeCodeGraph(info)

# Plot the graph (requires the 'igraph' or 'Rgraphviz' package)
plot(g)
```

### Handle Different File Types
`CodeDepends` can handle standard R scripts, RMarkdown, and Sweave files.

```r
# Read from an RMarkdown file
sc_rmd = readScript("report.Rmd", type = "Rnw") # Works for Rmd/Rnw

# Analyze a specific function's body
func_info = getInputs(body(my_function))
```

## Tips for Effective Analysis
- **Side Effects**: Be aware that static analysis may not always catch side effects like file system changes or environment modifications unless they involve standard R assignments.
- **Non-Standard Evaluation**: Functions using NSE (like `library()` or `subset()`) are handled via heuristics; check the `info` object if dependencies seem missing.
- **Script Cleaning**: Use `getInputs` to find variables that are defined but never used (dead code) to simplify complex scripts.
- **Task Graphs**: Use `taskGraph` to create high-level visualizations of script sections rather than individual lines.

## Reference documentation
- [GitHub Articles](./references/articles.md)
- [Change Log](./references/changes.md)
- [Project Home Page](./references/home_page.md)
- [Wiki](./references/wiki.md)