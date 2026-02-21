# MSstats: End to End Workflow

### September 5th, 2024

# **MSstats: Protein/Peptide significance analysis**

Package: MSstats

Author: Anshuman Raina & Devon Kohler

Date: 5th Semptember 2024

## **Introduction**

`MSstats`, an R package in Bioconductor, supports protein differential analysis
for statistical relative quantification of proteins and peptides in global,
targeted and data-independent proteomics. It handles shotgun, label-free and
label-based (universal synthetic peptide-based) SRM (selected reaction
monitoring), and DIA (data independent acquisition) experiments. It can be used
for experiments with complex designs (e.g. comparing more than two experimental
conditions, or a repeated measure design, such as a time course).

This vignette summarizes the introduction and various options of all
functionalities in `MSstats`. More details are available in `User Manual`.

For more information about the MSstats workflow, including a detailed
description of the available processing options and their impact on the
resulting differential analysis, please see the following publication:

Kohler et al, Nature Protocols 19, 2915–2938 (2024).

## **Installation**

To install this package, start R (version “4.0”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstats")
library(MSstats)
library(ggplot2)
```

## **1. Workflow**

### **1.1 Raw Data**

To begin with, we will load sample datasets, including both annotated and plain
data. The dataset you need can be found [here](https://github.com/Vitek-Lab/MSstatsConvert/blob/devel/inst/tinytest/raw_data/PD/pd_input.csv).

We will also load the Annotation Dataset using MSstatsConvert. You can access
this dataset [here](https://github.com/Vitek-Lab/MSstatsConvert/blob/devel/inst/tinytest/raw_data/PD/annot_pd.csv).

```
library(MSstats)

# Load data
pd_raw = system.file("tinytest/raw_data/PD/pd_input.csv",
                    package = "MSstatsConvert")

annotation_raw = system.file("tinytest/raw_data/PD/annot_pd.csv",
                   package = "MSstatsConvert")

pd = data.table::fread(pd_raw)
annotation = data.table::fread(annotation_raw)

head(pd, 5)
```

```
##    Confidence.Level Search.ID Processing.Node.No      Sequence Unique.Sequence.ID PSM.Ambiguity
##              <char>    <char>              <int>        <char>              <int>        <char>
## 1:             High         A                  4     SLIASTLYR               1327   Unambiguous
## 2:             High         A                  4   AYLATQGVEIR               2889   Unambiguous
## 3:             High         A                  4 NHEIIGDIVPLAK               4700   Unambiguous
## 4:             High         A                  4 NHEIIGDIVPLAK               4700   Unambiguous
## 5:             High         A                  4  YHVNQYTGDESR               5209   Unambiguous
##                                                                                                    Protein.Descriptions
##                                                                                                                  <char>
## 1:                                       Uridine kinase OS=Escherichia coli (strain K12) GN=udk PE=3 SV=1 - [URK_ECOLI]
## 2: Imidazole glycerol phosphate synthase subunit HisF OS=Escherichia coli (strain K12) GN=hisF PE=1 SV=1 - [HIS6_ECOLI]
## 3: Imidazole glycerol phosphate synthase subunit HisF OS=Escherichia coli (strain K12) GN=hisF PE=1 SV=1 - [HIS6_ECOLI]
## 4: Imidazole glycerol phosphate synthase subunit HisF OS=Escherichia coli (strain K12) GN=hisF PE=1 SV=1 - [HIS6_ECOLI]
## 5: Imidazole glycerol phosphate synthase subunit HisF OS=Escherichia coli (strain K12) GN=hisF PE=1 SV=1 - [HIS6_ECOLI]
##    X..Proteins X..Protein.Groups Protein.Group.Accessions Modifications Activation.Type DeltaScore DeltaCn
##          <int>             <int>                   <char>        <char>          <char>      <int>   <int>
## 1:           1                 1                   P0A8F4                           CID          1       0
## 2:           1                 1                   P60664                           CID          1       0
## 3:           1                 1                   P60664                           CID          1       0
## 4:           1                 1                   P60664                           CID          1       0
## 5:           1                 1                   P60664                           CID          1       0
##     Rank Search.Engine.Rank Precursor.Area QuanResultID Decoy.Peptides.Matched Exp.Value Homology.Threshold
##    <int>              <int>          <num>       <lgcl>                  <int>     <num>              <int>
## 1:     1                  1       3.26e+07           NA                     NA   2.7e-01                 13
## 2:     1                  1       2.71e+08           NA                     NA   8.4e-05                 13
## 3:     1                  1       1.40e+08           NA                     NA   6.6e-03                 13
## 4:     1                  1       2.13e+08           NA                     NA   4.5e-04                 13
## 5:     1                  1       5.43e+06           NA                     NA   3.8e-02                 13
##    Identity.High Identity.Middle IonScore Peptides.Matched X..Missed.Cleavages Isolation.Interference....
##            <int>           <int>    <int>            <int>               <int>                      <int>
## 1:            13              13       19                6                   0                         53
## 2:            13              13       54                9                   0                         25
## 3:            13              13       35               10                   0                         64
## 4:            13              13       46               10                   0                         50
## 5:            13              13       27                3                   0                         29
##    Ion.Inject.Time..ms. Intensity Charge m.z..Da. MH...Da. Delta.Mass..Da. Delta.Mass..PPM. RT..min.
##                   <int>     <num>  <int>    <num>    <num>           <int>            <num>    <num>
## 1:                    3   1590000      2 512.2952 1023.583               0            -0.17    48.61
## 2:                    0  17200000      2 610.8357 1220.664               0             0.67    45.31
## 3:                    1   3100000      3 473.6051 1418.801               0             0.35    58.58
## 4:                    3   2020000      2 709.9044 1418.802               0             0.92    58.53
## 5:                   12    579000      2 734.8257 1468.644               0            -0.74    23.52
##    First.Scan Last.Scan MS.Order Ions.Matched Matched.Ions Total.Ions
##         <int>     <int>   <char>       <char>        <int>      <int>
## 1:      14971     14971      MS2       Jun-74            6         74
## 2:      13599     13599      MS2       Sep-98            9         98
## 3:      19004     19004      MS2        8/128            8        128
## 4:      18981     18981      MS2       14/128           14        128
## 5:       4707      4707      MS2        8/112            8        112
##                                      Spectrum.File Annotation
##                                             <char>     <lgcl>
## 1: 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw         NA
## 2: 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw         NA
## 3: 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw         NA
## 4: 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw         NA
## 5: 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw         NA
```

```
head(annotation, 5)
```

```
##                                                Run  Condition BioReplicate
##                                             <char>     <char>        <int>
## 1: 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw Condition1            1
## 2: 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2.raw Condition1            1
## 3: 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3.raw Condition1            1
## 4: 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1.raw Condition2            2
## 5: 121219_S_CCES_01_05_LysC_Try_1to10_Mixt_2_2.raw Condition2            2
```

### **1.2 Loading PD Data to MSstats**

The imported data from Step 1.1. now must be converted through `MSstatsConvert`
package’s `PDtoMSstatsFormat` converter.

This function converts the Proteome Discoverer output into the required input
format for `MSstats`.

Actual data modification can be seen below:

```
library(MSstatsConvert)

pd_imported = MSstatsConvert::PDtoMSstatsFormat(pd, annotation,
                                                use_log_file = FALSE)
```

```
## INFO  [2026-01-22 19:04:16] ** Raw data from ProteomeDiscoverer imported successfully.
## INFO  [2026-01-22 19:04:16] ** Raw data from ProteomeDiscoverer cleaned successfully.
## INFO  [2026-01-22 19:04:16] ** Using provided annotation.
## INFO  [2026-01-22 19:04:16] ** Run labels were standardized to remove symbols such as '.' or '%'.
## INFO  [2026-01-22 19:04:16] ** The following options are used:
##   - Features will be defined by the columns: PeptideSequence, PrecursorCharge
##   - Shared peptides will be removed.
##   - Proteins with single feature will not be removed.
##   - Features with less than 3 measurements across runs will be removed.
## INFO  [2026-01-22 19:04:16] ** Features with all missing measurements across runs are removed.
## INFO  [2026-01-22 19:04:16] ** Shared peptides are removed.
```

```
## INFO  [2026-01-22 19:04:16] ** Multiple measurements in a feature and a run are summarized by summaryforMultipleRows: max
## INFO  [2026-01-22 19:04:16] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:04:16] ** Run annotation merged with quantification data.
## INFO  [2026-01-22 19:04:16] ** Features with one or two measurements across runs are removed.
## INFO  [2026-01-22 19:04:16] ** Fractionation handled.
## INFO  [2026-01-22 19:04:16] ** Updated quantification data to make balanced design. Missing values are marked by NA
## INFO  [2026-01-22 19:04:16] ** Finished preprocessing. The dataset is ready to be processed by the dataProcess function.
```

```
head(pd_imported)
```

```
##   ProteinName PeptideModifiedSequence PrecursorCharge FragmentIon ProductCharge IsotopeLabelType  Condition
## 1      P0ABU9         ANSHAPEAVVEGASR               2          NA            NA                L Condition1
## 2      P0ABU9         ANSHAPEAVVEGASR               2          NA            NA                L Condition1
## 3      P0ABU9         ANSHAPEAVVEGASR               2          NA            NA                L Condition1
## 4      P0ABU9         ANSHAPEAVVEGASR               2          NA            NA                L Condition2
## 5      P0ABU9         ANSHAPEAVVEGASR               2          NA            NA                L Condition2
## 6      P0ABU9         ANSHAPEAVVEGASR               2          NA            NA                L Condition2
##   BioReplicate                                            Run Fraction Intensity
## 1            1 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1raw        1  21400000
## 2            1 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2raw        1  17500000
## 3            1 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3raw        1        NA
## 4            2 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1raw        1  11600000
## 5            2 121219_S_CCES_01_05_LysC_Try_1to10_Mixt_2_2raw        1  12000000
## 6            2 121219_S_CCES_01_06_LysC_Try_1to10_Mixt_2_3raw        1  16200000
```

### **1.3 Converters**

We have the following converters, which allow you to convert various types of
output reports which include the feature level data to the required input format
of `MSstats`. Further information about the converters can be found in the
`MSstatsConvert` package.

1. `DIANNtoMSstatsFormat`
2. `DIAUmpiretoMSstatsFormat`
3. `FragPipetoMSstatsFormat`
4. `MaxQtoMSstatsFormat`
5. `OpenMStoMSstatsFormat`
6. `OpenSWATHtoMSstatsFormat`
7. `PDtoMSstatsFormat`
8. `ProgenesistoMSstatsFormat`
9. `SkylinetoMSstatsFormat`
10. `SpectronauttoMSstatsFormat`
11. `MetamorpheusToMSstatsFormat`

We show an example of how to use the above said Converters. For more information
about using the individual converters please see the coresponding documentation.

```
skyline_raw = system.file("tinytest/raw_data/Skyline/skyline_input.csv",
                    package = "MSstatsConvert")

skyline = data.table::fread(skyline_raw)
head(skyline, 5)
```

```
##        X Protein.Name Peptide.Modified.Sequence Precursor.Charge Fragment.Ion Product.Charge
##    <int>       <char>                    <char>            <int>       <char>          <int>
## 1: 28081       P23827            LPIVVYTPDNVDVK                2    precursor              2
## 2: 28082       P23827            LPIVVYTPDNVDVK                2    precursor              2
## 3: 28083       P23827            LPIVVYTPDNVDVK                2    precursor              2
## 4: 28084       P23827            LPIVVYTPDNVDVK                2    precursor              2
## 5: 28085       P23827            LPIVVYTPDNVDVK                2    precursor              2
##    Isotope.Label.Type Condition BioReplicate                                       File.Name      Area
##                <char>    <char>        <int>                                          <char>     <num>
## 1:              light      Mix1            1 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1.raw 173812688
## 2:              light      Mix1            2 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2.raw 193830304
## 3:              light      Mix1            3 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3.raw 185620528
## 4:              light      Mix2            4 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1.raw 154545824
## 5:              light      Mix2            5 121219_S_CCES_01_05_LysC_Try_1to10_Mixt_2_2.raw 169726768
##    Standard.Type Truncated
##           <lgcl>    <lgcl>
## 1:            NA     FALSE
## 2:            NA     FALSE
## 3:            NA     FALSE
## 4:            NA     FALSE
## 5:            NA     FALSE
```

```
msstats_format = MSstatsConvert::SkylinetoMSstatsFormat(skyline_raw,
                                      qvalue_cutoff = 0.01,
                                      useUniquePeptide = TRUE,
                                      removeFewMeasurements = TRUE,
                                      removeOxidationMpeptides = TRUE,
                                      removeProtein_with1Feature = TRUE)
```

```
head(msstats_format)
```

```
##   ProteinName      PeptideSequence PrecursorCharge FragmentIon ProductCharge IsotopeLabelType Condition
## 1      P00370 AANAGGVATSGLEMAQNAAR               3          NA            NA            light      Mix1
## 2      P00370 AANAGGVATSGLEMAQNAAR               3          NA            NA            light      Mix1
## 3      P00370 AANAGGVATSGLEMAQNAAR               3          NA            NA            light      Mix1
## 4      P00370 AANAGGVATSGLEMAQNAAR               3          NA            NA            light      Mix2
## 5      P00370 AANAGGVATSGLEMAQNAAR               3          NA            NA            light      Mix2
## 6      P00370 AANAGGVATSGLEMAQNAAR               3          NA            NA            light      Mix2
##   BioReplicate                                            Run Fraction  Intensity
## 1            1 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1raw        1 5311459776
## 2            2 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2raw        1 4900185344
## 3            3 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3raw        1 5323685504
## 4            4 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1raw        1 5327922240
## 5            5 121219_S_CCES_01_05_LysC_Try_1to10_Mixt_2_2raw        1 5824830336
## 6            6 121219_S_CCES_01_06_LysC_Try_1to10_Mixt_2_3raw        1 5674675584
```

### **1.4 Data Process**

Once we import the dataset correctly with Converter, we need to pre-process the
data which is done by the `dataProcess` function. This step involves data
processing and quality control of the measured feature intensities.

This function includes 5 main processing steps (with other additional small
steps):

* **Log transformation** - Transform the feature intensities from their original
  scale to the log scale. This step helps make the data closer to being normally
  distributed, requiring less replicates for the central limit theorem to kick in.
* **Normalization** - There are three different normalization options supported.
  ‘equalizeMedians’ (default) represents constant normalization (equalizing the
  medians) based on reference signals is performed. ‘quantile’ represents
  quantile normalization based on reference signals is performed.
  ‘globalStandards’ represents normalization with global standards proteins.
  FALSE represents no normalization is performed.
* **Feature selection** - This also has three options i.e. Select All features,
  Top-N features (by mean intensity) or “Best” features.
* **Missing value imputation** - We impute plausible values in case of missing
  data points. The RunLevelData can be queried to show Number of imputed
  intensities (censored intensities) in a RUN and Protein.
* **Summarization** - After data processing the individual features are
  summarized up to the protein-level using Tukey’s Median Polish. Linear
  summarization is also available as an option.

```
summarized = dataProcess(
    pd_imported,
    logTrans = 2,
    normalization = "equalizeMedians",
    featureSubset = "all",
    n_top_feature = 3,
    summaryMethod = "TMP",
    equalFeatureVar = TRUE,
    censoredInt = "NA",
    MBimpute = TRUE
    )
```

```
## INFO  [2026-01-22 19:04:16] ** Log2 intensities under cutoff = 23.053  were considered as censored missing values.
## INFO  [2026-01-22 19:04:16] ** Log2 intensities = NA were considered as censored missing values.
## INFO  [2026-01-22 19:04:16] ** Use all features that the dataset originally has.
## INFO  [2026-01-22 19:04:16]
##  # proteins: 5
##  # peptides per protein: 1-16
##  # features per peptide: 1-1
## INFO  [2026-01-22 19:04:16] Some proteins have only one feature:
##  P00363,
##  P0A8J2 ...
## INFO  [2026-01-22 19:04:16]
##                     Condition1 Condition2 Condition3 Condition4 Condition5
##              # runs          3          3          3          3          3
##     # bioreplicates          1          1          1          1          1
##  # tech. replicates          3          3          3          3          3
## INFO  [2026-01-22 19:04:16] Some features are completely missing in at least one condition:
##  AYLATQGVEIR_2_NA_NA,
##  DADVDGALAASVFHK_3_NA_NA,
##  ELREQVGDEHIGVIPEDcYYKC18(Carbamidomethyl)_3_NA_NA,
##  ILSFGADK_2_NA_NA,
##  LARPGSDVALDDQLYQEPQAAPVAVPMGK_3_NA_NA ...
## INFO  [2026-01-22 19:04:16]  == Start the summarization per subplot...
##
  |
  |                                                                                                    |   0%
  |
  |====================                                                                                |  20%
  |
  |========================================                                                            |  40%
  |
  |============================================================                                        |  60%
  |
  |================================================================================                    |  80%
  |
  |====================================================================================================| 100%
## INFO  [2026-01-22 19:04:16]  == Summarization is done.
```

```
head(summarized$FeatureLevelData)
```

```
##   PROTEIN           PEPTIDE TRANSITION                 FEATURE LABEL      GROUP RUN SUBJECT FRACTION
## 1  P0ABU9 ANSHAPEAVVEGASR_2      NA_NA ANSHAPEAVVEGASR_2_NA_NA     L Condition1   1       1        1
## 2  P0ABU9 ANSHAPEAVVEGASR_2      NA_NA ANSHAPEAVVEGASR_2_NA_NA     L Condition1   2       1        1
## 3  P0ABU9 ANSHAPEAVVEGASR_2      NA_NA ANSHAPEAVVEGASR_2_NA_NA     L Condition1   3       1        1
## 4  P0ABU9 ANSHAPEAVVEGASR_2      NA_NA ANSHAPEAVVEGASR_2_NA_NA     L Condition2   4       2        1
## 5  P0ABU9 ANSHAPEAVVEGASR_2      NA_NA ANSHAPEAVVEGASR_2_NA_NA     L Condition2   5       2        1
## 6  P0ABU9 ANSHAPEAVVEGASR_2      NA_NA ANSHAPEAVVEGASR_2_NA_NA     L Condition2   6       2        1
##                                      originalRUN censored INTENSITY ABUNDANCE newABUNDANCE predicted
## 1 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1raw    FALSE  21400000  23.71945     23.71945        NA
## 2 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2raw    FALSE  17500000  24.06085     24.06085        NA
## 3 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3raw     TRUE        NA        NA     22.77604  22.77604
## 4 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1raw    FALSE  11600000  23.77304     23.77304        NA
## 5 121219_S_CCES_01_05_LysC_Try_1to10_Mixt_2_2raw     TRUE  12000000  23.00805     22.95207  22.95207
## 6 121219_S_CCES_01_06_LysC_Try_1to10_Mixt_2_3raw    FALSE  16200000  23.74312     23.74312        NA
```

```
head(summarized$ProteinLevelData)
```

```
##   RUN Protein LogIntensities                                    originalRUN      GROUP SUBJECT
## 1   1  P0A8F4       22.96185 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1raw Condition1       1
## 2   2  P0A8F4       23.27048 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2raw Condition1       1
## 3   3  P0A8F4       23.44357 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3raw Condition1       1
## 4   4  P0A8F4       23.31217 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1raw Condition2       2
## 5   6  P0A8F4       23.87516 121219_S_CCES_01_06_LysC_Try_1to10_Mixt_2_3raw Condition2       2
## 6   8  P0A8F4       24.31958 121219_S_CCES_01_08_LysC_Try_1to10_Mixt_3_2raw Condition3       3
##   TotalGroupMeasurements NumMeasuredFeature MissingPercentage more50missing NumImputedFeature
## 1                      9                  1         0.6666667          TRUE                 2
## 2                      9                  1         0.6666667          TRUE                 2
## 3                      9                  1         0.6666667          TRUE                 2
## 4                      9                  1         0.6666667          TRUE                 2
## 5                      9                  1         0.6666667          TRUE                 2
## 6                      9                  2         0.3333333         FALSE                 1
```

```
head(summarized$SummaryMethod)
```

```
## [1] "TMP"
```

### **1.4.1 Data Processing Options**

Reference: [Kohler et al. 2024](https://www.nature.com/articles/s41596-024-01000-3#Sec20)

#### Normalization

Four options for normalization are included in MSstats: median, quantile, global standards and no normalization. There is no single best normalization for all experiments. Researchers must consider the assumptions underlying each normalization option and the appropriateness of the assumptions for their study. Below, we summarize the normalization options, their assumptions and the effect on downstream statistical analysis.

| Name | Description | Assumption | Effect |
| --- | --- | --- | --- |
| Median | Equalize medians of all log feature intensities in each run | All steps of data collection and acquisition were randomized | The normalization estimates the artifact deviations in each run with a single quantity, reducing overfitting |
|  |  | Most of the proteins in the experiment are the same and have the same concentration for all of the runs. The experimental artifacts affect every peptide in a run by the same constant amount | The normalization reduces bias and variance of the estimated log fold change |
| Quantile | Equalize the distributions of all log feature intensities in each run | All steps of data collection and acquisition were randomized | The normalization estimates the artifact deviations in each run with a complex non-linear function, potentially leading to overfitting |
|  |  | Most of the proteins in the experiment are the same and have the same concentration for all of the runs. The experimental artifacts affect every peptide non-linearly, as a function of its log intensity | The normalization reduces bias and variance of the estimated log fold change but may over-correct |
| Global standards | Equalize median log-intensities of endogenous or spiked-in reference peptides or proteins. Apply adjustment to the remainder of log feature intensities | All steps of data collection and acquisition were randomized | The normalization estimates the artifact deviations in each run with a single quantity, which reduces overfitting |
|  |  | The reference peptides or proteins are present in each run and have the same concentration for all of the runs. All experimental artifacts occur only after standards were added. | The normalization estimates the artifact deviations from a small number of peptides, which may increase overfitting. The normalization does not eliminate artifacts that occurred before adding spiked references |
|  |  | The experimental artifacts affect every protein in a run by the same constant amount | The normalization reduces bias and variance of the estimated log fold change |
| None | Do not apply any normalization | All steps of data collection and acquisition were randomized | All patterns of variation of interest and of nuisance variation are preserved |
|  |  | The experiment has no systematic artifacts or has been normalized in another custom manner |  |

If the assumptions of the normalization are not verified, the normalization may, in fact, increase bias or variance of the estimated log fold change. For example, if the experiment is not randomized and the experimental artifacts are confounded with the conditions, the median and quantile normalizations will introduce bias.

#### Feature Selection

Feature selection is used to determine which protein features should be used to infer the overall protein abundance in a sample. The options here are:

* Using all features
* Using the top ‘N’ features
* Removing uninformative features and outliers

Using all features will simply leverage all available information to infer the underlying protein abundance. Top ‘N’ features selects a pre-specified number of features with the highest average intensity across all runs for protein-level inference. This option is useful if you believe that the features with lower average intensity are less reliable, or in cases in which some of the proteins have a very large number of features (such as in DIA experiments). For any individual protein, it is usually possible to determine changes in abundance by looking at the peaks with highest intensity; in these cases, using all features results in redundancy while greatly increasing the computational processing time. Finally, removing uninformative features and outliers attempts to select the ‘best’ features by removing features that have too many missing values, that are too noisy or have outliers.

#### Missing Value Imputation

Missing value imputation attempts to infer feature intensities in runs in which they were not measured. MSstats imputes these values by using an accelerated failure time model

| Name | Description | Assumption | Effect |
| --- | --- | --- | --- |
| Imputation | Infer missing feature intensities by using an accelerated failure time model. It will not impute for runs in which all features are missing | Features are missing for reasons of low abundance (e.g., features are missing not at random) | If the assumption is true, imputation will remove bias toward high intensities in the summarization step. Otherwise, bias will be introduced via inaccurate imputation |
| No imputation | Do not apply imputation | Assume no information about reasons for missingness or that features are missing at random | If the assumption is true, no new bias will be introduced. Otherwise, if features are missing for reasons of low abundance, summarized values will be biased toward high intensities |

### **1.4.2 Data Process Plots**

After processing the input data, `MSstats` provides multiple plots to analyze the
results. Here we show the various types of plots we can use. By default, a
pdf file will be downloaded with corresponding feature level data and the Plot
generated. Alternatively, the `address` parameter can be set to `FALSE` which
will output the plots directly.

```
# Profile plot
dataProcessPlots(data=summarized, type="ProfilePlot",
                 address = FALSE, which.Protein = "P0ABU9")
```

![plot of chunk dataProcessPlots](data:image/png;base64...)![plot of chunk dataProcessPlots](data:image/png;base64...)

```
# Quality control plot
dataProcessPlots(data=summarized, type="QCPlot",
                 address = FALSE, which.Protein = "P0ABU9")
```

![plot of chunk dataProcessPlots](data:image/png;base64...)

```
# Quantification plot for conditions
dataProcessPlots(data=summarized, type="ConditionPlot",
                 address = FALSE, which.Protein = "P0ABU9")
```

![plot of chunk dataProcessPlots](data:image/png;base64...)

### \_\_1.5 Modeling \_\_

In this step we test for differential changes in protein abundance across
conditions using a linear mixed-effects model. The model will be automatically
adjusted based on your experimental design.

A contrast matrix must be provided to the model. Alternatively, all pairwise
comparisons can be made by passing `pairwise` to the function. For more
information on creating contrast matrices, please see the citation linked
at the beginning of this document.

```
model = groupComparison("pairwise", summarized)
```

```
## INFO  [2026-01-22 19:04:18]  == Start to test and get inference in whole plot ...
##
  |
  |                                                                                                    |   0%
  |
  |=========================                                                                           |  25%
  |
  |==================================================                                                  |  50%
  |
  |===========================================================================                         |  75%
  |
  |====================================================================================================| 100%
## INFO  [2026-01-22 19:04:19]  == Comparisons for all proteins are done.
```

Model Details

```
head(model$ModelQC)
```

```
##   RUN Protein ABUNDANCE                                    originalRUN      GROUP SUBJECT
## 1   1  P0A8F4  22.96185 121219_S_CCES_01_01_LysC_Try_1to10_Mixt_1_1raw Condition1       1
## 2   2  P0A8F4  23.27048 121219_S_CCES_01_02_LysC_Try_1to10_Mixt_1_2raw Condition1       1
## 3   3  P0A8F4  23.44357 121219_S_CCES_01_03_LysC_Try_1to10_Mixt_1_3raw Condition1       1
## 4   4  P0A8F4  23.31217 121219_S_CCES_01_04_LysC_Try_1to10_Mixt_2_1raw Condition2       2
## 5   6  P0A8F4  23.87516 121219_S_CCES_01_06_LysC_Try_1to10_Mixt_2_3raw Condition2       2
## 6   8  P0A8F4  24.31958 121219_S_CCES_01_08_LysC_Try_1to10_Mixt_3_2raw Condition3       3
##   TotalGroupMeasurements NumMeasuredFeature MissingPercentage more50missing NumImputedFeature   residuals
## 1                      9                  1         0.6666667          TRUE                 2 -0.26344817
## 2                      9                  1         0.6666667          TRUE                 2  0.04517815
## 3                      9                  1         0.6666667          TRUE                 2  0.21827003
## 4                      9                  1         0.6666667          TRUE                 2 -0.28149357
## 5                      9                  1         0.6666667          TRUE                 2  0.28149357
## 6                      9                  2         0.3333333         FALSE                 1  0.66038185
##     fitted
## 1 23.22530
## 2 23.22530
## 3 23.22530
## 4 23.59366
## 5 23.59366
## 6 23.65919
```

```
head(model$ComparisonResult)
```

```
##   Protein                    Label      log2FC        SE      Tvalue DF     pvalue adj.pvalue issue
## 1  P0A8F4 Condition1 vs Condition2 -0.36836494 0.6911553 -0.53296987  8 0.60853706 0.77204073  <NA>
## 2  P0A8F4 Condition1 vs Condition3 -0.43389600 0.6911553 -0.62778367  8 0.54764284 0.97435691  <NA>
## 3  P0A8F4 Condition1 vs Condition4 -1.12564427 0.6181881 -1.82087672  8 0.10610956 0.10610956  <NA>
## 4  P0A8F4 Condition1 vs Condition5 -1.15790197 0.6181881 -1.87305776  8 0.09794554 0.09794554  <NA>
## 5  P0A8F4 Condition2 vs Condition3 -0.06553106 0.7571227 -0.08655276  8 0.93315414 0.96560198  <NA>
## 6  P0A8F4 Condition2 vs Condition4 -0.75727933 0.6911553 -1.09567178  8 0.30510791 0.30510791  <NA>
##   MissingPercentage ImputationPercentage
## 1         0.7222222            0.5555556
## 2         0.6666667            0.5000000
## 3         0.6111111            0.6111111
## 4         0.6111111            0.6111111
## 5         0.7222222            0.3888889
## 6         0.6666667            0.5000000
```

### **1.5.1 How to Account for Covariates**

If you’re comparing disease vs. control, you may also want to account for other factors (covariates) like gender. Here’s how you can do that step-by-step:

#### Step 1: Set up your conditions

In your annotation file, define each condition as a combination of the disease status and the covariate. For example, you could label your samples like this:

* `Control_Male`
* `Control_Female`
* `Disease_Male`
* `Disease_Female`

#### Step 2: Create a contrast matrix

The contrast matrix defines how you want to compare the groups. The order of the conditions in the matrix should match the order you define:

**Example 1: Compare Control vs. Disease**
If you want to compare **control vs. disease** (averaging over gender), you can define the contrast matrix like this:

```
# Order of conditions: control_male, control_female, disease_male, disease_female
contrast.matrix = matrix(c(0.5, 0.5, -0.5, -0.5), nrow = 1)
colnames(contrast.matrix) = c("Control_Male", "Control_Female", "Disease_Male", "Disease_Female")
row.names(contrast.matrix) <- "Control - Disease"
```

* `0.5` for `Control_Male` and `Control_Female` means you’re averaging the control samples.
* `-0.5` for `Disease_Male` and `Disease_Female` means you’re averaging the disease samples and subtracting them from the control average.

**Example 2: Compare Male vs. Female**
If you want to compare **male vs. female** (averaging over disease status), set up the contrast matrix like this:

```
# Order of conditions: control_male, control_female, disease_male, disease_female
contrast.matrix = matrix(c(0.5, -0.5, 0.5, -0.5), nrow = 1)
colnames(contrast.matrix) = c("Control_Male", "Control_Female", "Disease_Male", "Disease_Female")
row.names(contrast.matrix) <- "Male - Female"
```

* 0.5 for Control\_Male and Disease\_Male means you’re averaging the male samples.
* -0.5 for Control\_Female and Disease\_Female means you’re averaging the female samples and subtracting them from the male average.

This setup allows you to control for gender while testing the main effect of disease, or vice versa.

### **1.5.2 groupComparisonPlot**

Visualization for model-based analysis and summarizing differentially abundant
proteins. To summarize the results of log-fold changes and adjusted p-values
for differentially abundant proteins, `groupComparisonPlots` takes testing
results from function `groupComparison` as input and automatically generate
three types of figures in pdf files as output :

* **Volcano plot** : For each comparison separately. It illustrates actual
  log-fold changes and adjusted p-values for each comparison separately with all
  proteins. The x-axis is the log fold change. The base of logarithm
  transformation is the same as specified in “logTrans” from `dataProcess`. The
  y-axis is the negative log2 or log10 adjusted p-values. The horizontal dashed
  line represents the FDR cutoff. The points below the FDR cutoff line are
  non-significantly abundant proteins (colored in black). The points above the
  FDR cutoff line are significantly abundant proteins (colored in red/blue for
  up-/down-regulated). If fold change cutoff is specified (FCcutoff = specific
  value), the points above the FDR cutoff line but within the FC cutoff line are
  non-significantly abundant proteins (colored in black).
* **Heatmap** : For multiple comparisons. It illustrates up-/down-regulated
  proteins for multiple comparisons with all proteins. Each column represents
  each comparison of interest. Each row represents each protein. Color red/blue
  represents proteins in that specific comparison are significantly
  up-regulated/down-regulated proteins with FDR cutoff and/or FC cutoff. The
  color scheme shows the evidences of significance. The darker color it is, the
  stronger evidence of significance it has. Color gold represents proteins are
  not significantly different in abundance.
* **Comparison plot** : For multiple comparisons per protein. It illustrates
  log-fold change and its variation of multiple comparisons for single protein.
  X-axis is comparison of interest. Y-axis is the log fold change. The red points
  are the estimated log fold change from the model. The error bars are the
  confidence interval with 0.95 significant level for log fold change. This
  interval is only based on the standard error, which is estimated from the model.

```
groupComparisonPlots(
  model$ComparisonResult,
  type="Heatmap",
  sig = 0.05,
  FCcutoff = FALSE,
  logBase.pvalue = 10,
  ylimUp = FALSE,
  ylimDown = FALSE,
  xlimUp = FALSE,
  x.axis.size = 10,
  y.axis.size = 10,
  dot.size = 3,
  text.size = 4,
  text.angle = 0,
  legend.size = 13,
  ProteinName = TRUE,
  colorkey = TRUE,
  numProtein = 100,
  clustering = "both",
  width = 800,
  height = 600,
  which.Comparison = "all",
  which.Protein = "all",
  address = FALSE,
  isPlotly = FALSE
)
```

![plot of chunk GroupComparisonPlots](data:image/png;base64...)![plot of chunk GroupComparisonPlots](data:image/png;base64...)

```
groupComparisonPlots(
  model$ComparisonResult,
  type="VolcanoPlot",
  sig = 0.05,
  FCcutoff = FALSE,
  logBase.pvalue = 10,
  ylimUp = FALSE,
  ylimDown = FALSE,
  xlimUp = FALSE,
  x.axis.size = 10,
  y.axis.size = 10,
  dot.size = 3,
  text.size = 4,
  text.angle = 0,
  legend.size = 13,
  ProteinName = TRUE,
  colorkey = TRUE,
  numProtein = 100,
  clustering = "both",
  width = 800,
  height = 600,
  which.Comparison = "Condition2 vs Condition4",
  which.Protein = "all",
  address = FALSE,
  isPlotly = FALSE
)
```

```
## [1] "labels"
## [1] "Condition2 vs Condition4"
```

![plot of chunk GroupComparisonPlots](data:image/png;base64...)

### **1.6 GroupComparisonQCPlots**

To check and verify that the resultant data of `groupComparison` offers a linear
model for whole plot inference, `groupComparisonQC` plots take the fitted data
and provide two ways of plotting:

1. Normal Q-Q plot : Quantile-Quantile plots represents normal quantile-quantile
   plot for each protein after fitting models
2. Residual plot : represents a plot of residuals versus fitted values for each
   protein in the dataset.

Results based on statistical models for whole plot level inference are accurate
as long as the assumptions of the model are met. The model assumes that the
measurement errors are normally distributed with mean 0 and constant variance.
The assumption of a constant variance can be checked by examining the residuals
from the model.

```
source("..//R//groupComparisonQCPlots.R")

groupComparisonQCPlots(data=model, type="QQPlots", address=FALSE,
                       which.Protein = "P0ABU9")
```

![plot of chunk GroupComparisonQCplots](data:image/png;base64...)

```
groupComparisonQCPlots(data=model, type="ResidualPlots", address=FALSE,
                       which.Protein = "P0ABU9")
```

![plot of chunk GroupComparisonQCplots](data:image/png;base64...)

### **1.7 Sample Size Calculation**

Calculate sample size for future experiments of a Selected Reaction
Monitoring (SRM), Data-Dependent Acquisition (DDA or shotgun), and
Data-Independent Acquisition (DIA or SWATH-MS) experiment based on
intensity-based linear model. The function fits the model and uses variance
components to calculate sample size. The underlying model fitting with
intensity-based linear model with technical MS run replication. Estimated
sample size is rounded to 0 decimal. Two options of the calculation:

* number of biological replicates per condition
* power

```
sample_size_calc = designSampleSize(model$FittedModel,
                                    desiredFC=c(1.75,2.5),
                                    power = TRUE,
                                    numSample=5)
```

### **1.7.1 Sample Size Calculation Plot**

To illustrate the relationship of desired fold change and the calculated minimal
number sample size which are

The input is the result from function `designSampleSize`.

```
designSampleSizePlots(sample_size_calc, isPlotly=FALSE)
```

![plot of chunk Sample Size plot](figure/Sample Size plot-1.png)

### **1.8 Quantification from groupComparison Data**

Model-based quantification for each condition or for each biological samples
per protein in a targeted Selected Reaction Monitoring (SRM), Data-Dependent
Acquisition (DDA or shotgun), and Data-Independent Acquisition
(DIA or SWATH-MS) experiment. Quantification takes the processed data set by
`dataProcess` as input and automatically generate the quantification results
(data.frame) with long or matrix format. The quantification for endogenous
samples is based on run summarization from subplot model, with TMP robust
estimation.

* Sample quantification : individual biological sample quantification for
  each protein. The label of each biological sample is a combination of the
  corresponding group and the sample ID. If there are no technical replicates or
  experimental replicates per sample, sample quantification is the same as run
  summarization from `dataProcess` (`RunlevelData` from `dataProcess`). If there
  are technical replicates or experimental replicates, sample quantification is
  median among run quantification corresponding MS runs.
* Group quantification : quantification for individual group or individual
  condition per protein. It is median among sample quantification.

```
sample_quant_long = quantification(summarized,
                             type = "Sample",
                             format = "long")
sample_quant_long
```

```
##     Protein Group_Subject LogIntensity
##      <fctr>        <fctr>        <num>
##  1:  P0A8F4  Condition1_1     23.27048
##  2:  P0A8J2  Condition1_1     25.41377
##  3:  P0ABU9  Condition1_1     23.94076
##  4:  P60664  Condition1_1     26.95914
##  5:  P0A8F4  Condition2_2     23.59366
##  6:  P0A8J2  Condition2_2     25.37768
##  7:  P0ABU9  Condition2_2     24.35179
##  8:  P60664  Condition2_2     27.36184
##  9:  P0A8F4  Condition3_3     23.65919
## 10:  P0A8J2  Condition3_3     24.84218
## 11:  P0ABU9  Condition3_3     23.97927
## 12:  P60664  Condition3_3     26.89201
## 13:  P0A8F4  Condition4_4     24.04638
## 14:  P0A8J2  Condition4_4           NA
## 15:  P0ABU9  Condition4_4     24.96019
## 16:  P60664  Condition4_4     27.69317
## 17:  P0A8F4  Condition5_5     24.50374
## 18:  P0A8J2  Condition5_5           NA
## 19:  P0ABU9  Condition5_5     25.42248
## 20:  P60664  Condition5_5     27.98325
##     Protein Group_Subject LogIntensity
##      <fctr>        <fctr>        <num>
```

```
sample_quant_wide = quantification(summarized,
                              type = "Sample",
                              format = "matrix")
sample_quant_wide
```

```
## Key: <Protein>
##    Protein Condition1_1 Condition2_2 Condition3_3 Condition4_4 Condition5_5
##     <fctr>        <num>        <num>        <num>        <num>        <num>
## 1:  P0A8F4     23.27048     23.59366     23.65919     24.04638     24.50374
## 2:  P0A8J2     25.41377     25.37768     24.84218           NA           NA
## 3:  P0ABU9     23.94076     24.35179     23.97927     24.96019     25.42248
## 4:  P60664     26.95914     27.36184     26.89201     27.69317     27.98325
```

```
group_quant_long = quantification(summarized,
                                  type = "Group",
                                  format = "long")
group_quant_long
```

```
##     Protein      Group LogIntensity
##      <fctr>     <fctr>        <num>
##  1:  P0A8F4 Condition1     23.27048
##  2:  P0A8J2 Condition1     25.41377
##  3:  P0ABU9 Condition1     23.94076
##  4:  P60664 Condition1     26.95914
##  5:  P0A8F4 Condition2     23.59366
##  6:  P0A8J2 Condition2     25.37768
##  7:  P0ABU9 Condition2     24.35179
##  8:  P60664 Condition2     27.36184
##  9:  P0A8F4 Condition3     23.65919
## 10:  P0A8J2 Condition3     24.84218
## 11:  P0ABU9 Condition3     23.97927
## 12:  P60664 Condition3     26.89201
## 13:  P0A8F4 Condition4     24.04638
## 14:  P0A8J2 Condition4           NA
## 15:  P0ABU9 Condition4     24.96019
## 16:  P60664 Condition4     27.69317
## 17:  P0A8F4 Condition5     24.50374
## 18:  P0A8J2 Condition5           NA
## 19:  P0ABU9 Condition5     25.42248
## 20:  P60664 Condition5     27.98325
##     Protein      Group LogIntensity
##      <fctr>     <fctr>        <num>
```

```
group_quant_wide = quantification(summarized,
                                  type = "Group",
                                  format = "matrix")
group_quant_wide
```

```
## Key: <Protein>
##    Protein Condition1 Condition2 Condition3 Condition4 Condition5
##     <fctr>      <num>      <num>      <num>      <num>      <num>
## 1:  P0A8F4   23.27048   23.59366   23.65919   24.04638   24.50374
## 2:  P0A8J2   25.41377   25.37768   24.84218         NA         NA
## 3:  P0ABU9   23.94076   24.35179   23.97927   24.96019   25.42248
## 4:  P60664   26.95914   27.36184   26.89201   27.69317   27.98325
```