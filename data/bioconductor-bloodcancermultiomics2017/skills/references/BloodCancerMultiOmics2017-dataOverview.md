# BloodCancerMultiOmics2017 - data overview

Małgorzata Oleś

#### 4 November 2025

# 1 Prerequisites

```
library("BloodCancerMultiOmics2017")
# additional
library("Biobase")
library("SummarizedExperiment")
library("DESeq2")
library("reshape2")
library("ggplot2")
library("dplyr")
library("BiocStyle")
```

# 2 Introduction

Primary tumor samples from blood cancer patients underwent functional and molecular characterization. *[BloodCancerMultiOmics2017](https://bioconductor.org/packages/3.22/BloodCancerMultiOmics2017)* includes the resulting preprocessed data. A quick overview of the available data is provided below. For the details on experimental settings please refer to:

S Dietrich\*, M Oleś\*, J Lu\* et al. *Drug-perturbation-based stratification of blood cancer*

*J. Clin. Invest.* (2018); 128(1):427–445. doi:10.1172/JCI93801.

\* equal contribution

# 3 Data overview

Load all of the available data.

```
data("conctab", "drpar", "lpdAll", "patmeta", "day23rep", "drugs",
     "methData", "validateExp", "dds", "exprTreat", "mutCOM",
     "cytokineViab")
```

The data sets are objects of different classes (`data.frame`, `ExpressionSet`, `NChannelSet`, `RangedSummarizedExperiment`, `DESeqDataSet`), and include data for either all studied patient samples or only a subset of these. The overview below shortly describes and summarizes the data available. Please note that the presence of a given patient sample ID within the data set doesn’t necessarily mean that the data is available for this sample (the slot could be filled with NAs).

Patient samples per data set.

```
samplesPerData = list(
  drpar = colnames(drpar),
  lpdAll = colnames(lpdAll),
  day23rep = colnames(day23rep),
  methData = colnames(methData),
  patmeta = rownames(patmeta),
  validateExp = unique(validateExp$patientID),
  dds = colData(dds)$PatID,
  exprTreat = unique(pData(exprTreat)$PatientID),
  mutCOM = rownames(mutCOM),
  cytokineViab = unique(cytokineViab$Patient)
)
```

List of all samples present in data sets.

```
(samples = sort(unique(unlist(samplesPerData))))
```

```
##   [1] "H001" "H002" "H003" "H005" "H006" "H007" "H008" "H009" "H010" "H011"
##  [11] "H012" "H013" "H014" "H015" "H016" "H017" "H018" "H019" "H020" "H021"
##  [21] "H022" "H023" "H024" "H025" "H026" "H027" "H028" "H029" "H030" "H031"
##  [31] "H032" "H033" "H035" "H036" "H037" "H038" "H039" "H040" "H041" "H042"
##  [41] "H043" "H044" "H045" "H046" "H047" "H048" "H049" "H050" "H051" "H053"
##  [51] "H054" "H055" "H056" "H057" "H058" "H059" "H060" "H062" "H063" "H064"
##  [61] "H065" "H066" "H067" "H069" "H070" "H071" "H072" "H073" "H074" "H075"
##  [71] "H076" "H077" "H078" "H079" "H080" "H081" "H082" "H083" "H084" "H085"
##  [81] "H086" "H087" "H088" "H089" "H090" "H092" "H093" "H094" "H095" "H096"
##  [91] "H097" "H098" "H099" "H100" "H101" "H102" "H103" "H104" "H105" "H106"
## [101] "H107" "H108" "H109" "H110" "H111" "H112" "H113" "H114" "H115" "H116"
## [111] "H117" "H118" "H119" "H120" "H121" "H122" "H126" "H127" "H128" "H133"
## [121] "H134" "H135" "H136" "H137" "H140" "H141" "H142" "H143" "H144" "H145"
## [131] "H146" "H147" "H148" "H149" "H150" "H151" "H152" "H153" "H154" "H155"
## [141] "H156" "H157" "H158" "H159" "H160" "H161" "H162" "H163" "H164" "H165"
## [151] "H166" "H167" "H168" "H169" "H170" "H171" "H172" "H173" "H174" "H175"
## [161] "H176" "H177" "H178" "H179" "H180" "H181" "H182" "H183" "H184" "H185"
## [171] "H186" "H187" "H188" "H189" "H190" "H191" "H192" "H193" "H194" "H195"
## [181] "H196" "H197" "H198" "H199" "H200" "H201" "H202" "H203" "H204" "H205"
## [191] "H206" "H207" "H208" "H209" "H210" "H211" "H212" "H213" "H214" "H215"
## [201] "H216" "H217" "H218" "H219" "H220" "H221" "H222" "H223" "H224" "H225"
## [211] "H226" "H227" "H228" "H229" "H230" "H231" "H232" "H233" "H234" "H235"
## [221] "H236" "H237" "H238" "H239" "H240" "H241" "H242" "H243" "H244" "H245"
## [231] "H246" "H247" "H248" "H249" "H250" "H251" "H252" "H253" "H254" "H255"
## [241] "H256" "H257" "H258" "H259" "H260" "H261" "H262" "H263" "H264" "H265"
## [251] "H266" "H267" "H268" "H269" "H270" "H271" "H272" "H273" "H274" "H275"
## [261] "H276" "H277" "H278" "H279" "H280" "H281" "H282" "H283" "MNC5" "MNC6"
## [271] "MNC7"
```

Total number of samples.

```
length(samples)
```

```
## [1] 271
```

A plot summarizing the presence of a given patient sample within each data set.
![](data:image/png;base64...)

The classification below stratifies data sets according to different types of experiments performed and included. Please refer to the manual for a more detailed information on the content of these data objects.

## 3.1 Patient metadata

Patient metadata is provided in the `patmeta` object.

```
# Number of patients per disease
sort(table(patmeta$Diagnosis), decreasing=TRUE)
```

```
##
##      CLL    T-PLL      MCL      MZL      AML      LPL    B-PLL      HCL
##      200       25       10        6        5        4        3        3
##     hMNC    HCL-V   Sezary       FL PTCL-NOS
##        3        2        2        1        1
```

```
# Number of samples from pretreated patients
table(!patmeta$IC50beforeTreatment)
```

```
##
## FALSE  TRUE
##   131    52
```

```
# IGHV status of CLL patients
table(patmeta[patmeta$Diagnosis=="CLL", "IGHV"])
```

```
##
##   M   U
## 104  84
```

## 3.2 High-throughput drug screen data

The viability measurements from the high-throughput drug screen are included in the `drpar` object. The metadata about the drugs and drug concentrations used can be found in `drugs` and `conctab` objects, respectively.

The `drpar` object includes multiple channels, each of which consists of cells’ viability data for a single drug concentration step. Channels `viaraw.1_5` and `viaraw.4_5` contain the mean viability score between multiple concentration steps as indicated at the end of the channel name.

```
channelNames(drpar)
```

```
## [1] "viaraw.1"   "viaraw.1_5" "viaraw.2"   "viaraw.3"   "viaraw.4"
## [6] "viaraw.4_5" "viaraw.5"
```

```
# show viability data for the first 5 patients and 7 drugs in their lowest conc.
assayData(drpar)[["viaraw.1"]][1:7,1:5]
```

```
##            H001      H002      H003       H005       H009
## D_001 0.3283159 0.2632593 0.4969538 0.02410373 0.19080155
## D_002 0.8322242 1.0353523 0.8381608 0.16190086 0.41572819
## D_003 0.7832597 0.8428674 0.7449635 0.65899478 0.41898375
## D_004 0.6529834 0.5654266 0.3548642 0.02827099 0.04094826
## D_006 0.4779778 0.6871057 0.4894785 0.30327813 0.12296120
## D_007 0.5912538 0.7246273 0.5119393 0.10447502 0.15369103
## D_008 0.3728575 0.5261570 0.3161154 0.02266465 0.03423222
```

Drug metadata.

```
# number of drugs
nrow(drugs)
```

```
## [1] 91
```

```
# type of information included in the object
colnames(drugs)
```

```
## [1] "name"            "main_targets"    "target_category" "group"
## [5] "pathway"         "distributor"     "approved_042016" "devel_042016"
```

Drug concentration steps (c1 - lowest, c5 - highest).

```
head(conctab)
```

```
##       c1    c2    c3    c4    c5
## D_001  1  0.25 0.063 0.016 0.004
## D_002 40 10.00 2.500 0.625 0.156
## D_003 40 10.00 2.500 0.625 0.156
## D_004  4  1.00 0.250 0.063 0.016
## D_006 40 10.00 2.500 0.625 0.156
## D_007 20  5.00 1.250 0.313 0.078
```

The reproducibility of the screening platform was assessed by screening 3 patient samples in two replicates. The viability measurements are available for two time points: 48 h and 72 h after adding the drug. The screen was performed for 67 drugs in 1-2 different drug concentrations (16 in 1 and 51 in 2 drug concentrations). This data is provided in `day23rep`.

```
channelNames(day23rep)
```

```
## [1] "day2rep1" "day2rep2" "day3rep1" "day3rep2"
```

```
# show viability data for 48 h time point for all patients marked as
# replicate 1 and 3 first drugs in all their conc.
drugs2Show = unique(fData(day23rep)$DrugID)[1:3]
assayData(day23rep)[["day2rep1"]][fData(day23rep)$DrugID %in% drugs2Show,]
```

```
##                 H016      H022      H030
## D_001-0.05 0.6037813 0.3461988 0.7801167
## D_001-0.1  0.2637692 0.2190428 0.6309255
## D_002-1    0.9959188 0.8119468 0.9005653
## D_002-10   0.9381762 0.4948085 0.8112993
## D_003-1    0.9575617 0.6848139 0.8939423
## D_003-10   0.7988831 0.5007344 0.8348084
```

The follow-up drug screen, which confirmed the targets and the signaling pathway dependence of the patient samples was performed for 128 samples and the following drugs: Cobimetinib, Ganetespib, Onalespib, SCH772984, Trametinib.

| Drug name | Target |
| --- | --- |
| Cobimetinib | MEK |
| Trametinib | MEK |
| SCH772984 | ERK1/2 |
| Ganetespib | Hsp90 |
| Onalespib | Hsp90 |

The data is included in the `validateExp` object.

```
head(validateExp)
```

```
## # A tibble: 6 × 4
##   patientID Drug        Concentration  viab
##   <chr>     <chr>               <dbl> <dbl>
## 1 H005      Cobimetinib        0.0032 0.749
## 2 H005      Cobimetinib        0.016  0.726
## 3 H005      Cobimetinib        0.08   0.723
## 4 H005      Cobimetinib        0.4    0.732
## 5 H005      Cobimetinib        2      0.744
## 6 H005      Ganetespib         0.0032 1.00
```

Moreover, we also performed a small drug screen in order to check the influence of the different cytokines/chemokines on the viability of the samples. These data are included in `cytokineViab` object.

```
head(cytokineViab)
```

```
## # A tibble: 6 × 11
##   Patient Timepoint Recording_date Seeding_date Stimulation
##   <chr>   <chr>     <date>         <date>       <chr>
## 1 H060    48h       2017-06-02     2017-05-31   IL-2
## 2 H060    48h       2017-06-02     2017-05-31   IL-2
## 3 H060    48h       2017-06-02     2017-05-31   IL-2
## 4 H060    48h       2017-06-02     2017-05-31   IL-4
## 5 H060    48h       2017-06-02     2017-05-31   IL-4
## 6 H060    48h       2017-06-02     2017-05-31   IL-4
## # ℹ 6 more variables: Cytokine_Concentration <fct>, Duplicate <dbl>,
## #   Normalized_DMSO <dbl>, mtor <chr>, Edge <fct>,
## #   Cytokine_Concentration2 <chr>
```

## 3.3 Gene mutation data

The `mutCOM` object contains information on the presence of gene mutations in the studied patient samples.

```
# there is only one channel with the binary type of data for each gene
channelNames(mutCOM)
```

```
## [1] "binary"
```

```
# the feature data includes detailed information about mutations in
# TP53 and BRAF genes, as well as clone size of
#del17p13, KRAS, UMODL1, CREBBP, PRPF8, trisomy12 mutations
colnames(fData(mutCOM))
```

```
##  [1] "TP53_CDS"    "TP53_AA"     "TP53_%"      "TP53cs"      "BRAF_CDS"
##  [6] "BRAF_AA"     "BRAF_%"      "BRAFcs"      "del17p13cs"  "KRAScs"
## [11] "UMODL1cs"    "CREBBPcs"    "PRPF8cs"     "trisomy12cs"
```

## 3.4 Gene expression data

RNA-Seq data preprocessed with *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* is provided in the `dds` object.

```
# show count data for the first 5 patients and 7 genes
assay(dds)[1:7,1:5]
```

```
##                    1     2     3     4     6
## ENSG00000000003    0     0     9     0     2
## ENSG00000000005    0     0     0     0     0
## ENSG00000000419 1272  3443  1682  1574  3463
## ENSG00000000457  430   472  2285  1022  1030
## ENSG00000000460  270  1043  1882   760   830
## ENSG00000000938 9391 24963 40337 31327 10077
## ENSG00000000971    5     1    57    56     0
```

```
# show the above with patient sample ids
assay(dds)[1:7,1:5] %>% `colnames<-` (colData(dds)$PatID[1:5])
```

```
##                 H045  H109  H024  H056  H079
## ENSG00000000003    0     0     9     0     2
## ENSG00000000005    0     0     0     0     0
## ENSG00000000419 1272  3443  1682  1574  3463
## ENSG00000000457  430   472  2285  1022  1030
## ENSG00000000460  270  1043  1882   760   830
## ENSG00000000938 9391 24963 40337 31327 10077
## ENSG00000000971    5     1    57    56     0
```

```
# number of genes and patient samples
nrow(dds); ncol(dds)
```

```
## [1] 63677
```

```
## [1] 136
```

Additionally, 12 patient samples underwent gene expression profiling using Illumina microarrays before and 12 h after treatment with 5 drugs. These data are included in the `exprTreat` data object.

```
# patient samples included in the data set
(p = unique(pData(exprTreat)$PatientID))
```

```
##  [1] "H112" "H108" "H238" "H194" "H173" "H234" "H169" "H233" "H094" "H109"
## [11] "H114" "H167"
```

```
# type of metadata included for each gene
colnames(fData(exprTreat))
```

```
##  [1] "ProbeID"               "TargetID"              "QC"
##  [4] "Species"               "Source"                "Search_Key"
##  [7] "Transcript"            "ILMN_Gene"             "Source_Reference_ID"
## [10] "RefSeq_ID"             "Unigene_ID"            "Entrez_Gene_ID"
## [13] "GI"                    "Accession"             "Symbol"
## [16] "Protein_Product"       "Probe_Id"              "Array_Address_Id"
## [19] "Probe_Type"            "Probe_Start"           "Probe_Sequence"
## [22] "Chromosome"            "Probe_Chr_Orientation" "Probe_Coordinates"
## [25] "Cytoband"              "Definition"            "Ontology_Component"
## [28] "Ontology_Process"      "Ontology_Function"     "Synonyms"
## [31] "Obsolete_Probe_Id"     "Factor"
```

```
# show expression level for the first patient and 3 first probes
Biobase::exprs(exprTreat)[1:3, pData(exprTreat)$PatientID==p[1]]
```

```
##        200128470091_A 200128470091_B 200128470091_C 200128470091_D
## R00001       9.172930       9.086734       9.112330       9.202076
## R00002       4.931757       4.893040       4.439497       4.887295
## R00003       4.887619       4.668925       4.796266       5.298392
##        200128470091_E 200128470091_F
## R00001       9.073740       8.870751
## R00002       5.227140       5.379562
## R00003       5.038028       5.115141
```

## 3.5 DNA methylation data

DNA methylation included in `methData` object contains data for 196 patient samples and 5000 of the most variable CpG sites.

```
# show the methylation for the first 7 CpGs and the first 5 patient samples
assay(methData)[1:7,1:5]
```

```
##                  H005       H023       H006       H024       H010
## cg17479716 0.13512727 0.94295266 0.03052286 0.03086889 0.97261914
## cg00674365 0.97992788 0.02102404 0.98030338 0.97448056 0.06720939
## cg24299136 0.97637954 0.97179489 0.03779711 0.08808060 0.97364936
## cg18723409 0.03438240 0.57677823 0.96091989 0.96505311 0.07195807
## cg23844018 0.03451902 0.97407334 0.10804103 0.17808162 0.97309712
## cg08425796 0.04653624 0.95438826 0.05756599 0.11993044 0.94959487
## cg02956248 0.40450644 0.96655136 0.18370129 0.03276800 0.96370039
```

```
# type of metadata included for CpGs
colnames(rowData(methData))
```

```
##  [1] "Strand"                   "Name"
##  [3] "AddressA"                 "AddressB"
##  [5] "ProbeSeqA"                "ProbeSeqB"
##  [7] "Type"                     "NextBase"
##  [9] "Color"                    "Probe_rs"
## [11] "Probe_maf"                "CpG_rs"
## [13] "CpG_maf"                  "SBE_rs"
## [15] "SBE_maf"                  "Islands_Name"
## [17] "Relation_to_Island"       "Forward_Sequence"
## [19] "SourceSeq"                "Random_Loci"
## [21] "Methyl27_Loci"            "UCSC_RefGene_Name"
## [23] "UCSC_RefGene_Accession"   "UCSC_RefGene_Group"
## [25] "Phantom"                  "DMR"
## [27] "Enhancer"                 "HMM_Island"
## [29] "Regulatory_Feature_Name"  "Regulatory_Feature_Group"
## [31] "DHS"
```

```
# number of patient samples screened with the given platform type
table(colData(methData)$platform)
```

```
##
## 450k 850k
##  118   78
```

## 3.6 Other

Object `lpdAll` is a convenient assembly of data contained in the other data objects mentioned earlier in this vignette. For details, please refer to the manual.

```
# number of rows in the dataset for each type of data
table(fData(lpdAll)$type)
```

```
##
##                IGHV Methylation_Cluster                 gen                viab
##                   1                   1                  89                 448
```

```
# show viability data for drug ibrutinib, idelalisib and dasatinib
# (in the mean of the two lowest concentration steps) and
# the first 5 patient samples
Biobase::exprs(lpdAll)[which(
  with(fData(lpdAll),
       name %in% c("ibrutinib", "idelalisib", "dasatinib") &
         subtype=="4:5")), 1:5]
```

```
##                H005      H009      H010      H011      H012
## D_002_4:5 0.9915251 1.0966397 0.8994378 1.0815918 0.9402181
## D_003_4:5 1.0253976 0.9924037 0.8850690 1.0352433 0.9109271
## D_050_4:5 0.9857736 0.6161776 0.6717888 0.8889409 0.6151546
```

# 4 Original data

The raw data from the whole exome sequencing, RNA-seq and DNA methylation arrays is stored in the European Genome-Phenome Archive (EGA) under accession number EGAS0000100174.

The preprocesed DNA methylation data, which include complete list of CpG sites (not only the 5000 with the highest variance) can be accessed through Bioconductor ExperimentHub platform.

```
library("ExperimentHub")

eh = ExperimentHub()
obj = query(eh, "CLLmethylation")
meth = obj[["EH1071"]] # extract the methylation data
```

# 5 Session info

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
##  [1] dplyr_1.1.4                      ggplot2_4.0.0
##  [3] reshape2_1.4.4                   DESeq2_1.50.0
##  [5] SummarizedExperiment_1.40.0      GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0                    IRanges_2.44.0
##  [9] S4Vectors_0.48.0                 MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0                Biobase_2.70.0
## [13] BiocGenerics_0.56.0              generics_0.1.4
## [15] BloodCancerMultiOmics2017_1.30.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    farver_2.1.2        S7_0.2.0
##  [4] fastmap_1.2.0       digest_0.6.37       lifecycle_1.0.4
##  [7] ellipsis_0.3.2      survival_3.8-3      magrittr_2.0.4
## [10] compiler_4.5.1      rlang_1.1.6         sass_0.4.10
## [13] tools_4.5.1         utf8_1.2.6          yaml_2.3.10
## [16] knitr_1.50          S4Arrays_1.10.0     pkgbuild_1.4.8
## [19] DelayedArray_0.36.0 plyr_1.8.9          RColorBrewer_1.1-3
## [22] pkgload_1.4.1       abind_1.4-8         BiocParallel_1.44.0
## [25] withr_3.0.2         purrr_1.1.0         grid_4.5.1
## [28] scales_1.4.0        iterators_1.0.14    MASS_7.3-65
## [31] ipflasso_1.1        dichromat_2.0-0.1   tinytex_0.57
## [34] cli_3.6.5           rmarkdown_2.30      remotes_2.5.0
## [37] sessioninfo_1.2.3   cachem_1.1.0        stringr_1.5.2
## [40] splines_4.5.1       parallel_4.5.1      BiocManager_1.30.26
## [43] XVector_0.50.0      vctrs_0.6.5         devtools_2.4.6
## [46] glmnet_4.1-10       Matrix_1.7-4        jsonlite_2.0.0
## [49] bookdown_0.45       beeswarm_0.4.0      magick_2.9.0
## [52] locfit_1.5-9.12     foreach_1.5.2       jquerylib_0.1.4
## [55] ggdendro_0.2.0      glue_1.8.0          codetools_0.2-20
## [58] stringi_1.8.7       shape_1.4.6.1       gtable_0.3.6
## [61] tibble_3.3.0        pillar_1.11.1       htmltools_0.5.8.1
## [64] R6_2.6.1            evaluate_1.0.5      lattice_0.22-7
## [67] memoise_2.0.1       bslib_0.9.0         Rcpp_1.1.0
## [70] SparseArray_1.10.1  xfun_0.54           fs_1.6.6
## [73] usethis_3.2.1       pkgconfig_2.0.3
```