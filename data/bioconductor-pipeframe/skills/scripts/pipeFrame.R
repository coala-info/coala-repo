# Code example from 'pipeFrame' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning=FALSE, message=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("pipeFrame")
# 

## -----------------------------------------------------------------------------
library(pipeFrame)

## ----eval=TRUE----------------------------------------------------------------
initPipeFrame(availableGenome = c("hg19", "hg38", "mm9", "mm10", 
                                  "danRer10", "galGal5", "galGal4", 
                                  "rheMac3", "rheMac8", "panTro4", 
                                  "rn5", "rn6", "sacCer2","sacCer3", 
                                  "susScr3", "testgenome"),
              defaultJobName = "test-pipeline"
)


## -----------------------------------------------------------------------------
# display current temporary directory
getTmpDir()

## -----------------------------------------------------------------------------
dir.create("./testdir")
# set a new temporary directory
setTmpDir("./testdir")

# display the new temporary directory
getTmpDir()

## -----------------------------------------------------------------------------
# display current reference directory
getRefDir()

## -----------------------------------------------------------------------------
# set a new reference directory
setRefDir("./refdir")

# display the new reference directory
getRefDir()

## -----------------------------------------------------------------------------
getValidGenome()


## -----------------------------------------------------------------------------

setGenome("hg19")

#display the current configured genome
getGenome()


## ----echo=FALSE---------------------------------------------------------------
checkAndInstall <- function(){
    runWithFinishCheck(func = checkAndInstallBSgenome,refName = "bsgenome")
}


## ----eval=FALSE---------------------------------------------------------------
# checkAndInstall <- function(){
#     runWithFinishCheck(func = checkAndInstallBSgenome,refName = "bsgenome")
#     runWithFinishCheck(func = checkAndInstallGenomeFa,refName = "fasta",
#                        refFilePath = "genome.fa")
# }
# 

## -----------------------------------------------------------------------------
library(BSgenome)
checkAndInstallBSgenome <- function(refFilePath){
    genome <- getGenome()
    bsgenomename<- BSgenome::available.genomes()[
        grepl(paste0(genome,"$"),BSgenome::available.genomes())]
    if(length(bsgenomename)==0){
        stop("BSgenome does not support this genome")
    }
    bsgenomeinstall <- BSgenome::installed.genomes()[
        grepl(paste0(genome,"$"),BSgenome::installed.genomes())]
    if(length(bsgenomeinstall)==0){
        message(paste("BSgenome for ",genome,"has not been installed,"))
        message("begin to install ...")
        BiocManager::install(bsgenomename)
    }
    return(getBSgenome(bsgenomename))
}

## -----------------------------------------------------------------------------
checkAndInstallGenomeFa <- function(refFilePath){
    outFile <- refFilePath
    bsgenome<-getRefRc("bsgenome")
    if(!is(bsgenome, "BSgenome")){
        stop("The variable 'bsgenome' is not a BSgenome")
        }
    append <- FALSE
    for(chrT in seqnames(bsgenome)){
        if(is.null(masks(bsgenome[[chrT]])))
            chrSeq <- DNAStringSet(bsgenome[[chrT]])
        else
            chrSeq <- DNAStringSet(injectHardMask(bsgenome[[chrT]], 
                                                  letter="N"))
        names(chrSeq) <- chrT
        writeXStringSet(chrSeq, filepath=outFile, format="fasta", 
                        append=append)
        append <- TRUE
    }
    return(NULL)
}

## -----------------------------------------------------------------------------
initPipeFrame(availableGenome = c("hg19", "hg38", "mm9", "mm10"),
              defaultJobName = "test-pipeline",
              defaultCheckAndInstallFunc = checkAndInstall
)


## -----------------------------------------------------------------------------
# check the max user thread limit
getThreads()

## -----------------------------------------------------------------------------
# customize the max threads number
setThreads(4)

# check the max user thread limit
getThreads()

## -----------------------------------------------------------------------------
# display the current job name
getJobName()

## -----------------------------------------------------------------------------
# set a new job name
setJobName("testJobName")

# display the new job name
getJobName()

getJobDir()

## -----------------------------------------------------------------------------

addEdges(edges = c("RandomRegionOnGenome","OverlappedRandomRegion"),argOrder = 1)

## ----eval=TRUE----------------------------------------------------------------
printMap()

## -----------------------------------------------------------------------------
randomRegionOnGenome <- function(sampleNumb, regionLen = 1000, 
                                 genome = NULL, outputBed = NULL, ...){
    allpara <- c(list(Class = "RandomRegionOnGenome"),
                 as.list(environment()),list(...))
    step <- do.call(new,allpara)
    invisible(step)
}


## -----------------------------------------------------------------------------

overlappedRandomRegion <- function(inputBed, randomBed, outputBed = NULL, ...){
    allpara <- c(list(Class = "OverlappedRandomRegion"),
                 as.list(environment()),list(...))
    step <- do.call(new,allpara)
    invisible(step)
}

## -----------------------------------------------------------------------------
setGeneric("runOverlappedRandomRegion",function(prevStep,
                                                inputBed,
                                                randomBed = NULL,
                                                outputBed = NULL,
                                                ...) 
    standardGeneric("runOverlappedRandomRegion"))


## -----------------------------------------------------------------------------
setMethod(
    f = "runOverlappedRandomRegion",
    signature = "Step",
    definition = function(prevStep,
                          inputBed,
                          randomBed = NULL,
                          outputBed = NULL,
                          ...){
        allpara <- c(list(Class = "OverlappedRandomRegion", 
                          prevSteps = list(prevStep)),
                     as.list(environment()),list(...))
        step <- do.call(new,allpara)
        invisible(step)
    }
)


## -----------------------------------------------------------------------------
# generate new Step : RandomRegionOnGenome
setClass(Class = "RandomRegionOnGenome",
         contains = "Step"
)

# generate another new Step : OverlappedRandomRegion
setClass(Class = "OverlappedRandomRegion",
         contains = "Step"
)

## -----------------------------------------------------------------------------
setMethod(
    f = "init",
    signature = "RandomRegionOnGenome",
    definition = function(.Object,prevSteps = list(),...){
        # All arguments in function randomRegionOnGenome
        # will be passed from "..."
        # so get the arguments from "..." first.
        allparam <- list(...)
        sampleNumb <- allparam[["sampleNumb"]]
        regionLen <- allparam[["regionLen"]]
        genome <- allparam[["genome"]]
        outputBed <- allparam[["outputBed"]]
        # no previous steps for this step so ingnore the "prevSteps"
        # begin to set input parameters
        # no input for this step
        # begin to set output parameters
        if(is.null(outputBed)){
            output(.Object)$outputBed <-
                getStepWorkDir(.Object,"random.bed")
        }else{
            output(.Object)$outputBed <- outputBed
        }
        # begin to set other parameters
        param(.Object)$regionLen <- regionLen
        param(.Object)$sampleNumb <- sampleNumb
        if(is.null(genome)){
            param(.Object)$bsgenome <- getBSgenome(getGenome())
        }else{
            param(.Object)$bsgenome <- getBSgenome(genome)
        }
        # don't forget to return .Object
        .Object
    }
)


setMethod(
    f = "init",
    signature = "OverlappedRandomRegion",
    definition = function(.Object,prevSteps = list(),...){
        # All arguments in function overlappedRandomRegion and
        # runOerlappedRandomRegion will be passed from "..."
        # so get the arguments from "..." first.
        allparam <- list(...)
        inputBed <- allparam[["inputBed"]]
        randomBed <- allparam[["randomBed"]]
        outputBed <- allparam[["outputBed"]]
        # inputBed can obtain from previous step object when running
        # runOerlappedRandomRegion
        if(length(prevSteps)>0){
            prevStep <- prevSteps[[1]]
            input(.Object)$randomBed <- getParam(prevStep,"outputBed")
        }
        # begin to set input parameters
        if(!is.null(inputBed)){
            input(.Object)$inputBed <- inputBed
        }
        if(!is.null(randomBed)){
            input(.Object)$randomBed <- randomBed
        }
        # begin to set output parameters
        # the output is recemended to set under the step work directory
        if(!is.null(outputBed)){
            output(.Object)$outputBed <- outputBed
        }else{
            output(.Object)$outputBed <-
                getAutoPath(.Object, getParam(.Object, "inputBed"),
                            "bed", suffix = "bed")
            # the path can also be generate in this way
            # ib <- getParam(.Object,"inputBed")
            # output(.Object)$outputBed <-
            #    file.path(getStepWorkDir(.Object),
            #    paste0(substring(ib,1,nchar(ib)-3), "bed"))
        }
        # begin to set other parameters
        # no other parameters
        # don't forget to return .Object


        .Object
    }
)


## -----------------------------------------------------------------------------

setMethod(
    f = "processing",
    signature = "RandomRegionOnGenome",
    definition = function(.Object,...){
        # All arguments are set in .Object
        # so we can get them from .Object
        sampleNumb <- getParam(.Object,"sampleNumb")
        regionLen <- getParam(.Object,"regionLen")
        bsgenome <- getParam(.Object,"bsgenome")
        outputBed <- getParam(.Object,"outputBed")
        # begin the calculation
        chrlens <-seqlengths(bsgenome)
        selchr <- grep("_|M",names(chrlens),invert=TRUE)
        chrlens <- chrlens[selchr]
        startchrlens <- chrlens - regionLen
        spchrs <- sample(x = names(startchrlens),
                         size =  sampleNumb, replace = TRUE, 
                         prob = startchrlens / sum(startchrlens))
        gr <- GRanges()
        for(chr in names(startchrlens)){
            startpt <- sample(x = 1:startchrlens[chr],
                              size = sum(spchrs == chr),replace = FALSE)
            gr <- c(gr,
                    GRanges(seqnames = chr, 
                            ranges = IRanges(start = startpt, width = 1000)))
        }
        result <- sort(gr,ignore.strand=TRUE)
        rtracklayer::export.bed(object = result, con =  outputBed)
        # don't forget to return .Object
        .Object
    }
)

setMethod(
    f = "genReport",
    signature = "RandomRegionOnGenome",
    definition = function(.Object, ...){
        .Object
    }
)



setMethod(
    f = "processing",
    signature = "OverlappedRandomRegion",
    definition = function(.Object,...){
        # All arguments are set in .Object
        # so we can get them from .Object
        allparam <- list(...)
        inputBed <- getParam(.Object,"inputBed")
        randomBed <- getParam(.Object,"randomBed")
        outputBed <- getParam(.Object,"outputBed")

        # begin the calculation
        gr1 <- import.bed(con = inputBed)
        gr2 <- import.bed(con = randomBed)
        gr <- second(findOverlapPairs(gr1,gr2))
        export.bed(gr,con = outputBed)
        # don't forget to return .Object
        .Object
    }
)

setMethod(
    f = "genReport",
    signature = "OverlappedRandomRegion",
    definition = function(.Object, ...){
        .Object
    }
)

## ----eval=TRUE----------------------------------------------------------------
library(magrittr)


testInputBedFilePath <- file.path(tempdir(),"test.bed")
library(rtracklayer)
export.bed(GRanges("chr7:1-127473000"),testInputBedFilePath)

result <- randomRegionOnGenome(1000) %>%
    runOverlappedRandomRegion(inputBed = testInputBedFilePath)


## ----eval=TRUE----------------------------------------------------------------
result1 <- randomRegionOnGenome(1000)

randombed <- getParam(result1,"outputBed")

randombed

result2 <- overlappedRandomRegion(inputBed = testInputBedFilePath, 
                                  randomBed = randombed)


## -----------------------------------------------------------------------------
library(magrittr)
examplePipe <- function(sampleNumb, inputBed, genome, threads = 2,...){
    setThreads(threads = threads)
    setGenome(genome = genome)
    result <- randomRegionOnGenome(sampleNumb = sampleNumb, ...) %>%
    runOverlappedRandomRegion(inputBed = inputBed,...)
    return(result)
}


## -----------------------------------------------------------------------------
examplePipe(sampleNumb = 1000,inputBed = testInputBedFilePath,genome = "hg19",
            RandomRegionOnGenome_pipe.regionLen = 10000)

## -----------------------------------------------------------------------------
sessionInfo()

