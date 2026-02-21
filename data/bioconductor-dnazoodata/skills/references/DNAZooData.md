# DNAZooData

Jacques Serizay

#### 2025-11-04

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 HiCExperiment and DNAZooData](#hicexperiment-and-dnazoodata)
* [4 Session info](#session-info)

# 1 Introduction

The [DNA Zoo Consortium](https://www.dnazoo.org/)
is a collaborative group whose aim is to correct and refine genome assemblies
across the tree of life using Hi-C approaches. As of 2023, they have
performed Hi-C across more than 300 animal, plant and fungi species.

`DNAZooData` is a package giving programmatic access
to these uniformly processed Hi-C contact files, as well as the refined genome
assemblies.

The `DNAZooData()` function provides a gateway to DNA Zoo-hosted Hi-C files,
fetching and caching relevant contact matrices in `.hic` format, and
providing a direct URL to corrcted genome assemblies in `fasta` format.
It returns a `HicFile` object, which can then be imported in memory using
`HiCExperiment::import()`.

`HiCFile` metadata also points to a URL to directly fetch the genome assembly
corrected by the DNA Zoo consortium.

```
library(DNAZooData)
head(DNAZooData())
#>                   species                              readme
#> 1        Acinonyx_jubatus        Acinonyx_jubatus/README.json
#> 2      Acropora_millepora      Acropora_millepora/README.json
#> 3     Addax_nasomaculatus     Addax_nasomaculatus/README.json
#> 4           Aedes_aegypti           Aedes_aegypti/README.json
#> 5   Aedes_aegypti__AaegL4   Aedes_aegypti__AaegL4/README.json
#> 6 Aedes_aegypti__AaegL5.0 Aedes_aegypti__AaegL5.0/README.json
#>                                                           readme_link
#> 1        https://dnazoo.s3.wasabisys.com/Acinonyx_jubatus/README.json
#> 2      https://dnazoo.s3.wasabisys.com/Acropora_millepora/README.json
#> 3     https://dnazoo.s3.wasabisys.com/Addax_nasomaculatus/README.json
#> 4           https://dnazoo.s3.wasabisys.com/Aedes_aegypti/README.json
#> 5   https://dnazoo.s3.wasabisys.com/Aedes_aegypti__AaegL4/README.json
#> 6 https://dnazoo.s3.wasabisys.com/Aedes_aegypti__AaegL5.0/README.json
#>   original_assembly     new_assembly
#> 1           aciJub1      aciJub1_HiC
#> 2       amil_sf_1.1  amil_sf_1.1_HiC
#> 3      ASM1959352v1 ASM1959352v1_HiC
#> 4        AGWG.draft         AaegL5.0
#> 5            AaegL3           AaegL4
#> 6        AGWG.draft         AaegL5.0
#>                                                               new_assembly_link
#> 1         https://dnazoo.s3.wasabisys.com/Acinonyx_jubatus/aciJub1_HiC.fasta.gz
#> 2   https://dnazoo.s3.wasabisys.com/Acropora_millepora/amil_sf_1.1_HiC.fasta.gz
#> 3 https://dnazoo.s3.wasabisys.com/Addax_nasomaculatus/ASM1959352v1_HiC.fasta.gz
#> 4               https://dnazoo.s3.wasabisys.com/Aedes_aegypti/AaegL5.0.fasta.gz
#> 5         https://dnazoo.s3.wasabisys.com/Aedes_aegypti__AaegL4/AaegL4.fasta.gz
#> 6     https://dnazoo.s3.wasabisys.com/Aedes_aegypti__AaegL5.0/AaegL5.0.fasta.gz
#>   new_assembly_link_status
#> 1                      200
#> 2                      200
#> 3                      200
#> 4                      404
#> 5                      200
#> 6                      200
#>                                                                   hic_link
#> 1    https://dnazoo.s3.wasabisys.com/Acinonyx_jubatus/aciJub1.rawchrom.hic
#> 2   https://dnazoo.s3.wasabisys.com/Acropora_millepora/amil_sf_1.1_HiC.hic
#> 3 https://dnazoo.s3.wasabisys.com/Addax_nasomaculatus/ASM1959352v1_HiC.hic
#> 4                                                                     <NA>
#> 5         https://dnazoo.s3.wasabisys.com/Aedes_aegypti__AaegL4/AaegL4.hic
#> 6     https://dnazoo.s3.wasabisys.com/Aedes_aegypti__AaegL5.0/AaegL5.0.hic
hicfile <- DNAZooData(species = 'Hypsibius_dujardini')
S4Vectors::metadata(hicfile)$organism
#> $vernacular
#> [1] "Tardigrade"
#>
#> $binomial
#> [1] "Hypsibius dujardini"
#>
#> $funFact
#> [1] "<i>Hypsibius dujardini</i> is a species of tardigrade, a tiny microscopic organism. They are also commonly called water bears. This species is found world-wide!"
#>
#> $extraInfo
#> [1] "on BioKIDS website"
#>
#> $extraInfoLink
#> [1] "http://www.biokids.umich.edu/critters/Hypsibius_dujardini/"
#>
#> $image
#> [1] "https://static.wixstatic.com/media/2b9330_82db39c219f24b20a75cb38943aad1fb~mv2.jpg"
#>
#> $imageCredit
#> [1] "By Willow Gabriel, Goldstein Lab - https://www.flickr.com/photos/waterbears/1614095719/ Template:Uploader Transferred from en.wikipedia to Commons., CC BY-SA 2.5, https://commons.wikimedia.org/w/index.php?curid=2261992"
#>
#> $isChromognomes
#> [1] "FALSE"
#>
#> $taxonomy
#> [1] "Species:202423-914154-914155-914158-155166-155362-710171-710179-710192-155390-155420"
S4Vectors::metadata(hicfile)$assemblyURL
#> [1] "https://dnazoo.s3.wasabisys.com/Hypsibius_dujardini/nHd_3.1_HiC.fasta.gz"
```

# 2 Installation

`DNAZooData` package can be installed from Bioconductor using the following
command:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DNAZooData")
```

# 3 HiCExperiment and DNAZooData

The `HiCExperiment` package can be used to import `.hic` files provided by
`DNAZooData`. Refer to `HiCExperiment` package documentation for further
information.

```
availableResolutions(hicfile)
#> resolutions(9): 5000 10000 ... 1e+06 2500000
#>
availableChromosomes(hicfile)
#> Seqinfo object with 5 sequences from an unspecified genome:
#>   seqnames       seqlengths isCircular genome
#>   HiC_scaffold_1   24848249         NA   <NA>
#>   HiC_scaffold_2   19596306         NA   <NA>
#>   HiC_scaffold_3   18943121         NA   <NA>
#>   HiC_scaffold_4   17897025         NA   <NA>
#>   HiC_scaffold_5   16309062         NA   <NA>
x <- import(hicfile, resolution = 10000, focus = 'HiC_scaffold_4')
x
#> `HiCExperiment` object with 435,341 contacts over 1,790 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/DNAZooData/1825bb32662d07_nHd_3.1_HiC.hic"
#> focus: "HiC_scaffold_4"
#> resolutions(9): 5000 10000 ... 1e+06 2500000
#> active resolution: 10000
#> interactions: 167314
#> scores(2): count balanced
#> topologicalFeatures: compartments(0) borders(0) loops(0) viewpoints(0)
#> pairsFile: N/A
#> metadata(6): organism draftAssembly ... credits assemblyURL
interactions(x)
#> GInteractions object with 167314 interactions and 4 metadata columns:
#>                 seqnames1           ranges1          seqnames2
#>                     <Rle>         <IRanges>              <Rle>
#>        [1] HiC_scaffold_4           1-10000 --- HiC_scaffold_4
#>        [2] HiC_scaffold_4           1-10000 --- HiC_scaffold_4
#>        [3] HiC_scaffold_4           1-10000 --- HiC_scaffold_4
#>        [4] HiC_scaffold_4           1-10000 --- HiC_scaffold_4
#>        [5] HiC_scaffold_4           1-10000 --- HiC_scaffold_4
#>        ...            ...               ... ...            ...
#>   [167310] HiC_scaffold_4 17870001-17880000 --- HiC_scaffold_4
#>   [167311] HiC_scaffold_4 17870001-17880000 --- HiC_scaffold_4
#>   [167312] HiC_scaffold_4 17880001-17890000 --- HiC_scaffold_4
#>   [167313] HiC_scaffold_4 17880001-17890000 --- HiC_scaffold_4
#>   [167314] HiC_scaffold_4 17890001-17897025 --- HiC_scaffold_4
#>                      ranges2 |   bin_id1   bin_id2     count  balanced
#>                    <IRanges> | <numeric> <numeric> <numeric> <numeric>
#>        [1]           1-10000 |      6340      6340        20 162.01923
#>        [2]       10001-20000 |      6340      6341         4  10.97758
#>        [3]       20001-30000 |      6340      6342         1   2.82559
#>        [4]       30001-40000 |      6340      6343         1   3.00288
#>        [5]       80001-90000 |      6340      6348         1   2.63953
#>        ...               ... .       ...       ...       ...       ...
#>   [167310] 17880001-17890000 |      8127      8128         4   3.91164
#>   [167311] 17890001-17897025 |      8127      8129         4   7.35998
#>   [167312] 17880001-17890000 |      8128      8128       107  99.46175
#>   [167313] 17890001-17897025 |      8128      8129         8  13.99203
#>   [167314] 17890001-17897025 |      8129      8129        47 154.67041
#>   -------
#>   regions: 1790 ranges and 3 metadata columns
#>   seqinfo: 5 sequences from an unspecified genome
as(x, 'ContactMatrix')
#> class: ContactMatrix
#> dim: 1790 1790
#> type: dgCMatrix
#> rownames: NULL
#> colnames: NULL
#> metadata(0):
#> regions: 1790
```

# 4 Session info

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
#> [1] DNAZooData_1.10.0    HiCExperiment_1.10.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
#>  [3] httr2_1.2.1                 xfun_0.54
#>  [5] bslib_0.9.0                 rhdf5_2.54.0
#>  [7] Biobase_2.70.0              lattice_0.22-7
#>  [9] tzdb_0.5.0                  rhdf5filters_1.22.0
#> [11] vctrs_0.6.5                 tools_4.5.1
#> [13] generics_0.1.4              curl_7.0.0
#> [15] stats4_4.5.1                parallel_4.5.1
#> [17] tibble_3.3.0                RSQLite_2.4.3
#> [19] blob_1.2.4                  pkgconfig_2.0.3
#> [21] Matrix_1.7-4                dbplyr_2.5.1
#> [23] S4Vectors_0.48.0            lifecycle_1.0.4
#> [25] compiler_4.5.1              Seqinfo_1.0.0
#> [27] codetools_0.2-20            InteractionSet_1.38.0
#> [29] htmltools_0.5.8.1           sass_0.4.10
#> [31] yaml_2.3.10                 pillar_1.11.1
#> [33] crayon_1.5.3                jquerylib_0.1.4
#> [35] BiocParallel_1.44.0         DelayedArray_0.36.0
#> [37] cachem_1.1.0                abind_1.4-8
#> [39] tidyselect_1.2.1            digest_0.6.37
#> [41] purrr_1.1.0                 dplyr_1.1.4
#> [43] bookdown_0.45               fastmap_1.2.0
#> [45] grid_4.5.1                  cli_3.6.5
#> [47] SparseArray_1.10.1          magrittr_2.0.4
#> [49] S4Arrays_1.10.0             withr_3.0.2
#> [51] filelock_1.0.3              rappdirs_0.3.3
#> [53] bit64_4.6.0-1               rmarkdown_2.30
#> [55] XVector_0.50.0              matrixStats_1.5.0
#> [57] bit_4.6.0                   memoise_2.0.1
#> [59] evaluate_1.0.5              knitr_1.50
#> [61] GenomicRanges_1.62.0        IRanges_2.44.0
#> [63] BiocIO_1.20.0               BiocFileCache_3.0.0
#> [65] rlang_1.1.6                 Rcpp_1.1.0
#> [67] glue_1.8.0                  DBI_1.2.3
#> [69] BiocManager_1.30.26         BiocGenerics_0.56.0
#> [71] vroom_1.6.6                 jsonlite_2.0.0
#> [73] strawr_0.0.92               R6_2.6.1
#> [75] Rhdf5lib_1.32.0             MatrixGenerics_1.22.0
```