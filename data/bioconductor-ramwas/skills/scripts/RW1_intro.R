# Code example from 'RW1_intro' vignette. See references/ for full tutorial.

## ----loadKnitr, echo=FALSE----------------------------------------------------
library("knitr")
# opts_chunk$set(eval = FALSE)
opts_chunk$set(fig.width = 6, fig.height = 6)
library(pander)
panderOptions("digits", 3)

## ----install, eval=FALSE------------------------------------------------------
# ## try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ramwas")

## ----loadIt, eval=FALSE-------------------------------------------------------
# library(ramwas) # Loads the package
# browseVignettes("ramwas") # Opens vignettes
# help(package = "ramwas") # Lists package functions

## ----loadPackages, echo=FALSE, warning=FALSE, message=FALSE-------------------
suppressPackageStartupMessages(library(ramwas))
# dr = "D:/temp"

## ----generateData, warning=FALSE, message=FALSE-------------------------------
library(ramwas)
dr = paste0(tempdir(), "/simulated_project")
ramwas0createArtificialData(
            dir = dr,
            nsamples = 20,
            nreads = 100e3,
            ncpgs = 25e3,
            threads = 2)
cat("Project directory:", dr)

## ----parameters---------------------------------------------------------------
param = ramwasParameters(
    dirproject = dr,
    dirbam = "bams",
    filebamlist = "bam_list.txt",
    filecpgset = "Simulated_chromosome.rds",
    cputhreads = 2,
    scoretag = "MAPQ",
    minscore = 4,
    minfragmentsize = 50,
    maxfragmentsize = 250,
    minavgcpgcoverage = 0.3,
    minnonzerosamples = 0.3,
    filecovariates = "covariates.txt",
    modelcovariates = NULL,
    modeloutcome = "age",
    modelPCs = 0,
    toppvthreshold = 1e-5,
    bihost = "grch37.ensembl.org",
    bimart = "ENSEMBL_MART_ENSEMBL",
    bidataset = "hsapiens_gene_ensembl",
    biattributes = c("hgnc_symbol","entrezgene","strand"),
    bifilters = list(with_hgnc_trans_name = TRUE),
    biflank = 0,
    cvnfolds = 5,
    mmalpha = 0,
    mmncpgs = c(5, 10, 50, 100, 500, 1000, 2000)
)

## ----scan-bams, warning=FALSE, message=FALSE----------------------------------
ramwas1scanBams(param)

## ----plotACbD, warning=FALSE, message=FALSE-----------------------------------
pfull = parameterPreprocess(param)
qc = readRDS(paste0(pfull$dirrqc, "/BAM007.qc.rds"))
plot(qc$qc$avg.coverage.by.density)

## ----collectQC1, warning=FALSE, message=FALSE---------------------------------
ramwas2collectqc(param)

## ----plotFSD, warning=FALSE, message=FALSE------------------------------------
qc = readRDS(paste0(pfull$dirqc, "/summary_total/qclist.rds"))
frdata = qc$total$hist.isolated.dist1
estimate = as.double(readLines(
    con = paste0(pfull$dirproject,"/Fragment_size_distribution.txt")))
plotFragmentSizeDistributionEstimate(frdata, estimate)

## ----normCoverage99, warning=FALSE, message=FALSE-----------------------------
ramwas3normalizedCoverage(param)

## ----pca99, warning=FALSE, message=FALSE--------------------------------------
ramwas4PCA(param)

## ----plotPCA, warning=FALSE, message=FALSE------------------------------------
eigenvalues = fm.load(paste0(pfull$dirpca, "/eigenvalues"));
eigenvectors = fm.open(
                filenamebase = paste0(pfull$dirpca, "/eigenvectors"),
                readonly = TRUE);
plotPCvalues(eigenvalues)
plotPCvectors(eigenvectors[,1], 1)
plotPCvectors(eigenvectors[,2], 2)
close(eigenvectors)

## ----tablePCAcr, warning=FALSE, message=FALSE---------------------------------
tblcr = read.table(
            file = paste0(pfull$dirpca, "/PC_vs_covs_corr.txt"),
            header = TRUE,
            sep = "\t")
pander(head(tblcr, 3))

## ----tablePCApv, warning=FALSE, message=FALSE---------------------------------
tblpv = read.table(
            file = paste0(pfull$dirpca, "/PC_vs_covs_pvalue.txt"),
            header = TRUE,
            sep = "\t")
pander(head(tblpv, 3))

## ----mwas99, warning=FALSE, message=FALSE-------------------------------------
ramwas5MWAS(param)

## ----tableMWAS, warning=FALSE, message=FALSE, fig.width = 12------------------
mwas = getMWASandLocations(param)
layout(matrix(c(1,2), 1, 2, byrow = TRUE), widths=c(1,2.2))
qqPlotFast(mwas$`p-value`)
man = manPlotPrepare(
        pvalues = mwas$`p-value`,
        chr = mwas$chr,
        pos = mwas$start,
        chrmargins = 0)
manPlotFast(man)

## ----anno, warning=FALSE, message=FALSE, eval=FALSE---------------------------
# ramwas6annotateTopFindings(param)

## ----CV, warning=FALSE, message=FALSE-----------------------------------------
ramwas7riskScoreCV(param)

## ----plotCV1, warning=FALSE, message=FALSE------------------------------------
cv = readRDS(paste0(pfull$dircv, "/rds/CpGs=000050_alpha=0.000000.rds"))
plotPrediction(
        param = pfull,
        outcome = cv$outcome,
        forecast = cv$forecast,
        cpgs2use = 50,
        main = "Prediction success (EN on coverage)")

## ----plotCV2, warning=FALSE, message=FALSE------------------------------------
cl = readRDS(sprintf("%s/rds/cor_data_alpha=%f.rds",
                    pfull$dircv,
                    pfull$mmalpha))
plotCVcors(cl, pfull)

## ----dirlocations-------------------------------------------------------------
pfull = parameterPreprocess(param)
cat("CpG score directory:", "\n", pfull$dircoveragenorm,"\n")
cat("PCA directory:", "\n", pfull$dirpca, "\n")
cat("MWAS directory:", "\n", pfull$dirmwas, "\n")
cat("MRS directory:", "\n", pfull$dircv, "\n")
cat("CpG-SNP directory:", "\n", pfull$dirSNPs, "\n")

## ----version------------------------------------------------------------------
sessionInfo()

