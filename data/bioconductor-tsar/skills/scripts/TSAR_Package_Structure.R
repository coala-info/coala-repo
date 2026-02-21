# Code example from 'TSAR_Package_Structure' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE, comment = "#>")

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(TSAR)
library(dplyr)
library(ggplot2)
library(shiny)
library(utils)

## ----echo=FALSE, fig.width=4, out.width="400px"-------------------------------
knitr::include_graphics("images/TSAR_logo.png")

## ----results = 'hide'---------------------------------------------------------
data("qPCR_data1")
raw_data <- qPCR_data1
head(raw_data)
tail(raw_data)

## ----out.width = "400px"------------------------------------------------------
screen(raw_data) + theme(
    aspect.ratio = 0.7,
    legend.position = "bottom",
    legend.text = element_text(size = 4),
    legend.key.size = unit(0.1, "cm"),
    legend.title = element_text(size = 6)
) +
    guides(color = guide_legend(nrow = 4, byrow = TRUE))
raw_data <- remove_raw(raw_data, removerange = c("C", "H", "1", "12"))

## ----eval = FALSE-------------------------------------------------------------
# runApp(weed_raw(raw_data))

## -----------------------------------------------------------------------------
raw_data <- remove_raw(raw_data,
    removelist =
        c(
            "B04", "B11", "B09", "B05", "B10", "B03",
            "B02", "B01", "B08", "B12", "B07", "B06"
        )
)

## ----out.width = "400px"------------------------------------------------------
test <- filter(raw_data, raw_data$Well.Position == "A01")
test <- normalize(test)
gammodel <- model_gam(test, x = test$Temperature, y = test$Normalized)
test <- model_fit(test, model = gammodel)
view <- view_model(test)
view[[1]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
view[[2]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
Tm_est(test)

## -----------------------------------------------------------------------------
x <- gam_analysis(raw_data,
    smoothed = TRUE,
    fluo_col = 5,
    selections = c(
        "Well.Position", "Temperature",
        "Fluorescence", "Normalized"
    )
)

## ----message=FALSE------------------------------------------------------------
data("well_information")
output <- join_well_info(
    file_path = NULL, file = well_information,
    read_tsar(x, output_content = 0), type = "by_template"
)

## ----message=FALSE------------------------------------------------------------
norm_data <- join_well_info(
    file_path = NULL, file = well_information,
    read_tsar(x, output_content = 2), type = "by_template"
)

## ----eval = FALSE-------------------------------------------------------------
# runApp(analyze_norm(raw_data))

## ----message=FALSE------------------------------------------------------------
# analyze replicate data
data("qPCR_data2")
raw_data_rep <- qPCR_data2
raw_data_rep <- remove_raw(raw_data_rep,
    removerange = c("B", "H", "1", "12"),
    removelist = c("A12")
)
analysis_rep <- gam_analysis(raw_data_rep, smoothed = TRUE)
norm_data_rep <- join_well_info(
    file_path = NULL, file = well_information,
    read_tsar(analysis_rep, output_content = 2),
    type = "by_template"
)

# merge data
tsar_data <- merge_norm(
    data = list(norm_data, norm_data_rep),
    name = c(
        "Vitamin_RawData_Thermal Shift_02_162.eds.csv",
        "Vitamin_RawData_Thermal Shift_02_168.eds.csv"
    ),
    date = c("20230203", "20230209")
)

## -----------------------------------------------------------------------------
#analysis_file <- read_analysis(analysis_file_path)
#raw_data <- read_raw_data(raw_data_path)
#merge_TSA(analysis_file, raw_data)

## -----------------------------------------------------------------------------
condition_IDs(tsar_data)
well_IDs(tsar_data)
TSA_proteins(tsar_data)
TSA_ligands(tsar_data)

conclusion <- tsar_data %>%
    filter(condition_ID != "NA_NA") %>%
    filter(condition_ID != "CA FL_Riboflavin")

## ----out.width = "400px"------------------------------------------------------
TSA_boxplot(conclusion,
    color_by = "Protein",
    label_by = "Ligand", separate_legend = TRUE
)

## -----------------------------------------------------------------------------
control_ID <- "CA FL_DMSO"

TSA_compare_plot(conclusion,
    y = "RFU",
    control_condition = control_ID
)

## -----------------------------------------------------------------------------
ABA_Cond <- conclusion %>% filter(condition_ID == "CA FL_4-ABA")
TSA_wells_plot(ABA_Cond, separate_legend = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# runApp(graph_tsar(tsar_data))

## -----------------------------------------------------------------------------
citation("TSAR")
citation()
citation("dplyr")
citation("ggplot2")
citation("shiny")
citation("utils")

## -----------------------------------------------------------------------------
sessionInfo()

