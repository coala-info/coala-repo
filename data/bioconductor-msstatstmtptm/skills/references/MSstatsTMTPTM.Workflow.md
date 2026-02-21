# MSstatsTMTPTM Example: An example workflow and analysis of the MSstatsTMTPTM package

#### Devon Kohler (kohler.d@northeastern.edu)

#### 2021-02-16

```
library(MSstatsTMTPTM)
library(MSstatsTMT)
library(MSstats)
library(dplyr)
```

This Vignette provides an example workflow for how to use the package MSstatsTMTPTM. It also provides examples and an analysis of how adjusting for global protein levels allows for better interpretations of PTM modeling results.

## Installation

To install this package, start R (version “4.0”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstatsTMTPTM")
```

## 1. Workflow

### 1.1 Raw Data Format

The first step is to load in the raw dataset for both the PTM and Protein datasets. This can be the output of the MSstatsTMT converter functions: `PDtoMSstatsTMTFormat`, `SpectroMinetoMSstatsTMTFormat`, and `OpenMStoMSstatsTMTFormat`. Both the PTM and protein datasets must include the following columns: `ProteinName`, `PeptideSequence`, `Charge`, `PSM`, `Mixture`, `TechRepMixture`, `Run`, `Channel`, `Condition`, `BioReplicate`, and `Intensity`.

#### 1.1.1 Raw PTM Data

```
# read in raw data files
# raw.ptm <- read.csv(file="raw.ptm.csv", header=TRUE)
head(raw.ptm)
#>       ProteinName PeptideSequence Charge           PSM Mixture TechRepMixture
#> 1 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 2 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 3 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 4 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 5 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#> 6 Protein_12_S703     Peptide_491      3 Peptide_491_3       1              1
#>   Run Channel   Condition  BioReplicate Intensity
#> 1 1_1    128N Condition_2 Condition_2_1   48030.0
#> 2 1_1    129C Condition_4 Condition_4_2  100224.4
#> 3 1_1    131C Condition_3 Condition_3_2   66804.6
#> 4 1_1    130N Condition_1 Condition_1_2   46779.8
#> 5 1_1    128C Condition_6 Condition_6_1   77497.9
#> 6 1_1    126C Condition_4 Condition_4_1   81559.7
```

It is important to note the `ProteinName` column in the PTM dataset represents the modification sites. The location of the modification must be added into the `ProteinName`. For example the first row shows `Protein_12_S703` for ProteinName, with Y474 being the modificaiton site. This can be done as shown above, or by adding the PeptideSequence into the ProteinName, ex. `Protein_12_Peptide_491` for the first row.

#### 1.1.1 Raw Protein Data

```
head(raw.protein)
#>   ProteinName PeptideSequence Charge             PSM Mixture TechRepMixture Run
#> 1  Protein_12    Peptide_9121      3  Peptide_9121_3       1              1 1_1
#> 2  Protein_12   Peptide_27963      5 Peptide_27963_5       1              1 1_1
#> 3  Protein_12   Peptide_28482      4 Peptide_28482_4       1              1 1_1
#> 4  Protein_12   Peptide_10940      2 Peptide_10940_2       2              1 2_1
#> 5  Protein_12    Peptide_4900      2  Peptide_4900_2       2              1 2_1
#> 6  Protein_12    Peptide_4900      3  Peptide_4900_3       2              1 2_1
#>   Channel   Condition  BioReplicate  Intensity
#> 1    126C Condition_4 Condition_4_1 10996116.9
#> 2    127C Condition_5 Condition_5_1    56965.1
#> 3    131N Condition_2 Condition_2_2   286121.7
#> 4    131N Condition_2 Condition_2_4   534806.0
#> 5    126C Condition_4 Condition_4_3  1134908.7
#> 6    126C Condition_4 Condition_4_3  1605773.2
# raw.protein <- read.csv(file="raw.protein.csv", header=TRUE)
```

The raw Protein dataset looks similar to the PTM dataset, however the `ProteinName` column does not contain a modification site.

### 1.2 proteinSummarization

After loading in the input data, the next step is to use the proteinSummarization function from MSstatsTMT. This provides the summarized dataset needed to model the protein/PTM abundance. The summarization for PTM and Protein datasets should be done separately. The function will summarize the Protein dataset up to the protein level and will summarize the PTM dataset up to the PTM level. The different summarizations are caused by adding the PTM site into the `ProteinName` field. For details about normalization and imputation options in proteinSummarization please review the package documentation here: [MSstatsTMT Package](https://www.bioconductor.org/packages/release/bioc/html/MSstatsTMT.html).

```
# Use proteinSummarization function from MSstatsTMT to summarize raw data
quant.msstats.ptm <- proteinSummarization(raw.ptm,
                                          method = "msstats",
                                          global_norm = TRUE,
                                          reference_norm = FALSE,
                                          MBimpute = TRUE)

quant.msstats.protein <- proteinSummarization(raw.protein,
                                          method = "msstats",
                                          global_norm = TRUE,
                                          reference_norm = FALSE,
                                          MBimpute = TRUE)
```

```
head(quant.msstats.ptm)
#>   Run          Protein Abundance Channel  BioReplicate   Condition
#> 1 1_1 Protein_1076_Y67  13.65475    130N Condition_1_2 Condition_1
#> 2 1_1 Protein_1076_Y67  13.57146    127N Condition_1_1 Condition_1
#> 3 1_1 Protein_1076_Y67  13.56900    128N Condition_2_1 Condition_2
#> 4 1_1 Protein_1076_Y67  13.70567    131N Condition_2_2 Condition_2
#> 5 1_1 Protein_1076_Y67  13.24717    131C Condition_3_2 Condition_3
#> 6 1_1 Protein_1076_Y67  13.11874    129N Condition_3_1 Condition_3
#>   TechRepMixture Mixture
#> 1              1       1
#> 2              1       1
#> 3              1       1
#> 4              1       1
#> 5              1       1
#> 6              1       1
head(quant.msstats.protein)
#>   Run      Protein Abundance Channel  BioReplicate   Condition TechRepMixture
#> 1 1_1 Protein_1076  18.75131    127N Condition_1_1 Condition_1              1
#> 2 1_1 Protein_1076  18.80198    130N Condition_1_2 Condition_1              1
#> 3 1_1 Protein_1076  18.92222    131N Condition_2_2 Condition_2              1
#> 4 1_1 Protein_1076  19.02252    128N Condition_2_1 Condition_2              1
#> 5 1_1 Protein_1076  18.28685    131C Condition_3_2 Condition_3              1
#> 6 1_1 Protein_1076  18.40555    129N Condition_3_1 Condition_3              1
#>   Mixture
#> 1       1
#> 2       1
#> 3       1
#> 4       1
#> 5       1
#> 6       1
```

### 1.3 groupComparisonTMTPTM

After the two datasets are summarized, both the summarized PTM and protein datasets should be used in the modeling function `groupComparisonTMTPTM`. First a full pairwise comparison is made between all conditions in the experiment.

```
# test for all the possible pairs of conditions
model.results.pairwise <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein)
```

Optionally, a specific contrast matrix can be defined. Below is an example of a contrast matrix and how it is passed into the `groupComparisonTMTPTM` function.

```
# Specify comparisons
comparison<-matrix(c(1,0,0,-1,0,0,
                     0,1,0,0,-1,0,
                     0,0,-1,0,0,-1,
                     1,0,-1,0,0,0,
                     0,1,-1,0,0,0,
                     0,0,0,1,0,-1,
                     0,0,0,0,1,-1,
                     .25,.25,-.5,.25,.25,-.5,
                     1/3,1/3,1/3,-1/3,-1/3,-1/3),nrow=9, ncol=6, byrow=TRUE)

# Set the names of each row
row.names(comparison)<-c('1-4', '2-5', '3-6', '1-3',
                         '2-3', '4-6', '5-6', 'Partial', 'Third')
# Set the column names
colnames(comparison)<- c('Condition_1', 'Condition_2', 'Condition_3',
                         'Condition_4', 'Condition_5', 'Condition_6')

comparison
#>         Condition_1 Condition_2 Condition_3 Condition_4 Condition_5 Condition_6
#> 1-4       1.0000000   0.0000000   0.0000000  -1.0000000   0.0000000   0.0000000
#> 2-5       0.0000000   1.0000000   0.0000000   0.0000000  -1.0000000   0.0000000
#> 3-6       0.0000000   0.0000000  -1.0000000   0.0000000   0.0000000  -1.0000000
#> 1-3       1.0000000   0.0000000  -1.0000000   0.0000000   0.0000000   0.0000000
#> 2-3       0.0000000   1.0000000  -1.0000000   0.0000000   0.0000000   0.0000000
#> 4-6       0.0000000   0.0000000   0.0000000   1.0000000   0.0000000  -1.0000000
#> 5-6       0.0000000   0.0000000   0.0000000   0.0000000   1.0000000  -1.0000000
#> Partial   0.2500000   0.2500000  -0.5000000   0.2500000   0.2500000  -0.5000000
#> Third     0.3333333   0.3333333   0.3333333  -0.3333333  -0.3333333  -0.3333333
```

```
# test for specified condition comparisons only
model.results.contrast <- groupComparisonTMTPTM(data.ptm=quant.msstats.ptm,
                                       data.protein=quant.msstats.protein,
                                       contrast.matrix = comparison)
```

```
names(model.results.contrast)
#> [1] "PTM.Model"      "Protein.Model"  "Adjusted.Model"
ptm_model <- model.results.contrast[[1]]
protein_model <- model.results.contrast[[2]]
adjusted_model <- model.results.contrast[[3]]

head(adjusted_model)
#> # A tibble: 6 x 8
#>   Protein           Label  log2FC     SE Tvalue    DF   pvalue adj.pvalue
#>   <fct>             <chr>   <dbl>  <dbl>  <dbl> <dbl>    <dbl>      <dbl>
#> 1 Protein_1076_Y67  1-4   -0.0328 0.155  -0.212  6.35 0.839      0.868
#> 2 Protein_1145_T915 1-4   -1.27   0.248  -5.11  14.8  0.000132   0.000880
#> 3 Protein_1146_S328 1-4    0.0336 0.179   0.188 20.0  0.853      0.872
#> 4 Protein_1160_S188 1-4   -0.246  0.146  -1.69  17.8  0.108      0.153
#> 5 Protein_1220_Y321 1-4   -0.330  0.0867 -3.81  24.6  0.000830   0.00369
#> 6 Protein_1235_S416 1-4   -0.242  0.168  -1.44  12.8  0.174      0.222
```

The modeling function will return a list consisting of three dataframes.One each for the PTM-level, Protein-level, and adjusted PTM-level group comparison result.

### 1.4 Example Volcano Plot

The models from the `groupComparisonTMTPTM` function can be used in the model visualization function, `groupComparisonPlots`, from the base MSstats. Below is a Volcano Plot for the Adjusted PTM model. **Note: the input for groupComparisonPlots should be one data.frame from output of groupComparisonTMTPTM.**

```
groupComparisonPlots(data = adjusted_model,
                     type = 'VolcanoPlot',
                     ProteinName = FALSE,
                     which.Comparison = '1-4',
                     address = FALSE)
```

![](data:image/png;base64...)

## 2. Analysis

### 2.1 How to adjust PTMs for changes in global protein levels?

In order to adjust the PTM abundance for global protein abundance there are two main steps. First the PTM and global protein datasets must be modeled and then the resulting model parameters are combined. The combination is done using the formulas below:

Log2FC: \(\log\_2FC\_{PTM} - \log\_2FC\_{Protein}\)

SE: \(\sqrt{SE\_{PTM}^2 + SE\_{Protein}^2}\)

DF: \((SE\_{PTM}^2 + SE\_{Protein}^2)^2 \biggm/ (\frac{SE\_{PTM}^2}{DF\_{PTM}} + \frac{SE\_{Protein}^2}{DF\_{Protein}})\)

Please see the package MSstatsPTM for further explanation of adjustment strategy and formulas.

### 2.2 Example PTM

```
dataProcessPlotsTMTPTM(data.ptm = raw.ptm,
                       data.protein = raw.protein,
                       data.ptm.summarization = quant.msstats.ptm,
                       data.protein.summarization = quant.msstats.protein,
                       type = 'ProfilePlot',
                       which.Protein = 'Protein_2391_Y40',
                       address = FALSE)
#> Drew the Profile plot for  Protein_2391_Y40 ( 1  of  1 )
```

![](data:image/png;base64...)

```
#> Drew the Profile plot with summarization for  Protein_2391_Y40 ( 1  of  1 )
```

![](data:image/png;base64...)

In the plots above the data points for the PTM `Protein_2391_Y40` and Protein `Protein_2391` are shown for all conditions. To take a look at a specific comparison, the input data can be filtered.

```
dataProcessPlotsTMTPTM(data.ptm = raw.ptm %>% filter(
  Condition %in% c('Condition_1', 'Condition_4')),
                       data.protein = raw.protein %>% filter(
                         Condition %in% c('Condition_1', 'Condition_4')),
                       data.ptm.summarization = quant.msstats.ptm %>% filter(
                         Condition %in% c('Condition_1', 'Condition_4')),
                       data.protein.summarization =
    quant.msstats.protein %>% filter(Condition %in% c(
      'Condition_1', 'Condition_4')),
                       type = 'ProfilePlot',
                       which.Protein = 'Protein_2391_Y40',
                       originalPlot = FALSE,
                       address = FALSE)
#> Drew the Profile plot with summarization for  Protein_2391_Y40 ( 1  of  1 )
```

![](data:image/png;base64...)

```
model_df <- rbind(adjusted_model %>% filter(
  Protein == 'Protein_2391_Y40' & Label == '1-4') %>% select(-Tvalue),
                  ptm_model %>% filter(
                    Protein == 'Protein_2391_Y40' & Label == '1-4'
                    ) %>% select(-issue),
                  protein_model %>% filter(
                    Protein == 'Protein_2391' & Label == '1-4'
                    ) %>% select(-issue))
model_df <- data.frame(model_df)
rownames(model_df) <- c('Adjusted PTM', 'PTM', 'Protein')
model_df
#>                       Protein Label     log2FC        SE       DF       pvalue
#> Adjusted PTM Protein_2391_Y40   1-4  0.6518589 0.1448410 29.64763 0.0000972072
#> PTM          Protein_2391_Y40   1-4  0.1437229 0.0966742 15.00000 0.1578171796
#> Protein          Protein_2391   1-4 -0.5081360 0.1078564 15.00000 0.0002784895
#>               adj.pvalue
#> Adjusted PTM 0.000879508
#> PTM          0.182096746
#> Protein      0.001315089
```

The example above shows the added insight of adjusting for Protein level. Originally the PTM model shows a small positive log2FC of 0.144. However, the global protein abundance changed strongly in the negative direction, -0.508. When the PTM is adjusted for the global the log2FC is increased to 0.652, which is a much larger absolute change than without adjustment. The change in abundance of this PTM may have been marked as insignificant without adjusting for protein levels. Note the change in SE and DF once the PTM model is adjusted.

Additionally, there are other situations where the PTM log2FC will be reduced after adjustment.

```
dataProcessPlotsTMTPTM(data.ptm = raw.ptm %>% filter(
  Condition %in% c('Condition_2', 'Condition_5')),
                       data.protein = raw.protein %>% filter(
                         Condition %in% c('Condition_2', 'Condition_5')),
                       data.ptm.summarization = quant.msstats.ptm %>%
    filter(Condition %in% c('Condition_2', 'Condition_5')),
                       data.protein.summarization = quant.msstats.protein %>%
    filter(Condition %in% c('Condition_2', 'Condition_5')),
                       type = 'ProfilePlot',
                       which.Protein = 'Protein_1076_Y67',
                       originalPlot = FALSE,
                       address = FALSE)
#> Drew the Profile plot with summarization for  Protein_1076_Y67 ( 1  of  1 )
```

![](data:image/png;base64...)

```
model_df <- rbind(adjusted_model %>% filter(
  Protein == 'Protein_1076_Y67' & Label == '2-5') %>% select(-Tvalue),
                  ptm_model %>% filter(
                    Protein == 'Protein_1076_Y67' & Label == '2-5'
                    ) %>% select(-issue),
                  protein_model %>% filter(
                    Protein == 'Protein_1076' & Label == '2-5'
                    ) %>% select(-issue))

model_df <- data.frame(model_df)
rownames(model_df) <- c('Adjusted PTM', 'PTM', 'Protein')
model_df
#>                       Protein Label     log2FC        SE        DF       pvalue
#> Adjusted PTM Protein_1076_Y67   2-5 -0.1142781 0.1551100  6.351078 0.4875850599
#> PTM          Protein_1076_Y67   2-5  0.2416246 0.0526497 15.000000 0.0003544345
#> Protein          Protein_1076   2-5  0.3559027 0.1459011  5.000000 0.0587012026
#>               adj.pvalue
#> Adjusted PTM 0.542438379
#> PTM          0.002022438
#> Protein      0.094940666
```

**Note - In this example Protein\_1076 was only available in one run of the global protein experiment.**

In this example the PTM model originally showed a large log2FC of 0.242, however most of this log2FC was due to the global protein abundance change which was 0.356. Once adjusted, the PTM shows a much smaller log2FC of -0.114. Without adjustment a potentially incorrect inference could have been drawn for this PTM.

From these two examples the added insight into PTM abundance change from protein adjustment can be observed. If the goal of the experiment is to find the true abundance change due to PTMs than removing the effect of the protein is very important.

## Session information

```
sessionInfo()
#> R version 4.0.3 (2020-10-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] dplyr_1.0.4         MSstats_3.22.0      MSstatsTMT_1.8.2
#> [4] MSstatsTMTPTM_1.0.2
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyr_1.1.2           splines_4.0.3         foreach_1.5.1
#>  [4] gtools_3.8.2          assertthat_0.2.1      statmod_1.4.35
#>  [7] highr_0.8             yaml_2.2.1            ggrepel_0.9.1
#> [10] numDeriv_2016.8-1.1   pillar_1.4.7          backports_1.2.1
#> [13] lattice_0.20-41       glue_1.4.2            limma_3.46.0
#> [16] doSNOW_1.0.19         digest_0.6.27         minqa_1.2.4
#> [19] colorspace_2.0-0      htmltools_0.5.1.1     preprocessCore_1.52.1
#> [22] Matrix_1.3-2          plyr_1.8.6            pkgconfig_2.0.3
#> [25] broom_0.7.4           purrr_0.3.4           scales_1.1.1
#> [28] snow_0.4-3            lme4_1.1-26           tibble_3.0.6
#> [31] generics_0.1.0        farver_2.0.3          ggplot2_3.3.3
#> [34] ellipsis_0.3.1        cli_2.3.0             survival_3.2-7
#> [37] magrittr_2.0.1        crayon_1.4.1          evaluate_0.14
#> [40] fansi_0.4.2           nlme_3.1-152          MASS_7.3-53.1
#> [43] gplots_3.1.1          tools_4.0.3           data.table_1.13.6
#> [46] minpack.lm_1.2-1      lifecycle_1.0.0       matrixStats_0.58.0
#> [49] stringr_1.4.0         munsell_0.5.0         compiler_4.0.3
#> [52] caTools_1.18.1        rlang_0.4.10          grid_4.0.3
#> [55] nloptr_1.2.2.2        iterators_1.0.13      marray_1.68.0
#> [58] bitops_1.0-6          labeling_0.4.2        rmarkdown_2.6
#> [61] boot_1.3-27           gtable_0.3.0          codetools_0.2-18
#> [64] lmerTest_3.1-3        DBI_1.1.1             reshape2_1.4.4
#> [67] R6_2.5.0              gridExtra_2.3         knitr_1.31
#> [70] utf8_1.1.4            KernSmooth_2.23-18    stringi_1.5.3
#> [73] parallel_4.0.3        Rcpp_1.0.6            vctrs_0.3.6
#> [76] tidyselect_1.1.0      xfun_0.21
```