# Code example from 'DataQualityAssessment' vignette. See references/ for full tutorial.

### R code from vignette source 'DataQualityAssessment.Rnw'

###################################################
### code chunk number 1: cellnum
###################################################
library(flowQ)
data(GvHD)
GvHD <- GvHD[1:10]
dest <- file.path(tempdir(), "flowQ")
qp1 <- qaProcess.cellnumber(GvHD, outdir=dest, cFactor=0.75)


###################################################
### code chunk number 2: cellnumfig
###################################################
img <- qp1@summaryGraph@fileNames[2]
to <- paste(flowQ:::guid(), "pdf", sep=".")
f <- file.copy(img, to)
cat(sprintf("\\myincfig{%s}{0.5\\textwidth}{%s}{%s}\n", to,
            paste("Summary graphics for the cell number QA criterion produced",
                  "by the \\Rfunction{qaProcess.cellnumber} function."), 
            "cellnum"))


###################################################
### code chunk number 3: margin
###################################################
qp2 <- qaProcess.marginevents(GvHD, channels=c("FSC-H", "SSC-H"), outdir=dest,
                              pdf=FALSE)


###################################################
### code chunk number 4: marginsumfig
###################################################
img <- qp2@summaryGraph@fileNames[2]
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(img, to)
cat(sprintf("\\myincfig{%s}{0.8\\textwidth}{%s}{%s}\n", to,
            paste("Summary graphics of the FSC-H channel for the boundary event",
                  "QA criterion produced by the \\Rfunction{qaProcess.marginevent}",
                  "function."), "marginsum"))


###################################################
### code chunk number 5: margindetfig
###################################################
img <- qp2@frameProcesses[[1]]@frameGraphs[[1]]@fileNames[[2]]
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(img, to)
cat(sprintf("\\myincfig{%s}{0.6\\textwidth}{%s}{%s}\n", to,
            paste("Detailed sample-specific graphics of the FSC-H channel",
                  "for the boundary event QA criterion produced by the",
                  "\\Rfunction{qaProcess.marginevent}function."), "margindet"))


###################################################
### code chunk number 6: time
###################################################
GvHD <- transform(GvHD, "FL1-H"=asinh(`FL1-H`), "FL2-H"=asinh(`FL2-H`))
qp3 <- qaProcess.timeline(GvHD, channel="FL1-H", outdir=dest, cutoff=1)
qp4 <- qaProcess.timeflow(GvHD, outdir=dest, cutoff=2)


###################################################
### code chunk number 7: timefig
###################################################
img <- qp3@summaryGraph@fileNames[2]
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(img, to)
cat(sprintf("\\myincfig{%s}{0.6\\textwidth}{%s}{%s}\n", to,
            paste("Summary graphics of the FL1-H channel for the time line",
                  "QA criterion produced by the \\Rfunction{qaProcess.timeline}",
                  "function."), "timeline"))


###################################################
### code chunk number 8: htmlreport
###################################################
url <- writeQAReport(GvHD, processes=list(qp1, qp2, qp3, qp4), outdir=dest)


###################################################
### code chunk number 9: browse (eval = FALSE)
###################################################
## browseURL(url)


###################################################
### code chunk number 10: loadPackage
###################################################
library(RColorBrewer)
library(latticeExtra)


###################################################
### code chunk number 11: Read_Transform
###################################################
data(qData)
qData[[1]][[1]]


###################################################
### code chunk number 12: transformData
###################################################
tData <- lapply(qData, function(x) transformList(colnames(x)[3:7], asinh) %on% x)


###################################################
### code chunk number 13: Plot1_TransformedData
###################################################
library(flowViz)
plot(tData[[1]][[1]])


###################################################
### code chunk number 14: displayBoundaryData
###################################################
resBoundary <- qaProcess.BoundaryPlot(tData, dyes=c("FSC-A","CD3"), 
                                      outdir=dest, cutoff=3, pdf=TRUE)
imagePath <- resBoundary@summaryGraph@fileNames[2]
#writeQAReport(tData[[1]], list(resBoundary), outdir=dest,pdf=TRUE)


###################################################
### code chunk number 15: displayBoundImage
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 16: BoundaryEvents
###################################################

createBoundaryFilterList<-function(flowSet){
    len <- length(colnames(flowSet))
    tmp<-fsApply(flowSet,range)
    tmp<-lapply(tmp,function(x){
        x[[colnames(x)[len]]]<-NULL
        x
    })
    res<-lapply(tmp,function(y){
        apply(y,2,function(x){
        # 2*x-extendrange(r=x,0.1)
          c((x[1]+2*.Machine$double.eps),(x[2]-2*.Machine$double.eps))
        })
    
    })
    filtList<-lapply(res,function(x){
            rectangleGate(filterId="boundary",.gate=x)
    }		)	
    return(filtList)
}

boundData<-list()
for(i in seq_len(length(tData))){
    wfNew <- workFlow(tData[[i]], name="panel")
    filtList<-createBoundaryFilterList(Data(wfNew[["base view"]]))
    flt<-filterList(x=filtList,filterId="boundary")
    add(wfNew,flt)
    boundData[[i]] <- Data(wfNew[["boundary+"]])
    rm(wfNew)
    cat(i)
    cat(".")
}


###################################################
### code chunk number 17: Data Normalization
###################################################
  library(flowStats)
  patientID=sampleNames(boundData[[1]])
  ls <- length(patientID)
  #dupes <- locateDuplicatedParameters(boundData)
  #nData<-normalizeSets(flowList=boundData,dupes=dupes[-c(1,2)]) ## ignoring FSC-A, SSC-A
  nData<-normalizeSets(flowList=boundData,dupes=c("CD8","CD27","CD4"))


###################################################
### code chunk number 18: getDistances
###################################################
getDistance<-function(res,dyes){
len<-length(res@frameProcesses)
result<-data.frame()
for( j in seq_len(length(dyes))){

    for (i in seq_len(len)){
    
        patName<-res@frameProcesses[[i]]@frameID
        dist   <-res@frameProcesses[[i]]@frameAggregators@.Data[[j]]@x
        passed <-res@frameProcesses[[i]]@frameAggregators@.Data[[j]]@passed
        tempRes<-data.frame(Patient=patName,Parameter=dyes[j],Passed=passed,
                  Distance=dist,check.names=F)   
    	result<-rbind(result,tempRes)
}
}
return(result)
}


###################################################
### code chunk number 19: ECDF plots 1
###################################################
dyes<- c("FSC-A","SSC-A")
resFSCECDF <- qaProcess.ECDFPlot(nData,dyes=dyes,outdir=dest,alpha=0.4,pdf=TRUE)
#ecdfUrl<-writeQAReport(nData[[1]], list(resFSCECDF), outdir=dest,pdf=TRUE)
#browseURL(ecdfUrl)



###################################################
### code chunk number 20: genTblECDF
###################################################
imagePath<-resFSCECDF@summaryGraph@fileNames[2]
getDistance(resFSCECDF,dyes)


###################################################
### code chunk number 21: produceFSCECDFimage
###################################################
to <- paste(flowQ:::guid(), "pdf", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 22: ECDF plots 2
###################################################
resCD8ECDF <- qaProcess.ECDFPlot(nData,dyes=c("CD8","CD27"),outdir=dest,alpha=0.4,pdf=TRUE)


###################################################
### code chunk number 23: genTblECDF2
###################################################
imagePath<-resCD8ECDF@summaryGraph@fileNames[2]
getDistance(resCD8ECDF,c("CD8","CD27"))



###################################################
### code chunk number 24: produceCD8ECDFimage
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 25: Density plots 1
###################################################
resDensityFSC <- qaProcess.DensityPlot(nData,dyes=c("FSC-A","SSC-A"),outdir=dest,alpha=0.2,pdf=TRUE)
#densityUrl<-writeQAReport(nData[[1]], list(resDensity), outdir=dest)
#browseURL(densityUrl)


###################################################
### code chunk number 26: genTblDens1
###################################################
imagePath<-resDensityFSC@summaryGraph@fileNames[2]
getDistance(resDensityFSC,c("FSC-A","SSC-A"))


###################################################
### code chunk number 27: produceDensityFSC
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 28: Density plots 2
###################################################
resDensityCD8 <- qaProcess.DensityPlot(nData,dyes=c("CD8","CD27"),outdir=dest,alpha=0.2,pdf=TRUE)


###################################################
### code chunk number 29: produceDensityCD27
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 30: 2DSummary_mean
###################################################
par<-c("FSC-A","SSC-A","CD4","CD8")
resMean <- qaProcess.2DStatsPlot(nData,dyes=par,outdir=dest,func=mean,
outBound=0.28,pdf=TRUE)
imagePath <- resMean@summaryGraph@fileNames[2]
#summaryUrl<-writeQAReport(nData[[1]], list(resMean), outdir=dest,pdf=TRUE)
#browseURL(summaryUrl)



###################################################
### code chunk number 31: 2Dsummaryplot_mean
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 32: 2DSummary_median
###################################################
par<-c("FSC-A","SSC-A","CD4","CD8")
resMedian <- qaProcess.2DStatsPlot(nData,dyes=par,outdir=dest,func=median,
outBound=0.28,pdf=TRUE)
imagePath <- resMedian@summaryGraph@fileNames[2]
#summaryUrl<-writeQAReport(nData[[1]], list(resMedian), outdir=dest,pdf=TRUE)
#browseURL(summaryUrl)


###################################################
### code chunk number 33: 2Dsummaryplot_median
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


###################################################
### code chunk number 34: KL Distance plots
###################################################
resKLdist <- qaProcess.KLDistPlot(nData,dyes=c("SSC-A","CD8"),outdir=dest,alpha=0.05,pdf=TRUE)
writeQAReport(nData[[1]], list(resKLdist), outdir=dest)
imagePath <- resKLdist@summaryGraph@fileNames[2]
#browseURL(klDistURL)


###################################################
### code chunk number 35: KLDistanceplot
###################################################
to <- paste(flowQ:::guid(), "jpg", sep=".")
f <- file.copy(imagePath, to)
cat('\\includegraphics[width=1.0\\textwidth]{', to, '}\n', sep="")


