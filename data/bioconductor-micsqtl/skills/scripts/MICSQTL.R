# Code example from 'MICSQTL' vignette. See references/ for full tutorial.

## ----set, echo = FALSE--------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message = FALSE, warning = FALSE, eval = FALSE--------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MICSQTL")

## ----lib, message = FALSE, warning = FALSE------------------------------------
library(MICSQTL)

## ----lib2, message = FALSE, warning = FALSE, eval = FALSE---------------------
# library(reshape2)
# library(GGally)
# library(ggplot2)

## ----obj----------------------------------------------------------------------
data(se)

## ----eg, eval = FALSE---------------------------------------------------------
# se <- SummarizedExperiment(
#     assays = list(protein = your_protein_data),
#     rowData = your_anno_protein
# )
# metadata(se) <- list(
#     gene_data = your_gene_data
# )

## ----cross, message = FALSE, warning = FALSE, results = FALSE, eval = FALSE----
# se <- ajive_decomp(se, use_marker = FALSE, refactor_loading = TRUE)
# se <- deconv(se, source = "cross", method = "JNMF",
#              Step = c(10^(-9), 10^(-7)),
#              use_refactor = 1000,
#              pinit = se@metadata$prop_gene,
#              ref_pnl = se@metadata$ref_gene)

## ----plot2, echo = FALSE, warning = FALSE, eval = FALSE-----------------------
# ggplot(
#     cbind(data.frame(melt(metadata(se)$prop), metadata(se)$meta)),
#     aes(x = Var2, y = value, fill = Var2)
# ) +
#     geom_point(
#         position = position_jitterdodge(
#             jitter.width = 0.1,
#             dodge.width = 0.7
#         ),
#         aes(fill = Var2, color = Var2),
#         pch = 21, alpha = 0.5
#     ) +
#     geom_boxplot(lwd = 0.7, outlier.shape = NA) +
#     theme_classic() +
#     facet_wrap(~disease) +
#     xlab("Cell type") +
#     ylab("Estimated proportion") +
#     theme(legend.position = "none")

## ----ajive, eval = FALSE------------------------------------------------------
# se <- ajive_decomp(se, plot = TRUE,
#                    group_var = "disease",
#                    scatter = TRUE, scatter_x = "cns_1", scatter_y = "cns_2")
# metadata(se)$cns_plot

## ----pca----------------------------------------------------------------------
pca_res <- prcomp(t(assay(se)), rank. = 3, scale. = FALSE)
pca_res_protein <- data.frame(pca_res[["x"]])
pca_res_protein <- cbind(pca_res_protein, metadata(se)$meta$disease)
colnames(pca_res_protein)[4] <- "disease"

## ----pcaplot, eval = FALSE----------------------------------------------------
# ggpairs(pca_res_protein,
#         columns = seq_len(3), aes(color = disease, alpha = 0.5),
#         upper = list(continuous = "points")
# ) + theme_classic()
# 
# 
# pca_res <- prcomp(t(metadata(se)$gene_data), rank. = 3, scale. = FALSE)
# pca_res_gene <- data.frame(pca_res[["x"]])
# pca_res_gene <- cbind(pca_res_gene, metadata(se)$meta$disease)
# colnames(pca_res_gene)[4] <- "disease"
# ggpairs(pca_res_gene,
#         columns = seq_len(3), aes(color = disease, alpha = 0.5),
#         upper = list(continuous = "points")
# ) + theme_classic()

## ----filter1------------------------------------------------------------------
head(rowData(se))

## ----filter2------------------------------------------------------------------
head(metadata(se)$anno_SNP)

## ----filter3------------------------------------------------------------------
target_protein <- rowData(se)[rowData(se)$Chr == 9, ][seq_len(3), "Symbol"]

## ----filter 4-----------------------------------------------------------------
se <- feature_filter(se,
    target_protein = target_protein,
    filter_method = c("allele", "distance"),
    filter_allele = 0.15,
    filter_geno = 0.05,
    ref_position = "TSS"
)

## ----filter5------------------------------------------------------------------
unlist(lapply(metadata(se)$choose_SNP_list, length))

## ----csQTL1, eval = FALSE-----------------------------------------------------
# system.time(se <- csQTL(se))

## ----csQTL2, eval = FALSE-----------------------------------------------------
# res <- metadata(se)$TOAST_output[[2]]
# head(res[order(apply(res, 1, min)), ])

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

