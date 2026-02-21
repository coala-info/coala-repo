# User Guide

Søren Helweg Dam

#### Last updated: 2025.10.30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Interoperability with IsoformSwitchAnalyzeR](#interoperability-with-isoformswitchanalyzer)
* [4 Paired differential expression and splicing](#paired-differential-expression-and-splicing)
  + [4.1 Preparing the experiment parameters](#preparing-the-experiment-parameters)
  + [4.2 Check your metadata](#check-your-metadata)
  + [4.3 Running the analysis](#running-the-analysis)
  + [4.4 Additional parameters](#additional-parameters)
* [5 Over-Representation Analysis](#over-representation-analysis)
  + [5.1 Additional parameters](#additional-parameters-1)
* [6 Analysing ORA results](#analysing-ora-results)
  + [6.1 Scatter plot of enrichment scores](#scatter-plot-of-enrichment-scores)
* [7 Session Info](#session-info)
* [References](#references)

# 1 Introduction

`pariedGSEA` is a user-friendly framework for paired differential gene
expression and splicing analyses.
Providing bulk RNA-seq count data, `pariedGSEA` combines the results of
*[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* (Love, Huber, and Anders [2014](#ref-deseq2)) and
*[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* (Anders, Reyes, and Huber [2012](#ref-dexseq)), aggregates the p-values to
gene level and allows
you to run a subsequent gene set over-representation analysis using
*[fgsea](https://bioconductor.org/packages/3.22/fgsea)*’s `fora` function (Korotkevich, Sukhov, and Sergushichev [2019](#ref-fgsea)).
Since version 0.99.2, you can also do the differential analyses using
*[limma](https://bioconductor.org/packages/3.22/limma)* .

`pairedGSEA` was developed to highlight the importance of differential
splicing analysis. It was build in a way that yields comparable results between
splicing and expression-related events. It, by default, accounts for
surrogate variables in the data, and facilitates exploratory data analysis
either through storing intermediate results or through plotting functions
for the over-representation analysis.

This vignette will guide you through how to use the main functions of
`pairedGSEA`.

`pariedGSEA` assumes you have already preprocessed and aligned your sequencing
reads to transcript level.
Before starting, you should therefore have a counts matrix and a metadata file.
This data may also be in the format of a
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* (Morgan et al. [2022](#ref-se)) or
`DESeqDataSet`.
*Importantly*, please ensure that the rownames have the format:
`gene:transcript`.

The metadata should, as a minimum, contain the `sample IDs` corresponding to
the column names of the count matrix, a `group` column containing information
on which samples corresponds to the baseline (controls) and
the case (condition). Bear in mind, the column names can be as you wish,
but the names must be provided in the `sample_col` and `group_col` parameters,
respectively.

To see an example of what such data could look like,
please see `?pairedGSEA::example_se`.

# 2 Installation

To install this package, start R (version “4.3”) and enter:

Bioconductor dependencies

```
# Install Bioconductor dependencies
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c(
    "SummarizedExperiment", "S4Vectors", "DESeq2", "DEXSeq",
    "fgsea", "sva", "BiocParallel"))
```

Install `pairedGSEA` from Bioconductor

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pairedGSEA")
```

Install development version from [GitHub](https://github.com/shdam/pairedGSEA)

```
# Install pairedGSEA from github
devtools::install_github("shdam/pairedGSEA", build_vignettes = TRUE)
```

# 3 Interoperability with IsoformSwitchAnalyzeR

[IsoformSwitchAnalyzeR](https://github.com/kvittingseerup/IsoformSwitchAnalyzeR) identifies, annotates, and visualizes Isoform Switches with Functional Consequences (from RNA-seq data).

Import and export between the packages with:

* **`IsoformSwitchAnalyzeR::importPairedGSEA()`**
* **`IsoformSwitchAnalyzeR::exportToPairedGSEA()`**

# 4 Paired differential expression and splicing

## 4.1 Preparing the experiment parameters

Running a paired Differential Gene Expression (DGE) and
Differential Gene Splicing (DGS) analysis is the first step in
the `pairedGSEA` workflow.

But before running the `paired_diff` function, we recommend storing
the experiment parameters in a set of variables at the top of your script
for future reference and easy access:

```
library("pairedGSEA")

# Defining plotting theme
ggplot2::theme_set(ggplot2::theme_classic(base_size = 20))

## Load data
# In this vignette we will use the included example Summarized Experiment.
# See ?example_se for more information about the data.
data("example_se")

if(FALSE){ # Examples of other data imports
    # Example of count matrix
    tx_count <- read.csv("path/to/counts.csv") # Or other load function
    md_file <- "path/to/metadata.xlsx" # Can also be a .csv file or a data.frame

    # Example of locally stored DESeqDataSet
    dds <- readRDS("path/to/dds.RDS")

    # Example of locally stored SummarizedExperiment
    se <- readRDS("path/to/se.RDS")
}

## Experiment parameters
group_col <- "group_nr" # Column with the groups you would like to compare
sample_col <- "id" # Name of column that specifies the sample id of each sample.
# This is used to ensure the metadata and count data contains the same samples
# and to arrange the data according to the metadata
# (important for underlying tools)
baseline <- 1 # Name of baseline group
case <- 2 # Name of case group
experiment_title <- "TGFb treatment for 12h" # Name of your experiment. This is
# used in the file names that are stored if store_results is TRUE (recommended)
```

## 4.2 Check your metadata

```
# Check if parameters above fit with metadaata
SummarizedExperiment::colData(example_se)
#> DataFrame with 6 rows and 5 columns
#>                  study          id                 source final_description
#>            <character> <character>            <character>       <character>
#> GSM1499784    GSE61220  GSM1499784 small airway epithel..       Epi,Control
#> GSM1499785    GSE61220  GSM1499785 small airway epithel..       Epi,Control
#> GSM1499786    GSE61220  GSM1499786 small airway epithel..       Epi,Control
#> GSM1499790    GSE61220  GSM1499790 small airway epithel..      Epi,TNF,12hr
#> GSM1499791    GSE61220  GSM1499791 small airway epithel..      Epi,TNF,12hr
#> GSM1499792    GSE61220  GSM1499792 small airway epithel..      Epi,TNF,12hr
#>            group_nr
#>            <factor>
#> GSM1499784        1
#> GSM1499785        1
#> GSM1499786        1
#> GSM1499790        2
#> GSM1499791        2
#> GSM1499792        2
```

```
# Check that all data samples are in the metadata
all(colnames(example_se) %in%
        SummarizedExperiment::colData(example_se)[[sample_col]])
#> [1] TRUE
```

## 4.3 Running the analysis

The paired DGE/DGS analysis is run with `paired_diff()`.
`paired_diff()` is essentially a wrapper function around
`DESeq2::DESeq` (Love, Huber, and Anders [2014](#ref-deseq2)) and `DEXSeq::DEXSeq` (Anders, Reyes, and Huber [2012](#ref-dexseq)), the latter takes in
the ballpark of 20-30 minutes to run depending on the size of the data
and computational resources. Please visit their individual vignettes
for further information.

```
set.seed(500) # For reproducible results

diff_results <- paired_diff(
    object = example_se,
    metadata = NULL, # Use with count matrix or if you want to change it in
    # the input object
    group_col = group_col,
    sample_col = sample_col,
    baseline = baseline,
    case = case,
    experiment_title = experiment_title,
    store_results = FALSE # Set to TRUE (recommended)  if you want
    # to store intermediate results, such as the results on transcript level
    )
#> Running TGFb treatment for 12h
#> Preparing metadata
#>
#> Removing 0 rows with a summed count lower than 10
#> Removing 108 rows with counts in less than 2 samples.
#> Running SVA
#> No significant surrogate variables
#>
#> Found 0 surrogate variables
#> Running DESeq2
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing
#> Extracting results
#> Initiating DEXSeq
#> Creating DEXSeqDataSet
#> converting counts to integer mode
#> Warning in DESeqDataSet(rse, design, ignoreRank = TRUE): some variables in
#> design formula are characters, converting to factors
#>
#> Running DEXSeq -- This might take a while
#> TGFb treatment for 12h is analysed.
#> Aggregating p values
#> Done.
```

After running the analyses, `paired_diff` will aggregate the p-values to
gene level using lancaster *[aggregation](https://CRAN.R-project.org/package%3Daggregation)*
(Lancaster [1961](#ref-lancaster)) and calculate
the FDR-adjusted p-values (see `?pairedGSEA:::aggregate_pvalue`
for more information).
For the DGE transcripts, the log2 fold changes will be aggregated
using a weighted mean, whereas the DGS log2 fold changes will be
assigned to the log2 fold change of the transcript with the lowest p-value.
Use the latter with a grain of salt.

From here, feel free to analyse the gene-level results using your
preferred method.
If you set `store_results = TRUE`, you could extract the transcript
level results found in the `results` folder under the names
"\*\_expression\_results.RDS"
and "\*\_splicing\_results.RDS" for the DGE and DGS analysis, respectively
(The \* corresponds to the provided experiment title).

## 4.4 Additional parameters

There are a range of other parameters you can play with to tailor
the experience. Here, the default settings are showed.
See `?pairedGSEA::paired_diff` for further details.

```
covariates = NULL,
run_sva = TRUE,
use_limma = FALSE,
prefilter = 10,
fit_type = "local",
test = "LRT",
quiet = FALSE,
parallel = TRUE,
BPPARAM = BiocParallel::bpparam(),
...
```

To highlight some examples of use:

1. You can use `limma::eBayes` and `limma::diffSplice` for the analyses with
   `use_limma = TRUE`.
2. You can use additional columns in your metadata as covariates in the
   model matrix by setting `covariates` to a character vector of the
   specific names. This will be used in SVA, DGE, and DGS.
3. The test should be kept at default settings, but advanced users may use
   the “wald” test instead, if they wish.
4. The `...` parameters will be fed to `DESeq2::DESeq`,
   see their manual for options.
5. If you want a stricter, more loose, or more advanced pre-filtering
   (generally not necessary, as *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*
   and *[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* performs their own
   pre-filtering), you can set the parameter to a different value or NULL and
   use your own pre-filtering method directly on the counts matrix.

# 5 Over-Representation Analysis

`pairedGSEA` comes with a wrapper function for `fgsea::fora` (Korotkevich, Sukhov, and Sergushichev [2019](#ref-fgsea)).
If you wish,
feel free to use that directly or any other gene set analysis method
- investigate the `diff_results` object before use to see what
information it contains.

The inbuilt wrapper also computes the relative risk for each gene set and an
enrichment score (`log2(relative_risk + 0.06)`, the pseudo count is
for plotting purposes).

### 5.0.1 Running the inbuilt ORA function

Before you get going, you will need a list of gene sets (aka. pathways)
according to the species you are working with and the category of
gene sets of interest.
For this purpose, feel free to use the *[msigdbr](https://CRAN.R-project.org/package%3Dmsigdbr)*
(Dolgalev [2022](#ref-msigdbr)) wrapper function in
`pairedGSEA`: `pairedGSEA::prepare_msigdb`. If you do,
see `?pairedGSEA::prepare_msigdb` for further details.

The inbuilt ORA function is called `paired_ora` and is run as follows

```
# Define gene sets in your preferred way
gene_sets <- pairedGSEA::prepare_msigdb(
    species = "Homo sapiens",
    collection = "C5",
    gene_id_type = "ensembl_gene"
    )

ora <- paired_ora(
    paired_diff_result = diff_results,
    gene_sets = gene_sets,
    experiment_title = NULL # experiment_title - if not NULL,
    # the results will be stored in an RDS object in the 'results' folder
    )
#> Running over-representation analyses
#> Joining result
```

## 5.1 Additional parameters

```
cutoff = 0.05,
min_size = 25,
quiet = FALSE
```

Please investigate the returned object to see the column names and what
they contain.

# 6 Analysing ORA results

There are many options for investigating your ORA results.
`pairedGSEA` comes with an inbuilt scatter plot function that plots the
enrichment score of DGE against those of DGS.

The function allows you to interactively look at the placement of the
significant pathways using *[plotly](https://CRAN.R-project.org/package%3Dplotly)* (Sievert [2020](#ref-plotly)).
You can color specific points
based on a regular expression for gene sets of interest.

## 6.1 Scatter plot of enrichment scores

```
# Scatter plot function with default settings
plot_ora(
    ora,
    paired = FALSE,
    plotly = FALSE,
    pattern = "Telomer", # Identify all gene sets about telomeres
    cutoff = 0.05, # Only include significant gene sets
    lines = TRUE # Guide lines
    )
```

![](data:image/png;base64...)

As mentioned, this function can be utilized in a few different ways.
The default settings will plot the enrichment scores of each analysis
and draw dashed lines for the `y = x` line, `y = 0`, and `x = 0`.
Remove those by setting `lines = FALSE`.

Make the plot interactive with `plotly = TRUE`.

Highlight gene sets containing a specific regex pattern
by setting `pattern` to the regex pattern of interest.

# 7 Session Info

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
#> [1] pairedGSEA_1.10.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                   bitops_1.0-9
#>   [3] httr2_1.2.1                 biomaRt_2.66.0
#>   [5] rlang_1.1.6                 magrittr_2.0.4
#>   [7] aggregation_1.0.1           msigdbr_25.1.1
#>   [9] matrixStats_1.5.0           compiler_4.5.1
#>  [11] RSQLite_2.4.3               mgcv_1.9-3
#>  [13] png_0.1-8                   vctrs_0.6.5
#>  [15] sva_3.58.0                  sysfonts_0.8.9
#>  [17] stringr_1.5.2               pkgconfig_2.0.3
#>  [19] crayon_1.5.3                fastmap_1.2.0
#>  [21] magick_2.9.0                dbplyr_2.5.1
#>  [23] XVector_0.50.0              labeling_0.4.3
#>  [25] Rsamtools_2.26.0            rmarkdown_2.30
#>  [27] tinytex_0.57                bit_4.6.0
#>  [29] xfun_0.53                   showtext_0.9-7
#>  [31] cachem_1.1.0                jsonlite_2.0.0
#>  [33] progress_1.2.3              blob_1.2.4
#>  [35] DelayedArray_0.36.0         BiocParallel_1.44.0
#>  [37] parallel_4.5.1              prettyunits_1.2.0
#>  [39] R6_2.6.1                    bslib_0.9.0
#>  [41] stringi_1.8.7               RColorBrewer_1.1-3
#>  [43] limma_3.66.0                genefilter_1.92.0
#>  [45] GenomicRanges_1.62.0        jquerylib_0.1.4
#>  [47] Rcpp_1.1.0                  Seqinfo_1.0.0
#>  [49] bookdown_0.45               assertthat_0.2.1
#>  [51] SummarizedExperiment_1.40.0 knitr_1.50
#>  [53] IRanges_2.44.0              Matrix_1.7-4
#>  [55] splines_4.5.1               tidyselect_1.2.1
#>  [57] dichromat_2.0-0.1           abind_1.4-8
#>  [59] yaml_2.3.10                 codetools_0.2-20
#>  [61] hwriter_1.3.2.1             curl_7.0.0
#>  [63] lattice_0.22-7              tibble_3.3.0
#>  [65] withr_3.0.2                 Biobase_2.70.0
#>  [67] KEGGREST_1.50.0             S7_0.2.0
#>  [69] evaluate_1.0.5              survival_3.8-3
#>  [71] BiocFileCache_3.0.0         Biostrings_2.78.0
#>  [73] pillar_1.11.1               BiocManager_1.30.26
#>  [75] filelock_1.0.3              MatrixGenerics_1.22.0
#>  [77] stats4_4.5.1                generics_0.1.4
#>  [79] S4Vectors_0.48.0            hms_1.1.4
#>  [81] ggplot2_4.0.0               scales_1.4.0
#>  [83] xtable_1.8-4                glue_1.8.0
#>  [85] tools_4.5.1                 data.table_1.17.8
#>  [87] fgsea_1.36.0                annotate_1.88.0
#>  [89] locfit_1.5-9.12             babelgene_22.9
#>  [91] XML_3.99-0.19               fastmatch_1.1-6
#>  [93] cowplot_1.2.0               grid_4.5.1
#>  [95] DEXSeq_1.56.0               edgeR_4.8.0
#>  [97] AnnotationDbi_1.72.0        nlme_3.1-168
#>  [99] showtextdb_3.0              cli_3.6.5
#> [101] rappdirs_0.3.3              S4Arrays_1.10.0
#> [103] dplyr_1.1.4                 gtable_0.3.6
#> [105] DESeq2_1.50.0               sass_0.4.10
#> [107] digest_0.6.37               BiocGenerics_0.56.0
#> [109] SparseArray_1.10.0          geneplotter_1.88.0
#> [111] farver_2.1.2                memoise_2.0.1
#> [113] htmltools_0.5.8.1           lifecycle_1.0.4
#> [115] httr_1.4.7                  statmod_1.5.1
#> [117] bit64_4.6.0-1
```

# References

Anders, Simon, Alejandro Reyes, and Wolfgang Huber. 2012. “Detecting Differential Usage of Exons from Rna-Seq Data.” *Genome Research* 22 (10): 2008–17. <https://doi.org/10.1101/gr.133744.111>.

Dolgalev, Igor. 2022. *Msigdbr: MSigDB Gene Sets for Multiple Organisms in a Tidy Data Format*. [https://CRAN.R-project.org/package=msigdbr](https://CRAN.R-project.org/package%3Dmsigdbr).

Korotkevich, Gennady, Vladimir Sukhov, and Alexey Sergushichev. 2019. “Fast Gene Set Enrichment Analysis.” *bioRxiv*. <https://doi.org/10.1101/060012>.

Lancaster, H. O. 1961. “THE Combination of Probabilities: AN Application of Orthonormal Functions.” *Australian Journal of Statistics* 3 (1): 20–33. [https://doi.org/https://doi.org/10.1111/j.1467-842X.1961.tb00058.x](https://doi.org/https%3A//doi.org/10.1111/j.1467-842X.1961.tb00058.x).

Love, Michael I., Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2022. *SummarizedExperiment: SummarizedExperiment Container*. <https://bioconductor.org/packages/SummarizedExperiment>.

Sievert, Carson. 2020. *Interactive Web-Based Data Visualization with R, Plotly, and Shiny*. Chapman; Hall/CRC. <https://plotly-r.com>.