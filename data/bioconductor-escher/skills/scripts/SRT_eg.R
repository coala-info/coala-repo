# Code example from 'SRT_eg' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = FALSE,
  comment = "#>",
  # fig.width = 8,
  # fig.height = 8,
  fig.small = TRUE,
  fig.retina = NULL
)

## ----install_bioc, eval=FALSE-------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("escheR")

## ----install_github, eval = FALSE---------------------------------------------
# if (!require("devtools")) install.packages("devtools")
# devtools::install_github("boyiguo1/escheR")
# 
# # `devel` version from Bioconductor
# BiocManager::install(version='devel')

## ----setup--------------------------------------------------------------------
library(escheR)
library(STexampleData)

## ----data.import--------------------------------------------------------------
spe <- Visium_humanDLPFC()

# Subset in-tissue spots
spe <- spe[, spe$in_tissue == 1]
spe <- spe[, !is.na(spe$ground_truth)]

## ----spe_summary--------------------------------------------------------------
spe

## ----create_plot--------------------------------------------------------------
p <- make_escheR(spe)

## ----creat_fill---------------------------------------------------------------
(p1 <- p |>
   add_fill(var = "cell_count"))

## ----create_ground------------------------------------------------------------
(p2 <- p |>
   add_ground(var = "ground_truth")) # round layer

## ----add_symbol---------------------------------------------------------------
p2 |>
  add_symbol(var = "ground_truth", size = 0.2) # Symbol layer

## ----default_con_cat_eg-------------------------------------------------------
# Prep data
# Adding gene counts for MBP to the colData
spe$counts_MOBP <- counts(spe)[which(rowData(spe)$gene_name=="MOBP"),]

(p <- make_escheR(spe) |> 
    add_fill(var = "counts_MOBP") |> 
    add_ground(var = "ground_truth", stroke = 0.5))

## ----improved_con_cat_eg------------------------------------------------------
(p2 <- p + 
   scale_fill_gradient(low = "white", high = "black"))

## ----creat_group--------------------------------------------------------------
spe$tmp_group <- cut(
  spe$array_row, 
  breaks = c(min(spe$array_row)-1 ,
             fivenum(spe$array_row))
)

table(spe$tmp_group)

## ----cat_cat_eg---------------------------------------------------------------
make_escheR(spe) |> 
  add_fill(var = "tmp_group") |> 
  add_ground(var = "ground_truth", stroke = 0.5) +
  scale_fill_brewer() +
  theme_void()

## ----cat_cat_eg2--------------------------------------------------------------
make_escheR(spe) |> 
  add_fill(var = "tmp_group") |> 
  add_ground(var = "ground_truth", stroke = 0.5) +
  scale_fill_brewer() +
  scale_color_manual(
    name = "", # turn off legend name for ground_truth
    values = c(
      "Layer1" = "#F0027F",
      "Layer2" = "transparent",
      "Layer3" = "#4DAF4A",
      "Layer4" = "#984EA3",
      "Layer5" = "#FFD700",
      "Layer6" = "#FF7F00",
      "WM" = "#1A1A1A")
  ) 

## ----customize, eval = FALSE--------------------------------------------------
# (p_final <- p2 +
#   scale_color_manual(
#     name = "", # No legend name
#     values = c(
#       "Layer1" = "#F0027F",
#       "Layer2" = "#377EB8",
#       "Layer3" = "#4DAF4A",
#       "Layer4" = "#984EA3",
#       "Layer5" = "#FFD700",
#       "Layer6" = "#FF7F00",
#       "WM" = "#1A1A1A")
#   ) +
#   labs(title = "Example Title"))

## ----subset-------------------------------------------------------------------
table(spe$ground_truth, useNA = "ifany")

spe$tmp_fac <- factor(spe$ground_truth,
                      levels = c("Layer1", "Layer2"))
table(spe$tmp_fac, useNA = "ifany")

make_escheR(spe) |> 
  add_ground(var = "ground_truth") |> 
  add_symbol(var = "tmp_fac", size = 0.4) + 
  scale_shape_manual(
    values=c(3, 16),    #> Set different symbols for the 2 levels
    breaks = c("Layer1", "Layer2") #> Remove NA from legend
  )

## ----make_plot_list, eval = FALSE---------------------------------------------
# # Create a list of `escheR` plots
# plot_list <- unique(spe$sample_id) |> # Create a list of sample names
#   lapply(FUN = function(.sample_id){ # Iterate over all samples
#     spe_single <- spe[, spe$sample_id == .sample_id]
#     make_escheR(spe_single) |>
#       add_fill(var = "counts_MOBP") |>
#       add_ground(var = "ground_truth", stroke = 0.5))
# # Customize theme
#   })

## ----paneling, fig.width=8, fig.height=5--------------------------------------
library(ggpubr)
plot_list <- list(p2, p2)
ggarrange(
  plotlist = plot_list,
  ncol = 2, nrow = 1,
  common.legend = TRUE)

## ----save_escheR, eval = FALSE------------------------------------------------
# ggsave(
#   filename = "path/file_name.pdf",
#   plot = p_final
# )

## -----------------------------------------------------------------------------
utils::sessionInfo()

