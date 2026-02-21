# Code example from 'CLI_tutorial' vignette. See references/ for full tutorial.

## ----install, eval=FALSE------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("psichomics")

## ----load, message=FALSE------------------------------------------------------
library(psichomics)

## ----TCGA options-------------------------------------------------------------
# Available tumour types
cohorts <- getFirebrowseCohorts()

# Available sample dates
date <- getFirebrowseDates()

# Available data types
dataTypes <- getFirebrowseDataTypes()

## ----download, eval=FALSE-----------------------------------------------------
# # Set download folder
# folder <- getDownloadsFolder()
# 
# # Download and load most recent junction quantification and clinical data from
# # TCGA/FireBrowse for Breast Cancer
# data <- loadFirebrowseData(folder=folder,
#                            cohort="BRCA",
#                            data=c("clinical", "junction_quantification",
#                                   "RSEM_genes"),
#                            date="2016-01-28")
# names(data)
# names(data[[1]])
# 
# # Select clinical and junction quantification dataset
# clinical      <- data[[1]]$`Clinical data`
# sampleInfo    <- data[[1]]$`Sample metadata`
# junctionQuant <- data[[1]]$`Junction quantification (Illumina HiSeq)`
# geneExpr      <- data[[1]]$`Gene expression`

## ----prepare examples, include=FALSE------------------------------------------
clinical <- readRDS("BRCA_clinical.RDS")
geneExpr <- readRDS("BRCA_geneExpr.RDS")

## ----normalise gene expression------------------------------------------------
# Check genes with 10 or more counts in at least some samples and 15 or more
# total counts across all samples
filter <- filterGeneExpr(geneExpr, minCounts=10, minTotalCounts=15)

# What normaliseGeneExpression() does:
# 1) Filter gene expression based on its argument "geneFilter"
# 2) Normalise gene expression with edgeR::calcNormFactors (internally) using
#    the trimmed mean of M-values (TMM) method (by default)
# 3) Calculate log2-counts per million (logCPM)
geneExprNorm <- normaliseGeneExpression(geneExpr,
                                        geneFilter=filter,
                                        method="TMM",
                                        log2transform=TRUE)

## ----quantify options---------------------------------------------------------
# Available alternative splicing annotation
annotList <- listSplicingAnnotations()
annotList

## ----prepare to quantify splicing, eval=FALSE---------------------------------
# # Load Human (hg19/GRCh37 assembly) annotation
# hg19 <- listSplicingAnnotations(assembly="hg19")[[1]]
# annotation <- loadAnnotation(hg19)

## ----event types--------------------------------------------------------------
# Available alternative splicing event types (skipped exon, alternative 
# first/last exon, mutually exclusive exons, etc.)
getSplicingEventTypes()

## ----quantify splicing, eval=FALSE--------------------------------------------
# # Discard alternative splicing quantified using few reads
# minReads <- 10 # default
# 
# psi <- quantifySplicing(annotation, junctionQuant, minReads=minReads)

## ----load splicing, echo=FALSE------------------------------------------------
psi <- readRDS("BRCA_psi.RDS")
sampleInfo <- parseTCGAsampleInfo(colnames(psi))

## ----check splicing events----------------------------------------------------
# Check the identifier of the splicing events in the resulting table
events <- rownames(psi)
head(events)

## ----data grouping------------------------------------------------------------
# Group by normal and tumour samples
types  <- createGroupByAttribute("Sample types", sampleInfo)
normal <- types$`Solid Tissue Normal`
tumour <- types$`Primary solid Tumor`

# Group by tumour stage (I, II, III or IV) or normal samples
stages <- createGroupByAttribute(
    "patient.stage_event.pathologic_stage_tumor_stage", clinical)
groups <- list()
for (i in c("i", "ii", "iii", "iv")) {
    stage <- Reduce(union,
           stages[grep(sprintf("stage %s[a|b|c]{0,1}$", i), names(stages))])
    # Include only tumour samples
    stageTumour <- names(getSubjectFromSample(tumour, stage))
    elem <- list(stageTumour)
    names(elem) <- paste("Tumour Stage", toupper(i))
    groups <- c(groups, elem)
}
groups <- c(groups, Normal=list(normal))

# Prepare group colours (for consistency across downstream analyses)
colours <- c("#6D1F95", "#FF152C", "#00C7BA", "#FF964F", "#00C65A")
names(colours) <- names(groups)
attr(groups, "Colour") <- colours

# Prepare normal versus tumour stage I samples
normalVSstage1Tumour <- groups[c("Tumour Stage I", "Normal")]
attr(normalVSstage1Tumour, "Colour") <- attr(groups, "Colour")

# Prepare normal versus tumour samples
normalVStumour <- list(Normal=normal, Tumour=tumour)
attr(normalVStumour, "Colour") <- c(Normal="#00C65A", Tumour="#EFE35C")

## ----perform pca--------------------------------------------------------------
# PCA of PSI between normal and tumour stage I samples
psi_stage1Norm    <- psi[ , unlist(normalVSstage1Tumour)]
pcaPSI_stage1Norm <- performPCA(t(psi_stage1Norm))

## ----plot pca-----------------------------------------------------------------
# Explained variance across principal components
plotPCAvariance(pcaPSI_stage1Norm)

# Score plot (clinical individuals)
plotPCA(pcaPSI_stage1Norm, groups=normalVSstage1Tumour)

# Loading plot (variable contributions)
plotPCA(pcaPSI_stage1Norm, loadings=TRUE, individuals=FALSE,
        nLoadings=100)

## ----pca contribution---------------------------------------------------------
# Table of variable contributions (as used to plot PCA, also)
table <- calculateLoadingsContribution(pcaPSI_stage1Norm)
head(table, 5)

## ----perform and plot remaining pca, eval=FALSE-------------------------------
# # PCA of PSI between all samples (coloured by tumour stage and normal samples)
# pcaPSI_all <- performPCA(t(psi))
# plotPCA(pcaPSI_all, groups=groups)
# plotPCA(pcaPSI_all, loadings=TRUE, individuals=FALSE)
# 
# # PCA of gene expression between all samples (coloured by tumour stage and
# # normal samples)
# pcaGE_all <- performPCA(t(geneExprNorm))
# plotPCA(pcaGE_all, groups=groups)
# plotPCA(pcaGE_all, loadings=TRUE, individuals=FALSE)
# 
# # PCA of gene expression between normal and tumour stage I samples
# ge_stage1Norm    <- geneExprNorm[ , unlist(normalVSstage1Tumour)]
# pcaGE_stage1Norm <- performPCA(t(ge_stage1Norm))
# plotPCA(pcaGE_stage1Norm, groups=normalVSstage1Tumour)
# plotPCA(pcaGE_stage1Norm, loadings=TRUE, individuals=FALSE)

## ----diff splicing NUMB exon 12-----------------------------------------------
# Find the right event
ASevents <- rownames(psi)
(tmp     <- grep("NUMB", ASevents, value=TRUE))
NUMBskippedExon12 <- tmp[1]

# Plot the representation of NUMB exon 12 inclusion
plotSplicingEvent(NUMBskippedExon12)

# Plot its PSI distribution
plotDistribution(psi[NUMBskippedExon12, ], normalVStumour)

## ----correlation, warning=FALSE-----------------------------------------------
# Find the right gene
genes <- rownames(geneExprNorm)
(tmp  <- grep("QKI", genes, value=TRUE))
QKI   <- tmp[1] # "QKI|9444"

# Plot its gene expression distribution
plotDistribution(geneExprNorm[QKI, ], normalVStumour, psi=FALSE)
plotCorrelation(correlateGEandAS(
    geneExprNorm, psi, QKI, NUMBskippedExon12, method="spearman"))

## ----exploratory diff analysis, message=FALSE---------------------------------
diffSplicing <- diffAnalyses(psi, normalVSstage1Tumour)

# Filter based on |∆ Median PSI| > 0.1 and q-value < 0.01
deltaPSIthreshold <- abs(diffSplicing$`∆ Median`) > 0.1
pvalueThreshold   <- diffSplicing$`Wilcoxon p-value (BH adjusted)` < 0.01
eventsThreshold <- diffSplicing[deltaPSIthreshold & pvalueThreshold, ]

# Plot results
library(ggplot2)
ggplot(diffSplicing, aes(`∆ Median`, 
                         -log10(`Wilcoxon p-value (BH adjusted)`))) +
    geom_point(data=eventsThreshold,
               colour="orange", alpha=0.5, size=3) + 
    geom_point(data=diffSplicing[!deltaPSIthreshold | !pvalueThreshold, ],
               colour="gray", alpha=0.5, size=3) + 
    theme_light(16) +
    ylab("-log10(q-value)")

# Table of events that pass the thresholds
head(eventsThreshold)

## ----survival-----------------------------------------------------------------
# Events already tested which have prognostic value
events <- c(
    "SE_9_+_6486925_6492303_6492401_6493826_UHRF2",
    "SE_4_-_87028376_87024397_87024339_87023185_MAPK10",
    "SE_2_+_152324660_152324988_152325065_152325155_RIF1",
    "SE_2_+_228205096_228217230_228217289_228220393_MFF",
    "MXE_15_+_63353138_63353397_63353472_63353912_63353987_63354414_TPM1",
    "SE_2_+_173362828_173366500_173366629_173368819_ITGA6",
    "SE_1_+_204957934_204971724_204971876_204978685_NFASC")

# Survival curves based on optimal PSI cutoff
library(survival)

# Assign alternative splicing quantification to patients based on their samples
samples <- colnames(psi)
match <- getSubjectFromSample(samples, clinical, sampleInfo=sampleInfo)

survPlots <- list()
for (event in events) {
    # Find optimal cutoff for the event
    eventPSI <- assignValuePerSubject(psi[event, ], match, clinical,
                                      samples=unlist(tumour))
    opt <- optimalSurvivalCutoff(clinical, eventPSI, censoring="right", 
                                 event="days_to_death", 
                                 timeStart="days_to_death")
    (optimalCutoff <- opt$par)    # Optimal exon inclusion level
    (optimalPvalue <- opt$value)  # Respective p-value
    
    label     <- labelBasedOnCutoff(eventPSI, round(optimalCutoff, 2), 
                                    label="PSI values")
    survTerms <- processSurvTerms(clinical, censoring="right",
                                  event="days_to_death", 
                                  timeStart="days_to_death",
                                  group=label, scale="years")
    surv <- survfit(survTerms)
    pvalue <- testSurvival(survTerms)
    survPlots[[event]] <- plotSurvivalCurves(surv, pvalue=pvalue, mark=FALSE)
}

# Now print the survival plot of a specific event
survPlots[[ events[[1]] ]]

## ----exploratory diff expression, message=FALSE, warning=FALSE----------------
# Prepare groups of samples to analyse and further filter unavailable samples in
# selected groups for gene expression
ge           <- geneExprNorm[ , unlist(normalVSstage1Tumour), drop=FALSE]
isFromGroup1 <- colnames(ge) %in% normalVSstage1Tumour[[1]]
design       <- cbind(1, ifelse(isFromGroup1, 0, 1))

# Fit a gene-wise linear model based on selected groups
library(limma)
fit <- lmFit(as.matrix(ge), design)

# Calculate moderated t-statistics and DE log-odds using limma::eBayes
ebayesFit <- eBayes(fit, trend=TRUE)

# Prepare data summary
pvalueAdjust <- "BH" # Benjamini-Hochberg p-value adjustment (FDR)
summary <- topTable(ebayesFit, number=nrow(fit), coef=2, sort.by="none",
                    adjust.method=pvalueAdjust, confint=TRUE)
names(summary) <- c("log2 Fold-Change", "CI (low)", "CI (high)", 
                    "Average expression", "moderated t-statistics", "p-value", 
                    paste0("p-value (", pvalueAdjust, " adjusted)"),
                    "B-statistics")
attr(summary, "groups") <- normalVSstage1Tumour

# Calculate basic statistics
stats <- diffAnalyses(ge, normalVSstage1Tumour, "basicStats", 
                      pvalueAdjust=NULL)
final <- cbind(stats, summary)

# Differential gene expression between breast tumour stage I and normal samples
library(ggplot2)
library(ggrepel)
cognateGenes <- unlist(parseSplicingEvent(events)$gene)
logFCthreshold  <- abs(final$`log2 Fold-Change`) > 1
pvalueThreshold <- final$`p-value (BH adjusted)` < 0.01

final$genes <- gsub("\\|.*$", "\\1", rownames(final))
ggplot(final, aes(`log2 Fold-Change`, 
                  -log10(`p-value (BH adjusted)`))) +
    geom_point(data=final[logFCthreshold & pvalueThreshold, ],
               colour="orange", alpha=0.5, size=3) + 
    geom_point(data=final[!logFCthreshold | !pvalueThreshold, ],
               colour="gray", alpha=0.5, size=3) + 
    geom_text_repel(data=final[cognateGenes, ], aes(label=genes),
                    box.padding=0.4, size=5) +
    theme_light(16) +
    ylab("-log10(q-value)")

## ----UHRF2 exon 10 diff splicing----------------------------------------------
# UHRF2 skipped exon 10's PSI values per tumour stage I and normal samples
UHRF2skippedExon10 <- events[1]
plotDistribution(psi[UHRF2skippedExon10, ], normalVSstage1Tumour)

## ----UHRF2 PSI survival-------------------------------------------------------
# Find optimal cutoff for the event
UHRF2skippedExon10 <- events[1]
eventPSI <- assignValuePerSubject(psi[UHRF2skippedExon10, ], match, clinical,
                                  samples=unlist(tumour))
opt <- optimalSurvivalCutoff(clinical, eventPSI, censoring="right", 
                             event="days_to_death", timeStart="days_to_death")
(optimalCutoff <- opt$par)    # Optimal exon inclusion level
(optimalPvalue <- opt$value)  # Respective p-value

label     <- labelBasedOnCutoff(eventPSI, round(optimalCutoff, 2), 
                                label="PSI values")
survTerms <- processSurvTerms(clinical, censoring="right",
                              event="days_to_death", timeStart="days_to_death",
                              group=label, scale="years")
surv <- survfit(survTerms)
pvalue <- testSurvival(survTerms)
plotSurvivalCurves(surv, pvalue=pvalue, mark=FALSE)

## ----UHRF2 GE diff expression-------------------------------------------------
plotDistribution(geneExprNorm["UHRF2", ], normalVSstage1Tumour)

## ----UHRF2 GE survival--------------------------------------------------------
UHRF2ge <- assignValuePerSubject(geneExprNorm["UHRF2", ], match, clinical, 
                                 samples=unlist(tumour))

# Survival curves based on optimal gene expression cutoff
opt <- optimalSurvivalCutoff(clinical, UHRF2ge, censoring="right",
                             event="days_to_death", timeStart="days_to_death")
(optimalCutoff <- opt$par)    # Optimal exon inclusion level
(optimalPvalue <- opt$value)  # Respective p-value

# Process again after rounding the cutoff
roundedCutoff <- round(optimalCutoff, 2)
label     <- labelBasedOnCutoff(UHRF2ge, roundedCutoff, label="Gene expression")
survTerms <- processSurvTerms(clinical, censoring="right",
                              event="days_to_death", timeStart="days_to_death",
                              group=label, scale="years")
surv   <- survfit(survTerms)
pvalue <- testSurvival(survTerms)
plotSurvivalCurves(surv, pvalue=pvalue, mark=FALSE)

## ----load GTEx, eval=FALSE----------------------------------------------------
# # Check GTEx tissues available based on the sample attributes
# getGtexTissues(sampleAttr)
# 
# tissues <- c("blood", "brain")
# gtex <- loadGtexData("~/Downloads", tissues=tissues)
# names(gtex)
# names(gtex[[1]])

## ----load all GTEx, eval=FALSE------------------------------------------------
# gtex <- loadGtexData("~/Downloads", tissues=NULL)
# names(gtex)
# names(gtex[[1]])

## ----load recount, eval=FALSE-------------------------------------------------
# View(recount::recount_abstract)
# sra <- loadSRAproject("SRP053101")
# names(sra)
# names(sra[[1]])

## ----load local, eval=FALSE---------------------------------------------------
# folder <- "~/Downloads/GTEx/"
# ignore <- c(".aux.", ".mage-tab.") # File patterns to ignore
# data <- loadLocalFiles(folder, ignore=ignore)[[1]]
# names(data)
# names(data[[1]])
# 
# # Select clinical and junction quantification dataset
# clinical      <- data[["Clinical data"]]
# sampleInfo    <- data[["Sample metadata"]]
# geneExpr      <- data[["Gene expression"]]
# junctionQuant <- data[["Junction quantification"]]

