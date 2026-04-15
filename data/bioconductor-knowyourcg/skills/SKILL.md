---
name: bioconductor-knowyourcg
description: This tool performs functional interpretation of DNA methylation data by testing CpG sets for enrichment against curated knowledgebases. Use when user asks to analyze CpG sets for enrichment, perform set enrichment analysis on methylation data, link CpGs to genes, or test for genomic proximity and co-regulation.
homepage: https://bioconductor.org/packages/release/bioc/html/knowYourCG.html
---

# bioconductor-knowyourcg

name: bioconductor-knowyourcg
description: Functional interpretation of DNA methylation data using the knowYourCG Bioconductor package. Use this skill when analyzing CpG sets (queries) for enrichment against curated knowledgebases including chromatin states, transcription factor binding sites (TFBS), histone modifications, and tissue-specific signatures. It supports Infinium arrays (HM450, EPIC, EPICv2, MM285) and sequencing data.

# bioconductor-knowyourcg

## Overview
knowYourCG (KYCG) is a CpG-centered framework for the functional interpretation of DNA methylation. Unlike gene-centric tools, it directly tests CpG dinucleotides against curated knowledgebases. It supports Fisher's Exact Test for categorical data and Set Enrichment Analysis (SEA) for continuous data (like beta values).

## Setup and Data Preparation
The package relies on `sesameData` for knowledgebase sets. Caching is required for first-time use.

```r
library(knowYourCG)
library(sesameData)
# Cache required data (only needs to be done once)
sesameDataCache() 
```

## Knowledgebase Management
Knowledgebases are organized into groups (e.g., "TFBS", "chromHMM", "tissueSignature").

- **List available groups**: `listDBGroups("MM285")` (replace with "EPIC" or "HM450" as needed).
- **Retrieve specific databases**: `dbs <- getDBs("MM285.chromHMM")`.
- **Search databases**: The package supports substring matching (e.g., "TFBS" matches "KYCG.MM285.TFBSconsensus...").

## Enrichment Testing

### Categorical Query (Fisher's Exact Test)
Use when you have a list of CpG IDs (e.g., from differential methylation analysis).

```r
# query: character vector of probe IDs
results <- testEnrichment(query, databases = "TFBS", platform = "MM285")
# results include: estimate (fold enrichment), p-value, FDR, overlap
```

### Continuous Query (Set Enrichment Analysis)
Use when you have a named numeric vector (e.g., beta values or correlation coefficients).

```r
# query: named numeric vector (names are probe IDs)
results <- testEnrichmentSEA(query, databases = "MM285.chromHMM")
# estimate here represents the enrichment score
```

## Gene and Pathway Analysis
KYCG can link CpGs to proximal genes and perform Gene Ontology (GO) enrichment.

- **Gene-centric enrichment**: 
  ```r
  gene_dbs <- buildGeneDBs(query, max_distance = 100000, platform = "MM285")
  results <- testEnrichment(query, gene_dbs, platform = "MM285")
  ```
- **GO Analysis**:
  ```r
  # Uses gprofiler2 internally
  go_results <- testGO(query, platform = "MM285", organism = "mmusculus")
  ```

## Genomic Proximity
Test if a set of probes are physically clustered in the genome, suggesting co-regulation.

```r
prox_res <- testProbeProximity(probeIDs = query)
# Returns Poisson statistics (lambda, p.val) and cluster coordinates
```

## Visualization
KYCG provides several plotting functions to interpret enrichment results:

- **Overview**: `KYCG_plotEnrichAll(results)` - Plots -log10(FDR) across all tested database groups.
- **Dot Plot**: `KYCG_plotDot(results)` - Standard enrichment dot plot.
- **Volcano Plot**: `KYCG_plotVolcano(results)` - Useful for two-tailed tests.
- **Waterfall/Bar**: `KYCG_plotWaterfall(results)` or `KYCG_plotBar(results)`.
- **Manhattan Plot**: `KYCG_plotManhattan(named_vector, platform = "HM450")` - Visualizes chromosomal distribution of significance.
- **Metagene Plot**: `KYCG_plotMeta(beta_values)` - Aggregates methylation signal over gene bodies/features.

## Tips for Success
1. **Universe Selection**: By default, the universe is inferred from the query. For more accurate results, explicitly provide the `platform` (e.g., "EPIC", "MM285") or a `universeSet`.
2. **Database Caching**: Always run `sesameDataCache()` if you encounter errors regarding missing database sets.
3. **Feature Aggregation**: Use `dbStats(betas, 'MM285.chromHMM')` to calculate summary statistics (like mean beta) for specific chromatin states across samples, which is useful for downstream machine learning.

## Reference documentation
- [Array Data Analysis](./references/Array.md)
- [Continuous Data Analysis](./references/Continuous.md)
- [Main KYCG Vignette](./references/KYCG.Rmd)
- [Sequencing Data Analysis](./references/Sequencing.md)
- [Visualization Guide](./references/visualization.md)