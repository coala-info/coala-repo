# ADAMgui: Activity and Diversity Analysis Module Graphical User Interface

## Giordano B. S. Seco, André L. Molan, Agnes A. S. Takeda,

### 29 October 2025

# Overview

*ADAMgui* is an Graphical User Interface for the ADAM package which is
GSEA R package created to group a set of genes from comparative samples
(control *versus* experiment) belonging to different species according to
their respective functions (Gene Ontology and KEGG pathways as default)
and show their significance by calculating p-values referring to gene
diversity and activity ([Castro 2009](#ref-Castro2009)). Each group of genes is called GFAG
(Group of Functionally Associated Genes).

The ADAM package was constituted by an
statistical class, all genes present in the expression data are
grouped by their respective functions according to the domains described by
AnalysisDomain argument. The relationship between genes and functions are made
based on the species annotation package. If there is no annotation package,
a three column file (gene, function and function description) must be provided.
For each GFAG, gene diversity and activity in each sample are calculated. As the
package always compare two samples (control *versus* experiment), relative gene
diversity and activity for each GFAG are calculated. Using bootstrap method,
for each GFAG, according to relative gene diversity and activity, two p-values
are calculated. The p-values are then corrected, according to the correction
method defined by PCorrectionMethod argument, generating a q-value ([Molan 2018](#ref-molan2018)).
The significative GFAGs will be those whoose q-value stay under the cutoff set
by PCorrection argument. Optionally, it’s possible to run Wilcoxon test and/or
Fisher’s exact test (@fontoura2016). These tests also provide a corrected
p-value, and siginificative groups can be seen through them.

The ADAMgui package provides a graphical class so the outputs of the statistical
functions in the ADAM package can be studied through different plots.
It’s possible, for example, to choose a specific GFAG and observe the gene
expression behavior within it. Features as differential expression and fold
change can be easily seen.

# Package Download and Installation

Download and installation of the package can be done with *Bioconductor*
plataform via *BiocManager* package, as the code chunk shows:

```
if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
    BiocManager::install("ADAMgui")}
```

Download and installation of the development version of the package can be done
from the package’s GitHub repositories as follows:

```
BiocManager::install('jrybarczyk/ADAMgui')
```

After download and installation of the desired version of the ADAMgui package,
it can be loaded:

```
library(ADAMgui)
```

# Graphical User Interface (GUI)

The ADAMgui package contains 2 graphical modules for visualization and analysis of
the GFAGAnalysis output file. These modules are shiny-generated (GUI)s that
allows the user to create and download plots in .eps format. The functions that
launches those applications are: GFAGpathUi() and GFAGtargetUi(). The sections
below contains more information about both applications.

## GFAG Path Viewer Function: GFAGpathUi()

‘Paths’ are essentially group names that contains the targets (eg: Gene
Ontologies and KEGG are paths while genes and proteins related to them
are targets). The GFAGAnalysis output file contains information about the paths
that the user utilized in the analysis and the GFAGpathUi() is a function that
launches a shiny based (GUI) that can construct heatmaps for q-values present in
the GFAGAnalysis output file. Below there is the layout of an usage example of
the application with the GFAGAnalysis output file created with the first 10
entries of the *Aedes Aegypt* data used in the statistical modules.

To generate the input file ‘ResultAnalysisAedes.txt’ use the commands on R
console listed below. First load the data in the package:

```
library(ADAMgui)
data("ResultAnalysisAedes")
```

Then select the first 10 rows:

```
library(ADAMgui)
data("ResultAnalysisAedes")
dt<-ResultAnalysisAedes[1:10,]
```

And save it:

```
write.table(dt,'ResultAnalysisAedes.txt',sep='\t',quote = F,
    row.names = F,col.names = T)
```

Now launch the app, it can be launched in local machine or your default browser:

```
library(ADAMgui)
```

```
 GFAGpathUi(TRUE)  #Run the app in your default browser.
 GFAGpathUi(FALSE) #Run the app in R (your local machine).
```

![drawing](data:image/png;base64...)

* \*\*1\*\* - \*\*Tabs\*\*

  +

  \*\*Data Input\*\* -
  The first and the only non-disabled Tab upon the application's launching.
  As the name implies, it is where the user will choose the input
  data (GFAGAnalysis output file) and it's reading parameters.

  +

  \*\*Data Selection\*\* - The elements of
  this Tab will be disabled initially, you need to correctly upload a file in
  the first tab to enable it's elements. Here you will be able to select the
  data to be plotted.

  +

  \*\*Data Formatting\*\* - The elements of
  this Tab will be disabled initially, you need to correctly upload a file in
  the first tab and then select your data in the second Tab to enable its
  elements. Here you will be able to format the selected data (select column
  order, rename columns, etc.).

  +

  \*\*Plot\*\* - The elements of
  this Tab will be disabled initially, you need to correctly upload a file in
  the first tab, select your data in the second Tab and the format the
  selected data in the third Tab to enable its elements. Here you will be
  able to plot the data and download the plot in .eps format.
* \*\*2\*\* - \*\*Tab 1: File upload\*\* - A search

buttom to upload the non-formated raw data (GFAGAnalysis output file)

* \*\*3\*\* - \*\*Tab 1: Read Table Parameters\*\* -

Parameters for reading file uploaded in **2**, checks=TRUE.

* \*\*4\*\* - \*\*Tab 1: Read Table Separator\*\* -

Separators for reading file uploaded in **2**, checks=TRUE (naturally only
one may be selected).

* \*\*5\*\* - \*\*Tab 1: File Information\*\* -

Dinamic message in the main panel that informs the user about the progress in
the process of file uploading.

* \*\*6\*\* - \*\*Tab 1: Main Panel Tabs\*\* - Tabs

in the main panel that only appear if a file was correctly uploaded. The ’
About file’ Tab provides basic information about the uploaded file such as
name, size and path. The ‘Data’ Tab shows the created data.table according to
the uploaded file in **1** and the selected parameters in **3** and **4**.
The ‘Summary’ Tab shows the output of the summary() function.

![drawing](data:image/png;base64...)

* \*\*7\*\* - \*\*Tab 2: Select the ID column\*\* -

Select the ID (Path) column of the uploaded file.

* \*\*8\*\* -

**Tab 2: Select the P-values/Q-values columns** -
Select multiple columns corresponding to the p-values or q-values to be
plotted.

* \*\*9\*\* - \*\*Tab 2: Create Dataframe\*\* -

Action Buttom to create a data.frame with the selected columns in **7** and
**8**. Note that you can add columns from multiple files, as long as the
ID column is IDENTICAL!

* \*\*10\*\* -

**Tab 2: Dataframe is ready for plotting** - Action button to confirm the
creation of the data.frame.

* \*\*11\*\* - \*\*Tab 2: Reset Dataframe\*\* -

Action buttom that resets everything done by the user in **Tabs 2,3 and 4**.

\*

\*\*12\*\* - \*\*Tab 2: Main Panel\*\* -
Shows the selected data.frame and the created data.frame.

![drawing](data:image/png;base64...)

* \*\*13\*\* -

**Tab 3: Select Columns Order** - Select the desired column order of your
created data.frame, this will affect the plot.

* \*\*14\*\* -

**Tab 3: Re-order dataframe** - Action button that reorders the created
data.frame according to the selected order in **13**. Should **13**
be empty the order will not be altered.

* \*\*15\*\* -

**Tab 3: Select a column to rename** - Disabled until you hit **14**,
this allows the user to select a column to be renamed. Note that renaming
columns is purely optional!.

* \*\*16\*\* -

**Tab 3: Write a name for the selected column** - Disabled until you hit **14**,
this allows the user to input a new name for the column selected in **15**.
Note that renaming columns is purely optional!.

* \*\*17\*\* -

**Tab 3: Rename Button** - Disabled until you hit
**14**, this action button renames the column selected in **14** with the name
in **15**. If **15** is empty, the column in **14** will not be renamed.
Note that renaming columns is purely optional!.

* \*\*18\*\* -

**Tab 3: Select ID/Path column position** - Disabled until you hit **14**,
here you must select what is the current position of your ID/Path column
in your currently formated data.frame. The default value is 1, should your
ID/Path column be in another position, then change the value accordingly!

* \*\*19\*\* -

**Tab 3: Dataframe is ready for plotting** - Disabled until you hit **14**,
this action button informs the application that the formating process is
finished. Upon hitting the plotting phase will start and the elements in
Tab 4 will be enabled.
.

* \*\*20\*\* -

**Tab 3: Main Panel** - The main Panel will show the created data.frame in
**Tab 2** initially, then it will also show the formated data.frame upon any
changes done by the user in **Tab 3**. The main panel also displays a dinamic
message that informs the user about progress done in this Tab.
.

![drawing](data:image/png;base64...)

* \*\*21\*\* -

**Tab 4: Plot Height** - Select the desired height for the plot,
it is a reactive input, meaning that the plot will be updated automatically
as this value changes.
.

* \*\*22\*\* -

**Tab 4: Plot Width** - Select the desired width for the plot,
it is a reactive input, meaning that the plot will be updated automatically
as this value changes.
.

* \*\*23\*\* -

**Tab 4: Select a font family for plot elements** - Select the desired font
family for the plot’s elements. Not reactive, you need to click in **29** to
re-plot and see the changes.
.

* \*\*24\*\* -

**Tab 4: Select a size for plot elements** - Select the desired size for the
font of the plot’s elements. Not reactive, you need to click in **29** to
re-plot and see the changes.
.

* \*\*25\*\* -

**Tab 4: Select a size for plot legend** - Select the desired size for the
font of the plot’s legend. Not reactive, you need to click in **29** to
re-plot and see the changes.
.

* \*\*26\*\* -

**Tab 4: Select a font face for the axis text** - Select the desired font
face/style (default=‘plain’,‘bold’,‘italic’,‘bold.italic’) for the font of the
plot’s legend. Not reactive, you need to click in **29** to re-plot and see
the changes.

* \*\*27\*\* -

**Tab 4: Select a font face for the legend** - Select the desired font
face/style (default=‘plain’,‘bold’,‘italic’,‘bold.italic’) for the font of the
plot’s legend. Not reactive, you need to click in **29** to re-plot and see the
changes.

* \*\*28\*\* -

**Tab 4: Plot Button** - Action button to display the plot with the
selected parameters.

* \*\*29\*\* -

**Tab 4: Download Button** - Download buttom, downloads the displayed
plot in .eps format. Disabled as long as there is no plot displayed.

* \*\*30\*\* -

**Tab 4: Main Panel** - Displays the plot.

## GFAG Target Viewer Function: GFAGtargetUi()

This application was made to further analyse the GFAGs in the GFAGAnalysis
output file. These paths can have many targets (genes, proteins) and this
application constructs a plot that show the differential expression of the
targets in a selected Path. The user needs to input 4 files in order to use this
application: the GFAGAnalysis output file, an expression file, a Path-to-Target
relationship file and a differential expression file.

Below there is the layout of an usage example of the application with the
GFAGAnalysis output file of the *Aedes Aegypt* data used in the
statistical modules. Load the required data first in order to generate
the input data:

```
library(ADAM)
library(ADAMgui)
```

```
data("ResultAnalysisAedes") # GFAG Output data
```

```
data("ExpressionAedes") # target expression data
```

```
data("GeneFunctionAedes") # Path-to-Target relationship data
```

```
data("DiffAedes") # target differential expression
```

Now create the files:

```
# save the GFAG output file
write.table(dt,'ResultAnalysisAedes.txt',sep='\t',quote = F,
    row.names = F,col.names = T)

# save the target expression file
write.table(dt,'ExpressionAedes.txt',sep='\t',quote = F,
    row.names = F,col.names = T)

# save the Path-to-Target relationship file
write.table(dt,'GeneFunctionAedes.txt',sep='\t',quote = F,
    row.names = F,col.names = T)

# save the target differential expression file
write.table(dt,'DiffAedes.txt',sep='\t',quote = F,
    row.names = F,col.names = T)
```

The app can be launched in local machine or your default browser:

```
library(ADAM)
library(ADAMgui)
```

```
GFAGtargetUi(TRUE)  #Run the app in your default browser.
GFAGtargetUi(FALSE) #Run the app in R (your local machine).
```

![drawing](data:image/png;base64...)

* \*\*1\*\* - \*\*Tabs\*\*

  +

  \*\*File Upload & Case Selection\*\* -
  The first and the only non-disabled Tab upon the application's launching.
  As the name implies, it is where the user will choose the input
  data (GFAGAnalysis output file) it's reading parameters.

  +

  \*\*GFAG Data Filter\*\* -
  The elements of this Tab will be disabled initially, you need to correctly
  upload a file in the first tab to enable it's elements. Here you will be
  able to filter and select the Paths whose targets will be plotted.

  +

  \*\*Plot\*\* -
  The elements of this Tab will be disabled initially, you need to correctly
  upload a file in the first tab and select a GFAG in the second Tab to
  enable it's elements. Here you will be able to select plotting parameters,
  construct the plot and download it in .eps format.
* \*\*2\*\* -

**Tab 1: GFAG Data** Initially this the only enabled element. Is it
where the user will choose the GFAGAnalysis output file and consequentially
the case as well.

* \*\*3\*\* -

**Tab 1: Target Expression Data** . This element is initially disabled, the user
needs to correctly upload a GFAGAnalysis output file first to enable it.
Here the user will choose the expression file that he used to generate the
GFAG output file that was selected.

* \*\*4\*\* -

**Tab 1: Path-to-Target Data** . This element is initially disabled, the user
needs to correctly upload a GFAGAnalysis output file and a expression file
first. Here the user will choose the Path-to-Target relationship file that can
be generated by the statistical modules.

* \*\*5\*\* -

**Tab 1:Target Differential Expression Data** . This element is initially
disabled, the user needs to correctly upload a GFAGAnalysis output file, a
expression file anda Path-to-Target file first. Here the user will choose the
differential expression file of interest. Note that this package does not
supports differential expression analysis. The user needs to make the analysis
by other means and input the results in the correct format. Because of this,
once a file is uploaded a menu containing reading parameters and column
selection elements will be displayed in this field. The columns to be selected
are respectively: the column the contains the target’s ID, the column that
contains the logFC (log Fold Change) values and a the column that contains the
p-values or q-values. No control can implemented here, so if the user input the
wrong columns in the fields, the resulting plot will be wrong. Should this
happen the user needs to reset the application by clicking on **6**.

* \*\*6\*\* -

**Tab 1: Reset Button** . This action button can reset the whole application
so the user can make a new analysis.

* \*\*7\*\* -

**Tab 1: Main Panel Tabs** .
+

**7** -
**Tab 1: Main Panel Tab 1-Summary** Displays information about
the uploaded files such as the number of entries in each file,
the number of unique elements in each file, the number of targets
that are present in your expression file that are contemplated
in the Path-to-Target file, the number of Paths in your GFAGAnalysis output
file that are contemplated in the Path-to-Target.

+

**7** -
**Tab 1: Main Panel Tab 2-Tables** Displays data.tables of the uploaded
files.

* \*\*8\*\* -

**Tab 1: Main Panel** . Different displays depending on the selected Tab
in **7**.

![drawing](data:image/png;base64...)

* \*\*9\*\* -

**Tab 2: Select q-value cut-off for ativity** - Input a desired q-value
cutoff for the ativity.

* \*\*10\*\* -

**Tab 2: Select q-value cut-off for diversity** - Input a desired q-value
cutoff for the diversity.

* \*\*11\*\* -

**Tab 2: Filter Buttons** - Action buttons for filtering the uploaded GFAG
output file so the user can select a Path. There are 4 buttons: ‘Filter
Ativity’, ‘Filter Diversity’, ‘Filter Ativity and Diversity’ and
‘No Filter’, respectively.

* \*\*12\*\* -

**Tab 2: Select a Path of interest** - Select a path of interest and then
click on the ‘Update GFAG/Path’ action button to update the value.

* \*\*13\*\* -

**Tab 2: Start Plot** - Click in the action button once a Path has been
selected and updated in **12** to start the plotting phase and enable
the elements in **Tab 3**

* \*\*14\*\* -

**Tab 2: Main Panel** - Displays a data.table of the filtered GFAGAnalysis
output file.

![drawing](data:image/png;base64...)

* \*\*15\*\* -

**Tab 3: Q-value interval selection** - Slider input to select a desired
q-value interval between 0 and 1. Used for filtering q-values to plot.

* \*\*16\*\* -

**Tab 3: LogFC interval selection** - Slider input to select a desired
logFC interval between -10 and 10. Used for filtering logFCs to plot.

* \*\*17\*\* -

**Tab 3: Plot Height** - Select the desired plot height.

* \*\*18\*\* -

**Tab 3: Plot Width** - Select the desired plot height.

* \*\*19\*\* -

**Tab 3: Select font family for plot elements** - Select the desired font family
for the plot’s elements.

* \*\*20\*\* -

**Tab 3: Select font size for plot elements** - Select the desired font size
for the plot’s elements.

* \*\*21\*\* -

**Tab 3: Select font size for plot title** - Select the desired font size
for the plot’s title.

* \*\*22\*\* -

**Tab 3: Select font size for axis text** - Select the desired font size
for the axis text.

* \*\*23\*\* -

**Tab 3: Select font size for axis title** - Select the desired font size
for the axis title.

* \*\*24\*\* -

**Tab 3: Select font face for axis text** - Select the desired font face/style
for the axis text.

* \*\*25\*\* -

**Tab 3: Select font face for axis title** - Select the desired font face/style
for the axis title.

* \*\*26\*\* -

**Tab 3: Select font face for plot title** - Select the desired font face/style
for the plot title.

* \*\*27\*\* -

**Tab 3: Plot Buttons** - Buttons to create a plot with the selected data and
parameters and display it on the main panel. There are 4 tipes of plots: ‘Plot
with filtered LogFC values’, ‘Plot with filtered q.values’, ‘Plot with filtered
q.values and LogFC values’ and ‘Plot with no filter’.

* \*\*28\*\* -

**Tab 3: Download Plot** - Download buttom for downloading the displayed plot
in .eps format. Disabled as long as there is no plot displayed on the main
panel.

* \*\*29\*\* -

**Tab 3: Main Panel** - Display the plot.

# Session Info

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
## [1] ADAMgui_1.26.0 ADAM_1.26.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] Biostrings_2.78.0           S7_0.2.0
##  [7] fastmap_1.2.0               promises_1.4.0
##  [9] shinyjs_2.1.0               digest_0.6.37
## [11] mime_0.13                   lifecycle_1.0.4
## [13] KEGGREST_1.50.0             RSQLite_2.4.3
## [15] magrittr_2.0.4              compiler_4.5.1
## [17] rlang_1.1.6                 tools_4.5.1
## [19] yaml_2.3.10                 data.table_1.17.8
## [21] knitr_1.50                  ggsignif_0.6.4
## [23] S4Arrays_1.10.0             htmlwidgets_1.6.4
## [25] bit_4.6.0                   DelayedArray_0.36.0
## [27] plyr_1.8.9                  RColorBrewer_1.1-3
## [29] abind_1.4-8                 purrr_1.1.0
## [31] BiocGenerics_0.56.0         grid_4.5.1
## [33] stats4_4.5.1                ggpubr_0.6.2
## [35] xtable_1.8-4                GO.db_3.22.0
## [37] ggplot2_4.0.0               scales_1.4.0
## [39] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [41] cli_3.6.5                   rmarkdown_2.30
## [43] crayon_1.5.3                generics_0.1.4
## [45] otel_0.2.0                  reshape2_1.4.4
## [47] httr_1.4.7                  DBI_1.2.3
## [49] pbapply_1.7-4               cachem_1.1.0
## [51] stringr_1.5.2               parallel_4.5.1
## [53] AnnotationDbi_1.72.0        BiocManager_1.30.26
## [55] XVector_0.50.0              matrixStats_1.5.0
## [57] vctrs_0.6.5                 Matrix_1.7-4
## [59] carData_3.0-5               car_3.1-3
## [61] IRanges_2.44.0              S4Vectors_0.48.0
## [63] rstatix_0.7.3               bit64_4.6.0-1
## [65] ggrepel_0.9.6               Formula_1.2-5
## [67] testthat_3.2.3              tidyr_1.3.1
## [69] colorRamps_2.3.4            glue_1.8.0
## [71] DT_0.34.0                   stringi_1.8.7
## [73] gtable_0.3.6                later_1.4.4
## [75] GenomicRanges_1.62.0        tibble_3.3.0
## [77] pillar_1.11.1               htmltools_0.5.8.1
## [79] Seqinfo_1.0.0               brio_1.1.5
## [81] R6_2.6.1                    varhandle_2.0.6
## [83] evaluate_1.0.5              shiny_1.11.1
## [85] lattice_0.22-7              Biobase_2.70.0
## [87] backports_1.5.0             png_0.1-8
## [89] broom_1.0.10                memoise_2.0.1
## [91] BiocStyle_2.38.0            httpuv_1.6.16
## [93] Rcpp_1.1.0                  gridExtra_2.3
## [95] SparseArray_1.10.0          xfun_0.53
## [97] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Castro MA, Filho JLR, Dalmolin RJ, Sinigaglia M, Moreira JC, Mombach JC, de Almeida RM (2009).
“ViaComplex: software for landscape analysis of gene expression networks in genomic context.”
*Bioinformatics*, **25**(11), 1468–1469.

Molan AL (2018).
*Construction of a tool for multispecies genic functional enrichment analysis among comparative samples*.
Master's thesis, Institute of Biosciences of Botucatu – Univ. Estadual Paulista.
<http://hdl.handle.net/11449/157105>.