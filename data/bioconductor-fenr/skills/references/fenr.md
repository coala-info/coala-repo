# Fast functional enrichment

Marek Gierlinski

#### 15 January 2026

#### Abstract

The *fenr* R package enables rapid functional enrichment analysis, typically completing in a fraction of a second, which makes it well-suited for interactive applications, such as Shiny apps. To accomplish this, fenr pre-downloads functional data (e.g., GO terms or KEGG pathways) and stores them in a format optimized for swift analysis of any arbitrary selection of features, including genes or proteins.

#### Package

fenr 1.8.1

# 1 Purpose

Functional enrichment analysis determines if specific biological functions or pathways are overrepresented in a set of features (e.g., genes, proteins). These sets often originate from differential expression analysis, while the functions and pathways are derived from databases such as *GO*, *Reactome*, or *KEGG*. In its simplest form, enrichment analysis employs Fisher’s test to evaluate if a given function is enriched in the selection. The null hypothesis asserts that the proportion of features annotated with that function is the same between selected and non-selected features.

Functional enrichment analysis requires downloading large datasets from the aforementioned databases before conducting the actual analysis. While downloading data is time-consuming, Fisher’s test can be performed rapidly. This package aims to separate these two steps, enabling fast enrichment analysis for various feature selections using a given database. It is specifically designed for interactive applications like Shiny. A small Shiny app, included in the package, demonstrates the usage of *fenr*.

## 1.1 Caveats

Functional enrichment analysis should not be considered the ultimate answer in understanding biological systems. In many instances, it may not provide clear insights into biology. Specifically, when arbitrary groups of genes are selected, enrichment analysis only reveals the statistical overrepresentation of a functional term within the selection, which may not directly correspond to biological relevance. This package serves as a tool for data exploration; any conclusions drawn about biology require independent validation and further investigation.

# 2 Installation

*fenr* can be installed from *Bioconductor* by using:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("fenr")
```

# 3 Overview

The input data for *fenr* consists of two tibbles or data frames (see figure below). One tibble contains functional term descriptions, while the other provides the term-to-feature mapping. Users can acquire these datasets using the convenient helper functions like `fetch_*`, which facilitate data retrieval from GO, KEGG, BioPlanet, or WikiPathways. Alternatively, users have the option to provide their own datasets. These tibbles are subsequently transformed into a fenr\_terms object, specifically designed for efficient data retrieval and access. The resulting object is then employed by the functional\_enrichment function to perform enrichment analysis for any chosen feature selection.

![Overview of fenr data pipeline.](data:image/png;base64...)

Figure 1: Overview of fenr data pipeline

# 4 Example

Package *fenr* and example data are loaded with the following commands:

```
library(fenr)
data(exmpl_all, exmpl_sel)
```

## 4.1 Data preparation

The initial step involves downloading functional term data. *fenr* supports data downloads from *Gene Ontology*, *Reactome*, *KEGG*, *BioPlanet*, and *WikiPathways*. Custom ontologies can also be used, provided they are converted into an appropriate format (refer to the `prepare_for_enrichment` function for more information). The command below downloads functional terms and gene mapping from Gene Ontology (GO):

```
go <- fetch_go(species = "sgd")
```

`sgd` is a designation for yeast in Gene Ontology. The full list of available species designations can be obtain using the command:

```
go_species <- fetch_go_species()
```

which returns a tibble:

```
go_species
#> # A tibble: 40 × 2
#>    species                                                   designation
#>    <chr>                                                     <chr>
#>  1 Species/Database                                          File
#>  2 Gallus gallus - EBI Gene Ontology Annotation Database (g… goa_chicke…
#>  3 Sus scrofa - EBI Gene Ontology Annotation Database (goa)  goa_pig_is…
#>  4 Dictyostelium discoideum - dictyBase (dictyBase)          dictybase
#>  5 Mus musculus - Mouse Genome Informatics (mgi)             mgi
#>  6 Solanaceae - Sol Genomics Network (sgn)                   sgn
#>  7 Sus scrofa - EBI Gene Ontology Annotation Database (goa)  goa_pig
#>  8 Gallus gallus - EBI Gene Ontology Annotation Database (g… goa_chicke…
#>  9 Danio rerio - Zebrafish Information Network (zfin)        zfin
#> 10 Bos taurus - EBI Gene Ontology Annotation Database (goa)  goa_cow_rna
#> # ℹ 30 more rows
```

`go` is a list with two tibbles. The first tibble contains term information:

```
go$terms
#> # A tibble: 51,641 × 3
#>    term_id    term_name                                        namespace
#>    <chr>      <chr>                                            <chr>
#>  1 GO:0000001 mitochondrion inheritance                        biologic…
#>  2 GO:0000002 mitochondrial genome maintenance                 biologic…
#>  3 GO:0000003 obsolete reproduction                            biologic…
#>  4 GO:0000005 obsolete ribosomal chaperone activity            molecula…
#>  5 GO:0000006 high-affinity zinc transmembrane transporter ac… molecula…
#>  6 GO:0000007 low-affinity zinc ion transmembrane transporter… molecula…
#>  7 GO:0000008 obsolete thioredoxin                             molecula…
#>  8 GO:0000009 alpha-1,6-mannosyltransferase activity           molecula…
#>  9 GO:0000010 heptaprenyl diphosphate synthase activity        molecula…
#> 10 GO:0000011 vacuole inheritance                              biologic…
#> # ℹ 51,631 more rows
```

The second tibble contains gene-term mapping:

```
go$mapping
#> # A tibble: 94,235 × 5
#>    gene_symbol gene_id db_id      term_id    evidence
#>    <chr>       <chr>   <chr>      <chr>      <chr>
#>  1 GPC1        YGR149W S000003381 GO:0090640 IGI
#>  2 ALE1        YOR175C S000005701 GO:0090640 IGI
#>  3 GPC1        YGR149W S000003381 GO:0036151 IMP
#>  4 RCF1        YML030W S000004492 GO:0033617 IMP
#>  5 SIW14       YNL032W S000004977 GO:0052845 IDA
#>  6 SIW14       YNL032W S000004977 GO:0071543 IMP
#>  7 PAB1        YER165W S000000967 GO:0031124 IMP
#>  8 ULP2        YIL031W S000001293 GO:0000785 IDA
#>  9 AIP5        YFR016C S000001912 GO:0032233 IDA
#> 10 AIP5        YFR016C S000001912 GO:0005934 IDA
#> # ℹ 94,225 more rows
```

Note that the mapping can be filtered based on the [evidence code](https://geneontology.org/docs/guide-go-evidence-codes/) (column `evidence`) to include only high-quality GO annotations, before further analysis. Here, we simply use all annotations.

To make these user-friendly data more suitable for rapid functional enrichment analysis, they need to be converted into a machine-friendly object using the following function:

```
go_terms <- prepare_for_enrichment(go$terms, go$mapping, exmpl_all,
                                   feature_name = "gene_symbol")
```

`exmpl_all` is an example of gene background - a vector with gene symbols related to all detections in an imaginary RNA-seq experiment. Since different datasets use different features (gene id, gene symbol, protein id), the column name containing features in `go$mapping` needs to be specified using `feature_name = "gene_symbol"`. The resulting object, `go_terms`, is a data structure containing all the mappings in a quickly accessible form. From this point on, `go_terms` can be employed to perform multiple functional enrichment analyses on various gene selections.

## 4.2 Functional enrichment

The package includes two pre-defined gene sets. `exmpl_all` contains all background gene symbols, while `exmpl_sel` comprises the genes of interest. To perform functional enrichment analysis on the selected genes, you can use the following single, efficient function call:

```
enr <- functional_enrichment(exmpl_all, exmpl_sel, go_terms)
```

## 4.3 The output

The result of `functional_enrichment` is a tibble with enrichment results.

```
enr |>
  head(10)
#> # A tibble: 10 × 10
#>    term_id    term_name N_with n_with_sel n_expect enrichment odds_ratio
#>    <chr>      <chr>      <int>      <int>    <dbl>      <dbl>      <dbl>
#>  1 GO:0031931 TORC1 co…      5          5     0.02      333          Inf
#>  2 GO:1905356 regulati…      2          2     0.01      333          Inf
#>  3 GO:0038201 TOR comp…      2          2     0.01      333          Inf
#>  4 GO:0031929 TOR sign…     15         14     0.05      310        13900
#>  5 GO:0001558 regulati…      9          5     0.03      185          544
#>  6 GO:0038202 TORC1 si…      4          2     0.01      166          366
#>  7 GO:0031932 TORC2 co…      7          3     0.02      143          290
#>  8 GO:0010506 regulati…      5          2     0.02      133          244
#>  9 GO:0016242 negative…      9          3     0.03      111          193
#> 10 GO:0030950 establis…     15          4     0.05       88.7        149
#> # ℹ 3 more variables: ids <chr>, p_value <dbl>, p_adjust <dbl>
```

The columns are as follows

* `N_with`: The number of features (genes) associated with this term in the background of all genes.
* `n_with_sel`: The number of features associated with this term in the selection.
* `n_expect`: The expected number of features associated with this term under the null hypothesis (terms are randomly distributed).
* `enrichment`: The ratio of observed to expected.
* `odds_ratio`: The effect size, represented by the odds ratio from the contingency table.
* `ids`: The identifiers of features with the term in the selection.
* `p_value`: The raw p-value from the hypergeometric distribution.
* `p_adjust`: The p-value adjusted for multiple tests using the Benjamini-Hochberg approach.

# 5 Interactive Example

A small Shiny app is included in the package to demonstrate the usage of *fenr* in an interactive environment. All time-consuming data loading and preparation tasks are performed before the app is launched.

```
data(yeast_de)
term_data <- fetch_terms_for_example(yeast_de)
```

`yeast_de` is the result of differential expression (using `edgeR`) on a subset of 6+6 replicates from [Gierlinski et al. (2015)](https://academic.oup.com/bioinformatics/article/31/22/3625/240923).

The function `fetch_terms_for_example` uses `fetch_*` functions from *fenr* to download and process data from *GO*, *Reactome* and *KEGG*. The step-by-step process of data acquisition can be examined by viewing the function by typing `fetch_terms_for_example` in the R console. The object `term_data` is a named list of `fenr_terms` objects, one for each ontology.

After completing the slow tasks, you can start the Shiny app by running:

```
enrichment_interactive(yeast_de, term_data)
```

To quickly see how *fenr* works an example can be loaded directly from GitHub:

```
shiny::runGitHub("bartongroup/fenr-shiny-example")
```

# 6 Comparison to other functional enrichment packages

There’s no shortage of R packages dedicated to functional enrichment analyses, including *topGO*, *GOstats*, *clusterProfiler*, and *GOfuncR*. Many of these packages provide comprehensive analyses tailored to a single gene selection. While they offer detailed insights, their extensive computational requirements often render them slower.

To illustrate, let’s take the example of the *topGO* package.

```
suppressPackageStartupMessages({
  library(topGO)
})
#>
#> groupGOTerms:    GOBPTerm, GOMFTerm, GOCCTerm environments built.

# Preparing the gene set
all_genes <- setNames(rep(0, length(exmpl_all)), exmpl_all)
all_genes[exmpl_all %in% exmpl_sel] <- 1

# Define the gene selection function
gene_selection <- function(genes) {
  genes > 0
}

# Mapping genes to GO, we use the go2gene downloaded above and convert it to a
# list
go2gene <- go$mapping |>
  dplyr::select(gene_symbol, term_id) |>
  dplyr::distinct() |>
  dplyr::group_by(term_id) |>
  dplyr::summarise(ids = list(gene_symbol)) |>
  tibble::deframe()

# Setting up the GO data for analysis
go_data <- new(
  "topGOdata",
  ontology = "BP",
  allGenes = all_genes,
  geneSel = gene_selection,
  annot = annFUN.GO2genes,
  GO2genes = go2gene
)
#>
#> Building most specific GOs .....
#>  ( 2922 GO terms found. )
#>
#> Build GO DAG topology ..........
#>  ( 4591 GO terms and 9732 relations. )
#>
#> Annotating nodes ...............
#>  ( 6762 genes annotated to the GO terms. )

# Performing the enrichment test
fisher_test <- runTest(go_data, algorithm = "classic", statistic = "fisher")
#>
#>           -- Classic Algorithm --
#>
#>       the algorithm is scoring 367 nontrivial nodes
#>       parameters:
#>           test statistic: fisher
```

Though the enrichment test (`runTest`) is fairly fast, completing in about 200 ms on an Intel Core i7 processor, the preparatory step (`new` call) demands a more substantial time commitment, around 6 seconds. Considering each additional gene selection requires a similar amount of time, conducting exploratory interactive analyses on multiple gene sets becomes notably cumbersome.

*fenr* separates preparatory steps and gene selection and is designed with interactivity and speed in mind, particularly when users wish to execute rapid, multiple selection tests.

```
# Setting up data for enrichment
go <- fetch_go(species = "sgd")
go_terms <- prepare_for_enrichment(go$terms, go$mapping, exmpl_all,
                                   feature_name = "gene_symbol")

# Executing the enrichment test
enr <- functional_enrichment(exmpl_all, exmpl_sel, go_terms)
```

While data preparation with *fenr* might take a bit longer (around 10 s), the enrichment test is fast, finishing in just about 50 ms. Each new gene selection takes a similar amount of time (with an obvious caveat that a larger gene selection would take more time to calculate).

# Session info

```
#> R version 4.5.2 (2025-10-31)
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
#> [1] stats4    stats     graphics  grDevices utils     datasets
#> [7] methods   base
#>
#> other attached packages:
#>  [1] topGO_2.62.0         SparseM_1.84-2       GO.db_3.22.0
#>  [4] AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0
#>  [7] Biobase_2.70.0       graph_1.88.1         BiocGenerics_0.56.0
#> [10] generics_0.1.4       tibble_3.3.1         fenr_1.8.1
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         utf8_1.2.6          lattice_0.22-7
#>  [4] RSQLite_2.4.5       digest_0.6.39       magrittr_2.0.4
#>  [7] grid_4.5.2          evaluate_1.0.5      bookdown_0.46
#> [10] fastmap_1.2.0       blob_1.3.0          jsonlite_2.0.0
#> [13] DBI_1.2.3           BiocManager_1.30.27 httr_1.4.7
#> [16] purrr_1.2.1         Biostrings_2.78.0   jquerylib_0.1.4
#> [19] cli_3.6.5           crayon_1.5.3        rlang_1.1.7
#> [22] XVector_0.50.0      bit64_4.6.0-1       withr_3.0.2
#> [25] cachem_1.1.0        yaml_2.3.12         otel_0.2.0
#> [28] tools_4.5.2         memoise_2.0.1       dplyr_1.1.4
#> [31] assertthat_0.2.1    vctrs_0.6.5         R6_2.6.1
#> [34] png_0.1-8           matrixStats_1.5.0   lifecycle_1.0.5
#> [37] Seqinfo_1.0.0       KEGGREST_1.50.0     bit_4.6.0
#> [40] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
#> [43] glue_1.8.0          xfun_0.55           tidyselect_1.2.1
#> [46] knitr_1.51          htmltools_0.5.9     rmarkdown_2.30
#> [49] compiler_4.5.2
```