# Code example from 'modeling' vignette. See references/ for full tutorial.

## ----model0, include=FALSE----------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)

## ----model1, message=FALSE, warning=FALSE-------------------------------------
library(sesame)
library(SummarizedExperiment)
sesameDataCache() # required at new sesame installation

## ----model2, message=FALSE----------------------------------------------------
se = sesameDataGet("MM285.10.SE.tissue")[1:1000,] # an arbitrary 1000 CpGs
cd = as.data.frame(colData(se)); rownames(cd) = NULL
cd

## ----model3-------------------------------------------------------------------
se_ok = (checkLevels(assay(se), colData(se)$sex) &
    checkLevels(assay(se), colData(se)$tissue))
sum(se_ok)                      # the number of CpGs that passes
se = se[se_ok,]

## ----model4-------------------------------------------------------------------
colData(se)$tissue <- relevel(factor(colData(se)$tissue), "Colon")
colData(se)$sex <- relevel(factor(colData(se)$sex), "Female")

## ----model5-------------------------------------------------------------------
smry = DML(se, ~tissue + sex)
smry

## ----model6-------------------------------------------------------------------
test_result = summaryExtractTest(smry)
colnames(test_result) # the column names, show four groups of statistics
head(test_result)

## ----model7, message = FALSE--------------------------------------------------
library(dplyr)
library(tidyr)
test_result %>% dplyr::filter(FPval_sex < 0.05, Eff_sex > 0.1) %>%
    select(FPval_sex, Eff_sex)

## ----model8-------------------------------------------------------------------
test_result %>%
    mutate(sex_specific =
        ifelse(FPval_sex < 0.05 & Eff_sex > 0.1, TRUE, FALSE)) %>%
    mutate(tissue_specific =
        ifelse(FPval_tissue < 0.05 & Eff_tissue > 0.1, TRUE, FALSE)) %>%
    select(sex_specific, tissue_specific) %>% table

## ----model9-------------------------------------------------------------------
library(ggplot2)
ggplot(test_result) + geom_point(aes(Est_sexMale, -log10(Pval_sexMale)))

## ----model10------------------------------------------------------------------
ggplot(test_result) + geom_point(aes(Est_tissueFat, -log10(Pval_tissueFat)))

## ----model11------------------------------------------------------------------
smry2 = DML(se, ~ age + sex)
test_result2 = summaryExtractTest(smry2) %>% arrange(Est_age)

## ----model12------------------------------------------------------------------
test_result2 %>% dplyr::select(Probe_ID, Est_age, Pval_age) %>% tail
df = data.frame(Age = colData(se)$age,
    BetaValue = assay(se)[test_result2$Probe_ID[nrow(test_result2)],])
ggplot(df, aes(Age, BetaValue)) + geom_smooth(method="lm") + geom_point()

## ----model13, eval=TRUE-------------------------------------------------------
dmContrasts(smry)                       # pick a contrast from below
merged = DMR(se, smry, "sexMale", platform="MM285") # merge CpGs to regions
merged %>% dplyr::filter(Seg_Pval_adj < 0.01)

## -----------------------------------------------------------------------------
sessionInfo()

