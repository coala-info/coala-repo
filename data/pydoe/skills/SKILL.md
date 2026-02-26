---
name: pydoe
description: The pydoe tool generates structured experimental design matrices using various Design of Experiments methods to optimize information gain and minimize trial counts. Use when user asks to create factorial designs, generate Latin-Hypercube samples, perform response-surface modeling, or construct optimal experimental plans.
homepage: https://github.com/pydoe/pydoe
---


# pydoe

## Overview
The `pydoe` skill provides a suite of Design of Experiments (DOE) methods to help you create structured experimental plans. Instead of testing every possible combination or testing one factor at a time, `pydoe` generates matrices that maximize information gain while minimizing the number of required trials. It covers everything from standard factorial designs to advanced space-filling and optimal designs.

## Core Design Patterns

### Factorial Designs
Use these when you want to understand the main effects and interactions between factors.
- **Full Factorial (`fullfact`)**: Explores every possible combination of factor levels.
- **2-Level Full Factorial (`ff2n`)**: Specifically for factors with only two levels (high/low).
- **Fractional Factorial (`fracfact`)**: Use a string notation (e.g., "A B AB") to define a subset of a full factorial design to save resources.
- **Plackett-Burman (`pbdesign`)**: Efficiently identifies main effects in a large number of factors using very few runs.

### Response-Surface Designs
Use these for optimization tasks where you need to model the curvature of the response.
- **Box-Behnken (`bbdesign`)**: Requires three levels for each factor but avoids extreme combinations (corners).
- **Central Composite (`ccdesign`)**: Adds "star points" to a factorial design to estimate second-order effects.

### Randomized and Space-Filling Designs
Use these for computer experiments and high-dimensional simulations.
- **Latin-Hypercube Sampling (`lhs`)**: Ensures that each factor is sampled across its entire range. Use the `criterion` parameter (e.g., `center`, `maximin`) to improve the space-filling properties.
- **Low-Discrepancy Sequences**: Use `sobol_sequence` or `halton_sequence` for quasi-random sampling that covers the space more uniformly than pure random sampling.

### Optimal Designs
Use `optimal_design` when you have a specific statistical goal or a non-standard experimental region.
- **Criteria**: Choose based on your goal (e.g., 'D' for minimizing variance of parameter estimates, 'A' for minimizing the average variance).
- **Algorithms**: Supports Sequential (Dykstra), Fedorov, and DETMAX search algorithms.

## Expert Tips and Best Practices

1. **Scaling**: Most `pydoe` functions return matrices in a coded format (usually -1 to 1 or 0 to level-1). Always map these coded values back to your physical units (e.g., temperature, pressure) before running experiments.
2. **Randomization**: While `pydoe` generates the structure, always randomize the actual order of your experimental runs to protect against time-dependent biases.
3. **LHS Criterion**: When using `lhs(n, samples)`, the default is random. For better results in sensitivity analysis, use `criterion='maximin'` to maximize the minimum distance between points.
4. **Factorial Notation**: In `fracfact`, the generator string is case-sensitive and follows standard statistical notation. Ensure your generators do not confound effects you wish to measure independently.
5. **Handling Constraints**: If your experimental space is not a simple hypercube, use `optimal_design` to find the best points within your specific constrained geometry.

## Reference documentation
- [PyDOE: An Experimental Design Package for Python](./references/github_com_pydoe_pydoe.md)