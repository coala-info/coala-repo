---
name: bioconductor-chipenrich
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/chipenrich.html
---

# bioconductor-chipenrich

## Overview
The `chipenrich` package provides a suite of methods for Gene Set Enrichment (GSE) testing of genomic regions (e.g., ChIP-seq peaks, ATAC-seq regions). Its primary advantage is accounting for the "locus length bias," where longer genes are more likely to have peaks by chance. It supports multiple organisms (human, mouse, rat, fly, zebrafish) and offers specialized models for different peak types and densities.

## Core Workflow

### 1. Prepare Input Data
Peaks can be a file path (BED, narrowPeak, broadPeak) or an R `data.frame` with `chrom`, `start`, and `end` columns.

```r
library(chipenrich)
# Example data from companion package
data(peaks_E2F4, package = 'chipenrich.data')
```

### 2. Select an Enrichment Method
Choose the function based on the nature of your genomic regions:

*   **`chipenrich()`**: Best for narrow peaks (transcription factors) with < 50,000 regions. Uses a logistic regression model (presence/absence of peak).
*   **`polyenrich()`**: Best for narrow peaks with > 50,000 regions or when the *number* of peaks per gene is biologically relevant. Uses a negative binomial model.
*   **`broadenrich()`**: Designed for broad regions (histone modifications) covering > 5% of the genome. Uses the ratio of gene locus coverage.
*   **`hybridenrich()`**: A combination of ChIP-Enrich and Poly-Enrich; recommended if unsure which narrow-peak method is optimal.
*   **`proxReg()`**: Tests if peaks in a gene set are significantly closer to or farther from TSS/enhancers compared to the genomic average.

### 3. Configure Parameters
*   **`genome`**: Supported builds include `hg19`, `hg38`, `mm9`, `mm10`, `rn4`, `rn5`, `rn6`, `dm3`, `dm6`, `danRer10`.
*   **`genesets`**: Built-in options like `GOBP`, `GOCC`, `GOMF`, `kegg_pathway`, `reactome`. Can also be a path to a custom text file.
*   **`locusdef`**: Defines how peaks are assigned to genes.
    *   `nearest_tss`: Assigns peak to the gene with the closest TSS.
    *   `nearest_gene`: Assigns peak to the gene whose body is closest.
    *   `1kb` / `5kb` / `10kb`: Proximal promoter definitions.
    *   `enhancer`: Specifically for linking distal regions to target genes (use with `polyenrich`).
*   **`mappability`**: (Optional) Adjusts for genomic regions that are difficult to sequence. Use `supported_read_lengths()` to see available values for your genome.

### 4. Execution Example
```r
# Basic ChIP-Enrich run
results = chipenrich(
  peaks = peaks_E2F4, 
  genome = 'hg19', 
  genesets = 'GOBP', 
  locusdef = "nearest_tss",
  qc_plots = TRUE
)

# Access results
head(results$results)       # Enrichment table (P-value, FDR, Effect)
head(results$peaks)         # Peak-to-gene assignments
head(results$peaks_per_gene) # Gene-level summary
```

## Quality Control Plots
If `qc_plots = TRUE`, the package generates visualizations to validate method selection:
*   `plot_dist_to_tss()`: Shows peak distribution relative to TSS to help choose `locusdef`.
*   `plot_chipenrich_spline()`: Shows the relationship between peak presence and locus length.
*   `plot_polyenrich_spline()`: Shows the relationship between peak count and locus length.

## Tips for Success
*   **Enhancer Analysis**: When using `locusdef = "enhancer"`, always use `polyenrich(method = "polyenrich_weighted", multiAssign = TRUE)`.
*   **Custom Gene Sets**: Input a tab-delimited file with two columns: `gs_id` and `gene_id` (Entrez IDs).
*   **Parallelization**: Use the `n_cores` argument to speed up calculations across multiple gene sets.
*   **Randomization**: Use the `randomization` parameter (`"complete"`, `"byLength"`, or `"byLocation"`) to assess Type I error and validate that your results aren't driven by biases.

## Reference documentation
- [Gene Set Enrichment For ChIP-seq Peak Data](./references/chipenrich-vignette.md)