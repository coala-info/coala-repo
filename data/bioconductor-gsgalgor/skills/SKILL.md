---
name: bioconductor-gsgalgor
description: GSgalgoR implements a multi-objective genetic algorithm to identify molecular subtypes by balancing cluster consistency and clinical survival differences. Use when user asks to discover cancer subtypes, optimize gene signatures using NSGA-II, or identify a Pareto front of solutions based on Silhouette Coefficient and Restricted Mean Survival Time.
homepage: https://bioconductor.org/packages/release/bioc/html/GSgalgoR.html
---

# bioconductor-gsgalgor

## Overview

GSgalgoR implements an elitist non-dominated sorting genetic algorithm (NSGA-II) to discover biologically and clinically relevant molecular subtypes. It treats cancer subtype discovery as a bi-objective problem, optimizing for both cluster consistency (Silhouette Coefficient) and survival differences (Restricted Mean Survival Time - RMST). This approach identifies a Pareto front of optimal solutions, allowing researchers to choose signatures that balance statistical robustness with clinical predictive power.

## Core Workflow

### 1. Data Preparation
GSgalgoR requires a scaled expression matrix and a survival object.

```r
library(GSgalgoR)
library(survival)

# 1. Scale expression data (features as rows, samples as columns)
# Robust linear scaling is recommended
expression_matrix <- t(apply(raw_expr, 1, genefu::rescale, na.rm = TRUE, q = 0.05))

# 2. Create Survival Object
surv_obj <- Surv(time = clinical_data$time, event = clinical_data$event)
```

### 2. Running the Genetic Algorithm
The `galgo()` function is the primary entry point.

```r
output <- galgo(
  generations = 150,      # Recommended > 150
  population = 100,       # Recommended > 100
  prob_matrix = expression_matrix,
  OS = surv_obj,
  nCV = 5,                # Cross-validation folds
  distancetype = "pearson", # 'pearson', 'spearman', or 'euclidean'
  period = 3650           # Outcome period for RMST evaluation
)
```

### 3. Analyzing Results
The output is a `galgo.Obj`. Convert it to standard R formats for inspection.

```r
# Convert to list or dataframe
results_list <- to_list(output)
results_df <- to_dataframe(output)

# Visualize the Pareto Front (SC Fitness vs Survival Fitness)
plot_pareto(output)

# Summarize non-dominated solutions (Rank 1)
summary_results <- non_dominated_summary(
  output = output,
  OS = surv_obj,
  prob_matrix = expression_matrix,
  distancetype = "pearson"
)
```

### 4. Classification and Validation
Once a signature (solution) is selected, use it to classify new samples.

```r
# 1. Create centroids for selected solutions
best_sol <- "Solution.1" # Example name from results
centroids <- create_centroids(output, solution_names = best_sol, trainset = expression_matrix)

# 2. Classify new data
new_classes <- classify_multiple(
  prob_matrix = test_expression_matrix,
  centroid_list = centroids,
  distancetype = "pearson"
)
```

## Advanced Usage: Callbacks

GSgalgoR supports a callback mechanism to hook into the execution process (e.g., for custom reporting or saving intermediate results).

Available hooks:
- `start_galgo_callback`: Before execution starts.
- `end_galgo_callback`: Before execution finishes.
- `start_gen_callback`: Start of each generation.
- `end_gen_callback`: End of each generation.
- `report_callback`: After mating pool creation.

```r
# Custom callback definition
my_callback <- function(userdir, generation, pop_pool, pareto, prob_matrix, current_time) {
  message(paste("Processing generation:", generation))
}

# Run with callback
output <- galgo(..., report_callback = my_callback)
```

## Tips for Success
- **Scaling**: Features MUST be scaled across the dataset before running `galgo()`.
- **Computational Cost**: Genetic algorithms are intensive. For large datasets, consider initial feature filtering or using a high-performance computing environment.
- **Solution Selection**: Use `non_dominated_summary()` to evaluate C-Index across the Pareto front to find the best balance for your specific biological question.

## Reference documentation
- [GSgalgoR User Guide](./references/GSgalgoR.md)
- [GSgalgoR Callbacks Mechanism](./references/GSgalgoR_callbacks.md)