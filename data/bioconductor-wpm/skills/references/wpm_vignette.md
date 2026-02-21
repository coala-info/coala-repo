# How to use Well Plate Maker

Helene Borges

#### 30 October 2025

#### Abstract

The **W**ell-**P**late **M**aker (WPM) is a shiny application deployed as an R package. Functions for a command-line/script use are also available. The WPM allows users to generate well plate maps to carry out their experiments while improving the handling of batch effects. In particular, it helps controlling the “plate effect” thanks to its ability to randomize samples over multiple well plates. The algorithm for placing the samples is inspired by the backtracking algorithm: the samples are placed at random while respecting specific spatial constraints. The use of WPM as well as the definition of configurable spatial constraints are described in the following sections.

# 1 Introduction

This tutorial explains how to use the **Well Plate Maker** package.

## 1.1 General principle

To generate plate maps, the WPM uses an algorithm inspired from the backtracking
algorithm. More precisely, WPM loops on the following actions until all of the
samples are given a correct location:

1. Randomly choose a well on the plate
2. Randomly selects a sample
3. Check whether all the specified location constraints are met. If yes, place the sample accordingly

This process allows for an experimental design by block randomization.

## 1.2 Uses and associated input formats

There are two ways to use the `WPM`:

* [Command line](#R_commands) with appropriate R functions: for users who want to work with
  scripts or want to integrate the WPM into a pre-existing pipeline.
* Through a [graphical interface (GUI)](#shiny_app): for users who do not necessarily have advanced
  R programming skills.

**Important:** Even in case of command line use, we strongly recommend to read the section about the
[shiny app section](#shiny_app), as this is where all terms and concepts are detailed.

| Input Format | Command line | WPM app |
| --- | --- | --- |
| CSV | yes | yes |
| ExpressionSet | yes | no |
| SummarizedExperiment | yes | no |
| MSnSet | yes | no |

# 2 Getting started

## 2.1 Prerequisites

Make sure you are using a recent version of R (\(\geq 4.0.0\)).
For Windows users who do not have the Edge browser, we recommend using the
Chrome browser rather than Internet Explorer.

## 2.2 How to install

From GitHub (consider it a devel version):

```
devtools::install_github("HelBor/wpm", build_vignettes=TRUE)
```

From Bioconductor (release, stable version):

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("wpm")
```

Instructions can also be found on the
[Bioconductor page](http://bioconductor.org/packages/release/bioc/html/wpm.html)

# 3 How to use the WPM shiny application

## 3.1 Load the WPM package

```
library(wpm)
```

## 3.2 Launch the shiny application

Whether you use RStudio or simply work in an R console, the procedure remains
the same to launch the shiny app:

```
library(wpm)
wpm()
```

If everything is in order, a new window will open in your default browser.
If not, find the line written in the R console that looks like
`Listening on http://127.0.0.1:8000`, and paste the URL in your web browser.

WPM has 4 main tabs: **Home**, **Parameters**, **Results** and **Help**.

## 3.3 The **Home** tab

This tab briefly presents the aim of the app, shows the last package version,
explains how to support our work by citing the associated article and gives contact information.

![](data:image/png;base64...)

The Home page when wpm is started

## 3.4 The **Parameters** tab

Overall the page is organized in two sections.

The one on the left hand side contains all the configuration steps.
It is divided into 7 main steps, detailed below. It is of the utmost
importance to correctly specify all the constraints for generating the desired
plate maps.

The one on the right hand side summarizes the input parameters (tuned along the 7 steps of
the left panel) as well as the chosen (empty) plate layout. The right section is
automatically updated each time a parameter is changed in the left section.

![](data:image/png;base64...)

Parameters Panel

### 3.4.1 Step 1: Upload the dataset

First, you need to upload a ***Comma-separated values*** (.CSV) or a text (.txt) file.
This file contains at least one piece of information: the list of the sample names.

| Sample |
| --- |
| s1 |
| s2 |
| s3 |
| s4 |

It is also possible to provide a file containing several other variables describing
the data, as in the example below:

| Sample | Type | Treatment |
| --- | --- | --- |
| s1 | A | trt1 |
| s2 | A | tr1 |
| s3 | B | Ctrl |
| s4 | C | Ctrl |

**IMPORTANT** Please make sure the data in the CSV file respect the following SPECIFIC ORDER of columns:
Sample names in the **first** column, and other variables in the other columns,
like the example below (if there are rownames, then the *Samples* Column must be
the second in the file.):

```
Sample;Type;Treatment
s1;A;trt1
s2;A;trt1
s3;B;Ctrl
s4;C;Ctrl
```

> If this is your first time using the WPM, we recommend that you test the
> capabilities of the WPM using the **demo dataset** (“Load the demo dataset” tab).

Second, you have to specify if there are quotes in your file or not
*(If you are using the demo dataset, this is not a requested parameter.)*:

The default is *none*, meaning that there is no ***"*** or ***’*** characters in your file.
If you select the appropriate quote, then you will be able to:

* check if your file does have a **header** and **row names**.
* select the appropriate **separator** field. Default is semicolon (***“;”***)

Then, you can select one of the variables that you want to use as the grouping
factor for WPM.
This column will be renamed “Group” in the final dataset.

![](data:image/png;base64...)

Choose the grouping factor

The names you give to columns in your CSV file do not matter, because the WPM will create
a new dataset having 3 fields: *“Sample”* , *“Group”* and *“ID”*.

You will see your dataset on the right hand side of the window, as well as another dataset
which will be used by WPM to generate the map(s).
Each sample is assigned a unique ID, which will be used to name it
onto the plate maps (for more details on the ID see the [Results section](#results_panel) ).

![](data:image/png;base64...)

Dataset vizualisation

**IMPORTANT** Please ensure that the dataset is correctly displayed in the right
window and that the number of samples / groups is correct.
If you see that the total number of samples is wrong, this means that you have
not chosen the appropriate options among those described above, so that corrections are needed.

### 3.4.2 Step 2: Choose a Project name

This step is mandatory. It will be used in the plot titles as well as in the output
file names. Moreover, it be concatenated with sample IDs to limit confusions.

### 3.4.3 Step 3: Plate(s) dimensions

Here you have to specify the plate dimensions and their number. Currently, WPM
supports plate dimensions of 6, 24, 48, 96, 386, 1534 wells; as well as custom dimensions
(where you manually specify the number of rows and columns).

To the right of step 2 you can see an information box, warning you that WPM
will distribute the samples in a balanced manner within the plates (if there
are several of them).

![](data:image/png;base64...)

balanced way message

If you select a plate size compatible with the total number of samples, you
will see two blue boxes and a plate plan appear on the right hand side. They summarize all
the elements of your configuration.
In the example below, we selected the pre-defined dimension of 96 wells and only
one plate:

![](data:image/png;base64...)

plate dimensions example

The right side of the panel will summarize all these parameters:

![](data:image/png;base64...)

parameters summary

This plot updates with each modification of the parameters, thus making it
possible to see if one has made an error.

**IMPORTANT**: If the WPM detects a problem or incompatibility between parameters,
you will see an error message instead of the plate map, providing hints on the possible origin of the problem.

![](data:image/png;base64...)

Example of error message

### 3.4.4 Step 4: Forbidden wells

In this step are listed the **Forbidden wells**, if any (optional):

> A **Forbidden well** will not be filled with any kind of sample, either
> because the user does not want to (*e.g.* plate corners in case of non-uniform
> heat distribution), or because of material constraints (*e.g.* dirty wells, broken
> pipettes).

You fill the text input with the coordinates of the wells (a combination of
letters and numbers, as in the example below):

![](data:image/png;base64...)

Example of forbidden wells listed in the text input

You will see the plot updated in the right section:

![](data:image/png;base64...)

Updated plot with forbidden wells

The wells filled with forbidden wells will have the *“forbidden”* ID in the
final dataset. On the resulting map, these wells will be colored in red.

### 3.4.5 Step 5: Buffers

At this stage you can specify the wells which correspond to buffers, if there
are any.

> A **buffer well** corresponds to a well filled filled with solution but without biological material (*e.g.* to avoid/check for cross-contamination).

Five patterns are available for placing the buffers:

**1)** *no buffers*: there will be no buffer on the plate(s).

**2)** *Per line*: Automatically places buffers every other row.
You can choose to start placing in even or odd row.

![](data:image/png;base64...)

Per line mode example with even option

**3)** *Per column*: Automatically places buffers every other column.
You can choose to start placing in even or odd column.

![](data:image/png;base64...)

Per Column mode example with even option

**4)** *Checkerboard*: Automatically places buffers like a checkerboard.

![](data:image/png;base64...)

Checkerboard mode

**5)** *Choose by hand*: It is the same procedure as for specifying forbidden
wells.

#### 3.4.5.1 Specify the neighborhood constraints

These are the spatial constraints that the WPM needs to respect when designing the plates.
Currently, 4 types of them are proposed. Note that the patterns are available only
if they are compatible with the chosen buffer pattern.
The question here is: Should samples from the same group be found side by side?

Schematically, the spatial constraints can be summarized as follows (the blue
well is the current well evaluated by WPM; The wells in green are those
assessed for compliance with the chosen constraint. The blue well therefore has
the possibility (but not the obligation since the filling of the plate is done
randomly) to be filled with a sample belonging to the same group as the samples
in the wells evaluated.

NS (North South): samples from the same group will not be placed side by side
column-wise.
![North-South constraint](data:image/png;base64...)

WE (West East): samples from the same group will not be placed side by side
row-wise.
![East-West constraint](data:image/png;base64...)

NSEW (North South East West): samples from the same group will not be placed
side by side either row-wise or column-wise.
![North-South-East-West constraint](data:image/png;base64...)

None: samples from the same group can be placed anywhere, including side by side.
![No constraint](data:image/png;base64...)

The wells filled with buffer solution will have the *“buffer”* ID in the
final dataset. On the resulting map, these wells will be colored in grey.

### 3.4.6 Step 6: Fixed samples

At this stage you can specify the wells which correspond to fixed
samples, if there are any.

> A **fixed sample** corresponds to a quality control sample or standard.
> The precise location of these samples must be controlled by the researcher.

This step works in exactly the same way as the
[forbidden well](#forbidden_wells) step. The only difference is that the fixed samples
will appear in **black** on the plot.

The fixed samples will have the *“fixed”* ID in
the final dataset.

### 3.4.7 Number of iterations

Choose a **maximum number of iterations** to find a solution, then start the
WPM by clicking the **“start WPM”** button. If the samples do not have a group, then the samples
will be placed completely randomly on the plates. If there are groups, the WPM will
use an algorithm inspired by the backtracking algorithm (to place the
samples in the wells while respecting the specified constraints).

The default value is 20, but if your configuration is somewhat complex, then
it is advised to increase the number.

An *iteration* corresponds to an attempt by the WPM to find a solution. The
algorithm used is not fully backtracked: the WPM stops as soon as there are no
more possibilities to finalize the current solution; then, it starts back from scratch
the plate map, until a solution that fits all the constraints is found.
With this approach, not all possible combinations are explored, but it does
reduce execution time.

When you start the computations, a progress bar appears.

If the WPM finds a solution, you will see this pop in the browser, inviting you to
go to the [Result Panel](#results_panel):

![](data:image/png;base64...)

WPM succeeded

If the WPM fails, an error message will appear, prompting you to try again:

![](data:image/png;base64...)

WPM failed

**IMPORTANT** If after launching WPM and generating the results, you realize
that one or more parameters do not work, you can always return to the
“Parameters” tab and modify them. The data displayed in the “Results” tab will
not be automatically changed, you will have to click again on the “start WPM”
button to take into account the new changes.

**NOTE** If you want to create a new plate plan for another project, press
`ctrl + f5`, this will reset the application.

---

## 3.5 The **Results** tab

The Result panel allows you to look at the final dataset containing the well
chosen for each sample, as well as a plot of your final well-plate map. Dataframe and
plots are downloadable separately.

![](data:image/png;base64...)

Final dataframe

The dataset contains 7 columns giving all the information needed to implement the
experiment: The sample name with its corresponding group; its ID for the plot;
the well chosen; the row and the column to which the well corresponds to; and the
number of the plate on which the sample must be placed.

This tab also shows the generated plot(s) of the final well-plate map(s).
One color corresponds to one group label. The numbers are the IDs used in
place of the sample names which could be too long to keep the plot readable.

Below is an example of 80 samples distributed in 10 groups (of unequal sizes) and placed on a
96 well-plate, with the North-South-East-West neighborhood constraint:

![](data:image/png;base64...)

Plate map

# 4 Using the WPM in command lines

As explained before, the WPM can also be used through R command lines by
following these steps:

1. Cast the dataset into the correct format
2. Run the WPM
3. Visualize the final plate plan(s)

## 4.1 Prepare the dataset

The user can work with CSV files, `ExpressionSet`, `MSnSet` or
`SummarizedExperiment`objects.
The first step is to create a dataframe containing all the necessary information for the WPM
to work correctly. Notably, it is needed to specify which column in the file
corresponds to the grouping factor, if any.

### 4.1.1 Starting from a CSV file:

```
imported_csv <- wpm::convertCSV("path-to-CSV-file")
```

### 4.1.2 Starting from an `ExpressionSet` or `MSnSet` object

```
sample_names <- c("s1","s2","s3","s4", "s5")
M <- matrix(NA, nrow = 4, ncol = 5)
colnames(M) <- sample_names
rownames(M) <- paste0("id", LETTERS[1:4])
pd <- data.frame(Environment = rep_len(LETTERS[1:3], 5),
                 Category = rep_len(1:2, 5), row.names = sample_names)
rownames(pd) <- colnames(M)
my_MSnSet_object <- MSnbase::MSnSet(exprs = M,pData =  pd)
```

Then, run `convertESet` by specifying the object and the variable to use as
grouping factor for samples:

```
df <- wpm::convertESet(my_MSnSet_object, "Environment")
```

### 4.1.3 Starting from a `SummarizedExperiment`

```
nrows <- 200
ncols <- 6
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
colData <- data.frame(Treatment=rep(c("ChIP", "Input"), 3),
                      row.names=LETTERS[1:6])
se <- SummarizedExperiment::SummarizedExperiment(assays=list(counts=counts),
                                                 colData=colData)
df <- wpm::convertSE(se, "Treatment")
```

For more details about the functions, please use `?wpm::<functionName>` R command.

## 4.2 Run the WPM

The next step is to run the `wrapperWPM` function by giving it all the parameters
needed:

* The dataframe generated with `convertXXX` functions
* The [plate dimensions](#plate-dims)
* The number of plates to fill
* The [forbidden wells](#forbidden_wells) (wells that must not be filled at all for the experiment)
* The [buffer wells](#buffers) (wells where there will be solution without biological material)
* The position of [fixed samples](#fixed_wells)
* The [spatial constraint](#neighborhood) to be respected when randomizing the samples
* The [maximal number of attempts](#iterations_number) for the WPM to find a valid solution

### 4.2.1 When using a CSV file

In the running toy example (see code shunks around), we do not specify any buffer well.

```
wpm_result <- wpm::wrapperWPM(user_df = imported_csv$df_wpm,
            plate_dims = list(8,12),
            nb_plates = 1,
            forbidden_wells = "A1,A2,A3",
            fixed_wells = "B1,B2",
            spatial_constraint = "NS")
```

### 4.2.2 When using an R-structured dataset (`ExpressionSet`, `MSnSet` or `SummarizedExperiment`)

```
wpm_result <- wpm::wrapperWPM(user_df = df,
            plate_dims = list(8,12),
            nb_plates = 1,
            forbidden_wells = "A1,A2,A3",
            fixed_wells = "B1,B2",
            spatial_constraint = "NS")
```

```
## 2025-10-30 03:11:55.42796 INFO::max_iteration: 20
## 2025-10-30 03:11:55.443803 INFO:backtrack/map:nrow(c): 6
## 2025-10-30 03:11:55.460307 INFO::plate number 1
## 2025-10-30 03:11:55.477278 WARNING:fonctions.generateMapPlate:number of attempts: 1
## 2025-10-30 03:11:55.480243 INFO:backtracking:class(new_df): data.frame
```

For more details, see `?wpm::wrapperWPM`

## 4.3 Plate map visualization

The final step is to create a visual output of the generated plate plan(s)
using the `drawMap()` function:

```
drawned_map <- wpm::drawMap(df = wpm_result,
        sample_gps = length(levels(as.factor(colData$Treatment))),
        gp_levels = gp_lvl <- levels(as.factor(colData$Treatment)),
        plate_lines = 8,
        plate_cols = 12,
        project_title = "my Project Title")
```

```
drawned_map
```

![](data:image/png;base64...)

For more details, see `?wpm::drawMap`

Plots can be saved with:

```
ggplot2::ggsave(
    filename = "my file name",
    plot = drawned_map,
    width = 10,
    height = 7,
    units = "in"
)
```

**IMPORTANT** If multiple plates where specified, then `wpm_result` will be a
list containing a dataset **for each generated plate**. Then, each of them can be accessed with `wpm_result[[numberOfThePlate]]`:

```
numberOfThePlate <- 1
drawned_map <- wpm::drawMap(df = wpm_result[[numberOfThePlate]],
        sample_gps = length(levels(as.factor(pd$Environment))),
        gp_levels = gp_lvl <- levels(as.factor(pd$Environment)),
        plate_lines = 8,
        plate_cols = 12,
        project_title = "my Project Title")
```

# 5 Citing Our work

> Borges, H., Hesse, A. M., Kraut, A., Couté, Y., Brun, V., & Burger, T. (2021). Well Plate Maker: A user-friendly randomized block design application to limit batch effects in largescale biomedical studies. Bioinformatics ([link to the publication](https://academic.oup.com/bioinformatics/advance-article-abstract/doi/10.1093/bioinformatics/btab065/6128508)).

# 6 SessionInfo

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] rlang_1.1.6                 magrittr_2.0.4
##   [3] clue_0.3-66                 matrixStats_1.5.0
##   [5] compiler_4.5.1              vctrs_0.6.5
##   [7] reshape2_1.4.4              stringr_1.5.2
##   [9] ProtGenerics_1.42.0         pkgconfig_2.0.3
##  [11] MetaboCoreUtils_1.18.0      crayon_1.5.3
##  [13] fastmap_1.2.0               magick_2.9.0
##  [15] XVector_0.50.0              rmarkdown_2.30
##  [17] preprocessCore_1.72.0       tinytex_0.57
##  [19] purrr_1.1.0                 xfun_0.53
##  [21] MultiAssayExperiment_1.36.0 cachem_1.1.0
##  [23] jsonlite_2.0.0              DelayedArray_0.36.0
##  [25] BiocParallel_1.44.0         parallel_4.5.1
##  [27] cluster_2.1.8.1             R6_2.6.1
##  [29] bslib_0.9.0                 stringi_1.8.7
##  [31] RColorBrewer_1.1-3          limma_3.66.0
##  [33] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [35] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [37] bookdown_0.45               SummarizedExperiment_1.40.0
##  [39] iterators_1.0.14            knitr_1.50
##  [41] IRanges_2.44.0              BiocBaseUtils_1.12.0
##  [43] Matrix_1.7-4                igraph_2.2.1
##  [45] tidyselect_1.2.1            dichromat_2.0-0.1
##  [47] abind_1.4-8                 yaml_2.3.10
##  [49] doParallel_1.0.17           codetools_0.2-20
##  [51] affy_1.88.0                 lattice_0.22-7
##  [53] tibble_3.3.0                plyr_1.8.9
##  [55] Biobase_2.70.0              withr_3.0.2
##  [57] S7_0.2.0                    evaluate_1.0.5
##  [59] Spectra_1.20.0              pillar_1.11.1
##  [61] affyio_1.80.0               BiocManager_1.30.26
##  [63] MatrixGenerics_1.22.0       foreach_1.5.2
##  [65] stats4_4.5.1                wpm_1.20.0
##  [67] MSnbase_2.36.0              MALDIquant_1.22.3
##  [69] ncdf4_1.24                  generics_0.1.4
##  [71] S4Vectors_0.48.0            ggplot2_4.0.0
##  [73] scales_1.4.0                glue_1.8.0
##  [75] lazyeval_0.2.2              tools_4.5.1
##  [77] mzID_1.48.0                 QFeatures_1.20.0
##  [79] vsn_3.78.0                  mzR_2.44.0
##  [81] fs_1.6.6                    XML_3.99-0.19
##  [83] grid_4.5.1                  impute_1.84.0
##  [85] tidyr_1.3.1                 MsCoreUtils_1.22.0
##  [87] PSMatch_1.14.0              cli_3.6.5
##  [89] S4Arrays_1.10.0             dplyr_1.1.4
##  [91] AnnotationFilter_1.34.0     pcaMethods_2.2.0
##  [93] gtable_0.3.6                logging_0.10-108
##  [95] sass_0.4.10                 digest_0.6.37
##  [97] BiocGenerics_0.56.0         SparseArray_1.10.0
##  [99] farver_2.1.2                htmltools_0.5.8.1
## [101] lifecycle_1.0.4             statmod_1.5.1
## [103] MASS_7.3-65
```