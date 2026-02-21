# Code example from 'documentation' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE------------------------------------------------
knitr::opts_chunk$set(
  cache=TRUE, autodep=TRUE, warning=FALSE, error=FALSE, message=FALSE,
  echo=TRUE, out.width=".5\\textwidth",
  duplicate.label="allow", fig.pos <- "H", out.extra = "")

## -----------------------------------------------------------------------------
library(moanin)
library(timecoursedata)
data(varoquaux2019leaf)
names(varoquaux2019leaf)

## -----------------------------------------------------------------------------
whSamples<-with(varoquaux2019leaf$meta,which(Genotype=="BT642" & Week >2))
preData<-varoquaux2019leaf$data[,whSamples]
preMeta<-varoquaux2019leaf$meta[whSamples,]
dim(preData)
dim(preMeta)

## -----------------------------------------------------------------------------
moaninObject <- create_moanin_model(data=preData, meta=preMeta, 
                            group_variable="Condition", time_variable="Week")
moaninObject

## -----------------------------------------------------------------------------
moaninObject[,1:2]

## -----------------------------------------------------------------------------
logMoaninObject<-moaninObject
assay(logMoaninObject)<-log(assay(moaninObject)+1)

## -----------------------------------------------------------------------------
preContrasts <- create_timepoints_contrasts(moaninObject,"Preflowering", "Control")

## -----------------------------------------------------------------------------
postContrasts <- create_timepoints_contrasts(
    moaninObject, "Postflowering", "Control" )
prepostContrasts <- create_timepoints_contrasts(
    moaninObject, "Postflowering", "Preflowering")

## -----------------------------------------------------------------------------
weeklyPre <- DE_timepoints(moaninObject[1:500,], 
    contrasts=c(preContrasts,postContrasts,prepostContrasts),
     use_voom_weights=TRUE)

## -----------------------------------------------------------------------------
dim(weeklyPre)
head(weeklyPre[,1:10])

## -----------------------------------------------------------------------------
preDiffContrasts <- create_timepoints_contrasts(
    moaninObject, "Preflowering" ,type="per_group_timepoint_diff")
head(preDiffContrasts)

## -----------------------------------------------------------------------------
preGroupDiffContrasts <- create_timepoints_contrasts(
    moaninObject, "Preflowering", "Control" ,type="group_and_timepoint_diff")
head(preGroupDiffContrasts)

## -----------------------------------------------------------------------------
preGroupDiffContrasts <- create_timepoints_contrasts(
    moaninObject, "Preflowering", "Control" ,
    type="group_and_timepoint_diff",timepoints_before=c(6,8),timepoints_after=c(8,9))
head(preDiffContrasts)

## -----------------------------------------------------------------------------
weeklyGroupDiffPre <- DE_timepoints(moaninObject[1:500,], 
    contrasts=preGroupDiffContrasts,
     use_voom_weights=TRUE)
head(weeklyGroupDiffPre)

## -----------------------------------------------------------------------------
timecourseContrasts <- c("Preflowering-Control",
			 "Postflowering-Control",
			 "Postflowering-Preflowering")
splinePre <- DE_timecourse(moaninObject[1:500,], contrasts=timecourseContrasts,
     use_voom_weights=TRUE)

## -----------------------------------------------------------------------------
head(splinePre)

## -----------------------------------------------------------------------------
log_fold_change_timepoints <- estimate_log_fold_change(
    moaninObject[1:500,], contrasts=timecourseContrasts, method="sum")
head(log_fold_change_timepoints)

## -----------------------------------------------------------------------------
whSig <- which(splinePre[,"Preflowering-Control_qval"]<0.05)
deGenes <- order(abs(
    log_fold_change_timepoints)[whSig,"Preflowering-Control"],
    decreasing=TRUE)[1:10]

plot_splines_data(moaninObject[whSig, ][deGenes,],
    smooth=TRUE, mar=c(1.5,2.5,2,0.1))

## ----clustering---------------------------------------------------------------
# First fit the kmeans clusters
kmeans_clusters <- splines_kmeans(moaninObject[1:500,], n_clusters=3,
    random_seed=42, 
    n_init=20)

## -----------------------------------------------------------------------------
plot_splines_data(
    data=kmeans_clusters$centroids, moaninObject,
    smooth=TRUE)

## -----------------------------------------------------------------------------
scores_and_labels <- splines_kmeans_score_and_label(
    object=moaninObject,data=preData[1:2000,], kmeans_clusters=kmeans_clusters)

## -----------------------------------------------------------------------------
head(scores_and_labels$scores)

## -----------------------------------------------------------------------------
head(scores_and_labels$labels)
# How many are not assigned a label?
sum(is.na(scores_and_labels$labels))

