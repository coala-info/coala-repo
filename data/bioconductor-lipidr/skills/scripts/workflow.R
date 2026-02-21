# Code example from 'workflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, fig.width = 8)
library(lipidr)
library(ggplot2)

## -----------------------------------------------------------------------------
datadir = system.file("extdata", package="lipidr")
filelist = list.files(datadir, "data.csv", full.names = TRUE) # all csv files

d = read_skyline(filelist)
print(d)

## -----------------------------------------------------------------------------
clinical_file = system.file("extdata", "clin.csv", package="lipidr")

d = add_sample_annotation(d, clinical_file)
colData(d)

## -----------------------------------------------------------------------------
d_subset = d[1:10, 1:10]
rowData(d_subset)
colData(d)

## -----------------------------------------------------------------------------
d_qc = d[, d$group == "QC"]
rowData(d_qc)
colData(d_qc)

## -----------------------------------------------------------------------------
pc_lipids = rowData(d)$Class %in% c("PC", "PCO", "PCP")
d_pc = d[pc_lipids,]
rowData(d_pc)
colData(d_pc)

## -----------------------------------------------------------------------------
lipid_classes = rowData(d)$Class %in% c("Cer", "PC", "LPC")
groups = d$BileAcid != "DCA"
d = d[lipid_classes, groups]

#QC sample subset
d_qc = d[, d$group == "QC"]

## ----fig.height=6-------------------------------------------------------------
plot_samples(d, type = "tic", log = TRUE)

## ----fig.width=10, fig.height=6-----------------------------------------------
plot_molecules(d_qc, "sd", measure = "Retention Time", log = FALSE)
plot_molecules(d_qc, "cv", measure = "Area")

## ----fig.height=5-------------------------------------------------------------
plot_lipidclass(d, "boxplot")

## -----------------------------------------------------------------------------
d_summarized = summarize_transitions(d, method = "average")

## ----fig.height=6-------------------------------------------------------------
d_normalized = normalize_pqn(d_summarized, measure = "Area", exclude = "blank", log = TRUE)
plot_samples(d_normalized, "boxplot")

## ----fig.height=6, eval=FALSE-------------------------------------------------
# d_normalized_istd = normalize_istd(d_summarized, measure = "Area", exclude = "blank", log = TRUE)

## ----fig.width=6, fig.height=5------------------------------------------------
mvaresults = mva(d_normalized, measure="Area", method="PCA")
plot_mva(mvaresults, color_by="group", components = c(1,2))

## -----------------------------------------------------------------------------
mvaresults = mva(d_normalized, method = "OPLS-DA", group_col = "Diet", groups=c("HighFat", "Normal"))
plot_mva(mvaresults, color_by="group")

## ----eval=FALSE---------------------------------------------------------------
# plot_mva_loadings(mvaresults, color_by="Class", top.n=10)

## -----------------------------------------------------------------------------
top_lipids(mvaresults, top.n=10)

## -----------------------------------------------------------------------------
de_results = de_analysis(
  data=d_normalized, 
  HighFat_water - NormalDiet_water,
  measure="Area"
)
head(de_results)
significant_molecules(de_results)

## ----fig.height=6-------------------------------------------------------------
plot_results_volcano(de_results, show.labels = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # Using formula
# de_design(
#   data=d_normalized,
#   design = ~ group,
#   coef="groupHighFat_water",
#   measure="Area")
# 
# # Using design matrix
# design = model.matrix(~ group, data=colData(d_normalized))
# de_design(
#   data=d_normalized,
#   design = design,
#   coef="groupHighFat_water",
#   measure="Area")

## -----------------------------------------------------------------------------
enrich_results = lsea(de_results, rank.by = "logFC")
significant_lipidsets(enrich_results)

## ----fig.width=6, fig.height=5------------------------------------------------
plot_enrichment(de_results, significant_lipidsets(enrich_results), annotation="class")
plot_enrichment(de_results, significant_lipidsets(enrich_results), annotation="unsat")

## ----fig.height=8-------------------------------------------------------------
plot_chain_distribution(de_results)

## -----------------------------------------------------------------------------
sessionInfo()

