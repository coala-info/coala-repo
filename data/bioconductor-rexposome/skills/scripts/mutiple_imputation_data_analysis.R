# Code example from 'mutiple_imputation_data_analysis' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(echo = TRUE, warnings=FALSE, crop = NULL)

## ----message=FALSE------------------------------------------------------------
library(rexposome)
library(mice)

## ----files_path---------------------------------------------------------------
path <- file.path(path.package("rexposome"), "extdata")
description <- file.path(path, "description.csv")
phenotype <- file.path(path, "phenotypes.csv")
exposures <- file.path(path, "exposures.csv")

## ----read_csv_files-----------------------------------------------------------
dd <- read.csv(description, header=TRUE, stringsAsFactors=FALSE)
ee <- read.csv(exposures, header=TRUE)
pp <- read.csv(phenotype, header=TRUE)

## ----remove_exposures---------------------------------------------------------
dd <- dd[-which(dd$Family %in% c("Phthalates", "PBDEs", "PFOAs", "Metals")), ]
ee <- ee[ , c("idnum", dd$Exposure)]

## ----check_na-----------------------------------------------------------------
data.frame(
    Set=c("Exposures", "Phenotypes"),
    Count=c(sum(is.na(ee)), sum(is.na(pp)))
)

## ----set_up_imputation--------------------------------------------------------
rownames(ee) <- ee$idnum
rownames(pp) <- pp$idnum

dta <- cbind(ee[ , -1], pp[ , -1])
dta[1:3, c(1:3, 52:56)]

## ----class_imputation---------------------------------------------------------
for(ii in c(1:13, 18:47, 55:56)) {
    dta[, ii] <- as.numeric(dta[ , ii])
}
for(ii in c(14:17, 48:54)) {
    dta[ , ii] <- as.factor(dta[ , ii])
}

## ----mice_imputation, message=FALSE-------------------------------------------
imp <- mice(dta[ , -52], pred = quickpred(dta[ , -52], mincor = 0.2, 
    minpuc = 0.4), seed = 38788, m = 5, maxit = 10, printFlag = FALSE)
class(imp)

## ----extract_non_imputed------------------------------------------------------
me <- complete(imp, action = 0)
me[ , ".imp"] <- 0
me[ , ".id"] <- rownames(me)
dim(me)
summary(me[, c("H_pesticides", "Benzene")])

## ----extract_imputation-------------------------------------------------------
for(set in 1:5) {
    im <- complete(imp, action = set)
    im[ , ".imp"] <- set
    im[ , ".id"] <- rownames(im)
    me <- rbind(me, im)
}
me <- me[ , c(".imp", ".id", colnames(me)[-(97:98)])]
rownames(me) <- 1:nrow(me)
dim(me)

## ----create_imexposomeset-----------------------------------------------------
ex_imp <- loadImputed(data = me, description = dd, 
                       description.famCol = "Family", 
                       description.expCol = "Exposure")

## ----args_load----------------------------------------------------------------
args(loadImputed)

## ----imexposomeset_show-------------------------------------------------------
ex_imp

## ----individuals_names--------------------------------------------------------
head(sampleNames(ex_imp))

## ----exposures_names----------------------------------------------------------
head(exposureNames(ex_imp))

## ----families_names-----------------------------------------------------------
familyNames(ex_imp)

## ----phenotype_names----------------------------------------------------------
phenotypeNames(ex_imp)

## ----exposures_matrix---------------------------------------------------------
head(fData(ex_imp), n = 3)

## ----phenotype----------------------------------------------------------------
head(pData(ex_imp), n = 3)

## ----plot_family_continuous---------------------------------------------------
plotFamily(ex_imp, family = "Organochlorines")

## ----plot_family_categorical--------------------------------------------------
plotFamily(ex_imp, family = "Home Environment")

## ----creating_es--------------------------------------------------------------
ex_1 <- toES(ex_imp, rid = 1)
ex_1

ex_3 <- toES(ex_imp, rid = 3)
ex_3

## ----exwas, warning=FALSE, message=FALSE, warning=FALSE-----------------------
as_iew <- exwas(ex_imp, formula = blood_pre~sex+age, family = "gaussian")
as_iew

## ----plot_exwas, fig.height=7-------------------------------------------------
clr <- rainbow(length(familyNames(ex_imp)))
names(clr) <- familyNames(ex_imp)
plotExwas(as_iew, color = clr)

## ----tef----------------------------------------------------------------------
(thr <- tef(as_iew))

## ----pvalue-------------------------------------------------------------------
tbl <- extract(as_iew)

## ----sig----------------------------------------------------------------------
(sig <- tbl[tbl$pvalue <= thr, ])

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

