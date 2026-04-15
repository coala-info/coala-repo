---
name: bioconductor-bionetstat
description: BioNetStat performs statistical analysis and comparison of biological networks using graph spectra, entropy, and centrality measures. Use when user asks to perform differential network analysis, compare structural properties across multiple biological states, or identify key variables using network centrality tests.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BioNetStat.html
---

# bioconductor-bionetstat

name: bioconductor-bionetstat
description: Statistical analysis and comparison of biological networks (gene expression, metabolites, etc.) using graph spectra, entropy, and centrality measures. Use this skill to perform differential network analysis, compare structural properties across multiple states, and identify key variables in biological systems using the BioNetStat R package.

## Overview
BioNetStat is a Bioconductor package designed to compare two or more biological networks simultaneously. It moves beyond simple pairwise comparisons by using graph spectra (eigenvalues of adjacency matrices) and other structural properties like spectral entropy, degree distribution, and node centralities to identify differences between biological states (e.g., control vs. disease).

## Core Workflow

### 1. Data Preparation
BioNetStat requires two main inputs: a variable value matrix (e.g., gene expression) and sample labels.

```R
library(BioNetStat)

# Load numeric variable data (rows = variables, cols = samples)
# Note: readVarFile reads numeric values only
matrix_data <- readVarFile(fileName = "data.csv", sep = ";", dec = ".")

# Create labels for different states/conditions
# Uses the first 'factor' column by default
labmat <- doLabels(fileName = "data.csv")

# Or specify a specific factor and classes to compare
labmat2 <- doLabels(fileName = "data.csv", 
                    factorName = "condition", 
                    classes = c("Control", "Treatment"))

# Optional: Load variable sets (e.g., GMT file for pathways)
varSets <- readSetFile(fileName = "pathways.gmt")
```

### 2. Defining the Adjacency Matrix
Before analysis, define how the networks should be constructed.

```R
# Parameters: method (pearson, spearman, kendall), association type, threshold type, and value
funAdjMat <- adjacencyMatrix(method = "pearson", 
                             association = "corr", 
                             threshold = "corr", 
                             thr.value = 0.5, 
                             weighted = TRUE)
```

### 3. Differential Network Analysis
Compare the global structural properties of networks across states.

```R
# Available methods: spectralDistributionTest, spectralEntropyTest, degreeDistributionTest, 
# degreeCentralityTest, betweennessCentralityTest, closenessCentralityTest, 
# eigenvectorCentralityTest, clusteringCoefficientTest

res <- diffNetAnalysis(method = spectralDistributionTest,
                       varFile = matrix_data, 
                       labels = labmat, 
                       varSets = NULL, # Use NULL for all variables or pass varSets
                       adjacencyMatrix = funAdjMat,
                       numPermutations = 1000, 
                       min.vert = 10,
                       options = list("bandwidth" = "Silverman"))
print(res)
```

### 4. Differential Vertex (Node) Analysis
Identify specific variables (nodes) that change their importance/centrality between networks.

```R
# Available methods: degreeCentralityVertexTest, betweennessCentralityVertexTest, 
# closenessCentralityVertexTest, eigenvectorCentralityVertexTest, clusteringCoefficientVertexTest

res_vertex <- diffNetAnalysis(method = degreeCentralityVertexTest,
                              varFile = matrix_data,
                              labels = labmat, 
                              adjacencyMatrix = funAdjMat, 
                              numPermutations = 1000,
                              options = list("bandwidth" = "Silverman"))
# Access results
res_vertex$all
```

## GUI Usage
BioNetStat includes a Shiny-based graphical user interface for users who prefer an interactive approach.

```R
runBioNetStat()
```

## Key Functions Reference
- `readVarFile()`: Reads numeric data for network construction.
- `doLabels()`: Extracts experimental design factors from data files.
- `readSetFile()`: Reads GMT files defining groups of variables (pathways).
- `adjacencyMatrix()`: Configures the correlation and thresholding logic.
- `diffNetAnalysis()`: The primary engine for both global network and local node comparisons.

## Reference documentation
- [Tutorial for using BioNetStat in command lines](./references/BNS_tutorial_by_command_line.md)
- [Tutorial para uso do BioNetStat em linhas de comando (PT)](./references/BNS_tutorial_by_command_line_pt.Rmd)
- [Tutorial for using BioNetStat in command lines (US)](./references/BNS_tutorial_by_command_line_us.Rmd)
- [BioNetStat Interface Tutorial (Rmd)](./references/vignette.Rmd)
- [BioNetStat Background and Interface Tutorial (MD)](./references/vignette.md)