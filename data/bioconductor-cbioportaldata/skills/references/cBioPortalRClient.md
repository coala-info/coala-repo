# cBioPortalData: API Reference Guide for Devs

Marcel Ramos & Levi Waldron

#### November 09, 2025

# Contents

* [Installation](#installation)
* [Introduction](#introduction)
* [Overview](#overview)
* [API representation](#api-representation)
  + [Operations](#operations)
    - [Searching through the API](#searching-through-the-api)
  + [Studies](#studies)
  + [Clinical Data](#clinical-data)
  + [Molecular Profiles](#molecular-profiles)
  + [Molecular Profile Data](#molecular-profile-data)
  + [Genes](#genes)
    - [All available genes](#all-available-genes)
    - [Gene Panels](#gene-panels)
  + [Molecular Gene Panels](#molecular-gene-panels)
    - [genePanelMolecular](#genepanelmolecular)
    - [getGenePanelMolecular](#getgenepanelmolecular)
    - [getDataByGenes](#getdatabygenes)
  + [Samples](#samples)
    - [Sample List Identifiers](#sample-list-identifiers)
    - [Sample Identifiers](#sample-identifiers)
    - [All samples within a study ID](#all-samples-within-a-study-id)
    - [Info on Samples](#info-on-samples)
* [Advanced Usage](#advanced-usage)
  + [Clearing the cache](#clearing-the-cache)
* [sessionInfo](#sessioninfo)

# Installation

Please use the devel version of the `AnVIL` Bioconductor package.

```
library(cBioPortalData)
library(AnVIL)
```

# Introduction

The cBioPortal for Cancer Genomics [website](https://cbioportal.org) is a great
resource for interactive exploration of study datasets. However, it does not
easily allow the analyst to obtain and further analyze the data.

We’ve developed the `cBioPortalData` package to fill this need to
programmatically access the data resources available on the cBioPortal.

The `cBioPortalData` package provides an R interface for accessing the
cBioPortal study data within the Bioconductor ecosystem.

It downloads study data from the cBioPortal API (<https://cbioportal.org/api>)
and uses Bioconductor infrastructure to cache and represent the data.

We use the [`MultiAssayExperiment`](https://dx.doi.org/10.1158/0008-5472.CAN-17-0344) (@Ramos2017-er) package to integrate,
represent, and coordinate multiple experiments for the studies availble in the
cBioPortal. This package in conjunction with `curatedTCGAData` give access to
a large trove of publicly available bioinformatic data. Please see our
publication [here](https://dx.doi.org/10.1200/CCI.19.00119) (@Ramos2020-ya).

We demonstrate common use cases of `cBioPortalData` and `curatedTCGAData`
during Bioconductor conference
[workshops](https://waldronlab.io/MultiAssayWorkshop/).

# Overview

This vignette is for users / developers who would like to learn more about
the available data in `cBioPortalData` and to learn how to hit other endpoints
in the cBioPortal API implementation. The functionality demonstrated
here is used internally by the package to create integrative representations
of study datasets.

Note. To avoid overloading the API service, the API was designed to only query
a part of the study data. Therefore, the user is required to enter either a set
of genes of interest or a gene panel identifier.

# API representation

Obtaining the cBioPortal API representation object

```
(cbio <- cBioPortal())
```

```
## service: cBioPortal
## host: www.cbioportal.org
## tags(); use cbioportal$<tab completion>:
## # A tibble: 65 × 3
##    tag                 operation                                  summary
##    <chr>               <chr>                                      <chr>
##  1 Cancer Types        getAllCancerTypesUsingGET                  Get all cance…
##  2 Cancer Types        getCancerTypeUsingGET                      Get a cancer …
##  3 Clinical Attributes fetchClinicalAttributesUsingPOST           Fetch clinica…
##  4 Clinical Attributes getAllClinicalAttributesInStudyUsingGET    Get all clini…
##  5 Clinical Attributes getAllClinicalAttributesUsingGET           Get all clini…
##  6 Clinical Attributes getClinicalAttributeInStudyUsingGET        Get specified…
##  7 Clinical Data       fetchAllClinicalDataInStudyUsingPOST       Fetch clinica…
##  8 Clinical Data       fetchClinicalDataUsingPOST                 Fetch clinica…
##  9 Clinical Data       getAllClinicalDataInStudyUsingGET          Get all clini…
## 10 Clinical Data       getAllClinicalDataOfPatientInStudyUsingGET Get all clini…
## # ℹ 55 more rows
## tag values:
##   Cancer Types, Clinical Attributes, Clinical Data, Copy Number
##   Segments, Discrete Copy Number Alterations, Gene Panel Data, Gene
##   Panels, Generic Assay Data, Generic Assays, Genes, Info, Molecular
##   Data, Molecular Profiles, Mutations, Patients, Sample Lists, Samples,
##   Server running status, Studies, Treatments
## schemas():
##   AlleleSpecificCopyNumber, AlterationFilter,
##   AndedPatientTreatmentFilters, AndedSampleTreatmentFilters,
##   CancerStudy
##   # ... with 62 more elements
```

## Operations

Check available tags, operations, and descriptions as a `tibble`:

```
tags(cbio)
```

```
## # A tibble: 65 × 3
##    tag                 operation                                  summary
##    <chr>               <chr>                                      <chr>
##  1 Cancer Types        getAllCancerTypesUsingGET                  Get all cance…
##  2 Cancer Types        getCancerTypeUsingGET                      Get a cancer …
##  3 Clinical Attributes fetchClinicalAttributesUsingPOST           Fetch clinica…
##  4 Clinical Attributes getAllClinicalAttributesInStudyUsingGET    Get all clini…
##  5 Clinical Attributes getAllClinicalAttributesUsingGET           Get all clini…
##  6 Clinical Attributes getClinicalAttributeInStudyUsingGET        Get specified…
##  7 Clinical Data       fetchAllClinicalDataInStudyUsingPOST       Fetch clinica…
##  8 Clinical Data       fetchClinicalDataUsingPOST                 Fetch clinica…
##  9 Clinical Data       getAllClinicalDataInStudyUsingGET          Get all clini…
## 10 Clinical Data       getAllClinicalDataOfPatientInStudyUsingGET Get all clini…
## # ℹ 55 more rows
```

```
head(tags(cbio)$operation)
```

```
## [1] "getAllCancerTypesUsingGET"
## [2] "getCancerTypeUsingGET"
## [3] "fetchClinicalAttributesUsingPOST"
## [4] "getAllClinicalAttributesInStudyUsingGET"
## [5] "getAllClinicalAttributesUsingGET"
## [6] "getClinicalAttributeInStudyUsingGET"
```

### Searching through the API

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

## Studies

Get the list of studies available:

```
getStudies(cbio)
```

```
## # A tibble: 508 × 13
##    name          description publicStudy pmid  citation groups status importDate
##    <chr>         <chr>       <lgl>       <chr> <chr>    <chr>   <int> <chr>
##  1 Ewing Sarcom… "Whole-gen… TRUE        2522… Tirode … "PUBL…      0 2025-06-0…
##  2 Kidney Renal… "Whole-exo… TRUE        2379… TCGA, N… "PUBL…      0 2024-12-2…
##  3 Diffuse Larg… "Whole-exo… TRUE        2971… Chapuy … "PUBL…      0 2025-06-0…
##  4 Kidney Renal… "TCGA Kidn… TRUE        <NA>  <NA>     "PUBL…      0 2024-12-1…
##  5 Adenoid Cyst… "Targeted … TRUE        2441… Ross et… "ACYC…      0 2024-12-0…
##  6 Lung Cancer … "Whole-gen… TRUE        3449… Zhang e… ""          0 2025-06-0…
##  7 Pancreatic N… "Whole-gen… TRUE        2819… Scarpa … "PUBL…      0 2025-06-1…
##  8 Pan-cancer A… "Whole exo… TRUE        <NA>  <NA>     ""          0 2025-11-0…
##  9 Upper Tract … "Whole-exo… TRUE        3339… Xiaopin… "PUBL…      0 2025-06-2…
## 10 Cutaneous Sq… "Catalogue… TRUE        3427… Chang e… ""          0 2024-12-2…
## # ℹ 498 more rows
## # ℹ 5 more variables: allSampleCount <int>, readPermission <lgl>,
## #   studyId <chr>, cancerTypeId <chr>, referenceGenome <chr>
```

## Clinical Data

Obtain the clinical data for a particular study:

```
clinicalData(cbio, "acc_tcga")
```

```
## # A tibble: 92 × 85
##    patientId    AGE   AJCC_PATHOLOGIC_TUMOR_STAGE ATYPICAL_MITOTIC_FIGURES
##    <chr>        <chr> <chr>                       <chr>
##  1 TCGA-OR-A5J1 58    Stage II                    Atypical Mitotic Figures Abse…
##  2 TCGA-OR-A5J2 44    Stage IV                    Atypical Mitotic Figures Pres…
##  3 TCGA-OR-A5J3 23    Stage III                   Atypical Mitotic Figures Abse…
##  4 TCGA-OR-A5J4 23    Stage IV                    Atypical Mitotic Figures Abse…
##  5 TCGA-OR-A5J5 30    Stage III                   Atypical Mitotic Figures Pres…
##  6 TCGA-OR-A5J6 29    Stage II                    Atypical Mitotic Figures Abse…
##  7 TCGA-OR-A5J7 30    Stage III                   Atypical Mitotic Figures Pres…
##  8 TCGA-OR-A5J8 66    Stage III                   Atypical Mitotic Figures Pres…
##  9 TCGA-OR-A5J9 22    Stage II                    Atypical Mitotic Figures Abse…
## 10 TCGA-OR-A5JA 53    Stage IV                    Atypical Mitotic Figures Pres…
## # ℹ 82 more rows
## # ℹ 81 more variables: CAPSULAR_INVASION <chr>, CLIN_M_STAGE <chr>,
## #   CT_SCAN_PREOP_RESULTS <chr>,
## #   CYTOPLASM_PRESENCE_LESS_THAN_EQUAL_25_PERCENT <chr>,
## #   DAYS_TO_INITIAL_PATHOLOGIC_DIAGNOSIS <chr>, DFS_MONTHS <chr>,
## #   DFS_STATUS <chr>, DIFFUSE_ARCHITECTURE <chr>, ETHNICITY <chr>,
## #   FORM_COMPLETION_DATE <chr>, HISTOLOGICAL_DIAGNOSIS <chr>, …
```

## Molecular Profiles

A table of molecular profiles for a particular study can be obtained by
running the following:

```
mols <- molecularProfiles(cbio, "acc_tcga")
mols[["molecularProfileId"]]
```

```
## [1] "acc_tcga_rppa"
## [2] "acc_tcga_rppa_Zscores"
## [3] "acc_tcga_gistic"
## [4] "acc_tcga_linear_CNA"
## [5] "acc_tcga_mutations"
## [6] "acc_tcga_methylation_hm450"
## [7] "acc_tcga_rna_seq_v2_mrna"
## [8] "acc_tcga_rna_seq_v2_mrna_median_Zscores"
## [9] "acc_tcga_rna_seq_v2_mrna_median_all_sample_Zscores"
```

## Molecular Profile Data

The data for a molecular profile can be obtained with prior knowledge of
available `entrezGeneIds`:

```
molecularData(cbio, molecularProfileIds = "acc_tcga_rna_seq_v2_mrna",
    entrezGeneIds = c(1, 2),
    sampleIds = c("TCGA-OR-A5J1-01",  "TCGA-OR-A5J2-01")
)
```

```
## $acc_tcga_rna_seq_v2_mrna
## # A tibble: 4 × 8
##   uniqueSampleKey      uniquePatientKey entrezGeneId molecularProfileId sampleId
##   <chr>                <chr>                   <int> <chr>              <chr>
## 1 VENHQS1PUi1BNUoxLTA… VENHQS1PUi1BNUo…            1 acc_tcga_rna_seq_… TCGA-OR…
## 2 VENHQS1PUi1BNUoxLTA… VENHQS1PUi1BNUo…            2 acc_tcga_rna_seq_… TCGA-OR…
## 3 VENHQS1PUi1BNUoyLTA… VENHQS1PUi1BNUo…            1 acc_tcga_rna_seq_… TCGA-OR…
## 4 VENHQS1PUi1BNUoyLTA… VENHQS1PUi1BNUo…            2 acc_tcga_rna_seq_… TCGA-OR…
## # ℹ 3 more variables: patientId <chr>, studyId <chr>, value <dbl>
```

## Genes

### All available genes

A list of all the genes provided by the API service including hugo symbols,
and entrez gene IDs can be obtained by using the `geneTable` function:

```
geneTable(cbio)
```

```
## # A tibble: 1,000 × 3
##    entrezGeneId hugoGeneSymbol  type
##           <int> <chr>           <chr>
##  1        -3624 MIR-10A/10A     miRNA
##  2        -3712 MIR-559/559     miRNA
##  3        -3042 MIR-4315-2/4315 miRNA
##  4        -3204 MIR-4535/4535   miRNA
##  5        -3763 MIR-607/607     miRNA
##  6        -3457 MIR-1269A/1269A miRNA
##  7        -3286 MIR-4679-1/4679 miRNA
##  8        -3295 MIR-4686/4686   miRNA
##  9        -3054 MIR-4325/4325   miRNA
## 10        -3510 MIR-124A-1/5P   miRNA
## # ℹ 990 more rows
```

### Gene Panels

```
genePanels(cbio)
```

```
## # A tibble: 67 × 2
##    description                                                       genePanelId
##    <chr>                                                             <chr>
##  1 Targeted (27 cancer genes) sequencing of adenoid cystic carcinom… ACYC_FMI_27
##  2 Targeted panel of 232 genes.                                      Agilent
##  3 Targeted panel of 8 genes.                                        AmpliSeq
##  4 ARCHER-HEME gene panel (199 genes)                                ARCHER-HEM…
##  5 ARCHER-SOLID Gene Panel (62 genes)                                ARCHER-SOL…
##  6 Targeted sequencing of various tumor types via bait v3.           bait_v3
##  7 Targeted sequencing of various tumor types via bait v4.           bait_v4
##  8 Targeted sequencing of various tumor types via bait v5.           bait_v5
##  9 Targeted panel of 387 cancer-related genes.                       bcc_unige_…
## 10 Research (CMO) IMPACT-Heme gene panel version 3.                  HemePACT_v3
## # ℹ 57 more rows
```

```
getGenePanel(cbio, "IMPACT341")
```

```
## # A tibble: 341 × 2
##    entrezGeneId hugoGeneSymbol
##           <int> <chr>
##  1           25 ABL1
##  2        84142 ABRAXAS1
##  3          207 AKT1
##  4          208 AKT2
##  5        10000 AKT3
##  6          238 ALK
##  7          242 ALOX12B
##  8       139285 AMER1
##  9          324 APC
## 10          367 AR
## # ℹ 331 more rows
```

## Molecular Gene Panels

### genePanelMolecular

```
gprppa <- genePanelMolecular(cbio,
    molecularProfileId = "acc_tcga_rppa",
    sampleListId = "acc_tcga_all")
gprppa
```

```
## # A tibble: 92 × 7
##    uniqueSampleKey        uniquePatientKey molecularProfileId sampleId patientId
##    <chr>                  <chr>            <chr>              <chr>    <chr>
##  1 VENHQS1PUi1BNUoxLTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  2 VENHQS1PUi1BNUoyLTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  3 VENHQS1PUi1BNUozLTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  4 VENHQS1PUi1BNUo0LTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  5 VENHQS1PUi1BNUo1LTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  6 VENHQS1PUi1BNUo2LTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  7 VENHQS1PUi1BNUo3LTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  8 VENHQS1PUi1BNUo4LTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
##  9 VENHQS1PUi1BNUo5LTAxO… VENHQS1PUi1BNUo… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
## 10 VENHQS1PUi1BNUpBLTAxO… VENHQS1PUi1BNUp… acc_tcga_rppa      TCGA-OR… TCGA-OR-…
## # ℹ 82 more rows
## # ℹ 2 more variables: studyId <chr>, profiled <lgl>
```

### getGenePanelMolecular

```
getGenePanelMolecular(cbio,
    molecularProfileIds = c("acc_tcga_rppa", "acc_tcga_gistic"),
    sampleIds = allSamples(cbio, "acc_tcga")$sampleId
)
```

```
## # A tibble: 184 × 7
##    uniqueSampleKey        uniquePatientKey molecularProfileId sampleId patientId
##    <chr>                  <chr>            <chr>              <chr>    <chr>
##  1 VENHQS1PUi1BNUoxLTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  2 VENHQS1PUi1BNUoyLTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  3 VENHQS1PUi1BNUozLTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  4 VENHQS1PUi1BNUo0LTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  5 VENHQS1PUi1BNUo1LTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  6 VENHQS1PUi1BNUo2LTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  7 VENHQS1PUi1BNUo3LTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  8 VENHQS1PUi1BNUo4LTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
##  9 VENHQS1PUi1BNUo5LTAxO… VENHQS1PUi1BNUo… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
## 10 VENHQS1PUi1BNUpBLTAxO… VENHQS1PUi1BNUp… acc_tcga_gistic    TCGA-OR… TCGA-OR-…
## # ℹ 174 more rows
## # ℹ 2 more variables: studyId <chr>, profiled <lgl>
```

### getDataByGenes

```
getDataByGenes(cbio, "acc_tcga", genePanelId = "IMPACT341",
    molecularProfileIds = "acc_tcga_rppa", sampleListId = "acc_tcga_rppa")
```

```
## $acc_tcga_rppa
## # A tibble: 2,622 × 9
##    uniqueSampleKey     uniquePatientKey entrezGeneId molecularProfileId sampleId
##    <chr>               <chr>                   <int> <chr>              <chr>
##  1 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…         3667 acc_tcga_rppa      TCGA-OR…
##  2 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…         5594 acc_tcga_rppa      TCGA-OR…
##  3 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…          596 acc_tcga_rppa      TCGA-OR…
##  4 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…          598 acc_tcga_rppa      TCGA-OR…
##  5 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…        10018 acc_tcga_rppa      TCGA-OR…
##  6 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…       253260 acc_tcga_rppa      TCGA-OR…
##  7 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…         6794 acc_tcga_rppa      TCGA-OR…
##  8 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…          207 acc_tcga_rppa      TCGA-OR…
##  9 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…          208 acc_tcga_rppa      TCGA-OR…
## 10 VENHQS1PUi1BNUoyLT… VENHQS1PUi1BNUo…        10000 acc_tcga_rppa      TCGA-OR…
## # ℹ 2,612 more rows
## # ℹ 4 more variables: patientId <chr>, studyId <chr>, value <dbl>,
## #   hugoGeneSymbol <chr>
```

It uses the `getAllGenesUsingGET` function from the API.

## Samples

### Sample List Identifiers

To display all available sample list identifiers for a particular study ID,
one can use the `sampleLists` function:

```
sampleLists(cbio, "acc_tcga")
```

```
## # A tibble: 9 × 5
##   category                                name  description sampleListId studyId
##   <chr>                                   <chr> <chr>       <chr>        <chr>
## 1 all_cases_with_mrna_rnaseq_data         Samp… Samples wi… acc_tcga_rn… acc_tc…
## 2 all_cases_in_study                      All … All sample… acc_tcga_all acc_tc…
## 3 all_cases_with_cna_data                 Samp… Samples wi… acc_tcga_cna acc_tc…
## 4 all_cases_with_mutation_and_cna_data    Samp… Samples wi… acc_tcga_cn… acc_tc…
## 5 all_cases_with_mutation_and_cna_and_mr… Comp… Samples wi… acc_tcga_3w… acc_tc…
## 6 all_cases_with_methylation_data         Samp… Samples wi… acc_tcga_me… acc_tc…
## 7 all_cases_with_methylation_data         Samp… Samples wi… acc_tcga_me… acc_tc…
## 8 all_cases_with_rppa_data                Samp… Samples pr… acc_tcga_rp… acc_tc…
## 9 all_cases_with_mutation_data            Samp… Samples wi… acc_tcga_se… acc_tc…
```

### Sample Identifiers

One can obtain the barcodes / identifiers for each sample using a specific
sample list identifier, in this case we want all the copy number alteration
samples:

```
samplesInSampleLists(cbio, "acc_tcga_cna")
```

```
## CharacterList of length 1
## [["acc_tcga_cna"]] TCGA-OR-A5J1-01 TCGA-OR-A5J2-01 ... TCGA-PK-A5HC-01
```

This returns a `CharacterList` of all identifiers for each sample list
identifier input:

```
samplesInSampleLists(cbio, c("acc_tcga_cna", "acc_tcga_cnaseq"))
```

```
## CharacterList of length 2
## [["acc_tcga_cna"]] TCGA-OR-A5J1-01 TCGA-OR-A5J2-01 ... TCGA-PK-A5HC-01
## [["acc_tcga_cnaseq"]] TCGA-OR-A5J1-01 TCGA-OR-A5J2-01 ... TCGA-PK-A5HC-01
```

### All samples within a study ID

```
allSamples(cbio, "acc_tcga")
```

```
## # A tibble: 92 × 6
##    uniqueSampleKey        uniquePatientKey sampleType sampleId patientId studyId
##    <chr>                  <chr>            <chr>      <chr>    <chr>     <chr>
##  1 VENHQS1PUi1BNUoxLTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  2 VENHQS1PUi1BNUoyLTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  3 VENHQS1PUi1BNUozLTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  4 VENHQS1PUi1BNUo0LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  5 VENHQS1PUi1BNUo1LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  6 VENHQS1PUi1BNUo2LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  7 VENHQS1PUi1BNUo3LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  8 VENHQS1PUi1BNUo4LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  9 VENHQS1PUi1BNUo5LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
## 10 VENHQS1PUi1BNUpBLTAxO… VENHQS1PUi1BNUp… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
## # ℹ 82 more rows
```

### Info on Samples

```
getSampleInfo(cbio, studyId = "acc_tcga",
    sampleListIds = c("acc_tcga_rppa", "acc_tcga_cna"))
```

```
## # A tibble: 136 × 6
##    uniqueSampleKey        uniquePatientKey sampleType sampleId patientId studyId
##    <chr>                  <chr>            <chr>      <chr>    <chr>     <chr>
##  1 VENHQS1PUi1BNUoyLTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  2 VENHQS1PUi1BNUozLTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  3 VENHQS1PUi1BNUo2LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  4 VENHQS1PUi1BNUo3LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  5 VENHQS1PUi1BNUo4LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  6 VENHQS1PUi1BNUo5LTAxO… VENHQS1PUi1BNUo… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  7 VENHQS1PUi1BNUpBLTAxO… VENHQS1PUi1BNUp… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  8 VENHQS1PUi1BNUpQLTAxO… VENHQS1PUi1BNUp… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
##  9 VENHQS1PUi1BNUpSLTAxO… VENHQS1PUi1BNUp… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
## 10 VENHQS1PUi1BNUpTLTAxO… VENHQS1PUi1BNUp… Primary S… TCGA-OR… TCGA-OR-… acc_tc…
## # ℹ 126 more rows
```

# Advanced Usage

The `cBioPortal` API representation is not limited to the functions
provided in the package. Users who wish to make use of any of the endpoints
provided by the API specification should use the dollar sign `$` function
to access the endpoints.

First the user should see the input for a particular endpoint as detailed
in the API:

```
cbio$getGeneUsingGET
```

```
## getGeneUsingGET
## Get a gene
##
## Parameters:
##   geneId (string)
##     Entrez Gene ID or Hugo Gene Symbol e.g. 1 or A1BG
```

Then the user can provide such input:

```
(resp <- cbio$getGeneUsingGET("BRCA1"))
```

```
## Response [https://www.cbioportal.org/api/genes/BRCA1]
##   Date: 2025-11-09 21:45
##   Status: 200
##   Content-Type: application/json
##   Size: 69 B
```

which will require the user to ‘translate’ the response using `httr::content`:

```
httr::content(resp)
```

```
## $entrezGeneId
## [1] 672
##
## $hugoGeneSymbol
## [1] "BRCA1"
##
## $type
## [1] "protein-coding"
```

## Clearing the cache

For users who wish to clear the entire `cBioPortalData` cache, it is
recommended that they use:

```
unlink("~/.cache/cBioPortalData/")
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