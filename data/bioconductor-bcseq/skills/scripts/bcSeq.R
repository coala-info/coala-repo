# Code example from 'bcSeq' vignette. See references/ for full tutorial.

## ----setup1, include=FALSE----------------------------------------------------
require(knitr)

## ----setup2, include=FALSE----------------------------------------------------
options(width=80)  # make the printing fit on the page
set.seed(1121)     # make the results repeatable
stdt<-date()

## ----bcSeq, eval=FALSE--------------------------------------------------------
# bcSeq_hamming(sampleFile, libFile, outFile, misMatch = 2, tMat = NULL,
#     numThread = 4, count_only = TRUE, detail_info = FALSE)

## ----bcSeq_edit, eval=FALSE---------------------------------------------------
# bcSeq_edit(sampleFile, libFile, outFile, misMatch = 2, tMat = NULL,
#     numThread = 4, count_only = TRUE, userProb = NULL,
#     gap_left = 2, ext_left = 1, gap_right = 2,
#     ext_right = 1, pen_max = 5, detail_info = FALSE)

## ----genlib, eval=TRUE--------------------------------------------------------
lFName    <- "./libFile.fasta"
bases     <- c(rep('A', 4), rep('C',4), rep('G',4), rep('T',4))
numOfBars <- 7
Barcodes  <- rep(NA, numOfBars*2)
for (i in 1:numOfBars){
    Barcodes[2*i-1] <- paste0(">barcode_ID: ", i)
    Barcodes[2*i]   <- paste(sample(bases, length(bases)), collapse = '')
}
write(Barcodes, lFName)

## ----genRead, eval=TRUE-------------------------------------------------------
rFName     <- "./readFile.fastq"
numOfReads <- 8
Reads      <- rep(NA, numOfReads*4)
for (i in 1:numOfReads){
    Reads[4*i-3] <- paste0("@read_ID_",i)
    Reads[4*i-2] <- Barcodes[2*sample(1:numOfBars,1,
        replace=TRUE, prob=seq(1:numOfBars))]
    Reads[4*i-1] <- "+"
    Reads[4*i]   <- paste(rawToChar(as.raw(
        33+sample(20:30, length(bases),replace=TRUE))),
        collapse='')
}
write(Reads, rFName)

## ----defaultAlign, eval=TRUE--------------------------------------------------
library(Matrix)
library(bcSeq)
ReadFile <- "./readFile.fastq"
BarFile  <- "./libFile.fasta"
outFile  <- "./count.csv"

## ----defaultAlign_test, eval=FALSE--------------------------------------------
# res <- bcSeq_hamming(ReadFile, BarFile, outFile, misMatch = 2,
#     tMat = NULL, numThread = 4, count_only = TRUE )
# res <- read.csv(outFile, header=FALSE)

## ----custAlign,eval=FALSE-----------------------------------------------------
# outFile  <- "./count2.csv"
# bcSeq_hamming(ReadFile, BarFile, outFile, misMatch = 2, tMat = NULL,
#     numThread = 4,count_only=FALSE )

## ----defaultAlign2, eval=FALSE------------------------------------------------
# res <- bcSeq_edit(ReadFile, BarFile, outFile, misMatch = 2,
#     tMat = NULL, numThread = 4, count_only = TRUE,
#     gap_left = 2, ext_left = 1, gap_right = 2, ext_right = 1,
#     pen_max = 7)
# res <- read.csv(outFile, header=FALSE)
# res[1:3,]

## ----custAlign2---------------------------------------------------------------
outFile  <- "./count2.csv"

## ----custAlign2_ex, eval=FALSE------------------------------------------------
# bcSeq_edit(ReadFile, BarFile, outFile, misMatch = 2, tMat = NULL,
#     numThread = 4, count_only = FALSE, gap_left = 2, ext_left = 1,
#     gap_right = 2, ext_right = 1, pen_max = 5)

## ----comtomizePF--------------------------------------------------------------
customizeP <- function(max_pen, prob, pen_val)
{
    prob * (1 - log(2) + log(1 + max_pen / (max_pen + pen_val) ) )
}

## ----comtomizeP,eval=FALSE----------------------------------------------------
# bcSeq_edit(sampleFile, libFile, outFile, misMatch = 2, tMat = NULL,
#     numThread = 4, count_only = TRUE, userProb = comstomizeP,
#     gap_left = 2, ext_left = 1, gap_right = 2,
#     ext_right = 1, pen_max = 5)

## ----comtomizeP2F-------------------------------------------------------------
library(Rcpp)
sourceCpp(code='
#include<Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
NumericVector cpp_fun(double m, NumericVector prob, NumericVector pen){
    NumericVector ret;
    for(int i = 0; i < prob.size(); ++i){
        ret.push_back(prob[i] * (1 - log(2) + log(1 + pen[i]/(m + pen[i]))));
    }
    return ret;
}')

## ----comtomizeP2,eval=FALSE---------------------------------------------------
# bcSeq_edit(sampleFile, libFile, outFile, misMatch = 2, tMat = NULL,
#     numThread = 4, count_only = TRUE, userProb = cpp_fun,
#     gap_left = 2, ext_left = 1, gap_right = 2,
#     ext_right = 1, pen_max = 5)

## ----eval=FALSE---------------------------------------------------------------
# library(gdata)
# x <- read.xls("./nbt.2800-S7.xlsx")
# fName <- "./libgRNA.fasta"
# size <- nrow(x)
# for(i in 1:size){
#     cat(">seq ID","\n",file=fName, append=TRUE)
#     cat(as.character(x$gRNA.sequence[i]),"\n", file=fName, append=TRUE)}
# fName <- "./libgRNA.csv"
# size <- nrow(x)
# for(i in 1:size){
#     cat(as.character(x$gRNA.sequence[i]),"\n", file=fName, append=TRUE)}

## ----eval=FALSE---------------------------------------------------------------
# library(bcSeq)
# readFileName  <- "ERR376998_trimed.fastq"
# libFileName   <- "libgRNA.fasta"
# alignedFile   <- "SampleAligned.txt"
# bcSeq_hamming(readFileName, libFileName, alignedFile, misMatch = 2,
#     tMat = NULL, numThread = 4, count_only = TRUE)

## ----sessinfo, echo=FALSE, include=TRUE, results='asis'-----------------------
toLatex(sessionInfo(), locale=FALSE)

## ----times, echo=FALSE, include=TRUE------------------------------------------
print(paste("Start Time",stdt))
print(paste("End Time  ",date()))

