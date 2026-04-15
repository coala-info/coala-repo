---
name: bioconductor-cancermutationanalysis
description: This tool performs statistical analysis of somatic mutations to distinguish driver genes from passenger mutations in cancer genomes. Use when user asks to calculate gene-level scores like CaMP or logLRT, estimate passenger probabilities via empirical Bayes FDR, or perform patient-oriented gene-set analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/CancerMutationAnalysis.html
---

# bioconductor-cancermutationanalysis

name: bioconductor-cancermutationanalysis
description: Statistical analysis of somatic mutations in cancer genomes using the CancerMutationAnalysis R package. Use this skill to calculate gene-level scores (CaMP, logLRT), estimate passenger probabilities via empirical Bayes FDR, and perform patient-oriented gene-set analysis to distinguish driver genes from passenger mutations.

## Overview

The `CancerMutationAnalysis` package provides tools for distinguishing "driver" genes (active in tumorigenesis) from "passenger" genes (mutated but neutral) in cancer sequencing studies. It implements methods for both gene-level scoring and gene-set level analysis, specifically designed for discovery and prevalence screen study designs.

## Core Data Objects

The package uses specific data structures for mutations, coverage, and samples:
- `GeneAlter*`: Mutation details (transcript, type [Mut/Amp/Del], sample, screen [Disc/Prev]).
- `GeneCov*`: Sequencing coverage (nucleotides successfully sequenced per transcript/context).
- `GeneSamp*`: Sample counts for discovery and prevalence screens.
- `BackRates*`: Estimated background passenger rates.

Example datasets included: `WoodBreast07`, `WoodColon07`, `JonesPancreas08`, `ParsonsGBM08`, `ParsonsMB11`.

## Gene-Level Analysis

### Calculating Gene Scores
Use `cma.scores` to calculate Cancer Mutation Prevalence (CaMP) and log Likelihood Ratio (logLRT) scores.

```r
library(CancerMutationAnalysis)
data(ParsonsGBM08)

scores <- cma.scores(
  cma.alter = GeneAlterGBM,
  cma.cov = GeneCovGBM,
  cma.samp = GeneSampGBM,
  passenger.rates = BackRatesGBM["MedianRates",]
)
head(scores)
```

### Estimating Passenger Probabilities (FDR)
Use `cma.fdr` to perform empirical Bayes analysis to estimate local false discovery rates (fdr), which represent passenger probabilities.

```r
fdr_results <- cma.fdr(
  cma.alter = GeneAlterGBM,
  cma.cov = GeneCovGBM,
  cma.samp = GeneSampGBM,
  scores = "logLRT",
  passenger.rates = BackRatesGBM["MedianRates",],
  showFigure = TRUE,
  cutoffFdr = 0.1
)
# Access results for a specific score
head(fdr_results[["logLRT"]])
```

## Gene-Set Analysis

The package implements "patient-oriented" approaches that calculate scores per sample before combining them.

### Performing Gene-Set Tests
Use `cma.set.stat` to test specific gene sets (e.g., from KEGG).

```r
# Requires mapping between Entrez IDs and Gene Names
data(EntrezID2Name)

results <- cma.set.stat(
  cma.alter = GeneAlterGBM,
  cma.cov = GeneCovGBM,
  cma.samp = GeneSampGBM,
  GeneSets = my_gene_sets, # List of gene vectors
  ID2name = EntrezID2Name,
  gene.method = FALSE,          # Wilcoxon gene-oriented method
  perm.null.method = TRUE,      # Permutation null (no heterogeneity)
  pass.null.method = TRUE       # Passenger null (no heterogeneity)
)
```

### Simulating Gene-Set Data
Use `cma.set.sim` to evaluate methods under null hypotheses or with "spiked-in" signals.

```r
sim_results <- cma.set.sim(
  cma.alter = GeneAlterGBM,
  cma.cov = GeneCovGBM,
  cma.samp = GeneSampGBM,
  GeneSets = my_gene_sets,
  nr.iter = 10,
  pass.null = TRUE,             # Use passenger null mechanism
  perc.samples = c(75, 95),     # Spiked-in mutation probabilities
  spiked.set.sizes = c(50)      # Size of spiked-in sets
)

# Extract specific metrics from simulation
p_vals <- extract.sims.method(sim_results, "p.values.perm.null")
```

## Workflow Tips

1. **Data Filtering**: Most analyses (especially gene-set methods) focus on point mutations (`Mut`) and discovery (`Disc`) samples.
2. **Annotation**: Ensure gene identifiers in your `GeneSets` match the names used in `GeneAlter` objects. Use the `ID2name` parameter to map identifiers if necessary.
3. **Performance**: Running all gene-set methods simultaneously via `cma.set.stat` can be computationally intensive; enable only the specific null models required for your study.

## Reference documentation

- [CancerMutationAnalysis](./references/CancerMutationAnalysis.md)