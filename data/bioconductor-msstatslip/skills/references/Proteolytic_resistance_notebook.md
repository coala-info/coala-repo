# Proteolytic resistance analysis

#### Valentina Cappelletti (cappelletti@imsb.biol.ethz.ch), Malinovska Liliana (malinovska@imsb.biol.ethz.ch), Devon Kohler (kohler.d@northeastern.edu)

#### 2025-10-30

* [MSstatsLiP Workflow: Protease resistance analysis](#msstatslip-workflow-protease-resistance-analysis)
  + [1. Installation](#installation)
* [2. Data preprocessing](#data-preprocessing)
  + [2.1 Load datasets](#load-datasets)
  + [2.2 Select only fully tryptic (FT) peptides in both LiP and TrP dataset](#select-only-fully-tryptic-ft-peptides-in-both-lip-and-trp-dataset)
  + [2.3 Correct nomenclature](#correct-nomenclature)
  + [2.4 Data Summarization](#data-summ)
* [3. Modelling](#modelling)
* [4. Calculate proteolytic resistance ratios](#calculate-proteolytic-resistance-ratios)
* [5. Proteolytic resistance differential analysis](#proteolytic-resistance-differential-analysis)
* [6. Save outputs](#save-outputs)
* [7. Plot aSynuclein proteolytic resistance DA result as barcode](#plot-asynuclein-proteolytic-resistance-da-result-as-barcode)

# MSstatsLiP Workflow: Protease resistance analysis

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook describing the analysis of a LiP-MS experiment using [MSstatsLiP](https://github.com/Vitek-Lab/MSstatsLiP). When you execute code within the notebook, the results appear beneath the code.

Here, we use LiP-MS data of human alpha-Synuclein in the monomeric (M) and fibrillar form (F) spiked into a *S.cerevisiae* lysate at 5 pmol/ug lysate (M1 and F1) and 20 pmol/ug lysate (M2 and F2).The data set is composed of four biological replicates per condition.

## 1. Installation

* Install and load all necessary packages. The installation needs to be performed at first use only. Un-comment the lines for execution.

```
 knitr::opts_chunk$set(include = FALSE)
```

```
library(MSstatsLiP)
library(tidyverse)
library(data.table)
library(gghighlight)
```

* Set the working directory

```
input_folder=choose.dir(caption="Choose the working directory")
knitr::opts_knit$set(root.dir = input_folder)
```

# 2. Data preprocessing

## 2.1 Load datasets

Load the data from the Spectronaut export. LiP data is loaded as `raw_lip`, trypsin-only control data (TrP data) is loaded as `raw_prot`. The function `choose.files()` enables browsing for the input file.

**CAVE:** Make sure the separator `delim` is set correctly. For comma-separated values (csv), the separator is set to `delim=","`.

```
raw_lip <- read_delim(file=choose.files(caption="Choose LiP dataset"),
                         delim=",", escape_double = FALSE, trim_ws = TRUE)
```

```
raw_prot <- read_delim(file=choose.files(caption="Choose TrP dataset"),
                          delim=",", escape_double = FALSE, trim_ws = TRUE)
```

```
raw_lip <- raw_lip %>% mutate_all(funs(ifelse(.=="P37840.1", "P37840", .)))
raw_prot <- raw_prot %>% mutate_all(funs(ifelse(.=="P37840.1", "P37840", .)))
```

Load the fasta file that was used in the Spectronaut search.

```
fasta_file=choose.files(caption = "Choose FASTA file")
```

Convert the data to MSstatsLiP format. Load first the LiP data set `raw_lip`, then the FASTA file `fasta_file` used for searches. If the experiment contains TrP data, `raw_prot` is loaded last.

To remove information on iRT peptides, the default setting is `removeiRT = TRUE`. As default, peptides containing modifications are filtered, but this can be changed using the argument `removeModifications`. Also, peptides with multiple protein annotations are filtered as default. However, for data sets containing protein isoforms, this argument can be set to `removeNonUniqueProteins = FALSE`.

The default settings use *PeakArea* as measure of intensity, filter features based on the q-value, with a q-value cut-off of 0.01 and import all conditions. You can adjust the settings accordingly. For information on each option, refer to the vignette of the function.

```
msstats_data <- SpectronauttoMSstatsLiPFormat(raw_lip, fasta_file, raw_prot)
```

```
## INFO  [2025-10-30 01:19:47] ** Raw data from Spectronaut imported successfully.
## INFO  [2025-10-30 01:19:47] ** Raw data from Spectronaut cleaned successfully.
## INFO  [2025-10-30 01:19:47] ** Using annotation extracted from quantification data.
## INFO  [2025-10-30 01:19:47] ** Run labels were standardized to remove symbols such as '.' or '%'.
## INFO  [2025-10-30 01:19:47] ** The following options are used:
##   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
##   - Shared peptides will be removed.
##   - Proteins with single feature will not be removed.
##   - Features with less than 3 measurements across runs will be removed.
## INFO  [2025-10-30 01:19:47] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
## WARN  [2025-10-30 01:19:47] ** PGQvalue not found in input columns.
## INFO  [2025-10-30 01:19:47] ** Intensities with values not smaller than 0.01 in EGQvalue are replaced with NA
## INFO  [2025-10-30 01:19:47] ** Features with all missing measurements across runs are removed.
## INFO  [2025-10-30 01:19:47] ** Shared peptides are removed.
```

```
## INFO  [2025-10-30 01:19:47] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
## INFO  [2025-10-30 01:19:48] ** Features with one or two measurements across runs are removed.
## INFO  [2025-10-30 01:19:48] ** Run annotation merged with quantification data.
## INFO  [2025-10-30 01:19:48] ** Features with one or two measurements across runs are removed.
## INFO  [2025-10-30 01:19:48] ** Fractionation handled.
## INFO  [2025-10-30 01:19:48] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2025-10-30 01:19:48] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
## INFO  [2025-10-30 01:19:48] ** Raw data from Spectronaut imported successfully.
## INFO  [2025-10-30 01:19:48] ** Raw data from Spectronaut cleaned successfully.
## INFO  [2025-10-30 01:19:48] ** Using annotation extracted from quantification data.
## INFO  [2025-10-30 01:19:48] ** Run labels were standardized to remove symbols such as '.' or '%'.
## INFO  [2025-10-30 01:19:48] ** The following options are used:
##   - Features will be defined by the columns: PeptideSequence, PrecursorCharge, FragmentIon, ProductCharge
##   - Shared peptides will be removed.
##   - Proteins with single feature will not be removed.
##   - Features with less than 3 measurements across runs will be removed.
## INFO  [2025-10-30 01:19:48] ** Intensities with values of FExcludedFromQuantification equal to TRUE are replaced with NA
## WARN  [2025-10-30 01:19:48] ** PGQvalue not found in input columns.
## INFO  [2025-10-30 01:19:48] ** Intensities with values not smaller than 0.01 in EGQvalue are replaced with NA
## INFO  [2025-10-30 01:19:48] ** Features with all missing measurements across runs are removed.
## INFO  [2025-10-30 01:19:48] ** Shared peptides are removed.
```

```
## INFO  [2025-10-30 01:19:48] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
## INFO  [2025-10-30 01:19:48] ** Features with one or two measurements across runs are removed.
## INFO  [2025-10-30 01:19:48] ** Run annotation merged with quantification data.
## INFO  [2025-10-30 01:19:48] ** Features with one or two measurements across runs are removed.
## INFO  [2025-10-30 01:19:48] ** Fractionation handled.
## INFO  [2025-10-30 01:19:48] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2025-10-30 01:19:48] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
```

## 2.2 Select only fully tryptic (FT) peptides in both LiP and TrP dataset

Proteolytic resistance is calculated as the of the intensity of fully tryptic peptides in the LiP condition to the TrP condition. Half-tryptic (HT) peptides are excluded from this analysis. The function “calculateTrypticity” is used to annotate FT and HT peptides in the LiP dataset. Next, from the TrP dataset we filtered out FT peptides not identified in the LiP dataset.The msstats\_data list will finally contain only FT peptides measured in both LiP and TrP datasets.

```
FullyTrP <- msstats_data[["LiP"]] %>%
  distinct(ProteinName, PeptideSequence) %>%
  calculateTrypticity(fasta_file) %>%
  filter(fully_TRI) %>%
  filter(MissedCleavage == FALSE) %>%
  select(ProteinName, PeptideSequence, StartPos, EndPos)
```

```
msstats_data[["LiP"]] <- msstats_data[["LiP"]] %>%
  select(-ProteinName) %>% inner_join(FullyTrP)
```

```
msstats_data[["TrP"]] <- msstats_data[["TrP"]] %>%
  select(-ProteinName) %>% inner_join(FullyTrP)
```

## 2.3 Correct nomenclature

#### Step 1:

Ensure that the `Condition` nomenclature is identical in both data sets. If the output is `TRUE` for all conditions, continue to [step 2](#steptwo).

```
unique(msstats_data[["LiP"]]$Condition)%in%unique(msstats_data[["TrP"]]$Condition)
```

```
## [1] TRUE TRUE TRUE TRUE
```

To correct the condition nomenclature, display the condition for both data sets.

```
paste("LiP Condition nomenclature:", unique(msstats_data[["LiP"]]$Condition), ",",
      "TrP Condition nomenclature:",unique(msstats_data[["TrP"]]$Condition))
```

```
## [1] "LiP Condition nomenclature: F1 , TrP Condition nomenclature: F2"
## [2] "LiP Condition nomenclature: M1 , TrP Condition nomenclature: M2"
## [3] "LiP Condition nomenclature: M2 , TrP Condition nomenclature: M1"
## [4] "LiP Condition nomenclature: F2 , TrP Condition nomenclature: F1"
```

If necessary, un-comment following lines to correct the condition nomenclature in either of the data sets. E.g. change the nomenclature of the TrP samples from `Cond1` to `cond1`.

```
# msstats_data[["TrP"]] = msstats_data[["TrP"]] %>%
#   mutate(Condition = case_when(Condition == "Cond1" ~ "cond1",
#                                Condition == "Cond2" ~ "cond2"))
```

#### Step 2:

Ensure that `BioReplicate` nomenclature is correctly annotated (see also [MSstats](http://msstats.org/wp-content/uploads/2020/02/MSstats_v3.18.1_manual_2020Feb26-v2.pdf) user manual. The BioReplicate needs a unique nomenclature, while the technical replicates can have duplicate numbering. If the replicate nomenclature is correct, proceed to [section 2.3](#data-summ).

```
paste("LiP BioReplicate nomenclature:", unique(msstats_data[["LiP"]]$BioReplicate), ",",
      "TrP BioReplicate nomenclature:",unique(msstats_data[["TrP"]]$BioReplicate))
```

```
## [1] "LiP BioReplicate nomenclature: 1 , TrP BioReplicate nomenclature: 1"
## [2] "LiP BioReplicate nomenclature: 2 , TrP BioReplicate nomenclature: 2"
## [3] "LiP BioReplicate nomenclature: 3 , TrP BioReplicate nomenclature: 3"
## [4] "LiP BioReplicate nomenclature: 4 , TrP BioReplicate nomenclature: 4"
```

Adjust `BioReplicate` column to correct nomenclature for a Case-control experiment.

```
msstats_data[["LiP"]] = msstats_data[["LiP"]] %>%
  mutate(BioReplicate = paste0(Condition,".",BioReplicate))

msstats_data[["TrP"]] = msstats_data[["TrP"]] %>%
  mutate(BioReplicate = paste0(Condition,".",BioReplicate))
```

Inspect corrected `BioReplicate` column.

```
paste("LiP BioReplicate nomenclature:", unique(msstats_data[["LiP"]]$BioReplicate), ",",
      "TrP BioReplicate nomenclature:",unique(msstats_data[["TrP"]]$BioReplicate))
```

```
##  [1] "LiP BioReplicate nomenclature: F1.1 , TrP BioReplicate nomenclature: F2.1"
##  [2] "LiP BioReplicate nomenclature: M1.1 , TrP BioReplicate nomenclature: M2.1"
##  [3] "LiP BioReplicate nomenclature: M2.1 , TrP BioReplicate nomenclature: M1.1"
##  [4] "LiP BioReplicate nomenclature: F2.1 , TrP BioReplicate nomenclature: F1.1"
##  [5] "LiP BioReplicate nomenclature: M1.2 , TrP BioReplicate nomenclature: M2.2"
##  [6] "LiP BioReplicate nomenclature: M2.2 , TrP BioReplicate nomenclature: F1.2"
##  [7] "LiP BioReplicate nomenclature: F1.2 , TrP BioReplicate nomenclature: M1.2"
##  [8] "LiP BioReplicate nomenclature: F2.2 , TrP BioReplicate nomenclature: F2.2"
##  [9] "LiP BioReplicate nomenclature: M2.3 , TrP BioReplicate nomenclature: M1.3"
## [10] "LiP BioReplicate nomenclature: F1.3 , TrP BioReplicate nomenclature: M2.3"
## [11] "LiP BioReplicate nomenclature: M1.3 , TrP BioReplicate nomenclature: F1.3"
## [12] "LiP BioReplicate nomenclature: F2.3 , TrP BioReplicate nomenclature: F2.3"
## [13] "LiP BioReplicate nomenclature: F2.4 , TrP BioReplicate nomenclature: F1.4"
## [14] "LiP BioReplicate nomenclature: M2.4 , TrP BioReplicate nomenclature: M1.4"
## [15] "LiP BioReplicate nomenclature: M1.4 , TrP BioReplicate nomenclature: M2.4"
## [16] "LiP BioReplicate nomenclature: F1.4 , TrP BioReplicate nomenclature: F2.4"
```

## 2.4 Data Summarization

Summarize the data. The default settings use a log2-transformation and normalize the data using the `"equalizeMedians"` method. The default summary method is `"TMP"` and imputation is set to `"FALSE"`. For detailed information on all settings, please refer to the function vignette.

This function will take some time and memory. If memory is limited, it is advisable to remove the raw files using the `rm()` function and clearing the memory cache using the `gc()` function.

```
MSstatsLiP_Summarized <- dataSummarizationLiP(msstats_data, normalization.LiP = "equalizeMedians")
```

```
## INFO  [2025-10-30 01:19:49] ** Features with one or two measurements across runs are removed.
## INFO  [2025-10-30 01:19:49] ** Fractionation handled.
## INFO  [2025-10-30 01:19:49] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2025-10-30 01:19:49] ** Use all features that the dataset originally has.
## INFO  [2025-10-30 01:19:49]
##  # proteins: 9
##  # peptides per protein: 1-1
##  # features per peptide: 1-2
## INFO  [2025-10-30 01:19:49] Some proteins have only one feature:
##  P14164_DLAIGAHGGK,
##  P16622_AFSENITK,
##  P17891_ALQLINQDDADIIGGR,
##  P38805_LFQSILPQNPDIEGR,
##  Q02908_IYPTLVIR ...
## INFO  [2025-10-30 01:19:49]
##                     F1 F2 M1 M2
##              # runs  4  4  4  4
##     # bioreplicates  4  4  4  4
##  # tech. replicates  1  1  1  1
## INFO  [2025-10-30 01:19:49] Some features are completely missing in at least one condition:
##  ALQLINQDDADIIGGR_2_y11_1,
##  DLAIGAHGGK_2_y8_1,
##  LFQSILPQNPDIEGR_2_y9_1,
##  PLTAETYK_2_y7_1,
##  NA ...
## INFO  [2025-10-30 01:19:49] The following runs have more than 75% missing values: 2,
##  4,
##  6,
##  10,
##  12,
##  16
## INFO  [2025-10-30 01:19:49]  == Start the summarization per subplot...
##   |                                                                              |                                                                      |   0%  |                                                                              |========                                                              |  11%  |                                                                              |================                                                      |  22%  |                                                                              |=======================                                               |  33%  |                                                                              |===============================                                       |  44%  |                                                                              |=======================================                               |  56%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================                |  78%  |                                                                              |==============================================================        |  89%  |                                                                              |======================================================================| 100%
## INFO  [2025-10-30 01:19:49]  == Summarization is done.
```

```
## INFO  [2025-10-30 01:19:49] ** Features with one or two measurements across runs are removed.
## INFO  [2025-10-30 01:19:49] ** Fractionation handled.
## INFO  [2025-10-30 01:19:49] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2025-10-30 01:19:49] ** Log2 intensities under cutoff = 15.979  were considered as censored missing values.
## INFO  [2025-10-30 01:19:49] ** Log2 intensities = NA were considered as censored missing values.
## INFO  [2025-10-30 01:19:49] ** Use all features that the dataset originally has.
## INFO  [2025-10-30 01:19:49]
##  # proteins: 4
##  # peptides per protein: 1-3
##  # features per peptide: 1-3
## INFO  [2025-10-30 01:19:49] Some proteins have only one feature:
##  P53235 ...
## INFO  [2025-10-30 01:19:49]
##                     F1 F2 M1 M2
##              # runs  4  4  4  4
##     # bioreplicates  4  4  4  4
##  # tech. replicates  1  1  1  1
## INFO  [2025-10-30 01:19:49] Some features are completely missing in at least one condition:
##  AFSENITK_2_y5_1,
##  AFSENITK_2_y6_1,
##  ELQDEAIK_2_y6_1,
##  IYPTLVIR_2_y6_1,
##  SEVVDQWK_2_y5_1 ...
## INFO  [2025-10-30 01:19:49]  == Start the summarization per subplot...
##   |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
## INFO  [2025-10-30 01:19:49]  == Summarization is done.
```

Inspect `MSstatsLiP_Summarized`.

```
names(MSstatsLiP_Summarized[["LiP"]])
```

```
## [1] "FeatureLevelData"  "ProteinLevelData"  "SummaryMethod"
## [4] "ModelQC"           "PredictBySurvival"
```

```
head(MSstatsLiP_Summarized[["LiP"]]$FeatureLevelData)
```

```
head(MSstatsLiP_Summarized[["LiP"]]$ProteinLevelData)
```

```
head(MSstatsLiP_Summarized[["TrP"]]$FeatureLevelData)
```

```
head(MSstatsLiP_Summarized[["TrP"]]$ProteinLevelData)
```

Save and/or load summarized data.

```
save(MSstatsLiP_Summarized, file = 'MSstatsLiP_summarized.rda')
load(file = 'MSstatsLiP_summarized.rda')
```

# 3. Modelling

Run the modeling to obtain significantly altered peptides and proteins. The function `groupComparisonLiP`outputs a list with three separate models: 1. `LiP.Model`, which contains the differential analysis on peptide level in the LiP sample without correction for protein abundance alterations. 2. `Adjusted.LiP.Model`, which contains the differential analysis on peptide level in the LiP sample with correction for protein abundance alterations 3. `TrP.Model`, which contains the differential analysis on protein level. The default setting of the function is a pairwise comparison of all existing groups. Alternatively, a contrast matrix can be provided to specify the comparisons of interest. See Vignette for details.

```
MSstatsLiP_model = groupComparisonLiP(MSstatsLiP_Summarized)
```

```
## INFO  [2025-10-30 01:19:49]  == Start to test and get inference in whole plot ...
##   |                                                                              |                                                                      |   0%  |                                                                              |========                                                              |  11%  |                                                                              |================                                                      |  22%  |                                                                              |=======================                                               |  33%  |                                                                              |===============================                                       |  44%  |                                                                              |=======================================                               |  56%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================                |  78%  |                                                                              |==============================================================        |  89%  |                                                                              |======================================================================| 100%
## INFO  [2025-10-30 01:19:49]  == Comparisons for all proteins are done.
```

```
## INFO  [2025-10-30 01:19:49]  == Start to test and get inference in whole plot ...
##   |                                                                              |                                                                      |   0%  |                                                                              |==================                                                    |  25%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================================                  |  75%  |                                                                              |======================================================================| 100%
## INFO  [2025-10-30 01:19:49]  == Comparisons for all proteins are done.
```

Inspect `MSstatsLiP_model`.

```
head(MSstatsLiP_model[["LiP.Model"]])
```

```
head(MSstatsLiP_model[["TrP.Model"]])
```

Save and/or load model data.

```
save(MSstatsLiP_model, file = 'MSstatsLiP_model.rda')
load(file = 'MSstatsLiP_model.rda')
```

# 4. Calculate proteolytic resistance ratios

Proteolytic resistance ratios are calculated as the ratio of the intensity of fully tryptic peptides in the LiP condition to the TrP condition. In general, a low protease resistance value is indicative of high extent of cleavage, while high protease resistance values indicate low cleavage extent.

```
Accessibility = calculateProteolyticResistance(MSstatsLiP_Summarized,
                                               fasta_file,
                                               differential_analysis = TRUE)
```

```
## INFO  [2025-10-30 01:19:50]  == Start to test and get inference in whole plot ...
##   |                                                                              |                                                                      |   0%  |                                                                              |========                                                              |  11%  |                                                                              |================                                                      |  22%  |                                                                              |=======================                                               |  33%
```

```
##   |                                                                              |===============================                                       |  44%  |                                                                              |=======================================                               |  56%  |                                                                              |===============================================                       |  67%  |                                                                              |======================================================                |  78%  |                                                                              |==============================================================        |  89%  |                                                                              |======================================================================| 100%
## INFO  [2025-10-30 01:19:50]  == Comparisons for all proteins are done.
```

```
Accessibility$RunLevelData
```

```
ResistanceBarcodePlotLiP(Accessibility,
                         fasta_file,
                         which.prot = "P16622",
                         which.condition = "F1",
                         address = FALSE)
```

![](data:image/png;base64...)

# 5. Proteolytic resistance differential analysis

In this paragraph we described how to compare proteolytic resistance patterns of different conditions, as reported in Cappelletti et al., 2021, Figure 3. As described in the “Protease digestion accessibility analysis” paragraph of Cappelletti et al., proteolytic resistance is calculated as the ratio of the intensity of fully tryptic peptides in the LiP condition to the TrP condition and can be compared across different conditions using the linear mixed effects models-based differential analysis implemented in the MSstatsLiP package. First, infinite values are filtered out from the result of the groupComparisonLiP function. Next, logFCs and standard errors of the LiP (log2FC, s2) and TrP (log2FC\_ref,s2\_ref) models are combined and Student’s T-test is applied to compare proteolytic resistance between different conditions.Finally, p-values are adjusted for multiple comparisons (default is Benjamini & Hochberg method). In general, a low Proteolytic resistance value is indicative of high extent of cleavage, while high Proteolytic resistance values indicate low cleavage extent.

```
Accessibility$groupComparison
```

Save and/or load model data

```
# save(FullyTrp.Model, file = 'Protection_model.rda')
# load(file = 'Protection_model.rda')
```

# 6. Save outputs

Save the output of the modeling in a .csv file.

```
# write.csv(FullyTrp.Model, "Proteolytic_resistance_DA.csv")
```

# 7. Plot aSynuclein proteolytic resistance DA result as barcode

Proteolytic resistance barcodes can be used to visualize FT peptides along the sequence of aSynucelin. Significant peptides showing high protease resistance are colored in red, significant peptides showing a decreased protease resistance are colored in blue and non-significant peptides (no change in protease resistance between conditions) are colored in grey. Black regions represent regions with no identified matching peptide. Position of the NAC domain is indicated by a rectangle.

```
ResistanceBarcodePlotLiP(Accessibility,
                         fasta_file,
                         which.prot = "P16622",
                         which.condition = "F1",
                         differential_analysis = TRUE,
                         which.comp = "F1 vs F2",
                         address = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)