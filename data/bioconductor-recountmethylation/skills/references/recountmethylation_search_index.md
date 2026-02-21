# Nearest neighbors analysis for DNAm arrays

#### Sean K. Maden

#### 30 October, 2025

* [Background: search indexes for biological data](#background-search-indexes-for-biological-data)
* [Index samples on dimension-reduced data](#index-samples-on-dimension-reduced-data)
  + [Virtual environment setup](#virtual-environment-setup)
  + [Perform dimensionality reduction on DNAm data](#perform-dimensionality-reduction-on-dnam-data)
  + [Make a new HNSW search index](#make-a-new-hnsw-search-index)
* [Query nearest neighbors in the search index](#query-nearest-neighbors-in-the-search-index)
  + [Get nearest neighbors from search index queries](#get-nearest-neighbors-from-search-index-queries)
  + [Inspect query results](#inspect-query-results)
* [Plot metadata labels among nearest neighbors](#plot-metadata-labels-among-nearest-neighbors)
  + [Metadata label frequency among neighbors from a single query](#metadata-label-frequency-among-neighbors-from-a-single-query)
  + [Distribution of neighbors labeled whole blood across queries](#distribution-of-neighbors-labeled-whole-blood-across-queries)
* [Distributions of multiple labels and queries](#distributions-of-multiple-labels-and-queries)
* [Session Info](#session-info)
* [Works Cited](#works-cited)

```
## $recountmethylation
##  [1] "limma"
##  [2] "gridExtra"
##  [3] "knitr"
##  [4] "recountmethylation"
##  [5] "HDF5Array"
##  [6] "h5mread"
##  [7] "rhdf5"
##  [8] "DelayedArray"
##  [9] "SparseArray"
## [10] "S4Arrays"
## [11] "abind"
## [12] "Matrix"
## [13] "ggplot2"
## [14] "minfiDataEPIC"
## [15] "IlluminaHumanMethylationEPICanno.ilm10b2.hg19"
## [16] "IlluminaHumanMethylationEPICmanifest"
## [17] "minfiData"
## [18] "IlluminaHumanMethylation450kanno.ilmn12.hg19"
## [19] "IlluminaHumanMethylation450kmanifest"
## [20] "minfi"
## [21] "bumphunter"
## [22] "locfit"
## [23] "parallel"
## [24] "iterators"
## [25] "foreach"
## [26] "Biostrings"
## [27] "XVector"
## [28] "SummarizedExperiment"
## [29] "Biobase"
## [30] "MatrixGenerics"
## [31] "matrixStats"
## [32] "GenomicRanges"
## [33] "Seqinfo"
## [34] "IRanges"
## [35] "S4Vectors"
## [36] "stats4"
## [37] "BiocGenerics"
## [38] "generics"
## [39] "BiocStyle"
## [40] "stats"
## [41] "graphics"
## [42] "grDevices"
## [43] "utils"
## [44] "datasets"
## [45] "methods"
## [46] "base"
##
## $basilisk
##  [1] "basilisk"
##  [2] "reticulate"
##  [3] "limma"
##  [4] "gridExtra"
##  [5] "knitr"
##  [6] "recountmethylation"
##  [7] "HDF5Array"
##  [8] "h5mread"
##  [9] "rhdf5"
## [10] "DelayedArray"
## [11] "SparseArray"
## [12] "S4Arrays"
## [13] "abind"
## [14] "Matrix"
## [15] "ggplot2"
## [16] "minfiDataEPIC"
## [17] "IlluminaHumanMethylationEPICanno.ilm10b2.hg19"
## [18] "IlluminaHumanMethylationEPICmanifest"
## [19] "minfiData"
## [20] "IlluminaHumanMethylation450kanno.ilmn12.hg19"
## [21] "IlluminaHumanMethylation450kmanifest"
## [22] "minfi"
## [23] "bumphunter"
## [24] "locfit"
## [25] "parallel"
## [26] "iterators"
## [27] "foreach"
## [28] "Biostrings"
## [29] "XVector"
## [30] "SummarizedExperiment"
## [31] "Biobase"
## [32] "MatrixGenerics"
## [33] "matrixStats"
## [34] "GenomicRanges"
## [35] "Seqinfo"
## [36] "IRanges"
## [37] "S4Vectors"
## [38] "stats4"
## [39] "BiocGenerics"
## [40] "generics"
## [41] "BiocStyle"
## [42] "stats"
## [43] "graphics"
## [44] "grDevices"
## [45] "utils"
## [46] "datasets"
## [47] "methods"
## [48] "base"
##
## $reticulate
##  [1] "basilisk"
##  [2] "reticulate"
##  [3] "limma"
##  [4] "gridExtra"
##  [5] "knitr"
##  [6] "recountmethylation"
##  [7] "HDF5Array"
##  [8] "h5mread"
##  [9] "rhdf5"
## [10] "DelayedArray"
## [11] "SparseArray"
## [12] "S4Arrays"
## [13] "abind"
## [14] "Matrix"
## [15] "ggplot2"
## [16] "minfiDataEPIC"
## [17] "IlluminaHumanMethylationEPICanno.ilm10b2.hg19"
## [18] "IlluminaHumanMethylationEPICmanifest"
## [19] "minfiData"
## [20] "IlluminaHumanMethylation450kanno.ilmn12.hg19"
## [21] "IlluminaHumanMethylation450kmanifest"
## [22] "minfi"
## [23] "bumphunter"
## [24] "locfit"
## [25] "parallel"
## [26] "iterators"
## [27] "foreach"
## [28] "Biostrings"
## [29] "XVector"
## [30] "SummarizedExperiment"
## [31] "Biobase"
## [32] "MatrixGenerics"
## [33] "matrixStats"
## [34] "GenomicRanges"
## [35] "Seqinfo"
## [36] "IRanges"
## [37] "S4Vectors"
## [38] "stats4"
## [39] "BiocGenerics"
## [40] "generics"
## [41] "BiocStyle"
## [42] "stats"
## [43] "graphics"
## [44] "grDevices"
## [45] "utils"
## [46] "datasets"
## [47] "methods"
## [48] "base"
##
## $HDF5Array
##  [1] "basilisk"
##  [2] "reticulate"
##  [3] "limma"
##  [4] "gridExtra"
##  [5] "knitr"
##  [6] "recountmethylation"
##  [7] "HDF5Array"
##  [8] "h5mread"
##  [9] "rhdf5"
## [10] "DelayedArray"
## [11] "SparseArray"
## [12] "S4Arrays"
## [13] "abind"
## [14] "Matrix"
## [15] "ggplot2"
## [16] "minfiDataEPIC"
## [17] "IlluminaHumanMethylationEPICanno.ilm10b2.hg19"
## [18] "IlluminaHumanMethylationEPICmanifest"
## [19] "minfiData"
## [20] "IlluminaHumanMethylation450kanno.ilmn12.hg19"
## [21] "IlluminaHumanMethylation450kmanifest"
## [22] "minfi"
## [23] "bumphunter"
## [24] "locfit"
## [25] "parallel"
## [26] "iterators"
## [27] "foreach"
## [28] "Biostrings"
## [29] "XVector"
## [30] "SummarizedExperiment"
## [31] "Biobase"
## [32] "MatrixGenerics"
## [33] "matrixStats"
## [34] "GenomicRanges"
## [35] "Seqinfo"
## [36] "IRanges"
## [37] "S4Vectors"
## [38] "stats4"
## [39] "BiocGenerics"
## [40] "generics"
## [41] "BiocStyle"
## [42] "stats"
## [43] "graphics"
## [44] "grDevices"
## [45] "utils"
## [46] "datasets"
## [47] "methods"
## [48] "base"
##
## $ggplot2
##  [1] "basilisk"
##  [2] "reticulate"
##  [3] "limma"
##  [4] "gridExtra"
##  [5] "knitr"
##  [6] "recountmethylation"
##  [7] "HDF5Array"
##  [8] "h5mread"
##  [9] "rhdf5"
## [10] "DelayedArray"
## [11] "SparseArray"
## [12] "S4Arrays"
## [13] "abind"
## [14] "Matrix"
## [15] "ggplot2"
## [16] "minfiDataEPIC"
## [17] "IlluminaHumanMethylationEPICanno.ilm10b2.hg19"
## [18] "IlluminaHumanMethylationEPICmanifest"
## [19] "minfiData"
## [20] "IlluminaHumanMethylation450kanno.ilmn12.hg19"
## [21] "IlluminaHumanMethylation450kmanifest"
## [22] "minfi"
## [23] "bumphunter"
## [24] "locfit"
## [25] "parallel"
## [26] "iterators"
## [27] "foreach"
## [28] "Biostrings"
## [29] "XVector"
## [30] "SummarizedExperiment"
## [31] "Biobase"
## [32] "MatrixGenerics"
## [33] "matrixStats"
## [34] "GenomicRanges"
## [35] "Seqinfo"
## [36] "IRanges"
## [37] "S4Vectors"
## [38] "stats4"
## [39] "BiocGenerics"
## [40] "generics"
## [41] "BiocStyle"
## [42] "stats"
## [43] "graphics"
## [44] "grDevices"
## [45] "utils"
## [46] "datasets"
## [47] "methods"
## [48] "base"
```

This vignette provides instructions to construct and analyze a search index of DNAm array data. The index is made using the `hnswlib` Python library, and the `basilisk` and `reticulate` R/Bioconductor libraries are used to manage Python environments and functions. These methods should be widely usedful for genomics and epigenomics analyses, especially for very large datasets.

# Background: search indexes for biological data

The search index has a similar function to the index of a book. Rather than storing the full/uncompressed data, only the between-entity relations are stored, which enables rapid entity lookup and nearest neighbors analysis while keeping stored file sizes manageable. Many methods for search index construction are available. The Hierarchical Navigable Small World (HNSW) graph method, used below, is fairly new (Malkov and Yashunin (2018)) and was among the overall top performing methods benchmarked in [ANN benchmarks](https://github.com/erikbern/ann-benchmarks) (Aumüller, Bernhardsson, and Faithfull (2018)). HNSW is implemented by the `hnswlib` Python library, which also includes helpful docstrings and a ReadMe to apply the method in practice.

While prior work showed the utility of indexing several types of biomedical data for research, to our knowledge this is the first time support has been provided for R users to make and analyze search indexes of DNAm array data. This vignette walks through a small example using a handful DNAm array samples from blood. Interested users can further access a comprehensive [index](%22https%3A//recount.bio/data/sidict-hnsw__bval-gseadj-fh10k__all-blood-2-platforms.pickle%22) of pre-compiled DNAm array data from blood samples on the [`recountmethylation` server](https://recount.bio/data/). These data were available in the Gene Expression Omnibus (GEO) by March 31, 2021, and they include 13,835 samples run on either the HM450K or EPIC platform.

# Index samples on dimension-reduced data

Make a new search index using sample DNAm array data after performing dimensionality reduction on the data using feature hashing (a.k.a. “the hashing trick”, Weinberger et al. (2010)).

## Virtual environment setup

First, use the `setup_sienv()` function to set up a Python virtual environment named “dnam\_si\_vignette” which contains the required dependencies. Since this function and other related functions are not exported, use `:::` to call it.

For greater reproducibility, specify exact dependency versions e.g. like “numpy==1.20.1”. Install the `hnswlib` (v0.5.1) library to manage search index construction and access. install `pandas` (v1.2.2) and `numpy` (v1.20.1) for data manipulations, and `mmh3` (v3.0.0) for feature hashing. Note certain packages, including `hnswlib`, may only be available in conda repositories for certain operating systems.

```
recountmethylation:::setup_sienv(env.name = "dnam_si_vignette")
```

## Perform dimensionality reduction on DNAm data

Search index efficiency pairs well with dimensionality reduction to enable very rapid queries on large datasets. This section shows how to reduce a dataset of DNAm fractions prior to indexing.

First, save the DNAm fractions (Beta-values) from a `SummarizedExperiment` object, ensuring sample data is in rows and probes are in columns. First, access the DNAm locally from the object `gr-noob_h5se_hm450k-epic-merge_0-0-3`, which is available for download from `recount.bio/data`. Next, identify samples of interest from the sample metadata, which is accessed using `colData()`. After subsetting the samples, store the DNAm fractions (a.k.a. ``Beta-values'') for 100 CpG probes, which we access using`getBeta()`.

First, load the `h5se` object.

```
gr.fname <- "gr-noob_h5se_hm450k-epic-merge_0-0-3"
gr <- HDF5Array::loadHDF5SummarizedExperiment(gr.fname)
md <- as.data.frame(colData(gr)) # get sample metadata
```

Next, identify samples from study GSE67393 (Inoshita et al. (2015)) using the sample metadata object `md`.

```
# identify samples from metadata
gseid <- "GSE67393"
gsmv <- md[md$gse == gseid,]$gsm # get study samples
gsmv <- gsmv[sample(length(gsmv), 10)]
```

For this vignette, select a random subset of whole blood and PBMC samples to analyze. Identify these using the “blood.subgroup” column in `md`.

```
# get random samples by group label
set.seed(1)
mdf <- md[md$blood.subgroup=="PBMC",]
gsmv <- c(gsmv, mdf[sample(nrow(mdf), 20),]$gsm)
mdf <- md[md$blood.subgroup=="whole_blood",]
gsmv <- c(gsmv, mdf[sample(nrow(mdf), 20),]$gsm)
```

For the specified samples of interest, extract DNAm Beta-value fractions for a subset of 100 probes.

```
# norm bvals for probe subset
num.cg <- 100
grf <- gr[,gr$gsm %in% gsmv]; dim(grf)
bval <- getBeta(grf[sample(nrow(grf), num.cg),])
bval <- t(bval) # get transpose
rownames(bval) <- gsub("\\..*", "", rownames(bval)) # format rownames
```

This produced a DNAm matrix of 50 samples by 100 probes, which we’ll save.

```
# save bval table
bval.fpath <- paste0("bval_",num.cg,".csv")
write.csv(bval, file = bval.fpath)
```

Call `get_fh()` to perform feature hashing on the DNAm data. Feature hashing is a dimensionality reduction technique, which here means that it reduces the dataset features/columns (or probes in this case) while preserving beween-sample variances.

Specify the target dimensions for this step using the `ndim` argument. For this small example, reduce the DNAm matrix to about 10% of its original size by setting the target dimensions to 10 (e.g. use `ndim = 10`).

```
# get example table and labels
num.dim <- 10 # target reduced dimensions
fhtable.fpath <- "bval_100_fh10.csv"
recountmethylation:::get_fh(csv_savepath = fhtable.fpath,
                            csv_openpath = bval.fpath,
                            ndim = num.dim)
```

If `ndim` is high, the data is less reduced/compressed but more closely resembles the original uncompressed data, while the opposite is true at lower `ndim`. The exact target dimensions to ultimately use is up to user discretion. In practice, 10,000 dimensions yields a good tradeoff between compression and uncompressed data simliarity for HM450K arrays.

## Make a new HNSW search index

Use `make_si()` to make a new search index. This function calls the `hnswlib` Python package to make a new search index and dictionary using the hashed features file generated above. The resulting search index file has the extension `*.pickle`, since the `pickle` Python library is used to compress the search index binary.

```
# set file paths
si.fname.str <- "new_search_index"
si.fpath <- file.path(si.dpath, paste0(si.fname.str, ".pickle"))
sidict.fpath <- file.path(si.dpath, paste0(si.fname.str, "_dict.pickle"))
# make the new search index
recountmethylation:::make_si(fh_csv_fpath = fhtable.fpath,
                             si_fname = si.fpath,
                             si_dict_fname = sidict.fpath)
```

The tuning parameters `space_val`, `efc_val`, `m_val`, and `ef_val` were selected to work well for DNAm array data, and further details about these parameters can be found in the `hnswlib` package docstrings and ReadMe.

# Query nearest neighbors in the search index

Analyze nearest neighbors returned from a series of queries varying the k number of nearest neighbors from 1 to 20.

## Get nearest neighbors from search index queries

Specify a vector of valid GSM IDs which can be found in the hashed features table `bval_100_fh10.csv` as well as the saved search index `new_search_index.pickle` and dictionary `new_search_index_dictionary.pickle`.

```
query.gsmv <- c("GSM1506297", "GSM1646161", "GSM1646175", "GSM1649753", "GSM1649758", "GSM1649762")
```

Specify the vector `lkval` containing the k numbers of nearest neighbors to return in each query.

Certain query constraints are determined by the seach index properites. First, if each record in a search index includes 100 features (e.g. probes, hashed features, etc.), then queries should include exactly 100 dimensions per queried sample, in the same order as the search index. This is why it is convenient to use the previously compiled hashed features table for queries. Further, the k nearest neighbors to return cannot exceed the total indexed entities, or 50 in this example.

```
lkval <- c(1, 5, 10, 20) # vector of query k values
```

Use `query_si()` to run the query. The path to the hashed feature table `bval_100_fh10.csv` is specified, which is where sample data are accessed for each query.

```
si_fpath <- system.file("extdata", "sitest", package = "recountmethylation")
dfnn <- recountmethylation:::query_si(sample_idv = query.gsmv,
                                      fh_csv_fpath = fhtable.fpath,
                                      si_fname = "new_search_index",
                                      si_fpath = si_fpath,
                                      lkval = lkval)
```

## Inspect query results

The query results were assigned to `dfnn`, which we can now inspect. First show its dimensions.

```
dim(dfnn)
```

`dfnn` has 10 rows, corresponding to the 10 queried sample IDs, and 5 columns. The first column shows the IDs for the queried samples. Columns 2-5 show the results of individual queries, where column names designate the k value for a query as `k=...`.

```
colnames(dfnn)
```

Now consider the query results for the sample in the first row, called “GSM1646161.1607013450.hlink.GSM1646161\_9611518054\_R01C01”. Check the results of the first 3 queries for this sample (k = 1, 5, or 10).

```
unlist(strsplit(dfnn[1,"k=1"], ";"))
```

When k = 1, the sample ID is returned. This is because the query uses the same hashed features data as was used to make the search index, and the search is for a subset of the indexed samples.

```
unlist(strsplit(dfnn[1,"k=5"], ";"))
```

This shows that samples are returned in the order of descending similarity to the queried data. For k = 5, the first sample returned is the same as k = 1, followed by the next 4 nearest neighboring samples.

```
unlist(strsplit(dfnn[1,"k=10"], ";"))
```

For k = 10, the first 5 neighbors are the same as for k = 5, followed by the next 5 nearest neighbors.

# Plot metadata labels among nearest neighbors

This section shows some ways to visualize the results of nearest neighbors queries using the `ggplot2` package.

## Metadata label frequency among neighbors from a single query

Now analyze the type of samples among returned nearest neighbors. Use the `md` object to map labels to returned sample IDs for a single query, e.g. the first row where k = 5.

```
gsmvi <- unlist(strsplit(dfnn[1, "k=5"], ";"))
blood.typev <- md[gsmvi,]$blood.subgroup
```

We see there are 4 whole blood samples, and 1 labeled other/NOS which corresponds to the label for the queried sample.

## Distribution of neighbors labeled whole blood across queries

Now get the distribution of labels across samples for a single k value. We’ll show the distribution of samples with the label “whole\_blood” from the variable “blood.subgroup”, focusing on nearest neighbors returned from the first query with k = 20.

```
dist.wb <- unlist(lapply(seq(nrow(dfnn)), function(ii){
  gsmvi <- unlist(strsplit(dfnn[ii,"k=20"], ";"))
  length(which(md[gsmvi,]$blood.subgroup=="whole_blood"))
}))
```

Now plot the results for whole blood after formatting the results variables. Use a composite violin plot and boxplot to show the results scaled as percentages on the y-axis, including important distribution features such as the median, interquantile range, and outliers.

```
dfp <- data.frame(num.samples = dist.wb)
dfp$perc.samples <- 100*dfp$num.samples/20
dfp$type <- "whole_blood"
ggplot(dfp, aes(x = type, y = perc.samples)) +
  geom_violin() + geom_boxplot(width = 0.2) + theme_bw() +
  ylab("Percent of neighbors") + theme(axis.title.x = element_blank()) +
  scale_y_continuous(labels = scales::percent_format(scale = 1))
```

![](data:image/png;base64...)

Figure 1. Distribution of whole blood label among returned nearest neighbors.

# Distributions of multiple labels and queries

Repeat the above for all three mapped metadata labels. Define a function `get_dfgrp()` to calculate the number of neighbors having each metadata label. This function takes the metadata object `md` as a first argument, and the vector of metadata labels `ugroupv` as the second argument.

For `ugroupv`, specify the three metadata labels of interest identifiable under the `blood.subgroup` column in `md` (e.g. “whole\_blood”, “PBMC”, “other/NOS”).

```
# function to get samples by label
get_dfgrp <- function(md, ugroupv = c("whole_blood", "PBMC", "other/NOS")){
  do.call(rbind, lapply(c("whole_blood", "PBMC", "other/NOS"), function(ugroupi){
    num.grp <- length(which(md[ugroupv,]$blood.subgroup==ugroupi))
    data.frame(num.samples = num.grp, type = ugroupi)
  }))
}
```

For each queried sample, use `get_dfgrp()` to calculate frequencies for metadata labels specified in `ugroupv`. Assign the results to `dfp`.

```
# get samples by label across queries
dfp <- do.call(rbind, lapply(seq(nrow(dfnn)), function(ii){
  get_dfgrp(md = md, unlist(strsplit(dfnn[ii,"k=20"], ";")))
}))
```

Format `dfp`’s variables for plotting, then make the composite violin and boxplots. This will show the three label distributions across queries. The metadata labels will be ordered according to their distribution medians, and the y-axis will reflect the percent of neighbors containing each label.

```
# format dfp variables for plots
dfp$perc.samples <- 100*dfp$num.samples/20
# reorder on medians
medianv <- unlist(lapply(c("whole_blood", "PBMC", "other/NOS"), function(groupi){
  median(dfp[dfp$type==groupi,]$perc.samples)}))
# define legend groups
dfp$`Sample\ntype` <- factor(dfp$type, levels = c("whole_blood", "PBMC", "other/NOS")[order(medianv)])
```

Generate composite violin plots and boxplots for each metadata label.

```
# make new composite plot
ggplot(dfp, aes(x = `Sample\ntype`, y = perc.samples, fill = `Sample\ntype`)) +
  geom_violin() + geom_boxplot(width = 0.2) + theme_bw() +
  ylab("Percent of neighbors") + theme(axis.title.x = element_blank()) +
  scale_y_continuous(labels = scales::percent_format(scale = 1))
```

![](data:image/png;base64...)

Figure 2. Distribution of 3 metadata labels among returned nearest neighbors.

# Session Info

```
utils::sessionInfo()
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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] basilisk_1.22.0
##  [2] reticulate_1.44.0
##  [3] limma_3.66.0
##  [4] gridExtra_2.3
##  [5] knitr_1.50
##  [6] recountmethylation_1.20.0
##  [7] HDF5Array_1.38.0
##  [8] h5mread_1.2.0
##  [9] rhdf5_2.54.0
## [10] DelayedArray_0.36.0
## [11] SparseArray_1.10.0
## [12] S4Arrays_1.10.0
## [13] abind_1.4-8
## [14] Matrix_1.7-4
## [15] ggplot2_4.0.0
## [16] minfiDataEPIC_1.35.0
## [17] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
## [18] IlluminaHumanMethylationEPICmanifest_0.3.0
## [19] minfiData_0.55.0
## [20] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [21] IlluminaHumanMethylation450kmanifest_0.4.0
## [22] minfi_1.56.0
## [23] bumphunter_1.52.0
## [24] locfit_1.5-9.12
## [25] iterators_1.0.14
## [26] foreach_1.5.2
## [27] Biostrings_2.78.0
## [28] XVector_0.50.0
## [29] SummarizedExperiment_1.40.0
## [30] Biobase_2.70.0
## [31] MatrixGenerics_1.22.0
## [32] matrixStats_1.5.0
## [33] GenomicRanges_1.62.0
## [34] Seqinfo_1.0.0
## [35] IRanges_2.44.0
## [36] S4Vectors_0.48.0
## [37] BiocGenerics_0.56.0
## [38] generics_0.1.4
## [39] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] GenomicFeatures_1.62.0    farver_2.1.2
##   [7] rmarkdown_2.30            BiocIO_1.20.0
##   [9] vctrs_0.6.5               multtest_2.66.0
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [15] askpass_1.2.1             tinytex_0.57
##  [17] htmltools_0.5.8.1         curl_7.0.0
##  [19] Rhdf5lib_1.32.0           sass_0.4.10
##  [21] nor1mix_1.3-3             bslib_0.9.0
##  [23] plyr_1.8.9                cachem_1.1.0
##  [25] GenomicAlignments_1.46.0  lifecycle_1.0.4
##  [27] pkgconfig_2.0.3           R6_2.6.1
##  [29] fastmap_1.2.0             digest_0.6.37
##  [31] siggenes_1.84.0           reshape_0.8.10
##  [33] AnnotationDbi_1.72.0      RSQLite_2.4.3
##  [35] base64_2.0.2              filelock_1.0.3
##  [37] labeling_0.4.3            mgcv_1.9-3
##  [39] httr_1.4.7                compiler_4.5.1
##  [41] beanplot_1.3.1            rngtools_1.5.2
##  [43] withr_3.0.2               bit64_4.6.0-1
##  [45] S7_0.2.0                  BiocParallel_1.44.0
##  [47] DBI_1.2.3                 MASS_7.3-65
##  [49] openssl_2.3.4             rjson_0.2.23
##  [51] tools_4.5.1               rentrez_1.2.4
##  [53] glue_1.8.0                quadprog_1.5-8
##  [55] restfulr_0.0.16           nlme_3.1-168
##  [57] rhdf5filters_1.22.0       grid_4.5.1
##  [59] gtable_0.3.6              tzdb_0.5.0
##  [61] preprocessCore_1.72.0     tidyr_1.3.1
##  [63] data.table_1.17.8         hms_1.1.4
##  [65] xml2_1.4.1                pillar_1.11.1
##  [67] genefilter_1.92.0         splines_4.5.1
##  [69] dplyr_1.1.4               lattice_0.22-7
##  [71] survival_3.8-3            rtracklayer_1.70.0
##  [73] bit_4.6.0                 GEOquery_2.78.0
##  [75] annotate_1.88.0           tidyselect_1.2.1
##  [77] bookdown_0.45             xfun_0.53
##  [79] scrime_1.3.5              statmod_1.5.1
##  [81] yaml_2.3.10               evaluate_1.0.5
##  [83] codetools_0.2-20          cigarillo_1.0.0
##  [85] tibble_3.3.0              BiocManager_1.30.26
##  [87] cli_3.6.5                 xtable_1.8-4
##  [89] jquerylib_0.1.4           dichromat_2.0-0.1
##  [91] Rcpp_1.1.0                dir.expiry_1.18.0
##  [93] png_0.1-8                 XML_3.99-0.19
##  [95] readr_2.1.5               blob_1.2.4
##  [97] mclust_6.1.1              doRNG_1.8.6.2
##  [99] sparseMatrixStats_1.22.0  bitops_1.0-9
## [101] scales_1.4.0              illuminaio_0.52.0
## [103] purrr_1.1.0               crayon_1.5.3
## [105] rlang_1.1.6               KEGGREST_1.50.0
```

# Works Cited

Aumüller, Martin, Erik Bernhardsson, and Alexander Faithfull. 2018. “ANN-Benchmarks: A Benchmarking Tool for Approximate Nearest Neighbor Algorithms.” *arXiv:1807.05614 [Cs]*, July. <http://arxiv.org/abs/1807.05614>.

Inoshita, Masatoshi, Shusuke Numata, Atsushi Tajima, Makoto Kinoshita, Hidehiro Umehara, Hidenaga Yamamori, Ryota Hashimoto, Issei Imoto, and Tetsuro Ohmori. 2015. “Sex Differences of Leukocytes DNA Methylation Adjusted for Estimated Cellular Proportions.” *Biology of Sex Differences* 6 (1): 11. <https://doi.org/10.1186/s13293-015-0029-7>.

Malkov, Yu A., and D. A. Yashunin. 2018. “Efficient and Robust Approximate Nearest Neighbor Search Using Hierarchical Navigable Small World Graphs.” *arXiv:1603.09320 [Cs]*, August. <http://arxiv.org/abs/1603.09320>.

Weinberger, Kilian, Anirban Dasgupta, Josh Attenberg, John Langford, and Alex Smola. 2010. “Feature Hashing for Large Scale Multitask Learning.” *arXiv:0902.2206 [Cs]*, February. <http://arxiv.org/abs/0902.2206>.