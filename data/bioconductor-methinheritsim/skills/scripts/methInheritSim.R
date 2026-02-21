# Code example from 'methInheritSim' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, warning=FALSE, message=FALSE, results = 'asis'------
BiocStyle::markdown()
library(knitr)

## ----loadingPackage, warning=FALSE, message=FALSE-----------------------------
library(methInheritSim)

## ----caseStudy01, warning=FALSE, message=FALSE, collapse=TRUE-----------------
## Load  read DMS dataset (not in this case but normaly)
data(samplesForChrSynthetic)

## Print the first three rows of the object
head(samplesForChrSynthetic, n = 3)

## ----runSim01, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE--------
## Directory where the files related to the simulation will be saved
temp_dir <- "test_runSim"

## Run the simulation
runSim(methData = samplesForChrSynthetic,  # The dataset use for generate 
                                           # the synthetic chr.
        nbSynCHR = 1,       # The number of synthetic chromosome
        nbSimulation = 2,   # The number of simulation for each parameter
        nbBlock = 10, nbCpG = 20, # The number of site in the 
                                  # synthetic chr is nbBLock * nbCpG
        nbGeneration = 3,    # At least 2 generations must be present
        vNbSample = c(3, 6), # The number of controls (= number of cases) in
                             # each simulation
        vpDiff = c(0.9),   # Mean proportion of samples with  
                           # differentially methylated values
        vpDiffsd = c(0.1), # Standard deviation associated to vpDiff
        vDiff = c(0.8),    # The shift of the mean of the C/T ratio in 
                           # the differentially methylated sites
        vInheritance = c(0.5),  # The proportion of cases that inherit 
                                # differentially methylated sites
        propInherite = 0.3,     # The proportion of diffementially methylated
                                # regions that are inherited
        rateDiff = 0.3,    # The mean frequency of the differentially 
                           # methylated regions
        minRate = 0.2,     # The minimum rate for differentially
                           # methylated sites
        propHetero = 0.5,  # The reduction of vDiff for the following
                           # generations
        keepDiff = FALSE,  # When FALSE, the differentially methylated
                           # sites are the same in all simulations
        outputDir = temp_dir, # Directory where files are saved
        fileID = "S1",
        runAnalysis = TRUE, 
        nbCores = 1, 
        vSeed = 32)        # Fix seed to unable reproductive results
        
        # The files generated
        dir(temp_dir)

## ----removeFiles, warning=FALSE, message=FALSE, collapse=TRUE, echo=FALSE-----
if (dir.exists(temp_dir)) {
    unlink(temp_dir, recursive = TRUE, force = FALSE)
}

## ----syntheticChr, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE----
## The synthetic chromosome
syntheticChr <- readRDS("demo_runSim/syntheticChr_S1_1.rds")

## In GRanges format, only Cpg present
head(syntheticChr, n=3)

## ----simData, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE---------
#### The simulation dataset
simData <- readRDS("demo_runSim/simData_S1_1_3_0.9_0.8_0.5_1.rds")

#### Information for the first generation F1
head(simData[[1]], n=3)

#### Information for the second generation F2
head(simData[[2]], n=3)

## ----stateDiff, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-------
#### The DMS state information
stateDiff <- readRDS("demo_runSim/stateDiff_S1_1_3_0.9_0.8_0.5_1.rds")

#### In stateDiff, the position of DMS is indicated by 1
#### in stateInherite, the position of inherited DMS is indicated by 1
head(stateDiff)

## ----methylGR, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE--------
#### The raw methylation data in GRanges
methylGR <- readRDS("demo_runSim/methylGR_S1_1_3_0.9_0.8_0.5_1.rds")

#### The third sample of the first generation
head(methylGR[[1]][[3]], n = 3)

#### The fourth sample of the third generation
head(methylGR[[3]][[4]], n = 3)

## ----treatment, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-------
#### The information about controls and cases 
treatment <- readRDS("demo_runSim/treatment_S1_1_3.rds")

#### 0 = control, 1 = case, length = number of samples
head(treatment)

## ----methylObj, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-------
## The raw methylation data
methylObj <- readRDS("demo_runSim/methylObj_S1_1_3_0.9_0.8_0.5_1.rds")

#### The third sample of the first generation
head(methylObj[[1]][[3]], n = 3)

#### The fourth sample of the third generation
head(methylObj[[3]][[4]], n = 3)

## ----meth, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE------------
#### The methylation events present in multiple samples
meth <- readRDS("demo_runSim/meth_S1_1_3_0.9_0.8_0.5_1.rds")

#### Information for all samples in the first generation
head(meth[[1]], n = 3)

## ----methDiff, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE--------
#### The differential methylation statistics
methDiff <- readRDS("demo_runSim/methDiff_S1_1_3_0.9_0.8_0.5_1.rds")
#### Information for the first generation
head(methDiff[[1]], n = 3)

