# Code example from 'using_depmap' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----load_libraries, message=FALSE, warning=FALSE, echo=TRUE------------------
library("dplyr")
library("ggplot2")
library("viridis")
library("tibble")
library("gridExtra")
library("stringr")
library("depmap")
library("ExperimentHub")

## ----load_data, message=FALSE, warning=FALSE, echo=TRUE-----------------------
## create ExperimentHub query object
eh <- ExperimentHub()
query(eh, "depmap")
rnai <- eh[["EH3080"]]
mutationCalls <- eh[["EH3085"]]
metadata <- eh[["EH3086"]]
TPM <- eh[["EH3084"]]
copyNumber <- eh[["EH3082"]]
# crispr <- eh[["EH3081"]]
# drug_sensitivity <- eh[["EH3087"]]

## ----soft_tissue_cell_lines, echo=TRUE----------------------------------------
## list of dependency scores
rnai |>
    dplyr::select(cell_line, gene_name, dependency) |>
    dplyr::filter(stringr::str_detect(cell_line, "SOFT_TISSUE")) |>
    dplyr::arrange(dependency) |>
    head(10)

## ----message=FALSE, warning=FALSE---------------------------------------------
## Basic histogram
rnai |>
    dplyr::select(gene, gene_name, dependency) |>
    dplyr::filter(gene_name == "RPL14") |>
    ggplot(aes(x = dependency)) +
    geom_histogram() +
    geom_vline(xintercept = mean(rnai$dependency, na.rm = TRUE),
               linetype = "dotted", color = "red") +
    ggtitle("Histogram of dependency scores for gene RPL14")

## ----message=FALSE, warning=FALSE---------------------------------------------
meta_rnai <- metadata |>
    dplyr::select(depmap_id, lineage) |>
    dplyr::full_join(rnai, by = "depmap_id") |>
    dplyr::filter(gene_name == "RPL14") |>
    dplyr::full_join((mutationCalls |>
                      dplyr::select(depmap_id, entrez_id,
                                    is_cosmic_hotspot, var_annotation)),
                     by = c("depmap_id", "entrez_id"))

p1 <- meta_rnai |>
      ggplot(aes(x = dependency, y = lineage)) +
      geom_point(alpha = 0.4, size = 0.5) +
      geom_point(data = subset(
         meta_rnai, var_annotation == "damaging"), color = "red") +
      geom_point(data = subset(
         meta_rnai, var_annotation == "other non-conserving"), color = "blue") +
      geom_point(data = subset(
         meta_rnai, var_annotation == "other conserving"), color = "cyan") +
      geom_point(data = subset(
         meta_rnai, is_cosmic_hotspot == TRUE), color = "orange") +
      geom_vline(xintercept=mean(meta_rnai$dependency, na.rm = TRUE),
                 linetype = "dotted", color = "red") +
      ggtitle("Scatterplot of dependency scores for gene RPL14 by lineage")

p1

## ----message=FALSE, warning=FALSE---------------------------------------------
metadata |>
    dplyr::select(depmap_id, lineage) |>
    dplyr::full_join(TPM, by = "depmap_id") |>
    dplyr::filter(gene_name == "RPL14") |>
    ggplot(aes(x = lineage, y = expression, fill = lineage)) +
    geom_boxplot(outlier.alpha = 0.1) +
    ggtitle("Boxplot of expression values for gene RPL14 by lineage") +
    theme(axis.text.x = element_text(angle = 45, hjust=1)) +
    theme(legend.position = "none")

## ----message=FALSE, warning=FALSE---------------------------------------------
## expression vs rnai gene dependency for Rhabdomyosarcoma Sarcoma
sarcoma <- metadata |>
    dplyr::select(depmap_id, cell_line,
                  primary_disease, subtype_disease) |>
    dplyr::filter(primary_disease == "Sarcoma",
                  subtype_disease == "Rhabdomyosarcoma")

rnai_sub <- rnai |>
    dplyr::select(depmap_id, gene, gene_name, dependency)
tpm_sub <- TPM |>
    dplyr::select(depmap_id, gene, gene_name, expression)

sarcoma_dep <- sarcoma |>
    dplyr::left_join(rnai_sub, by = "depmap_id") |>
    dplyr::select(-cell_line, -primary_disease,
                  -subtype_disease, -gene_name)

sarcoma_exp <- sarcoma |>
    dplyr::left_join(tpm_sub, by = "depmap_id")

sarcoma_dat_exp <- dplyr::full_join(sarcoma_dep, sarcoma_exp,
                                    by = c("depmap_id", "gene")) |>
    dplyr::filter(!is.na(expression))

p2 <- ggplot(data = sarcoma_dat_exp, aes(x = dependency, y = expression)) +
    geom_point(alpha = 0.4, size = 0.5) +
    geom_vline(xintercept=mean(sarcoma_dat_exp$dependency, na.rm = TRUE),
               linetype = "dotted", color = "red") +
    geom_hline(yintercept=mean(sarcoma_dat_exp$expression, na.rm = TRUE),
               linetype = "dotted", color = "red") +
    ggtitle("Scatterplot of rnai dependency vs expression values for gene")

p2 + theme(axis.text.x = element_text(angle = 45))

## -----------------------------------------------------------------------------
sarcoma_dat_exp |>
    dplyr::select(cell_line, gene_name, dependency, expression) |>
    dplyr::arrange(dependency) |>
    head(10)

## ----message=FALSE, warning=FALSE---------------------------------------------
metadata |>
    dplyr::select(depmap_id, lineage) |>
    dplyr::full_join(copyNumber, by = "depmap_id") |>
    dplyr::filter(gene_name == "RPL14") |>
    ggplot(aes(x = lineage, y = log_copy_number, fill = lineage)) +
    geom_boxplot(outlier.alpha = 0.1) +
    ggtitle("Boxplot of log copy number for gene RPL14 by lineage") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(legend.position = "none")

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

