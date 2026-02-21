# Code example from 'ASSIGN.vignette' vignette. See references/ for full tutorial.

## ----setup, echo=TRUE---------------------------------------------------------
library(ASSIGN)

dir.create("tempdir")
tempdir <- "tempdir"

## ----datasets-and-labels, eval=FALSE------------------------------------------
# data(trainingData1)
# data(testData1)
# data(geneList1)
# trainingLabel1 <- list(control = list(bcat=1:10, e2f3=1:10,
#                                       myc=1:10, ras=1:10, src=1:10),
#                        bcat = 11:19, e2f3 = 20:28, myc= 29:38,
#                        ras = 39:48, src = 49:55)
# testLabel1 <- rep(c("Adeno", "Squamous"), c(53,58))

## ----all-in-one-assign-wrapper-example1, eval=FALSE, results='hide'-----------
# dir.create(file.path(tempdir,"wrapper_example1"))
# assign.wrapper(trainingData=trainingData1, testData=testData1,
#                trainingLabel=trainingLabel1, testLabel=testLabel1,
#                geneList=NULL, n_sigGene=rep(200,5), adaptive_B=TRUE,
#                adaptive_S=FALSE, mixture_beta=TRUE,
#                outputDir=file.path(tempdir,"wrapper_example1"),
#                iter=2000, burn_in=1000)

## ----all-in-one-assign-wrapper-example2, eval=FALSE, results='hide'-----------
# dir.create(file.path(tempdir,"wrapper_example2"))
# assign.wrapper(trainingData=trainingData1, testData=testData1,
#                trainingLabel=trainingLabel1, testLabel=NULL,
#                geneList=geneList1, n_sigGene=NULL, adaptive_B=TRUE,
#                adaptive_S=FALSE, mixture_beta=TRUE,
#                outputDir=file.path(tempdir,"wrapper_example2"),
#                iter=2000, burn_in=1000)

## ----all-in-one-assign-wrapper-example3, eval=FALSE, results='hide'-----------
# dir.create(file.path(tempdir,"wrapper_example3"))
# assign.wrapper(trainingData=NULL, testData=testData1,
#                trainingLabel=NULL, testLabel=NULL,
#                geneList=geneList1, n_sigGene=NULL, adaptive_B=TRUE,
#                adaptive_S=TRUE, mixture_beta=TRUE,
#                outputDir=file.path(tempdir,"wrapper_example3"),
#                iter=2000, burn_in=1000)

## ----assign-preprocess-function1, eval=FALSE, results='hide'------------------
# # training dataset is available;
# # the gene list of pathway signature is NOT available
# processed.data <- assign.preprocess(trainingData=trainingData1,
#                                     testData=testData1,
#                                     trainingLabel=trainingLabel1,
#                                     geneList=NULL, n_sigGene=rep(200,5))

## ----assign-preprocess-function2, eval=FALSE, results='hide'------------------
# # training dataset is available;
# # the gene list of pathway signature is available
# processed.data <- assign.preprocess(trainingData=trainingData1,
#                                     testData=testData1,
#                                     trainingLabel=trainingLabel1,
#                                     geneList=geneList1)

## ----assign-preprocess-function3, eval=FALSE, results='hide'------------------
# # training dataset is NOT available;
# # the gene list of pathway signature is available
# processed.data <- assign.preprocess(trainingData=NULL,
#                                     testData=testData1,
#                                     trainingLabel=NULL,
#                                     geneList=geneList1)

## ----assign-mcmc-function, eval=FALSE, results='hide'-------------------------
# mcmc.chain <- assign.mcmc(Y=processed.data$testData_sub,
#                           Bg = processed.data$B_vector,
#                           X=processed.data$S_matrix,
#                           Delta_prior_p = processed.data$Pi_matrix,
#                           iter = 2000, adaptive_B=TRUE,
#                           adaptive_S=FALSE, mixture_beta=TRUE)

## ----assign-convergence-function, eval=FALSE, results='hide'------------------
# trace.plot <- assign.convergence(test=mcmc.chain, burn_in=0, iter=2000,
#                                  parameter="B", whichGene=1,
#                                  whichSample=NA, whichPath=NA)

## ----assign-summary-function, eval=FALSE, results='hide'----------------------
# mcmc.pos.mean <- assign.summary(test=mcmc.chain, burn_in=1000,
#                                 iter=2000, adaptive_B=TRUE,
#                                 adaptive_S=FALSE, mixture_beta=TRUE)

## ----assign-cv-output-function, eval=FALSE, results='hide'--------------------
# # For cross-validation, Y in the assign.mcmc function
# # should be specified as processed.data$trainingData_sub.
# assign.cv.output(processed.data=processed.data,
#                  mcmc.pos.mean.trainingData=mcmc.pos.mean,
#                  trainingData=trainingData1,
#                  trainingLabel=trainingLabel1, adaptive_B=FALSE,
#                  adaptive_S=FALSE, mixture_beta=TRUE,
#                  outputDir=tempdir)

## ----assign-output-function, eval=FALSE, results='hide'-----------------------
# assign.output(processed.data=processed.data,
#               mcmc.pos.mean.testData=mcmc.pos.mean,
#               trainingData=trainingData1, testData=testData1,
#               trainingLabel=trainingLabel1,
#               testLabel=testLabel1, geneList=NULL,
#               adaptive_B=TRUE, adaptive_S=FALSE,
#               mixture_beta=TRUE, outputDir=tempdir)

## ----anchor-exclude-example, eval=FALSE, results='hide'-----------------------
# dir.create(file.path(tempdir, "anchor_exclude_example"))
# 
# anchorList = list(bcat="224321_at",
#                   e2f3="202589_at",
#                   myc="221891_x_at",
#                   ras="201820_at",
#                   src="224567_x_at")
# excludeList = list(bcat="1555340_x_at",
#                    e2f3="1555340_x_at",
#                    myc="1555340_x_at",
#                    ras="204748_at",
#                    src="1555339_at")
# 
# assign.wrapper(trainingData=trainingData1, testData=testData1,
#                trainingLabel=trainingLabel1, testLabel=NULL,
#                geneList=geneList1, n_sigGene=NULL, adaptive_B=TRUE,
#                adaptive_S=TRUE, mixture_beta=TRUE,
#                outputDir=file.path(tempdir, "anchor_exclude_example"),
#                anchorGenes=anchorList, excludeGenes=excludeList,
#                iter=2000, burn_in=1000)

## ----gfrn-optimization-dl, eval=FALSE, results='hide'-------------------------
# dir.create(file.path(tempdir, "optimization_example"))
# setwd(file.path(tempdir, "optimization_example"))
# 
# testData <- read.table("https://drive.google.com/uc?authuser=0&id=1mJICN4z_aCeh4JuPzNfm8GR_lkJOhWFr&export=download",
#                        sep='\t', row.names=1, header=1)
# 
# corData1 <- read.table("https://drive.google.com/uc?authuser=0&id=1MDWVP2jBsAAcMNcNFKE74vYl-orpo7WH&export=download",
#                       sep='\t', row.names=1, header=1)

## ----gfrn-optimization-cor, eval=FALSE, results='hide'------------------------
# #this is a list of pathways and columns in the correlation data that will
# #be used for correlation
# corList <- list(akt=c("Akt","PDK1","PDK1p241"))

## ----gfrn-optimization-optimize, eval=FALSE, results='hide'-------------------
# #run the batch correction procedure between the test and training data
# combat.data <- ComBat.step2(testData, pcaPlots = TRUE)
# 
# #run the default optimization procedure
# optimization_results <- optimizeGFRN(combat.data, corData,
#                                      corList, run="akt")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

