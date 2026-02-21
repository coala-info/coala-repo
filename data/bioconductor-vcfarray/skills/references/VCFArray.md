# VCFArray: DelayedArray objects with on-disk/remote VCF backend

Qian Liu1 and Martin Morgan1

1Roswell Park Comprehensive Cancer Center, Buffalo, NY

#### last edit: 08/23/2018

#### Package

VCFArray 1.26.0

# 1 Introduction

[VCFArray](https://bioconductor.org/packages/VCFArray) is a *Bioconductor* package that represents VCF files as
objects derived from the [DelayedArray](https://bioconductor.org/packages/DelayedArray) package and `DelayedArray`
class. It converts data entries from VCF file into a
`DelayedArray`-derived data structure. The backend VCF file could
either be saved on-disk locally or remote as online resources. Data
entries that could be extracted include the fixed data fields (REF,
ALT, QUAL, FILTER), information field (e.g., AA, AF…), and the
individual format field (e.g., GT, DP…). The array data generated
from fixed/information fields are one-dimensional `VCFArray`, with the
dimension being the length of the variants. The array data generated
from individual `FORMAT` field are always returned with the first
dimension being `variants` and the second dimension being
`samples`. This feature is consistent with the assay data saved in
`SummarizedExperiment`, and makes the `VCFArray` package interoperable
with other established *Bioconductor* data infrastructure.

# 2 Installation

1. Download the package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("VCFArray")
```

The development version is also available to download from Github.

```
BiocManager::install("Bioconductor/VCFArray")
```

2. Load the package into R session.

```
library(VCFArray)
```

# 3 VCFArray

## 3.1 VCFArray constructor

To construct a `VCFArray` object, 4 arguments are needed: `file`,
`vindex` and `name`, and `pfix`. The `file` argument could take either
a character string (VCF file name), or `VcfFile` object, or a
`RangedVcfStack` object. `name` argument must be specified to indicate
which data entry we want to extract from the input file. It’s
case-sensitive, and must be consistent with the names from VCF header
file. `vindex` argument will only be used to indicate the file path
of the index file if it does not exist. `pfix` is used to spefify the
category that the `name` field belongs to. **NOTE** that the `pfix`
needs to be provided specifically when there are same `name` in
multiple categories, otherwise, error will return.

The `vcfFields()` method takes the VCF file path, `VcfFile` object or
`RangedVcfStack` object as input, and returns a CharacterList with all
available VCF fields within specific categories. Users should consult
the `fixed`, `info` and `geno` category for available data entries
that could be converted into `VCFArray` instances. The data entry
names can be used as input for the `name` argument in `VCFArray`
constructor.

```
args(VCFArray)
#> function (file, vindex = character(), name = NA, pfix = NULL)
#> NULL
fl <- system.file("extdata", "chr22.vcf.gz", package = "VariantAnnotation")
library(VariantAnnotation)
vcfFields(fl)
#> CharacterList of length 4
#> [["fixed"]] REF ALT QUAL FILTER
#> [["info"]] LDAF AVGPOST RSQ ERATE THETA ... ASN_AF AFR_AF EUR_AF VT SNPSOURCE
#> [["geno"]] GT DS GL
#> [["samples"]] HG00096 HG00097 HG00099 HG00100 HG00101
```

Since the index file for our vcf file already exists, the `vindex`
argument would not be needed (which is the most common case for
on-disk VCF files). So we can construct the `VCFArray` object for the
`GT` data entry in the provided VCF file with arguments of `file` and
`name` only.

```
VCFArray(file = fl, name = "GT")
#> <10376 x 5> VCFMatrix object of type "character":
#>             HG00096 HG00097 HG00099 HG00100 HG00101
#> rs7410291   "0|0"   "0|0"   "1|0"   "0|0"   "0|0"
#> rs147922003 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs114143073 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> ...         .       .       .       .       .
#> rs5770892   "0|0"   "0|0"   "0|0"   "0|0"   "0|1"
#> rs144055359 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs114526001 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
```

We can also construct a `VCFArray` object with the `file` argument
being a `VcfFile` object.

```
vcf <- VariantAnnotation::VcfFile(fl)
VCFArray(file = vcf, name = "DS")
#> <10376 x 5> VCFMatrix object of type "double":
#>             HG00096 HG00097 HG00099 HG00100 HG00101
#>   rs7410291       0       0       1       0       0
#> rs147922003       0       0       0       0       0
#> rs114143073       0       0       0       0       0
#>         ...       .       .       .       .       .
#>   rs5770892       0       0       0       0       1
#> rs144055359       0       0       0       0       0
#> rs114526001       0       0       0       0       0
```

The `file` argument could also take `RangedVcfStack` object. Note that
an ordinary `VcfStack` object without `Range` information could not
be used to construct a `VCFArray`.

```
extdata <- system.file(package = "GenomicFiles", "extdata")
files <- dir(extdata, pattern="^CEUtrio.*bgz$", full=TRUE)[1:2]
names(files) <- sub(".*_([0-9XY]+).*", "\\1", basename(files))
seqinfo <- as(readRDS(file.path(extdata, "seqinfo.rds")), "Seqinfo")
stack <- GenomicFiles::VcfStack(files, seqinfo)
gr <- as(GenomicFiles::seqinfo(stack)[rownames(stack)], "GRanges")
## RangedVcfStack
rgstack <- GenomicFiles::RangedVcfStack(stack, rowRanges = gr)
rgstack
#> VcfStack object with 2 files and 3 samples
#> GRanges object with 2 ranges and 0 metadata columns
#> Seqinfo object with 25 sequences from hg19 genome
#> use 'readVcfStack()' to extract VariantAnnotation VCF.
```

Here we choose the `name = SB`, which returns a 3-dimensional
`VCFArray` object, with the first 2 dimensions correspond to variants
and samples respectively.

```
vcfFields(rgstack)$geno
#> [1] "GT"     "AD"     "DP"     "GQ"     "MIN_DP" "PGT"    "PID"    "PL"
#> [9] "SB"
VCFArray(rgstack, name = "SB")
#> <318 x 3 x 4> VCFArray object of type "integer":
#> ,,1
#>             NA12878 NA12891 NA12892
#> rs771898125      NA      NA      NA
#>   rs6118055      NA      NA      NA
#>         ...       .       .       .
#>   rs2009307      NA      NA      NA
#>   rs2273444      NA      NA      NA
#>
#> ...
#>
#> ,,4
#>             NA12878 NA12891 NA12892
#> rs771898125      NA      NA      NA
#>   rs6118055      NA      NA      NA
#>         ...       .       .       .
#>   rs2009307      NA      NA      NA
#>   rs2273444      NA      NA      NA
```

As the vignette title suggest, the backend VCF file could also be
remote files. Here we included an example of representing VCF file of
chromosome 22 from the 1000 Genomes Project (Phase 3). **NOTE that for
a remote VCF file, the `vindex` argument must be specified.** Since
this VCF files is relatively big, and it takes longer time, we only
show the code here without evaluation.

```
chr22url <- "https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"
chr22url.tbi <- paste0(chr22url, ".tbi")
va <- VCFArray(chr22url, vindex =chr22url.tbi, name = "GT")
```

## 3.2 VCFArray methods

`VCFArray` represents VCF files as `DelayedArray` instances. It has
methods like `dim`, `dimnames` defined, and it inherits array-like
operations and methods from `DelayedArray`, e.g., the subsetting
method of `[`.
**NOTE** that for 1-dimensional `VCFArray` objects that are generated
from the fixed / information data field of VCF file, `drop = FALSE`
should always be used with `[` subsetting to ensure `VCFArray` object
as returned value.

### 3.2.1 slot accessors

`seed` returns the `VCFArraySeed` of the `VCFArray` object, which
includes information about the backend VCF file, e.g., the vcf file
path, index file path, name of the data entry (with a prefix of
category), dimension and etc.

```
va <- VCFArray(fl, name = "GT")
seed(va)
#> VCFArraySeed
#> VCF file path: /home/biocbuild/bbs-3.22-bioc/R/site-library/VariantAnnotation/extdata/chr22.vcf.gz
#> VCF index path: /home/biocbuild/bbs-3.22-bioc/R/site-library/VariantAnnotation/extdata/chr22.vcf.gz.tbi
#> array data: GT
#> dim: 10376 x 5
```

`vcffile` returns the `VcfFile` object corresponding to the backend
VCF file.

```
vcffile(va)
#> class: VcfFile
#> path: /home/biocbuild/bbs-3.22-bioc/R/site-library/VariantAnnota.../chr22.vcf.gz
#> index: /home/biocbuild/bbs-3.22-bioc/R/site-library/VariantA.../chr22.vcf.gz.tbi
#> isOpen: FALSE
#> yieldSize: NA
```

### 3.2.2 `dim()` and `dimnames()`

The `dimnames(VCFArray)` returns an unnamed list, with the length of
each element being the same as return from `dim(VCFArray)`.

```
va <- VCFArray(fl, name = "GT")
dim(va)
#> [1] 10376     5
class(dimnames(va))
#> [1] "list"
lengths(dimnames(va))
#> [1] 10376     5
```

### 3.2.3 `[` subsetting

`VCFArray` instances can be subsetted, following the usual *R*
conventions, with numeric or logical vectors; logical vectors are
recycled to the appropriate length.

```
va[1:3, 1:3]
#> <3 x 3> DelayedMatrix object of type "character":
#>             HG00096 HG00097 HG00099
#> rs7410291   "0|0"   "0|0"   "1|0"
#> rs147922003 "0|0"   "0|0"   "0|0"
#> rs114143073 "0|0"   "0|0"   "0|0"
va[c(TRUE, FALSE), ]
#> <5188 x 5> DelayedMatrix object of type "character":
#>             HG00096 HG00097 HG00099 HG00100 HG00101
#> rs7410291   "0|0"   "0|0"   "1|0"   "0|0"   "0|0"
#> rs114143073 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs182170314 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> ...         .       .       .       .       .
#> rs9628212   "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs9628178   "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs144055359 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
```

### 3.2.4 Some numeric calculation

Numeric calculations could be evaluated on `VCFArray` objects.

```
ds <- VCFArray(fl, name = "DS")
log(ds+5)
#> <10376 x 5> DelayedMatrix object of type "double":
#>              HG00096  HG00097  HG00099  HG00100  HG00101
#>   rs7410291 1.609438 1.609438 1.791759 1.609438 1.609438
#> rs147922003 1.609438 1.609438 1.609438 1.609438 1.609438
#> rs114143073 1.609438 1.609438 1.609438 1.609438 1.609438
#>         ...        .        .        .        .        .
#>   rs5770892 1.609438 1.609438 1.609438 1.609438 1.791759
#> rs144055359 1.609438 1.609438 1.609438 1.609438 1.609438
#> rs114526001 1.609438 1.609438 1.609438 1.609438 1.609438
```

# 4 Internals: VCFArraySeed

The `VCFArraySeed` class represents the ‘seed’ for the `VCFArray`
object. It is not exported from the [VCFArray](https://bioconductor.org/packages/VCFArray) package. Seed objects
should contain the VCF file path, and are expected to satisfy the
“seed contract” of [DelayedArray](https://bioconductor.org/packages/DelayedArray), i.e. to support `dim()` and
`dimnames()`.

```
seed <- VCFArray:::VCFArraySeed(fl, name = "GT", pfix = NULL)
seed
#> VCFArraySeed
#> VCF file path: /home/biocbuild/bbs-3.22-bioc/R/site-library/VariantAnnotation/extdata/chr22.vcf.gz
#> VCF index path: /home/biocbuild/bbs-3.22-bioc/R/site-library/VariantAnnotation/extdata/chr22.vcf.gz.tbi
#> array data: GT
#> dim: 10376 x 5
path(vcffile(seed))
#> [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/VariantAnnotation/extdata/chr22.vcf.gz"
```

The seed can be used to construct a `VCFArray` instance.

```
(va <- VCFArray(seed))
#> <10376 x 5> VCFMatrix object of type "character":
#>             HG00096 HG00097 HG00099 HG00100 HG00101
#> rs7410291   "0|0"   "0|0"   "1|0"   "0|0"   "0|0"
#> rs147922003 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs114143073 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> ...         .       .       .       .       .
#> rs5770892   "0|0"   "0|0"   "0|0"   "0|0"   "0|1"
#> rs144055359 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
#> rs114526001 "0|0"   "0|0"   "0|0"   "0|0"   "0|0"
```

The `DelayedArray()` constructor with `VCFArraySeed` object as inputs
will return the same content as the `VCFArray()` constructor over the
same `VCFArraySeed`.

```
da <- DelayedArray(seed)
class(da)
#> [1] "VCFMatrix"
#> attr(,"package")
#> [1] "VCFArray"
all.equal(da, va)
#> [1] TRUE
```

# 5 sessionInfo()

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
#>  [1] VariantAnnotation_1.56.0    Rsamtools_2.26.0
#>  [3] Biostrings_2.78.0           XVector_0.50.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] VCFArray_1.26.0             DelayedArray_0.36.0
#> [11] SparseArray_1.10.0          S4Arrays_1.10.0
#> [13] abind_1.4-8                 IRanges_2.44.0
#> [15] S4Vectors_0.48.0            MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           Matrix_1.7-4
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.53
#>  [4] bslib_0.9.0              lattice_0.22-7           vctrs_0.6.5
#>  [7] tools_4.5.1              bitops_1.0-9             curl_7.0.0
#> [10] parallel_4.5.1           AnnotationDbi_1.72.0     RSQLite_2.4.3
#> [13] blob_1.2.4               BSgenome_1.78.0          cigarillo_1.0.0
#> [16] lifecycle_1.0.4          compiler_4.5.1           codetools_0.2-20
#> [19] GenomicFiles_1.46.0      GenomeInfoDb_1.46.0      htmltools_0.5.8.1
#> [22] sass_0.4.10              RCurl_1.98-1.17          yaml_2.3.10
#> [25] crayon_1.5.3             jquerylib_0.1.4          BiocParallel_1.44.0
#> [28] cachem_1.1.0             digest_0.6.37            restfulr_0.0.16
#> [31] bookdown_0.45            fastmap_1.2.0            grid_4.5.1
#> [34] cli_3.6.5                GenomicFeatures_1.62.0   XML_3.99-0.19
#> [37] UCSC.utils_1.6.0         bit64_4.6.0-1            rmarkdown_2.30
#> [40] httr_1.4.7               bit_4.6.0                png_0.1-8
#> [43] memoise_2.0.1            evaluate_1.0.5           knitr_1.50
#> [46] BiocIO_1.20.0            rtracklayer_1.70.0       rlang_1.1.6
#> [49] DBI_1.2.3                BiocManager_1.30.26      jsonlite_2.0.0
#> [52] R6_2.6.1                 GenomicAlignments_1.46.0
```