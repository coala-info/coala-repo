---
name: bioconductor-timerquant
description: This tool analyzes and simulates tandem fluorescent protein timers to quantify protein maturation kinetics and half-lives. Use when user asks to model fluorophore maturation, calculate protein stability from fluorescence ratios, simulate FRET effects, or analyze steady-state and time-dependent fluorescence data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TimerQuant.html
---


# bioconductor-timerquant

name: bioconductor-timerquant
description: Analysis and simulation of tandem fluorescent protein timers (tFTs). Use this skill to model fluorophore maturation kinetics, calculate protein half-lives from fluorescence ratios, simulate the effects of FRET on timer signals, and analyze steady-state or time-dependent fluorescence data.

# bioconductor-timerquant

## Overview
The `TimerQuant` package provides tools for the quantification and simulation of tandem fluorescent protein timers (tFTs). tFTs consist of two fluorophores with different maturation rates (typically a fast-maturing green FP and a slower-maturing red FP) fused to a protein of interest. The ratio of their intensities serves as a proxy for protein age and half-life. This skill enables modeling these kinetics, accounting for FRET, and simulating noise in timer signals.

## Core Functions and Workflows

### 1. Modeling Maturation and Ratios
The package uses differential equations to model the population of non-mature and mature fluorophores.

- `x1(p0, m, k, t)`: Calculates the molecular population of a mature fluorophore at time `t` given production rate `p0`, maturation rate `m`, and degradation rate `k`.
- `x1ss(p0, m, k)`: Calculates the steady-state population of a mature fluorophore.
- `signal(T1, T2, TA, TB, E)`: Calculates the timer signal (log2 fold-change of ratios) between two protein half-lives `TA` and `TB`, given maturation times `T1` and `T2` and FRET efficiency `E`.

### 2. Simulation and Noise Analysis
To understand how production rates or FRET affect the reliability of timer readouts:

- `simulatedSignal(T1, T2, TA, TB, sigmaAdd, p, E)`: Simulates the timer signal with optional additive noise (`sigmaAdd`).
- `simulatedSignalN(...)`: A version of the simulation that produces multiple realizations to estimate mean and standard deviation.
- `fitCV(df)`: Fits the coefficient of variation (CV) to simulation results to find the optimal maturation time for a given protein half-life.

### 3. Visualization Tools
- `genRatioHeatmap(...)`: Generates a heatmap of steady-state ratios as a function of maturation time and protein half-life.
- `genTimeSteadyStateHeatmap(...)`: Visualizes the time required for a timer to reach steady state (`Tss`).
- `plotPrimordiumProfile(...)`: Specialized function for plotting spatial fluorescence profiles (e.g., from zebrafish data).

### 4. Dynamic Models
For scenarios where production or degradation rates change over time:
- `solveModel(x01, x02, t, m1, m2, typeProd, typeDeg, p0, k0, E)`: Solves the time-dependent model for arbitrary production/degradation functions (e.g., "linearIncrease", "burst", "stepUp").
- `rFun(type, r0, tf)`: Helper to create rate functions for the solver.

## Typical Workflow: Calculating Protein Half-life
1. **Define Parameters**: Set maturation times (e.g., `T1 <- 5`, `T2 <- 100`) and degradation rates.
2. **Calculate Ratios**: Use `x1ss` for steady-state ratios or `x1` for time-course data.
3. **Account for FRET**: If FRET is present, adjust the ratio using the efficiency `E`. The steady-state ratio with FRET is:
   `R = f * (m2 * (k + m1)) / (m1 * (k + m2 - E * m2))`
4. **Compare Conditions**: Use `signal()` to determine the sensitivity of the timer to changes in protein stability.

## Tips for Interpretation
- **Steady State**: The time to reach steady state (`Tss`) is primarily determined by the slower-maturing fluorophore (FP2) and the protein degradation rate.
- **FRET Reordering**: High FRET efficiency can reorder the slopes of timer profiles, potentially making a slower-maturing timer appear more sensitive than it is.
- **Optimal Maturation**: The "best" timer for a specific experiment depends on the expected protein half-life; use `fitCV` to identify which FP2 maturation rate minimizes the coefficient of variation for your target half-life.

## Reference documentation
- [Supplementary Methods - Automatic generation of paper figures](./references/genPaperFigures.md)
- [Supplementary Methods - mathematical derivations](./references/mathematerDerivations.md)