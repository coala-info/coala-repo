# Code example from 'exposome_data_analysis' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
BiocStyle::markdown()
options(width=80)
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, tidy = TRUE, crop = NULL)

## ----github, eval=FALSE-------------------------------------------------------
# devtools::install_github("isglobal-brge/rexposome")

## ----library, message=FALSE---------------------------------------------------
library(rexposome)

## ----files_path---------------------------------------------------------------
path <- file.path(path.package("rexposome"), "extdata")
description <- file.path(path, "description.csv")
phenotype <- file.path(path, "phenotypes.csv")
exposures <- file.path(path, "exposures.csv")

## ----ags_read_exposome--------------------------------------------------------
args(readExposome)

## ----read_exposome------------------------------------------------------------
exp <- readExposome(
    exposures = exposures, 
    description = description, 
    phenotype = phenotype,
    exposures.samCol = "idnum", 
    description.expCol = "Exposure", 
    description.famCol = "Family", 
    phenotype.samCol = "idnum"
)

## ----show_es_1----------------------------------------------------------------
exp

## ----ags_load_exposome--------------------------------------------------------
args(loadExposome)

## ----read_csv_files-----------------------------------------------------------
dd <- read.csv(description, header=TRUE)
ee <- read.csv(exposures, header=TRUE)
pp <- read.csv(phenotype, header=TRUE)

## ----set_dd_rownames----------------------------------------------------------
rownames(dd) <- dd[, 2]
dd <- dd[ , -2]

## ----set_ee_rownames----------------------------------------------------------
rownames(ee) <- ee[ , 1]
ee <- ee[ , -1]

## ----set_pp, rownames---------------------------------------------------------
rownames(pp) <- pp[ , 1]
pp <- pp[ , -1]

## ----load_exposome------------------------------------------------------------
exp <- loadExposome(
    exposures = ee, 
    description = dd, 
    phenotype = pp,
    description.famCol = "Family"
)

## ----individuals_names--------------------------------------------------------
head(sampleNames(exp))

## ----exposures_names----------------------------------------------------------
head(exposureNames(exp))

## ----families_names-----------------------------------------------------------
familyNames(exp)

## ----phenotype_names----------------------------------------------------------
phenotypeNames(exp)

## ----feature------------------------------------------------------------------
head(fData(exp), n = 3)

## ----phenotype----------------------------------------------------------------
head(pData(exp), n = 3)

## ----exposures----------------------------------------------------------------
expos(exp)[1:10, c("Cotinine", "PM10V", "PM25", "X5cxMEPP")]

## ----misssing_data_table------------------------------------------------------
tableMissings(exp, set = "exposures", output = "n")
tableMissings(exp, set = "phenotypes", output = "n")

## ----missing_exposures_plot, fig.height=8-------------------------------------
plotMissings(exp, set = "exposures")

## ----normality----------------------------------------------------------------
nm <- normalityTest(exp)
table(nm$normality)

## ----no_normality-------------------------------------------------------------
nm$exposure[!nm$normality]

## ----histogram_cleaning, message=FALSE----------------------------------------
library(ggplot2)
plotHistogram(exp, select = "G_pesticides") +
    ggtitle("Garden Pesticides")

## ----histogram_no_normal, message=FALSE, warning=FALSE------------------------
plotHistogram(exp, select = "BDE209") + 
    ggtitle("BDE209 - Histogram")

## ----histogram_trans, message=FALSE, warning=FALSE----------------------------
plotHistogram(exp, select = "BDE209", show.trans = TRUE)

## ----impute_hmisc-------------------------------------------------------------
exp <- imputation(exp)

## ----plot_all_exposures, fig.height=12, fig.width=8---------------------------
plotFamily(exp, family = "all")

## ----plot_phenols_sex---------------------------------------------------------
plotFamily(exp, family = "Phthalates", group = "sex")

## ----plot_phenols_sex_rhinitis------------------------------------------------
plotFamily(exp, family = "Phthalates", group = "rhinitis", group2 = "rhinitis")

## ----standardize, warning=FALSE-----------------------------------------------
exp_std <- standardize(exp, method = "normal")
exp_std

## ----pca----------------------------------------------------------------------
# FAMD
exp_pca <- pca(exp_std)

# PCA
exp_pca <- pca(exp_std, pca = TRUE)

## ----plot_pca_all-------------------------------------------------------------
plotPCA(exp_pca, set = "all")

## ----plot_pca_samples---------------------------------------------------------
plotPCA(exp_pca, set = "samples", phenotype = "sex")

## ----plot_pca_samples_3d------------------------------------------------------
plot3PCA(exp_pca, cmpX=1, cmpY=2, cmpZ=3, phenotype = "sex")

## ----correlation, warning=FALSE, message=FALSE--------------------------------
exp_cr <- correlation(exp, use = "pairwise.complete.obs", method.cor = "pearson")

## ----extract_correlation------------------------------------------------------
extract(exp_cr)[1:4, 1:4]

## ----correlation_circos, fig.width=8, fig.height=8----------------------------
plotCorrelation(exp_cr, type = "circos")

## ----correlation_matrix, fig.width=7, fig.height=7----------------------------
plotCorrelation(exp_cr, type = "matrix")

## ----clustering_args----------------------------------------------------------
args(clustering)

## ----hclust_function----------------------------------------------------------
hclust_data <- function(data, ...) {
    hclust(d = dist(x = data), ...)
}

## ----hclus_k3-----------------------------------------------------------------
hclust_k3 <- function(result) {
    cutree(result, k = 3)
}

## ----expo_clustering----------------------------------------------------------
exp_c <- clustering(exp, method = hclust_data, cmethod = hclust_k3)
exp_c

## ----plot_clustering, fig.width=12, fig.height=15-----------------------------
plotClassification(exp_c)

## ----classification_clustering------------------------------------------------
table(classification(exp_c))

## ----plot_pca_exp_cor, fig.width=7, fig.height=12, message=FALSE, warning=FALSE----
plotEXP(exp_pca) + theme(axis.text.y = element_text(size = 6.5)) + ylab("")

## ----plot_pca_phe_ass, fig.width=7, fig.height=4, message=FALSE, warning=FALSE----
plotPHE(exp_pca)

## ----exwas_flu, warning=FALSE, message=FALSE----------------------------------
fl_ew <- exwas(exp, formula = blood_pre~sex+age, family = "gaussian")
fl_ew

## ----exwas_wheezing, warning=FALSE, message=FALSE-----------------------------
we_ew <- exwas(exp, formula = wheezing~sex+age, family = "binomial")
we_ew

## ----exwas_extrat-------------------------------------------------------------
head(extract(fl_ew))

## ----exwas_plot, warning=FALSE, fig.width=10, fig.height=12, message=FALSE----
clr <- rainbow(length(familyNames(exp)))
names(clr) <- familyNames(exp)
plotExwas(fl_ew, we_ew, color = clr) + 
      ggtitle("Exposome Association Study - Univariate Approach")


## ----exwas_effect_plot, warning=FALSE, fig.width=8, fig.height=10, message=FALSE----
plotEffect(fl_ew)

## ----stratified_exwas---------------------------------------------------------
strat_variable <- "sex"
formula <- cbmi ~ 1
family <- "gaussian"

strat_ex <- lapply(levels(as.factor(pData(exp)[[strat_variable]])), function(i){
      mask <- pData(exp)[[strat_variable]]==i
      exwas_i <- rexposome::exwas(exp[,mask], formula = formula,
                                  family = family, tef = FALSE)
      exwas_i@formula <- update.formula(exwas_i@formula, 
                                        as.formula(paste0("~ . + strata(", strat_variable, 
                                                          "_", gsub("[[:space:]]|-|+|(|)", "", i), ")")))
      return(exwas_i)
    })

## ----stratified_exwas_plot, fig.width=8, fig.height=10------------------------
do.call(plotExwas, strat_ex)

## ----inverse_exwas------------------------------------------------------------
inv_ex <- invExWAS(exp, formula = ~ flu + sex)
inv_ex

## ----inverse_exwas_extract----------------------------------------------------
head(extract(inv_ex))

## ----inveres_exwas_plot-------------------------------------------------------
clr <- rainbow(length(familyNames(exp)))
names(clr) <- familyNames(exp)
plotExwas(inv_ex, color = clr) + ggtitle("Inverse Exposome Association Study - Univariate Approach")

## ----enet, warning=FALSE------------------------------------------------------
bl_mew <- mexwas(exp_std, phenotype = "blood_pre", family = "gaussian")
we_mew <- mexwas(exp_std, phenotype = "wheezing", family = "binomial")

## ----plot_enet_heatmap, fig.width=10, fig.height=12---------------------------
plotExwas(bl_mew, we_mew) + ylab("") +
        ggtitle("Exposome Association Study - Multivariate Approach")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

