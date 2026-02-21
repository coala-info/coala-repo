# Code example from 'flowGate' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.height = 7,
  fig.width = 7,
  fig.align = "center"
)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE)){
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("flowGate")

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE)){
#   install.packages("BiocManager")
# }
# 
# if(!requireNamespace("flowCore", quietly = TRUE)){
#   BiocManager::install("flowCore")
# }
# 
# if(!requireNamespace("flowWorkspace", quietly = TRUE)){
#   BiocManager::install("flowWorkspace")
# }
# 
# if(!requireNamespace("ggcyto", quietly = TRUE)){
#   BiocManager::install("ggcyto")
# }

## ----eval = FALSE-------------------------------------------------------------
# # install devtools if you don't already have it
# if(!requireNamespace("devtools", quietly = TRUE)){
#   install.packages("devtools")
# }
# 
# devtools::install_github("NKInstinct/flowGate")

## -----------------------------------------------------------------------------
library(flowGate)
library(flowCore)

path_to_fcs <- system.file("extdata", package = "flowGate")

## -----------------------------------------------------------------------------
fs <- read.flowSet(path = path_to_fcs,
                   pattern = ".FCS$",
                   full.names = TRUE)

## ----use NCDF, eval = FALSE---------------------------------------------------
# # Not run for the purposes of the vignette
# library(ncdfFlow)
# fs <- read.ncdfFlowSet(files = list.files(path = path_to_fcs,
#                                           pattern = ".FCS$",
#                                           full.names = TRUE))

## ----make GatingSet-----------------------------------------------------------
library(flowWorkspace)
gs <- GatingSet(fs)

## ----Compensate data----------------------------------------------------------
path_to_comp <- system.file("extdata", 
                            "compdata", 
                            "compmatrix", 
                            package = "flowCore")
comp_matrix <- read.table(path_to_comp, 
                          header = TRUE, 
                          skip = 2, 
                          check.names = FALSE)

comp <- compensation(comp_matrix)

gs <- compensate(gs, comp)

## ----Acquisition-defined comp, eval = FALSE-----------------------------------
# # Not run for the purposes of the vignette
# 
# # Find out which slot the compensation data are in.
# spillover(some_new_fs[[3]])
# 
# # You need to select one of the samples contained in the flowSet. I chose the
# # third one here ([[3]]), but that is completely arbitrary. The should all have
# # the exact same compensation matrix.
# 
# # This command should output a list of several objects. One of them should look
# # like a compensation matrix. If we were running this command on data from my
# # Fortessa, it would be the first object in the list (the $SPIL slot), but look
# # at your data and see which object you want to work with. Once you know which
# # object is your compensation matrix, proceed.
# 
# comp_matrix <- spillover(some_new_fs[[3]])[[1]]
# 
# # Note that I have selected the first object in the list, which corresponds to
# # where my acquisition-defined matrices are stored. If yours is in a different
# # list object, put that object's number in place of the [[1]] above.
# 
# # From here, it is exactly like before:
# 
# comp <- compensation(comp_matrix)
# 
# some_new_gs <- compensate(some_new_gs, comp)

## ----create import function---------------------------------------------------
import_gs <- function(path, pattern, compensation_matrix){
  
  fs <- read.flowSet(path = path, 
                     pattern = pattern, 
                     full.names = TRUE)
  
  gs <- GatingSet(fs)
  
  comp <- compensation(compensation_matrix)
  gs <- compensate(gs, comp)
  
  return(gs)
}

## ----functional import--------------------------------------------------------
#Setup the paths to your data as before
path_to_fcs <- system.file("extdata", 
                           package = "flowGate")

path_to_comp<- system.file("extdata", 
                           "compdata", 
                           "compmatrix", 
                           package = "flowCore")

comp_matrix <- read.table(path_to_comp, 
                          header = TRUE, 
                          skip = 2, 
                          check.names = FALSE)

#Then run the import function we just created
gs <- import_gs(path = path_to_fcs,
                pattern = ".FCS$",
                compensation_matrix = comp_matrix)

## -----------------------------------------------------------------------------
colnames(gs)

markernames(gs)

## ----eval = FALSE-------------------------------------------------------------
# gs_gate_interactive(gs,
#                     filterId = "Leukocytes",
#                     dims = list("FSC-H", "SSC-H"))

## ----echo = FALSE, message = FALSE--------------------------------------------
#Needed to add the gate when building the vignette
p1 <- readRDS("p1Gate.Rds")
gs_pop_add(gs, p1)
recompute(gs)

## -----------------------------------------------------------------------------
autoplot(gs[[1]], gate = "Leukocytes")

## ----eval = FALSE-------------------------------------------------------------
# gs_gate_interactive(gs,
#                     filterId = "CD45",
#                     dims = "CD45",
#                     subset = "Leukocytes")

## ----echo = FALSE, message=FALSE----------------------------------------------
p2 <- readRDS("p2Gate.Rds")
gs_pop_add(gs, p2, parent = "Leukocytes")
recompute(gs)

## -----------------------------------------------------------------------------
ggcyto(gs[[1]], aes("CD45")) +
  geom_density() +
  geom_gate("CD45") +
  geom_stats()

## ----eval = FALSE-------------------------------------------------------------
# gs_gate_interactive(gs[[1]],
#                     filterId = "CD33 CD15",
#                     dims = list("CD33", "CD15"),
#                     subset = "CD45")
# 

## ----echo = FALSE, message=FALSE----------------------------------------------
p3 <- readRDS("p3Gate.Rds")
gs_pop_add(gs, p3, parent = "CD45")
recompute(gs)

## ----eval = FALSE-------------------------------------------------------------
# ggcyto(gs[[1]], aes("CD33", "CD15")) +
#   geom_hex(bins = 128) +
#   geom_gate("CD33 CD15") +
#   scale_x_flowjo_biexp(maxValue = 252245, widthBasis = -29, pos = 4) +
#   scale_y_flowjo_biexp(maxValue = 250000, widthBasis = -12, pos = 5) +
#   geom_stats()

## -----------------------------------------------------------------------------
gs_get_pop_paths(gs)

## -----------------------------------------------------------------------------
ggcyto(gs[[1]], aes("CD33", "CD15")) +
  geom_hex(bins = 128) +
  scale_x_flowjo_biexp(maxValue = 252245, widthBasis = -29, pos = 4) +
  scale_y_flowjo_biexp(maxValue = 250000, widthBasis = -12, pos = 5) +
  geom_gate(c("CD33 APC-CD15 FITC+",
              "CD33 APC+CD15 FITC+",
              "CD33 APC+CD15 FITC-",
              "CD33 APC-CD15 FITC-")) +
  geom_hline(yintercept = 80.2426) +
  geom_vline(xintercept = 97.42192) +
  geom_stats()

## -----------------------------------------------------------------------------
quadgates <- gs_get_pop_paths(gs)[stringr::str_detect(gs_get_pop_paths(gs),
                                                      "CD33")]

ggcyto(gs[[1]], aes("CD33", "CD15")) +
  geom_hex(bins = 128) +
  scale_x_flowjo_biexp(maxValue = 252245, widthBasis = -29, pos = 4) +
  scale_y_flowjo_biexp(maxValue = 250000, widthBasis = -12, pos = 5) +
  geom_gate(quadgates) +
  geom_hline(yintercept = 80.2426) +
  geom_vline(xintercept = 97.42192) +
  geom_stats()

## ----eval=FALSE---------------------------------------------------------------
# save_gs(gs, "GvHD GatingSet.gs")
# 
# #Load it back in
# gs <- load_gs(file.path("GvHD GatingSet.gs"))

## -----------------------------------------------------------------------------
strategy <- tibble::tribble(
  ~filterId,    ~dims,                  ~subset,      ~bins,
  "Leukocytes", list("FSC-H", "SSC-H"), "root",       256,
  "CD45",       list("CD45"),           "Leukocytes", 256,
  "CD33 CD15",  list("CD33", "CD15"),    "CD45",      64
)

## ----eval=FALSE---------------------------------------------------------------
# gs_apply_gating_strategy(gs, gating_strategy = strategy)

## ----eval=FALSE---------------------------------------------------------------
# strategy <- tibble::tribble(
#   ~filterId,    ~dims,                  ~subset,
#   "Leukocytes", list("FSC-H", "SSC-H"), "root",
#   "CD45",       list("CD45"),           "Leukocytes",
#   "CD33 CD15",  list("CD33", "CD15"),    "CD45"
# )
# 
# gs_apply_gating_strategy(gs, gating_strategy = strategy, bins = 64)

## ----fig.height = 4.5---------------------------------------------------------
ggcyto(gs, aes("FSC-H", "SSC-H")) +
  geom_hex() +
  geom_gate("Leukocytes") +
  geom_stats()

## ----fig.height = 4.5---------------------------------------------------------
ggcyto(gs, aes("FSC-H", "SSC-H")) +
  geom_hex(bins = 128) +
  geom_gate("Leukocytes", colour = "grey3", alpha = 0.2) +
  geom_stats(digits = 1)

## ----fig.height = 4.5---------------------------------------------------------
ggcyto(gs, aes("FSC-H", "SSC-H")) +
  geom_hex(bins = 128) +
  geom_gate("Leukocytes", colour = "grey3", alpha = 0.2) +
  geom_stats(digits = 1) +
  theme_minimal()

## -----------------------------------------------------------------------------
gs_pop_get_count_fast(gs)

## -----------------------------------------------------------------------------
gs_pop_get_stats(gs, type = "percent")

gs_pop_get_stats(gs, type = "percent", nodes = "CD45")

## -----------------------------------------------------------------------------
gs_pop_get_stats(gs, type = pop.MFI)

## ----eval = FALSE-------------------------------------------------------------
# results <- gs_pop_get_stats(gs, type = "percent")
# 
# writs.csv(results, "results.csv")

## -----------------------------------------------------------------------------
sessionInfo()

