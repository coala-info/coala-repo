---
name: bioconductor-graphalignment
description: This tool aligns two networks by considering both node similarity and interaction topology using a Bayesian scoring scheme and iterative heuristic. Use when user asks to align protein-protein interaction networks, perform cross-species analysis of biological networks, or find optimal one-to-one mappings between nodes in two different graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/GraphAlignment.html
---

# bioconductor-graphalignment

name: bioconductor-graphalignment
description: Find alignments between two networks (graphs) based on link and node similarity. Use this skill when you need to perform cross-species analysis of biological networks, align protein-protein interaction (PPI) networks, or find functional relationships between nodes in two different graphs using an iterative heuristic based on the linear assignment problem.

# bioconductor-graphalignment

## Overview
The `GraphAlignment` package provides a framework for aligning two networks (represented as adjacency matrices) by considering both node similarity (e.g., sequence homology) and link similarity (interaction topology). It uses a Bayesian scoring scheme and an iterative algorithm with simulated annealing to find an optimal one-to-one mapping between nodes.

## Core Workflow

### 1. Data Preparation
Networks must be represented as adjacency matrices. Node similarities (e.g., BLAST scores) are stored in a similarity matrix $R$.
```r
library(GraphAlignment)
# A and B are adjacency matrices; R is the similarity matrix
# Generate dummy data for testing:
ex <- GenerateExample(dimA=20, dimB=20, filling=0.5, covariance=0.6, numOrths=10)
A <- ex$a
B <- ex$b
R <- ex$r
```

### 2. Initial Alignment
Create a starting point for the iterative algorithm. A common choice is using reciprocal best matches from the similarity matrix.
```r
# psize must be >= dimA and dimB to accommodate dummy nodes
p_init <- InitialAlignment(psize=40, r=R, mode="reciprocal")
```

### 3. Parameter Estimation
Define lookup tables (bins) for link weights and node similarities, then estimate scoring parameters based on the initial alignment.
```r
# Define bins (e.g., for binary data or specific weight ranges)
lookupLink <- c(-0.5, 0.5, 1.5) 
lookupNode <- c(-0.5, 0.5, 1.5)

# Compute log-likelihood parameters
linkParams <- ComputeLinkParameters(A, B, p_init, lookupLink)
nodeParams <- ComputeNodeParameters(dim(A)[1], dim(B)[1], R, p_init, lookupNode)
```

### 4. Network Alignment
Run the iterative alignment algorithm. Use `bStart` and `bEnd` to control simulated annealing (inverse temperature).
```r
al <- AlignNetworks(A=A, B=B, R=R, P=p_init,
                    linkScore=linkParams$ls,
                    selfLinkScore=linkParams$lsSelf,
                    nodeScore1=nodeParams$s1, 
                    nodeScore0=nodeParams$s0,
                    lookupLink=lookupLink, 
                    lookupNode=lookupNode,
                    bStart=0.1, bEnd=30,
                    maxNumSteps=50)
```

### 5. Analysis and Scoring
Extract the aligned pairs and calculate the final alignment score.
```r
# Get matrix of aligned node indices
pairs <- AlignedPairs(A, B, al)

# Calculate link (sl) and node (sn) scores
scores <- ComputeScores(A, B, R, al, 
                        linkParams$ls, linkParams$lsSelf, 
                        nodeParams$s1, nodeParams$s0, 
                        lookupLink, lookupNode, symmetric=TRUE)

# Analyze alignment quality
analysis <- AnalyzeAlignment(A, B, R, al, lookupNode, epsilon=0.5)
```

## Key Functions
- `AlignNetworks`: The main iterative solver.
- `ComputeM`: Calculates the score matrix $M$ for the linear assignment problem.
- `LinearAssignment`: Solves the underlying optimization problem (Jonker-Volgenant algorithm).
- `EncodeDirectedGraph`: Converts directed binary graphs into a symmetric representation for alignment.
- `GenerateExample`: Useful for creating synthetic networks with known correlations for benchmarking.

## Tips for Success
- **Permutation Vector**: The alignment `al` is a vector where `al[i]` is the node in B aligned to node `i` in A. If `al[i] > dim(B)`, node `i` is unaligned (mapped to a dummy node).
- **Dummy Nodes**: Always ensure `psize` in `InitialAlignment` is large enough (e.g., `dim(A) + dim(B)`). If the number of aligned nodes equals the minimum possible, increase `psize`.
- **Self-Consistency**: For better results, recalculate parameters using the output alignment and run `AlignNetworks` again until the alignment converges.
- **Directed Graphs**: Set `directed=TRUE` in `AlignNetworks` and use `EncodeDirectedGraph` if working with directed networks.

## Reference documentation
- [GraphAlignment](./references/GraphAlignment.md)