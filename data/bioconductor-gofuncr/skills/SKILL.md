---
name: bioconductor-gofuncr
description: "the package and updated regularly (01-May-2021). GOfuncR provides the standard candidate vs. background enrichment analysis using the hypergeometric test, as well as three additional tests: (i) the Wilcoxon rank-sum test that is used when genes are ranked, (ii) a binomial test that is used when genes are associated with two counts and (iii) a Chi-square or Fisher's exact test that is used in cases when genes are associated with four counts. To correct for multiple testing and interdependency of the tests, family-wise error rates are computed based on random permutations of the gene-associated variables. GOfuncR also provides tools for exploring the ontology graph and the annotations, and options to take gene-length or spatial clustering of genes into account. It is also possible to provide custom gene coordinates, annotations and ontologies."
homepage: https://bioconductor.org/packages/release/bioc/html/GOfuncR.html
---

# bioconductor-gofuncr

name: bioconductor-gofuncr
description: Gene Ontology (GO) enrichment analysis using the FUNC software. Supports hypergeometric, Wilcoxon rank-sum, binomial, and 2x2 contingency table tests. Use this skill when performing GO enrichment for candidate gene sets, ranked gene lists, or genes with associated counts (e.g., McDonald-Kreitman tests). It includes features for gene-length correction, genomic region input, and GO graph exploration.

# bioconductor-gofuncr

## Overview
`GOfuncR` is an R package for Gene Ontology (GO) enrichment analysis based on the FUNC software. It is particularly robust because it computes family-wise error rates (FWER) through random permutations of gene-associated variables, accounting for the interdependency of GO terms. It supports multiple species via Bioconductor annotation packages (like `Homo.sapiens` or `Mus.musculus`) and allows for custom annotations and ontologies.

## Core Workflow: go_enrich()
The primary function is `go_enrich()`. It automatically maps genes to GO terms and performs the requested statistical test.

### 1. Hypergeometric Test (Candidate vs. Background)
Used to find over-represented GO terms in a list of candidate genes.
```r
library(GOfuncR)
# Input: 1 for candidate, 0 for background (optional)
genes <- data.frame(
  gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4'),
  is_candidate = c(1, 1, 0, 0)
)
res <- go_enrich(genes, n_randsets = 1000)
# Results are in the first element
head(res[[1]])
```

### 2. Wilcoxon Rank-Sum Test (Ranked Genes)
Used when genes are associated with a continuous score (e.g., p-values or fold-changes).
```r
genes <- data.frame(
  gene_ids = c('GCK', 'CALB1', 'PAX2', 'GYS1'),
  score = runif(4, 0, 1)
)
res <- go_enrich(genes, test = 'wilcoxon')
```

### 3. Binomial and Contingency Tests
*   **Binomial**: For genes with two counts (e.g., A and B).
*   **Contingency**: For genes with four counts (e.g., A, B, C, D for McDonald-Kreitman tests).
```r
# Contingency example
genes <- data.frame(
  gene_ids = c('G6PD', 'GCK'),
  subs_non_syn = c(8, 12), subs_syn = c(9, 8),
  vari_non_syn = c(1, 1), vari_syn = c(7, 11)
)
res <- go_enrich(genes, test = 'contingency')
```

## Advanced Features

### Genomic Regions
Instead of gene symbols, you can provide chromosomal coordinates. `GOfuncR` will identify genes in these regions and account for spatial clustering.
```r
regions <- data.frame(
  chrom_coords = c('8:81000000-83000000', '7:1300000-56800000'),
  is_candidate = c(1, 0)
)
res <- go_enrich(regions, regions = TRUE)
```

### Bias Correction
*   **Gene Length**: Set `gene_len = TRUE` in `go_enrich` (hypergeometric only) to correct for the bias where longer genes are more likely to be detected.
*   **Refinement**: Use `refine(res, fwer = 0.1)` to apply the *elim* algorithm, which removes genes from significant child nodes to find the most specific significant categories.

### Visualization
Use `plot_anno_scores(res, go_ids)` to visualize the distribution of scores or counts within specific GO categories compared to the root nodes.

## GO Graph Exploration
*   `get_parent_nodes(go_ids)` / `get_child_nodes(go_ids)`: Navigate the hierarchy.
*   `get_names(go_ids)`: Get full term names and domains.
*   `get_ids(search_string)`: Search for GO IDs by keyword.
*   `get_anno_genes(go_ids)`: Find all genes annotated to a specific term.

## Tips for Success
1.  **Annotation Packages**: Ensure the required `OrganismDb` (e.g., `Homo.sapiens`) or `OrgDb` (e.g., `org.Hs.eg.db`) is installed.
2.  **FWER**: The `FWER_overrep` column is the most important for interpreting significance after multiple testing correction. Values < 0.05 are typically considered significant.
3.  **Custom Data**: If working with a non-standard organism, provide custom dataframes to the `annotations` and `gene_coords` parameters.

## Reference documentation
- [GOfuncR: Gene Ontology Enrichment Using FUNC](./references/GOfuncR.md)