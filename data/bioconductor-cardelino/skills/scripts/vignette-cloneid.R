# Code example from 'vignette-cloneid' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE------------------
## To render an HTML version that works nicely with github and web pages, do:
## rmarkdown::render("vignettes/vignette-cloneid.Rmd", "all")
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5, dev = 'png',
    warning = FALSE, error = FALSE, message = FALSE)
library(ggplot2)
library(BiocStyle)
theme_set(theme_bw(12))

## ----load-pkg-----------------------------------------------------------------
library(ggplot2)
library(cardelino)

## ----read-vcf-data------------------------------------------------------------
vcf_file <- system.file("extdata", "cellSNP.cells.vcf.gz", 
                        package = "cardelino")
input_data <- load_cellSNP_vcf(vcf_file)

## ----allele-frequency, , fig.height = 3, fig.width = 5------------------------
AF <- as.matrix(input_data$A / input_data$D)

p = pheatmap::pheatmap(AF, cluster_rows=FALSE, cluster_cols=FALSE,
                   show_rownames = TRUE, show_colnames = TRUE,
                   labels_row='77 cells', labels_col='112 SNVs',
                   angle_col=0, angle_row=0)

## ----read-canopy-data---------------------------------------------------------
canopy_res <- readRDS(system.file("extdata", "canopy_results.coveraged.rds", 
                                  package = "cardelino"))
Config <- canopy_res$tree$Z

## ----correct-variant-ids------------------------------------------------------
rownames(Config) <- gsub(":", "_", rownames(Config))

## ----plot-tre-----------------------------------------------------------------
plot_tree(canopy_res$tree, orient = "v")

## ----cell-assign--------------------------------------------------------------
set.seed(7)
assignments <- clone_id(input_data$A, input_data$D, Config = Config,
                        min_iter = 800, max_iter = 1200)
names(assignments)

## ----prob-heatmap-------------------------------------------------------------
prob_heatmap(assignments$prob)

## ----assign-cell-clone-easy---------------------------------------------------
df <- assign_cells_to_clones(assignments$prob)
head(df)
table(df$clone)

## ----Config update------------------------------------------------------------
heat_matrix(t(assignments$Config_prob - Config)) + 
  scale_fill_gradient2() +
  ggtitle('Changes of clonal Config') + 
  labs(x='Clones', y='112 SNVs') +
  theme(axis.text.y = element_blank(), legend.position = "right")

## ----results-plot, fig.height = 4.5, fig.width = 7.5--------------------------
AF <- as.matrix(input_data$A / input_data$D)
cardelino::vc_heatmap(AF, assignments$prob, Config, show_legend=TRUE)

## ----read in mtx files--------------------------------------------------------
AD_file <- system.file("extdata", "passed_ad.mtx", package = "cardelino")
DP_file <- system.file("extdata", "passed_dp.mtx", package = "cardelino")
id_file <- system.file("extdata", "passed_variant_names.txt", 
                       package = "cardelino")

AD <- Matrix::readMM(AD_file)
DP <- Matrix::readMM(DP_file)
var_ids <- read.table(id_file, )
rownames(AD) <- rownames(DP) <- var_ids[, 1]
colnames(AD) <- colnames(DP) <- paste0('Cell', seq(ncol(DP)))

## ----pheatmap, fig.height = 4.5, fig.width = 8.5------------------------------
AF_mt <- as.matrix(AD / DP)
pheatmap::pheatmap(AF_mt)

## ----denovo-mtDNA-------------------------------------------------------------
set.seed(7)
assign_mtClones <- clone_id(AD, DP, Config=NULL, n_clone = 3, 
                            keep_base_clone=FALSE)

## ----vc_heatmap-mtDNA, fig.height = 4.2, fig.width = 7------------------------
Config_mt <- assign_mtClones$Config_prob
Config_mt[Config_mt >= 0.5] = 1
Config_mt[Config_mt <  0.5] = 0
cardelino::vc_heatmap(AF_mt, assign_mtClones$prob, Config_mt, show_legend=TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

