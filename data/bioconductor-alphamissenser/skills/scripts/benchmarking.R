# Code example from 'benchmarking' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(AlphaMissenseR)
library(ExperimentHub)
library(dplyr)
library(tidyr)
library(ggdist)
library(ggplot2)

## ----access_dms---------------------------------------------------------------
eh <- ExperimentHub::ExperimentHub()
dms_data <- eh[['EH9555']]

head(names(dms_data))

## ----am_scores----------------------------------------------------------------
am_scores <- eh[['EH9554']]
am_scores |> head()

## ----dms_am_NUD15-------------------------------------------------------------
NUD15_dms <- dms_data[["NUD15_HUMAN_Suiter_2020"]]

NUD15_am <- am_scores |> 
    filter(DMS_id == "NUD15_HUMAN_Suiter_2020")

## ----dms_am_wrangle-----------------------------------------------------------
NUD15_am <- NUD15_am |>
    mutate(Uniprot_ID = "Q9NV35")

merged_table <- 
    left_join(
        NUD15_am, NUD15_dms, 
        by = c("Uniprot_ID" = "UniProt_id", "variant_id" = "mutant"),
        relationship = "many-to-many"
    ) |>
    select(Uniprot_ID, variant_id, AlphaMissense, DMS_score) |> 
    na.omit()

## ----dms_am_plot, fig.width=5, fig.height=3.5---------------------------------
correlation_plot <- 
    merged_table |> 
    ggplot(
        aes(y = .data$AlphaMissense, x = .data$DMS_score)
    ) +
    geom_bin2d(bins = 60) +
    scale_fill_continuous(type = "viridis") +
    xlab("DMS score") +
    ylab("AlphaMissense score") +
    theme_classic() +
    theme(
        axis.text.x = element_text(size = 16),
        axis.text.y = element_text(size = 16),
        axis.title.y = element_text(size = 16, vjust = 2),
        axis.title.x = element_text(size = 16, vjust = 0),
        legend.title = element_text(size = 16),
        legend.text = element_text(size = 16)
    )

correlation_plot

## ----corrtest-----------------------------------------------------------------
cor.test(
    merged_table$AlphaMissense, merged_table$DMS_score, 
    method="spearman", 
    exact = FALSE
)

## ----load_metrics-------------------------------------------------------------
metrics_scores <- eh[['EH9593']]

## ----prep_data----------------------------------------------------------------
chosen_assays <- c(
    "A0A1I9GEU1_NEIME_Kennouche_2019", 
    "A0A192B1T2_9HIV1_Haddox_2018", 
    "ADRB2_HUMAN_Jones_2020", 
    "BRCA1_HUMAN_Findlay_2018", 
    "CALM1_HUMAN_Weile_2017",
    "GAL4_YEAST_Kitzman_2015", 
    "Q59976_STRSQ_Romero_2015", 
    "UBC9_HUMAN_Weile_2017", 
    "TPK1_HUMAN_Weile_2017",
    "YAP1_HUMAN_Araya_2012")

am_subset <- 
    am_scores |> 
    filter(DMS_id %in% chosen_assays)

dms_subset <- 
    dms_data[names(dms_data) %in% chosen_assays]

dms_subset <- 
    bind_rows(dms_subset) |> 
    as.data.frame()

metric_subset <- 
    metrics_scores[["Spearman"]] |> 
    filter(DMS_ID %in% chosen_assays) |> 
    select(-c(Number_of_Mutants, Selection_Type, UniProt_ID, 
        MSA_Neff_L_category, Taxon))

merge_am_dms <-
    left_join(
        am_subset, dms_subset, 
        by = c("DMS_id" = "DMS_id", "variant_id" = "mutant"),
        relationship = "many-to-many"
    ) |>
    na.omit()

## ----calc_sp------------------------------------------------------------------
spearman_res <- 
    merge_am_dms |> 
    group_by(DMS_id) |> 
    summarize(
        AlphaMissense = cor(AlphaMissense, DMS_score, method = "spearman")
    ) |> 
    mutate(
        AlphaMissense = abs(AlphaMissense)
    )

DMS_IDs <- metric_subset |> pull(DMS_ID)

metric_subset <- 
    metric_subset |> 
    select(-DMS_ID) |> 
    abs() |> 
    mutate(DMS_id = DMS_IDs)

all_sp <- 
    left_join(
        metric_subset, spearman_res, 
        by = "DMS_id"
    )

## ----pivot_long---------------------------------------------------------------
res_long <- 
    all_sp |> 
    select(-DMS_id) |> 
    tidyr::pivot_longer(
        cols = everything(), 
        names_to = "model", 
        values_to = "score"
    ) |> 
    group_by(model) |> 
    mutate(
        model_mean = mean(score)
    ) |> 
    mutate(
        model = as.factor(model)
    ) |> 
    ungroup() 

unique_ordered_models <- unique(res_long$model[order(res_long$model_mean, 
                                                        decreasing = TRUE)])

res_long$model <- factor(res_long$model, 
                   levels = unique_ordered_models)

topmodels <- levels(res_long$model)[1:5]

top_spearmans <- 
    res_long |> 
    filter(model %in% topmodels) |> 
    droplevels()

## ----raincloud, fig.width=7, fig.height=4.5-----------------------------------
top_spearmans |> 
    ggplot(
        aes(x = model, y = score, fill = model, group = model)
    ) + 
    ggdist::stat_halfeye(
        adjust = .5, 
        width = .6, 
        .width = 0, 
        justification = -.2, 
        point_colour = NA
    ) + 
    geom_boxplot(
        width = .15, 
        outlier.shape = NA
    ) +
    coord_cartesian(clip = "off") +
    scale_fill_discrete(name = "Models") +
    theme_classic() +
    ylab("Spearman") +
    theme(
        axis.text.x = element_text(size = 11, angle = -12),
        axis.text.y = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.title.x = element_blank(),
        legend.title = element_text(size = 16),
        legend.text = element_text(size = 11)
    )

## -----------------------------------------------------------------------------
sessionInfo()

