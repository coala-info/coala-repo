# Code example from 'TCC' vignette. See references/ for full tutorial.

### R code from vignette source 'TCC.Rnw'

###################################################
### code chunk number 1: 3408021901
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 3, FDR = 0.1, floorPDEG = 0.05)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
result <- getResult(tcc, sort = TRUE)
head(result)


###################################################
### code chunk number 2: 4378919285
###################################################
library(TCC)
data(hypoData)
head(hypoData)
dim(hypoData)
group <- c(1, 1, 1, 2, 2, 2)


###################################################
### code chunk number 3: 1209835923
###################################################
group <- c(1, 1, 1, 1, 2, 2, 2, 2, 2)


###################################################
### code chunk number 4: 4389570100
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc


###################################################
### code chunk number 5: 5048219812
###################################################
head(tcc$count)
tcc$group


###################################################
### code chunk number 6: 4085249378
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- filterLowCountGenes(tcc)
dim(tcc$count)


###################################################
### code chunk number 7: filter_low_count_genes
###################################################
filter <- as.logical(rowSums(hypoData) > 0)
dim(hypoData[filter, ])
tcc <- new("TCC", hypoData[filter, ], group)
dim(tcc$count)


###################################################
### code chunk number 8: degesEdger_tcc
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 1, FDR = 0.1, floorPDEG = 0.05)
tcc$norm.factors
tcc$DEGES$execution.time


###################################################
### code chunk number 9: degesEdger_edger
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
FDR <- 0.1
floorPDEG <- 0.05
d <- DGEList(counts = hypoData, group = group)
### STEP 1 ###
d <- calcNormFactors(d)
### STEP 2 ###
design <- model.matrix(~group)
d <- estimateDisp(d, design)
fit <- glmQLFit(d, design)
out <- glmQLFTest(fit, coef = 2)
pval <- out$table$PValue
qval <- p.adjust(pval, method = "BH")
if (sum(qval < FDR) > (floorPDEG * nrow(hypoData))) {
  is.DEG <- as.logical(qval < FDR)
} else {
  is.DEG <- as.logical(rank(pval, ties.method = "min") <=
                       nrow(hypoData) * floorPDEG)
}
### STEP 3 ###
d <- DGEList(counts = hypoData[!is.DEG, ], group = group)
d <- calcNormFactors(d)
norm.factors <- d$samples$norm.factors * colSums(hypoData[!is.DEG, ]) /
                  colSums(hypoData)
norm.factors <- norm.factors / mean(norm.factors)
norm.factors


###################################################
### code chunk number 10: idegesEdger_tcc
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 3, FDR = 0.1, floorPDEG = 0.05)
tcc$norm.factors
tcc$DEGES$execution.time


###################################################
### code chunk number 11: 4390811048
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "deseq2", test.method = "deseq2",
                       iteration = 1, FDR = 0.1, floorPDEG = 0.05)
tcc$norm.factors
tcc$DEGES$execution.time


###################################################
### code chunk number 12: 0869034832
###################################################
library(TCC)
data(hypoData)
FDR <- 0.1
floorPDEG <- 0.05
group <- factor(c(1, 1, 1, 2, 2, 2))
cl <- data.frame(group = group)
design <- formula(~ group)
dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
                              design = design)
### STEP 1 ###
dds <- estimateSizeFactors(dds)
sizeFactors(dds) <- sizeFactors(dds) / mean(sizeFactors(dds))

### STEP 2 ###
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)
result <- results(dds)
result$pvalue[is.na(result$pvalue)] <- 1
pval <- result$pvalue
qval <- p.adjust(pval, method = "BH")
if (sum(qval < FDR) > (floorPDEG * nrow(hypoData))) {
  is.DEG <- as.logical(qval < FDR)
} else {
  is.DEG <- as.logical(rank(pval, ties.method = "min") <=
                       nrow(hypoData) * floorPDEG)
}
### STEP 3 ###
dds <- DESeqDataSetFromMatrix(countData = hypoData[!is.DEG, ], colData = cl,
                              design = design)
dds <- estimateSizeFactors(dds)
norm.factors <- sizeFactors(dds) / colSums(hypoData)
norm.factors <- norm.factors / mean(norm.factors)
norm.factors


###################################################
### code chunk number 13: 9347533928
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
head(hypoData)


###################################################
### code chunk number 14: 2394782901
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
group <- c(1, 1, 1, 2, 2, 2)
pair <- c(1, 2, 3, 1, 2, 3)
cl <- data.frame(group = group, pair = pair)
tcc <- new("TCC", hypoData, cl)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 1, FDR = 0.1, floorPDEG = 0.05, paired = TRUE)
tcc$norm.factors


###################################################
### code chunk number 15: 8939487592
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
group <- factor(c(1, 1, 1, 2, 2, 2))
pair <- factor(c(1, 2, 3, 1, 2, 3))
design <- model.matrix(~ group + pair)
coef <- 2
FDR <- 0.1
floorPDEG <- 0.05
d <- DGEList(counts = hypoData, group = group)
### STEP 1 ###
d <- calcNormFactors(d)
### STEP 2 ###
d <- estimateDisp(d, design)
fit <- glmQLFit(d, design)
out <- glmQLFTest(fit, coef = coef)
pval <- out$table$PValue
qval <- p.adjust(pval, method = "BH")
if (sum(qval < FDR) > (floorPDEG * nrow(hypoData))){
  is.DEG <- as.logical(qval < FDR)
} else {
  is.DEG <- as.logical(rank(pval, ties.method = "min") <=
                       nrow(hypoData) * floorPDEG)
}
### STEP 3 ###
d <- DGEList(counts = hypoData[!is.DEG, ], group = group)
d <- calcNormFactors(d)
norm.factors <- d$samples$norm.factors * colSums(hypoData[!is.DEG, ]) /
colSums(hypoData)
norm.factors <- norm.factors / mean(norm.factors)
norm.factors


###################################################
### code chunk number 16: load_hypoData_mg
###################################################
library(TCC)
data(hypoData_mg)
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group)
tcc
dim(tcc$count)


###################################################
### code chunk number 17: degesEdger_multigroup_tcc
###################################################
library(TCC)
data(hypoData_mg)
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group)
design <- model.matrix(~ as.factor(group))
coef <- 2:length(unique(group))


###################################################
### code chunk number 18: degesEdger_multigroup_tcc_nf
###################################################
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 1, design = design, coef = coef)
tcc$norm.factors


###################################################
### code chunk number 19: 3498028981
###################################################
library(TCC)
data(hypoData_mg)
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 1)
tcc$norm.factors


###################################################
### code chunk number 20: degesEdger_multigroup_edger
###################################################
library(TCC)
data(hypoData_mg)
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group)
FDR <- 0.1
floorPDEG <- 0.05
design <- model.matrix(~ as.factor(group))
coef <- 2:ncol(design)
d <- DGEList(counts = hypoData_mg, group = group)
### STEP 1 ###
d <- calcNormFactors(d)
### STEP 2 ###
d <- estimateDisp(d, design)
fit <- glmQLFit(d, design)
out <- glmQLFTest(fit, coef = coef)
result <- as.data.frame(topTags(out, n = nrow(hypoData_mg)))
result <- result$table[rownames(hypoData_mg), ]
pval <- out$table$PValue
qval <- p.adjust(pval, method = "BH")
if (sum(qval < FDR) > (floorPDEG * nrow(hypoData_mg))) {
  is.DEG <- as.logical(qval < FDR)
} else  {
  is.DEG <- as.logical(rank(pval, ties.method = "min") <=
                       nrow(hypoData_mg) * floorPDEG)
}
### STEP 3 ###
d <- DGEList(counts = hypoData_mg[!is.DEG, ], group = group)
d <- calcNormFactors(d)
norm.factors <- d$samples$norm.factors * colSums(hypoData_mg[!is.DEG, ]) /
                colSums(hypoData_mg)
norm.factors <- norm.factors / mean(norm.factors)
norm.factors


###################################################
### code chunk number 21: hypoData_deg_label
###################################################
library(TCC)
data(hypoData)
nonDEG <- 201:1000
summary(hypoData[nonDEG, ])


###################################################
### code chunk number 22: calc_median_of_nondeg_hypoData
###################################################
apply(hypoData[nonDEG, ], 2, median)


###################################################
### code chunk number 23: calc_median_of_nondeg_hypoData_hide
###################################################
hypoData.median <- apply(hypoData[nonDEG, ], 2, median)
hypoData.14.median <- apply(hypoData[nonDEG, c(1, 4)], 2, median)


###################################################
### code chunk number 24: get_normalized_data
###################################################
normalized.count <- getNormalizedData(tcc)


###################################################
### code chunk number 25: degesEdger_tcc_normed_data
###################################################
library(TCC)
data(hypoData)  
nonDEG <- 201:1000
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 1, FDR = 0.1, floorPDEG = 0.05)
normalized.count <- getNormalizedData(tcc)
apply(normalized.count[nonDEG, ], 2, median)
range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 26: 4390011292
###################################################
buff_1 <- range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 27: 2391104042
###################################################
library(TCC)
data(hypoData)
nonDEG <- 201:1000
group <- c(1, 1, 1, 2, 2, 2)
d <- DGEList(count = hypoData, group = group)
d <- calcNormFactors(d)
norm.factors <- d$samples$norm.factors
effective.libsizes <- colSums(hypoData) * norm.factors
normalized.count <- sweep(hypoData, 2,
                    mean(effective.libsizes) / effective.libsizes, "*")
apply(normalized.count[nonDEG, ], 2, median)
range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 28: 4330011292
###################################################
buff_2 <- range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 29: 5647309237
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
nonDEG <- 201:1000
group <- c(1, 1, 1, 2, 2, 2)
pair <- c(1, 2, 3, 1, 2, 3)
cl <- data.frame(group = group, pair = pair)
tcc <- new("TCC", hypoData, cl)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 1, FDR = 0.1, floorPDEG = 0.05, paired = TRUE)
normalized.count <- getNormalizedData(tcc)
head(normalized.count, n = 4)
apply(normalized.count[nonDEG, ], 2, median)
range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 30: 1674110292
###################################################
buff_1 <- range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 31: 4387803948
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
nonDEG <- 201:1000
group <- factor(c(1, 1, 1, 2, 2, 2))
d <- DGEList(counts = hypoData, group = group)
d <- calcNormFactors(d)
norm.factors <- d$samples$norm.factors
effective.libsizes <- colSums(hypoData) * norm.factors
normalized.count <- sweep(hypoData, 2,
                          mean(effective.libsizes) / effective.libsizes, "*")
apply(normalized.count[nonDEG, ], 2, median)
range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 32: 1674110992
###################################################
buff_2 <- range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 33: hypoData_mg_deg_label
###################################################
library(TCC)
data(hypoData_mg)
nonDEG <- 201:1000
summary(hypoData_mg[nonDEG, ])


###################################################
### code chunk number 34: calc_median_of_nondeg_hypoData_mg
###################################################
apply(hypoData_mg[nonDEG, ], 2, median)


###################################################
### code chunk number 35: NormHypoDataMultiGGet
###################################################
hypoData_mg.median <- apply(hypoData_mg[nonDEG, ], 2, median)


###################################################
### code chunk number 36: degesEdger_tcc_multigroup_normed_data
###################################################
library(TCC)
data(hypoData_mg)
nonDEG <- 201:1000
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group)
design <- model.matrix(~ as.factor(group))
coef <- 2:length(unique(group))
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 3)
normalized.count <- getNormalizedData(tcc)
apply(normalized.count[nonDEG, ], 2, median)
range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 37: degesEdger_tcc_multigroup_normed_data_hdie
###################################################
normByiDEGES <- range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 38: tmm_tcc_multigroup_normed_data
###################################################
library(TCC)
data(hypoData_mg)
nonDEG <- 201:1000
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
d <- DGEList(tcc$count, group = group)
d <- calcNormFactors(d)
norm.factors <- d$samples$norm.factors
effective.libsizes <- colSums(hypoData) * norm.factors
normalized.count <- sweep(hypoData, 2,
                    mean(effective.libsizes) / effective.libsizes, "*")
apply(normalized.count[nonDEG, ], 2, median)
range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 39: tmm_tcc_multigroup_normed_data_hide
###################################################
normByTMM <- range(apply(normalized.count[nonDEG, ], 2, median))


###################################################
### code chunk number 40: idegesEdger_tcc
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 3, FDR = 0.1, floorPDEG = 0.05)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)


###################################################
### code chunk number 41: get_estimated_results
###################################################
result <- getResult(tcc, sort = TRUE)
head(result)


###################################################
### code chunk number 42: summary_of_estimated_deg
###################################################
table(tcc$estimatedDEG) 


###################################################
### code chunk number 43: maplot_of_estimated_result
###################################################
plot(tcc)


###################################################
### code chunk number 44: 3498757592
###################################################
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))


###################################################
### code chunk number 45: 5901287562
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
design <- model.matrix(~ as.factor(group))
d <- DGEList(count = hypoData, group = group)
d <- calcNormFactors(d)
d <- estimateDisp(d, design)
fit <- glmQLFit(d, design)
out <- glmQLFTest(fit, coef = 2)
result <- as.data.frame(topTags(out, n = nrow(hypoData), sort.by = "PValue"))
head(result)


###################################################
### code chunk number 46: 1027518347
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "tmm", iteration = 0)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
result <- getResult(tcc, sort = TRUE)
head(result)
AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))


###################################################
### code chunk number 47: 5029042481
###################################################
result <- getResult(tcc, sort = TRUE)
head(result)


###################################################
### code chunk number 48: 7512913498
###################################################
table(tcc$estimatedDEG)


###################################################
### code chunk number 49: 7512013498
###################################################
tb <- table(tcc$estimatedDEG)


###################################################
### code chunk number 50: 3489400103
###################################################
plot(tcc)


###################################################
### code chunk number 51: 4012399910
###################################################
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))


###################################################
### code chunk number 52: 4930011190
###################################################
library(TCC)
data(hypoData)
group <- factor(c(1, 1, 1, 2, 2, 2))
cl <- data.frame(group = group)
design <- formula(~ group)
dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
                              design = design)
dds <- estimateSizeFactors(dds)
sizeFactors(dds) <- sizeFactors(dds) / mean(sizeFactors(dds))
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)
result <- results(dds)
head(result[order(result$pvalue),])
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
result$pvalue[is.na(result$pvalue)] <- 1
AUC(rocdemo.sca(truth = truth, data = -rank(result$pvalue)))


###################################################
### code chunk number 53: 4390023901
###################################################
library(TCC)
data(hypoData)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
tcc <- calcNormFactors(tcc, norm.method = "deseq2", iteration = 0)
tcc <- estimateDE(tcc, test.method = "deseq2", FDR = 0.1)
result <- getResult(tcc, sort = TRUE)
head(result)
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))
tcc$norm.factors


###################################################
### code chunk number 54: 4090911011
###################################################
buff_1 <- AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))


###################################################
### code chunk number 55: 0309001992
###################################################
library(TCC)
data(hypoData)
group <- factor(c(1, 1, 1, 2, 2, 2))
cl <- data.frame(group = group)
design <- formula(~ group)
dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
                              design = design)
dds <- estimateSizeFactors(dds)
size.factors <- sizeFactors(dds)
size.factors
hoge <- size.factors / colSums(hypoData)
norm.factors <- hoge / mean(hoge)
norm.factors
ef.libsizes <- norm.factors * colSums(hypoData)
ef.libsizes


###################################################
### code chunk number 56: 4328593702
###################################################
library(TCC)
data(hypoData)
group <- factor(c(1, 1, 1, 2, 2, 2))
cl <- data.frame(group = group)
design <- formula(~ group)
dds <- DESeqDataSetFromMatrix(countData = hypoData, colData = cl,
                              design = design)
dds <- estimateSizeFactors(dds)
sizeFactors(dds) <- sizeFactors(dds) / mean(sizeFactors(dds))
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)
result <- results(dds)
head(result[order(result$pvalue),])
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
result$pvalue[is.na(result$pvalue)] <- 1
AUC(rocdemo.sca(truth = truth, data = -rank(result$pvalue)))


###################################################
### code chunk number 57: 0285012872
###################################################
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
head(hypoData)


###################################################
### code chunk number 58: 4891209302
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
group <- c(1, 1, 1, 2, 2, 2)
pair <- c(1, 2, 3, 1, 2, 3)
cl <- data.frame(group = group, pair = pair)
tcc <- new("TCC", hypoData, cl)
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 3, FDR = 0.1, floorPDEG = 0.05, paired = TRUE)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1, paired = TRUE)


###################################################
### code chunk number 59: 4390911012
###################################################
result <- getResult(tcc, sort = TRUE)
head(result)


###################################################
### code chunk number 60: 3909884931
###################################################
table(tcc$estimatedDEG)


###################################################
### code chunk number 61: 3934884932
###################################################
tb <- table(tcc$estimatedDEG)


###################################################
### code chunk number 62: 3482340103
###################################################
plot(tcc)


###################################################
### code chunk number 63: 3490930192
###################################################
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))


###################################################
### code chunk number 64: 8402288128
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
group <- factor(c(1, 1, 1, 2, 2, 2))
pair <- factor(c(1, 2, 3, 1, 2, 3))
design <- model.matrix(~ group + pair)
coef <- 2
d <- DGEList(counts = hypoData, group = group)
d <- calcNormFactors(d)
d <- estimateDisp(d, design)
fit <- glmQLFit(d, design)
out <- glmQLFTest(fit, coef=2)

topTags(out, n = 6)
p.value <- out$table$PValue
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
AUC(rocdemo.sca(truth = truth, data = -rank(p.value)))


###################################################
### code chunk number 65: 4209576561
###################################################
library(TCC)
data(hypoData)
colnames(hypoData) <- c("T_dogA", "T_dogB", "T_dogC",
                        "N_dogA", "N_dogB", "N_dogC")
group <- c(1, 1, 1, 2, 2, 2)
pair <- c(1, 2, 3, 1, 2, 3)
cl <- data.frame(group = group, pair = pair)
tcc <- new("TCC", hypoData, cl)
tcc <- calcNormFactors(tcc, norm.method = "tmm", iteration = 0, paired = TRUE)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1, paired = TRUE)
result <- getResult(tcc, sort = TRUE)
head(result)
library(ROC)
truth <- c(rep(1, 200), rep(0, 800))
AUC(rocdemo.sca(truth = truth, data = -tcc$stat$rank))


###################################################
### code chunk number 66: degerTbt_tcc_edger_multigroup_summary
###################################################
library(TCC)
data(hypoData_mg)
group <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group)
###  Normalization  ###
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 1)
###  DE analysis  ###
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
result <- getResult(tcc, sort = TRUE)
head(result)
table(tcc$estimatedDEG)


###################################################
### code chunk number 67: generate_simulation_count_data
###################################################
set.seed(1000)
library(TCC)
tcc <- simulateReadCounts(Ngene = 1000, PDEG = 0.2, 
                              DEG.assign = c(0.9, 0.1),
                              DEG.foldchange = c(4, 4), 
                              replicates = c(3, 3))
dim(tcc$count)
head(tcc$count)
tcc$group


###################################################
### code chunk number 68: str_of_simulation_field
###################################################
str(tcc$simulation)


###################################################
### code chunk number 69: tale_of_simulation_trueDEG
###################################################
table(tcc$simulation$trueDEG)


###################################################
### code chunk number 70: analysis_simulation_data
###################################################
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 1, FDR = 0.1, floorPDEG = 0.05)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
result <- getResult(tcc, sort = TRUE)
head(result)


###################################################
### code chunk number 71: calc_AUC_of_simulation_data
###################################################
calcAUCValue(tcc)


###################################################
### code chunk number 72: calc_AUC_of_simulation_data_hide
###################################################
auc.degesedger <- calcAUCValue(tcc)


###################################################
### code chunk number 73: calc_AUC_of_simulation_data_ROC
###################################################
AUC(rocdemo.sca(truth = as.numeric(tcc$simulation$trueDEG != 0),
                data = -tcc$stat$rank))


###################################################
### code chunk number 74: calc_AUC_of_tmm_tcc
###################################################
tcc <- calcNormFactors(tcc, norm.method = "tmm", iteration = 0)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
calcAUCValue(tcc)


###################################################
### code chunk number 75: calc_AUC_of_tmm_org
###################################################
design <- model.matrix(~ as.factor(tcc$group$group))
d <- DGEList(counts = tcc$count, group = tcc$group$group)
d <- calcNormFactors(d)
d$samples$norm.factors <- d$samples$norm.factors / 
                          mean(d$samples$norm.factors)
d <- estimateDisp(d, design)
fit <- glmQLFit(d, design)
result <- glmQLFTest(fit, coef = 2)
result$table$PValue[is.na(result$table$PValue)] <- 1
AUC(rocdemo.sca(truth = as.numeric(tcc$simulation$trueDEG != 0),
                data = -rank(result$table$PValue)))


###################################################
### code chunk number 76: generate_simulation_data_multigroup
###################################################
set.seed(1000)
library(TCC)
tcc <- simulateReadCounts(Ngene = 1000, PDEG = 0.3,
                         DEG.assign = c(0.7, 0.2, 0.1),
                         DEG.foldchange = c(3, 10, 6),
                         replicates = c(2, 4, 3))
dim(tcc$count)
tcc$group
head(tcc$count)


###################################################
### code chunk number 77: plot_fc_pseudocolor_multigroup
###################################################
plotFCPseudocolor(tcc)


###################################################
### code chunk number 78: degesEdger_edger_tcc_multigroup
###################################################
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 1)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
calcAUCValue(tcc)


###################################################
### code chunk number 79: tmm_edger_tcc_multigroup
###################################################
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger",
                       iteration = 0)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)
calcAUCValue(tcc)


###################################################
### code chunk number 80: plot_fc_pseudocolor_multigroup_2
###################################################
set.seed(1000)
library(TCC)
tcc <- simulateReadCounts(Ngene = 10000, PDEG = 0.34,
               DEG.assign = c(0.1, 0.3, 0.05, 0.1, 0.05, 0.21, 0.09, 0.1),
               DEG.foldchange = c(3.1, 13, 2, 1.5, 9, 5.6, 4, 2),
               replicates = c(1, 1, 2, 1, 1, 1, 1, 1))
dim(tcc$count)
tcc$group
head(tcc$count)
plotFCPseudocolor(tcc)


###################################################
### code chunk number 81: generate_simulation_data_multifactor_group
###################################################
group <- data.frame(
    GROUP = c("WT", "WT", "WT", "WT", "KO", "KO", "KO", "KO"),
    TIME = c("1d", "1d", "2d", "2d", "1d", "1d", "2d", "2d")
)


###################################################
### code chunk number 82: generate_simulation_data_multifactor_fc
###################################################
DEG.foldchange <- data.frame(
    FACTOR1.1 = c(2, 2, 2, 2, 1, 1, 1, 1),
    FACTOR1.2 = c(1, 1, 1, 1, 3, 3, 3, 3),
    FACTOR2 = c(1, 1, 0.5, 0.5, 1, 1, 4, 4)
)


###################################################
### code chunk number 83: generate_simulation_data_multifactor
###################################################
set.seed(1000)
tcc <- simulateReadCounts(Ngene = 10000, PDEG = 0.2,
               DEG.assign = c(0.5, 0.2, 0.3),
               DEG.foldchange = DEG.foldchange,
               group = group)


###################################################
### code chunk number 84: plot_fc_pseudocolor_multifactor
###################################################
head(tcc$count)
tcc$group
plotFCPseudocolor(tcc)


###################################################
### code chunk number 85: simulate_data_1000
###################################################
set.seed(1000)
library(TCC)
tcc <- simulateReadCounts(Ngene = 20000, PDEG = 0.30, 
               DEG.assign = c(0.85, 0.15),
               DEG.foldchange = c(8, 16), 
               replicates = c(2, 2))
head(tcc$count)


###################################################
### code chunk number 86: maplot_simulate_data_1000
###################################################
plot(tcc)


###################################################
### code chunk number 87: norm_simulate_data_1000
###################################################
normalized.count <- getNormalizedData(tcc)
colSums(normalized.count)
colSums(tcc$count)
mean(colSums(tcc$count))


###################################################
### code chunk number 88: maplot_normed_simulate_data_1000_hide
###################################################
xy <- plot(tcc)
isnot.na <- as.logical(xy[, 1] != min(xy[, 1]))
upG1 <- as.numeric(xy$m.value < 0)
upG2 <- as.numeric(xy$m.value > 0)
median.G1 <- median(xy[((tcc$simulation$trueDEG == 1) & isnot.na) & upG1, 2])
median.G2 <- median(xy[((tcc$simulation$trueDEG == 1) & isnot.na) & upG2, 2])
median.nonDEG <- median(xy[(tcc$simulation$trueDEG == 0) & isnot.na, 2])


###################################################
### code chunk number 89: maplot_normed_simulate_data_1000
###################################################
plot(tcc, median.lines = TRUE) 


###################################################
### code chunk number 90: maplot_normed_simulate_data_1000_2_hide
###################################################
tcc <- calcNormFactors(tcc, "tmm", "edger", iteration = 3, 
                       FDR = 0.1, floorPDEG = 0.05)
xy <- plot(tcc)
isnot.na <- as.logical(xy[, 1] != min(xy[, 1]))
median.nonDEG <- median(xy[(tcc$simulation$trueDEG == 0) & isnot.na, 2])


###################################################
### code chunk number 91: maplot_normed_simulate_data_1000_2
###################################################
tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 3, FDR = 0.1, floorPDEG = 0.05)
plot(tcc, median.line = TRUE)


###################################################
### code chunk number 92: 2390118599
###################################################
sessionInfo()


