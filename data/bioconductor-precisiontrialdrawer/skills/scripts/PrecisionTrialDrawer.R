# Code example from 'PrecisionTrialDrawer' vignette. See references/ for full tutorial.

## ----macro, echo=FALSE-----------------------------------------------------
library(BiocStyle)

## ----setup, include=FALSE--------------------------------------------------
# I can measure the timing of all the chunks
knitr::knit_hooks$set(timeit = local({
  now = NULL
  function(before, options) {
    if (before) {
      now <<- Sys.time()
    } else {
      res = difftime(Sys.time(), now)
      now <<- NULL
      # use options$label if you want the chunk label as well
      paste('Time for this code chunk:', as.character(res))
    }
  }})
)

## ----chunk1, echo=TRUE, eval=TRUE , message=FALSE, warning=FALSE , timeit=NULL----
library(PrecisionTrialDrawer)
library(knitr)
data(panelexample)
knitr::kable(panelexample)

## ----chunk2, echo=TRUE , eval=TRUE, message=TRUE, warning=FALSE, timeit=NULL----
mypanel <- newCancerPanel(panelexample)

## ----chunk2_b, echo=FALSE, eval=TRUE, message=TRUE, warning=FALSE, timeit=NULL----
# Keep a copy of this object in this status
mypanel2 <- mypanel

## ----chunk2_h, echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE,timeit=NULL----
#  # Connect to US east coast server
#  # The default is www.ensembl.org
#  mypanel <- newCancerPanel(panelexample , myhost="uswest.ensembl.org")

## ----chunk_rules, timeit=NULL----------------------------------------------
rules <- data.frame(
    drug=c("Erlotinib" , "Erlotinib", "Erlotinib","Erlotinib","Olaparib")
    , gene_symbol=c("EGFR" , "KRAS", "" , "", "")
    , alteration=c("SNV" , "SNV", "" , "", "")
    , exact_alteration=c("amino_acid_variant" , "", "" , "", "")
    , mutation_specification=c("T790M" , "" , "" , "", "")
    , group=c("Driver" , "Driver", "Driver" , "Driver", "Driver")
    , tumor_type=c("luad" , "luad" , "luad" , "coadread","brca")
    , in_out=c("exclude" , "exclude" , "include" , "include" , "include")
    , stringsAsFactors = FALSE
)
knitr::kable(rules)

## ----chunk2_e, echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE,timeit=NULL----
#  mypanel_exclude <- newCancerPanel(panelexample
#                                    , myhost="uswest.ensembl.org"
#                                    , rules = rules)

## ----chunk_rules2, timeit=NULL---------------------------------------------
knitr::kable(rules[1:2 , ])

## ----chunk_rules3, timeit=NULL---------------------------------------------
knitr::kable(rules[3:5 , ])

## ----chunk3, echo=TRUE , eval=FALSE, message=TRUE, warning=FALSE, timeit=NULL----
#  # Check available tumor types
#  knitr::kable( head(showTumorType()) , row.names=FALSE)
#  # Fetch data from breast cancer and lung adenocarcinoma samples
#  mypanel <- getAlterations(mypanel , tumor_type=c("brca" , "luad"))
#  # See the updated slot dataFull for mutations
#  str( cpData(mypanel)$mutations , vec.len = 1)

## ----chunk3_b, echo=FALSE , eval=TRUE, message=TRUE, warning=FALSE,timeit=NULL----
# Check available tumor types
knitr::kable( head(showTumorType()) , row.names=FALSE)
# Fetch data from breast cancer and lung adenocarcinoma samples
data(cpObj)
mypanel <- cpObj
# See the updated slot dataFull for mutations
str( cpData(mypanel)$mutations , vec.len = 1)
rm(cpObj)

## ----sct,echo=TRUE,eval=FALSE,message=FALSE,warning=FALSE,timeit=NULL------
#  # Check available tumor types
#  knitr::kable( showCancerStudy(c("brca","luad")) , row.names = FALSE )
#  # Fetch data from breast cancer and lung adenocarcinoma samples
#  mypanel_alternative <- getAlterations(mypanel
#                          , tumor_type=c("luad_tcga_pan_can_atlas_2018"
#                                         , "brca_tcga_pan_can_atlas_2018"))

## ----chunk4,echo=TRUE,eval=TRUE,message=FALSE,warning=FALSE,timeit=NULL----
# Extract the data from the panel as a toy example.
repos <- lapply(cpData(mypanel) , '[' , c('data' , 'Samples'))
# How custom data should look like
str(repos , vec.len=1)

## ----chunk4_bis,echo=TRUE,eval=FALSE,message=FALSE,warning=FALSE,timeit=NULL----
#  # Use custom data in a new CancerPanel object
#  mypanel_toy <- newCancerPanel(panelexample)
#  mypanel_toy <- getAlterations(mypanel_toy , repos=repos)

## ----chunk4_b,echo=FALSE,eval=TRUE,message=FALSE,warning=FALSE,timeit=NULL----
# Use custom data in a new CancerPanel object
mypanel_toy <- mypanel2
mypanel_toy <- getAlterations(mypanel_toy , repos=repos)

## ----append,echo=TRUE,eval=FALSE,message=FALSE,warning=FALSE,timeit=NULL----
#  # Add two mutations from two different samples for breast cancer
#  newmutations <- data.frame(
#      entrez_gene_id=c(7157 , 7157)
#      ,gene_symbol=c("TP53" , "TP53")
#      ,case_id=c("new_samp1" , "new_samp2")
#      ,mutation_type=c("Nonsense_Mutation" , "Nonsense_Mutation")
#      ,amino_acid_change=c("R306*" , "Y126*")
#      ,genetic_profile_id=c("mynewbreaststudy" , "mynewbreaststudy")
#      ,tumor_type=c("brca" , "brca")
#      ,amino_position=c(306 , 126)
#      ,genomic_position=c("17:7577022:G,A" , "17:7578552:G,C")
#      ,stringsAsFactors=FALSE
#      )
#  newsamples <- c("new_samp1" , "new_samp2")
#  # A dataFull slot style list should look like this
#  toBeAdded <- list(fusions=list(data=NULL , Samples=NULL)
#                   , mutations=list(data=newmutations
#                                    , Samples=list(brca=newsamples))
#                   , copynumber=list(data=NULL , Samples=NULL)
#                   , expression=list(data=NULL , Samples=NULL)
#                   )
#  new_panel <- appendRepo(mypanel_toy , toBeAdded)

## ----filter,echo=TRUE,eval=FALSE,message=FALSE,warning=FALSE,timeit=NULL----
#  # Create a bedfile
#  bed <- data.frame(chr = paste0("chr" , c(7 , 17))
#                    , start = c(140534632 , 41244326)
#                    , end = c(140534732 , 41244426)
#                    , stringsAsFactors=FALSE)
#  knitr::kable(bed , row.names=FALSE)
#  # Apply the filter
#  # You can decide to exclude or keep only the mutations in the bed file
#  new_panel <- filterMutations(mypanel_toy , bed = bed , mode = "exclude")
#  # Filtering can be also tumor-wise
#  new_panel <- filterMutations(mypanel_toy , bed = bed
#                               , mode = "exclude" , tumor_type="brca")

## ----chunk5,echo=FALSE,eval=TRUE,message=FALSE,warning=FALSE,timeit=NULL----
rm(mypanel_toy)
rm(new_panel)

## ----chunk6,echo=TRUE,eval=FALSE,message=FALSE,warning=FALSE,timeit=NULL----
#  # Subset the alterations using panel information
#  mypanel <- subsetAlterations(mypanel)
#  # See the updated slot dataSubset
#  str( cpDataSubset(mypanel) , vec.len = 1)

## ----echo=TRUE,eval=TRUE,message=FALSE,warning=FALSE,timeit=NULL-----------
mypanel_exclude <- mypanel
mypanel_exclude <- subsetAlterations(mypanel_exclude 
                                     , rules=rules)

## ----plot1, echo=TRUE, eval=TRUE , timeit=NULL-----------------------------
coveragePlot(mypanel 
, alterationType=c("mutations" , "expression" , "copynumber" , "fusions")
, grouping="tumor_type")

## ----chunk7 , echo=TRUE , eval=TRUE , timeit=NULL--------------------------
# Same command, but we ask for no plot, just the statistics
covStats <- coveragePlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , grouping="tumor_type" 
             , noPlot=TRUE)
# Proportion of covered samples by at least one alteration
atLeastOne <- covStats$plottedTable[ , 1]/covStats$Samples

## ----plot2 , echo=TRUE , eval=TRUE , timeit=NULL---------------------------
# We add a new grouping variable, 'group'
coveragePlot(mypanel 
            , alterationType=c("mutations" , "expression" 
                               , "copynumber" , "fusions")
            , grouping=c("tumor_type" , "group")
            )

## ----chunk8 , echo=FALSE , eval=TRUE , timeit=NULL-------------------------
# Same command as above, but we ask for no plot, just the statistics
covStats2 <- coveragePlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , grouping=c("tumor_type" , "group")
             , noPlot=TRUE)
# Proportion of covered samples by at least one actionable alteration
atLeastOne2 <- covStats2$plottedTable[ , 1]/covStats2$Samples

## ----plotStack,echo=TRUE,eval=TRUE,timeit=NULL-----------------------------
# the stacked coverage plot requires:
  # 'var' parameter (that selects the bars)
  # 'grouping' parameter (that selects the stratification variable, optional)
  # 'tumor_type' parameter (to select one or more tumor type, optional)
par(mfrow=c(2,1))
coverageStackPlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , var="drug"
             , grouping="gene_symbol"
             , tumor_type="brca"
             )
coverageStackPlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , var="drug"
             , grouping="gene_symbol"
             , tumor_type="luad"
             )

## ----statsStack , echo=FALSE , eval=TRUE, timeit=NULL----------------------
stackStats <- lapply(c("brca" , "luad") , function(x) {
               coverageStackPlot(mypanel
                , alterationType=c("mutations" , "expression" 
                                   , "copynumber" , "fusions")
                , var="drug"
                , grouping="gene_symbol"
                , tumor_type=x
                ,noPlot=TRUE)
              })
freqGene <- lapply(stackStats , function(x) {
  rowSums(x$plottedTable)/x$Samples['all_tumors']})
freqDrug <- lapply(stackStats , function(x) {
  x$plottedTable['Total' , ]/x$Samples['all_tumors']})
names(freqGene) <- c("brca" , "luad")
names(freqDrug) <- c("brca" , "luad")
olaparib <- sapply(freqDrug , '[' , 'Total Olaparib')

## ----plotStackHTML1,echo=TRUE,eval=TRUE,timeit=NULL------------------------
# Add parameter html=TRUE
myHTMLPlot <- coverageStackPlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , var="drug"
             , grouping="gene_symbol"
             , html=TRUE)

## ----plotStackHTML2 , echo=TRUE , eval=FALSE, timeit=NULL------------------
#  # The plot is not displayed immediately to allow the user
#  # to embed it in markdown document or web page
#  # Now run plot
#  plot(myHTMLPlot)

## ----plotStackHTMLshow,echo=FALSE,eval=TRUE,results='asis',timeit=NULL-----
# Print is the actual command that works inside a Rmd
# Plot is the one to use in case you are on a R console
print(myHTMLPlot , tag="chart")

## ----plotStack_exclude,echo=TRUE,eval=TRUE,timeit=NULL---------------------
# First plot with exclude activated, second without
par(mfrow=c(2,1))
coverageStackPlot(mypanel_exclude
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , var="drug"
             , grouping=NA
             , tumor_type="luad"
             )
coverageStackPlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , var="drug"
             , grouping=NA
             , tumor_type="luad"
             )

## ----plot3 , echo=TRUE , eval=TRUE, timeit=NULL----------------------------
# Saturation plot by adding one gene at a time divided by tumor type
saturationPlot(mypanel 
            , alterationType=c("mutations" , "expression" 
                               , "copynumber" , "fusions")
            , grouping="tumor_type"
            , adding="gene_symbol"
            )

## ----chunk9 , echo=TRUE , eval=TRUE, timeit=NULL---------------------------
# As always, we can ask for the statistics with the option noPlot
satStats <- saturationPlot(mypanel
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , grouping="tumor_type"
             , adding="gene_symbol"
             , noPlot=TRUE
             )
# Retrieve all the genes of the panel
panelGenes <- unique( cpArguments(mypanel)$panel$gene_symbol )
# Look for the ones that are not present in the plot with a simple setdiff
missingGenes <- sapply( c("brca" , "luad") , function(x) {
                  setdiff( panelGenes 
                        , satStats[ satStats$grouping==x , "gene_symbol2" ] )
                  })
# Print out
missingGenes

## ----plot4 , echo=TRUE , eval=TRUE, timeit=NULL----------------------------
# Saturation plot by adding one drug at a time divided by tumor type
saturationPlot(mypanel 
            , alterationType=c("mutations" , "expression" 
                               , "copynumber" , "fusions")
            , grouping="tumor_type"
            , adding="drug"
            , y_measure="absolute"
            )

## ----plot5 , echo=TRUE , eval=TRUE , timeit=NULL---------------------------
# One tumor at a time, we draw a stack plot of drug without stratification
par(mfrow=c(2,1))
coverageStackPlot(mypanel , var="drug" 
        , grouping=NA , tumor_type="brca" , collapseByGene=TRUE)
coverageStackPlot(mypanel , var="drug" 
        , grouping=NA , tumor_type="luad" , collapseByGene=TRUE)

## ----parToNormal, echo=FALSE , eval=TRUE, timeit=NULL----------------------
par(mfrow=c(1,1))

## ----plot6 , echo=TRUE , eval=TRUE , timeit=NULL---------------------------
# coocMutexPlot of drug divided by tumor type
coocMutexPlot(mypanel 
     , alterationType=c("mutations" , "expression" , "copynumber" , "fusions")
     , grouping="tumor_type"
     , var="drug")

## ----plot7 , echo=TRUE , eval=TRUE , timeit=NULL---------------------------
# coocMutexPlot of genes divided by tumor type
# To avoid plotting gene pairs with no significance, we set parameter plotrandom
coocMutexPlot(mypanel 
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , grouping="tumor_type"
             , var="gene_symbol"
             , plotrandom=FALSE
             )

## ----plotDendro,echo=TRUE,eval=TRUE, timeit=NULL---------------------------
# coocMutexPlot of drugs divided by tumor type
# Style set to dendro
coocMutexPlot(mypanel 
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , grouping="tumor_type"
             , var="drug"
             , style="dendro"
             )

## ----chunk10,echo=TRUE,eval=TRUE,timeit=NULL-------------------------------
# coocMutexPlot of genes divided by tumor type
coocMutexStats <- coocMutexPlot(mypanel 
             , alterationType=c("mutations" , "expression" 
                                , "copynumber" , "fusions")
             , grouping="tumor_type"
             , var="drug"
             , noPlot=TRUE
             )
knitr::kable(head(coocMutexStats) , digits = 3)

## ----chunkInvisible , echo=FALSE , eval=TRUE , timeit=NULL-----------------
idx <- coocMutexStats$sp1_name=="Idelalisib" & 
  coocMutexStats$sp2_name=="Olaparib" & coocMutexStats$grouping=="brca"
idx2 <- coocMutexStats$sp2_name=="Idelalisib" & 
  coocMutexStats$sp1_name=="Olaparib" & coocMutexStats$grouping=="brca"
olapstats <- coocMutexStats[idx | idx2 , , drop=TRUE]

## ----extract,echo=TRUE,eval=TRUE,timeit=NULL-------------------------------
#Extract mutations from BRCA tumor type
myData <- dataExtractor(mypanel , alterationType = "mutations" 
                        , tumor_type = "brca")
# Check the format
str(myData)

## ----customplot,echo=TRUE,eval=TRUE,timeit=NULL----------------------------
#Extract drug samples couples
dataDrug <- unique(myData$data[ , c("case_id" , "drug")])
# Retrieve all screened samples
samps <- myData$Samples$all_tumors
# Calculate number of drugs per patient (we consider also non altered samples)
drugsPerPatient <- table( factor(dataDrug$case_id , levels = samps) )
# Now in terms of frequency
drugsPerPatientFreq <- table(drugsPerPatient)/length(samps)
# Ready to plot
barplot(drugsPerPatientFreq ,  ylim = c(0,1) 
        , main="Patients with 0, 1, 2... molecular targets" 
        , col="darkcyan")

## ----panOpt , echo=TRUE , eval=FALSE, timeit=NULL--------------------------
#  panOpt <- panelOptimizer(mypanel)

## ----chunkSurv1 , echo=TRUE , eval=TRUE , timeit=NULL----------------------
survPowerSampleSize(mypanel
  , HR = c(0.625 , 0.5 ,  0.4 , 0.3)
  , power = seq(0.6 , 0.9 , 0.1)
  , alpha = 0.05
  , ber = 0.9
  , fu = 3
  , case.fraction = 0.5
  )

## ----chunkSurv2 , echo=TRUE , eval=TRUE , timeit=NULL----------------------
# Add option noPlot to retrieve results as dataframe
sampSize <- survPowerSampleSize(mypanel
  , HR = c(0.625 , 0.5 ,  0.4 , 0.3)
  , power = seq(0.6 , 0.9 , 0.1)
  , alpha = 0.05
  , ber = 0.9
  , fu = 3
  , case.fraction = 0.5
  , noPlot=TRUE
  )
knitr::kable(sampSize[ sampSize$HazardRatio==0.5 , ] , row.names = FALSE)

## ----chunkSurv3 , echo=TRUE , eval=TRUE , timeit=NULL----------------------
# Calculate power from sample size at screening
survPowerSampleSize(mypanel
  , HR = 0.5
  , sample.size = sampSize[ sampSize$HazardRatio==0.5 , "ScreeningSampleSize"]
  , alpha = 0.05
  , ber = 0.9
  , fu = 3
  , case.fraction = 0.5
  )

## ----chunkSurv3invisible , echo=FALSE , eval=TRUE , timeit=NULL------------
# Calculate power from sample size at screening
survSampInv <- survPowerSampleSize(mypanel
  , HR = 0.5
  , sample.size = sampSize[ sampSize$HazardRatio==0.5 , "ScreeningSampleSize"]
  , alpha = 0.05
  , ber = 0.9
  , fu = 3
  , case.fraction = 0.5
  , noPlot=TRUE
  )

## ----chunkSurv4 , echo=TRUE , eval=TRUE , timeit=NULL----------------------
# Calcualte sample size by tumor type
survPowerSampleSize(mypanel
  , var = "tumor_type"
  , HR = c(0.625 , 0.5 ,  0.4 , 0.3)
  , power = seq(0.6 , 0.9 , 0.1)
  , alpha = 0.05
  , ber = 0.9
  , fu = 3
  , case.fraction = 0.5
  )

## ----chunkSurv5 , echo=TRUE , eval=TRUE , timeit=NULL----------------------
# Calcualte sample size by drug
# Visualize only "Olaparib" and "Idelalisib"
survPowerSampleSize(mypanel
  , var = "drug"
  , stratum = c("Olaparib" , "Idelalisib")
  , HR = c(0.625 , 0.5 ,  0.4 , 0.3)
  , power = seq(0.6 , 0.9 , 0.1)
  , alpha = 0.05
  , ber = 0.9
  , fu = 3
  , case.fraction = 0.5
  )

## ----prior1 , echo=TRUE , eval=TRUE , timeit=NULL--------------------------
drugs4 <- c("Idelalisib" , "Olaparib" , "Trastuzumab" , "Vandetanib")
prior4drugs <- survPowerSampleSize(mypanel
  , var = "drug"
  , priority.trial = drugs4 
  , priority.trial.order="optimal"
  , HR = 0.5
  , power = 0.8
  , noPlot = TRUE
  )
prior4drugs

## ----prior2 , echo=TRUE , eval=TRUE , timeit=NULL--------------------------
# We use stratum to create a design with only four drugs
fullDesign <- survPowerSampleSize(mypanel
  , var = "drug"
  , stratum = drugs4
  , HR = 0.5
  , power = 0.8
  , noPlot = TRUE)
knitr::kable(fullDesign)

## ----prior3 , echo=TRUE , eval=TRUE , timeit=NULL--------------------------
sum(fullDesign[fullDesign$Var %in% drugs4 , "ScreeningSampleSize"])

## ----prior4 , echo=TRUE , eval=TRUE , timeit=NULL--------------------------
# Extract the number of samples calculated with priority.trial
sizePrior4Drugs <- prior4drugs[[1]]$Summary["Screened" , "Total"]
# Calculate post-hoc power, given sample.size
postHocPower <- survPowerSampleSize(mypanel
  , var = "drug"
  , stratum = drugs4
  , HR = 0.5
  , sample.size = sizePrior4Drugs
  , noPlot = TRUE)
postHocPower[ postHocPower$Var=="Full Design" , "Power"]

## ----basket1 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
coverageStackPlot(mypanel , var="drug" 
        , grouping=NA , collapseByGene=TRUE)

## ----basket1Hidden , echo=FALSE , eval=TRUE, timeit=NULL-------------------
#we use this to calculate inline stuff
covstackdrug <- coverageStackPlot(mypanel , var="drug" , grouping=NA 
                                  , collapseByGene=TRUE , noPlot=TRUE)

## ----basket2 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
coverageStackPlot(mypanel , var="drug" 
        , grouping=NA , collapseByGene=TRUE 
        , tumor.freqs=c(brca=0.5 , luad=0.5))

## ----basket2Hidden , echo=FALSE , eval=TRUE, timeit=NULL-------------------
covstackdrug2 <- coverageStackPlot(mypanel , var="drug" 
        , grouping=NA , collapseByGene=TRUE 
        , tumor.freqs=c(brca=0.5 , luad=0.5) , noPlot=TRUE)

## ----basket3 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
# Run cpFreq with and withouth tumor.freqs
flatfreq <- cpFreq(mypanel , alterationType = "mutations")
weightedfreq <- cpFreq(mypanel , alterationType = "mutations" 
                       , tumor.freqs=c(brca=0.5 , luad=0.5) )

## ----basket3show1 , echo=TRUE , eval=TRUE , timeit=NULL--------------------
# Frequency with no weights
knitr::kable(flatfreq[ flatfreq$gene_symbol=="PIK3CA" , ] , row.names=FALSE)

## ----basket3show2 , echo=TRUE , eval=TRUE , timeit=NULL--------------------
# Frequency with balanced weights
knitr::kable(weightedfreq[ weightedfreq$gene_symbol=="PIK3CA" , ] 
             , row.names=FALSE)

## ----basket4 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
samplefreqs <- cpFreq(mypanel , alterationType = "mutations" 
                      , tumor.weights=c(brca=50 , luad=40))
knitr::kable(samplefreqs[ samplefreqs$gene_symbol=="PIK3CA" , ] 
             , row.names=FALSE)

## ----basket5 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
# Run cpFreq 20 times
samplefreqsboot <- replicate( 20 
                          , cpFreq(mypanel , alterationType = "mutations" 
                            , tumor.weights=c(brca=50 , luad=40)) 
                          , simplify=FALSE)
# Extract PIK3CA frequency in the 20 runs
pik3caboot <- sapply(samplefreqsboot , function(x) {
  x[x$gene_symbol=="PIK3CA" , "freq"]})

## ----basket6 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
# calculate mean and sd of PIK3CA frequency distribution
avgpik3ca <- mean(pik3caboot)
sdpik3ca <- sd(pik3caboot)
# Plot the distribution
title <- paste("PIK3CA frequency distribution with 50 BRCA and 40 LUAD samples"
              , paste("Mean:" , round(avgpik3ca , 3))
              , paste("SD:" , round(sdpik3ca , 3))
              , sep="\n")
# draw a simple histogram. the red line shows the mean value
hist(pik3caboot , col="cadetblue" , breaks=30 
     , main=title , xlab="Frequencies of resampling")
abline(v = avgpik3ca , col="red" , lwd=3 , xpd=FALSE)

## ----basket7 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
# Write a simple function to calculate confidence interval of a proportion
CI <- function(x){
  left <- quantile(x , 0.025)
  right <- quantile(x , 0.975)
  return(c(left , right))
}
# Create a small data.frame to summarize everything
pik3caSummary <- data.frame(Gene = "PIK3CA"
          , AverageMutationRate = round(avgpik3ca , 3)
          , SDMutationRate = round(sdpik3ca , 3)
          , MaxMutationRate = round(max(pik3caboot)[1] , 3)
          , MinMutationRate = round(min(pik3caboot)[1] , 3)
          , CI = paste( round( CI(pik3caboot) , 3) , collapse=" - "))
knitr::kable(pik3caSummary , row.names=FALSE)

## ----basket8 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
# We want to know how many samples we will need under
  # HR = 2
  # power = 0.8
survboot <- replicate( 10 
                    , survPowerSampleSize(mypanel 
                            , var="gene_symbol"
                            , alterationType = "mutations"
                            , HR=2
                            , power=0.8
                            , tumor.weights=c(brca=50 , luad=40)
                            , noPlot=TRUE)
                    , simplify=FALSE)
# Extract PIK3CA results
survbootpik3ca <- sapply(survboot , function(x) {
  x[ x$Var=="PIK3CA" , "ScreeningSampleSize"]} )

## ----basket9 , echo=TRUE , eval=TRUE , timeit=NULL-------------------------
# Create a small data.frame to summarize 
# everything (we round up to integer values)
survSummary <- data.frame(Gene = "PIK3CA"
            , Mean.Screen.Samp.Size = round(mean(survbootpik3ca))
            , SD.Screen.Samp.Size = round(sd(survbootpik3ca))
            , Max.Screen.Samp.Size = round(max(survbootpik3ca)[1])
            , Min.Screen.Samp.Size = round(min(survbootpik3ca)[1])
            , CI = paste( round( CI(survbootpik3ca)) , collapse=" - "))
knitr::kable(survSummary , row.names=FALSE)

## ----chunk11 , echo=TRUE , eval=FALSE , message=FALSE, timeit=NULL---------
#  # Design our panel in full with no padding
#  # length and merge window equal to 100 bp
#  mydesign <- panelDesigner(mypanel
#                          , padding_length=0
#                          , merge_window=100)

## ----chunk11_bis , echo=FALSE , eval=TRUE , message=FALSE, timeit=NULL-----
# Design our panel in full with no padding 
# length and merge window equal to 100 bp
data(cpDesign)
mydesign <- cpDesign
str(mydesign , vec.len=1)

## ----chunk12 , echo=TRUE , eval=TRUE , message=FALSE, timeit=NULL----------
# Retrieve the panel in bed format
bedPanel <- mydesign$BedStylePanel
head(bedPanel)

## ----chunk12_bis , echo=TRUE , eval=TRUE , message=FALSE, timeit=NULL------
# Calculate genomic space in kilo bases
sum( bedPanel$end - bedPanel$start )/100

## ----chunk13 , echo=TRUE , eval=FALSE , message=FALSE, timeit=NULL---------
#  # Design the panel for mutations
#  myMutationDesign <- panelDesigner(mypanel
#                          , alterationType="mutations"
#                          , padding_length=0
#                          , merge_window=100)

## ----info,echo=TRUE,eval=TRUE, timeit=NULL---------------------------------
sessionInfo()

