# MSstatsBioData: Datasets of published biological studies with DDA or SRM experiments

Package: MSstatsBioData
Author: Meena Choi
Date: October 2, 2017

## Overview

This package provides the peak intensities datasets from seven biological investigations in DDA or SRM experiments. Experimental design, data acqusition and processing steps by spectral processing tools are as described in publications [1-5]. The datasets are formatted as MSstats required format (package *[MSstats](https://bioconductor.org/packages/3.8/MSstats)*). For usage of the data for differential abundance analysis, please refer to the *[MSstats](https://bioconductor.org/packages/3.8/MSstats)* vignette.

Overview of the datasets included in MSstatsBioData:

| object | description |
| --- | --- |
| `DDA_cardio` | DDA dataset for cardiovascular disease study [1] |
| `SRM_crc_training` | The training set from a study for subjects with colorectal cancer [2] |
| `SRM_crc_validation` | The validation set from a study for subjects with colorectal cancer [2] |
| `SRM_mpm_training` | The training set from a study of subjects with malignant pleural mesothelioma(MPM) [3] |
| `SRM_mpm_validation` | The validation set from a study of subjects with malignant pleural mesothelioma(MPM) [3] |
| `SRM_ovarian` | SRM dataset for a study of subjects with ovarian cancer [4] |
| `SRM_yeast` | Time course investigation of central carbon metabolism of \emph{S. cerevisiae} [5] |

## Data structure

All datasets in the package are represented in a data.frame with 10 columns, as `MSstats` rsequired format :

| column | description |
| --- | --- |
| `ProteinName` | Protein id. |
| `PeptideSequence` | Peptide sequence or modified peptide sequence |
| `PrecursorCharge` | Precursor charge |
| `FragmentIon` | fragment |
| `ProductCharge` | normalized microarray data, RNA-seq data or developmental effect score |
| `IsotopeLabelType` | endogenous peptides (use L) or labeled reference peptides (use H) |
| `Condition` | indicates groups of interest |
| `BioReplicate` | a unique identifier for each biological replicate in the experiment |
| `Run` | identifier of a mass spectrometry run |
| `Intensity` | the quantified signal of a feature in a run without any transformation (the peak height or the peak of area under curve) |

## Data manipulation

#### Intensities are normalized in `SRM_crc_training` and `SRM_crc_validation`

Two steps-normalization in log2 transformed intensity were already performed for these two datsets as described in manuscript. First they are normalized by equalized median using heavy reference peptides. Second, endogenous peptides are normalized by two standard proteins (AIAG and FETUA). After normalization, intensity value was came back to original scale from log2 transformation. These normalizations were performed by each dataset. User do not need extra normalization.

## Comments for some datasets

#### no missing in `DDA_cardio`

This DDA dataset had no missing values, unusally, because the procedure reported the background signal if a feature in a run was not detected.

## How to use dataset

Here one example (SRM\_yeast) of differential abundance analysis by MSstats will be shown. Other example will be available in help file for each datasets.

### 1.Read the data.

```
## load package
require(MSstatsBioData)

## require SRM_yeast data
data(SRM_yeast)
## look at first lines
head(SRM_yeast)
```

```
##   ProteinName PeptideSequence PrecursorCharge FragmentIon ProductCharge IsotopeLabelType Condition
## 1        ACEA EILGHEIFFDWELPR               3          y3             0                H         1
## 2        ACEA EILGHEIFFDWELPR               3          y3             0                L         1
## 3        ACEA EILGHEIFFDWELPR               3          y4             0                H         1
## 4        ACEA EILGHEIFFDWELPR               3          y4             0                L         1
## 5        ACEA EILGHEIFFDWELPR               3          y5             0                H         1
## 6        ACEA EILGHEIFFDWELPR               3          y5             0                L         1
##   BioReplicate Run    Intensity
## 1        ReplA   1  66472.38470
## 2        ReplA   1   5764.16228
## 3        ReplA   1 101005.16640
## 4        ReplA   1     61.65238
## 5        ReplA   1  90055.49930
## 6        ReplA   1    472.69180
```

### 2. Load MSstats package and process the data

```
## Example of using MSstats for differential abundance analysis.
require(MSstats)
input.proposed <- dataProcess(SRM_yeast,
                            summaryMethod="TMP",
                            cutoffCensored="minFeature",
                            censoredInt="0",
                            MBimpute=TRUE,
                            maxQuantileforCensored=0.999)
```

```
##
##   Summary of Features :
##                          count
## # of Protein                45
## # of Peptides/Protein      1-2
## # of Transitions/Peptide   1-3
##
##   Summary of Samples :
##                            1 2 3 4 5 6 7 8 9 10
## # of MS runs               3 3 3 3 3 3 3 3 3  3
## # of Biological Replicates 3 3 3 3 3 3 3 3 3  3
## # of Technical Replicates  1 1 1 1 1 1 1 1 1  1
##
  |
  |                                                                                                    |   0%
  |
  |==                                                                                                  |   2%
  |
  |====                                                                                                |   4%
  |
  |=======                                                                                             |   7%
  |
  |=========                                                                                           |   9%
  |
  |===========                                                                                         |  11%
  |
  |=============                                                                                       |  13%
  |
  |================                                                                                    |  16%
  |
  |==================                                                                                  |  18%
  |
  |====================                                                                                |  20%
  |
  |======================                                                                              |  22%
  |
  |========================                                                                            |  24%
  |
  |===========================                                                                         |  27%
  |
  |=============================                                                                       |  29%
  |
  |===============================                                                                     |  31%
  |
  |=================================                                                                   |  33%
  |
  |====================================                                                                |  36%
  |
  |======================================                                                              |  38%
  |
  |========================================                                                            |  40%
  |
  |==========================================                                                          |  42%
  |
  |============================================                                                        |  44%
  |
  |===============================================                                                     |  47%
  |
  |=================================================                                                   |  49%
  |
  |===================================================                                                 |  51%
  |
  |=====================================================                                               |  53%
  |
  |========================================================                                            |  56%
  |
  |==========================================================                                          |  58%
  |
  |============================================================                                        |  60%
  |
  |==============================================================                                      |  62%
  |
  |================================================================                                    |  64%
  |
  |===================================================================                                 |  67%
  |
  |=====================================================================                               |  69%
  |
  |=======================================================================                             |  71%
  |
  |=========================================================================                           |  73%
  |
  |============================================================================                        |  76%
  |
  |==============================================================================                      |  78%
  |
  |================================================================================                    |  80%
  |
  |==================================================================================                  |  82%
  |
  |====================================================================================                |  84%
  |
  |=======================================================================================             |  87%
  |
  |=========================================================================================           |  89%
  |
  |===========================================================================================         |  91%
  |
  |=============================================================================================       |  93%
  |
  |================================================================================================    |  96%
  |
  |==================================================================================================  |  98%
  |
  |====================================================================================================| 100%
```

```
## set up the comparison that you want.
comparison1<-matrix(c(-1,1,0,0,0,0,0,0,0,0),nrow=1)
comparison2<-matrix(c(-1,0,1,0,0,0,0,0,0,0),nrow=1)
comparison3<-matrix(c(-1,0,0,1,0,0,0,0,0,0),nrow=1)
comparison4<-matrix(c(-1,0,0,0,1,0,0,0,0,0),nrow=1)
comparison5<-matrix(c(-1,0,0,0,0,1,0,0,0,0),nrow=1)
comparison6<-matrix(c(-1,0,0,0,0,0,1,0,0,0),nrow=1)
comparison7<-matrix(c(-1,0,0,0,0,0,0,1,0,0),nrow=1)
comparison8<-matrix(c(-1,0,0,0,0,0,0,0,1,0),nrow=1)
comparison9<-matrix(c(-1,0,0,0,0,0,0,0,0,1),nrow=1)

comparison <- rbind(comparison1,comparison2,comparison3,
                    comparison4,comparison5,comparison6,
                    comparison7,comparison8,comparison9)
row.names(comparison) <- c("T2-T1","T3-T1","T4-T1",
                            "T5-T1","T6-T1","T7-T1",
                            "T8-T1","T9-T1","T10-T1")
```

```
## test between comparison you set up.
output.comparison <- groupComparison(contrast.matrix=comparison,
                            data=input.proposed)
```

```
##
  |
  |                                                                                                    |   0%
  |
  |==                                                                                                  |   2%
  |
  |====                                                                                                |   4%
  |
  |=======                                                                                             |   7%
  |
  |=========                                                                                           |   9%
  |
  |===========                                                                                         |  11%
  |
  |=============                                                                                       |  13%
  |
  |================                                                                                    |  16%
  |
  |==================                                                                                  |  18%
  |
  |====================                                                                                |  20%
  |
  |======================                                                                              |  22%
  |
  |========================                                                                            |  24%
  |
  |===========================                                                                         |  27%
  |
  |=============================                                                                       |  29%
  |
  |===============================                                                                     |  31%
  |
  |=================================                                                                   |  33%
  |
  |====================================                                                                |  36%
  |
  |======================================                                                              |  38%
  |
  |========================================                                                            |  40%
  |
  |==========================================                                                          |  42%
  |
  |============================================                                                        |  44%
  |
  |===============================================                                                     |  47%
  |
  |=================================================                                                   |  49%
  |
  |===================================================                                                 |  51%
  |
  |=====================================================                                               |  53%
  |
  |========================================================                                            |  56%
  |
  |==========================================================                                          |  58%
  |
  |============================================================                                        |  60%
  |
  |==============================================================                                      |  62%
  |
  |================================================================                                    |  64%
  |
  |===================================================================                                 |  67%
  |
  |=====================================================================                               |  69%
  |
  |=======================================================================                             |  71%
  |
  |=========================================================================                           |  73%
  |
  |============================================================================                        |  76%
  |
  |==============================================================================                      |  78%
  |
  |================================================================================                    |  80%
  |
  |==================================================================================                  |  82%
  |
  |====================================================================================                |  84%
  |
  |=======================================================================================             |  87%
  |
  |=========================================================================================           |  89%
  |
  |===========================================================================================         |  91%
  |
  |=============================================================================================       |  93%
  |
  |================================================================================================    |  96%
  |
  |==================================================================================================  |  98%
  |
  |====================================================================================================| 100%
```

```
## output.comparison$ComparisonResult include the result of testing.
head(output.comparison$ComparisonResult)
```

```
##   Protein Label      log2FC         SE     Tvalue DF       pvalue   adj.pvalue issue MissingPercentage
## 1    ACEA T2-T1  0.47446637 0.17242085  2.7517923 18 1.312206e-02 2.811870e-02    NA                 0
## 2    ACH1 T2-T1  0.29936641 0.09533910  3.1400173 18 5.660892e-03 1.273701e-02    NA                 0
## 3    ACON T2-T1  0.15362516 0.02701301  5.6870805 18 2.152559e-05 8.805925e-05    NA                 0
## 4    ADH1 T2-T1 -0.08619979 0.02260686 -3.8129930 18 1.273964e-03 4.036070e-03    NA                 0
## 5    ADH2 T2-T1  0.23043035 0.26485775  0.8700155 18 3.957462e-01 4.686469e-01    NA                 0
## 6    ADH4 T2-T1  0.19962675 0.39593315  0.5041931 18 6.202414e-01 6.807527e-01    NA                 0
##   ImputationPercentage
## 1                    0
## 2                    0
## 3                    0
## 4                    0
## 5                    0
## 6                    0
```

## References

[1] Clough, T. et al. (2009) Protein quantification in label-free LC-MS experiments. \emph{J. Proteome Res.}, 8, 5275–5284.

[2] Surinova, S. et al. (2015) Prediction of colorectal cancer diagnosis based on circulating plasma proteins. \emph{EMBO Mol. Med.}, 7, 1166–1178.

[3] Cerciello, F. et al. (2013) Identification of a seven glycopeptide signature for malignant pleural mesothelioma in human serum by selected reaction monitoring. \emph{Clin. Proteomics}, 10, 16.

[4] Huttenhain, R. et al. (2012) Reproducible quantification of cancer-associated proteins in body fluids using targeted proteomics. \emph{Sci. Tansl. Med.}, 4, 142ra94.

[5] Picotti, P. et ak. (2009) Full dynamic range proteome analysis of S. cerevisiae by targeted proteomics. \emph{Cell}, 138, 795–806.