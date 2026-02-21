# Code example from 'GA_ChIPanalyser' vignette. See references/ for full tutorial.

## ----loading_ChIPanalyser, eval = TRUE, echo = TRUE---------------------------
library(ChIPanalyser)
# Input data 
data(ChIPanalyserData)
# PFM Matrix 
PFM <- file.path(system.file("extdata",package="ChIPanalyser"),"BEAF-32.pfm")



## ----bsgenome, eval = TRUE, echo = TRUE---------------------------------------
library(BSgenome.Dmelanogaster.UCSC.dm6)

DNASequenceSet <- getSeq(BSgenome.Dmelanogaster.UCSC.dm6)


## ----GA_params, eval = TRUE, echo = TRUE--------------------------------------
# Number of individuals per generation 
pop <- 10 

# Number of generations 
gen <- 2

# Mutation Probability 
mut <- 0.3

# Children - Number of ofspring passed to the next generation 
child <- 2 

# Method - Goodness of fit metric used to optimise the Genetic algorithm 
method <- "MSE"


## ----GA_params_recom, class.source = 'fold-hide' ,eval = FALSE, echo = TRUE----
# # Number of individuals per generation
# pop <- 100
# 
# # Number of generations
# gen <- 50
# 
# # Mutation Probability
# mut <- 0.3
# 
# # Children - Number of ofspring passed to the next generation
# child <- 10
# 
# # Method - Goodness of fit metric used to optimise the Genetic algorithm
# method <- "MSE"
# 

## ----opti_params, eval = FALSE, echo = TRUE-----------------------------------
# # Parameters to optimised
# params <- c("N","lambda","PWMThreshold", paste0("CS",seq(1:11)))

## ----opti_params2,eval = TRUE,echo= TRUE--------------------------------------
params_custom <- vector("list", 14)
names(params_custom) <- c("N","lambda","PWMThreshold", paste0("CS",seq(1:11)))

# vector in the format of min value, max value and number of values 
params_custom$N <- c(1,1000000,5)

params_custom$lambda <- c(1,5,5)

# Bound between 0 and 1 
params_custom$PWMThreshold <- c(0.1,0.9,5)

# Bound between 0 and 1 
CS <- c(0,1,5)
CS_loc <- grep("CS",names(params_custom))
for(i in CS_loc){
    params_custom[[i]] <- CS
}

## ----gpp, eval = TRUE, echo = TRUE--------------------------------------------
GPP <- genomicProfiles(PFM=PFM,PFMFormat="JASPAR", BPFrequency=DNASequenceSet)


## ----generateStartingPopulation, class.source = 'fold-hide', eval = TRUE, echo = TRUE----
start_pop <- generateStartingPopulation(pop, params_custom)

## ----preprocess, eval = TRUE, echo = TRUE-------------------------------------
chipProfile <- processingChIP(chip,loci = top)

# Splitting data into training and testing
# We recommend setting dist to 20/80. However, here we only have 4 loci. 
splitdata <- splitData(chipProfile,dist = c(50,50),as.proportion = TRUE)

trainingSet <- splitdata$trainingSet
testingSet <- splitdata$testingSet

## ----evolve, eval = TRUE, echo = TRUE-----------------------------------------
evo <- evolve(population = pop,
    DNASequenceSet = DNASequenceSet,
    ChIPScore = trainingSet,
    genomicProfiles = GPP,
    parameters = params_custom,
    mutationProbability = mut,
    generations = gen,
    offsprings = child,
    chromatinState = cs,
    method = method,
    filename = "This_TF_is_Best_TF",
    checkpoint = FALSE,
    cores= 1)


## ----getFit, echo = TRUE, eval = TRUE-----------------------------------------
SuperFit <- getHighestFitnessSolutions(evo$population, 
    child = 1, 
    method = method)
single<-evo[["population"]][SuperFit]

## ----singleRun, eval = TRUE, echo = TRUE--------------------------------------
# Set chromatin states for single run - create CS Granges with affinity scores
cs_single <- setChromatinStates(single,cs)[[1]]

superFit <- singleRun(indiv = single,
    DNAAffinity = cs_single,
    genomicProfiles = GPP,
    DNASequenceSet = DNASequenceSet,
    ChIPScore = testingSet,
    fitness = "all")


## ----plotOccup, eval = TRUE, echo = TRUE,fig.height= 8, fig.width=15,fig.show=TRUE----

par(mfrow = c(2,1))
plotOccupancyProfile(predictedProfile = superFit$ChIP,
    ChIPScore = testingSet,
    chromatinState = cs_single,
    occupancy = superFit$occupancy,
    goodnessOfFit = superFit$gof,
    geneRef = geneRef,
    addLegend = TRUE)


