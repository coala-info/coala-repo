# Code example from 'survtype' vignette. See references/ for full tutorial.

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
library(survtype)
data(lung)
lung.survtype <- Surv.survtype(lung, time = "time", status = "status")
plot.survtype(lung.survtype, pval = TRUE)

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
data(ovarian)
ovarian.survtype <- Surv.survtype(ovarian, time = "futime", status = "fustat")
plot.survtype(ovarian.survtype, pval = TRUE)

## ----fig.align='center', message=FALSE, warning=FALSE, eval=FALSE-------------
# DLBCLgenes <- read.csv("https://doi.org/10.1371/journal.pbio.0020108.sd012", header = FALSE)
# DLBCLpatients <- read.csv("https://doi.org/10.1371/journal.pbio.0020108.sd013", header = FALSE)
# colnames(DLBCLpatients) <- c("time", "status")
# rownames(DLBCLpatients) <- colnames(DLBCLgenes)
# plot.survtype(Single.survgroup(DLBCLpatients, time = "time", status = "status", DLBCLgenes[1,]), pval = TRUE)
# 
# SE <- SummarizedExperiment(assays=SimpleList(expression = as.matrix(DLBCLgenes)))
# DLBCL.survtype <- Exprs.survtype(DLBCLpatients, time = "time", status = "status",
#                                  assay(SE), num.genes = 50,
#                                  scale = "row", gene.sel = TRUE,
#                                  clustering_method = "ward.D2",
#                                  show_colnames = FALSE)
# plot.survtype(DLBCL.survtype, pval = TRUE)

## ----fig.align='center', message=FALSE, warning=FALSE, eval=FALSE-------------
# library(SummarizedExperiment)
# library(TCGAbiolinks)
# query <- GDCquery(project = "TCGA-LUAD",
#                   data.category = "Gene expression",
#                   data.type = "Gene expression quantification",
#                   platform = "Illumina HiSeq",
#                   file.type  = "normalized_results",
#                   experimental.strategy = "RNA-Seq",
#                   legacy = TRUE)
# GDCdownload(query, method = "api")
# data <- GDCprepare(query)
# exprs.LUAD <- assay(data)
# # cancer only
# exprs.LUAD <- exprs.LUAD[,which(substr(colnames(exprs.LUAD), 14, 15) == "01")]
# clinic.LUAD <- GDCquery_clinic("TCGA-LUAD", "clinical")
# # stage I only
# clinic.LUAD <- clinic.LUAD[clinic.LUAD$tumor_stage %in% c("stage i", "stage ia", "stage ib"),]
# rownames(clinic.LUAD) <- clinic.LUAD[,1]
# clinic.LUAD <- clinic.LUAD[,c("days_to_last_follow_up", "vital_status")]
# clinic.LUAD$vital_status <- ifelse(clinic.LUAD$vital_status == "dead", 1, 0)
# # match TCGA ID
# colnames(exprs.LUAD) <- substr(colnames(exprs.LUAD), 1, 12)
# # filtering
# keep <- rowMeans(exprs.LUAD) > 500
# exprs.LUAD <- exprs.LUAD[keep,]
# # log2 transformation
# exprs.LUAD <- log2(exprs.LUAD + 1)
# # normalization
# exprs.LUAD <- quantile_normalization(exprs.LUAD)
# dim(exprs.LUAD)
# LUAD.survtype <- Exprs.survtype(clinic.LUAD, time = "days_to_last_follow_up",
#                                 status = "vital_status", exprs.LUAD,
#                                 num.genes = 100, scale = "row",
#                                 gene.sel = FALSE, clustering_method = "ward.D2",
#                                 show_colnames = FALSE)
# plot(LUAD.survtype, pval = TRUE, palette = c("#619CFF", "#F8766D"))
# gene.clust(LUAD.survtype, 2, scale = "row", clustering_method = "ward.D2",
#            show_colnames = FALSE)
# # VEGFA
# VEGFA.survgroup <- Single.survgroup(LUAD.survtype$surv.data,
#                                  time = "days_to_last_follow_up",
#                                  status = "vital_status",
#                                  LUAD.survtype$exprs.data["VEGFA",],
#                                  group.names = c("High Expression",
#                                                  "Low Expression"))
# plot(VEGFA.survgroup, title = "VEGFA", pval = TRUE)

## ----fig.align='center', message=FALSE, warning=FALSE, eval=TRUE--------------
library(maftools)
laml.maf <- system.file('extdata', 'tcga_laml.maf.gz', package = 'maftools', mustWork = TRUE)
laml.clin <- system.file('extdata', 'tcga_laml_annot.tsv', package = 'maftools', mustWork = TRUE)
laml.maf <- read.csv(laml.maf, sep = "\t")
laml.clinical.data <- read.csv(laml.clin, sep = "\t", row.names = 1)
index <- which(laml.clinical.data$days_to_last_followup == -Inf)
laml.clinical.data <- laml.clinical.data[-index,]
laml.clinical.data <- data.frame(laml.clinical.data)
laml.survgroup <- MAF.survgroup(laml.clinical.data, time = "days_to_last_followup",
                              status = "Overall_Survival_Status", laml.maf,
                              variants = "Missense_Mutation", num.genes = 10,
                              top.genes = 1, pval = TRUE)
head(laml.survgroup$summary)

