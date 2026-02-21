# Code example from 'planet' vignette. See references/ for full tutorial.

## ----message = FALSE, warning = FALSE, eval = FALSE---------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("planet")

## ----load_libraries, message = FALSE, warning = FALSE-------------------------
# cell deconvolution packages
library(minfi)
library(EpiDISH)

# data wrangling and plotting
library(dplyr)
library(ggplot2)
library(tidyr)
library(planet)

# load example data
data("plBetas")
data("plCellCpGsThird")
head(plCellCpGsThird)

## ----houseman-----------------------------------------------------------------
houseman_estimates <- minfi:::projectCellType(
  plBetas[rownames(plCellCpGsThird), ],
  plCellCpGsThird,
  lessThanOne = FALSE
)

head(houseman_estimates)

## ----epidish, results='hide'--------------------------------------------------
# robust partial correlations
epidish_RPC <- epidish(
  beta.m = plBetas[rownames(plCellCpGsThird), ],
  ref.m = plCellCpGsThird,
  method = "RPC"
)

# CIBERSORT
epidish_CBS <- epidish(
  beta.m = plBetas[rownames(plCellCpGsThird), ],
  ref.m = plCellCpGsThird,
  method = "CBS"
)

# constrained projection (houseman 2012)
epidish_CP <- epidish(
  beta.m = plBetas[rownames(plCellCpGsThird), ],
  ref.m = plCellCpGsThird,
  method = "CP"
)

## ----compare_deconvolution, fig.width = 7, fig.height = 7---------------------
data("plColors")

# bind estimate data frames and reshape for plotting
bind_rows(
  houseman_estimates %>% as.data.frame() %>% mutate(algorithm = "CP (Houseman)"),
  epidish_RPC$estF %>% as.data.frame() %>% mutate(algorithm = "RPC"),
  epidish_CBS$estF %>% as.data.frame() %>% mutate(algorithm = "CBS"),
  epidish_CP$estF %>% as.data.frame() %>% mutate(algorithm = "CP (EpiDISH)")
) %>%
  mutate(sample = rep(rownames(houseman_estimates), 4)) %>%
  as_tibble() %>%
  pivot_longer(
    cols = -c(algorithm, sample),
    names_to = "component",
    values_to = "estimate"
  ) %>%
  
  # relevel for plot
  mutate(component = factor(component,
                            levels = c(
                              "nRBC", "Endothelial", "Hofbauer",
                              "Stromal", "Trophoblasts",
                              "Syncytiotrophoblast"
                            )
  )) %>%
  
  # plot
  ggplot(aes(x = sample, y = estimate, fill = component)) +
  geom_bar(stat = "identity") +
  facet_wrap(~algorithm, ncol = 1) +
  scale_fill_manual(values = plColors) +
  scale_y_continuous(
    limits = c(-0.1, 1.1), breaks = c(0, 0.5, 1),
    labels = scales::percent
  ) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  coord_cartesian(ylim = c(0, 1)) +
  labs(x = "", fill = "")

## ----gestational_age----------------------------------------------------------
# load example data
data(plBetas)
data(plPhenoData)

dim(plBetas)
#> [1] 13918    24
head(plPhenoData)
#> # A tibble: 6 x 7
#>   sample_id  sex   disease   gestation_wk ga_RPC ga_CPC ga_RRPC
#>   <fct>      <chr> <chr>            <dbl>  <dbl>  <dbl>   <dbl>
#> 1 GSM1944936 Male  preeclam~           36   38.5   38.7    38.7
#> 2 GSM1944939 Male  preeclam~           32   33.1   34.2    32.6
#> 3 GSM1944942 Fema~ preeclam~           32   34.3   35.1    33.3
#> 4 GSM1944944 Male  preeclam~           35   35.5   36.7    35.5
#> 5 GSM1944946 Fema~ preeclam~           38   37.6   37.6    36.6
#> 6 GSM1944948 Fema~ preeclam~           36   36.8   38.4    36.7

## ----predict_ga---------------------------------------------------------------
plPhenoData <- plPhenoData %>%
  mutate(
    ga_RPC = predictAge(plBetas, type = "RPC"),
    ga_CPC = predictAge(plBetas, type = "CPC"),
    ga_RRPC = predictAge(plBetas, type = "RRPC")
  )

## ----view_ga, fig.width = 7, fig.height = 5-----------------------------------
plPhenoData %>%
  
  # reshape, to plot
  pivot_longer(
    cols = contains("ga"),
    names_to = "clock_type",
    names_prefix = "ga_",
    values_to = "ga"
  ) %>%
  
  # plot code
  ggplot(aes(x = gestation_wk, y = ga, col = disease)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~clock_type) +
  theme(legend.position = "top") +
  labs(x = "Reported GA (weeks)", y = "Inferred GA (weeks)", col = "")

## ----ethnicity----------------------------------------------------------------
data(ethnicityCpGs)
all(ethnicityCpGs %in% rownames(plBetas))

results <- predictEthnicity(plBetas)
results %>%
  tail(8)

## ----fig.width = 7------------------------------------------------------------
results %>%
  ggplot(aes(
    x = Prob_Caucasian, y = Prob_African,
    col = Predicted_ethnicity
  )) +
  geom_point(alpha = 0.7) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "P(Caucasian)", y = "P(African)")

results %>%
  ggplot(aes(
    x = Prob_Caucasian, y = Prob_Asian,
    col = Predicted_ethnicity
  )) +
  geom_point(alpha = 0.7) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1)) +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "P(Caucasian)", y = "P(Asian)")

## -----------------------------------------------------------------------------
table(results$Predicted_ethnicity)

## ----predict_pe, include=TRUE, eval = TRUE------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "eoPredData")

# download BMIQ normalized 450k data
x_test <- eh[['EH8403']]
preds <- x_test %>% predictPreeclampsia()

## ----include=TRUE, eval = TRUE, fig.width = 7---------------------------------
head(preds)

# join with metadata
valMeta <- eh[['EH8404']]
valMeta <- left_join(valMeta, preds, by="Sample_ID")

# visualize results
plot_predictions <- function(df, predicted_class_column) {
  df %>% 
    ggplot() +
    geom_boxplot(
      aes(x = Class, y = EOPE),
      width = 0.3,
      alpha = 0.5,
      color = "darkgrey"
    ) +
    geom_jitter(
      aes(x = Class, y = EOPE, color = {{predicted_class_column}}), 
      alpha = 0.75, 
      position = position_jitter(width = .1)
    ) + 
    coord_flip() +
    ylab("Class Probability of EOPE") +
    xlab("True Class") +
    ylim(0,1) +
    scale_color_manual(
      name = "Predicted Class", 
      values = c("#E69F00", "skyblue", "#999999")
    ) + 
    theme_minimal() 
}

## ----fig.width = 7------------------------------------------------------------
valMeta %>% plot_predictions(PE_Status)

## ----fig.width = 7------------------------------------------------------------
valMeta %>% mutate(
  Pred_Class = case_when(
    EOPE > 0.7 ~ "EOPE",
    `Non-PE Preterm` > 0.7 ~ "Non-PE Preterm",
    .default = 'low-confidence'
  )) %>% plot_predictions(Pred_Class)


## -----------------------------------------------------------------------------
sessionInfo()

