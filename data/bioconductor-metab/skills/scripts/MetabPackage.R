# Code example from 'MetabPackage' vignette. See references/ for full tutorial.

### R code from vignette source 'MetabPackage.Rnw'

###################################################
### code chunk number 1: LoadAMDISReport
###################################################
library(Metab)
data(exampleAMDISReport)
print(head(exampleAMDISReport, 25))


###################################################
### code chunk number 2: LoadIonLibrary
###################################################
data(exampleMSLfile)
print(head(exampleMSLfile, 29))
testLib <- buildLib(exampleMSLfile, save = FALSE, verbose = FALSE)
print(testLib)


###################################################
### code chunk number 3: RunMetReport
###################################################
###### Load exampleAMDISReport ######
data(exampleAMDISReport)
###### Load exampleIonLib ###########
data(exampleIonLib)
###### Analyse a single file ########
testfile <- unzip(system.file("extdata/130513_REF_SOL2_2_50_50_1.CDF.zip", package = "Metab"))
test <- MetReport(inputData = testfile,
                  singleFile = TRUE, AmdisReport = exampleAMDISReport,
                  ionLib = exampleIonLib, abundance = "recalculate",
                  TimeWindow = 0.5, save = FALSE)
###### Show results #################
print(test)


###################################################
### code chunk number 4: RunMetReportArea
###################################################
###### Load exampleAMDISReport ######
data(exampleAMDISReport)
###### Analyse a single file ########
test <- MetReport(inputData = testfile,
                  singleFile = TRUE, AmdisReport = exampleAMDISReport,
                  abundance = "Area", TimeWindow = 0.5, save = FALSE)
###### Show results #################
print(test)


###################################################
### code chunk number 5: ExampleForMetReport (eval = FALSE)
###################################################
## MetReport(
## 	dataFolder = "/Users/ThePathToTheMainFolder/",
## 	AmdisReport = "/Users/MyAMDISreport.TXT",
## 	ionLib = "/Users/MyIonLibrary.csv",
## 	save = TRUE,
## 	output = "metabData",
## 	TimeWindow = 2.5,
## 	Remove = c("Ethanol", "Pyridine"))


###################################################
### code chunk number 6: LoadReportMetReport
###################################################
data(exampleMetReport)
print(exampleMetReport)


###################################################
### code chunk number 7: ExampleMetReportNames
###################################################
### Load the example of AMDIS report #####
data(exampleAMDISReport)
### Extract the Area of compounds in samples 
# 130513_REF_SOL2_2_100_1 and 130513_REF_SOL2_2_100_2 ##
test <- MetReportNames(
	c("130513_REF_SOL2_2_100_1", "130513_REF_SOL2_2_100_2"), 
	exampleAMDISReport, 
	save = FALSE, 
	TimeWindow = 0.5, 
	base.peak = FALSE)
print(test)


###################################################
### code chunk number 8: RemovingFalsePositives
###################################################
### Load the inputData ###
data(exampleMetReport)
### Normalize ####
normalizedData <- removeFalsePositives(exampleMetReport, truePercentage = 40, save = FALSE)
##################
# The abundances of compound Zylene3 will be replaced by NA in samples from experimental 
#condition 50ul, as it is present in less than 40 per cent of the samples from this 
#experimental condition. 
### Show results ####
print(normalizedData)


###################################################
### code chunk number 9: ExampleIST
###################################################
### Load the inputData ###
data(exampleMetReport)
### Normalize ####
normalizedData <- normalizeByInternalStandard(
	exampleMetReport, 
	internalStandard = "Acetone", 
	save = FALSE)
### Show results ####
print(normalizedData)


###################################################
### code chunk number 10: LoadBiomasses
###################################################
data(exampleBiomass)
print(exampleBiomass)


###################################################
### code chunk number 11: ExampleBiomassNorm
###################################################
### Load the inputData ###
data(exampleMetReport)
### Load the list of biomasses ### 
data(exampleBiomass)
### Normalize ####
normalizedData <- normalizeByBiomass(
	exampleMetReport, 
	biomass = exampleBiomass, 
	save = FALSE)
### Show results ###
print(normalizedData)


###################################################
### code chunk number 12: ExampleForHtest
###################################################
### Load the inputData ###
	data(exampleMetReport)
### Perform t-test ####
	tTestResults <- htest(
		exampleMetReport, 
		signif.level = 0.05, 
		StatTest = "T", 
		save = FALSE
	)
### Show results ###
	print(tTestResults)
### Perform ANOVA ####
	AnovaResults <- htest(
		exampleMetReport, 
		signif.level = 0.05, 
		StatTest = "Anova", 
		save = FALSE
	)
### Show results ###
	print(AnovaResults)


###################################################
### code chunk number 13: sessioninfo
###################################################
print(sessionInfo(), locale = FALSE)


