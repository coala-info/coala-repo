# Saving `VCF`s to artifacts and back again

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: September 22, 2022

#### Package

alabaster.se 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Further comments](#further-comments)
* [Session information](#session-information)

# 1 Overview

The *[alabaster.vcf](https://github.com/ArtifactDB/alabaster.vcf)* package implements methods to save `VCF` objects to file artifacts and load them back into R.
This refers specifically to the `SummarizedExperiment` subclasses (i.e., `CollapsedVCF` and `ExpandedVCF`) that are used to represent the variant calling data in an R session,
which may contain additional modifications that cannot be easily stored inside the original VCF file.
Check out the *[alabaster.base](https://github.com/ArtifactDB/alabaster.base)* for more details on the motivation and concepts of the **alabaster** framework.

# 2 Quick start

Given a `VCF` object, we can use `stageObject()` to save it inside a staging directory:

```
library(VariantAnnotation)
fl <- system.file("extdata", "structural.vcf", package="VariantAnnotation")
vcf <- readVcf(fl, genome="hg19")
vcf
```

```
## class: CollapsedVCF
## dim: 7 1
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 10 columns: BKPTID, CIEND, CIPOS, END, HOMLEN, HOMSEQ, IMPR...
## info(header(vcf)):
##              Number Type    Description
##    BKPTID    .      String  ID of the assembled alternate allele in the asse...
##    CIEND     2      Integer Confidence interval around END for imprecise var...
##    CIPOS     2      Integer Confidence interval around POS for imprecise var...
##    END       1      Integer End position of the variant described in this re...
##    HOMLEN    .      Integer Length of base pair identical micro-homology at ...
##    HOMSEQ    .      String  Sequence of base pair identical micro-homology a...
##    IMPRECISE 0      Flag    Imprecise structural variation
##    MEINFO    4      String  Mobile element info of the form NAME,START,END,P...
##    SVLEN     .      Integer Difference in length between REF and ALT alleles
##    SVTYPE    1      String  Type of structural variant
## geno(vcf):
##   List of length 4: GT, GQ, CN, CNQ
## geno(header(vcf)):
##        Number Type    Description
##    GT  1      String  Genotype
##    GQ  1      Float   Genotype quality
##    CN  1      Integer Copy number genotype for imprecise events
##    CNQ 1      Float   Copy number genotype quality for imprecise events
```

```
library(alabaster.vcf)
tmp <- tempfile()
dir.create(tmp)
meta <- stageObject(vcf, tmp, "vcf")
.writeMetadata(meta, tmp)
```

```
## $type
## [1] "local"
##
## $path
## [1] "vcf/experiment.json"
```

```
list.files(tmp, recursive=TRUE)
```

```
##  [1] "vcf/assay-1/array.h5"
##  [2] "vcf/assay-1/array.h5.json"
##  [3] "vcf/assay-2/array.h5"
##  [4] "vcf/assay-2/array.h5.json"
##  [5] "vcf/assay-3/array.h5"
##  [6] "vcf/assay-3/array.h5.json"
##  [7] "vcf/assay-4/array.h5"
##  [8] "vcf/assay-4/array.h5.json"
##  [9] "vcf/coldata/simple.csv.gz"
## [10] "vcf/coldata/simple.csv.gz.json"
## [11] "vcf/experiment.json"
## [12] "vcf/fixed/column1/sequence.fa.gz"
## [13] "vcf/fixed/column1/sequence.fa.gz.json"
## [14] "vcf/fixed/column1/set.json"
## [15] "vcf/fixed/column2/concatenated/simple.csv.gz"
## [16] "vcf/fixed/column2/concatenated/simple.csv.gz.json"
## [17] "vcf/fixed/column2/grouping.csv.gz"
## [18] "vcf/fixed/column2/grouping.csv.gz.json"
## [19] "vcf/fixed/simple.csv.gz"
## [20] "vcf/fixed/simple.csv.gz.json"
## [21] "vcf/header/header.bcf"
## [22] "vcf/header/header.bcf.json"
## [23] "vcf/info/column1/concatenated/simple.csv.gz"
## [24] "vcf/info/column1/concatenated/simple.csv.gz.json"
## [25] "vcf/info/column1/grouping.csv.gz"
## [26] "vcf/info/column1/grouping.csv.gz.json"
## [27] "vcf/info/column2/concatenated/simple.csv.gz"
## [28] "vcf/info/column2/concatenated/simple.csv.gz.json"
## [29] "vcf/info/column2/grouping.csv.gz"
## [30] "vcf/info/column2/grouping.csv.gz.json"
## [31] "vcf/info/column3/concatenated/simple.csv.gz"
## [32] "vcf/info/column3/concatenated/simple.csv.gz.json"
## [33] "vcf/info/column3/grouping.csv.gz"
## [34] "vcf/info/column3/grouping.csv.gz.json"
## [35] "vcf/info/column5/concatenated/simple.csv.gz"
## [36] "vcf/info/column5/concatenated/simple.csv.gz.json"
## [37] "vcf/info/column5/grouping.csv.gz"
## [38] "vcf/info/column5/grouping.csv.gz.json"
## [39] "vcf/info/column6/concatenated/simple.csv.gz"
## [40] "vcf/info/column6/concatenated/simple.csv.gz.json"
## [41] "vcf/info/column6/grouping.csv.gz"
## [42] "vcf/info/column6/grouping.csv.gz.json"
## [43] "vcf/info/column8/concatenated/simple.csv.gz"
## [44] "vcf/info/column8/concatenated/simple.csv.gz.json"
## [45] "vcf/info/column8/grouping.csv.gz"
## [46] "vcf/info/column8/grouping.csv.gz.json"
## [47] "vcf/info/column9/concatenated/simple.csv.gz"
## [48] "vcf/info/column9/concatenated/simple.csv.gz.json"
## [49] "vcf/info/column9/grouping.csv.gz"
## [50] "vcf/info/column9/grouping.csv.gz.json"
## [51] "vcf/info/simple.csv.gz"
## [52] "vcf/info/simple.csv.gz.json"
## [53] "vcf/rowdata/column1/simple.txt.gz"
## [54] "vcf/rowdata/column1/simple.txt.gz.json"
## [55] "vcf/rowdata/simple.csv.gz"
## [56] "vcf/rowdata/simple.csv.gz.json"
## [57] "vcf/rowranges/ranges.csv.gz"
## [58] "vcf/rowranges/ranges.csv.gz.json"
## [59] "vcf/rowranges/seqinfo/simple.csv.gz"
## [60] "vcf/rowranges/seqinfo/simple.csv.gz.json"
```

We can then load it back into the session with `loadObject()`.

```
meta <- acquireMetadata(tmp, "vcf/experiment.json")
roundtrip <- loadObject(meta, tmp)
class(roundtrip)
```

```
## [1] "CollapsedVCF"
## attr(,"package")
## [1] "VariantAnnotation"
```

More details on the metadata and on-disk layout are provided in the [schema](https://artifactdb.github.io/BiocObjectSchemas/html/vcf_experiment/v1.html).

# 3 Further comments

We do not use VCF itself as our file format as the `VCF` may be decorated with more information (e.g., in the `rowData` or `colData`) that may not be easily stored in a VCF file.
The VCF file is not amenable to random access of data, either for individual variants or for different aspects of the dataset, e.g., just the row annotations.
Finally, it allow interpretation of the data as the SummarizedExperiment base class.

The last point is worth some elaboration.
Downstream consumers do not necessarily need to know anything about the `VCF` data structure to read the files,
as long as they understand how to interpret the base `summarized_experiment` schema:

```
library(alabaster.se)
loadSummarizedExperiment(meta, tmp)
```

```
## class: RangedSummarizedExperiment
## dim: 7 1
## metadata(0):
## assays(4): GT GQ CN CNQ
## rownames(7): 1:13220_T/<DEL>
##   1:2827693_CCGTGGATGCGGGGACCCGCATCCCCTCTCCCTTCACAGCTGAGTGACCCACATCCCCTCTCCCCTCGCA/C
##   ... 3:12665100_A/<DUP> 4:18665128_T/<DUP:TANDEM>
## rowData names(1): paramRangeID
## colnames(1): NA00001
## colData names(1): Samples
```

# Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] alabaster.se_1.10.0         alabaster.vcf_1.10.0
##  [3] alabaster.base_1.10.0       VariantAnnotation_1.56.0
##  [5] Rsamtools_2.26.0            Biostrings_2.78.0
##  [7] XVector_0.50.0              SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] Seqinfo_1.0.0               MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocGenerics_0.56.0
## [17] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.53
##  [4] bslib_0.9.0              alabaster.string_1.10.0  rhdf5_2.54.0
##  [7] lattice_0.22-7           rhdf5filters_1.22.0      vctrs_0.6.5
## [10] tools_4.5.1              bitops_1.0-9             curl_7.0.0
## [13] parallel_4.5.1           AnnotationDbi_1.72.0     RSQLite_2.4.3
## [16] blob_1.2.4               Matrix_1.7-4             BSgenome_1.78.0
## [19] cigarillo_1.0.0          lifecycle_1.0.4          compiler_4.5.1
## [22] codetools_0.2-20         htmltools_0.5.8.1        sass_0.4.10
## [25] alabaster.matrix_1.10.0  RCurl_1.98-1.17          yaml_2.3.10
## [28] crayon_1.5.3             jquerylib_0.1.4          BiocParallel_1.44.0
## [31] jsonvalidate_1.5.0       DelayedArray_0.36.0      cachem_1.1.0
## [34] abind_1.4-8              digest_0.6.37            restfulr_0.0.16
## [37] bookdown_0.45            fastmap_1.2.0            grid_4.5.1
## [40] cli_3.6.5                SparseArray_1.10.0       S4Arrays_1.10.0
## [43] GenomicFeatures_1.62.0   h5mread_1.2.0            XML_3.99-0.19
## [46] bit64_4.6.0-1            rmarkdown_2.30           httr_1.4.7
## [49] bit_4.6.0                png_0.1-8                HDF5Array_1.38.0
## [52] memoise_2.0.1            evaluate_1.0.5           knitr_1.50
## [55] BiocIO_1.20.0            V8_8.0.1                 rtracklayer_1.70.0
## [58] rlang_1.1.6              Rcpp_1.1.0               DBI_1.2.3
## [61] BiocManager_1.30.26      alabaster.ranges_1.10.0  alabaster.schemas_1.10.0
## [64] jsonlite_2.0.0           Rhdf5lib_1.32.0          R6_2.6.1
## [67] GenomicAlignments_1.46.0
```