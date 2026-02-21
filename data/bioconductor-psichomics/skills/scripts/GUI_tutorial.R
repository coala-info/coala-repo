# Code example from 'GUI_tutorial' vignette. See references/ for full tutorial.

## ----install, eval=FALSE------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("psichomics")

## ----eval=FALSE---------------------------------------------------------------
# library(psichomics)
# psichomics()

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Options to load TCGA data."----
knitr::include_graphics("img/1_load_data.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Options to filter and normalise gene expression."----
knitr::include_graphics("img/2_normalise_gene_expression.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Options to quantify alternative splicing."----
knitr::include_graphics("img/3_quantify_splicing.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Creating groups by tumour stage."----
knitr::include_graphics("img/4_data_grouping.png")

## ----echo=FALSE, fig.retina=NULL, out.width='600pt', fig.cap="Table showing data groups as created for downstream analyses."----
knitr::include_graphics("img/4_group_tables.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Options to save and load groups."----
knitr::include_graphics("img/4_save_groups.png")

## ----echo=FALSE, fig.retina=NULL, out.width='800pt', fig.cap="Options to perform and visualise PCA."----
knitr::include_graphics("img/5_pca.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="PCA score and loading plots"----
knitr::include_graphics("img/pca_results.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Differential splicing of *NUMB* exon 12 between tumour and normal samples."----
knitr::include_graphics("img/NUMB_exon_12_inclusion.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Correlation between *NUMB* exon 12 inclusion and QKI expression in all TCGA breast samples."----
knitr::include_graphics("img/Correlation_NUMB_exon_12_and_QKI_GE.png")

## ----echo=FALSE, fig.retina=NULL, out.width='800pt', fig.cap="Differentially spliced events (|Δ Median PSI| > 0.1 and Wilcoxon q-value ≤ 0.01). Labelled splicing events have putative prognostic value (more on that in the following section)."----
knitr::include_graphics("img/diff_analyses.png")

## ----echo=FALSE, fig.retina=NULL, out.width='800pt', fig.cap="Differentially expressed genes (|log2(Fold-change)| > 1 and FDR ≤ 0.01). Labelled genes are those with alternative splicing events with putative prognostic value."----
knitr::include_graphics("img/diff_expression.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Differential splicing of *UHRF2* exon 10 between tumour stage I and normal samples."----
knitr::include_graphics("img/UHRF2_exon_10_inclusion_differential_splicing.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Prognostic value of *UHRF2* exon 10 inclusion (patients separated by the optimal PSI cutoff of 0.09)."----
knitr::include_graphics("img/UHRF2_exon_10_inclusion_prognosis.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Differential expression of *UHRF2* between tumour stage I and normal samples."----
knitr::include_graphics("img/UHRF2_differential_expression.png")

## ----echo=FALSE, fig.retina=NULL, out.width='400pt', fig.cap="Prognostic value of *UHRF2* expression (patients separated by the optimal gene expression cutoff of 5.43)."----
knitr::include_graphics("img/UHRF2_expression_prognosis.png")

