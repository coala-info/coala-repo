# Code example from 'blimaTestingData' vignette. See references/ for full tutorial.

### R code from vignette source 'blimaTestingData.rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: blimaTestingData.rnw:22-24
###################################################
library(blimaTestingData)
data(blimatesting)


###################################################
### code chunk number 3: blimaTestingData.rnw:28-53
###################################################
library(beadarray)

processAllData <- function(dir, useImages=FALSE, illuminaAnnotation=NULL, 
		phenoData, platformName, platformAnnotationPath, processOnly = NULL)
{
	if(missing(dir) | missing(useImages) | missing(illuminaAnnotation) 
			| missing(phenoData) | missing(platformName) 
			| missing(platformAnnotationPath))
	{
		stop("Provide all data!")
	}
	x <- readIllumina(dir, useImages, illuminaAnnotation, sectionNames=processOnly);
	x@experimentData$phenoData <- phenoData;
	x <- insertSectionData(x, what="Platform", data=rep(platformName, 
					nrow(x@sectionData$numBeads)))
	x <- addChipsAnnotation(x, platformAnnotationPath);
	return(x);
}

addChipsAnnotation <- function(x, platformAnnotationPath)
{
	chipsannotation <- read.AnnotatedDataFrame(platformAnnotationPath);
	x <- insertSectionData(x, what="Chips", data=pData(chipsannotation))
	return(x);
}


###################################################
### code chunk number 4: blimaTestingData.rnw:58-80
###################################################
inputDirectory = "/tmp/BLIMATESTINGRAW"
outputDirectory = "/tmp"
if(file.exists(inputDirectory))
{
    useImages = TRUE;
    phenox <- read.AnnotatedDataFrame(file.path(inputDirectory, "annotation_6898481097.csv"));
    phenoy <- read.AnnotatedDataFrame(file.path(inputDirectory, "annotation_6898481102.csv"));
    px <- pData(phenox)
    py <- pData(phenoy)
    px <- px[px$Name %in% c("A1", "A2", "A3", "A4"),]
    py <- py[py$Name %in% c("D4", "E1", "E2", "E3", "E4"),]
    phenox <- AnnotatedDataFrame(data=px)
    phenoy <- AnnotatedDataFrame(data=py)
    spotsToReadx <- rownames(px)
    spotsToReady <- rownames(py)
    x15 <- processAllData(file.path(inputDirectory,"6898481097"), useImages, "Humanv4", phenox, 
    		"HumanHT-12.v4", file.path(inputDirectory, "chips.txt"), processOnly=spotsToReadx)
    y15 <- processAllData(file.path(inputDirectory, "6898481102"), useImages, "Humanv4", phenoy, 
    		"HumanHT-12.v4", file.path(inputDirectory, "chips.txt"), processOnly=spotsToReady)
    blimatesting <- c(x15, y15)
    save(blimatesting, file=file.path(outputDirectory, "blimatesting.rda"), compress="xz")
}


###################################################
### code chunk number 5: blimaTestingData.rnw:83-111
###################################################
if(file.exists(inputDirectory))
{
    annotationHumanHT12V4file <-file.path(inputDirectory, 
    		"Illumina/annotation/HumanHT-12_V4_0_R2_15002873_B.txt")
    annotationLines <- readLines(annotationHumanHT12V4file)
    sections <- grep("^\\[.*\\]$",annotationLines)
    sections <- c(sections, length(annotationLines) + 1)
    annotationHumanHT12V4 <- list()
    for(i in 1:(length(sections)-1))
    {
    	row <- sections[i]
    	sectionName <- substr(annotationLines[row], 2, nchar(annotationLines[row])-1)
    	if(sectionName == "Heading")
    	{
    		section <- read.csv(annotationHumanHT12V4file, sep="\t", skip=row, 
    				nrows = sections[i+1] - sections[i] - 1, header=FALSE)
    	}else
    	{
    		section <- read.csv(annotationHumanHT12V4file, sep="\t", skip=row, 
    				nrows = sections[i+1] - sections[i] - 1)
    	}
    	
    	annotationHumanHT12V4[[length(annotationHumanHT12V4) + 1]] = section
    	names(annotationHumanHT12V4)[i] <- sectionName
    }
    save(annotationHumanHT12V4, file=file.path(outputDirectory, 
                    "annotationHumanHT12V4.rda"), compress="xz")
}


###################################################
### code chunk number 6: blimaTestingData.rnw:114-119
###################################################
if(file.exists(inputDirectory))
{
    load(file=file.path(outputDirectory, "blimatesting.rda"), envir=.GlobalEnv)
    load(file=file.path(outputDirectory, "annotationHumanHT12V4.rda"), envir=.GlobalEnv)
}


###################################################
### code chunk number 7: blimaTestingData.rnw:124-125
###################################################
data(blimatesting)


