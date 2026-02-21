# Code example from 'count-clust' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"-------------------------------------
library("knitr")
library(kableExtra)
opts_chunk$set(tidy=FALSE,tidy.opts=list(width.cutoff=30),dev="png",fig.show="hide",
               fig.width=4,fig.height=7,
               message=FALSE, warning = FALSE)

## ----style, eval=TRUE, echo=FALSE, results='asis'--------------------------
BiocStyle::markdown()

## ----install_github, eval=TRUE---------------------------------------------
library(devtools)
install_github("TaddyLab/maptpx")

## ----install_countclust_bio, eval=FALSE------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("CountClust")

## ----install_countclust_github, eval=FALSE---------------------------------
#  install_github('kkdey/CountClust')

## ----load_countclust, cache=FALSE, eval=TRUE,warning=FALSE-----------------
library(CountClust)

## ----data_install_deng, eval=TRUE------------------------------------------
library(devtools)

read.data1 = function() {
x = tempfile()
download.file(
'https://cdn.rawgit.com/kkdey/singleCellRNASeqMouseDeng2014/master/data/Deng2014MouseEsc.rda',
destfile=x, quiet=TRUE)
z = get(load((x)))
return(z)
}

Deng2014MouseESC <- read.data1()
## Alternatively,
# install_github('kkdey/singleCellRNASeqMouseDeng2014')

## ----data_install_gtex, eval=TRUE------------------------------------------
read.data2 = function() {
x = tempfile()
download.file(
'https://cdn.rawgit.com/kkdey/GTExV6Brain/master/data/GTExV6Brain.rda',
destfile = x, quiet=TRUE)
z = get(load((x)))
return(z)
}

GTExV6Brain <- read.data2()
## Alternatively
# install_github('kkdey/GTExV6Brain')

## ----data_load_deng, eval=TRUE---------------------------------------------
deng.counts <- Biobase::exprs(Deng2014MouseESC)
deng.meta_data <- Biobase::pData(Deng2014MouseESC)
deng.gene_names <- rownames(deng.counts)

## ----data_load_gtex, eval=TRUE---------------------------------------------
gtex.counts <- Biobase::exprs(GTExV6Brain)
gtex.meta_data <- Biobase::pData(GTExV6Brain)
gtex.gene_names <- rownames(gtex.counts)

## ----topic_fit_gtex, eval=FALSE--------------------------------------------
#  FitGoM(t(gtex.counts),
#              K=4, tol=1,
#              path_rda="../data/GTExV6Brain.FitGoM.rda")

## ----topic_fit_deng, eval=FALSE--------------------------------------------
#  FitGoM(t(deng.counts),
#              K=2:7, tol=0.1,
#              path_rda="../data/MouseDeng2014.FitGoM.rda")

## ----prepare_deng_gom,eval=TRUE, warning=FALSE-----------------------------
data("MouseDeng2014.FitGoM")
names(MouseDeng2014.FitGoM$clust_6)
omega <- MouseDeng2014.FitGoM$clust_6$omega

## ----plot_topic_deng_annot, eval=TRUE, warning=FALSE-----------------------
annotation <- data.frame(
  sample_id = paste0("X", c(1:NROW(omega))),
  tissue_label = factor(rownames(omega),
                        levels = rev( c("zy", "early2cell",
                                        "mid2cell", "late2cell",
                                        "4cell", "8cell", "16cell",
                                        "earlyblast","midblast",
                                         "lateblast") ) ) )

rownames(omega) <- annotation$sample_id;

## ----plot_topic_deng,eval=TRUE, warning=FALSE, fig.align = "center", fig.show="asis", dpi=144, fig.width=3, fig.height=7----
StructureGGplot(omega = omega,
                annotation = annotation,
                palette = RColorBrewer::brewer.pal(8, "Accent"),
                yaxis_label = "Development Phase",
                order_sample = TRUE,
                axis_tick = list(axis_ticks_length = .1,
                                 axis_ticks_lwd_y = .1,
                                 axis_ticks_lwd_x = .1,
                                 axis_label_size = 7,
                                 axis_label_face = "bold"))

## ----prepare_gtex_gom, eval=TRUE-------------------------------------------
data("GTExV6Brain.FitGoM")
omega <- GTExV6Brain.FitGoM$omega;
dim(omega)
colnames(omega) <- c(1:NCOL(omega))

## ----annot_gtex, eval=FALSE------------------------------------------------
#  tissue_labels <- gtex.meta_data[,3];
#  
#  annotation <- data.frame(
#      sample_id = paste0("X", 1:length(tissue_labels)),
#      tissue_label = factor(tissue_labels,
#                            levels = rev(unique(tissue_labels) ) ) );
#  
#  cols <- c("blue", "darkgoldenrod1", "cyan", "red")

## ----plot_topic_gtex, eval=FALSE, warning=FALSE, fig.align="center", fig.show="asis", dpi=144, fig.width=5, fig.height=7, out.width="5in", out.height="7in"----
#  StructureGGplot(omega = omega,
#                  annotation= annotation,
#                  palette = cols,
#                  yaxis_label = "",
#                  order_sample = TRUE,
#                  split_line = list(split_lwd = .4,
#                                    split_col = "white"),
#                  axis_tick = list(axis_ticks_length = .1,
#                                   axis_ticks_lwd_y = .1,
#                                   axis_ticks_lwd_x = .1,
#                                   axis_label_size = 7,
#                                   axis_label_face = "bold"))

## ----extract_features_deng, eval=TRUE, warning=FALSE-----------------------
data("MouseDeng2014.FitGoM")
theta_mat <- MouseDeng2014.FitGoM$clust_6$theta;
top_features <- ExtractTopFeatures(theta_mat, top_features=100,
                                   method="poisson", options="min");
gene_list <- do.call(rbind, lapply(1:dim(top_features$indices)[1],
                        function(x) deng.gene_names[top_features$indices[x,]]))

## ----top_genes_clusters_deng, eval=TRUE, fig.width=7-----------------------
tmp <- do.call(rbind, lapply(1:5, function(i) toString(gene_list[,i])))
rownames(tmp) <- paste("Cluster", c(1:5))
tmp %>%
  kable("html") %>%
  kable_styling()

## ----extract_features_gtex, eval=TRUE, warning=FALSE-----------------------
data("GTExV6Brain.FitGoM")
theta_mat <- GTExV6Brain.FitGoM$theta;
top_features <- ExtractTopFeatures(theta_mat, top_features=100,
                                   method="poisson", options="min");
gene_list <- do.call(rbind, lapply(1:dim(top_features$indices)[1],
                        function(x) gtex.gene_names[top_features$indices[x,]]))

## ----top_genes_clusters_gtex, eval=TRUE------------------------------------
tmp <- do.call(rbind, lapply(1:3, function(i) toString(gene_list[,i])))
rownames(tmp) <- paste("Cluster", c(1:3))
tmp %>%
  kable("html") %>%
  kable_styling()

## ----data_install_jaitin, echo=TRUE, eval=TRUE-----------------------------
read.data3 = function() {
x = tempfile()
download.file(
'https://cdn.rawgit.com/jhsiao999/singleCellRNASeqMouseJaitinSpleen/master/data/MouseJaitinSpleen.rda',
destfile = x, quiet=TRUE)
z = get(load((x)))
return(z)
}

MouseJaitinSpleen <- read.data3()
## Alternatively
# devtools::install_github('jhsiao999/singleCellRNASeqMouseJaitinSpleen')

## ----data_load_jaitin, echo=TRUE, eval=TRUE--------------------------------
jaitin.counts <- Biobase::exprs(MouseJaitinSpleen)
jaitin.meta_data <- Biobase::pData(MouseJaitinSpleen)
jaitin.gene_names <- rownames(jaitin.counts)

## ----non_ercc, eval=TRUE, echo=TRUE----------------------------------------
ENSG_genes_index <- grep("ERCC", jaitin.gene_names, invert = TRUE)
jaitin.counts_ensg <- jaitin.counts[ENSG_genes_index, ]
filter_genes <- c("M34473","abParts","M13680","Tmsb4x",
                  "S100a4","B2m","Atpase6","Rpl23","Rps18",
                  "Rpl13","Rps19","H2-Ab1","Rplp1","Rpl4",
                  "Rps26","EF437368")
fcounts <- jaitin.counts_ensg[ -match(filter_genes, rownames(jaitin.counts_ensg)), ]
sample_counts <- colSums(fcounts)

filter_sample_index <- which(jaitin.meta_data$number_of_cells == 1 &
                              jaitin.meta_data$group_name == "CD11c+" &
                                 sample_counts > 600)
fcounts.filtered <- fcounts[,filter_sample_index];

## ----metadata, eval=TRUE, echo=TRUE----------------------------------------
jaitin.meta_data_filtered <- jaitin.meta_data[filter_sample_index, ]

## ----topic_fit_jaitin, eval=FALSE, echo=TRUE-------------------------------
#  StructureObj(t(fcounts),
#              nclus_vec=7, tol=0.1,
#               path_rda="../data/MouseJaitinSpleen.FitGoM.rda")

## ----plot_topic_annot, eval=TRUE, echo=TRUE--------------------------------
data("MouseJaitinSpleen.FitGoM")
names(MouseJaitinSpleen.FitGoM$clust_7)
omega <- MouseJaitinSpleen.FitGoM$clust_7$omega

amp_batch <- as.numeric(jaitin.meta_data_filtered[ , "amplification_batch"])
annotation <- data.frame(
    sample_id = paste0("X", c(1:NROW(omega)) ),
    tissue_label = factor(amp_batch,
                          levels = rev(sort(unique(amp_batch))) ) )

## ----plot_topic, eval=TRUE, echo=TRUE, warning=FALSE, fig.align="center", fig.show="asis", dpi=144, fig.width=3, fig.height=7----
StructureGGplot(omega = omega,
                annotation = annotation,
                palette = RColorBrewer::brewer.pal(9, "Set1"),
                yaxis_label = "Amplification batch",
                order_sample = FALSE,
                axis_tick = list(axis_ticks_length = .1,
                                 axis_ticks_lwd_y = .1,
                                 axis_ticks_lwd_x = .1,
                                 axis_label_size = 7,
                                 axis_label_face = "bold"))

## ----batch_correct, eval=FALSE, echo=TRUE----------------------------------
#  batchcorrect.fcounts <- BatchCorrectedCounts(t(fcounts.filtered),
#                                            amp_batch, use_parallel = FALSE);
#  dim(batchcorrect.fcounts)

## ----session_info, eval=TRUE-----------------------------------------------
sessionInfo()

