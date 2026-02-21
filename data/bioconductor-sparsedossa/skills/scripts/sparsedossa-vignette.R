# Code example from 'sparsedossa-vignette' vignette. See references/ for full tutorial.

## ----load, eval=TRUE, warning=FALSE, results="hide"----------------------
library(sparseDOSSA)

## ----run-sparsedossa-help, eval=TRUE, warning=FALSE, message=FALSE, results="hide"----
?sparseDOSSA 

## ----default-run, eval=TRUE, cache=TRUE, warning=FALSE, message=FALSE, results="hide"----
sparseDOSSA::sparseDOSSA()

## ----input-community, eval=TRUE, cache=TRUE, warning=FALSE, message=FALSE, results="hide"----
n.microbes <- 150
n.samples <- 50
n.metadata <- 2
sparseDOSSA::sparseDOSSA( number_features = n.microbes, 
                          number_samples = n.samples, 
                          number_metadata = n.metadata )

## ----bugmeta, eval=TRUE, cache=TRUE, warning=FALSE, message=FALSE, results="hide"----
sparseDOSSA::sparseDOSSA( spikeStrength = "2.0", spikeCount = "2" )

## ----bugbug, eval=TRUE, cache=TRUE, warning=FALSE, message=FALSE, results="hide"----
sparseDOSSA::sparseDOSSA( runBugBug = TRUE, bugBugCorr = "0.2",
bugs_to_spike = 5 )

## ----output, eval=TRUE, cache=TRUE, warning=FALSE, message=FALSE, results="hide"----
sparseDOSSA::sparseDOSSA( strNormalizedFileName = "my_Microbiome.pcl",
    strCountFileName = "my_Microbiome-Counts.pcl",
    parameter_filename = "my_MicrobiomeParameterFile.txt" )

## ----PRISM, eval=FALSE, cache=TRUE, results="hide"-----------------------
#  n.microbes <- 150
#  n.samples <- 180
#  n.metadata <- 10
#  n.dataset <- 1
#  sparseDOSSA::sparseDOSSA( number_features = n.microbes,
#                            number_samples = n.samples,
#                            number_metadata = n.metadata,
#                            datasetCount = n.dataset )

## ----PRISM-bm, eval=FALSE, cache=TRUE, results="hide"--------------------
#  n.microbes <- 150
#  n.samples <- 180
#  n.metadata <- 10
#  n.dataset <- 1
#  spike.perc <- 0.02
#  sparseDOSSA::sparseDOSSA( number_features = n.microbes,
#                            number_samples = n.samples,
#                            number_metadata = n.metadata,
#                            datasetCount = n.dataset,
#                            percent_spiked =spike.perc  )

## ----PRISM-bb, eval=FALSE, cache=TRUE, results="hide"--------------------
#  n.microbes <- 150
#  n.samples <- 180
#  n.metadata <- 10
#  n.dataset <- 1
#  n.corr <- 10
#  sparseDOSSA::sparseDOSSA( number_features = n.microbes,
#                            number_samples = n.samples,
#                            number_metadata = n.metadata,
#                            datasetCount = n.dataset,
#                            bugs_to_spike = n.corr,
#                            runBugBug = TRUE  )

## ----Metagenomeseq, eval=FALSE, cache=TRUE, results="hide"---------------
#  sparseDOSSA::sparseDOSSA( calibrate = "mice.txt", number_metadata = 1,
#  percent_spiked = 0.2 )

