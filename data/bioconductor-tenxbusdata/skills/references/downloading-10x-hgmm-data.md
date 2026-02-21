# Downloading BUS data

Lambda Moses

#### 2025-11-04

This package provides the barcode, UMI, and set (BUS) format of the following datasets from 10X genomics:

* [100 1:1 Mixture of Fresh Frozen Human (HEK293T) and Mouse (NIH3T3) Cells (v2 chemistry)](https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/hgmm_100)
* [1k 1:1 Mixture of Fresh Frozen Human (HEK293T) and Mouse (NIH3T3) Cells (v3 chemistry)](https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/hgmm_1k_v3)
* [1k PBMCs from a Healthy Donor (v3 chemistry)](https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/pbmc_1k_v3)
* [10k Brain Cells from an E18 Mouse (v3 chemistry)](https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/neuron_10k_v3)

The original fastq files have already been processed into the BUS format, which is a table with the following columns: barcode, UMI, equivalence class/set, and count (i.e. number of reads for the same barcode, UMI, and set). The datasets have been uploaded to `ExperimentHub`. This vignette demonstrates how to download the first dataset above with this package. See the [BUSpaRse website](https://bustools.github.io/BUS_notebooks_R/index.html) for more detailed vignettes.

```
library(TENxBUSData)
library(ExperimentHub)
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

See which datasets are available with this package.

```
eh <- ExperimentHub()
listResources(eh, "TENxBUSData")
#> [1] "100 1:1 Mixture of Fresh Frozen Human (HEK293T) and Mouse (NIH3T3) Cells"
#> [2] "1k 1:1 Mixture of Fresh Frozen Human (HEK293T) and Mouse (NIH3T3) Cells (v3 chemistry)"
#> [3] "1k PBMCs from a Healthy Donor (v3 chemistry)"
#> [4] "10k Brain Cells from an E18 Mouse (v3 chemistry)"
```

In this vignette, we download the 100 cell dataset. The `force` argument will force redownload even if the files are already present.

```
TENxBUSData(".", dataset = "hgmm100", force = TRUE)
#> see ?TENxBUSData and browseVignettes('TENxBUSData') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> loading from cache
#> The downloaded files are in /tmp/Rtmp1YhNtt/Rbuild99c121c672e7/TENxBUSData/vignettes/out_hgmm100
#> [1] "/tmp/Rtmp1YhNtt/Rbuild99c121c672e7/TENxBUSData/vignettes/out_hgmm100"
```

Which files are downloaded?

```
list.files("./out_hgmm100")
#> [1] "matrix.ec"         "output.sorted"     "output.sorted.txt"
#> [4] "transcripts.txt"
```

These should be sufficient to construct a sparse matrix with package [`BUSpaRse`](https://github.com/BUStools/BUSpaRse).