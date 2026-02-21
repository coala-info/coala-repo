# Code example from 'IsoformSwitchAnalyzeR' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----results = "hide", message = FALSE, warning=FALSE-------------------------
library(IsoformSwitchAnalyzeR)

## -----------------------------------------------------------------------------
packageVersion('IsoformSwitchAnalyzeR')

## -----------------------------------------------------------------------------
### Please note
# The way of importing files in the following example with
# "system.file('pathToFile', package="IsoformSwitchAnalyzeR") is
# specialized way of accessing the example data in the IsoformSwitchAnalyzeR package
# and not something  you need to do - just supply the string e.g.
# parentDir = "/path/to/mySalmonQuantifications/" pointing to the parent directory (where
# each sample is a separate sub-directory) to the function.

### Import quantifications
salmonQuant <- importIsoformExpression(
    parentDir = system.file("extdata/",package="IsoformSwitchAnalyzeR")
)

## -----------------------------------------------------------------------------
head(salmonQuant$abundance, 2)

head(salmonQuant$counts, 2)

## -----------------------------------------------------------------------------
myDesign <- data.frame(
    sampleID = colnames(salmonQuant$abundance)[-1],
    condition = gsub('_.*', '', colnames(salmonQuant$abundance)[-1])
)
myDesign

## ----message = TRUE, warning=FALSE--------------------------------------------
### Please note:
# The way of importing files in the following example with
# "system.file("extdata/example.gtf.gz", package="IsoformSwitchAnalyzeR")"" is
# specialiced way of accessing the example data in the IsoformSwitchAnalyzeR package
# and not somhting you need to do - just supply the string e.g.
# isoformExonAnnoation="/myAnnotation/myQuantified.gtf" to the isoformExonAnnoation argument

### Create switchAnalyzeRlist
aSwitchList <- importRdata(
    isoformCountMatrix   = salmonQuant$counts,
    isoformRepExpression = salmonQuant$abundance,
    designMatrix         = myDesign,
    isoformExonAnnoation = system.file("extdata/example.gtf.gz"             , package="IsoformSwitchAnalyzeR"),
    isoformNtFasta       = system.file("extdata/example_isoform_nt.fasta.gz", package="IsoformSwitchAnalyzeR"),
    fixStringTieAnnotationProblem = TRUE,
    showProgress = FALSE
)

## -----------------------------------------------------------------------------
summary(aSwitchList)

## -----------------------------------------------------------------------------
### load example data
data("exampleSwitchList")

### Subset for quick runtime
exampleSwitchList <- subsetSwitchAnalyzeRlist(
    switchAnalyzeRlist = exampleSwitchList,
    subset = abs(exampleSwitchList$isoformFeatures$dIF) > 0.4
)

### Print summary of switchAnalyzeRlist
summary(exampleSwitchList)

## ----results = "hide", message = FALSE, warning=FALSE-------------------------
exampleSwitchList <- isoformSwitchAnalysisPart1(
    switchAnalyzeRlist   = exampleSwitchList,
    # pathToOutput = 'path/to/where/output/should/be/'
    outputSequences      = FALSE, # change to TRUE whan analyzing your own data 
    prepareForWebServers = FALSE  # change to TRUE if you will use webservers for external sequence analysis
)

## -----------------------------------------------------------------------------
extractSwitchSummary( exampleSwitchList )

## -----------------------------------------------------------------------------
# Please note that in the following the part of the examples using
# the "system.file()" command not nesseary when using your own
# data - just supply the path as a string
# (e.g. pathToCPC2resultFile = "/myFiles/myCPC2results.txt" )

exampleSwitchList <- isoformSwitchAnalysisPart2(
  switchAnalyzeRlist        = exampleSwitchList, 
  n                         = 10,    # if plotting was enabled, it would only output the top 10 switches
  removeNoncodinORFs        = TRUE,
  pathToCPC2resultFile      = system.file("extdata/cpc2_result.txt"         , package = "IsoformSwitchAnalyzeR"),
  pathToPFAMresultFile      = system.file("extdata/pfam_results.txt"        , package = "IsoformSwitchAnalyzeR"),
  pathToIUPred2AresultFile  = system.file("extdata/iupred2a_result.txt.gz"  , package = "IsoformSwitchAnalyzeR"),
  pathToSignalPresultFile   = system.file("extdata/signalP_results.txt"     , package = "IsoformSwitchAnalyzeR"),
  outputPlots               = FALSE  # keeps the function from outputting the plots from this example
)

## ----message = FALSE----------------------------------------------------------
extractTopSwitches(exampleSwitchList, filterForConsequences = TRUE, n=3)

## -----------------------------------------------------------------------------
data("exampleSwitchListAnalyzed")

## -----------------------------------------------------------------------------
extractSwitchSummary(
    exampleSwitchListAnalyzed,
    filterForConsequences = TRUE
) 

## -----------------------------------------------------------------------------
subset(
    extractTopSwitches(
        exampleSwitchListAnalyzed,
        filterForConsequences = TRUE,
        n=10,
        inEachComparison = TRUE
    )[,c('gene_name','condition_1','condition_2','gene_switch_q_value','Rank')],
    gene_name == 'ZAK'
)

## ----fig.width=12, fig.height=7, warning=FALSE--------------------------------
switchPlot(
    exampleSwitchListAnalyzed,
    gene='ZAK',
    condition1 = 'COAD_ctrl',
    condition2 = 'COAD_cancer',
    localTheme = theme_bw(base_size = 13) # making text sightly larger for vignette
)

## ----fig.width=9, fig.height=5------------------------------------------------
extractSwitchOverlap(
    exampleSwitchListAnalyzed,
    filterForConsequences=TRUE,
    plotIsoforms = FALSE
)

## ----fig.width=12, fig.height=5-----------------------------------------------
extractConsequenceSummary(
    exampleSwitchListAnalyzed,
    consequencesToAnalyze='all',
    plotGenes = FALSE,           # enables analysis of genes (instead of isoforms)
    asFractionTotal = FALSE      # enables analysis of fraction of significant features
)

## ----fig.width=14, fig.height=5-----------------------------------------------
extractConsequenceEnrichment(
    exampleSwitchListAnalyzed,
    consequencesToAnalyze='all',
    analysisOppositeConsequence = TRUE,
    localTheme = theme_bw(base_size = 14), # Increase font size in vignette
    returnResult = FALSE # if TRUE returns a data.frame with the summary statistics
)

## ----fig.width=12, fig.height=4-----------------------------------------------
extractConsequenceEnrichmentComparison(
    exampleSwitchListAnalyzed,
    consequencesToAnalyze=c('domains_identified','coding_potential'),
    analysisOppositeConsequence = TRUE,
    returnResult = FALSE # if TRUE returns a data.frame with the summary statistics
)

## ----fig.width=9, fig.height=5------------------------------------------------
extractSubCellShifts(
    exampleSwitchListAnalyzed,
    returnResult = FALSE # returns plot instead of data
)

## ----fig.width=9, fig.height=5------------------------------------------------
### Extract shifts
locChange <- extractSubCellShifts(
    exampleSwitchListAnalyzed,
    returnResult = TRUE # returns data insted of plot
)

### Sort
locChange <- locChange[sort.list(
    locChange$n_genes,
    decreasing = TRUE
),]

### View
head(locChange, 3)

## ----fig.width=12, fig.height=4.5---------------------------------------------
extractSplicingEnrichment(
    exampleSwitchListAnalyzed,
    returnResult = FALSE # if TRUE returns a data.frame with the summary statistics
)

## ----fig.width=12, fig.height=4-----------------------------------------------
extractSplicingEnrichmentComparison(
    exampleSwitchListAnalyzed,
    splicingToAnalyze = c('A3','A5','ATSS','ATTS'), # the splicing highlighted above
    returnResult = FALSE # if TRUE returns a data.frame with the results
)

## ----fig.width=8, fig.height=4, warning=FALSE---------------------------------
### Volcano like plot:
ggplot(data=exampleSwitchListAnalyzed$isoformFeatures, aes(x=dIF, y=-log10(isoform_switch_q_value))) +
     geom_point(
        aes( color=abs(dIF) > 0.1 & isoform_switch_q_value < 0.05 ), # default cutoff
        size=1
    ) +
    geom_hline(yintercept = -log10(0.05), linetype='dashed') + # default cutoff
    geom_vline(xintercept = c(-0.1, 0.1), linetype='dashed') + # default cutoff
    facet_wrap( ~ condition_2) +
    #facet_grid(condition_1 ~ condition_2) + # alternative to facet_wrap if you have overlapping conditions
    scale_color_manual('Signficant\nIsoform Switch', values = c('black','red')) +
    labs(x='dIF', y='-Log10 ( Isoform Switch Q Value )') +
    theme_bw()

## ----fig.width=8, fig.height=4, warning=FALSE---------------------------------
### Switch vs Gene changes:
ggplot(data=exampleSwitchListAnalyzed$isoformFeatures, aes(x=gene_log2_fold_change, y=dIF)) +
    geom_point(
        aes( color=abs(dIF) > 0.1 & isoform_switch_q_value < 0.05 ), # default cutoff
        size=1
    ) + 
    facet_wrap(~ condition_2) +
    #facet_grid(condition_1 ~ condition_2) + # alternative to facet_wrap if you have overlapping conditions
    geom_hline(yintercept = 0, linetype='dashed') +
    geom_vline(xintercept = 0, linetype='dashed') +
    scale_color_manual('Signficant\nIsoform Switch', values = c('black','red')) +
    labs(x='Gene log2 fold change', y='dIF') +
    theme_bw()

## -----------------------------------------------------------------------------
### A newly created switchAnalyzeRlist + switch analysis
data("exampleSwitchList")         
names(exampleSwitchList)

## -----------------------------------------------------------------------------
### Preview
head(exampleSwitchList, 2)
# tail(exampleSwitchList, 2)

### Dimentions
dim(exampleSwitchList$isoformFeatures)

nrow(exampleSwitchList)
ncol(exampleSwitchList)
dim(exampleSwitchList)

## -----------------------------------------------------------------------------
exampleSwitchList

### Subset
subsetSwitchAnalyzeRlist(
    exampleSwitchList,
    exampleSwitchList$isoformFeatures$gene_name == 'ARHGEF19'
)

## -----------------------------------------------------------------------------
head(exampleSwitchList$exons,2)

## -----------------------------------------------------------------------------
### Please note
# The way of importing files in the following example with
# "system.file('pathToFile', package="IsoformSwitchAnalyzeR") is
# specialized way of accessing the example data in the IsoformSwitchAnalyzeR package
# and not something  you need to do - just supply the string e.g.
# parentDir = "/mySalmonQuantifications/" pointing to the parent directory (where 
# each sample is a seperate sub-directory) to the function.

### Import Salmon example data in R package
salmonQuant <- importIsoformExpression(
    parentDir = system.file("extdata/", package="IsoformSwitchAnalyzeR"),
    addIsofomIdAsColumn = TRUE
)

## -----------------------------------------------------------------------------
### Make design matrix
myDesign <- data.frame(
    sampleID = colnames(salmonQuant$abundance)[-1],
    condition = gsub('_.*', '', colnames(salmonQuant$abundance)[-1])
)

### Please note
# The way of importing files in the following example with
# "system.file('pathToFile', package="IsoformSwitchAnalyzeR") is
# specialized way of accessing the example data in the IsoformSwitchAnalyzeR package
# and not something  you need to do - just supply the string e.g.:
# isoformExonAnnoation = "/myAnnotations/annotation.gtf".

### Create switchAnalyzeRlist
aSwitchList <- importRdata(
    isoformCountMatrix   = salmonQuant$counts,
    isoformRepExpression = salmonQuant$abundance,
    designMatrix         = myDesign,
    isoformExonAnnoation = system.file("extdata/example.gtf.gz"             , package="IsoformSwitchAnalyzeR"),
    isoformNtFasta       = system.file("extdata/example_isoform_nt.fasta.gz", package="IsoformSwitchAnalyzeR"),
    showProgress = FALSE
)

## -----------------------------------------------------------------------------
head(aSwitchList$isoformFeatures,2)

head(aSwitchList$exons,2)

head(aSwitchList$ntSequence,2)

# Etc...

## -----------------------------------------------------------------------------
### Please note
# The way of importing files in the following example with
#   "system.file('pathToFile', package="IsoformSwitchAnalyzeR") is
#   specialized way of accessing the example data in the IsoformSwitchAnalyzeR package
#   and not something you need to do - just supply the string e.g.
#   parentDir = "individual_quantifications_in_subdir/" to the functions
#   path (e.g. "myAnnotation/isoformsQuantified.gtf") to the isoformExonAnnoation argument

### Prepare data.frame with quant file info
salmonDf <- prepareSalmonFileDataFrame(
    system.file("extdata/drosophila", package="IsoformSwitchAnalyzeR")
)

## -----------------------------------------------------------------------------
### Add conditions
salmonDf$condition <- c('wt','wt','ko','ko')

## -----------------------------------------------------------------------------
aSwitchList <- importSalmonData(
    salmonFileDataFrame = salmonDf, # as created above
    showProgress=FALSE              # For nicer printout in vignette
)

## -----------------------------------------------------------------------------
summary(aSwitchList)

## ----warning=FALSE, message=FALSE---------------------------------------------
aSwitchList <- importGTF(pathToGTF = system.file("extdata/example.gtf.gz", package="IsoformSwitchAnalyzeR"))

## -----------------------------------------------------------------------------
aSwitchList

head(aSwitchList,2)
head(aSwitchList$conditions,2)

## -----------------------------------------------------------------------------
data("exampleSwitchList")

exampleSwitchListFiltered <- preFilter(
    switchAnalyzeRlist = exampleSwitchList,
    geneExpressionCutoff = 1,
    isoformExpressionCutoff = 0,
    removeSingleIsoformGenes = TRUE
)

exampleSwitchListFilteredStrict <- preFilter(
    switchAnalyzeRlist = exampleSwitchList,
    geneExpressionCutoff = 10,
    isoformExpressionCutoff = 3,
    removeSingleIsoformGenes = TRUE
)

## ----warning=FALSE------------------------------------------------------------
# Load example data and pre-filter
data("exampleSwitchList")
exampleSwitchList <- preFilter(exampleSwitchList) # preFilter to remove lowly expressed features

# Perform test
exampleSwitchListAnalyzed <- isoformSwitchTestDEXSeq(
    switchAnalyzeRlist = exampleSwitchList,
    reduceToSwitchingGenes=TRUE
)

# Summarize switching features
extractSwitchSummary(exampleSwitchListAnalyzed)

## ----warning=FALSE------------------------------------------------------------
# Load example data and pre-filter
data("exampleSwitchList")
exampleSwitchList <- preFilter(exampleSwitchList, geneExpressionCutoff = 4) # preFilter for fast runtime

# Perform test (takes ~10 sec)
exampleSwitchListAnalyzed <- isoformSwitchTestSatuRn(
    switchAnalyzeRlist = exampleSwitchList,
    reduceToSwitchingGenes = TRUE
)

# Summarize switching features
extractSwitchSummary(exampleSwitchListAnalyzed)

## ----warning=FALSE------------------------------------------------------------
"orfAnalysis" %in% names( exampleSwitchList )

## -----------------------------------------------------------------------------
### This example relies on the example data from the 'Analyzing Open Reading Frames' section above 

exampleSwitchListAnalyzed <- extractSequence(
    exampleSwitchListAnalyzed, 
    pathToOutput = '<insert_path>',
    writeToFile=FALSE # to avoid output when running this example data
)

## -----------------------------------------------------------------------------
### Please note the way of importing files in the following example with
# "system.file('pathToFile', package="IsoformSwitchAnalyzeR") is
# just a way to accessing the example data in the IsoformSwitchAnalyzeR package
# and not something you need to do - just supply the string e.g.
# "myAnnotation/predicted_annoation.txt" to the function.

### Load test data (matching the external sequence analysis results)
data("exampleSwitchListIntermediary")
exampleSwitchListIntermediary

### Add CPAT analysis
exampleSwitchListAnalyzed <- analyzeCPAT(
    switchAnalyzeRlist   = exampleSwitchListIntermediary,
    pathToCPATresultFile = system.file("extdata/cpat_results.txt", package = "IsoformSwitchAnalyzeR"),
    codingCutoff         = 0.725, # the coding potential cutoff we suggested for human
    removeNoncodinORFs   = TRUE   # because ORF was predicted de novo
)

### Add CPC2 analysis
exampleSwitchListAnalyzed <- analyzeCPC2(
    switchAnalyzeRlist   = exampleSwitchListAnalyzed,
    pathToCPC2resultFile = system.file("extdata/cpc2_result.txt", package = "IsoformSwitchAnalyzeR"),
    removeNoncodinORFs   = TRUE   # because ORF was predicted de novo
)

### Add PFAM analysis
exampleSwitchListAnalyzed <- analyzePFAM(
    switchAnalyzeRlist   = exampleSwitchListAnalyzed,
    pathToPFAMresultFile = system.file("extdata/pfam_results.txt", package = "IsoformSwitchAnalyzeR"),
    showProgress=FALSE
)

### Add SignalP analysis
exampleSwitchListAnalyzed <- analyzeSignalP(
    switchAnalyzeRlist       = exampleSwitchListAnalyzed,
    pathToSignalPresultFile  = system.file("extdata/signalP_results.txt", package = "IsoformSwitchAnalyzeR")
)

### Add IUPred2A analysis
exampleSwitchListAnalyzed <- analyzeIUPred2A(
    switchAnalyzeRlist        = exampleSwitchListAnalyzed,
    pathToIUPred2AresultFile = system.file("extdata/iupred2a_result.txt.gz", package = "IsoformSwitchAnalyzeR"),
    showProgress = FALSE
)

### Add DeepLoc2 analysis
exampleSwitchListAnalyzed <- analyzeDeepLoc2(
    switchAnalyzeRlist = exampleSwitchListAnalyzed,
    pathToDeepLoc2resultFile = system.file("extdata/deeploc2.csv", package = "IsoformSwitchAnalyzeR"),
    quiet = FALSE
)

### Add DeepTMHMM analysis
exampleSwitchListAnalyzed <- analyzeDeepTMHMM(
    switchAnalyzeRlist   = exampleSwitchListAnalyzed,
    pathToDeepTMHMMresultFile = system.file("extdata/DeepTMHMM.gff3", package = "IsoformSwitchAnalyzeR"),
    showProgress=FALSE
)


exampleSwitchListAnalyzed

## -----------------------------------------------------------------------------
### This example relies on the example data from the 'Importing External Sequence Analysis' section above 

exampleSwitchListAnalyzed <- analyzeAlternativeSplicing(
    switchAnalyzeRlist = exampleSwitchListAnalyzed,
    quiet=TRUE
)

### overview of number of intron retentions (IR)
table( exampleSwitchListAnalyzed$AlternativeSplicingAnalysis$IR )

## -----------------------------------------------------------------------------
### This example relies on the example data from the 'Predicting Alternative Splicing' section above 

# the consequences highlighted in the text above
consequencesOfInterest <- c('intron_retention','coding_potential','NMD_status','domains_identified','ORF_seq_similarity')

exampleSwitchListAnalyzed <- analyzeSwitchConsequences(
    exampleSwitchListAnalyzed,
    consequencesToAnalyze = consequencesOfInterest, 
    dIFcutoff = 0.4, # very high cutoff for fast runtimes - you should use the default (0.1)
    showProgress=FALSE
)

extractSwitchSummary(exampleSwitchListAnalyzed, dIFcutoff = 0.4, filterForConsequences = FALSE)
extractSwitchSummary(exampleSwitchListAnalyzed, dIFcutoff = 0.4, filterForConsequences = TRUE)

## -----------------------------------------------------------------------------
### Load already analyzed data
data("exampleSwitchListAnalyzed")

### Let's reduce the switchAnalyzeRlist to only one condition
exampleSwitchListAnalyzedSubset <- subsetSwitchAnalyzeRlist(
    exampleSwitchListAnalyzed, 
    exampleSwitchListAnalyzed$isoformFeatures$condition_1 == 'COAD_ctrl'
)
exampleSwitchListAnalyzedSubset

### Extract top switching genes (by q-value)
extractTopSwitches(
    exampleSwitchListAnalyzedSubset, 
    filterForConsequences = TRUE, 
    n = 2, 
    sortByQvals = TRUE
)

### Extract top 2 switching genes (by dIF values)
extractTopSwitches(
    exampleSwitchListAnalyzedSubset, 
    filterForConsequences = TRUE, 
    n = 2, 
    sortByQvals = FALSE
)

## -----------------------------------------------------------------------------
### Extract data.frame with all switching isoforms
switchingIso <- extractTopSwitches( 
    exampleSwitchListAnalyzedSubset, 
    filterForConsequences = TRUE, 
    n = NA,                  # n=NA: all features are returned
    extractGenes = FALSE,    # when FALSE isoforms are returned
    sortByQvals = TRUE
)

subset(switchingIso, gene_name == 'ZAK')

## ----fig.width=12, fig.height=7-----------------------------------------------
switchPlot(exampleSwitchListAnalyzedSubset, gene = 'ZAK')

## ----fig.width=12, fig.height=3-----------------------------------------------
### exampleSwitchListAnalyzedSubset is created above

switchPlotTranscript(exampleSwitchListAnalyzedSubset, gene = 'ZAK')

## ----fig.width=3, fig.height=3------------------------------------------------
switchPlotGeneExp (exampleSwitchListAnalyzedSubset, gene = 'ZAK')

## ----fig.width=4, fig.height=3------------------------------------------------
switchPlotIsoExp(exampleSwitchListAnalyzedSubset, gene = 'TNFRSF1B')

## ----fig.width=4, fig.height=3------------------------------------------------
switchPlotIsoUsage(exampleSwitchListAnalyzedSubset, gene = 'ZAK')

## -----------------------------------------------------------------------------
data("exampleSwitchListAnalyzed")
exampleSwitchListAnalyzed

## ----fig.width=12, fig.height=5-----------------------------------------------
extractSplicingSummary(
    exampleSwitchListAnalyzed,
    asFractionTotal = FALSE,
    plotGenes=FALSE
)

## ----fig.width=12, fig.height=4.5---------------------------------------------
splicingEnrichment <- extractSplicingEnrichment(
    exampleSwitchListAnalyzed,
    splicingToAnalyze='all',
    returnResult=TRUE,
    returnSummary=TRUE
)

## ----fig.width=12, fig.height=6-----------------------------------------------
subset(splicingEnrichment, splicingEnrichment$AStype == 'ATSS')

## ----fig.width=12, fig.height=4.5---------------------------------------------
extractSplicingEnrichmentComparison(
    exampleSwitchListAnalyzed,
    splicingToAnalyze=c('A3','MES','ATSS'), # Those significant in COAD in the previous analysis
    returnResult=FALSE # Preventing the summary statistics to be returned as a data.frame
)

## ----fig.width=10, fig.height=6-----------------------------------------------
extractSplicingGenomeWide(
    exampleSwitchListAnalyzed,
    featureToExtract = 'all',                 # all isoforms stored in the switchAnalyzeRlist
    splicingToAnalyze = c('A3','MES','ATSS'), # Splice types significantly enriched in COAD
    plot=TRUE,
    returnResult=FALSE  # Preventing the summary statistics to be returned as a data.frame
)

## ----results = "hide", message = FALSE----------------------------------------
### Load example data
data("exampleSwitchListAnalyzed")

### Reduce datasize for fast runtime
selectedGenes <- unique(exampleSwitchListAnalyzed$isoformFeatures$gene_id)[50:100]
exampleSwitchListAnalyzedSubset <- subsetSwitchAnalyzeRlist(
    exampleSwitchListAnalyzed,
    exampleSwitchListAnalyzed$isoformFeatures$gene_id %in% selectedGenes
)

### analyze the biological mechanisms
bioMechanismeAnalysis <- analyzeSwitchConsequences(
    exampleSwitchListAnalyzedSubset, 
    consequencesToAnalyze = c('tss','tts','intron_structure'),
    showProgress = FALSE
)$switchConsequence # only the consequences are interesting here

### subset to those with differences
bioMechanismeAnalysis <- bioMechanismeAnalysis[which(bioMechanismeAnalysis$isoformsDifferent),]

### extract the consequences of interest already stored in the switchAnalyzeRlist
myConsequences <- exampleSwitchListAnalyzedSubset$switchConsequence
myConsequences <- myConsequences[which(myConsequences$isoformsDifferent),]
myConsequences$isoPair <- paste(myConsequences$isoformUpregulated, myConsequences$isoformDownregulated) # id for specific iso comparison

### Obtain the mechanisms of the isoform switches with consequences
bioMechanismeAnalysis$isoPair <- paste(bioMechanismeAnalysis$isoformUpregulated, bioMechanismeAnalysis$isoformDownregulated)
bioMechanismeAnalysis <- bioMechanismeAnalysis[which(bioMechanismeAnalysis$isoPair %in% myConsequences$isoPair),]  # id for specific iso comparison

## ----fig.width=3.5, fig.height=3.5--------------------------------------------
### Create list with the isoPair ids for each consequence
AS   <- bioMechanismeAnalysis$isoPair[ which( bioMechanismeAnalysis$featureCompared == 'intron_structure')]
aTSS <- bioMechanismeAnalysis$isoPair[ which( bioMechanismeAnalysis$featureCompared == 'tss'             )]
aTTS <- bioMechanismeAnalysis$isoPair[ which( bioMechanismeAnalysis$featureCompared == 'tts'             )]

mechList <- list(
    AS=AS,
    aTSS=aTSS,
    aTTS=aTTS
)

### Create Venn diagram
library(VennDiagram)
myVenn <- venn.diagram(
    x = mechList,
    col='transparent',
    alpha=0.4,
    fill=RColorBrewer::brewer.pal(n=3,name='Dark2'),
    filename=NULL
)

### Plot the venn diagram
grid.newpage() ; grid.draw(myVenn)

## -----------------------------------------------------------------------------
myDesign <- data.frame(
    sampleID=1:6,
    condition=c('wt','wt','wt','ko','ko','ko') # WT = wildtype, KO = Knock out
)

myDesign

## -----------------------------------------------------------------------------
myDesign$batch <- factor(c('a','a','b','a','b','b'))
myDesign

## -----------------------------------------------------------------------------
packageVersion('IsoformSwitchAnalyzeR')

sessionInfo()

