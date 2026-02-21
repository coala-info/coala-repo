# Code example from 'PloGO2_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'PloGO2_vignette.Rnw'

###################################################
### code chunk number 1: library
###################################################
library(PloGO2)
library(xtable)


###################################################
### code chunk number 2: genFile
###################################################
v <- c("Q9HWC9","Q9HWD0","Q9I4N8","Q9HW18","Q9HWC9","Q9HWD0")
wego.file <- genWegoFile(v, fname = "F1.txt")


###################################################
### code chunk number 3: PloGO2_vignette.Rnw:95-96
###################################################
print(xtable(read.annot.file(wego.file), align = "rp{4cm}p{10cm}"))


###################################################
### code chunk number 4: PloGO2_vignette.Rnw:106-111
###################################################
path <- system.file("files", package = "PloGO2")
goRet <- file.path(path, "goRetOutput.txt")
print(xtable(read.annot.file(goRet)[1:10, ]))
bioMt <- file.path(path, "mart_export.txt")
print(xtable(read.annot.file(bioMt, format="long")[1:10, ]))


###################################################
### code chunk number 5: dataFile
###################################################
file.names <- file.path(path, c("00100.txt", "01111.txt", "10000.txt", 
	"11111.txt", "Control.txt"))
datafile <- file.path(path, "NSAFDesc.csv")


###################################################
### code chunk number 6: PloGO2_vignette.Rnw:127-128
###################################################
options(width = 60)


###################################################
### code chunk number 7: GoLev3
###################################################
GOIDlist <- GOTermList("BP", level = 2)


###################################################
### code chunk number 8: GoSlim
###################################################
GOSlimCC <- c( "GO:0000228", "GO:0000229", "GO:0005575", "GO:0005576", 
	"GO:0005578", "GO:0005615", "GO:0005618", "GO:0005622", "GO:0005623", 
	"GO:0005634", "GO:0005635", "GO:0005654", "GO:0005694", "GO:0005730", 
	"GO:0005737", "GO:0005739", "GO:0005764", "GO:0005768", "GO:0005773", 
	"GO:0005777", "GO:0005783", "GO:0005794", "GO:0005811", "GO:0005815", 
	"GO:0005829", "GO:0005840", "GO:0005856", "GO:0005886", "GO:0005929", 
	"GO:0009536", "GO:0009579", "GO:0016023", "GO:0030312", "GO:0043226", 
	"GO:0043234" )


###################################################
### code chunk number 9: GoIDlist
###################################################
# Extract a few categories of interest
termList <- c("response to stimulus", "transport", "protein folding",
	"protein metabolic process", "carbohydrate metabolic process",
	"oxidation reduction", "photosynthesis", "lipid metabolic process",
	"cell redox homeostasis", 
	"cellular amino acid and derivative metabolic process", 
	"nucleobase, nucleoside and nucleotide metabolic process", 
	"vitamin metabolic process", "generation of precursor metabolites and energy", 
	"metabolic process", "signaling")
GOIDmap <- getGoID(termList)
GOIDlist <- names(GOIDmap)


###################################################
### code chunk number 10: processFile
###################################################
go.file <- processGoFile(wego.file, GOIDlist)


###################################################
### code chunk number 11: processFiles
###################################################
res.list <- processAnnotation(file.names, GOIDlist, printFiles = FALSE)


###################################################
### code chunk number 12: printAnnot
###################################################
annot.res <- annotationPlot(res.list)


###################################################
### code chunk number 13: PloGO2_vignette.Rnw:189-191
###################################################
print(xtable(annot.res$counts, align = "rp{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}"))
print(xtable(annot.res$percentages, align = "rp{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}p{1.2cm}"))


###################################################
### code chunk number 14: PloGO2_vignette.Rnw:208-210
###################################################
res <- compareAnnot(res.list, "Control")
print(xtable(res))


###################################################
### code chunk number 15: withAbundance
###################################################
res.list <- processAnnotation(file.names, GOIDlist, data.file.name = datafile, 
	printFiles = FALSE, datafile.ignore.cols = 2)


###################################################
### code chunk number 16: writeAnnotation
###################################################
annot.file <- writeAnnotation(res.list, datafile = datafile, format = "matrix")


###################################################
### code chunk number 17: annotationPlot
###################################################
tp <- abundancePlot(res.list)


###################################################
### code chunk number 18: PloGO2_vignette.Rnw:273-276
###################################################
path <- system.file("files", package = "PloGO2")
filedb <- file.path(path, "pathwayDB.csv")
print(xtable(read.csv(filedb)[1:5,]))


###################################################
### code chunk number 19: genAnnotFile
###################################################
path <- system.file("files", package = "PloGO2")
res.annot <- genAnnotationFiles(fExcelName = file.path(path, 
					"ResultsWGCNA_Input4PloGO2.xlsx"),  
				colName="Uniprot", 
				DB.name = file.path(path, "pathwayDB.csv"),
				folder="PWFiles")					


###################################################
### code chunk number 20: PloGO2_vignette.Rnw:306-307
###################################################
print(xtable(read.annot.file(file.path(path, "PWFiles", "red.txt"))[1:5,]))


###################################################
### code chunk number 21: processPathFile
###################################################
fname <- file.path(path,"PWFiles/AllData.txt")
AnnotIDlist <- c("osa01100","osa01110","osa01230","osa00300","osa00860")	
res.pathfile <- processPathFile(fname, AnnotIDlist)


###################################################
### code chunk number 22: processPathFile
###################################################
datafile <- paste(path, "Abundance_data.csv", sep="/")
res.pathfile.abun <- processPathFile(fname, AnnotIDlist, datafile=datafile)


###################################################
### code chunk number 23: processAnnotation
###################################################
file.list <- file.path(path,"PWFiles", c("AllData.txt", "red.txt", "yellow.txt") )
AnnotIDlist <- c("osa01100","osa01110","osa01230","osa00300","osa00860")	
res.list <- processAnnotation(file.list, AnnotIDlist, data.file.name=datafile)	


###################################################
### code chunk number 24: abundancePlot
###################################################
Group <- names(read.csv(datafile))[-1]
abundance <- abundancePlot(res.list, Group=Group)


###################################################
### code chunk number 25: PloGO2_vignette.Rnw:354-357
###################################################
reference="AllData"
comp <- compareAnnot(res.list, reference)
print(xtable(comp, digits=4))


###################################################
### code chunk number 26: plopathway
###################################################
path <- system.file("files", package = "PloGO2")
res <- PloPathway( zipFile=paste(path, "PWFiles.zip", sep="/"), 
	reference="AllData", 
	data.file.name = paste(path, "Abundance_data.csv", sep="/"),
	datafile.ignore.cols = 1)


###################################################
### code chunk number 27: printSummary
###################################################
printSummary(res)


###################################################
### code chunk number 28: abundanceBarplot
###################################################
abudanceBar <- plotAbundanceBar(res$aggregatedAbundance, res$Counts)


