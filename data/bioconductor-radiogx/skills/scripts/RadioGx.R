# Code example from 'RadioGx' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install_radiogx, eval=FALSE, message=FALSE-------------------------------
# BiocManager::install('RadioGx', version='devel')

## ----load_package, message=FALSE----------------------------------------------
library(RadioGx)

## ----radioset, echo=FALSE, fig.wide=TRUE, fig.cap = "**RadioSet class diagram**. Objects comprising a `RadioSet` are enclosed in boxes. First box indicates type and name of each object. Second box indicates the structure of an object or class. Third box shows accessor methods from `RadioGx` for that specific object. '=>' represents return and specifies what is returned from that item or method."----
knitr::include_graphics('./RadioGxClassDiagram.png')

## ----available_rsets, evel=FALSE, message=FALSE-------------------------------
RSets <- availableRSets()

## ----download_rset, eval=FALSE------------------------------------------------
# Cleveland <- downloadRSet('Cleveland', saveDir='.')

## ----printing_a_radioset, hide=TRUE-------------------------------------------
data(clevelandSmall)
clevelandSmall

## ----radiation_info_accessor--------------------------------------------------
# Get the radiation info data.frame from an RSet
radInf <- radiationInfo(clevelandSmall)

## ----print_radinf, fig.wide = TRUE--------------------------------------------
knitr::kable(radInf)

## ----radiation_types_accessor-------------------------------------------------
radTypes <- radiationTypes(clevelandSmall)
radTypes

## ----molecular_data_slot_accessors--------------------------------------------
# Get the list (equivalent to @molecularProfiles, except that it is robust to changes in RSet structure
str(molecularProfilesSlot(clevelandSmall), max.level=2)

# Get the names from the list
mDataNames(clevelandSmall)

## ----sample_meta_data---------------------------------------------------------
# Get sample metadata
phenoInf <- phenoInfo(clevelandSmall, 'cnv')

## ----print_sample_meta_data, echo=FALSE, fig.small=TRUE-----------------------
knitr::kable(phenoInf[, 1:5], row.names=FALSE)

## ----feature_meta_data--------------------------------------------------------
# Get feature metadata
featInfo <- featureInfo(clevelandSmall, 'rna')

## ----print_feature_meta_data, echo=FALSE, align="center"----------------------
knitr::kable(featInfo[1:3, 1:5], row.names=FALSE)

## ----molecular_data, fig.wide=TRUE--------------------------------------------
# Access the moleclar feature data
mProf <- molecularProfiles(clevelandSmall, 'rnaseq')

## ----print_molecular_profile_data, echo=FALSE---------------------------------
knitr::kable(mProf[1:3, 1:5])

## ----response_data_accessors--------------------------------------------------
# Get sensitivity slot
sens <- treatmentResponse(clevelandSmall)

## -----------------------------------------------------------------------------
# Get sensitivity raw data
sensRaw <- sensitivityRaw(clevelandSmall)

## -----------------------------------------------------------------------------
# Get sensitivity profiles
sensProf <- sensitivityProfiles(clevelandSmall)

## -----------------------------------------------------------------------------
# Get sensitivity info
sensInfo <- sensitivityInfo(clevelandSmall)

## ----model_fit----------------------------------------------------------------
# Extract raw sensitvity data from the RadioSet
sensRaw <- sensitivityRaw(clevelandSmall)

## ----structure_sensitivity_raw------------------------------------------------
str(sensRaw)

## ----cellline_names-----------------------------------------------------------
# Find a cancer cell-line of interest
head(sensitivityInfo(clevelandSmall)$sampleid)

## ----selecting_cancer_cell_line-----------------------------------------------
cancerCellLine <- sensitivityInfo(clevelandSmall)$sampleid[1]
print(cancerCellLine)

## ----extracting_dose_response_data--------------------------------------------
# Get the radiation doses and associated survival data from clevelandSmall
radiationDoses <- sensRaw[1, , 'Dose']
survivalFractions <- sensRaw[1, , 'Viability']

## ----fitting_lq_model---------------------------------------------------------
LQmodel <- linearQuadraticModel(D=radiationDoses,
                                SF=survivalFractions)
LQmodel

## ----metrics_computed_from_fit_parameters-------------------------------------
survFracAfter2Units <- computeSF2(pars=LQmodel)
print(survFracAfter2Units)

dose10PercentSurv <- computeD10(pars=LQmodel)
print(dose10PercentSurv)

## ----metrics_computed_from_dose_response_data---------------------------------
areaUnderDoseRespCurve <- RadioGx::computeAUC(D=radiationDoses, pars=LQmodel, lower=0,
                                     upper=1)
print(areaUnderDoseRespCurve)

## ----plotting_rad_dose_resp, fig.small=TRUE-----------------------------------
doseResponseCurve(
  Ds=list("Experiment 1" = c(0, 2, 4, 6)),
  SFs=list("Experiment 1" = c(1,.6,.4,.2)),
  plot.type="Both"
)

## ----plotting_rad_dose_resp_rSet, fig.small=TRUE------------------------------
doseResponseCurve(
  rSets=list(clevelandSmall),
  cellline=cellInfo(clevelandSmall)$sampleid[5]
)

## ----summarize_sensitivity----------------------------------------------------
sensSummary <- summarizeSensitivityProfiles(clevelandSmall)

## ----show_summarized_sensivitiy-----------------------------------------------
sensSummary[, 1:3]

## ----summarize_molecular_data-------------------------------------------------
mprofSummary <- summarizeMolecularProfiles(clevelandSmall, mDataType='rna', summary.stat='median', fill.missing=FALSE)

## ----show_summarized_sensitivity----------------------------------------------
mprofSummary

## ----compute_molecular_signature----------------------------------------------
radSensSig <- radSensitivitySig(clevelandSmall, mDataType='rna', features=fNames(clevelandSmall, 'rna')[2:5], nthread=1)

## ----exploring_molecular_signature--------------------------------------------
radSensSig@.Data

