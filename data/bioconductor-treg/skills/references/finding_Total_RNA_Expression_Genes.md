# How to find Total RNA Expression Genes (TREGs)

Louise A. Huuki-Myers1\* and Leonardo Collado-Torres1\*\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus

\*lahuuki@gmail.com
\*\*lcolladotor@gmail.com

#### 30 October 2025

#### Package

TREG 1.14.0

# Contents

* [1 Basics](#basics)
  + [1.1 Install `TREG`](#install-treg)
  + [1.2 Required knowledge](#required-knowledge)
  + [1.3 Asking for help](#asking-for-help)
  + [1.4 Citing `TREG`](#citing-treg)
* [2 Overview](#overview)
  + [2.1 Why are TREGs useful?](#why-are-tregs-useful)
  + [2.2 What makes a gene a good TREG?](#what-makes-a-gene-a-good-treg)
  + [2.3 How to find candidate TREGs with `TREG`](#how-to-find-candidate-tregs-with-treg)
* [3 Example TREG Application](#example-treg-application)
  + [3.1 Load Packages](#load-packages)
  + [3.2 Download and Prep Data](#download-and-prep-data)
    - [3.2.1 Filter and Refine to Cell Types of Interest](#filter-and-refine-to-cell-types-of-interest)
  + [3.3 Filter Genes](#filter-genes)
    - [3.3.1 Filter to Top 50% Expression](#filter-to-top-50-expression)
    - [3.3.2 Calculate Proportion Zero and Pick Cutoff](#calculate-proportion-zero-and-pick-cutoff)
    - [3.3.3 Filter by the Max Proportion Zero](#filter-by-the-max-proportion-zero)
  + [3.4 Run Rank Invariance](#run-rank-invariance)
* [4 Selecting thresholds](#selecting-thresholds)
* [5 Conclusion](#conclusion)
* [6 Reproducibility](#reproducibility)
* [7 Bibliography](#bibliography)

***Note**: TREG is pronounced as a single word and fully capitalized, unlike [Regulatory T cells](https://en.wikipedia.org/wiki/Regulatory_T_cell), which are known as “Tregs” (pronounced “T-regs”). The work described here is unrelated to regulatory T cells.*

# 1 Basics

## 1.1 Install `TREG`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[TREG](https://bioconductor.org/packages/3.22/TREG)* is a `R` package available via Bioconductor. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[TREG](https://bioconductor.org/packages/3.22/TREG)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("TREG")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[TREG](https://bioconductor.org/packages/3.22/TREG)* (Huuki-Myers and Collado-Torres, 2025) is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with single cell RNA sequencing data, visualization functions, and interactive data exploration. That is, packages like *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* that allow you to store the data.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help regarding Bioconductor. Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `TREG`

We hope that *[TREG](https://bioconductor.org/packages/3.22/TREG)* will be useful for your research. Please use the following information to cite the package and the research article describing the data provided by *[TREG](https://bioconductor.org/packages/3.22/TREG)*. Thank you!

```
## Citation info
citation("TREG")
#> To cite package 'TREG' in publications use:
#>
#>   Huuki-Myers LA, Collado-Torres L (2025). _TREG: a R/Bioconductor
#>   package to identify Total RNA Expression Genes_.
#>   doi:10.18129/B9.bioc.TREG <https://doi.org/10.18129/B9.bioc.TREG>,
#>   https://github.com/LieberInstitute/TREG/TREG - R package version
#>   1.14.0, <http://www.bioconductor.org/packages/TREG>.
#>
#>   Huuki-Myers LA, Montgomery KD, Kwon SH, Page SC, Hicks SC, Maynard
#>   KR, Collado-Torres L (2022). "Data Driven Identification of Total RNA
#>   Expression Genes "TREGs" for estimation of RNA abundance in
#>   heterogeneous cell types." _bioRxiv_. doi:10.1101/2022.04.28.489923
#>   <https://doi.org/10.1101/2022.04.28.489923>,
#>   <https://doi.org/10.1101/2022.04.28.489923>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 Overview

The *[TREG](https://bioconductor.org/packages/3.22/TREG)* (Huuki-Myers and Collado-Torres, 2025) package was developed for identifying candidate **Total RNA Expression Genes (TREGs)** for estimating RNA abundance for individual cells in an snFISH experiment by researchers at the Lieber Institute for Brain Development (LIBD) (Huuki-Myers, Montgomery, Kwon, Page, Hicks, Maynard, and Collado-Torres, 2022).

In this vignette we’ll showcase how you can use the R functions provided by *[TREG](https://bioconductor.org/packages/3.22/TREG)* (Huuki-Myers and Collado-Torres, 2025) with the snRNA-seq dataset that was recently published by our LIBD collaborators (Tran, Maynard, Spangler, Huuki, Montgomery, Sadashivaiah, Tippani, Barry, Hancock, Hicks, Kleinman, Hyde, Collado-Torres, Jaffe, and Martinowich, 2021).

To get started, please load the *[TREG](https://bioconductor.org/packages/3.22/TREG)* package.

```
library("TREG")
```

The goal of `TREG` is to help find candidate **Total RNA Expression Genes (TREGs)**
in single nucleus (or single cell) RNA-seq data.

## 2.1 Why are TREGs useful?

The expression of a TREG is proportional to the the overall RNA expression in a
cell. This relationship can be used to estimate total RNA content in cells in
assays where only a few genes can be measured, such as single-molecule
fluorescent in situ hybridization (smFISH).

In a smFISH experiment the number of TREG puncta can be used to infer the total
RNA expression of the cell.

The motivation of this work is to collect data via smFISH in to help build better
deconvolution algorithms. But may be many other application for TREGs in
experimental design!

![The Expression of a TREG can inform total RNA content of a cell](data:image/png;base64... "fig:")

## 2.2 What makes a gene a good TREG?

1. The gene must have **non-zero expression in most cells** across different tissue
   and cell types.
2. A TREG should also be expressed at a constant level in respect to other genes
   across different cell types or have **high rank invariance**.
3. Be **measurable as a continuous metric** in the experimental assay, for example
   have a dynamic range of puncta when observed in RNAscope. This will need to be
   considered for the candidate TREGs, and may need to be validated experimentally.

![Distribution of ranks of a gene of High and Low Invariance](data:image/png;base64... "fig:")

## 2.3 How to find candidate TREGs with `TREG`

![Overview of the Rank Invariance Process](data:image/png;base64... "fig:")

1. **Filter for low Proportion Zero genes snRNA-seq dataset:** This is
   facilitated with the functions `get_prop_zero()` and `filter_prop_zero()` (Equation [(1)](#eq:propZero)).
   snRNA-seq data is notoriously sparse, these functions enrich for genes with more
   universal expression.
2. **Evaluate genes for Rank Invariance** The nuclei are grouped only
   by cell type. Within each cell type, the mean expression for each
   gene is ranked, the result is a vector (length is the number of
   genes), using the function `rank_group()`. Then the expression of each gene is
   ranked for each nucleus,the result is a matrix (the number of nuclei x number
   of genes), using the function `rank_cells()`.Then the absolute difference
   between the rank of each nucleus and the mean expression is found, from here
   the mean of the differences for each gene is calculated, then ranked.
   These steps are repeated for each group, the result is a matrix of ranks, (number of cell
   types x number of genes). From here the sum of the ranks for each
   gene are reversed ranked, so there is one final value for each gene,
   the “Rank Invariance” The genes with the highest rank-invariance are
   considered good candidates as TREGs. This is calculated with `rank_invariance_express()`.
   **This full process is implemented by: `rank_invariance_express()`.**

# 3 Example TREG Application

In this example we will apply our data driven process for TREG discovery to a
snRNA-seq dataset. This process has three main steps:

## 3.1 Load Packages

```
library("SingleCellExperiment")
library("pheatmap")
library("dplyr")
library("ggplot2")
library("tidyr")
library("tibble")
```

## 3.2 Download and Prep Data

Here we download a public single nucleus RNA-seq (snRNA-seq) data from (Tran, Maynard, Spangler et al., 2021)
that we’ll use as our example. This data can be accessed on [github](https://github.com/LieberInstitute/10xPilot_snRNAseq-human#processed-data).
This data is from postmortem human brain in the dorsolateral prefrontal
cortex (DLPFC) region, and contains gene expression data for 11k nuclei.

We will use `BiocFileCache()` to cache this data. It is stored as a `SingleCellExperiment`
object named `sce.dlpfc.tran`, and takes 1.01 GB of RAM memory to load.

```
# Download and save a local cache of the data available at:
# https://github.com/LieberInstitute/10xPilot_snRNAseq-human#processed-data
bfc <- BiocFileCache::BiocFileCache()
url <- paste0(
    "https://libd-snrnaseq-pilot.s3.us-east-2.amazonaws.com/",
    "SCE_DLPFC-n3_tran-etal.rda"
)
local_data <- BiocFileCache::bfcrpath(url, x = bfc)

load(local_data, verbose = TRUE)
#> Loading objects:
#>   sce.dlpfc.tran
```

Table 1: Cell type names and corresponding acronyms used in this dataset

| Cell Type | Acronym |
| --- | --- |
| Astrocyte | Astro |
| Excitatory Neurons | Excit |
| Microglia | Micro |
| Oligodendrocytes | Oligo |
| Oligodendrocyte Progenitor Cells | OPC |
| Inhibitory Neurons | Inhib |

Human brain tissue consists of many types of cells, for the porpose of this demo,
we will focus on the six major cell types listed in Table [1](#tab:acronyms).

### 3.2.1 Filter and Refine to Cell Types of Interest

First we will combine all of the Excit, Inhib subtypes, as it is a finer
resolution than we want to examine, and combine rare subtypes in to one group.
If there are too few cells in a group there may not be enough data to
get good results. This new cell type classification is stored in the `colData` as
`cellType.broad`.

```
## Explore the dimensions and cell type annotations
dim(sce.dlpfc.tran)
#> [1] 33538 11202
table(sce.dlpfc.tran$cellType)
#>
#>      Astro    Excit_A    Excit_B    Excit_C    Excit_D    Excit_E    Excit_F
#>        782        529        773        524        132        187        243
#>    Inhib_A    Inhib_B    Inhib_C    Inhib_D    Inhib_E    Inhib_F Macrophage
#>        333        454        365        413          7          8         10
#>      Micro      Mural      Oligo        OPC      Tcell
#>        388         18       5455        572          9

## Use a lower resolution of cell type annotation
sce.dlpfc.tran$cellType.broad <- gsub("_[A-Z]$", "", sce.dlpfc.tran$cellType)
(cell_type_tab <- table(sce.dlpfc.tran$cellType.broad))
#>
#>      Astro      Excit      Inhib Macrophage      Micro      Mural        OPC
#>        782       2388       1580         10        388         18        572
#>      Oligo      Tcell
#>       5455          9
```

Next, we will drop any groups with < 50 cells after merging subtypes.
This excludes any very rare cell types. Now we are working with the six broad cell
types we are interested in.

```
## Find cell types with < 50 cells
(ct_drop <- names(cell_type_tab)[cell_type_tab < 50])
#> [1] "Macrophage" "Mural"      "Tcell"

## Filter columns of sce object
sce.dlpfc.tran <- sce.dlpfc.tran[, !sce.dlpfc.tran$cellType.broad %in% ct_drop]

## Check new cell type bread down and dimension
table(sce.dlpfc.tran$cellType.broad)
#>
#> Astro Excit Inhib Micro   OPC Oligo
#>   782  2388  1580   388   572  5455

dim(sce.dlpfc.tran)
#> [1] 33538 11165
```

## 3.3 Filter Genes

Single Nucleus data is often very sparse (lots of zeros in the count data), this
dataset is 88% sparse. We can illustrate this in the heat map of the first 1k
genes and 500 cells. The heatmap is mostly blue, indicating low values
(Figure [1](#fig:examineSparsity)).

```
## this data is 88% sparse
sum(assays(sce.dlpfc.tran)$counts == 0) / (nrow(sce.dlpfc.tran) * ncol(sce.dlpfc.tran))
#> [1] 0.8839022

## lets make a heatmap of the first 1k genes and 500 cells
count_test <- as.matrix(assays(sce.dlpfc.tran)$logcounts[seq_len(1000), seq_len(500)])
pheatmap(count_test,
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = FALSE,
    show_colnames = FALSE
)
```

![Heatmap of the snRNA-seq counts. Illustrates sparseness of unfiltered data.](data:image/png;base64...)

Figure 1: Heatmap of the snRNA-seq counts
Illustrates sparseness of unfiltered data.

### 3.3.1 Filter to Top 50% Expression

Determine the median expression of genes over all rows, drop all the genes that
are below this limit.

```
row_means <- rowMeans(assays(sce.dlpfc.tran)$logcounts)
(median_row_means <- median(row_means))
#> [1] 0.01405562

sce.dlpfc.tran <- sce.dlpfc.tran[row_means > median_row_means, ]
dim(sce.dlpfc.tran)
#> [1] 16769 11165
```

After this filter lets check sparsity and make a heatmap of the first 1k genes
and 500 cells. We are seeing more non-blue (Figure [2](#fig:top50FilterHeatmap))!

```
## this data down to 77% sparse
sum(assays(sce.dlpfc.tran)$counts == 0) / (nrow(sce.dlpfc.tran) * ncol(sce.dlpfc.tran))
#> [1] 0.7713423

## replot heatmap
count_test <- as.matrix(assays(sce.dlpfc.tran)$logcounts[seq_len(1000), seq_len(500)])
pheatmap::pheatmap(count_test,
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = FALSE,
    show_colnames = FALSE
)
```

![Heatmap of the snRNA-seq counts. With top 50% filtering the data becomes less sparse.](data:image/png;base64...)

Figure 2: Heatmap of the snRNA-seq counts
With top 50% filtering the data becomes less sparse.

### 3.3.2 Calculate Proportion Zero and Pick Cutoff

For each group (let’s use `cellType.broad`) get the Proportion Zero for each gene, where Proportion Zero is defined in Equation [(1)](#eq:propZero) where \(c\_{i,j,k,z}\) is the number of snRNA-seq counts for cell/nucleus \(z\) for gene \(i\), cell type \(j\), brain region \(k\), and \(n\_{j, k}\) is the number of cells/nuclei for cell type \(j\) and brain region \(k\).

\[\begin{equation}
PZ\_{i,j,k} = \sum\_{z=1}^{n\_{j,k}} I(c\_{i,j,k} > 0) / n\_{j,k}
\tag{1}
\end{equation}\]

```
# get prop zero for each gene for each cell type
prop_zeros <- get_prop_zero(sce.dlpfc.tran, group_col = "cellType.broad")
head(prop_zeros)
#>                Astro     Excit     Inhib     Micro       OPC     Oligo
#> AL627309.1 0.9667519 0.7784757 0.8487342 0.9536082 0.9685315 0.9552704
#> AL669831.5 0.8836317 0.2361809 0.4879747 0.8608247 0.7657343 0.8445463
#> LINC00115  0.9948849 0.9493300 0.9759494 0.9845361 0.9930070 0.9891842
#> NOC2L      0.9347826 0.6168342 0.7556962 0.9536082 0.8811189 0.9365720
#> KLHL17     0.9859335 0.8986600 0.9360759 0.9922680 0.9877622 0.9963336
#> HES4       0.8695652 0.7357621 0.6892405 0.9974227 0.9737762 0.9906508
```

To determine a good cutoff for filtering lets examine the distribution of these
Proportion Zeros by group.

```
# Pivot data longer for plotting
prop_zero_long <- prop_zeros %>%
    rownames_to_column("Gene") %>%
    pivot_longer(!Gene, names_to = "Group", values_to = "prop_zero")

# Plot histograms
(prop_zero_histogram <- ggplot(
    data = prop_zero_long,
    aes(x = prop_zero, fill = Group)
) +
    geom_histogram(binwidth = 0.05) +
    facet_wrap(~Group))
```

![Distribution of Proption Zero across cell types and regions.](data:image/png;base64...)

Figure 3: Distribution of Proption Zero across cell types and regions

Looks like around 0.9 the densities peak, we’ll set that as the cutoff (Figure [3](#fig:propZeroDistribution)).

```
## Specify a cutoff, here we use 0.9
propZero_limit <- 0.9

## Add a vertical red dashed line where the cutoff is located
prop_zero_histogram +
    geom_vline(xintercept = propZero_limit, color = "red", linetype = "dashed")
```

![Show Proportion Zero Cutoff on Distributions.](data:image/png;base64...)

Figure 4: Show Proportion Zero Cutoff on Distributions

The chosen cutoff excludes the peak Proportion Zeros from all groups (Figure [4](#fig:pickCutoff)).

### 3.3.3 Filter by the Max Proportion Zero

Use the cutoff to filter the remaining genes. Only 4k or ~11% of genes pass with
this cutoff. Filter the SCE object to this set of genes.

```
## get a list of filtered genes
filtered_genes <- filter_prop_zero(prop_zeros, cutoff = propZero_limit)

## How many genes pass the filter?
length(filtered_genes)
#> [1] 4005

## What % of genes is this
length(filtered_genes) / nrow(sce.dlpfc.tran)
#> [1] 0.2388336

## Filter the sce object
sce.dlpfc.tran <- sce.dlpfc.tran[filtered_genes, ]
```

One last check of the sparsity, more non-blue means more non-zero values for the Rank Invariance calculation,
which prevents rank ties (Figure [5](#fig:propZeroFilterHeatmap)).

```
## this data down to 50% sparse
sum(assays(sce.dlpfc.tran)$counts == 0) / (nrow(sce.dlpfc.tran) * ncol(sce.dlpfc.tran))
#> [1] 0.5010587

## re-plot heatmap
count_test <- as.matrix(assays(sce.dlpfc.tran)$logcounts[seq_len(1000), seq_len(500)])
pheatmap::pheatmap(count_test,
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = FALSE,
    show_colnames = FALSE
)
```

![Heatmap of the snRNA-seq counts after Proption Zero filtering.](data:image/png;base64...)

Figure 5: Heatmap of the snRNA-seq counts after Proption Zero filtering

## 3.4 Run Rank Invariance

To get the Rank Invariance (RI), the rank of the genes across the cells in a group,
and between groups is considered. One way to calculate RI is to find the group
rank values, and cell rank values separately, then combine them as shown below.
The genes with the top RI values are the best candidate TREGs.

```
## Get the rank of the gene in each group
group_rank <- rank_group(sce.dlpfc.tran, group_col = "cellType.broad")

## Get the rank of the gene for each cell
cell_rank <- rank_cells(sce.dlpfc.tran, group_col = "cellType.broad")

## Use both rankings to calculate rank_invariance()
rank_invar <- rank_invariance(group_rank, cell_rank)

## The top 5 Candidate TREGs:
head(sort(rank_invar, decreasing = TRUE))
#>  MALAT1  CTNND2     FTX    RERE FAM155A    GNAQ
#>    4005    4004    4003    4002    4001    4000
```

The `rank_invariance_express()` function combines these three steps into one
function, and achieves the same results.

```
## rank_invariance_express() runs the previous functions for you
rank_invar2 <- rank_invariance_express(
    sce.dlpfc.tran,
    group_col = "cellType.broad"
)
## Again the top 5 Candidate TREGs:
head(sort(rank_invar2, decreasing = TRUE))
#>  MALAT1  CTNND2     FTX    RERE FAM155A    GNAQ
#>    4005    4004    4003    4002    4001    4000

## Check computationally that the results are identical
stopifnot(identical(rank_invar, rank_invar2))
```

The `rank_invariance_express()` function is more efficient as well, as it loops
through the data to rank the genes over cells, and groups at the same time.

# 4 Selecting thresholds

When identifying candidate TREGs with our software, there are a few thresholds users will select. In our manuscript (Huuki-Myers, Montgomery, Kwon et al., 2022), we used a few filters.

1. We focused on genes among the top 50% of genes expressed in the snRNA-seq data. This helped address sparsity inherent to snRNA-seq data.
2. We used a maximum Proportion Zero filter of 75%.

Overall it’s a balancing act between the computational requirements (reduce sparsity inherent to snRNA-seq data, reduce expression rank ties) and the biological goal (select a gene expressed in most nuclei from all cell types of interest). If you focus on just genes expressed in all nuclei or above a given threshold as shown in this [figure](https://github.com/LieberInstitute/TREG_paper/blob/master/plots/05_perc_expressed/genes_percent_expressed.pdf), you could be losing too many genes (likely no gene is expressed in all nuclei as [shown in our data](https://github.com/LieberInstitute/TREG_paper/blob/0cdf9fbfbd691764a62f9f0fe8d4a0e31d326d04/code/05_perc_expressed/01_check_for_reviewer.R#L26)) or genes that are not expressed at all in some cell types, given that some cell types are much less frequent than other cell types. While we consider the thresholds we used as those that balance both aspects and are practical, ultimately we do encourage users to plot their own data.

For example, making plots like those from **Supplementary Figure 2**. **Supplementary Figure 2A** is useful to examine whether genes you might have expected to pass the filters are being dropped. You can then check they were just below the filtering cutoffs, or significantly far away from them. Once you have the candidate TREG results, then **Supplementary Figure 2B** is useful to examine at what point do the top candidate TREGs have a stronger relationship with total RNA expression as measured from the snRNA-seq data. That is, where the blue curve jumps up and shows a more clear association between the two axes of that plot.

Among the top candidate TREGs, there might be practical limitations to consider for using that TREG in another assay, such as availability of RNAscope probes as well as measurability of the puncta for a given probe. We showed in **Figure 5** how *MALAT1* could not be reliably quantified with RNAscope due to high expression and oversaturation of fluorescent signals. In the case of RNAscope, we recommend testing the measurability of candidate TREGs with RNAscope data before generating a full dataset with a probe that may be difficult to accurately quantify.

# 5 Conclusion

We have identified top candidate TREG genes from this dataset, by applying
Proportion Zero filtering and calculating the Rank Invariance using the `TREG` package.
This provides a list of candidate genes that can be useful for estimating total
RNA expression in assays such as smFISH.

However, we are unable to assess other important qualities of these genes that
ensure they are experimentally compatible with the chosen assay.
For example, in smFISH with RNAscope it is important that a TREG be
expressed at a level that individual puncta can be accurately counted, and have a
dynamic range of puncta. During experimental validation we found that *MALAT1* was too highly expressed in the
human DLPFC to segment individual puncta, and ruled it out as an experimentally
useful TREG (Huuki-Myers, Montgomery, Kwon et al., 2022).

Therefore, we recommend that TREGs be evaluated in the assay or
analysis of choice you perform a validation experiment with a pilot sample before
implementing experiments using it on rare and valuable samples.

If you are designing a sc/snRNA-seq study to use as a reference for deconvolution of bulk RNA-seq, we recommend that you generate spatially-adjacent dissections in order to use them for RNAscope experiments. By doing so, you could identify cell types in your sc/snRNA-seq data, then identify candidate TREGs based on those cell types, and use these candidate TREGs in your spatially-adjacent dissections to quantify size and total RNA amounts for the cell types of interest (Huuki-Myers, Montgomery, Kwon et al., 2022). Furthermore, the RNAscope data alone can be used as a gold standard reference for cell fractions.

TREGs could be useful for other research purposes and other contexts than the ones we envisioned!

Thanks for your interest in TREGs :)

# 6 Reproducibility

The *[TREG](https://bioconductor.org/packages/3.22/TREG)* package (Huuki-Myers and Collado-Torres, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* (Shepherd and Morgan, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* (Wickham, François, Henry, Müller, and Vaughan, 2023)
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* (Bates, Maechler, and Jagan, 2025)
* *[pheatmap](https://CRAN.R-project.org/package%3Dpheatmap)* (Kolde, 2025)
* *[purrr](https://CRAN.R-project.org/package%3Dpurrr)* (Wickham and Henry, 2025)
* *[rafalib](https://CRAN.R-project.org/package%3Drafalib)* (Irizarry and Love, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* (Morgan, Obenchain, Hester, and Pagès, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[tibble](https://CRAN.R-project.org/package%3Dtibble)* (Müller and Wickham, 2025)
* *[tidyr](https://CRAN.R-project.org/package%3Dtidyr)* (Wickham, Vaughan, and Girlich, 2024)

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("finding_Total_RNA_Expression_Genes.Rmd"))

## Extract the R code
library("knitr")
knit("finding_Total_RNA_Expression_Genes.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 03:02:24 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 1.244 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  backports              1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache          3.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0   2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr                 2.5.1   2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                * 1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3   2023-12-11 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2              * 4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1   2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  pheatmap             * 1.0.13  2025-06-05 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rafalib                1.0.4   2025-04-08 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3   2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble               * 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                * 1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex                0.57    2025-04-15 [2] CRAN (R 4.5.1)
#>  TREG                 * 1.14.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmp1WQhKl/Rinst3ac03e1eedc5f4
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 7 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025), *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-bates2025matrix)
D. Bates, M. Maechler, and M. Jagan.
*Matrix: Sparse and Dense Matrix Classes and Methods*.
R package version 1.7-4.
2025.
DOI: [10.32614/CRAN.package.Matrix](https://doi.org/10.32614/CRAN.package.Matrix).
URL: [https://CRAN.R-project.org/package=Matrix](https://CRAN.R-project.org/package%3DMatrix).

[[3]](#cite-huukimyers2025treg)
L. A. Huuki-Myers and L. Collado-Torres.
*TREG: a R/Bioconductor package to identify Total RNA Expression Genes*.
<https://github.com/LieberInstitute/TREG/TREG> - R package version 1.14.0.
2025.
DOI: [10.18129/B9.bioc.TREG](https://doi.org/10.18129/B9.bioc.TREG).
URL: <http://www.bioconductor.org/packages/TREG>.

[[4]](#cite-huukimyers2022data)
L. A. Huuki-Myers, K. D. Montgomery, S. H. Kwon, et al.
“Data Driven Identification of Total RNA Expression Genes”TREGs" for estimation of RNA abundance in heterogeneous cell types”.
In: *bioRxiv* (2022).
DOI: [10.1101/2022.04.28.489923](https://doi.org/10.1101/2022.04.28.489923).
URL: <https://doi.org/10.1101/2022.04.28.489923>.

[[5]](#cite-irizarry2025rafalib)
R. A. Irizarry and M. I. Love.
*rafalib: Convenience Functions for Routine Data Exploration*.
R package version 1.0.4.
2025.
DOI: [10.32614/CRAN.package.rafalib](https://doi.org/10.32614/CRAN.package.rafalib).
URL: [https://CRAN.R-project.org/package=rafalib](https://CRAN.R-project.org/package%3Drafalib).

[[6]](#cite-kolde2025pheatmap)
R. Kolde.
*pheatmap: Pretty Heatmaps*.
R package version 1.0.13.
2025.
DOI: [10.32614/CRAN.package.pheatmap](https://doi.org/10.32614/CRAN.package.pheatmap).
URL: [https://CRAN.R-project.org/package=pheatmap](https://CRAN.R-project.org/package%3Dpheatmap).

[[7]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[8]](#cite-morgan2025summarizedexperiment)
M. Morgan, V. Obenchain, J. Hester, et al.
*SummarizedExperiment: A container (S4 class) for matrix-like assays*.
R package version 1.40.0.
2025.
DOI: [10.18129/B9.bioc.SummarizedExperiment](https://doi.org/10.18129/B9.bioc.SummarizedExperiment).
URL: <https://bioconductor.org/packages/SummarizedExperiment>.

[[9]](#cite-mller2025tibble)
K. Müller and H. Wickham.
*tibble: Simple Data Frames*.
R package version 3.3.0.
2025.
DOI: [10.32614/CRAN.package.tibble](https://doi.org/10.32614/CRAN.package.tibble).
URL: [https://CRAN.R-project.org/package=tibble](https://CRAN.R-project.org/package%3Dtibble).

[[10]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[11]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[12]](#cite-shepherd2025biocfilecache)
L. Shepherd and M. Morgan.
*BiocFileCache: Manage Files Across Sessions*.
R package version 3.0.0.
2025.
DOI: [10.18129/B9.bioc.BiocFileCache](https://doi.org/10.18129/B9.bioc.BiocFileCache).
URL: <https://bioconductor.org/packages/BiocFileCache>.

[[13]](#cite-tran2021)
M. N. Tran, K. R. Maynard, A. Spangler, et al.
“Single-nucleus transcriptome analysis reveals cell-type-specific molecular signatures across reward circuitry in the human brain”.
In: *Neuron* (2021).
DOI: [10.1016/j.neuron.2021.09.001](https://doi.org/10.1016/j.neuron.2021.09.001).

[[14]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[15]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[16]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[17]](#cite-wickham2023dplyr)
H. Wickham, R. François, L. Henry, et al.
*dplyr: A Grammar of Data Manipulation*.
R package version 1.1.4.
2023.
DOI: [10.32614/CRAN.package.dplyr](https://doi.org/10.32614/CRAN.package.dplyr).
URL: [https://CRAN.R-project.org/package=dplyr](https://CRAN.R-project.org/package%3Ddplyr).

[[18]](#cite-wickham2025purrr)
H. Wickham and L. Henry.
*purrr: Functional Programming Tools*.
R package version 1.1.0.
2025.
DOI: [10.32614/CRAN.package.purrr](https://doi.org/10.32614/CRAN.package.purrr).
URL: [https://CRAN.R-project.org/package=purrr](https://CRAN.R-project.org/package%3Dpurrr).

[[19]](#cite-wickham2024tidyr)
H. Wickham, D. Vaughan, and M. Girlich.
*tidyr: Tidy Messy Data*.
R package version 1.3.1.
2024.
DOI: [10.32614/CRAN.package.tidyr](https://doi.org/10.32614/CRAN.package.tidyr).
URL: [https://CRAN.R-project.org/package=tidyr](https://CRAN.R-project.org/package%3Dtidyr).

[[20]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.