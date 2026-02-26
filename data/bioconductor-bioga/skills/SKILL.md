---
name: bioconductor-bioga
description: BioGA performs multi-objective genetic algorithm optimization on high-throughput genomic data to balance data fidelity and model sparsity. Use when user asks to perform feature selection, identify gene signatures, tune model parameters, or optimize genomic models using biologically informed operators.
homepage: https://bioconductor.org/packages/release/bioc/html/BioGA.html
---


# bioconductor-bioga

name: bioconductor-bioga
description: Expert guidance for using the BioGA Bioconductor package to perform multi-objective genetic algorithm (GA) optimization on high-throughput genomic data. Use this skill when you need to perform feature selection (gene signatures), parameter tuning, or model optimization where balancing predictive accuracy and model sparsity is required. It supports biologically informed operators, parallel processing via Rcpp/OpenMP, and integration with SummarizedExperiment objects.

## Overview

BioGA (Biologically Informed Genetic Algorithm) is a high-performance R package implemented in C++ designed for genomic data optimization. It utilizes a modified NSGA-II (Non-dominated Sorting Genetic Algorithm II) framework to solve multi-objective problems—specifically balancing **Expression Difference** (data fidelity) and **Sparsity** (minimizing the number of features). Unlike general GAs, BioGA can incorporate biological priors such as gene co-expression clusters or interaction networks to guide the evolutionary process, ensuring results are both statistically sound and biologically plausible.

## Core Workflow

### 1. Data Preparation
BioGA expects a genomic expression matrix where rows are genes and columns are samples. It integrates seamlessly with `SummarizedExperiment`.

```r
library(BioGA)
library(SummarizedExperiment)

# Extract matrix from SummarizedExperiment
genomic_data <- assay(se) 

# Optional: Pre-cluster genes to inform initialization
cor_matrix <- cor(t(genomic_data))
hc <- hclust(as.dist(1 - cor_matrix), method = "average")
clusters <- cutree(hc, k = 20)
```

### 2. Running the Optimization
The primary interface is `bioga_main_cpp`. This function handles the entire evolutionary cycle in a single call.

```r
result <- bioga_main_cpp(
    genomic_data = genomic_data,
    population_size = 30,
    num_generations = 50,
    crossover_rate = 0.9,
    eta_c = 20,            # Distribution index for SBX crossover
    mutation_rate = 0.05,
    num_parents = 20,
    num_offspring = 20,
    num_to_replace = 10,
    weights = c(1.0, 0.3), # w1: Expression Difference, w2: Sparsity
    seed = 2025,
    clusters = clusters    # Optional: cluster-based initialization
)
```

### 3. Interpreting Results
The output is a list containing the final population and their fitness scores.

*   **`result$population`**: A matrix where each row is an optimized individual (gene expression values).
*   **`result$fitness`**: A matrix of objective scores (Column 1: Expression Diff, Column 2: Sparsity).

```r
# Identify the best individual (lowest expression difference)
best_idx <- which.min(result$fitness[, 1])
best_individual <- result$population[best_idx, ]

# Extract selected gene signature (non-zero features)
selected_genes <- which(abs(best_individual) > 1e-6)
gene_names <- rownames(genomic_data)[selected_genes]
```

## Advanced Operators

BioGA allows for granular control over the GA steps if the main wrapper is not used:

*   **Initialization**: `initialize_population_cpp(data, size, seed, clusters)`
*   **Fitness**: `evaluate_fitness_cpp(data, population, weights)`
*   **Selection**: `selection_cpp(population, fitness, num_parents)`
*   **Crossover**: `crossover_cpp(parents, offspring_size, eta_c)`
*   **Mutation**: `mutation_cpp(population, rate, iteration, max_iterations, network)`
    *   *Tip*: Provide a `network` adjacency matrix to dampen mutations in highly connected hub genes.
*   **Replacement**: `replacement_cpp(old_pop, offspring, old_fit, off_fit, num_to_replace)`

## Best Practices

1.  **Weight Tuning**: The `weights` parameter is critical. A higher second weight (Sparsity) will result in fewer selected genes but potentially higher expression error.
2.  **Parallelism**: BioGA uses OpenMP. Ensure your environment allows multi-threading. Use `RcppParallel::setThreadOptions()` to manage CPU usage.
3.  **Convergence**: Always visualize the Pareto front (Expression Diff vs. Sparsity) to ensure the algorithm has converged and to select the best trade-off for your specific biological question.
4.  **Network Constraints**: When using `mutation_cpp`, providing a STRINGdb or KEGG-derived adjacency matrix helps maintain biological modules during the search.

## Reference documentation

- [Introduction to BioGA](./references/BioGA.Rmd)
- [The Foundation of BioGA: Mathematical Theory](./references/Foundation.Rmd)
- [BioGA Overview and Getting Started](./references/Introduction.md)
- [Usage Demonstration of BioGA](./references/UsageDemostration.Rmd)