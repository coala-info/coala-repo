# Code example from 'Analysis_Example' vignette. See references/ for full tutorial.

## ----packages, message=TRUE, warning=TRUE-------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(ggplot2)
library(dplyr)
library(tidyr)

## ----ScreenR install Bioc, eval=FALSE, message=TRUE, warning=TRUE-------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ScreenR")

## ----github install, eval=FALSE, message=TRUE, warning=TRUE-------------------
# if (!require("devtools", quietly = TRUE))
#    install.packages("devtools")
# 
# devtools::install_github("EmanuelSoda/ScreenR")

## ----message=TRUE, warning=TRUE-----------------------------------------------
library(ScreenR)

## ----read_data, message=TRUE, warning=TRUE------------------------------------
data(count_table)
data(annotation_table)

data <- count_table
colnames(data) <- c(
    "Barcode", "Time1", "Time2", "Time3_TRT_A", "Time3_TRT_B", "Time3_TRT_C",
    "Time3_CTRL_A", "Time3_CTRL_B", "Time3_CTRL_C", 
    "Time4_TRT_A", "Time4_TRT_B", "Time4_TRT_C", 
    "Time4_CTRL_A", "Time4_CTRL_B", "Time4_CTRL_C"
)
data <- data %>%
    dplyr::mutate(Barcode = as.factor(Barcode)) %>%
    dplyr::filter(Barcode != "*") %>%  
  tibble()


total_Annotation <- annotation_table

## ----Create_Object, message=TRUE, warning=TRUE--------------------------------
groups <- factor(c(
    "T1/T2", "T1/T2",
    "Time3_TRT", "Time3_TRT", "Time3_TRT",
    "Time3_CTRL", "Time3_CTRL", "Time3_CTRL",
    "Time4_TRT", "Time4_TRT", "Time4_TRT",
    "Time4_CTRL", "Time4_CTRL", "Time4_CTRL"
))


palette <- c("#66c2a5", "#fc8d62", rep("#8da0cb", 3), rep("#e78ac3", 3),
    rep("#a6d854", 3), rep("#ffd92f", 3))


object <- create_screenr_object(
    table = data, annotation = total_Annotation, groups = groups,
    replicates = ""
)

## ----Removing all zero rows, message=TRUE, warning=TRUE-----------------------
object <- remove_all_zero_row(object)

## ----normalization, message=TRUE, warning=TRUE--------------------------------
object <- normalize_data(object)
object <- compute_data_table(object)

## ----plot_mapped_reads, message=TRUE, warning=TRUE----------------------------
plot <- plot_mapped_reads(object, palette) +
    ggplot2::coord_flip() +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::theme(legend.position = "none") +
    ggplot2::ggtitle("Number of Mapped Reads in each sample")

plot

## ----plot_mapped_reads_distribution_boxplot, message=TRUE, warning=TRUE-------
plot <- plot_mapped_reads_distribution(
    object, palette,
    alpha = 0.8,
    type = "boxplot"
) +
    coord_flip() +
    theme(legend.position = "none") 

plot

## ----plot_mapped_reads_distribution_density, message=TRUE, warning=TRUE-------
plot <- plot_mapped_reads_distribution(
    object, palette,
    alpha = 0.5,
    type = "density"
) +
    ggplot2::theme(legend.position = "none") 

plot

## ----plot_barcode_lost, message=TRUE, warning=TRUE----------------------------
plot <- plot_barcode_lost(screenR_Object = object, palette = palette) +
    ggplot2::coord_flip()
plot

## ----plot_barcode_lost_for_gene, message=TRUE, warning=TRUE-------------------
plot <- plot_barcode_lost_for_gene(object,
    samples = c("Time4_TRT_C", "Time4_CTRL_C")
)
plot


## ----Plot_MDS_Sample, message=TRUE, warning=TRUE------------------------------
plot_mds(screenR_Object = object)

## ----Plot_MDS_Treatment, message=TRUE, warning=TRUE---------------------------
group_table <- get_data_table(object)   %>%
    select(Sample, Day, Treatment) %>%
    distinct()

group_treatment <- group_table$Treatment

plot_mds(
    screenR_Object = object,
    groups = factor(x = group_treatment, levels = unique(group_treatment))
)

## ----Plot_MDS_Day, message=TRUE, warning=TRUE---------------------------------
group_day <- group_table$Day

plot_mds(
    screenR_Object = object,
    groups = factor(x = group_day, levels = unique(group_day))
)

## ----compute_metrics, message=TRUE, warning=TRUE------------------------------
# 2DG
data_with_measure_TRT <- list(
    Time3 = compute_metrics(
        object,
        control = "CTRL", treatment = "TRT",
        day = "Time3"
    ),
    Time4 = compute_metrics(
        object,
        control = "CTRL", treatment = "TRT",
        day = "Time4"
    )
)

plot_zscore_distribution(data_with_measure_TRT, alpha = 0.8) 

## ----Z_score_hit, message=TRUE, warning=TRUE----------------------------------
zscore_hit_TRT <- list(
    Time3 = find_zscore_hit(
        table_treate_vs_control = data_with_measure_TRT$Time3,
        number_barcode = 6, metric = "median"
    ),
    Time4 = find_zscore_hit(
        table_treate_vs_control = data_with_measure_TRT$Time4,
        number_barcode = 6, metric = "median"
    )
)
zscore_hit_TRT

## ----CAMERA, message=TRUE, warning=TRUE---------------------------------------
matrix_model <- model.matrix(~ groups)
colnames(matrix_model) <- unique(groups)


camera_hit_TRT <- list(
    Time3 = find_camera_hit(
        screenR_Object = object, matrix_model = matrix_model,
        contrast = "Time3_TRT",
    ),
    Time4 = find_camera_hit(
        screenR_Object = object, matrix_model = matrix_model,
        contrast = "Time4_TRT"
    )
)

camera_hit_TRT

## ----ROAST, message=TRUE, warning=TRUE----------------------------------------
roast_hit_TRT <- list(
    Time3 = find_roast_hit(
        screenR_Object = object, matrix_model = matrix_model,
        contrast = "Time3_TRT", 
    ),
    Time4 = find_roast_hit(
        screenR_Object = object, matrix_model = matrix_model,
        contrast = "Time4_TRT"
    )
)

roast_hit_TRT

## ----Common_Hit,  message=TRUE, warning=TRUE----------------------------------
common_hit_TRT_at_least_2 <- list(
    Time3 = find_common_hit(
        zscore_hit_TRT$Time3, camera_hit_TRT$Time3, roast_hit_TRT$Day3,
        common_in = 2
    ),
    Time4 = find_common_hit(
        zscore_hit_TRT$Time4, camera_hit_TRT$Time4, roast_hit_TRT$Day6,
        common_in = 2
    )
)

common_hit_TRT_at_least_3 <- list(
    Time3 = find_common_hit(
        zscore_hit_TRT$Time3, camera_hit_TRT$Time3, roast_hit_TRT$Time3,
        common_in = 3
    ),
    Time4 = find_common_hit(
        zscore_hit_TRT$Time4, camera_hit_TRT$Time4, roast_hit_TRT$Time4,
        common_in = 3
    )
)

## ----Venn_diagram_in_at_least_2,  message=TRUE, warning=TRUE------------------
plot_common_hit(
    hit_zscore = zscore_hit_TRT$Time4, hit_camera = camera_hit_TRT$Time4,
    roast_hit_TRT$Time4, show_elements = FALSE, show_percentage = TRUE
)

## ----plot_trend,  message=TRUE, warning=TRUE----------------------------------
candidate_hits <- common_hit_TRT_at_least_2$Time3

plot_trend(screenR_Object = object, 
           genes = candidate_hits[1], 
           nrow = 2, ncol = 2, 
           group_var = c("Time1", "Time2", "TRT"))

plot_trend(screenR_Object = object, 
           genes = candidate_hits[2], 
           nrow = 2, ncol = 2, 
           group_var = c("Time1", "Time2", "TRT"))

## ----message=TRUE, warning=TRUE-----------------------------------------------
sessionInfo()

