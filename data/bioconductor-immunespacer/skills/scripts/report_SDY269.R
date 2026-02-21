# Code example from 'report_SDY269' vignette. See references/ for full tutorial.

## ----knitr-opts, echo = FALSE, message = FALSE, cache = FALSE------------
library(knitr)
opts_chunk$set(cache = FALSE, echo = TRUE, message = FALSE, warning = FALSE,
               fig.width = 8, fig.height = 4, dpi = 100, fig.align = "center")

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
study <- CreateConnection("SDY269")
dt_hai <- study$getDataset("hai", reload = TRUE)
dt_fcs <- study$getDataset("fcs_analyzed_result", reload = TRUE)
dt_elispot <- study$getDataset("elispot", reload = TRUE)

## ----data-subset---------------------------------------------------------
# Compute max fold change for HAI, and remove time zero
dt_hai <- dt_hai[, hai_response := value_preferred / value_preferred[study_time_collected == 0],
                 by = "virus,cohort,participant_id"][study_time_collected == 28]
dt_hai <- dt_hai[, list(hai_response = max(hai_response)), by = "cohort,participant_id"]

# Define variable for ELISPOT, keep only the IgG class
dt_elispot <- dt_elispot[, elispot_response := spot_number_reported + 1][study_time_collected == 7 & analyte == "IgG"]

# Compute % plasmablasts
dt_fcs <- dt_fcs[, fcs_response := (as.double(population_cell_number) + 1) /
                   as.double(base_parent_population)][study_time_collected == 7]

## ----merging-------------------------------------------------------------
# Let's key the different datasets
setkeyv(dt_hai, c("participant_id"))
setkeyv(dt_fcs, c("participant_id"))
setkeyv(dt_elispot, c("participant_id"))
dt_all <- dt_hai[dt_fcs, nomatch = 0][dt_elispot, nomatch = 0]

## ----plot1, dev='png'----------------------------------------------------
ggplot(dt_all, aes(x = as.double(fcs_response), y = elispot_response, color = cohort)) +
  geom_point() + 
  scale_y_log10() + 
  scale_x_log10() + 
  geom_smooth(method="lm") +
  xlab("Total plasmablasts (%)") + 
  ylab("Influenza specific cells\n (per 10^6 PBMCs)") +
  theme_IS()

## ----plot2, dev='png'----------------------------------------------------
ggplot(dt_all, aes(x = as.double(hai_response), y = elispot_response, color = cohort)) +
  geom_point() + 
  scale_x_continuous(trans = "log2") + 
  scale_y_log10() +
  geom_smooth(method = "lm") + 
  xlab("HAI fold") +
  ylab("Influenza specific cells\n (per 10^6 PBMCs)") + 
  theme_IS()

