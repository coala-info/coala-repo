# LRcell: Differential **cell** type change analysis using **L**ogistic/linear **R**egression.

Wenjing Ma1\* and Dr. Zhaohui S. Qin2

1Computer Science and Informatics, Emory University
2Department of Biostatistics and Bioinformatics, Emory University

\*wenjing.ma@emory.edu

#### 2025-10-30

#### Abstract

The goal of LRcell is to identify specific sub-cell types that drives the changes observed in a bulk RNA-seq differential gene expression experiment. To achieve this, LRcell utilizes sets of cell marker genes acquired from single-cell RNA-sequencing (scRNA-seq) as indicators for various cell types in the tissue of interest. Next, for each cell type, using its marker genes as indicators, we apply Logistic/Linear Regression on the complete set of genes with differential expression p-values to calculate a cell-type significance p-value. Finally, these p-values are compared to predict which one(s) are likely to be responsible for the differential gene expression pattern observed in the bulk RNA-seq experiments. LRcell is inspired by the LRpath(Sartor, Leikauf, and Medvedovic [2009](#ref-sartor2009lrpath)) algorithm developed by Sartor et al., originally designed for pathway/gene set enrichment analysis. LRcell contains three major components: LRcell analysis, plot generation and marker gene selection. All modules in this package are written in R. This package also provides marker genes in the Prefrontal Cortex (pFC) human brain region and nine mouse brain regions (Frontal Cortex, Cerebellum, Globus Pallidus, Hippocampus, Entopeduncular, Posterior Cortex, Striatum, Substantia Nigra and Thalamus).

# Contents

* [1 Introduction](#introduction)
* [2 Standard Workflow](#standard-workflow)
  + [2.1 Installation](#installation)
  + [2.2 LRcell usage](#lrcell-usage)
    - [2.2.1 Directly indicate species and brain region in LRcell](#directly-indicate-species-and-brain-region-in-lrcell)
    - [2.2.2 Marker gene download and do LRcell analysis](#marker-gene-download-and-do-lrcell-analysis)
  + [2.3 Calculate gene enrichment scores from expression dataframe](#calculate-gene-enrichment-scores-from-expression-dataframe)
* [3 SessionInfo](#sessioninfo)
* [References](#references)

# 1 Introduction

Single-cell RNA-sequencing (scRNA-seq) technologies have revealed cell heterogeneity.
Marker gene expressions are considered as the most intuitive and informative measurements
distinguishing different cell types. Although several computational methods have
been proposed to do marker gene selection from clusters or cell types, none of them applied
marker gene information on bulk RNA-seq experiments to find cell type or cluster enrichment.
Here, we present LRcell package, which uses Logistic/Linear Regression to
identify the most transcriptionally enriched cell types or clusters when applying cell marker
information to a bulk experiment with p-values measurements of differentially expressed genes.

**Pre-Loaded Marker genes information**: This package offers marker genes information in 1 human PBMC data, 1 human brain region
and 9 mouse brain regions.

# 2 Standard Workflow

## 2.1 Installation

This is a R Bioconductor package and it can be installed by using `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager") ## this will install the BiocManager package
BiocManager::install("LRcell")
#> Bioconductor version 3.22 (BiocManager 1.30.26), R 4.5.1 Patched (2025-08-23
#>   r88802)
#> Warning: package(s) not installed when version(s) same as or greater than current; use
#>   `force = TRUE` to re-install: 'LRcell'
```

To check whether LRcell package is successfully installed:

```
library(LRcell)
#> Loading required package: ExperimentHub
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: AnnotationHub
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
```

## 2.2 LRcell usage

Once we have LRcell package loaded, we can start using it to analyze the transcriptional
engagement of cell types or clusters. LRcell **takes both single-cell marker genes list
and p-values of bulk DE genes as input** to calculate the enrichment of cell-type specific
marker genes in the ranked DE genes.

As mentioned above, LRcell provides single-cell marker genes list in 1 human PBMC data, 1 human brain region
(Prefrontal Cortex) and 9 mouse brain regions (Frontal Cortex, Cerebellum, Globus Pallidus,
Hippocampus, Entopeduncular, Posterior Cortex, Striatum, Substantia Nigra and Thalamus).

* The human PBMC data comes from volunteers enrolled in an HIV vaccine trial (Hao et al. [2020](#ref-hao2020integrated)) at time point of day 0.
* The human brain data comes from control samples in Major Depressive Disorder studies. (Nagy et al. [2020](#ref-nagy2020single)).
* The mouse data comes from the whole brain single-cell RNA-seq experiments(Saunders et al. [2018](#ref-saunders2018molecular)). Another resource for this dataset is [DropViz](http://dropviz.org/).

The data is stored in another Bioconductor ExperimentHub package named [LRcellTypeMarkers](https://github.com/marvinquiet/LRcellTypeMarkers). Users can access the data through ExperimentHub by:

```
## for installing ExperimentHub
# BiocManager::install("ExperimentHub")

## query data
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()
eh <- AnnotationHub::query(eh, "LRcellTypeMarkers")  ## query for LRcellTypeMarkers package
eh  ## this will list out EH number to access the calculated gene enrichment scores
#> ExperimentHub with 15 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Emory University
#> # $species: Mus musculus, Homo sapiens
#> # $rdataclass: Matrix, list
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH4548"]]'
#>
#>            title
#>   EH4548 | Mouse Frontal Cortex Marker Genes
#>   EH4549 | Mouse Cerebellum Marker Genes
#>   EH4550 | Mouse Entopeduncular Marker Genes
#>   EH4551 | Mouse Globus Pallidus Marker Genes
#>   EH4552 | Mouse Posterior Cortex Marker Genes
#>   ...      ...
#>   EH5420 | Human PBMC Marker Genes
#>   EH6727 | MSigDB C8 MANNO MIDBRAIN
#>   EH6728 | MSigDB C8 ZHENG CORD BLOOD
#>   EH6729 | MSigDB C8 FAN OVARY
#>   EH6730 | MSigDB C8 RUBENSTEIN SKELETAL MUSCLE

## get mouse brain Frontal Cortex enriched genes
enriched.g <- eh[["EH4548"]]
#> see ?LRcellTypeMarkers and browseVignettes('LRcellTypeMarkers') for documentation
#> loading from cache
marker.g <- get_markergenes(enriched.g, method="LR", topn=100)
```

Users are also encouraged to process a read count matrix with cell annotation information into a gene enrichment scores matrix.

```
enriched.g <- LRcell_gene_enriched_scores(expr, annot, power=1, parallel=TRUE, n.cores=4)
```

Here, `expr` is a read count matrix with rows as genes and columns as cells. `annot` is a named-vector with names as cell names (which is in accordance with the column names of `expr`) and values as annotated cell types. `power` is a hyper-parameter controlling how much penalty for the proportion of cells expressing certain gene. `parallel` and `n.cores` are two parameters for executing function in parallel to accelerate the calculation.

### 2.2.1 Directly indicate species and brain region in LRcell

Compared to processing data yourself, a much easier way is to indicate species and brain region or tissue.
In this way, marker genes are extracted from ExperimentHub accordingly. For example, we can use mouse Frontal Cortex
marker genes to do LRcell analysis on the example bulk experiment(Swarup et al. [2019](#ref-swarup2019identification)). (The example contains 23, 420 genes along with p-values calculated from
[DESeq2](https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html).
Data is processed from a mouse Alzheimer’s disease model (GEO: [GSE90693](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE90693)),
which is 6 months after treatment in Frontal Cortex brain region.)

```
# load example bulk data
data("example_gene_pvals")
head(example_gene_pvals, n=5)
#>         Xkr4          Rp1        Sox17       Mrpl15       Lypla1
#> 1.742186e-05 4.103134e-02 9.697389e-02 1.206500e-02 6.609558e-01
```

Here, we use Linear Regression:

```
res <- LRcell(gene.p = example_gene_pvals,
              marker.g = NULL,
              species = "mouse",
              region = "FC",
              method = "LiR")
#> see ?LRcellTypeMarkers and browseVignettes('LRcellTypeMarkers') for documentation
#> loading from cache
FC_res <- res$FC
# exclude leading genes for a better view
sub_FC_res <- subset(FC_res, select=-lead_genes)
head(sub_FC_res)
#>                        ID genes_num          coef   p.value       FDR
#> 1  FC_1-1.Interneuron_CGE        98  6.065974e-04 0.2365456 0.4088820
#> 2 FC_1-10.Interneuron_CGE        92 -7.992953e-05 0.9154947 0.9515587
#> 3 FC_1-11.Interneuron_CGE        95  1.183490e-06 0.9987899 0.9987899
#> 4  FC_1-2.Interneuron_CGE        98  4.642689e-04 0.3418545 0.5114907
#> 5  FC_1-3.Interneuron_CGE        85 -2.765110e-04 0.6647116 0.8273606
#> 6  FC_1-4.Interneuron_CGE        98  5.427872e-06 0.9950063 0.9987899
#>         cell_type
#> 1 Interneuron_CGE
#> 2 Interneuron_CGE
#> 3 Interneuron_CGE
#> 4 Interneuron_CGE
#> 5 Interneuron_CGE
#> 6 Interneuron_CGE
```

Plot out the result:

```
plot_manhattan_enrich(FC_res, sig.cutoff = .05, label.topn = 5)
```

![](data:image/png;base64...)

According to the result, when using enrichment scores as a predictor variable in Linear Regression,
one cluster of Astrocytes (FC\_8-2.Astrocytes) is the mostly enriched along with Microglia (FC\_11-1.Microglia).
(Note that although cluster FC\_11-4 was annotated as **unknown** in the publication, according to our research,
FC\_11-\* belong to Microglia/Macrophage cell types.) Recent publications have shown that Astrocytes are involved
in Alzheimer’s Disease.

### 2.2.2 Marker gene download and do LRcell analysis

Marker gene list downloading example (mouse, Frontal Cortex, Logistic Regression):

```
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()  ## use ExperimentHub to download data
eh <- query(eh, "LRcellTypeMarkers")
enriched_genes <- eh[["EH4548"]]  # use title ID which indicates FC region
#> see ?LRcellTypeMarkers and browseVignettes('LRcellTypeMarkers') for documentation
#> loading from cache
# get marker genes for LRcell in logistic regression
FC_marker_genes <- get_markergenes(enriched_genes, method="LR", topn=100)

# to have a glance of the marker gene list
head(lapply(FC_marker_genes, head))
#> $`FC_1-1.Interneuron_CGE`
#> [1] "Npy"    "Pde11a" "Kit"    "Gad2"   "Fam46a" "Pnoc"
#>
#> $`FC_1-10.Interneuron_CGE`
#> [1] "Krt73"   "Npas1"   "Yjefn3"  "Dlx6os1" "Igf1"    "Sln"
#>
#> $`FC_1-11.Interneuron_CGE`
#> [1] "Htr3a"     "Tnfaip8l3" "Npy2r"     "Adarb2"    "Npas1"     "Crabp1"
#>
#> $`FC_1-2.Interneuron_CGE`
#> [1] "Ndnf"  "Kit"   "Reln"  "Npy"   "Cplx3" "Gad1"
#>
#> $`FC_1-3.Interneuron_CGE`
#> [1] "Calb2"  "Crh"    "Nr2f2"  "Dlx1"   "Penk"   "Pcdh18"
#>
#> $`FC_1-4.Interneuron_CGE`
#> [1] "Htr3a"    "Tac2"     "Vip"      "Crh"      "Crispld2" "Adarb2"
```

Then, we can run LRcell analysis by using `LRcellCore()` function using Logistic Regression.

```
res <- LRcellCore(gene.p = example_gene_pvals,
           marker.g = FC_marker_genes,
           method = "LR", min.size = 5,
           sig.cutoff = 0.05)
#> Warning: glm.fit: algorithm did not converge
## curate cell types
res$cell_type <- unlist(lapply(strsplit(res$ID, '\\.'), '[', 2))
head(subset(res, select=-lead_genes))
#>                        ID genes_num        coef odds_ratio     p.value
#> 1  FC_1-1.Interneuron_CGE        98 0.011908189   1.076812 0.006035417
#> 2 FC_1-10.Interneuron_CGE        92 0.006805227   1.043199 0.358384832
#> 3 FC_1-11.Interneuron_CGE        95 0.006160366   1.039027 0.441406086
#> 4  FC_1-2.Interneuron_CGE        98 0.009983947   1.064012 0.039942444
#> 5  FC_1-3.Interneuron_CGE        85 0.004671113   1.029455 0.651009137
#> 6  FC_1-4.Interneuron_CGE        98 0.006406322   1.040616 0.400647777
#>          FDR       cell_type
#> 1 0.01357969 Interneuron_CGE
#> 2 0.41470245 Interneuron_CGE
#> 3 0.48316072 Interneuron_CGE
#> 4 0.05882433 Interneuron_CGE
#> 5 0.66749038 Interneuron_CGE
#> 6 0.45707704 Interneuron_CGE
```

Plot out the result:

```
plot_manhattan_enrich(res, sig.cutoff = .05, label.topn = 5)
```

![](data:image/png;base64...)

We can clearly find that Microglia (FC\_11-1.Microglia) is the most transcriptionally enriched
when using Logistic Regression analysis. The result is clear and sound because
proliferation and activation of Microglia in the brain is a known feature of
Alzheimer’s Disease (AD).

LRcell is used to give a hint on which cell types are potentially involved in diseases when a paired
scRNA-seq and bulk RNA-seq experiments are unavailable. Thus, LRcell can be applied to the considerable
amount of bulk DEG experiments to shed light on biological discoveries.

## 2.3 Calculate gene enrichment scores from expression dataframe

The gene enrichment score calculation is based on algorithm proposed in (Marques et al. [2016](#ref-marques2016oligodendrocyte)),
which takes both enrichment of genes in certain cell types and fraction of cells expressing the gene into
consideration. If interested, please take a look at the **Supplementary Materials** in the original paper.

`LRcell_gene_enriched_scores()` function takes the gene-by-cell expression matrix and a cell-type annotation as input,
which means cell type assignments should be done first. The columns of the expression matrix
should be in accordance with cell names in the annotation vector.

Take a randomly-generated data as example.

```
# print out the generated expression matrix
print(sim.expr)
#>       cell1 cell2 cell3 cell4 cell5 cell6 cell7 cell8 cell9 cell10
#> gene1     3     0     2     8    10     6     1     0     0      2
#> gene2     7     5     8     1     0     5     2     3     2      1
#> gene3     8    10     6     7     8     9     5     8     6      8

# print out the cell-type annotation
print(sim.annot)
#>       cell1       cell2       cell3       cell4       cell5       cell6
#> "celltype1" "celltype1" "celltype1" "celltype2" "celltype2" "celltype2"
#>       cell7       cell8       cell9      cell10
#> "celltype3" "celltype3" "celltype3" "celltype3"
```

This toy example contains 3 genes and 10 cells. As you can tell from the matrix, **gene1** is
a marker gene of **celltype2**; **gene2** is a marker gene of **celltype1**; **gene3** is a house keeping gene.

```
# generating the enrichment score
enriched_res <- LRcell_gene_enriched_scores(expr = sim.expr,
                            annot = sim.annot, parallel = FALSE)
#> Generate enrichment score for each gene..
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
#> total gene number: 3
enriched_res
#>       celltype1 celltype2 celltype3
#> gene1 0.3472222 2.5000000 0.1171875
#> gene2 1.9607843 0.3921569 0.5882353
#> gene3 1.0666667 1.0666667 0.9000000
```

According to the result, it is a gene-by-celltype dataframe indicating the enrichment score of genes in different cell type.
Since **gene2** is a marker gene of **celltype1**, thus it has the highest enrichment score.

When choosing marker genes using top 1 as threshold:

```
marker_res <- get_markergenes(enriched.g = enriched_res,
                method = "LR", topn=1)
marker_res
#> $celltype1
#> [1] "gene2"
#>
#> $celltype2
#> [1] "gene1"
#>
#> $celltype3
#> [1] "gene3"
```

# 3 SessionInfo

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
#> [1] LRcellTypeMarkers_1.17.0 LRcell_1.18.0            ExperimentHub_3.0.0
#> [4] AnnotationHub_4.0.0      BiocFileCache_3.0.0      dbplyr_2.5.1
#> [7] BiocGenerics_0.56.0      generics_0.1.4           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      gtable_0.3.6         xfun_0.53
#>  [4] bslib_0.9.0          ggplot2_4.0.0        httr2_1.2.1
#>  [7] ggrepel_0.9.6        Biobase_2.70.0       vctrs_0.6.5
#> [10] tools_4.5.1          stats4_4.5.1         curl_7.0.0
#> [13] parallel_4.5.1       tibble_3.3.0         AnnotationDbi_1.72.0
#> [16] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
#> [19] RColorBrewer_1.1-3   S7_0.2.0             S4Vectors_0.48.0
#> [22] lifecycle_1.0.4      compiler_4.5.1       farver_2.1.2
#> [25] Biostrings_2.78.0    tinytex_0.57         Seqinfo_1.0.0
#> [28] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
#> [31] yaml_2.3.10          pillar_1.11.1        crayon_1.5.3
#> [34] jquerylib_0.1.4      BiocParallel_1.44.0  cachem_1.1.0
#> [37] magick_2.9.0         tidyselect_1.2.1     digest_0.6.37
#> [40] purrr_1.1.0          dplyr_1.1.4          bookdown_0.45
#> [43] BiocVersion_3.22.0   labeling_0.4.3       fastmap_1.2.0
#> [46] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
#> [49] dichromat_2.0-0.1    withr_3.0.2          filelock_1.0.3
#> [52] scales_1.4.0         rappdirs_0.3.3       bit64_4.6.0-1
#> [55] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
#> [58] bit_4.6.0            png_0.1-8            memoise_2.0.1
#> [61] evaluate_1.0.5       knitr_1.50           IRanges_2.44.0
#> [64] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
#> [67] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
#> [70] R6_2.6.1
```

# References

Hao, Yuhan, Stephanie Hao, Erica Andersen-Nissen, William M Mauck, Shiwei Zheng, Andrew Butler, Maddie Jane Lee, et al. 2020. “Integrated Analysis of Multimodal Single-Cell Data.” *bioRxiv*.

Marques, Sueli, Amit Zeisel, Simone Codeluppi, David van Bruggen, Ana Mendanha Falcão, Lin Xiao, Huiliang Li, et al. 2016. “Oligodendrocyte Heterogeneity in the Mouse Juvenile and Adult Central Nervous System.” *Science* 352 (6291): 1326–9.

Nagy, Corina, Malosree Maitra, Arnaud Tanti, Matthew Suderman, Jean-Francois Théroux, Maria Antonietta Davoli, Kelly Perlman, et al. 2020. “Single-Nucleus Transcriptomics of the Prefrontal Cortex in Major Depressive Disorder Implicates Oligodendrocyte Precursor Cells and Excitatory Neurons.” *Nature Neuroscience*, 1–11.

Sartor, Maureen A, George D Leikauf, and Mario Medvedovic. 2009. “LRpath: A Logistic Regression Approach for Identifying Enriched Biological Groups in Gene Expression Data.” *Bioinformatics* 25 (2): 211–17.

Saunders, Arpiar, Evan Z Macosko, Alec Wysoker, Melissa Goldman, Fenna M Krienen, Heather de Rivera, Elizabeth Bien, et al. 2018. “Molecular Diversity and Specializations Among the Cells of the Adult Mouse Brain.” *Cell* 174 (4): 1015–30.

Swarup, Vivek, Flora I Hinz, Jessica E Rexach, Ken-ichi Noguchi, Hiroyoshi Toyoshiba, Akira Oda, Keisuke Hirai, et al. 2019. “Identification of Evolutionarily Conserved Gene Networks Mediating Neurodegenerative Dementia.” *Nature Medicine* 25 (1): 152–64.