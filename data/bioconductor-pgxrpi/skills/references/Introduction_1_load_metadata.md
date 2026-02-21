# Introduction\_1\_load\_metadata

Hangjia Zhao

#### 2025-10-30

# Contents

* [1 Load library](#load-library)
  + [1.1 `pgxLoader` function](#pgxloader-function)
* [2 Retrieve biosamples information](#retrieve-biosamples-information)
  + [2.1 Search by filters](#search-by-filters)
  + [2.2 Search by biosample id and individual id](#search-by-biosample-id-and-individual-id)
  + [2.3 Access a subset of samples](#access-a-subset-of-samples)
  + [2.4 Parameter `codematches` use](#parameter-codematches-use)
* [3 Retrieve individuals information](#retrieve-individuals-information)
* [4 Retrieve analyses information](#retrieve-analyses-information)
* [5 Retrieve the number of results for a specific filter](#retrieve-the-number-of-results-for-a-specific-filter)
* [6 Query from multiple data resources](#query-from-multiple-data-resources)
* [7 Visualization of survival data](#visualization-of-survival-data)
  + [7.1 `pgxMetaplot` function](#pgxmetaplot-function)
    - [7.1.1 Example usage](#example-usage)
* [8 Session Info](#session-info)

[Progenetix](https://progenetix.org/) is an open data resource that provides curated individual cancer copy number variation (CNV) profiles along with associated metadata sourced from published oncogenomic studies and various data repositories. This vignette provides a comprehensive guide on accessing and utilizing metadata for samples or their corresponding individuals within the Progenetix database.

If your focus lies in cancer cell lines, you can access data from [*cancercelllines.org*](https://cancercelllines.org/) by setting the `domain` parameter to `"cancercelllines.org"` in `pgxLoader` function. This data repository originates from CNV profiling data of cell lines initially collected as part of Progenetix and currently includes additional types of genomic mutations.

# 1 Load library

```
library(pgxRpi)
```

## 1.1 `pgxLoader` function

This function loads various data from `Progenetix` database via the Beacon v2 API with some extensions (BeaconPlus).

The parameters of this function used in this tutorial:

* `type`: A string specifying output data type. `"individuals"`, `"biosamples"`, `"analyses"`, `"filtering_terms"`, and `"counts"` are used in this tutorial.
* `filters`: Identifiers used in public repositories, bio-ontology terms, or custom terms such as `c("NCIT:C7376", "pgx:icdom-85003")`. When multiple filters are used, they are combined using AND logic when the parameter `type` is `"individuals"`, `"biosamples"`, or `"analyses"`; OR logic when the parameter `type` is `"counts"`.
* `individual_id`: Identifiers used in the query database for identifying individuals.
* `biosample_id`: Identifiers used in the query database for identifying biosamples.
* `codematches`: A logical value determining whether to exclude samples from child concepts
  of specified filters in the ontology tree. If `TRUE`, only samples exactly matching the specified filters will be included.
  Do not use this parameter when `filters` include ontology-irrelevant filters such as pubmed or cohort identifiers. Default is `FALSE`.
* `filter_pattern`: Optional string pattern to match against the `label` field of available filters. Only used when the parameter type is `"filtering_terms"`. Default is `NULL`, which includes all filters.
* `limit`: Integer to specify the number of returned profiles. Default is `0` (return all).
* `skip`: Integer to specify the number of skipped profiles. E.g. if `skip = 2, limit=500`, the first 2\*500=1000 profiles are skipped and the next 500 profiles are returned. Default is `0` (no skip).
* `use_https`: A logical value indicating whether to use the HTTPS protocol. If `TRUE`, the domain will be prefixed with `"https://"`; otherwise, `"http://"` will be used. Default is `TRUE`.
* `dataset`: A string specifying the dataset to query from the Beacon response. Default is `NULL`, which includes results from all datasets.
* `domain`: A string specifying the domain of the query data resource. Default is `"progenetix.org"`.
* `entry_point`: A string specifying the entry point of the Beacon v2 API. Default is `"beacon"`, resulting in the endpoint being `"https://progenetix.org/beacon"`.
* `num_cores`: An integer specifying the number of cores to use for parallel processing during Beacon v2 phenotypic/meta-data queries from multiple domains. Default is `1`.

# 2 Retrieve biosamples information

## 2.1 Search by filters

Filters are a significant enhancement to the [Beacon](https://www.ga4gh.org/product/beacon-api/) query API, providing a mechanism for specifying rules to select records based on their field values. To learn more about how to utilize filters in Progenetix, please refer to the [documentation](https://docs.progenetix.org/common/beacon-api/#filters-filtering-terms).

The following example demonstrates how to access all available filters in Progenetix:

```
all_filters <- pgxLoader(type="filtering_terms")
head(all_filters)
#>                           id                      label         type scopes
#> 1 labelSeg-based calibration labelSeg-based calibration alphanumeric     NA
#> 2                NCIT:C28076    Disease Grade Qualifier ontologyTerm     NA
#> 3                NCIT:C18000           Histologic Grade ontologyTerm     NA
#> 4                NCIT:C14158                 High Grade ontologyTerm     NA
#> 5                NCIT:C14161                  Low Grade ontologyTerm     NA
#> 6                NCIT:C14167      Poorly Differentiated ontologyTerm     NA
```

If you’re interested in filters related to a specific disease or phenotype, you can use the `filter_pattern` argument to narrow down the list. For example, to search for filters related to retinoblastoma:

```
query_filter <- pgxLoader(type="filtering_terms",filter_pattern="retinoblastoma")
query_filter
#>                id                     label         type scopes
#> 1      NCIT:C7541            Retinoblastoma ontologyTerm     NA
#> 2      NCIT:C8713  Bilateral Retinoblastoma ontologyTerm     NA
#> 3      NCIT:C8714 Unilateral Retinoblastoma ontologyTerm     NA
#> 4 pgx:icdom-95103       Retinoblastoma, NOS ontologyTerm     NA
```

To retrieve biosamples associated with a specific disease, use appropriate filter terms. In this example, we use an [NCIt](https://ncit.nci.nih.gov) code corresponding to **retinoblastoma** (`NCIT:C7541`):

```
biosamples <- pgxLoader(type="biosamples", filters = "NCIT:C7541")
# data looks like this
biosamples[1:5,]
#>     biosample_id   individual_id biosample_status_id biosample_status_label
#> 1 pgxbs-kftvhaw0 pgxind-kftx37dw         EFO:0009656      neoplastic sample
#> 2 pgxbs-kftvh7z4 pgxind-kftx33qo         EFO:0009656      neoplastic sample
#> 3 pgxbs-kftvhax0 pgxind-kftx37f5         EFO:0009656      neoplastic sample
#> 4 pgxbs-kftvhavn pgxind-kftx37dg         EFO:0009656      neoplastic sample
#> 5 pgxbs-kftvh76u pgxind-kftx32rf         EFO:0009656      neoplastic sample
#>   sample_origin_type_id sample_origin_type_label histological_diagnosis_id
#> 1           OBI:0001479   specimen from organism                NCIT:C8713
#> 2           OBI:0001479   specimen from organism                NCIT:C7541
#> 3           OBI:0001479   specimen from organism                NCIT:C8714
#> 4           OBI:0001479   specimen from organism                NCIT:C8714
#> 5           OBI:0001479   specimen from organism                NCIT:C7541
#>   histological_diagnosis_label sampled_tissue_id sampled_tissue_label
#> 1     Bilateral Retinoblastoma    UBERON:0000966               retina
#> 2               Retinoblastoma    UBERON:0000966               retina
#> 3    Unilateral Retinoblastoma    UBERON:0000966               retina
#> 4    Unilateral Retinoblastoma    UBERON:0000966               retina
#> 5               Retinoblastoma    UBERON:0000966               retina
#>   pathological_stage_id pathological_stage_label tnm tumor_grade age_iso info
#> 1           NCIT:C92207            Stage Unknown  NA          NA    <NA>   NA
#> 2           NCIT:C92207            Stage Unknown  NA          NA  P2Y10M   NA
#> 3           NCIT:C92207            Stage Unknown  NA          NA    <NA>   NA
#> 4           NCIT:C92207            Stage Unknown  NA          NA    <NA>   NA
#> 5           NCIT:C92207            Stage Unknown  NA          NA   P0Y1M   NA
#>                         notes icdo_morphology_id icdo_morphology_label
#> 1  Retinoblastoma [bilateral]    pgx:icdom-95103   Retinoblastoma, NOS
#> 2              retinoblastoma    pgx:icdom-95103   Retinoblastoma, NOS
#> 3 retinoblastoma [unilateral]    pgx:icdom-95103   Retinoblastoma, NOS
#> 4 retinoblastoma [unilateral]    pgx:icdom-95103   Retinoblastoma, NOS
#> 5              retinoblastoma    pgx:icdom-95103   Retinoblastoma, NOS
#>   icdo_topography_id icdo_topography_label
#> 1    pgx:icdot-C69.2                Retina
#> 2    pgx:icdot-C69.2                Retina
#> 3    pgx:icdot-C69.2                Retina
#> 4    pgx:icdot-C69.2                Retina
#> 5    pgx:icdot-C69.2                Retina
#>                                                                external_references_description
#> 1              Chen D, Gallie BL et al. (2001): Minimal regions of chromosomal imbalance in...
#> 2                Lillington DM, Goff LK et al. (2002): High level amplification of N-MYC is...
#> 3              Chen D, Gallie BL et al. (2001): Minimal regions of chromosomal imbalance in...
#> 4              Chen D, Gallie BL et al. (2001): Minimal regions of chromosomal imbalance in...
#> 5 Lillington DM, Kingston JE et al. (2003): Comparative genomic hybridization of 49 primary...
#>   external_references_id              external_references_reference
#> 1        pubmed:11520568 https://europepmc.org/article/MED/11520568
#> 2        pubmed:12232763 https://europepmc.org/article/MED/12232763
#> 3        pubmed:11520568 https://europepmc.org/article/MED/11520568
#> 4        pubmed:11520568 https://europepmc.org/article/MED/11520568
#> 5        pubmed:12508240 https://europepmc.org/article/MED/12508240
#>   analysis_info                cohorts_id                     cohorts_label
#> 1            NA pgx:cohort-2021progenetix Version at Progenetix Update 2021
#> 2            NA pgx:cohort-2021progenetix Version at Progenetix Update 2021
#> 3            NA pgx:cohort-2021progenetix Version at Progenetix Update 2021
#> 4            NA pgx:cohort-2021progenetix Version at Progenetix Update 2021
#> 5            NA pgx:cohort-2021progenetix Version at Progenetix Update 2021
#>   geo_location_geometry_coordinates geo_location_geometry_type
#> 1                       -79.42,43.7                      Point
#> 2                       -0.13,51.51                      Point
#> 3                       -79.42,43.7                      Point
#> 4                       -79.42,43.7                      Point
#> 5                       -0.13,51.51                      Point
#>   geo_location_properties_iso3166alpha2 geo_location_properties_iso3166alpha3
#> 1                                    CA                                   CAN
#> 2                                    UK                                  <NA>
#> 3                                    CA                                   CAN
#> 4                                    CA                                   CAN
#> 5                                    UK                                  <NA>
#>   geo_location_properties_city geo_location_properties_continent
#> 1                      Toronto                     North America
#> 2                       London                            Europe
#> 3                      Toronto                     North America
#> 4                      Toronto                     North America
#> 5                       London                            Europe
#>   geo_location_properties_country geo_location_properties_geoprov_id
#> 1                          Canada                    toronto::canada
#> 2                  United Kingdom              london::unitedkingdom
#> 3                          Canada                    toronto::canada
#> 4                          Canada                    toronto::canada
#> 5                  United Kingdom              london::unitedkingdom
#>   geo_location_type                    updated geo_location pathological_stage
#> 1           Feature 2020-09-10 17:44:39.361000           NA                 NA
#> 2           Feature 2020-09-10 17:44:36.157000           NA                 NA
#> 3           Feature 2020-09-10 17:44:39.391000           NA                 NA
#> 4           Feature 2020-09-10 17:44:39.350000           NA                 NA
#> 5           Feature 2020-09-10 17:44:35.293000           NA                 NA
#>   external_references analysis_info_experiment_id analysis_info_platform_id
#> 1                  NA                        <NA>                      <NA>
#> 2                  NA                        <NA>                      <NA>
#> 3                  NA                        <NA>                      <NA>
#> 4                  NA                        <NA>                      <NA>
#> 5                  NA                        <NA>                      <NA>
#>   analysis_info_series_id
#> 1                    <NA>
#> 2                    <NA>
#> 3                    <NA>
#> 4                    <NA>
#> 5                    <NA>
```

The data contains many columns representing different aspects of sample information.

## 2.2 Search by biosample id and individual id

In the Beacon v2 specification, biosample id and individual id are unique identifiers for biosamples and their corresponding individuals, respectively. These identifiers can be obtained through metadata searches using filters as described above or by querying the [Progenetix search interface](https://progenetix.org/search), which provides access to the IDs used in the Progenetix database.

```
biosamples_2 <- pgxLoader(type="biosamples", biosample_id = "pgxbs-kftvki7h",individual_id = "pgxind-kftx6ltu")

biosamples_2
#>     biosample_id   individual_id biosample_status_id biosample_status_label
#> 1 pgxbs-kftvki7h pgxind-kftx6ltd         EFO:0009656      neoplastic sample
#> 2 pgxbs-kftvki7v pgxind-kftx6ltu         EFO:0009656      neoplastic sample
#>   sample_origin_type_id sample_origin_type_label histological_diagnosis_id
#> 1           OBI:0001479   specimen from organism                NCIT:C3512
#> 2           OBI:0001479   specimen from organism                NCIT:C3512
#>   histological_diagnosis_label sampled_tissue_id sampled_tissue_label
#> 1          Lung Adenocarcinoma    UBERON:0002048                 lung
#> 2          Lung Adenocarcinoma    UBERON:0002048                 lung
#>   pathological_stage_id pathological_stage_label
#> 1           NCIT:C27976                 Stage Ib
#> 2           NCIT:C27977               Stage IIIa
#>                                tnm_id
#> 1 NCIT:C48706,NCIT:C48714,NCIT:C48724
#> 2 NCIT:C48706,NCIT:C48714,NCIT:C48728
#>                                            tnm_label tumor_grade age_iso info
#> 1 N1 Stage Finding,N3 Stage Finding,T2 Stage Finding          NA    P56Y   NA
#> 2 N1 Stage Finding,N3 Stage Finding,T3 Stage Finding          NA    P75Y   NA
#>                   notes icdo_morphology_id icdo_morphology_label
#> 1 adenocarcinoma [lung]    pgx:icdom-81403   Adenocarcinoma, NOS
#> 2 adenocarcinoma [lung]    pgx:icdom-81403   Adenocarcinoma, NOS
#>   icdo_topography_id icdo_topography_label
#> 1    pgx:icdot-C34.9             Lung, NOS
#> 2    pgx:icdot-C34.9             Lung, NOS
#>                                                     external_references_description
#> 1 Kang JU, Koo SH et al. (2009): Identification of novel candidate target genes,...
#> 2 Kang JU, Koo SH et al. (2009): Identification of novel candidate target genes,...
#>   external_references_id              external_references_reference
#> 1        pubmed:19607727 https://europepmc.org/article/MED/19607727
#> 2        pubmed:19607727 https://europepmc.org/article/MED/19607727
#>   analysis_info_experiment_id analysis_info_platform_id analysis_info_series_id
#> 1               geo:GSM417055               geo:GPL8690            geo:GSE16597
#> 2               geo:GSM417063               geo:GPL8690            geo:GSE16597
#>                                                                              cohorts_id
#> 1 pgx:cohort-arraymap,pgx:cohort-2021progenetix,pgx:cohort-carriocordo2021heterogeneity
#> 2                                         pgx:cohort-arraymap,pgx:cohort-2021progenetix
#>                                                                                                                  cohorts_label
#> 1 arrayMap collection,Version at Progenetix Update 2021,Carrio-Cordo and Baudis - Genomic Heterogeneity in Cancer Types (2021)
#> 2                                                                        arrayMap collection,Version at Progenetix Update 2021
#>   geo_location_geometry_coordinates geo_location_geometry_type
#> 1                      -74.01,40.71                      Point
#> 2                      -74.01,40.71                      Point
#>   geo_location_properties_iso3166alpha2 geo_location_properties_iso3166alpha3
#> 1                                    US                                   USA
#> 2                                    US                                   USA
#>   geo_location_properties_city geo_location_properties_continent
#> 1                New York City                     North America
#> 2                New York City                     North America
#>   geo_location_properties_country geo_location_properties_geoprov_id
#> 1        United States of America          newyorkcity::unitedstates
#> 2        United States of America          newyorkcity::unitedstates
#>   geo_location_type                    updated
#> 1           Feature 2020-09-10 17:46:45.105000
#> 2           Feature 2020-09-10 17:46:45.115000
```

It’s also possible to query by a combination of filters, biosample id, and individual id.

## 2.3 Access a subset of samples

By default, it returns all related samples (limit=0). You can access a subset of them
via the parameter `limit` and `skip`. For example, if you want to access the first 10 samples
, you can set `limit` = 10, `skip` = 0.

```
biosamples_3 <- pgxLoader(type="biosamples", filters = "NCIT:C7541",skip=0, limit = 10)
# Dimension: Number of samples * features
print(dim(biosamples))
#> [1] 336  43
print(dim(biosamples_3))
#> [1] 10 43
```

## 2.4 Parameter `codematches` use

Some filters, such as NCIt codes, are hierarchical. As a result, retrieved samples may
include not only the specified filters but also their child terms.

```
unique(biosamples$histological_diagnosis_id)
#> [1] "NCIT:C8713" "NCIT:C7541" "NCIT:C8714"
```

Setting `codematches` as TRUE allows this function to only return biosamples that exactly match the specified filter, excluding child terms.

```
biosamples_4 <- pgxLoader(type="biosamples", filters = "NCIT:C7541",codematches = TRUE)
unique(biosamples_4$histological_diagnosis_id)
#> [1] "NCIT:C7541"
```

# 3 Retrieve individuals information

If you want to query details of individuals (e.g. clinical data) where the samples
of interest come from, set the parameter `type` to “individuals” and follow the same steps as above.

```
individuals <- pgxLoader(type="individuals",individual_id = "pgxind-kftx26ml",filters="NCIT:C7541")
# data looks like this
tail(individuals,2)
#>       individual_id      sex_id sex_label age_iso histological_diagnosis_id
#> 328 pgxind-kftx32rc NCIT:C17998   unknown   P0Y5M                NCIT:C7541
#> 329 pgxind-kftx26ml NCIT:C20197      male    <NA>                NCIT:C3493
#>     histological_diagnosis_label followup_time followup_state_id
#> 328               Retinoblastoma          P97M       EFO:0030049
#> 329 Lung Squamous Cell Carcinoma          <NA>       EFO:0030039
#>        followup_state_label diseases_notes                  info
#> 328 dead (follow-up status)           <NA> PGX_IND_RetBl-lil-021
#> 329      no followup status           <NA> PGX_IND_AdSqLu-bjo-01
#>                        updated info_legacy_ids info_provenance
#> 328 2018-09-26 09:51:32.561000            <NA>            <NA>
#> 329 2025-07-11T16:57:08.312131            <NA>            <NA>
```

# 4 Retrieve analyses information

If you want to know more details about data analyses, set the parameter `type` to “analyses”.
The other steps are the same, except the parameter `codematches` is not available because
analyses data do not include filter information, even though it can be searched by filters.

```
analyses <- pgxLoader(type="analyses",biosample_id = c("pgxbs-kftvik5i","pgxbs-kftvik96"))

analyses
#>      analysis_id   biosample_id   individual_id calling_pipeline analysis_info
#> 1 pgxcs-kftw8qme pgxbs-kftvik5i pgxind-kftx4963       progenetix            NA
#> 2 pgxcs-kftw8rrh pgxbs-kftvik96 pgxind-kftx49ao       progenetix            NA
#>   platform_id                            platform_label
#> 1 geo:GPL2826             VUMC MACF human 30K oligo v31
#> 2 geo:GPL3960 MPIMG Homo sapiens 44K aCGH3_MPIMG_BERLIN
#>                      updated
#> 1 2025-07-13T18:28:42.839469
#> 2 2025-07-13T18:28:43.540286
```

# 5 Retrieve the number of results for a specific filter

To retrieve the number of results for a specific filter in Progenetix, set the `type` parameter to `"counts"`. You can query different Beacon v2 resources by setting the `domain` and `entry_point` parameters accordingly.

```
pgxLoader(type="counts",filters = "NCIT:C7541")
#>       filter      entity count
#> 1 NCIT:C7541 individuals   328
#> 2 NCIT:C7541  biosamples   336
#> 3 NCIT:C7541    analyses   356
```

# 6 Query from multiple data resources

You can query data from multiple resources via the Beacon v2 API by setting the `domain` and `entry_point` parameters accordingly. To speed up the process, use the `num_cores` parameter to enable parallel processing across different domains. For resources that only support `http` (e.g., local or internal network instances), set `use_https = FALSE` to avoid connection issues.

```
record_counts <- pgxLoader(type="counts",filters = "NCIT:C9245",domain=c("progenetix.org","cancercelllines.org"), entry_point=c("beacon","beacon"))

record_counts
#> $progenetix.org
#>       filter      entity count
#> 1 NCIT:C9245 individuals  8267
#> 2 NCIT:C9245  biosamples  9862
#> 3 NCIT:C9245    analyses 12001
#>
#> $cancercelllines.org
#>       filter      entity count
#> 1 NCIT:C9245 individuals    42
#> 2 NCIT:C9245  biosamples  1005
#> 3 NCIT:C9245    analyses   929
```

# 7 Visualization of survival data

Suppose you want to investigate whether there are survival differences associated with a particular disease, for example, between younger and older patients, or based on other variables. You can query and visualize the relevant information using the `pgxMetaplot` function.

## 7.1 `pgxMetaplot` function

This function generates a survival plot using metadata of individuals obtained by the `pgxLoader` function.

The parameters of this function:

* `data`: The data frame returned by the `pgxLoader` function, containing survival data for individuals. The survival state is represented by Experimental Factor Ontology in the “followup\_state\_id” column, and the survival time is represented in ISO 8601 duration format in the “followup\_time” column.
* `group_id`: A string specifying which column is used for grouping in the Kaplan-Meier plot.
* `condition`: A string for splitting individuals into younger and older groups, following the ISO 8601 duration format. Only used if `group_id` is “age\_iso”.
* `return_data`: A logical value determining whether to return the metadata used for plotting. Default is FALSE.
* `...`: Other parameters relevant to KM plot. These include `pval`, `pval.coord`, `pval.method`, `conf.int`, `linetype`, and `palette` (see ggsurvplot function from survminer package)

### 7.1.1 Example usage

```
# query metadata of individuals with lung adenocarcinoma
luad_inds <- pgxLoader(type="individuals",filters="NCIT:C3512")
# use 70 years old as the splitting condition
pgxMetaplot(data=luad_inds, group_id="age_iso", condition="P70Y", pval=TRUE)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the ggpubr package.
#>   Please report the issue at <https://github.com/kassambara/ggpubr/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

It’s noted that not all individuals have available survival data. If you set `return_data` to TRUE,
the function will return the metadata of individuals used for the plot.

# 8 Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] future_1.67.0    pgxRpi_1.6.0     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] ggplot2_4.0.0       rstatix_0.7.3       lattice_0.22-7
#>  [7] vctrs_0.6.5         tools_4.5.1         generics_0.1.4
#> [10] curl_7.0.0          parallel_4.5.1      tibble_3.3.0
#> [13] pkgconfig_2.0.3     Matrix_1.7-4        data.table_1.17.8
#> [16] RColorBrewer_1.1-3  S7_0.2.0            lifecycle_1.0.4
#> [19] compiler_4.5.1      farver_2.1.2        tinytex_0.57
#> [22] codetools_0.2-20    carData_3.0-5       htmltools_0.5.8.1
#> [25] sass_0.4.10         yaml_2.3.10         Formula_1.2-5
#> [28] crayon_1.5.3        pillar_1.11.1       car_3.1-3
#> [31] ggpubr_0.6.2        jquerylib_0.1.4     tidyr_1.3.1
#> [34] cachem_1.1.0        survminer_0.5.1     magick_2.9.0
#> [37] abind_1.4-8         km.ci_0.5-6         parallelly_1.45.1
#> [40] tidyselect_1.2.1    digest_0.6.37       dplyr_1.1.4
#> [43] purrr_1.1.0         bookdown_0.45       listenv_0.9.1
#> [46] labeling_0.4.3      splines_4.5.1       fastmap_1.2.0
#> [49] grid_4.5.1          cli_3.6.5           magrittr_2.0.4
#> [52] dichromat_2.0-0.1   survival_3.8-3      broom_1.0.10
#> [55] future.apply_1.20.0 withr_3.0.2         scales_1.4.0
#> [58] backports_1.5.0     lubridate_1.9.4     timechange_0.3.0
#> [61] rmarkdown_2.30      httr_1.4.7          globals_0.18.0
#> [64] gridExtra_2.3       ggsignif_0.6.4      zoo_1.8-14
#> [67] evaluate_1.0.5      knitr_1.50          KMsurv_0.1-6
#> [70] survMisc_0.5.6      rlang_1.1.6         Rcpp_1.1.0
#> [73] xtable_1.8-4        glue_1.8.0          BiocManager_1.30.26
#> [76] attempt_0.3.1       jsonlite_2.0.0      R6_2.6.1
```