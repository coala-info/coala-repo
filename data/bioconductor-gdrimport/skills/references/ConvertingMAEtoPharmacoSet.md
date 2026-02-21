# Converting a gDR-generated MultiAssayExperiment object into a PharmacoSet

#### Jermiah Joseph

jermiah.joseph@uhn.ca

#### Bartosz Czech

bartosz.w.czech@gmail.com

## Introduction

The `PharmacoGx` package is a popular tool from the Bioconductor project within the field of bioinformatics and computational biology. Whereas the `gDR` package is a valuable tool that provides the framework for the import, processing, analysism and visualization of high-dimensional drug response data, the `PharmacoGx` package provides functionality to containerize processed drug response and genomic data to perform pharmacogenomic analyses. The data structure used by `PharmacoGx` is described as a `PharamcoSet` class, inherited from `CoreGx::CoreSet`. Inspired by the `SummarizedExperiment` class, a new data structure class called the `TreatmentResponseExperiment` was developed to store drug response data within the `PharmacoSet`.

In collaboration with the BHKLab, we have developed functionality to convert between the `gDR`-generated `MultiAssayExperiment (MAE)` object and the `PharmacoSet` object (see the ConvertingPharmacoSetToGDR vignette to convert from a PharmacoSet to gDR object).

# Loading the gDR-generated MAE object

This workflow assumes that you have already generated a `MAE` object using the `gDR` package. We will load in a `MAE` object generated using the data from the [KW. Song et al, 2022](https://doi.org/10.1158/2159-8290.CD-21-0072) study. This `MAE` contains two drugs (`treatments`) and 7 cell lines (`samples`).

```
(mae <- qs::qread(
    system.file("extdata", "kyung2022mae", "MAE_E2.qs", package = "gDRimport")
  )
)
#> A MultiAssayExperiment object of 2 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 2:
#>  [1] matrix: SummarizedExperiment with 1 rows and 7 columns
#>  [2] single-agent: SummarizedExperiment with 2 rows and 7 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

# Converting the MAE object into a PharmacoSet object

First we will view the experiments and assays within the MultiAssayExperiment object.

```
gDRutils::MAEpply(mae, assays)
#> $matrix
#> List of length 14
#> names(14): RawTreated Controls Normalized ... CIScore_50 CIScore_80 Metrics
#>
#> $`single-agent`
#> List of length 5
#> names(5): RawTreated Controls Normalized Averaged Metrics
```

We will now convert the `MAE` object into a `PharmacoSet` object. We need to provide a name for the data object, in this example we will use the name of the study.

```
pset <- convert_MAE_to_PSet(mae, pset_name="Kyung2022")
#> 2025-12-08 17:48:59 Building assay index...
#> 2025-12-08 17:48:59 Joining rowData to assayIndex...
#> 2025-12-08 17:49:00 Joining colData to assayIndex...
#> 2025-12-08 17:49:00 Joining assays to assayIndex...
#> 2025-12-08 17:49:02 Setting assayIndex key...
#> 2025-12-08 17:49:02 Building LongTable...
```

We can now view the `PharmacoSet` object.

```
pset
#> <PharmacoSet>
#> Name: Kyung2022
#> Date Created: Mon Dec  8 17:49:03 2025
#> Number of samples:  7
#> Molecular profiles: <MultiAssayExperiment>
#>    ExperimentList class object of length 1:
#>     [1] emptySE : SummarizedExperiment with 0 rows and 7 columns
#> Treatment response: <TreatmentResponseExperiment>
#>    dim:  3 7
#>    assays(14): RawTreated Controls Normalized Averaged SmoothMatrix BlissExcess
#>   HSAExcess all_iso_points isobolograms BlissScore HSAScore CIScore_50
#>   CIScore_80 Metrics
#>    rownames(3): G02001876_Palbociclib_CDK4|CDK6_168 G02967907_GDC-0077_PI3K-A_168 G02967907_GDC-0077_PI3K-A_G02001876_Palbociclib_CDK4|CDK6_vehicle_vehicle_168
#>    rowData(10): treatmentid Gnumber DrugName ... DrugName_3 drug_moa_3 Duration
#>    colnames(7): CL129757_MCF-7_Breast_MCF-7_unknown_30 CL130218_BT-474_Breast_BT-474_unknown_70 CL130742_T-47D_Breast_T-47D_unknown_60 ... CL131873_HCC1428_Breast_HCC1428_unknown_74 CL131891_EFM-19_Breast_EFM-19_unknown_64 CL131903_BT-483_Breast_BT-483_unknown_130
#>    colData(7): sampleid clid CellLineName ... parental_identifier subtype ReferenceDivisionTime
#>    metadata(0): none
```

We can view information about the drugs and cell lines in the `PharmacoSet` object using the `treatment` and `sample` slots:

```
head(treatmentInfo(pset))
#>                                                                     treatmentid
#> 1 G02967907_GDC-0077_PI3K-A_G02001876_Palbociclib_CDK4|CDK6_vehicle_vehicle_168
#> 2                                           G02001876_Palbociclib_CDK4|CDK6_168
#> 3                                                 G02967907_GDC-0077_PI3K-A_168
#>     Gnumber    DrugName  drug_moa Gnumber_2  DrugName_2 drug_moa_2 DrugName_3
#> 1 G02967907    GDC-0077    PI3K-A G02001876 Palbociclib  CDK4|CDK6    vehicle
#> 2 G02001876 Palbociclib CDK4|CDK6      <NA>        <NA>       <NA>       <NA>
#> 3 G02967907    GDC-0077    PI3K-A      <NA>        <NA>       <NA>       <NA>
#>   drug_moa_3 Duration
#> 1    vehicle      168
#> 2       <NA>      168
#> 3       <NA>      168

head(sampleInfo(pset))
#>                                                                              sampleid
#> CL129757_MCF-7_Breast_MCF-7_unknown_30         CL129757_MCF-7_Breast_MCF-7_unknown_30
#> CL130218_BT-474_Breast_BT-474_unknown_70     CL130218_BT-474_Breast_BT-474_unknown_70
#> CL130742_T-47D_Breast_T-47D_unknown_60         CL130742_T-47D_Breast_T-47D_unknown_60
#> CL131438_CAMA-1_Breast_CAMA-1_unknown_53     CL131438_CAMA-1_Breast_CAMA-1_unknown_53
#> CL131873_HCC1428_Breast_HCC1428_unknown_74 CL131873_HCC1428_Breast_HCC1428_unknown_74
#> CL131891_EFM-19_Breast_EFM-19_unknown_64     CL131891_EFM-19_Breast_EFM-19_unknown_64
#>                                                clid CellLineName Tissue
#> CL129757_MCF-7_Breast_MCF-7_unknown_30     CL129757        MCF-7 Breast
#> CL130218_BT-474_Breast_BT-474_unknown_70   CL130218       BT-474 Breast
#> CL130742_T-47D_Breast_T-47D_unknown_60     CL130742        T-47D Breast
#> CL131438_CAMA-1_Breast_CAMA-1_unknown_53   CL131438       CAMA-1 Breast
#> CL131873_HCC1428_Breast_HCC1428_unknown_74 CL131873      HCC1428 Breast
#> CL131891_EFM-19_Breast_EFM-19_unknown_64   CL131891       EFM-19 Breast
#>                                            parental_identifier subtype
#> CL129757_MCF-7_Breast_MCF-7_unknown_30                   MCF-7 unknown
#> CL130218_BT-474_Breast_BT-474_unknown_70                BT-474 unknown
#> CL130742_T-47D_Breast_T-47D_unknown_60                   T-47D unknown
#> CL131438_CAMA-1_Breast_CAMA-1_unknown_53                CAMA-1 unknown
#> CL131873_HCC1428_Breast_HCC1428_unknown_74             HCC1428 unknown
#> CL131891_EFM-19_Breast_EFM-19_unknown_64                EFM-19 unknown
#>                                            ReferenceDivisionTime batchid
#> CL129757_MCF-7_Breast_MCF-7_unknown_30                        30       1
#> CL130218_BT-474_Breast_BT-474_unknown_70                      70       1
#> CL130742_T-47D_Breast_T-47D_unknown_60                        60       1
#> CL131438_CAMA-1_Breast_CAMA-1_unknown_53                      53       1
#> CL131873_HCC1428_Breast_HCC1428_unknown_74                    74       1
#> CL131891_EFM-19_Breast_EFM-19_unknown_64                      64       1
```

# TreatmentResponseExperiment Object

The `TreatmentResponseExperiment` is a new class that was developed to store drug response data within the `PharmacoSet` object. This vignette will cover some basics about this class, however for more information, please refer to the `PharmacoSet` vignette [TreatmentResponseExperiment](https://bioconductor.org/packages/release/bioc/vignettes/CoreGx/inst/doc/TreatmentResponseExperiment.html)\*\*\*\*.

## Row and Column Names

```
tre <- treatmentResponse(pset)
head(rownames(tre))
#> [1] "G02001876_Palbociclib_CDK4|CDK6_168"
#> [2] "G02967907_GDC-0077_PI3K-A_168"
#> [3] "G02967907_GDC-0077_PI3K-A_G02001876_Palbociclib_CDK4|CDK6_vehicle_vehicle_168"
head(rowData(tre))
#>                                                                      treatmentid
#>                                                                           <char>
#> 1:                                           G02001876_Palbociclib_CDK4|CDK6_168
#> 2:                                                 G02967907_GDC-0077_PI3K-A_168
#> 3: G02967907_GDC-0077_PI3K-A_G02001876_Palbociclib_CDK4|CDK6_vehicle_vehicle_168
#>      Gnumber    DrugName  drug_moa Gnumber_2  DrugName_2 drug_moa_2 DrugName_3
#>       <char>      <char>    <char>    <char>      <char>     <char>     <char>
#> 1: G02001876 Palbociclib CDK4|CDK6      <NA>        <NA>       <NA>       <NA>
#> 2: G02967907    GDC-0077    PI3K-A      <NA>        <NA>       <NA>       <NA>
#> 3: G02967907    GDC-0077    PI3K-A G02001876 Palbociclib  CDK4|CDK6    vehicle
#>    drug_moa_3 Duration
#>        <char>    <num>
#> 1:       <NA>      168
#> 2:       <NA>      168
#> 3:    vehicle      168
```

```
head(colnames(tre))
#> [1] "CL129757_MCF-7_Breast_MCF-7_unknown_30"
#> [2] "CL130218_BT-474_Breast_BT-474_unknown_70"
#> [3] "CL130742_T-47D_Breast_T-47D_unknown_60"
#> [4] "CL131438_CAMA-1_Breast_CAMA-1_unknown_53"
#> [5] "CL131873_HCC1428_Breast_HCC1428_unknown_74"
#> [6] "CL131891_EFM-19_Breast_EFM-19_unknown_64"
head(colData(tre))
#>                                      sampleid     clid CellLineName Tissue
#>                                        <char>   <char>       <char> <char>
#> 1:     CL129757_MCF-7_Breast_MCF-7_unknown_30 CL129757        MCF-7 Breast
#> 2:   CL130218_BT-474_Breast_BT-474_unknown_70 CL130218       BT-474 Breast
#> 3:     CL130742_T-47D_Breast_T-47D_unknown_60 CL130742        T-47D Breast
#> 4:   CL131438_CAMA-1_Breast_CAMA-1_unknown_53 CL131438       CAMA-1 Breast
#> 5: CL131873_HCC1428_Breast_HCC1428_unknown_74 CL131873      HCC1428 Breast
#> 6:   CL131891_EFM-19_Breast_EFM-19_unknown_64 CL131891       EFM-19 Breast
#>    parental_identifier subtype ReferenceDivisionTime
#>                 <char>  <char>                 <num>
#> 1:               MCF-7 unknown                    30
#> 2:              BT-474 unknown                    70
#> 3:               T-47D unknown                    60
#> 4:              CAMA-1 unknown                    53
#> 5:             HCC1428 unknown                    74
#> 6:              EFM-19 unknown                    64
```

## `data.table` Subsetting

In addition to regex queries, a `TreatmentResponseExperiment` object supports arbitrarily complex subset queries using the `data.table` API. To access this API, you will need to use the `.` function, which allows you to pass raw R expressions to be evaluated inside the `i` and `j` arguments for `dataTable[i, j]`.

For example if we want to subset to rows where the cell line is “CL131891\_EFM-19\_Breast\_EFM-19\_unknown\_64” and drug is “G02967907\_GDC-0077\_PI3K-A\_168”.

```
tre[
  .(treatmentid=="G02967907_GDC-0077_PI3K-A_168"), # query on row
  .(sampleid=="CL131891_EFM-19_Breast_EFM-19_unknown_64") # query on column
]
#> <TreatmentResponseExperiment>
#>    dim:  1 1
#>    assays(14): RawTreated Controls Normalized Averaged SmoothMatrix BlissExcess
#>   HSAExcess all_iso_points isobolograms BlissScore HSAScore CIScore_50
#>   CIScore_80 Metrics
#>    rownames(1): G02967907_GDC-0077_PI3K-A_168
#>    rowData(10): treatmentid Gnumber DrugName ... DrugName_3 drug_moa_3 Duration
#>    colnames(1): CL131891_EFM-19_Breast_EFM-19_unknown_64
#>    colData(7): sampleid clid CellLineName ... parental_identifier subtype ReferenceDivisionTime
#>    metadata(0): none
```

We can also invert matches or subset on other columns in `rowData` or `colData`:

```
tre[
  .(treatmentid!="G02967907_GDC-0077_PI3K-A_168"), # query on row
  .(sampleid!="CL131891_EFM-19_Breast_EFM-19_unknown_64") # query on column
]
#> <TreatmentResponseExperiment>
#>    dim:  2 6
#>    assays(14): RawTreated Controls Normalized Averaged SmoothMatrix BlissExcess
#>   HSAExcess all_iso_points isobolograms BlissScore HSAScore CIScore_50
#>   CIScore_80 Metrics
#>    rownames(2): G02001876_Palbociclib_CDK4|CDK6_168 G02967907_GDC-0077_PI3K-A_G02001876_Palbociclib_CDK4|CDK6_vehicle_vehicle_168
#>    rowData(10): treatmentid Gnumber DrugName ... DrugName_3 drug_moa_3 Duration
#>    colnames(6): CL129757_MCF-7_Breast_MCF-7_unknown_30 CL130218_BT-474_Breast_BT-474_unknown_70 CL130742_T-47D_Breast_T-47D_unknown_60 CL131438_CAMA-1_Breast_CAMA-1_unknown_53 CL131873_HCC1428_Breast_HCC1428_unknown_74 CL131903_BT-483_Breast_BT-483_unknown_130
#>    colData(7): sampleid clid CellLineName ... parental_identifier subtype ReferenceDivisionTime
#>    metadata(0): none
```

## assays

The assays can be viewed through the `assays` function. Each assay has a column “data\_type” which references which `SummarizedExperiment` from the `MAE` the data corresponds with.

```
lapply(assays(tre), head)
#> $RawTreated
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type Concentration
#>    <char> <char>              <char>  <char>       <char>         <num>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent   0.004572471
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent   0.004572471
#>    Concentration_2   Barcode ReadoutValue BackgroundValue
#>              <num>    <char>        <num>           <num>
#> 1:              NA 30190103p       921614             483
#> 2:              NA 30190103p       999312             483
#> 3:              NA 30190103p      1104556             483
#> 4:              NA 30190103p      1122112             483
#> 5:              NA 30190103p       874807             483
#> 6:              NA 30190103p       994797             483
#>                                Template WellRow WellColumn record_id masked
#>                                  <char>  <char>     <char>     <int> <lgcl>
#> 1: Template_0077_Palbo_7daytreated.xlsx       D         20      2832  FALSE
#> 2: Template_0077_Palbo_7daytreated.xlsx       C         20      2831  FALSE
#> 3: Template_0077_Palbo_7daytreated.xlsx       D         19      2830  FALSE
#> 4: Template_0077_Palbo_7daytreated.xlsx       C         19      2829  FALSE
#> 5: Template_0077_Palbo_7daytreated.xlsx       C         18      2835  FALSE
#> 6: Template_0077_Palbo_7daytreated.xlsx       D         18      2836  FALSE
#>    CorrectedReadout swap_sa i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2
#>               <num>  <lgcl>    <char>      <char>     <char>      <char>
#> 1:           921131      NA G02001876 Palbociclib  CDK4|CDK6        <NA>
#> 2:           998829      NA G02001876 Palbociclib  CDK4|CDK6        <NA>
#> 3:          1104073      NA G02001876 Palbociclib  CDK4|CDK6        <NA>
#> 4:          1121629      NA G02001876 Palbociclib  CDK4|CDK6        <NA>
#> 5:           874324      NA G02001876 Palbociclib  CDK4|CDK6        <NA>
#> 6:           994314      NA G02001876 Palbociclib  CDK4|CDK6        <NA>
#>    i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration   i.clid
#>          <char>       <char>       <char>       <char>      <num>   <char>
#> 1:         <NA>         <NA>         <NA>         <NA>        168 CL129757
#> 2:         <NA>         <NA>         <NA>         <NA>        168 CL129757
#> 3:         <NA>         <NA>         <NA>         <NA>        168 CL129757
#> 4:         <NA>         <NA>         <NA>         <NA>        168 CL129757
#> 5:         <NA>         <NA>         <NA>         <NA>        168 CL129757
#> 6:         <NA>         <NA>         <NA>         <NA>        168 CL129757
#>    i.CellLineName i.Tissue i.parental_identifier i.subtype
#>            <char>   <char>                <char>    <char>
#> 1:          MCF-7   Breast                 MCF-7   unknown
#> 2:          MCF-7   Breast                 MCF-7   unknown
#> 3:          MCF-7   Breast                 MCF-7   unknown
#> 4:          MCF-7   Breast                 MCF-7   unknown
#> 5:          MCF-7   Breast                 MCF-7   unknown
#> 6:          MCF-7   Breast                 MCF-7   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      30
#> 3:                      30
#> 4:                      30
#> 5:                      30
#> 6:                      30
#>
#> $Controls
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type control_type
#>    <char> <char>              <char>  <char>       <char>       <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent  Day0Readout
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent  Day0Readout
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent  Day0Readout
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent  Day0Readout
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent  Day0Readout
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent  Day0Readout
#>    CorrectedReadout record_id   Barcode isDay0 i.Gnumber  i.DrugName i.drug_moa
#>               <num>     <int>    <char> <lgcl>    <char>      <char>     <char>
#> 1:            97219      2401 20190103p   TRUE G02001876 Palbociclib  CDK4|CDK6
#> 2:            97219      2402 20190103p   TRUE G02001876 Palbociclib  CDK4|CDK6
#> 3:            97219      2403 20190103p   TRUE G02001876 Palbociclib  CDK4|CDK6
#> 4:            97219      2404 20190103p   TRUE G02001876 Palbociclib  CDK4|CDK6
#> 5:            97219      2405 20190103p   TRUE G02001876 Palbociclib  CDK4|CDK6
#> 6:            97219      2406 20190103p   TRUE G02001876 Palbociclib  CDK4|CDK6
#>    i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration
#>         <char>       <char>       <char>       <char>       <char>      <num>
#> 1:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 2:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 3:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 4:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 5:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 6:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#>      i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>      <char>         <char>   <char>                <char>    <char>
#> 1: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 3: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 4: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 5: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 6: CL129757          MCF-7   Breast                 MCF-7   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      30
#> 3:                      30
#> 4:                      30
#> 5:                      30
#> 6:                      30
#>
#> $Normalized
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type Concentration
#>    <char> <char>              <char>  <char>       <char>         <num>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent   0.001524158
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent   0.004572471
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent   0.004572471
#>    Concentration_2 masked normalization_type      x i.Gnumber  i.DrugName
#>              <num> <lgcl>             <fctr>  <num>    <char>      <char>
#> 1:              NA  FALSE                 RV 0.8253 G02001876 Palbociclib
#> 2:              NA  FALSE                 RV 0.8949 G02001876 Palbociclib
#> 3:              NA  FALSE                 RV 0.9892 G02001876 Palbociclib
#> 4:              NA  FALSE                 RV 1.0049 G02001876 Palbociclib
#> 5:              NA  FALSE                 RV 0.7833 G02001876 Palbociclib
#> 6:              NA  FALSE                 RV 0.8908 G02001876 Palbociclib
#>    i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3
#>        <char>      <char>       <char>       <char>       <char>       <char>
#> 1:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 2:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 3:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 4:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 5:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 6:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#>    i.Duration   i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>         <num>   <char>         <char>   <char>                <char>    <char>
#> 1:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 3:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 4:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 5:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 6:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      30
#> 3:                      30
#> 4:                      30
#> 5:                      30
#> 6:                      30
#>
#> $Averaged
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <fctr>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent                 RV
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent                 GR
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent                 RV
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent                 GR
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent                 RV
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent                 GR
#>    Concentration Concentration_2        x      x_std i.Gnumber  i.DrugName
#>            <num>           <num>    <num>      <num>    <char>      <char>
#> 1:   0.001524158              NA 0.928575 0.08426274 G02001876 Palbociclib
#> 2:   0.001524158              NA 0.952225 0.05675581 G02001876 Palbociclib
#> 3:   0.004572471              NA 0.885050 0.07091133 G02001876 Palbociclib
#> 4:   0.004572471              NA 0.923000 0.04998000 G02001876 Palbociclib
#> 5:   0.013717406              NA 0.843800 0.05585201 G02001876 Palbociclib
#> 6:   0.013717406              NA 0.894475 0.04037973 G02001876 Palbociclib
#>    i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3
#>        <char>      <char>       <char>       <char>       <char>       <char>
#> 1:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 2:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 3:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 4:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 5:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 6:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#>    i.Duration   i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>         <num>   <char>         <char>   <char>                <char>    <char>
#> 1:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 3:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 4:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 5:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 6:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      30
#> 3:                      30
#> 4:                      30
#> 5:                      30
#> 6:                      30
#>
#> $SmoothMatrix
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type Concentration
#>    <char> <char>              <char>  <char>       <char>         <num>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#>    Concentration_2     x normalization_type i.Gnumber  i.DrugName i.drug_moa
#>              <num> <num>             <char>    <char>      <char>     <char>
#> 1:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 2:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 3:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 4:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 5:              NA    NA               <NA> G02967907    GDC-0077     PI3K-A
#> 6:              NA    NA               <NA> G02967907    GDC-0077     PI3K-A
#>    i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration
#>         <char>       <char>       <char>       <char>       <char>      <num>
#> 1:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 2:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 3:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 4:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 5:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 6:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#>      i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>      <char>         <char>   <char>                <char>    <char>
#> 1: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2: CL130742          T-47D   Breast                 T-47D   unknown
#> 3: CL131873        HCC1428   Breast               HCC1428   unknown
#> 4: CL131903         BT-483   Breast                BT-483   unknown
#> 5: CL130218         BT-474   Breast                BT-474   unknown
#> 6: CL131438         CAMA-1   Breast                CAMA-1   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      60
#> 3:                      74
#> 4:                     130
#> 5:                      70
#> 6:                      53
#>
#> $BlissExcess
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type Concentration
#>    <char> <char>              <char>  <char>       <char>         <num>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#>    Concentration_2     x normalization_type i.Gnumber  i.DrugName i.drug_moa
#>              <num> <num>             <char>    <char>      <char>     <char>
#> 1:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 2:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 3:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 4:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 5:              NA    NA               <NA> G02967907    GDC-0077     PI3K-A
#> 6:              NA    NA               <NA> G02967907    GDC-0077     PI3K-A
#>    i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration
#>         <char>       <char>       <char>       <char>       <char>      <num>
#> 1:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 2:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 3:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 4:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 5:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 6:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#>      i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>      <char>         <char>   <char>                <char>    <char>
#> 1: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2: CL130742          T-47D   Breast                 T-47D   unknown
#> 3: CL131873        HCC1428   Breast               HCC1428   unknown
#> 4: CL131903         BT-483   Breast                BT-483   unknown
#> 5: CL130218         BT-474   Breast                BT-474   unknown
#> 6: CL131438         CAMA-1   Breast                CAMA-1   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      60
#> 3:                      74
#> 4:                     130
#> 5:                      70
#> 6:                      53
#>
#> $HSAExcess
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type Concentration
#>    <char> <char>              <char>  <char>       <char>         <num>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent            NA
#>    Concentration_2     x normalization_type i.Gnumber  i.DrugName i.drug_moa
#>              <num> <num>             <char>    <char>      <char>     <char>
#> 1:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 2:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 3:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 4:              NA    NA               <NA> G02001876 Palbociclib  CDK4|CDK6
#> 5:              NA    NA               <NA> G02967907    GDC-0077     PI3K-A
#> 6:              NA    NA               <NA> G02967907    GDC-0077     PI3K-A
#>    i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration
#>         <char>       <char>       <char>       <char>       <char>      <num>
#> 1:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 2:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 3:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 4:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 5:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#> 6:        <NA>         <NA>         <NA>         <NA>         <NA>        168
#>      i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>      <char>         <char>   <char>                <char>    <char>
#> 1: CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2: CL130742          T-47D   Breast                 T-47D   unknown
#> 3: CL131873        HCC1428   Breast               HCC1428   unknown
#> 4: CL131903         BT-483   Breast                BT-483   unknown
#> 5: CL130218         BT-474   Breast                BT-474   unknown
#> 6: CL131438         CAMA-1   Breast                CAMA-1   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      60
#> 3:                      74
#> 4:                     130
#> 5:                      70
#> 6:                      53
#>
#> $all_iso_points
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#>    i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2
#>       <char>      <char>     <char>      <char>       <char>       <char>
#> 1: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 2: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 3: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 4: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 5: G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#> 6: G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#>    i.DrugName_3 i.drug_moa_3 i.Duration   i.clid i.CellLineName i.Tissue
#>          <char>       <char>      <num>   <char>         <char>   <char>
#> 1:         <NA>         <NA>        168 CL129757          MCF-7   Breast
#> 2:         <NA>         <NA>        168 CL130742          T-47D   Breast
#> 3:         <NA>         <NA>        168 CL131873        HCC1428   Breast
#> 4:         <NA>         <NA>        168 CL131903         BT-483   Breast
#> 5:         <NA>         <NA>        168 CL130218         BT-474   Breast
#> 6:         <NA>         <NA>        168 CL131438         CAMA-1   Breast
#>    i.parental_identifier i.subtype i.ReferenceDivisionTime      x
#>                   <char>    <char>                   <num> <lgcl>
#> 1:                 MCF-7   unknown                      30     NA
#> 2:                 T-47D   unknown                      60     NA
#> 3:               HCC1428   unknown                      74     NA
#> 4:                BT-483   unknown                     130     NA
#> 5:                BT-474   unknown                      70     NA
#> 6:                CAMA-1   unknown                      53     NA
#>
#> $isobolograms
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#>    i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2
#>       <char>      <char>     <char>      <char>       <char>       <char>
#> 1: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 2: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 3: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 4: G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 5: G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#> 6: G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#>    i.DrugName_3 i.drug_moa_3 i.Duration   i.clid i.CellLineName i.Tissue
#>          <char>       <char>      <num>   <char>         <char>   <char>
#> 1:         <NA>         <NA>        168 CL129757          MCF-7   Breast
#> 2:         <NA>         <NA>        168 CL130742          T-47D   Breast
#> 3:         <NA>         <NA>        168 CL131873        HCC1428   Breast
#> 4:         <NA>         <NA>        168 CL131903         BT-483   Breast
#> 5:         <NA>         <NA>        168 CL130218         BT-474   Breast
#> 6:         <NA>         <NA>        168 CL131438         CAMA-1   Breast
#>    i.parental_identifier i.subtype i.ReferenceDivisionTime      x
#>                   <char>    <char>                   <num> <lgcl>
#> 1:                 MCF-7   unknown                      30     NA
#> 2:                 T-47D   unknown                      60     NA
#> 3:               HCC1428   unknown                      74     NA
#> 4:                BT-483   unknown                     130     NA
#> 5:                BT-474   unknown                      70     NA
#> 6:                CAMA-1   unknown                      53     NA
#>
#> $BlissScore
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#>        x i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2
#>    <num>    <char>      <char>     <char>      <char>       <char>       <char>
#> 1:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 2:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 3:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 4:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 5:    NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#> 6:    NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#>    i.DrugName_3 i.drug_moa_3 i.Duration   i.clid i.CellLineName i.Tissue
#>          <char>       <char>      <num>   <char>         <char>   <char>
#> 1:         <NA>         <NA>        168 CL129757          MCF-7   Breast
#> 2:         <NA>         <NA>        168 CL130742          T-47D   Breast
#> 3:         <NA>         <NA>        168 CL131873        HCC1428   Breast
#> 4:         <NA>         <NA>        168 CL131903         BT-483   Breast
#> 5:         <NA>         <NA>        168 CL130218         BT-474   Breast
#> 6:         <NA>         <NA>        168 CL131438         CAMA-1   Breast
#>    i.parental_identifier i.subtype i.ReferenceDivisionTime
#>                   <char>    <char>                   <num>
#> 1:                 MCF-7   unknown                      30
#> 2:                 T-47D   unknown                      60
#> 3:               HCC1428   unknown                      74
#> 4:                BT-483   unknown                     130
#> 5:                BT-474   unknown                      70
#> 6:                CAMA-1   unknown                      53
#>
#> $HSAScore
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#>        x i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2
#>    <num>    <char>      <char>     <char>      <char>       <char>       <char>
#> 1:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 2:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 3:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 4:    NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>         <NA>
#> 5:    NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#> 6:    NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>         <NA>
#>    i.DrugName_3 i.drug_moa_3 i.Duration   i.clid i.CellLineName i.Tissue
#>          <char>       <char>      <num>   <char>         <char>   <char>
#> 1:         <NA>         <NA>        168 CL129757          MCF-7   Breast
#> 2:         <NA>         <NA>        168 CL130742          T-47D   Breast
#> 3:         <NA>         <NA>        168 CL131873        HCC1428   Breast
#> 4:         <NA>         <NA>        168 CL131903         BT-483   Breast
#> 5:         <NA>         <NA>        168 CL130218         BT-474   Breast
#> 6:         <NA>         <NA>        168 CL131438         CAMA-1   Breast
#>    i.parental_identifier i.subtype i.ReferenceDivisionTime
#>                   <char>    <char>                   <num>
#> 1:                 MCF-7   unknown                      30
#> 2:                 T-47D   unknown                      60
#> 3:               HCC1428   unknown                      74
#> 4:                BT-483   unknown                     130
#> 5:                BT-474   unknown                      70
#> 6:                CAMA-1   unknown                      53
#>
#> $CIScore_50
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#>         x i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2 i.DrugName_2
#>    <lgcl>    <char>      <char>     <char>      <char>       <char>
#> 1:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 2:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 3:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 4:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 5:     NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>
#> 6:     NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>
#>    i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration   i.clid i.CellLineName
#>          <char>       <char>       <char>      <num>   <char>         <char>
#> 1:         <NA>         <NA>         <NA>        168 CL129757          MCF-7
#> 2:         <NA>         <NA>         <NA>        168 CL130742          T-47D
#> 3:         <NA>         <NA>         <NA>        168 CL131873        HCC1428
#> 4:         <NA>         <NA>         <NA>        168 CL131903         BT-483
#> 5:         <NA>         <NA>         <NA>        168 CL130218         BT-474
#> 6:         <NA>         <NA>         <NA>        168 CL131438         CAMA-1
#>    i.Tissue i.parental_identifier i.subtype i.ReferenceDivisionTime
#>      <char>                <char>    <char>                   <num>
#> 1:   Breast                 MCF-7   unknown                      30
#> 2:   Breast                 T-47D   unknown                      60
#> 3:   Breast               HCC1428   unknown                      74
#> 4:   Breast                BT-483   unknown                     130
#> 5:   Breast                BT-474   unknown                      70
#> 6:   Breast                CAMA-1   unknown                      53
#>
#> $CIScore_80
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type normalization_type
#>    <char> <char>              <char>  <char>       <char>             <char>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent               <NA>
#>         x i.Gnumber  i.DrugName i.drug_moa i.Gnumber_2 i.DrugName_2
#>    <lgcl>    <char>      <char>     <char>      <char>       <char>
#> 1:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 2:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 3:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 4:     NA G02001876 Palbociclib  CDK4|CDK6        <NA>         <NA>
#> 5:     NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>
#> 6:     NA G02967907    GDC-0077     PI3K-A        <NA>         <NA>
#>    i.drug_moa_2 i.DrugName_3 i.drug_moa_3 i.Duration   i.clid i.CellLineName
#>          <char>       <char>       <char>      <num>   <char>         <char>
#> 1:         <NA>         <NA>         <NA>        168 CL129757          MCF-7
#> 2:         <NA>         <NA>         <NA>        168 CL130742          T-47D
#> 3:         <NA>         <NA>         <NA>        168 CL131873        HCC1428
#> 4:         <NA>         <NA>         <NA>        168 CL131903         BT-483
#> 5:         <NA>         <NA>         <NA>        168 CL130218         BT-474
#> 6:         <NA>         <NA>         <NA>        168 CL131438         CAMA-1
#>    i.Tissue i.parental_identifier i.subtype i.ReferenceDivisionTime
#>      <char>                <char>    <char>                   <num>
#> 1:   Breast                 MCF-7   unknown                      30
#> 2:   Breast                 T-47D   unknown                      60
#> 3:   Breast               HCC1428   unknown                      74
#> 4:   Breast                BT-483   unknown                     130
#> 5:   Breast                BT-474   unknown                      70
#> 6:   Breast                CAMA-1   unknown                      53
#>
#> $Metrics
#> Key: <treatmentid, sampleid>
#>    treatmentid sampleid DrugName DrugName_2 DrugName_3 Duration Gnumber
#>         <char>   <char>   <char>     <char>     <char>    <num>  <char>
#> 1:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 2:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 3:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 4:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 5:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#> 6:        <NA>     <NA>     <NA>       <NA>       <NA>       NA    <NA>
#>    Gnumber_2 drug_moa drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime
#>       <char>   <char>     <char>     <char>       <char>                 <num>
#> 1:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 2:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 3:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 4:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 5:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#> 6:      <NA>     <NA>       <NA>       <NA>         <NA>                    NA
#>    Tissue   clid parental_identifier subtype    data_type    x_mean     x_AOC
#>    <char> <char>              <char>  <char>       <char>     <num>     <num>
#> 1:   <NA>   <NA>                <NA>    <NA> single-agent 0.4766169 0.5233831
#> 2:   <NA>   <NA>                <NA>    <NA> single-agent 0.6438030 0.3561970
#> 3:   <NA>   <NA>                <NA>    <NA> single-agent 0.5797408 0.4202592
#> 4:   <NA>   <NA>                <NA>    <NA> single-agent 0.4888085 0.5111915
#> 5:   <NA>   <NA>                <NA>    <NA> single-agent 0.6458536 0.3541464
#> 6:   <NA>   <NA>                <NA>    <NA> single-agent 0.4821213 0.5178787
#>    x_AOC_range       xc50    x_max       ec50      x_inf   x_0         h
#>          <num>      <num>    <num>      <num>      <num> <num>     <num>
#> 1:   0.5685724 0.07649828 0.107050 0.06354470 0.08684205     1 1.0283168
#> 2:   0.3828886 0.26119890 0.281750 0.09897928 0.32080324     1 1.0574543
#> 3:   0.4560827 0.10802210 0.207125 0.08784832 0.21933259     1 2.7932767
#> 4:   0.5620006 0.06629065 0.111625 0.05911087 0.12311310     1 2.4657832
#> 5:   0.3770687 0.26781723 0.228300 0.13626047 0.27577126     1 1.1867664
#> 6:   0.5639825 0.06294109 0.148225 0.04029515 0.16592442     1 0.9041923
#>           r2   x_sd_avg               fit_type maxlog10Concentration N_conc
#>        <num>      <num>                 <char>                 <num>  <int>
#> 1: 0.9853800 0.05272629 DRC3pHillFitModelFixS0                     1     10
#> 2: 0.9465590 0.07259453 DRC3pHillFitModelFixS0                     1     10
#> 3: 0.9787945 0.06655135 DRC3pHillFitModelFixS0                     1     10
#> 4: 0.9946671 0.07915584 DRC3pHillFitModelFixS0                     1     10
#> 5: 0.9616801 0.06463053 DRC3pHillFitModelFixS0                     1     10
#> 6: 0.9740112 0.05594059 DRC3pHillFitModelFixS0                     1     10
#>    normalization_type fit_source cotrt_value source i.Gnumber  i.DrugName
#>                <char>     <char>       <num> <char>    <char>      <char>
#> 1:                 RV        gDR          NA   <NA> G02001876 Palbociclib
#> 2:                 RV        gDR          NA   <NA> G02001876 Palbociclib
#> 3:                 RV        gDR          NA   <NA> G02001876 Palbociclib
#> 4:                 RV        gDR          NA   <NA> G02001876 Palbociclib
#> 5:                 RV        gDR          NA   <NA> G02001876 Palbociclib
#> 6:                 RV        gDR          NA   <NA> G02001876 Palbociclib
#>    i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3
#>        <char>      <char>       <char>       <char>       <char>       <char>
#> 1:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 2:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 3:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 4:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 5:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 6:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#>    i.Duration   i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>         <num>   <char>         <char>   <char>                <char>    <char>
#> 1:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2:        168 CL130218         BT-474   Breast                BT-474   unknown
#> 3:        168 CL130742          T-47D   Breast                 T-47D   unknown
#> 4:        168 CL131438         CAMA-1   Breast                CAMA-1   unknown
#> 5:        168 CL131873        HCC1428   Breast               HCC1428   unknown
#> 6:        168 CL131891         EFM-19   Breast                EFM-19   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      70
#> 3:                      60
#> 4:                      53
#> 5:                      74
#> 6:                      64
```

```
assayNames(tre)
#>  [1] "RawTreated"     "Controls"       "Normalized"     "Averaged"
#>  [5] "SmoothMatrix"   "BlissExcess"    "HSAExcess"      "all_iso_points"
#>  [9] "isobolograms"   "BlissScore"     "HSAScore"       "CIScore_50"
#> [13] "CIScore_80"     "Metrics"
```

```
head(assay(tre, "Metrics"),3)
#> Key: <treatmentid, sampleid>
#>                            treatmentid                                 sampleid
#>                                 <char>                                   <char>
#> 1: G02001876_Palbociclib_CDK4|CDK6_168   CL129757_MCF-7_Breast_MCF-7_unknown_30
#> 2: G02001876_Palbociclib_CDK4|CDK6_168 CL130218_BT-474_Breast_BT-474_unknown_70
#> 3: G02001876_Palbociclib_CDK4|CDK6_168   CL130742_T-47D_Breast_T-47D_unknown_60
#>       DrugName DrugName_2 DrugName_3 Duration   Gnumber Gnumber_2  drug_moa
#>         <char>     <char>     <char>    <num>    <char>    <char>    <char>
#> 1: Palbociclib       <NA>       <NA>      168 G02001876      <NA> CDK4|CDK6
#> 2: Palbociclib       <NA>       <NA>      168 G02001876      <NA> CDK4|CDK6
#> 3: Palbociclib       <NA>       <NA>      168 G02001876      <NA> CDK4|CDK6
#>    drug_moa_2 drug_moa_3 CellLineName ReferenceDivisionTime Tissue     clid
#>        <char>     <char>       <char>                 <num> <char>   <char>
#> 1:       <NA>       <NA>        MCF-7                    30 Breast CL129757
#> 2:       <NA>       <NA>       BT-474                    70 Breast CL130218
#> 3:       <NA>       <NA>        T-47D                    60 Breast CL130742
#>    parental_identifier subtype    data_type    x_mean     x_AOC x_AOC_range
#>                 <char>  <char>       <char>     <num>     <num>       <num>
#> 1:               MCF-7 unknown single-agent 0.4774514 0.5225486   0.5592516
#> 2:              BT-474 unknown single-agent 0.5916887 0.4083113   0.4338082
#> 3:               T-47D unknown single-agent 0.5478704 0.4521296   0.4876840
#>         xc50     x_max      ec50       x_inf   x_0         h        r2
#>        <num>     <num>     <num>       <num> <num>     <num>     <num>
#> 1: 0.1100133 -0.017025 0.1161741 -0.03117468     1 1.1100114 0.9880388
#> 2: 0.2091202  0.114275 0.1360264  0.16571556     1 0.9361851 0.9555750
#> 3: 0.1164343  0.111425 0.1033672  0.13053185     1 2.5415386 0.9815621
#>      x_sd_avg               fit_type maxlog10Concentration N_conc
#>         <num>                 <char>                 <num>  <int>
#> 1: 0.05887778 DRC3pHillFitModelFixS0                     1     10
#> 2: 0.08197778 DRC3pHillFitModelFixS0                     1     10
#> 3: 0.06581980 DRC3pHillFitModelFixS0                     1     10
#>    normalization_type fit_source cotrt_value source i.Gnumber  i.DrugName
#>                <char>     <char>       <num> <char>    <char>      <char>
#> 1:                 GR        gDR          NA   <NA> G02001876 Palbociclib
#> 2:                 GR        gDR          NA   <NA> G02001876 Palbociclib
#> 3:                 GR        gDR          NA   <NA> G02001876 Palbociclib
#>    i.drug_moa i.Gnumber_2 i.DrugName_2 i.drug_moa_2 i.DrugName_3 i.drug_moa_3
#>        <char>      <char>       <char>       <char>       <char>       <char>
#> 1:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 2:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#> 3:  CDK4|CDK6        <NA>         <NA>         <NA>         <NA>         <NA>
#>    i.Duration   i.clid i.CellLineName i.Tissue i.parental_identifier i.subtype
#>         <num>   <char>         <char>   <char>                <char>    <char>
#> 1:        168 CL129757          MCF-7   Breast                 MCF-7   unknown
#> 2:        168 CL130218         BT-474   Breast                BT-474   unknown
#> 3:        168 CL130742          T-47D   Breast                 T-47D   unknown
#>    i.ReferenceDivisionTime
#>                      <num>
#> 1:                      30
#> 2:                      70
#> 3:                      60
```

# References

1. Song, K. W., Edgar, K. A., Hanan, E. J., Hafner, M., Oeh, J., Merchant, M., … & Friedman, L. S. (2022). RTK-dependent inducible degradation of mutant PI3K drives GDC-0077 (Inavolisib) efficacy. Cancer discovery, 12(1), 204-219.

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] MultiAssayExperiment_1.36.1 gDRimport_1.8.1
#>  [3] PharmacoGx_3.14.0           CoreGx_2.14.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.1        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] bitops_1.0-9          rlang_1.1.6           magrittr_2.0.4
#>  [4] shinydashboard_0.7.3  otel_0.2.0            compiler_4.5.2
#>  [7] vctrs_0.6.5           reshape2_1.4.5        relations_0.6-15
#> [10] stringr_1.6.0         pkgconfig_2.0.3       crayon_1.5.3
#> [13] fastmap_1.2.0         backports_1.5.0       XVector_0.50.0
#> [16] caTools_1.18.3        promises_1.5.0        rmarkdown_2.30
#> [19] coop_0.6-3            xfun_0.54             cachem_1.1.0
#> [22] jsonlite_2.0.0        SnowballC_0.7.1       later_1.4.4
#> [25] DelayedArray_0.36.0   BiocParallel_1.44.0   parallel_4.5.2
#> [28] sets_1.0-25           cluster_2.1.8.1       R6_2.6.1
#> [31] bslib_0.9.0           stringi_1.8.7         RColorBrewer_1.1-3
#> [34] qs_0.27.3             limma_3.66.0          boot_1.3-32
#> [37] jquerylib_0.1.4       Rcpp_1.1.0            knitr_1.50
#> [40] downloader_0.4.1      BiocBaseUtils_1.12.0  httpuv_1.6.16
#> [43] Matrix_1.7-4          igraph_2.2.1          tidyselect_1.2.1
#> [46] dichromat_2.0-0.1     abind_1.4-8           yaml_2.3.11
#> [49] stringfish_0.17.0     gplots_3.3.0          codetools_0.2-20
#> [52] lattice_0.22-7        tibble_3.3.0          plyr_1.8.9
#> [55] shiny_1.12.0          BumpyMatrix_1.18.0    S7_0.2.1
#> [58] evaluate_1.0.5        RcppParallel_5.1.11-1 bench_1.1.4
#> [61] pillar_1.11.1         lsa_0.73.3            KernSmooth_2.23-26
#> [64] checkmate_2.3.3       DT_0.34.0             shinyjs_2.1.0
#> [67] piano_2.26.0          ggplot2_4.0.1         scales_1.4.0
#> [70] RApiSerialize_0.1.4   gtools_3.9.5          xtable_1.8-4
#> [73] marray_1.88.0         glue_1.8.0            slam_0.1-55
#> [76] tools_4.5.2           data.table_1.17.8     gDRutils_1.8.0
#> [79] fgsea_1.36.0          visNetwork_2.1.4      fastmatch_1.1-6
#> [82] cowplot_1.2.0         grid_4.5.2            cli_3.6.5
#> [85] S4Arrays_1.10.1       dplyr_1.1.4           gtable_0.3.6
#> [88] sass_0.4.10           digest_0.6.39         SparseArray_1.10.6
#> [91] htmlwidgets_1.6.4     farver_2.1.2          htmltools_0.5.9
#> [94] lifecycle_1.0.4       statmod_1.5.1         mime_0.13
```