# Build functional gene modules with GNET2

#### Chen Chen

#### 2025-10-30

## 1. Introduction

GNET2 is a R package used for build regulator network and cluster genes to functional groups with E-M process. It iterative perform TF assigning and Gene assigning, until the assignment of genes did not change, or max number of iterations is reached.

## 2. Installation

To install, open R and type:

```
install.packages("devtools")
library("devtools")
install_github("chrischen1/GNET2")
```

## 3. Build module networks

We first generate random expression data and a list of regulator gene names.

The input is typically a p by n matrix of expression data of p genes and n samples, for example log2 RPKM from RNA-Seq.

```
set.seed(2)
init_group_num = 8
init_method = 'boosting'
exp_data <- matrix(rnorm(300*12),300,12)
reg_names <- paste0('TF',1:20)
rownames(exp_data) <- c(reg_names,paste0('gene',1:(nrow(exp_data)-length(reg_names))))
colnames(exp_data) <- paste0('condition_',1:ncol(exp_data))
```

For the list of potential regulator genes, they are usually available from databases. For example, the PlantTFDB (<http://planttfdb.gao-lab.org/download.php>) curated lists of transcription factors in 156 species, and this information can be imported by the follow steps:

```
url <- "http://planttfdb.gao-lab.org/download/TF_list/Ath_TF_list.txt.gz"
dest_file <- './Ath_TF_list.txt.gz'
download.file(url, destfile)
reg_names <- read.table(gzfile(destfile),sep="\t",header = T,as.is = T)$Gene_ID
```

The module construction process make take a few time, depending on the size of data and maximum iterations allowed.

```
gnet_result <- gnet(exp_data,reg_names,init_method,init_group_num,heuristic = TRUE)
#> Determining initial group number...
#> Building module networks...
#> Iteration 1
#> Iteration 2
#> Iteration 3
#> Iteration 4
#> Iteration 5
#> Converged.
#> Generating final network modules...
#> Done.
```

## 4. Plot the modules and trees

Plot the regulators module and heatmap of the expression inferred downstream genes for each sample. It can be interpreted as two parts: the bars at the top shows how samples are split by the regression tree and the heatmap at the bottom shows how downstream genes are regulated by each subgroup determined by the regulators.

```
plot_gene_group(gnet_result,group_idx = 1,plot_leaf_labels = T)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the GNET2 package.
#>   Please report the issue at <https://github.com/chrischen1/GNET2/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

It is also possible to compare the clustering of GNET2 with experiment conditions by providing the labels of conditions

```
exp_labels = rep(paste0('Exp_',1:4),each = 3)
plot_gene_group(gnet_result,group_idx = 1,group_labels = exp_labels)
```

![](data:image/png;base64...)

The similarity between the clusters from each module of GNET2 and experiment conditions can be quantified by Adjuster Rand Index (for categorical labels) or the inverse of K-L Divergence (for ordinal labels, e.g. dosage,time points). For both cases, significant P values suggests high similarity between the grouping of the modules and the label information provided by the user.

```
exp_labels_factor = as.numeric(factor(exp_labels))

print('Similarity to categorical experimental conditions of each module:')
#> [1] "Similarity to categorical experimental conditions of each module:"
print(similarity_score(gnet_result,exp_labels_factor))
#> $score
#> [1]  0.06201550 -0.10852713  0.02531646  0.11814346  0.40310078 -0.06751055
#> [7] -0.16033755
#>
#> $p_value
#> [1] 0.276 0.793 0.328 0.138 0.001 0.636 0.920

print('Similarity to ordinal experimental conditions of each module:')
#> [1] "Similarity to ordinal experimental conditions of each module:"
print(similarity_score(gnet_result,exp_labels_factor),ranked=TRUE)
#> $score
#> [1]  0.06201550 -0.10852713  0.02531646  0.11814346  0.40310078 -0.06751055
#> [7] -0.16033755
#>
#> $p_value
#> [1] 0.264 0.783 0.319 0.144 0.003 0.644 0.904
```

Plot the tree of the first group

```
plot_tree(gnet_result,group_idx = 1)
```

Plot the correlation of each group and auto detected knee point.

```
group_above_kn <- plot_group_correlation(gnet_result)
```

![](data:image/png;base64...)

```
print(group_above_kn)
#> [1] 2 4
```

The group IDs in group\_above\_kn can been used as a list of groups with correlation higher than the knee point. You may consider use them only for further analysis.

## 5. extract information from the GNET2 output

Show the total number of modules

```
print('Total number of modules:')
#> [1] "Total number of modules:"
print(gnet_result$modules_count)
#> [1] 7
```

Show the regulatory genes and target genes in the first module

```
group_index = 1
print('Regulators in module 1:')
#> [1] "Regulators in module 1:"
print(gnet_result$regulators[[group_index]])
#> [1] "TF19" "TF14" "TF17"
print('Targets in module 1:')
#> [1] "Targets in module 1:"
print(gnet_result$target_genes[[group_index]])
#>  [1] "gene1"   "gene13"  "gene16"  "gene17"  "gene36"  "gene37"  "gene39"
#>  [8] "gene43"  "gene45"  "gene52"  "gene73"  "gene81"  "gene92"  "gene108"
#> [15] "gene113" "gene126" "gene129" "gene139" "gene141" "gene147" "gene149"
#> [22] "gene151" "gene152" "gene158" "gene161" "gene168" "gene170" "gene173"
#> [29] "gene185" "gene189" "gene200" "gene206" "gene209" "gene216" "gene218"
#> [36] "gene222" "gene244" "gene250" "gene252" "gene264" "gene267" "gene269"
#> [43] "gene275" "gene277" "gene278"
```

Return the interactions and their scores as adjacency matrix

```
mat <- extract_edges(gnet_result)
#> Warning: `group_by_()` was deprecated in dplyr 0.7.0.
#> ℹ Please use `group_by()` instead.
#> ℹ See vignette('programming') for more help
#> ℹ The deprecated feature was likely used in the GNET2 package.
#>   Please report the issue at <https://github.com/chrischen1/GNET2/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
print(dim(mat))
#> [1]  20 300
```

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
#> [1] GNET2_1.26.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DiagrammeR_1.0.11           sass_0.4.10
#>  [3] generics_0.1.4              SparseArray_1.10.0
#>  [5] stringi_1.8.7               lattice_0.22-7
#>  [7] digest_0.6.37               magrittr_2.0.4
#>  [9] evaluate_1.0.5              grid_4.5.1
#> [11] RColorBrewer_1.1-3          fastmap_1.2.0
#> [13] xgboost_1.7.11.1            plyr_1.8.9
#> [15] jsonlite_2.0.0              Matrix_1.7-4
#> [17] purrr_1.1.0                 scales_1.4.0
#> [19] jquerylib_0.1.4             abind_1.4-8
#> [21] cli_3.6.5                   crayon_1.5.3
#> [23] rlang_1.1.6                 XVector_0.50.0
#> [25] Biobase_2.70.0              visNetwork_2.1.4
#> [27] withr_3.0.2                 cachem_1.1.0
#> [29] DelayedArray_0.36.0         yaml_2.3.10
#> [31] S4Arrays_1.10.0             tools_4.5.1
#> [33] reshape2_1.4.4              dplyr_1.1.4
#> [35] ggplot2_4.0.0               SummarizedExperiment_1.40.0
#> [37] BiocGenerics_0.56.0         vctrs_0.6.5
#> [39] R6_2.6.1                    matrixStats_1.5.0
#> [41] stats4_4.5.1                lifecycle_1.0.4
#> [43] Seqinfo_1.0.0               stringr_1.5.2
#> [45] S4Vectors_0.48.0            htmlwidgets_1.6.4
#> [47] IRanges_2.44.0              pkgconfig_2.0.3
#> [49] pillar_1.11.1               bslib_0.9.0
#> [51] gtable_0.3.6                data.table_1.17.8
#> [53] glue_1.8.0                  Rcpp_1.1.0
#> [55] xfun_0.53                   tibble_3.3.0
#> [57] GenomicRanges_1.62.0        tidyselect_1.2.1
#> [59] rstudioapi_0.17.1           MatrixGenerics_1.22.0
#> [61] knitr_1.50                  dichromat_2.0-0.1
#> [63] farver_2.1.2                igraph_2.2.1
#> [65] htmltools_0.5.8.1           labeling_0.4.3
#> [67] rmarkdown_2.30              compiler_4.5.1
#> [69] S7_0.2.0
```