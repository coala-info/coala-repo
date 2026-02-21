# Using curatedAdipoArray

#### Mahmoud Ahmed

#### 2025-11-04

# curatedAdipoArray

A Curated Microarrays Dataset of MDI-induced Differentiated Adipocytes (3T3-L1) Under Genetic and Pharmacological Perturbations

# Overview

A curated dataset of Microarrays samples. The samples are MDI-induced pre- adipocytes (3T3-L1) at different time points/stage of differentiation under different types of genetic (knockdown/overexpression) and pharmacological (drug treatment) perturbations. The package documents the data collection and processing. In addition to the documentation, the package contains the scripts that was used to generated the data.

# Introduction

## What is `curatedAdipoArray`?

This package is for documenting and distributing a curated dataset of gene expression from MDI-induced 3T3-L1 adipocyte cell model under genetic and pharmacological modification.

## What is contained in `curatedAdipoArray`?

The package contains two things:

1. Scripts for documenting and reproducing the dataset in `inst/scripts`.
2. Access to the clean and the processed data `SummarizedExperiment` objects through `ExperimentHub`.

## What is `curatedAdipoArray` for?

The data contained in the package can be used in any number of downstream analysis such as differential expression and gene set enrichment.

# Installation

The `curatedAdipoArray` package can be installed from Bioconductor using `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("curatedAdipoArray")
```

# Docker image

The pre-processing and processing of the data setup environment is available as a `docker` image. This image is also suitable for reproducing this document. The `docker` image can be obtained using the `docker` CLI client.

```
$ docker pull bcmslab/adiporeg_array:latest
```

# Generating `curatedAdipoArray`

## Data collection and acquisition

We surveyed the literature for MDI-induced 3T3-L1 microarrays studies with or without course perturbations. 43 published studies were included. 47 datasets from these studies were examined for metadata and annotation completeness. One and two studies were excluded for missing probe intensities and probe annotations respectively. In addition to the data and the metadata, the original publications were also examined to extract the experimental design and other missing experimental details. The remaining datasets were curated, cleaned and packaged in two final datasets for each type of differentiation course perturbation.

## Data processing and quality assessment

The probe intensities, probe annotation and metadata of each study were obtained from the gene expression omnibus (GEO) using `GEOquery`. The probe intensities (expression matrices) were collapsed using probe to gene symbol annotation using `collapsRows`. The metadata for studies, data series and samples were homogenized across studies using common vocabularies to describe the experimental designs. Information for each sample of the differentiation status and time point were retrieved and recorded. In addition, the treatment type, target, dose and time were added for each sample. The processed datasets were packaged in `R`/``` Bioconductor``SummarizedExperiment ``` object individually.

For illustration purposes, the dataset objects were merged into two separate `SummarizedExperiment` for the genetic or the pharmacological perturbations. In each set, missing and low intensity genes were removed. Then the gene intensities were log transformed and normalized across studies using `limma`. Finally, the known batch effects (data series and platform) were removed using `sva`.

# Exploring the data objects

```
# loading required libraries
library(ExperimentHub)
library(SummarizedExperiment)
```

```
# query package resources on ExperimentHub
eh <- ExperimentHub()
query(eh, "curatedAdipoArray")
#> ExperimentHub with 45 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: GEO
#> # $species: Mus musculus
#> # $rdataclass: SummarizedExperiment
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH3245"]]'
#>
#>            title
#>   EH3245 | A Clean Expression Matrix of the GEOGSE102403 Dataset.
#>   EH3246 | A Clean Expression Matrix of the GEOGSE122054 Dataset.
#>   EH3247 | A Clean Expression Matrix of the GEOGSE12929 Dataset.
#>   EH3248 | A Clean Expression Matrix of the GEOGSE14004 Dataset.
#>   EH3249 | A Clean Expression Matrix of the GEOGSE1458 Dataset.
#>   ...      ...
#>   EH3285 | A Clean Expression Matrix of the GEOGSE97241 Dataset.
#>   EH3286 | A Curated Microarrays Dataset  of MDI-induced Differentiated Adi...
#>   EH3287 | A Curated Microarrays Dataset (processed) of MDI-induced Differe...
#>   EH3288 | A Curated Microarrays Dataset  of MDI-induced Differentiated Adi...
#>   EH3289 | A Curated Microarrays Dataset (processed) of MDI-induced Differe...
```

```
listResources(eh, "curatedAdipoArray")[43]
#> [1] "A Curated Microarrays Dataset (processed) of MDI-induced Differentiated Adipocytes (3T3-L1) Under genetic Perturbations"
```

```
genetic <- query(eh, 'curatedAdipoArray')[[43]]
```

Each of the objects attached to this package is an `SummarizedExperiment`. This object contains two main tables. The first is the expression matrix in the form of probe/gene intensities. The second table is the sample metadata.

```
# show class of the SummarizedExperiment
class(genetic)
#> [1] "RangedSummarizedExperiment"
#> attr(,"package")
#> [1] "SummarizedExperiment"

# show the first table
assay(genetic)[1:5, 1:5]
#>               GSM3453832 GSM3453833 GSM3453834 GSM3453835 GSM3453836
#> 0610010K14Rik   5.605891   5.914512   5.835002   5.761030   5.599307
#> 1110004F10Rik   5.362545   5.431240   5.339172   5.281284   5.454288
#> 1110032A03Rik   4.828588   4.852295   4.835784   4.749035   4.263849
#> 1110051M20Rik   3.872351   3.787890   4.268141   4.064035   4.400137
#> 1110059E24Rik   5.030677   4.814407   4.928870   4.911451   5.472552

# show the second table
colData(genetic)[1:5,]
#> DataFrame with 5 rows and 18 columns
#>              series_id   sample_id      pmid      time       media   treatment
#>            <character> <character> <numeric> <numeric> <character> <character>
#> GSM3453832   GSE122054  GSM3453832  31199203        48         MDI   knockdown
#> GSM3453833   GSE122054  GSM3453833  31199203        96         MDI   knockdown
#> GSM3453834   GSE122054  GSM3453834  31199203         0        none   knockdown
#> GSM3453835   GSE122054  GSM3453835  31199203       -48         MDI   knockdown
#> GSM3453836   GSE122054  GSM3453836  31199203        48         MDI        none
#>            treatment_target treatment_type treatment_subtype treatment_time
#>                 <character>    <character>       <character>      <numeric>
#> GSM3453832         slincRAD          shRNA                NA             -1
#> GSM3453833         slincRAD          shRNA                NA             -1
#> GSM3453834         slincRAD          shRNA                NA             -1
#> GSM3453835         slincRAD          shRNA                NA             -1
#> GSM3453836             none          shRNA                NA             -1
#>            treatment_duration treatment_dose treatment_dose_unit  channels
#>                     <numeric>    <character>         <character> <numeric>
#> GSM3453832                 NA             NA                  NA         1
#> GSM3453833                 NA             NA                  NA         1
#> GSM3453834                 NA             NA                  NA         1
#> GSM3453835                 NA             NA                  NA         1
#> GSM3453836                 NA             NA                  NA         1
#>                    gpl geo_missing symbol_missing perturbation_type
#>            <character>   <numeric>      <numeric>       <character>
#> GSM3453832    GPL11202           0              0           genetic
#> GSM3453833    GPL11202           0              0           genetic
#> GSM3453834    GPL11202           0              0           genetic
#> GSM3453835    GPL11202           0              0           genetic
#> GSM3453836    GPL11202           0              0           genetic
```

The samples metadata were manually curated using controlled vocabularies to make comparing and combining the data easier. Table 1. show the columns and the descriptions of the metadata table.

| col\_id | description |
| --- | --- |
| series\_id | The GEO series identifier. |
| sample\_id | The GEO sample identifier. |
| pmid | The pubmed identifier of the published study. |
| time | The time from the start of the differentiation protocol in hours. |
| media | The differentiation media MDI or none. |
| treatment | The treatment status: none, drug, knockdown or overexpression. |
| treatment\_target | The target of the treatment: gene name or a biological |
| pathway. |  |
| treatment\_type | The type of the treatment. |
| treatment\_subtype | The detailed subtype of the treatment. |
| treatment\_time | The time of the treatment in relation to differentiation time |
| : -1, before; 0, at; and 1 after the start of the differentiation induction. |  |
| treatment\_duration | The duration from the treatment to the collection of the |
| RNA from the sample. |  |
| treatment\_dose | The dose of the treatment. |
| treatment\_dose\_unit | The dose unit of the treatment. |
| channels | The number of the channels on the array chip: 1 or 2. |
| gpl | The GEO GPL/annotation identifier. |
| geo\_missing | The availability of the data on GEO: 0 or 1. |
| symbol\_missing | The availability of the gene symbol of the probes in the GPL |
| object. |  |
| perturbation\_type | The type of the perturbation: genetic or pharmacological. |

# Citing the studies in this subset of the data

The original articles where the datasets were first published are recorded by their pubmid ID. Please, cite the articles when using the related dataset.

# Citing `curatedAdipoArray`

To cite the package use:

```
# citing the package
citation("curatedAdipoArray")
```

# Related Packages

The packages [curatedAdipoRNA](https://github.com/MahShaaban/curatedAdipoRNA) and [curatedAdipoChIP](https://github.com/MahShaaban/curatedAdipoChIP) contain gene expression and DNA-binding of important factors in the same cell line model, respectively.

# Session Info

```
devtools::session_info()
```