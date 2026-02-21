# Up and running with *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*

Federico Marini1,2\* and Harald Binder1

1Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
2Center for Thrombosis and Hemostasis (CTH), Mainz

\*marinif@uni-mainz.de

#### 30 October 2025

#### Package

pcaExplorer 3.4.0

```
knitr::opts_chunk$set(crop = NULL)
```

# 1 Setup

First things first: install *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* and load it into your R session.
You should receive a message notification if this is completed without errors.

```
BiocManager::install("pcaExplorer")
library("pcaExplorer")
```

This document describes a use case for *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*, based on the dataset in the *[airway](https://bioconductor.org/packages/3.22/airway)* package.
If this package is not available on your machine, please install it by executing:

```
BiocManager::install("airway")
```

This dataset consists of the gene-level expression measurements (as raw read counts) for an experiment where four different human airway smooth muscle cell lines are either treated with dexamethasone or left untreated.

# 2 Start exploring - the beauty of interactivity

To start the exploration, you just need the following lines:

```
library("pcaExplorer")
pcaExplorer()
```

The easiest way to explore the *[airway](https://bioconductor.org/packages/3.22/airway)* dataset is by clicking on the dedicated button in the **Data Upload** panel.
This action will:

* load the *[airway](https://bioconductor.org/packages/3.22/airway)* package
* load the count matrix and the experimental metadata
* compose the `dds` object, normalize the expression values (using the robust method proposed by Anders and Huber in the original DESeq manuscript), and compute the variance stabilizing transformed expression values (stored in the `dst` object)
* retrieve the gene annotation information via the *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)*, adding gene symbols to the ENSEMBL ids - this step is optional, but recommended for more human-readable identifiers to be used.

If you want to load your expression data, please refer to the [User Guide](https://bioconductor.org/packages/3.22/pcaExplorer/vignettes/pcaExplorer.html), which contains detailed information on the formats your data have to respect.

Once the preprocessing of the input is done, you should get a notification in the lower right corner that you’re all set.
The whole preprocessing should take around 5-6 seconds (tested on a MacBook Pro, with i7 and 16 Gb RAM).
You can check how each component looks like by clicking on its respective button, once they appeared in the lower half of the panel.

![Overview of the Data Upload panel. After clicking on the 'Load the demo airway data' button, all widgets are automatically populated, and each data component (count matrix, experimental data, dds object, annotation) can be previewed in a modal window by clicking on its respective button.](data:image/png;base64...)

Figure 1: Overview of the Data Upload panel
After clicking on the ‘Load the demo airway data’ button, all widgets are automatically populated, and each data component (count matrix, experimental data, dds object, annotation) can be previewed in a modal window by clicking on its respective button.

You can proceed to explore the expression values of your dataset in the **Counts Table** tab.
You can change the data type you are displaying between raw counts, normalized, or transformed, and plot their values in a scatterplot matrix to explore their sample-to-sample correlations.
To try this, select for example “Normalized counts”, change the correlation coefficient to “spearman”, and click on the `Run` action button.
The correlation values will also be displayed as a heatmap.

![Screenshot of the sample to sample scatter plot matrix. The user can select the correlation method to use, the option to plot values on log2 scales, and the possibility to use a subset of genes (to obtain a quicker overview if many samples are provided).](data:image/png;base64...)

Figure 2: Screenshot of the sample to sample scatter plot matrix
The user can select the correlation method to use, the option to plot values on log2 scales, and the possibility to use a subset of genes (to obtain a quicker overview if many samples are provided).

Additional features, both for samples and for features, are displayed in the **Data overview** panel.
A closer look at the metadata of the `airway` set highlights how each combination of cell type (`cell`) and dexamethasone treatment (`dex`) is represented by a single sequencing experiment.
The 8 samples in the demo dataset are themselves a subsample of the [full GEO record](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE52778), namely the ones non treated with albuterol (`alb` column).

The relationship among samples can be seen in the sample-to-sample heatmap.
For example, by selecting the Manhattan distance metric, it is evident how the samples cluster by dex treatment, yet they show a dendrogram structure that recalls the 4 different cell types used.
The total sum of counts per sample is displayed as a bar plot.

![Screenshot of the sample to sample heatmap. Selected is the Manhattan distance, but Euclidean and correlation-based distance are also provided as options. In this case, the user has also selected the dex and cell factors in the 'Group/color by' widget in the sidebar menu, and these covariates decorate the heatmap to facilitate identification of patterns.](data:image/png;base64...)

Figure 3: Screenshot of the sample to sample heatmap
Selected is the Manhattan distance, but Euclidean and correlation-based distance are also provided as options. In this case, the user has also selected the dex and cell factors in the ‘Group/color by’ widget in the sidebar menu, and these covariates decorate the heatmap to facilitate identification of patterns.

Patterns can become clearer after selecting, in the **App settings** on the left, an experimental factor to group and color by: try selecting `dex`, for example.
If more than one covariate is selected, the interaction between these will be taken as a grouping factor.
To remove one, simply click on it to highlight and press the del or backspace key to delete it.
Try doing so by also clicking on `cell`, and then removing `dex` afterwards.

Basic summary information is also displayed for the genes.
In the count matrix provided, one can check how many genes were detected, by selecting a “Threshold on the row sums of the counts” or on the row means of the normalized counts (more stringent).
For example, selecting 5 in both cases, only 24345 genes have a total number of counts, summed by row, and 17745 genes have more than 5 counts (normalized) on average.

![Screenshot of the Basic Summary of the counts in the Data Overview panel. General information are provided, together with an overview on detected genes according to different filtering criteria.](data:image/png;base64...)

Figure 4: Screenshot of the Basic Summary of the counts in the Data Overview panel
General information are provided, together with an overview on detected genes according to different filtering criteria.

The **Samples View** and the **Genes View** are the tabs where most results coming from Principal Component Analysis, either performed on the samples or on the genes, can be explored in depth.
Assuming you selected `cell` in the “Group/color by” option on the left, the Samples PCA plot should clearly display how the cell type explain a considerable portion of the variability in the dataset (corresponding to the second PC).
To check that `dex` treatment is the main source of variability, select that instead of `cell`.

![The Samples View panel. Displayed are a PCA plot (left) and the corresponding scree plot (right), with the samples colored and labeled by cell type - separating on the second principal component.](data:image/png;base64...)

Figure 5: The Samples View panel
Displayed are a PCA plot (left) and the corresponding scree plot (right), with the samples colored and labeled by cell type - separating on the second principal component.

The scree plot on the right shows how many components should be retained for a satisfactory reduced dimension view of the original set, with their eigenvalues from largest to smallest.
To explore the PCs other than the first and the second one, you can just select them in the x-axis PC and y-axis PC widgets in the left sidebar.

![PCA plot for the samples, colored by dexamethasone treatment. The dex factor is the main driver of the variability in the data, and samples separate nicely on the first principal component.](data:image/png;base64...)

Figure 6: PCA plot for the samples, colored by dexamethasone treatment
The dex factor is the main driver of the variability in the data, and samples separate nicely on the first principal component.

If you brush (left-click and hold) on the PCA plot, you can display a zoomed version of it in the frame below.
If you suspect some samples might be outliers (this is not the case in the `airway` set, still), you can select them in the dedicated plot, and give a first check on how the remainder of the samples would look like.
On the right side, you can quickly check which genes show the top and bottom loadings, split by principal component.
First, change the value in the input widget to 20; then, select one of each list and try to check them in the **Gene Finder** tab; try for example with *DUSP1*, *PER1*, and *DDX3Y*.

![Genes with highest loadings on the first and second principal components. The user can select how many top and bottom genes will be displayed, and the gene names are printed below each gene's contribution on each PC.](data:image/png;base64...)

Figure 7: Genes with highest loadings on the first and second principal components
The user can select how many top and bottom genes will be displayed, and the gene names are printed below each gene’s contribution on each PC.

While *DUSP1* and *PER1* clearly show a change in expression upon dexamethasone treatment (and indeed where reported among the well known glucocorticoid-responsive genes in the original publication of Himes et al., 2014), *DDX3Y* displays variability at the cell type level (select `cell` in the Group/color by widget): this gene is almost undetected in N061011 cells, and this high variance is what determines its high loading on the second principal component.

![Plot of the gene expression levels of DUSP1. Points are split according to dex treatment, and both graphics and table are displayed.](data:image/png;base64...)

Figure 8: Plot of the gene expression levels of DUSP1
Points are split according to dex treatment, and both graphics and table are displayed.

![Plot of the gene expression levels of PER1. Points are split according to dex treatment.](data:image/png;base64...)

Figure 9: Plot of the gene expression levels of PER1
Points are split according to dex treatment.

![Plot of the gene expression levels of DDX3Y. Points are split according to cell type, as this gene was highly variable across this experimental factor - indeed, in one cell type it is barely detected.](data:image/png;base64...)

Figure 10: Plot of the gene expression levels of DDX3Y
Points are split according to cell type, as this gene was highly variable across this experimental factor - indeed, in one cell type it is barely detected.

You can see the single expression values in a table as well, and this information can be downloaded with a simple click.

Back to the **Samples View**, you can experiment with the number of top variable genes to see how the results of PCA are in this case robust to a wide range of this value - this might not be the case with other datasets, and the simplicity of interacting with these parameters makes it easy to iterate in the exploration steps.

Proceeding to the **Genes View**, you can see the dual of the Samples PCA: now the samples are displayed as arrows in the genes biplot, which can show which genes display a similar behaviour.
You can capture this with a simple brushing action on the plot, and notice how their profiles throughout all samples are shown in the Profile explorer below; moreover, a static and an interactive heatmap, together with a table containing the underlying data, are generated in the rows below.

![The Genes View panel. Upper panel: the genes biplot, and its zoomed plot, with gene names displayed. Lower panel: the profile explorer of the selected subset of genes (corresponding to the zoomed window), and the boxplot for the gene selected by clicking close to a location in the zoomed window.](data:image/png;base64...)

Figure 11: The Genes View panel
Upper panel: the genes biplot, and its zoomed plot, with gene names displayed. Lower panel: the profile explorer of the selected subset of genes (corresponding to the zoomed window), and the boxplot for the gene selected by clicking close to a location in the zoomed window.

Since we compute the gene annotation table as well, it’s nice to read the gene symbols in the zoomed window (instead of the ENSEMBL ids).
By clicking close enough to any of these genes, the expression values are plotted, in a similar fashion as in the **Gene Finder**.

The tab **PCA2GO** helps you understanding which are the biological common themes (default: the Gene Ontology Biological Process terms) in the genes showing up in the top and in the bottom loadings for each principal component.
Since we launched the `pcaExplorer` app without additional parameters, this information is not available, but can be computed live (this might take a while).

![The PCA2GO panel. Four tables (2 per dimension, here only 3 are displayed) decorate the PCA plot in the middle, and display the top enriched functional categories in each subset of gene with high loadings.](data:image/png;base64...)

Figure 12: The PCA2GO panel
Four tables (2 per dimension, here only 3 are displayed) decorate the PCA plot in the middle, and display the top enriched functional categories in each subset of gene with high loadings.

Still, a previous call to `pca2go` is recommended, as it relies on the algorithm of the *[topGO](https://bioconductor.org/packages/3.22/topGO)* package: it will require some additional computing time, but it is likely to deliver more precise terms (i.e. in turn more relevant from the point of view of their biological relevance). To do so, you should exit the live session, compute this object, and provide it in the call to `pcaExplorer` (see more how to do so in [the main user guide](https://bioconductor.org/packages/3.22/pcaExplorer/vignettes/pcaExplorer.html)).

# 3 When you’re done - the power of reproducibility

A typical session with `pcaExplorer` includes one or more iterations on each of these tabs.
Once you are finished, you might want to store the results of your analysis in different formats.

![The pcaExplorer task menu. Buttons for saving the session to binary data or to a dedicated environment are displayed.](data:image/png;base64...)

Figure 13: The pcaExplorer task menu
Buttons for saving the session to binary data or to a dedicated environment are displayed.

With `pcaExplorer` you can do all of the following:

* save every plot and table by simply clicking on the respective button, below each element
* save the state of the entire app and its reactive elements as a binary `.RData` file, as if it was a workspace (clicking on the cog icon in the right side of the task menu)
* use the “Exit `pcaExplorer` and save” saves the state but in a specific environment of your R session, which you can later access by its name, which normally could look like `pcaExplorerState_YYYYMMDD_HHMMSS` (also accessible from the cog)
* enjoy the beauty of reproducible research in the **Report Editor**: `pcaExplorer` comes with a template analysis, that picks the latest status of the app during your session, and combines these reactive values together in a R Markdown document, which you can first preview live in the app, and then download as standalone HTML file - to store or share.
  This document stiches together narrative text, code, and output objects, and constitutes a compendium where all actions are recorded.
  If you are familiar with R, you can edit that live, with support for autocompletion, in the “Edit report” tab.

![The Report Editor tab. The collapsible elements control general markdown and editor options, which are regarded when the report is compiled. Its content is specified in the Ace editor, integrated in the Shiny app.](data:image/png;base64...)

Figure 14: The Report Editor tab
The collapsible elements control general markdown and editor options, which are regarded when the report is compiled. Its content is specified in the Ace editor, integrated in the Shiny app.

The functionality to display the report preview is based on `knit2html`, and some elements such as `DataTable` objects might not render correctly.
To render them correctly, please install the PhantomJS executable before launching the app.
This can be done by using the *[webshot](https://CRAN.R-project.org/package%3Dwebshot)* package and calling `webshot::install_phantomjs()` - HTML widgets will be rendered automatically as screenshots.
Alternatively, the more recent *[webshot2](https://CRAN.R-project.org/package%3Dwebshot2)* package uses the headless Chrome browser (via the *[chromote](https://CRAN.R-project.org/package%3Dchromote)* package, requiring Google Chrome or other Chromium-based browser).
Keep in mind that the fully rendered report (the one you can obtain with the “Generate & Save” button) is not affected by this, since it uses `rmarkdown::render()`.

# Session Info

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
##  [1] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
##  [3] DESeq2_1.50.0               airway_1.29.0
##  [5] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           pcaExplorer_3.4.0
## [13] bigmemory_4.6.4             Biobase_2.70.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                 bitops_1.0-9             enrichplot_1.30.0
##   [4] fontawesome_0.5.3        httr_1.4.7               webshot_0.5.5
##   [7] RColorBrewer_1.1-3       doParallel_1.0.17        Rgraphviz_2.54.0
##  [10] tools_4.5.1              R6_2.6.1                 DT_0.34.0
##  [13] mgcv_1.9-3               lazyeval_0.2.2           withr_3.0.2
##  [16] prettyunits_1.2.0        gridExtra_2.3            cli_3.6.5
##  [19] TSP_1.2-5                labeling_0.4.3           sass_0.4.10
##  [22] topGO_2.62.0             S7_0.2.0                 genefilter_1.92.0
##  [25] goseq_1.62.0             Rsamtools_2.26.0         systemfonts_1.3.1
##  [28] yulab.utils_0.2.1        gson_0.1.0               txdbmaker_1.6.0
##  [31] DOSE_4.4.0               R.utils_2.13.0           AnnotationForge_1.52.0
##  [34] dichromat_2.0-0.1        limma_3.66.0             RSQLite_2.4.3
##  [37] GOstats_2.76.0           gridGraphics_0.5-1       BiocIO_1.20.0
##  [40] crosstalk_1.2.2          dplyr_1.1.4              dendextend_1.19.1
##  [43] GO.db_3.22.0             Matrix_1.7-4             abind_1.4-8
##  [46] R.methodsS3_1.8.2        lifecycle_1.0.4          yaml_2.3.10
##  [49] qvalue_2.42.0            SparseArray_1.10.0       BiocFileCache_3.0.0
##  [52] grid_4.5.1               blob_1.2.4               promises_1.4.0
##  [55] crayon_1.5.3             shinydashboard_0.7.3     ggtangle_0.0.7
##  [58] lattice_0.22-7           cowplot_1.2.0            GenomicFeatures_1.62.0
##  [61] cigarillo_1.0.0          annotate_1.88.0          KEGGREST_1.50.0
##  [64] magick_2.9.0             pillar_1.11.1            fgsea_1.36.0
##  [67] rjson_0.2.23             codetools_0.2-20         fastmatch_1.1-6
##  [70] glue_1.8.0               ggiraph_0.9.2            ggfun_0.2.0
##  [73] fontLiberation_0.1.0     data.table_1.17.8        vctrs_0.6.5
##  [76] png_0.1-8                treeio_1.34.0            gtable_0.3.6
##  [79] assertthat_0.2.1         cachem_1.1.0             xfun_0.53
##  [82] S4Arrays_1.10.0          mime_0.13                survival_3.8-3
##  [85] pheatmap_1.0.13          seriation_1.5.8          iterators_1.0.14
##  [88] tinytex_0.57             statmod_1.5.1            Category_2.76.0
##  [91] nlme_3.1-168             ggtree_4.0.0             bit64_4.6.0-1
##  [94] fontquiver_0.2.1         threejs_0.3.4            progress_1.2.3
##  [97] filelock_1.0.3           GenomeInfoDb_1.46.0      bslib_0.9.0
## [100] otel_0.2.0               colorspace_2.1-2         DBI_1.2.3
## [103] tidyselect_1.2.1         bit_4.6.0                compiler_4.5.1
## [106] curl_7.0.0               httr2_1.2.1              graph_1.88.0
## [109] BiasedUrn_2.0.12         SparseM_1.84-2           fontBitstreamVera_0.1.1
## [112] DelayedArray_0.36.0      plotly_4.11.0            bookdown_0.45
## [115] rtracklayer_1.70.0       scales_1.4.0             mosdef_1.6.0
## [118] RBGL_1.86.0              NMF_0.28                 rappdirs_0.3.3
## [121] stringr_1.5.2            digest_0.6.37            shinyBS_0.61.1
## [124] rmarkdown_2.30           ca_0.71.1                XVector_0.50.0
## [127] htmltools_0.5.8.1        pkgconfig_2.0.3          base64enc_0.1-3
## [130] dbplyr_2.5.1             fastmap_1.2.0            UCSC.utils_1.6.0
## [133] rlang_1.1.6              htmlwidgets_1.6.4        shiny_1.11.1
## [136] farver_2.1.2             jquerylib_0.1.4          jsonlite_2.0.0
## [139] BiocParallel_1.44.0      GOSemSim_2.36.0          R.oo_1.27.1
## [142] RCurl_1.98-1.17          magrittr_2.0.4           ggplotify_0.1.3
## [145] patchwork_1.3.2          Rcpp_1.1.0               ape_5.8-1
## [148] viridis_0.6.5            gdtools_0.4.4            stringi_1.8.7
## [151] MASS_7.3-65              plyr_1.8.9               parallel_4.5.1
## [154] ggrepel_0.9.6            bigmemory.sri_0.1.8      Biostrings_2.78.0
## [157] splines_4.5.1            hms_1.1.4                geneLenDataBase_1.45.0
## [160] locfit_1.5-9.12          igraph_2.2.1             uuid_1.2-1
## [163] rngtools_1.5.2           reshape2_1.4.4           biomaRt_2.66.0
## [166] XML_3.99-0.19            evaluate_1.0.5           BiocManager_1.30.26
## [169] foreach_1.5.2            tweenr_2.0.3             httpuv_1.6.16
## [172] tidyr_1.3.1              purrr_1.1.0              polyclip_1.10-7
## [175] heatmaply_1.6.0          ggplot2_4.0.0            gridBase_0.4-7
## [178] ggforce_0.5.0            xtable_1.8-4             restfulr_0.0.16
## [181] tidytree_0.4.6           later_1.4.4              viridisLite_0.4.2
## [184] tibble_3.3.0             clusterProfiler_4.18.0   aplot_0.2.9
## [187] memoise_2.0.1            registry_0.5-1           GenomicAlignments_1.46.0
## [190] cluster_2.1.8.1          GSEABase_1.72.0          shinyAce_0.4.4
```