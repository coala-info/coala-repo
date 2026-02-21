# Code example from 'brainImageR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ------------------------------------------------------------------------
library(brainImageR)
library(ggplot2)
brainImageR:::loadworkspace()

## ------------------------------------------------------------------------
data(vth)
length(vth)
head(vth)

## ------------------------------------------------------------------------
data(hipp)
length(hipp)
head(hipp)

## ---- message=FALSE, warning=FALSE---------------------------------------
### FILL THIS IN

## ---- message=FALSE, warning=FALSE---------------------------------------
composite <- SpatialEnrichment(genes = vth, reps = 2, refset = "developing")

## ------------------------------------------------------------------------
res <- testEnrich(composite, method = "fisher")

## ---- eval = FALSE-------------------------------------------------------
#  save(list = c("composite", "res"), file = "/mydir/myfile.rda")

## ------------------------------------------------------------------------
res <- res[order(res$FC, decreasing=TRUE),]
head(res)

## ---- fig.width = 6, fig.height = 5--------------------------------------
PlotEnrich(res)

## ------------------------------------------------------------------------
vth_lha_overlap <- GetGenes(vth, composite, tissue_abrev = "LHAa")
length(vth_lha_overlap)

## ------------------------------------------------------------------------
tis_in_region(composite, "LHAa")

## ---- message=FALSE, warning=FALSE---------------------------------------
composite <- CreateBrain(composite, res, slice = 5, pcut = 0.05)

## ---- fig.width=5, fig.height==7-----------------------------------------
PlotBrain(composite)

## ------------------------------------------------------------------------
available_areanames(composite, slice = 6)

## ------------------------------------------------------------------------
tis_set(composite, area.name = "Pu", slice = 6)

## ---- message=FALSE, warning=FALSE,fig.width = 10, fig.height = 5--------
vth_pld_overlap <- GetGenes(vth, composite, tissue_abrev = "Pmv")
length(vth_pld_overlap)
##vth_go <- enrichGO(gene = vth_pld_overlap,
##                   OrgDb = org.Hs.eg.db,
##                   keytype = 'SYMBOL',
##                   pvalueCutoff = 0.05, 
##                   qvalueCutoff = 0.05)

##dotplot(vth_go, showCategory=30)

## ------------------------------------------------------------------------
#grab the genes associated with hormone activity
#vth_go2 <- data.frame(vth_go)
#vth_match <- vth_go2$Description == "hormone activity"
#vth_pmv_hormone <- vth_go2[vth_match, "geneID"]
#vth_pmv_hormone <- unlist(strsplit(vth_pmv_hormone,"/"))


#identify the presence of these genes across all tissues
#vth_pmv_hormone_tis <- whichtissues(vth_pmv_hormone, refset = "developing")
#vth_pmv_hormone_tis[,1:10]


#which genes are present (1) in the LHAa
#all <- vth_pmv_hormone_tis[,"LHAa"]
#vth_pmv_hormone[ all == 1]

## ------------------------------------------------------------------------
data(dat)
dim(dat)
head(rownames(dat))
head(colnames(dat))

state <- do.call("rbind", strsplit(colnames(dat), ".", fixed = TRUE))[,1]

## ------------------------------------------------------------------------
#availabledatasets()

## ----warning=FALSE-------------------------------------------------------
time <- predict_time(dat,  minage = 8, maxage = 40)

## ----warning=FALSE,fig.width = 7, fig.height = 4-------------------------
PlotPred(time)

## ----warning=FALSE,fig.width = 7, fig.height = 4-------------------------
#time <- predict_time(dat,dataset = "prenatal")
#PlotPred(time)

## ----warning=FALSE,fig.width = 7, fig.height = 4-------------------------
#time2 <- data.frame(pred_age = time@pred_age, state)
#time2$state <- factor(time2$state, c("NPC","Neurons"))

#ggplot(time2, aes(state,pred_age))+
#  geom_boxplot()+
#  ylab("Predicted time, weeks post-conception")+
#  labs(title = "predicted developmental time,\ndataset = prenatal")


## ----warning=FALSE-------------------------------------------------------
#time <- predict_time(dat,minage = 40, tissue = "AMY")

