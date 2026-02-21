# Code example from 'epimutacions' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(comment="", 
                      warning = FALSE, 
                      message = FALSE,
                      cache = FALSE)

## ----implementation, echo=FALSE, fig.cap= "Implementation of each outlier detection method", out.width = '90%', fig.align='center'----
knitr::include_graphics("fig/implementation.png")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("epimutacions")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("epimutacionsData")

## ----message = FALSE----------------------------------------------------------
library(epimutacions)

## ----workflow, echo=FALSE, fig.cap="Allowed data formats, normalization and input types", out.width = '90%', fig.align='center'----
knitr::include_graphics("fig/workflow.png")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ExperimentHub")

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, c("epimutacionsData"))

## ----IDAT files, eval = FALSE-------------------------------------------------
# baseDir <- system.file("extdata", package = "epimutacionsData")

## ----message = FALSE, FALSE---------------------------------------------------
reference_panel <- eh[["EH6691"]]
methy <- eh[["EH6690"]]

## ----eval = FALSE-------------------------------------------------------------
# library(minfi)
# # Regions 450K
# library("IlluminaHumanMethylation450kanno.ilmn12.hg19")
# 
# data(Locations)
# 
# ### Select CpGs (names starting by cg) in autosomic chromosomes
# locs.450 <- subset(Locations, grepl("^cg", rownames(Locations)) & chr %in% paste0("chr", 1:22))
# locs.450GR <- makeGRangesFromDataFrame(locs.450,
#                                        start.field = "pos",
#                                        end.field = "pos",
#                                        strand = "*")
# locs.450GR <- sort(locs.450GR)
# mat <- matrix(0, nrow = length(locs.450GR), ncol = 2,
#               dimnames = list(names(locs.450GR), c("A", "B")))
# 
# ## Set sample B to all 1
# mat[, 2] <- 1
# 
# ## Define model matrix
# pheno <- data.frame(var = c(0, 1))
# model <- model.matrix(~ var, pheno)
# 
# ## Run bumphunter
# bumps <- bumphunter(mat, design = model, pos = start(locs.450GR),
#                     chr = as.character(seqnames(locs.450GR)),
#                     cutoff = 0.05)$table
# bumps.fil <- subset(bumps, L >= 3)

## ----message = FALSE, eval = FALSE--------------------------------------------
# candRegsGR <- eh[["EH6692"]]

## ----echo = FALSE-------------------------------------------------------------
library(kableExtra)
df <- data.frame(Method = c(rep("illumina",3), 
                            rep("quantile", 7), 
                            rep("noob", 3), 
                            rep("funnorm", 5)), 
                 parameters = c("bg.correct", 
                                "normalize", 
                                "reference", 
                                "fixOutliers", 
                                "removeBadSamples", 
                                "badSampleCutoff",
                                "quantileNormalize", 
                                "stratified", 
                                "mergeManifest", 
                                "sex",
                                "offset", 
                                "dyeCorr", 
                                "dyeMethod", 
                                "nPCs", 
                                "sex", 
                                "bgCorr", 
                                "dyeCorr", 
                                "keepCN"),
                 Description = c("Performs background correction", 
    "Performs controls normalization", 
    "The reference array for control normalization",
    "Low outlier Meth and Unmeth signals will be fixed", 
    "Remove bad samples", 
    "The cutoff to label samples as ‘bad’",
    "Performs quantile normalization", 
    "Performs quantile normalization within region strata", 
    "Merged to the output the information in the associated manifest package", 
    "Sex of the samples",
    "Offset for the normexp background correct", 
    "Performs dye normalization",
    "Dye bias correction to be done",
    "The number of principal components from the control probes", 
    "Sex of the samples",
    "Performs NOOB background correction before functional normalization",
    "Performs dye normalization", "Keeps copy number estimates"))

kable(df[,2:3]) %>% 
      pack_rows(index = c("illumina" = 3,
                          "quantile" = 7,
                          "noob" = 3,
                          "funnorm" = 5))

## -----------------------------------------------------------------------------
norm_parameters()

## -----------------------------------------------------------------------------
parameters <- norm_parameters(illumina = list("bg.correct" = FALSE))
parameters$illumina$bg.correct

## ----eval = FALSE-------------------------------------------------------------
# GRset <- epi_preprocess(baseDir,
#                         reference_panel,
#                         pattern = "SampleSheet.csv")

## -----------------------------------------------------------------------------
case_samples <- methy[,methy$status == "case"]
control_samples <- methy[,methy$status == "control"]

## ----epi_mvo, message=FALSE, warning=FALSE------------------------------------
epi_mvo <- epimutations(case_samples, 
                        control_samples, 
                        method = "manova")

## ----eval = FALSE-------------------------------------------------------------
# #manova (default method)
# data(GRset)
# epi_mva_one_leave_out<- epimutations_one_leave_out(GRset)

## ----echo = FALSE-------------------------------------------------------------
df <- data.frame(Method = c("Manova, mlm", 
                            rep("iso.forest", 2), 
                            "mahdist.mcd", 
                            rep("quantile", 2), 
                            rep("beta",2)), 
                 parameters = c("pvalue_cutoff", 
                                "outlier_score_cutoff", 
                                "ntrees", "nsamp", 
                                "window_sz", 
                                "offset_mean/offset_abs", 
                                "pvalue_cutoff",
                                "diff_threshold"),
                 Description = c("The threshold p-value to select which CpG regions are outliers ", 
                                 "The threshold to select which CpG regions are outliers",
                                 "The number of binary trees to build for the model",
                                 "The number of subsets used for initial estimates in the MCD",
                                 "The maximum distance between CpGs to be considered in the same DMR",
                                 "The upper and lower threshold to consider a CpG an outlier",
                                 "The minimum p-value to consider a CpG an outlier",
                                 "The minimum methylation difference between the CpG and the mean methylation to consider a position an outlier"))
kable(df[,2:3]) %>% 
  pack_rows(index = c("Manova, mlm" = 1,
                      "iso.forest" = 2,
                      "mahdist.mcd" = 1,
                      "quantile" = 2, 
                      "beta" = 2))

## -----------------------------------------------------------------------------
epi_parameters()

## -----------------------------------------------------------------------------
parameters <- epi_parameters(manova = list("pvalue_cutoff" = 0.01))
parameters$manova$pvalue_cutoff

## -----------------------------------------------------------------------------
dim(epi_mvo)
class(epi_mvo)
head(as.data.frame(epi_mvo), 1)

## ----annot, eval = TRUE-------------------------------------------------------
rst_mvo <- annotate_epimutations(epi_mvo, omim = TRUE)

## ----annot_relIsland, eval = TRUE---------------------------------------------
kableExtra::kable(
    rst_mvo[ c(27,32) ,c("epi_id", "cpg_ids", "Relation_to_Island")],
    row.names = FALSE) %>% 
  column_spec(1:3, width = "4cm")

## ----annot_omim, eval = TRUE--------------------------------------------------
kableExtra::kable(
    rst_mvo[ c(4,8,22) , c("epi_id", "OMIM_ACC", "OMIM_DESC")],
    row.names = FALSE ) %>% 
  column_spec(1:3, width = "4cm")
    

## ----annot_ensembl, eval = TRUE-----------------------------------------------
kableExtra::kable(
    rst_mvo[ c(1:5), c("epi_id", "ensembl_reg_id", "ensembl_reg_type")],
    row.names = FALSE ) %>% 
  column_spec(1:3, width = "4cm")

## ----plot_default-------------------------------------------------------------
plot_epimutations(as.data.frame(epi_mvo[1,]), methy)

## ----plot_mvo_genes_annot, eval=FALSE-----------------------------------------
# p <- plot_epimutations(as.data.frame(epi_mvo[1,]),
#                        methy = methy,
#                        genes_annot = TRUE)

## ----plot_genes_annot, results='asis', fig.align = "center", fig.height=12, eval=FALSE----
# plot(p)
# 

## ----fig_genes_annot, echo=FALSE, out.width = '90%', fig.align='center'-------
knitr::include_graphics("fig/gvizGenesannot.png")

## ----plot_mvo_regulation, eval=FALSE------------------------------------------
# p <- plot_epimutations(as.data.frame(epi_mvo[1,]),
#                        methy =  methy,
#                        regulation = TRUE)

## ----plot_genes_regulation, results='asis', fig.align = "center", fig.height=12, eval=FALSE----
# plot(p)
# 

## ----fig_genes_regulation, echo=FALSE, out.width = '90%', fig.align='center'----
knitr::include_graphics("fig/gvizRegulation.png")

## -----------------------------------------------------------------------------
sessionInfo()

