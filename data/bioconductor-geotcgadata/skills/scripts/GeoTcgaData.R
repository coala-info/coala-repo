# Code example from 'GeoTcgaData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(GeoTcgaData)

## ----message=FALSE, warning=FALSE---------------------------------------------
# use user-defined data
df <- matrix(rnbinom(400, mu = 4, size = 10), 25, 16)
df <- as.data.frame(df)
rownames(df) <- paste0("gene", 1:25)
colnames(df) <- paste0("sample", 1:16)
group <- sample(c("group1", "group2"), 16, replace = TRUE)
result <- differential_RNA(counts = df, group = group,
    filte = FALSE, method = "Wilcoxon")
# use SummarizedExperiment object input
df <- matrix(rnbinom(400, mu = 4, size = 10), 25, 16)
rownames(df) <- paste0("gene", 1:25)
colnames(df) <- paste0("sample", 1:16)
group <- sample(c("group1", "group2"), 16, replace = TRUE)

nrows <- 200; ncols <- 20
counts <- matrix(
    runif(nrows * ncols, 1, 1e4), nrows,
    dimnames = list(paste0("cg",1:200),paste0("S",1:20))
)

colData <- S4Vectors::DataFrame(
  row.names = paste0("sample", 1:16),
  group = group
)
data <- SummarizedExperiment::SummarizedExperiment(
         assays=S4Vectors::SimpleList(counts=df),
         colData = colData)

result <- differential_RNA(counts = data, groupCol = "group",
    filte = FALSE, method = "Wilcoxon") 

## ----message=FALSE, warning=FALSE---------------------------------------------
# use user defined data
library(ChAMP)
cpgData <- matrix(runif(2000), nrow = 200, ncol = 10)
rownames(cpgData) <- paste0("cpg", seq_len(200))
colnames(cpgData) <- paste0("sample", seq_len(10))
sampleGroup <- c(rep("group1", 5), rep("group2", 5))
names(sampleGroup) <- colnames(cpgData)
cpg2gene <- data.frame(cpg = rownames(cpgData), 
    gene = rep(paste0("gene", seq_len(20)), 10))
result <- differential_methy(cpgData, sampleGroup, 
    cpg2gene = cpg2gene, normMethod = NULL)
# use SummarizedExperiment object input
library(ChAMP)
cpgData <- matrix(runif(2000), nrow = 200, ncol = 10)
rownames(cpgData) <- paste0("cpg", seq_len(200))
colnames(cpgData) <- paste0("sample", seq_len(10))
sampleGroup <- c(rep("group1", 5), rep("group2", 5))
names(sampleGroup) <- colnames(cpgData)
cpg2gene <- data.frame(cpg = rownames(cpgData), 
    gene = rep(paste0("gene", seq_len(20)), 10))
colData <- S4Vectors::DataFrame(
    row.names = colnames(cpgData),
    group = sampleGroup
)
data <- SummarizedExperiment::SummarizedExperiment(
         assays=S4Vectors::SimpleList(counts=cpgData),
         colData = colData)
result <- differential_methy(cpgData = data, 
    groupCol = "group", normMethod = NULL, 
    cpg2gene = cpg2gene)  

## ----message=FALSE, warning=FALSE---------------------------------------------
# use random data as example
aa <- matrix(sample(c(0, 1, -1), 200, replace = TRUE), 25, 8)
rownames(aa) <- paste0("gene", 1:25)
colnames(aa) <- paste0("sample", 1:8)
sampleGroup <- sample(c("A", "B"), ncol(aa), replace = TRUE)
diffCnv <- differential_CNV(aa, sampleGroup)

## ----message=FALSE, warning=FALSE---------------------------------------------
snpDf <- matrix(sample(c("AA", "Aa", "aa"), 100, replace = TRUE), 10, 10)
snpDf <- as.data.frame(snpDf)
sampleGroup <- sample(c("A", "B"), 10, replace = TRUE)
result <- SNP_QC(snpDf)

## ----message=FALSE, warning=FALSE---------------------------------------------
#' snpDf <- matrix(sample(c("mutation", NA), 100, replace = TRUE), 10, 10)
#' snpDf <- as.data.frame(snpDf)
#' sampleGroup <- sample(c("A", "B"), 10, replace = TRUE)
#' result <- differential_SNP(snpDf, sampleGroup)

## ----message=FALSE, warning=FALSE---------------------------------------------
aa <- c("MARCH1","MARC1","MARCH1","MARCH1","MARCH1")
bb <- c(2.969058399,4.722410064,8.165514853,8.24243893,8.60815086)
cc <- c(3.969058399,5.722410064,7.165514853,6.24243893,7.60815086)
file_gene_ave <- data.frame(aa=aa,bb=bb,cc=cc)
colnames(file_gene_ave) <- c("Gene", "GSM1629982", "GSM1629983")
result <- gene_ave(file_gene_ave, 1)

## -----------------------------------------------------------------------------
aa <- c("MARCH1 /// MMA","MARC1","MARCH2 /// MARCH3",
        "MARCH3 /// MARCH4","MARCH1")
bb <- c("2.969058399","4.722410064","8.165514853","8.24243893","8.60815086")
cc <- c("3.969058399","5.722410064","7.165514853","6.24243893","7.60815086")
input_file <- data.frame(aa=aa,bb=bb,cc=cc)
repAssign_result <- repAssign(input_file," /// ")
repRemove_result <- repRemove(input_file," /// ")

## ----message=FALSE, warning=FALSE---------------------------------------------
data(profile)
result <- id_conversion_TCGA(profile)

## -----------------------------------------------------------------------------
data(gene_cov)
lung_squ_count2 <- matrix(c(1,2,3,4,5,6,7,8,9),ncol=3)
rownames(lung_squ_count2) <- c("DISC1","TCOF1","SPPL3")
colnames(lung_squ_count2) <- c("sample1","sample2","sample3")
result <- countToFpkm(lung_squ_count2, keyType = "SYMBOL", 
    gene_cov = gene_cov)

## ----message=FALSE, warning=FALSE---------------------------------------------
data(gene_cov)
lung_squ_count2 <- matrix(c(0.11,0.22,0.43,0.14,0.875,
    0.66,0.77,0.18,0.29),ncol=3)
rownames(lung_squ_count2) <- c("DISC1","TCOF1","SPPL3")
colnames(lung_squ_count2) <- c("sample1","sample2","sample3")
result <- countToTpm(lung_squ_count2, keyType = "SYMBOL", 
    gene_cov = gene_cov)

## -----------------------------------------------------------------------------
sessionInfo()

