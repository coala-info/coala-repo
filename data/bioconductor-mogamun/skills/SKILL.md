---
name: bioconductor-mogamun
description: bioconductor-mogamun identifies active modules in multiplex biological networks using a multi-objective genetic algorithm to balance node scores and subnetwork density. Use when user asks to find active subnetworks across multiple interaction layers, identify significant modules from differential expression data, or optimize subnetwork density and statistical significance.
homepage: https://bioconductor.org/packages/release/bioc/html/MOGAMUN.html
---

# bioconductor-mogamun

## Overview
MOGAMUN is an R package designed to identify active modules within multiplex biological networks. It uses a multi-objective genetic algorithm to optimize two conflicting objectives: the average nodes score (based on differential expression) and the density of the subnetwork. This approach allows for the discovery of subnetworks that are both statistically significant and topologically dense across multiple layers of biological interaction.

## Workflow

### 1. Initialization of Parameters
Define the evolution parameters using `mogamun_init()`. While default values are recommended for most parameters, `MinSize` and `MaxSize` are often adjusted based on the desired subnetwork scale.

```r
library(MOGAMUN)

# Initialize with custom generations and population size for testing
# Default: Generations = 500, PopSize = 100
params <- mogamun_init(
    Generations = 500, 
    PopSize = 100,
    MinSize = 15,
    MaxSize = 50,
    Measure = "FDR",    # Or "PValue"
    ThresholdDEG = 0.05
)
```

### 2. Loading Input Data
MOGAMUN requires a differential expression file and a directory containing network layers.

*   **Differential Expression**: CSV with columns `gene` and either `FDR` or `PValue`. Including `logFC` is recommended for visualization.
*   **Network Layers**: A directory containing tab-separated files (2 columns: NodeA, NodeB). Each filename must start with a unique character.

```r
# Load data and build the multiplex network
loadedData <- mogamun_load_data(
    EvolutionParameters = params,
    DifferentialExpressionPath = "path/to/DE_results.csv",
    NodesScoresPath = "path/to/output_scores.csv", # Created if it doesn't exist
    NetworkLayersDir = "path/to/layers_folder/",
    Layers = "12" # Use files starting with '1' and '2'
)
```

### 3. Running the Algorithm
Execute the genetic algorithm. It is highly recommended to run the algorithm multiple times (e.g., 30 runs) to ensure convergence to the global Pareto front.

```r
# Run MOGAMUN
# Note: Parallel execution (Cores > 1) is not supported on Windows
mogamun_run(
    LoadedData = loadedData, 
    Cores = 1, 
    NumberOfRunsToExecute = 30, 
    ResultsDir = "results_output"
)
```

### 4. Post-processing and Visualization
After the runs complete, use `mogamun_postprocess` to calculate the accumulated Pareto front (rank 1 subnetworks across all runs) and merge similar modules.

```r
# Post-process results
mogamun_postprocess(
    LoadedData = loadedData, 
    ExperimentDir = "results_output/YYYY-MM-DD_HHMMSS/", # Path created by mogamun_run
    JaccardSimilarityThreshold = 70, # Threshold for merging similar subnetworks
    VisualizeInCytoscape = FALSE     # Set TRUE if Cytoscape is running
)
```

## Result Interpretation
*   **StatisticsPerGeneration**: CSV file used to monitor convergence of the two objectives.
*   **Run_N.txt**: Contains the final population. Each row is a subnetwork. The last four values in a row are: Average Nodes Score, Density, Rank, and Crowding Distance.
*   **Rank 1**: These are the non-dominated (best) subnetworks.
*   **Visualization**: If using Cytoscape, nodes are colored by `logFC` (Red: Up, Green: Down) and edges are colored by network layer.

## Reference documentation
- [Finding active modules with MOGAMUN](./references/MOGAMUN_Vignette.Rmd)
- [MOGAMUN Vignette (Markdown)](./references/MOGAMUN_Vignette.md)