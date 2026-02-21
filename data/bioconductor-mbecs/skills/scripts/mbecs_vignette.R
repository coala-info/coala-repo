# Code example from 'mbecs_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----DEPENDENCIES, echo=FALSE, eval=TRUE, results='asis', tidy=FALSE----------
# Dependency table
pkg_dependencies <- data.frame("Package"=c("phyloseq","magrittr","cluster",
                                           "dplyr","ggplot2","gridExtra",
                                           "limma","lme4","lmerTest","pheatmap",
                                           "rmarkdown","ruv","sva","tibble",
                                           "tidyr","vegan","methods","stats",
                                           "utils"),
                               "Version"=NA,
                               "Date"=NA,
                               "Repository"=NA)

for( pkg in 1:length(pkg_dependencies$Package) ) {
  pkg_dependencies$Version[pkg] <- 
      toString(utils::packageVersion(eval(pkg_dependencies$Package[pkg])))
  tmp_description <- 
      utils::packageDescription(eval(pkg_dependencies$Package[pkg]))
  pkg_dependencies$Date[pkg] <- toString(tmp_description["Date"])
  pkg_dependencies$Repository[pkg] <- toString(tmp_description["Repository"])
}


knitr::kable(pkg_dependencies, 
             align = 'c', 
             caption = "MBECS package dependencies",
             label = NULL)

## ----BIOCINSTALLATION, echo=TRUE, eval=FALSE, results='asis', tidy=FALSE------
# if (!"BiocManager" %in% rownames(installed.packages()))
#      install.packages("BiocManager")
# BiocManager::install("MBECS")

## ----GITINSTALLATION, echo=TRUE, eval=FALSE, results='asis', tidy=FALSE-------
# # Use the devtools package to install from a GitHub repository.
# install.packages("devtools")
# 
# # This will install the MBECS package from GitHub.
# devtools::install_github("rmolbrich/MBECS")

## ----ACTIVATION, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE-------------
library(MBECS)

## ----Load_dummies, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE-----------
# List object 
data(dummy.list)
# Phyloseq object
data(dummy.ps)
# MbecData object
data(dummy.mbec)

## ----Structure_list, echo=TRUE, eval=TRUE, tidy=FALSE-------------------------
# The dummy-list input object comprises two matrices:
names(dummy.list)

## ----Usage_list, echo=TRUE, eval=TRUE, tidy=FALSE-----------------------------
mbec.obj <- mbecProcessInput(dummy.list, 
                             required.col = c("group", "batch", "replicate"))

## ----Usage_phyloseq, echo=TRUE, eval=TRUE, tidy=FALSE-------------------------
mbec.obj <- mbecProcessInput(dummy.ps, 
                             required.col = c("group", "batch", "replicate"))

## ----Usage_tss_transformation, echo=TRUE, eval=TRUE, tidy=FALSE---------------
mbec.obj <- mbecTransform(mbec.obj, method = "tss")

## ----Usage_clr_transformation, echo=TRUE, eval=TRUE, tidy=FALSE---------------
mbec.obj <- mbecTransform(mbec.obj, method = "clr", offset = 0.0001)

## ----Usage_prelimreport, echo=TRUE, eval=FALSE, results='asis', tidy=FALSE----
# mbecReportPrelim(input.obj=mbec.obj, model.vars=c("batch","group"),
#                  type="clr")

## ----Usage_single_correction, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE----
mbec.obj <- mbecCorrection(mbec.obj, model.vars=c("batch","group"), 
                           method = "bat", type = "clr")

## ----Usage_multiple_correction, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE----
mbec.obj <- mbecRunCorrections(mbec.obj, model.vars=c("batch","group"),
                               method=c("ruv3","rbe","bmc","pn","svd"), 
                               type = "clr")

## ----Usage_postreport, echo=TRUE, eval=FALSE, results='asis', tidy=FALSE------
# mbecReportPost(input.obj=mbec.obj, model.vars=c("batch","group"),
#                type="clr")

## ----Usage_returnPS_clr, echo=TRUE, eval=FALSE, results='asis', tidy=FALSE----
# ps.clr <- mbecGetPhyloseq(mbec.obj, type="clr")

## ----Usage_returnPS_bmc, echo=TRUE, eval=FALSE, results='asis', tidy=FALSE----
# ps.bmc <- mbecGetPhyloseq(mbec.obj, type="cor", label="bmc")

## ----Usage_rle, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE--------------
rle.plot <- mbecRLE(input.obj=mbec.obj, model.vars = c("batch","group"), 
                    type="clr",return.data = FALSE) 

# Take a look.
plot(rle.plot)

## ----Usage_pca_one, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE----------
pca.plot <- mbecPCA(input.obj=mbec.obj, model.vars = "group", type="clr",
                    pca.axes=c(1,2), return.data = FALSE) 

## ----Usage_pca_two, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE----------
pca.plot <- mbecPCA(input.obj=mbec.obj, model.vars = c("batch","group"),
                    type="clr", pca.axes=c(1,2), return.data = FALSE) 

## ----Usage_box_n, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE------------
box.plot <- mbecBox(input.obj=mbec.obj, method = "TOP", n = 2, 
                    model.var = "batch", type="clr", return.data = FALSE) 

# Take a look.
plot(box.plot$OTU109)

## ----Usage_box_selected, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE-----
box.plot <- mbecBox(input.obj=mbec.obj, method = c("OTU1","OTU2"), 
                    model.var = "batch", type="clr", return.data = FALSE) 

# Take a look.
plot(box.plot$OTU2)

## ----Usage_heat, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE-------------
heat.plot <- mbecHeat(input.obj=mbec.obj, method = "TOP", n = 10, 
                    model.vars = c("batch","group"), center = TRUE,
                     scale = TRUE, type="clr", return.data = FALSE) 

## ----Usage_mosaic, echo=TRUE, eval=TRUE, results='asis', tidy=FALSE-----------
mosaic.plot <- mbecMosaic(input.obj = mbec.obj, 
                          model.vars = c("batch","group"),
                          return.data = FALSE)

## ----Usage_varLM, echo=TRUE, eval=TRUE, results='hide', fig.keep='all', message = FALSE, warning = FALSE, tidy=FALSE----
lm.variance <- mbecModelVariance(input.obj=mbec.obj, 
                                 model.vars = c("batch", "group"),
                                 method="lm",type="cor", label="svd")

# Produce plot from data.
lm.plot <- mbecVarianceStatsPlot(lm.variance)

# Take a look.
plot(lm.plot)

## ----Usage_varLMM, echo=TRUE, eval=TRUE, results='hide', fig.keep='all', message = FALSE, warning = FALSE, tidy=FALSE----
lmm.variance <- mbecModelVariance(input.obj=mbec.obj, 
                                  model.vars = c("batch","group"), 
                                  method="lmm",
                                  type="cor", label="ruv3")

# Produce plot from data.
lmm.plot <- mbecVarianceStatsPlot(lmm.variance)

# Take a look.
plot(lmm.plot)

## ----Usage_varRDA, echo=TRUE, eval=TRUE, results='hide', fig.keep='all', message = FALSE, warning = FALSE, tidy=FALSE----
rda.variance <- mbecModelVariance(input.obj=mbec.obj, 
                                  model.vars = c("batch", "group"),
                                  method="rda",type="cor", label="bat")

# Produce plot from data.
rda.plot <- mbecRDAStatsPlot(rda.variance)

# Take a look.
plot(rda.plot)

## ----Usage_varPVCA, echo=TRUE, eval=TRUE, results='hide', fig.keep='all', message = FALSE, warning = FALSE, tidy=FALSE----
pvca.variance <- mbecModelVariance(input.obj=mbec.obj, 
                                   model.vars = c("batch", "group"),
                                   method="pvca",type="cor", label="rbe")

# Produce plot from data.
pvca.plot <- mbecPVCAStatsPlot(pvca.variance)

# Take a look.
plot(pvca.plot)

## ----Usage_varSCOEF, echo=TRUE, eval=TRUE, results='hide', fig.keep='all', message = FALSE, warning = FALSE, tidy=FALSE----
sil.coefficient <- mbecModelVariance(input.obj=mbec.obj, 
                                     model.vars = c("batch", "group"),
                                     method="s.coef",type="cor", label="bmc")

# Produce plot from data.
scoef.plot <- mbecSCOEFStatsPlot(sil.coefficient)

# Take a look.
plot(scoef.plot)

## ----Session_Info, echo=FALSE, eval=TRUE--------------------------------------
print(sessionInfo(), locale = FALSE)

