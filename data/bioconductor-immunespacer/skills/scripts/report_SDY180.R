# Code example from 'report_SDY180' vignette. See references/ for full tutorial.

## ----knitr-opts, echo = FALSE, message = FALSE, cache = FALSE------------
library(knitr)
opts_chunk$set(cache = FALSE, echo = TRUE, message = FALSE, warning = FALSE,
               fig.width = 10, fig.height = 14, dpi = 100, fig.align = "center")

## ----netrc_req, echo = FALSE---------------------------------------------
# This chunk is only useful for BioConductor checks and shouldn't affect any other setup
if (!any(file.exists("~/.netrc", "~/_netrc"))) {
    labkey.netrc.file <- ImmuneSpaceR:::get_env_netrc()
    labkey.url.base <- ImmuneSpaceR:::get_env_url()
}

## ----libraries, cache=FALSE----------------------------------------------
library(ImmuneSpaceR)
library(ggplot2)
library(data.table)

## ----connection----------------------------------------------------------
study <- CreateConnection(c("SDY180"))
dt_fcs <- study$getDataset("fcs_analyzed_result")

## ----data-subset---------------------------------------------------------
dt_fcs19 <- dt_fcs[population_name_reported %like% "Plasma"]
dt_fcs19 <- dt_fcs19[, cohort := gsub("Study g", "G", cohort), ]

## ----data-summary--------------------------------------------------------
dt_fcs19_median <- dt_fcs19[, .(median_cell_reported = median(as.double(population_cell_number) + 1,
                   na.rm = TRUE)), by = .(cohort,study_time_collected,population_name_reported)]

## ---- dev='png'----------------------------------------------------------
ggplot(dt_fcs19, aes(x = as.factor(study_time_collected), y = as.double(population_cell_number) + 1)) +
  geom_boxplot() + 
  geom_jitter() + 
  scale_y_log10() + 
  facet_grid(cohort~population_name_reported, scale = "free") + 
  xlab("Time") + 
  ylab(expression(paste("Number of cells/", mu, "l"))) + 
  geom_line(data = dt_fcs19_median, aes(x = as.factor(study_time_collected), y = as.double(median_cell_reported),
  group = 1), color = "black", size = 1.2) + 
  labs(title = "Plasma cell abundance after vaccination") + 
  theme_IS()

