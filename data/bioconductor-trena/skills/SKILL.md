---
name: bioconductor-trena
description: The trena package provides a framework for inferring gene regulatory networks by using statistical solvers to identify transcription factors that explain the expression of a target gene. Use when user asks to infer gene regulatory networks, filter candidate transcription factors, or run ensemble feature selection models to identify gene regulators.
homepage: https://bioconductor.org/packages/3.8/bioc/html/trena.html
---


# bioconductor-trena

## Overview
The `trena` package provides a framework for inferring gene regulatory networks. It operates by taking a target gene and a set of candidate regulators (transcription factors) and using various statistical "solvers" to determine which regulators best explain the expression of the target gene. The workflow typically involves data normalization, filtering candidate regulators to reduce the search space, and running feature selection models.

## Typical Workflow

### 1. Data Preparation
Load the library and your expression matrix. It is highly recommended to transform skewed data (e.g., using `asinh` or `voom`) to normalize the mean-variance relationship.

```r
library(trena)

# Load expression matrix (rows = genes, cols = samples)
# Example: mtx.asinh <- asinh(mtx.sub)
```

### 2. Filtering Candidate Regulators
Filtering reduces the number of predictors, improving solver performance and biological relevance.

*   **VarianceFilter**: Selects TFs with expression variance similar to the target gene.
    ```r
    vf <- VarianceFilter(mtx.assay = mtx.asinh, targetGene = "MEF2C", varSize = 0.5)
    tfs <- getCandidates(vf)$tfs
    ```
*   **FootprintFilter**: Uses DNAse footprints and motif matching (requires database connections).
    ```r
    # Requires genome and project database URIs
    ff <- FootprintFilter(genomeDB = genome.db.uri, footprintDB = project.db.uri, regions = gene.regions)
    tbl.fp <- getCandidates(ff)[[1]]
    
    # Associate motifs with TFs using MotifDb
    library(MotifDb)
    tbl.tfs <- associateTranscriptionFactors(MotifDb, tbl.fp, source="MotifDb", expand.rows=TRUE)
    candidate.tfs <- unique(tbl.tfs$geneSymbol)
    ```

### 3. Running Solvers
Solvers perform the actual feature selection. You can use individual methods or an ensemble approach.

*   **Individual Solvers**: Supported methods include `LassoSolver`, `RidgeSolver`, `RandomForestSolver`, `PearsonSolver`, and `SpearmanSolver`.
    ```r
    solver <- LassoSolver(mtx.assay = mtx.asinh, 
                          targetGene = "MEF2C", 
                          candidateRegulators = candidate.tfs)
    tbl.results <- run(solver)
    ```

*   **Ensemble Solver (Recommended)**: Combines multiple methods to provide a composite score.
    ```r
    ens.solver <- EnsembleSolver(mtx.assay = mtx.asinh, 
                                 targetGene = "MEF2C", 
                                 candidateRegulators = candidate.tfs,
                                 solverNames = c("lasso", "ridge", "randomforest", "pearson"))
    tbl.ens <- run(ens.solver)
    ```

## Interpreting Results
*   **Beta/Coefficients**: In LASSO/Ridge, non-zero beta values indicate the strength and direction of the regulation.
*   **pcaMax**: In the Ensemble solver, this score quantifies the agreement between dissimilar solvers. High scores suggest high confidence.
*   **concordance**: A "voting" metric (0-1) representing how many solvers identified the regulator as significant.
*   **geneCutoff**: By default, the Ensemble solver returns the top 10% of regulators. Set `geneCutoff = 1.0` to see all candidates.

## Tips
*   **Seed Setting**: Always use `set.seed()` before running stochastic solvers like `RandomForestSolver` or `LassoSolver` (which uses cross-validation) for reproducibility.
*   **Keep Metrics**: For `LassoSolver` and `RidgeSolver`, set `keep.metrics = TRUE` in the constructor to retrieve $R^2$ and lambda values.
*   **Solver Choice**: Use LASSO for sparse models (few regulators) and Random Forest or Ensemble for a more comprehensive view of the regulatory landscape.

## Reference documentation
- [A Brief Introduction to TReNA](./references/TReNA_Vignette.md)