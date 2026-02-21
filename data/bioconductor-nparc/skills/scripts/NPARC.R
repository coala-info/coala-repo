# Code example from 'NPARC' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----dependencies, message=FALSE----------------------------------------------
library(dplyr)
library(magrittr)
library(ggplot2)
library(broom)
library(knitr)
library(NPARC)

## ----load_data----------------------------------------------------------------
data("stauro_TPP_data_tidy")

## -----------------------------------------------------------------------------
df <- stauro_TPP_data_tidy

## ----data_head----------------------------------------------------------------
df %>% 
  mutate(compoundConcentration = factor(compoundConcentration), 
         replicate = factor(replicate), 
         dataset = factor(dataset)) %>% 
  summary()


## ----filter_qupm_or_NAs, results='asis'---------------------------------------
df %<>% filter(uniquePeptideMatches >= 1)
df %<>% filter(!is.na(relAbundance))

## ----count_curves_per_protein-------------------------------------------------
# Count full curves per protein
df %<>%
  group_by(dataset, uniqueID) %>%
  mutate(n = n()) %>%
  group_by(dataset) %>%
  mutate(max_n = max(n)) %>% 
  ungroup

table(distinct(df, uniqueID, n)$n)

## -----------------------------------------------------------------------------
# Filter for full curves per protein:
df %<>% 
  filter(n == max_n) %>%
  dplyr::select(-n, -max_n)

## ----select_stk4--------------------------------------------------------------
stk4 <- filter(df, uniqueID == "STK4_IPI00011488")

## -----------------------------------------------------------------------------
stk4 %>% filter(compoundConcentration == 20, replicate == 1) %>% 
  dplyr::select(-dataset) %>% kable(digits = 2)

## ----plot_stk4----------------------------------------------------------------
stk4_plot_orig <- ggplot(stk4, aes(x = temperature, y = relAbundance)) +
  geom_point(aes(shape = factor(replicate), color = factor(compoundConcentration)), size = 2) +
  theme_bw() +
  ggtitle("STK4") +
  scale_color_manual("staurosporine (mu M)", values = c("#808080", "#da7f2d")) +
  scale_shape_manual("replicate", values = c(19, 17))

print(stk4_plot_orig)

## ----fit_null_stk4------------------------------------------------------------
nullFit <- NPARC:::fitSingleSigmoid(x = stk4$temperature, y = stk4$relAbundance)

## ----summarize_null_stk4------------------------------------------------------
summary(nullFit)

## ----augment_null_stk4--------------------------------------------------------
nullPredictions <- broom::augment(nullFit)

## ----head_augment_result------------------------------------------------------
nullPredictions %>% filter(x %in% c(46, 49)) %>% kable()

## ----add_null_resids_stk4-----------------------------------------------------
stk4$nullPrediction <- nullPredictions$.fitted
stk4$nullResiduals <- nullPredictions$.resid

stk4_plot <- stk4_plot_orig + geom_line(data = stk4, aes(y = nullPrediction))

print(stk4_plot)

## ----fit_alternative_stk4-----------------------------------------------------
alternativePredictions <- stk4 %>%
# Fit separate curves per treatment group:
  group_by(compoundConcentration) %>%
  do({
    fit = NPARC:::fitSingleSigmoid(x = .$temperature, y = .$relAbundance, start=c(Pl = 0, a = 550, b = 10))
    broom::augment(fit)
  }) %>%
  ungroup %>%
  # Rename columns for merge to data frame:
  dplyr::rename(alternativePrediction = .fitted,
                alternativeResiduals = .resid,
                temperature = x,
                relAbundance = y)

## ----add_alternative_resids_stk4----------------------------------------------
stk4 <- stk4 %>%
  left_join(alternativePredictions, 
            by = c("relAbundance", "temperature", 
                   "compoundConcentration")) %>%
  distinct()

## ----plot_Fig_2_A_B-----------------------------------------------------------
stk4_plot <- stk4_plot +
  geom_line(data = distinct(stk4, temperature, compoundConcentration, alternativePrediction), 
            aes(y = alternativePrediction, color = factor(compoundConcentration)))

print(stk4_plot)

## ----compute_rss_stk4---------------------------------------------------------
rssPerModel <- stk4 %>%
  summarise(rssNull = sum(nullResiduals^2),
            rssAlternative = sum(alternativeResiduals^2))

kable(rssPerModel, digits = 4)

## -----------------------------------------------------------------------------
BPPARAM <- BiocParallel::SerialParam(progressbar = FALSE)

## ----fit_all_proteins---------------------------------------------------------
fits <- NPARCfit(x = df$temperature, 
                 y = df$relAbundance, 
                 id = df$uniqueID, 
                 groupsNull = NULL, 
                 groupsAlt = df$compoundConcentration, 
                 BPPARAM = BPPARAM,
                 returnModels = FALSE)

str(fits, 1)

## ----show_fit_results---------------------------------------------------------
fits$metrics %>% 
  mutate(modelType = factor(modelType), nCoeffs = factor(nCoeffs), nFitted = factor(nFitted), group = factor((group))) %>% 
  summary

fits$predictions %>% 
  mutate(modelType = factor(modelType), group = factor((group))) %>% 
  summary

## ----show_stk4_results--------------------------------------------------------
stk4Metrics <- filter(fits$metrics, id == "STK4_IPI00011488")

rssNull <- filter(stk4Metrics, modelType == "null")$rss
rssAlt <- sum(filter(stk4Metrics, modelType == "alternative")$rss) # Summarize over both experimental groups

rssNull
rssAlt

## ----plot_stk4_results--------------------------------------------------------
stk4Predictions <- filter(fits$predictions, modelType == "alternative", id == "STK4_IPI00011488")

stk4_plot_orig +
  geom_line(data = filter(stk4Predictions, modelType == "alternative"), 
            aes(x = x, y = .fitted, color = factor(group))) +
    geom_line(data = filter(stk4Predictions, modelType == "null"), 
            aes(x = x, y = .fitted))

## ----testDOFiid---------------------------------------------------------------
modelMetrics <- fits$metrics 
fStats <- NPARCtest(modelMetrics, dfType = "theoretical")

## ----plotF_DOFiid-------------------------------------------------------------
fStats %>% 
  filter(!is.na(pAdj)) %>%
  distinct(nFittedNull, nFittedAlt, nCoeffsNull, nCoeffsAlt, df1, df2) %>%
  kable()

## ----plotFiid-----------------------------------------------------------------
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_density(aes(x = fStat), fill = "steelblue", alpha = 0.5) +
  geom_line(aes(x = fStat, y = df(fStat, df1 = df1, df2 = df2)), color = "darkred", size = 1.5) +
  theme_bw() +
  # Zoom in to small values to increase resolution for the proteins under H0:
  xlim(c(0, 10))

## ----plotPiid-----------------------------------------------------------------
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_histogram(aes(x = pVal, y = ..density..), fill = "steelblue", alpha = 0.5, boundary = 0, bins = 30) +
  geom_line(aes(x = pVal, y = dunif(pVal)), color = "darkred", size = 1.5) +
  theme_bw()

## ----testDOFemp---------------------------------------------------------------
modelMetrics <- fits$metrics 
fStats <- NPARCtest(modelMetrics, dfType = "empirical")

## ----plotFnew-----------------------------------------------------------------
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_density(aes(x = fStat), fill = "steelblue", alpha = 0.5) +
  geom_line(aes(x = fStat, y = df(fStat, df1 = df1, df2 = df2)), color = "darkred", size = 1.5) +
  theme_bw() +
  # Zoom in to small values to increase resolution for the proteins under H0:
  xlim(c(0, 10))

## ----plotPnew-----------------------------------------------------------------
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_histogram(aes(x = pVal, y = ..density..), fill = "steelblue", alpha = 0.5, boundary = 0, bins = 30) +
  geom_line(aes(x = pVal, y = dunif(pVal)), color = "darkred", size = 1.5) +
  theme_bw()

## ----selectHits---------------------------------------------------------------
topHits <- fStats %>% 
  filter(pAdj <= 0.01) %>%
  dplyr::select(id, fStat, pVal, pAdj) %>%
  arrange(-fStat)

## ----showHits, results='asis'-------------------------------------------------
knitr::kable(topHits)

## ----session------------------------------------------------------------------
devtools::session_info()

