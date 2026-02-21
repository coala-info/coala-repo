# Introduction

Dany Mukesha

#### 2025-10-29

#### Abstract

Genetic algorithms (GAs) are optimization techniques inspired by the process of natural selection and genetics. They operate by evolving a population of candidate solutions over successive generations, with each individual representing a potential solution to the optimization problem at hand. Through the application of genetic operators such as selection, crossover, and mutation, genetic algorithms iteratively improve the population, eventually converging towards optimal or near-optimal solutions.
In the field of genomics, where data sets are often large, complex, and high-dimensional, genetic algorithms offer a good approach for addressing optimization challenges such as feature selection, parameter tuning, and model optimization. By harnessing the power of evolutionary principles, genetic algorithms can effectively explore the solution space, identify informative features, and optimize model parameters, leading to improved accuracy and interpretability in genomic data analysis.
The BioGA package extends the capabilities of genetic algorithms to the realm of genomic data analysis, providing a suite of functions optimized for handling high throughput genomic data. Implemented in C++ for enhanced performance, BioGA offers efficient algorithms for tasks such as feature selection, classification, clustering, and more. By integrating seamlessly with the Bioconductor ecosystem, BioGA empowers researchers and analysts to leverage the power of genetic algorithms within their genomics workflows, facilitating the discovery of biological insights from large-scale genomic data sets.

# Contents

* [1 Getting Started](#getting-started)
  + [1.1 Installation](#installation)
  + [1.2 Overview](#overview)
  + [1.3 Example Scenario](#example-scenario)
  + [1.4 Initialization](#initialization)
  + [1.5 Genetic Algorithm Optimization](#genetic-algorithm-optimization)
  + [1.6 Fitness Calculation](#fitness-calculation)

# 1 Getting Started

## 1.1 Installation

To install this package, start R (version “4.4”) and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BioGA")
```

You can also install the package directly from GitHub
using the `devtools` package:

```
devtools::install_github("danymukesha/BioGA")
```

In this vignette, we illustrate the usage of BioGA for genetic algorithm
optimization in the context of high throughput genomic data analysis.
We showcase its interoperability with Bioconductor classes, demonstrating
how genetic algorithm optimization can be seamlessly integrated into
existing genomics pipelines for improved analysis and interpretation.

The BioGA package provides a set of functions for genetic algorithm
optimization tailored for analyzing high throughput genomic data.
This vignette demonstrates the usage of BioGA in the context of selecting
the best combination of genes for predicting a certain trait,
such as disease susceptibility.

## 1.2 Overview

Genomic data refers to the genetic information stored in an organism’s DNA.
It includes the sequence of nucleotides (adenine, thymine, cytosine,
and guanine) that make up the DNA molecules. Genomic data can provide valuable
insights into various biological processes, such as gene expression,
genetic variation, and evolutionary relationships.

Genomic data in this context could consist of gene expression profiles
measured across different individuals (e.g., patients).

* Each row in the genomic\_data matrix represents a gene, and each column
  represents a patient sample.
* The values in the matrix represent the expression levels of each gene in
  each patient sample.

Here’s an example of genomic data:

```
      Sample 1   Sample 2   Sample 3   Sample 4
Gene1    0.1        0.2        0.3        0.4
Gene2    1.2        1.3        1.4        1.5
Gene3    2.3        2.2        2.1        2.0
```

In this example, each row represents a gene (or genomic feature), and
each column represents a sample. The values in the matrix represent
some measurement of gene expression, such as mRNA levels or protein abundance,
in each sample.

For instance, the value 0.1 in Sample 1 for Gene1 indicates the expression
level of Gene1 in Sample 1. Similarly, the value 2.2 in Sample 2 for Gene3
indicates the expression level of Gene3 in Sample 2.

Genomic data can be used in various analyses, including genetic association
studies, gene expression analysis, and comparative genomics. In the context
of the `evaluate_fitness_cpp` function, genomic data is used to calculate
fitness scores for individuals in a population, typically in the context
of genetic algorithm optimization.

The population represents a set of candidate combinations of genes that
could be predictive of the trait.
Each individual in the population is represented by a binary vector indicating
the presence or absence of each gene.
For example, an individual in the population might be represented as
[1, 0, 1],
indicating the presence of Gene1 and Gene3 but the absence of Gene2.
The population undergoes genetic algorithm operations such as selection,
crossover, mutation, and replacement to evolve towards individuals with higher
predictive power for the trait.

## 1.3 Example Scenario

Consider an example scenario of using genetic algorithm optimization to select
the best combination of genes for predicting a certain trait, such as disease
susceptibility.

```
# Load necessary packages
library(BioGA)
library(SummarizedExperiment)
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians

# Define parameters
num_genes <- 1000
num_samples <- 10

# Define parameters for genetic algorithm
population_size <- 100
generations <- 20
mutation_rate <- 0.1

# Generate example genomic data using SummarizedExperiment
counts <- matrix(rpois(num_genes * num_samples, lambda = 10),
    nrow = num_genes
)
rownames(counts) <- paste0("Gene", 1:num_genes)
colnames(counts) <- paste0("Sample", 1:num_samples)

# Create SummarizedExperiment object
se <-
  SummarizedExperiment::SummarizedExperiment(assays = list(counts = counts))

# Convert SummarizedExperiment to matrix for compatibility with BioGA package
genomic_data <- assay(se)
```

In this example, `counts` is a matrix representing the counts
of gene expression levels across different samples. Each row corresponds
to a gene, and each column corresponds to a sample. We use the
`SummarizedExperiment` class to store this data, which is
common Bioconductor class for representing rectangular feature x sample data,
such as RNAseq count matrices or microarray data.

```
head(genomic_data)
#>       Sample1 Sample2 Sample3 Sample4 Sample5 Sample6 Sample7 Sample8 Sample9
#> Gene1       8      12      14      10       9       8       7      10       7
#> Gene2       7      10      16       6       7       3      11      11      20
#> Gene3       9       9       6      18       8      10      12       5      10
#> Gene4       7       9      14      12      12       8       8       9       5
#> Gene5      18       9      11       9      12       8       7       5      12
#> Gene6      12       9       8       8       8       6      11      10       6
#>       Sample10
#> Gene1       10
#> Gene2       10
#> Gene3       10
#> Gene4       15
#> Gene5        6
#> Gene6        8
```

## 1.4 Initialization

```
# Initialize population (select the number of canditate you wish `population`)
population <- BioGA::initialize_population_cpp(genomic_data,
    population_size = 5
)
```

The population represents a set of candidate combinations of genes that
could be predictive of the trait. Each individual in the population is
represented by a binary vector indicating the presence or absence of
each gene.
For example, an individual in the population might be represented
as [1, 0, 1], indicating the presence of Gene1 and Gene3 but the absence
of Gene2.
The population undergoes genetic algorithm operations such as selection,
crossover, mutation, and replacement to evolve towards individuals
with higher predictive power for the trait.

## 1.5 Genetic Algorithm Optimization

```
# Initialize fitness history
fitness_history <- list()

# Initialize time progress
start_time <- Sys.time()

# Run genetic algorithm optimization
generation <- 0
while (TRUE) {
    generation <- generation + 1

    # Evaluate fitness
    fitness <- BioGA::evaluate_fitness_cpp(genomic_data, population)
    fitness_history[[generation]] <- fitness

    # Check termination condition
    if (generation == generations) { # defined number of generations
        break
    }

    # Selection
    selected_parents <- BioGA::selection_cpp(population,
        fitness,
        num_parents = 2
    )

    # Crossover and Mutation
    offspring <- BioGA::crossover_cpp(selected_parents, offspring_size = 2)
    # (no mutation in this example)
    mutated_offspring <- BioGA::mutation_cpp(offspring, mutation_rate = 0)

    # Replacement
    population <- BioGA::replacement_cpp(population, mutated_offspring,
        num_to_replace = 1
    )

    # Calculate time progress
    elapsed_time <- difftime(Sys.time(), start_time, units = "secs")

    # Print time progress
    cat(
        "\rGeneration:", generation, "- Elapsed Time:",
        format(elapsed_time, units = "secs"), "     "
    )
}
#>
Generation: 1 - Elapsed Time: 0.01341867 secs
Generation: 2 - Elapsed Time: 0.01575756 secs
Generation: 3 - Elapsed Time: 0.01619434 secs
Generation: 4 - Elapsed Time: 0.01658249 secs
Generation: 5 - Elapsed Time: 0.01697135 secs
Generation: 6 - Elapsed Time: 0.01736164 secs
Generation: 7 - Elapsed Time: 0.01774335 secs
Generation: 8 - Elapsed Time: 0.01812744 secs
Generation: 9 - Elapsed Time: 0.01850915 secs
Generation: 10 - Elapsed Time: 0.01888776 secs
Generation: 11 - Elapsed Time: 0.0192647 secs
Generation: 12 - Elapsed Time: 0.01966524 secs
Generation: 13 - Elapsed Time: 0.02005219 secs
Generation: 14 - Elapsed Time: 0.02043033 secs
Generation: 15 - Elapsed Time: 0.02080059 secs
Generation: 16 - Elapsed Time: 0.02118731 secs
Generation: 17 - Elapsed Time: 0.02155805 secs
Generation: 18 - Elapsed Time: 0.02193213 secs
Generation: 19 - Elapsed Time: 0.02230167 secs
```

## 1.6 Fitness Calculation

The fitness calculation described in the provided code calculates a measure
of dissimilarity between the gene expression profiles of individuals
in the population and the genomic data. This measure of dissimilarity,
or “fitness”, quantifies how well the gene expression profile of an individual
matches the genomic data.

Mathematically, the fitness calculation can be represented as follows:

Let:

* \(g\_{ijk}\) be the gene expression level of gene \(j\)
  in individual \(i\) and sample \(k\) from the genomic data.
* \(p\_{ij}\) be the gene expression level of gene \(j\)
  in individual \(i\) from the population.
* \(N\) be the number of individuals in the population.
* \(G\) be the number of genes.
* \(S\) be the number of samples.

Then, the fitness \(F\_i\) for individual \(i\) in the population can be
calculated as the sum of squared differences between the gene expression
levels of individual \(i\) and the corresponding gene expression levels
in the genomic data, across all genes and samples:
\[
F\_i = \sum\_{j=1}^{G} \sum\_{k=1}^{S} (g\_{ijk} - p\_{ij})^2
\]

This fitness calculation aims to minimize the overall dissimilarity between
the gene expression profiles of individuals in the population and
the genomic data. Individuals with lower fitness scores are considered to have
gene expression profiles that are more similar to the genomic data and
are therefore more likely to be selected for further optimization
in the genetic algorithm.

```
# Plot fitness change over generations
BioGA::plot_fitness_history(fitness_history)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the BioGA package.
#>   Please report the issue at <https://github.com/danymukesha/BioGA/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

This showcases the integration of genetic algorithms with genomic
data analysis and highlights the potential of genetic algorithms
for feature selection in genomics.

Here’s how BioGA could work in the context of high throughput genomic data
analysis:

1. **Problem Definition**: BioGA starts with a clear definition of the
   problem to be solved. This could include tasks such as identifying genetic
   markers associated with a particular disease, optimizing gene expression
   patterns, or clustering genomic data to identify patterns or groupings.
2. **Representation**: Genomic data would need to be appropriately represented
   for use within the genetic algorithm framework. This might involve encoding
   the data in a suitable format, such as binary strings representing genes
   or chromosomes.
3. **Fitness Evaluation**: BioGA would define a fitness function that
   evaluates how well a particular solution performs with respect to the
   problem being addressed. In the context of genomic data analysis,
   this could involve measures such as classification accuracy, correlation
   with clinical outcomes, or fitness to a particular model.
4. **Initialization**: The algorithm would initialize a population of
   candidate solutions, typically randomly or using some heuristic method.
   Each solution in the population represents a potential solution
   to the problem at hand.
5. **Genetic Operations**: BioGA would apply genetic operators such as
   selection, crossover, and mutation to evolve the population over successive
   generations. Selection identifies individuals with higher fitness to serve
   as parents for the next generation. Crossover combines genetic material
   from two parent solutions to produce offspring. Mutation introduces
   random changes to the offspring to maintain genetic diversity.
6. **Termination Criteria**: The algorithm would continue iterating through
   generations until a termination criterion is met. This could be a maximum
   number of generations, reaching a satisfactory solution, or convergence
   of the population.
7. **Result Analysis**: Once the algorithm terminates, BioGA would analyze
   the final population to identify the best solution(s) found. This could
   involve further validation or interpretation of the results in the context
   of the original problem.

Other applications of BioGA in genomic data analysis could include genome-wide
association studies (GWAS), gene expression analysis, pathway analysis,
and predictive modeling for personalized medicine, among others.
By leveraging genetic algorithms, BioGA offers a powerful approach
to exploring complex genomic datasets and identifying meaningful patterns
and associations.

**Session Info**

```
sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  animation              2.8       2025-08-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biocViews              1.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BioGA                * 1.4.0     2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  graph                  1.88.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RBGL                   1.86.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  RUnit                  0.4.33.1  2025-06-17 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpXUnDUA/Rinst36fd23694d90e6
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```