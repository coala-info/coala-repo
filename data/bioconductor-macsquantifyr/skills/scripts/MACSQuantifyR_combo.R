# Code example from 'MACSQuantifyR_combo' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.width = 8,
    fig.height = 8
)

## ----echo = FALSE, fig.width=10, fig.height=8,fig.asp=0.6---------------------
library(png)
library(grid)
path_intro <- system.file("extdata", "manual.png", package = "MACSQuantifyR")
intro <- readPNG(path_intro)
grid.raster(intro)

## ----echo = FALSE-------------------------------------------------------------
path_img1 <- system.file("extdata", "combo.png", package = "MACSQuantifyR")
img1 <- readPNG(path_img1)
grid.raster(img1)

## ----load---------------------------------------------------------------------
library(MACSQuantifyR)
library(knitr)
library(grid)
library(gridExtra)
library(ggplot2)
library(tools)
library(readxl)
library(lattice)
library(latticeExtra)
suppressMessages(library(R.utils))

## -----------------------------------------------------------------------------
MACSQuant <- new_class_MQ(path = "output_path")

## -----------------------------------------------------------------------------
slot(MACSQuant, "experiment_name") <- "Combo drug1-drug2 HC line 101"

## ----load_file, include = TRUE------------------------------------------------
filepath <- system.file("extdata", "drugs.xlsx",
    package = "MACSQuantifyR")
MACSQuant <- load_MACSQuant(filepath,
    sheet_name = "combo_drugs",
    MACSQuant.obj = MACSQuant)

## -----------------------------------------------------------------------------
# this line is used to created c_names variable
# for this experiment according to selection
slot(MACSQuant, "param.experiment")$c_names <-
    c(sprintf("Drug1_c%d", 1:4), # DRUG1 ALONE
        sprintf("Drug2_c%d", 1:3), # DRUG2 ALONE
        sprintf("D2[1]_D1[%d]", 1:4), # DRUG2_C1 + DRUG1_Cs
        sprintf("D2[2]_D1[%d]", 1:4), # DRUG2_C2 + DRUG1_Cs
        sprintf("D2[3]_D1[%d]", 1:4)) # DRUG2_C3 + DRUG1_Cs

# custom colors can be defined (with control if selected)
plt.col <- c(heat.colors(length(slot(MACSQuant, "param.experiment")$c_names)),
    1)

# dose vector of concentration each condition
slot(MACSQuant, "param.experiment")$doses <-
    c(1, 3, 5, 10, # DRUG1 ALONE
        0, 0, 0,                  # DRUG2 ALONE
        1, 3, 5, 10, # DRUG2_C1 ++ DRUG1_Cs
        1, 3, 5, 10, # DRUG2_C2 + DRUG1_Cs
        1, 3, 5, 10  # DRUG2_C3 + DRUG1_Cs
    )
slot(MACSQuant, "param.experiment")$doses.alt <-
    c(0, 0, 0, 0,                # DRUG1 ALONE
        10, 50, 100,              # DRUG2 ALONE
        10, 10, 10, 10,            # DRUG2_C1 + DRUG1_Cs
        50, 50, 50, 50,            # DRUG2_C2 ++ DRUG1_Cs
        100, 100, 100, 100          # DRUG2_C3 ++ DRUG1_Cs
    )

## ----eval=FALSE---------------------------------------------------------------
# 
# MACSQuant <- on_plate_selection(MACSQuant,
#     number_of_replicates = 3,
#     number_of_conditions = 19,
#     control = TRUE,
#     save.files = TRUE)

## ----include=F----------------------------------------------------------------
filepath <- system.file("extdata", "drugs.Rdata",
    package = "MACSQuantifyR")
load(filepath)

## -----------------------------------------------------------------------------
plt.col <-
    c(
        heat.colors(length(slot(MACSQuant, "param.experiment")$c_names)), 1)

plt.labels <- c(slot(MACSQuant, "param.experiment")$c_names, "Control")

slot(MACSQuant, "param.output")$plt.title <- "Custom title example"

## ----fig.width=31.75,  fig.height=15.875,fig.asp=0.5,fig.asp=0.5--------------
flav <- "counts"
p_counts <- barplot_data(MACSQuant,
    plt.col = plt.col,
    plt.flavour = flav,
    plt.labels = plt.labels,
    plt.combo = TRUE,
    xlab = "Drug1",
    ylab = "Drug2")
grid.arrange(p_counts)


flav <- "percent"
p_percent <- barplot_data(MACSQuant,
    plt.col = plt.col,
    plt.flavour = flav,
    plt.labels = plt.labels,
    plt.combo = TRUE,
    xlab = "Drug1",
    ylab = "Drug2")
grid.arrange(p_percent)

## ----eval =FALSE--------------------------------------------------------------
# # flav='counts'
# ggsave(paste(MACSQuant@param.output$path,
#     "/outputMQ/barplot_", flav, ".png", sep = ""),
# width = 31.75, height = 15.875,
# units = "cm", p_counts)
# # flav='percent'
# ggsave(paste(MACSQuant@param.output$path,
#     "/outputMQ/barplot_", flav, ".png", sep = ""),
# width = 31.75, height = 15.875,
# units = "cm", p_percent)

## -----------------------------------------------------------------------------
MACSQuant <- combination_index(MACSQuant)

## ----eval=FALSE---------------------------------------------------------------
# generate_report(MACSQuant)

