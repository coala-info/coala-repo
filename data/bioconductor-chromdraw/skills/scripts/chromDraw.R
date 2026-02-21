# Code example from 'chromDraw' vignette. See references/ for full tutorial.

### R code from vignette source 'chromDraw.Rnw'

###################################################
### code chunk number 1: vignette.exampleData
###################################################
library(GenomicRanges)

exampleData <- GRanges(seqnames =Rle(c("ACK1"), c(4)),ranges = 
IRanges(start = c(0, 6700000,0,12400000), 
        end = c(6700000,12400000,0,17000000), 
        names = c("A","B","CENTROMERE","C")),  
        color = c("yellow","yellow","","yellow")
       );

exampleData;


###################################################
### code chunk number 2: vignette.exampleColor
###################################################

name <- c("yellow", "red");
r <- c(255, 255);
g <- c(255, 0);
b <- c(0, 0);
exampleColor <- data.frame(name,r,g,b);

exampleColor;


###################################################
### code chunk number 3: vignette.chromDraw
###################################################
library(chromDraw)

OUTPUTPATH = file.path(getwd());

INPUTPATH = system.file('extdata',
                        'Ack_and_Stenopetalum_nutans.txt', 
                        package ='chromDraw')
                        
COLORPATH = system.file('extdata',
                        'default_colors.txt', 
                        package ='chromDraw')
                        
chromDraw(argc=7,  
          argv=c("chromDraw","-c",COLORPATH,"-d",INPUTPATH,"-o",
OUTPUTPATH));


###################################################
### code chunk number 4: vignette.chromDrawGR
###################################################
library(chromDraw)

chromDrawGR(list(exampleData), exampleColor);


###################################################
### code chunk number 5: vignette.chromDraw
###################################################
library(chromDraw)

OUTPUTPATH = file.path(getwd());

INPUTPATH = system.file('extdata',
                        'bed.bed', 
                        package ='chromDraw')
                        
chromDraw(argc=7,  
          argv=c("chromDraw", "-f", "bed", "-d",INPUTPATH, "-o",
OUTPUTPATH));


