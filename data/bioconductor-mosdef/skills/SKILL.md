---
name: bioconductor-mosdef
description: This tool streamlines the post-processing of differential expression results through functional enrichment analysis, publication-quality visualization, and interactive report generation. Use when user asks to perform functional enrichment analysis using topGO or clusterProfiler, generate volcano and MA plots, or create interactive HTML reports with links to external gene databases.
homepage: https://bioconductor.org/packages/release/bioc/html/mosdef.html
---

# bioconductor-mosdef

name: bioconductor-mosdef
description: Specialized workflow for differential expression (DE) analysis post-processing using the Bioconductor package 'mosdef'. Use this skill to perform functional enrichment analysis (topGO, goseq, clusterProfiler), generate publication-ready visualizations (Volcano, MA, and gene plots), and create interactive, link-rich HTML reports for DE results.

## Overview
The `mosdef` package (MOSt frequently used DE-related Functions) streamlines the post-processing of differential expression results. It provides a unified API for enrichment analysis, robust plotting functions, and utilities to "beautify" RMarkdown reports by automatically linking gene symbols and GO terms to external databases like ENSEMBL, GeneCards, NCBI, and GTEx.

## Core Workflow

### 1. Input Requirements
`mosdef` primarily works with objects from the `DESeq2` workflow:
- `de_container`: A `DESeqDataSet` containing expression counts.
- `res_de`: A `DESeqResults` object containing the DE analysis results.
- `mapping`: An `AnnotationDbi` package (e.g., `org.Hs.eg.db` for human).

Validate inputs using:
```r
mosdef_de_container_check(dds)
mosdef_res_check(res)
```

### 2. Unified Enrichment Analysis
`mosdef` provides a standardized interface for three major algorithms. All return a table with a `genes` column containing the DE genes associated with each term.

- **topGO**: Best for reducing GO redundancy.
  ```r
  res_topgo <- run_topGO(dds, res, ontology = "BP", mapping = "org.Hs.eg.db")
  ```
- **goseq**: Accounts for gene length bias in RNA-seq.
  ```r
  res_goseq <- run_goseq(dds, res, mapping = "org.Hs.eg.db", testCats = "GO:BP")
  ```
- **clusterProfiler**:
  ```r
  res_clu <- run_cluPro(dds, res, mapping = "org.Hs.eg.db", ont = "BP")
  ```

### 3. Visualization
- **Individual Genes**: Plot normalized counts across groups.
  ```r
  gene_plot(dds, gene = "ENSG00000125347", intgroup = "condition")
  ```
- **Volcano Plots**:
  - Standard: `de_volcano(res, mapping = "org.Hs.eg.db", labeled_genes = 20)`
  - GO-specific (highlights genes in a term): `go_volcano(res, res_enrich, term_index = 1)`
- **MA Plots**:
  ```r
  plot_ma(res, FDR = 0.05, intgenes = c("GENE1", "GENE2"))
  ```

### 4. Report Enhancement (Buttonifier)
Transform DE tables into interactive HTML tables with links to external databases. This is highly effective in RMarkdown reports.

```r
# Convert results to data frame first
res_df <- deresult_to_df(res, FDR = 0.05)

# Create interactive table with database buttons
buttonifier(
  df = res_df,
  col_to_use = "symbol",
  create_buttons_to = c("GC", "NCBI", "GTEX", "PUBMED"),
  ens_col = "id",
  ens_species = "Homo_sapiens"
)
```

### 5. HTML Snippets
Generate rich HTML descriptions for specific genes or GO terms for embedding in dashboards:
```r
geneinfo_to_html("IRF1", res_de = res)
go_to_html("GO:0001525")
```

## Tips and Best Practices
- **Identifier Consistency**: Ensure `res_de` has a `symbol` column for plotting and linking functions.
- **Table Painting**: Use `de_table_painter(res_df)` to add visual bar charts representing Log2FoldChange directly into your tables.
- **Vector Input**: If you don't have `DESeq2` objects, enrichment functions also accept `de_genes` and `bg_genes` (background) as character vectors.
- **Interactive Tables**: When using `buttonifier` or manual links in `DT::datatable`, always set `escape = FALSE` to render the HTML buttons correctly.

## Reference documentation
- [mosdef_userguide](./references/mosdef_userguide.md)
- [mosdef_userguide.Rmd](./references/mosdef_userguide.Rmd)