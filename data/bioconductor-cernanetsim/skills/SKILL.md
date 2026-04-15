---
name: bioconductor-cernanetsim
description: This tool simulates and analyzes miRNA-target interaction networks to model how expression changes propagate through competitive endogenous RNA systems. Use when user asks to model ceRNA network perturbations, calculate miRNA-target binding efficiencies, or simulate the ripple effect of RNA expression changes on a network.
homepage: https://bioconductor.org/packages/release/bioc/html/ceRNAnetsim.html
---

# bioconductor-cernanetsim

name: bioconductor-cernanetsim
description: Analysis and simulation of miRNA-target interaction networks (ceRNA networks). Use when Claude needs to model how changes in expression levels of specific RNAs (miRNAs, circRNAs, lincRNAs, etc.) propagate through a network, calculate perturbation efficiency, or visualize competitive endogenous RNA (ceRNA) behavior using the ceRNAnetsim R package.

# bioconductor-cernanetsim

## Overview
The `ceRNAnetsim` package simulates the regulation of miRNA-target interactions by distributing miRNA expression across available competing endogenous RNAs (ceRNAs). It models the "ripple effect" where a change in one node's expression level affects the entire network. The package represents these interactions as graph objects, allowing for the incorporation of interaction factors like seed type, binding energy, and binding location to modify miRNA effects.

## Core Workflow

### 1. Data Preparation
The input data must contain columns for competing RNAs, miRNAs, and their respective expression counts.

```r
library(ceRNAnetsim)
library(dplyr)

# Example using built-in minimal sample
data("minsamp")

# Basic structure: competing, miRNA, Competing_expression, miRNA_expression
# Optional factors: energy, seed_type, region
```

### 2. Initializing the Network
Convert the dataframe into a graph object using `priming_graph()`. This calculates the steady-state efficiency of miRNAs for each target.

```r
# Simple priming
g <- priming_graph(minsamp, 
                   competing_count = Competing_expression, 
                   miRNA_count = miRNA_expression)

# Priming with interaction factors (affinity and degradation)
g_factors <- priming_graph(minsamp, 
                           competing_count = Competing_expression, 
                           miRNA_count = miRNA_expression,
                           aff_factor = c(energy, seed_type), 
                           deg_factor = region)
```

### 3. Triggering Perturbations
Introduce changes to the system (upregulation, downregulation, or knockdown).

```r
# Method 1: Change a single node (e.g., 2-fold upregulation of Gene2)
g_triggered <- g %>% update_how(node_name = "Gene2", how = 2)

# Method 2: Knockdown (set how to 0)
g_knockdown <- g %>% update_how(node_name = "Gene2", how = 0)

# Method 3: Update multiple variables using a new count dataframe
# data(new_counts)
g_multi <- g %>% update_variables(current_counts = new_counts)
```

### 4. Simulation
Run the simulation to propagate the trigger through the network until a new steady-state is reached or for a fixed number of cycles.

```r
# Run for 10 cycles
g_sim <- g_triggered %>% simulate(cycle = 10, threshold = 0.1)

# Extract results as a tibble
results <- g_sim %>% 
  as_tibble() %>% 
  select(name, initial_count, count_current)
```

## Advanced Analysis

### Finding Optimal Iterations
Use `find_iteration()` to determine how many cycles are needed for the perturbation to propagate fully.

```r
# Calculate iteration with maximum node propagation
opt_iter <- g_triggered %>% 
  simulate(50) %>% 
  find_iteration(limit = 0.1)
```

### Perturbation Efficiency
Evaluate how much a specific node disturbs the rest of the network.

```r
# Efficiency of a specific node
perf <- g_factors %>% 
  calc_perturbation(node_name = "Gene17", how = 3, cycle = 30, limit = 0.1)

# Screen all nodes for their perturbation potential
all_perf <- g_factors %>% 
  find_node_perturbation(how = 3, cycle = 4, limit = 0.1)
```

### Visualization
Visualize the network state at any point.

```r
# Static plot
vis_graph(g_sim, title = "Network State")

# Step-by-step simulation visualization (generates frames)
g_triggered %>% simulate_vis(cycle = 5, title = "Propagation Steps")
```

## Tips
- **Thresholds**: Use the `threshold` argument in `simulate()` to ignore negligible decimal changes and reach steady-state faster.
- **Graph Manipulation**: Since the output is a `tbl_graph`, you can use `tidygraph` functions like `activate(nodes)` or `activate(edges)` followed by `dplyr` verbs to inspect internal variables like `comp_count_list`.
- **Column Order**: `priming_graph()` assumes the first column is competing and the second is miRNA unless specified.

## Reference documentation
- [The auxiliary commands which can help to the users](./references/auxiliary_commands.md)
- [Basic Use of ceRNAnetsim](./references/basic_usage.md)
- [Calculating Number of Iterations Required to Reach Steady-State](./references/convenient_iteration.md)
- [How does the system behave in mirtarbase dataset without interaction factors?](./references/mirtarbase_example.md)