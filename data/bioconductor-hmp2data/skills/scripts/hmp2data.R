# Code example from 'hmp2data' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)

## ----eval = FALSE-------------------------------------------------------------
# # Check if BiocManager is installed
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# # Install HMP2Data package using BiocManager
# BiocManager::install("HMP2Data")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("jstansfield0/HMP2Data")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(HMP2Data)
library(phyloseq)
library(SummarizedExperiment)
library(MultiAssayExperiment)
library(dplyr)
library(ggplot2)
library(UpSetR)

## -----------------------------------------------------------------------------
data("momspi16S_mtx")
momspi16S_mtx[1:5, 1:3]

## -----------------------------------------------------------------------------
data("momspi16S_tax")
colnames(momspi16S_tax)
momspi16S_tax[1:5, 1:3]

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# # Check if Greengene IDs match between the 16S and taxonomy data
# # all.equal(rownames(momspi16S_mtx), rownames(momspi16S_tax)) # Should be TRUE

## -----------------------------------------------------------------------------
data("momspi16S_samp")
colnames(momspi16S_samp)
momspi16S_samp[1:5, 1:3]
# Check if sample names match between the 16S and sample data
# all.equal(colnames(momspi16S_mtx), rownames(momspi16S_samp)) # Should be TRUE

## ----message=FALSE------------------------------------------------------------
momspi16S_phyloseq <- momspi16S()
momspi16S_phyloseq

## -----------------------------------------------------------------------------
data("momspiCyto_mtx")
momspiCyto_mtx[1:5, 1:5]

## -----------------------------------------------------------------------------
data("momspiCyto_samp")
colnames(momspiCyto_samp)
momspiCyto_samp[1:5, 1:5]

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# # Check if sample names match between the 16S and sample data
# # all.equal(colnames(momspiCyto_mtx), rownames(momspiCyto_samp)) # Should be TRUE

## -----------------------------------------------------------------------------
momspiCyto <- momspiCytokines()
momspiCyto

## -----------------------------------------------------------------------------
momspiMA <- momspiMultiAssay()
momspiMA

## -----------------------------------------------------------------------------
rRNA <- momspiMA[[1L]]

## -----------------------------------------------------------------------------
cyto <- momspiMA[[2L]]

## -----------------------------------------------------------------------------
colData(momspiMA) %>% head()

## -----------------------------------------------------------------------------
completeMA <- intersectColumns(momspiMA)
completeMA

## -----------------------------------------------------------------------------
data("IBD16S_mtx")
IBD16S_mtx[1:5, 1:5]

## -----------------------------------------------------------------------------
data("IBD16S_tax")
colnames(IBD16S_tax)
IBD16S_tax[1:5, 1:5]

## -----------------------------------------------------------------------------
data("IBD16S_samp")
colnames(IBD16S_samp) %>% head()
IBD16S_samp[1:5, 1:5]

## -----------------------------------------------------------------------------
IBD <- IBD16S()
IBD

## -----------------------------------------------------------------------------
data("T2D16S_mtx")
T2D16S_mtx[1:5, 1:5]

## -----------------------------------------------------------------------------
data("T2D16S_tax")
colnames(T2D16S_tax)
T2D16S_tax[1:5, 1:5]

## -----------------------------------------------------------------------------
data("T2D16S_samp")
colnames(T2D16S_samp)
T2D16S_samp[1:5, 1:5]

## -----------------------------------------------------------------------------
T2D <- T2D16S()
T2D

## -----------------------------------------------------------------------------
list("MOMS-PI 16S" = momspi16S_phyloseq, "MOMS-PI Cytokines" = momspiCyto, "IBD 16S" = IBD, "T2D 16S" = T2D) %>% table_two()

## -----------------------------------------------------------------------------
list("MOMS-PI 16S" = momspi16S_phyloseq, "MOMS-PI Cytokines" = momspiCyto, "IBD 16S" = IBD, "T2D 16S" = T2D) %>% visit_table()

## -----------------------------------------------------------------------------
list("MOMS-PI 16S" = momspi16S_phyloseq, "MOMS-PI Cytokines" = momspiCyto, "IBD 16S" = IBD, "T2D 16S" = T2D) %>% patient_table()

## ----fig.height=4, fig.width=4------------------------------------------------
# set up ggplots
p1 <- ggplot(momspi16S_samp, aes(x = visit_number)) + 
  geom_histogram(bins = 20, color = "#00BFC4", fill = "lightblue") +
  xlim(c(0,20)) + xlab("Visit number") + ylab("Count")
# theme(panel.background = element_blank(), panel.grid = element_blank())
p1

## ----fig.height=4, fig.width=7------------------------------------------------
# make data.frame for plotting
plot_visits <- data.frame(study = c(rep("MOMS-PI Cytokines", nrow(momspiCyto_samp)),
                     rep("IBD 16S", nrow(IBD16S_samp)),
                     rep("T2D 16S", nrow(T2D16S_samp))),
          visits = c(momspiCyto_samp$visit_number,
                     IBD16S_samp$visit_number,
                     T2D16S_samp$visit_number))
p2 <- ggplot(plot_visits, aes(x = visits, fill = study)) + 
  geom_histogram(position = "dodge", alpha = 0.7, bins = 30, color = "#00BFC4") + xlim(c(0, 40)) +
  theme(legend.position = c(0.8, 0.8))  + 
  xlab("Visit number") + ylab("Count")
p2

## ----fig.height=6, fig.width=10-----------------------------------------------
# set up data.frame for UpSetR
tmp_data <- split(momspi16S_samp, momspi16S_samp$subject_id)
momspi_upset <- lapply(tmp_data, function(x) {
  table(x$sample_body_site)
})
momspi_upset <- bind_rows(momspi_upset)
tmp <- as.matrix(momspi_upset[, -1])
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
momspi_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(momspi_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)

## -----------------------------------------------------------------------------
# set up data.frame for UpSetR
tmp_data <- split(momspiCyto_samp, momspiCyto_samp$subject_id)
momspiCyto_upset <- lapply(tmp_data, function(x) {
  table(x$sample_body_site)
})
momspiCyto_upset <- bind_rows(momspiCyto_upset)
tmp <- as.matrix(momspiCyto_upset[, -1])
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
momspiCyto_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(momspiCyto_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)

## -----------------------------------------------------------------------------
# set up data.frame for UpSetR
tmp_data <- split(IBD16S_samp, IBD16S_samp$subject_id)
IBD_upset <- lapply(tmp_data, function(x) {
  table(x$biopsy_location)
})
IBD_upset <- bind_rows(IBD_upset)
tmp <- as.matrix(IBD_upset[, -1])
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
IBD_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(IBD_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)

## -----------------------------------------------------------------------------
# set up data.frame for UpSetR
tmp_data <- split(T2D16S_samp,T2D16S_samp$subject_id)
T2D_upset <- lapply(tmp_data, function(x) {
  table(x$sample_body_site)
})
T2D_upset <- bind_rows(T2D_upset)
tmp <- as.matrix(T2D_upset)
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
T2D_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(T2D_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)

## -----------------------------------------------------------------------------
momspi_cytokines_participants <- colData(momspiCyto)
momspi_cytokines_participants[1:5, ]

## -----------------------------------------------------------------------------
momspi_cytokines <- assay(momspiCyto)
momspi_cytokines[1:5, 1:5]

## -----------------------------------------------------------------------------
momspi_16S_participants <- sample_data(momspi16S_phyloseq)

## -----------------------------------------------------------------------------
momspi16s_data <- as.matrix(otu_table(momspi16S_phyloseq))

## -----------------------------------------------------------------------------
momspi16s_taxa <- tax_table(momspi16S_phyloseq) %>% as.data.frame()

## ----eval = FALSE-------------------------------------------------------------
# library(readr)
# write_csv(data.frame(file_id = rownames(momspi_cytokines_participants), momspi_cytokines_participants), "momspi_cytokines_participants.csv")
# write_csv(data.frame(momspi_cytokines), "momspi_cytokines.csv")

## ----message=FALSE------------------------------------------------------------
sessionInfo()

