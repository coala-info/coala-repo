# Code example from 'cn.farms' vignette. See references/ for full tutorial.

### R code from vignette source 'cn.farms.Rnw'

###################################################
### code chunk number 1: cn.farms.Rnw:38-52
###################################################
options(width = 80)
set.seed(0)
require(cn.farms)
farmsVers <- packageDescription("cn.farms")$Version

##  toy-data which is used for testing the vignette
load(system.file("exampleData/normData.RData", package = "cn.farms"))
load(system.file("exampleData/slData.RData", package = "cn.farms"))
notes(experimentData(normData))$annotDir <- 
		system.file("exampleData/annotation/pd.genomewidesnp.6/1.1.0",
				package = "cn.farms")
cores <- 1
runtype <- "ff"
npData <- slData


###################################################
### code chunk number 2: cn.farms.Rnw:221-235
###################################################
summaryMethod <- "Variational"
summaryParam <- list()
summaryParam$cyc <- c(10)
callParam <- list(cores=cores, runtype=runtype)

slData <- slSummarization(normData, 
		summaryMethod=summaryMethod, 
		summaryParam=summaryParam,
		callParam=callParam,
		summaryWindow="std")

show(slData)
assayData(slData)$intensity[1:6, 1:5] ## intensity values
assayData(slData)$L_z[1:6, 1:5] ## relative values


###################################################
### code chunk number 3: cn.farms.Rnw:251-253
###################################################
combData <- combineData(slData, npData, runtype=runtype)
show(combData) 


###################################################
### code chunk number 4: cn.farms.Rnw:274-291
###################################################
windowMethod <- "std"
windowParam <- list()
windowParam$windowSize <- 5
windowParam$overlap <- TRUE
summaryMethod <- "Variational"
summaryParam <- list()
summaryParam$cyc <- c(20)
callParam <- list(cores=cores, runtype=runtype)
mlData <- mlSummarization(slData, 
		windowMethod =windowMethod, 
		windowParam  =windowParam, 
		summaryMethod=summaryMethod, 
		summaryParam =summaryParam, 
		callParam    =callParam)
names(assayData(mlData))
assayData(mlData)$intensity[1:6, 1:5]
assayData(mlData)$L_z[1:6, 1:5]


###################################################
### code chunk number 5: cn.farms.Rnw:298-306
###################################################
colnames(assayData(mlData)$L_z) <- sampleNames(mlData)
segments <- dnaCopySf(
		x        =assayData(mlData)$L_z[, 1:10], 
		chrom    =fData(mlData)$chrom, 
		maploc   =fData(mlData)$start, 
		cores    =cores, 
		smoothing=FALSE)
head(fData(segments))


###################################################
### code chunk number 6: cn.farms.Rnw:790-791
###################################################
sessionInfo()


