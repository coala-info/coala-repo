# Code example from 'RegParallel' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------

  suppressWarnings(library(knitr))
  opts_chunk$set(tidy = FALSE, message = FALSE, warning = FALSE)
  Sys.setenv(VROOM_CONNECTION_SIZE='512000')


## ----getPackage, eval = FALSE-------------------------------------------------
# 
#   if (!requireNamespace('BiocManager', quietly = TRUE))
#     install.packages('BiocManager')
# 
#   BiocManager::install('RegParallel')
# 

## ----getPackageDevel, eval = FALSE--------------------------------------------
# 
#   remotes::install_github('kevinblighe/RegParallel')
# 

## ----Load, message=FALSE------------------------------------------------------

  library(RegParallel)


## -----------------------------------------------------------------------------

  library(airway)
  library(magrittr)

  data('airway')
  airway$dex %<>% relevel('untrt')


## -----------------------------------------------------------------------------

  library(DESeq2)

  dds <- DESeqDataSet(airway, design = ~ dex + cell)
  dds <- DESeq(dds, betaPrior = FALSE)
  rldexpr <- assay(rlog(dds, blind = FALSE))
  rlddata <- data.frame(colData(airway), t(rldexpr))


## ----glmParallel1, echo = TRUE------------------------------------------------

  ## NOT RUN

  res1 <- RegParallel(
    data = rlddata[ ,1:3000],
    formula = 'dex ~ [*]',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit')),
    FUNtype = 'glm',
    variables = colnames(rlddata)[10:3000])

  res1[order(res1$P, decreasing=FALSE),]


## ----lmParallel1--------------------------------------------------------------

  rlddata <- rlddata[ ,1:2000]

  res2 <- RegParallel(
    data = rlddata,
    formula = '[*] ~ cell',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = colnames(rlddata)[10:ncol(rlddata)],
    p.adjust = "none")

  res3 <- RegParallel(
    data = rlddata,
    formula = '[*] ~ cell',
    FUN = function(formula, data)
      lm(formula = formula,
        data = data),
    FUNtype = 'lm',
    variables = colnames(rlddata)[10:ncol(rlddata)],
    p.adjust = "none")

  subset(res2, P<0.05)
  subset(res3, P<0.05)


## ----echo = FALSE-------------------------------------------------------------

  rm(dds, rlddata, rldexpr, airway)


## ----coxphParallel1-----------------------------------------------------------

  library(Biobase)
  library(GEOquery)

  # load series and platform data from GEO
    gset <- getGEO('GSE2990', GSEMatrix =TRUE, getGPL=FALSE)
    x <- exprs(gset[[1]])

  # remove Affymetrix control probes
    x <- x[-grep('^AFFX', rownames(x)),]

  # transform the expression data to Z scores
    x <- t(scale(t(x)))

  # extract information of interest from the phenotype data (pdata)
    idx <- which(colnames(pData(gset[[1]])) %in%
      c('age:ch1', 'distant rfs:ch1', 'er:ch1',
        'ggi:ch1', 'grade:ch1', 'node:ch1',
        'size:ch1', 'time rfs:ch1'))
    metadata <- data.frame(pData(gset[[1]])[,idx],
      row.names = rownames(pData(gset[[1]])))

  # remove samples from the pdata that have any NA value
    discard <- apply(metadata, 1, function(x) any(is.na(x)))
    metadata <- metadata[!discard,]

  # filter the Z-scores expression data to match the samples in our pdata
    x <- x[,which(colnames(x) %in% rownames(metadata))]

  # check that sample names match exactly between pdata and Z-scores 
    all((colnames(x) == rownames(metadata)) == TRUE)

  # create a merged pdata and Z-scores object
    coxdata <- data.frame(metadata, t(x))

  # tidy column names
    colnames(coxdata)[1:8] <- c('Age', 'Distant.RFS', 'ER',
      'GGI', 'Grade', 'Node', 'Size', 'Time.RFS')

  # prepare certain phenotypes
    coxdata$Age <- as.numeric(gsub('^KJ', '', coxdata$Age))
    coxdata$Distant.RFS <- as.numeric(coxdata$Distant.RFS)
    coxdata$ER <- factor(coxdata$ER, levels = c(0, 1))
    coxdata$Grade <- factor(coxdata$Grade, levels = c(1, 2, 3))
    coxdata$Time.RFS <- as.numeric(gsub('^KJX|^KJ', '', coxdata$Time.RFS))


## ----coxphParallel2-----------------------------------------------------------

  library(survival)
  res5 <- RegParallel(
    data = coxdata,
    formula = 'Surv(Time.RFS, Distant.RFS) ~ [*]',
    FUN = function(formula, data)
      coxph(formula = formula,
        data = data,
        ties = 'breslow',
        singular.ok = TRUE),
    FUNtype = 'coxph',
    variables = colnames(coxdata)[9:ncol(coxdata)],
    blocksize = 2000,
    p.adjust = "BH")
  res5 <- res5[!is.na(res5$P),]
  res5


## ----coxphParallel3, eval = FALSE---------------------------------------------
#   res5 <- res5[order(res5$LogRank, decreasing = FALSE),]
#   final <- subset(res5, LogRank < 0.01)
#   probes <- gsub('^X', '', final$Variable)
#   library(biomaRt)
#   mart <- useMart('ENSEMBL_MART_ENSEMBL', host = 'useast.ensembl.org')
#   mart <- useDataset("hsapiens_gene_ensembl", mart)
#   annotLookup <- getBM(mart = mart,
#     attributes = c('affy_hg_u133a',
#       'ensembl_gene_id',
#       'gene_biotype',
#       'external_gene_name'),
#     filter = 'affy_hg_u133a',
#     values = probes,
#     uniqueRows = TRUE)

## ----coxphParallel4-----------------------------------------------------------
  # extract RFS and probe data for downstream analysis
    survplotdata <- coxdata[,c('Time.RFS', 'Distant.RFS',
      'X203666_at', 'X205680_at')]
    colnames(survplotdata) <- c('Time.RFS', 'Distant.RFS',
      'CXCL12', 'MMP10')

  # set Z-scale cut-offs for high and low expression
    highExpr <- 1.0
    lowExpr <- 1.0

  # encode the expression for CXCL12 and MMP10 as low, mid, and high
    survplotdata$CXCL12 <- ifelse(survplotdata$CXCL12 >= highExpr, 'High',
      ifelse(x <= lowExpr, 'Low', 'Mid'))
    survplotdata$MMP10 <- ifelse(survplotdata$MMP10 >= highExpr, 'High',
      ifelse(x <= lowExpr, 'Low', 'Mid'))

  # relevel the factors to have mid as the reference level
    survplotdata$CXCL12 <- factor(survplotdata$CXCL12,
      levels = c('Mid', 'Low', 'High'))
    survplotdata$MMP10 <- factor(survplotdata$MMP10,
      levels = c('Mid', 'Low', 'High'))

## ----coxphParallel5, fig.height = 6, fig.width = 6, fig.cap = "Survival analysis via Cox Proportional Hazards regression."----
  library(survminer)
  ggsurvplot(survfit(Surv(Time.RFS, Distant.RFS) ~ CXCL12,
    data = survplotdata),
    data = survplotdata,
    risk.table = TRUE,
    pval = TRUE,
    break.time.by = 500,
    ggtheme = theme_minimal(),
    risk.table.y.text.col = TRUE,
    risk.table.y.text = FALSE)
  ggsurvplot(survfit(Surv(Time.RFS, Distant.RFS) ~ MMP10,
    data = survplotdata),
    data = survplotdata,
    risk.table = TRUE,
    pval = TRUE,
    break.time.by = 500,
    ggtheme = theme_minimal(),
    risk.table.y.text.col = TRUE,
    risk.table.y.text = FALSE)

## ----clogitParallel1----------------------------------------------------------

  x <- exprs(gset[[1]])
  x <- x[-grep('^AFFX', rownames(x)),]
  x <- scale(x)
  x <- x[,which(colnames(x) %in% rownames(metadata))]

  coxdata <- data.frame(metadata, t(x))

  colnames(coxdata)[1:8] <- c('Age', 'Distant.RFS', 'ER',
    'GGI', 'Grade', 'Node',
    'Size', 'Time.RFS')

  coxdata$Age <- as.numeric(gsub('^KJ', '', coxdata$Age))
  coxdata$Grade <- factor(coxdata$Grade, levels = c(1, 2, 3))
  coxdata$ER <- as.numeric(coxdata$ER)
  coxdata <- coxdata[!is.na(coxdata$ER),]

  res6 <- RegParallel(
    data = coxdata,
    formula = 'ER ~ [*] + Age + strata(Grade)',
    FUN = function(formula, data)
      clogit(formula = formula,
        data = data,
        method = 'breslow'),
    FUNtype = 'clogit',
    variables = colnames(coxdata)[9:ncol(coxdata)],
    blocksize = 2000)

  subset(res6, P < 0.01)


## ----clogitParallel2, eval = FALSE--------------------------------------------
#   getBM(mart = mart,
#     attributes = c('affy_hg_u133a',
#       'ensembl_gene_id',
#       'gene_biotype',
#       'external_gene_name'),
#     filter = 'affy_hg_u133a',
#     values = c('204667_at',
#       '205225_at',
#       '207813_s_at',
#       '212108_at',
#       '219497_s_at'),
#     uniqueRows=TRUE)
# 

## ----echo = FALSE-------------------------------------------------------------
  rm(coxdata, x, gset, survplotdata, highExpr, lowExpr,
    annotLookup, mart, final, probes, idx)
  gc()

## ----speedup1-----------------------------------------------------------------

  options(scipen=10)
  options(digits=6)

  # create a data-matrix of 20 x 60000 (rows x cols) random numbers
  col <- 60000
  row <- 20
  mat <- matrix(
    rexp(col*row, rate = .1),
    ncol = col)

  # add fake gene and sample names
  colnames(mat) <- paste0('gene', 1:ncol(mat))

  rownames(mat) <- paste0('sample', 1:nrow(mat))

  # add some fake metadata
  modelling <- data.frame(
    cell = rep(c('B', 'T'), nrow(mat) / 2),
    group = c(rep(c('treatment'), nrow(mat) / 2), rep(c('control'), nrow(mat) / 2)),
    dosage = t(data.frame(matrix(rexp(row, rate = 1), ncol = row))),
    mat,
    row.names = rownames(mat))


## ----speedup2-----------------------------------------------------------------

  df <- modelling[ ,1:2000]
  variables <- colnames(df)[4:ncol(df)]

  ptm <- proc.time()

  res <- RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 500,
    cores = 2,
    nestedParallel = TRUE,
    p.adjust = "BY")

  proc.time() - ptm


## ----speedup3-----------------------------------------------------------------

  df <- modelling[ ,1:2000]
  variables <- colnames(df)[4:ncol(df)]

  ptm <- proc.time()

  res <- RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 500,
    cores = 2,
    nestedParallel = FALSE,
    p.adjust = "BY")

  proc.time() - ptm


## ----speedup4-----------------------------------------------------------------

  df <- modelling[ ,1:40000]
  variables <- colnames(df)[4:ncol(df)]

  system.time(RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 2000,
    cores = 2,
    nestedParallel = TRUE))


## ----speedup5-----------------------------------------------------------------

  df <- modelling[,1:40000]
  variables <- colnames(df)[4:ncol(df)]

  system.time(RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 2000,
    cores = 2,
    nestedParallel = FALSE))


## ----speedup6-----------------------------------------------------------------

  df <- modelling[,1:40000]
  variables <- colnames(df)[4:ncol(df)]

  system.time(RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 5000,
    cores = 3,
    nestedParallel = TRUE))


## ----confint------------------------------------------------------------------

  df <- modelling[ ,1:500]
  variables <- colnames(df)[4:ncol(df)]

  # 99% confidfence intervals
  RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 150,
    cores = 3,
    nestedParallel = TRUE,
    conflevel = 99)

  # 95% confidfence intervals (default)
  RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 150,
    cores = 3,
    nestedParallel = TRUE,
    conflevel = 95)


## ----removeterms--------------------------------------------------------------

  # remove terms but keep Intercept
  RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 150,
    cores = 3,
    nestedParallel = TRUE,
    conflevel = 95,
    excludeTerms = c('cell', 'dosage'),
    excludeIntercept = FALSE)

  # remove everything but the variable being tested
  RegParallel(
    data = df,
    formula = 'factor(group) ~ [*] + (cell:dosage) ^ 2',
    FUN = function(formula, data)
      glm(formula = formula,
        data = data,
        family = binomial(link = 'logit'),
        method = 'glm.fit'),
    FUNtype = 'glm',
    variables = variables,
    blocksize = 150,
    cores = 3,
    nestedParallel = TRUE,
    conflevel = 95,
    excludeTerms = c('cell', 'dosage'),
    excludeIntercept = TRUE)


## -----------------------------------------------------------------------------

sessionInfo()


