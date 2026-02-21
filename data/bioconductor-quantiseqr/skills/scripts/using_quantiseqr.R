# Code example from 'using_quantiseqr' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  # eval = FALSE,
  comment = "#>"
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("quantiseqr")

## ----loadlib, eval = TRUE-----------------------------------------------------
library("quantiseqr")

## ----loadotherpkgs, message=FALSE, warning=FALSE------------------------------
library("dplyr")
library("ggplot2")
library("tidyr")
library("tibble")
library("GEOquery")
library("reshape2")
library("SummarizedExperiment")

## ----ex1-racle-view-----------------------------------------------------------
data("dataset_racle")
dim(dataset_racle$expr_mat)
knitr::kable(dataset_racle$expr_mat[1:5, ])

## ----ex1-ti-run---------------------------------------------------------------
ti_racle <- quantiseqr::run_quantiseq(
  expression_data = dataset_racle$expr_mat,
  signature_matrix = "TIL10",
  is_arraydata = FALSE,
  is_tumordata = TRUE,
  scale_mRNA = TRUE
)

## ----ex1-ti-plot, fig.height=4, fig.width=8, fig.cap="Stacked barplot of quanTIseq cell fractions computed on the Racle dataset (patients with metastatic melanoma)."----
quantiplot(ti_racle)

## ----ex2-pbmcs-retrieve-------------------------------------------------------
## While downloading by hand is possible, it is recommended to use GEOquery
# wget -c ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE107nnn/GSE107572/suppl/GSE107572%5Ftpm%5FPBMC%5FRNAseq%2Etxt%2Egz
# unzip GSE107572_tpm_PBMC_RNAseq.txt.gz
# read.table("GSE107572_tpm_PBMC_RNAseq.txt", header = TRUE)


# downloading the supplemental files on the fly
tpminfo_GSE107572 <- getGEOSuppFiles("GSE107572",
  baseDir = tempdir(),
  filter_regex = "GSE107572_tpm_PBMC_RNAseq"
)
tpm_location <- rownames(tpminfo_GSE107572)[1]
tpm_location
tpmdata <- read.table(tpm_location, header = TRUE)

## ----ex2-ti-run---------------------------------------------------------------
tpm_genesymbols <- tpmdata$GENE
tpmdata <- as.matrix(tpmdata[, -1])
rownames(tpmdata) <- tpm_genesymbols

ti_PBMCs <- quantiseqr::run_quantiseq(
  expression_data = tpmdata,
  signature_matrix = "TIL10",
  is_arraydata = FALSE,
  is_tumordata = FALSE,
  scale_mRNA = TRUE
)

## ----ex2-ti-plot, fig.width=7, fig.height=5, fig.cap="Stacked barplot of quanTIseq cell fractions computed on the blood derived PBMCs dataset."----
# printing out the percentages for the first 4 samples
signif(ti_PBMCs[1:4, 2:12], digits = 3)
# getting a complete visual overview
quantiplot(ti_PBMCs)

## ----ex2-comparison-----------------------------------------------------------
GEOid <- "GSE107572"
gds <- getGEO(GEOid)
GEOinfo <- pData(gds[[1]])
FACSdata <- data.frame(
  B.cells = GEOinfo$`b cells:ch1`,
  T.cells.CD4 = GEOinfo$`cd4+ t cells:ch1`,
  T.cells.CD8 = GEOinfo$`cd8+ t cells:ch1`,
  Monocytes = GEOinfo$`monocytes:ch1`,
  Dendritic.cells = GEOinfo$`myeloid dendritic cells:ch1`,
  NK.cells = GEOinfo$`natural killer cells:ch1`,
  Neutrophils = GEOinfo$`neutrophils:ch1`,
  Tregs = GEOinfo$`tregs:ch1`
)
rownames(FACSdata) <- gsub(
  "Blood-derived immune-cell mixture from donor ", "pbmc", GEOinfo$title
)

rownames(ti_PBMCs) <- gsub("_.*$", "", sub("_", "", rownames(ti_PBMCs)))

ccells <- intersect(colnames(ti_PBMCs), colnames(FACSdata))
csbjs <- intersect(rownames(ti_PBMCs), rownames(FACSdata))

ti_PBMCs <- ti_PBMCs[csbjs, ccells]
FACSdata <- FACSdata[csbjs, ccells]

## ----ex2-comparison-plot, fig.width=9, fig.height=9, fig.cap="Scatterplot of quanTIseq cell fractions for the PBMCs dataset, plotted against the fractions estimated from flow cytometry. Each subplot display a specific cell type, and all cells are summarized in the lower right corner. The dashed grey line indicates the diagonal, corresponding to the identity line, while the black solid line is the linear model fit. The text annotation reports the r correlation coefficient, its significance, and the root mean squared error."----
palette <- c("#451C87", "#B3B300", "#CE0648", "#2363C5", "#AB4CA1", "#0A839B", "#DD8C24", "#ED6D42")

names(palette) <- c("T.cells.CD4", "Dendritic.cells", "Monocytes", "T.cells.CD8", "Tregs", "B.cells", "NK.cells", "Neutrophils")

par(mfrow = c(3, 3))
colall <- c()
for (i in 1:(ncol(ti_PBMCs) + 1)) {
  if (i <= ncol(ti_PBMCs)) {
    x <- as.numeric(as.character(FACSdata[, i]))
    y <- ti_PBMCs[, i]
    ccell <- colnames(ti_PBMCs)[i]
    col <- palette[ccell]
  } else {
    x <- as.numeric(as.vector(as.matrix(FACSdata)))
    y <- as.vector(as.matrix(ti_PBMCs))
    ccell <- "All cells"
    col <- colall
  }
  res.cor <- cor.test(y, x)
  R <- round(res.cor$estimate, digits = 2)
  p <- format.pval(res.cor$p.value, digits = 2)
  RMSE <- round(sqrt(mean((y - x)^2, na.rm = TRUE)), digits = 2)

  regl <- lm(y ~ x)
  ymax <- max(round(max(y), digits = 2) * 1.3, 0.01)
  xmax <- max(round(max(x), digits = 2), 0.01)
  plot(x, y,
    main = gsub("(\\.)", " ", ccell), pch = 19,
    xlab = "Flow cytometry fractions",
    ylab = "quanTIseq cell fractions",
    col = col, cex.main = 1.3, ylim = c(0, ymax), xlim = c(0, xmax), las = 1
  )
  abline(regl)
  abline(a = 0, b = 1, lty = "dashed", col = "lightgrey")
  text(0, ymax * 0.98, cex = 1, paste0("r = ", R, ", p = ", p), pos = 4)
  text(0, ymax * 0.9, cex = 1, paste0("RMSE = ", RMSE), pos = 4)

  colall <- c(colall, rep(col, length(x)))
}

## ----ex3-retrieve-run---------------------------------------------------------
library("ExperimentHub")
eh <- ExperimentHub()
quantiseqdata_eh <- query(eh, "quantiseqr")
quantiseqdata_eh

se_Song2017_MAPKi_treatment <- quantiseqdata_eh[["EH6015"]]

se_Song2017_MAPKi_treatment_tiquant <- quantiseqr::run_quantiseq(
  expression_data = se_Song2017_MAPKi_treatment,
  signature_matrix = "TIL10",
  is_arraydata = FALSE,
  is_tumordata = TRUE,
  scale_mRNA = TRUE
)

dim(se_Song2017_MAPKi_treatment_tiquant)
# colData(se_Song2017_MAPKi_treatment_tiquant)
colnames(colData(se_Song2017_MAPKi_treatment_tiquant))

## ----ex3-ti-plot, fig.height=5, fig.width=7, fig.cap="Stacked barplot of quanTIseq cell fractions computed on the Song et al. dataset, this time using a customized color palette."----
# to extract the TIL10-relevant parts:
ti_quant <- quantiseqr::extract_ti_from_se(se_Song2017_MAPKi_treatment_tiquant)

# to access the full column metadata:
cdata <- colData(se_Song2017_MAPKi_treatment_tiquant)

cellfracs_tidy <- tidyr::pivot_longer(
  as.data.frame(cdata), 
  cols = quanTIseq_TIL10_B.cells:quanTIseq_TIL10_Other)

cellfracs_tidy$name <- factor(gsub("quanTIseq_TIL10_", "", cellfracs_tidy$name),
  levels = c(
    "B.cells", "Macrophages.M1", "Macrophages.M2",
    "Monocytes", "Neutrophils", "NK.cells",
    "T.cells.CD4", "T.cells.CD8", "Tregs",
    "Dendritic.cells", "Other"
  )
)

ggplot(cellfracs_tidy, aes(fill = name, y = value, x = sra_id)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_fill_brewer(palette = "PuOr") +
  xlab("") +
  ylab("Cell Fractions") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# we could have also used the compact wrapper
## quantiplot(se_Song2017_MAPKi_treatment_tiquant)

## ----ex3-ti-plot2, fig.height=5, fig.width=7, fig.cap="Boxplot of quanTIseq cell fractions computed on the Song et al. dataset, showing the effect of the MAPKi treatment."----
prepost_data <- cdata[cdata$is_patient, ]

prepost_data_tidy <- tidyr::pivot_longer(
  as.data.frame(prepost_data), 
  cols = quanTIseq_TIL10_B.cells:quanTIseq_TIL10_Dendritic.cells)

prepost_data_tidy$groups <- factor(prepost_data_tidy$mapki.treatment.ch1, levels = c("none", "on-treatment"))

prepost_data_tidy$name <- factor(gsub("quanTIseq_TIL10_", "", prepost_data_tidy$name),
  levels = c(
    "B.cells", "Macrophages.M1", "Macrophages.M2",
    "Monocytes", "Neutrophils", "NK.cells",
    "T.cells.CD4", "T.cells.CD8", "Tregs",
    "Dendritic.cells"
  )
)

ggplot(prepost_data_tidy, aes(name, value, fill = groups)) +
  geom_boxplot() +
  xlab("") +
  ylab("cell fractions") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----ex4-setup, eval = FALSE--------------------------------------------------
# # downloading first the file from https://icbi.i-med.ac.at/software/quantiseq/doc/downloads/quanTIseq_SimRNAseq_mixture.txt
# 
# # https://icbi.i-med.ac.at/software/quantiseq/doc/
# 
# tpm_1700mixtures <- readr::read_tsv("quanTIseq_SimRNAseq_mixture.txt.gz")
# dim(tpm_1700mixtures)
# 
# # extracting the gene names, restructuring the matrix by dropping the column
# tpm_genesymbols <- tpm_1700mixtures$Gene
# tpm_1700mixtures <- as.matrix(tpm_1700mixtures[, -1])
# rownames(tpm_1700mixtures) <- tpm_genesymbols
# 
# # running quantiseq on that set
# # True mRNA fractions were simulated with no total-mRNA bias. Thus, these data should be analyzed specifying the option scale_mRNA set to FALSE
# ti_quant_sim1700mixtures <- quantiseqr::run_quantiseq(
#   expression_data = tpm_1700mixtures,
#   signature_matrix = "TIL10",
#   is_arraydata = FALSE,
#   is_tumordata = TRUE,
#   scale_mRNA = FALSE
# )
# 
# # save(ti_quant_sim1700mixtures, file = "data/ti_quant_sim1700mixtures.RData")

## ----ex4-load-plot, fig.height=10, fig.width=6, fig.cap="Stacked barplot of quanTIseq cell fractions computed on the first 100 samples from the simulated dataset."----
data(ti_quant_sim1700mixtures)
dim(ti_quant_sim1700mixtures)
head(ti_quant_sim1700mixtures)
quantiplot(ti_quant_sim1700mixtures[1:100, ])

## ----ex4-gtruth---------------------------------------------------------------
true_prop_1700mix <- read.table(
  system.file("extdata", "quanTIseq_SimRNAseq_read_fractions.txt.gz", package = "quantiseqr"),
  sep = "\t", header = TRUE
)
head(true_prop_1700mix)

## ----ex4-compare-plot, fig.width=7, fig.cap="Scatterplot of quanTIseq cell fractions computed on the simulated dataset, plotted against the true fractions."----
# merging the two sets to facilitate the visualization
# colnames(ti_quant_sim1700mixtures) <- paste0("quantiseq_", colnames(ti_quant_sim1700mixtures))
# colnames(true_prop_1700mix) <- paste0("trueprops_", colnames(true_prop_1700mix))

# ti_quant_sim1700mixtures$method <- "quanTIseq"
# true_prop_1700mix$method <- "ground_truth"

colnames(true_prop_1700mix)[1] <- "Sample"
colnames(true_prop_1700mix)[12] <- "Other"

ti_long <- tidyr::pivot_longer(ti_quant_sim1700mixtures,
  cols = B.cells:Other,
  names_to = "cell_type",
  values_to = "value_quantiseq"
)
ti_long$mix_id <- paste(ti_long$Sample, ti_long$cell_type, sep = "_")

tp_long <- pivot_longer(true_prop_1700mix,
  cols = B.cells:Other,
  names_to = "cell_type",
  values_to = "value_trueprop"
)
tp_long$mix_id <- paste(tp_long$Sample, tp_long$cell_type, sep = "_")


ti_tp_merged <- merge(ti_long, tp_long, by = "mix_id")
ti_tp_merged$cell_type.x <- factor(ti_tp_merged$cell_type.x, levels = colnames(true_prop_1700mix)[2:12])

# ti_merged <- rbind(ti_quant_sim1700mixtures,
# true_prop_1700mix)

# ti_merged_long <- pivot_longer(ti_quant_sim1700mixtures, cols = B.cells:Other)

ggplot(
  ti_tp_merged,
  aes(
    x = value_trueprop,
    y = value_quantiseq,
    col = cell_type.x
  )
) +
  geom_point(alpha = 0.5) +
  theme_bw() + 
  labs(
    x = "True fractions",
    y = "quanTIseq cell fractions",
    col = "Cell type"
  )

## ----ex4-compare-plot2, fig.width=7, fig.cap="Scatterplot of quanTIseq cell fractions computed on the simulated dataset, plotted against the true fractions - this time using small multiples for each cell type. The light grey line is the identity line, 'y = x'"----
ggplot(
  ti_tp_merged,
  aes(
    x = value_trueprop,
    y = value_quantiseq,
    col = cell_type.x
  )
) +
  facet_wrap(~cell_type.x, scales = "free") +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, col = "lightgrey") + 
  labs(
    x = "True fractions",
    y = "quanTIseq cell fractions",
    col = "Cell type"
  ) + 
  theme_bw()

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

