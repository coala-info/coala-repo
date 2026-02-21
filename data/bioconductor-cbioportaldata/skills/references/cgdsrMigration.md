Code

* Show All Code
* Hide All Code

# cgdsr to cBioPortalData: Migration Tutorial

Karim Mezhoud & Marcel Ramos

#### November 09, 2025

# Contents

* [Introduction](#introduction)
* [Loading the package](#loading-the-package)
* [Discovering studies](#discovering-studies)
  + [`cBioPortalData` setup](#cbioportaldata-setup)
  + [`cgdsr` setup](#cgdsr-setup)
* [Obtaining Cases](#obtaining-cases)
  + [`cBioPortalData` (Cases)](#cbioportaldata-cases)
    - [Notes](#notes)
    - [sampleLists](#samplelists)
    - [samples from sampleLists](#samples-from-samplelists)
    - [getSampleInfo](#getsampleinfo)
  + [`cgdsr` (Cases)](#cgdsr-cases)
    - [Notes](#notes-1)
    - [`getCaseLists` and `getClinicalData`](#getcaselists-and-getclinicaldata)
* [Obtaining Clinical Data](#obtaining-clinical-data)
  + [`cBioPortalData` (Clinical)](#cbioportaldata-clinical)
    - [All clinical data](#all-clinical-data)
    - [By sample data](#by-sample-data)
  + [`cgdsr` (Clinical)](#cgdsr-clinical)
    - [Notes](#notes-2)
    - [getClinicalData](#getclinicaldata)
* [Clinical Data Summary](#clinical-data-summary)
* [Molecular or Genetic Profiles](#molecular-or-genetic-profiles)
  + [`cBioPortalData` (molecularProfiles)](#cbioportaldata-molecularprofiles)
  + [`cgdsr` (getGeneticProfiles)](#cgdsr-getgeneticprofiles)
* [Genomic Profile Data for a set of genes](#genomic-profile-data-for-a-set-of-genes)
  + [`cBioPortalData` (Indentify samples and genes)](#cbioportaldata-indentify-samples-and-genes)
    - [Convert `hugoGeneSymbol` to `entrezGeneId`](#convert-hugogenesymbol-to-entrezgeneid)
    - [Obtain all samples in study](#obtain-all-samples-in-study)
  + [`cgdsr` (Profile Data)](#cgdsr-profile-data)
* [Molecular Data with `cBioPortalData`](#molecular-data-with-cbioportaldata)
  + [`molecularData`](#moleculardata)
  + [`getDataByGenes`](#getdatabygenes)
  + [`cBioPortalData`: the main end-user function](#cbioportaldata-the-main-end-user-function)
* [Mutation Data](#mutation-data)
  + [`cBioPortalData` (mutationData)](#cbioportaldata-mutationdata)
  + [`cgdsr` (getMutationData)](#cgdsr-getmutationdata)
* [Copy Number Alteration (CNA)](#copy-number-alteration-cna)
  + [`cBioPortalData` (CNA)](#cbioportaldata-cna)
  + [`cgdsr` (CNA)](#cgdsr-cna)
* [Methylation Data](#methylation-data)
  + [`cBioPortalData` (Methylation)](#cbioportaldata-methylation)
  + [`cgdsr` (Methylation)](#cgdsr-methylation)
* [sessionInfo](#sessioninfo)

# Introduction

This vignette aims to help developers migrate from the now defunct `cgdsr`
CRAN package. Note that the `cgdsr` package code is shown for comparison but it
is not guaranteed to work. If you have questions regarding the contents,
please create an issue at the GitHub repository:
<https://github.com/waldronlab/cBioPortalData/issues>

# Loading the package

```
library(cBioPortalData)
```

# Discovering studies

## `cBioPortalData` setup

Here we show the default inputs to the cBioPortal function for clarity.

```
cbio <- cBioPortal(
    hostname = "www.cbioportal.org",
    protocol = "https",
    api. = "/api/v2/api-docs"
)
getStudies(cbio)
```

```
FALSE # A tibble: 508 × 13
FALSE    name          description publicStudy pmid  citation groups status importDate
FALSE    <chr>         <chr>       <lgl>       <chr> <chr>    <chr>   <int> <chr>
FALSE  1 Ewing Sarcom… "Whole-gen… TRUE        2522… Tirode … "PUBL…      0 2025-06-0…
FALSE  2 Kidney Renal… "Whole-exo… TRUE        2379… TCGA, N… "PUBL…      0 2024-12-2…
FALSE  3 Diffuse Larg… "Whole-exo… TRUE        2971… Chapuy … "PUBL…      0 2025-06-0…
FALSE  4 Kidney Renal… "TCGA Kidn… TRUE        <NA>  <NA>     "PUBL…      0 2024-12-1…
FALSE  5 Adenoid Cyst… "Targeted … TRUE        2441… Ross et… "ACYC…      0 2024-12-0…
FALSE  6 Lung Cancer … "Whole-gen… TRUE        3449… Zhang e… ""          0 2025-06-0…
FALSE  7 Pancreatic N… "Whole-gen… TRUE        2819… Scarpa … "PUBL…      0 2025-06-1…
FALSE  8 Pan-cancer A… "Whole exo… TRUE        <NA>  <NA>     ""          0 2025-11-0…
FALSE  9 Upper Tract … "Whole-exo… TRUE        3339… Xiaopin… "PUBL…      0 2025-06-2…
FALSE 10 Cutaneous Sq… "Catalogue… TRUE        3427… Chang e… ""          0 2024-12-2…
FALSE # ℹ 498 more rows
FALSE # ℹ 5 more variables: allSampleCount <int>, readPermission <lgl>,
FALSE #   studyId <chr>, cancerTypeId <chr>, referenceGenome <chr>
```

Note that the `studyId` column is important for further queries.

```
head(getStudies(cbio)[["studyId"]])
```

```
## [1] "es_iocurie_2014" "kirc_tcga_pub"   "dlbcl_dfci_2018" "kirp_tcga"
## [5] "acyc_fmi_2014"   "lung_nci_2022"
```

## `cgdsr` setup

```
library(cgdsr)
cgds <- CGDS("http://www.cbioportal.org/")
getCancerStudies.CGDS(cgds)
```

# Obtaining Cases

## `cBioPortalData` (Cases)

### Notes

* Each patient is identified by a `patientId`.
* `sampleListId` identifies groups of `patientId` based on profile type
* The `sampleLists` function uses `studyId` input to return `sampleListId`

### sampleLists

For the sample list identifiers, you can use `sampleLists` and inspect the
`sampleListId` column.

```
samps <- sampleLists(cbio, "gbm_tcga_pub")
samps[, c("category", "name", "sampleListId")]
```

```
## # A tibble: 15 × 3
##    category                             name                        sampleListId
##    <chr>                                <chr>                       <chr>
##  1 all_cases_in_study                   All samples                 gbm_tcga_pu…
##  2 other                                Expression Cluster Classic… gbm_tcga_pu…
##  3 all_cases_with_cna_data              Samples with CNA data       gbm_tcga_pu…
##  4 all_cases_with_mutation_and_cna_data Samples with mutation and … gbm_tcga_pu…
##  5 all_cases_with_mrna_array_data       Samples with mRNA data (Ag… gbm_tcga_pu…
##  6 other                                Expression Cluster Mesench… gbm_tcga_pu…
##  7 all_cases_with_methylation_data      Samples with methylation d… gbm_tcga_pu…
##  8 all_cases_with_methylation_data      Samples with methylation d… gbm_tcga_pu…
##  9 all_cases_with_microrna_data         Samples with microRNA data… gbm_tcga_pu…
## 10 other                                Expression Cluster Neural   gbm_tcga_pu…
## 11 other                                Expression Cluster Proneur… gbm_tcga_pu…
## 12 other                                Sequenced, No Hypermutators gbm_tcga_pu…
## 13 other                                Sequenced, Not Treated      gbm_tcga_pu…
## 14 other                                Sequenced, Treated          gbm_tcga_pu…
## 15 all_cases_with_mutation_data         Samples with mutation data  gbm_tcga_pu…
```

### samples from sampleLists

It is possible to get `case_ids` directly when using the `samplesInSampleLists`
function. The function handles multiple `sampleList` identifiers.

```
samplesInSampleLists(
    api = cbio,
    sampleListIds = c(
        "gbm_tcga_pub_expr_classical", "gbm_tcga_pub_expr_mesenchymal"
    )
)
```

```
## CharacterList of length 2
## [["gbm_tcga_pub_expr_classical"]] TCGA-02-0001-01 ... TCGA-12-0615-01
## [["gbm_tcga_pub_expr_mesenchymal"]] TCGA-02-0004-01 ... TCGA-12-0620-01
```

### getSampleInfo

To get more information about patients, we can query with `getSampleInfo`
function.

```
getSampleInfo(api = cbio,  studyId = "gbm_tcga_pub", projection = "SUMMARY")
```

```
## # A tibble: 206 × 6
##    uniqueSampleKey        uniquePatientKey sampleType sampleId patientId studyId
##    <chr>                  <chr>            <chr>      <chr>    <chr>     <chr>
##  1 VENHQS0wMi0wMDAxLTAxO… VENHQS0wMi0wMDA… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  2 VENHQS0wMi0wMDAzLTAxO… VENHQS0wMi0wMDA… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  3 VENHQS0wMi0wMDA0LTAxO… VENHQS0wMi0wMDA… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  4 VENHQS0wMi0wMDA2LTAxO… VENHQS0wMi0wMDA… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  5 VENHQS0wMi0wMDA3LTAxO… VENHQS0wMi0wMDA… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  6 VENHQS0wMi0wMDA5LTAxO… VENHQS0wMi0wMDA… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  7 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  8 VENHQS0wMi0wMDExLTAxO… VENHQS0wMi0wMDE… Primary S… TCGA-02… TCGA-02-… gbm_tc…
##  9 VENHQS0wMi0wMDE0LTAxO… VENHQS0wMi0wMDE… Primary S… TCGA-02… TCGA-02-… gbm_tc…
## 10 VENHQS0wMi0wMDE1LTAxO… VENHQS0wMi0wMDE… Primary S… TCGA-02… TCGA-02-… gbm_tc…
## # ℹ 196 more rows
```

## `cgdsr` (Cases)

### Notes

* ‘Cases’ and ‘Patients’ are synonymous.
* Each patient is identified by a `case_id`.
* Queries only handle a single `cancerStudy` identifier
* The `case_list_description` describes the assays

### `getCaseLists` and `getClinicalData`

We obtain the first `case_list_id` in the `cgds` object from above and the
corresponding clinical data for that case list (`gbm_tcga_pub_all` as the case
list in this example).

```
clist1 <-
    getCaseLists.CGDS(cgds, cancerStudy = "gbm_tcga_pub")[1, "case_list_id"]

getClinicalData.CGDS(cgds, clist1)
```

# Obtaining Clinical Data

## `cBioPortalData` (Clinical)

### All clinical data

Note that a `sampleListId` is not required when using the
`fetchAllClinicalDataInStudyUsingPOST` internal endpoint. Data for all
patients can be obtained using the `clinicalData` function.

```
clinicalData(cbio, "gbm_tcga_pub")
```

```
## # A tibble: 206 × 24
##    patientId    DFS_MONTHS DFS_STATUS KARNOFSKY_PERFORMANC…¹ OS_MONTHS OS_STATUS
##    <chr>        <chr>      <chr>      <chr>                  <chr>     <chr>
##  1 TCGA-02-0001 4.5041095… 1:Recurred 80.0                   11.60547… 1:DECEAS…
##  2 TCGA-02-0003 1.3150684… 1:Recurred 100.0                  4.734246… 1:DECEAS…
##  3 TCGA-02-0004 10.323287… 1:Recurred 80.0                   11.34246… 1:DECEAS…
##  4 TCGA-02-0006 9.9287671… 1:Recurred 80.0                   18.34520… 1:DECEAS…
##  5 TCGA-02-0007 17.030136… 1:Recurred 80.0                   23.17808… 1:DECEAS…
##  6 TCGA-02-0009 8.6794520… 1:Recurred 80.0                   10.58630… 1:DECEAS…
##  7 TCGA-02-0010 11.539726… 1:Recurred 80.0                   35.40821… 1:DECEAS…
##  8 TCGA-02-0011 4.7342465… 1:Recurred 80.0                   20.71232… 1:DECEAS…
##  9 TCGA-02-0014 <NA>       <NA>       100.0                  82.55342… 1:DECEAS…
## 10 TCGA-02-0015 14.991780… 1:Recurred 80.0                   20.61369… 1:DECEAS…
## # ℹ 196 more rows
## # ℹ abbreviated name: ¹​KARNOFSKY_PERFORMANCE_SCORE
## # ℹ 18 more variables: PRETREATMENT_HISTORY <chr>, PRIOR_GLIOMA <chr>,
## #   SAMPLE_COUNT <chr>, SEX <chr>, sampleId <chr>, ACGH_DATA <chr>,
## #   CANCER_TYPE <chr>, CANCER_TYPE_DETAILED <chr>, COMPLETE_DATA <chr>,
## #   FRACTION_GENOME_ALTERED <chr>, MRNA_DATA <chr>, MUTATION_COUNT <chr>,
## #   ONCOTREE_CODE <chr>, SAMPLE_TYPE <chr>, SEQUENCED <chr>, …
```

### By sample data

You can use a different endpoint to obtain data for a single sample.
First, obtain a single `sampleId` with the `samplesInSampleLists` function.

```
clist1 <- "gbm_tcga_pub_all"
samplist <- samplesInSampleLists(cbio, clist1)
onesample <- samplist[["gbm_tcga_pub_all"]][1]
onesample
```

```
## [1] "TCGA-02-0001-01"
```

Then we use the API endpoint to retrieve the data. Note that you would run
`httr::content` on the output to extract the data.

```
cbio$getAllClinicalDataOfSampleInStudyUsingGET(
    sampleId = onesample, studyId = "gbm_tcga_pub"
)
```

```
## Response [https://www.cbioportal.org/api/studies/gbm_tcga_pub/samples/TCGA-02-0001-01/clinical-data]
##   Date: 2025-11-09 21:45
##   Status: 200
##   Content-Type: application/json
##   Size: 3.31 kB
```

## `cgdsr` (Clinical)

### Notes

* `getClinicalData` uses `case_list_id` as input without specifying the
  `study_id` as case list identifiers are unique to each study.

### getClinicalData

We query clinical data for the `gbm_tcga_pub_expr_classical` case list
identifier which is part of the `gbm_tcga_pub` study.

```
getClinicalData.CGDS(x = cgds,
    caseList = "gbm_tcga_pub_expr_classical"
)
```

# Clinical Data Summary

`cgdsr` allows you to obtain clinical data for a case list subset
(54 cases with `gbm_tcga_pub_expr_classical`) and `cBioPortalData` provides
clinical data for all 206 samples in `gbm_tcga_pub` using the `clinicalData`
function.

* `cgdsr` returns a `data.frame` with `sampleId` (TCGA.02.0009.01) but not
  `patientId` (TCGA.02.0009)
* `cBioPortalData` returns `sampleId` (TCGA-02-0009-01) and `patientId`
  (TCGA-02-0009).
* Note the differences in identifier delimiters between the two packages,
  `cgdsr` provides `case_id`s with `.` and `cBioPortalData` returns `patientId`s
  with `-`.

You may be interested in other clinical data endpoints. For a list, use
the `searchOps` function.

```
searchOps(cbio, "clinical")
```

```
## [1] "getAllClinicalAttributesUsingGET"
## [2] "fetchClinicalAttributesUsingPOST"
## [3] "fetchClinicalDataUsingPOST"
## [4] "getAllClinicalAttributesInStudyUsingGET"
## [5] "getClinicalAttributeInStudyUsingGET"
## [6] "getAllClinicalDataInStudyUsingGET"
## [7] "fetchAllClinicalDataInStudyUsingPOST"
## [8] "getAllClinicalDataOfPatientInStudyUsingGET"
## [9] "getAllClinicalDataOfSampleInStudyUsingGET"
```

# Molecular or Genetic Profiles

## `cBioPortalData` (molecularProfiles)

```
molecularProfiles(api = cbio, studyId = "gbm_tcga_pub")
```

```
## # A tibble: 10 × 8
##    molecularAlterationType datatype   name    description showProfileInAnalysi…¹
##    <chr>                   <chr>      <chr>   <chr>       <lgl>
##  1 COPY_NUMBER_ALTERATION  DISCRETE   Putati… Putative c… TRUE
##  2 COPY_NUMBER_ALTERATION  DISCRETE   Putati… Putative c… TRUE
##  3 MUTATION_EXTENDED       MAF        Mutati… Mutation d… TRUE
##  4 METHYLATION             CONTINUOUS Methyl… Methylatio… FALSE
##  5 MRNA_EXPRESSION         CONTINUOUS mRNA e… mRNA expre… FALSE
##  6 MRNA_EXPRESSION         Z-SCORE    mRNA e… 18,698 gen… TRUE
##  7 MRNA_EXPRESSION         Z-SCORE    mRNA e… Log-transf… TRUE
##  8 MRNA_EXPRESSION         CONTINUOUS microR… expression… FALSE
##  9 MRNA_EXPRESSION         Z-SCORE    microR… microRNA e… FALSE
## 10 MRNA_EXPRESSION         Z-SCORE    mRNA/m… mRNA and m… TRUE
## # ℹ abbreviated name: ¹​showProfileInAnalysisTab
## # ℹ 3 more variables: patientLevel <lgl>, molecularProfileId <chr>,
## #   studyId <chr>
```

Note that we want to pull the `molecularProfileId` column to use in other
queries.

## `cgdsr` (getGeneticProfiles)

```
getGeneticProfiles.CGDS(cgds, cancerStudy = "gbm_tcga_pub")
```

# Genomic Profile Data for a set of genes

## `cBioPortalData` (Indentify samples and genes)

Currently, some conversion is needed to directly use the `molecularData`
function, if you only have Hugo symbols. First, convert to Entrez gene IDs
and then obtain all the samples in the sample list of interest.

### Convert `hugoGeneSymbol` to `entrezGeneId`

```
genetab <- queryGeneTable(cbio,
    by = "hugoGeneSymbol",
    genes = c("NF1", "TP53", "ABL1")
)
genetab
```

```
## # A tibble: 3 × 3
##   entrezGeneId hugoGeneSymbol type
##          <int> <chr>          <chr>
## 1         4763 NF1            protein-coding
## 2           25 ABL1           protein-coding
## 3         7157 TP53           protein-coding
```

```
entrez <- genetab[["entrezGeneId"]]
```

### Obtain all samples in study

```
allsamps <- samplesInSampleLists(cbio, "gbm_tcga_pub_all")
```

In the next section, we will show how to use the genes and sample identifiers
to obtain the molecular profile data.

## `cgdsr` (Profile Data)

The `getProfileData` function allows for straightforward retrieval of the
molecular profile data with only a case list and genetic profile identifiers.

```
getProfileData.CGDS(x = cgds,
    genes = c("NF1", "TP53", "ABL1"),
    geneticProfiles = "gbm_tcga_pub_mrna",
    caseList = "gbm_tcga_pub_all"
)
```

# Molecular Data with `cBioPortalData`

`cBioPortalData` provides a number of options for retrieving molecular profile
data depending on the use case. Note that `molecularData` is mostly used
internally and that the `cBioPortalData` function is the user-friendly method
for downloading such data.

## `molecularData`

We use the translated `entrez` identifiers from above.

```
molecularData(cbio, "gbm_tcga_pub_mrna",
    entrezGeneIds = entrez, sampleIds = unlist(allsamps))
```

```
## $gbm_tcga_pub_mrna
## # A tibble: 618 × 8
##    uniqueSampleKey     uniquePatientKey entrezGeneId molecularProfileId sampleId
##    <chr>               <chr>                   <int> <chr>              <chr>
##  1 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
##  2 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_mrna  TCGA-02…
##  3 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_mrna  TCGA-02…
##  4 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
##  5 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_mrna  TCGA-02…
##  6 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_mrna  TCGA-02…
##  7 VENHQS0wMi0wMDA0LT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
##  8 VENHQS0wMi0wMDA0LT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_mrna  TCGA-02…
##  9 VENHQS0wMi0wMDA0LT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_mrna  TCGA-02…
## 10 VENHQS0wMi0wMDA2LT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
## # ℹ 608 more rows
## # ℹ 3 more variables: patientId <chr>, studyId <chr>, value <dbl>
```

## `getDataByGenes`

The `getDataByGenes` function automatically figures out all the sample
identifiers in the study and it allows Hugo and Entrez identifiers, as well
as `genePanelId` inputs.

```
getDataByGenes(
    api =  cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_mrna"
)
```

```
## $gbm_tcga_pub_mrna
## # A tibble: 618 × 10
##    uniqueSampleKey     uniquePatientKey entrezGeneId molecularProfileId sampleId
##    <chr>               <chr>                   <int> <chr>              <chr>
##  1 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
##  2 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_mrna  TCGA-02…
##  3 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_mrna  TCGA-02…
##  4 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
##  5 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_mrna  TCGA-02…
##  6 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_mrna  TCGA-02…
##  7 VENHQS0wMi0wMDA0LT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
##  8 VENHQS0wMi0wMDA0LT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_mrna  TCGA-02…
##  9 VENHQS0wMi0wMDA0LT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_mrna  TCGA-02…
## 10 VENHQS0wMi0wMDA2LT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_mrna  TCGA-02…
## # ℹ 608 more rows
## # ℹ 5 more variables: patientId <chr>, studyId <chr>, value <dbl>,
## #   hugoGeneSymbol <chr>, type <chr>
```

## `cBioPortalData`: the main end-user function

It is important to note that end users who wish to obtain the data as
easily as possible should use the main `cBioPortalData` function:

```
gbm_pub <- cBioPortalData(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"), by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_mrna"
)

assay(gbm_pub[["gbm_tcga_pub_mrna"]])[, 1:4]
```

```
##      TCGA-02-0001-01 TCGA-02-0003-01 TCGA-02-0004-01 TCGA-02-0006-01
## ABL1         -0.1745         -0.1771         -0.0878         -0.1734
## NF1          -0.2967         -0.0011         -0.2363         -0.1692
## TP53          0.6213          0.0064         -0.3051          0.3968
```

# Mutation Data

## `cBioPortalData` (mutationData)

Similar to `molecularData`, mutation data can be obtained with the
`mutationData` function or the `getDataByGenes` function.

```
mutationData(
    api = cbio,
    molecularProfileIds = "gbm_tcga_pub_mutations",
    entrezGeneIds = entrez,
    sampleIds = unlist(allsamps)
)
```

```
## $gbm_tcga_pub_mutations
## # A tibble: 57 × 23
##    uniqueSampleKey        uniquePatientKey molecularProfileId sampleId patientId
##    <chr>                  <chr>            <chr>              <chr>    <chr>
##  1 VENHQS0wMi0wMDAxLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  2 VENHQS0wMi0wMDAxLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  3 VENHQS0wMi0wMDAzLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  4 VENHQS0wMi0wMDAzLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  5 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  6 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  7 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  8 VENHQS0wMi0wMDExLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  9 VENHQS0wMi0wMDE0LTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
## 10 VENHQS0wMi0wMDI0LTAxO… VENHQS0wMi0wMDI… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
## # ℹ 47 more rows
## # ℹ 18 more variables: entrezGeneId <int>, studyId <chr>, center <chr>,
## #   mutationStatus <chr>, validationStatus <chr>, startPosition <int>,
## #   endPosition <int>, referenceAllele <chr>, proteinChange <chr>,
## #   mutationType <chr>, ncbiBuild <chr>, variantType <chr>, keyword <chr>,
## #   chr <chr>, variantAllele <chr>, refseqMrnaId <chr>, proteinPosStart <int>,
## #   proteinPosEnd <int>
```

```
getDataByGenes(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_mutations"
)
```

```
## $gbm_tcga_pub_mutations
## # A tibble: 57 × 25
##    uniqueSampleKey        uniquePatientKey molecularProfileId sampleId patientId
##    <chr>                  <chr>            <chr>              <chr>    <chr>
##  1 VENHQS0wMi0wMDAxLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  2 VENHQS0wMi0wMDAxLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  3 VENHQS0wMi0wMDAzLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  4 VENHQS0wMi0wMDAzLTAxO… VENHQS0wMi0wMDA… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  5 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  6 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  7 VENHQS0wMi0wMDEwLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  8 VENHQS0wMi0wMDExLTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
##  9 VENHQS0wMi0wMDE0LTAxO… VENHQS0wMi0wMDE… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
## 10 VENHQS0wMi0wMDI0LTAxO… VENHQS0wMi0wMDI… gbm_tcga_pub_muta… TCGA-02… TCGA-02-…
## # ℹ 47 more rows
## # ℹ 20 more variables: entrezGeneId <int>, studyId <chr>, center <chr>,
## #   mutationStatus <chr>, validationStatus <chr>, startPosition <int>,
## #   endPosition <int>, referenceAllele <chr>, proteinChange <chr>,
## #   mutationType <chr>, ncbiBuild <chr>, variantType <chr>, keyword <chr>,
## #   chr <chr>, variantAllele <chr>, refseqMrnaId <chr>, proteinPosStart <int>,
## #   proteinPosEnd <int>, hugoGeneSymbol <chr>, type <chr>
```

## `cgdsr` (getMutationData)

```
getMutationData.CGDS(
    x = cgds,
    caseList = "getMutationData",
    geneticProfile = "gbm_tcga_pub_mutations",
    genes = c("NF1", "TP53", "ABL1")
)
```

# Copy Number Alteration (CNA)

## `cBioPortalData` (CNA)

Copy Number Alteration data can be obtained with the `getDataByGenes` function
or by the main `cBioPortal` function.

```
getDataByGenes(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_cna_rae"
)
```

```
## $gbm_tcga_pub_cna_rae
## # A tibble: 6 × 10
##   uniqueSampleKey         uniquePatientKey molecularProfileId sampleId patientId
##   <chr>                   <chr>            <chr>              <chr>    <chr>
## 1 VENHQS0wNi0wMjEzLTAxOm… VENHQS0wNi0wMjE… gbm_tcga_pub_cna_… TCGA-06… TCGA-06-…
## 2 VENHQS0wNi0wNjQ2LTAxOm… VENHQS0wNi0wNjQ… gbm_tcga_pub_cna_… TCGA-06… TCGA-06-…
## 3 VENHQS0wMi0wMDU1LTAxOm… VENHQS0wMi0wMDU… gbm_tcga_pub_cna_… TCGA-02… TCGA-02-…
## 4 VENHQS0wMi0wMzI0LTAxOm… VENHQS0wMi0wMzI… gbm_tcga_pub_cna_… TCGA-02… TCGA-02-…
## 5 VENHQS0wNi0wMTY2LTAxOm… VENHQS0wNi0wMTY… gbm_tcga_pub_cna_… TCGA-06… TCGA-06-…
## 6 VENHQS0wNi0wMjA2LTAxOm… VENHQS0wNi0wMjA… gbm_tcga_pub_cna_… TCGA-06… TCGA-06-…
## # ℹ 5 more variables: entrezGeneId <int>, studyId <chr>, alteration <int>,
## #   hugoGeneSymbol <chr>, type <chr>
```

```
cBioPortalData(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_cna_rae"
)
```

```
## harmonizing input:
##   removing 200 colData rownames not in sampleMap 'primary'
```

```
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] gbm_tcga_pub_cna_rae: SummarizedExperiment with 2 rows and 6 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## `cgdsr` (CNA)

```
getProfileData.CGDS(
    x = cgds,
    genes = c("NF1", "TP53", "ABL1"),
    geneticProfiles = "gbm_tcga_pub_cna_rae",
    caseList = "gbm_tcga_pub_cna"
)
```

# Methylation Data

## `cBioPortalData` (Methylation)

Similar to Copy Number Alteration, Methylation can be obtained by
`getDataByGenes` function or by ‘cBioPortalData’ function.

```
getDataByGenes(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_methylation_hm27"
)
```

```
## $gbm_tcga_pub_methylation_hm27
## # A tibble: 174 × 10
##    uniqueSampleKey     uniquePatientKey entrezGeneId molecularProfileId sampleId
##    <chr>               <chr>                   <int> <chr>              <chr>
##  1 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_meth… TCGA-02…
##  2 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_meth… TCGA-02…
##  3 VENHQS0wMi0wMDAxLT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_meth… TCGA-02…
##  4 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_meth… TCGA-02…
##  5 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_meth… TCGA-02…
##  6 VENHQS0wMi0wMDAzLT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_meth… TCGA-02…
##  7 VENHQS0wMi0wMDA2LT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_meth… TCGA-02…
##  8 VENHQS0wMi0wMDA2LT… VENHQS0wMi0wMDA…         4763 gbm_tcga_pub_meth… TCGA-02…
##  9 VENHQS0wMi0wMDA2LT… VENHQS0wMi0wMDA…         7157 gbm_tcga_pub_meth… TCGA-02…
## 10 VENHQS0wMi0wMDA3LT… VENHQS0wMi0wMDA…           25 gbm_tcga_pub_meth… TCGA-02…
## # ℹ 164 more rows
## # ℹ 5 more variables: patientId <chr>, studyId <chr>, value <dbl>,
## #   hugoGeneSymbol <chr>, type <chr>
```

```
cBioPortalData(
    api = cbio,
    studyId = "gbm_tcga_pub",
    genes = c("NF1", "TP53", "ABL1"),
    by = "hugoGeneSymbol",
    molecularProfileIds = "gbm_tcga_pub_methylation_hm27"
)
```

```
## harmonizing input:
##   removing 148 colData rownames not in sampleMap 'primary'
```

```
## A MultiAssayExperiment object of 1 listed
##  experiment with a user-defined name and respective class.
##  Containing an ExperimentList class object of length 1:
##  [1] gbm_tcga_pub_methylation_hm27: SummarizedExperiment with 3 rows and 58 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## `cgdsr` (Methylation)

```
getProfileData.CGDS(
    x = cgds,
    genes = c("NF1", "TP53", "ABL1"),
    geneticProfiles = "gbm_tcga_pub_methylation_hm27",
    caseList = "gbm_tcga_pub_methylation_hm27"
)
```

# sessionInfo

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
##  [1] jsonlite_2.0.0              survminer_0.5.1
##  [3] ggpubr_0.6.2                ggplot2_4.0.0
##  [5] survival_3.8-3              cBioPortalData_2.22.1
##  [7] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           AnVIL_1.22.0
## [19] AnVILBase_1.4.0             dplyr_1.1.4
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] GCPtools_1.0.0            splines_4.5.1
##   [3] later_1.4.4               BiocIO_1.20.0
##   [5] bitops_1.0-9              filelock_1.0.3
##   [7] tibble_3.3.0              RaggedExperiment_1.34.0
##   [9] XML_3.99-0.20             lifecycle_1.0.4
##  [11] httr2_1.2.1               rstatix_0.7.3
##  [13] processx_3.8.6            lattice_0.22-7
##  [15] backports_1.5.0           magrittr_2.0.4
##  [17] sass_0.4.10               rmarkdown_2.30
##  [19] jquerylib_0.1.4           yaml_2.3.10
##  [21] httpuv_1.6.16             otel_0.2.0
##  [23] chromote_0.5.1            DBI_1.2.3
##  [25] RColorBrewer_1.1-3        abind_1.4-8
##  [27] rvest_1.0.5               purrr_1.2.0
##  [29] RCurl_1.98-1.17           rappdirs_0.3.3
##  [31] RTCGAToolbox_2.40.0       KMsurv_0.1-6
##  [33] commonmark_2.0.0          codetools_0.2-20
##  [35] DelayedArray_0.36.0       DT_0.34.0
##  [37] ggtext_0.1.2              xml2_1.4.1
##  [39] tidyselect_1.2.1          futile.logger_1.4.3
##  [41] UCSC.utils_1.6.0          farver_2.1.2
##  [43] BiocFileCache_3.0.0       GenomicAlignments_1.46.0
##  [45] Formula_1.2-5             tools_4.5.1
##  [47] Rcpp_1.1.0                glue_1.8.0
##  [49] GenomicDataCommons_1.34.1 gridExtra_2.3
##  [51] SparseArray_1.10.1        BiocBaseUtils_1.12.0
##  [53] xfun_0.54                 GenomeInfoDb_1.46.0
##  [55] websocket_1.4.4           withr_3.0.2
##  [57] formatR_1.14              BiocManager_1.30.26
##  [59] fastmap_1.2.0             litedown_0.8
##  [61] digest_0.6.37             R6_2.6.1
##  [63] mime_0.13                 dichromat_2.0-0.1
##  [65] markdown_2.0              RSQLite_2.4.3
##  [67] cigarillo_1.0.0           utf8_1.2.6
##  [69] tidyr_1.3.1               data.table_1.17.8
##  [71] rtracklayer_1.70.0        httr_1.4.7
##  [73] htmlwidgets_1.6.4         S4Arrays_1.10.0
##  [75] RJSONIO_2.0.0             pkgconfig_2.0.3
##  [77] gtable_0.3.6              blob_1.2.4
##  [79] S7_0.2.0                  XVector_0.50.0
##  [81] survMisc_0.5.6            htmltools_0.5.8.1
##  [83] carData_3.0-5             bookdown_0.45
##  [85] scales_1.4.0              rapiclient_0.1.8
##  [87] png_0.1-8                 knitr_1.50
##  [89] km.ci_0.5-6               lambda.r_1.2.4
##  [91] tzdb_0.5.0                rjson_0.2.23
##  [93] curl_7.0.0                cachem_1.1.0
##  [95] zoo_1.8-14                stringr_1.6.0
##  [97] parallel_4.5.1            miniUI_0.1.2
##  [99] AnnotationDbi_1.72.0      restfulr_0.0.16
## [101] pillar_1.11.1             grid_4.5.1
## [103] vctrs_0.6.5               promises_1.5.0
## [105] car_3.1-3                 dbplyr_2.5.1
## [107] xtable_1.8-4              evaluate_1.0.5
## [109] magick_2.9.0              readr_2.1.5
## [111] tinytex_0.57              GenomicFeatures_1.62.0
## [113] cli_3.6.5                 compiler_4.5.1
## [115] futile.options_1.0.1      Rsamtools_2.26.0
## [117] rlang_1.1.6               crayon_1.5.3
## [119] ggsignif_0.6.4            labeling_0.4.3
## [121] ps_1.9.1                  stringi_1.8.7
## [123] BiocParallel_1.44.0       Biostrings_2.78.0
## [125] Matrix_1.7-4              hms_1.1.4
## [127] bit64_4.6.0-1             KEGGREST_1.50.0
## [129] shiny_1.11.1              gridtext_0.1.5
## [131] broom_1.0.10              memoise_2.0.1
## [133] bslib_0.9.0               bit_4.6.0
## [135] TCGAutils_1.30.0
```