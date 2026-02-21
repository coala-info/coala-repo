# Code example from 'MethPed-vignette' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
## Data Structure

## ----include=FALSE------------------------------------------------------------
## Data Structure
library(MethPed)
data(MethPed_sample)
MethPed_sample_v1<- MethPed_sample

## ----echo=FALSE---------------------------------------------------------------
head(MethPed_sample_v1)

## -----------------------------------------------------------------------------
## Data class

## ----echo=FALSE---------------------------------------------------------------
class(MethPed_sample_v1)

## ----include=FALSE------------------------------------------------------------
library(Biobase)

## -----------------------------------------------------------------------------
## Data Structure

## ----echo=FALSE---------------------------------------------------------------
MethPed_sample_v2<-Biobase::exprs(MethPed_sample)
head(MethPed_sample_v2)

## -----------------------------------------------------------------------------
## Data class

## ----echo=FALSE---------------------------------------------------------------
class(MethPed_sample_v2)

## -----------------------------------------------------------------------------
## Data Structure

## ----echo=FALSE---------------------------------------------------------------
MethPed_sample_v3 <- data.frame(MethPed_sample_v2)
MethPed_sample_v3$TargetID <- rownames(MethPed_sample_v3)
rownames(MethPed_sample_v3) <-NULL
head(MethPed_sample_v3)

## -----------------------------------------------------------------------------
## Data class

## ----echo=FALSE---------------------------------------------------------------
class(MethPed_sample_v3)

## -----------------------------------------------------------------------------
# List of 900 probes in predictors
library(MethPed)
data(MethPed_900probes)
head(MethPed_900probes)

## ----Loading_package_and_data-------------------------------------------------
# Loading package
library(MethPed)
# Loading data set
data(MethPed_sample)
head(MethPed_sample)
class(MethPed_sample)

## ----Check_missing_probe_data, echo=TRUE--------------------------------------
## Check for missing value 
missingIndex <- checkNA(MethPed_sample)
missingIndex

## ----include=FALSE------------------------------------------------------------
set.seed(1000)

## ----Run_MethPed_classifier, echo=TRUE, message=TRUE, warning=FALSE-----------
# Run the MethPed classifier
myClassification <- MethPed(MethPed_sample)

## ----Output_of_Methped_classifier---------------------------------------------
myClassification

## ----MethPed_classifier_output_description_1-3--------------------------------
# First part
myClassification$target_id
# Second part
myClassification$probes
# Third part
myClassification$sample

## ----MethPed_classifier_output_description_4----------------------------------
# Fourth part
myClassification$probes_missing

## ----MethPed_classifier_output_description_5----------------------------------
# Fifth part
myClassification$oob_err.rate

## ----MethPed_classifier_output_description_6----------------------------------
# Sixth part
myClassification$predictions

## ----Summary_of_MethPed_classifier_1------------------------------------------
summary(myClassification)

## ----include=FALSE------------------------------------------------------------
set.seed(1000)

## ----include=FALSE------------------------------------------------------------
myClassification_max <- MethPed(MethPed_sample,prob=FALSE)

## ----echo=FALSE---------------------------------------------------------------
summary(myClassification_max)

## ----MethPed_bar_plot_custom_code---------------------------------------------
par(mai = c(1, 1, 1, 2), xpd=TRUE)
mat<-t(myClassification$predictions)
mycols <- c("green",rainbow(nrow(mat),start=0,end=1)[nrow(mat):1],"red")
barplot(mat,  col = mycols,
                beside=FALSE,axisnames=TRUE,
                ylim=c(0,1),xlab= "Sample",ylab="Probability")
legend( ncol(mat)+0.5,1,
          legend = rownames(mat),fill = mycols,xpd=TRUE, cex = 0.6)

## ----MethPed_bar_plot_generic_function_TRUE, echo=FALSE-----------------------
plot(myClassification)

## ----MethPed_bar_plot_generic_function_FALSE, echo=FALSE----------------------
plot(myClassification_max)

## ----Function_to_get_missing_probes-------------------------------------------
probeMis(myClassification)

## -----------------------------------------------------------------------------
# Loading dataset
data(MethPed_sample)
class(MethPed_sample)

## ----include=FALSE------------------------------------------------------------
library(Biobase)

## ----echo=FALSE---------------------------------------------------------------
MethPed_sample_matrix<-Biobase::exprs(MethPed_sample)
head(MethPed_sample_matrix)

## -----------------------------------------------------------------------------
class(MethPed_sample_matrix)

## -----------------------------------------------------------------------------
checkNA(MethPed_sample_matrix)

## -----------------------------------------------------------------------------
MethPed_sample_missing<-MethPed_sample_matrix
MethPed_sample_missing[c(1,10,200),2]<-NA
MethPed_sample_missing[c(4,600,500,1000),1]<-NA
head(MethPed_sample_missing,10)

## -----------------------------------------------------------------------------
checkNA(MethPed_sample_missing)

## ----Delete_random_seed-------------------------------------------------------
if(exists(".Random.seed")) rm(.Random.seed)

## ----include=FALSE------------------------------------------------------------
library(impute)
imputedData <- impute.knn(MethPed_sample_missing)

## ----Combine_probe_name_with_impoted_data, include=FALSE----------------------
imputedData <- imputedData$data

## ----echo=FALSE---------------------------------------------------------------
checkNA(imputedData)

## ----include=FALSE------------------------------------------------------------
set.seed(1000)

## ----include=FALSE------------------------------------------------------------
myClassification <- MethPed(imputedData)

## ----echo=FALSE---------------------------------------------------------------
summary(myClassification)

## -----------------------------------------------------------------------------
citation('MethPed')

## -----------------------------------------------------------------------------
sessionInfo()

