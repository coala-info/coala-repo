# Code example from 'BUScorrect_user_guide' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----data_preparation1-----------------------------------------------------
library(BUScorrect)
data("BUSexample_data", package="BUScorrect")

#BUSexample_data is a list
class(BUSexample_data)

#The list's length is three, thus we have three batches
length(BUSexample_data)

#Each element of the list is a matrix 
class(BUSexample_data[[1]])

#In the matrix, a row is a gene, and a column corresponds to a sample
dim(BUSexample_data[[1]])
dim(BUSexample_data[[2]])
dim(BUSexample_data[[3]])

#Look at the expression data
head(BUSexample_data[[1]][ ,1:4])

## ----data_preparation2-----------------------------------------------------
#require the SummarizedExperiment from Bioconductor
require(SummarizedExperiment)

#batch number
B <- length(BUSexample_data)

#sample size vector 
n_vec <- sapply(1:B, function(b){ 
						ncol(BUSexample_data[[b]])})

#gene expression matrix						
GE_matr <- NULL
for(b in 1:B){
	GE_matr <- cbind(GE_matr, BUSexample_data[[b]])
} 
rownames(GE_matr) <- NULL
colnames(GE_matr) <- NULL

#batch information
Batch <- NULL
for(b in 1:B){
	Batch <- c(Batch, rep(b, n_vec[b]))
}

#column data frame
colData <- DataFrame(Batch = Batch)

#construct a SummarizedExperiment object
BUSdata_SumExp <- SummarizedExperiment(assays=list(GE_matr=GE_matr), colData=colData)

head(assays(BUSdata_SumExp)$GE_matr[ ,1:4])

head(colData(BUSdata_SumExp)$Batch)

## ----BUSgibbs--------------------------------------------------------------
#For R list input format
set.seed(123)
BUSfits <- BUSgibbs(Data = BUSexample_data, n.subtypes = 3, n.iterations = 300, 
						showIteration = FALSE)
						
#For SummarizedExperiment object input format
#set.seed(123)
#BUSfits_SumExp <- BUSgibbs(Data = BUSdata_SumExp, n.subtypes = 3, n.iterations = 300, 
#						showIteration = FALSE)

## ----BUSfits---------------------------------------------------------------
summary(BUSfits)

## ----Subtypes--------------------------------------------------------------
est_subtypes <- Subtypes(BUSfits)

## ----BatchEffects----------------------------------------------------------
est_location_batch_effects <- location_batch_effects(BUSfits)
head(est_location_batch_effects)
est_scale_batch_effects <- scale_batch_effects(BUSfits)
head(est_scale_batch_effects)

## ----SubtypeEffects--------------------------------------------------------
est_subtype_effects <- subtype_effects(BUSfits)

## ----IG--------------------------------------------------------------------
#select posterior probability threshold to identify the intrinsic gene indicators
thr0 <- postprob_DE_thr_fun(BUSfits, fdr_threshold=0.01)
est_L <- estimate_IG_indicators(BUSfits, postprob_DE_threshold=thr0)

#obtain the intrinsic gene indicators
intrinsic_gene_indices <- IG_index(est_L)

## --------------------------------------------------------------------------
postprob_DE_matr <- postprob_DE(BUSfits)

## ----adjusted--------------------------------------------------------------
adjusted_data <- adjusted_values(BUSfits, BUSexample_data)

## ----visualize1------------------------------------------------------------
#only show the first 100 genes
visualize_data(BUSexample_data, title_name = "original expression values", 
								gene_ind_set = 1:100) 

#try the following command to show the whole set of genes
#visualize_data(BUSexample_data, title_name = "original expression values", 
#								gene_ind_set = 1:2000) 

## ----visualize2------------------------------------------------------------
#only show the first 100 genes
visualize_data(adjusted_data, title_name = "adjusted expression values", 
								gene_ind_set = 1:100) 
								
#try the following command to show the whole set of genes
#visualize_data(adjusted_data, title_name = "adjusted expression values", 
#								gene_ind_set = 1:2000) 

## ----bic-------------------------------------------------------------------
BIC_val <- BIC_BUS(BUSfits)

## ----selection-------------------------------------------------------------
BIC_values <- NULL
for(k in 2:4){
	set.seed(123)
	BUSfits <- BUSgibbs(Data = BUSexample_data, n.subtypes = k, n.iterations = 300, 
						showIteration = FALSE)
	BIC_values <- c(BIC_values, BIC_BUS(BUSfits))
}
plot(2:4, BIC_values, xlab="subtype number", ylab="BIC", main="BIC plot", type="b")

