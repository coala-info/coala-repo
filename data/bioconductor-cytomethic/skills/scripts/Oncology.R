# Code example from 'Oncology' vignette. See references/ for full tutorial.

## ----cyto-model, result="asis", echo=FALSE, message=FALSE---------------------
library(knitr)
library(CytoMethIC)
kable(cmi_models[
    cmi_models$PredictionGroup == "2. Oncology",
    c("EHID", "ModelID", "PredictionLabel")],
    caption = "CytoMethIC Oncology Models"
)

## ----cyto4, message=FALSE-----------------------------------------------------
## for missing data
library(sesame)
library(CytoMethIC)
betas = imputeBetas(sesameDataGet("HM450.1.TCGA.PAAD")$betas)
model = ExperimentHub()[["EH8395"]] # Random forest model
cmi_predict(betas, model)

model = ExperimentHub()[["EH8396"]] # SVM model
cmi_predict(betas, model)

model = ExperimentHub()[["EH8422"]] # Cancer subtype
cmi_predict(sesameDataGet("HM450.1.TCGA.PAAD")$betas, model)

## ----cyto7, message=FALSE-----------------------------------------------------
model = ExperimentHub()[["EH8423"]]
cmi_predict(sesameDataGet("HM450.1.TCGA.PAAD")$betas, model)

## -----------------------------------------------------------------------------
sessionInfo()

