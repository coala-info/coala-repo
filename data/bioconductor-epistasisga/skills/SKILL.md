---
name: bioconductor-epistasisga
description: This tool identifies multi-SNP disease associations and gene-by-environment interactions in nuclear families using the GADGETS genetic algorithm. Use when user asks to identify epistasis in case-parent triads or sibling pairs, detect higher-order gene-by-environment interactions, or run the GADGETS method for genetic association studies.
homepage: https://bioconductor.org/packages/release/bioc/html/epistasisGA.html
---

# bioconductor-epistasisga

name: bioconductor-epistasisga
description: Use the epistasisGA R package to identify multi-SNP disease associations (epistasis) and gene-by-environment (GxGxE) interactions in nuclear families (case-parent triads or sibling pairs) using the GADGETS genetic algorithm.

# bioconductor-epistasisga

## Overview
The `epistasisGA` package implements the GADGETS (Genetic Algorithm for Detecting Genetic Epistasis Transferring Salience) method. It is designed to identify collections of SNPs that jointly influence disease risk, even when individual SNPs have small marginal effects. It supports case-parent triads and affected/unaffected sibling pairs. The package also includes E-GADGETS for detecting higher-order gene-by-environment interactions.

## Core Workflow

### 1. Data Preparation
Input data must be matrices where rows are families and columns are SNPs (coded 0, 1, 2). Missing values should be -9.

```r
library(epistasisGA)
# For case-parent triads
data(case); data(dad); data(mom)
case <- as.matrix(case)
dad <- as.matrix(dad)
mom <- as.matrix(mom)

# Define Linkage Equilibrium (LD) blocks (e.g., 25 SNPs per block)
ld.block.vec <- rep(25, 4) 

# Pre-process
pp.list <- preprocess.genetic.data(case, 
                                   father.genetic.data = dad, 
                                   mother.genetic.data = mom, 
                                   ld.block.vec = ld.block.vec)
```

### 2. Running GADGETS
The algorithm searches for SNP-sets of a fixed size (`chromosome.size`). It is recommended to run for sizes 2–6.

```r
run.gadgets(pp.list, 
            n.chromosomes = 100,       # Population size per island
            chromosome.size = 3,       # Number of SNPs in a set
            results.dir = "results_3", 
            n.islands = 8,             # Parallel populations
            island.cluster.size = 4, 
            cluster.type = "interactive") # Use "slurm" or "multicore" for HPC
```

### 3. Summarizing Results
Combine results from different islands and annotate with rsIDs.

```r
data(snp.annotations)
results <- combine.islands("results_3", snp.annotations, pp.list)
head(results)
```

### 4. Gene-by-Environment (E-GADGETS)
To detect GxGxE interactions, include exposure data in the pre-processing step.

```r
# categorical.exposures or continuous.exposures
pp.list.gxe <- preprocess.genetic.data(case, dad, mom, 
                                       ld.block.vec = ld.block.vec,
                                       categorical.exposures = exposure_vec)

run.gadgets(pp.list.gxe, chromosome.size = 3, results.dir = "gxe_results")
```

## Statistical Inference and Visualization

### Permutation Testing
To assess global significance, use `permute.dataset` to create null distributions, re-run GADGETS on those datasets, and then use `global.test`.

```r
# After running GADGETS on observed and permuted data:
# results_list contains observed and permutation fitness scores
test_res <- global.test(results_list, n.top.scores = 10)
test_res$pval
```

### Epistasis Test (h-values)
Test a specific SNP-set for interaction effects conditional on marginal associations.
```r
top_snps <- as.vector(t(results[1, 1:3]))
epi_test <- epistasis.test(top_snps, pp.list)
epi_test$pval # Interpreted as an 'h-value'
```

### Visualization
Generate network plots where node size and edge thickness represent the strength of the interaction.

```r
# Compute scores for the network
graph_scores <- compute.graphical.scores(list(results), pp.list)

# Plot
network.plot(graph_scores, pp.list, node.size = 40)
```

## Key Tips
- **HPC Usage**: For real datasets (e.g., 10,000 SNPs), use `cluster.type = "slurm"` or similar. The package uses `batchtools` for job management.
- **X Chromosome**: Requires manual creation of "complement" genotypes. For males, the complement is the allele not transmitted by the mother.
- **LD Blocks**: The `ld.block.vec` is critical. If SNPs are in the same block, they are permuted together in the epistasis test, which may result in `NA` p-values if no cross-block interactions exist.

## Reference documentation
- [Detecting GxGxE interactions with case-parent triads using E-GADGETS](./references/E_GADGETS.md)
- [Use of the GADGETS method to identify multi-SNP effects in nuclear families](./references/GADGETS.md)
- [Including Maternal SNPs in GADGETS](./references/Including_Maternal_SNPs.md)