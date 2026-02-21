# Code example from 'condiments' vignette. See references/ for full tutorial.

## ----packages, include=F------------------------------------------------------
library(knitr)
opts_chunk$set(
  fig.pos = "!h", out.extra = "",
  fig.align = "center"
)

## ----warning=FALSE, message=F-------------------------------------------------
# For analysis
library(condiments)
library(slingshot)
# For data manipulation
library(dplyr)
library(tidyr)
# For visualization
library(ggplot2)
library(RColorBrewer)
library(viridis)
set.seed(2071)
theme_set(theme_classic())

## -----------------------------------------------------------------------------
data("toy_dataset", package = "condiments")
df <- toy_dataset$sd

## -----------------------------------------------------------------------------
p <- ggplot(df, aes(x = Dim1, y = Dim2, col = conditions)) +
  geom_point() +
  scale_color_brewer(type = "qual")
p

## -----------------------------------------------------------------------------
p <- ggplot(df, aes(x = Dim1, y = Dim2, col = conditions)) +
  geom_point(alpha = .5) +
  geom_point(data = toy_dataset$mst, size = 2) +
  geom_path(data = toy_dataset$mst, aes(group = lineages), size = 1.5) +
  scale_color_brewer(type = "qual") + 
  facet_wrap(~conditions) +
  guides(col = FALSE)
p

## -----------------------------------------------------------------------------
scores <- imbalance_score(Object = df %>% select(Dim1, Dim2) %>% as.matrix(),
                          conditions = df$conditions)
df$scores <- scores$scores
df$scaled_scores <- scores$scaled_scores

## -----------------------------------------------------------------------------
ggplot(df, aes(x = Dim1, y = Dim2, col = scores)) +
  geom_point() +
  scale_color_viridis_c(option = "C")

## -----------------------------------------------------------------------------
ggplot(df, aes(x = Dim1, y = Dim2, col = scaled_scores)) +
  geom_point() +
  scale_color_viridis_c(option = "C")

## -----------------------------------------------------------------------------
ggplot(df, aes(x = Dim1, y = Dim2, col = cl)) +
  geom_point()

## -----------------------------------------------------------------------------
rd <- as.matrix(df[, c("Dim1", "Dim2")])
sds <- slingshot(rd, df$cl)
## Takes ~1m30s to run
top_res <- topologyTest(sds = sds, conditions = df$conditions)
knitr::kable(top_res)

## -----------------------------------------------------------------------------
ggplot(df, aes(x = Dim1, y = Dim2, col = cl)) +
  geom_point() +
  geom_path(data =  slingCurves(sds, as.df = TRUE) %>% arrange(Order),
            aes(group = Lineage), col = "black", size = 2)

## -----------------------------------------------------------------------------
psts <- slingPseudotime(sds) %>%
  as.data.frame() %>%
  mutate(cells = rownames(.),
         conditions = df$conditions) %>%
  pivot_longer(starts_with("Lineage"), values_to = "pseudotime", names_to = "lineages")

## ----warning=FALSE------------------------------------------------------------
ggplot(psts, aes(x = pseudotime, fill = conditions)) +
  geom_density(alpha = .5) +
  scale_fill_brewer(type = "qual") +
  facet_wrap(~lineages) +
  theme(legend.position = "bottom")

## -----------------------------------------------------------------------------
prog_res <- progressionTest(sds, conditions = df$conditions, global = TRUE, lineages = TRUE)
knitr::kable(prog_res)

## -----------------------------------------------------------------------------
df$weight_1 <- slingCurveWeights(sds, as.probs = TRUE)[, 1]
ggplot(df, aes(x = weight_1, fill = conditions)) +
  geom_density(alpha = .5) +
  scale_fill_brewer(type = "qual") +
  labs(x = "Curve weight for the first lineage")

## -----------------------------------------------------------------------------
set.seed(12)
dif_res <- fateSelectionTest(sds, conditions = df$conditions, global = FALSE, pairwise = TRUE)
knitr::kable(dif_res)

## ----eval = FALSE-------------------------------------------------------------
# library(tradeSeq)
# sce <- fitGAM(counts = counts, sds = sds, conditions = df$conditions)
# cond_genes <- conditionTest(sds)

## -----------------------------------------------------------------------------
sessionInfo()

