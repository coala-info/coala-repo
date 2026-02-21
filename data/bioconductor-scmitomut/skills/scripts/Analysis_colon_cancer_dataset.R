# Code example from 'Analysis_colon_cancer_dataset' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, TOC = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scMitoMut")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("remotes", quietly = TRUE))
#     install.packages("remotes")
# remotes::install_github("wenjie1991/scMitoMut")

## -----------------------------------------------------------------------------
library(scMitoMut)
library(data.table)
library(ggplot2)
library(rhdf5)

## ----eval=TRUE----------------------------------------------------------------
## Load the allele count table
f <- system.file("extdata", "mini_dataset.tsv.gz", package = "scMitoMut")
f_h5_tmp <- tempfile(fileext = ".h5")
f_h5 <- parse_table(f, h5_file = f_h5_tmp)

## ----eval=TRUE----------------------------------------------------------------
f_h5

## -----------------------------------------------------------------------------
## Open the h5 file as a scMitoMut object
x <- open_h5_file(f_h5)
str(x)

## Show what's in the h5 file
h5ls(x$h5f, recursive = FALSE)

## -----------------------------------------------------------------------------
f <- system.file("extdata", "mini_dataset_cell_ann.csv", package = "scMitoMut")
cell_ann <- read.csv(f, row.names = 1)

## Subset the cells, the cell id can be found by colnames() for the Seurat object
x <- subset_cell(x, rownames(cell_ann))

## -----------------------------------------------------------------------------
head(x$cell_selected)

## ----eval=TRUE----------------------------------------------------------------
## Run the model fitting
run_model_fit(x, mc.cores = 1)

## The p-value is kept in the pval group of H5 file
h5ls(x$h5f, recursive = FALSE)

## -----------------------------------------------------------------------------
## Filter mutation
x <- filter_loc(
  mtmutObj = x,
  min_cell = 2,
  model = "bb",
  p_threshold = 0.01,
  p_adj_method = "fdr"
)
x$loc_pass

## ----fig.width = 12-----------------------------------------------------------
## Prepare the color for cell annotation
colors <- c(
  "Cancer Epi" = "#f28482",
  Blood = "#f6bd60"
)
ann_colors <- list("SeuratCellTypes" = colors)

## ----fig.width = 12-----------------------------------------------------------
## binary heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "binary",
  percent_interp = 0.2, n_interp = 3
)

## ----fig.width = 12-----------------------------------------------------------
## binary heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "binary",
  percent_interp = 1, n_interp = 3
)

## ----fig.width = 12-----------------------------------------------------------
## p value heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "p",
  percent_interp = 0.2, n_interp = 3
)

## ----fig.width = 12-----------------------------------------------------------
## allele frequency heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "af",
  percent_interp = 0.2, n_interp = 3
)

## -----------------------------------------------------------------------------
## Export the mutation data as data.frame
m_df <- export_df(x)
m_df[1:10, ]
## Export allele frequency data as data.matrix
export_af(x)[1:5, 1:5]
## Export p-value data as data.matrix
export_pval(x)[1:5, 1:5]
## Export binary mutation status data as data.matrix
export_binary(x)[1:5, 1:5]

## ----fig.width = 5------------------------------------------------------------
## The `m_df` is exported using the `export_df` function above.
m_dt <- data.table(m_df)
m_dt[, cell_type := cell_ann[as.character(m_dt$cell_barcode), "SeuratCellTypes"]]
m_dt_sub <- m_dt[loc == "chrM.1227"]
m_dt_sub[, sum((pval) < 0.01, na.rm = TRUE), by = cell_type]
m_dt_sub[, sum((1 - af) > 0.05, na.rm = TRUE), by = cell_type]

## The p value versus cell types
ggplot(m_dt_sub) +
  aes(x = cell_type, y = -log10(pval), color = cell_type) +
  geom_jitter() +
  scale_color_manual(values = colors) +
  theme_bw() +
  geom_hline(yintercept = -log10(0.01), linetype = "dashed") +
  ylab("-log10(FDR)")

## The allele frequency versus cell types
ggplot(m_dt_sub) +
  aes(x = cell_type, y = 1 - af, color = factor(cell_type)) +
  geom_jitter() +
  scale_color_manual(values = colors) +
  theme_bw() +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  ylab("1 - Dominant Allele Frequency")

## The p value versus allele frequency
ggplot(m_dt_sub) +
    aes(x = -log10(pval), y = 1 - af, color = factor(cell_type)) +
    geom_point() +
    scale_color_manual(values = colors) +
    theme_bw() +
    geom_hline(yintercept = 0.05, linetype = "dashed") +
    geom_vline(xintercept = -log10(0.01), linetype = "dashed") +
    xlab("-log10(FDR)") +
    ylab("1 - Dominant Allele Frequency")

## -----------------------------------------------------------------------------
sessionInfo()

