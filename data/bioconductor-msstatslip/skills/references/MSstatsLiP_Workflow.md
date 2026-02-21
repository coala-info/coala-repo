# MSstatsLiP Workflow: An example workflow and analysis of the MSstatsLiP package

#### Devon Kohler (kohler.d@northeastern.edu)

#### 2025-10-30

## MSstatsLiP Workflow Vignette

This Vignette provides an example workflow for how to use the package MSstatsLiP.

**NOTE** This vignette uses a small portion of a bigger dataset, which may cause some plots to look different than they would with the full data.

## Installation

To install this package, start R (version “4.1”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstatsLiP")
```

```
library(MSstatsLiP)
library(tidyverse)
library(data.table)
```

## Workflow

### 1. Preprocessing

### 1.1 Raw Data Format

The first step is to load in the raw dataset for both the PTM and Protein datasets. This data can then be converted into MSstatsLiP format with one of the built in converters, or manually converted. In this case we use the converter for Spectronaut.

```
## Read in raw data files
head(LiPRawData)
#>    R.Condition    R.FileName R.Replicate PG.ProteinAccessions PG.ProteinGroups
#>         <char>        <char>      <char>               <char>           <char>
#> 1:        Osmo 180423_IP1742      Osmo_1               P14164           P14164
#> 2:        Osmo 180423_IP1742      Osmo_1               P14164           P14164
#> 3:        Osmo 180423_IP1742      Osmo_1               P14164           P14164
#> 4:        Osmo 180423_IP1742      Osmo_1               P14164           P14164
#> 5:        Osmo 180423_IP1742      Osmo_1               P14164           P14164
#> 6:        Osmo 180423_IP1742      Osmo_1               P14164           P14164
#>    PG.Quantity PEP.GroupingKey PEP.StrippedSequence PEP.Quantity
#>          <num>          <char>               <char>        <num>
#> 1:    105910.6         ILQNDLK              ILQNDLK     65116.91
#> 2:    105910.6         ILQNDLK              ILQNDLK     65116.91
#> 3:    105910.6         ILQNDLK              ILQNDLK     65116.91
#> 4:    105910.6         ILQNDLK              ILQNDLK     65116.91
#> 5:    105910.6         ILQNDLK              ILQNDLK     65116.91
#> 6:    105910.6         ILQNDLK              ILQNDLK     65116.91
#>    EG.iRTPredicted           EG.Library EG.ModifiedSequence EG.PrecursorId
#>              <num>               <char>              <char>         <char>
#> 1:       -9.285238 180517_Sc_Sent_O_all           _ILQNDLK_    _ILQNDLK_.2
#> 2:       -9.285238 180517_Sc_Sent_O_all           _ILQNDLK_    _ILQNDLK_.2
#> 3:       -9.285238 180517_Sc_Sent_O_all           _ILQNDLK_    _ILQNDLK_.2
#> 4:       -9.285238 180517_Sc_Sent_O_all           _ILQNDLK_    _ILQNDLK_.2
#> 5:       -9.285238 180517_Sc_Sent_O_all           _ILQNDLK_    _ILQNDLK_.2
#> 6:       -9.285238 180517_Sc_Sent_O_all           _ILQNDLK_    _ILQNDLK_.2
#>       EG.Qvalue FG.Charge       FG.Id FG.PrecMz FG.Quantity F.Charge F.FrgIon
#>           <num>     <num>      <char>     <num>       <num>    <num>   <char>
#> 1: 0.0001794077         2 _ILQNDLK_.2  422.2504    65116.91        1       y5
#> 2: 0.0001794077         2 _ILQNDLK_.2  422.2504    65116.91        1       y6
#> 3: 0.0001794077         2 _ILQNDLK_.2  422.2504    65116.91        1       y5
#> 4: 0.0001794077         2 _ILQNDLK_.2  422.2504    65116.91        1       y4
#> 5: 0.0001794077         2 _ILQNDLK_.2  422.2504    65116.91        1       y5
#> 6: 0.0001794077         2 _ILQNDLK_.2  422.2504    65116.91        1       y3
#>    F.FrgLossType  F.FrgMz F.FrgNum F.FrgType F.ExcludedFromQuantification
#>           <char>    <num>    <num>    <char>                       <lgcl>
#> 1:        noloss 617.3253        5         y                         TRUE
#> 2:        noloss 730.4094        6         y                        FALSE
#> 3:           NH3 600.2988        5         y                        FALSE
#> 4:        noloss 489.2667        4         y                        FALSE
#> 5:           H2O 599.3148        5         y                         TRUE
#> 6:        noloss 375.2238        3         y                         TRUE
#>    F.NormalizedPeakArea F.NormalizedPeakHeight F.PeakArea F.PeakHeight
#>                   <num>                  <num>      <num>        <num>
#> 1:             40994.32              275561.99   39189.54    263430.31
#> 2:             32552.17              267988.39   31119.05    256190.14
#> 3:             17712.62              124252.06   16932.82    118781.84
#> 4:             14852.12              101414.80   14198.25     96949.99
#> 5:             30117.24              257451.20   28791.32    246116.86
#> 6:             28752.17               69229.75   27486.35     66181.90
head(TrPRawData)
#>    R.Condition    R.FileName R.Replicate PG.ProteinAccessions PG.ProteinGroups
#>         <char>        <char>      <char>               <char>           <char>
#> 1:       OsmoT 180423_IP1739     OsmoT_1               P14164           P14164
#> 2:       OsmoT 180423_IP1739     OsmoT_1               P14164           P14164
#> 3:       OsmoT 180423_IP1739     OsmoT_1               P14164           P14164
#> 4:       OsmoT 180423_IP1739     OsmoT_1               P14164           P14164
#> 5:       OsmoT 180423_IP1739     OsmoT_1               P14164           P14164
#> 6:       OsmoT 180423_IP1739     OsmoT_1               P16622           P16622
#>    PG.Quantity    PEP.GroupingKey PEP.StrippedSequence PEP.Quantity
#>          <num>             <char>               <char>        <num>
#> 1:    159438.5 GLDDESGPTHGNDSGNHR   GLDDESGPTHGNDSGNHR     58285.34
#> 2:    159438.5 GLDDESGPTHGNDSGNHR   GLDDESGPTHGNDSGNHR     58285.34
#> 3:    159438.5 GLDDESGPTHGNDSGNHR   GLDDESGPTHGNDSGNHR     58285.34
#> 4:    159438.5 GLDDESGPTHGNDSGNHR   GLDDESGPTHGNDSGNHR     58285.34
#> 5:    159438.5 GLDDESGPTHGNDSGNHR   GLDDESGPTHGNDSGNHR     58285.34
#> 6:    254877.6         EIGGGSPIRK           EIGGGSPIRK     53057.78
#>    EG.iRTPredicted             EG.Library  EG.ModifiedSequence
#>              <num>                 <char>               <char>
#> 1:       -39.34548 180516_Sc_Sent_O_mixed _GLDDESGPTHGNDSGNHR_
#> 2:       -39.34548 180516_Sc_Sent_O_mixed _GLDDESGPTHGNDSGNHR_
#> 3:       -39.34548 180516_Sc_Sent_O_mixed _GLDDESGPTHGNDSGNHR_
#> 4:       -39.34548 180516_Sc_Sent_O_mixed _GLDDESGPTHGNDSGNHR_
#> 5:       -39.34548 180516_Sc_Sent_O_mixed _GLDDESGPTHGNDSGNHR_
#> 6:       -26.57706 180516_Sc_Sent_O_mixed         _EIGGGSPIRK_
#>            EG.PrecursorId            EG.Qvalue FG.Charge                  FG.Id
#>                    <char>               <char>     <num>                 <char>
#> 1: _GLDDESGPTHGNDSGNHR_.4  0.00616306309215817         4 _GLDDESGPTHGNDSGNHR_.4
#> 2: _GLDDESGPTHGNDSGNHR_.4  0.00616306309215817         4 _GLDDESGPTHGNDSGNHR_.4
#> 3: _GLDDESGPTHGNDSGNHR_.4  0.00616306309215817         4 _GLDDESGPTHGNDSGNHR_.4
#> 4: _GLDDESGPTHGNDSGNHR_.4  0.00616306309215817         4 _GLDDESGPTHGNDSGNHR_.4
#> 5: _GLDDESGPTHGNDSGNHR_.4  0.00616306309215817         4 _GLDDESGPTHGNDSGNHR_.4
#> 6:         _EIGGGSPIRK_.2 0.000802627490914289         2         _EIGGGSPIRK_.2
#>    FG.PrecMz FG.Quantity F.Charge F.FrgIon F.FrgLossType  F.FrgMz F.FrgNum
#>        <num>       <num>    <num>   <char>        <char>    <num>    <num>
#> 1:  466.9506    58285.34        2      y13        noloss 668.2928       13
#> 2:  466.9506    58285.34        1       y5        noloss 570.2743        5
#> 3:  466.9506    58285.34        2      y12        noloss 624.7769       12
#> 4:  466.9506    58285.34        2       y9        noloss 497.2159        9
#> 5:  466.9506    58285.34        2      y11        noloss 596.2661       11
#> 6:  507.2906    53057.78        1       y8        noloss 771.4471        8
#>    F.FrgType F.ExcludedFromQuantification F.NormalizedPeakArea
#>       <char>                       <lgcl>                <num>
#> 1:         y                        FALSE           31132.0269
#> 2:         y                         TRUE            1120.1924
#> 3:         y                        FALSE             804.3179
#> 4:         y                        FALSE           26348.9965
#> 5:         y                         TRUE             195.7826
#> 6:         y                        FALSE           38764.9840
#>    F.NormalizedPeakHeight F.PeakArea F.PeakHeight
#>                     <num>      <num>        <num>
#> 1:               178334.5 29018.9570 1.662301e+05
#> 2:                    1.0  1044.1599 3.929213e-01
#> 3:                    1.0   749.7252 7.420349e-01
#> 4:               209829.8 24560.5723 1.955877e+05
#> 5:                    1.0   182.4940 4.759888e-01
#> 6:               119907.3 35223.5391 1.089530e+05
```

### 1.2 Converter

```
## Run converter
MSstatsLiP_data <- SpectronauttoMSstatsLiPFormat(LiPRawData,
                                      "../inst/extdata/ExampleFastaFile.fasta",
                                      TrPRawData, use_log_file = FALSE,
                                      append = FALSE)
#> INFO  [2025-10-30 01:19:33] ** Raw data from Spectronaut imported successfully.
#> INFO  [2025-10-30 01:19:33] ** Raw data from Spectronaut cleaned successfully.
#> INFO  [2025-10-30 01:19:33] ** Using annotation extracted from quantification data.
#> INFO  [2025-10-30 01:19:33] ** Run labels were standardized to remove symbols such as '.' or '%'.
#> INFO  [2025-10-30 01:19:33] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements across runs will be removed.
#> INFO  [2025-10-30 01:19:33] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
#> WARN  [2025-10-30 01:19:33] ** PGQvalue not found in input columns.
#> INFO  [2025-10-30 01:19:33] ** Intensities with values not smaller than 0.01 in EGQvalue are replaced with NA
#> INFO  [2025-10-30 01:19:33] ** Features with all missing measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:33] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
#> INFO  [2025-10-30 01:19:33] ** Features with one or two measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Run annotation merged with quantification data.
#> INFO  [2025-10-30 01:19:33] ** Features with one or two measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:33] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:33] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
#> INFO  [2025-10-30 01:19:33] ** Raw data from Spectronaut imported successfully.
#> INFO  [2025-10-30 01:19:33] ** Raw data from Spectronaut cleaned successfully.
#> INFO  [2025-10-30 01:19:33] ** Using annotation extracted from quantification data.
#> INFO  [2025-10-30 01:19:33] ** Run labels were standardized to remove symbols such as '.' or '%'.
#> INFO  [2025-10-30 01:19:33] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements across runs will be removed.
#> INFO  [2025-10-30 01:19:33] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
#> WARN  [2025-10-30 01:19:33] ** PGQvalue not found in input columns.
#> INFO  [2025-10-30 01:19:33] ** Intensities with values not smaller than 0.01 in EGQvalue are replaced with NA
#> INFO  [2025-10-30 01:19:33] ** Features with all missing measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:33] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
#> INFO  [2025-10-30 01:19:33] ** Features with one or two measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Run annotation merged with quantification data.
#> INFO  [2025-10-30 01:19:33] ** Features with one or two measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:33] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:33] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.

head(MSstatsLiP_data[["LiP"]])
#> Key: <ProteinName, PeptideSequence>
#>    ProteinName PeptideSequence PrecursorCharge FragmentIon ProductCharge
#>         <char>          <char>          <char>      <char>        <char>
#> 1:      P14164         ILQNDLK               2          y4             1
#> 2:      P14164         ILQNDLK               2          y4             1
#> 3:      P14164         ILQNDLK               2          y4             1
#> 4:      P14164         ILQNDLK               2          y4             1
#> 5:      P14164         ILQNDLK               2          y4             1
#> 6:      P14164         ILQNDLK               2          y4             1
#>    IsotopeLabelType Condition BioReplicate           Run Fraction    Intensity
#>              <char>    <char>       <char>        <char>   <char>       <char>
#> 1:                L      Osmo       Osmo_1 180423_IP1742        1 1.419825e+04
#> 2:                L      Osmo       Osmo_2 180423_IP1743        1 1.053235e+04
#> 3:                L      Osmo       Osmo_3 180423_IP1744        1 1.232257e+04
#> 4:                L   Control    Control_1 180423_IP1748        1 1.034930e+04
#> 5:                L   Control    Control_2 180423_IP1749        1 2.396684e+04
#> 6:                L   Control    Control_3 180423_IP1750        1 9.265785e+03
#>      FULL_PEPTIDE
#>            <char>
#> 1: P14164_ILQNDLK
#> 2: P14164_ILQNDLK
#> 3: P14164_ILQNDLK
#> 4: P14164_ILQNDLK
#> 5: P14164_ILQNDLK
#> 6: P14164_ILQNDLK
head(MSstatsLiP_data[["TrP"]])
#> Key: <ProteinName>
#>    ProteinName    PeptideSequence PrecursorCharge FragmentIon ProductCharge
#>         <char>             <char>          <char>      <char>        <char>
#> 1:      P14164 GLDDESGPTHGNDSGNHR               4         y12             2
#> 2:      P14164 GLDDESGPTHGNDSGNHR               4         y12             2
#> 3:      P14164 GLDDESGPTHGNDSGNHR               4         y12             2
#> 4:      P14164 GLDDESGPTHGNDSGNHR               4         y12             2
#> 5:      P14164 GLDDESGPTHGNDSGNHR               4         y12             2
#> 6:      P14164 GLDDESGPTHGNDSGNHR               4         y12             2
#>    IsotopeLabelType Condition BioReplicate             Run Fraction
#>              <char>    <char>       <char>          <char>   <char>
#> 1:                L     OsmoT      OsmoT_1   180423_IP1739        1
#> 2:                L     OsmoT      OsmoT_2 180423_IP1740_2        1
#> 3:                L     OsmoT      OsmoT_3 180423_IP1741_2        1
#> 4:                L     CtrlT      CtrlT_1   180423_IP1745        1
#> 5:                L     CtrlT      CtrlT_2   180423_IP1746        1
#> 6:                L     CtrlT      CtrlT_3   180423_IP1747        1
#>       Intensity
#>          <char>
#> 1: 7.497252e+02
#> 2:         <NA>
#> 3: 3.105397e+03
#> 4: 3.712693e+03
#> 5: 4.353941e+03
#> 6: 4.617424e+03

## Make conditions match
MSstatsLiP_data[["LiP"]][MSstatsLiP_data[["LiP"]]$Condition == "Control",
                         "Condition"] = "Ctrl"
MSstatsLiP_data[["TrP"]]$Condition = substr(MSstatsLiP_data[["TrP"]]$Condition,
  1, nchar(MSstatsLiP_data[["TrP"]]$Condition)-1)
```

In the case above the SpectronauttoMSstatsLiPFormat was ran to convert the data into the format required for MSstatsLiP. Note that the condition names did not match between the LiP and TrP datasets. Here we edit the conditions in each dataset to match.

Additionally, it is important that the column “FULL\_PEPTIDE” in the LiP dataset contains both the Protein and Peptide information, seperated by an underscore. This allows us to summarize up to the peptide level, while keeping important information about which protein the peptide corresponds to.

### 2. Summarization

The next step in the MSstatsLiP workflow is to summarize feature intensities per run into one value using the dataSummarizationLiP function. This function takes as input the formatted data from the converter.

#### 2.1 Summarization Function

```
MSstatsLiP_Summarized <- dataSummarizationLiP(MSstatsLiP_data,
                                              MBimpute = FALSE,
                                              use_log_file = FALSE,
                                              append = FALSE)
#> Starting PTM summarization...
#> INFO  [2025-10-30 01:19:33] ** Features with one or two measurements across runs are removed.
#> INFO  [2025-10-30 01:19:33] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:33] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:33] ** Use all features that the dataset originally has.
#> INFO  [2025-10-30 01:19:33]
#>  # proteins: 14
#>  # peptides per protein: 1-2
#>  # features per peptide: 2-4
#> INFO  [2025-10-30 01:19:33]
#>                     Ctrl Osmo
#>              # runs    3    3
#>     # bioreplicates    3    3
#>  # tech. replicates    1    1
#> INFO  [2025-10-30 01:19:33]  == Start the summarization per subplot...
#>   |                                                                              |                                                                      |   0%  |                                                                              |=====                                                                 |   7%  |                                                                              |==========                                                            |  14%  |                                                                              |===============                                                       |  21%  |                                                                              |====================                                                  |  29%  |                                                                              |=========================                                             |  36%  |                                                                              |==============================                                        |  43%  |                                                                              |===================================                                   |  50%  |                                                                              |========================================                              |  57%  |                                                                              |=============================================                         |  64%  |                                                                              |==================================================                    |  71%  |                                                                              |=======================================================               |  79%  |                                                                              |============================================================          |  86%  |                                                                              |=================================================================     |  93%  |                                                                              |======================================================================| 100%
#> INFO  [2025-10-30 01:19:34]  == Summarization is done.
#> Starting Protein summarization...
#> INFO  [2025-10-30 01:19:34] ** Features with one or two measurements across runs are removed.
#> INFO  [2025-10-30 01:19:34] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:34] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:34] ** Use all features that the dataset originally has.
#> INFO  [2025-10-30 01:19:34]
#>  # proteins: 13
#>  # peptides per protein: 1-4
#>  # features per peptide: 2-4
#> INFO  [2025-10-30 01:19:34]
#>                     Ctrl Osmo
#>              # runs    3    3
#>     # bioreplicates    3    3
#>  # tech. replicates    1    1
#> INFO  [2025-10-30 01:19:34] Some features are completely missing in at least one condition:
#>  AGGAYKPPHAR_3_y10_2,
#>  AGGAYKPPHAR_3_y4_1,
#>  AGGAYKPPHAR_3_y5_1,
#>  DNFLSLDYEAPSPAFSK_2_b3_1,
#>  DNFLSLDYEAPSPAFSK_2_y5_1 ...
#> INFO  [2025-10-30 01:19:34]  == Start the summarization per subplot...
#>   |                                                                              |                                                                      |   0%  |                                                                              |=====                                                                 |   8%  |                                                                              |===========                                                           |  15%  |                                                                              |================                                                      |  23%  |                                                                              |======================                                                |  31%  |                                                                              |===========================                                           |  38%  |                                                                              |================================                                      |  46%  |                                                                              |======================================                                |  54%  |                                                                              |===========================================                           |  62%  |                                                                              |================================================                      |  69%  |                                                                              |======================================================                |  77%  |                                                                              |===========================================================           |  85%  |                                                                              |=================================================================     |  92%  |                                                                              |======================================================================| 100%
#> INFO  [2025-10-30 01:19:34]  == Summarization is done.
names(MSstatsLiP_Summarized[["LiP"]])
#> [1] "FeatureLevelData"  "ProteinLevelData"  "SummaryMethod"
#> [4] "ModelQC"           "PredictBySurvival"

lip_protein_data <- MSstatsLiP_Summarized[["LiP"]]$ProteinLevelData
trp_protein_data <- MSstatsLiP_Summarized[["TrP"]]$ProteinLevelData

head(lip_protein_data)
#> Key: <FULL_PEPTIDE>
#>      FULL_PEPTIDE    RUN LogIntensities   originalRUN  GROUP   SUBJECT
#>            <char> <fctr>          <num>        <fctr> <fctr>    <char>
#> 1: P14164_ILQNDLK      1       15.67592 180423_IP1748   Ctrl Control_1
#> 2: P14164_ILQNDLK      2       15.71415 180423_IP1749   Ctrl Control_2
#> 3: P14164_ILQNDLK      3       15.50261 180423_IP1750   Ctrl Control_3
#> 4: P14164_ILQNDLK      4       14.35382 180423_IP1742   Osmo    Osmo_1
#> 5: P14164_ILQNDLK      5       14.98971 180423_IP1743   Osmo    Osmo_2
#> 6: P14164_ILQNDLK      6       14.36873 180423_IP1744   Osmo    Osmo_3
#>    TotalGroupMeasurements NumMeasuredFeature MissingPercentage more50missing
#>                     <int>              <int>             <num>        <lgcl>
#> 1:                      6                  2                 0         FALSE
#> 2:                      6                  2                 0         FALSE
#> 3:                      6                  2                 0         FALSE
#> 4:                      6                  2                 0         FALSE
#> 5:                      6                  2                 0         FALSE
#> 6:                      6                  2                 0         FALSE
#>    NumImputedFeature Protein
#>                <num>  <char>
#> 1:                 0  P14164
#> 2:                 0  P14164
#> 3:                 0  P14164
#> 4:                 0  P14164
#> 5:                 0  P14164
#> 6:                 0  P14164
head(trp_protein_data)
#>   RUN Protein LogIntensities     originalRUN GROUP SUBJECT
#> 1   1  P14164       12.20158   180423_IP1745  Ctrl CtrlT_1
#> 2   2  P14164       12.00412   180423_IP1746  Ctrl CtrlT_2
#> 3   3  P14164       12.34676   180423_IP1747  Ctrl CtrlT_3
#> 4   4  P14164       11.58219   180423_IP1739  Osmo OsmoT_1
#> 5   6  P14164       11.78048 180423_IP1741_2  Osmo OsmoT_3
#> 6   3  P16622       12.85950   180423_IP1747  Ctrl CtrlT_3
#>   TotalGroupMeasurements NumMeasuredFeature MissingPercentage more50missing
#> 1                     15                  5               0.0         FALSE
#> 2                     15                  5               0.0         FALSE
#> 3                     15                  5               0.0         FALSE
#> 4                     15                  3               0.4         FALSE
#> 5                     15                  3               0.4         FALSE
#> 6                      9                  3               0.0         FALSE
#>   NumImputedFeature
#> 1                 0
#> 2                 0
#> 3                 0
#> 4                 0
#> 5                 0
#> 6                 0
```

Again the summarization function returns a list of two dataframes one each for LiP and TrP. Each LiP and TrP is also a list with additional summary information. This summarized data can be used as input into some of the plotting functions included in the package.

#### 2.2 Tryptic barplot

MSstatsLiP has a wide variety of plotting functionality to analysis and assess the results of experiments. Here we plot the number of half vs fully tryptic peptides per replicate.

```
trypticHistogramLiP(MSstatsLiP_Summarized,
                    "../inst/extdata/ExampleFastaFile.fasta",
                    color_scale = "bright",
                    address = FALSE)
```

![](data:image/png;base64...)

#### 2.3 Run Correlation Plot

MSstatsLiP also provides a function to plot run correlation.

```
correlationPlotLiP(MSstatsLiP_Summarized, address = FALSE)
```

![](data:image/png;base64...)

#### 2.4 Coefficient of Variation

Here we provide a simple script to examine the coefficient of variance between conditions

```
MSstatsLiP_Summarized[["LiP"]]$FeatureLevelData %>%
  group_by(FEATURE, GROUP) %>%
  summarize(cv = sd(INTENSITY) / mean(INTENSITY)) %>%
  ggplot() + geom_violin(aes(x = GROUP, y = cv, fill = GROUP)) +
  labs(title = "Coefficient of Variation between Condtions",
       y = "Coefficient of Variation", x = "Conditon")
#> `summarise()` has grouped output by 'FEATURE'. You can override using the
#> `.groups` argument.
#> Warning: Removed 30 rows containing non-finite outside the scale range
#> (`stat_ydensity()`).
```

![](data:image/png;base64...)

#### 2.5 QCPlot

The following plots are used to view the summarized data and check for potential systemic issues.

```
## Quality Control Plot
dataProcessPlotsLiP(MSstatsLiP_Summarized,
                    type = 'QCPLOT',
                    which.Peptide = "allonly",
                    address = FALSE)
```

![](data:image/png;base64...)

```
#> Drew the Quality Contol plot(boxplot) for all ptms/proteins.
```

#### 2.6 Profile Plot

```
dataProcessPlotsLiP(MSstatsLiP_Summarized,
                    type = 'ProfilePlot',
                    which.Peptide = c("P14164_ILQNDLK"),
                    address = FALSE)
```

![](data:image/png;base64...)

```
#> Drew the Profile plot for P14164_ILQNDLK (1 of 1)
```

![](data:image/png;base64...)

```
#> Drew the Profile plot for  P14164_ILQNDLK ( 1  of  1 )
```

#### 2.7 PCA Plot

In addition, Priciple Component Analysis can also be done on the summarized dataset. Three different PCA plots can be created one each for: Percent of explained variance per component, PC1 vs PC2 for peptides, and PC1 vs PC2 for conditions.

```
PCAPlotLiP(MSstatsLiP_Summarized,
           bar.plot = FALSE,
           protein.pca = FALSE,
           comparison.pca = TRUE,
           which.comparison = c("Ctrl", "Osmo"),
           address=FALSE)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the factoextra package.
#>   Please report the issue at <https://github.com/kassambara/factoextra/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the factoextra package.
#>   Please report the issue at <https://github.com/kassambara/factoextra/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

```
PCAPlotLiP(MSstatsLiP_Summarized,
           bar.plot = FALSE,
           protein.pca = TRUE,
           comparison.pca = FALSE,
           which.pep = c("P14164_ILQNDLK", "P17891_ALQLINQDDADIIGGRDR"),
           address=FALSE)
```

![](data:image/png;base64...)

#### 2.8 Calculate Trypticity

Finally, the trypticity of a peptide can also be calculated and added to any dataframe with the ProteinName and PeptideSequence column.

```
feature_data <- data.table::copy(MSstatsLiP_Summarized$LiP$FeatureLevelData)
data.table::setnames(feature_data, c("PEPTIDE", "PROTEIN"),
                     c("PeptideSequence", "ProteinName"))
feature_data$PeptideSequence <- substr(feature_data$PeptideSequence, 1,
                                       nchar(as.character(
                                         feature_data$PeptideSequence)) - 2)

calculateTrypticity(feature_data, "../inst/extdata/ExampleFastaFile.fasta")
#> Key: <ProteinName>
#>     ProteinName       PeptideSequence fully_TRI NSEMI_TRI CSEMI_TRI CTERMINUS
#>          <char>                <char>    <lgcl>    <lgcl>    <lgcl>    <lgcl>
#>  1:      P14164               ILQNDLK      TRUE     FALSE     FALSE     FALSE
#>  2:      P16622 SHLQSNQLYSNQLPLDFALGK      TRUE     FALSE     FALSE     FALSE
#>  3:      P17891    ALQLINQDDADIIGGRDR      TRUE     FALSE     FALSE     FALSE
#>  4:      P17891              DDDTDFLK      TRUE     FALSE     FALSE     FALSE
#>  5:      P24004            FIGASEQNIR      TRUE     FALSE     FALSE     FALSE
#>  6:      P36112       SNDLLSGLTGSSQTR      TRUE     FALSE     FALSE     FALSE
#>  7:      P38805               LGQTVGR      TRUE     FALSE     FALSE     FALSE
#>  8:      P46959        DIIGKPYGSQIAIR      TRUE     FALSE     FALSE     FALSE
#>  9:      P52893           SSSQGVEGIRK     FALSE     FALSE      TRUE     FALSE
#> 10:      P52911          TWITEDDFEQIK      TRUE     FALSE     FALSE     FALSE
#> 11:      P53235      ERQAVGDKLEDTQVLK      TRUE     FALSE     FALSE     FALSE
#> 12:      P53858       FLDNHEVDSIVSLER      TRUE     FALSE     FALSE     FALSE
#> 13:      Q02908            ISVISGVGVR      TRUE     FALSE     FALSE     FALSE
#> 14:      Q12248            EFQSVSDLWK      TRUE     FALSE     FALSE     FALSE
#>     NTERMINUS MissedCleavage StartPos EndPos
#>        <lgcl>         <lgcl>    <num>  <num>
#>  1:     FALSE          FALSE      358    365
#>  2:     FALSE          FALSE      354    375
#>  3:     FALSE           TRUE      196    214
#>  4:     FALSE          FALSE       21     29
#>  5:     FALSE          FALSE      770    780
#>  6:     FALSE          FALSE      102    117
#>  7:     FALSE          FALSE      205    212
#>  8:     FALSE          FALSE       49     63
#>  9:     FALSE           TRUE      221    232
#> 10:     FALSE          FALSE      117    129
#> 11:     FALSE           TRUE      607    623
#> 12:     FALSE          FALSE      491    506
#> 13:     FALSE          FALSE      528    538
#> 14:     FALSE          FALSE       57     67

MSstatsLiP_Summarized$LiP$FeatureLevelData%>%
  rename(PeptideSequence=PEPTIDE, ProteinName=PROTEIN)%>%
  mutate(PeptideSequence=substr(PeptideSequence, 1,
                                nchar(as.character(PeptideSequence))-2)
         ) %>% calculateTrypticity("../inst/extdata/ExampleFastaFile.fasta")
#> Key: <ProteinName>
#>     ProteinName       PeptideSequence fully_TRI NSEMI_TRI CSEMI_TRI CTERMINUS
#>          <char>                <char>    <lgcl>    <lgcl>    <lgcl>    <lgcl>
#>  1:      P14164               ILQNDLK      TRUE     FALSE     FALSE     FALSE
#>  2:      P16622 SHLQSNQLYSNQLPLDFALGK      TRUE     FALSE     FALSE     FALSE
#>  3:      P17891    ALQLINQDDADIIGGRDR      TRUE     FALSE     FALSE     FALSE
#>  4:      P17891              DDDTDFLK      TRUE     FALSE     FALSE     FALSE
#>  5:      P24004            FIGASEQNIR      TRUE     FALSE     FALSE     FALSE
#>  6:      P36112       SNDLLSGLTGSSQTR      TRUE     FALSE     FALSE     FALSE
#>  7:      P38805               LGQTVGR      TRUE     FALSE     FALSE     FALSE
#>  8:      P46959        DIIGKPYGSQIAIR      TRUE     FALSE     FALSE     FALSE
#>  9:      P52893           SSSQGVEGIRK     FALSE     FALSE      TRUE     FALSE
#> 10:      P52911          TWITEDDFEQIK      TRUE     FALSE     FALSE     FALSE
#> 11:      P53235      ERQAVGDKLEDTQVLK      TRUE     FALSE     FALSE     FALSE
#> 12:      P53858       FLDNHEVDSIVSLER      TRUE     FALSE     FALSE     FALSE
#> 13:      Q02908            ISVISGVGVR      TRUE     FALSE     FALSE     FALSE
#> 14:      Q12248            EFQSVSDLWK      TRUE     FALSE     FALSE     FALSE
#>     NTERMINUS MissedCleavage StartPos EndPos
#>        <lgcl>         <lgcl>    <num>  <num>
#>  1:     FALSE          FALSE      358    365
#>  2:     FALSE          FALSE      354    375
#>  3:     FALSE           TRUE      196    214
#>  4:     FALSE          FALSE       21     29
#>  5:     FALSE          FALSE      770    780
#>  6:     FALSE          FALSE      102    117
#>  7:     FALSE          FALSE      205    212
#>  8:     FALSE          FALSE       49     63
#>  9:     FALSE           TRUE      221    232
#> 10:     FALSE          FALSE      117    129
#> 11:     FALSE           TRUE      607    623
#> 12:     FALSE          FALSE      491    506
#> 13:     FALSE          FALSE      528    538
#> 14:     FALSE          FALSE       57     67
```

### 3. Modeling

The modeling function groupComparisonLiP takes as input the output of the summarization function dataSummarizationLiP.

#### 3.1 Function

```
MSstatsLiP_model <- groupComparisonLiP(MSstatsLiP_Summarized,
                               fasta = "../inst/extdata/ExampleFastaFile.fasta",
                               use_log_file = FALSE,
                               append = FALSE)
#> Starting PTM modeling...
#> INFO  [2025-10-30 01:19:41]  == Start to test and get inference in whole plot ...
#>   |                                                                              |                                                                      |   0%  |                                                                              |=====                                                                 |   7%  |                                                                              |==========                                                            |  14%  |                                                                              |===============                                                       |  21%  |                                                                              |====================                                                  |  29%  |                                                                              |=========================                                             |  36%  |                                                                              |==============================                                        |  43%  |                                                                              |===================================                                   |  50%  |                                                                              |========================================                              |  57%  |                                                                              |=============================================                         |  64%  |                                                                              |==================================================                    |  71%  |                                                                              |=======================================================               |  79%  |                                                                              |============================================================          |  86%  |                                                                              |=================================================================     |  93%  |                                                                              |======================================================================| 100%
#> INFO  [2025-10-30 01:19:41]  == Comparisons for all proteins are done.
#> Starting Protein modeling...
#> INFO  [2025-10-30 01:19:41]  == Start to test and get inference in whole plot ...
#>   |                                                                              |                                                                      |   0%  |                                                                              |=====                                                                 |   8%  |                                                                              |===========                                                           |  15%  |                                                                              |================                                                      |  23%  |                                                                              |======================                                                |  31%  |                                                                              |===========================                                           |  38%  |                                                                              |================================                                      |  46%  |                                                                              |======================================                                |  54%  |                                                                              |===========================================                           |  62%  |                                                                              |================================================                      |  69%  |                                                                              |======================================================                |  77%  |                                                                              |===========================================================           |  85%  |                                                                              |=================================================================     |  92%  |                                                                              |======================================================================| 100%
#> INFO  [2025-10-30 01:19:41]  == Comparisons for all proteins are done.
#> Starting adjustment...

lip_model <- MSstatsLiP_model[["LiP.Model"]]
trp_model <- MSstatsLiP_model[["TrP.Model"]]
adj_lip_model <- MSstatsLiP_model[["Adjusted.LiP.Model"]]

head(lip_model)
#> Key: <ProteinName, PeptideSequence>
#>    ProteinName       PeptideSequence                 FULL_PEPTIDE        Label
#>         <char>                <char>                       <char>       <char>
#> 1:      P14164               ILQNDLK               P14164_ILQNDLK Ctrl vs Osmo
#> 2:      P16622 SHLQSNQLYSNQLPLDFALGK P16622_SHLQSNQLYSNQLPLDFALGK Ctrl vs Osmo
#> 3:      P17891    ALQLINQDDADIIGGRDR    P17891_ALQLINQDDADIIGGRDR Ctrl vs Osmo
#> 4:      P17891              DDDTDFLK              P17891_DDDTDFLK Ctrl vs Osmo
#> 5:      P24004            FIGASEQNIR            P24004_FIGASEQNIR Ctrl vs Osmo
#> 6:      P36112       SNDLLSGLTGSSQTR       P36112_SNDLLSGLTGSSQTR Ctrl vs Osmo
#>        log2FC          SE      Tvalue    DF      pvalue adj.pvalue  issue
#>         <num>       <num>       <num> <int>       <num>      <num> <lgcl>
#> 1:  1.0601391 0.219397767   4.8320413     4 0.008448744 0.03942747     NA
#> 2:  0.1655540 0.277961791   0.5955998     3 0.593383886 0.71358286     NA
#> 3:  0.5436687 0.296272579   1.8350288     4 0.140405767 0.28081153     NA
#> 4: -0.3294106 0.173801944  -1.8953216     4 0.130943731 0.28081153     NA
#> 5:  1.7019345 0.006157026 276.4215332     1 0.002303066 0.03224292     NA
#> 6: -0.1584000 0.601777383  -0.2632203     1 0.836145500 0.85751951     NA
#>    MissingPercentage ImputationPercentage fully_TRI NSEMI_TRI CSEMI_TRI
#>                <num>                <num>    <lgcl>    <lgcl>    <lgcl>
#> 1:         0.0000000                    0      TRUE     FALSE     FALSE
#> 2:         0.1666667                    0      TRUE     FALSE     FALSE
#> 3:         0.0000000                    0      TRUE     FALSE     FALSE
#> 4:         0.0000000                    0      TRUE     FALSE     FALSE
#> 5:         0.5000000                    0      TRUE     FALSE     FALSE
#> 6:         0.5000000                    0      TRUE     FALSE     FALSE
#>    CTERMINUS NTERMINUS MissedCleavage StartPos EndPos
#>       <lgcl>    <lgcl>         <lgcl>    <num>  <num>
#> 1:     FALSE     FALSE          FALSE      358    365
#> 2:     FALSE     FALSE          FALSE      354    375
#> 3:     FALSE     FALSE           TRUE      196    214
#> 4:     FALSE     FALSE          FALSE       21     29
#> 5:     FALSE     FALSE          FALSE      770    780
#> 6:     FALSE     FALSE          FALSE      102    117
head(trp_model)
#>    Protein        Label      log2FC         SE    Tvalue    DF     pvalue
#>     <fctr>       <char>       <num>      <num>     <num> <int>      <num>
#> 1:  P14164 Ctrl vs Osmo  0.50281634 0.14796419  3.398230     3 0.04251661
#> 2:  P16622 Ctrl vs Osmo -0.48689817 0.38376886 -1.268728     1 0.42494298
#> 3:  P17891 Ctrl vs Osmo  1.15384384 0.52228878  2.209207     4 0.09170709
#> 4:  P24004 Ctrl vs Osmo -0.09463078 0.03735157 -2.533516     1 0.23932853
#> 5:  P36112 Ctrl vs Osmo -0.85301975 0.23381706 -3.648236     4 0.02180540
#> 6:  P38805 Ctrl vs Osmo  0.40570919 0.25707606  1.578168     4 0.18966680
#>    adj.pvalue  issue MissingPercentage ImputationPercentage
#>         <num> <lgcl>             <num>                <num>
#> 1: 0.09211932     NA         0.3000000                    0
#> 2: 0.48236810     NA         0.5000000                    0
#> 3: 0.17031317     NA         0.3194444                    0
#> 4: 0.34569677     NA         0.5000000                    0
#> 5: 0.06993334     NA         0.4393939                    0
#> 6: 0.30820855     NA         0.2500000                    0
head(adj_lip_model)
#> Key: <FULL_PEPTIDE, Label>
#>                    FULL_PEPTIDE        Label ProteinName       PeptideSequence
#>                          <char>       <char>      <char>                <char>
#> 1:               P14164_ILQNDLK Ctrl vs Osmo      P14164               ILQNDLK
#> 2: P16622_SHLQSNQLYSNQLPLDFALGK Ctrl vs Osmo      P16622 SHLQSNQLYSNQLPLDFALGK
#> 3:    P17891_ALQLINQDDADIIGGRDR Ctrl vs Osmo      P17891    ALQLINQDDADIIGGRDR
#> 4:              P17891_DDDTDFLK Ctrl vs Osmo      P17891              DDDTDFLK
#> 5:            P24004_FIGASEQNIR Ctrl vs Osmo      P24004            FIGASEQNIR
#> 6:       P36112_SNDLLSGLTGSSQTR Ctrl vs Osmo      P36112       SNDLLSGLTGSSQTR
#>        log2FC         SE    Tvalue       DF     pvalue adj.pvalue Adjusted
#>         <num>      <num>     <num>    <num>      <num>      <num>   <lgcl>
#> 1:  0.5573227 0.26462952  2.106049 6.635790 0.07538247 0.15076494     TRUE
#> 2:  0.6524522 0.47385789  1.376894 2.129099 0.29543338 0.51700842     TRUE
#> 3: -0.6101751 0.60046899 -1.016164 6.332717 0.34679119 0.53945296     TRUE
#> 4: -1.4832544 0.55044772 -2.694633 4.875155 0.04419616 0.12374924     TRUE
#> 5:  1.7965653 0.03785563 47.458342 1.054304 0.01100135 0.04872612     TRUE
#> 6:  0.6946197 0.64560548  1.075920 1.317219 0.44032063 0.54772318     TRUE
#>    fully_TRI NSEMI_TRI CSEMI_TRI CTERMINUS NTERMINUS MissedCleavage StartPos
#>       <lgcl>    <lgcl>    <lgcl>    <lgcl>    <lgcl>         <lgcl>    <num>
#> 1:      TRUE     FALSE     FALSE     FALSE     FALSE          FALSE      358
#> 2:      TRUE     FALSE     FALSE     FALSE     FALSE          FALSE      354
#> 3:      TRUE     FALSE     FALSE     FALSE     FALSE           TRUE      196
#> 4:      TRUE     FALSE     FALSE     FALSE     FALSE          FALSE       21
#> 5:      TRUE     FALSE     FALSE     FALSE     FALSE          FALSE      770
#> 6:      TRUE     FALSE     FALSE     FALSE     FALSE          FALSE      102
#>    EndPos  issue
#>     <num> <lgcl>
#> 1:    365     NA
#> 2:    375     NA
#> 3:    214     NA
#> 4:     29     NA
#> 5:    780     NA
#> 6:    117     NA

## Number of significant adjusted lip peptides
adj_lip_model %>% filter(adj.pvalue < .05) %>% nrow()
#> [1] 4
```

The groupComparisonLiP function outputs a list with three separate models. These models are as follows: LiP model, TrP model, and adjusted LiP model.

#### 3.2 Volcano Plot

```
groupComparisonPlotsLiP(MSstatsLiP_model,
                        type = "VolcanoPlot",
                        address = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

#### 3.3 Heatmap

```
groupComparisonPlotsLiP(MSstatsLiP_model,
                        type = "HEATMAP",
                        numProtein=50,
                        address = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

#### 3.4 Barcode

Here we show a barcode plot, showing the coverage of LiP and TrP peptides. This function requires the data in MSstatsLiP format and the path to a fasta file.

```
StructuralBarcodePlotLiP(MSstatsLiP_model,
                         "../inst/extdata/ExampleFastaFile.fasta",
                         model_type = "Adjusted", which.prot = c("P53858"),
                         address = FALSE)
#> Warning in geom_col(aes(x = Index, y = 10, fill = Coverage, text =
#> paste("Sequence:", : Ignoring unknown aesthetics: text
```

![](data:image/png;base64...)

#### 3.5 Calculate proteolytic resistance ratios

Proteolytic resistance ratios are calculated as the ratio of the intensity of fully tryptic peptides in the LiP condition to the TrP condition. In general, a low protease resistance value is indicative of high extent of cleavage, while high protease resistance values indicate low cleavage extent.

```
Accessibility = calculateProteolyticResistance(MSstatsLiP_Summarized,
                                               "../inst/extdata/ExampleFastaFile.fasta",
                                               differential_analysis = TRUE)
#> INFO  [2025-10-30 01:19:45]  == Start to test and get inference in whole plot ...
#>   |                                                                              |                                                                      |   0%
#>   |                                                                              |=====                                                                 |   8%  |                                                                              |===========                                                           |  15%  |                                                                              |================                                                      |  23%  |                                                                              |======================                                                |  31%  |                                                                              |===========================                                           |  38%  |                                                                              |================================                                      |  46%  |                                                                              |======================================                                |  54%  |                                                                              |===========================================                           |  62%  |                                                                              |================================================                      |  69%  |                                                                              |======================================================                |  77%  |                                                                              |===========================================================           |  85%
#>   |                                                                              |=================================================================     |  92%
#>   |                                                                              |======================================================================| 100%
#> INFO  [2025-10-30 01:19:45]  == Comparisons for all proteins are done.

Accessibility$RunLevelData
#> Key: <FULL_PEPTIDE, Protein, GROUP, RUN>
#>                     FULL_PEPTIDE Protein  GROUP    RUN       PeptideSequence
#>                           <char>  <char> <fctr> <fctr>                <char>
#>  1:               P14164_ILQNDLK  P14164   Ctrl      1               ILQNDLK
#>  2:               P14164_ILQNDLK  P14164   Ctrl      2               ILQNDLK
#>  3:               P14164_ILQNDLK  P14164   Ctrl      3               ILQNDLK
#>  4:               P14164_ILQNDLK  P14164   Osmo      4               ILQNDLK
#>  5:               P14164_ILQNDLK  P14164   Osmo      5               ILQNDLK
#>  6:               P14164_ILQNDLK  P14164   Osmo      6               ILQNDLK
#>  7: P16622_SHLQSNQLYSNQLPLDFALGK  P16622   Ctrl      2 SHLQSNQLYSNQLPLDFALGK
#>  8: P16622_SHLQSNQLYSNQLPLDFALGK  P16622   Ctrl      3 SHLQSNQLYSNQLPLDFALGK
#>  9: P16622_SHLQSNQLYSNQLPLDFALGK  P16622   Osmo      4 SHLQSNQLYSNQLPLDFALGK
#> 10: P16622_SHLQSNQLYSNQLPLDFALGK  P16622   Osmo      5 SHLQSNQLYSNQLPLDFALGK
#> 11: P16622_SHLQSNQLYSNQLPLDFALGK  P16622   Osmo      6 SHLQSNQLYSNQLPLDFALGK
#> 12:    P17891_ALQLINQDDADIIGGRDR  P17891   Ctrl      1    ALQLINQDDADIIGGRDR
#> 13:    P17891_ALQLINQDDADIIGGRDR  P17891   Ctrl      2    ALQLINQDDADIIGGRDR
#> 14:    P17891_ALQLINQDDADIIGGRDR  P17891   Ctrl      3    ALQLINQDDADIIGGRDR
#> 15:    P17891_ALQLINQDDADIIGGRDR  P17891   Osmo      4    ALQLINQDDADIIGGRDR
#> 16:    P17891_ALQLINQDDADIIGGRDR  P17891   Osmo      5    ALQLINQDDADIIGGRDR
#> 17:    P17891_ALQLINQDDADIIGGRDR  P17891   Osmo      6    ALQLINQDDADIIGGRDR
#> 18:              P17891_DDDTDFLK  P17891   Ctrl      1              DDDTDFLK
#> 19:              P17891_DDDTDFLK  P17891   Ctrl      2              DDDTDFLK
#> 20:              P17891_DDDTDFLK  P17891   Ctrl      3              DDDTDFLK
#> 21:              P17891_DDDTDFLK  P17891   Osmo      4              DDDTDFLK
#> 22:              P17891_DDDTDFLK  P17891   Osmo      5              DDDTDFLK
#> 23:              P17891_DDDTDFLK  P17891   Osmo      6              DDDTDFLK
#> 24:            P24004_FIGASEQNIR  P24004   Ctrl      2            FIGASEQNIR
#> 25:            P24004_FIGASEQNIR  P24004   Osmo      4            FIGASEQNIR
#> 26:            P24004_FIGASEQNIR  P24004   Osmo      6            FIGASEQNIR
#> 27:       P36112_SNDLLSGLTGSSQTR  P36112   Ctrl      1       SNDLLSGLTGSSQTR
#> 28:       P36112_SNDLLSGLTGSSQTR  P36112   Osmo      4       SNDLLSGLTGSSQTR
#> 29:       P36112_SNDLLSGLTGSSQTR  P36112   Osmo      6       SNDLLSGLTGSSQTR
#> 30:               P38805_LGQTVGR  P38805   Ctrl      1               LGQTVGR
#> 31:               P38805_LGQTVGR  P38805   Ctrl      2               LGQTVGR
#> 32:               P38805_LGQTVGR  P38805   Ctrl      3               LGQTVGR
#> 33:               P38805_LGQTVGR  P38805   Osmo      5               LGQTVGR
#> 34:               P38805_LGQTVGR  P38805   Osmo      6               LGQTVGR
#> 35:        P46959_DIIGKPYGSQIAIR  P46959   Ctrl      1        DIIGKPYGSQIAIR
#> 36:        P46959_DIIGKPYGSQIAIR  P46959   Ctrl      2        DIIGKPYGSQIAIR
#> 37:        P46959_DIIGKPYGSQIAIR  P46959   Ctrl      3        DIIGKPYGSQIAIR
#> 38:        P46959_DIIGKPYGSQIAIR  P46959   Osmo      4        DIIGKPYGSQIAIR
#> 39:        P46959_DIIGKPYGSQIAIR  P46959   Osmo      5        DIIGKPYGSQIAIR
#> 40:        P46959_DIIGKPYGSQIAIR  P46959   Osmo      6        DIIGKPYGSQIAIR
#> 41:          P52911_TWITEDDFEQIK  P52911   Ctrl      1          TWITEDDFEQIK
#> 42:          P52911_TWITEDDFEQIK  P52911   Ctrl      2          TWITEDDFEQIK
#> 43:          P52911_TWITEDDFEQIK  P52911   Ctrl      3          TWITEDDFEQIK
#> 44:          P52911_TWITEDDFEQIK  P52911   Osmo      4          TWITEDDFEQIK
#> 45:          P52911_TWITEDDFEQIK  P52911   Osmo      5          TWITEDDFEQIK
#> 46:          P52911_TWITEDDFEQIK  P52911   Osmo      6          TWITEDDFEQIK
#> 47:      P53235_ERQAVGDKLEDTQVLK  P53235   Ctrl      1      ERQAVGDKLEDTQVLK
#> 48:      P53235_ERQAVGDKLEDTQVLK  P53235   Ctrl      2      ERQAVGDKLEDTQVLK
#> 49:      P53235_ERQAVGDKLEDTQVLK  P53235   Ctrl      3      ERQAVGDKLEDTQVLK
#> 50:      P53235_ERQAVGDKLEDTQVLK  P53235   Osmo      4      ERQAVGDKLEDTQVLK
#> 51:      P53235_ERQAVGDKLEDTQVLK  P53235   Osmo      6      ERQAVGDKLEDTQVLK
#> 52:       P53858_FLDNHEVDSIVSLER  P53858   Ctrl      1       FLDNHEVDSIVSLER
#> 53:       P53858_FLDNHEVDSIVSLER  P53858   Ctrl      2       FLDNHEVDSIVSLER
#> 54:       P53858_FLDNHEVDSIVSLER  P53858   Ctrl      3       FLDNHEVDSIVSLER
#> 55:       P53858_FLDNHEVDSIVSLER  P53858   Osmo      4       FLDNHEVDSIVSLER
#> 56:       P53858_FLDNHEVDSIVSLER  P53858   Osmo      5       FLDNHEVDSIVSLER
#> 57:            Q02908_ISVISGVGVR  Q02908   Ctrl      1            ISVISGVGVR
#> 58:            Q02908_ISVISGVGVR  Q02908   Ctrl      2            ISVISGVGVR
#> 59:            Q02908_ISVISGVGVR  Q02908   Ctrl      3            ISVISGVGVR
#> 60:            Q02908_ISVISGVGVR  Q02908   Osmo      4            ISVISGVGVR
#> 61:            Q02908_ISVISGVGVR  Q02908   Osmo      5            ISVISGVGVR
#> 62:            Q02908_ISVISGVGVR  Q02908   Osmo      6            ISVISGVGVR
#> 63:            Q12248_EFQSVSDLWK  Q12248   Ctrl      1            EFQSVSDLWK
#> 64:            Q12248_EFQSVSDLWK  Q12248   Ctrl      2            EFQSVSDLWK
#> 65:            Q12248_EFQSVSDLWK  Q12248   Ctrl      3            EFQSVSDLWK
#> 66:            Q12248_EFQSVSDLWK  Q12248   Osmo      4            EFQSVSDLWK
#> 67:            Q12248_EFQSVSDLWK  Q12248   Osmo      5            EFQSVSDLWK
#> 68:            Q12248_EFQSVSDLWK  Q12248   Osmo      6            EFQSVSDLWK
#>                     FULL_PEPTIDE Protein  GROUP    RUN       PeptideSequence
#>     Accessibility_ratio   originalRUN   SUBJECT TotalGroupMeasurements
#>                   <num>        <fctr>    <char>                  <int>
#>  1:          1.00000000 180423_IP1748 Control_1                      6
#>  2:          1.00000000 180423_IP1749 Control_2                      6
#>  3:          1.00000000 180423_IP1750 Control_3                      6
#>  4:          1.00000000 180423_IP1742    Osmo_1                      6
#>  5:                  NA 180423_IP1743    Osmo_2                      6
#>  6:          1.00000000 180423_IP1744    Osmo_3                      6
#>  7:                  NA 180423_IP1749 Control_2                      9
#>  8:          0.32345035 180423_IP1750 Control_3                      9
#>  9:          0.21085472 180423_IP1742    Osmo_1                      9
#> 10:                  NA 180423_IP1743    Osmo_2                      9
#> 11:          0.20184052 180423_IP1744    Osmo_3                      9
#> 12:          0.46640506 180423_IP1748 Control_1                      9
#> 13:          1.00000000 180423_IP1749 Control_2                      9
#> 14:          1.00000000 180423_IP1750 Control_3                      9
#> 15:          1.00000000 180423_IP1742    Osmo_1                      9
#> 16:          1.00000000 180423_IP1743    Osmo_2                      9
#> 17:          0.99635019 180423_IP1744    Osmo_3                      9
#> 18:          0.18055185 180423_IP1748 Control_1                      9
#> 19:          0.43802933 180423_IP1749 Control_2                      9
#> 20:          0.65621207 180423_IP1750 Control_3                      9
#> 21:          1.00000000 180423_IP1742    Osmo_1                      9
#> 22:          1.00000000 180423_IP1743    Osmo_2                      9
#> 23:          0.59829185 180423_IP1744    Osmo_3                      9
#> 24:          1.00000000 180423_IP1749 Control_2                      9
#> 25:          0.46480913 180423_IP1742    Osmo_1                      9
#> 26:                  NA 180423_IP1744    Osmo_3                      9
#> 27:          0.41997419 180423_IP1748 Control_1                      9
#> 28:          0.50076007 180423_IP1742    Osmo_1                      9
#> 29:          0.23822452 180423_IP1744    Osmo_3                      9
#> 30:          1.00000000 180423_IP1748 Control_1                      6
#> 31:          0.61622199 180423_IP1749 Control_2                      6
#> 32:          0.89693110 180423_IP1750 Control_3                      6
#> 33:          0.52013303 180423_IP1743    Osmo_2                      6
#> 34:          0.70947596 180423_IP1744    Osmo_3                      6
#> 35:                  NA 180423_IP1748 Control_1                      9
#> 36:          1.00000000 180423_IP1749 Control_2                      9
#> 37:          1.00000000 180423_IP1750 Control_3                      9
#> 38:          1.00000000 180423_IP1742    Osmo_1                      9
#> 39:          1.00000000 180423_IP1743    Osmo_2                      9
#> 40:          0.25473089 180423_IP1744    Osmo_3                      9
#> 41:          0.04713104 180423_IP1748 Control_1                      9
#> 42:          0.15418803 180423_IP1749 Control_2                      9
#> 43:          0.07654634 180423_IP1750 Control_3                      9
#> 44:          0.39044227 180423_IP1742    Osmo_1                      9
#> 45:          0.60119225 180423_IP1743    Osmo_2                      9
#> 46:          0.20483639 180423_IP1744    Osmo_3                      9
#> 47:          0.01196915 180423_IP1748 Control_1                      9
#> 48:          0.02512174 180423_IP1749 Control_2                      9
#> 49:                  NA 180423_IP1750 Control_3                      9
#> 50:          0.57220826 180423_IP1742    Osmo_1                      9
#> 51:          0.45183815 180423_IP1744    Osmo_3                      9
#> 52:          0.38326514 180423_IP1748 Control_1                      6
#> 53:          0.51278291 180423_IP1749 Control_2                      6
#> 54:          0.51503008 180423_IP1750 Control_3                      6
#> 55:          0.87535868 180423_IP1742    Osmo_1                      6
#> 56:          0.94807030 180423_IP1743    Osmo_2                      6
#> 57:          1.00000000 180423_IP1748 Control_1                     12
#> 58:          1.00000000 180423_IP1749 Control_2                     12
#> 59:          1.00000000 180423_IP1750 Control_3                     12
#> 60:          1.00000000 180423_IP1742    Osmo_1                     12
#> 61:          1.00000000 180423_IP1743    Osmo_2                     12
#> 62:          1.00000000 180423_IP1744    Osmo_3                     12
#> 63:          1.00000000 180423_IP1748 Control_1                      9
#> 64:                  NA 180423_IP1749 Control_2                      9
#> 65:                  NA 180423_IP1750 Control_3                      9
#> 66:                  NA 180423_IP1742    Osmo_1                      9
#> 67:          1.00000000 180423_IP1743    Osmo_2                      9
#> 68:          1.00000000 180423_IP1744    Osmo_3                      9
#>     Accessibility_ratio   originalRUN   SUBJECT TotalGroupMeasurements
#>     NumMeasuredFeature MissingPercentage more50missing NumImputedFeature
#>                  <int>             <num>        <lgcl>             <num>
#>  1:                  2         0.0000000         FALSE                 0
#>  2:                  2         0.0000000         FALSE                 0
#>  3:                  2         0.0000000         FALSE                 0
#>  4:                  2         0.0000000         FALSE                 0
#>  5:                  2         0.0000000         FALSE                 0
#>  6:                  2         0.0000000         FALSE                 0
#>  7:                  3         0.0000000         FALSE                 0
#>  8:                  3         0.0000000         FALSE                 0
#>  9:                  3         0.0000000         FALSE                 0
#> 10:                  3         0.0000000         FALSE                 0
#> 11:                  3         0.0000000         FALSE                 0
#> 12:                  3         0.0000000         FALSE                 0
#> 13:                  3         0.0000000         FALSE                 0
#> 14:                  3         0.0000000         FALSE                 0
#> 15:                  3         0.0000000         FALSE                 0
#> 16:                  3         0.0000000         FALSE                 0
#> 17:                  3         0.0000000         FALSE                 0
#> 18:                  3         0.0000000         FALSE                 0
#> 19:                  3         0.0000000         FALSE                 0
#> 20:                  3         0.0000000         FALSE                 0
#> 21:                  3         0.0000000         FALSE                 0
#> 22:                  3         0.0000000         FALSE                 0
#> 23:                  3         0.0000000         FALSE                 0
#> 24:                  3         0.0000000         FALSE                 0
#> 25:                  3         0.0000000         FALSE                 0
#> 26:                  3         0.0000000         FALSE                 0
#> 27:                  3         0.0000000         FALSE                 0
#> 28:                  3         0.0000000         FALSE                 0
#> 29:                  3         0.0000000         FALSE                 0
#> 30:                  2         0.0000000         FALSE                 0
#> 31:                  2         0.0000000         FALSE                 0
#> 32:                  2         0.0000000         FALSE                 0
#> 33:                  2         0.0000000         FALSE                 0
#> 34:                  2         0.0000000         FALSE                 0
#> 35:                  3         0.0000000         FALSE                 0
#> 36:                  3         0.0000000         FALSE                 0
#> 37:                  3         0.0000000         FALSE                 0
#> 38:                  2         0.3333333         FALSE                 0
#> 39:                  3         0.0000000         FALSE                 0
#> 40:                  3         0.0000000         FALSE                 0
#> 41:                  3         0.0000000         FALSE                 0
#> 42:                  2         0.3333333         FALSE                 0
#> 43:                  3         0.0000000         FALSE                 0
#> 44:                  3         0.0000000         FALSE                 0
#> 45:                  3         0.0000000         FALSE                 0
#> 46:                  3         0.0000000         FALSE                 0
#> 47:                  3         0.0000000         FALSE                 0
#> 48:                  3         0.0000000         FALSE                 0
#> 49:                  3         0.0000000         FALSE                 0
#> 50:                  3         0.0000000         FALSE                 0
#> 51:                  3         0.0000000         FALSE                 0
#> 52:                  2         0.0000000         FALSE                 0
#> 53:                  2         0.0000000         FALSE                 0
#> 54:                  2         0.0000000         FALSE                 0
#> 55:                  2         0.0000000         FALSE                 0
#> 56:                  2         0.0000000         FALSE                 0
#> 57:                  4         0.0000000         FALSE                 0
#> 58:                  4         0.0000000         FALSE                 0
#> 59:                  4         0.0000000         FALSE                 0
#> 60:                  4         0.0000000         FALSE                 0
#> 61:                  4         0.0000000         FALSE                 0
#> 62:                  4         0.0000000         FALSE                 0
#> 63:                  3         0.0000000         FALSE                 0
#> 64:                  3         0.0000000         FALSE                 0
#> 65:                  3         0.0000000         FALSE                 0
#> 66:                  3         0.0000000         FALSE                 0
#> 67:                  3         0.0000000         FALSE                 0
#> 68:                  3         0.0000000         FALSE                 0
#>     NumMeasuredFeature MissingPercentage more50missing NumImputedFeature
```

```
ResistanceBarcodePlotLiP(Accessibility,
                         "../inst/extdata/ExampleFastaFile.fasta",
                         which.prot = "P14164",
                         which.condition = "Osmo",
                         address = FALSE)
```

![](data:image/png;base64...)

```
ResistanceBarcodePlotLiP(Accessibility,
                         "../inst/extdata/ExampleFastaFile.fasta",
                         differential_analysis = TRUE,
                         which.prot = "P53858",
                         which.condition = "Osmo",
                         address = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)