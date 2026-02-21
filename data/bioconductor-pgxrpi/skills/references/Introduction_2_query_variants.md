# Introduction\_2\_query\_variants

Hangjia Zhao

#### 2025-10-30

# Contents

* [1 Load library](#load-library)
  + [1.1 `pgxLoader` function](#pgxloader-function)
* [2 Retrieve variants](#retrieve-variants)
  + [2.1 Get biosample id](#get-biosample-id)
  + [2.2 The first output format (by default)](#the-first-output-format-by-default)
  + [2.3 The second output format (`output` = “pgxseg”)](#the-second-output-format-output-pgxseg)
  + [2.4 The third output format (`output` = “seg”)](#the-third-output-format-output-seg)
* [3 Export variants data for visualization](#export-variants-data-for-visualization)
  + [3.1 Upload ‘pgxseg’ file to Progenetix website](#upload-pgxseg-file-to-progenetix-website)
  + [3.2 Upload ‘.seg’ file to IGV](#upload-.seg-file-to-igv)
* [4 Retrive CNV fraction of biosamples](#retrive-cnv-fraction-of-biosamples)
  + [4.1 Across chromosomes or the whole genome](#across-chromosomes-or-the-whole-genome)
  + [4.2 Across genomic bins](#across-genomic-bins)
* [5 Session Info](#session-info)

[Progenetix](https://progenetix.org/) is an open data resource that provides curated individual cancer copy number variation (CNV) profiles along with associated metadata sourced from published oncogenomic studies and various data repositories. This vignette provides a comprehensive guide on accessing genomic variant data within the Progenetix database.

If your focus lies in cancer cell lines, you can access data from [*cancercelllines.org*](https://cancercelllines.org/) by setting the `domain` parameter to `"cancercelllines.org"` in `pgxLoader` function. This data repository originates from CNV profiling data of cell lines initially collected as part of Progenetix and currently includes additional types of genomic mutations.

# 1 Load library

```
library(pgxRpi)
library(SummarizedExperiment) # for pgxmatrix data
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
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
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
```

## 1.1 `pgxLoader` function

This function loads various data from `Progenetix` database via the Beacon v2 API with some extensions (BeaconPlus).

The parameters of this function used in this tutorial:

* `type`: A string specifying output data type. `"g_variants"` and `"cnv_fraction"` are used in this tutorial.
* `output`: A string specifying output file format. The available options depend on the `type` parameter. When `type` is `"g_variants"`, available options are `NULL` (default), `"pgxseg"`, or `"seg"`; when `type` is `"cnv_fraction"`, available options are `NULL` (default) or `"pgxmatrix"`.
* `biosample_id`: Identifiers used in the query database for identifying biosamples.
* `individual_id`: Identifiers used in the query database for identifying individuals.
* `filters`: Identifiers used in public repositories, bio-ontology terms, or custom terms such as `"NCIT:C7376"`. For more information about filters, see the [documentation](https://docs.progenetix.org/common/beacon-api/#filters-filtering-terms).
* `codematches`: A logical value determining whether to exclude samples from child concepts
  of specified filters in the ontology tree. If `TRUE`, only samples exactly matching the specified filters will be included. Do not use this parameter when `filters` include ontology-irrelevant filters such as pubmed or cohort identifiers. Default is `FALSE`.
* `limit`: Integer to specify the number of returned profiles. Default is `0` (return all).
* `skip`: Integer to specify the number of skipped profiles. E.g. if `skip = 2,limit=500`, the first 2\*500=1000 profiles are skipped and the next 500 profiles are returned. Default is `0` (no skip).
* `dataset`: A string specifying the dataset to query from the Beacon response. Default is `NULL`, which includes results from all datasets.
* `save_file`: A logical value determining whether to save variant data as a local file instead of direct return. Only used when the parameter `type` is `"g_variants"`. Default is `FALSE`.
* `filename`: A string specifying the path and name of the file to be saved. Only used if the parameter `save_file` is `TRUE`. Default is `"variants.tsv"`, saved in the current working directory..
* `num_cores`: An integer specifying the number of cores to use for parallel processing during Beacon v2 variant data queries from multiple biosamples. Default is `1`.
* `use_https`: A logical value indicating whether to use the HTTPS protocol. If `TRUE`, the domain will be prefixed with `"https://"`; otherwise, `"http://"` will be used. Default is `TRUE`.
* `domain`: A string specifying the domain of the query data resource. Default is `"progenetix.org"`.
* `entry_point`: A string specifying the entry point of the Beacon v2 API. Default is `"beacon"`, resulting in the endpoint being `"https://progenetix.org/beacon"`.

# 2 Retrieve variants

Due to time-out constraints, variant data in Progenetix or cancercelllines can only be queried using biosample ids, rather than filters or individual ids. To speed up the process, you can use the `num_cores` parameter to enable parallel processing across multiple samples. For more details about retrieving biosample ids, refer to the vignette *Introduction\_1\_load\_metadata*.

## 2.1 Get biosample id

```
# get 2 samples for demonstration
biosamples <- pgxLoader(type="biosamples", filters = "NCIT:C3512", limit=2)

biosample_id <- biosamples$biosample_id

biosample_id
#> [1] "pgxbs-m84dbahf" "pgxbs-m84d9x03"
```

There are three output formats.

## 2.2 The first output format (by default)

The default output format extracts variant data from the Beacon v2 response, containing variant id and associated analysis id, biosample id and individual id. The CNV data is represented as [copy number change class](https://vrs.ga4gh.org/en/stable/concepts/SystemicVariation/CopyNumberChange.html#copy-change-term-definitions) following the GA4GH Variation Representation Specification (VRS).

```
variant_1 <- pgxLoader(type="g_variants", biosample_id = biosample_id)
#> Warning in read_variant_beacon(i, limit, use_https, domain, entry_point, : NAs
#> introduced by coercion
#> Warning in read_variant_beacon(i, limit, use_https, domain, entry_point, : NAs
#> introduced by coercion
head(variant_1)
#>                        variant_id    analysis_id   biosample_id   individual_id
#> 1 bycvar-684b062f49354dfc45f7a13b pgxcs-m84dbahf pgxbs-m84dbahf pgxind-m84d7a5q
#> 2 bycvar-684b063049354dfc45f7a14c pgxcs-m84dbahf pgxbs-m84dbahf pgxind-m84d7a5q
#> 3 bycvar-684b063049354dfc45f7a143 pgxcs-m84dbahf pgxbs-m84dbahf pgxind-m84d7a5q
#> 4 bycvar-684b062f49354dfc45f7a139 pgxcs-m84dbahf pgxbs-m84dbahf pgxind-m84d7a5q
#> 5 bycvar-684b063049354dfc45f7a142 pgxcs-m84dbahf pgxbs-m84dbahf pgxind-m84d7a5q
#> 6 bycvar-684b063049354dfc45f7a141 pgxcs-m84dbahf pgxbs-m84dbahf pgxind-m84d7a5q
#>                         variant_internal_id variation_location_chromosome
#> 1 NC_000005.10:218387-181114186:EFO_0030068                             5
#> 2  NC_000017.11:264878-35373143:EFO_0030068                            17
#> 3   NC_000012.12:285559-2892178:EFO_0030068                            12
#> 4 NC_000003.12:376406-195760866:EFO_0030068                             3
#> 5 NC_000010.11:414000-132385563:EFO_0030068                            10
#> 6  NC_000009.12:421980-31112859:EFO_0030068                             9
#>   variation_location_end variation_location_sequence_id
#> 1              181114186            refseq:NC_000005.10
#> 2               35373143            refseq:NC_000017.11
#> 3                2892178            refseq:NC_000012.12
#> 4              195760866            refseq:NC_000003.12
#> 5              132385563            refseq:NC_000010.11
#> 6               31112859            refseq:NC_000009.12
#>   variation_location_sequence_reference_refget_accession
#> 1                    SQ.aUiQCzCPZ2d0csHbMSbh2NzInhonSXwI
#> 2                    SQ.dLZ15tNO1Ur0IcGjwc3Sdi_0A6Yf4zm7
#> 3                    SQ.6wlJpONE3oNb4D69ULmEXhqyDZ4vwNfl
#> 4                    SQ.Zu7h9AggXxhTaGVsy7h_EZSChSZGcmgX
#> 5                    SQ.ss8r_wB0-b9r44TQTMmVTI92884QvBiB
#> 6                    SQ.KEO-4XBcm1cxeo_DIQ8_ofqGUkp4iZhI
#>   variation_location_sequence_reference_type variation_location_start
#> 1                          SequenceReference                   218387
#> 2                          SequenceReference                   264878
#> 3                          SequenceReference                   285559
#> 4                          SequenceReference                   376406
#> 5                          SequenceReference                   414000
#> 6                          SequenceReference                   421980
#>   variation_location_type variant_copychange identifiers molecularAttributes
#> 1        SequenceLocation     low-level loss          NA                  NA
#> 2        SequenceLocation     low-level loss          NA                  NA
#> 3        SequenceLocation     low-level loss          NA                  NA
#> 4        SequenceLocation     low-level loss          NA                  NA
#> 5        SequenceLocation     low-level loss          NA                  NA
#> 6        SequenceLocation     low-level loss          NA                  NA
```

You can also query variant data from other Beacon v2 resources by setting the `domain` and `entry_point` parameters accordingly.

```
variant_2 <- pgxLoader(type="g_variants", biosample_id = "cellzbs-kftvksak", domain = "cancercelllines.org", entry_point="beacon")
#> Warning in read_variant_beacon(i, limit, use_https, domain, entry_point, : NAs
#> introduced by coercion
head(variant_2)
#>                        variant_id      analysis_id     biosample_id
#> 1 bycvar-63d118be42040c6f3561d6b5 cellzcs-kftwtxov cellzbs-kftvksak
#> 2 bycvar-63d118be42040c6f3561d6cd cellzcs-kftwtxov cellzbs-kftvksak
#> 3 bycvar-63d118be42040c6f3561d6b7 cellzcs-kftwtxov cellzbs-kftvksak
#> 4 bycvar-63d118be42040c6f3561d552 cellzcs-kftwtxov cellzbs-kftvksak
#> 5 bycvar-63d118be42040c6f3561d506 cellzcs-kftwtxov cellzbs-kftvksak
#> 6 bycvar-63d118be42040c6f3561d635 cellzcs-kftwtxov cellzbs-kftvksak
#>       individual_id                     variant_internal_id
#> 1 cellzind-B45e11EE    NC_000016.10:10777-11588:EFO_0030070
#> 2 cellzind-B45e11EE   NC_000018.10:11543-122470:EFO_0030070
#> 3 cellzind-B45e11EE NC_000016.10:12016-14877558:EFO_0030067
#> 4 cellzind-B45e11EE    NC_000004.12:12281-48898:EFO_0030067
#> 5 cellzind-B45e11EE NC_000003.12:18667-46751887:EFO_0030067
#> 6 cellzind-B45e11EE    NC_000010.11:26823-58258:EFO_0030070
#>   variation_location_chromosome variation_location_end
#> 1                            16                  11588
#> 2                            18                 122470
#> 3                            16               14877558
#> 4                             4                  48898
#> 5                             3               46751887
#> 6                            10                  58258
#>   variation_location_sequence_id
#> 1            refseq:NC_000016.10
#> 2            refseq:NC_000018.10
#> 3            refseq:NC_000016.10
#> 4            refseq:NC_000004.12
#> 5            refseq:NC_000003.12
#> 6            refseq:NC_000010.11
#>   variation_location_sequence_reference_refget_accession
#> 1                    SQ.yC_0RBj3fgBlvgyAuycbzdubtLxq-rE0
#> 2                    SQ.vWwFhJ5lQDMhh-czg06YtlWqu0lvFAZV
#> 3                    SQ.yC_0RBj3fgBlvgyAuycbzdubtLxq-rE0
#> 4                    SQ.HxuclGHh0XCDuF8x6yQrpHUBL7ZntAHc
#> 5                    SQ.Zu7h9AggXxhTaGVsy7h_EZSChSZGcmgX
#> 6                    SQ.ss8r_wB0-b9r44TQTMmVTI92884QvBiB
#>   variation_location_sequence_reference_type variation_location_start
#> 1                          SequenceReference                    10777
#> 2                          SequenceReference                    11543
#> 3                          SequenceReference                    12016
#> 4                          SequenceReference                    12281
#> 5                          SequenceReference                    18667
#> 6                          SequenceReference                    26823
#>   variation_location_type variant_copychange identifiers molecularAttributes
#> 1        SequenceLocation               gain          NA                  NA
#> 2        SequenceLocation               gain          NA                  NA
#> 3        SequenceLocation               loss          NA                  NA
#> 4        SequenceLocation               loss          NA                  NA
#> 5        SequenceLocation               loss          NA                  NA
#> 6        SequenceLocation               gain          NA                  NA
```

## 2.3 The second output format (`output` = “pgxseg”)

This format accesses data from [Progenetix services API](https://docs.progenetix.org/services/), which utilizes specialized resources within Progenetix. The ‘.pgxseg’ file format contains segment mean values (in `log2` column), which are equal to log2(copy number of measured sample/copy number of control sample (usually 2)). A few variants are point mutations represented by columns `reference_bases` and `alternate_bases`.

```
variant_3 <- pgxLoader(type="g_variants", biosample_id = biosample_id,output = "pgxseg")
head(variant_3)
#>     biosample_id reference_name     start       end    log2 variant_type
#> 1 pgxbs-m84dbahf              1 120005459 247433974  0.6774          DUP
#> 2 pgxbs-m84dbahf              3    376406 195760866 -0.1637          DEL
#> 3 pgxbs-m84dbahf              4  53377881 189341332 -0.4039          DEL
#> 4 pgxbs-m84dbahf              5    218387 181114186 -0.1362          DEL
#> 5 pgxbs-m84dbahf              6  97282077 114057806 -0.8663          DEL
#> 6 pgxbs-m84dbahf              6 161350155 170489803 -0.2514          DEL
#>   reference_sequence sequence variant_state_id variant_state_label
#> 1                  .        .      EFO:0030071      low-level gain
#> 2                  .        .      EFO:0030068      low-level loss
#> 3                  .        .      EFO:0030068      low-level loss
#> 4                  .        .      EFO:0030068      low-level loss
#> 5                  .        .      EFO:0020073     high-level loss
#> 6                  .        .      EFO:0030068      low-level loss
```

## 2.4 The third output format (`output` = “seg”)

This format accesses data from [Progenetix services API](https://docs.progenetix.org/services/), which utilizes specialized resources within Progenetix. This format is compatible with IGV tool for visualization.

```
variant_4 <- pgxLoader(type="g_variants", biosample_id = biosample_id,output = "seg")
head(variant_4)
#>               ID chrom loc.start   loc.end num.mark seg.mean
#> 1 pgxbs-m84dbahf     1 120005460 247433974       NA   0.6774
#> 2 pgxbs-m84dbahf     3    376407 195760866       NA  -0.1637
#> 3 pgxbs-m84dbahf     4  53377882 189341332       NA  -0.4039
#> 4 pgxbs-m84dbahf     5    218388 181114186       NA  -0.1362
#> 5 pgxbs-m84dbahf     6  97282078 114057806       NA  -0.8663
#> 6 pgxbs-m84dbahf     6 161350156 170489803       NA  -0.2514
```

# 3 Export variants data for visualization

Setting `save_file` to TRUE in the `pgxLoader` function will save the retrieved variants data to a file
rather than returning it directly. By default, the data will be saved in the current working directory,
but you can specify a different path using the `filename` parameter. This export functionality is
only available for variants data (when `type='g_variants'`).

## 3.1 Upload ‘pgxseg’ file to Progenetix website

The following codes creates a ‘.pgxseg’ file with the name “variants.pgxseg” in “~/Downloads/” folder.

```
pgxLoader(type="g_variants", output="pgxseg", biosample_id=biosample_id, save_file=TRUE,
          filename="~/Downloads/variants.pgxseg")
```

To visualize the ‘.pgxseg’ file, you can either upload it to [this link](https://progenetix.org/service-collection/uploader)
or use the [byconaut](https://byconaut.progenetix.org/) package for local visualization when dealing with a large number of samples.

## 3.2 Upload ‘.seg’ file to IGV

The following codes creates a special ‘.seg’ file with the name “variants.seg” in “~/Downloads/” folder.

```
pgxLoader(type="g_variants", output="seg", biosample_id=biosample_id, save_file=TRUE,
          filename="~/Downloads/variants.seg")
```

You can upload this ‘.seg’ file to [IGV tool](https://software.broadinstitute.org/software/igv/) for visualization.

# 4 Retrive CNV fraction of biosamples

Because segment variants are not harmonized across samples, Progenetix provides processed CNV features, known as CNV fractions. These fractions represent the proportion of genomic regions overlapping one or more CNVs of a given type, facilitating sample-wise comparisons. The following query is based on filters, but biosample id and individual id are also available for sample-specific CNV fraction queries. For more information about filters, biosample id and individual id, as well as the use of parameters `skip`, `limit`, and `codematches`, see the vignette *Introduction\_1\_load\_metadata*.

CNV fraction data is retrieved through the [Progenetix services API](https://docs.progenetix.org/services/). When making a query, the domain of the data resource should be set to either `"progenetix.org"` (by default) or `"cancercelllines.org"`.

## 4.1 Across chromosomes or the whole genome

```
cnv_fraction <- pgxLoader(type="cnv_fraction", filters = "NCIT:C2948")
```

This includes CNV fraction across chromosome arms, whole chromosomes, or the whole genome.

```
names(cnv_fraction)
#> [1] "arm_cnv_frac"    "chr_cnv_frac"    "genome_cnv_frac"
```

The CNV fraction across chromosomal arms looks like this

```
head(cnv_fraction$arm_cnv_frac)[,c(1:4, 49:52)]
#>                chr1p.dup chr1q.dup chr2p.dup chr2q.dup chr1p.del chr1q.del
#> pgxcs-kftvs0ri         0     0.000     0.000     0.000     0.000         0
#> pgxcs-kftvu9w2         0     0.000     0.000     0.000     0.000         0
#> pgxcs-kftvw1kw         0     0.000     0.000     0.000     0.000         0
#> pgxcs-kftvw1ld         0     0.000     0.000     0.000     0.000         0
#> pgxcs-kftvw1lu         0     0.000     0.000     0.000     0.225         0
#> pgxcs-kftvw1mb         0     0.979     0.989     0.003     0.000         0
#>                chr2p.del chr2q.del
#> pgxcs-kftvs0ri         0         0
#> pgxcs-kftvu9w2         0         0
#> pgxcs-kftvw1kw         0         0
#> pgxcs-kftvw1ld         0         0
#> pgxcs-kftvw1lu         0         0
#> pgxcs-kftvw1mb         0         0
```

The row names are analyses ids from samples that belong to the input filter NCIT:C2948. There are 96 columns.
The first 48 columns are duplication fraction across chromosomal arms, followed by deletion fraction.
CNV fraction across whole chromosomes is similar, with the only difference in columns.

The CNV fraction across the genome (hg38) looks like this

```
head(cnv_fraction$genome_cnv_frac)
#>                cnvfraction dupfraction delfraction
#> pgxcs-kftvs0ri       0.080       0.036       0.044
#> pgxcs-kftvu9w2       0.058       0.010       0.048
#> pgxcs-kftvw1kw       0.000       0.000       0.000
#> pgxcs-kftvw1ld       0.000       0.000       0.000
#> pgxcs-kftvw1lu       0.027       0.000       0.027
#> pgxcs-kftvw1mb       0.176       0.159       0.017
```

The first column is the total called fraction, followed by duplication fraction and deletion fraction.

## 4.2 Across genomic bins

```
cnvfrac_matrix <- pgxLoader(type="cnv_fraction", output="pgxmatrix", filters = "NCIT:C2948")
```

The returned data is stored in [*RangedSummarizedExperiment*](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) object, which is a matrix-like container where rows represent ranges of interest (as a GRanges object) and columns represent analyses derived from biosamples. The data looks like this

```
cnvfrac_matrix
#> class: RangedSummarizedExperiment
#> dim: 6212 87
#> metadata(0):
#> assays(1): cnv_matrix
#> rownames(6212): 1 2 ... 6211 6212
#> rowData names(1): type
#> colnames(87): pgxcs-kftvs0ri pgxcs-kftvu9w2 ... pgxcs-m84dipwe
#>   pgxcs-m84dir2n
#> colData names(3): analysis_id biosample_id group_id
```

You could get the interval information by `rowRanges` function from *SummarizedExperiment* package.

```
rowRanges(cnvfrac_matrix)
#> GRanges object with 6212 ranges and 1 metadata column:
#>        seqnames            ranges strand |        type
#>           <Rle>         <IRanges>  <Rle> | <character>
#>      1     chr1          0-400000      * |         DUP
#>      2     chr1    400000-1400000      * |         DUP
#>      3     chr1   1400000-2400000      * |         DUP
#>      4     chr1   2400000-3400000      * |         DUP
#>      5     chr1   3400000-4400000      * |         DUP
#>    ...      ...               ...    ... .         ...
#>   6208     chrY 52400000-53400000      * |         DEL
#>   6209     chrY 53400000-54400000      * |         DEL
#>   6210     chrY 54400000-55400000      * |         DEL
#>   6211     chrY 55400000-56400000      * |         DEL
#>   6212     chrY 56400000-57227415      * |         DEL
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

To access the CNV fraction matrix, use `assay` accesssor from *SummarizedExperiment* package

```
assay(cnvfrac_matrix)[1:3,1:3]
#>   pgxcs-kftvs0ri pgxcs-kftvu9w2 pgxcs-kftvw1kw
#> 1              0              0              0
#> 2              0              0              0
#> 3              0              0              0
```

The matrix contains 6212 rows, corresponding to genomic regions. These rows include 3,106 intervals with “gain status” and 3,106 intervals with “loss status”. The columns represent analysis profiles derived from samples that belong to the input filter.

The value is the fraction of the binned interval overlapping with one or more CNVs of the given type (DUP/DEL). For example, if the value in the second row, the first column is 0.2, it means that one or more duplication events overlapped with 20% of the genomic bin located in chromosome 1: 400000-1400000 in the first analysis profile.

To get associated biosample id and filters for analyses, use `colData` function from *SummarizedExperiment* package:

```
colData(cnvfrac_matrix)
#> DataFrame with 87 rows and 3 columns
#>                   analysis_id   biosample_id    group_id
#>                   <character>    <character> <character>
#> pgxcs-kftvs0ri pgxcs-kftvs0ri pgxbs-kftvh262  NCIT:C2948
#> pgxcs-kftvu9w2 pgxcs-kftvu9w2 pgxbs-kftvh9fp  NCIT:C2948
#> pgxcs-kftvw1kw pgxcs-kftvw1kw pgxbs-kftvhf4h  NCIT:C8893
#> pgxcs-kftvw1ld pgxcs-kftvw1ld pgxbs-kftvhf4i  NCIT:C8893
#> pgxcs-kftvw1lu pgxcs-kftvw1lu pgxbs-kftvhf4k  NCIT:C8893
#> ...                       ...            ...         ...
#> pgxcs-m84dghm4 pgxcs-m84dghm4 pgxbs-m84dghm4 NCIT:C27246
#> pgxcs-m84dgpmm pgxcs-m84dgpmm pgxbs-m84dgpmm  NCIT:C4515
#> pgxcs-m84dhq9w pgxcs-m84dhq9w pgxbs-m84dhq9w  NCIT:C7733
#> pgxcs-m84dipwe pgxcs-m84dipwe pgxbs-m84dipwe  NCIT:C7733
#> pgxcs-m84dir2n pgxcs-m84dir2n pgxbs-m84dir2n NCIT:C27246
```

It is noted that the number of analysis profiles does not necessarily equal the number of samples. One biosample id may correspond to multiple analysis ids. `group_id` corresponds to the meaning of `filters`.

# 5 Session Info

```
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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] future_1.67.0               pgxRpi_1.6.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2
#>  [4] S7_0.2.0            fastmap_1.2.0       digest_0.6.37
#>  [7] timechange_0.3.0    lifecycle_1.0.4     survival_3.8-3
#> [10] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
#> [13] sass_0.4.10         tools_4.5.1         yaml_2.3.10
#> [16] data.table_1.17.8   knitr_1.50          ggsignif_0.6.4
#> [19] S4Arrays_1.10.0     labeling_0.4.3      curl_7.0.0
#> [22] DelayedArray_0.36.0 RColorBrewer_1.1-3  abind_1.4-8
#> [25] withr_3.0.2         purrr_1.1.0         grid_4.5.1
#> [28] ggpubr_0.6.2        xtable_1.8-4        ggplot2_4.0.0
#> [31] globals_0.18.0      scales_1.4.0        dichromat_2.0-0.1
#> [34] tinytex_0.57        cli_3.6.5           rmarkdown_2.30
#> [37] crayon_1.5.3        future.apply_1.20.0 km.ci_0.5-6
#> [40] httr_1.4.7          survminer_0.5.1     cachem_1.1.0
#> [43] splines_4.5.1       parallel_4.5.1      XVector_0.50.0
#> [46] BiocManager_1.30.26 survMisc_0.5.6      vctrs_0.6.5
#> [49] Matrix_1.7-4        jsonlite_2.0.0      carData_3.0-5
#> [52] bookdown_0.45       car_3.1-3           rstatix_0.7.3
#> [55] Formula_1.2-5       listenv_0.9.1       magick_2.9.0
#> [58] attempt_0.3.1       tidyr_1.3.1         jquerylib_0.1.4
#> [61] glue_1.8.0          parallelly_1.45.1   codetools_0.2-20
#> [64] lubridate_1.9.4     gtable_0.3.6        tibble_3.3.0
#> [67] pillar_1.11.1       htmltools_0.5.8.1   R6_2.6.1
#> [70] KMsurv_0.1-6        evaluate_1.0.5      lattice_0.22-7
#> [73] backports_1.5.0     broom_1.0.10        bslib_0.9.0
#> [76] Rcpp_1.1.0          SparseArray_1.10.0  gridExtra_2.3
#> [79] xfun_0.53           zoo_1.8-14          pkgconfig_2.0.3
```