# Code example from 'TSAR_Workflow_by_Command' vignette. See references/ for full tutorial.

## ----echo=FALSE, fig.width=4, out.width="400px"-------------------------------
knitr::include_graphics("images/TSAR_logo.png")

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE, comment = "#>")

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(TSAR)
library(dplyr)
library(ggplot2)

## -----------------------------------------------------------------------------
data("qPCR_data1")
raw_data <- qPCR_data1

## -----------------------------------------------------------------------------
test <- raw_data %>% filter(Well.Position == "A01")

## -----------------------------------------------------------------------------
# normalize fluorescence reading into scale between 0 and 1
test <- normalize(test, fluo = 5, selected = c(
    "Well.Position", "Temperature",
    "Fluorescence", "Normalized"
))
head(test)
gammodel <- model_gam(test, x = test$Temperature, y = test$Normalized)
test <- model_fit(test, model = gammodel)

## -----------------------------------------------------------------------------
Tm_est(test)
view <- view_model(test)
view[[1]] + theme(aspect.ratio = 0.7, legend.position = "bottom")
view[[2]] + theme(aspect.ratio = 0.7, legend.position = "bottom")

## -----------------------------------------------------------------------------
myApp <- weed_raw(raw_data, checkrange = c("A", "C", "1", "12"))

## ----eval = FALSE-------------------------------------------------------------
# shiny::runApp(myApp)

## -----------------------------------------------------------------------------
raw_data <- remove_raw(raw_data, removerange = c("B", "H", "1", "12"))
screen(raw_data) + theme(
    aspect.ratio = 0.7,
    legend.position = "bottom",
    legend.text = element_text(size = 6),
    legend.key.size = unit(0.4, "cm"),
    legend.title = element_text(size = 8)
) +
    guides(color = guide_legend(nrow = 2, byrow = TRUE))

## ----echo = FALSE-------------------------------------------------------------
x <- gam_analysis(raw_data,
    smoothed = TRUE, fluo_col = 5,
    selections = c(
        "Well.Position", "Temperature",
        "Fluorescence", "Normalized"
    )
)
x <- na.omit(x)

## ----echo = FALSE-------------------------------------------------------------
# look at only Tm result by well
output <- read_tsar(x, output_content = 0)
head(output)
tail(output)

## ----echo = FALSE-------------------------------------------------------------
# join protein and ligand information
data("well_information")
norm_data <- join_well_info(
    file_path = NULL,
    file = well_information,
    read_tsar(x, output_content = 2), type = "by_template"
)
norm_data <- na.omit(norm_data)
head(norm_data)
tail(norm_data)

## -----------------------------------------------------------------------------
data("qPCR_data2")
raw_data_rep <- qPCR_data2

raw_data_rep <- remove_raw(raw_data_rep, removerange = c("B", "H", "1", "12"))

## ----eval = FALSE-------------------------------------------------------------
# myApp <- weed_raw(raw_data_rep)
# shiny::runApp(myApp)

## -----------------------------------------------------------------------------
raw_data_rep <- remove_raw(raw_data_rep, removelist = "A12")
screen(raw_data_rep) + theme(
    aspect.ratio = 0.7,
    legend.position = "bottom",
    legend.text = element_text(size = 6),
    legend.key.size = unit(0.4, "cm"),
    legend.title = element_text(size = 8)
) +
    guides(color = guide_legend(nrow = 2, byrow = TRUE))

analysis_rep <- gam_analysis(raw_data_rep, smoothed = TRUE)
output_rep <- read_tsar(analysis_rep, output_content = 2)
norm_data_rep <- join_well_info(
    file_path = NULL,
    file = well_information,
    output_rep, type = "by_template"
)
norm_data_rep <- na.omit(norm_data_rep)

## -----------------------------------------------------------------------------
norm_data <- na.omit(norm_data)
norm_data_rep <- na.omit(norm_data_rep)
tsar_data <- merge_norm(
    data = list(norm_data, norm_data_rep),
    name = c(
        "Vitamin_RawData_Thermal Shift_02_162.eds.csv",
        "Vitamin_RawData_Thermal Shift_02_168.eds.csv"
    ),
    date = c("20230203", "20230209")
)

## -----------------------------------------------------------------------------
condition_IDs(tsar_data)
well_IDs(tsar_data)
conclusion <- tsar_data %>%
    filter(condition_ID != "NA_NA") %>%
    filter(condition_ID != "CA FL_Riboflavin")
TSA_boxplot(conclusion,
    color_by = "Protein", label_by = "Ligand",
    separate_legend = FALSE
)

## -----------------------------------------------------------------------------
control_ID <- "CA FL_DMSO"

TSA_compare_plot(conclusion,
    y = "RFU",
    control_condition = control_ID
)

## -----------------------------------------------------------------------------
error <- conclusion %>% filter(condition_ID == "CA FL_PyxINE HCl")
TSA_wells_plot(error, separate_legend = FALSE)

## -----------------------------------------------------------------------------
citation("TSAR")
citation()
citation("dplyr")
citation("ggplot2")

## -----------------------------------------------------------------------------
sessionInfo()

