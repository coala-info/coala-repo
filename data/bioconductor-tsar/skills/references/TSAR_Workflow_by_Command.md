# TSAR Workflow by Command

![](data:image/png;base64...) Pipeline analysis from raw data reading to graphic visualization

## 1. Introduction

TSAR Package provides simple solution to qPCR data processing, computing thermal shift analysis given either raw fluorescent data or smoothed curves. The functions provide users with the protocol to conduct preliminary data checks and also expansive analysis on large scale of data. Furthermore, it showcases simple graphic presentation of analysis, generating clear box plot and line graphs given input of desired designs. Overall, TSAR Package offers a workflow easy to manage and visualize.

## 2. Installation

Load Package and other relevant packages. Usage of dplyr and ggplot2 along with TSAR package is recommended for enhanced analysis.

Use commands below to install TSAR package: library(BiocManager) BiocManager::install(“TSAR”)

```
library(TSAR)
library(dplyr)
library(ggplot2)
```

## 3. Load Data

Read data in .txt or .csv format. Use read.delim function to input tab delimited file; use read.csv to input comma separated files. Other formats of input are welcomed as long as data is stored in data frame structure as numeric type (calculation-required data) and characters (non-calculation-required data). Ensure excessive lines are removed (e.g. skip = , nrows = ). Means to check these are View(), pre-opening data file in excel, or manually removing all excessive data before input reading. Package defaults variable names as “Well.Position”, “Temperature”, “Fluorescence”, “Normalized”. Consider renaming data frame before proceding to following step.

```
data("qPCR_data1")
raw_data <- qPCR_data1
```

## 4. Data Pre-Processing

Select data of individual cell for pre-analysis screening. e.g. select well A1

```
test <- raw_data %>% filter(Well.Position == "A01")
```

Run example analysis on one well to screen potential errors and enhancement of model.

```
# normalize fluorescence reading into scale between 0 and 1
test <- normalize(test, fluo = 5, selected = c(
    "Well.Position", "Temperature",
    "Fluorescence", "Normalized"
))
head(test)
```

```
#>   Well.Position Temperature Fluorescence Normalized
#> 1           A01    21.97290     87464.91  0.4339496
#> 2           A01    22.03227     87437.66  0.4337473
#> 3           A01    22.09164     87410.72  0.4335473
#> 4           A01    22.15101     87384.08  0.4333495
#> 5           A01    22.21038     87357.69  0.4331535
#> 6           A01    22.26976     87331.48  0.4329590
```

```
gammodel <- model_gam(test, x = test$Temperature, y = test$Normalized)
test <- model_fit(test, model = gammodel)
```

Output analysis result using `view_model()` to view normalized data and fitted model. Determine if any noise need to be removed (i.e. subsetting by temperature range). Determine which model is the best (i.e. is currrent data already smoothed, does fitted model suit well.) Determine if Tm-estimation is proper. \*current model assumes derivative estimation of Tm value.

```
Tm_est(test)
```

```
#> [1] 53.73642
```

```
view <- view_model(test)
view[[1]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
```

![](data:image/png;base64...)

```
view[[2]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
```

![](data:image/png;base64...)

Screen all wells for curve shape on raw\_data set and sift out corrupted data. This step is not required but may help remove data modeling errors.

```
myApp <- weed_raw(raw_data, checkrange = c("A", "C", "1", "12"))
```

```
shiny::runApp(myApp)
```

```
raw_data <- remove_raw(raw_data, removerange = c("B", "H", "1", "12"))
screen(raw_data) + theme(
    aspect.ratio = 0.7,
    legend.position = "bottom",
    legend.text = element_text(size = 6),
    legend.key.size = unit(0.4, "cm"),
    legend.title = element_text(size = 8)
) +
    guides(color = guide_legend(nrow = 2, byrow = TRUE))
```

![](data:image/png;base64...)

## 5. 96-well Analysis Application

TSAR package excels in mass analysis by propagating identical protocols to all 96 wells. `smoothed = T` infers current data is smoothed and no separate modeling is needed. If modeling is needed, input argument as `smoothed = F`.

TSAR package performs derivative analysis using a generalized additive model through package `mgcv` or boltzmann analysis using nlsLM from package `minpack.lm`.

## 6. Intermediate Data Output

Read analysis using read\_tsar() function and view head and tail to ensure appropriate output was achieved. Data output can also be saved locally into .csv or .txt format using function wrtie\_tsar. However, pipeline to downstream analysis does not require output to be locally saved.

```
#>   Well.Position       tm
#> 1           A01 53.49893
#> 2           A02 54.33012
#> 3           A03 53.79578
#> 4           A04 54.68635
#> 5           A05 54.27076
#> 6           A06 55.04258
```

```
#>    Well.Position       tm
#> 7            A07 53.14270
#> 8            A08 55.16132
#> 9            A09 53.97390
#> 10           A10 55.04258
#> 11           A11 54.27076
#> 12           A12 54.68635
```

write output data file `write_tsar(read_tsar(x, output_content = 2),` `name = "0923_tm_val", file = "csv")`

## 7. Complete Dataset with Ligand and Protein Information

For downstream analysis, data need to be mapped towards specific ligand and compound. Use may input by default excel template included in the package or input as .txt or .csv table, specifying Ligand and Compound by Well ID. Data with coumpound and ligand labels can also be stored locally using the same mean as previous step. All data are kept including wells with blank condition information (specified as NA). In case removal is needed, call function na.omit().

```
#>   Well.Position Temperature Fluorescence Normalized   norm_deriv       tm
#> 1           A01    21.97290     87464.91  0.4339496 -0.003408165 53.49893
#> 2           A01    22.03227     87437.66  0.4337473 -0.003369012 53.49893
#> 3           A01    22.09164     87410.72  0.4335473 -0.003331383 53.49893
#> 4           A01    22.15101     87384.08  0.4333495 -0.003300231 53.49893
#> 5           A01    22.21038     87357.69  0.4331535 -0.003277111 53.49893
#> 6           A01    22.26976     87331.48  0.4329590 -0.003259463 53.49893
#>   Protein Ligand
#> 1   CA FL   DMSO
#> 2   CA FL   DMSO
#> 3   CA FL   DMSO
#> 4   CA FL   DMSO
#> 5   CA FL   DMSO
#> 6   CA FL   DMSO
```

```
#>       Well.Position Temperature Fluorescence  Normalized  norm_deriv       tm
#> 14766           A12    94.64307     15464.46 0.011995930 -0.03386972 54.68635
#> 14767           A12    94.70245     15343.25 0.009985017 -0.03379408 54.68635
#> 14768           A12    94.76181     15222.33 0.007978866 -0.03371186 54.68635
#> 14769           A12    94.82118     15101.69 0.005977393 -0.03363219 54.68635
#> 14770           A12    94.88055     14981.33 0.003980515 -0.03355871 54.68635
#> 14771           A12    94.93993     14861.24 0.001988068 -0.03348381 54.68635
#>       Protein     Ligand
#> 14766   CA FL PyxINE HCl
#> 14767   CA FL PyxINE HCl
#> 14768   CA FL PyxINE HCl
#> 14769   CA FL PyxINE HCl
#> 14770   CA FL PyxINE HCl
#> 14771   CA FL PyxINE HCl
```

Write output into the working directory with write\_tsar `write_tsar(norm_data, name = "vitamin_tm_val_norm", file = "csv")`

## 8. Merge Data across Biological Replicates

Repeat step 2 through 6 on replicate data set. A five step function call will complete all analysis. If additional screening is desired, a two step call will run the interactive window to allow selection of

```
data("qPCR_data2")
raw_data_rep <- qPCR_data2

raw_data_rep <- remove_raw(raw_data_rep, removerange = c("B", "H", "1", "12"))
```

```
myApp <- weed_raw(raw_data_rep)
shiny::runApp(myApp)
```

```
raw_data_rep <- remove_raw(raw_data_rep, removelist = "A12")
screen(raw_data_rep) + theme(
    aspect.ratio = 0.7,
    legend.position = "bottom",
    legend.text = element_text(size = 6),
    legend.key.size = unit(0.4, "cm"),
    legend.title = element_text(size = 8)
) +
    guides(color = guide_legend(nrow = 2, byrow = TRUE))
```

![](data:image/png;base64...)

```
analysis_rep <- gam_analysis(raw_data_rep, smoothed = TRUE)
output_rep <- read_tsar(analysis_rep, output_content = 2)
norm_data_rep <- join_well_info(
    file_path = NULL,
    file = well_information,
    output_rep, type = "by_template"
)
norm_data_rep <- na.omit(norm_data_rep)
```

Merge data by content. All data are marked its source file name and experiment date.

```
norm_data <- na.omit(norm_data)
norm_data_rep <- na.omit(norm_data_rep)
tsar_data <- merge_norm(
    data = list(norm_data, norm_data_rep),
    name = c(
        "Vitamin_RawData_Thermal Shift_02_162.eds.csv",
        "Vitamin_RawData_Thermal Shift_02_168.eds.csv"
    ),
    date = c("20230203", "20230209")
)
```

## 9. Tm Estimation Shift Visualization

Use condition\_IDs() and well\_IDs() to select or remove condition to visualize. Visualize Tm estimation by compound or ligand type in the format of box graph.

```
condition_IDs(tsar_data)
```

```
#> [1] "CA FL_DMSO"       "CA FL_CAI"        "CA FL_BIOTIN"     "CA FL_4-ABA"
#> [5] "CA FL_=+-LA"      "CA FL_PyxINE HCl"
```

```
well_IDs(tsar_data)
```

```
#>  [1] "A01_CA FL_DMSO_20230203"       "A02_CA FL_DMSO_20230203"
#>  [3] "A03_CA FL_CAI_20230203"        "A04_CA FL_CAI_20230203"
#>  [5] "A05_CA FL_BIOTIN_20230203"     "A06_CA FL_BIOTIN_20230203"
#>  [7] "A07_CA FL_4-ABA_20230203"      "A08_CA FL_4-ABA_20230203"
#>  [9] "A09_CA FL_=+-LA_20230203"      "A10_CA FL_=+-LA_20230203"
#> [11] "A11_CA FL_PyxINE HCl_20230203" "A12_CA FL_PyxINE HCl_20230203"
#> [13] "A01_CA FL_DMSO_20230209"       "A02_CA FL_DMSO_20230209"
#> [15] "A03_CA FL_CAI_20230209"        "A04_CA FL_CAI_20230209"
#> [17] "A05_CA FL_BIOTIN_20230209"     "A06_CA FL_BIOTIN_20230209"
#> [19] "A07_CA FL_4-ABA_20230209"      "A08_CA FL_4-ABA_20230209"
#> [21] "A09_CA FL_=+-LA_20230209"      "A10_CA FL_=+-LA_20230209"
#> [23] "A11_CA FL_PyxINE HCl_20230209"
```

```
conclusion <- tsar_data %>%
    filter(condition_ID != "NA_NA") %>%
    filter(condition_ID != "CA FL_Riboflavin")
TSA_boxplot(conclusion,
    color_by = "Protein", label_by = "Ligand",
    separate_legend = FALSE
)
```

![](data:image/png;base64...)

## 10. TSA Curve Visualization

Specify Control condition by assigning condition\_ID to control. TSA\_compare\_plot generated multiple line graphs for comparison.

```
control_ID <- "CA FL_DMSO"

TSA_compare_plot(conclusion,
    y = "RFU",
    control_condition = control_ID
)
```

```
#> $`CA FL_CAI`
```

![](data:image/png;base64...)

```
#>
#> $`CA FL_BIOTIN`
```

![](data:image/png;base64...)

```
#>
#> $`CA FL_4-ABA`
```

![](data:image/png;base64...)

```
#>
#> $`CA FL_=+-LA`
```

![](data:image/png;base64...)

```
#>
#> $`CA FL_PyxINE HCl`
```

![](data:image/png;base64...)

```
#>
#> $`Control: CA FL_DMSO`
```

![](data:image/png;base64...)

Select by condition or well IDs to view curves and estimated Tm values.

```
error <- conclusion %>% filter(condition_ID == "CA FL_PyxINE HCl")
TSA_wells_plot(error, separate_legend = FALSE)
```

![](data:image/png;base64...)

To further visualize the comparison, graph first derivatives grouped by needs (i.e. well\_ID, condition\_ID, or other separately appended conditions).

Below is an example command. Due to size limit of vignette, graph will not be displayed. `view_deriv(conclusion, frame_by = "condition_ID")`

## 11. Session Info

### 11.1 Citation

```
citation("TSAR")
```

```
#> To cite package 'TSAR' in publications use:
#>
#>   Gao X, McFadden WM, Wen X, Emanuelli A, Lorson ZC, Zheng H, Kirby KA,
#>   Sarafianos SG (2023). "Use of TSAR, Thermal Shift Analysis in R, to
#>   identify Folic Acid as a Molecule that Interacts with HIV-1 Capsid."
#>   _bioRxiv_. doi:10.1101/2023.11.29.569293
#>   <https://doi.org/10.1101/2023.11.29.569293>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {Use of TSAR, Thermal Shift Analysis in R, to identify Folic Acid
#>             as a Molecule that Interacts with HIV-1 Capsid},
#>     author = {X. Gao and W. M. McFadden and X. Wen and A. Emanuelli and Z. C. Lorson and H. Zheng and K. A. Kirby and S. G. Sarafianos},
#>     journal = {bioRxiv},
#>     year = {2023},
#>     doi = {10.1101/2023.11.29.569293},
#>   }
```

```
citation()
```

```
#> To cite R in publications use:
#>
#>   R Core Team (2025). _R: A Language and Environment for Statistical
#>   Computing_. R Foundation for Statistical Computing, Vienna, Austria.
#>   <https://www.R-project.org/>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {R: A Language and Environment for Statistical Computing},
#>     author = {{R Core Team}},
#>     organization = {R Foundation for Statistical Computing},
#>     address = {Vienna, Austria},
#>     year = {2025},
#>     url = {https://www.R-project.org/},
#>   }
#>
#> We have invested a lot of time and effort in creating R, please cite it
#> when using it for data analysis. See also 'citation("pkgname")' for
#> citing R packages.
```

```
citation("dplyr")
```

```
#> To cite package 'dplyr' in publications use:
#>
#>   Wickham H, François R, Henry L, Müller K, Vaughan D (2023). _dplyr: A
#>   Grammar of Data Manipulation_. doi:10.32614/CRAN.package.dplyr
#>   <https://doi.org/10.32614/CRAN.package.dplyr>, R package version
#>   1.1.4, <https://CRAN.R-project.org/package=dplyr>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {dplyr: A Grammar of Data Manipulation},
#>     author = {Hadley Wickham and Romain François and Lionel Henry and Kirill Müller and Davis Vaughan},
#>     year = {2023},
#>     note = {R package version 1.1.4},
#>     url = {https://CRAN.R-project.org/package=dplyr},
#>     doi = {10.32614/CRAN.package.dplyr},
#>   }
```

```
citation("ggplot2")
```

```
#> To cite ggplot2 in publications, please use
#>
#>   H. Wickham. ggplot2: Elegant Graphics for Data Analysis.
#>   Springer-Verlag New York, 2016.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Book{,
#>     author = {Hadley Wickham},
#>     title = {ggplot2: Elegant Graphics for Data Analysis},
#>     publisher = {Springer-Verlag New York},
#>     year = {2016},
#>     isbn = {978-3-319-24277-4},
#>     url = {https://ggplot2.tidyverse.org},
#>   }
```

### 11.2 Session Info

```
sessionInfo()
```

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] shiny_1.11.1  ggplot2_4.0.0 dplyr_1.1.4   TSAR_1.8.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] shinyjs_2.1.0       htmlwidgets_1.6.4   rstatix_0.7.3
#>  [7] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#> [10] generics_0.1.4      tibble_3.3.0        pkgconfig_2.0.3
#> [13] Matrix_1.7-4        data.table_1.17.8   RColorBrewer_1.1-3
#> [16] S7_0.2.0            readxl_1.4.5        lifecycle_1.0.4
#> [19] stringr_1.5.2       compiler_4.5.1      farver_2.1.2
#> [22] minpack.lm_1.2-4    carData_3.0-5       httpuv_1.6.16
#> [25] shinyWidgets_0.9.0  htmltools_0.5.8.1   sass_0.4.10
#> [28] yaml_2.3.10         lazyeval_0.2.2      Formula_1.2-5
#> [31] plotly_4.11.0       later_1.4.4         pillar_1.11.1
#> [34] car_3.1-3           ggpubr_0.6.2        jquerylib_0.1.4
#> [37] tidyr_1.3.1         cachem_1.1.0        abind_1.4-8
#> [40] nlme_3.1-168        mime_0.13           tidyselect_1.2.1
#> [43] zip_2.3.3           digest_0.6.37       stringi_1.8.7
#> [46] purrr_1.1.0         labeling_0.4.3      splines_4.5.1
#> [49] cowplot_1.2.0       fastmap_1.2.0       grid_4.5.1
#> [52] cli_3.6.5           magrittr_2.0.4      dichromat_2.0-0.1
#> [55] broom_1.0.10        withr_3.0.2         scales_1.4.0
#> [58] promises_1.4.0      backports_1.5.0     rmarkdown_2.30
#> [61] httr_1.4.7          otel_0.2.0          cellranger_1.1.0
#> [64] ggsignif_0.6.4      openxlsx_4.2.8      evaluate_1.0.5
#> [67] knitr_1.50          viridisLite_0.4.2   mgcv_1.9-3
#> [70] rlang_1.1.6         Rcpp_1.1.0          xtable_1.8-4
#> [73] glue_1.8.0          rhandsontable_0.3.8 jsonlite_2.0.0
#> [76] R6_2.6.1
```