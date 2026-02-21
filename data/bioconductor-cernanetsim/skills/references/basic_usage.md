# Basic Use of ceRNAnetsim

#### Selcen Ari

#### 2025-10-29

* [1. Introduction](#introduction)
* [2. Installation](#installation)
* [3. About the data](#about-the-data)
* [4. Simulation via expression values of miRNAs and genes in `minsamp` dataset](#simulation-via-expression-values-of-mirnas-and-genes-in-minsamp-dataset)
  + [4.1. Handle basic dataset](#handle-basic-dataset)
  + [4.2. Trigger a change](#trigger-a-change)
  + [4.3. Simulate the changes in graph](#simulate-the-changes-in-graph)
  + [4.4. A special case: knockdown](#a-special-case-knockdown)
* [5. Simulation via interaction factors in addition to expression values of miRNAs and genes in `minsamp` dataset](#simulation-via-interaction-factors-in-addition-to-expression-values-of-mirnas-and-genes-in-minsamp-dataset)
  + [5.1. Change expression level of one or more nodes in the graph](#change-expression-level-of-one-or-more-nodes-in-the-graph)
  + [5.2. Update the node variables with edge variables.](#update-the-node-variables-with-edge-variables.)
  + [5.3. Simulate the model](#simulate-the-model)
  + [5.4. Visualisation of the graph](#visualisation-of-the-graph)
* [6. Session Info](#session-info)

# 1. Introduction

This vignette demonstrates how to analyse miRNA:Competing interactions via `ceRNAnetsim` package. The perturbations in the miRNA:target interactions are handled step by step in `ceRNAnetsim`. The package calculates and simulates regulation of miRNA:competing RNA interactions based on amounts of miRNA and the targets and interaction factors.

The `ceRNAnetsim` works by executing following steps:

* The input dataset is prepared for analysis. The first variable is arranged as competing and the second as miRNA.
* The dataset is primed with `priming_graph()` function so that it’s converted into a graph. This function makes calculations that are depended on miRNA amount, target (competing) amount and the interaction factors. It determines the efficiency of miRNA to each target and saves that values as edge data. All calculations are performed in edge data. After that, results of calculations are used in node data.
* Now, the change in expression level of either miRNA or competing RNA can be introduced with `update_variables()` or `update_how()` functions.
* The calculated values in edge are carried to node data through a helper function `update_nodes()`.
* The change is perceived as a trigger and network-wise calculations are performed.
* The trigger is used for simulation of regulations in `simulate()` or `simulate_vis()`.
* These processes can generate various outputs such as graphs or graph objects.

The workflow of `ceRNAnetsim` are shown as following:

![](data:image/png;base64...)

```
library(ceRNAnetsim)
```

# 2. Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ceRNAnetsim")
```

# 3. About the data

Below is the minimal data that can be used with ceRNAnetsim.

```
data("minsamp")
minsamp %>%
  select(1:4)
#>   competing miRNA Competing_expression miRNA_expression
#> 1     Gene1  Mir1                10000             1000
#> 2     Gene2  Mir1                10000             1000
#> 3     Gene3  Mir1                 5000             1000
#> 4     Gene4  Mir1                10000             1000
#> 5     Gene4  Mir2                10000             2000
#> 6     Gene5  Mir2                 5000             2000
#> 7     Gene6  Mir2                10000             2000
```

The table is actually constructed by merging three different tables:

* gene expression data
* miRNA expression data
* miRNA:gene pairs (might **optionally** contain data about the interaction)

So, the `basic_data` table is constructed by merging following tables:

```
data("minsamp")
minsamp %>%
  select(competing, Competing_expression) %>%
  distinct() -> gene_expression
```

```
gene_expression
#>   competing Competing_expression
#> 1     Gene1                10000
#> 2     Gene2                10000
#> 3     Gene3                 5000
#> 4     Gene4                10000
#> 5     Gene5                 5000
#> 6     Gene6                10000
```

```
minsamp %>%
  select(miRNA, miRNA_expression) %>%
  distinct() -> mirna_expression
```

```
mirna_expression
#>   miRNA miRNA_expression
#> 1  Mir1             1000
#> 2  Mir2             2000
```

Third table should contain miRNA:gene interactions per row. The `ceRNAnetsim` will assume first column contains competing RNA names and second column to be miRNA names. If the order is different the user should indicate column names accordingly.

```
minsamp %>%
  select(competing, miRNA) -> interaction_simple
```

```
interaction_simple
#>   competing miRNA
#> 1     Gene1  Mir1
#> 2     Gene2  Mir1
#> 3     Gene3  Mir1
#> 4     Gene4  Mir1
#> 5     Gene4  Mir2
#> 6     Gene5  Mir2
#> 7     Gene6  Mir2
```

The three tables can be joined in R (as shown below) or elsewhere to have interaction and expression data altogether in expected format.

```
interaction_simple %>%
  inner_join(gene_expression, by = "competing") %>%
  inner_join(mirna_expression, "miRNA") -> basic_data

basic_data
#>   competing miRNA Competing_expression miRNA_expression
#> 1     Gene1  Mir1                10000             1000
#> 2     Gene2  Mir1                10000             1000
#> 3     Gene3  Mir1                 5000             1000
#> 4     Gene4  Mir1                10000             1000
#> 5     Gene4  Mir2                10000             2000
#> 6     Gene5  Mir2                 5000             2000
#> 7     Gene6  Mir2                10000             2000
```

# 4. Simulation via expression values of miRNAs and genes in `minsamp` dataset

ceRNAnetsim processes your dataset as graph object and simulates competing behaviours of targets when steady-state is perturbed via expression level changes in one or more genes. Let’s go over three steps:

## 4.1. Handle basic dataset

In first step, the expression and interaction table is converted into graph/network. `tidygraph` is used importing the data thus both node and edge data are accessible as tables if needed. `priming_graph` generates many columns in edge/node table which are mostly for internal use.

```
#Convertion of dataset to graph.

priming_graph(basic_data, competing_count = Competing_expression, miRNA_count =miRNA_expression)
#> Warning in priming_graph(basic_data, competing_count = Competing_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10000         10000 Competing
#> 2 Gene2 Competing       2         10000     10000         10000 Competing
#> 3 Gene3 Competing       3          5000      5000          5000 Competing
#> 4 Gene4 Competing       4         10000     10000         10000 Competing
#> 5 Gene5 Competing       5          5000      5000          5000 Competing
#> 6 Gene6 Competing       6         10000     10000         10000 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 19
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 13 more variables: dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>,
#> #   comp_count_list <list>, comp_count_pre <dbl>, comp_count_current <dbl>,
#> #   mirna_count_list <list>, mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>
```

## 4.2. Trigger a change

`update_how` function can be used to simulate a change in the network. (If multiple chnages are aimed to be used as trigger, `update_variables()` function should be used).

In the example below, expression level of “Gene2” is increased to two-fold.

```
priming_graph(basic_data, competing_count = Competing_expression,
              miRNA_count =miRNA_expression) %>%
  update_how(node_name = "Gene2", how=2)
#> Warning in priming_graph(basic_data, competing_count = Competing_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10000         10000 Competing
#> 2 Gene2 Competing       2         10000     10000         20000 Up
#> 3 Gene3 Competing       3          5000      5000          5000 Competing
#> 4 Gene4 Competing       4         10000     10000         10000 Competing
#> 5 Gene5 Competing       5          5000      5000          5000 Competing
#> 6 Gene6 Competing       6         10000     10000         10000 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 19
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 13 more variables: dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>,
#> #   comp_count_list <list>, comp_count_pre <dbl>, comp_count_current <dbl>,
#> #   mirna_count_list <list>, mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>
```

You can see the current count of Gene2 node is 20000 and its change is denoted as “Up” in `changes_variable` column in node table data.

## 4.3. Simulate the changes in graph

Finally, with the help of `simulate` function, the effect of expression change (*i.e.* the trigger) on overall network. The example code advances only for 5 cycles.

```
priming_graph(basic_data, competing_count = Competing_expression,
              miRNA_count =miRNA_expression) %>%
  update_how(node_name = "Gene2", how=2) %>%
  simulate(cycle = 5)
#> Warning in priming_graph(basic_data, competing_count = Competing_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10062         10062 Competing
#> 2 Gene2 Competing       2         10000     19845         19845 Competing
#> 3 Gene3 Competing       3          5000      5031          5031 Competing
#> 4 Gene4 Competing       4         10000     10059         10059 Competing
#> 5 Gene5 Competing       5          5000      5001          5001 Competing
#> 6 Gene6 Competing       6         10000     10001         10001 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 20
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 14 more variables: dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>,
#> #   comp_count_list <list>, comp_count_pre <dbl>, comp_count_current <dbl>,
#> #   mirna_count_list <list>, mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>, mirna_count_per_comp <dbl>
```

`count_current` column indicate results after 5 cycle of calculations for each node. You can see the gene expression changes after this perturbation and simulation. This table can be obtained easily at following:

```
priming_graph(basic_data, competing_count = Competing_expression,
              miRNA_count =miRNA_expression) %>%
  update_how(node_name = "Gene2", how=2) %>%
  simulate(cycle = 5)%>%
  as_tibble()%>%
  select(name, initial_count, count_current)
#> Warning in priming_graph(basic_data, competing_count = Competing_expression, : First column is processed as competing and the second as miRNA.
#> # A tibble: 8 × 3
#>   name  initial_count count_current
#>   <chr>         <dbl>         <dbl>
#> 1 Gene1         10000         10062
#> 2 Gene2         10000         19845
#> 3 Gene3          5000          5031
#> 4 Gene4         10000         10059
#> 5 Gene5          5000          5001
#> 6 Gene6         10000         10001
#> 7 Mir1           1000          1000
#> 8 Mir2           2000          2000
```

## 4.4. A special case: knockdown

ceRNAnetsim also provides the simulation of gene knockdown in the network. In normal conditions, when a gene is up or down regulated, it is considered that amounts of gene transcripts change depended on interactions. But, the transcripts of the gene are not observed in the system when it is knocked down. To achieve this case, you just need to define `how` argument to 0 (zero) in `update_how` function.

```
priming_graph(basic_data, competing_count = Competing_expression,
              miRNA_count =miRNA_expression) %>%
  update_how(node_name = "Gene2", how=0) %>%
  simulate(cycle = 5)
#> Warning in priming_graph(basic_data, competing_count = Competing_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000      9886          9886 Competing
#> 2 Gene2 Competing       2         10000         0             0 Competing
#> 3 Gene3 Competing       3          5000      4943          4943 Competing
#> 4 Gene4 Competing       4         10000      9891          9891 Competing
#> 5 Gene5 Competing       5          5000      4999          4999 Competing
#> 6 Gene6 Competing       6         10000      9998          9998 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 20
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 14 more variables: dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>,
#> #   comp_count_list <list>, comp_count_pre <dbl>, comp_count_current <dbl>,
#> #   mirna_count_list <list>, mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>, mirna_count_per_comp <dbl>
```

So, if Gene2 is knocked down, there will be more miRNA (Mir1 to be exact) available for Gene1, Gene3 and Gene4, thus lowering their transcript levels. Since Gene4 is has lower expression level, we can observe minute changes in Gene5 and Gene6 levels due to more miRNA (Mir2) being available for them. These changes can be observed in `current_count` column.

Briefly, ceRNAnetsim utilizes the change(s) as trigger and calculates regulation of targets according to miRNA:target and target:total target ratios.

# 5. Simulation via interaction factors in addition to expression values of miRNAs and genes in `minsamp` dataset

Minimal sample `minsamp` is processed with `priming_graph()` function in first step. This provides conversion of dataset from data frame to graph object. This step comprises of:

* The competing elements (Genes in *minsamp*) are grouped according to the miRNAs they are associated with.
* In graph object, the **optional** interaction factors are processed and graded within the groups.
* The amounts (expressions) of miRNAs are distributed according to competing:total competing ratio.
* miRNA efficiency in steady-state is calculated by taking into account of expression distribution and effecting factors. The **optional** factors might have two types of effect; 1) affinity, 2) degradation effect. Any column which has effect on affinity should be provided as a vector to `aff_factor` argument and any column that effects degradation of target RNA should be as a vector to `deg_factor` argument.

```
minsamp
#>   competing miRNA Competing_expression miRNA_expression seed_type region energy
#> 1     Gene1  Mir1                10000             1000      0.43   0.30    -20
#> 2     Gene2  Mir1                10000             1000      0.43   0.01    -15
#> 3     Gene3  Mir1                 5000             1000      0.32   0.40    -14
#> 4     Gene4  Mir1                10000             1000      0.23   0.50    -10
#> 5     Gene4  Mir2                10000             2000      0.35   0.90    -12
#> 6     Gene5  Mir2                 5000             2000      0.05   0.40    -11
#> 7     Gene6  Mir2                10000             2000      0.01   0.80    -25
```

```
priming_graph(minsamp,
              competing_count = Competing_expression,
              miRNA_count = miRNA_expression,
              aff_factor = c(energy, seed_type),
              deg_factor = region)
#> Warning in priming_graph(minsamp, competing_count = Competing_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10000         10000 Competing
#> 2 Gene2 Competing       2         10000     10000         10000 Competing
#> 3 Gene3 Competing       3          5000      5000          5000 Competing
#> 4 Gene4 Competing       4         10000     10000         10000 Competing
#> 5 Gene5 Competing       5          5000      5000          5000 Competing
#> 6 Gene6 Competing       6         10000     10000         10000 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 22
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 16 more variables: energy <dbl>, seed_type <dbl>, region <dbl>,
#> #   dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>, comp_count_list <list>,
#> #   comp_count_pre <dbl>, comp_count_current <dbl>, mirna_count_list <list>,
#> #   mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>
```

In the processed data, the values are carried as node variables and many more columns are initialized which are to be used in subsequent steps.

## 5.1. Change expression level of one or more nodes in the graph

In the steady-state, the miRNA degradation effect on gene expression is assumed to be stable (*i.e.* in equilibrium). But, if one or more nodes have altered expression level, the system tends to reach steady-state again.

The `ceRNAnetsim` package utilizes two methods to simulate change in expression level, `update_how()` and `update_variables()` functions provide unstable state from which calculations are triggered to reach steady-state.

* Method 1: change expression level of single node

If updating expression level of single node is desired then `update_how()` function should be used. In the example below, expression level of Gene4 is increased 2-fold.

```
minsamp %>%
   priming_graph(competing_count = Competing_expression,
                 miRNA_count = miRNA_expression,
                 aff_factor = c(energy, seed_type),
                 deg_factor = region) %>%
   update_how(node_name = "Gene4", how = 2) %>%
   activate(edges)%>%
   # following line is just for focusing on necessary
   # columns to see the change in edge data
   select(3:4,comp_count_pre,comp_count_current)
#> Warning in priming_graph(., competing_count = Competing_expression, miRNA_count = miRNA_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Edge Data: 7 × 6 (active)
#>    from    to Competing_name miRNA_name comp_count_pre comp_count_current
#>   <int> <int> <chr>          <chr>               <dbl>              <dbl>
#> 1     1     7 Gene1          Mir1                10000              10000
#> 2     2     7 Gene2          Mir1                10000              10000
#> 3     3     7 Gene3          Mir1                 5000               5000
#> 4     4     7 Gene4          Mir1                10000              20000
#> 5     4     8 Gene4          Mir2                10000              20000
#> 6     5     8 Gene5          Mir2                 5000               5000
#> 7     6     8 Gene6          Mir2                10000              10000
#> #
#> # Node Data: 8 × 7
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10000         10000 Competing
#> 2 Gene2 Competing       2         10000     10000         10000 Competing
#> 3 Gene3 Competing       3          5000      5000          5000 Competing
#> # ℹ 5 more rows
```

* Method 2: update expression level of all nodes

The `update_variables()` function uses an external dataset which has number of rows equal to number of nodes in graph. The external dataset might include changed and unchanged expression values for each node.

Load the `new_count` dataset (provided with package sample data) in which expression level of Gene2 is increased 2 fold (from 10,000 to 20,000). Note that variables of the dataset included updated variables must be named as “Competing”, “miRNA”, “miRNA\_count” and “Competing\_count”.

```
data(new_counts)
new_counts
#>   Competing miRNA Competing_count miRNA_count
#> 1     Gene1  Mir1           10000        1000
#> 2     Gene2  Mir1           20000        1000
#> 3     Gene3  Mir1            5000        1000
#> 4     Gene4  Mir1           10000        1000
#> 5     Gene4  Mir2           10000        2000
#> 6     Gene5  Mir2            5000        2000
#> 7     Gene6  Mir2           10000        2000
```

`update_variables()` function replaces the existing expression values with new values. The function checks for updates in all rows after importing expression values, thus it’s possible to introduce multiple changes at once.

```
minsamp %>%
   priming_graph(competing_count = Competing_expression,
                 miRNA_count = miRNA_expression,
                 aff_factor = c(energy, seed_type),
                 deg_factor = region) %>%
   update_variables(current_counts = new_counts)
#> Warning in priming_graph(., competing_count = Competing_expression, miRNA_count = miRNA_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10000         10000 Competing
#> 2 Gene2 Competing       2         10000     10000         20000 Up
#> 3 Gene3 Competing       3          5000      5000          5000 Competing
#> 4 Gene4 Competing       4         10000     10000         10000 Competing
#> 5 Gene5 Competing       5          5000      5000          5000 Competing
#> 6 Gene6 Competing       6         10000     10000         10000 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 22
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 16 more variables: energy <dbl>, seed_type <dbl>, region <dbl>,
#> #   dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>, comp_count_list <list>,
#> #   comp_count_pre <dbl>, comp_count_current <dbl>, mirna_count_list <list>,
#> #   mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>
```

## 5.2. Update the node variables with edge variables.

The functions `update_variables()` and `update_how()` updates edge data. In these functions, `update_nodes()` function is applied in order to reflect changes in edge data over to node data. In other words, if there’s a change in edge data, nodes can be updated accordingly with `update_nodes()` function.

```
minsamp %>%
  priming_graph(competing_count = Competing_expression,
                miRNA_count = miRNA_expression,
                aff_factor = c(energy, seed_type),
                deg_factor = region) %>%
  update_how("Gene4", how = 2)
#> Warning in priming_graph(., competing_count = Competing_expression, miRNA_count = miRNA_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10000         10000 Competing
#> 2 Gene2 Competing       2         10000     10000         10000 Competing
#> 3 Gene3 Competing       3          5000      5000          5000 Competing
#> 4 Gene4 Competing       4         10000     10000         20000 Up
#> 5 Gene5 Competing       5          5000      5000          5000 Competing
#> 6 Gene6 Competing       6         10000     10000         10000 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 22
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 16 more variables: energy <dbl>, seed_type <dbl>, region <dbl>,
#> #   dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>, comp_count_list <list>,
#> #   comp_count_pre <dbl>, comp_count_current <dbl>, mirna_count_list <list>,
#> #   mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>

# OR
# minsamp %>%
#   priming_graph(competing_count = Competing_expression,
#                 miRNA_count = miRNA_expression,
#                 aff_factor = c(energy, seed_type),
#                 deg_factor = region) %>%
#   update_variables(current_counts = new_counts)
```

![](data:image/png;base64...)

## 5.3. Simulate the model

Change in expression level of one or more nodes will trigger a perturbation in the system which will effect neighboring miRNA:target interactions. The effect will propagate and iterate over until it reaches steady-state.

With `simulate()` function the changes in the system, are calculated iteratively. For example, in the example below, simulation will proceed ten cycles only. In simulation of the regulation, the important argument is `threshold` which provides to specify absolute minimum amount of change required to be considered changed element as up or down.

```
minsamp %>%
  priming_graph(competing_count = Competing_expression,
                miRNA_count = miRNA_expression,
                aff_factor = c(energy, seed_type),
                deg_factor = region) %>%
  update_how("Gene4", how = 2) %>%
  simulate(cycle=10) #threshold with default 0.
#> Warning in priming_graph(., competing_count = Competing_expression, miRNA_count = miRNA_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000     10027         10027 Competing
#> 2 Gene2 Competing       2         10000     10000         10000 Competing
#> 3 Gene3 Competing       3          5000      5005          5005 Competing
#> 4 Gene4 Competing       4         10000     19806         19806 Competing
#> 5 Gene5 Competing       5          5000      5024          5024 Competing
#> 6 Gene6 Competing       6         10000     10044         10044 Competing
#> 7 Mir1  miRNA           7          1000      1000          1000 miRNA
#> 8 Mir2  miRNA           8          2000      2000          2000 miRNA
#> #
#> # Edge Data: 7 × 23
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 17 more variables: energy <dbl>, seed_type <dbl>, region <dbl>,
#> #   dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>, comp_count_list <list>,
#> #   comp_count_pre <dbl>, comp_count_current <dbl>, mirna_count_list <list>,
#> #   mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>, mirna_count_per_comp <dbl>
```

`simulate()` saves the expression level of previous iterations in list columns in edge data. The changes in expression level throughout the simulate cycles are accessible with standard `dplyr` functions. For example:

```
minsamp %>%
   priming_graph(competing_count = Competing_expression,
                 miRNA_count = miRNA_expression,
                 aff_factor = c(energy, seed_type),
                 deg_factor = region) %>%
   update_how("Gene4", how = 2) %>%
   simulate(cycle=10) %>%
   activate(edges) %>%       #from tidygraph package
   select(comp_count_list, mirna_count_list) %>%
   as_tibble()
#> Warning in priming_graph(., competing_count = Competing_expression, miRNA_count = miRNA_expression, : First column is processed as competing and the second as miRNA.
#> # A tibble: 7 × 4
#>    from    to comp_count_list mirna_count_list
#>   <int> <int> <list>          <list>
#> 1     1     7 <dbl [11]>      <dbl [11]>
#> 2     2     7 <dbl [11]>      <dbl [11]>
#> 3     3     7 <dbl [11]>      <dbl [11]>
#> 4     4     7 <dbl [11]>      <dbl [11]>
#> 5     4     8 <dbl [11]>      <dbl [11]>
#> 6     5     8 <dbl [11]>      <dbl [11]>
#> 7     6     8 <dbl [11]>      <dbl [11]>
```

Here, `comp_count_list` and `mirna_count_list` are list-columns which track changes in both competing RNA and miRNA levels. In the sample above, “Gene4” has initial expression level of 10000 (after trigger, it’s initial expression is 20000) and reached level of 19806 at 9th cycle (count\_pre) and also stayed at 19806 in last cycle (count\_current). The full history of expression level for Gene4 is as follows:

```
#>  [1] 10000 19803 19806 19806 19806 19806 19806 19806 19806 19806 19806
```

Actually, Gene4 seems like reached steady-state in iteration 4. But, this approach is sensitive to even small decimal numbers. So, threshold argument could be used to ignore very small decimal numbers. With a threshold value the system can reach steady-state early, like following.

```
minsamp %>%
  priming_graph(competing_count = Competing_expression,
                miRNA_count = miRNA_expression,
                aff_factor = c(energy, seed_type),
                deg_factor = region) %>%
  update_how("Gene4", how = 2) %>%
  simulate(cycle=3, threshold = 1)
#> Warning in priming_graph(., competing_count = Competing_expression, miRNA_count = miRNA_expression, : First column is processed as competing and the second as miRNA.
#> # A tbl_graph: 8 nodes and 7 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 8 × 7 (active)
#>   name  type      node_id initial_count count_pre count_current changes_variable
#>   <chr> <chr>       <int>         <dbl>     <dbl>         <dbl> <chr>
#> 1 Gene1 Competing       1         10000    10027.         10027 Competing
#> 2 Gene2 Competing       2         10000    10000          10000 Competing
#> 3 Gene3 Competing       3          5000     5005           5005 Competing
#> 4 Gene4 Competing       4         10000    19806.         19806 Competing
#> 5 Gene5 Competing       5          5000     5024.          5024 Competing
#> 6 Gene6 Competing       6         10000    10044.         10044 Competing
#> 7 Mir1  miRNA           7          1000     1000           1000 miRNA
#> 8 Mir2  miRNA           8          2000     2000           2000 miRNA
#> #
#> # Edge Data: 7 × 23
#>    from    to Competing_name miRNA_name Competing_expression miRNA_expression
#>   <int> <int> <chr>          <chr>                     <dbl>            <dbl>
#> 1     1     7 Gene1          Mir1                      10000             1000
#> 2     2     7 Gene2          Mir1                      10000             1000
#> 3     3     7 Gene3          Mir1                       5000             1000
#> # ℹ 4 more rows
#> # ℹ 17 more variables: energy <dbl>, seed_type <dbl>, region <dbl>,
#> #   dummy <dbl>, afff_factor <dbl>, degg_factor <dbl>, comp_count_list <list>,
#> #   comp_count_pre <dbl>, comp_count_current <dbl>, mirna_count_list <list>,
#> #   mirna_count_pre <dbl>, mirna_count_current <dbl>,
#> #   mirna_count_per_dep <dbl>, effect_current <dbl>, effect_pre <dbl>,
#> #   effect_list <list>, mirna_count_per_comp <dbl>
```

## 5.4. Visualisation of the graph

The `vis_graph()` function is used for visualization of the graph object. The initial graph object (steady-state) is visualized as following:

```
minsamp %>%
   priming_graph(competing_count = Competing_expression,
                 miRNA_count = miRNA_expression,
                 aff_factor = c(energy, seed_type),
                 deg_factor = region) %>%
   vis_graph(title = "Minsamp initial Graph")
```

![](data:image/png;base64...)

Also, The graph can be visualized at any step of process, for example, after simulation of 3 cycles the graph will look like:

```
minsamp %>%
   priming_graph(competing_count = Competing_expression,
                 miRNA_count = miRNA_expression,
                 aff_factor = c(energy, seed_type),
                 deg_factor = region) %>%
   update_variables(current_counts = new_counts) %>%
   simulate(3) %>%
   vis_graph(title = "Minsamp Graph After 3 Iteration")
```

![](data:image/png;base64...)

On the other hand, the network of each step can be plotted individually by using `simulate_vis()` function. `simulate_vis()` processes the given network just like `simulate()` function does while saving image of each step.

```
minsamp %>%
   priming_graph(competing_count = Competing_expression,
                 miRNA_count = miRNA_expression,
                 aff_factor = c(energy, seed_type),
                 deg_factor = region) %>%
   update_variables(current_counts = new_counts) %>%
   simulate_vis(3, title = "Minsamp Graph After Each Iteration")
```

![](data:image/gif;base64...)

Minsamp with 3 iteration

Note: Animated gif above was generated by online service. Actually, workflow gives the frames which include condition of each iteration. Note that you must use a terminal or online service, if you want to generate the animated gif.

# 6. Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ceRNAnetsim_1.22.0 tidygraph_1.3.1    dplyr_1.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] viridis_0.6.5      utf8_1.2.6         sass_0.4.10        future_1.67.0
#>  [5] generics_0.1.4     tidyr_1.3.1        listenv_0.9.1      digest_0.6.37
#>  [9] magrittr_2.0.4     evaluate_1.0.5     grid_4.5.1         RColorBrewer_1.1-3
#> [13] fastmap_1.2.0      jsonlite_2.0.0     ggrepel_0.9.6      gridExtra_2.3
#> [17] purrr_1.1.0        viridisLite_0.4.2  scales_1.4.0       tweenr_2.0.3
#> [21] codetools_0.2-20   jquerylib_0.1.4    cli_3.6.5          graphlayouts_1.2.2
#> [25] rlang_1.1.6        polyclip_1.10-7    parallelly_1.45.1  withr_3.0.2
#> [29] cachem_1.1.0       yaml_2.3.10        tools_4.5.1        parallel_4.5.1
#> [33] memoise_2.0.1      ggplot2_4.0.0      globals_0.18.0     png_0.1-8
#> [37] vctrs_0.6.5        R6_2.6.1           lifecycle_1.0.4    MASS_7.3-65
#> [41] furrr_0.3.1        ggraph_2.2.2       pkgconfig_2.0.3    pillar_1.11.1
#> [45] bslib_0.9.0        gtable_0.3.6       Rcpp_1.1.0         glue_1.8.0
#> [49] ggforce_0.5.0      xfun_0.53          tibble_3.3.0       tidyselect_1.2.1
#> [53] knitr_1.50         dichromat_2.0-0.1  farver_2.1.2       htmltools_0.5.8.1
#> [57] igraph_2.2.1       labeling_0.4.3     rmarkdown_2.30     compiler_4.5.1
#> [61] S7_0.2.0
```

See the other vignettes for more information.