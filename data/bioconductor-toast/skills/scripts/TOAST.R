# Code example from 'TOAST' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("TOAST")

## ----quick_start, eval = FALSE------------------------------------------------
# Design_out <- makeDesign(design, Prop)
# fitted_model <- fitModel(Design_out, Y_raw)
# fitted_model$all_coefs # list all phenotype names
# fitted_model$all_cell_types # list all cell type names
# # coef should be one of above listed phenotypes
# # cell_type should be one of above listed cell types
# res_table <- csTest(fitted_model, coef = "age",
#                     cell_type = "Neuron", contrast_matrix = NULL)
# head(res_table)

## ----loadData-----------------------------------------------------------------
library(TOAST)
data("RA_100samples")
Y_raw <- RA_100samples$Y_raw
Pheno <- RA_100samples$Pheno
Blood_ref <- RA_100samples$Blood_ref

## ----checkData----------------------------------------------------------------
dim(Y_raw) 
Y_raw[1:4,1:4]

## ----checkPheno---------------------------------------------------------------
dim(Pheno)
head(Pheno, 3)

## ----checkRef-----------------------------------------------------------------
dim(Blood_ref)
head(Blood_ref, 3)

## ----loadDataCBS--------------------------------------------------------------
data("CBS_PBMC_array")
CBS_mix <- CBS_PBMC_array$mixed_all
LM_5 <- CBS_PBMC_array$LM_5
CBS_trueProp <- CBS_PBMC_array$trueProp
prior_alpha <- CBS_PBMC_array$prior_alpha
prior_sigma <- CBS_PBMC_array$prior_sigma

## ----checkDataCBS-------------------------------------------------------------
dim(CBS_mix) 
CBS_mix[1:4,1:4]
head(CBS_trueProp, 3)

## ----checkLM5-----------------------------------------------------------------
head(LM_5, 3)

## ----checkPrior---------------------------------------------------------------
prior_alpha
prior_sigma

## ----loadDatabeta-------------------------------------------------------------
data("beta_emp")
Ybeta = beta_emp$Y.raw
ref_m = beta_emp$ref.m

## ----checkDatabeta------------------------------------------------------------
dim(Ybeta) 
Ybeta[1:4,1:4]

## ----checkDataRef-------------------------------------------------------------
head(ref_m, 3)

## ----SelFeature---------------------------------------------------------------
refinx <- findRefinx(Y_raw, nmarker = 1000)

## ----Subset-------------------------------------------------------------------
Y <- Y_raw[refinx,]
Ref <- as.matrix(Blood_ref[refinx,])

## ----DB2----------------------------------------------------------------------
library(EpiDISH)
outT <- epidish(beta.m = Y, ref.m = Ref, method = "RPC")
estProp_RB <- outT$estF

## ----DB3----------------------------------------------------------------------
refinx = findRefinx(Y_raw, nmarker=1000, sortBy = "var")

## ----DF2----------------------------------------------------------------------
refinx <- findRefinx(Y_raw, nmarker = 1000)
Y <- Y_raw[refinx,]

## ----DF3, results='hide', message=FALSE, warning=FALSE------------------------
K <- 6
outT <- myRefFreeCellMix(Y, mu0=myRefFreeCellMixInitialize(Y, K = K))
estProp_RF <- outT$Omega

## ----compareRFRB--------------------------------------------------------------
# first we align the cell types from RF 
# and RB estimations using pearson's correlation
estProp_RF <- assignCellType(input=estProp_RF,
                             reference=estProp_RB) 
mean(diag(cor(estProp_RF, estProp_RB)))

## ----IRB-RFCM1, message=FALSE, warning=FALSE----------------------------------
library(TOAST)

## ----IRB-RFCM2, results='hide', message=FALSE, warning=FALSE------------------
K=6
set.seed(1234)
outRF1 <- csDeconv(Y_raw, K, TotalIter = 30, bound_negative = TRUE) 

## ----IRB-RFCM3, message=FALSE, warning=FALSE----------------------------------
## check the accuracy of deconvolution
estProp_RF_improved <- assignCellType(input=outRF1$estProp,
                                      reference=estProp_RB) 
mean(diag(cor(estProp_RF_improved, estProp_RB)))

## ----initFeature, eval = FALSE------------------------------------------------
# refinx <- findRefinx(Y_raw, nmarker = 1000, sortBy = "cv")
# InitNames <- rownames(Y_raw)[refinx]
# csDeconv(Y_raw, K = 6, nMarker = 1000,
#          InitMarker = InitNames, TotalIter = 30)

## ----eval = FALSE-------------------------------------------------------------
# mydeconv <- function(Y, K){
#      if (is(Y, "SummarizedExperiment")) {
#           se <- Y
#           Y <- assays(se)$counts
#      } else if (!is(Y, "matrix")) {
#           stop("Y should be a matrix
#                or a SummarizedExperiment object!")
#      }
# 
#      if (K<0 | K>ncol(Y)) {
#          stop("K should be between 0 and N (samples)!")
#      }
#      outY = myRefFreeCellMix(Y,
#                mu0=myRefFreeCellMixInitialize(Y,
#                K = K))
#      Prop0 = outY$Omega
#      return(Prop0)
# }
# set.seed(1234)
# outT <- csDeconv(Y_raw, K, FUN = mydeconv, bound_negative = TRUE)

## ----chooseMarker-------------------------------------------------------------
## create cell type list:
CellType <- list(Bcells = 1,
                 CD8T = 2,
                 CD4T = 3,
                 NK = 4,
                 Monocytes = 5)
## choose (up to 20) significant markers 
## per cell type
myMarker <- ChooseMarker(LM_5, 
                         CellType, 
                         nMarkCT = 20,
                         chooseSig = TRUE,
                         verbose = FALSE)
lapply(myMarker, head, 3)

## ----PRFwithoutPrior----------------------------------------------------------
resCBS0 <- MDeconv(CBS_mix, myMarker,
                epsilon = 1e-3, verbose = FALSE)
diag(cor(CBS_trueProp, t(resCBS0$H)))
mean(abs(as.matrix(CBS_trueProp) - t(resCBS0$H)))

## ----manualalpha--------------------------------------------------------------
prior_alpha <- c(0.09475, 0.23471, 0.33232, 0.0969, 0.24132)
prior_sigma <- c(0.09963, 0.14418, 0.16024, 0.10064, 0.14556)
names(prior_alpha) <- c("B cells", "CD8T", "CD4T",
                        "NK cells", "Monocytes")
names(prior_sigma) <- names(prior_alpha) 

## ----getprior-----------------------------------------------------------------
thisprior <- GetPrior("human pbmc")
thisprior

## ----PRFwithPrior-------------------------------------------------------------
resCBS1 <- MDeconv(CBS_mix, myMarker,
                alpha = prior_alpha,
                sigma = prior_sigma,
                epsilon = 1e-3, verbose = FALSE)
diag(cor(CBS_trueProp, t(resCBS1$H)))
mean(abs(as.matrix(CBS_trueProp) - t(resCBS1$H)))

## ----PRFwithPrior2------------------------------------------------------------
resCBS2 <- MDeconv(CBS_mix, myMarker,
                   alpha = "human pbmc",
                   epsilon = 1e-3, verbose = FALSE)
diag(cor(CBS_trueProp, t(resCBS2$H)))
mean(abs(as.matrix(CBS_trueProp) - t(resCBS2$H)))

## ----expKRef,results='hide',message=FALSE, warning=FALSE----------------------
out = Tsisal(Ybeta,K = 4, knowRef = ref_m)
out$estProp[1:3,1:4]
head(out$selMarker)

## ----expAllNULL,results='hide',message=FALSE, warning=FALSE-------------------
out = Tsisal(Ybeta,K = NULL, knowRef = NULL, possibleCellNumber = 2:5)
out$estProp[1:3,1:out$K]
head(out$selMarker)
out$K

## ----expKNULL,results='hide',message=FALSE, warning=FALSE---------------------
out = Tsisal(Ybeta, K = NULL, knowRef = ref_m, possibleCellNumber = 2:5)
out$estProp[1:3,1:out$K]
head(out$selMarker)
out$K

## ----csDE2--------------------------------------------------------------------
head(Pheno, 3)
design <- data.frame(disease = as.factor(Pheno$disease))

Prop <- estProp_RF_improved
colnames(Prop) <- colnames(Ref) 
## columns of proportion matrix should have names


## ----csDE3--------------------------------------------------------------------
Design_out <- makeDesign(design, Prop)

## ----csDE4--------------------------------------------------------------------
fitted_model <- fitModel(Design_out, Y_raw)
# print all the cell type names
fitted_model$all_cell_types
# print all phenotypes
fitted_model$all_coefs

## -----------------------------------------------------------------------------
res_table <- csTest(fitted_model, 
                    coef = "disease", 
                    cell_type = "Gran")
head(res_table, 3)
Disease_Gran_res <- res_table

## ----eval = FALSE-------------------------------------------------------------
# res_table <- csTest(fitted_model,
#                     coef = "disease",
#                     cell_type = "joint")
# head(res_table, 3)

## ----joint, eval = FALSE------------------------------------------------------
# res_table <- csTest(fitted_model,
#                     coef = "disease",
#                     cell_type = NULL)
# lapply(res_table, head, 3)
# 
# ## this is exactly the same as
# res_table <- csTest(fitted_model, coef = "disease")

## ----eval = T, fig.align='default', fig.height=9,fig.width=11-----------------
res_table <- csTest(fitted_model, coef = "disease",verbose = F)
pval.all <- matrix(NA, ncol= 6, nrow= nrow(Y_raw))
feature.name <- rownames(Y_raw)
rownames(pval.all) = feature.name
colnames(pval.all) = names(res_table)[1:6]
for(cell.ix in 1:6){
  pval.all[,cell.ix] <- res_table[[cell.ix]][feature.name,'p_value']
}
plotCorr(pval = pval.all, pval.thres = 0.05)

## -----------------------------------------------------------------------------
res_cedar <- cedar(Y_raw = Y_raw, prop = Prop, design.1 = design,
                   factor.to.test = 'disease',cutoff.tree = c('pval',0.01),
                   cutoff.prior.prob = c('pval',0.01))

## -----------------------------------------------------------------------------
head(res_cedar$tree_res$full$pp)

## -----------------------------------------------------------------------------
res_cedar$tree_res$full$tree_structure

## -----------------------------------------------------------------------------
res_cedar$tree_res$single$tree_structure

## ----general2-----------------------------------------------------------------
design <- data.frame(age = Pheno$age,
                     gender = as.factor(Pheno$gender),
                     disease = as.factor(Pheno$disease))

Prop <- estProp_RF_improved
colnames(Prop) <- colnames(Ref)  
## columns of proportion matrix should have names

## ----general3-----------------------------------------------------------------
Design_out <- makeDesign(design, Prop)

## ----general4-----------------------------------------------------------------
fitted_model <- fitModel(Design_out, Y_raw)
# print all the cell type names
fitted_model$all_cell_types
# print all phenotypes
fitted_model$all_coefs

## ----general5-----------------------------------------------------------------
res_table <- csTest(fitted_model, 
                    coef = "age", 
                    cell_type = "Gran")
head(res_table, 3)

## ----general6-----------------------------------------------------------------
res_table <- csTest(fitted_model, 
                    coef = "disease", 
                    cell_type = "Bcell")
head(res_table, 3)

## -----------------------------------------------------------------------------
res_table <- csTest(fitted_model, 
                    coef = c("gender", 2, 1), 
                    cell_type = "CD4T")
head(res_table, 3)

## ----eval = FALSE-------------------------------------------------------------
# res_table <- csTest(fitted_model,
#                     coef = "age",
#                     cell_type = "joint")
# head(res_table, 3)

## ----eval = FALSE-------------------------------------------------------------
# res_table <- csTest(fitted_model,
#                     coef = "age",
#                     cell_type = NULL)
# lapply(res_table, head, 3)
# 
# ## this is exactly the same as
# res_table <- csTest(fitted_model,
#                     coef = "age")

## ----crossCellType2-----------------------------------------------------------
design <- data.frame(age = Pheno$age,
                     gender = as.factor(Pheno$gender),
                     disease = as.factor(Pheno$disease))

Prop <- estProp_RF_improved
colnames(Prop) <- colnames(Ref)  ## columns of proportion matrix should have names

## ----crossCellType3, eval = FALSE---------------------------------------------
# design <- data.frame(disease = as.factor(rep(0,100)))

## ----crossCellType4-----------------------------------------------------------
Design_out <- makeDesign(design, Prop)

## ----crossCellType5-----------------------------------------------------------
fitted_model <- fitModel(Design_out, Y_raw)
# print all the cell type names
fitted_model$all_cell_types
# print all phenotypes
fitted_model$all_coefs

## -----------------------------------------------------------------------------
test <- csTest(fitted_model, 
               coef = c("disease", 1), 
               cell_type = c("CD8T", "Bcell"), 
               contrast_matrix = NULL)
head(test, 3)

## -----------------------------------------------------------------------------
test <- csTest(fitted_model, 
               coef = c("disease", 0), 
               cell_type = c("CD8T", "Bcell"), 
               contrast_matrix = NULL)
head(test, 3)

## -----------------------------------------------------------------------------
test <- csTest(fitted_model, 
               coef = "joint", 
               cell_type = c("Gran", "CD4T"), 
               contrast_matrix = NULL)
head(test, 3)

## -----------------------------------------------------------------------------
test <- csTest(fitted_model, 
               coef = NULL, 
               cell_type = c("Gran", "CD4T"), 
               contrast_matrix = NULL)
lapply(test, head, 3)

## -----------------------------------------------------------------------------
test <- csTest(fitted_model, 
               coef = "disease", 
               cell_type = c("Gran", "CD4T"), 
               contrast_matrix = NULL)
head(test, 3)

## -----------------------------------------------------------------------------
test <- csTest(fitted_model, 
               coef = "gender", 
               cell_type = c("Gran", "CD4T"), 
               contrast_matrix = NULL)
head(test, 3)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

