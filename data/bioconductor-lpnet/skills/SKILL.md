---
name: bioconductor-lpnet
description: This tool infers intracellular signal transduction networks from steady-state or time-series perturbation data using linear programming. Use when user asks to reconstruct gene or protein interaction networks from knockdown experiments, perform cross-validation to optimize penalty parameters, or integrate prior biological knowledge into network inference.
homepage: https://bioconductor.org/packages/release/bioc/html/lpNet.html
---


# bioconductor-lpnet

name: bioconductor-lpnet
description: Infer intracellular signal transduction networks from perturbation data (steady-state or time-series) using linear programming. Use this skill when you need to reconstruct gene or protein interaction networks from RNAi or knockdown experiments, perform cross-validation to find optimal penalty parameters, or integrate prior biological knowledge into network inference.

## Overview
The `lpNet` package implements a linear programming (LP) approach to infer signaling networks. It treats signal transduction as a flow through a network where nodes are genes/proteins and edges represent interaction strengths. By observing how perturbations (like knockdowns) affect the system compared to a threshold ($\delta$), the package solves an inverse problem to find the most likely network topology and edge weights.

## Core Workflow

### 1. Data Preparation
You need an observation matrix (or 3D array for time-series) and a perturbation vector/matrix.

```R
library(lpNet)

# n: number of genes, K: number of experiments
n <- 5 
K <- 7 

# Observations: rows = genes, cols = experiments
obs <- matrix(rnorm(n*K), nrow=n, ncol=K)

# Define threshold delta (e.g., mean of observations per gene)
delta <- apply(obs, 1, mean)
delta_type <- "perGene"

# Perturbation vector b: 0 if gene is inactivated, 1 otherwise
# Length should be n * K
b <- rep(1, n * K) 
# Example: knockdown gene 1 in experiment 1
b[1] <- 0 
```

### 2. Network Inference
Use `doILP` to infer the network and `getAdja` to extract the adjacency matrix.

```R
# Infer network with penalty parameter lambda
res <- doILP(obs, delta, lambda=1, b, n, K, 
             T_=NULL, annot=getEdgeAnnot(n), delta_type)

# Convert to adjacency matrix
adja <- getAdja(res, n)
```

### 3. Time-Series Data
For time-series, `obs` must be an array `[genes, experiments, timepoints]`.

```R
T_ <- 4 # time points
obs_ts <- array(rnorm(n*K*T_), c(n,K,T_))

res_ts <- doILP(obs_ts, delta, lambda=1, b, n, K, T_, 
                annot=getEdgeAnnot(n), delta_type, 
                flag_time_series=TRUE)
```

## Parameter Optimization (Cross-Validation)
To find the best $\lambda$, use Leave-One-Out (`loocv`) or K-fold (`kfoldCV`) cross-validation. This requires defining Gaussian parameters for active/inactive states.

```R
active_mu <- 1.1; inactive_mu <- 0.9
active_sd <- 0.01; inactive_sd <- 0.01

# Find range for lambda
lambdas <- calcRangeLambda(obs, delta, delta_type)

# Example LOOCV loop
best_mse <- Inf
for (l in lambdas) {
  cv <- loocv(kfold=NULL, times=5, obs, delta, lambda=l, b, n, K, 
              T_=NULL, annot=getEdgeAnnot(n), annot_node=1:n,
              active_mu, active_sd, inactive_mu, inactive_sd, 
              mu_type="single", delta_type)
  if (cv$MSE < best_mse) {
    best_mse <- cv$MSE
    best_edges <- cv$edges_all
  }
}

# Get final adjacency matrix from CV results
final_adja <- getSampleAdjaMAD(best_edges, n, 1:n)
```

## Integrating Prior Knowledge
You can constrain the LP solver using known biology.

### Source and Sink Nodes
```R
res <- doILP(obs, delta, lambda=1, b, n, K, T_=NULL, 
             annot=getEdgeAnnot(n), delta_type, 
             sourceNode=1, sinkNode=5)
```

### Individual Edge Constraints
Define specific weights or directions for edges.
```R
# Format: c("edge_annotation", objective_coefficient, "direction", rhs)
# Example: weight of activating edge from 1 to 2 must be > 1
prior <- list(c("w+_1_2", 1, ">", 1))

res <- doILP(obs, delta, lambda=1, b, n, K, T_=NULL, 
             annot=getEdgeAnnot(n), delta_type, 
             prior=prior)
```

## Tips
- **Edge Annotations**: Use `getEdgeAnnot(n)` to see how edges are named (e.g., `w+_1_2` for activation, `w-_1_2` for inhibition).
- **Sign Constraints**: If you only expect activating edges, set `all.pos=TRUE` in `doILP` and use `getEdgeAnnot(n, allpos=TRUE)`.
- **Real Data**: When working with RPPA or expression data, ensure replicates are summarized (e.g., using `summarizeRepl`) before computing $\delta$ or running the ILP.

## Reference documentation
- [lpNet](./references/vignette_lpNet.md)