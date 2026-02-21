# Code example from 'nonhuman' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
library(wheatmap)
library(dplyr)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----nh1, message=FALSE, warning=FALSE----------------------------------------
library(sesame)
sesameDataCache()

## ----nh3, message=FALSE, eval=FALSE-------------------------------------------
# betas = openSesame(sprintf("~/Downloads/GSM4411982", tmp), prep="SHCDPM")

## ----nh4, eval=FALSE----------------------------------------------------------
# ## equivalent to the above openSesame call
# betas = getBetas(matchDesign(pOOBAH(dyeBiasNL(inferInfiniumIChannel(
#     prefixMaskButC(inferSpecies(readIDATpair(
#         "~/Downloads/GSM4411982"))))))))

## ----nh13, message=FALSE, eval=TRUE-------------------------------------------
sdf = sesameDataGet("Mammal40.1.SigDF") # an example SigDF
inferSpecies(sdf, return.species = TRUE)

## ----nh14, message=FALSE------------------------------------------------------
## showing the candidate species with top scores
head(sort(inferSpecies(sdf, return.auc = TRUE), decreasing=TRUE))

## ----nh15, eval=FALSE---------------------------------------------------------
# sdf_mouse <- updateSigDF(sdf, species="mus_musculus")

## ----nh2, message=FALSE, eval=FALSE-------------------------------------------
# betas = openSesame("~/Downloads/204637490002_R05C01", prep="TQCDPB")

## ----nh9, message=FALSE-------------------------------------------------------
sdf = sesameDataGet("MM285.1.SigDF") # an example dataset
inferStrain(sdf, return.strain = TRUE) # return strain as a string
sdf_after = inferStrain(sdf)   # update mask and col by strain inference
sum(sdf$mask) # before strain inference
sum(sdf_after$mask) # after strain inference

## ----nh10, fig.width=6, fig.height=4, message=FALSE---------------------------
library(ggplot2)
p = inferStrain(sdf, return.probability = TRUE)
df = data.frame(strain=names(p), probs=p)
ggplot(data = df,  aes(x = strain, y = probs)) +
            geom_bar(stat = "identity", color="gray") +
            ggtitle("Strain Probabilities") +
            ylab("Probability") + xlab("") +
            scale_x_discrete(position = "top") +
            theme(axis.text.x = element_text(angle = 90, vjust=0.5, hjust=0),
            legend.position = "none")

## ----nh7, message=FALSE-------------------------------------------------------
sdf = sesameDataGet('MM285.1.SigDF')
sum(is.na(openSesame(sdf, prep="TQCDPB")))
sum(is.na(openSesame(sdf, prep="TQCD0PB")))

## -----------------------------------------------------------------------------
sessionInfo()

