---
name: bioconductor-trajectorygeometry
description: TrajectoryGeometry quantifies and visualizes the directionality of trajectories in N-dimensional space by projecting vectors onto a unit sphere. Use when user asks to quantify trajectory directionality, test path significance, compare different lineages, or analyze branch points.
homepage: https://bioconductor.org/packages/release/bioc/html/TrajectoryGeometry.html
---


# bioconductor-trajectorygeometry

## Overview

The `TrajectoryGeometry` package provides tools to quantify and visualize the directionality of trajectories in N-dimensional space (e.g., PCA projections or gene expression matrices). It works by projecting vectors from a starting point onto a unit sphere and measuring the clustering of these projections. A path with consistent directionality will result in tightly clustered points on the sphere, whereas a wandering path will produce dispersed points.

## Core Workflow

### 1. Data Preparation
The package requires a matrix of cell attributes (rows = cells, columns = features like PCs) and a vector of pseudotime values.

```r
library(TrajectoryGeometry)

# Filter matrix and pseudotime to include only cells in the trajectory
traj_attributes = single_cell_matrix[!is.na(pseudo_time), ]
traj_pseudo_time = pseudo_time[!is.na(pseudo_time)]

# Normalize pseudotime (0 to 100)
pseudo_norm = 100 * ((traj_pseudo_time - min(traj_pseudo_time)) / (max(traj_pseudo_time) - min(traj_pseudo_time)))
```

### 2. Sampling a Path
To reduce noise and ensure even representation across pseudotime, sample a representative path.

```r
# Samples one cell from each of 10 equal pseudotime windows
sampled_path = samplePath(traj_attributes, pseudo_norm)
```

### 3. Testing Directionality
Test if the sampled path is more directional than random chance.

```r
# Test using permutation of columns
results = testPathForDirectionality(
    path = sampled_path[, 1:3], 
    randomizationParams = c('byPermutation', 'permuteWithinColumns'),
    statistic = "mean", 
    N = 1000
)

# Interpret results
# results$p.value: Significance of directionality
# results$sphericalData$distance: Mean distance from the center (lower = more directional)
```

### 4. Comparing Trajectories
To compare two lineages (e.g., Hepatocytes vs. Cholangiocytes), use `analyseSingleCellTrajectory` to sample multiple paths and compare their distance metrics.

```r
hep_ans = analyseSingleCellTrajectory(hep_attr, hep_time, nSamples = 100, N = 1)
chol_ans = analyseSingleCellTrajectory(chol_attr, chol_time, nSamples = 100, N = 1)

# Visualize comparison
comp = visualiseTrajectoryStats(chol_ans, "distance", traj2Data = hep_ans)
comp$plot
```

### 5. Branch Point Analysis
Identify where a trajectory becomes more or less directional by testing successive starting points.

```r
branch_results = analyseBranchPoint(
    traj_attributes, 
    traj_pseudo_time,
    start = 0, stop = 50, step = 5,
    nSamples = 100
)

stats = visualiseBranchPointStats(branch_results)
print(stats$distancePlot) # Look for decreases in distance indicating stabilized direction
```

## Visualization
For 3D data (e.g., first 3 PCs), you can visualize the path and its projection on the sphere.

```r
plotPathProjectionCenterAndCircle(
    path = sampled_path[, 1:3],
    projection = results$sphericalData$projections,
    center = results$sphericalData$center,
    radius = results$sphericalData$distance,
    circleColor = "white"
)
```

## Key Parameters
- **randomizationParams**: 
    - `bySteps`: Generates random walks. Use `preserveLengths` to keep step sizes consistent with data.
    - `byPermutation`: Shuffles data. Use `permuteWithinColumns` for gene expression data to maintain gene-specific distributions.
- **statistic**: "mean", "median", or "max" to define how the "center" of the spherical projection is calculated.
- **nonNegative**: Add to `randomizationParams` if working with raw expression data where negative values are impossible.

## Reference documentation
- [SingleCellTrajectoryAnalysis](./references/SingleCellTrajectoryAnalysis.md)
- [TrajectoryGeometry](./references/TrajectoryGeometry.md)