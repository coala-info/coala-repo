# VDJdive Workflow

Kelly Street\*, Mercedeh Movassagh and Jill Lundell

\*street.kelly@gmail.com

#### 30 October 2025

#### Abstract

This vignette demonstrates the utility of the `VDJdive` package. The package provides functions for handling and analyzing immune receptor repertoire data, as produced by the CellRanger V(D)J pipeline. This includes reading the data into R, merging it with paired single-cell RNA-seq data, assigning clonotype labels, calculating diversity metrics, and producing common plots.

#### Package

VDJdive 1.12.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Read in 10X data](#read-in-10x-data)
* [4 Merging V(D)J and scRNAseq Data](#merging-vdj-and-scrnaseq-data)
* [5 Assign Clonotypes and Calculate Summaries](#assign-clonotypes-and-calculate-summaries)
* [6 Diversity](#diversity)
* [7 Cluster Diversity](#cluster-diversity)
* [8 Visualization](#visualization)
  + [8.1 Clonotype Abundance Bar Plot](#clonotype-abundance-bar-plot)
  + [8.2 Clonotype Abundance Pie Chart](#clonotype-abundance-pie-chart)
  + [8.3 Richness vs. Evenness Scatter Plot](#richness-vs.-evenness-scatter-plot)
  + [8.4 Clonotype Abundance Dot Plot](#clonotype-abundance-dot-plot)
  + [8.5 Session Info](#session-info)

# 1 Introduction

Targeted sequencing of immune receptors is a powerful tool for interrogating the adaptive immune system. Single-cell technology has increased the resolution of this type of data tremendously. While many tools exist to analyze single-cell RNA sequencing data, there are fewer options available for targeted assays like adaptive immune receptor sequencing (AIRRseq).

The *[VDJdive](https://bioconductor.org/packages/3.22/VDJdive)* package provides functionality for incorporating AIRRseq (or TCRseq) data into the Bioconductor single-cell ecosystem and analyzing it in a variety of ways. We believe this will unlock many powerful tools for the analysis of immune receptor data and make it easily accessible to users already familiar with `SingleCellExperiment` objects and the Bioconductor framework. This vignette will give you a brief overview of the methods available in the package and demonstrate their usage on a simple dataset.

# 2 Installation

To install `VDJdive` from Bioconductor, you can use the following code:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("VDJdive")
```

Additionally, some features of `VDJdive` make use of C++ functionality, which is made available through the [`Rcpp`](https://cran.r-project.org/package%3DRcpp) package.

# 3 Read in 10X data

The 10X data are in a file called `filtered_contig_annotations.csv`, containing one entry (row) for each unique contig in each cell. When we read this data into R, we could produce a single `data.frame`, but we want to keep entries from the same cell together. Hence, we read the data in as a `SplitDataFrameList`, which efficiently stores a collection of data frames all containing the same column names. The following snippet demonstrates how to read in the `filtered_contig_annotations.csv` file and convert it to a `CompressedSplitDFrameList` for downstream use.

The function `readVDJcontigs` takes a character vector that contains directory names. Each directory should contain a file called `filtered_contig_annotations.csv`. `readVDJcontigs` will read in the 10X files from the directory, split by cell barcode, and create a `SplitDataFrameList` from the files. The barcodes will be unique across samples because the sample name is appended to the barcode.

```
# Read in a single file
contigs <- readVDJcontigs("path_to_10X_files")

# Read in files for multiple samples
path1 <- "sample1"
path2 <- "sample2"
contigs <- readVDJcontigs(c("path1", "path2"))
```

# 4 Merging V(D)J and scRNAseq Data

Besides keeping data on the same cells together, the primary advantage of the `SplitDataFrameList` is that it has length equal to the number of cells and can therefore be added to the column data of a `SingleCellExperiment` object. Cells are matched between the two objects by their barcodes. However, this merging can lead to information loss, as cells that are not already represented in the SCE object will be dropped from the `SplitDataFrameList`. When this happens, `addVDJtoSCE` will issue a warning with the number of cells that have been dropped.

```
require(SingleCellExperiment)
ncells <- 24
u <- matrix(rpois(1000 * ncells, 5), ncol = ncells)
barcodes <- vapply(contigs[,'barcode'], function(x){ x[1] }, 'A')
samples <- vapply(contigs[,'sample'], function(x){ x[1] }, 'A')
sce <- SingleCellExperiment(assays = list(counts = u),
                            colData = data.frame(Barcode = barcodes,
                                                 group = samples))
sce <- addVDJtoSCE(contigs, sce)
sce$contigs
#> SplitDataFrameList of length 24
#> $`ACAGCCGTCACCATAG-2`
#> DataFrame with 3 rows and 20 columns
#>                                         X            barcode   is_cell
#>                               <character>        <character> <logical>
#> ACAGCCGTCACCATAG-2 ACAGCCGTCACCATAG-2.A.. ACAGCCGTCACCATAG-2      TRUE
#> ACAGCCGTCACCATAG-2 ACAGCCGTCACCATAG-2.A.. ACAGCCGTCACCATAG-2      TRUE
#> ACAGCCGTCACCATAG-2 ACAGCCGTCACCATAG-2.A.. ACAGCCGTCACCATAG-2      TRUE
#>                                 contig_id high_confidence    length       chain
#>                               <character>       <logical> <integer> <character>
#> ACAGCCGTCACCATAG-2 ACAGCCGTCACCATAG-1_c..            TRUE       512         TRA
#> ACAGCCGTCACCATAG-2 ACAGCCGTCACCATAG-1_c..            TRUE       731         TRB
#> ACAGCCGTCACCATAG-2 ACAGCCGTCACCATAG-1_c..            TRUE       696         TRB
#>                         v_gene      d_gene      j_gene      c_gene full_length
#>                    <character> <character> <character> <character>   <logical>
#> ACAGCCGTCACCATAG-2       TRAV6        None      TRAJ28        TRAC        TRUE
#> ACAGCCGTCACCATAG-2    TRBV29-1       TRBD2     TRBJ2-3       TRBC2        TRUE
#> ACAGCCGTCACCATAG-2     TRBV7-3       TRBD2     TRBJ2-1       TRBC2        TRUE
#>                    productive            cdr3                cdr3_nt     reads
#>                     <logical>     <character>            <character> <integer>
#> ACAGCCGTCACCATAG-2       TRUE  CASRPGAGSYQLTF TGTGCTTCCCGGCCGGGGGC..     23449
#> ACAGCCGTCACCATAG-2       TRUE CSVEPTSRSTDTQYF TGCAGCGTTGAGCCGACTAG..     44248
#> ACAGCCGTCACCATAG-2       TRUE CASSPRGGGLNEQFF TGTGCCAGCAGCCCTAGGGG..     46804
#>                         umis raw_clonotype_id       raw_consensus_id
#>                    <integer>      <character>            <character>
#> ACAGCCGTCACCATAG-2         4     clonotype113 clonotype113_consens..
#> ACAGCCGTCACCATAG-2         8     clonotype113 clonotype113_consens..
#> ACAGCCGTCACCATAG-2         8     clonotype113 clonotype113_consens..
#>                         sample
#>                    <character>
#> ACAGCCGTCACCATAG-2     sample2
#> ACAGCCGTCACCATAG-2     sample2
#> ACAGCCGTCACCATAG-2     sample2
#>
#> $`ACGCAGCCACTATCTT-1`
#> DataFrame with 6 rows and 20 columns
#>                                         X            barcode   is_cell
#>                               <character>        <character> <logical>
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1.A.. ACGCAGCCACTATCTT-1      TRUE
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1.A.. ACGCAGCCACTATCTT-1      TRUE
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1.A.. ACGCAGCCACTATCTT-1      TRUE
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1.A.. ACGCAGCCACTATCTT-1      TRUE
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1.A.. ACGCAGCCACTATCTT-1      TRUE
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1.A.. ACGCAGCCACTATCTT-1      TRUE
#>                                 contig_id high_confidence    length       chain
#>                               <character>       <logical> <integer> <character>
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1_c..            TRUE       514         IGL
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1_c..            TRUE       625         TRD
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1_c..            TRUE       554         IGH
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1_c..            TRUE       800         TRB
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1_c..            TRUE       327       Multi
#> ACGCAGCCACTATCTT-1 ACGCAGCCACTATCTT-1_c..            TRUE       526         TRA
#>                         v_gene      d_gene      j_gene      c_gene full_length
#>                    <character> <character> <character> <character>   <logical>
#> ACGCAGCCACTATCTT-1    IGLV2-18        None        None        None       FALSE
#> ACGCAGCCACTATCTT-1       TRDV3        None        None        None       FALSE
#> ACGCAGCCACTATCTT-1    IGHV1-45        None        None       IGHG4       FALSE
#> ACGCAGCCACTATCTT-1     TRBV7-3       TRBD1     TRBJ1-2        None       FALSE
#> ACGCAGCCACTATCTT-1     IGHV1-2        None     TRBJ2-3       TRBC2       FALSE
#> ACGCAGCCACTATCTT-1      TRAV27        None       TRAJ6        None       FALSE
#>                    productive        cdr3     cdr3_nt     reads      umis
#>                     <logical> <character> <character> <integer> <integer>
#> ACGCAGCCACTATCTT-1      FALSE        None        None        39         2
#> ACGCAGCCACTATCTT-1      FALSE        None        None       118         1
#> ACGCAGCCACTATCTT-1      FALSE        None        None       124         1
#> ACGCAGCCACTATCTT-1      FALSE        None        None      1492         9
#> ACGCAGCCACTATCTT-1      FALSE        None        None      2202         2
#> ACGCAGCCACTATCTT-1      FALSE        None        None       135         2
#>                    raw_clonotype_id raw_consensus_id      sample
#>                         <character>      <character> <character>
#> ACGCAGCCACTATCTT-1             None             None     sample1
#> ACGCAGCCACTATCTT-1             None             None     sample1
#> ACGCAGCCACTATCTT-1             None             None     sample1
#> ACGCAGCCACTATCTT-1             None             None     sample1
#> ACGCAGCCACTATCTT-1             None             None     sample1
#> ACGCAGCCACTATCTT-1             None             None     sample1
#>
#> $`AGCATACAGTCTCAAC-2`
#> DataFrame with 2 rows and 20 columns
#>                                         X            barcode   is_cell
#>                               <character>        <character> <logical>
#> AGCATACAGTCTCAAC-2 AGCATACAGTCTCAAC-2.A.. AGCATACAGTCTCAAC-2      TRUE
#> AGCATACAGTCTCAAC-2 AGCATACAGTCTCAAC-2.A.. AGCATACAGTCTCAAC-2      TRUE
#>                                 contig_id high_confidence    length       chain
#>                               <character>       <logical> <integer> <character>
#> AGCATACAGTCTCAAC-2 AGCATACAGTCTCAAC-1_c..            TRUE       698         TRB
#> AGCATACAGTCTCAAC-2 AGCATACAGTCTCAAC-1_c..            TRUE       698         TRA
#>                         v_gene      d_gene      j_gene      c_gene full_length
#>                    <character> <character> <character> <character>   <logical>
#> AGCATACAGTCTCAAC-2    TRBV29-1       TRBD2     TRBJ2-3       TRBC2        TRUE
#> AGCATACAGTCTCAAC-2       TRAV6        None      TRAJ28        TRAC        TRUE
#>                    productive            cdr3                cdr3_nt     reads
#>                     <logical>     <character>            <character> <integer>
#> AGCATACAGTCTCAAC-2       TRUE CSVEPTSRSTDTQYF TGCAGCGTTGAGCCGACTAG..     70053
#> AGCATACAGTCTCAAC-2       TRUE  CASRPGAGSYQLTF TGTGCTTCCCGGCCGGGGGC..     14509
#>                         umis raw_clonotype_id       raw_consensus_id
#>                    <integer>      <character>            <character>
#> AGCATACAGTCTCAAC-2         8       clonotype6 clonotype6_consensus_1
#> AGCATACAGTCTCAAC-2         4       clonotype6 clonotype6_consensus_2
#>                         sample
#>                    <character>
#> AGCATACAGTCTCAAC-2     sample2
#> AGCATACAGTCTCAAC-2     sample2
#>
#> ...
#> <21 more elements>
```

# 5 Assign Clonotypes and Calculate Summaries

*[VDJdive](https://bioconductor.org/packages/3.22/VDJdive)* contains two methods for assigning clonotype lables. The first considers only cells with complete, productive alpha and beta chains (exactly one of each). These are the cells which can only be assigned a single, unique clonotype label and the resulting abudances are always whole numbers. Cells that do not meet this criteria are not assigned a clonotype and do not contribute to downstream analysis. If two cells have identical amino acid sequences in their CDR3 regions, they are considered to be the same clonotype. We assign clonotypes in this manner by running `clonoStats` with the option `method = 'unique'`:

```
UNstats <- clonoStats(contigs, method = 'unique')
class(UNstats)
#> [1] "clonoStats"
#> attr(,"package")
#> [1] "VDJdive"
```

The other method for assigning clonotype lables is probabalistic and makes use of the Expectation-Maximization (EM) algorithm. Rather than filtering out ambiguous cells (ie. cells with no alpha chain, no beta chain, or more than one of either), this method allows for partial assignment. For example, if a cell has one productive alpha chain and two productive beta chains, the EM algorithm will be used to make a partial clonotype assignment based on the prevalence of each clonotype in the sample. That means that a cell may have a count of 0.6 for one clonotype and 0.4 for a different clonotype rather than a count of 1 for a single clonotype. We assign clonotypes in this manner by running `clonoStats` with the option `method = 'EM'` (which is the default):

```
EMstats <- clonoStats(contigs, method = "EM")
class(EMstats)
#> [1] "clonoStats"
#> attr(,"package")
#> [1] "VDJdive"
```

Similarly, we can call `clonoStats` on a `SingleCellExperiment` object that contains V(D)J data. This will add a `clonoStats` object to the metadata of the SCE:

```
sce <- clonoStats(sce, method = 'EM')
metadata(sce)
#> $clonoStats
#> An object of class "clonoStats"
#> clonotypes: 23
#> cells: 24
#> groups(2): sample1 sample2
#> has assignment: FALSE
```

Functions to access the clonoStats class.

```
head(clonoAbundance(sce)) # access output of abundance for clonotypes for clonoStats class
#> 6 x 2 sparse Matrix of class "dgCMatrix"
#>      sample1 sample2
#> [1,]    0.25       .
#> [2,]    0.25       .
#> [3,]    0.25       .
#> [4,]    0.25       .
#> [5,]    2.00       1
#> [6,]    0.50       .
clonoFrequency(sce) # access output of frequency for clonotypes for clonoStats class
#> 3 x 2 sparse Matrix of class "dgCMatrix"
#>   sample1 sample2
#> 1       4       7
#> 2       2       2
#> 3       1       .
clonoFrequency(sce) # access output of clonotypes assignment for clonoStats class
#> 3 x 2 sparse Matrix of class "dgCMatrix"
#>   sample1 sample2
#> 1       4       7
#> 2       2       2
#> 3       1       .
clonoGroup(sce) # access output of clonotypes grouping for clonoStats class
#>  [1] sample2 sample1 sample2 sample1 sample1 sample1 sample2 sample1 sample1
#> [10] sample2 sample1 sample1 sample2 sample2 sample1 sample2 sample2 sample2
#> [19] sample1 sample2 sample2 sample2 sample1 sample1
#> Levels: sample1 sample2
clonoNames(sce) # access output of clonotypes samples for clonoStats class
#>  [1] "CAASISGGSNYKLTF CASSVDSGRGETQYF"   "CAACVEGLMF CASSVDSGRGETQYF"
#>  [3] "CAASISGGSNYKLTF CASSLADGLNTEAFF"   "CAACVEGLMF CASSLADGLNTEAFF"
#>  [5] "CVVLPGSSNTGKLIF CASSLSAGARYEQYF"   "CAMLDSNYQLIW CASSESEVAEPDTQYF"
#>  [7] "CAMLDSNYQLIW CASSTSGDFYEQYF"       "CAMSAEDDKIIF CASSYSTVYEQYF"
#>  [9] "CATYPWTSYDKVIF CASSFDEGGGETQYF"    "CAVSDAGGTSYGKLTF CASSVSGNRGNYGYTF"
#> [11] "CALSGRGEGGSEKLVF CASSWGLGTEAFF"    "CAGLDTGTASKLTF CASSWGLGTEAFF"
#> [13] "CASRPGAGSYQLTF CSVEPTSRSTDTQYF"    "CAVRTLADYKLSF CASSITPDSPSYGYTF"
#> [15] "CIVRVAFGQNFVF CSADISGSSYNEQFF"     "CAPSFSGNTPLVF CSADISGSSYNEQFF"
#> [17] "CAGFFYNQGGKLIF CSAARTGSYEQYF"      "CAVGEGGSTLGRLYF CASTRYNEQFF"
#> [19] "CIVSSHQGAQKLVF CASTRYNEQFF"        "CAVGEGGSTLGRLYF CASSVLGGKTDTQYF"
#> [21] "CIVSSHQGAQKLVF CASSVLGGKTDTQYF"    "CAETWGQGNLIF CASSGPGVGSTDTQYF"
#> [23] "CAVGGMTTDSWGKLQF CASSLSSGNTGELFF"
```

# 6 Diversity

Diversity metrics can be computed from the `clonoStats` object or a `SingleCellExperiment` object containing the relevant output. The `calculateDiversity` function can compute (normalized) Shannon entropy, Simpson index, inverse-Simpson index, Chao diversity, and Chao-Bunge diversity. The Chao and Chao-Bunge diversity measures require clonotype frequencies that may be philosophically incompatible with the expected counts generated by the EM algorithm. In these cases, the results for the EM counts are taken as Bernoulli probabilities and we calculate the expected number of singletons, doubletons, etc. The entropy measures and Simpson indices do not require integer counts so no additional calculation is needed for those measures.

All of the diversity measures can be computed for each sample with the following:

```
div <- calculateDiversity(EMstats, methods = "all")
div
#>                       sample1    sample2
#> nCells             11.0000000 11.0000000
#> nClonotypes         7.0000000  9.0000000
#> shannon             2.0982737  2.3348819
#> normentropy         0.8444075  0.9103033
#> invsimpson          6.2857143  8.8000000
#> ginisimpson         0.8409091  0.8863636
#> chao1               9.0000000 16.0000000
#> chaobunge.est       9.8108108 15.1250000
#> chaobunge.CI.lower  7.0000000 10.0000000
#> chaobunge.CI.upper 31.0000000 45.0000000
```

We also provide a function for estimation of species richness through breakaway (Willis et al, biometrics 2015). For this section please ensure to install the breakaway package from CRAN <https://cran.r-project.org/web/packages/breakaway/index.html> . The method uses the frequency (number of singletons, doubletons etc to provide a more accurate estimate for richness with standard error and confidence intervals).

```
#divBreakaway <- runBreakaway(EMstats, methods = 'unique')
#divBreakaway
```

# 7 Cluster Diversity

Rather than grouping cells by sample, we may be interested in other groupings, such as clusters based on RNA expression. In this case, if we have the original clonotype assignment matrix, we can calculate new summary statistics based on a different grouping variable. This is preferable to grouping by cluster in the original call to `clonoStats` because the most accurate clonotype assignment is achieved cells are grouped by sample. Otherwise, we may see unwanted crosstalk between samples leading to nonsensical counts (ie. a clonotype that never appears in a particular sample may receive non-zero counts from some ambiguous cells in that sample).

```
EMstats <- clonoStats(contigs, method = "EM", assignment = TRUE)

clus <- sample(1:2, 24, replace = TRUE)

EMstats.clus <- clonoStats(EMstats, group = clus)
```

To reiterate: we always recommend running `clonoStats` by sample of origin first, to get the most accurate clonotype assignment. It is easy to re-calculate summary statistics for other grouping variables later.

# 8 Visualization

*[VDJdive](https://bioconductor.org/packages/3.22/VDJdive)* has many options for visualization. This section demonstrates the graphs that can be created.

## 8.1 Clonotype Abundance Bar Plot

Barplot function which shows the number of T cells in each group (sample) as well as the clonotype abundances within each group (sample). The coloring indicates the number of cells assigned to each clonotype, with darker colors denoting singletons and
lighter colors denoting expanded clonotypes (scale = log count of clontypes).

```
barVDJ(EMstats, title = "contigs", legend = TRUE)
```

![](data:image/png;base64...)

## 8.2 Clonotype Abundance Pie Chart

Similar to the bar plot above, these pie charts show the clonotype abundances
within each group (sample), as a percentage of cells within that group. The coloring indicates the number of cells assigned to each clonotype, with darker colors denoting singletons and lighter colors denoting expanded clonotypes (scale = log count of clontypes).

```
pieVDJ(EMstats)
#> [[1]]
```

![](data:image/png;base64...)

```
#>
#> [[2]]
```

![](data:image/png;base64...)

## 8.3 Richness vs. Evenness Scatter Plot

This scatter plot shows two measures of group-level (sample-level) diversity.
The “richness” (total number of clonotypes) is shown on the x-axis and the
“evenness” (mixture of clonotypes) on the y-axis. Diversity measures such as
Shannon entropy contain information about both the evenness and the abundance of
a sample, but because both characteristics are combined into one number,
comparison between samples or groups of samples is difficult. Other measures,
such as the breakaway measure of diversity, only express the abundance of the
sample and not the evenness. The scatterplot shows how evenness and abundance
differ between each sample and between each group of samples.

```
sampleGroups <- data.frame(Sample = c("sample1", "sample2"),
                           Group = c("Tumor", "Normal"))
scatterVDJ(div, sampleGroups = NULL,
       title = "Evenness-abundance plot", legend = TRUE)
```

![](data:image/png;base64...)

## 8.4 Clonotype Abundance Dot Plot

This dot plot shows the clonotype abundances in each group (sample) above a
specified cutoff. The most abundant clonotypes for each group (sample) are annotated on
the plot and ordered from most abundant to least abundant.

```
abundanceVDJ(EMstats)
```

![](data:image/png;base64...)

## 8.5 Session Info

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           VDJdive_1.12.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
#>  [4] magrittr_2.0.4      digest_0.6.37       evaluate_1.0.5
#>  [7] grid_4.5.1          RColorBrewer_1.1-3  bookdown_0.45
#> [10] fastmap_1.2.0       jsonlite_2.0.0      Matrix_1.7-4
#> [13] tinytex_0.57        gridExtra_2.3       BiocManager_1.30.26
#> [16] viridisLite_0.4.2   scales_1.4.0        codetools_0.2-20
#> [19] jquerylib_0.1.4     abind_1.4-8         cli_3.6.5
#> [22] rlang_1.1.6         XVector_0.50.0      cowplot_1.2.0
#> [25] withr_3.0.2         cachem_1.1.0        DelayedArray_0.36.0
#> [28] yaml_2.3.10         S4Arrays_1.10.0     tools_4.5.1
#> [31] parallel_4.5.1      BiocParallel_1.44.0 dplyr_1.1.4
#> [34] ggplot2_4.0.0       vctrs_0.6.5         R6_2.6.1
#> [37] magick_2.9.0        lifecycle_1.0.4     pkgconfig_2.0.3
#> [40] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
#> [43] glue_1.8.0          Rcpp_1.1.0          tidyselect_1.2.1
#> [46] tibble_3.3.0        xfun_0.53           knitr_1.50
#> [49] dichromat_2.0-0.1   farver_2.1.2        htmltools_0.5.8.1
#> [52] labeling_0.4.3      rmarkdown_2.30      compiler_4.5.1
#> [55] S7_0.2.0
```