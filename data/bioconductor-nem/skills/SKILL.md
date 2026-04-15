---
name: bioconductor-nem
description: This tool reconstructs signaling pathway hierarchies by analyzing the nested structure of downstream perturbation effects. Use when user asks to infer directed signaling networks from high-throughput phenotypic data, model dependencies between perturbed genes, or identify the logical structure of signaling pathways using nested effects models.
homepage: https://bioconductor.org/packages/3.5/bioc/html/nem.html
---

# bioconductor-nem

name: bioconductor-nem
description: Reconstruct signaling pathway hierarchies from the nested structure of perturbation effects. Use this skill when analyzing high-throughput phenotypic data (e.g., gene expression, protein levels) from systematic perturbation experiments (e.g., RNAi, CRISPR, knockouts) to infer the directed graph of signaling genes (S-genes) based on their downstream effect genes (E-genes).

## Overview

The `nem` (Nested Effects Models) package is designed to infer the logical structure of a signaling network by observing how perturbations of "Signaling genes" (S-genes) affect "Effect genes" (E-genes). The core principle is that if the effects of perturbing S-gene A are a subset of the effects of perturbing S-gene B, then A is likely downstream of B.

The package supports various inference algorithms, including exhaustive search (for small networks), greedy hill-climbing, and triplet-based approaches. It can handle both discrete and continuous data, typically using log-odds (B-scores) as input.

## Typical Workflow

1. **Prepare Input Data**: Create a data matrix where rows are E-genes and columns are S-gene perturbations. Values should ideally be log-odds ratios (B-scores) representing the probability of a gene being differentially expressed.
2. **Define S-genes**: Identify which columns correspond to which perturbed signaling components.
3. **Set Parameters**: Use `set.default.parameters` to configure the inference type (e.g., "greedy", "exhaustive", "pairwise") and the null model.
4. **Run Inference**: Execute the `nem` function to find the highest-scoring network topology.
5. **Visualize**: Use `plot.nem` to view the inferred hierarchy and the attachment of E-genes to S-genes.

## Key Functions

### Inference and Model Selection

- `nem(D, inference="greedy", ...)`: The primary interface for model induction.
- `nem.model.select(D, ...)`: Used for estimating the optimal number of S-genes or comparing different model priors.
- `set.default.parameters(Sgenes, ...)`: Initialize a parameter list for the inference process. Key parameters include `type` ("mcmc", "greedy", "exhaustive", "pairwise") and `prob` (prior probabilities).

### Data Processing

- `nem.discretize(D, ...)`: Convert continuous expression data into discrete states (0, 1) if required by the specific model type.
- `getBScore(D, ...)`: Calculate B-scores (log-odds) from expression data, which is the preferred input for probabilistic NEM.

### Visualization and Analysis

- `plot.nem(res)`: Generate a directed acyclic graph (DAG) of the inferred S-gene hierarchy.
- `nem.bootstrap(D, ...)`: Perform bootstrap analysis to assess the stability of the inferred edges.
- `transitive.reduction(graph)`: Remove redundant edges from the inferred graph to simplify the signaling path.

## Usage Tips

- **S-genes vs. E-genes**: Ensure a clear distinction. S-genes are the components you perturbed; E-genes are the reporters (e.g., all genes on a microarray).
- **Input Scaling**: If using p-values, convert them to log-odds. NEM performs best when the input represents the evidence for an effect.
- **Search Space**: For more than 7-8 S-genes, avoid `inference="exhaustive"`. Use "greedy" or "module" instead to manage computational complexity.
- **Transitive Closure**: By default, NEM models represent the transitive closure. Use `transitive.reduction` for a more "biological" view of the pathway.

## Reference documentation

- [Probabilistic Models for Gene Silencing Data](./references/markowetz-thesis-2006.md)
- [nem: Nested Effects Models](./references/nem.md)