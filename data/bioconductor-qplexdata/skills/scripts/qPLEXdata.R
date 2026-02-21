# Code example from 'qPLEXdata' vignette. See references/ for full tutorial.

## ----options,echo=FALSE-----------------------------------------------
options(width=72)

## ----lbsload,message=FALSE,cache=TRUE---------------------------------
library(dplyr)
suppressWarnings(library(qPLEXanalyzer))
suppressWarnings(library(qPLEXdata))
data(human_anno)

## ----exp1_specificity,message=FALSE,cache=TRUE------------------------
## load data
data(exp1_specificity)

## create MSnSet object
MSnset_data <- convertToMSnset(exp1_specificity$intensities,
                               metadata=exp1_specificity$metadata,
                               indExpData=c(6:15),Sequences=1,Accessions=5)

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median)

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(ER_vs_IgG = "ER - IgG")
diffstats <- computeDiffStats(MSnSetObj=MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts)
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.01 & diffexp$log2FC >1),]

## ----exp2_Xlink,message=FALSE,cache=TRUE------------------------------
## load data
data(exp2_Xlink)

## create MSnSet object
MSnset_data <- convertToMSnset(exp2_Xlink$intensities,
                               metadata=exp2_Xlink$metadata,
                               indExpData=c(7:16),Sequences=2,Accessions=6)
exprs(MSnset_data) <- exprs(MSnset_data)+0.01
MSnset_data <- MSnset_data[,-5]

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median)

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(DSG.FA_vs_FA = "DSG.FA - FA")
diffstats <- computeDiffStats(MSnSetObj=MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts,
                              controlGroup = "IgG")
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.05 & abs(diffexp$log2FC) > 0.5),]

## ----exp3_OHT_ESR1,message=FALSE,cache=TRUE,fig.asp=0.7---------------
## load data
data(exp3_OHT_ESR1)

## create MSnSet object
MSnset_data1 <- convertToMSnset(exp3_OHT_ESR1$intensities_qPLEX1,
                                metadata=exp3_OHT_ESR1$metadata_qPLEX1,
                                indExpData=c(7:16),Sequences=2,Accessions=6)
pData(MSnset_data1)$Run <- 1
MSnset_data2 <- convertToMSnset(exp3_OHT_ESR1$intensities_qPLEX2,
                                metadata=exp3_OHT_ESR1$metadata_qPLEX2,
                                indExpData=c(7:16),Sequences=2,Accessions=6)
pData(MSnset_data2)$Run <- 2
MSnset_data3 <- convertToMSnset(exp3_OHT_ESR1$intensities_qPLEX3,
                                metadata=exp3_OHT_ESR1$metadata_qPLEX3,
                                indExpData=c(7:16),Sequences=2,Accessions=6)
pData(MSnset_data3)$Run <- 3

## Summation of peptide to protein intensity
MSnset_P1 <- summarizeIntensities(MSnset_data1, sum, human_anno)
MSnset_P2 <- summarizeIntensities(MSnset_data2, sum, human_anno)
MSnset_P3 <- summarizeIntensities(MSnset_data3, sum, human_anno)

## Normalization
MSnset_P1 <- rowScaling(MSnset_P1,mean)
MSnset_P2 <- rowScaling(MSnset_P2,mean)
MSnset_P3 <- rowScaling(MSnset_P3,mean)

###### Compute common unique peptides
features1 <- fData(MSnset_data1)
features1 <- as.data.frame(features1[, c("Sequences", 
                                       "Accessions")],
                           stringsAsFactors = FALSE)
features2 <- fData(MSnset_data2)
features2 <- as.data.frame(features2[, c("Sequences", 
                                         "Accessions")],
                           stringsAsFactors = FALSE)
features3 <- fData(MSnset_data3)
features3 <- as.data.frame(features3[, c("Sequences", 
                                         "Accessions")],
                           stringsAsFactors = FALSE)
features <- rbind(features1,features2,features3)
features <- unique(features)
features$Sequences <- as.character(features$Sequences)
features$Accessions <- as.character(features$Accessions)
counts <- features %>% count(Accessions)
colnames(counts)[2] <- "Count"

##### create combine MSnSet object

MSnset_P1 <- updateFvarLabels(MSnset_P1)
MSnset_P2 <- updateFvarLabels(MSnset_P2)
MSnset_P3 <- updateFvarLabels(MSnset_P3)

MSnset_P1 <- updateSampleNames(MSnset_P1)
MSnset_P2 <- updateSampleNames(MSnset_P2)
MSnset_P3 <- updateSampleNames(MSnset_P3)

suppressWarnings(MSnset_comb <- combine(MSnset_P1, MSnset_P2, MSnset_P3))
tokeep <- which(complete.cases(fData(MSnset_comb))==TRUE)
MSnset_comb <- MSnset_comb[tokeep,]
sampleNames(MSnset_comb) <- pData(MSnset_comb)$SampleName

pData(MSnset_comb)$BioRep <- c(rep(1,4),rep(2,4),c(1,2),rep(3,4),rep(4,4),c(3,4),
                           rep(5,4),rep(6,4),c(5,6))
fData(MSnset_comb) <- fData(MSnset_comb)[,c(1:4)]
colnames(fData(MSnset_comb)) <- c("Accessions","Gene","Description",
                                            "GeneSymbol")
ind <- match(fData(MSnset_comb)$Accessions, counts$Accessions)
fData(MSnset_comb)$Count <- counts$Count[ind]

### create separate MSnSet for IgG comparision
pheno <- pData(MSnset_comb)
pheno$SampleGroup <- c(rep(c(rep("Exp",8),rep("IgG",2)),3))
pheno$SampleGroup <- factor(pheno$SampleGroup)
MSnset_IgG <- MSnset_comb
pData(MSnset_IgG) <- pheno

### Differential analysis to find ER specific interactors
contrasts <- c(
  Exp_vs_IgG = "Exp - IgG"
)

diffstats <- computeDiffStats(MSnSetObj=MSnset_IgG, contrasts=contrasts, 
                              transform = FALSE)
results <- getContrastResults(diffstats=diffstats, contrast=contrasts, 
                              transform = FALSE)

### create subset of protein filtering non-specific IgG
ind <- which(results$adj.P.Val < 0.01 & results$log2FC > 1)
diff_IgG <- results[ind,]
ind <- match(diff_IgG$Accessions, fData(MSnset_comb)$Accessions)
MSnset_subset <- MSnset_comb[ind]
IgG_ind <- which(pData(MSnset_subset)$SampleGroup == "IgG")

### perform regression analysis on dataset
MSnset_reg <- regressIntensity(MSnset_subset, controlInd=IgG_ind, ProteinId="P03372")

### Differential analysis
contrasts <- c(
  tam.2h_vs_vehicle = "tam.2h - vehicle",
  tam.6h_vs_vehicle = "tam.6h - vehicle",
  tam.24h_vs_vehicle = "tam.24h - vehicle"
)

suppressWarnings(diffstats <- computeDiffStats(MSnSetObj=MSnset_reg, contrasts=contrasts, 
                              transform = FALSE))

diffexp1 <- getContrastResults(diffstats=diffstats, contrast=contrasts[1], 
                              transform = FALSE)
diffexp1 <- diffexp1[which(diffexp1$adj.P.Val < 0.05 & abs(diffexp1$log2FC) > 0.5),]
diffexp2 <- getContrastResults(diffstats=diffstats, contrast=contrasts[2], 
                              transform = FALSE)
diffexp2 <- diffexp2[which(diffexp2$adj.P.Val < 0.05 & abs(diffexp2$log2FC) > 0.5),]
diffexp3 <- getContrastResults(diffstats=diffstats, contrast=contrasts[3], 
                              transform = FALSE)
diffexp3 <- diffexp3[which(diffexp3$adj.P.Val < 0.05 & abs(diffexp3$log2FC) > 0.5),]

## ----exp4_OHT_FP,message=FALSE,cache=TRUE-----------------------------
## load data
data(exp4_OHT_FP)

## create MSnSet object
MSnset_data1 <- convertToMSnset(exp4_OHT_FP$FP_1,
                                metadata=exp4_OHT_FP$metadata_FP1,
                                indExpData=c(7:14),Sequences=2,Accessions=6)
pData(MSnset_data1)$Run <- 1
MSnset_data2 <- convertToMSnset(exp4_OHT_FP$FP_2,
                                metadata=exp4_OHT_FP$metadata_FP2,
                                indExpData=c(7:14),Sequences=2,Accessions=6)
pData(MSnset_data2)$Run <- 2

## Summation of peptide to protein intensity
MSnset_P1 <- summarizeIntensities(MSnset_data1, sum, human_anno)
MSnset_P2 <- summarizeIntensities(MSnset_data2, sum, human_anno)


### Computing common unique peptides 
features1 <- fData(MSnset_data1)
features1 <- as.data.frame(features1[, c("Sequences","Accessions")],
                           stringsAsFactors = FALSE)
features2 <- fData(MSnset_data2)
features2 <- as.data.frame(features2[, c("Sequences","Accessions")],
                           stringsAsFactors = FALSE)
features <- rbind(features1,features2)
features <- unique(features)
features$Sequences <- as.character(features$Sequences)
features$Accessions <- as.character(features$Accessions)
counts <- features %>% count(Accessions) 
colnames(counts)[2] <- "Count"

##### create combine MSnSet object

MSnset_P1 <- updateFvarLabels(MSnset_P1)
MSnset_P2 <- updateFvarLabels(MSnset_P2)
MSnset_P1 <- updateSampleNames(MSnset_P1)
MSnset_P2 <- updateSampleNames(MSnset_P2)

suppressWarnings(MSnset_comb <- combine(MSnset_P1, MSnset_P2))
tokeep <- which(complete.cases(fData(MSnset_comb))==TRUE)
MSnset_comb <- MSnset_comb[tokeep,]
sampleNames(MSnset_comb) <- pData(MSnset_comb)$SampleName
fData(MSnset_comb) <- fData(MSnset_comb)[,c(1:4)]
colnames(fData(MSnset_comb)) <- c("Accessions","Gene","Description",
                                            "GeneSymbol")
ind <- match(fData(MSnset_comb)$Accessions,counts$Accessions)
fData(MSnset_comb)$Count <- counts$Count[ind]

## Normalization
MSnset_Pnorm <- normalizeScaling(MSnset_comb, median)

## Differential analysis
contrasts <- c(
  tam.2h_vs_vehicle = "tam.2h - vehicle",
  tam.6h_vs_vehicle = "tam.6h - vehicle",
  tam.24h_vs_vehicle = "tam.24h - vehicle"
)
batchEffect <- c("Run", "BioRep")

diffstats <- computeDiffStats(MSnset_Pnorm, contrasts=contrasts, 
                              batchEffect=batchEffect)

diffexp1 <- getContrastResults(diffstats=diffstats, contrast=contrasts[1])
diffexp1 <- diffexp1[which(diffexp1$adj.P.Val < 0.05 & abs(diffexp1$log2FC) > 0.5),]
diffexp2 <- getContrastResults(diffstats=diffstats, contrast=contrasts[2])
diffexp2 <- diffexp2[which(diffexp2$adj.P.Val < 0.05 & abs(diffexp2$log2FC) > 0.5),]
diffexp3 <- getContrastResults(diffstats=diffstats, contrast=contrasts[3])
diffexp3 <- diffexp3[which(diffexp3$adj.P.Val < 0.05 & abs(diffexp3$log2FC) > 0.5),]

## ----exp5_PDX,message=FALSE,cache=TRUE--------------------------------
## load data
data(exp5_PDX)

## create MSnSet object
MSnset_data <- convertToMSnset(exp5_PDX$intensities, metadata=exp5_PDX$metadata,
                               indExpData=c(7:16), Sequences=2,Accessions=6)

## Exclude outlier and techical replicate samples
MSnset_data <- MSnset_data[,-c(7:10)]

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median)

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(PDX_vs_IgG = "PDX - IgG")

diffstats <- computeDiffStats(MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts)
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.05 & diffexp$log2FC > 1),]

## ----exp6_ER,message=FALSE,cache=TRUE---------------------------------
## load data
data(exp6_ER)

## create MSnSet object
MSnset_data <- convertToMSnset(exp6_ER$intensities, metadata=exp6_ER$metadata,
                               indExpData=c(6:15), Sequences=2, Accessions=5, 
                               rmMissing=FALSE)
exprs(MSnset_data)[is.na(exprs(MSnset_data))] <- 0
exprs(MSnset_data) <- exprs(MSnset_data)+0.01

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median, groupingColumn="SampleGroup")

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(ER_vs_IgG = "ER - IgG")
diffstats <- computeDiffStats(MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts)
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.01 & diffexp$log2FC >1),]

## ----exp7_NCOA3,message=FALSE,cache=TRUE------------------------------
## load data
data(exp7_NCOA3)

## create MSnSet object
MSnset_data <- convertToMSnset(exp7_NCOA3$intensities, metadata=exp7_NCOA3$metadata,
                               indExpData=c(7:16), Sequences=2, Accessions=6, 
                               rmMissing=FALSE)
exprs(MSnset_data)[is.na(exprs(MSnset_data))] <- 0
exprs(MSnset_data) <- exprs(MSnset_data)+0.01

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median, groupingColumn="SampleGroup")

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(NCOA3_vs_IgG = "NCOA3 - IgG")
diffstats <- computeDiffStats(MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts)
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.01 & diffexp$log2FC >1),]

## ----exp8_CBP,message=FALSE,cache=TRUE--------------------------------
## load data
data(exp8_CBP)

## create MSnSet object
MSnset_data <- convertToMSnset(exp8_CBP$intensities, metadata=exp8_CBP$metadata,
                               indExpData=c(7:16), Sequences=2, Accessions=6, 
                               rmMissing=FALSE)
exprs(MSnset_data)[is.na(exprs(MSnset_data))] <- 0
exprs(MSnset_data) <- exprs(MSnset_data)+0.01

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median, groupingColumn="SampleGroup")

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(CREBBP_vs_IgG = "CREBBP - IgG")
diffstats <- computeDiffStats(MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts)
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.01 & diffexp$log2FC >1),]

## ----exp9_PolII,message=FALSE,cache=TRUE------------------------------
## load data
data(exp9_PolII)

## create MSnSet object
MSnset_data <- convertToMSnset(exp9_PolII$intensities, metadata=exp9_PolII$metadata,
                               indExpData=c(7:16), Sequences=2, Accessions=6, 
                               rmMissing=FALSE)
exprs(MSnset_data)[is.na(exprs(MSnset_data))] <- 0
exprs(MSnset_data) <- exprs(MSnset_data)+0.01

## Normalization
MSnset_norm <- groupScaling(MSnset_data, median, groupingColumn="SampleGroup")

## Summation of peptide to protein intensity
MSnset_Pnorm <- summarizeIntensities(MSnset_norm, sum, human_anno)

## Differential analysis
contrasts <- c(POLR2A_vs_IgG = "POLR2A - IgG")
diffstats <- computeDiffStats(MSnset_Pnorm, contrasts=contrasts)
diffexp <- getContrastResults(diffstats=diffstats, contrast=contrasts)
diffexp <- diffexp[which(diffexp$adj.P.Val < 0.01 & diffexp$log2FC >1),]

## ----info,echo=TRUE---------------------------------------------------
sessionInfo()

