# cmapR Tutorial

Ted Natoli\*

\*ted.e.natoli@gmail.com

#### 1/10/2020

#### Abstract

A tutorial on using the cmapR package to parse and maniplate data in various formats used by the Connectivity Map, mainly annotated matrices stored as GCT or GCTX.

#### Package

cmapR 1.22.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Loading the cmapR package](#loading-the-cmapr-package)
* [4 GCT objects in R](#gct-objects-in-r)
  + [4.1 Accessing GCT object components](#accessing-gct-object-components)
  + [4.2 Parsing GCTX files](#parsing-gctx-files)
    - [4.2.1 Parsing the entire file](#parsing-the-entire-file)
    - [4.2.2 Parsing a susbset of the file](#parsing-a-susbset-of-the-file)
  + [4.3 Creating a GCT object from existing workspace objects](#creating-a-gct-object-from-existing-workspace-objects)
  + [4.4 Adding annotations to a GCT object](#adding-annotations-to-a-gct-object)
  + [4.5 Slicing a GCT object](#slicing-a-gct-object)
  + [4.6 Melting GCT objects](#melting-gct-objects)
  + [4.7 Merging two GCT objects](#merging-two-gct-objects)
  + [4.8 Math operations on GCT objects](#math-operations-on-gct-objects)
    - [4.8.1 GCT-specific math functions](#gct-specific-math-functions)
  + [4.9 Writing GCT objects to disk](#writing-gct-objects-to-disk)
  + [4.10 Converting GCT objects to SummarizedExperiment objects](#converting-gct-objects-to-summarizedexperiment-objects)
* [5 Session Info](#session-info)

# 1 Introduction

This notebook will walk through some of the basic functionality in the cmapR package, which is largely centered around working with matrix data in [GCT and GCTX format](https://doi.org/10.1093/bioinformatics/bty784), commonly used by the [Connectivity Map (CMap) project](https://clue.io).

# 2 Installation

The cmapR package can be installed from Bioconductor by running the following commands in an R session.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("cmapR")
```

```
## Bioconductor version 3.22 (BiocManager 1.30.26), R 4.5.1 Patched (2025-08-23
##   r88802)
```

```
## Warning: package(s) not installed when version(s) same as or greater than current; use
##   `force = TRUE` to re-install: 'cmapR'
```

cmapR source code can be also obtained from [github](https://github.com/cmap/cmapR).

# 3 Loading the cmapR package

cmapR can be loaded within an R session or script just like any other package.

```
library(cmapR)
```

# 4 GCT objects in R

The main class of objects in `cmapR` is the `GCT` class. The `GCT` object contains a data `matrix` and (optionally) row and column annotations as `data.frame` objects. cmapR has comes with an example GCT object called `ds` (short for dataset). We can view its structure by simply typing its name.

```
ds
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:978, 1:272] -0.524 -0.372 0.578 0.569 1.48 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:978] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. .. ..$ : chr [1:272] "CPC006_A549_6H:BRD-U88459701-000-01-8:10" "CPC020_A375_6H:BRD-A82307304-001-01-8:10" "CPC020_HT29_6H:BRD-A82307304-001-01-8:10" "CPC020_PC3_24H:BRD-A82307304-001-01-8:10" ...
##   ..@ rid    : chr [1:978] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cid    : chr [1:272] "CPC006_A549_6H:BRD-U88459701-000-01-8:10" "CPC020_A375_6H:BRD-A82307304-001-01-8:10" "CPC020_HT29_6H:BRD-A82307304-001-01-8:10" "CPC020_PC3_24H:BRD-A82307304-001-01-8:10" ...
##   ..@ rdesc  :'data.frame':  978 obs. of  6 variables:
##   .. ..$ id            : chr [1:978] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. ..$ is_bing       : int [1:978] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ is_lm         : int [1:978] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ pr_gene_id    : int [1:978] 5720 466 6009 2309 387 3553 427 5898 23365 6657 ...
##   .. ..$ pr_gene_symbol: chr [1:978] "PSME1" "ATF1" "RHEB" "FOXO3" ...
##   .. ..$ pr_gene_title : chr [1:978] "proteasome (prosome, macropain) activator subunit 1 (PA28 alpha)" "activating transcription factor 1" "Ras homolog enriched in brain" "forkhead box O3" ...
##   ..@ cdesc  :'data.frame':  272 obs. of  16 variables:
##   .. ..$ brew_prefix           : chr [1:272] "CPC006_A549_6H" "CPC020_A375_6H" "CPC020_HT29_6H" "CPC020_PC3_24H" ...
##   .. ..$ cell_id               : chr [1:272] "A549" "A375" "HT29" "PC3" ...
##   .. ..$ distil_cc_q75         : num [1:272] 0.18 0.46 0.14 0.57 0.2 ...
##   .. ..$ distil_nsample        : int [1:272] 4 5 4 5 7 5 3 2 2 2 ...
##   .. ..$ distil_ss             : num [1:272] 2.65 3.21 2.14 4.62 2.27 ...
##   .. ..$ id                    : chr [1:272] "CPC006_A549_6H:BRD-U88459701-000-01-8:10" "CPC020_A375_6H:BRD-A82307304-001-01-8:10" "CPC020_HT29_6H:BRD-A82307304-001-01-8:10" "CPC020_PC3_24H:BRD-A82307304-001-01-8:10" ...
##   .. ..$ is_gold               : int [1:272] 0 1 0 1 1 1 1 0 0 1 ...
##   .. ..$ ngenes_modulated_dn_lm: int [1:272] 15 14 4 67 8 95 42 20 14 80 ...
##   .. ..$ ngenes_modulated_up_lm: int [1:272] 10 17 7 50 6 98 19 21 14 36 ...
##   .. ..$ pct_self_rank_q25     : num [1:272] 5.526 1.567 9.072 0 0.353 ...
##   .. ..$ pert_id               : chr [1:272] "BRD-U88459701" "BRD-A82307304" "BRD-A82307304" "BRD-A82307304" ...
##   .. ..$ pert_idose            : chr [1:272] "10 <b5>M" "10 <b5>M" "10 <b5>M" "10 <b5>M" ...
##   .. ..$ pert_iname            : chr [1:272] "atorvastatin" "atorvastatin" "atorvastatin" "atorvastatin" ...
##   .. ..$ pert_itime            : chr [1:272] "6 h" "6 h" "6 h" "24 h" ...
##   .. ..$ pert_type             : chr [1:272] "trt_cp" "trt_cp" "trt_cp" "trt_cp" ...
##   .. ..$ pool_id               : chr [1:272] "epsilon" "epsilon" "epsilon" "epsilon" ...
##   ..@ version: chr(0)
##   ..@ src    : chr "inst/extdata/modzs_n272x978.gctx"
```

`GCT` objects contain the following components, or `slots`.

* `mat` - the data matrix
* `rdesc` - a `data.frame` of row annotations, with one row per matrix row
* `cdesc` - a `data.frame` of column annotations, with one row per matrix column
* `rid` - a character vector of unique row identifiers
* `cid` - a character vector of unique column identifiers
* `src` - a character string indicating the source (usually a file path) of the data

## 4.1 Accessing GCT object components

The components of a `GCT` object can be accessed or modified using a set of accessor functions.

```
# access the data matrix
m <- mat(ds)

# access the row and column metadata
rdesc <- meta(ds, dimension = "row")
cdesc <- meta(ds, dimension = "column")

# access the row and column ids
rid <- ids(ds, dimension = "row")
cid <- ids(ds, dimension = "column")
```

```
# update the matrix data to set some values to zero
# note that the updated matrix must be the of the same dimensions as
# the current matrix
m[1:10, 1:10] <- 0
mat(ds) <- m

# replace row and column metadata
meta(ds, dimension = "row") <- data.frame(x=sample(letters, nrow(m),
                                                   replace=TRUE))
meta(ds, dimension = "column") <- data.frame(x=sample(letters, ncol(m),
                                                   replace=TRUE))

# replace row and column ids
ids(ds, dimension = "row") <- as.character(seq_len(nrow(m)))
ids(ds, dimension = "column") <- as.character(seq_len(ncol(m)))

# and let's look at the modified object
ds
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:978, 1:272] 0 0 0 0 0 0 0 0 0 0 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:978] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. .. ..$ : chr [1:272] "CPC006_A549_6H:BRD-U88459701-000-01-8:10" "CPC020_A375_6H:BRD-A82307304-001-01-8:10" "CPC020_HT29_6H:BRD-A82307304-001-01-8:10" "CPC020_PC3_24H:BRD-A82307304-001-01-8:10" ...
##   ..@ rid    : chr [1:978] "1" "2" "3" "4" ...
##   ..@ cid    : chr [1:272] "1" "2" "3" "4" ...
##   ..@ rdesc  :'data.frame':  978 obs. of  1 variable:
##   .. ..$ x: chr [1:978] "g" "p" "e" "k" ...
##   ..@ cdesc  :'data.frame':  272 obs. of  1 variable:
##   .. ..$ x: chr [1:272] "o" "v" "b" "o" ...
##   ..@ version: chr(0)
##   ..@ src    : chr "inst/extdata/modzs_n272x978.gctx"
```

## 4.2 Parsing GCTX files

You can parse both GCT and GCTX files using the `parse_gctx` method. This method will read the corresponding GCT or GCTX file and return an object of class `GCT` into your R session.

### 4.2.1 Parsing the entire file

If the file is small enough to fit in memory, you can parse the entire file at once.

```
# create a variable to store the path to the GCTX file
# here we'll use a file that's internal to the cmapR package, but
# in practice this could be any valid path to a GCT or GCTX file
ds_path <- system.file("extdata", "modzs_n25x50.gctx", package="cmapR")
my_ds <- parse_gctx(ds_path)
```

```
## reading /tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx
```

```
## done
```

You can view the structure of this newly-created GCT object just by typing its name.

```
my_ds
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:50, 1:25] -1.145 -1.165 0.437 0.139 -0.673 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. .. ..$ : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rid    : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cid    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rdesc  :'data.frame':  50 obs. of  6 variables:
##   .. ..$ id            : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. ..$ is_bing       : int [1:50] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ is_lm         : int [1:50] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ pr_gene_id    : int [1:50] 5720 466 6009 2309 387 3553 427 5898 23365 6657 ...
##   .. ..$ pr_gene_symbol: chr [1:50] "PSME1" "ATF1" "RHEB" "FOXO3" ...
##   .. ..$ pr_gene_title : chr [1:50] "proteasome (prosome, macropain) activator subunit 1 (PA28 alpha)" "activating transcription factor 1" "Ras homolog enriched in brain" "forkhead box O3" ...
##   ..@ cdesc  :'data.frame':  25 obs. of  16 variables:
##   .. ..$ brew_prefix           : chr [1:25] "CPC004_PC3_24H" "BRAF001_HEK293T_24H" "CPC006_HT29_24H" "CVD001_HEPG2_24H" ...
##   .. ..$ cell_id               : chr [1:25] "PC3" "HEK293T" "HT29" "HEPG2" ...
##   .. ..$ distil_cc_q75         : num [1:25] 0.05 0.1 0.17 0.45 0.24 ...
##   .. ..$ distil_nsample        : int [1:25] 5 9 4 3 4 5 2 3 2 2 ...
##   .. ..$ distil_ss             : num [1:25] 2.9 1.88 2.71 4.06 3.83 ...
##   .. ..$ id                    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   .. ..$ is_gold               : int [1:25] 0 0 0 1 1 0 1 0 0 0 ...
##   .. ..$ ngenes_modulated_dn_lm: int [1:25] 11 3 8 38 36 23 12 11 33 13 ...
##   .. ..$ ngenes_modulated_up_lm: int [1:25] 10 7 25 40 16 17 23 14 37 22 ...
##   .. ..$ pct_self_rank_q25     : num [1:25] 26.904 17.125 7.06 0.229 4.686 ...
##   .. ..$ pert_id               : chr [1:25] "BRD-A51714012" "BRD-U73308409" "BRD-U88459701" "BRD-U88459701" ...
##   .. ..$ pert_idose            : chr [1:25] "10 <b5>M" "500 nM" "10 <b5>M" "10 <b5>M" ...
##   .. ..$ pert_iname            : chr [1:25] "venlafaxine" "vemurafenib" "atorvastatin" "atorvastatin" ...
##   .. ..$ pert_itime            : chr [1:25] "24 h" "24 h" "24 h" "24 h" ...
##   .. ..$ pert_type             : chr [1:25] "trt_cp" "trt_cp" "trt_cp" "trt_cp" ...
##   .. ..$ pool_id               : chr [1:25] "epsilon" "epsilon" "epsilon" "epsilon" ...
##   ..@ version: chr(0)
##   ..@ src    : chr "/tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx"
```

As you can see from looking at the `@mat` slot, this small dataset has 50 rows and 25 columns.

### 4.2.2 Parsing a susbset of the file

**Note:** only GCTX files (not GCT) support parsing subsets.

When working with large GCTX files, it is usually not possible to read the entire file into memory all at once. In these cases, it’s helpful to read subsets of the data. These subsets can be defined by numeric row or column index, as shown below.

```
# read just the first 10 columns, using numeric indices
(my_ds_10_columns <- parse_gctx(ds_path, cid=1:10))
```

```
## reading /tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx
```

```
## done
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:50, 1:10] -1.145 -1.165 0.437 0.139 -0.673 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. .. ..$ : chr [1:10] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rid    : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cid    : chr [1:10] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rdesc  :'data.frame':  50 obs. of  6 variables:
##   .. ..$ id            : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. ..$ is_bing       : int [1:50] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ is_lm         : int [1:50] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ pr_gene_id    : int [1:50] 5720 466 6009 2309 387 3553 427 5898 23365 6657 ...
##   .. ..$ pr_gene_symbol: chr [1:50] "PSME1" "ATF1" "RHEB" "FOXO3" ...
##   .. ..$ pr_gene_title : chr [1:50] "proteasome (prosome, macropain) activator subunit 1 (PA28 alpha)" "activating transcription factor 1" "Ras homolog enriched in brain" "forkhead box O3" ...
##   ..@ cdesc  :'data.frame':  10 obs. of  16 variables:
##   .. ..$ brew_prefix           : chr [1:10] "CPC004_PC3_24H" "BRAF001_HEK293T_24H" "CPC006_HT29_24H" "CVD001_HEPG2_24H" ...
##   .. ..$ cell_id               : chr [1:10] "PC3" "HEK293T" "HT29" "HEPG2" ...
##   .. ..$ distil_cc_q75         : num [1:10] 0.05 0.1 0.17 0.45 0.24 ...
##   .. ..$ distil_nsample        : int [1:10] 5 9 4 3 4 5 2 3 2 2
##   .. ..$ distil_ss             : num [1:10] 2.9 1.88 2.71 4.06 3.83 ...
##   .. ..$ id                    : chr [1:10] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   .. ..$ is_gold               : int [1:10] 0 0 0 1 1 0 1 0 0 0
##   .. ..$ ngenes_modulated_dn_lm: int [1:10] 11 3 8 38 36 23 12 11 33 13
##   .. ..$ ngenes_modulated_up_lm: int [1:10] 10 7 25 40 16 17 23 14 37 22
##   .. ..$ pct_self_rank_q25     : num [1:10] 26.904 17.125 7.06 0.229 4.686 ...
##   .. ..$ pert_id               : chr [1:10] "BRD-A51714012" "BRD-U73308409" "BRD-U88459701" "BRD-U88459701" ...
##   .. ..$ pert_idose            : chr [1:10] "10 <b5>M" "500 nM" "10 <b5>M" "10 <b5>M" ...
##   .. ..$ pert_iname            : chr [1:10] "venlafaxine" "vemurafenib" "atorvastatin" "atorvastatin" ...
##   .. ..$ pert_itime            : chr [1:10] "24 h" "24 h" "24 h" "24 h" ...
##   .. ..$ pert_type             : chr [1:10] "trt_cp" "trt_cp" "trt_cp" "trt_cp" ...
##   .. ..$ pool_id               : chr [1:10] "epsilon" "epsilon" "epsilon" "epsilon" ...
##   ..@ version: chr(0)
##   ..@ src    : chr "/tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx"
```

As expected, we see that we’ve now got a 10-column dataset.

More commonly, we’ll want to identify a subset of the data that is of particular interest and read only those rows and/or columns. In either case, we’ll use the `rid` and/or `cid` arguments to `parse_gctx` to extract only the data we want. In this example, we’ll use the GCTX file’s embedded column annotations to identify the columns corresponding to the compound *vemurafenib* and then read only those columns. We can extract these annotations using the `read_gctx_meta` function.

```
# read the column metadata
col_meta <- read_gctx_meta(ds_path, dim="col")

# figure out which signatures correspond to vorinostat by searching the 'pert_iname' column
idx <- which(col_meta$pert_iname=="vemurafenib")

# read only those columns from the GCTX file by using the 'cid' parameter
vemurafenib_ds <- parse_gctx(ds_path, cid=idx)
```

```
## reading /tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx
```

```
## done
```

In the example above we used numeric column indices, but the `rid` and `cid` arguments also accept character vectors of ids. The following is equally valid.

```
# get a vector of character ids, using the id column in col_meta
col_ids <- col_meta$id[idx]
vemurafenib_ds2 <- parse_gctx(ds_path, cid=col_ids)
```

```
## reading /tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx
```

```
## done
```

```
identical(vemurafenib_ds, vemurafenib_ds2)
```

```
## [1] TRUE
```

## 4.3 Creating a GCT object from existing workspace objects

It’s also possible to create a `GCT` object from existing objects in your R workspace. You will minimally need to have a matrix object, but can also optionally include `data.frame`s of row and column annotations. This is done using the `new` constructor function.

```
# initialize a matrix object
# note that you either must assign values to the rownames and colnames
# of the matrix, or pass them,
# as the 'rid' and 'cid' arguments to GCT"
m <- matrix(stats::rnorm(100), ncol=10)
rownames(m) <- letters[1:10]
colnames(m) <- LETTERS[1:10]
(my_new_ds <- new("GCT", mat=m))
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:10, 1:10] -1.815 -0.764 -0.408 0.644 1.111 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:10] "a" "b" "c" "d" ...
##   .. .. ..$ : chr [1:10] "A" "B" "C" "D" ...
##   ..@ rid    : chr [1:10] "a" "b" "c" "d" ...
##   ..@ cid    : chr [1:10] "A" "B" "C" "D" ...
##   ..@ rdesc  :'data.frame':  0 obs. of  0 variables
## Formal class 'data.frame' [package "methods"] with 4 slots
##   .. .. ..@ .Data    : list()
##   .. .. ..@ names    : chr(0)
##   .. .. ..@ row.names: int(0)
##   .. .. ..@ .S3Class : chr "data.frame"
##   ..@ cdesc  :'data.frame':  0 obs. of  0 variables
## Formal class 'data.frame' [package "methods"] with 4 slots
##   .. .. ..@ .Data    : list()
##   .. .. ..@ names    : chr(0)
##   .. .. ..@ row.names: int(0)
##   .. .. ..@ .S3Class : chr "data.frame"
##   ..@ version: chr(0)
##   ..@ src    : chr(0)
```

```
# we can also include the row/column annotations as data.frames
# note these are just arbitrary annotations used to illustrate the function call
rdesc <- data.frame(id=letters[1:10], type=rep(c(1, 2), each=5))
cdesc <- data.frame(id=LETTERS[1:10], type=rep(c(3, 4), each=5))
(my_new_ds <- new("GCT", mat=m, rdesc=rdesc, cdesc=cdesc))
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:10, 1:10] -1.815 -0.764 -0.408 0.644 1.111 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:10] "a" "b" "c" "d" ...
##   .. .. ..$ : chr [1:10] "A" "B" "C" "D" ...
##   ..@ rid    : chr [1:10] "a" "b" "c" "d" ...
##   ..@ cid    : chr [1:10] "A" "B" "C" "D" ...
##   ..@ rdesc  :'data.frame':  10 obs. of  2 variables:
##   .. ..$ id  : chr [1:10] "a" "b" "c" "d" ...
##   .. ..$ type: num [1:10] 1 1 1 1 1 2 2 2 2 2
##   ..@ cdesc  :'data.frame':  10 obs. of  2 variables:
##   .. ..$ id  : chr [1:10] "A" "B" "C" "D" ...
##   .. ..$ type: num [1:10] 3 3 3 3 3 4 4 4 4 4
##   ..@ version: chr(0)
##   ..@ src    : chr(0)
```

## 4.4 Adding annotations to a GCT object

When working with `GCT` objects, it’s often convenient to have the row and column annotations embedded as the `rdesc` and `cdesc` slots, respectively. If these metadata are stored separatly from the GCTX file itself, you can read them in separately and then apply them to the `GCT` object using the `annotate.gct` function. Let’s parse the dataset again, only this time reading only the matrix. We’ll then apply the column annotations we read in previously.

```
# we'll use the matrix_only argument to extract just the matrix
(my_ds_no_meta <- parse_gctx(ds_path, matrix_only = TRUE))
```

```
## reading /tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx
```

```
## done
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:50, 1:25] -1.145 -1.165 0.437 0.139 -0.673 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. .. ..$ : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rid    : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cid    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rdesc  :'data.frame':  50 obs. of  1 variable:
##   .. ..$ id: chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cdesc  :'data.frame':  25 obs. of  1 variable:
##   .. ..$ id: chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ version: chr(0)
##   ..@ src    : chr "/tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx"
```

Note in this case that cmapR still populates 1-column `data.frames` containing the row and column ids, but the rest of the annotations have been omitted.

Now we’ll apply the column annotations using `annotate.gct`.

```
# note we need to specifiy which dimension to annotate (dim)
# and which column in the annotations corresponds to the column
# ids in the matrix (keyfield)
(my_ds_no_meta <- annotate_gct(my_ds_no_meta, col_meta, dim="col",
                               keyfield="id"))
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:50, 1:25] -1.145 -1.165 0.437 0.139 -0.673 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. .. ..$ : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rid    : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cid    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ rdesc  :'data.frame':  50 obs. of  1 variable:
##   .. ..$ id: chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ cdesc  :'data.frame':  25 obs. of  16 variables:
##   .. ..$ id                    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   .. ..$ brew_prefix           : chr [1:25] "CPC004_PC3_24H" "BRAF001_HEK293T_24H" "CPC006_HT29_24H" "CVD001_HEPG2_24H" ...
##   .. ..$ cell_id               : chr [1:25] "PC3" "HEK293T" "HT29" "HEPG2" ...
##   .. ..$ distil_cc_q75         : num [1:25] 0.05 0.1 0.17 0.45 0.24 ...
##   .. ..$ distil_nsample        : int [1:25] 5 9 4 3 4 5 2 3 2 2 ...
##   .. ..$ distil_ss             : num [1:25] 2.9 1.88 2.71 4.06 3.83 ...
##   .. ..$ is_gold               : int [1:25] 0 0 0 1 1 0 1 0 0 0 ...
##   .. ..$ ngenes_modulated_dn_lm: int [1:25] 11 3 8 38 36 23 12 11 33 13 ...
##   .. ..$ ngenes_modulated_up_lm: int [1:25] 10 7 25 40 16 17 23 14 37 22 ...
##   .. ..$ pct_self_rank_q25     : num [1:25] 26.904 17.125 7.06 0.229 4.686 ...
##   .. ..$ pert_id               : chr [1:25] "BRD-A51714012" "BRD-U73308409" "BRD-U88459701" "BRD-U88459701" ...
##   .. ..$ pert_idose            : chr [1:25] "10 <b5>M" "500 nM" "10 <b5>M" "10 <b5>M" ...
##   .. ..$ pert_iname            : chr [1:25] "venlafaxine" "vemurafenib" "atorvastatin" "atorvastatin" ...
##   .. ..$ pert_itime            : chr [1:25] "24 h" "24 h" "24 h" "24 h" ...
##   .. ..$ pert_type             : chr [1:25] "trt_cp" "trt_cp" "trt_cp" "trt_cp" ...
##   .. ..$ pool_id               : chr [1:25] "epsilon" "epsilon" "epsilon" "epsilon" ...
##   ..@ version: chr(0)
##   ..@ src    : chr "/tmp/RtmpeDFOiI/Rinst3aaf5a2d601d4/cmapR/extdata/modzs_n25x50.gctx"
```

Note how now the `cdesc` slot is populated after annotating.

## 4.5 Slicing a GCT object

Just as it’s possible to read a subset of rows or columns from a GCTX file, it is also possible to extract a subset of rows or columns from a `GCT` object in memory. This is done with the `subset_gct` function. Just like `parse_gctx`, this function uses `rid` and `cid` parameters to determine which rows and columns to extract. Let’s extract the *vemurafenib* columns from the `my_ds` object in memory.

```
# in memory slice using the cid parameter
vemurafenib_ds3 <- subset_gct(my_ds,
                             cid=which(col_meta$pert_iname=="vemurafenib"))
identical(vemurafenib_ds, vemurafenib_ds3)
```

```
## [1] FALSE
```

## 4.6 Melting GCT objects

It’s often useful to have data stored in long form `data.frame` objects, especially for compatibility with plotting libraries like [`ggplot2`](http://docs.ggplot2.org/current/). It’s possible to convert a `GCT` object into this long form by using the `melt_gct` function, which relies on the `melt` function in the [`data.table`](https://cran.r-project.org/web/packages/data.table/) package.

```
# melt to long form
vemurafenib_ds3_melted <- melt_gct(vemurafenib_ds3)
```

```
## melting GCT object...
```

```
## done
```

```
# plot the matrix values grouped by gene
grps <- with(vemurafenib_ds3_melted, split(value, pr_gene_symbol))
boxplot(grps)
```

![](data:image/png;base64...)

## 4.7 Merging two GCT objects

You can combine two independent `GCT` objects using the `merge_gct` function. Note that it is important to specify which dimension (row or column) you wish to merge on and that the two `GCT` objects in question share one common dimension.

## 4.8 Math operations on GCT objects

The `@mat` slot of a GCT object is a base R matrix object, so it’s possible to perform standard math operations on this matrix. This matrix can be accessed directly, i.e. `my_ds@mat`, but can also be extracted using the `get_gct_matrix` function from `cmapR`. Below are a few simple examples, but these can easily be extended, particulary through use of the `apply` function.

```
# extract the data matrix from the my_ds object
m <- mat(my_ds)
```

Now let’s perform a few simple math operations

```
# compute the row and column means
row_means <- rowMeans(m)
col_means <- colMeans(m)
message("means:")
```

```
## means:
```

```
head(row_means)
```

```
##   200814_at   222103_at 201453_x_at 204131_s_at 200059_s_at   205067_at
## -0.04539519 -0.36639891 -0.40457100  0.35614147  0.40454578 -0.22763633
```

```
head(col_means)
```

```
##         CPC004_PC3_24H:BRD-A51714012-001-03-1:10
##                                       0.04775844
## BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625
##                                      -0.01296067
##        CPC006_HT29_24H:BRD-U88459701-000-01-8:10
##                                      -0.20454084
##       CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10
##                                      -0.26358546
##          NMH001_NEU_6H:BRD-K69726342-001-02-6:10
##                                      -0.44564062
##         CPC020_VCAP_6H:BRD-A82307304-001-01-8:10
##                                      -0.08844710
```

```
# using 'apply', compute the max of each row and column
row_max <- apply(m, 1, max)
col_max <- apply(m, 2, max)
message("maxes:")
```

```
## maxes:
```

```
head(row_max)
```

```
##   200814_at   222103_at 201453_x_at 204131_s_at 200059_s_at   205067_at
##    1.204220    1.829283    1.022154    2.507013    3.064311    1.876900
```

```
head(col_max)
```

```
##         CPC004_PC3_24H:BRD-A51714012-001-03-1:10
##                                        1.8241825
## BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625
##                                        0.8706381
##        CPC006_HT29_24H:BRD-U88459701-000-01-8:10
##                                        2.5714328
##       CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10
##                                        3.0643106
##          NMH001_NEU_6H:BRD-K69726342-001-02-6:10
##                                        1.8993782
##         CPC020_VCAP_6H:BRD-A82307304-001-01-8:10
##                                        0.8148650
```

### 4.8.1 GCT-specific math functions

`cmapR` also contains a handful of math functions designed specifically for operating on `GCT` objects.

```
# transposing a GCT object - also swaps row and column annotations
(my_ds_transpose <- transpose_gct(my_ds))
```

```
## Formal class 'GCT' [package "cmapR"] with 7 slots
##   ..@ mat    : num [1:25, 1:50] -1.145 0.142 -0.469 0.457 0.483 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   .. .. ..$ : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ rid    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   ..@ cid    : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   ..@ rdesc  :'data.frame':  25 obs. of  16 variables:
##   .. ..$ brew_prefix           : chr [1:25] "CPC004_PC3_24H" "BRAF001_HEK293T_24H" "CPC006_HT29_24H" "CVD001_HEPG2_24H" ...
##   .. ..$ cell_id               : chr [1:25] "PC3" "HEK293T" "HT29" "HEPG2" ...
##   .. ..$ distil_cc_q75         : num [1:25] 0.05 0.1 0.17 0.45 0.24 ...
##   .. ..$ distil_nsample        : int [1:25] 5 9 4 3 4 5 2 3 2 2 ...
##   .. ..$ distil_ss             : num [1:25] 2.9 1.88 2.71 4.06 3.83 ...
##   .. ..$ id                    : chr [1:25] "CPC004_PC3_24H:BRD-A51714012-001-03-1:10" "BRAF001_HEK293T_24H:BRD-U73308409-000-01-9:0.625" "CPC006_HT29_24H:BRD-U88459701-000-01-8:10" "CVD001_HEPG2_24H:BRD-U88459701-000-01-8:10" ...
##   .. ..$ is_gold               : int [1:25] 0 0 0 1 1 0 1 0 0 0 ...
##   .. ..$ ngenes_modulated_dn_lm: int [1:25] 11 3 8 38 36 23 12 11 33 13 ...
##   .. ..$ ngenes_modulated_up_lm: int [1:25] 10 7 25 40 16 17 23 14 37 22 ...
##   .. ..$ pct_self_rank_q25     : num [1:25] 26.904 17.125 7.06 0.229 4.686 ...
##   .. ..$ pert_id               : chr [1:25] "BRD-A51714012" "BRD-U73308409" "BRD-U88459701" "BRD-U88459701" ...
##   .. ..$ pert_idose            : chr [1:25] "10 <b5>M" "500 nM" "10 <b5>M" "10 <b5>M" ...
##   .. ..$ pert_iname            : chr [1:25] "venlafaxine" "vemurafenib" "atorvastatin" "atorvastatin" ...
##   .. ..$ pert_itime            : chr [1:25] "24 h" "24 h" "24 h" "24 h" ...
##   .. ..$ pert_type             : chr [1:25] "trt_cp" "trt_cp" "trt_cp" "trt_cp" ...
##   .. ..$ pool_id               : chr [1:25] "epsilon" "epsilon" "epsilon" "epsilon" ...
##   ..@ cdesc  :'data.frame':  50 obs. of  6 variables:
##   .. ..$ id            : chr [1:50] "200814_at" "222103_at" "201453_x_at" "204131_s_at" ...
##   .. ..$ is_bing       : int [1:50] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ is_lm         : int [1:50] 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ pr_gene_id    : int [1:50] 5720 466 6009 2309 387 3553 427 5898 23365 6657 ...
##   .. ..$ pr_gene_symbol: chr [1:50] "PSME1" "ATF1" "RHEB" "FOXO3" ...
##   .. ..$ pr_gene_title : chr [1:50] "proteasome (prosome, macropain) activator subunit 1 (PA28 alpha)" "activating transcription factor 1" "Ras homolog enriched in brain" "forkhead box O3" ...
##   ..@ version: chr(0)
##   ..@ src    : chr(0)
```

```
# converting a GCT object's matrix to ranks
# the 'dim' option controls the direction along which the ranks are calculated
my_ds_rank_by_column <- rank_gct(my_ds, dim="col")

# plot z-score vs rank for the first 25 genes (rows)
ranked_m <- mat(my_ds_rank_by_column)
plot(ranked_m[1:25, ],
     m[1:25, ],
     xlab="rank",
     ylab="differential expression score",
     main="score vs. rank")
```

![](data:image/png;base64...)

## 4.9 Writing GCT objects to disk

`GCT` objects can be written to disk either in GCT or GCTX format using the `write_gct` and `write_gctx` functions, respectively.

```
# write 'my_ds' in both GCT and GCTX format
write_gct(my_ds, "my_ds")
```

```
## Saving file to  ./my_ds_n25x50.gct
## Dimensions of matrix: [50x25]
## Setting precision to 4
## Saved.
```

```
write_gctx(my_ds, "my_ds")
```

```
## writing ./my_ds_n25x50.gctx
```

```
## chunk sizes: 50  25
```

```
# write_gctx can also compress the dataset upon write,
# which can be controlled using the 'compression_level' option.
# the higher the value, the greater the compression, but the
# longer the read/write time
write_gctx(my_ds, "my_ds_compressed", compression_level = 9)
```

```
## writing ./my_ds_compressed_n25x50.gctx
## chunk sizes: 50  25
```

## 4.10 Converting GCT objects to SummarizedExperiment objects

The `GCT` class is quite similar in spirit to the `SummarizedExperiment` class from the `SummarizedExperiment` package (citation). Converting a `GCT` object to a `SummarizedExeriment` object is straightforward, as shown below.

```
# ds is an object of class GCT
(se <- as(ds, "SummarizedExperiment"))
```

```
## class: SummarizedExperiment
## dim: 978 272
## metadata(0):
## assays(1): exprs
## rownames(978): 200814_at 222103_at ... 203341_at 205379_at
## rowData names(1): x
## colnames(272): CPC006_A549_6H:BRD-U88459701-000-01-8:10
##   CPC020_A375_6H:BRD-A82307304-001-01-8:10 ...
##   CPD002_PC3_6H:BRD-A51714012-001-04-9:10
##   CPD002_PC3_24H:BRD-A51714012-001-04-9:10
## colData names(1): x
```

# 5 Session Info

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
## [1] cmapR_1.22.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4                jsonlite_2.0.0
##  [3] compiler_4.5.1              BiocManager_1.30.26
##  [5] Rcpp_1.1.0                  tinytex_0.57
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] cytolib_2.22.0              magick_2.9.0
## [11] rhdf5filters_1.22.0         GenomicRanges_1.62.0
## [13] jquerylib_0.1.4             IRanges_2.44.0
## [15] Seqinfo_1.0.0               yaml_2.3.10
## [17] fastmap_1.2.0               lattice_0.22-7
## [19] RProtoBufLib_2.22.0         R6_2.6.1
## [21] XVector_0.50.0              S4Arrays_1.10.0
## [23] generics_0.1.4              knitr_1.50
## [25] BiocGenerics_0.56.0         DelayedArray_0.36.0
## [27] bookdown_0.45               MatrixGenerics_1.22.0
## [29] bslib_0.9.0                 rlang_1.1.6
## [31] cachem_1.1.0                flowCore_2.22.0
## [33] xfun_0.53                   sass_0.4.10
## [35] SparseArray_1.10.0          cli_3.6.5
## [37] magrittr_2.0.4              Rhdf5lib_1.32.0
## [39] digest_0.6.37               grid_4.5.1
## [41] rhdf5_2.54.0                lifecycle_1.0.4
## [43] S4Vectors_0.48.0            data.table_1.17.8
## [45] evaluate_1.0.5              abind_1.4-8
## [47] stats4_4.5.1                rmarkdown_2.30
## [49] matrixStats_1.5.0           tools_4.5.1
## [51] htmltools_0.5.8.1
```