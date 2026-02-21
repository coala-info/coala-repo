# Code example from 'GettingStartedWithFlowStats' vignette. See references/ for full tutorial.

### R code from vignette source 'GettingStartedWithFlowStats.Rnw'

###################################################
### code chunk number 1: loadGvHD
###################################################
library(flowCore)
library(flowStats)
library(flowWorkspace)
library(ggcyto)
data(ITN)


###################################################
### code chunk number 2: transform
###################################################
require(scales)
gs <- GatingSet(ITN)
trans.func <- asinh
inv.func <- sinh
trans.obj <- trans_new("myAsinh", trans.func, inv.func)
transList <- transformerList(colnames(ITN)[3:7], trans.obj)
gs <- transform(gs, transList)


###################################################
### code chunk number 3: lymphGate
###################################################
lg <- lymphGate(gs_cyto_data(gs), channels=c("CD3", "SSC"),
                preselection="CD4", filterId="TCells",
                scale=2.5)
gs_pop_add(gs, lg)
recompute(gs)


###################################################
### code chunk number 4: lymphGatePlot
###################################################
ggcyto(gs, aes(x = CD3, y = SSC)) + geom_hex(bins = 32) + geom_gate("TCells")


###################################################
### code chunk number 5: variation
###################################################
require(ggridges)
require(gridExtra)
pars <- colnames(gs)[c(3,4,5,7)]

data <- gs_pop_get_data(gs, "TCells")
plots <- lapply(pars, function(par)
  as.ggplot(ggcyto(data, aes(x = !!par, fill = GroupID)) +
    geom_density_ridges(mapping = aes(y = name), alpha = 0.4) +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()) +
    facet_null()
  ))
do.call("grid.arrange", c(plots, nrow=1))


###################################################
### code chunk number 6: quad_gate
###################################################
qgate <- quadrantGate(gs_pop_get_data(gs, "TCells"), stains=c("CD4", "CD8"),
                      filterId="CD4CD8", sd=3)
gs_pop_add(gs, qgate, parent = "TCells")
recompute(gs)


###################################################
### code chunk number 7: quad_gate_norm
###################################################
gs <- normalize(gs, populations=c("CD4+CD8+", "CD4+CD8-", "CD4-CD8+", "CD4-CD8-"), 
                     dims=c("CD4", "CD8"), minCountThreshold = 50)


###################################################
### code chunk number 8: variation_norm
###################################################
data <- gs_pop_get_data(gs, "TCells")
plots <- lapply(pars, function(par)
  as.ggplot(ggcyto(data, aes(x = !!par, fill = GroupID)) +
    geom_density_ridges(mapping = aes(y = name), alpha = 0.4) +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()) +
    facet_null()
  ))
do.call("grid.arrange", c(plots, nrow=1))


###################################################
### code chunk number 9: quad_gate_norm_plot
###################################################
ggcyto(gs_pop_get_data(gs, "TCells"), aes(x=CD4, y=CD8)) +
  geom_hex(bins=32) +
  geom_gate(gs_pop_get_gate(gs, "CD4-CD8-")) +
  geom_gate(gs_pop_get_gate(gs, "CD4-CD8+")) +
  geom_gate(gs_pop_get_gate(gs, "CD4+CD8-")) +
  geom_gate(gs_pop_get_gate(gs, "CD4+CD8+"))


###################################################
### code chunk number 10: rangeGate
###################################################
CD69rg <- rangeGate(gs_cyto_data(gs), stain="CD69",
                    alpha=0.75, filterId="CD4+CD8-CD69", sd=2.5)
gs_pop_add(gs, CD69rg, parent="CD4+CD8-")
# gs_pop_add(gs, CD69rg, parent="CD4+CD8-", name = "CD4+CD8-CD69-", negated=TRUE)
recompute(gs)


###################################################
### code chunk number 11: rangeGatePlot
###################################################
ggcyto(gs_pop_get_data(gs, "CD4+CD8-"), aes(x=CD69, fill = GroupID)) +
    geom_density_ridges(mapping = aes(y = name), alpha = 0.4) +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()) +
    geom_vline(xintercept = CD69rg@min) +
    facet_null() +
    ggtitle("CD4+")


###################################################
### code chunk number 12: rangeGate_norm
###################################################
gs <- normalize(gs, populations=c("CD4+CD8-CD69"), 
                     dims=c("CD69"), minCountThreshold = 50)


###################################################
### code chunk number 13: rangeGate_norm_plot
###################################################
ggcyto(gs_pop_get_data(gs, "CD4+CD8-"), aes(x=CD69, fill = GroupID)) +
    geom_density_ridges(mapping = aes(y = name), alpha = 0.4) +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()) +
    geom_vline(xintercept = CD69rg@min) +
    facet_null() +
    ggtitle("CD4+")


###################################################
### code chunk number 14: createData
###################################################
dat <- gs_cyto_data(gs)



###################################################
### code chunk number 15: rawData
###################################################
autoplot(dat, "CD4", "CD8") +
  ggtitle("Experimental Dataset")


###################################################
### code chunk number 16: createControlData
###################################################
datComb <- as(dat,"flowFrame")
subCount <- nrow(exprs(datComb))/length(dat)
	sf <- sampleFilter(filterId="mySampleFilter", size=subCount)
	fres <- filter(datComb, sf)
	ctrlData <- Subset(datComb, fres)
	ctrlData <- ctrlData[,-ncol(ctrlData)] ##remove the  column name "original"
	


###################################################
### code chunk number 17: BinControlData
###################################################
minRow=subCount*0.05
refBins<-proBin(ctrlData,minRow,channels=c("CD4","CD8"))
	


###################################################
### code chunk number 18: controlBinsPlot
###################################################
plotBins(refBins,ctrlData,channels=c("CD4","CD8"),title="Control Data")



###################################################
### code chunk number 19: binSampleData
###################################################
sampBins <- fsApply(dat,function(x){
		   binByRef(refBins,x)
		   })


###################################################
### code chunk number 20: pearsonStat
###################################################
pearsonStat <- lapply(sampBins,function(x){
		      calcPearsonChi(refBins,x)
                     })


###################################################
### code chunk number 21: Roderers PBin metric
###################################################
sCount <- fsApply(dat,nrow)
pBStat <-lapply(seq_along(sampBins),function(x){
		calcPBChiSquare(refBins,sampBins[[x]],subCount,sCount[x])
		})


###################################################
### code chunk number 22: plotBinsresiduals
###################################################
par(mfrow=c(4,4),mar=c(1.5,1.5,1.5,1.5))

plotBins(refBins,ctrlData,channels=c("CD4","CD8"),title="Control Data")
patNames <-sampleNames(dat)
tm<-lapply(seq_len(length(dat)),function(x){
		plotBins(refBins,dat[[x]],channels=c("CD4","CD8"),
			title=patNames[x],
			residuals=pearsonStat[[x]]$residuals[2,],
			shadeFactor=0.7)
		
		}
      )


###################################################
### code chunk number 23: chiSqstatisticvalues
###################################################
library(xtable)
chi_Square_Statistic <- unlist(lapply(pearsonStat,function(x){
		x$statistic
		}))

pBin_Statistic <-unlist(lapply(pBStat,function(x){
                x$pbStat
						                        })) 
	
frame <- data.frame(chi_Square_Statistic, pBin_Statistic)
rownames(frame) <- patNames
 	


###################################################
### code chunk number 24: GettingStartedWithFlowStats.Rnw:395-396
###################################################
print(xtable(frame))


###################################################
### code chunk number 25: GettingStartedWithFlowStats.Rnw:402-403
###################################################
toLatex(sessionInfo())


