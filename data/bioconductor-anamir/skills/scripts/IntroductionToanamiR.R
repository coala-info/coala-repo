# Code example from 'IntroductionToanamiR' vignette. See references/ for full tutorial.

## ---- eval = FALSE---------------------------------------------------------
#  install.packages("BiocManager")
#  BiocManager::install("anamiR")

## --------------------------------------------------------------------------
library(anamiR)

## --------------------------------------------------------------------------
data(mrna)
data(mirna)
data(pheno.mirna)
data(pheno.mrna)

## --------------------------------------------------------------------------
mrna[1:5, 1:5]

## --------------------------------------------------------------------------
mirna[1:5, 1:5]

## --------------------------------------------------------------------------
pheno.mrna[1:3, 1:3]
pheno.mrna[28:30, 1:3]

## ---- eval = FALSE---------------------------------------------------------
#  se <- normalization(data = mirna, method = "quantile")

## --------------------------------------------------------------------------

mrna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mrna),
    colData = pheno.mrna)

mirna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mirna),
    colData = pheno.mirna)


## --------------------------------------------------------------------------
mrna_d <- differExp_discrete(se = mrna_se,
    class = "ER", method = "t.test",
    t_test.var = FALSE, log2 = FALSE,
    p_value.cutoff = 0.05,  logratio = 0.5
)

mirna_d <- differExp_discrete(se = mirna_se,
   class = "ER", method = "t.test",
   t_test.var = FALSE, log2 = FALSE,
   p_value.cutoff = 0.05,  logratio = 0.5
)

## --------------------------------------------------------------------------
nc <- ncol(mrna_d)
mrna_d[1:5, (nc-4):nc]

## --------------------------------------------------------------------------
mirna_21 <- miR_converter(data = mirna_d, remove_old = TRUE,
    original_version = 17, latest_version = 21)

## --------------------------------------------------------------------------
# Before
head(row.names(mirna_d))
# After
head(row.names(mirna_21))

## --------------------------------------------------------------------------
cor <- negative_cor(mrna_data = mrna_d, mirna_data = mirna_21,
    method = "pearson", cut.off = -0.5)

## --------------------------------------------------------------------------
head(cor)

## --------------------------------------------------------------------------
heat_vis(cor, mrna_d, mirna_21)

## --------------------------------------------------------------------------
sup <- database_support(cor_data = cor,
    org = "hsa", Sum.cutoff = 3)

## --------------------------------------------------------------------------
head(sup)

## --------------------------------------------------------------------------
path <- enrichment(data_support = sup, org = "hsa", per_time = 500)

## --------------------------------------------------------------------------
head(path)

## --------------------------------------------------------------------------
require(data.table)

aa <- system.file("extdata", "GSE19536_mrna.csv", package = "anamiR")
mrna <- fread(aa, fill = TRUE, header = TRUE)

bb <- system.file("extdata", "GSE19536_mirna.csv", package = "anamiR")
mirna <- fread(bb, fill = TRUE, header = TRUE)

cc <- system.file("extdata", "pheno_data.csv", package = "anamiR")
pheno.data <- fread(cc, fill = TRUE, header = TRUE)

## --------------------------------------------------------------------------
mirna_name <- mirna[["miRNA"]]
mrna_name <- mrna[["Gene"]]
mirna <- mirna[, -1]
mrna <- mrna[, -1]
mirna <- data.matrix(mirna)
mrna <- data.matrix(mrna)
row.names(mirna) <- mirna_name
row.names(mrna) <- mrna_name

pheno_name <- pheno.data[["Sample"]]
pheno.data <- pheno.data[, -1]
pheno.data <- as.matrix(pheno.data)
row.names(pheno.data) <- pheno_name


## --------------------------------------------------------------------------
mrna[1:5, 1:5]

## --------------------------------------------------------------------------
mirna[1:5, 1:5]

## --------------------------------------------------------------------------
pheno.data[1:5, 1]
pheno.data[94:98, 1]

## --------------------------------------------------------------------------

mrna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mrna),
    colData = pheno.data)

mirna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mirna),
    colData = pheno.data)


## ---- eval = FALSE---------------------------------------------------------
#  table <- GSEA_ana(mrna_se = mrna_se, mirna_se = mirna_se, class = "ER", pathway_num = 2)

## --------------------------------------------------------------------------
data(table_pre)

## --------------------------------------------------------------------------
names(table_pre)[1]
table_pre[[1]][1:5, 1:5]
names(table_pre)[2]
table_pre[[2]][1:5, 1:5]

## --------------------------------------------------------------------------
result <- GSEA_res(table = table_pre, pheno.data = pheno.data, class = "ER", DE_method = "limma", cor_cut = 0)

## --------------------------------------------------------------------------
names(result)[1]
result[[1]]

