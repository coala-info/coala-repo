# Code example from 'smartid_Demo' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 5
)

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# if (!requireNamespace("smartid", quietly = TRUE)) {
#   BiocManager::install("smartid")
# }

## ----set up, message=FALSE----------------------------------------------------
library(smartid)
library(SummarizedExperiment)
library(splatter)
library(ggplot2)
library(scater)

## set seed for reproducibility
set.seed(123)
sim_params <- newSplatParams(
  nGenes = 1000,
  batchCells = 3000,
  group.prob = seq(0.1, 0.4, length.out = 4),
  de.prob = c(0.02, 0.02, 0.02, 0),
  # de.downProb = 0,
  de.facLoc = 0.5,
  de.facScale = 0.4
)

data_sim <- splatSimulate(sim_params, method = "groups")

## get up markers based on fold change
fc <- 1
cols <- paste0("DEFacGroup", seq_along(unique(data_sim$Group)))
defac <- as.data.frame(rowData(data_sim)[, cols])
up <- lapply(cols, \(id)
dplyr::filter(defac, if_all(-!!sym(id), \(x) !!sym(id) / x > fc)) |>
  rownames())
slot(data_sim, "metadata")$up_markers <- setNames(up, cols)
slot(data_sim, "metadata")$up_markers
data_sim

## -----------------------------------------------------------------------------
## show available methods
idf_iae_methods()

## -----------------------------------------------------------------------------
## compute score
system.time(
  data_sim <- cal_score(
    data_sim,
    tf = "logtf",
    idf = "prob",
    iae = "prob",
    par.idf = list(label = "Group"),
    par.iae = list(label = "Group")
  )
)

## score and tf,idf,iae all saved
assays(data_sim)
names(metadata(data_sim))

## -----------------------------------------------------------------------------
top_m <- top_markers(
  data = data_sim,
  label = "Group",
  n = Inf # set Inf to get all features processed score
)
top_m

## -----------------------------------------------------------------------------
score_barplot(
  top_markers = top_m,
  column = ".dot",
  f_list = slot(data_sim, "metadata")$up_markers,
  n = 20
)

## -----------------------------------------------------------------------------
sin_score_boxplot(
  metadata(data_sim)$tf,
  features = "Gene76",
  ref.group = "Group2",
  label = data_sim$Group
)

## sim gene info
SummarizedExperiment::elementMetadata(data_sim)[76, ]

## -----------------------------------------------------------------------------
set.seed(123)
marker_ls <- markers_mixmdl(
  top_markers = top_m,
  column = ".dot",
  ratio = 2,
  dist = "norm",
  plot = TRUE
)
marker_ls

## -----------------------------------------------------------------------------
library(UpSetR)

upset(fromList(c(slot(data_sim, "metadata")$up_markers, marker_ls)), nsets = 6)

## -----------------------------------------------------------------------------
set.seed(123)
marker_ls_new <- markers_mclust(
  top_markers = top_m,
  column = ".dot",
  method = "max.one",
  plot = TRUE
)
names(marker_ls_new) <- paste(names(marker_ls_new), "new")

## -----------------------------------------------------------------------------
upset(fromList(c(marker_ls, marker_ls_new)), nsets = 6)

## -----------------------------------------------------------------------------
## compute score without label
system.time(
  data_sim <- cal_score(
    data_sim,
    tf = "logtf",
    idf = "sd",
    iae = "sd",
    new.slot = "score_unlabel"
  )
)

## new score is saved and tf,idf,iae all updated
assays(data_sim)
names(metadata(data_sim))

## -----------------------------------------------------------------------------
## compute score for each group marker list
data_sim <- gs_score(
  data = data_sim,
  features = marker_ls[1:3], # group 4 has no markers
  slot = "score_unlabel",
  suffix = "score.unlabel" # specify the suffix of names to save
)

## saved score
colnames(colData(data_sim))

## ----fig.width=10, fig.height=3-----------------------------------------------
as.data.frame(colData(data_sim)) |>
  tidyr::pivot_longer("Group1.score.unlabel":"Group3.score.unlabel",
    names_to = "group markers",
    values_to = "score"
  ) |>
  ggplot(aes(x = Group, y = score, fill = Group)) +
  geom_boxplot() +
  facet_wrap(~`group markers`, scales = "free") +
  theme_bw()

## -----------------------------------------------------------------------------
sessionInfo()

