# MSstatsTMT : A package for protein significance analysis in shotgun mass spectrometry-based proteomic experiments with tandem mass tag (TMT) labeling

#### Ting Huang (thuang0703@gmail.com), Meena Choi (mnchoi67@gmail.com), Mateusz Staniak (mtst@mstaniak.pl), Sicheng Hao (hao.sic@husky.neu.edu), Olga Vitek(o.vitek@northeastern.edu)

#### 2025-10-30

## 0. Load MSstatsTMT

Load MSstatsTMT first. Then you are ready to start MSstatsTMT

```
# ## Install MSstatsTMT package from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
#
# BiocManager::install("MSstatsTMT")

library(MSstatsTMT)
```

This vignette summarizes the introduction and various options of all functionalities in MSstatsTMT.

* A set of tools for detecting differentially abundant peptides and proteins in shotgun mass spectrometry-based proteomic experiments with tandem mass tag (TMT) labeling.
* The types of experiment that MSstatsTMT supports for metabolic labeling or iTRAQ experiments. LC-MS, SRM, DIA(SWATH) with label-free or labeled synthetic peptides can be analyzed with other R package, MSstats.

MSstatsTMT includes the following three steps for statistical testing:

1. Converters for different peptide quantification tools to get the input with required format: `PDtoMSstatsTMTFormat`, `MaxQtoMSstatsTMTFormat`, `SpectroMinetoMSstatsTMTFormat`, `OpenMStoMSstatsTMTFormat` and `PhilosophertoMSstatsTMTFormat`.
2. Protein summarization based on peptide quantification data: `proteinSummarization`
3. Group comparison on protein quantification data: `groupComparisonTMT`

## 1. Converters for different peptide quantification tools

`MSstatsTMT` performs statistical analysis steps, that follow peptide identification and quantitation. Therefore, input to MSstatsTMT is the output of other software tools (such as `Proteome Discoverer`, `MaxQuant` and so on) that read raw spectral files , identify and quantify peptide ions. The preferred structure of data for use in MSstatsTMT is a .csv file in a *long* format with at least 9 columns representing the following variables: **ProteinName**, **PeptideSequence**, **Charge**, **PSM**, **Channel**, **Condition**, **BioReplicate**, **Mixture**, **Intensity**. The variable names are fixed, but are case-insensitive.

```
#>   ProteinName     PeptideSequence Charge                   PSM  Mixture
#> 1      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 2      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 3      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 4      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 5      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 6      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#>   TechRepMixture                                         Run Channel
#> 1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw     126
#> 2              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 3              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127N
#> 4              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    128C
#> 5              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    128N
#> 6              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    129C
#>   BioReplicate Condition Intensity
#> 1         Norm      Norm  23398.14
#> 2        0.125     0.125  22387.63
#> 3        0.667     0.667  17754.91
#> 4            1         1  19640.59
#> 5          0.5       0.5  20048.57
#> 6          0.5       0.5  19188.13
```

### PDtoMSstatsTMTFormat()

Preprocess PSM data from Proteome Discoverer and convert into the required input format for MSstatsTMT.

#### Arguments

* `input` : data name of Proteome discover PSM output. Read PSM sheet.
* `annotation` : data frame which contains column `Run`, `Fraction`, `TechRepMixture`, `Channel`, `Condition`, `BioReplicate`, `Mixture`.
* `which.proteinid` : Use `Protein.Accessions`(default) column for protein name. `Master.Protein.Accessions` can be used instead.
* `useNumProteinsColumn` : TURE(default) remove shared peptides by information of # Proteins column in PSM sheet.
* `useUniquePeptide` : TRUE(default) removes peptides that are assigned for more than one proteins. We assume to use unique peptide for each protein.
* `rmPSM_withfewMea_withinRun` : only for rmPSM\_withMissing\_withinRun = FALSE. TRUE(default) will remove the features that have 1 or 2 measurements within each Run.
* `removeProtein_with1Peptide` : TRUE will remove the proteins which have only 1 peptide and charge. Default is FALSE.
* `summaryforMultipleRows` : sum(default) or max - when there are multiple measurements for certain PSM in certain run, select the PSM with the largest summation or maximal value.

#### Example

```
# read in PD PSM sheet
# raw.pd <- read.delim("161117_SILAC_HeLa_UPS1_TMT10_5Mixtures_3TechRep_UPSdB_Multiconsensus_PD22_Intensity_PSMs.txt")
head(raw.pd)
#>    Checked Confidence Identifying.Node PSM.Ambiguity
#>     <lgcl>     <char>           <char>        <char>
#> 1:   FALSE       High      Mascot (O4)   Unambiguous
#> 2:   FALSE       High      Mascot (K2)   Unambiguous
#> 3:   FALSE       High      Mascot (K2)   Unambiguous
#> 4:   FALSE       High      Mascot (F2)      Selected
#> 5:   FALSE       High      Mascot (K2)   Unambiguous
#> 6:   FALSE       High      Mascot (K2)   Unambiguous
#>                        Annotated.Sequence
#>                                    <char>
#> 1: [K].gFQQILAGEYDHLPEQAFYMVGPIEEAVAk.[A]
#> 2:          [R].qYPWGVAEVENGEHcDFTILr.[N]
#> 3:              [R].dkPSVEPVEEYDYEDLk.[E]
#> 4:                      [R].hEHQVMLmr.[Q]
#> 5:       [R].dNLTLWTADNAGEEGGEAPQEPQS.[-]
#> 6:         [R].aLVAIGTHDLDTLSGPFTYTAk.[R]
#>                                                      Modifications Marked.as
#>                                                             <char>    <lgcl>
#> 1:                                 N-Term(TMT6plex); K30(TMT6plex)        NA
#> 2: N-Term(TMT6plex); C15(Carbamidomethyl); R21(Label:13C(6)15N(4))        NA
#> 3:                         N-Term(TMT6plex); K2(Label); K17(Label)        NA
#> 4:         N-Term(TMT6plex); M8(Oxidation); R9(Label:13C(6)15N(4))        NA
#> 5:                                                N-Term(TMT6plex)        NA
#> 6:                                    N-Term(TMT6plex); K22(Label)        NA
#>    X..Protein.Groups X..Proteins Master.Protein.Accessions
#>                <int>       <int>                    <char>
#> 1:                 1           1                    P06576
#> 2:                 1           1                    Q16181
#> 3:                 1           1                    Q9Y450
#> 4:                 1           1                    Q15233
#> 5:                 1           1                    P31947
#> 6:                 1           1                    Q9NSD9
#>                                                            Master.Protein.Descriptions
#>                                                                                 <char>
#> 1:         ATP synthase subunit beta, mitochondrial OS=Homo sapiens GN=ATP5B PE=1 SV=3
#> 2:                                         Septin-7 OS=Homo sapiens GN=SEPT7 PE=1 SV=2
#> 3:                                HBS1-like protein OS=Homo sapiens GN=HBS1L PE=1 SV=1
#> 4: Non-POU domain-containing octamer-binding protein OS=Homo sapiens GN=NONO PE=1 SV=4
#> 5:                               14-3-3 protein sigma OS=Homo sapiens GN=SFN PE=1 SV=1
#> 6:          Phenylalanine--tRNA ligase beta subunit OS=Homo sapiens GN=FARSB PE=1 SV=3
#>    Protein.Accessions
#>                <char>
#> 1:             P06576
#> 2:             Q16181
#> 3:             Q9Y450
#> 4:             Q15233
#> 5:             P31947
#> 6:             Q9NSD9
#>                                                                   Protein.Descriptions
#>                                                                                 <char>
#> 1:         ATP synthase subunit beta, mitochondrial OS=Homo sapiens GN=ATP5B PE=1 SV=3
#> 2:                                         Septin-7 OS=Homo sapiens GN=SEPT7 PE=1 SV=2
#> 3:                                HBS1-like protein OS=Homo sapiens GN=HBS1L PE=1 SV=1
#> 4: Non-POU domain-containing octamer-binding protein OS=Homo sapiens GN=NONO PE=1 SV=4
#> 5:                               14-3-3 protein sigma OS=Homo sapiens GN=SFN PE=1 SV=1
#> 6:          Phenylalanine--tRNA ligase beta subunit OS=Homo sapiens GN=FARSB PE=1 SV=3
#>    X..Missed.Cleavages Charge DeltaScore DeltaCn  Rank Search.Engine.Rank
#>                  <int>  <int>      <num>   <num> <int>              <int>
#> 1:                   0      3     1.0000       0     1                  1
#> 2:                   0      3     1.0000       0     1                  1
#> 3:                   1      3     0.9730       0     1                  1
#> 4:                   0      4     0.5250       0     1                  1
#> 5:                   0      3     1.0000       0     1                  1
#> 6:                   0      3     0.9783       0     1                  1
#>     m.z..Da. MH...Da. Theo..MH...Da. DeltaM..ppm. Deltam.z..Da. Activation.Type
#>        <num>    <num>          <num>        <num>         <num>          <char>
#> 1: 1270.3249 3808.960       3808.966        -1.51      -0.00192             CID
#> 2:  920.4493 2759.333       2759.332         0.31       0.00028             CID
#> 3:  920.1605 2758.467       2758.461         2.08       0.00192             CID
#> 4:  359.6898 1435.737       1435.738        -0.04      -0.00002             CID
#> 5:  920.0943 2758.268       2758.264         1.53       0.00141             CID
#> 6:  919.8502 2757.536       2757.532         1.48       0.00136             CID
#>    MS.Order Isolation.Interference.... Average.Reporter.S.N
#>      <char>                      <num>                <num>
#> 1:      MS2                  47.955590                  8.7
#> 2:      MS2                   9.377507                  8.1
#> 3:      MS2                  38.317050                 17.8
#> 4:      MS2                  21.390040                 36.5
#> 5:      MS2                   0.000000                 16.7
#> 6:      MS2                  30.619960                 26.7
#>    Ion.Inject.Time..ms. RT..min. First.Scan
#>                   <num>    <num>      <int>
#> 1:               50.000 212.2487     112815
#> 2:                3.242 164.7507      87392
#> 3:               13.596 143.4534      74786
#> 4:               50.000  21.6426       6458
#> 5:                6.723 174.1863      92950
#> 6:                8.958 176.4863      94294
#>                                   Spectrum.File File.ID Abundance..126
#>                                          <char>  <char>          <num>
#> 1: 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_03.raw      F1       2548.326
#> 2: 161117_SILAC_HeLa_UPS1_TMT10_Mixture3_03.raw      F5      22861.765
#> 3: 161117_SILAC_HeLa_UPS1_TMT10_Mixture3_03.raw      F5      25504.083
#> 4: 161117_SILAC_HeLa_UPS1_TMT10_Mixture4_02.raw     F10      13493.228
#> 5: 161117_SILAC_HeLa_UPS1_TMT10_Mixture3_03.raw      F5      64582.786
#> 6: 161117_SILAC_HeLa_UPS1_TMT10_Mixture3_03.raw      F5      35404.709
#>    Abundance..127N Abundance..127C Abundance..128N Abundance..128C
#>              <num>           <num>           <num>           <num>
#> 1:        3231.929        2760.839        4111.639        3127.254
#> 2:       25817.946       23349.498       29449.609       25995.929
#> 3:       27740.450       25144.974       25754.579       29923.176
#> 4:       14674.490       11187.900       12831.495       13839.426
#> 5:       50576.417       47126.037       56285.129       46257.310
#> 6:       31905.852       30993.941       36854.351       37506.001
#>    Abundance..129N Abundance..129C Abundance..130N Abundance..130C
#>              <num>           <num>           <num>           <num>
#> 1:        1874.163        2831.423        2298.401        3798.876
#> 2:       22955.769       30578.971       30660.488       38728.853
#> 3:       34097.637       31650.255       27632.692       23886.881
#> 4:       12441.353       13450.885       14777.844       13039.995
#> 5:       52634.885       49716.850       60660.574       55830.488
#> 6:       25703.444       38626.598       35447.942       33788.409
#>    Abundance..131 Quan.Info Ions.Score Identity.Strict Identity.Relaxed
#>             <num>    <lgcl>      <int>           <int>            <int>
#> 1:       3739.067        NA         90              28               21
#> 2:      25047.280        NA         76              24               17
#> 3:      35331.092        NA         74              30               23
#> 4:      12057.121        NA         40              25               18
#> 5:      40280.577        NA         38              21               14
#> 6:      32031.516        NA         46              29               22
#>    Expectation.Value Percolator.q.Value Percolator.PEP
#>                <num>              <num>          <num>
#> 1:      7.038672e-09                  0      1.396e-05
#> 2:      6.298627e-08                  0      3.349e-07
#> 3:      4.318385e-07                  0      9.922e-07
#> 4:      3.351211e-04                  0      1.175e-04
#> 5:      2.152501e-04                  0      1.383e-05
#> 6:      2.060469e-04                  0      7.198e-05

# Read in annotation including condition and biological replicates per run and channel.
# Users should make this annotation file. It is not the output from Proteome Discoverer.
# annotation.pd <- read.csv(file="PD_Annotation.csv", header=TRUE)
head(annotation.pd)
#>                                            Run Fraction TechRepMixture Channel
#> 1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01.raw        1              1     126
#> 2 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01.raw        1              1    127N
#> 3 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01.raw        1              1    127C
#> 4 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01.raw        1              1    128N
#> 5 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01.raw        1              1    128C
#> 6 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01.raw        1              1    129N
#>   Condition  Mixture BioReplicate
#> 1      Norm Mixture1         Norm
#> 2     0.667 Mixture1        0.667
#> 3     0.125 Mixture1        0.125
#> 4       0.5 Mixture1          0.5
#> 5         1 Mixture1            1
#> 6     0.125 Mixture1        0.125

# use Protein.Accessions as protein name
input.pd <- PDtoMSstatsTMTFormat(raw.pd, annotation.pd,
                                 which.proteinid = "Protein.Accessions")
#> INFO  [2025-10-30 01:19:51] ** Raw data from ProteomeDiscoverer imported successfully.
#> INFO  [2025-10-30 01:19:51] ** Raw data from ProteomeDiscoverer cleaned successfully.
#> INFO  [2025-10-30 01:19:51] ** Using provided annotation.
#> INFO  [2025-10-30 01:19:51] ** Run and Channel labels were standardized to remove symbols such as '.' or '%'.
#> INFO  [2025-10-30 01:19:51] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements within each run will be removed.
#> INFO  [2025-10-30 01:19:51] ** Features with all missing measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:51] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:51] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:52] ** PSMs have been aggregated to peptide ions.
#> INFO  [2025-10-30 01:19:52] ** Run annotation merged with quantification data.
#> INFO  [2025-10-30 01:19:52] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:52] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:52] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:52] ** Finished preprocessing. The dataset is ready to be processed by the proteinSummarization function.
head(input.pd)
#>   ProteinName     PeptideSequence Charge                   PSM  Mixture
#> 1      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 2      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 3      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 4      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 5      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 6      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#>   TechRepMixture                                         Run Channel
#> 1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw     126
#> 2              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 3              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127N
#> 4              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    128C
#> 5              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    128N
#> 6              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    129C
#>   BioReplicate Condition Intensity
#> 1         Norm      Norm  23398.14
#> 2        0.125     0.125  22387.63
#> 3        0.667     0.667  17754.91
#> 4            1         1  19640.59
#> 5          0.5       0.5  20048.57
#> 6          0.5       0.5  19188.13

# use Master.Protein.Accessions as protein name
input.pd.master <- PDtoMSstatsTMTFormat(raw.pd, annotation.pd,
                                 which.proteinid = "Master.Protein.Accessions")
#> INFO  [2025-10-30 01:19:52] ** Raw data from ProteomeDiscoverer imported successfully.
#> INFO  [2025-10-30 01:19:52] ** Raw data from ProteomeDiscoverer cleaned successfully.
#> INFO  [2025-10-30 01:19:52] ** Using provided annotation.
#> INFO  [2025-10-30 01:19:52] ** Run and Channel labels were standardized to remove symbols such as '.' or '%'.
#> INFO  [2025-10-30 01:19:52] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements within each run will be removed.
#> INFO  [2025-10-30 01:19:52] ** Features with all missing measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:52] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:52] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** PSMs have been aggregated to peptide ions.
#> INFO  [2025-10-30 01:19:54] ** Run annotation merged with quantification data.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:54] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:54] ** Finished preprocessing. The dataset is ready to be processed by the proteinSummarization function.
head(input.pd.master)
#>   ProteinName     PeptideSequence Charge                   PSM  Mixture
#> 1      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 2      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 3      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 4      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 5      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#> 6      Q9NSD9 [K].aAGASDVVLYk.[I]      2 [K].aAGASDVVLYk.[I]_2 Mixture1
#>   TechRepMixture                                         Run Channel
#> 1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw     126
#> 2              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 3              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127N
#> 4              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    128C
#> 5              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    128N
#> 6              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    129C
#>   BioReplicate Condition Intensity
#> 1         Norm      Norm  23398.14
#> 2        0.125     0.125  22387.63
#> 3        0.667     0.667  17754.91
#> 4            1         1  19640.59
#> 5          0.5       0.5  20048.57
#> 6          0.5       0.5  19188.13
```

Here is the summary of pre-processing steps in `PDtoMSstatsTMTFormat` function.

* Peptide ions which are shared by more than one protein are removed
* If one spectrum has multiple identifications within one run, it only keeps the best identification with the minimal number of missing reporter ion intensities, highest reporter ion intensity, or lowest interference score if the information was available
* If a spectrum only has one or two reporter ion intensities within one MS run, it removes the spectrum from that run
* Ambiguous protein groups which contained multiple proteins were filtered out
* For fractionation, If a peptide ion was shared by multiple fractions, we kept the fraction with maximal average reporter ion abundance across all the channel in the fraction.

### MaxQtoMSstatsTMTFormat()

Preprocess PSM-level data from MaxQuant and convert into the required input format for MSstatsTMT.

#### Arguments

* `evidence` : name of `evidence.txt` data, which includes PSM-level data.
* `proteinGroups` : name of `proteinGroups.txt` data, which contains the detailed information of protein identifications.
* `annotation` : data frame which contains column `Run`, `Fraction`, `TechRepMixture`, `Channel`, `Condition`, `BioReplicate`, `Mixture`.
* `which.proteinid` : Use `Proteins`(default) column for protein name. `Leading.proteins` or `Leading.razor.proteins` can be used instead. However, those can potentially have the shared peptides.
* `rmProt_Only.identified.by.site` : TRUE will remove proteins with ‘+’ in ‘Only.identified.by.site’ column from proteinGroups.txt, which was identified only by a modification site. FALSE is the default.
* `useUniquePeptide` : TRUE(default) removes peptides that are assigned for more than one proteins. We assume to use unique peptide for each protein.
* `rmPSM_withfewMea_withinRun` : only for rmPSM\_withMissing\_withinRun = FALSE. TRUE(default) will remove the features that have 1 or 2 measurements within each Run.
* `removeProtein_with1Peptide` : TRUE will remove the proteins which have only 1 peptide and charge. Default is FALSE.
* `summaryforMultipleRows` : sum(default) or max - when there are multiple measurements for certain PSM in certain run, select the PSM with the largest summation or maximal value.

#### Example

```
# Read in MaxQuant files
# proteinGroups <- read.table("proteinGroups.txt", sep="\t", header=TRUE)

# evidence <- read.table("evidence.txt", sep="\t", header=TRUE)

# Users should make this annotation file. It is not the output from MaxQuant.
# annotation.mq <- read.csv(file="MQ_Annotation.csv", header=TRUE)

input.mq <- MaxQtoMSstatsTMTFormat(evidence, proteinGroups, annotation.mq)
#> INFO  [2025-10-30 01:19:54] ** Raw data from MaxQuant imported successfully.
#> INFO  [2025-10-30 01:19:54] ** Rows with values of Potentialcontaminant equal to + are removed
#> INFO  [2025-10-30 01:19:54] ** Rows with values of Reverse equal to + are removed
#> INFO  [2025-10-30 01:19:54] ** Rows with values of Potentialcontaminant equal to + are removed
#> INFO  [2025-10-30 01:19:54] ** Rows with values of Reverse equal to + are removed
#> INFO  [2025-10-30 01:19:54] ** + Contaminant, + Reverse, + Potential.contaminant proteins are removed.
#> INFO  [2025-10-30 01:19:54] ** Features with all missing measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Raw data from MaxQuant cleaned successfully.
#> INFO  [2025-10-30 01:19:54] ** Using provided annotation.
#> INFO  [2025-10-30 01:19:54] ** Run and Channel labels were standardized to remove symbols such as '.' or '%'.
#> INFO  [2025-10-30 01:19:54] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements within each run will be removed.
#> INFO  [2025-10-30 01:19:54] ** Features with all missing measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** PSMs have been aggregated to peptide ions.
#> INFO  [2025-10-30 01:19:54] ** Run annotation merged with quantification data.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:54] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:54] ** Finished preprocessing. The dataset is ready to be processed by the proteinSummarization function.
head(input.mq)
#>   ProteinName               PeptideSequence Charge
#> 1      P37108 AAAAAAAAAPAAAATAPTTAATTAATAAQ      3
#> 2      P37108 AAAAAAAAAPAAAATAPTTAATTAATAAQ      3
#> 3      P37108 AAAAAAAAAPAAAATAPTTAATTAATAAQ      3
#> 4      P37108 AAAAAAAAAPAAAATAPTTAATTAATAAQ      3
#> 5      P37108 AAAAAAAAAPAAAATAPTTAATTAATAAQ      3
#> 6      P37108 AAAAAAAAAPAAAATAPTTAATTAATAAQ      3
#>                               PSM  Mixture TechRepMixture
#> 1 AAAAAAAAAPAAAATAPTTAATTAATAAQ_3 Mixture1              1
#> 2 AAAAAAAAAPAAAATAPTTAATTAATAAQ_3 Mixture1              1
#> 3 AAAAAAAAAPAAAATAPTTAATTAATAAQ_3 Mixture1              1
#> 4 AAAAAAAAAPAAAATAPTTAATTAATAAQ_3 Mixture1              1
#> 5 AAAAAAAAAPAAAATAPTTAATTAATAAQ_3 Mixture1              1
#> 6 AAAAAAAAAPAAAATAPTTAATTAATAAQ_3 Mixture1              1
#>                                        Run  Channel BioReplicate Condition
#> 1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01 channel0         Norm      Norm
#> 2 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01 channel1        0.667     0.667
#> 3 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01 channel2        0.125     0.125
#> 4 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01 channel3          0.5       0.5
#> 5 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01 channel4            1         1
#> 6 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01 channel5        0.125     0.125
#>   Intensity
#> 1    883.78
#> 2    715.37
#> 3   1090.60
#> 4   1080.10
#> 5   1006.40
#> 6   1137.90
```

### SpectroMinetoMSstatsTMTFormat()

Preprocess PSM data from SpectroMine and convert into the required input format for MSstatsTMT.

#### Arguments

* `input` : data name of SpectroMine PSM output. Read PSM sheet.
* `annotation` : data frame which contains column `Run`, `Fraction`, `TechRepMixture`, `Channel`, `Condition`, `BioReplicate`, `Mixture`.
* `filter_with_Qvalue` : TRUE(default) will filter out the intensities that have greater than qvalue\_cutoff in EG.Qvalue column. Those intensities will be replaced with NA and will be considered as censored missing values for imputation purpose.
* `qvalue_cutoff` : Cutoff for EG.Qvalue. default is 0.01.
* `useUniquePeptide` : TRUE(default) removes peptides that are assigned for more than one proteins. We assume to use unique peptide for each protein.
* `rmPSM_withfewMea_withinRun` : only for `rmPSM_withMissing_withinRun = FALSE`. TRUE(default) will remove the features that have 1 or 2 measurements within each Run.
* `removeProtein_with1Peptide` : TRUE will remove the proteins which have only 1 peptide and charge. Default is FALSE.
* `summaryforMultipleRows` : sum(default) or max - when there are multiple measurements for certain PSM in certain run, select the PSM with the largest summation or maximal value.

#### Example

```
# Read in SpectroMine PSM report
# raw.mine <- read.csv('20180831_095547_CID-OT-MS3-Short_PSM Report_20180831_103118.xls', sep="\t")

# Users should make this annotation file. It is not the output from SpectroMine
# annotation.mine <- read.csv(file="Mine_Annotation.csv", header=TRUE)

input.mine <- SpectroMinetoMSstatsTMTFormat(raw.mine, annotation.mine)
#> INFO  [2025-10-30 01:19:54] ** Raw data from SpectroMine imported successfully.
#> INFO  [2025-10-30 01:19:54] ** Raw data from SpectroMine cleaned successfully.
#> INFO  [2025-10-30 01:19:54] ** Using provided annotation.
#> INFO  [2025-10-30 01:19:54] ** Run and Channel labels were standardized to remove symbols such as '.' or '%'.
#> INFO  [2025-10-30 01:19:54] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements within each run will be removed.
#> INFO  [2025-10-30 01:19:54] ** Intensities with values not smaller than 0.01 in PGQValue are replaced with NA
#> INFO  [2025-10-30 01:19:54] ** Intensities with values not smaller than 0.01 in Qvalue are replaced with NA
#> INFO  [2025-10-30 01:19:54] ** Features with all missing measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** PSMs have been aggregated to peptide ions.
#> INFO  [2025-10-30 01:19:54] ** Run annotation merged with quantification data.
#> INFO  [2025-10-30 01:19:54] ** For peptides overlapped between fractions of 1_1 use the fraction with maximal average abundance.
#> INFO  [2025-10-30 01:19:54] ** Fractions belonging to same mixture have been combined.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:54] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:54] ** Finished preprocessing. The dataset is ready to be processed by the proteinSummarization function.
head(input.mine)
#>   ProteinName                 PeptideSequence Charge
#> 1      P07954 [TMTNter]AAAEVNQDYGLDPK[TMTLys]      2
#> 2      P07954 [TMTNter]AAAEVNQDYGLDPK[TMTLys]      2
#> 3      P07954 [TMTNter]AAAEVNQDYGLDPK[TMTLys]      2
#> 4      P07954 [TMTNter]AAAEVNQDYGLDPK[TMTLys]      2
#> 5      P07954 [TMTNter]AAAEVNQDYGLDPK[TMTLys]      2
#> 6      P07954 [TMTNter]AAAEVNQDYGLDPK[TMTLys]      2
#>                                 PSM Mixture TechRepMixture Run  Channel
#> 1 [TMTNter]AAAEVNQDYGLDPK[TMTLys]_2       1              1 1_1 TMT6_126
#> 2 [TMTNter]AAAEVNQDYGLDPK[TMTLys]_2       1              1 1_1 TMT6_127
#> 3 [TMTNter]AAAEVNQDYGLDPK[TMTLys]_2       1              1 1_1 TMT6_128
#> 4 [TMTNter]AAAEVNQDYGLDPK[TMTLys]_2       1              1 1_1 TMT6_129
#> 5 [TMTNter]AAAEVNQDYGLDPK[TMTLys]_2       1              1 1_1 TMT6_130
#> 6 [TMTNter]AAAEVNQDYGLDPK[TMTLys]_2       1              1 1_1 TMT6_131
#>   BioReplicate Condition Intensity
#> 1            1         3  6393.694
#> 2            2         3  7887.951
#> 3            3         3  9917.544
#> 4            1         1 11282.770
#> 5            2         1  8544.471
#> 6            3         1  4893.753
```

### OpenMStoMSstatsTMTFormat()

Preprocess MSstatsTMT report from OpenMS and convert into the required input format for MSstatsTMT.

#### Arguments

* `input` : data name of MSstatsTMT report from OpenMS. Read csv file.
* `useUniquePeptide` : TRUE(default) removes peptides that are assigned for more than one proteins. We assume to use unique peptide for each protein.
* `rmPSM_withfewMea_withinRun` : only for rmPSM\_withMissing\_withinRun = FALSE. TRUE(default) will remove the features that have 1 or 2 measurements within each Run.
* `removeProtein_with1Peptide` : TRUE will remove the proteins which have only 1 peptide and charge. Default is FALSE.
* `summaryforMultipleRows` : sum(default) or max - when there are multiple measurements for certain PSM in certain run, select the PSM with the largest summation or maximal value.

#### Example

```
# read in MSstatsTMT report from OpenMS
# raw.om <- read.csv("OpenMS_20200222/20200225_MSstatsTMT_OpenMS_Export.csv")
head(raw.om)
#>   RetentionTime          ProteinName                 PeptideSequence Charge
#> 1      2924.491 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 2      2924.491 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 3      2924.491 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 4      2924.491 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 5      2924.491 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 6      2924.491 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#>   Channel Condition BioReplicate   Run Mixture TechRepMixture Fraction
#> 1       1   Long_LF            1 1_1_3       1            1_1        3
#> 2       2   Long_LF            2 1_1_3       1            1_1        3
#> 3       3    Long_M            3 1_1_3       1            1_1        3
#> 4       6    Long_M            6 1_1_3       1            1_1        3
#> 5       5      Norm            5 1_1_3       1            1_1        3
#> 6       9      Norm            9 1_1_3       1            1_1        3
#>   Intensity
#> 1  5727.319
#> 2  6985.365
#> 3  4553.897
#> 4  5937.782
#> 5  5151.292
#> 6  6800.128
#>                                                                                                          Reference
#> 1 PAMI-176_Mouse_A-J_TMT_40ug_22pctACN_25cm_120min_20160223_OT.mzML_controllerType=0 controllerNumber=1 scan=11324
#> 2 PAMI-176_Mouse_A-J_TMT_40ug_22pctACN_25cm_120min_20160223_OT.mzML_controllerType=0 controllerNumber=1 scan=11324
#> 3 PAMI-176_Mouse_A-J_TMT_40ug_22pctACN_25cm_120min_20160223_OT.mzML_controllerType=0 controllerNumber=1 scan=11324
#> 4 PAMI-176_Mouse_A-J_TMT_40ug_22pctACN_25cm_120min_20160223_OT.mzML_controllerType=0 controllerNumber=1 scan=11324
#> 5 PAMI-176_Mouse_A-J_TMT_40ug_22pctACN_25cm_120min_20160223_OT.mzML_controllerType=0 controllerNumber=1 scan=11324
#> 6 PAMI-176_Mouse_A-J_TMT_40ug_22pctACN_25cm_120min_20160223_OT.mzML_controllerType=0 controllerNumber=1 scan=11324

# the function only requries one input file
input.om <- OpenMStoMSstatsTMTFormat(raw.om)
#> INFO  [2025-10-30 01:19:54] ** Raw data from OpenMS imported successfully.
#> INFO  [2025-10-30 01:19:54] ** Raw data from OpenMS cleaned successfully.
#> INFO  [2025-10-30 01:19:54] ** The following options are used:
#>   - Features will be defined by the columns: PeptideSequence, PrecursorCharge
#>   - Shared peptides will be removed.
#>   - Proteins with single feature will not be removed.
#>   - Features with less than 3 measurements within each run will be removed.
#> INFO  [2025-10-30 01:19:54] ** Features with all missing measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Shared peptides are removed.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** PSMs have been aggregated to peptide ions.
#> INFO  [2025-10-30 01:19:54] ** For peptides overlapped between fractions of 2_2_2 use the fraction with maximal average abundance.
#> INFO  [2025-10-30 01:19:54] ** For peptides overlapped between fractions of 3_3_3 use the fraction with maximal average abundance.
#> INFO  [2025-10-30 01:19:54] ** Fractions belonging to same mixture have been combined.
#> INFO  [2025-10-30 01:19:54] ** Features with one or two measurements across channels within each run are removed.
#> INFO  [2025-10-30 01:19:54] ** Fractionation handled.
#> INFO  [2025-10-30 01:19:54] ** Updated quantification data to make balanced design. Missing values are marked by NA
#> INFO  [2025-10-30 01:19:54] ** Finished preprocessing. The dataset is ready to be processed by the proteinSummarization function.
head(input.om)
#>            ProteinName                 PeptideSequence Charge
#> 1 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 2 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 3 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 4 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 5 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#> 6 sp|P11679|K2C8_MOUSE .(TMT6plex)AEAETMYQIK(TMT6plex)      2
#>                                 PSM Mixture TechRepMixture   Run Channel
#> 1 .(TMT6plex)AEAETMYQIK(TMT6plex)_2       1            1_1 1_1_1       1
#> 2 .(TMT6plex)AEAETMYQIK(TMT6plex)_2       1            1_1 1_1_1       2
#> 3 .(TMT6plex)AEAETMYQIK(TMT6plex)_2       1            1_1 1_1_1       3
#> 4 .(TMT6plex)AEAETMYQIK(TMT6plex)_2       1            1_1 1_1_1       4
#> 5 .(TMT6plex)AEAETMYQIK(TMT6plex)_2       1            1_1 1_1_1       5
#> 6 .(TMT6plex)AEAETMYQIK(TMT6plex)_2       1            1_1 1_1_1       6
#>   BioReplicate Condition Intensity
#> 1            1   Long_LF  5727.319
#> 2            2   Long_LF  6985.365
#> 3            3    Long_M  4553.897
#> 4            4  Short_LF  6277.917
#> 5            5      Norm  5151.292
#> 6            6    Long_M  5937.782
```

### PhilosophertoMSstatsTMTFormat()

Preprocess MSstats report from Philosopher of Fragpipe and convert into the required input format for MSstatsTMT.

#### Arguments

* `input` : list of tables exported by Philosopher. Fragpipe produces a csv file for each TMT mixture.
* `path` : a path to the folder with all the Philosopher msstats csv files. Fragpipe produces a msstats.csv file for each TMT mixture.
* `folder` : logical, if TRUE, path parameter will be treated as folder path and all msstats\*.csv files will be imported. If FALSE, path parameter will be treated as a vector of fixed file paths.
* `annotation` : annotation with Run, Fraction, TechRepMixture, Mixture, Channel, BioReplicate, Condition columns or a path to file. Refer to the example ‘annotation’ for the meaning of each column. Channel column should be consistent with the channel columns (Ignore the prefix “Channel”) in msstats.csv file. Run column should be consistent with the Spectrum.File columns in msstats.csv file.
* `protein_id_col` : Use ‘Protein.Accessions’(default) column for protein name. ‘Master.Protein.Accessions’ can be used instead to get the protein ID with single protein.
* `peptide_id_col` : Use ‘Peptide.Sequence’(default) column for peptide sequence. ‘Modified.Peptide.Sequence’ can be used instead to get the modified peptide sequence.
* `Purity_cutoff` : Cutoff for purity. Default is 0.6
* `PeptideProphet_prob_cutoff` : Cutoff for the peptide identification probability. Default is 0.7.
* `useUniquePeptide` : logical, if TRUE (default) removes peptides that are assigned for more than one proteins. We assume to use unique peptide for each protein.
* `rmPSM_withfewMea_withinRun` : TRUE(default) will remove the features that have 1 or 2 measurements within each Run.
* `rmPeptide_OxidationM` : TRUE (default) will remove the peptides including oxidation (M) sequence.
* `removeProtein_with1Peptide` : TRUE will remove the proteins which have only 1 peptide and charge. Default is FALSE.
* `summaryforMultipleRows` : sum(default) or max - when there are multiple measurements for certain PSM in certain run, select the PSM with the largest summation or maximal value.

#### Example

```
# Example code is skipped for Philosopher Converter
# since the input is a path to the folder with all the Philosopher msstats csv files
```

## 2. Protein summarization, normalization and visualization

### 2.1. proteinSummarization()

After reading the input files and get the data with required format, `MSstatsTMT` performs

* 1. logarithm transformation of `Intensity` column
* 2. global median normalization between channels
* 3. protein summarization per MS run and channel
* 4. local protein-level normalization with reference channel

Global median normalization is first applied to peptide level quantification data (equalizing the medians across all the channels and MS runs). Protein summarization from peptide level quantification should be performed before testing differentially abundant proteins. Then, normalization between MS runs using reference channels will be implemented. In particular, protein summarization method `MSstats` assumes missing values are censored and then imputes the missing values before summarizing peptide level data into protein level data. Other methods, including `MedianPolish`, `Median` and `LogSum`, do not impute missing values.

#### Arguments

* `data` : Name of the output of PDtoMSstatsTMTFormat function or peptide-level quantified data from other tools. It should have columns named `Protein`, `PSM`, `TechRepMixture`, `Mixture`, `Run`, `Channel`, `Condition`, `BioReplicate`, `Intensity`.
* `method` : Four different summarization methods to protein-level can be performed : `msstats`(default), `MedianPolish`, `Median`, `LogSum`.
* `global_norm` : Global median normalization on peptide level data (equalizing the medians across all the channels and MS runs). Default is TRUE. It will be performed before protein-level summarization.
* `reference_norm` : Reference channel based normalization between MS runs. TRUE(default) needs at least one reference channel in each MS run, annotated by `Norm` in Condtion column. It will be performed after protein-level summarization. FALSE will not perform this normalization step. If data only has one run, then reference\_norm=FALSE.
* `remove_norm_channel` : TRUE(default) removes `Norm` channels from protein level data.
* `remove_empty_channel` : TRUE(default) removes `Empty` channels from protein level data.
* `MBimpute` : only for `method = "msstats"`. TRUE (default) imputes missing values by Accelated failure model. FALSE uses minimum value to impute the missing value for each peptide precursor ion.
* `maxQuantileforCensored` : We assume missing values are censored. `maxQuantileforCensored` is Maximum quantile for deciding censored missing value, for instance, 0.999. Default is Null.

#### Example

```
# use MSstats for protein summarization
quant.msstats <- proteinSummarization(input.pd,
                                      method="msstats",
                                      global_norm=TRUE,
                                      reference_norm=TRUE,
                                      remove_norm_channel = TRUE,
                                      remove_empty_channel = TRUE)
```

```
head(quant.pd.msstats$ProteinLevelData)
#>    Mixture TechRepMixture                                         Run Channel
#> 1 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 2 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 3 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 4 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 5 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 6 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#>   Protein Abundance BioReplicate Condition
#> 1  P04406  16.59812        0.125     0.125
#> 2  P06576  15.55891        0.125     0.125
#> 3  P12277  15.28471        0.125     0.125
#> 4  P23919  15.20871        0.125     0.125
#> 5  P31947  14.86975        0.125     0.125
#> 6  Q15233  14.57543        0.125     0.125
```

```
# use Median for protein summarization
quant.median <- proteinSummarization(input.pd,
                                     method="Median",
                                     global_norm=TRUE,
                                     reference_norm=TRUE,
                                     remove_norm_channel = TRUE,
                                     remove_empty_channel = TRUE)
```

```
head(quant.median$ProteinLevelData)
#>    Mixture TechRepMixture                                         Run Channel
#> 1 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 2 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 3 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 4 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 5 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#> 6 Mixture1              1 161117_SILAC_HeLa_UPS1_TMT10_Mixture1_01raw    127C
#>   Protein Abundance BioReplicate Condition
#> 1  Q9NSD9  15.33397        0.125     0.125
#> 2  P04406  16.39393        0.125     0.125
#> 3  Q15233  14.69981        0.125     0.125
#> 4  Q16181  13.83691        0.125     0.125
#> 5  P12277  15.06154        0.125     0.125
#> 6  P23919  14.89041        0.125     0.125
```

### 2.2 dataProcessPlotsTMT()

Visualization for explanatory data analysis. To illustrate the quantitative data after data-preprocessing and quality control of TMT runs, dataProcessPlotsTMT takes the quantitative data and summarized data from function `proteinSummarization` as input. It generates two types of figures in pdf files as output :

1. profile plot (specify “ProfilePlot” in option type), to identify the potential sources of variation for each protein;
2. quality control plot (specify “QCPlot” in option type), to evaluate the systematic bias between MS runs and channels.

#### Arguments

* `data` : the output of `proteinSummarization` function. It is a list with data frames `FeatureLevelData` and `ProteinLevelData`
* `type` : choice of visualization. “ProfilePlot” represents profile plot of log intensities across MS runs. “QCPlot” represents quality control plot of log intensities across MS runs.
* `ylimUp` : upper limit for y-axis in the log scale. FALSE(Default) for Profile Plot and QC Plot use the upper limit as rounded off maximum of log2(intensities) after normalization + 3.
* `ylimDown` : lower limit for y-axis in the log scale. FALSE(Default) for Profile Plot and QC Plot is 0.
* `x.axis.size` : size of x-axis labeling for “Run” and “channel” in Profile Plot and QC Plot.
* `y.axis.size` : size of y-axis labels. Default is 10.
* `text.size` : size of labels represented each condition at the top of graph in Profile Plot and QC plot. Default is 4.
* `text.angle` : angle of labels represented each condition at the top of graph in Profile Plot and QC plot. Default is 0.
* `legend.size` : size of legend above graph in Profile Plot. Default is 7.
* `dot.size.profile` : size of dots in profile plot. Default is 2.
* `ncol.guide` : number of columns for legends at the top of plot. Default is 5.
* `width` : width of the saved file. Default is 10.
* `height` : height of the saved file. Default is 10.
* `which.Protein` : Protein list to draw plots. List can be names of Proteins or order numbers of Proteins. Default is “all”, which generates all plots for each protein. For QC plot, “allonly” will generate one QC plot with all proteins.
* `originalPlot` : TRUE(default) draws original profile plots, without normalization.
* `summaryPlot` : TRUE(default) draws profile plots with protein summarization for each channel and MS run.
* `address` : the name of folder that will store the results. Default folder is the current working directory. The other assigned folder has to be existed under the current working directory. An output pdf file is automatically created with the default name of “ProfilePlot.pdf” or “QCplot.pdf”. The command address can help to specify where to store the file as well as how to modify the beginning of the file name. If address=FALSE, plot will be not saved as pdf file but showed in window.

#### Example

```
## Profile plot without norm channnels and empty channels
dataProcessPlotsTMT(data=quant.msstats,
                     type = 'ProfilePlot',
                     width = 21, # adjust the figure width since there are 15 TMT runs.
                     height = 7)
```

There are two pdfs with all the proteins, first is profile plot and second plot is profile plot with summarized and normalized data. `XXX_ProfilePlot.pdf` shows each peptide ions across runs and channels, grouped per condition. Each panel represents one MS run and each dot within one panel is one channel within one Run. Each peptide has a different colour/type layout. The dots are linked with line per peptide ion If line is disconnected, that means there is no value (missing value). Profile plot is good visualization to check individual measurements. `XXX_ProfilePlot_wSummarization.pdf` shows the same peptide ions in grey, with the values as summarized by the model overlayed in red.

Instead of making all profile plots for all proteins, we can make plot for individual protein. Here is the example of protein`P04406`

```
dataProcessPlotsTMT(data=quant.msstats,
                    type='ProfilePlot', # choice of visualization
                    width = 21,
                    height = 7,
                    which.Protein = 'P04406')
```

```
## Quality control plot
# dataProcessPlotsTMT(data=quant.msstats,
                     # type='QCPlot',
                     # width = 21, # adjust the figure width since there are 15 TMT runs.
                     # height = 7)
```

## 3. groupComparisonTMT()

Tests for significant changes in protein abundance across conditions based on a family of linear mixed-effects models in TMT experiment. Experimental design of case-control study (patients are not repeatedly measured) is automatically determined based on proper statistical model.

### Arguments

* `data` : the output of `proteinSummarization` function. It is a list with data frames `FeatureLevelData` and `ProteinLevelData`
* `contrast.matrix` : Comparison between conditions of interests. 1) default is `pairwise`, which compare all possible pairs between two conditions. 2) Otherwise, users can specify the comparisons of interest. Based on the levels of conditions, specify 1 or -1 to the conditions of interests and 0 otherwise. The levels of conditions are sorted alphabetically.
* `moderated` : If moderated = TRUE, then moderated t statistic will be calculated; otherwise, ordinary t statistic will be used.
* `adj.method` : adjusted method for multiple comparison. ’BH` is default.
* `save_fitted_models`: logical, if TRUE, fitted models will be added to
* `remove_norm_channel` : TRUE(default) removes `Norm` channels from protein level data.
* `remove_empty_channel` : TRUE(default) removes `Empty` channels from protein level data.

If you want to make all the pairwise comparison,`MSstatsTMT` has an easy option for it. Setting `contrast.matrix = pairwise` compares all the possible pairs between two conditions.

### Example

```
# test for all the possible pairs of conditions
test.pairwise <- groupComparisonTMT(quant.msstats, moderated = TRUE)
```

```
# Show test result
# Label : which comparison is used
# log2FC : estimated log2 fold change between two conditions (the contrast)
# adj.pvalue : adjusted p value
head(test.pairwise$ComparisonResult)
#>    Protein          Label       log2FC         SE       DF    pvalue adj.pvalue
#>     <fctr>         <char>        <num>      <num>    <num>     <num>      <num>
#> 1:  P04406 0.125 vs 0.667 -0.010442843 0.02184769 111.8925 0.6335941  0.9051345
#> 2:  P04406     0.125 vs 1 -0.005921016 0.02184769 111.8925 0.7868800  0.9519310
#> 3:  P04406   0.125 vs 0.5 -0.031373953 0.02184769 111.8925 0.1537834  0.4077351
#> 4:  P04406     0.667 vs 1  0.004521827 0.02184769 111.8925 0.8364091  0.9321517
#> 5:  P04406   0.667 vs 0.5 -0.020931110 0.02184769 111.8925 0.3401046  0.5731751
#> 6:  P04406       1 vs 0.5 -0.025452937 0.02184769 111.8925 0.2464896  0.6162240
#>     issue
#>    <lgcl>
#> 1:     NA
#> 2:     NA
#> 3:     NA
#> 4:     NA
#> 5:     NA
#> 6:     NA
```

If you would like to compare some specific combination of conditions, you need to tell `groupComparisonTMT` the contrast of the conditions to compare. You can make your `contrast.matrix` in R in a text editor. We define our contrast matrix by adding a column for every condition. We add a row for every comparison we would like to make between groups of conditions.

**0** is for conditions we would like to ignore. **1** is for conditions we would like to put in the numerator of the ratio or fold-change. **-1** is for conditions we would like to put in the denumerator of the ratio or fold-change.

If you have multiple groups, you can assign any group comparisons you are interested in.

```
# Check the conditions in the protein level data
levels(quant.msstats$ProteinLevelData$Condition)
#> [1] "0.125" "0.5"   "0.667" "1"
# Only compare condition 0.125 and 1
comparison<-matrix(c(-1,0,0,1),nrow=1)
# Set the names of each row
row.names(comparison)<-"1-0.125"
# Set the column names
colnames(comparison)<- c("0.125", "0.5", "0.667", "1")
comparison
#>         0.125 0.5 0.667 1
#> 1-0.125    -1   0     0 1
```

```
test.contrast <- groupComparisonTMT(data = quant.msstats, contrast.matrix = comparison, moderated = TRUE)
```

```
head(test.contrast$ComparisonResult)
#>    Protein   Label       log2FC         SE       DF    pvalue adj.pvalue  issue
#>     <fctr>  <char>        <num>      <num>    <num>     <num>      <num> <lgcl>
#> 1:  P04406 1-0.125  0.005921016 0.02184769 111.8925 0.7868800  0.9519310     NA
#> 2:  P06576 1-0.125 -0.001284321 0.02125746 111.8925 0.9519310  0.9519310     NA
#> 3:  P12277 1-0.125 -0.013004897 0.02632339 111.8925 0.6222440  0.9220317     NA
#> 4:  P23919 1-0.125  0.031852508 0.02489210 111.8925 0.2033247  0.6158831     NA
#> 5:  P31947 1-0.125  0.034549433 0.03056662 111.8925 0.2607671  0.6158831     NA
#> 6:  Q15233 1-0.125  0.010110290 0.02191319 111.8925 0.6454222  0.9220317     NA
```