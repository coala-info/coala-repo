# Code example from 'detecting_hidden_heterogeneity_iasvaV0.95' vignette. See references/ for full tutorial.

## ----load_packages, echo=TRUE, message=FALSE----------------------------------
library(irlba) 
library(iasva)
library(sva)
library(Rtsne)
library(pheatmap)
library(corrplot)
library(DescTools)
library(RColorBrewer)
library(SummarizedExperiment)
set.seed(100)
color.vec <- brewer.pal(3, "Set1")

## ----load_data, echo=TRUE-----------------------------------------------------
counts_file <- system.file("extdata", "iasva_counts_test.Rds",
                         package = "iasva")
# matrix of read counts where genes are rows, samples are columns
counts <- readRDS(counts_file)
# matrix of sample annotations/metadata
anns_file <- system.file("extdata", "iasva_anns_test.Rds",
                         package = "iasva")
anns <- readRDS(anns_file)


## ----geno_lib_size, echo=TRUE, fig.width=7, fig.height=4----------------------
geo_lib_size <- colSums(log(counts + 1))
barplot(geo_lib_size, xlab = "Cell", ylab = "Geometric Lib Size", las = 2)
lcounts <- log(counts + 1)

# PC1 and Geometric library size correlation
pc1 <- irlba(lcounts - rowMeans(lcounts), 1)$v[, 1]
cor(geo_lib_size, pc1)

## ----run_iasva, echo=TRUE, fig.width= 7, fig.height=6-------------------------
set.seed(100)
patient_id <- anns$Patient_ID
mod <- model.matrix(~patient_id + geo_lib_size)
# create a summarizedexperiment class
summ_exp <- SummarizedExperiment(assays = counts)
iasva.res<- iasva(summ_exp, mod[, -1],verbose = FALSE, 
                  permute = FALSE, num.sv = 5)
iasva.sv <- iasva.res$sv
plot(iasva.sv[, 1], iasva.sv[, 2], xlab = "SV1", ylab = "SV2")
cell_type <- as.factor(iasva.sv[, 1] > -0.1) 
levels(cell_type) <- c("Cell1", "Cell2")
table(cell_type)

# We identified 6 outlier cells based on SV1 that are marked in red
pairs(iasva.sv, main = "IA-SVA", pch = 21, col = color.vec[cell_type],
      bg = color.vec[cell_type], oma = c(4,4,6,12))
legend("right", levels(cell_type), fill = color.vec, bty = "n")
plot(iasva.sv[, 1:2], main = "IA-SVA", pch = 21, xlab = "SV1", ylab = "SV2",
     col = color.vec[cell_type], bg = color.vec[cell_type])
cor(geo_lib_size, iasva.sv[, 1])
corrplot(cor(iasva.sv))

## ----find_markers, echo=TRUE, fig.width=7, fig.height=14----------------------
marker.counts <- find_markers(summ_exp, as.matrix(iasva.sv[,1]))
nrow(marker.counts)
rownames(marker.counts)
anno.col <- data.frame(cell_type = cell_type)
rownames(anno.col) <- colnames(marker.counts)
head(anno.col)
pheatmap(log(marker.counts + 1), show_colnames = FALSE,
         clustering_method = "ward.D2", cutree_cols = 2,
         annotation_col = anno.col)

## ----run_tsne, echo=TRUE, fig.width=7, fig.height=7---------------------------
set.seed(100)
tsne.res <- Rtsne(t(lcounts), dims = 2)

plot(tsne.res$Y, main = "tSNE", xlab = "tSNE Dim1", ylab = "tSNE Dim2",
     pch = 21, col = color.vec[cell_type], bg = color.vec[cell_type],
     oma = c(4, 4, 6, 12))
legend("bottomright", levels(cell_type), fill = color.vec, bty = "n")

## ----run_tsne_post_iasva, echo=TRUE, fig.width=7, fig.height=7----------------
set.seed(100)
tsne.res <- Rtsne(unique(t(log(marker.counts + 1))), dims = 2)
plot(tsne.res$Y, main = "tSNE post IA-SVA", xlab = "tSNE Dim1",
     ylab = "tSNE Dim2", pch = 21, col = color.vec[cell_type],
     bg = color.vec[cell_type], oma = c(4, 4, 6, 12))
legend("bottomright", levels(cell_type), fill = color.vec, bty = "n")

## ----fast_iasva, echo=TRUE----------------------------------------------------
iasva.res <- fast_iasva(summ_exp, mod[, -1], num.sv = 5)

## ----study_r2, echo=TRUE, fig.width=7, fig.height=7---------------------------
study_res <- study_R2(summ_exp, iasva.sv)

## ----session_info, echo=TRUE--------------------------------------------------
sessionInfo()

