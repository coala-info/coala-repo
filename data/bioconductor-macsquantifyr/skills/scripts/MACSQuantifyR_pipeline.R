# Code example from 'MACSQuantifyR_pipeline' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.width = 8,
    fig.height = 8
)

## ----echo = FALSE,fig.asp=0.6-------------------------------------------------
library(png)
library(grid)
path_intro <- system.file("extdata", "auto.png", package = "MACSQuantifyR")
intro <- readPNG(path_intro)
grid.raster(intro)

## ----load---------------------------------------------------------------------
library(MACSQuantifyR)
library(knitr)
library(grid)
library(gridExtra)
library(png)
suppressMessages(library(R.utils))

## ----load_file, include = TRUE------------------------------------------------
file <- system.file("extdata", "drugs.xlsx",
    package = "MACSQuantifyR")

## ----echo=FALSE---------------------------------------------------------------
print(basename(file))

## ----echo=FALSE,include=FALSE-------------------------------------------------
MACSQuant <- load_MACSQuant(file)
my_data <- slot(MACSQuant, "my_data")

## ----echo=FALSE---------------------------------------------------------------
kable(head(my_data), digits = 4)

## ----eval=FALSE---------------------------------------------------------------
# MACSQuant <- pipeline(filepath = file,
#     sheet_name = NULL, # optional
#     number_of_replicates = 3,
#     number_of_conditions = 8,
#     control = T)

## ----echo = FALSE-------------------------------------------------------------

example_path <- system.file("extdata/",
    "plate_template_pipeline.png",
    package = "MACSQuantifyR")
example_image <- readPNG(example_path)
grid.raster(example_image)

## ----echo = FALSE-------------------------------------------------------------
printf(paste("...To quit press ESC...\n",
    "...You can now select your conditions",
    "replicates (without control condition replicates)...\n",
    "    --> 18 conditions:...1...2...3...4...5...6...7...8...OK\n",
    "    --> Done: replicates identified\n",
    "    --> Done: statistics on each condition replicates\n",
    "...You can now select your control replicates...\n",
    "    --> 1 control: ...OK...\n",
    "    --> Done: statistics on each control replicates\n",
    "--> Done: replicates stored in variable my_replicates_sorted\n",
    sep = " "))

## ----echo = FALSE-------------------------------------------------------------
warning(paste("In order_data(sorted_matrix_final, my_data, save.files =",
    "save.files) : \n !!! A2 not selected and will be ignored",
    sep = " "))

## ----echo=FALSE---------------------------------------------------------------

drugs_R_image <- system.file("extdata",
    "drugs.RDS",
    package = "MACSQuantifyR")
MACSQuant <- readRDS(drugs_R_image)
kable(slot(MACSQuant, "statistics"), digits = 4)

## ----echo = FALSE, fig.width=20, fig.height=20,fig.asp=0.5--------------------
example_res1 <- system.file("extdata/",
    "barplot_counts_pipeline.png",
    package = "MACSQuantifyR")
example_res2 <- system.file("extdata/",
    "barplot_percent_pipeline.png",
    package = "MACSQuantifyR")
img4 <-  rasterGrob(as.raster(readPNG(example_res1)), interpolate = FALSE)
img5 <-  rasterGrob(as.raster(readPNG(example_res2)), interpolate = FALSE)
grid.arrange(img4, img5, ncol = 2)

