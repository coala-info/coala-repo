# TSAR Workflow by Shiny

![](data:image/png;base64...) ## 1. Introduction TSAR, short for Thermal Shift Analysis in R, provides simple solution to qPCR data processing, computing thermal shift analysis given either raw fluorescent data or smoothed curves. The functions provide users with the protocol to conduct preliminary data checks and also expansive analysis on large scale of data. Furthermore, it showcases simple graphic presentation of analysis, generating clear box plot and line graphs given input of desired designs. Overall, TSAR Package offers a workflow easy to manage and visualize. TSAR Package is wrapped within a three separate shiny application regarding, data pre-processing, data analysis, and data visualization. All application can be opened in both interactive window or browsing engine by copy pasting server address into web browser.

## 2. Installation

## 3. Load TSAR Package

Use commands below to install TSAR package: library(BiocManager) BiocManager::install(“TSAR”)

```
library(TSAR)
library(shiny)
```

## 4. Data Pre-Processing

Load data and remove blank wells by specifying a range of wells with `removerange = c()` or individual wells with `removelist = c()`. User may also use function `weed_raw()` to open Shiny application to screen all raw curves and remove by curve selection. To propagate change to data to local change, close window properly by clicking `Close Window`. The updated data set will be stored in the global environment as `new_raw_data`.

```
data("qPCR_data1")
qPCR_data1 <- remove_raw(qPCR_data1, removerange = c("B", "H", "1", "12"))
```

```
runApp(weed_raw(qPCR_data1))
```

In the plot panel, user can interact with graph and select and un-select data by clicking on curves. User may also `View Selected` wells only and `Remove Selected`. To return to default page and current all change to data set, click `Refresh Screening`. To propagate the same changes to local data set, simple click`Close Window`. Else, click `Copy Well IDs` or `Copy Selected in Full Function Call` to copy a `remove_raw()` call containing all selected wells into clipboard. Paste the call back into console or script and run to propagate changes locally. p.s. It is recommended to remove large areas of blank wells before calling `weed_raw()` to boost speed of application.

![](data:image/png;base64...)

Selection by grid is also possible; click on grid to highlight wells of selection. Click again to un-highlight. Click too fast may lead to error due to speed of reaction, use `Clear All Selected` button at the top of page to reset selection. Note that clearing selections alters to-be-copied selections, but will not restore curves already removed in the graph. However, changes are not made permanently. If erroneously removed, simply close and reopen window to run again.

![](data:image/png;base64...)

Use `View Selected` and `Remove Selected` to view and remove selection. To return to viewing rest of the data, click `Refresh Screening`. To propagate the same changes to local data set, click `Copy Selected in Full Function Call` to copy a `remove_raw()` call containing all selected wells into clipboard. Paste the call back into console or script and run to propagate changes locally. ![](data:image/png;base64...)

## 5. Data Analysis

Analyze data by calling function `analyze_norm()` and follow the workflow from top to bottom. Preview data table for changes occurring at each step and refer to graph to view fit of model on each well. Always refer to the message for hints and error references. A success message will also be prompted after each successful run of step.

Remember to save analysis output locally by clicking `Save File`. Always preview data before saving to ensure data contains all necessary information.

```
runApp(analyze_norm(qPCR_data1))
```

The top left panel output a preview of current data set. The right panel allows user to view the fit of model and Tm estimation by individual wells of selection. Once confirming correct data input and modeling effects,

![](data:image/png;base64...)

Click `Analyze all Wells` to propagate model and analysis onto the rest of data. A preview of analyzed data will also be modeling and analyzing all 96 Wells will take between 30 to 50 seconds. If no modeling are needed, given data are smooth enough, analysis of all 96 wells should be completed under 5 seconds. p.s. actual time length many subject to change under different conditions

![](data:image/png;base64...)![](data:image/png;base64...)

Upload well information by excel template and preview to confirm if information is correct. Use `Preview` to preview uploaded information and directly edit inside the window. User may also choose `Manual Input` to put in all condition information by Well. Make sure to hit `Save Changes` after editing and click `Set Conditions` to link all data to the conditions. A success message should be prompted. p.s. manually inputted information will override file upload. If mistakenly saved, please close window and re-run command.

![](data:image/png;base64...)![](data:image/png;base64...)

![](data:image/png;base64...)

Lastly, to save all analysis locally, click `Save File` after previewing output. p.s. make to select `both` under `Choose dataset` if intending to use `graph_tsar()` or other graphing tools within the package.

## 6. Data Visualization

Use function `graph_tsar()` to start a Shiny application for graphing options. Run `na.omit()` on data if error occurs. Four graphing options are allowed, boxplot of Tm, compare plots, and conditions plot.

Function takes optional data parameter. If analysis file is already imported in the environment, call function as `graph_tsar(tsar_data)`. Refer to vignette “TSAR Workflow by Command” for instructions on how to merge using function `merge_norm()`. Else, user may use the merge data panel to upload and merge data of all test trials. Simply call `graph_tsar()` and click `Upload and Merge Data` button to reveal the panel to merge data.

```
runApp(graph_tsar())
```

Upload is limited to 30MB in size, but not count. After upload, user will be prompted corresponding numbers of input boxes to specify date of each experiment. Click `Save Dates`, then `Merge and Save Data`. A short preview of tsar\_data will be prompted. For full lists and filters of well\_ID and conditions\_ID, refer to the helper buttons at the bottom of page.

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Top panel outputs all plots, selected desired graphing features below and click generate to output graphs. p.s. Graphing compare plots and selected curves are takes longer than boxplot, please give it few seconds to load.

Boxplot has the option to be loaded interactive. Note interactive graphs have to be produced with legend combined.

![](data:image/png;base64...)![](data:image/png;base64...)

![](data:image/png;base64...)

Generating compare plots will output all plausible comparisons by control. To any specific one, a drop list `View Only:` will be prompted below the button `Generate Compare Plots`. Select by condition\_ID to zoom in on graphs.

![](data:image/png;base64...)

![](data:image/png;base64...)

Compare plots for first derivative graphs are interactive graphs grouped by specified variable. ![](data:image/png;base64...)

Helper functions include these following:

![](data:image/png;base64...)![](data:image/png;base64...)

## 7. Session Info

### 7.1 Citation

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

### 7.2 Session Info

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