# Code example from 'recount3-quickstart' vignette. See references/ for full tutorial.

## ----'knitr_options', include = FALSE-----------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("knitcitations")

## Load knitcitations with a clean bibliography
cleanbib()
cite_options(hyperlink = "to.doc", citation_format = "text", style = "html")
# Note links won't show for now due to the following issue
# https://github.com/cboettig/knitcitations/issues/63

## Write bibliography information
bib <- c(
    R = citation(),
    BiocFileCache = citation("BiocFileCache")[1],
    BiocStyle = citation("BiocStyle")[1],
    knitcitations = citation("knitcitations")[1],
    knitr = citation("knitr")[3],
    recount3 = citation("recount3")[1],
    recount3paper = citation("recount3")[2],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    SummarizedExperiment = RefManageR::BibEntry(
        bibtype = "manual",
        key = "SummarizedExperiment",
        author = "Martin Morgan and Valerie Obenchain and Jim Hester and Hervé Pagès",
        title = "SummarizedExperiment: SummarizedExperiment container",
        year = 2019, doi = "10.18129/B9.bioc.SummarizedExperiment"
    ),
    testthat = citation("testthat")[1],
    covr = citation("covr")[1],
    RefManageR = citation("RefManageR")[1],
    pryr = citation("pryr")[1],
    rtracklayer = citation("rtracklayer")[1],
    S4Vectors = citation("S4Vectors")[1],
    httr = citation("httr")[1],
    data.table = citation("data.table")[1],
    R.utils = citation("R.utils")[1],
    Matrix = citation("Matrix")[1],
    GenomicRanges = citation("GenomicRanges")[1],
    recount2paper = citation("recount")[1],
    recount2workflow = citation("recount")[2],
    recount1paper = citation("recount")[5],
    recountbrain = citation("recount")[6],
    recount2fantom = citation("recount")[7],
    bioconductor2015 = RefManageR::BibEntry(
        bibtype = "Article",
        key = "bioconductor2015",
        author = "Wolfgang Huber and Vincent J Carey and Robert Gentleman and Simon Anders and Marc Carlson and Benilton S Carvalho and Hector Corrada Bravo and Sean Davis and Laurent Gatto and Thomas Girke and Raphael Gottardo and Florian Hahne and Kasper D Hansen and Rafael A Irizarry and Michael Lawrence and Michael I Love and James MacDonald and Valerie Obenchain and Andrzej K Oles and Hervé Pagès and Alejandro Reyes and Paul Shannon and Gordon K Smyth and Dan Tenenbaum and Levi Waldron and Martin Morgan",
        title = "Orchestrating high-throughput genomic analysis with Bioconductor",
        year = 2015, doi = "10.1038/nmeth.3252",
        journal = "Nature Methods",
        journaltitle = "Nat Methods"
    )
)

write.bibtex(bib, file = "quickstartRef.bib")

## ----'install', eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("recount3")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'install_dev', eval = FALSE----------------------------------------------
# BiocManager::install("LieberInstitute/recount3")

## ----'citation'---------------------------------------------------------------
## Citation info
citation("recount3")

## ----'start', message=FALSE---------------------------------------------------
## Load recount3 R package
library("recount3")

## ----'quick_example'----------------------------------------------------------
## Find all available human projects
human_projects <- available_projects()

## Find the project you are interested in,
## here we use SRP009615 as an example
proj_info <- subset(
    human_projects,
    project == "SRP009615" & project_type == "data_sources"
)

## Create a RangedSummarizedExperiment (RSE) object at the gene level
rse_gene_SRP009615 <- create_rse(proj_info)

## Explore that RSE object
rse_gene_SRP009615

## ----"tranform_counts"--------------------------------------------------------
## Once you have your RSE object, you can transform the raw coverage
## base-pair coverage counts using transform_counts().
## For RPKM, TPM or read outputs, check the details in transform_counts().
assay(rse_gene_SRP009615, "counts") <- transform_counts(rse_gene_SRP009615)

## ----"recountWorkflowFig1", out.width="100%", fig.align="center", fig.cap = "Overview of the data available in recount2 and recount3. Reads (pink boxes) aligned to the reference genome can be used to compute a base-pair coverage curve and identify exon-exon junctions (split reads). Gene and exon count matrices are generated using annotation information providing the gene (green boxes) and exon (blue boxes) coordinates together with the base-level coverage curve. The reads spanning exon-exon junctions (jx) are used to compute a third count matrix that might include unannotated junctions (jx 3 and 4). Without using annotation information, expressed regions (orange box) can be determined from the base-level coverage curve to then construct data-driven count matrices. DOI: < https://doi.org/10.12688/f1000research.12223.1>.", echo = FALSE----
knitr::include_graphics("https://raw.githubusercontent.com/LieberInstitute/recountWorkflow/master/vignettes/Figure1.png")

## ----recountWorkflowFig2, out.width="100%", fig.align="center", fig.cap = "recount2 and recount3 provide coverage count matrices in RangedSummarizedExperiment (rse) objects. Once the rse object has been downloaded and loaded into R (using `recount3::create_rse()` or `recount2::download_study()`), the feature information is accessed with `rowRanges(rse)` (blue box), the counts with assays(rse) (pink box) and the sample metadata with `colData(rse)` (green box). The sample metadata stored in `colData(rse)` can be expanded with custom code (brown box) matching by a unique sample identifier such as the SRA Run ID. The rse object is inside the purple box and matching data is highlighted in each box. DOI: < https://doi.org/10.12688/f1000research.12223.1>.", echo = FALSE----
knitr::include_graphics("https://raw.githubusercontent.com/LieberInstitute/recountWorkflow/master/vignettes/Figure2.png")

## ----"human_projects"---------------------------------------------------------
human_projects <- available_projects()
dim(human_projects)
head(human_projects)

## Select a study of interest
project_info <- subset(
    human_projects,
    project == "SRP009615" & project_type == "data_sources"
)
project_info

## ----"gtex_projects"----------------------------------------------------------
subset(human_projects, file_source == "gtex" & project_type == "data_sources")

## ----"display_proj_info"------------------------------------------------------
project_info[, c("project", "organism", "project_home")]

## ----"annotations"------------------------------------------------------------
annotation_options("human")
annotation_options("mouse")

## ----"rse_gencode_v26"--------------------------------------------------------
## Create a RSE object at the gene level
rse_gene_SRP009615 <- create_rse(project_info)

## Explore the resulting RSE gene object
rse_gene_SRP009615

## ----"metadata_rse"-----------------------------------------------------------
## Information about how this RSE object was made
metadata(rse_gene_SRP009615)

## ----"row_ranges"-------------------------------------------------------------
## Number of genes by number of samples
dim(rse_gene_SRP009615)

## Information about the genes
rowRanges(rse_gene_SRP009615)

## ----"recount3_meta_cols"-----------------------------------------------------
## Sample metadata
recount3_cols <- colnames(colData(rse_gene_SRP009615))

## How many are there?
length(recount3_cols)

## View the first few ones
head(recount3_cols)

## Group them by source
recount3_cols_groups <- table(gsub("\\..*", "", recount3_cols))

## Common sources and number of columns per source
recount3_cols_groups[recount3_cols_groups > 1]

## Unique columns
recount3_cols_groups[recount3_cols_groups == 1]

## ----"explore_all", eval = FALSE----------------------------------------------
# ## Explore them all
# recount3_cols

## ----"expand attributes"------------------------------------------------------
rse_gene_SRP009615_expanded <-
    expand_sra_attributes(rse_gene_SRP009615)
colData(rse_gene_SRP009615_expanded)[, ncol(colData(rse_gene_SRP009615)):ncol(colData(rse_gene_SRP009615_expanded))]

## ----"raw_counts"-------------------------------------------------------------
assayNames(rse_gene_SRP009615)

## ----"scaling_counts"---------------------------------------------------------
## Once you have your RSE object, you can transform the raw coverage
## base-pair coverage counts using transform_counts().
## For RPKM, TPM or read outputs, check the details in transform_counts().
assay(rse_gene_SRP009615, "counts") <- transform_counts(rse_gene_SRP009615)

## ----"rse_exon"---------------------------------------------------------------
## Create a RSE object at the exon level
rse_exon_SRP009615 <- create_rse(
    proj_info,
    type = "exon"
)

## Explore the resulting RSE exon object
rse_exon_SRP009615

## Explore the object
dim(rse_exon_SRP009615)

## ----"exon_ranges"------------------------------------------------------------
## Exon annotation information
rowRanges(rse_exon_SRP009615)

## Exon ids are repeated because a given exon can be part of
## more than one transcript
length(unique(rowRanges(rse_exon_SRP009615)$exon_id))

## ----"exon_memory"------------------------------------------------------------
## Check how much memory the gene and exon RSE objects use
pryr::object_size(rse_gene_SRP009615)
pryr::object_size(rse_exon_SRP009615)

## ----"rse_jxn"----------------------------------------------------------------
## Create a RSE object at the exon-exon junction level
rse_jxn_SRP009615 <- create_rse(
    proj_info,
    type = "jxn"
)

## Explore the resulting RSE exon-exon junctions object
rse_jxn_SRP009615
dim(rse_jxn_SRP009615)

## Exon-exon junction information
rowRanges(rse_jxn_SRP009615)

## Memory used
pryr::object_size(rse_jxn_SRP009615)

## ----"BigWigURLs"-------------------------------------------------------------
## BigWig file names
## The full URL is stored in BigWigUrl
basename(head(rse_gene_SRP009615$BigWigURL))

## ----"BiocFileCache"----------------------------------------------------------
## List the URLs of the recount3 data that you have downloaded
recount3_cache_files()

## ----"remove_files", eval = FALSE---------------------------------------------
# ## Delete the recount3 files from your cache
# recount3_cache_rm()
# 
# ## Check that no files are listed
# recount3_cache_files()

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("recount3-quickstart.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("recount3-quickstart.Rmd", tangle = TRUE)

## ----createVignette2----------------------------------------------------------
## Clean up
file.remove("quickstartRef.bib")

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
bibliography()

