# Code example from 'CytoMethIC' vignette. See references/ for full tutorial.

## ----cyto-model, result="asis", echo=FALSE, message=FALSE---------------------
library(knitr)
library(CytoMethIC)
kable(cmi_models[
    cmi_models$PredictionGroup == "1. Basic",
    c("EHID", "ModelID", "PredictionLabel")],
    caption = "CytoMethIC Basic Models"
)

## ----cyto0, message=FALSE-----------------------------------------------------
library(sesame)
library(CytoMethIC)
betasHM450 = imputeBetas(sesameDataGet("HM450.1.TCGA.PAAD")$betas)

## ----cyto2, message=FALSE, eval=FALSE-----------------------------------------
# betasEPIC = openSesame(sesameDataGet("EPICv2.8.SigDF")[[1]], mask=FALSE)
# betasHM450 = imputeBetas(mLiftOver(betasEPIC, "HM450"))

## -----------------------------------------------------------------------------
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/Sex2_HM450_20240114.rds"))
cmi_predict(betasHM450, model)

## ----cyto1, message=FALSE, warning=FALSE--------------------------------------
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/Age_HM450_20240504.rds"))
cmi_predict(betasHM450, model)

## ----cyto6, message=FALSE-----------------------------------------------------
model = ExperimentHub()[["EH8421"]] # the same as "https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/Race5_rfcTCGA_InfHum3.rds"
cmi_predict(betasHM450, model)

## ----cyto-basic8--------------------------------------------------------------
## leukocyte fractions
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/LeukoFrac_HM450_20240614.rds"))
cmi_predict(betasHM450, model)

## ----cyto-basic9, fig.width=4, fig.height=4, eval=FALSE-----------------------
# model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/TissueComp_HM450_20240827.rds"))
# cell_comps = cmi_predict(betasHM450, model)
# cell_comps = enframe(cell_comps$frac, name="cell_type", value="frac")
# cell_comps = cell_comps |> filter(frac>0)
# 
# ggplot(cell_comps, aes(x="", y=frac, fill=cell_type)) +
#     geom_bar(stat="identity", width=1) +
#     coord_polar(theta="y") +
#     theme_void() + labs(fill = "Cell Type") +
#     theme(plot.title = element_text(hjust = 0.5))

## -----------------------------------------------------------------------------
sessionInfo()

