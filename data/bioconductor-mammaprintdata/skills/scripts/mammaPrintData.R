# Code example from 'mammaPrintData' vignette. See references/ for full tutorial.

### R code from vignette source 'mammaPrintData.Rnw'

###################################################
### code chunk number 1: start
###################################################
### setCacheDir("cacheSweave")
### if (! file.exists("./cacheSweave") ) {
### 	dir.create("./cacheSweave")
### }
### setCacheDir("cacheSweave")
options(width=75)
options(continue=" ")
rm(list=ls())
myDate <- format(Sys.Date(), "%b %d, %Y")


###################################################
### code chunk number 2: getPackagesBioc
###################################################
###Get the list of available packages
installedPckgs <- installed.packages()[,"Package"]
###Define the list of desired libraries
pckgListBIOC <- c("Biobase", "limma", "readxl")
###Install BiocManager if needed
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager", repo="https://cloud.r-project.org/")
###Load the packages, install them from Bioconductor if needed
for (pckg in pckgListBIOC) {
	if (! pckg %in% installedPckgs) BiocManager::install(pckg)
	require(pckg, character.only=TRUE)
}


###################################################
### code chunk number 3: get70genes
###################################################
###Define the url for Supplementary data on the Nature Website
url <- "http://www.nature.com/nature/journal/v415/n6871/extref/415530a-s9.xls"

myFile <- tempfile()

###Dowload the Excel file from Nature
download.file(url, destfile=myFile,
	      quiet = FALSE, mode = "w", cacheOK = TRUE)


###################################################
### code chunk number 4: read70genes
###################################################
###Load the library to process Excell files
require(readxl)
###Read the Excel file with the 70-genes signature information for van't Veer dataset
gns231 <- read_xls(myFile)
###Remove special characters in the colums header
###These are due to white spaces present in the Excel file
colnames(gns231) <- gsub("\\s#", "", colnames(gns231))
colnames(gns231) <- gsub("\\s", ".", colnames(gns231))
###Remove GO annotation
gns231 <- gns231[, -grep("sp_xref_keyword_list", colnames(gns231))]
###Check the structure of the data.frame
str(gns231)


###################################################
### code chunk number 5: read70genes2
###################################################
###Reorder the genes in decreasing order by absolute correlation
gns231 <- gns231[order(abs(gns231$correlation), decreasing=TRUE),]
###Select the feature identifiers corresponding to the top 70 genes
gns70 <- gns231[1:70,]
###Create a list of features and gene symbols for later use
progSig <- list(gns231acc = unique(gns231$accession), gns231name = unique(gns231$gene.name),
		gns231any = unique(c(gns231$accession, gns231$gene.name)),
		gns70acc = unique(gns70$accession), gns70name = unique(gns70$gene.name),
		gns70any = unique(c(gns70$accession, gns70$gene.name)) )
###Remove empty elements
progSig <- lapply(progSig, function(x) x[x!=""])
###Create a data.frame of correlations with combined accession
###and gene symbols as identifiers
gns231Cors <- data.frame(stringsAsFactors=FALSE,
			 ID=c(gns231$gene.name[ gns231$gene.name %in% progSig$gns231any ],
			 gns231$accession),
			 gns231Cors=c(gns231$correlation[ gns231$gene.name %in% progSig$gns231any ],
			 gns231$correlation) )
####Keep unique only
progSig$gns231Cors <- gns231Cors[!duplicated(gns231Cors$ID), ]
progSig$gns231Cors <- gns231Cors[gns231Cors$ID != "", ]
###Check the structure of the list just created
str(progSig)


###################################################
### code chunk number 6: getETAB115 (eval = FALSE)
###################################################
## ###Chunk nor executed: files are already included in the package
## ###This chunk is just to show the source of the data
## ###Load the ArrayExpress library
## require(ArrayExpress)
## ###Create a working directory
## dir.create("../extdata/ETABM115", showWarnings = FALSE)
## ###Obtain the data package E-TABM-115 from ArrayExpress
## etabm115 <- getAE("E-TABM-115", type = "full", path="../extdata/ETABM115", extract=FALSE)
## ###Save
## save(etabm115, file="../extdata/ETABM115/etabm115.rda")


###################################################
### code chunk number 7: readETAB115pheno
###################################################
###Load the Biobase library
require(Biobase)
###List the files obtained from ArrayExpress
etabm155filesLoc <- system.file("extdata/ETABM115", package = "mammaPrintData")
head(dir(etabm155filesLoc))
###Read the phenotypic information from "E-TABM-115.sdrf.txt"
targets <- read.table(dir(etabm155filesLoc, full.names=TRUE, pattern="E-TABM-115.sdrf.txt"),
		      comment.char="", sep="\t", header=TRUE, stringsAsFactors=FALSE)
###Check and process the phenotypic information: keep non-redundant information
targets <- targets[, apply(targets, 2, function(x) length(unique(x)) != 1 )]
###Reorder by file name
targets <- targets[order(targets$Array.Data.File, decreasing=TRUE),]
###Remove points in colnames
colnames(targets) <- gsub("\\.$","",gsub("\\.\\.",".",colnames(targets)))
###Show the available phenotypic iformation
str(targets)


###################################################
### code chunk number 8: checkETAB115sdrf
###################################################
###Check targets data.frame dimentions
dim(targets)
###Count the unique file names
length(unique(targets$Array.Data.File))
###Count the number of rows associated with each channel
table(CHANNEL=targets$Label)
###Count the number of rows for the reference RNA (named "MRP") in each channel
table(CHANNEL=targets$Label, REFERENCE=targets$Sample.Name == "MRP")
###Count the number of distinct RNA analyzed (excluding the refernce RNA)
sum(REFERENCE=targets$Sample.Name!="MRP")
###Count the number of metastatic events
table(METASTASES=targets$Characteristics.EventDistantMetastases)
###Count the number of rown for which metastatic events is missing
table(MISSING=is.na(targets$Characteristics.EventDistantMetastases))
###Check if missing clinical information is exactly associated with
###hybridizations where the "MRP" reference RNA was used in the Cy5 channel
table(MISSING=is.na(targets$Characteristics.EventDistantMetastases),
      REFERENCE=targets$Sample.Name!="MRP")


###################################################
### code chunk number 9: ETAB115rglist
###################################################
###List files for E-TABM-115 experiment
etabm155filesLoc <- system.file("extdata/ETABM115", package = "mammaPrintData")
etabm155files <- list.files(etabm155filesLoc,  pattern="^US")
###Check whether all available files correspond to the targets$Array.Data.File
all(paste(targets$Array.Data.File, ".gz", sep="") %in% etabm155files)
###Check whether they are ordered in the same way
all(paste(targets$Array.Data.File, ".gz", sep="") == etabm155files)
###Load the required library
require(limma)
###Define the columns which will be read from the raw files selection
colsList <- list(Rf="Feature Extraction Software:rMedianSignal",
		 Rb="Feature Extraction Software:rBGMedianSignal",
		 Gf="Feature Extraction Software:gMedianSignal",
		 Gb="Feature Extraction Software:gBGMedianSignal",
		 logRatio="Feature Extraction Software:LogRatio",
		 logRatioError="Feature Extraction Software:LogRatioError")
###Subset the targets data.frame for the hybridization in which the Reference RNA was labeled with Cy3
targetsCy3info <- targets[ targets$Source.Name == "MRP" & targets$Label == "Cy3", ]
dim(targetsCy3info)
###Subset the targets data.frame for the hybridization in which the Reference RNA was labeled with Cy5
targetsCy5info <- targets[ targets$Source.Name != "MRP" & targets$Label == "Cy5", ]
dim(targetsCy5info)
###The two sets of hybridizations above should be mutually exclusive
all(targetsCy3info$Array.Data.File != targetsCy5info$Array.Data.File)
###Create an "RGList" using specific columns for the first set of swapped hybridizations:
RGcy3 <- read.maimages(paste(targetsCy3info$Array.Data.File,  ".gz", sep=""),
		       source="generic",
		       columns=colsList, annotation="Reporter identifier",
		       path=etabm155filesLoc, verbose=FALSE)
###Add targets information
RGcy3$targets <- targetsCy3info
###Format Reporter identifiers
RGcy3$genes$ID <- gsub(".+A-MEXP-318\\.", "", RGcy3$genes[, "Reporter identifier"])
###Check dimensions
dim(RGcy3)
###Create an "RGList" using specific columns for the second set of swapped hybridizations:
RGcy5 <- read.maimages(paste(targetsCy3info$Array.Data.File,  ".gz", sep=""),
		       source="generic",
		       columns=colsList, annotation="Reporter identifier",
		       path=etabm155filesLoc, verbose=FALSE)
###Add targets information
RGcy5$targets <- targetsCy5info
###Format Reporter identifiers
RGcy5$genes$ID <- gsub(".+A-MEXP-318\\.", "", RGcy5$genes[, "Reporter identifier"])
###Check dimensions
dim(RGcy5)


###################################################
### code chunk number 10: checkMode1
###################################################
###Check mode of read data for first set of hybridizations
sapply(RGcy3, mode)
###Since RGc3$logRatio is character convert to numeric
RGcy3$logRatio <- apply(RGcy3$logRatio, 2, as.numeric)
###Check mode of read data for second set of hybridizations
sapply(RGcy5, mode)
###Since RGc3$logRatio is character convert to numeric
RGcy5$logRatio <- apply(RGcy5$logRatio, 2, as.numeric)


###################################################
### code chunk number 11: genes115
###################################################
###Read genes information for MammaPrint array from the A-MEXP-318.adf.txt
genes <- read.table(dir(etabm155filesLoc, full.names=TRUE, pattern="A-MEXP-318.adf.txt"),
		    skip=21, sep="\t", header=TRUE, stringsAsFactors=FALSE)
###Remove special characters like points in the colums header
colnames(genes) <- gsub("\\.$","",gsub("\\.\\.",".",colnames(genes)))
###Use the annotation information previously processed
str(progSig)
###Count the features mapped to the 231-gene prognostic signature by accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns231acc)
###Count the features mapped to the 231-gene prognostic signature by gene symbol
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns231name)
###Count the features mapped to the 231-gene prognostic signature by gene symbol or accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns231any)
###Add mapping information for 229 features using both gene symbols and accession numbers
genes$genes231 <- genes$Comment.AEReporterName %in% progSig$gns231any
###Count the features mapped to the 70-gene prognostic signature by accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns70acc)
###Count the features mapped to the 70-gene prognostic signature by gene symbol
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns70name)
###Count the features mapped to the 70-gene prognostic signature by gene symbol or accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns70any)
###Add mapping information for 69 features using both gene symbols and accession numbers
genes$genes70 <- genes$Comment.AEReporterName %in% progSig$gns70any
###The resulting gene annotation file
str(genes)
###Add original correlation from the van't Veer study
gns231Cors <- progSig$gns231Cors
gns231Cors <- gns231Cors[gns231Cors$ID %in% genes$Comment.AEReporterName,]
###Merge and remove duplicates
genes <- merge(genes, gns231Cors, all.x=TRUE, all.y=FALSE,
	       by.x="Comment.AEReporterName", by.y="ID")
genes <- genes[!duplicated(genes$Reporter.Name),]
###Check genes
str(genes)


###################################################
### code chunk number 12: annETABM115
###################################################
###Compare genes between platform and RGList instances: first set of hybridizations
if  (nrow(genes)==nrow(RGcy3)) {
	##Compare the identifiers' order
	if ( !all(genes$Reporter.Name == RGcy3$genes$ID) ) {
		##Reorder if needed
		RGcy3 <- RGcy3[order(RGcy3$genes$ID),]
		genes <- genes[order(genes$Reporter.Name),]
		##Check for order AGAIN
		if ( all(genes$Reporter.Name == RGcy3$genes$ID) ) {
			##Substitute genes or stop
			RGcy3$genes <- genes
		} else {
			stop("Wrong gene order, check objects")
		}
	} else {
		print("Updating gene annotation")
		RGcy3$genes <- genes
	}
} else {
	stop("Wrong number of features, check objects")
}
###Rename the object
glasRGcy3 <- RGcy3


###################################################
### code chunk number 13: annETABM115b
###################################################
###Compare genes between paltform and RGList instances: second set of hybridizations
if (nrow(genes)==nrow(RGcy5)) {
	##Compare the identifiers' order
	if ( !all(genes$Reporter.Name == RGcy5$genes$ID) ) {
		##Reorder if needed
		RGcy5 <- RGcy5[order(RGcy5$genes$ID),]
		genes <- genes[order(genes$Reporter.Name),]
		##Check for order AGAIN
		if ( all(genes$Reporter.Name == RGcy5$genes$ID) ) {
			##Substitute genes or stop
			RGcy5$genes <- genes
		} else {
			stop("Wrong gene order, check objects")
		}
	} else {
		print("Updating gene annotation")
		RGcy5$genes <- genes
	}
} else {
	stop("Wrong number of features, check objects")
}
###Rename the object
glasRGcy5 <- RGcy5


###################################################
### code chunk number 14: downloadETAB77 (eval = FALSE)
###################################################
## ###Chunk not executed: files are already included in the package
## ###This chunk is just to show the source of the data
## dir.create("../extdata/ETABM77", showWarnings = FALSE)
## ###################################################
## ###Obtain the data package E-TABM-115 from ArrayExpress
## etabm77 <- getAE("E-TABM-77", type = "full", path="../extdata/ETABM77", extract=FALSE)
## ###################################################
## ###Save
## save(etabm77,file="../extdata/ETABM77/etabm77.rda")


###################################################
### code chunk number 15: readETAB77pheno
###################################################
###List the files obtained from ArrayExpress
etabm77filesLoc <- system.file("extdata/ETABM77", package = "mammaPrintData")
head(dir(etabm77filesLoc))
###Read the phenotypic information from "E-TABM-77.sdrf.txt"
targets <- read.table(dir(etabm77filesLoc, full.names=TRUE, pattern="E-TABM-77.sdrf.txt"),
		      comment.char="", sep="\t", header=TRUE, stringsAsFactors=FALSE)
###Check and process the phenotypic information: keep non-redundant information
targets <- targets[, apply(targets, 2, function(x) length(unique(x)) != 1 )]
###Reorder by file name
targets <- targets[order(targets$Array.Data.File, decreasing=TRUE),]
###Remove points in colnames
colnames(targets) <- gsub("\\.$","",gsub("\\.\\.",".",colnames(targets)))
###Show the available phenotypic iformation
str(targets)


###################################################
### code chunk number 16: checkETAB77sdrf
###################################################
###Check targets data.frame dimentions
dim(targets)
###Count the unique file names
length(unique(targets$Array.Data.File))
###Count the number of rows associated with each channel
table(CHANNEL=targets$Label)
###Count the number of rows for the reference RNA (named "MRP") in each channel
table(CHANNEL=targets$Label, REFERENCE=targets$Sample.Name == "MRP")
###Count the number of distinct RNA analyzed (excluding the refernce RNA)
sum(REFERENCE=targets$Sample.Name!="MRP")
###Count the MammaPrint predictions
table(MAMMAPRINT=targets$Factor.Value.MammaPrint.prediction)


###################################################
### code chunk number 17: ETAB77rglist
###################################################
###List files for E-TABM-77 experiment
etabm77filesLoc <- system.file("extdata/ETABM77", package = "mammaPrintData")
etabm77files <- list.files(etabm77filesLoc,  pattern="^US")
###Check whether all available files correspond to the targets$Array.Data.File
all(paste(targets$Array.Data.File, ".gz", sep="") %in% etabm77files)
###Check whether they are ordered in the same way
all(paste(targets$Array.Data.File, ".gz", sep="") == etabm77files)
####Subset targets table extracting the rows for CANCER and the separate by channel
caList <- !targets$Sample.Name=="MRP"
targetsCa <- targets[caList,]
###Cy5 channel
targetsCa.ch1 <- targetsCa[targetsCa$Label=="Cy5",]
colnames(targetsCa.ch1) <- paste(colnames(targetsCa.ch1),"Cy5",sep=".")
###Cy3 channel
targetsCa.ch2 <- targetsCa[targetsCa$Label=="Cy3",]
colnames(targetsCa.ch2) <- paste(colnames(targetsCa.ch2),"Cy3", sep=".")
####Subset targets table extracting the rows for REFERENCE and the separate by channel
refList <- targets$Sample.Name=="MRP"
targetsRef <- targets[refList,]
###Cy5 channel
targetsRef.ch1 <- targetsRef[targetsRef$Label=="Cy5",]
colnames(targetsRef.ch1) <- paste(colnames(targetsRef.ch1),"Cy5",sep=".")
###Cy3 channel
targetsRef.ch2 <- targetsRef[targetsRef$Label=="Cy3",]
colnames(targetsRef.ch2) <- paste(colnames(targetsRef.ch2),"Cy3", sep=".")


###################################################
### code chunk number 18: ETAB77rglist2
###################################################
###Now combine channel information to create the new targets object
###Here is for the FIRST set of swapped hybridization (keep only useful columns)
if ( all(targetsCa.ch1$Array.Data.File.Cy5==targetsRef.ch2$Array.Data.File.Cy3) ) {
	colsSel <- apply(targetsCa.ch1==targetsRef.ch2,2,function(x) sum(x) != length(x) )
	targetsSwap1 <- cbind(targetsCa.ch1,targetsRef.ch2[,colsSel],stringsAsFactors=FALSE)
	targetsSwap1 <- targetsSwap1[,apply(targetsSwap1,2,function(x) length(unique(x)) != 1 )]
	##add Cy5 and Cy3 columns
	targetsSwap1$Cy5 <- targetsSwap1$Sample.Name
	targetsSwap1$Cy3 <- "Ref"
	targetsSwap1 <- targetsSwap1[,order(colnames(targetsSwap1))]
	##remove dye extension to Scan name
	colnames(targetsSwap1) <- gsub("\\.Cy5$","",colnames(targetsSwap1))
	##reorder by sample name in Cy5
	targetsSwap1 <- 	targetsSwap1[order(targetsSwap1$Cy5),]
	print("Assembling the targets object for the first set of swapped hybridizations")
} else {
	stop("Check objects")
}


###################################################
### code chunk number 19: ETAB77rglist3
###################################################
###create new target objects for SECOND set of swapped hybs and keep useful columns
if ( all(targetsCa.ch2$Array.Data.File.Cy3==targetsRef.ch1$Array.Data.File.Cy5) ) {
	colsSel <- apply(targetsCa.ch2==targetsRef.ch1,2,function(x) sum(x) != length(x) )
	targetsSwap2 <- cbind(targetsCa.ch2,targetsRef.ch1[,colsSel],stringsAsFactors=FALSE)
	targetsSwap2 <- targetsSwap2[,apply(targetsSwap2,2,function(x) length(unique(x)) != 1 )]
	##add Cy5 and Cy3 columns
	targetsSwap2$Cy5 <- "Ref"
	targetsSwap2$Cy3 <- targetsSwap2$Sample.Name
	targetsSwap2 <- targetsSwap2[,order(colnames(targetsSwap2))]
	##remove dye extension to Scan name
	colnames(targetsSwap2) <- gsub("\\.Cy3$","",colnames(targetsSwap2))
	##reorder by sample name in Cy3
	targetsSwap2 <- 	targetsSwap2[order(targetsSwap2$Cy3),]
	print("Assembling the targets object for the second set of swapped hybridizations")
} else {
	stop("Check objects")
}


###################################################
### code chunk number 20: ETAB77rglist4
###################################################
##Define the columns which will be read from the raw files selection
colsList <- list(Rf="Feature Extraction Software:rMedianSignal",
		 Rb="Feature Extraction Software:rBGMedianSignal",
		 Gf="Feature Extraction Software:gMedianSignal",
		 Gb="Feature Extraction Software:gBGMedianSignal",
		 logRatio="Feature Extraction Software:LogRatio",
		 logRatioError="Feature Extraction Software:LogRatioError")
###Swap set 1 has Reference RNA in Cy3 channel
table(targetsSwap1$Cy3)
###This creates an instance of class "RGList", selecting specific columns from the raw data:
RGcy3 <- read.maimages(paste(targetsSwap1$Array.Data.File, ".gz",  sep=""),
		       source="generic",
		       columns=colsList, annotation="Reporter identifier",
		       path=etabm77filesLoc, verbose=FALSE)
###Add targets information
RGcy3$targets <- targetsSwap1
###Add sample names as column names with prefix
colnames(RGcy3) <- paste("BC",targetsSwap1$Sample.Name,sep=".")
###Format Reporter identifiers
RGcy3$genes$ID <- gsub(".+A-MEXP-318\\.", "", RGcy3$genes[, "Reporter identifier"])
###Check dimensions
dim(RGcy3)


###################################################
### code chunk number 21: ETAB77rglist5
###################################################
###This creates an instance of class "RGList", selecting specific columns from the raw data:
RGcy5 <- read.maimages(paste(targetsSwap1$Array.Data.File, ".gz",  sep=""),
		       source="generic",
		       columns=colsList, annotation="Reporter identifier",
		       path=etabm77filesLoc, verbose=FALSE)
###Swap set 2 has Reference RNA in Cy5 channel
table(targetsSwap2$Cy5)
###Add targets information
RGcy5$targets <- targetsSwap2
###Format Reporter identifiers
RGcy5$genes$ID <- gsub(".+A-MEXP-318\\.", "", RGcy5$genes[, "Reporter identifier"])
###Add sample names as column names with prefix
colnames(RGcy5) <- paste("BC",targetsSwap2$Sample.Name,sep=".")
###Check dimensions
dim(RGcy5)


###################################################
### code chunk number 22: checkMode2
###################################################
###Check mode of read data for first set of hybridizations
sapply(RGcy3, mode)
###Since RGc3$logRatio is character convert to numeric
RGcy3$logRatio <- apply(RGcy3$logRatio, 2, as.numeric)
###Check mode of read data for second set of hybridizations
sapply(RGcy5, mode)
###Since RGc3$logRatio is character convert to numeric
RGcy5$logRatio <- apply(RGcy5$logRatio, 2, as.numeric)


###################################################
### code chunk number 23: genesETABM77
###################################################
###Read genes information for MammaPrint array from the A-MEXP-318.adf.txt
genes <- read.table(dir(etabm77filesLoc, full.names=TRUE, pattern="A-MEXP-318.adf.txt"),
		    comment.char="", skip=21, sep="\t", header=TRUE, stringsAsFactors=FALSE)
###Remove special characters like points in the colums header
colnames(genes) <- gsub("\\.$","",gsub("\\.\\.",".",colnames(genes)))
###Use the annotation information previously processed
str(progSig)
###Count the features mapped to the 231-gene prognostic signature by accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns231acc)
###Count the features mapped to the 231-gene prognostic signature by gene symbol
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns231name)
###Count the features mapped to the 231-gene prognostic signature by gene symbol or accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns231any)
###Add mapping information for 229 features using both gene symbols and accession numbers
genes$genes231 <- genes$Comment.AEReporterName %in% progSig$gns231any
###Count the features mapped to the 70-gene prognostic signature by accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns70acc)
###Count the features mapped to the 70-gene prognostic signature by gene symbol
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns70name)
###Count the features mapped to the 70-gene prognostic signature by gene symbol or accession number
apply(genes, 2, function(x, y) { sum(unique(x) %in% y) }, y = progSig$gns70any)
###Add mapping information for 229 features using both gene symbols and accession numbers
genes$genes70 <- genes$Comment.AEReporterName %in% progSig$gns70any
###The resulting gene annotation file
str(genes)
###Add original correlation from the van't Veer study
gns231Cors <- progSig$gns231Cors
gns231Cors <- gns231Cors[gns231Cors$ID %in% genes$Comment.AEReporterName,]
###Merge and remove duplicates
genes <- merge(genes, gns231Cors, all.x=TRUE, all.y=FALSE,
	       by.x="Comment.AEReporterName", by.y="ID")
genes <- genes[!duplicated(genes$Reporter.Name),]
###Check genes
str(genes)


###################################################
### code chunk number 24: annETABM77
###################################################
###Compare genes between paltform and RGList instances: first set of hybridizations
if (nrow(genes)==nrow(RGcy3)) {
	##Compare the identifiers' order
	if ( !all(genes$Reporter.Name == RGcy3$genes$ID) ) {
		##Reorder if needed
		RGcy3 <- RGcy3[order(RGcy3$genes$ID),]
		genes <- genes[order(genes$Reporter.Name),]
		##check for order AGAIN
		if ( all(genes$Reporter.Name == RGcy3$genes$ID) ) {
			##Substitute genes or stop
			RGcy3$genes <- genes
		} else {
			stop("Wrong gene order, check objects")
		}
	} else {
		print("Updating gene annotation")
		RGcy3$genes <- genes
	}
} else {
	stop("Wrong number of features, check objects")
}
###Rename
buyseRGcy3 <- RGcy3


###################################################
### code chunk number 25: annETABM77b
###################################################
###Compare genes between paltform and RGList instances: second set of hybridizations
if (nrow(genes)==nrow(RGcy5)) {
	##Compare the identifiers' order
	if ( !all(genes$Reporter.Name == RGcy5$genes$ID) ) {
		##Reorder if needed
		RGcy5 <- RGcy5[order(RGcy5$genes$ID),]
		genes <- genes[order(genes$Reporter.Name),]
		##check for order AGAIN
		if ( all(genes$Reporter.Name == RGcy5$genes$ID) ) {
			##Substitute genes or stop
			RGcy5$genes <- genes
		} else {
			stop("Wrong gene order, check objects")
		}
	} else {
		print("Updating gene annotation")
		RGcy5$genes <- genes
	}
} else {
	stop("Wrong number of features, check objects")
}
###Rename
buyseRGcy5 <- RGcy5


###################################################
### code chunk number 26: phenoGlasOriginalCohorts
###################################################
###Retrieve the phenotypic information from one of the RGList intances
phenoGlasCy3 <- glasRGcy3$targets
phenoGlasCy5 <- glasRGcy5$targets
###Identification of the 78 samples from van't Veer and the 84 from VanDeVijver
table(gsub(".+_", "", phenoGlasCy3$Scan.Name) == gsub(".+_", "", phenoGlasCy5$Scan.Name))
##################################################
###There are 78 hybridizations with 1-digit suffixes, and 84 of them with 3-digit suffixes
table(nchar(gsub(".+_", "", phenoGlasCy5$Scan.Name)))
table(nchar(gsub(".+_", "", phenoGlasCy3$Scan.Name)))
###Use the hybridization file names suffixes to define the putative cohort of origin: FIRST SET
phenoGlasCy5$putativeCohort <- factor(nchar(gsub(".+_", "", phenoGlasCy5$Scan.Name)))
levels(phenoGlasCy5$putativeCohort) <- c("putativeVantVeer", "putativeVanDeVijver")
###Use the hybridization file names suffixes to define the putative cohort of origin: SECOND SET
phenoGlasCy3$putativeCohort <- factor(nchar(gsub(".+_", "", phenoGlasCy3$Scan.Name)))
levels(phenoGlasCy3$putativeCohort) <- c("putativeVantVeer", "putativeVanDeVijver")
###Show counts FIRST SET
table(phenoGlasCy5$putativeCohort)
##################################################
###Show counts SECOND SET
table(phenoGlasCy3$putativeCohort)


###################################################
### code chunk number 27: osGlas
###################################################
###Process the overall survival (OS) character strings  and make numeric
OS <- gsub("\\s.+", "", phenoGlasCy5$Factor.Value.overall_survival)
phenoGlasCy5$OS <- as.numeric(OS)
####Process OS event and make numeric: missing data, labeled with "n/a" strings are turned into NA
phenoGlasCy5$OSevent <- as.numeric(phenoGlasCy5$Factor.Value.Event_Death)
###Count missing information by counting the number of NA
sum(is.na(phenoGlasCy5$OSevent))
####Create binary OS at 10 years groups
phenoGlasCy5$TenYearSurv <- phenoGlasCy5$OS < 10 & phenoGlasCy5$OSevent == 1
phenoGlasCy5$TenYearSurv[is.na(phenoGlasCy5$OSevent)] <- NA


###################################################
### code chunk number 28: print
###################################################
###Count OS events
table(phenoGlasCy5$OSevent)
###Count survival at 10 years status
table(phenoGlasCy5$TenYearSurv)


###################################################
### code chunk number 29: ttmGlas
###################################################
###Process time metastases (TTM) character strings and make numeric
###Note that missing data, labeled with "n/a" strings are turned into NA
TTM <- phenoGlasCy5$Factor.Value.Time_to_development_of_distant_metastases
phenoGlasCy5$TTM <- as.numeric(gsub("\\s.+", "", TTM))
####Process TTM event and make numeric
phenoGlasCy5$TTMevent <- as.numeric(phenoGlasCy5$Factor.Value.Event_distant_metastases)
###Use follow-up time from OS as TTM for patients withouth metastasis event
phenoGlasCy5$TTM[is.na(phenoGlasCy5$TTM)] <- phenoGlasCy5$OS[is.na(phenoGlasCy5$TTM)]
####Create binary TTM at 5 years groups
phenoGlasCy5$FiveYearMetastasis <- phenoGlasCy5$TTM < 5 & phenoGlasCy5$TTMevent == 1


###################################################
### code chunk number 30: prognosisGroupsGlas
###################################################
###Count TTM events
table(phenoGlasCy5$TTMevent)
###Count metastasis events by putative cohort of origin
table(phenoGlasCy5$FiveYearMetastasis, phenoGlasCy5$putativeCohort)


###################################################
### code chunk number 31: substitutePhenoGlas (eval = FALSE)
###################################################
## ###Substitute in the RGLists
## glasRGcy3$targets <- phenoGlasCy3
## glasRGcy5$targets <- phenoGlasCy5


###################################################
### code chunk number 32: finalETABM115save (eval = FALSE)
###################################################
## ###Save the final ExpressionSet object: not run
## dataDirLoc <- system.file("data", package = "mammaPrintData")
## save(glasRGcy5, glasRGcy3, file=paste(dataDirLoc, "/glasRG.rda", sep=""))


###################################################
### code chunk number 33: phenoBuyseOriginalCohorts
###################################################
###Retrieve the phenotypic information from one of the RGList intances
phenoBuyseCy3 <- buyseRGcy3$targets
phenoBuyseCy5 <- buyseRGcy5$targets
###Process overall survival (OS) character strings and make numeric: BOTH SETS
OScy5 <- phenoBuyseCy5$Factor.Value.SurvivalTime
phenoBuyseCy5$OS <- as.numeric(gsub("\\s.+", "", OScy5))
OScy3 <- phenoBuyseCy3$Factor.Value.SurvivalTime
phenoBuyseCy3$OS <- as.numeric(gsub("\\s.+", "", OScy3))
###Create the OS event by processing the OS character string with grep
###and the "plus" pattern making it a numeric vector: BOTH SETS
phenoBuyseCy5$OSevent <- 1*( ! 1:nrow(phenoBuyseCy5) %in% grep("plus", OScy5))
phenoBuyseCy3$OSevent <- 1*( ! 1:nrow(phenoBuyseCy3) %in% grep("plus", OScy3))
####Create binary OS at 10 years groups: BOTH SETS
phenoBuyseCy5$TenYearSurv <- phenoBuyseCy5$OS < 10 & phenoBuyseCy5$OSevent == 1
phenoBuyseCy3$TenYearSurv <- phenoBuyseCy3$OS < 10 & phenoBuyseCy3$OSevent == 1


###################################################
### code chunk number 34: osBuyse2
###################################################
###Count OS survival events: BOTH SETS
table(phenoBuyseCy5$OSevent)
table(phenoBuyseCy3$OSevent)
###Count survival at 10 years status: BOTH SETS
table(phenoBuyseCy5$TenYearSurv)
table(phenoBuyseCy3$TenYearSurv)


###################################################
### code chunk number 35: dfsBuyse
###################################################
###Process disease free survival (DFS) character strings and make numeric: BOTH SETS
DFScy5 <- phenoBuyseCy5$Factor.Value.Disease.Free.Survival
phenoBuyseCy5$DFS <- as.numeric(gsub("\\s.+", "", DFScy5))
DFScy3 <- phenoBuyseCy3$Factor.Value.Disease.Free.Survival
phenoBuyseCy3$DFS <- as.numeric(gsub("\\s.+", "", DFScy3))
###Create the DFS event by processing the DFS character string with grep
###and the "plus" pattern making it a numeric vector: BOTH SETS
phenoBuyseCy5$DFSevent <- 1*( ! 1:nrow(phenoBuyseCy5) %in% grep("plus", DFScy5))
phenoBuyseCy3$DFSevent <- 1*( ! 1:nrow(phenoBuyseCy3) %in% grep("plus", DFScy3))
####Create binary DFS at 5 years groups:BOTH SETS
phenoBuyseCy5$FiveYearDiseaseFree <- (phenoBuyseCy5$DFS < 5
				      & phenoBuyseCy5$DFSevent == 1)
phenoBuyseCy3$FiveYearDiseaseFree <- (phenoBuyseCy3$DFS < 5
				      & phenoBuyseCy3$DFSevent == 1)


###################################################
### code chunk number 36: dfsBuyse2
###################################################
###Count DFS survival events: BOTH SETS
table(phenoBuyseCy5$DFSevent)
table(phenoBuyseCy3$DFSevent)
###Count recurrence at 5 years status: BOTH SETS
table(phenoBuyseCy5$FiveYearDiseaseFree)
table(phenoBuyseCy3$FiveYearDiseaseFree)


###################################################
### code chunk number 37: ttmBuyse
###################################################
###Process time metastases (TTM) character strings and make numeric: BOTH SETS
TTMcy5 <- phenoBuyseCy5$Factor.Value.DistantMetastasis.Free.Survival
phenoBuyseCy5$TTM <- as.numeric(gsub("\\s.+", "", TTMcy5))
TTMcy3 <- phenoBuyseCy3$Factor.Value.DistantMetastasis.Free.Survival
phenoBuyseCy3$TTM <- as.numeric(gsub("\\s.+", "", TTMcy3))
###Create the TTM event by processing the TTM character string with grep
###and the "plus" pattern making it a numeric vector: BOTH SETS
phenoBuyseCy5$TTMevent <- 1*( ! 1:nrow(phenoBuyseCy5) %in% grep("plus", TTMcy5))
phenoBuyseCy3$TTMevent <- 1*( ! 1:nrow(phenoBuyseCy3) %in% grep("plus", TTMcy3))
####Create binary TTM at 5 years groups: BOTH SETS
phenoBuyseCy5$FiveYearRecurrence <- (phenoBuyseCy5$TTM < 5
				     & phenoBuyseCy5$TTMevent == 1)
phenoBuyseCy3$FiveYearRecurrence <- (phenoBuyseCy3$TTM < 5
				     & phenoBuyseCy3$TTMevent == 1)


###################################################
### code chunk number 38: prognosisGroupsBuyse
###################################################
###Count TTM survival events: BOTH SETS
table(phenoBuyseCy5$TTMevent)
table(phenoBuyseCy3$TTMevent)
###Count recurrence at 5 years status: BOTH SETS
table(phenoBuyseCy5$FiveYearRecurrence)
table(phenoBuyseCy3$FiveYearRecurrence)
###Count metastasis events by European center: BOTH SETS
table(phenoBuyseCy5$FiveYearRecurrence, phenoBuyseCy5$Characteristics.BioSourceProvider)
table(phenoBuyseCy3$FiveYearRecurrence, phenoBuyseCy3$Characteristics.BioSourceProvider)


###################################################
### code chunk number 39: excludeBuyse (eval = FALSE)
###################################################
## ###Exclude patients with missing ER status: BOTH SETSXS
## phenoBuyseCy5$toExclude <- phenoBuyseCy5$Factor.Value.ER.status=="unknown"
## phenoBuyseCy3$toExclude <- phenoBuyseCy3$Factor.Value.ER.status=="unknown"


###################################################
### code chunk number 40: substitutePhenoBuyse
###################################################
###Substitute in the RGLists
buyseRGcy3$targets <- phenoBuyseCy3
buyseRGcy5$targets <- phenoBuyseCy5


###################################################
### code chunk number 41: finalETABM77save (eval = FALSE)
###################################################
## ###Save RGList instances for later use: not run
## dataDirLoc <- system.file("data", package = "mammaPrintData")
## save(buyseRGcy5, buyseRGcy3, file=paste(dataDirLoc, "/buyseRG.rda", sep=""))


###################################################
### code chunk number 42: sessioInfo
###################################################
toLatex(sessionInfo())


