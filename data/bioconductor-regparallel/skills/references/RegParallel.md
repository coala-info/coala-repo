# Standard regression functions in R enabled for parallel processing over large data-frames

#### Kevin Blighe, Jessica Lasky-Su

#### 2025-11-04

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 1. Download the package from Bioconductor](#download-the-package-from-bioconductor)
  + [2.2 2. Load the package into R session](#load-the-package-into-r-session)
* [3 Quick start](#quick-start)
  + [3.1 Perform the most basic logistic regression analysis](#perform-the-most-basic-logistic-regression-analysis)
  + [3.2 Perform a basic linear regression](#perform-a-basic-linear-regression)
  + [3.3 Survival analysis via Cox Proportional Hazards regression](#survival-analysis-via-cox-proportional-hazards-regression)
  + [3.4 Perform a conditional logistic regression](#perform-a-conditional-logistic-regression)
* [4 Advanced features](#advanced-features)
  + [4.1 Speed up processing](#speed-up-processing)
    - [4.1.1 ~2000 tests; blocksize, 500; cores, 2; nestedParallel, TRUE](#tests-blocksize-500-cores-2-nestedparallel-true)
    - [4.1.2 ~2000 tests; blocksize, 500; cores, 2; nestedParallel, FALSE](#tests-blocksize-500-cores-2-nestedparallel-false)
    - [4.1.3 ~40000 tests; blocksize, 2000; cores, 2; nestedParallel, TRUE](#tests-blocksize-2000-cores-2-nestedparallel-true)
    - [4.1.4 ~40000 tests; blocksize, 2000; cores, 2; nestedParallel, FALSE](#tests-blocksize-2000-cores-2-nestedparallel-false)
    - [4.1.5 ~40000 tests; blocksize, 5000; cores, 3; nestedParallel, TRUE](#tests-blocksize-5000-cores-3-nestedparallel-true)
  + [4.2 Modify confidence intervals](#modify-confidence-intervals)
  + [4.3 Remove some terms from output / include the intercept](#remove-some-terms-from-output-include-the-intercept)
* [5 Acknowledgments](#acknowledgments)
* [6 Session info](#session-info)
* [7 References](#references)

# 1 Introduction

In many analyses, a large amount of variables have to be tested independently against the trait/endpoint of interest, and also adjusted for covariates and confounding factors at the same time. The major bottleneck in these is the amount of time that it takes to complete these analyses.

With *RegParallel*, a large number of tests can be performed simultaneously. On a 12-core system, 144 variables can be tested simultaneously, with 1000s of variables processed in a matter of seconds via ‘nested’ parallel processing.

Works for logistic regression, linear regression, conditional logistic regression, Cox proportional hazards and survival models, and Bayesian logistic regression. Also caters for generalised linear models that utilise survey weights created by the ‘survey’ CRAN package and that utilise ‘survey::svyglm’.

# 2 Installation

## 2.1 1. Download the package from Bioconductor

```
  if (!requireNamespace('BiocManager', quietly = TRUE))
    install.packages('BiocManager')

  BiocManager::install('RegParallel')
```

Note: to install development version:

```
  remotes::install_github('kevinblighe/RegParallel')
```

## 2.2 2. Load the package into R session

```
  library(RegParallel)
```

# 3 Quick start

For this quick start, we will follow the tutorial (from Section 3.1) of [RNA-seq workflow: gene-level exploratory analysis and differential expression](http://master.bioconductor.org/packages/release/workflows/vignettes/rnaseqGene/inst/doc/rnaseqGene.html). Specifically, we will load the ‘airway’ data, where different airway smooth muscle cells were treated with dexamethasone.

```
  library(airway)
  library(magrittr)

  data('airway')
  airway$dex %<>% relevel('untrt')
```

Normalise the raw counts in *DESeq2* and produce regularised log expression levels:

```
  library(DESeq2)

  dds <- DESeqDataSet(airway, design = ~ dex + cell)
  dds <- DESeq(dds, betaPrior = FALSE)
  rldexpr <- assay(rlog(dds, blind = FALSE))
  rlddata <- data.frame(colData(airway), t(rldexpr))
```

## 3.1 Perform the most basic logistic regression analysis

Here, we fit a binomial logistic regression model to the data via *glmParallel*, with dexamethasone as the dependent variable.

```
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
```

```
##              Variable            Term       Beta StandardError             Z
##                <char>          <char>      <num>         <num>         <num>
##    1: ENSG00000095464 ENSG00000095464   43.27934  2.593463e+01  1.6687854476
##    2: ENSG00000071859 ENSG00000071859   12.96251  7.890287e+00  1.6428433092
##    3: ENSG00000069812 ENSG00000069812  -44.37139  2.704021e+01 -1.6409412536
##    4: ENSG00000072415 ENSG00000072415  -19.90841  1.227527e+01 -1.6218306224
##    5: ENSG00000073921 ENSG00000073921   14.59470  8.999831e+00  1.6216635641
##   ---
## 2817: ENSG00000068831 ENSG00000068831  110.84893  2.729072e+05  0.0004061781
## 2818: ENSG00000069020 ENSG00000069020 -186.45744  4.603615e+05 -0.0004050239
## 2819: ENSG00000083642 ENSG00000083642 -789.55666  1.951104e+06 -0.0004046717
## 2820: ENSG00000104331 ENSG00000104331  394.14700  9.749138e+05  0.0004042891
## 2821: ENSG00000083097 ENSG00000083097 -217.48873  5.398191e+05 -0.0004028919
##                P            OR      ORlower      ORupper
##            <num>         <num>        <num>        <num>
##    1: 0.09515991  6.251402e+18 5.252646e-04 7.440065e+40
##    2: 0.10041536  4.261323e+05 8.190681e-02 2.217017e+12
##    3: 0.10080961  5.367228e-20 5.165170e-43 5.577191e+03
##    4: 0.10483962  2.258841e-09 8.038113e-20 6.347711e+01
##    5: 0.10487540  2.179701e+06 4.761313e-02 9.978541e+13
##   ---
## 2817: 0.99967592  1.383811e+48 0.000000e+00           NA
## 2818: 0.99967684  1.053326e-81 0.000000e+00           NA
## 2819: 0.99967712  0.000000e+00 0.000000e+00           NA
## 2820: 0.99967742 1.499223e+171 0.000000e+00           NA
## 2821: 0.99967854  3.514359e-95 0.000000e+00           NA
```

## 3.2 Perform a basic linear regression

Here, we will perform the linear regression using both *glmParallel* and *lmParallel*. We will appreciate that a linear regression is the same using either function with the default settings.

Regularised log expression levels from our *DESeq2* data will be used.

```
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
```

```
##             Variable        Term        Beta StandardError          t
##               <char>      <char>       <num>         <num>      <num>
##   1: ENSG00000001461 cellN061011 -0.46859875    0.10526111  -4.451775
##   2: ENSG00000001461 cellN080611 -0.84020922    0.10526111  -7.982143
##   3: ENSG00000001461  cellN61311 -0.87778101    0.10526111  -8.339082
##   4: ENSG00000001561 cellN080611 -1.71802758    0.13649920 -12.586357
##   5: ENSG00000001561  cellN61311 -1.05328889    0.13649920  -7.716448
##  ---
## 519: ENSG00000092108 cellN061011 -0.12721659    0.01564082  -8.133625
## 520: ENSG00000092108  cellN61311 -0.12451203    0.01564082  -7.960708
## 521: ENSG00000092148 cellN080611 -0.34988071    0.10313461  -3.392467
## 522: ENSG00000092200 cellN080611  0.05906656    0.01521063   3.883241
## 523: ENSG00000092208 cellN080611 -0.28587683    0.08506716  -3.360602
##                 P        OR   ORlower   ORupper
##             <num>     <num>     <num>     <num>
##   1: 0.0112313246 0.6258787 0.5092039 0.7692873
##   2: 0.0013351958 0.4316202 0.3511586 0.5305181
##   3: 0.0011301853 0.4157043 0.3382098 0.5109554
##   4: 0.0002293465 0.1794197 0.1373036 0.2344544
##   5: 0.0015182960 0.3487887 0.2669157 0.4557753
##  ---
## 519: 0.0012429963 0.8805429 0.8539591 0.9079544
## 520: 0.0013489163 0.8829276 0.8562718 0.9104133
## 521: 0.0274674209 0.7047722 0.5757851 0.8626549
## 522: 0.0177922771 1.0608458 1.0296864 1.0929482
## 523: 0.0282890537 0.7513552 0.6359690 0.8876762
```

```
  subset(res3, P<0.05)
```

```
##             Variable        Term        Beta StandardError          t
##               <char>      <char>       <num>         <num>      <num>
##   1: ENSG00000001461 cellN061011 -0.46859875    0.10526111  -4.451775
##   2: ENSG00000001461 cellN080611 -0.84020922    0.10526111  -7.982143
##   3: ENSG00000001461  cellN61311 -0.87778101    0.10526111  -8.339082
##   4: ENSG00000001561 cellN080611 -1.71802758    0.13649920 -12.586357
##   5: ENSG00000001561  cellN61311 -1.05328889    0.13649920  -7.716448
##  ---
## 519: ENSG00000092108 cellN061011 -0.12721659    0.01564082  -8.133625
## 520: ENSG00000092108  cellN61311 -0.12451203    0.01564082  -7.960708
## 521: ENSG00000092148 cellN080611 -0.34988071    0.10313461  -3.392467
## 522: ENSG00000092200 cellN080611  0.05906656    0.01521063   3.883241
## 523: ENSG00000092208 cellN080611 -0.28587683    0.08506716  -3.360602
##                 P        OR   ORlower   ORupper
##             <num>     <num>     <num>     <num>
##   1: 0.0112313246 0.6258787 0.5092039 0.7692873
##   2: 0.0013351958 0.4316202 0.3511586 0.5305181
##   3: 0.0011301853 0.4157043 0.3382098 0.5109554
##   4: 0.0002293465 0.1794197 0.1373036 0.2344544
##   5: 0.0015182960 0.3487887 0.2669157 0.4557753
##  ---
## 519: 0.0012429963 0.8805429 0.8539591 0.9079544
## 520: 0.0013489163 0.8829276 0.8562718 0.9104133
## 521: 0.0274674209 0.7047722 0.5757851 0.8626549
## 522: 0.0177922771 1.0608458 1.0296864 1.0929482
## 523: 0.0282890537 0.7513552 0.6359690 0.8876762
```

## 3.3 Survival analysis via Cox Proportional Hazards regression

For this example, we will load breast cancer gene expression data with recurrence free survival (RFS) from [Gene Expression Profiling in Breast Cancer: Understanding the Molecular Basis of Histologic Grade To Improve Prognosis](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE2990). Specifically, we will encode each gene’s expression into Low|Mid|High based on Z-scores and compare these against RFS while adjusting for tumour grade in a Cox Proportional Hazards model.

First, let’s read in and prepare the data:

```
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
```

```
## [1] TRUE
```

```
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
```

With the data prepared, we can now apply a Cox Proportional Hazards model independently for each probe in the dataset against RFS.

In this we also increase the default blocksize to 2000 in order to speed up the analysis.

```
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
```

```
##           Variable        Term          Beta StandardError             Z
##             <char>      <char>         <num>         <num>         <num>
##     1:  X1007_s_at  X1007_s_at  0.3780639987     0.3535022  1.0694811914
##     2:    X1053_at    X1053_at  0.1177398813     0.2275041  0.5175285346
##     3:     X117_at     X117_at  0.6265036787     0.6763106  0.9263549892
##     4:     X121_at     X121_at -0.6138126274     0.6166626 -0.9953783151
##     5:  X1255_g_at  X1255_g_at -0.2043297829     0.3983930 -0.5128849375
##    ---
## 22211:   X91703_at   X91703_at -0.4124539527     0.4883759 -0.8445419981
## 22212: X91816_f_at X91816_f_at  0.0482030943     0.3899180  0.1236236554
## 22213:   X91826_at   X91826_at  0.0546751431     0.3319572  0.1647053850
## 22214:   X91920_at   X91920_at -0.6452125945     0.8534623 -0.7559942684
## 22215:   X91952_at   X91952_at -0.0001396044     0.7377681 -0.0001892254
##                P       LRT      Wald   LogRank        HR    HRlower  HRupper
##            <num>     <num>     <num>     <num>     <num>      <num>    <num>
##     1: 0.2848529 0.2826716 0.2848529 0.2848400 1.4594563 0.72994385 2.918050
##     2: 0.6047873 0.6085603 0.6047873 0.6046839 1.1249515 0.72024775 1.757056
##     3: 0.3542615 0.3652989 0.3542615 0.3541855 1.8710573 0.49706191 7.043097
##     4: 0.3195523 0.3188303 0.3195523 0.3186921 0.5412832 0.16162940 1.812712
##     5: 0.6080318 0.6084157 0.6080318 0.6077573 0.8151935 0.37337733 1.779809
##    ---
## 22211: 0.3983666 0.3949865 0.3983666 0.3981244 0.6620237 0.25419512 1.724169
## 22212: 0.9016133 0.9015048 0.9016133 0.9016144 1.0493838 0.48869230 2.253373
## 22213: 0.8691759 0.8691994 0.8691759 0.8691733 1.0561974 0.55103934 2.024453
## 22214: 0.4496526 0.4478541 0.4496526 0.4498007 0.5245510 0.09847349 2.794191
## 22215: 0.9998490 0.9998490 0.9998490 0.9998490 0.9998604 0.23547784 4.245498
##         P.adjust LRT.adjust Wald.adjust LogRank.adjust
##            <num>      <num>       <num>          <num>
##     1: 0.9999969  0.9999969   0.9999969      0.9999969
##     2: 0.9999969  0.9999969   0.9999969      0.9999969
##     3: 0.9999969  0.9999969   0.9999969      0.9999969
##     4: 0.9999969  0.9999969   0.9999969      0.9999969
##     5: 0.9999969  0.9999969   0.9999969      0.9999969
##    ---
## 22211: 0.9999969  0.9999969   0.9999969      0.9999969
## 22212: 0.9999969  0.9999969   0.9999969      0.9999969
## 22213: 0.9999969  0.9999969   0.9999969      0.9999969
## 22214: 0.9999969  0.9999969   0.9999969      0.9999969
## 22215: 0.9999969  0.9999969   0.9999969      0.9999969
```

We now take the top probes from the model by Log Rank p-value and use *biomaRt* to look up the corresponding gene symbols.

*not run*

```
  res5 <- res5[order(res5$LogRank, decreasing = FALSE),]
  final <- subset(res5, LogRank < 0.01)
  probes <- gsub('^X', '', final$Variable)
  library(biomaRt)
  mart <- useMart('ENSEMBL_MART_ENSEMBL', host = 'useast.ensembl.org')
  mart <- useDataset("hsapiens_gene_ensembl", mart)
  annotLookup <- getBM(mart = mart,
    attributes = c('affy_hg_u133a',
      'ensembl_gene_id',
      'gene_biotype',
      'external_gene_name'),
    filter = 'affy_hg_u133a',
    values = probes,
    uniqueRows = TRUE)
```

Two of the top hits include *CXCL12* and *MMP10*. High expression of *CXCL12* was previously associated with good progression free and overall survival in breast cancer in (doi: 10.1016/j.cca.2018.05.041.)[<https://www.ncbi.nlm.nih.gov/pubmed/29800557>] , whilst high expression of *MMP10* was associated with poor prognosis in colon cancer in (doi: 10.1186/s12885-016-2515-7)[<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4950722/>].

We can further explore the role of these genes to RFS by dividing their gene expression Z-scores into tertiles for low, mid, and high expression:

```
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
```

Plot the survival curves and place Log Rank p-value in the plots:

```
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
```

![Survival analysis via Cox Proportional Hazards regression.](data:image/png;base64...)

Survival analysis via Cox Proportional Hazards regression.

```
  ggsurvplot(survfit(Surv(Time.RFS, Distant.RFS) ~ MMP10,
    data = survplotdata),
    data = survplotdata,
    risk.table = TRUE,
    pval = TRUE,
    break.time.by = 500,
    ggtheme = theme_minimal(),
    risk.table.y.text.col = TRUE,
    risk.table.y.text = FALSE)
```

![Survival analysis via Cox Proportional Hazards regression.](data:image/png;base64...)

Survival analysis via Cox Proportional Hazards regression.

## 3.4 Perform a conditional logistic regression

In this example, we will re-use the Cox data for the purpose of performing conditional logistic regression with tumour grade as our grouping / matching factor. For this example, we will use ER status as the dependent variable and also adjust for age.

```
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
```

```
##        Variable         Term       Beta StandardError         Z           P
##          <char>       <char>      <num>         <num>     <num>       <num>
## 1:   X204667_at   X204667_at  0.9940504     0.3628087  2.739875 0.006146252
## 2:   X205225_at   X205225_at  0.4444556     0.1633857  2.720285 0.006522559
## 3: X207813_s_at X207813_s_at  0.8218501     0.3050777  2.693904 0.007062046
## 4:   X212108_at   X212108_at  1.9610211     0.7607284  2.577820 0.009942574
## 5: X219497_s_at X219497_s_at -1.0249671     0.3541401 -2.894242 0.003800756
##            LRT       Wald    LogRank        HR   HRlower   HRupper
##          <num>      <num>      <num>     <num>     <num>     <num>
## 1: 0.006808415 0.02212540 0.02104525 2.7021573 1.3270501  5.502169
## 2: 0.010783544 0.01941078 0.01701248 1.5596409 1.1322713  2.148319
## 3: 0.037459927 0.02449358 0.02424809 2.2747043 1.2509569  4.136257
## 4: 0.033447973 0.03356050 0.03384960 7.1065797 1.6000274 31.564132
## 5: 0.005153233 0.01387183 0.01183245 0.3588083 0.1792329  0.718302
```

*not run*

```
  getBM(mart = mart,
    attributes = c('affy_hg_u133a',
      'ensembl_gene_id',
      'gene_biotype',
      'external_gene_name'),
    filter = 'affy_hg_u133a',
    values = c('204667_at',
      '205225_at',
      '207813_s_at',
      '212108_at',
      '219497_s_at'),
    uniqueRows=TRUE)
```

Oestrogen receptor (*ESR1*) comes out - makes sense! Also, although 204667\_at is not listed in *biomaRt*, it overlaps an exon of *FOXA1*, which also makes sense in relation to oestrogen signalling.

```
##            used  (Mb) gc trigger  (Mb) max used  (Mb)
## Ncells  7972508 425.8   12127477 647.7 12127477 647.7
## Vcells 18197464 138.9   64821432 494.6 64821429 494.6
```

# 4 Advanced features

Advanced features include the ability to modify block size, choose different numbers of cores, enable ‘nested’ parallel processing, modify limits for confidence intervals, and exclude certain model terms from output.

## 4.1 Speed up processing

First create some test data for the purpose of benchmarking:

```
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
```

### 4.1.1 ~2000 tests; blocksize, 500; cores, 2; nestedParallel, TRUE

With 2 cores instead of the default of 3, coupled with nestedParallel being enabled, a total of 2 x 2 = 4 threads will be used.

```
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
```

```
##    user  system elapsed
##   0.316   0.083   3.648
```

### 4.1.2 ~2000 tests; blocksize, 500; cores, 2; nestedParallel, FALSE

```
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
```

```
##    user  system elapsed
##   3.254   0.589   3.811
```

Focusing on the elapsed time (as system time only reports time from the last core that finished), we can see that nested processing has negligible improvement or may actually be slower under certain conditions when tested over a small number of variables. This is likely due to the system being slowed by simply managing the larger number of threads. Nested processing’s benefits can only be gained when processing a large number of variables:

### 4.1.3 ~40000 tests; blocksize, 2000; cores, 2; nestedParallel, TRUE

```
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
```

```
##    user  system elapsed
##  84.929  18.079  54.406
```

### 4.1.4 ~40000 tests; blocksize, 2000; cores, 2; nestedParallel, FALSE

```
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
```

```
##    user  system elapsed
##  78.811   1.605  81.264
```

Performance is system-dependent and even increasing cores may not result in huge gains in time. Performance is a trade-off between cores, forked threads, blocksize, and the number of terms in each model.

### 4.1.5 ~40000 tests; blocksize, 5000; cores, 3; nestedParallel, TRUE

In this example, we choose a large blocksize and 3 cores. With nestedParallel enabled, this translates to 9 simultaneous threads.

```
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
```

```
##    user  system elapsed
## 172.312  17.465  40.295
```

## 4.2 Modify confidence intervals

```
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
```

```
##       Variable         Term        Beta StandardError         Z        P
##         <char>       <char>       <num>         <num>     <num>    <num>
##    1:    gene1        gene1 -0.06548720     0.0664758 -0.985129 0.324561
##    2:    gene1 cellB:dosage -3.23552551     2.1041748 -1.537670 0.124129
##    3:    gene1 cellT:dosage -0.17364792     0.5130646 -0.338452 0.735022
##    4:    gene2        gene2 -0.04854827     0.1026448 -0.472974 0.636232
##    5:    gene2 cellB:dosage -2.97409632     2.1398982 -1.389831 0.164580
##   ---
## 1487:  gene496 cellB:dosage -4.03894640     2.6025118 -1.551942 0.120676
## 1488:  gene496 cellT:dosage -0.29596447     0.5095054 -0.580886 0.561317
## 1489:  gene497      gene497  0.00909706     0.0301646  0.301581 0.762972
## 1490:  gene497 cellB:dosage -2.98607489     2.1236693 -1.406092 0.159697
## 1491:  gene497 cellT:dosage -0.28773592     0.5023189 -0.572815 0.566770
##              OR      ORlower  ORupper
##           <num>        <num>    <num>
##    1: 0.9366110 0.7892142084  1.11154
##    2: 0.0393395 0.0001741627  8.88594
##    3: 0.8405928 0.2242004398  3.15163
##    4: 0.9526114 0.7312911287  1.24091
##    5: 0.0510936 0.0002063145 12.65328
##   ---
## 1487: 0.0176160 0.0000216053 14.36335
## 1488: 0.7438139 0.2002149991  2.76332
## 1489: 1.0091386 0.9336984109  1.09067
## 1490: 0.0504852 0.0002125604 11.99074
## 1491: 0.7499596 0.2056409200  2.73506
```

```
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
```

```
##       Variable         Term        Beta StandardError         Z        P
##         <char>       <char>       <num>         <num>     <num>    <num>
##    1:    gene1        gene1 -0.06548720     0.0664758 -0.985129 0.324561
##    2:    gene1 cellB:dosage -3.23552551     2.1041748 -1.537670 0.124129
##    3:    gene1 cellT:dosage -0.17364792     0.5130646 -0.338452 0.735022
##    4:    gene2        gene2 -0.04854827     0.1026448 -0.472974 0.636232
##    5:    gene2 cellB:dosage -2.97409632     2.1398982 -1.389831 0.164580
##   ---
## 1487:  gene496 cellB:dosage -4.03894640     2.6025118 -1.551942 0.120676
## 1488:  gene496 cellT:dosage -0.29596447     0.5095054 -0.580886 0.561317
## 1489:  gene497      gene497  0.00909706     0.0301646  0.301581 0.762972
## 1490:  gene497 cellB:dosage -2.98607489     2.1236693 -1.406092 0.159697
## 1491:  gene497 cellT:dosage -0.28773592     0.5023189 -0.572815 0.566770
##              OR     ORlower ORupper
##           <num>       <num>   <num>
##    1: 0.9366110 0.822195264 1.06695
##    2: 0.0393395 0.000636432 2.43168
##    3: 0.8405928 0.307513558 2.29777
##    4: 0.9526114 0.779012418 1.16490
##    5: 0.0510936 0.000770694 3.38728
##   ---
## 1487: 0.0176160 0.000107311 2.89181
## 1488: 0.7438139 0.274013811 2.01909
## 1489: 1.0091386 0.951206154 1.07060
## 1490: 0.0504852 0.000786129 3.24216
## 1491: 0.7499596 0.280196838 2.00730
```

## 4.3 Remove some terms from output / include the intercept

```
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
```

```
##      Variable        Term        Beta StandardError          Z        P
##        <char>      <char>       <num>         <num>      <num>    <num>
##   1:    gene1 (Intercept)  1.30940132     0.9055806  1.4459247 0.148198
##   2:    gene1       gene1 -0.06548720     0.0664758 -0.9851285 0.324561
##   3:    gene2 (Intercept)  1.08808598     0.9423116  1.1546987 0.248214
##   4:    gene2       gene2 -0.04854827     0.1026448 -0.4729737 0.636232
##   5:    gene3 (Intercept)  0.90864966     0.9256344  0.9816507 0.326272
##  ---
## 990:  gene495     gene495  0.03489729     0.0779458  0.4477125 0.654361
## 991:  gene496 (Intercept)  0.03074676     0.8974369  0.0342606 0.972669
## 992:  gene496     gene496  0.11117002     0.0912132  1.2187927 0.222923
## 993:  gene497 (Intercept)  0.63551011     0.8976407  0.7079782 0.478959
## 994:  gene497     gene497  0.00909706     0.0301646  0.3015807 0.762972
##            OR  ORlower  ORupper
##         <num>    <num>    <num>
##   1: 3.703956 0.627819 21.85231
##   2: 0.936611 0.822195  1.06695
##   3: 2.968587 0.468223 18.82118
##   4: 0.952611 0.779012  1.16490
##   5: 2.480970 0.404315 15.22380
##  ---
## 990: 1.035513 0.888808  1.20643
## 991: 1.031224 0.177604  5.98760
## 992: 1.117585 0.934630  1.33635
## 993: 1.887985 0.325031 10.96659
## 994: 1.009139 0.951206  1.07060
```

```
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
```

```
##      Variable    Term        Beta StandardError         Z        P       OR
##        <char>  <char>       <num>         <num>     <num>    <num>    <num>
##   1:    gene1   gene1 -0.06548720     0.0664758 -0.985129 0.324561 0.936611
##   2:    gene2   gene2 -0.04854827     0.1026448 -0.472974 0.636232 0.952611
##   3:    gene3   gene3 -0.00893283     0.0488091 -0.183016 0.854786 0.991107
##   4:    gene4   gene4  0.08635437     0.0818692  1.054785 0.291524 1.090193
##   5:    gene5   gene5 -0.07573622     0.0691920 -1.094580 0.273701 0.927061
##  ---
## 493:  gene493 gene493  0.05126687     0.0739494  0.693269 0.488141 1.052604
## 494:  gene494 gene494  0.20897371     0.1558502  1.340863 0.179965 1.232413
## 495:  gene495 gene495  0.03489729     0.0779458  0.447713 0.654361 1.035513
## 496:  gene496 gene496  0.11117002     0.0912132  1.218793 0.222923 1.117585
## 497:  gene497 gene497  0.00909706     0.0301646  0.301581 0.762972 1.009139
##       ORlower ORupper
##         <num>   <num>
##   1: 0.822195 1.06695
##   2: 0.779012 1.16490
##   3: 0.900687 1.09060
##   4: 0.928573 1.27994
##   5: 0.809491 1.06171
##  ---
## 493: 0.910582 1.21678
## 494: 0.908022 1.67269
## 495: 0.888808 1.20643
## 496: 0.934630 1.33635
## 497: 0.951206 1.07060
```

# 5 Acknowledgments

Thanks to Horácio Montenegro and GenoMax for testing cross-platform differences, and Wolfgang Huber for providing the nudge that FDR correction needed to be implemented.

Thanks to Michael Barnes in London for introducing me to parallel processing in R.

Finally, thanks to Juan Celedón at Children’s Hospital of Pittsburgh.

Sarega Gurudas, whose suggestion led to the implementation of survey weights via svyglm.

# 6 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] survminer_0.5.1             ggpubr_0.6.2
##  [3] ggplot2_4.0.0               GEOquery_2.78.0
##  [5] DESeq2_1.50.0               magrittr_2.0.4
##  [7] airway_1.30.0               SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           RegParallel_1.28.0
## [19] arm_1.14-4                  lme4_1.1-37
## [21] Matrix_1.7-4                MASS_7.3-65
## [23] survival_3.8-3              stringr_1.5.2
## [25] data.table_1.17.8           doParallel_1.0.17
## [27] iterators_1.0.14            foreach_1.5.2
## [29] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] Rdpack_2.6.4        gridExtra_2.3       httr2_1.2.1
##  [4] rlang_1.1.6         compiler_4.5.1      vctrs_0.6.5
##  [7] pkgconfig_2.0.3     fastmap_1.2.0       backports_1.5.0
## [10] XVector_0.50.0      labeling_0.4.3      KMsurv_0.1-6
## [13] rmarkdown_2.30      tzdb_0.5.0          nloptr_2.2.1
## [16] purrr_1.1.0         xfun_0.54           cachem_1.1.0
## [19] jsonlite_2.0.0      DelayedArray_0.36.0 BiocParallel_1.44.0
## [22] broom_1.0.10        R6_2.6.1            bslib_0.9.0
## [25] stringi_1.8.7       RColorBrewer_1.1-3  limma_3.66.0
## [28] car_3.1-3           boot_1.3-32         jquerylib_0.1.4
## [31] Rcpp_1.1.0          zoo_1.8-14          R.utils_2.13.0
## [34] readr_2.1.5         rentrez_1.2.4       splines_4.5.1
## [37] tidyselect_1.2.1    dichromat_2.0-0.1   abind_1.4-8
## [40] yaml_2.3.10         ggtext_0.1.2        codetools_0.2-20
## [43] curl_7.0.0          lattice_0.22-7      tibble_3.3.0
## [46] withr_3.0.2         S7_0.2.0            coda_0.19-4.1
## [49] evaluate_1.0.5      xml2_1.4.1          survMisc_0.5.6
## [52] pillar_1.11.1       carData_3.0-5       reformulas_0.4.2
## [55] hms_1.1.4           scales_1.4.0        minqa_1.2.8
## [58] xtable_1.8-4        glue_1.8.0          tools_4.5.1
## [61] locfit_1.5-9.12     ggsignif_0.6.4      XML_3.99-0.19
## [64] grid_4.5.1          tidyr_1.3.1         rbibutils_2.3
## [67] nlme_3.1-168        Formula_1.2-5       cli_3.6.5
## [70] km.ci_0.5-6         rappdirs_0.3.3      S4Arrays_1.10.0
## [73] dplyr_1.1.4         gtable_0.3.6        R.methodsS3_1.8.2
## [76] rstatix_0.7.3       sass_0.4.10         digest_0.6.37
## [79] SparseArray_1.10.1  farver_2.1.2        htmltools_0.5.8.1
## [82] R.oo_1.27.1         lifecycle_1.0.4     statmod_1.5.1
## [85] gridtext_0.1.5
```

# 7 References

Blighe and Lasky-Su (2018)

Blighe, K, and J Lasky-Su. 2018. “RegParallel: Standard regression functions in R enabled for parallel processing over large data-frames.” <https://github.com/kevinblighe/RegParallel.>