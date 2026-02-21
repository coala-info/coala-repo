# Code example from 'methylclock' vignette. See references/ for full tutorial.

## ----setup_knitr, include=FALSE-----------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE,
                            cache=FALSE, comment = " ")
options(timeout = 300)

## ----install_req_packages, eval=FALSE-----------------------------------------
# install.packages(c("tidyverse", "impute", "Rcpp"))

## ----install_packages, eval=FALSE---------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#                         install.packages("BiocManager")
# 
# BiocManager::install("methylclock")

## ----load_package-------------------------------------------------------------
library(methylclockData)
library(methylclock)

## ----load_others, eval=TRUE---------------------------------------------------
library(Biobase)
library(tibble)
library(impute)
library(ggplot2)
library(ggpmisc)
library(GEOquery)

## ----check--------------------------------------------------------------------
# Get TestDataset data
TestDataset <- get_TestDataset()

cpgs.missing <- checkClocks(TestDataset)

## ----checkGA------------------------------------------------------------------
cpgs.missing.GA <- checkClocksGA(TestDataset)

## ----showMissing--------------------------------------------------------------
names(cpgs.missing)

## ----showMissNames------------------------------------------------------------
commonClockCpgs(cpgs.missing, "Hannum" )

commonClockCpgs(cpgs.missing.GA, "Bohlin" )


## ----load_horvath_example-----------------------------------------------------
library(tidyverse)
MethylationData <- get_MethylationDataExample()
MethylationData

## ----DNAmAge_horvath, warning=TRUE--------------------------------------------
age.example55 <- DNAmAge(MethylationData)
age.example55

## ----show_cpg_miss------------------------------------------------------------
missCpGs <- checkClocks(MethylationData)

## ----DNAmAgemp_horvath, warning=TRUE------------------------------------------
age.example55.2 <- DNAmAge(MethylationData, min.perc = 0.25)
age.example55.2

## ----DNAmAge_horvath_sel, warning=TRUE----------------------------------------
age.example55.sel <- DNAmAge(MethylationData, clocks=c("Horvath", "BNN"))
age.example55.sel

## ----covariates_horvath_example-----------------------------------------------
library(tidyverse)
path <- system.file("extdata", package = "methylclock")
covariates <- read_csv(file.path(path, "SampleAnnotationExample55.csv"))
covariates

## ----age_horvath_example------------------------------------------------------
age <- covariates$Age
head(age)

## ----DNAmAge_horvath_cell, warning=TRUE---------------------------------------
age.example55 <- DNAmAge(MethylationData, age=age, cell.count=TRUE)
age.example55

## ----compare_autistic---------------------------------------------------------
autism <- covariates$diseaseStatus
kruskal.test(age.example55$ageAcc.Horvath ~ autism)
kruskal.test(age.example55$ageAcc2.Horvath ~ autism)
kruskal.test(age.example55$ageAcc3.Horvath ~ autism)

## ----get_gse58045, echo=FALSE-------------------------------------------------
# ff <- "c:/juan/CREAL/BayesianPrediction/Bayesian_clock/paper"
# load(file.path(ff, "data/GSE58045.Rdata"))

## ----get_geo_gse58045, eval=TRUE----------------------------------------------
# To avoid connection buffer size 
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 10)

# Download data
dd <- GEOquery::getGEO("GSE58045")
gse58045 <- dd[[1]]

# Restore connection buffer size
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072)

## ----show_gse58045------------------------------------------------------------
gse58045

## ----age_gse58045-------------------------------------------------------------
pheno <- pData(gse58045)
age <- as.numeric(pheno$`age:ch1`)

## ----DNAmAge_gse58045, warning=TRUE-------------------------------------------
age.gse58045 <- DNAmAge(gse58045, age=age)
age.gse58045

## ----horvat_age---------------------------------------------------------------
plotDNAmAge(age.gse58045$Horvath, age)

## ----bnn_age------------------------------------------------------------------
plotDNAmAge(age.gse58045$BNN, age, tit="Bayesian Neural Network")

## ----get_gse19711, echo=FALSE-------------------------------------------------
# ff <- "c:/juan/CREAL/BayesianPrediction/Bayesian_clock/paper"
# load(file.path(ff, "data/GSE19711.Rdata"))

## ----get_geo_gse19711, eval=TRUE----------------------------------------------
# To avoid connection buffer size 
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 10)

# Download data
dd <- GEOquery::getGEO("GSE19711")
gse19711 <- dd[[1]]

# Restore connection buffer size
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072)

## ----show_gse19711------------------------------------------------------------
gse19711

## ----get_case_control---------------------------------------------------------
pheno <- pData(gse19711)
age <- as.numeric(pheno$`ageatrecruitment:ch1`)
disease <- pheno$`sample type:ch1`
table(disease)
disease[grep("Control", disease)] <- "Control"
disease[grep("Case", disease)] <- "Case"
disease <- factor(disease, levels=c("Control", "Case"))
table(disease)

## ----DNAmAge_gse19711, warning=TRUE-------------------------------------------
age.gse19711 <- DNAmAge(gse19711, age=age)

## ----show_age.gse19711--------------------------------------------------------
age.gse19711

## ----assoc_hpv----------------------------------------------------------------
mod.horvath1 <- glm(disease ~ ageAcc.Horvath , 
                    data=age.gse19711,
                    family="binomial")
summary(mod.horvath1)

mod.skinHorvath <- glm(disease ~ ageAcc2.Horvath , 
                       data=age.gse19711,
                       family="binomial")
summary(mod.skinHorvath)

mod.horvath3 <- glm(disease ~ ageAcc3.Horvath , 
                    data=age.gse19711,
                    family="binomial")
summary(mod.horvath3)

## ----mod_levine---------------------------------------------------------------
mod.levine1 <- glm(disease ~ ageAcc.Levine , data=age.gse19711,
                    family="binomial")
summary(mod.levine1)

mod.levine2 <- glm(disease ~ ageAcc2.Levine , data=age.gse19711,
                    family="binomial")
summary(mod.levine2)

mod.levine3 <- glm(disease ~ ageAcc3.Levine , data=age.gse19711,
                    family="binomial")
summary(mod.levine3)

## ----assoc_cell---------------------------------------------------------------
cell <- attr(age.gse19711, "cell_proportion")
mod.cell <- glm(disease ~ ageAcc.Levine + cell, data=age.gse19711,
                    family="binomial")
summary(mod.cell)

## ----get_gse109446, echo=FALSE------------------------------------------------
# ff <- "c:/juan/CREAL/BayesianPrediction/Bayesian_clock/paper"
# load(file.path(ff, "data/GSE109446.Rdata"))

## ----get_geo_109446, eval=TRUE------------------------------------------------
dd <- GEOquery::getGEO("GSE109446")
gse109446 <- dd[[1]]

## ----age_gse109446, warning=TRUE----------------------------------------------
controls <- pData(gse109446)$`diagnosis:ch1`=="control"
gse <- gse109446[,controls]
age <- as.numeric(pData(gse)$`age:ch1`)
age.gse <- DNAmAge(gse, age=age)

## ----plotClocks---------------------------------------------------------------
plotCorClocks(age.gse)

## ----load_3_inds--------------------------------------------------------------
TestDataset[1:5,]

## ----age_test, warning=TRUE---------------------------------------------------
ga.test <- DNAmGA(TestDataset)
ga.test

## ----get_progress-------------------------------------------------------------
data(progress_data)

## ----progressClin-------------------------------------------------------------
data(progress_vars)

## ----age_progress, warning=TRUE-----------------------------------------------
ga.progress <- DNAmGA(progress_data)
ga.progress

## ----plot_progress------------------------------------------------------------
plotDNAmAge(ga.progress$Knight, progress_vars$EGA, 
            tit="GA Knight's method", 
            clock="GA")

## ----plotAcc------------------------------------------------------------------
library(ggplot2)
progress_vars$acc <- ga.progress$Knight - progress_vars$EGA
p <- ggplot(data=progress_vars, aes(x = acc, y = birthweight)) +
    geom_point() +
    geom_smooth(method = "lm", se=FALSE, color="black") +
    xlab("GA acceleration") +
    ylab("Birthweight (kgs.)") 
p

## ----acccelerated_ga, warning=TRUE--------------------------------------------
accga.progress <- DNAmGA(progress_data, 
                        age = progress_vars$EGA, 
                        cell.count=FALSE)
accga.progress


## ----check_clocks_2-----------------------------------------------------------
checkClocksGA(progress_data)

## ----plotCorClockHealth-------------------------------------------------------
plotCorClocks(age.gse58045)

