# CIMICE-R: (Markov) Chain Method to Infer Cancer Evolution

Nicolò Rossi1\*

1Lab. of Computational Biology and Bioinformatics, Department of Mathematics, Computer Science and Physics, University of Udine

\*olocin.issor@gmail.com

#### 6/04/2021

# 1 Introduction

This document is a presentation of the R implementation of the tool [CIMICE](https://github.com/redsnic/tumorEvolutionWithMarkovChains).
It shows the main features of this software and how it is built as a modular pipeline, with the goal of making it easy to change and update.

CIMICE is a tool in the field of tumor phylogenetics and
its goal is to build a Markov Chain (called Cancer Progression Markov Chain, CPMC) in order to model tumor subtypes evolution.
The input of CIMICE is a Mutational Matrix, so a boolean matrix representing altered genes in a
collection of samples. These samples are assumed to be obtained with single-cell DNA analysis techniques and
the tool is specifically written to use the peculiarities of this data for the CMPC construction.

CIMICE data processing and analysis can be divided in four section:

* Input management
* Graph topology reconstruction
* Graph weight computation
* Output presentation

These steps will be presented in the following sections.

## 1.1 Used libraries

This implementation of CIMICE is built as a single library on its own:

```
library(CIMICE)
```

and it requires the following libraries:

*[IRanges](https://bioconductor.org/packages/3.22/IRanges)*

```
# Dataframe manipulation
library(dplyr)
# Plot display
library(ggplot2)
# Improved string operations
library(glue)
# Dataframe manipulation
library(tidyr)
# Graph data management
library(igraph)
# Remove transitive edges on a graph
# library(relations)
# Interactive graph visualization
library(networkD3)
# Interactive graph visualization
library(visNetwork)
# Correlation plot visualization
library(ggcorrplot)
# Functional R programming
library(purrr)
# Graph Visualization
library(ggraph)
# sparse matrices
library(Matrix)
```

# 2 Input management

CIMICE requires a boolean dataframe as input, structured as follows:

* Each column represents a gene
* Each row represents a sample (or a genotype)
* Each 0/1 represents if a given gene is mutated in a given sample

It is possible to load this information from a file. The default input format for CIMICE is the “CAPRI/CAPRESE” *[TRONCO](https://bioconductor.org/packages/3.22/TRONCO)* format:

* The file is a tab or space separated file
* The first line starts with the string “s\g” (or any other word) followed by the list of genes (or loci) to be considered in the analysis
* Each subsequent line starts with a sample identifier string, followed by the bit set representing its genotype

This is a scheme of CIMICE’s input format:

```
s\g       gene_1 gene_2 ... gene_n
sample_1    1      0    ...   0
...
sample_m    1      1    ...   1
```

and this an example on how to load a dataset from the file system:

```
# Read input dataset in CAPRI/CAPRESE format
dataset.big <- read_CAPRI(system.file("extdata", "example.CAPRI", package = "CIMICE", mustWork = TRUE))
```

|  | sfmF | ulaF | dapB | yibT | phnL | ispA |
| --- | --- | --- | --- | --- | --- | --- |
| GCF\_001281685.1\_ASM128168v1\_genomic.fna | 1 | 1 | 0 | 0 | 0 | 0 |
| GCF\_001281725.1\_ASM128172v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001281755.1\_ASM128175v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001281775.1\_ASM128177v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001281795.1\_ASM128179v1\_genomic.fna | 0 | 1 | 0 | 0 | 0 | 0 |
| GCF\_001281815.1\_ASM128181v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |

```
## [1] "ncol: 999  - nrow: 160"
```

Another option is to define directly the dataframe in R. This is made easy by the functions `make_dataset` and `update_df`, used as follows:

```
# genes
dataset <- make_dataset(A,B,C,D) %>%
    # samples
    update_df("S1", 0, 0, 0, 1) %>%
    update_df("S2", 1, 0, 0, 0) %>%
    update_df("S3", 1, 0, 0, 0) %>%
    update_df("S4", 1, 0, 0, 1) %>%
    update_df("S5", 1, 1, 0, 1) %>%
    update_df("S6", 1, 1, 0, 1) %>%
    update_df("S7", 1, 0, 1, 1) %>%
    update_df("S8", 1, 1, 0, 1)
```

with the following outcome:

```
## 8 x 4 Matrix of class "dgeMatrix"
##    A B C D
## S1 0 0 0 1
## S2 1 0 0 0
## S3 1 0 0 0
## S4 1 0 0 1
## S5 1 1 0 1
## S6 1 1 0 1
## S7 1 0 1 1
## S8 1 1 0 1
```

In the case your data is composed by samples with associated frequencies it is possible to use an alternative format
that we call “CAPRIpop”:

```
s/g    gene_1 gene_2 ... gene_n freq
sample_1 1 0 ... 0 freq_s1
...
sample_m 1 1 ... 1 freq_sm
```

where the `freq` column is mandatory and sample must not be repeated. Frequencies
in the `freq` column will be automatically normalized. This format is meant
to be used with the functions `quick_run(dataset, mode="CAPRIpop")` for the
full analysis and `dataset_preprocessing_population(...)` for the preprocessing
stage only. The subsequent operations remain otherwise equal to those
of the default format.

Another option is to compute a mutational matrix directly from a MAF file, which
can be done as follows:

```
#        path to MAF file
read_MAF(system.file("extdata", "paac_jhu_2014_500.maf", package = "CIMICE", mustWork = TRUE))[1:5,1:5]
```

```
## -Reading
## -Validating
## -Silent variants: 49
## -Summarizing
## --Possible FLAGS among top ten genes:
##   HMCN1
## -Processing clinical data
## --Missing clinical data
## -Finished in 0.104s elapsed (0.126s cpu)
```

```
## 5 x 5 sparse Matrix of class "dgCMatrix"
##          CSMD2 C2orf61 DCHS2 DPYS GPR158
## ACINAR28     1       1     .    .      .
## ACINAR27     1       .     .    .      .
## ACINAR25     1       .     .    .      .
## ACINAR02     .       .     1    .      1
## ACINAR13     .       .     1    .      .
```

# 3 Preliminary check of mutations distributions

This implementation of CIMICE includes simple functions to quickly analyze the distributions of mutations among genes and samples.

The following code displays an histogram showing the distribution of the number of mutations hitting a gene:

```
gene_mutations_hist(dataset.big)
```

![](data:image/png;base64...)

And this does the same but from the samples point of view:

```
sample_mutations_hist(dataset.big, binwidth = 10)
```

![](data:image/png;base64...)

## 3.1 Simple procedures of feature selection

In case of huge dataset, it could be necessary to focus only on a subset of the input samples or genes.
The following procedures aim to provide an easy way to do so when the goal is to use the most (or least)
mutated samples or genes.

### 3.1.1 By genes

Keeps the first \(n\) (=100) most mutated genes:

```
select_genes_on_mutations(dataset.big, 100)
```

|  | eptA | yohC | yedK | yeeO | narU | rsxC |
| --- | --- | --- | --- | --- | --- | --- |
| GCF\_001281685.1\_ASM128168v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |
| GCF\_001281725.1\_ASM128172v1\_genomic.fna | 1 | 1 | 1 | 0 | 0 | 0 |
| GCF\_001281755.1\_ASM128175v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |
| GCF\_001281775.1\_ASM128177v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 0 |
| GCF\_001281795.1\_ASM128179v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |
| GCF\_001281815.1\_ASM128181v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |

```
## [1] "ncol: 100  - nrow: 160"
```

### 3.1.2 By samples

Keeps the first \(n\) (=100) least mutated samples:

```
select_samples_on_mutations(dataset.big, 100, desc = FALSE)
```

|  | sfmF | ulaF | dapB | yibT | phnL | ispA |
| --- | --- | --- | --- | --- | --- | --- |
| GCF\_001281725.1\_ASM128172v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001281855.1\_ASM128185v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001281815.1\_ASM128181v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001281775.1\_ASM128177v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001607735.1\_ASM160773v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |
| GCF\_001297965.1\_ASM129796v1\_genomic.fna | 0 | 0 | 0 | 0 | 0 | 0 |

```
## [1] "ncol: 999  - nrow: 100"
```

## 3.2 Both selections

It is easy to combine these selections by using the pipe operator `%>%`:

```
select_samples_on_mutations(dataset.big , 100, desc = FALSE) %>% select_genes_on_mutations(100)
```

|  | eptA | yohC | yedK | argK | yeeO | narU |
| --- | --- | --- | --- | --- | --- | --- |
| GCF\_001281725.1\_ASM128172v1\_genomic.fna | 1 | 1 | 1 | 1 | 0 | 0 |
| GCF\_001281855.1\_ASM128185v1\_genomic.fna | 1 | 1 | 1 | 1 | 0 | 0 |
| GCF\_001281815.1\_ASM128181v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |
| GCF\_001281775.1\_ASM128177v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |
| GCF\_001607735.1\_ASM160773v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |
| GCF\_001297965.1\_ASM129796v1\_genomic.fna | 1 | 1 | 1 | 1 | 1 | 1 |

```
## [1] "ncol: 100  - nrow: 100"
```

## 3.3 Correlation plot

It may be of interest to show correlations among gene or sample mutations. The library `corrplots` provides an easy way to do so by preparing an
heatmap based on the correlation matrix. We can show these plots by using the following comands:

gene mutations correlation:

```
corrplot_genes(dataset)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the ggcorrplot package.
##   Please report the issue at <https://github.com/kassambara/ggcorrplot/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

sample mutations correlation:

```
corrplot_samples(dataset)
```

![](data:image/png;base64...)

## 3.4 Group equal genotypes

The first step of the CIMICE algorithm is based on grouping the genotypes contained in the dataset to compute their observed frequencies.
In this implementation we used a simple approach using the library `dplyr`. However, this solution is not optimal from an efficiency
point of view and might be problematic with very large datasets. An Rcpp implementation is planned and, moreover, it is possible to easily modify
this step by changing the algorithm as long as its output is a dataframe containing only unique genotypes with an additional column named “freq” for the observed frequencies count.

```
# groups and counts equal genotypes
compactedDataset <- compact_dataset(dataset)
```

```
## $matrix
## 5 x 4 Matrix of class "dgeMatrix"
##    A B C D
## S1 0 0 0 1
## S2 1 0 0 0
## S4 1 0 0 1
## S7 1 0 1 1
## S5 1 1 0 1
##
## $counts
## [1] 1 2 1 1 3
##
## $row_names
## $row_names[[1]]
## [1] "S1"
##
## $row_names[[2]]
## [1] "S2, S3"
##
## $row_names[[3]]
## [1] "S4"
##
## $row_names[[4]]
## [1] "S7"
##
## $row_names[[5]]
## [1] "S5, S6, S8"
```

# 4 Graph topology construction

The subsequent stage goal is to prepare the topology for the final Cancer Progression Markov Chain. We racall that this topology is assumed to be
a DAG. These eraly steps are required to prepare the information necessary for this and the following pahses.

Convert dataset to matricial form:

```
samples <- compactedDataset$matrix
```

```
## 5 x 4 Matrix of class "dgeMatrix"
##    A B C D
## S1 0 0 0 1
## S2 1 0 0 0
## S4 1 0 0 1
## S7 1 0 1 1
## S5 1 1 0 1
```

Extract gene names:

```
genes <- colnames(samples)
```

```
## [1] "A" "B" "C" "D"
```

Compute observed frequency of each genotype:

```
freqs <- compactedDataset$counts/sum(compactedDataset$counts)
```

```
## [1] 0.125 0.250 0.125 0.125 0.375
```

Add “Clonal” genotype to the dataset (if not present) that will be used as DAG root:

```
# prepare node labels listing the mutated genes for each node
labels <- prepare_labels(samples, genes)
if( is.null(compactedDataset$row_names) ){
    compactedDataset$row_names <- rownames(compactedDataset$matrix)
}
matching_samples <- compactedDataset$row_names
# fix Colonal genotype absence, if needed
fix <- fix_clonal_genotype(samples, freqs, labels, matching_samples)
samples = fix[["samples"]]
freqs = fix[["freqs"]]
labels = fix[["labels"]]
matching_samples <- fix[["matching_samples"]]
```

```
## 6 x 4 Matrix of class "dgeMatrix"
##        A B C D
## S1     0 0 0 1
## S2     1 0 0 0
## S4     1 0 0 1
## S7     1 0 1 1
## S5     1 1 0 1
## Clonal 0 0 0 0
```

Build the topology of the graph based on the “superset” relation:

```
# compute edges based on subset relation
edges <- build_topology_subset(samples)
```

and finally prepare and show with the current topology of the graph:

```
# remove transitive edges and prepare igraph object
g <- build_subset_graph(edges, labels)
```

that can be (badly) plotted using basic igraph:

![](data:image/png;base64...)

# 5 Graph weight computation

In this sections, it is shown how to call the procedures to the four steps weight computation used in CIMICE. This is in fact based in computing
“UP” weights, normalized “UP” weights, “DOWN” weights and normalized “DOWN” weights.

The process is based on the graph adjacency matrix “A”:

```
A <- as_adj(g)
```

```
## Warning: `as_adj()` was deprecated in igraph 2.1.0.
## ℹ Please use `as_adjacency_matrix()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## 6 x 6 sparse Matrix of class "dgCMatrix"
##
## [1,] . . 1 . . .
## [2,] . . 1 . . .
## [3,] . . . 1 1 .
## [4,] . . . . . .
## [5,] . . . . . .
## [6,] 1 1 . . . .
```

and on the number of successors for each node:

```
no.of.children <- get_no_of_children(A,g)
```

```
## [1] 1 1 2 0 0 2
```

### 5.0.1 “UP” weights

\[W\_{up}(\langle a,b \rangle \in E) = \frac{1}{ |\Lambda\_a|}(P(a) + \sum\_{x\in \Pi\_a}W\_{up}(\langle x,a \rangle)) \]
given that \(\Lambda\_a\) and \(\Pi\_a\) denote the set of children of a node \(a\) and the set of parents of a node \(a\) respectively and that \(P(a)\) is the observed frequency of node \(a\).

```
upWeights <- computeUPW(g, freqs, no.of.children, A)
```

```
## [1] 0.000 0.000 0.125 0.250 0.250 0.250
```

### 5.0.2 “UP” weights normalization

\[\overline{W}\_{up}(\langle a,b \rangle \in E\_1) = \begin{cases}
1 & \mbox{if $a[0]=\emptyset$} \\
\frac{ W\_{up}(\langle a,b \rangle \in E)}{\sum\_{x \in \Pi\_b} W\_{up}(\langle x,b \rangle)} & \mbox{else}
\end{cases}\]

```
normUpWeights <- normalizeUPW(g, freqs, no.of.children, A, upWeights)
```

```
## [1] 1.0000000 1.0000000 0.3333333 0.6666667 1.0000000 1.0000000
```

### 5.0.3 “DOWN” Weights

\[W\_{down}(\langle a,b \rangle) = \overline{W}\_{up}(\langle a,b \rangle)(P(b) + \sum\_{x\in \Lambda\_b}W\_{down}(\langle b,x \rangle))\]

```
downWeights <- computeDWNW(g, freqs, no.of.children, A, normUpWeights)
```

```
## [1] 0.3333333 0.6666667 0.2083333 0.4166667 0.1250000 0.3750000
```

### 5.0.4 “DOWN” weights normalization

\[ P(\langle a,b \rangle) = \overline{W}\_{down}(\langle a,b \rangle) = \frac{W\_{down}(\langle a,b \rangle)}{\sum\_{x\in \Lambda\_a}{W\_{down}(\langle a,x \rangle)}} \]

```
normDownWeights <- normalizeDWNW(g, freqs, no.of.children, A, downWeights)
```

```
## [1] 0.3333333 0.6666667 1.0000000 1.0000000 0.2500000 0.7500000
```

# 6 Output presentation

To better show the results of the analysis there were prepared three ouput methods based on three different libraries: `ggraph`, `networkD3` and
`visNetwork`. These libraries improve the dafault `igraph` output visualization. Note that output interaction is disabled in this document,
check the Quick Guide instead.

This is the output based on `ggraph`, it is ideal for small graphs but, for legibility reasons, it is better not to use it with long labels.

```
draw_ggraph(quick_run(example_dataset()))
```

![](data:image/png;base64...)

The `networkD3` is a quite valid interactive approach, but it lacks the option to draw labels on edges, limiting the representation to thicker or thinner edges.

```
draw_networkD3(quick_run(example_dataset()))
```

![](data:image/png;base64...)

The `visNetwork` approach is overall the best for interactive purposes. It allows almost arbitrary long labels, as it is compatible with `HTML` elements and
in particular with textboxes and the “hovering condition” for vertex and edges.

```
draw_visNetwork(quick_run(example_dataset()))
```

![](data:image/png;base64...)

Finally, it is also possible to export CIMICE’s output to the standard [dot format](https://en.wikipedia.org/wiki/DOT_%28graph_description_language%29)
for use in other visualization applications.

```
cat(to_dot(quick_run(example_dataset())))
```

```
## digraph G{
## 1[label="S1"]
## 2[label="S2, S3"]
## 3[label="S4"]
## 4[label="S7"]
## 5[label="S5, S6, S8"]
## 6[label="Clonal"]
## 6 -> 1[label="0.333"]
## 6 -> 2[label="0.667"]
## 1 -> 3[label="1"]
## 2 -> 3[label="1"]
## 3 -> 4[label="0.25"]
## 3 -> 5[label="0.75"]
## }
```

## 6.1 Session information

This vignette was prepared using a R session with the following specifications:

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] Matrix_1.7-4       ggraph_2.2.2       purrr_1.1.0        ggcorrplot_0.1.4.1
##  [5] visNetwork_2.1.4   networkD3_0.4.1    igraph_2.2.1       tidyr_1.3.1
##  [9] glue_1.8.0         ggplot2_4.0.0      dplyr_1.1.4        CIMICE_1.18.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] htmlwidgets_1.6.4   ggrepel_0.9.6       lattice_0.22-7
##  [7] vctrs_0.6.5         tools_4.5.1         generics_0.1.4
## [10] tibble_3.3.0        pkgconfig_2.0.3     data.table_1.17.8
## [13] RColorBrewer_1.1-3  S7_0.2.0            assertthat_0.2.1
## [16] lifecycle_1.0.4     stringr_1.5.2       compiler_4.5.1
## [19] farver_2.1.2        tinytex_0.57        data.tree_1.2.0
## [22] ggforce_0.5.0       graphlayouts_1.2.2  htmltools_0.5.8.1
## [25] sass_0.4.10         yaml_2.3.10         crayon_1.5.3
## [28] pillar_1.11.1       jquerylib_0.1.4     MASS_7.3-65
## [31] cachem_1.1.0        magick_2.9.0        viridis_0.6.5
## [34] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7
## [37] reshape2_1.4.4      bookdown_0.45       labeling_0.4.3
## [40] splines_4.5.1       maftools_2.26.0     polyclip_1.10-7
## [43] fastmap_1.2.0       grid_4.5.1          expm_1.0-0
## [46] cli_3.6.5           magrittr_2.0.4      dichromat_2.0-0.1
## [49] tidygraph_1.3.1     survival_3.8-3      withr_3.0.2
## [52] scales_1.4.0        rmarkdown_2.30      gridExtra_2.3
## [55] memoise_2.0.1       DNAcopy_1.84.0      evaluate_1.0.5
## [58] knitr_1.50          viridisLite_0.4.2   rlang_1.1.6
## [61] Rcpp_1.1.0          tweenr_2.0.3        BiocManager_1.30.26
## [64] jsonlite_2.0.0      plyr_1.8.9          R6_2.6.1
```