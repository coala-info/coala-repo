# Code example from 'Workflow_WTA_kidney' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("GeoDiff")

## ----setup, results='hide', warning=FALSE, message=FALSE----------------------
library(GeoDiff)
library(dplyr)
library(ggplot2)
library(NanoStringNCTools)
library(GeomxTools)
library(Biobase)
library(reshape2)

## ----load data----------------------------------------------------------------
data("kidney")

#Update to current NanoStringGeoMxSet version
kidney <- updateGeoMxSet(kidney)

kidney

head(pData(kidney))

table(pData(kidney)$`slide name`)
table(pData(kidney)$region)

## -----------------------------------------------------------------------------
kidney <- kidney[, which(kidney$`slide name` %in% c("disease3", "normal3"))][, c(1:4, 48:51,
                                                                                 60:63, 115:118)]
table(kidney$region, kidney$`slide name`)
table(kidney$`slide name`, kidney$class)

## ----probe level--------------------------------------------------------------
featureType(kidney)

paste("## of Negative Probes:", sum(fData(kidney)$Negative))

## -----------------------------------------------------------------------------
kidney <- fitPoisBG(kidney)

summary(pData(kidney)$sizefact)
summary(fData(kidney)$featfact[fData(kidney)$Negative])

## -----------------------------------------------------------------------------
set.seed(123)
kidney_diag <- diagPoisBG(kidney)

notes(kidney_diag)$disper

## ----eval=FALSE---------------------------------------------------------------
# which(assayDataElement(kidney_diag, "low_outlier") == 1, arr.ind = TRUE)
# which(assayDataElement(kidney_diag, "up_outlier") == 1, arr.ind = TRUE)

## -----------------------------------------------------------------------------
kidney <- fitPoisBG(kidney, groupvar = "slide name")

## -----------------------------------------------------------------------------
set.seed(123)
kidney_diag <- diagPoisBG(kidney, split = TRUE)
notes(kidney_diag)$disper_sp

## -----------------------------------------------------------------------------
all0probeidx <- which(rowSums(exprs(kidney))==0)
if (length(all0probeidx) > 0) {
    kidney <- kidney[-all0probeidx, ]
}
kidney <- aggreprobe(kidney, use = "cor")

## -----------------------------------------------------------------------------
kidney <- BGScoreTest(kidney)

sum(fData(kidney)[["pvalues"]] < 1e-3, na.rm = TRUE)

## -----------------------------------------------------------------------------
kidneySplit <- BGScoreTest(kidney, split = TRUE, removeoutlier = FALSE, useprior = FALSE)
sum(fData(kidneySplit)[["pvalues"]] < 1e-3, na.rm = TRUE)

kidneyOutliers <- BGScoreTest(kidney, split = FALSE, removeoutlier = TRUE, useprior = FALSE)
sum(fData(kidneyOutliers)[["pvalues"]] < 1e-3, na.rm = TRUE)

kidneyPrior <- BGScoreTest(kidney, split = FALSE, removeoutlier = FALSE, useprior = TRUE)
sum(fData(kidneyPrior)[["pvalues"]] < 1e-3, na.rm = TRUE)

## -----------------------------------------------------------------------------
set.seed(123)

kidney <- fitNBth(kidney, split = TRUE)

features_high <- rownames(fData(kidney))[fData(kidney)$feature_high_fitNBth == 1]

length(features_high)

## -----------------------------------------------------------------------------
bgMean <- mean(fData(kidney)$featfact, na.rm = TRUE)

notes(kidney)[["threshold"]]
bgMean

## -----------------------------------------------------------------------------
cor(kidney$sizefact, kidney$sizefact_fitNBth)
plot(kidney$sizefact, kidney$sizefact_fitNBth, xlab = "Background Size Factor",
     ylab = "Signal Size Factor")
abline(a = 0, b = 1)

## -----------------------------------------------------------------------------
# get only biological probes
posdat <- kidney[-which(fData(kidney)$CodeClass == "Negative"), ]
posdat <- exprs(posdat)

quan <- sapply(c(0.75, 0.8, 0.9, 0.95), function(y)
  apply(posdat, 2, function(x) quantile(x, probs = y)))

corrs <- apply(quan, 2, function(x) cor(x, kidney$sizefact_fitNBth))
names(corrs) <- c(0.75, 0.8, 0.9, 0.95)

corrs

quan75 <- apply(posdat, 2, function(x) quantile(x, probs = 0.75))

## -----------------------------------------------------------------------------
kidney <- QuanRange(kidney, split = FALSE, probs = c(0.75, 0.8, 0.9, 0.95))

corrs <- apply(pData(kidney)[, as.character(c(0.75, 0.8, 0.9, 0.95))], 2, function(x)
  cor(x, kidney$sizefact_fitNBth))

names(corrs) <- c(0.75, 0.8, 0.9, 0.95)

corrs

## -----------------------------------------------------------------------------
ROIs_high <- sampleNames(kidney)[which((quantile(fData(kidney)[["para"]][, 1],
                                                  probs = 0.90, na.rm = TRUE) -
                                          notes(kidney)[["threshold"]])*kidney$sizefact_fitNBth>2)]

features_all <- rownames(posdat)

## -----------------------------------------------------------------------------

NBthDEmod <- fitNBthDE(form = ~region,
                       split = FALSE,
                       object = kidney)

str(NBthDEmod)

## ----echo=FALSE---------------------------------------------------------------
if(!"ACADM" %in% features_high[1:30]){
  if("ACADM" %in% features_high){
    features_high[which(features_high == "ACADM")] <- features_high[28]
  }
  features_high[28] <- "ACADM"
}

## -----------------------------------------------------------------------------
pData(kidney)$region <- factor(pData(kidney)$region, levels=c("glomerulus", "tubule"))

table(pData(kidney)[, c("region", "slide name")])

features_high_subset <- features_high[1:30]

## ----message=FALSE------------------------------------------------------------
set.seed(123)
NBthmDEmod <- fitNBthmDE(object = kidney,
                         form = ~ region+(1|`slide name`),
                         ROIs_high = ROIs_high,
                         split = FALSE,
                         features_all = features_high_subset,
                         preci1=NBthDEmod$preci1,
                         threshold_mean = bgMean,
                         sizescale = TRUE,
                         controlRandom=list(nu=12, nmh_e=400, thin_e=60))

str(NBthmDEmod)

## ----message=FALSE------------------------------------------------------------
set.seed(123)
NBthmDEmodslope <- fitNBthmDE(object = kidney,
                              form = ~ region+(1+region|`slide name`),
                              ROIs_high = ROIs_high,
                              split = FALSE,
                              features_all = features_high_subset,
                              preci1=NBthDEmod$preci1,
                              threshold_mean = bgMean,
                              sizescale = TRUE,
                              controlRandom=list(nu=12, nmh_e=400, thin_e=60))

## ----fig.height=4, fig.width=4------------------------------------------------
plot(NBthDEmod$para[2,names(NBthmDEmod$para[2,])], NBthmDEmod$para[2,],
     xlab = "Fixed Effect Model Output Parameters", ylab = "Mixed Effect Model Output Parameters")
abline(a=0,b=1)

plot(NBthDEmod$para[2,names(NBthmDEmodslope$para[2,])], NBthmDEmodslope$para[2,],
     xlab = "Fixed Effect Model Output Parameters", ylab = "Random Slope Model Output Parameters")
abline(a=0,b=1)


## -----------------------------------------------------------------------------
diff_high <- names(which(abs(NBthDEmod$para[2,names(NBthmDEmodslope$para[2,])]-
                               NBthmDEmodslope$para[2,])>0.6))
diff_high
set.seed(123)

NBthmDEmodslope$theta[3, "ACADM"]


annot <- pData(kidney)
annot$ACADM <- posdat["ACADM",]

## ----fig.height=4, fig.width=4------------------------------------------------

plot_dat <- annot[,c("region", "ACADM", "slide name")]

p <- ggplot(plot_dat, aes(x=`slide name`, y=ACADM, fill=region)) +
  geom_boxplot()

plot(p)


## -----------------------------------------------------------------------------
coeff <- coefNBth(NBthDEmod)
coefr <- coefNBth(NBthmDEmod)
coefrslope <- coefNBth(NBthmDEmodslope)

str(coeff)

## -----------------------------------------------------------------------------
rownames(coeff$estimate)[-1]

## -----------------------------------------------------------------------------
DEtab <- DENBth(coeff, variable = "regiontubule")
DEtabr <- DENBth(coefr, variable = "regiontubule")
DEtabrslope <- DENBth(coefrslope, variable = "regiontubule")

head(DEtab)

## -----------------------------------------------------------------------------
set.seed(123)

names(assayData(kidney))

kidney <- fitPoisthNorm(object = kidney,
                        ROIs_high = ROIs_high,
                        threshold_mean = bgMean,
                        sizescalebythreshold = TRUE)

names(assayData(kidney))

head(fData(kidney)[,(ncol(fData(kidney))-6):ncol(fData(kidney))])

head(pData(kidney))

## -----------------------------------------------------------------------------
set.seed(123)

kidney <- fitPoisthNorm(object = kidney,
                        split = TRUE,
                        ROIs_high = ROIs_high,
                        threshold_mean = bgMean,
                        sizescalebythreshold = TRUE)

names(assayData(kidney))


## -----------------------------------------------------------------------------
norm_dat_backqu75 <- sweep(posdat[, ROIs_high], 2,
                           (kidney[, ROIs_high]$sizefact * bgMean),
                           FUN = "-") %>%
  sweep(., 2, quan75[ROIs_high], FUN = "/") %>%
  pmax(., 0) %>%
  `+`(., 0.01) %>%
  log2()

## ----fig.height=4, fig.width=4------------------------------------------------
dat_plot <- cbind(pData(kidney)[ROIs_high, c("slide name", "region")],
                  t(norm_dat_backqu75[features_all, ]))

dat_plot <- cbind(dat_plot, ROI_ID = ROIs_high)

dat_plot <- melt(dat_plot, id.vars = c("ROI_ID", "slide name", "region"))

ggplot(dat_plot, aes(x = value)) +
  geom_density(aes(fill = region, group = ROI_ID, alpha = 0.01)) +
  facet_grid(~`slide name`) +
  ggtitle("Q3 Normalization")+
  labs(x = "Q3 Normalized Value (log2)")

## ----fig.height=4, fig.width=4------------------------------------------------
annot <- pData(kidney)

dat_plot <- cbind(annot[ROIs_high, c("slide name", "region")],
                  t(assayDataElement(kidney[features_high, ROIs_high], "normmat_sp")))

dat_plot <- cbind(dat_plot, ROI_ID = ROIs_high)

dat_plot <- melt(dat_plot, id.vars = c("ROI_ID", "slide name", "region"))

ggplot(dat_plot, aes(x = value)) +
  geom_density(aes(fill = region, group = ROI_ID, alpha = 0.01)) +
  facet_wrap(~`slide name`) +
  ggtitle("Poisson threshold normalization")+
  labs(x = "Poisson Threshold Normalized Value (log2)")

## ----fig.height=4, fig.width=4------------------------------------------------
dat <- t(norm_dat_backqu75[features_high, ])
dat_pca <- prcomp(dat, center = TRUE, scale. = TRUE)
dat <- as.data.frame(dat)

dat$PC1 <- dat_pca$x[, 1]
dat$PC2 <- dat_pca$x[, 2]
dat$id <- annot$`slide name`[match(ROIs_high, colnames(posdat))]
dat$class <- annot$class[match(ROIs_high, colnames(posdat))]
dat$region <- annot$region[match(ROIs_high, colnames(posdat))]
dat$sizeratio <- kidney[, ROIs_high]$sizefact_fitNBth / kidney[, ROIs_high]$sizefact

p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = paste(class, region))) +
  theme_bw()+
  labs(title = "Q3 Normalized Data")

plot(p)

p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = log2(sizeratio))) +
  theme_bw()+
  scale_color_gradient2(high = "gold", mid = "grey50", low = "darkblue", midpoint = 0.2)+
  labs(title = "Q3 Normalized Data")

plot(p)

## ----fig.height=4, fig.width=4------------------------------------------------
dat <- t(assayDataElement(kidney[features_high, ROIs_high],"normmat_sp"))
dat_pca <- prcomp(dat, center = TRUE, scale. = TRUE)
dat <- as.data.frame(dat)

dat$PC1 <- dat_pca$x[, 1]
dat$PC2 <- dat_pca$x[, 2]
dat$id <- annot$`slide name`[match(ROIs_high, colnames(posdat))]
dat$class <- annot$class[match(ROIs_high, colnames(posdat))]
dat$region <- annot$region[match(ROIs_high, colnames(posdat))]
dat$sizeratio <- kidney[, ROIs_high]$sizefact_fitNBt / kidney[, ROIs_high]$sizefact

p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = paste(class, region))) +
  theme_bw()+
  labs(title = "Poisson Threshold Normalized Data")

plot(p)

p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = log2(sizeratio))) +
  theme_bw()+
  scale_color_gradient2(high = "gold", mid = "grey50", low = "darkblue", midpoint = 0.2)+
  labs(title = "Poisson Threshold Normalized Data")

plot(p)

## -----------------------------------------------------------------------------
sessionInfo()

