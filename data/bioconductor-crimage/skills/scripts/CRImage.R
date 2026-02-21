# Code example from 'CRImage' vignette. See references/ for full tutorial.

### R code from vignette source 'CRImage.Rnw'

###################################################
### code chunk number 1: CRImage.Rnw:31-32
###################################################
library(CRImage)


###################################################
### code chunk number 2: CRImage.Rnw:38-55
###################################################
f = system.file("extdata", "exImg2.jpg", package="CRImage")
img=readImage(f)
#convert image to the HSV color space
imgHSV=convertRGBToHSV(img)
#convert image to the LAB color space
imgLAB=convertRGBToLAB(img)
#convert back to the RGB color space
imgRGB=convertHSVToRGB(imgHSV)
imgRGB=Image(imgRGB)
colorMode(imgRGB)='color'
#display(imgRGB)

#convert back to the RGB color space
imgRGB=convertLABToRGB(imgLAB)
imgRGB=Image(imgRGB)
colorMode(imgRGB)='color'
#display(imgRGB)


###################################################
### code chunk number 3: CRImage.Rnw:73-81
###################################################
f = system.file("extdata", "exImg2.jpg", package="CRImage")
img=readImage(f)
#convert to grayscale
imgG=EBImage::channel(img,"gray")
#create a mask for white pixel
whitePixelMask=img[,,1]>0.85 & img[,,2]>0.85 & img[,,3]>0.85
#create binary image
imgB=createBinaryImage(imgG,img,method="otsu",numWindows=4,whitePixelMask=whitePixelMask)


###################################################
### code chunk number 4: CRImage.Rnw:92-94
###################################################
f = system.file("extdata", "exImg2.jpg", package="CRImage")
segmentationValues=segmentImage(filename=f,maxShape=800,minShape=40,failureRegion=2000,threshold="otsu",numWindows=4) 


###################################################
### code chunk number 5: CRImage.Rnw:146-154
###################################################
f = system.file("extdata", "trainingData.txt", package="CRImage")
#read training data
trainingData=read.table(f,header=TRUE)
#create classifier
classifierValues=createClassifier(trainingData)
classifier=classifierValues[[1]]
#classifiedCells=classifierValues[[2]]
#display(classifiedCells)


###################################################
### code chunk number 6: CRImage.Rnw:159-162
###################################################
	#classify cells
	f = system.file("extdata", "exImg2.jpg", package="CRImage")
	classValues=classifyCells(classifier,filename=f,KS=TRUE,maxShape=800,minShape=40,failureRegion=2000)


###################################################
### code chunk number 7: CRImage.Rnw:166-174
###################################################
t = system.file("extdata", "trainingData.txt", package="CRImage")
#read training data
trainingData=read.table(t,header=TRUE)
#create classifier
classifier=createClassifier(trainingData)[[1]]
#calculation of cellularity
f = system.file("extdata", "exImg2.jpg", package="CRImage")
cellularity=calculateCellularity(classifier=classifier,filename=f,KS=TRUE,maxShape=800,minShape=40,failureRegion=2000,classifyStructures=FALSE,cancerIdentifier="1",numDensityWindows=2,colors=c("green","red"))


###################################################
### code chunk number 8: CRImage.Rnw:185-189
###################################################
#create the classifier
t = system.file("extdata", "trainingData.txt", package="CRImage")
trainingData=read.table(t,header=TRUE)
classifier=createClassifier(trainingData)[[1]]


###################################################
### code chunk number 9: CRImage.Rnw:191-194 (eval = FALSE)
###################################################
## dir.create("AperiOutput")
## f = system.file("extdata",  package="CRImage")
## processAperio(classifier=classifier,inputFolder=f,outputFolder="AperiOutput",identifier="Da",numSections=2,cancerIdentifier="c",maxShape=800,minShape=40,failureRegion=2000)


###################################################
### code chunk number 10: CRImage.Rnw:201-211
###################################################
LRR <- c(rnorm(100, 0, 1), rnorm(10, -2, 1), rnorm(20, 3, 1),
       rnorm(100,0, 1)) 
BAF <- c(rnorm(100, 0.5, 0.1), rnorm(5, 0.2, 0.01), rnorm(5, 0.8, 0.01), rnorm(10, 0.25, 0.1), rnorm(10, 0.75, 0.1),
       rnorm(100,0.5, 0.1)) 

Pos <- sample(x=1:500, size=230, replace=TRUE)
Pos <- cumsum(Pos)
Chrom <- rep(1, length(LRR))
z <- data.frame(Name=1:length(LRR), Chrom=Chrom, Pos=Pos, LRR=LRR, BAF=BAF)
res <- correctCopyNumber(arr="Sample1", chr=1, p=0.75, z=z)


###################################################
### code chunk number 11: CRImage.Rnw:215-216 (eval = FALSE)
###################################################
## 	plotCorrectedCN(res, chr=1)


