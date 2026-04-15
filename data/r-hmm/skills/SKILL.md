---
name: r-hmm
description: This tool uses the R package HMM to build, simulate, and analyze discrete-time and discrete-space Hidden Markov Models. Use when user asks to initialize HMM parameters, simulate state sequences, decode hidden states using the Viterbi algorithm, calculate probabilities with Forward or Backward algorithms, or estimate parameters using Baum-Welch.
homepage: https://cran.r-project.org/web/packages/hmm/index.html
---

# r-hmm

name: r-hmm
description: Specialized for using the R package 'HMM' to build, simulate, and analyze discrete-time, discrete-space Hidden Markov Models. Use this skill when the user needs to implement HMMs in R, including state sequence decoding (Viterbi), probability calculations (Forward/Backward), or parameter estimation (Baum-Welch).

## Overview
The `HMM` package is a lightweight and efficient library for managing discrete-time and discrete-space Hidden Markov Models. It allows users to define model parameters (states, symbols, and probabilities), simulate data, and perform standard inference tasks like decoding the most likely state sequence or estimating parameters from observed data.

## Installation
To install the package from CRAN:
```R
install.packages("HMM")
library(HMM)
```

## Core Workflow

1.  **Initialization**: Define the hidden states, the observable symbols, and the initial probability matrices (start, transition, and emission).
2.  **Simulation (Optional)**: Generate a sequence of states and observations from a defined HMM.
3.  **Evaluation**: Calculate the probability of an observed sequence using Forward or Backward algorithms.
4.  **Decoding**: Identify the most probable sequence of hidden states given an observation sequence using the Viterbi algorithm.
5.  **Learning**: Refine the transition and emission probabilities based on observed data using the Baum-Welch algorithm.

## Main Functions

- `initHMM(States, Symbols, startProbs, transProbs, emissionProbs)`: Initializes an HMM object. If probabilities are omitted, they are initialized uniformly.
- `simHMM(hmm, length)`: Simulates a path of states and observations of a given length.
- `viterbi(hmm, observation)`: Computes the most probable sequence of hidden states (the Viterbi path).
- `forward(hmm, observation)`: Computes the forward probabilities (log-scale).
- `backward(hmm, observation)`: Computes the backward probabilities (log-scale).
- `posterior(hmm, observation)`: Computes the posterior probabilities of being in a specific state at a specific time point.
- `baumWelch(hmm, observation, maxIterations, delta)`: Performs the Expectation-Maximization algorithm to estimate HMM parameters.

## Examples

### Basic HMM Setup and Decoding
```R
# Define states and symbols
states <- c("Fair", "Unfair")
symbols <- c("1", "2", "3", "4", "5", "6")

# Initialize HMM
hmm <- initHMM(states, symbols, 
               startProbs = c(0.5, 0.5),
               transProbs = matrix(c(0.9, 0.1, 0.1, 0.9), 2),
               emissionProbs = matrix(c(rep(1/6, 6), c(rep(0.1, 5), 0.5)), 2, byrow = TRUE))

# Observations
obs <- c("6", "6", "6", "1", "2", "6")

# Find most likely state sequence
viterbi_path <- viterbi(hmm, obs)
print(viterbi_path)
```

### Parameter Estimation (Baum-Welch)
```R
# Start with a generic model
hmm_init <- initHMM(c("A", "B"), c("L", "R"))

# Observed data
observations <- c("L", "L", "R", "R", "L", "R", "L", "L")

# Optimize parameters
bw_result <- baumWelch(hmm_init, observations, maxIterations = 100)
print(bw_result$hmm)
```

## Tips and Best Practices
- **Log-Space**: The `forward` and `backward` functions return values in log-scale to prevent numerical underflow in long sequences.
- **Matrix Orientation**: Ensure `transProbs` and `emissionProbs` are correctly oriented. In `transProbs`, rows represent the "from" state and columns represent the "to" state.
- **Discrete Only**: This package is strictly for discrete observations. For continuous data (e.g., Gaussian emissions), consider other packages like `depmixS4`.

## Reference documentation
- [HMM Home Page](./references/home_page.md)