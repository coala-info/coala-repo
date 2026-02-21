# TSAR Package Structure

# 1. Introduction

TSAR Package provides simple solution to qPCR data processing, computing thermal shift analysis given either raw fluorescent data or smoothed curves. The functions provide users with the protocol to conduct preliminary data checks and also expansive analysis on large scale of data. Furthermore, it showcases simple graphic presentation of analysis, generating clear box plot and line graphs given input of desired designs. Overall, TSAR Package offers a workflow easy to manage and visualize.

# 2. Installation

Use commands below to install TSAR package: library(BiocManager) BiocManager::install(“TSAR”)

```
library(TSAR)
library(dplyr)
library(ggplot2)
library(shiny)
library(utils)
```

![](data:image/png;base64...)

# 3. Data Structure

TSAR segregates data structure into three tiers:

* `raw_data`, raw-readings of qPCR data
* `norm_data`, pre-processed and normalized data
* `tsar_data`, analyzed with ready for graphs

Users may initiate the TSAR workflow from either `raw_data` or `norm_data` as long as the data achieves approriate qualities. Functions corresponding each tier are wrapped in shiny application. All analysis and visualization can be achieved within user-interactive window, also open-able in local browser.

* `weed_raw()`; input: raw; output: data without blank and corrupted curves
* `analyze_norm()`; input: raw or output of weed\_raw; output: analyzed data with conditions specified
* `graph_tsar()`; input: tsar\_data or output of analyze\_norm; output: graphs

# 4. From `raw_data` to `norm_data`

To access the workflow of `TSAR`, user can input raw fluorescent readings through built in functions from utils: `read.delim()` or `read.csv()`. Built in data imports from RStudio UI is also appropriate, given `raw_data` only needs to be saved as `dataframe` structure. Wrapping input in `data.frame()` will also ensure correct data type. Use `head()` and `tail()` to ensure excessive information is removed, i.e. blank lines, duplicate titles, etc.

```
data("qPCR_data1")
raw_data <- qPCR_data1
head(raw_data)
tail(raw_data)
```

## 4.1 Data Preprocessing

From raw data to ready-for-analysis data, there are few functions to assist the selection and normalization of data.

Functions `screen()` and `remove_raw()` helps screen and remove data of selection. This save time and space by remove unwanted data such as blank wells and corrupted curves. Aside from `data` param input, both functions share similar parameters of `checkrange`, `checklist` or `removerange`, `removelist`.

* `checkrange`, `removerange` : a range of wells, e.g. wells from A01 to B08 is `c("A","B","1","8")`
* `checklist`, `removelist`: a list of wells, e.g. `c("A01","C03")`

If no wells are specified, `screen()` will default to screening every well and `reomve_raw()` will default to not removing an well.

```
screen(raw_data) + theme(
    aspect.ratio = 0.7,
    legend.position = "bottom",
    legend.text = element_text(size = 4),
    legend.key.size = unit(0.1, "cm"),
    legend.title = element_text(size = 6)
) +
    guides(color = guide_legend(nrow = 4, byrow = TRUE))
```

![](data:image/png;base64...)

```
raw_data <- remove_raw(raw_data, removerange = c("C", "H", "1", "12"))
```

Both functions above are wrapped inside an interactive window through function `weed_raw()`. It is implemented through R Shiny application where users can select curves using cursor and remove selected curves easily. Refer to separate vignette, `"TSAR Workflow by Shiny"`, and README.md file for more documentation.

```
runApp(weed_raw(raw_data))
```

Running the window, we can spot that the curve at A12 has an abnormally high initial fluorescence and should be removed for data accuracy. We can make sure of correct selection through the `View Selected` button and remove it using the `Remove Data` button. Note that all data edits are made inside the interactive window. To translate the change globally for downstream analysis, simply click `Save to R`and close window to store data into the global environment. Alternatively, click `Copy Selected` and paste information to `remove_raw()`. To avoid error, close window proper through `Close Window` instead of the cross mark on top left corner.

```
raw_data <- remove_raw(raw_data,
    removelist =
        c(
            "B04", "B11", "B09", "B05", "B10", "B03",
            "B02", "B01", "B08", "B12", "B07", "B06"
        )
)
```

## 4.2 Data Analysis

Normalizing data is prompted through `normalize()`. Although individual calls are not necessary as they are wrapped together in `gam_analysis()`, if viewing the validity of model is desired, one can prompt analysis of one well.

TSAR package performs derivative analysis using a generalized additive model through package `mgcv` or boltzmann analysis using nlsLM from package `minpack.lm`.

### 4.2.1 Individual Well Application

For analysis of an idividual well, refer to these following functions:

* `normalize()`
* `model_gam()`
* `model_fit()`
* `view_model()`
* `Tm_est()`

```
test <- filter(raw_data, raw_data$Well.Position == "A01")
test <- normalize(test)
gammodel <- model_gam(test, x = test$Temperature, y = test$Normalized)
test <- model_fit(test, model = gammodel)
view <- view_model(test)
view[[1]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
```

![](data:image/png;base64...)

```
view[[2]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
```

![](data:image/png;base64...)

```
Tm_est(test)
```

```
#> [1] 53.73642
```

View model generates a list of two graphs, showing fit of modeling on fluorescence data and the derivative calculation of such data.

### 4.2.2 96-Well Plate Application

All analysis necessary are formatted in function `gam_analysis()`. Parameters are inherited from functions noted in section “Individual Well Application”. Hence, if any errors are prompted, check through individual well application for correct parameter input and other potential errors.

* `smoothed` inherited from model\_fit()
* `fluo` and `selections` inherited from normalize()

```
x <- gam_analysis(raw_data,
    smoothed = TRUE,
    fluo_col = 5,
    selections = c(
        "Well.Position", "Temperature",
        "Fluorescence", "Normalized"
    )
)
```

## 4.3 Data Summary

Data summary offers an exit point from the workflow if no further graphic outputs are required. Output is allowed in three formats: - `output_content = 0`, only Tm values by well - `output_content = 1`, all data analysis by each temperature reading. If previously called `smoothed = T`, analysis will not run gam modeling, thus will not have `fitted` data. - `output_content = 2`, combination of the above two data set.

To associate ligand and protein conditions with each individual well, call the function `join_well_info()`. One may specify using the template excel or separate csv file containing a table of three variables, “Well”, “Protein”, and “Ligand”.

```
data("well_information")
output <- join_well_info(
    file_path = NULL, file = well_information,
    read_tsar(x, output_content = 0), type = "by_template"
)
```

Write output using command write\_tsar `write_tsar(output, name = "vitamin_analysis", file = "csv")`

To streamline to the following graphic analysis, make sure `output_content = 2` to maintain all necessary data.

```
norm_data <- join_well_info(
    file_path = NULL, file = well_information,
    read_tsar(x, output_content = 2), type = "by_template"
)
```

All of the function above in section 2 are wrapped together in a shiny application named `analyze_norm()`. Refer to separate vignette, `"TSAR Workflow by Shiny"`, and README.md file for more documentation.

```
runApp(analyze_norm(raw_data))
```

# 5. From `norm_data` to `tsar_data`

`norm_data` contains normalized fluorescent data on a scale of 0 to 1 based on the maximum and minimum fluorescence reading. `norm_data` also contains a first derivative column. `tsar_data` is the final format of project data encapsulating all replication. Therefore, it contains all condition data including experiment date and analysis file source.

## 5.1 Merge Replicates

Use `merge_norm()` to merge all norm\_data and specify original data file name and experiment date for latter tracking purposes.

```
# analyze replicate data
data("qPCR_data2")
raw_data_rep <- qPCR_data2
raw_data_rep <- remove_raw(raw_data_rep,
    removerange = c("B", "H", "1", "12"),
    removelist = c("A12")
)
analysis_rep <- gam_analysis(raw_data_rep, smoothed = TRUE)
norm_data_rep <- join_well_info(
    file_path = NULL, file = well_information,
    read_tsar(analysis_rep, output_content = 2),
    type = "by_template"
)

# merge data
tsar_data <- merge_norm(
    data = list(norm_data, norm_data_rep),
    name = c(
        "Vitamin_RawData_Thermal Shift_02_162.eds.csv",
        "Vitamin_RawData_Thermal Shift_02_168.eds.csv"
    ),
    date = c("20230203", "20230209")
)
```

### 5.1.1 Jumpstart to Graph

If outputted data from qPCR already contains analysis and data necessary, enter TSAR workflow from here, using functions `merge_TSA()`, `read_raw_data()`, `read_analysis()`.

```
#analysis_file <- read_analysis(analysis_file_path)
#raw_data <- read_raw_data(raw_data_path)
#merge_TSA(analysis_file, raw_data)
```

After merging, use assisting functions to check and trace data. Use these two functions to guide graphics analysis for error identification, selective graphing and graph comparisons.

* `condition_IDs()` list all conditions in data
* `well_IDs()` list all IDs of individual well
* `TSA_proteins()` list all distinct proteins
* `TSA_ligands()` list all distinct ligands
* `TSA_Tms()` list all Tm estimations by condition
* `Tm_difference()` list all delta Tm estimations by control condition

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
TSA_proteins(tsar_data)
```

```
#> [1] "CA FL"
```

```
TSA_ligands(tsar_data)
```

```
#> [1] "4-ABA"      "=+-LA"      "BIOTIN"     "CAI"        "DMSO"
#> [6] "PyxINE HCl"
```

```
conclusion <- tsar_data %>%
    filter(condition_ID != "NA_NA") %>%
    filter(condition_ID != "CA FL_Riboflavin")
```

## 5.2 Graphic Analysis

### 5.2.1 Tm Boxplot

Use `TSA_boxplot()` to generate comparison boxplot graphs. Stylistics choices include coloring by protein or ligand, and legend separation. Function returns ggplot object, thus further stylistic changes are allowed.

```
TSA_boxplot(conclusion,
    color_by = "Protein",
    label_by = "Ligand", separate_legend = TRUE
)
```

```
#> [[1]]
```

![](data:image/png;base64...)

```
#>
#> [[2]]
```

![](data:image/png;base64...)

### 5.2.2 TSA Curve Visualization

`TSA_compare_plot()` generates multiple line graphs for comparison. Specify Control condition by assigning condition\_ID to control. Functions allows graphing by both: - raw fluorescent readings `y = 'Fluorescence'` - normalized readings `y = 'RFU'`.

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

### 5.2.3 Curves by Condition

Users may also graph by condition IDs or well IDs using function `TSA_wells_plot()`.

```
ABA_Cond <- conclusion %>% filter(condition_ID == "CA FL_4-ABA")
TSA_wells_plot(ABA_Cond, separate_legend = TRUE)
```

```
#> [[1]]
```

![](data:image/png;base64...)

```
#>
#> [[2]]
```

![](data:image/png;base64...)

### 5.2.4 First Derivative Comparison

To further visualization comparison, graph first derivatives grouped by needs. Note if modeling was set to boltzman fit, frist derivatives will be excessively smooth and contains no information beyond specified minimum and maximum. Below is an example command. Due to size limit of vignette, graph will not be displayed. `view_deriv(conclusion, frame_by = "condition_ID")`

All of the above functions are also wrapped in an interactive window call through `graph_tsar()`. Simply call function on merged tsar\_data and access all graphing features in one window. Refer to separate vignette, `"TSAR Workflow by Shiny"`, and readme.md file for more documentation.

```
runApp(graph_tsar(tsar_data))
```

# 6. Session Info

## 6.1 Citation

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

```
citation("shiny")
```

```
#> To cite package 'shiny' in publications use:
#>
#>   Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J,
#>   McPherson J, Dipert A, Borges B (2025). _shiny: Web Application
#>   Framework for R_. doi:10.32614/CRAN.package.shiny
#>   <https://doi.org/10.32614/CRAN.package.shiny>, R package version
#>   1.11.1, <https://CRAN.R-project.org/package=shiny>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {shiny: Web Application Framework for R},
#>     author = {Winston Chang and Joe Cheng and JJ Allaire and Carson Sievert and Barret Schloerke and Yihui Xie and Jeff Allen and Jonathan McPherson and Alan Dipert and Barbara Borges},
#>     year = {2025},
#>     note = {R package version 1.11.1},
#>     url = {https://CRAN.R-project.org/package=shiny},
#>     doi = {10.32614/CRAN.package.shiny},
#>   }
```

```
citation("utils")
```

```
#> The 'utils' package is part of R.  To cite R in publications use:
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

## 6.2 Session Info

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