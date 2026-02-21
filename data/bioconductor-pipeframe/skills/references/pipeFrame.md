# Componentized Pipeline Framework

#### Zheng Wei and Shining Ma

#### 2025-10-30

# 1 What is pipeFrame

pipeFrame is an R package for building a componentized bioinformatics pipeline. Each step in this pipeline is wrapped in this framework, so the connection among steps is created seamlessly and automatically. Users could focus more on fine-tuning arguments rather than spending time on transforming file format, passing task outputs to task inputs or installing the dependencies. Componentized step elements can be customized into other new pipelines flexibly as well. This pipeline can be split into several important functional steps, so it is much easier for users to understand the complex arguments from each step rather than parameter combination from the whole pipeline. At the same time, componentized pipeline can restart at the breakpoint and avoid rerunning the whole pipeline, which may save time for users on pipeline tuning or such issues as power off or interrupted process.

![](data:image/png;base64...)

Componentized Pipeline

# 2 Download and Installation

The package pipeFrame is part of Bioconductor project starting from Bioc 3.9 built on R 3.6. To install the latest version of pipeFrame, please check your current Bioconductor version and R version first. The latest version of R is recommended, then you can download and install pipeFrame and all its dependencies as follows:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("pipeFrame")
```

Similar with other R packages, please load pipeFrame as follows:

```
library(pipeFrame)
```

# 3 Building the pipeline

## 3.1 Initialize

Before building your pipeline, please initialize the configuration.

For general users, calling the function `initPipeFrame` is required after loading the package.

```
initPipeFrame(availableGenome = c("hg19", "hg38", "mm9", "mm10",
                                  "danRer10", "galGal5", "galGal4",
                                  "rheMac3", "rheMac8", "panTro4",
                                  "rn5", "rn6", "sacCer2","sacCer3",
                                  "susScr3", "testgenome"),
              defaultJobName = "test-pipeline"
)
```

In this function, several parameters need to be defined and configured, including genome (All of the genomes available for this pacakge are shown in the code above. This is also the default value for `availableGenome`. User can use a subset of them.), job name, reference directory, temporary directory, check and install function, threads number, reference list, etc. In the following section, we will go through them in more details.

## 3.2 Configuration

For the default configuration, the directory of files is organized as follows:

* Working Directory/ (Temporary Directory)
  + pkgname-pipeline/ (Job name)
    - Step\_00\_FirstStepName\_pipe/
    - Step\_01\_SecondStepName\_pipe/
    - Step\_02\_ThirdStepName\_pipe/
    - …
  + refdir (Reference genome directory, which could be set by calling the function ‘setGenome’)
    - hg19/ (Human reference genome files (e.g. hg19.fa) are stored here)
    - hg38/
    - mm10/
    - mm9/
    - …

### 3.2.1 Temporary Directory

By default, the temporary directory is set as the current working directory. It could be modified by the function `initPipeFrame` with argument `defaultTmpDir`. Typically, all intermediate results for one job will be stored at the sub-directory named after this job. Users can get the full pathname by calling the function:

```
# display current temporary directory
getTmpDir()
```

```
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes"
```

Users can customize the temporary directory in this way:

```
dir.create("./testdir")
# set a new temporary directory
setTmpDir("./testdir")

# display the new temporary directory
getTmpDir()
```

```
## [1] "./testdir"
```

### 3.2.2 Reference Directory

The default reference directory is under the temporary directory. It could be modified by the function `initPipeFrame` with argument `defaultRefDir`. All of the reference data will be stored at the sub-directory named after the reference genome version, respectively. Users can get the full pathname by calling the function:

```
# display current reference directory
getRefDir()
```

```
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/refdir"
```

Users can customize the reference directory in this way:

```
# set a new reference directory
setRefDir("./refdir")

# display the new reference directory
getRefDir()
```

```
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/refdir"
```

### 3.2.3 Genome Annotation

Usually, only several genome assemblies are available for the pipeline. The pipeline builders need to specify which genome assemblies are available. It can be set by the argument `availableGenome` in the `initPipeFrame` function. Users can obtain the available genome assemblies:

```
getValidGenome()
```

```
##  [1] "hg19"       "hg38"       "mm9"        "mm10"       "danRer10"
##  [6] "galGal5"    "galGal4"    "rheMac3"    "rheMac8"    "panTro4"
## [11] "rn5"        "rn6"        "sacCer2"    "sacCer3"    "susScr3"
## [16] "testgenome"
```

Users can configure currently genome assembly by:

```
setGenome("hg19")

#display the current configured genome
getGenome()
```

```
## [1] "hg19"
```

If the genome is not available, a stop message will prompt.

### 3.2.4 Reference Data Generation

Users usually select only one specific genome assembly, so it would be more efficient to generate the reference data for this specific genome rather than all available genome assemblies.

There are two options for generating reference data. 1) For any R objects reference data shared by all genome assemblies (e.g. motif PWMs for vertebrate), they can be set by the argument `defaultReference` in the `initPipeFrame` function as a list member. Users can use `getRef("itemName")` to obtain the reference data. 2) In other cases, please implement a function and pass it to the argument `defaultCheckAndInstallFunc` in the function `initPipeFrame`. There are two steps:

First, implement a function for argument `defaultReference`. Here we show how to install BSgenome package for a specific genome assembly and generate its FASTA file. `checkAndInstall` needs to call several installation functions (e.g. `checkAndInstallBSgenome` and `checkAndInstallGenomeFa`) by `runWithFinishCheck`. Users assign a reference name (`refName`) and file/folder name (`refFilePath`) in the reference directory such as “path/to/refdir/hg19/”. This function can detect break point if the installation is not complete and skip the item that has already been generated or installed.

```
checkAndInstall <- function(){
    runWithFinishCheck(func = checkAndInstallBSgenome,refName = "bsgenome")
    runWithFinishCheck(func = checkAndInstallGenomeFa,refName = "fasta",
                       refFilePath = "genome.fa")
}
```

Second, implement functions for installation or data generation with the argument `refFilePath`.

For BSgenome installation:

```
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
```

In this example, the code will check if BSgenome is available for this genome and install the corresponding BSgenome package.
`refFilePath` can be ignored because no files will be generated. The function returns the BSgenome object as the resource of the reference name. So in the next example, use `getRefRc("bsgenome")` to obtain this object.

For genome sequence FASTA file generation:

```
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
```

In this example, the FASTA file can be generated based on BSgenome object. It needs to be stored at `refFilePath`. So the steps in the pipeline can obtain the reference directory by `getRefFile('fasta')`. It does not return any value because there is no R object generated.

Finally, the function can be passed to the initialization function:

```
initPipeFrame(availableGenome = c("hg19", "hg38", "mm9", "mm10"),
              defaultJobName = "test-pipeline",
              defaultCheckAndInstallFunc = checkAndInstall
)
```

When users call `setGenome("hg19")` to configure genome, this function will be called and the corresponding reference data will be installed.

### 3.2.5 Threads

For multi-core processors, multi-thread program could make full use of CPUs. It can be set in the function `initPipeFrame` with argument `defaultThreads`. User can get the currently available max threads as follows:

```
# check the max user thread limit
getThreads()
```

```
## [1] 2
```

Users can customize the max threads number as follows:

```
# customize the max threads number
setThreads(4)

# check the max user thread limit
getThreads()
```

```
## [1] 4
```

### 3.2.6 Job Name

Intermediate results will be stored in a folder with the job name under the temporary directory.

It is set in the function `initPipeFrame` with argument `defaultJobName`. Users can get the current job name as follows:

```
# display the current job name
getJobName()
```

```
## [1] "test-pipeline"
```

Users can customize the job name as follows:

```
# set a new job name
setJobName("testJobName")

# display the new job name
getJobName()
```

```
## [1] "testJobName"
```

```
getJobDir()
```

```
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/testdir/testJobName"
```

## 3.3 Step Restriction and Graph Management

The step relations managed are restricted to directed acyclic graph. The direction of data flow is from upstream to downstream. So when users create a new step object, restricting its relation with existing steps is necessary.

For example, if a two-step pipeline is under development, it should be restricted as follows:

```
addEdges(edges = c("RandomRegionOnGenome","OverlappedRandomRegion"),argOrder = 1)
```

The first parameter is the edge character vector, which consists of the upstream step and downstream step name. The second parameter `argOrder` will tell the order of upstream step in the graph when it transfers to the downstream step. This will be important and informative when there are more than one upstream steps for a downstream object, which helps the `Step` method distinguish them.

For package development, this function should be called in the `.onLoad` function

After the steps are restricted, they are organized in a graph. Users can query this graph by:

```
printMap()
```

## 3.4 Step Componentization

Each step should be properly wrapped in the pipeline framework to make the connections among steps seamless. The framework is specified in the `Step` base class. The `Step` objects contain the basic organized information for each step such as input directories, output directories, other parameters etc. All other customized steps must inherit from this class which is also the wrapper. Creating a new step needs to obey the rules outlined in the following section.

### 3.4.1 Non-object Function Wrapper

As many users may not be familiar with the definition of class or object, a function wrapper for the object generator is necessary. In the above example, the two-step pipeline randomly generates regions on the whole genome in the first step and finds out regions overlapped with known regions. Each step can be used individually or as the first step for downstream steps. So the two functions are shown as below.

For step `RandomRegionOnGenome` class, only sampleNumb is required. All other arguments could be set by default, as `genome` can be obtained from getGenome and `outputBed` can be generated automatically. In this wrapper, all the parameters from the function are put in one `list` to generate the `RandomRegionOnGenome` class. Finally, the step object should be returned.

```
randomRegionOnGenome <- function(sampleNumb, regionLen = 1000,
                                 genome = NULL, outputBed = NULL, ...){
    allpara <- c(list(Class = "RandomRegionOnGenome"),
                 as.list(environment()),list(...))
    step <- do.call(new,allpara)
    invisible(step)
}
```

For the `OverlappedRandomRegion` class, it is very similar. Only `inputBed` and `randomBed` are required.

```
overlappedRandomRegion <- function(inputBed, randomBed, outputBed = NULL, ...){
    allpara <- c(list(Class = "OverlappedRandomRegion"),
                 as.list(environment()),list(...))
    step <- do.call(new,allpara)
    invisible(step)
}
```

As `OverlappedRandomRegion` can be the next step of `RandomRegionOnGenome`, another function wrapper is needed for seamless data transfer. First, a generic interface should be declared. All of the parameters are the same except for the prevStep. Besides, the randomBed is no longer necessary as it can be obtained from prevStep object.

```
setGeneric("runOverlappedRandomRegion",function(prevStep,
                                                inputBed,
                                                randomBed = NULL,
                                                outputBed = NULL,
                                                ...)
    standardGeneric("runOverlappedRandomRegion"))
```

```
## [1] "runOverlappedRandomRegion"
```

Second, a `Step` method should be declared. One more parameter `prevStep` needs to be passed to `OverlappedRandomRegion` generator.

```
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
```

### 3.4.2 Class Implementation

First, to declare classes, they are required to be inherit from `Step`.

Two step classes are shown below as an example

```
# generate new Step : RandomRegionOnGenome
setClass(Class = "RandomRegionOnGenome",
         contains = "Step"
)

# generate another new Step : OverlappedRandomRegion
setClass(Class = "OverlappedRandomRegion",
         contains = "Step"
)
```

Second, to initialize parameters, `init` of `Step` method is required to be override. It includes three arguments, of which `.Object` is the object itself, `prevSteps` is the prior `Step` object that is required, and `...` contains all parameters passed from wrapper function. In this function, the pipeline developers need to fill the three list objects including `.Object@inputList` (all input directories or R objects), `.Object@outputList` (all output directories or R objects) and `.Object@paramList` (other parameters) based on the given arguments.

We recomend to fill in these list with function `input(.Object)$itemname <- value`, `output(.Object)$itemname <- value` and `param(.Object)$itemname <- value` rather than `.Object@inputList[[itemname]] <- value`, `.Object@outputList[[itemname]] <- value` and `.Object@paramList[[itemname]] <- value`. Because it is more safer to access the slot member of the class.

Here are some tips:

* Use `list(...)` to obtain all parameters passed from the wrapper
* If there are prevSteps for this step, use `getParam(prevStep,"outputListKey")` to obtain the output to fill inputList object
* All output file directories should be generated by default in the step intermediate result directory, which can be obtained by getStepWorkDir(.Object,“defaultOutputFileName”)
* If the name of output file is based on the name of input file, use `getAutoPath(.Object,getParam(.Object,"theInputKey"), "suffixToBeRemoved","newSuffixToBeReplacedc")`
* Input, output and other parameters should be filled in correct formats.
* The dependent input reference files or objects should be filled with `getRef`, `getRefRc`, `getRefFiles` or `getGenome` when the arguments are set with `NULL` or other default values. So when users configure the genome assembly, these arguments are actually not required.
* Return .Object at the end of the method

All tips are illustrated in the following two examples.

```
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
```

Third, to process the data, `processing` of `Step` method is required to be override. It contains two arguments, `.Object` and `...`. `.Object` is the object itself, and `...` is currently unused and for future extension. In this function, the pipeline developers need to implement the core calculation algorithm and save the result objects or files to configure the output directory.

Here are some tips:

* Display the parameters including input, output and others by `getParam(.Object, "the key name")`
* Return .Object at the end of the method

```
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
```

### 3.4.3 Step Components Usage

In this way, users do not need to get familiar with the definition of classes or objects, and could build the pipeline easily:

```
library(magrittr)

testInputBedFilePath <- file.path(tempdir(),"test.bed")
library(rtracklayer)
export.bed(GRanges("chr7:1-127473000"),testInputBedFilePath)

result <- randomRegionOnGenome(1000) %>%
    runOverlappedRandomRegion(inputBed = testInputBedFilePath)
```

```
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
```

```
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
```

Or use the function seperately:

```
result1 <- randomRegionOnGenome(1000)
```

```
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
```

```
randombed <- getParam(result1,"outputBed")

randombed
```

```
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/testdir/testJobName/Step_00_pipe_RandomRegionOnGenome/random.bed"
```

```
result2 <- overlappedRandomRegion(inputBed = testInputBedFilePath,
                                  randomBed = randombed)
```

```
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
```

```
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
## [1] "2025-10-30 01:43:20 EDT"
```

## 3.5 Combine into Whole Pipeline

The steps can be combined into a whole pipeline with a function wrapper:

```
library(magrittr)
examplePipe <- function(sampleNumb, inputBed, genome, threads = 2,...){
    setThreads(threads = threads)
    setGenome(genome = genome)
    result <- randomRegionOnGenome(sampleNumb = sampleNumb, ...) %>%
    runOverlappedRandomRegion(inputBed = inputBed,...)
    return(result)
}
```

Developers can select important and frequently used arguments of the steps as the arguments of the whole pipeline. Other arguments can be passed through `...` with `StepName.argumentsName = value` like:

```
examplePipe(sampleNumb = 1000,inputBed = testInputBedFilePath,genome = "hg19",
            RandomRegionOnGenome_pipe.regionLen = 10000)
```

```
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
```

```
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
```

```
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
## [1] "2025-10-30 01:43:24 EDT"
```

```
## An object of class "OverlappedRandomRegion"
## Slot "argv":
## $stepDefName
## NULL
##
## $stepPipeName
## NULL
##
## $isReportStep
## [1] FALSE
##
## $outputBed
## NULL
##
## $randomBed
## NULL
##
## $inputBed
## [1] "/tmp/Rtmp8KvbcH/test.bed"
##
## $prevStep
## An object of class "RandomRegionOnGenome"
## Slot "argv":
## $stepDefName
## NULL
##
## $stepPipeName
## NULL
##
## $isReportStep
## [1] FALSE
##
## $sampleNumb
## [1] 1000
##
## $regionLen
## [1] 1000
##
## $genome
## NULL
##
## $outputBed
## NULL
##
##
## Slot "paramList":
## $regionLen
## [1] 1000
##
## $sampleNumb
## [1] 1000
##
## $bsgenome
## | BSgenome object for Human
## | - organism: Homo sapiens
## | - provider: UCSC
## | - genome: hg19
## | - release date: June 2013
## | - 298 sequence(s):
## |     chr1                  chr2                  chr3
## |     chr4                  chr5                  chr6
## |     chr7                  chr8                  chr9
## |     chr10                 chr11                 chr12
## |     chr13                 chr14                 chr15
## |     ...                   ...                   ...
## |     chr19_gl949749_alt    chr19_gl949750_alt    chr19_gl949751_alt
## |     chr19_gl949752_alt    chr19_gl949753_alt    chr20_gl383577_alt
## |     chr21_gl383578_alt    chr21_gl383579_alt    chr21_gl383580_alt
## |     chr21_gl383581_alt    chr22_gl383582_alt    chr22_gl383583_alt
## |     chr22_kb663609_alt
## |
## | Tips: call 'seqnames()' on the object to get all the sequence names, call
## | 'seqinfo()' to get the full sequence info, use the '$' or '[[' operator to
## | access a given sequence, see '?BSgenome' for more information.
##
##
## Slot "inputList":
## list()
##
## Slot "outputList":
## $outputBed
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/testdir/testJobName/Step_00_pipe_RandomRegionOnGenome/random.bed"
##
##
## Slot "propList":
## $pipe
## list()
##
##
## Slot "reportList":
## $timeStampStart
## [1] "2025-10-30 01:43:19 EDT"
##
## $timeStampEnd
## [1] "2025-10-30 01:43:20 EDT"
##
##
## Slot "stepName":
## [1] "pipe_RandomRegionOnGenome"
##
## Slot "stepBaseClass":
## [1] "RandomRegionOnGenome"
##
## Slot "finish":
## [1] TRUE
##
## Slot "timeStampStart":
## [1] "2025-10-30 01:43:19 EDT"
##
## Slot "timeStampEnd":
## [1] "2025-10-30 01:43:20 EDT"
##
## Slot "id":
## [1] 0
##
## Slot "pipeName":
## [1] "pipe"
##
## Slot "loaded":
## [1] TRUE
##
## Slot "isReportStep":
## [1] FALSE
##
## Slot "initParam":
## [[1]]
## [1] "test"
##
##
## Slot "processingParam":
## [[1]]
## [1] "test"
##
##
##
## $RandomRegionOnGenome_pipe.regionLen
## [1] 10000
##
##
## Slot "paramList":
## list()
##
## Slot "inputList":
## $randomBed
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/testdir/testJobName/Step_00_pipe_RandomRegionOnGenome/random.bed"
##
## $inputBed
## [1] "/tmp/Rtmp8KvbcH/test.bed"
##
##
## Slot "outputList":
## $outputBed
## [1] "/tmp/Rtmpb8t1W6/Rbuild2342eb19f26fe0/pipeFrame/vignettes/testdir/testJobName/Step_01_pipe_OverlappedRandomRegion/test.bed"
##
##
## Slot "propList":
## $pipe
## list()
##
##
## Slot "reportList":
## $timeStampStart
## [1] "2025-10-30 01:43:24 EDT"
##
## $timeStampEnd
## [1] "2025-10-30 01:43:24 EDT"
##
##
## Slot "stepName":
## [1] "pipe_OverlappedRandomRegion"
##
## Slot "stepBaseClass":
## [1] "OverlappedRandomRegion"
##
## Slot "finish":
## [1] TRUE
##
## Slot "timeStampStart":
## [1] "2025-10-30 01:43:24 EDT"
##
## Slot "timeStampEnd":
## [1] "2025-10-30 01:43:24 EDT"
##
## Slot "id":
## [1] 1
##
## Slot "pipeName":
## [1] "pipe"
##
## Slot "loaded":
## [1] FALSE
##
## Slot "isReportStep":
## [1] FALSE
##
## Slot "initParam":
## [[1]]
## [1] "test"
##
##
## Slot "processingParam":
## [[1]]
## [1] "test"
```

# 4 Session Information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 magrittr_2.0.4
##  [3] BSgenome_1.78.0                   rtracklayer_1.70.0
##  [5] BiocIO_1.20.0                     Biostrings_2.78.0
##  [7] XVector_0.50.0                    GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0                     IRanges_2.44.0
## [11] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [13] generics_0.1.4                    pipeFrame_1.26.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 SparseArray_1.10.0
##  [3] bitops_1.0-9                lattice_0.22-7
##  [5] digest_0.6.37               evaluate_1.0.5
##  [7] grid_4.5.1                  fastmap_1.2.0
##  [9] jsonlite_2.0.0              Matrix_1.7-4
## [11] cigarillo_1.0.0             restfulr_0.0.16
## [13] BiocManager_1.30.26         httr_1.4.7
## [15] XML_3.99-0.19               codetools_0.2-20
## [17] jquerylib_0.1.4             abind_1.4-8
## [19] cli_3.6.5                   rlang_1.1.6
## [21] crayon_1.5.3                Biobase_2.70.0
## [23] visNetwork_2.1.4            cachem_1.1.0
## [25] DelayedArray_0.36.0         yaml_2.3.10
## [27] S4Arrays_1.10.0             tools_4.5.1
## [29] parallel_4.5.1              BiocParallel_1.44.0
## [31] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
## [33] curl_7.0.0                  R6_2.6.1
## [35] matrixStats_1.5.0           lifecycle_1.0.4
## [37] htmlwidgets_1.6.4           bslib_0.9.0
## [39] xfun_0.53                   GenomicAlignments_1.46.0
## [41] MatrixGenerics_1.22.0       knitr_1.50
## [43] rjson_0.2.23                htmltools_0.5.8.1
## [45] rmarkdown_2.30              compiler_4.5.1
## [47] RCurl_1.98-1.17
```