---
name: r-sbpiper
description: The r-sbpiper tool provides functions to analyze and visualize repetitive parameter estimations and simulations for mathematical models. Use when user asks to calculate parameter density statistics, perform PCA on best fits, generate profile likelihood estimations, or visualize deterministic and stochastic time-course simulations.
homepage: https://cran.r-project.org/web/packages/sbpiper/index.html
---


# r-sbpiper

name: r-sbpiper
description: Expert guidance for using the sbpiper R package to analyze repetitive parameter estimations and simulations of mathematical models (ODEs/SDEs). Use this skill when a user needs to calculate statistics or generate plots for parameter density, PCA of best fits, Profile Likelihood Estimations (PLE), or time-course simulations (deterministic/stochastic) based on SBpipe outputs or compatible data structures.

# r-sbpiper

## Overview
`sbpiper` is an R package designed for the analysis of repetitive parameter estimations and simulations of mathematical models. It provides an API to process results from models typically defined by Ordinary Differential Equations (ODEs) or Stochastic Differential Equations (SDEs). It is the primary analytical engine for the [SBpipe](http://sbpipe.readthedocs.io) software suite.

Key capabilities:
- **Parameter Estimation Analysis**: Statistics and plots for parameter density, PCA of best fits, and 1D/2D Profile Likelihood Estimations (PLE).
- **Simulation Analysis**: Statistics and plots for deterministic and stochastic time courses (cartesian and heatmap).
- **Parameter Scans**: Visualization of model behavior across one or two parameter variations.

## Installation
To install the stable version from CRAN:
```r
install.packages("sbpiper")
library(sbpiper)
```

## Core Workflows

### 1. Parameter Estimation Analysis
Analyze the results of multiple parameter estimation runs to assess identifiability and distribution.

- **Parameter Density**: Use `sbpiper` functions to visualize the distribution of estimated parameters across multiple runs.
- **PCA of Best Fits**: Perform Principal Component Analysis on the top-performing parameter sets to identify correlations.
- **Profile Likelihood (PLE)**: Generate 1D and 2D PLE plots to evaluate parameter sensitivity and confidence intervals.

### 2. Model Simulation Analysis
Process and visualize time-course data from model simulations.

- **Time Courses**: Generate mean and standard deviation plots for stochastic simulations or single trajectories for deterministic ones.
- **Heatmaps**: Visualize high-dimensional simulation data or parameter scans using heatmaps.
- **Parameter Scans**: Analyze how model outputs change when one or two parameters are systematically varied.

## Usage Tips
- **Data Input**: `sbpiper` expects data frames or file paths formatted according to SBpipe standards (typically CSV files containing parameter sets or simulation trajectories).
- **Subsetting**: Many functions allow for analysis using only a subset of the "best" computed parameter sets (e.g., based on a cost function or likelihood).
- **Integration**: While designed for SBpipe, the functions can be used independently in R if the input data matches the expected schema (columns for parameters/time and rows for observations/simulations).

## Reference documentation
- [SBpiper - Data analysis functions for SBpipe](./references/README.md)