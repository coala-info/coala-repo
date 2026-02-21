# Code example from 'upandrunning' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
knitr::opts_chunk$set(crop = NULL)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("pcaExplorer")
# library("pcaExplorer")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("airway")

## ----eval=FALSE---------------------------------------------------------------
# library("pcaExplorer")
# pcaExplorer()

## ----ss00, echo=FALSE, fig.cap="Overview of the Data Upload panel. After clicking on the 'Load the demo airway data' button, all widgets are automatically populated, and each data component (count matrix, experimental data, dds object, annotation) can be previewed in a modal window by clicking on its respective button."----
knitr::include_graphics("unr_00_demo_loaded.png")

## ----ss01, echo=FALSE, fig.cap="Screenshot of the sample to sample scatter plot matrix. The user can select the correlation method to use, the option to plot values on log2 scales, and the possibility to use a subset of genes (to obtain a quicker overview if many samples are provided)."----
knitr::include_graphics("unr_01_splom.png")

## ----ss02, echo=FALSE, fig.cap="Screenshot of the sample to sample heatmap. Selected is the Manhattan distance, but Euclidean and correlation-based distance are also provided as options. In this case, the user has also selected the dex and cell factors in the 'Group/color by' widget in the sidebar menu, and these covariates decorate the heatmap to facilitate identification of patterns."----
knitr::include_graphics("unr_02_sts_heatmap.png")

## ----ss03, echo=FALSE, fig.cap="Screenshot of the Basic Summary of the counts in the Data Overview panel. General information are provided, together with an overview on detected genes according to different filtering criteria."----
knitr::include_graphics("unr_03_summary_counts.png")

## ----ss04a, echo=FALSE, fig.cap="The Samples View panel. Displayed are a PCA plot (left) and the corresponding scree plot (right), with the samples colored and labeled by cell type - separating on the second principal component."----
knitr::include_graphics("unr_04a_samplespca.png")

## ----ss04b, echo=FALSE, fig.cap="PCA plot for the samples, colored by dexamethasone treatment. The dex factor is the main driver of the variability in the data, and samples separate nicely on the first principal component."----
knitr::include_graphics("unr_04b_samples_dex.png")

## ----ss05, echo=FALSE, fig.cap="Genes with highest loadings on the first and second principal components. The user can select how many top and bottom genes will be displayed, and the gene names are printed below each gene's contribution on each PC."----
knitr::include_graphics("unr_05_loadings.png")

## ----ss06a, echo=FALSE, fig.cap="Plot of the gene expression levels of DUSP1. Points are split according to dex treatment, and both graphics and table are displayed."----
knitr::include_graphics("unr_06a_genefinder_dusp1.png")

## ----ss06b, echo=FALSE, fig.cap="Plot of the gene expression levels of PER1. Points are split according to dex treatment."----
knitr::include_graphics("unr_06b_genefinder_per1.png")

## ----ss06c, echo=FALSE, fig.cap="Plot of the gene expression levels of DDX3Y. Points are split according to cell type, as this gene was highly variable across this experimental factor - indeed, in one cell type it is barely detected."----
knitr::include_graphics("unr_06c_genefinder_ddx3y.png")

## ----ss07, echo=FALSE, fig.cap="The Genes View panel. Upper panel: the genes biplot, and its zoomed plot, with gene names displayed. Lower panel: the profile explorer of the selected subset of genes (corresponding to the zoomed window), and the boxplot for the gene selected by clicking close to a location in the zoomed window."----
knitr::include_graphics("unr_07_genespca.png")

## ----ss08, echo=FALSE, fig.cap="The PCA2GO panel. Four tables (2 per dimension, here only 3 are displayed) decorate the PCA plot in the middle, and display the top enriched functional categories in each subset of gene with high loadings."----
knitr::include_graphics("unr_08_pca2go_topgo.png")

## ----ss90, echo=FALSE, fig.cap="The pcaExplorer task menu. Buttons for saving the session to binary data or to a dedicated environment are displayed.",out.width="80%"----
knitr::include_graphics("unr_90_exitsave.png")

## ----ss99, echo=FALSE, fig.cap="The Report Editor tab. The collapsible elements control general markdown and editor options, which are regarded when the report is compiled. Its content is specified in the Ace editor, integrated in the Shiny app."----
knitr::include_graphics("unr_99_editreport.png")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

