# TL;DR

This code block is not evaluated. Need a breakdown? Look at the following sections.

```
suppressWarnings(suppressMessages(require(netDx)))
suppressWarnings(suppressMessages(library(curatedTCGAData)))

# fetch data remotely
brca <- suppressMessages(curatedTCGAData("BRCA",c("mRNAArray"),FALSE))

# process input variables
staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
staget <- suppressWarnings(as.integer(staget))
colData(brca)$STAGE <- staget

pam50 <- colData(brca)$PAM50.mRNA
pam50[which(!pam50 %in% "Luminal A")] <- "notLumA"
pam50[which(pam50 %in% "Luminal A")] <- "LumA"
colData(brca)$pam_mod <- pam50

tmp <- colData(brca)$PAM50.mRNA
idx <- union(which(tmp %in% c("Normal-like","Luminal B","HER2-enriched")),
                    which(is.na(staget)))
pID <- colData(brca)$patientID
tokeep <- setdiff(pID, pID[idx])
brca <- brca[,tokeep,]

smp <- sampleMap(brca)
samps <- smp[which(smp$assay=="BRCA_mRNAArray-20160128"),]
# remove duplicate assays mapped to the same sample
notdup <- samps[which(!duplicated(samps$primary)),"colname"]
brca[[1]] <- suppressMessages(brca[[1]][,notdup])

# colData must have ID and STATUS columns
pID <- colData(brca)$patientID
colData(brca)$ID <- pID
colData(brca)$STATUS <- colData(brca)$pam_mod

# create grouping rules
groupList <- list()
# genes in mRNA data are grouped by pathways
pathList <- readPathways(fetchPathwayDefinitions("January",2018))
groupList[["BRCA_mRNAArray-20160128"]] <- pathList[1:3]
# clinical data is not grouped; each variable is its own feature
groupList[["clinical"]] <- list(
      age="patient.age_at_initial_pathologic_diagnosis",
       stage="STAGE"
)

# create function to tell netDx how to build features (PSN) from your data
makeNets <- function(dataList, groupList, netDir,...) {
    netList <- c() # initialize before is.null() check
    # make RNA nets (NOTE: the check for is.null() is important!)
    # (Pearson correlation)
    if (!is.null(groupList[["BRCA_mRNAArray-20160128"]])) {
    netList <- makePSN_NamedMatrix(dataList[["BRCA_mRNAArray-20160128"]],
                rownames(dataList[["BRCA_mRNAArray-20160128"]]),
                groupList[["BRCA_mRNAArray-20160128"]],
                netDir,verbose=FALSE,
                writeProfiles=TRUE,...)
    }

    # make clinical nets (normalized difference)
    netList2 <- c()
    if (!is.null(groupList[["clinical"]])) {
    netList2 <- makePSN_NamedMatrix(dataList$clinical,
        rownames(dataList$clinical),
        groupList[["clinical"]],netDir,
        simMetric="custom",customFunc=normDiff, # custom function
        writeProfiles=FALSE,
        sparsify=TRUE,verbose=TRUE,...)
    }
    netList <- c(unlist(netList),unlist(netList2))
    return(netList)
}

# run predictor
set.seed(42) # make results reproducible
outDir <- paste(tempdir(),randAlphanumString(),
    "pred_output",sep=getFileSep())
# To see all messages, remove suppressMessages() and set logging="default".
# To keep all intermediate data, set keepAllData=TRUE
out <- buildPredictor(
      dataList=brca,groupList=groupList,
      makeNetFunc=makeNets,
      outDir=outDir, ## netDx requires absolute path
      numSplits=2L,featScoreMax=2L, featSelCutoff=1L,
      numCores=1L,logging="none",
      keepAllData=FALSE,debugMode=TRUE
   )

# collect results
numSplits <- 2
st <- unique(colData(brca)$STATUS)
acc <- c()         # accuracy
predList <- list() # prediction tables
featScores <- list() # feature scores per class
for (cur in unique(st)) featScores[[cur]] <- list()

for (k in 1:numSplits) {
    pred <- out[[sprintf("Split%i",k)]][["predictions"]];
    # predictions table
    tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
                     sprintf("%s_SCORE",st))]
    predList[[k]] <- tmp
    # accuracy
    acc <- c(acc, sum(tmp$PRED==tmp$STATUS)/nrow(tmp))
    # feature scores
    for (cur in unique(st)) {
       tmp <- out[[sprintf("Split%i",k)]][["featureScores"]][[cur]]
       colnames(tmp) <- c("PATHWAY_NAME","SCORE")
       featScores[[cur]][[sprintf("Split%i",k)]] <- tmp
    }
}

# plot ROC and PR curve, compute AUROC, AUPR
predPerf <- plotPerf(predList, predClasses=st)
# get table of feature scores for each split and patient label
featScores2 <- lapply(featScores, getNetConsensus)
# identify features that consistently perform well
featSelNet <- lapply(featScores2, function(x) {
    callFeatSel(x, fsCutoff=1, fsPctPass=0)
})

# prepare data for EnrichmentMap plotting of top-scoring features
Emap_res <- getEMapInput_many(featScores2,pathList,
    minScore=1,maxScore=2,pctPass=0,out$inputNets,verbose=FALSE)
gmtFiles <- list()
nodeAttrFiles <- list()

for (g in names(Emap_res)) {
    outFile <- paste(outDir,sprintf("%s_nodeAttrs.txt",g),sep=getFileSep())
    write.table(Emap_res[[g]][["nodeAttrs"]],file=outFile,
        sep="\t",col=TRUE,row=FALSE,quote=FALSE)
    nodeAttrFiles[[g]] <- outFile

    outFile <- paste(outDir,sprintf("%s.gmt",g),sep=getFileSep())
    conn <- suppressWarnings(
         suppressMessages(base::file(outFile,"w")))
    tmp <- Emap_res[[g]][["featureSets"]]
    gmtFiles[[g]] <- outFile

    for (cur in names(tmp)) {
        curr <- sprintf("%s\t%s\t%s", cur,cur,
            paste(tmp[[cur]],collapse="\t"))
        writeLines(curr,con=conn)
    }
close(conn)
}

# This step requires Cytoscape to be installed and running.
###plotEmap(gmtFiles[[1]],nodeAttrFiles[[1]],
###         groupClusters=TRUE, hideNodeLabels=TRUE)

# collect data for integrated PSN
featScores2 <- lapply(featScores, getNetConsensus)
featSelNet <- lapply(featScores2, function(x) {
    callFeatSel(x, fsCutoff=2, fsPctPass=1)
})
topPath <- gsub(".profile","",
        unique(unlist(featSelNet)))
topPath <- gsub("_cont.txt","",topPath)
# create groupList limited to top features
g2 <- list();
for (nm in names(groupList)) {
    cur <- groupList[[nm]]
    idx <- which(names(cur) %in% topPath)
    message(sprintf("%s: %i pathways", nm, length(idx)))
    if (length(idx)>0) g2[[nm]] <- cur[idx]
}

# calculates integrated PSN, calculates grouping statistics,
# and plots integrates PSN. Set plotCytoscape=TRUE if Cytoscape is running.
psn <- suppressMessages(
   plotIntegratedPatientNetwork(brca,
  groupList=g2, makeNetFunc=makeNets,
  aggFun="MEAN",prune_X=0.30,prune_useTop=TRUE,
  numCores=1L,calcShortestPath=TRUE,
  showStats=FALSE,
  verbose=FALSE, plotCytoscape=FALSE)
)

# Visualize integrated patient similarity network as a tSNE plot
tsne <- plot_tSNE(psn$patientSimNetwork_unpruned,colData(brca))
```

# Introduction

In this example, we will build a binary breast tumour classifier from clinical data and gene expression data. We will use different rules to create features for each data layer. Specifically:

* Clinical data: Features are defined directly at the level of *variables*; similarity is defined by normalized difference.
* Gene expression data: Features are defined at the level of *pathways*; similarity is defined by pairwise Pearson correlation.

Feature scoring is performed over multiple random splits of the data into train and blind test partitions. Feature selected networks are those that consistently score highly across the multiple splits (e.g. those that score 9 out of 10 in >=70% of splits).

Conceptually, this is what the higher-level logic looks like for a cross-validation design. In the pseudocode example below, the predictor runs for 100 train/test splits. Within a split, features are scored from 0 to 10. Features scoring >=9 are used to predict labels on the held-out test set (20%).

*(Note: these aren't real function calls; this block just serves to illustrate the concept of the design for our purposes)*

```
numSplits <- 100     # num times to split data into train/blind test samples
featScoreMax <- 10   # num folds for cross-validation, also max score for a network
featSelCutoff <- 9
netScores <- list()  # collect <numSplits> set of netScores
perf <- list()       # collect <numSplits> set of test evaluations

for k in 1:numSplits
 [train, test] <- splitData(80:20) # split data using RNG seed
  featScores[[k]] <- scoreFeatures(train, featScoreMax)
 topFeat[[k]] <- applyFeatCutoff(featScores[[k]])
 perf[[k]] <- collectPerformance(topFeat[[k]], test)
end
```

# Setup

```
suppressWarnings(suppressMessages(require(netDx)))
```

# Data

In this example, we use curated data from The Cancer Genome Atlas, through the BioConductor `curatedTCGAData` package. The goal is to classify a breast tumour into either a Luminal A subtype or otherwise. The predictor will integrate clinical variables selected by the user, along with gene expression data.

Here we load the required packages and download clinical and gene expression data.

```
suppressMessages(library(curatedTCGAData))
```

Take a look at the available data without downloading any:

```
curatedTCGAData(diseaseCode="BRCA", assays="*",dry.run=TRUE)
```

```
##                                         Title DispatchClass
## 31                       BRCA_CNASeq-20160128           Rda
## 32                       BRCA_CNASNP-20160128           Rda
## 33                       BRCA_CNVSNP-20160128           Rda
## 35             BRCA_GISTIC_AllByGene-20160128           Rda
## 36                 BRCA_GISTIC_Peaks-20160128           Rda
## 37     BRCA_GISTIC_ThresholdedByGene-20160128           Rda
## 39  BRCA_Methylation_methyl27-20160128_assays        H5File
## 40      BRCA_Methylation_methyl27-20160128_se           Rds
## 41 BRCA_Methylation_methyl450-20160128_assays        H5File
## 42     BRCA_Methylation_methyl450-20160128_se           Rds
## 43                 BRCA_miRNASeqGene-20160128           Rda
## 44                    BRCA_mRNAArray-20160128           Rda
## 45                     BRCA_Mutation-20160128           Rda
## 46              BRCA_RNASeq2GeneNorm-20160128           Rda
## 47                   BRCA_RNASeqGene-20160128           Rda
## 48                    BRCA_RPPAArray-20160128           Rda
```

We will work only with the mRNA data in this example:

```
brca <- suppressMessages(curatedTCGAData("BRCA",c("mRNAArray"),FALSE))
```

This next code block prepares the TCGA data. In practice you would do this once, and save the data before running netDx, but we run it here to see an end-to-end example.

```
staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
staget <- suppressWarnings(as.integer(staget))
colData(brca)$STAGE <- staget

pam50 <- colData(brca)$PAM50.mRNA
pam50[which(!pam50 %in% "Luminal A")] <- "notLumA"
pam50[which(pam50 %in% "Luminal A")] <- "LumA"
colData(brca)$pam_mod <- pam50

tmp <- colData(brca)$PAM50.mRNA
idx <- union(which(tmp %in% c("Normal-like","Luminal B","HER2-enriched")),
                    which(is.na(staget)))
pID <- colData(brca)$patientID
tokeep <- setdiff(pID, pID[idx])
brca <- brca[,tokeep,]

# remove duplicate assays mapped to the same sample
smp <- sampleMap(brca)
samps <- smp[which(smp$assay=="BRCA_mRNAArray-20160128"),]
notdup <- samps[which(!duplicated(samps$primary)),"colname"]
brca[[1]] <- suppressMessages(brca[[1]][,notdup])
```

```
## harmonizing input:
##   removing 44 sampleMap rows with 'colname' not in colnames of experiments
```

The important thing is to create `ID` and `STATUS` columns in the sample metadata table. netDx uses these to get the patient identifiers and labels, respectively.

```
pID <- colData(brca)$patientID
colData(brca)$ID <- pID
colData(brca)$STATUS <- colData(brca)$pam_mod
```

# Design custom patient similarity networks (features)

netDx allows the user to define a custom function that takes patient data and variable groupings as input, and returns a set of patient similarity networks (PSN) as output. The user can customize what datatypes are used, how they are grouped, and what defines patient similarity for a given datatype.

When running the predictor (next section), the user simply passes this custom function as an input variable; i.e. the `makeNetFunc` parameter when calling `buildPredictor()`.

***Note:*** While netDx provides a high degree of flexibility in achieving your design of choice, it is up to the user to ensure that the design, i.e. the similarity metric and variable groupings, is appropriate for your application. Domain knowledge is almost likely required for good design.

netDx requires that this function take some generic parameters as input. These include:

* `dataList`: the patient data, provided as a `MultiAssayExperiment` object. Refer to the [tutorials for MultiAssayExperiment](https://bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html) to see how to construct those objects from data.
* `groupList`: sets of input data that would correspond to individual networks (e.g. genes grouped into pathways)
* `netDir`: the directory where the resulting PSN would be stored.

## dataList

Here the BRCA data is already provided to us as a `MultiAssayExperiment` object:

```
summary(brca)
```

```
##               Length                Class                 Mode
##                    1 MultiAssayExperiment                   S4
```

## groupList

This object tells the predictor how to group units when constructing a network. For examples, genes may be grouped into a network representing a pathway. This object is a list; the names match those of `dataList` while each value is itself a list and reflects a potential network.

```
groupList <- list()

# genes in mRNA data are grouped by pathways
pathList <- readPathways(fetchPathwayDefinitions("January",2018))
```

```
## ---------------------------------------
```

```
## Fetching http://download.baderlab.org/EM_Genesets/January_01_2018/Human/symbol/Human_AllPathways_January_01_2018_symbol.gmt
```

```
## adding rname 'http://download.baderlab.org/EM_Genesets/January_01_2018/Human/symbol/Human_AllPathways_January_01_2018_symbol.gmt'
```

```
## File: 31d166b24893_Human_AllPathways_January_01_2018_symbol.gmt
```

```
## Read 3028 pathways in total, internal list has 3009 entries
```

```
##  FILTER: sets with num genes in [10, 200]
```

```
##    => 971 pathways excluded
##    => 2038 left
```

```
groupList[["BRCA_mRNAArray-20160128"]] <- pathList[1:3]
# clinical data is not grouped; each variable is its own feature
groupList[["clinical"]] <- list(
      age="patient.age_at_initial_pathologic_diagnosis",
       stage="STAGE"
)
```

So the `groupList` variable has one entry per data *layer*:

```
summary(groupList)
```

```
##                         Length Class  Mode
## BRCA_mRNAArray-20160128 3      -none- list
## clinical                2      -none- list
```

Each entry contains a list, with one entry per feature. Here we have 3 pathway-level features for mRNA and two variable-level features for clinical data.

For example, here are the networks to be created with RNA data. Genes corresponding to pathways are to be grouped into individual network. Such a groupList would create pathway-level networks:

```
groupList[["BRCA_mRNAArray-20160128"]][1:3]
```

```
## $UREA_CYCLE
##  [1] "SLC25A15" "CPS1"     "ASL"      "ARG2"     "SLC25A2"  "OTC"
##  [7] "NMRAL1"   "NAGS"     "ASS1"     "ARG1"
##
## $`CDP-DIACYLGLYCEROL_BIOSYNTHESIS_I`
##  [1] "AGPAT1" "GPD2"   "ABHD5"  "GPAT2"  "CDS1"   "LPCAT3" "LPCAT4" "CDS2"
##  [9] "AGPAT6" "AGPAT5" "MBOAT7" "AGPAT9" "LCLAT1" "MBOAT2" "AGPAT4" "GPAM"
## [17] "AGPAT3" "AGPAT2"
##
## $`SUPERPATHWAY_OF_D-_I_MYO__I_-INOSITOL__1,4,5_-TRISPHOSPHATE_METABOLISM`
##  [1] "IPMK"   "INPP5B" "INPP5F" "INPP5D" "MINPP1" "INPP5A" "ITPKA"  "OCRL"
##  [9] "ITPKC"  "ITPKB"  "SYNJ2"  "INPP5J" "INPP5K" "PTEN"   "IMPA2"  "INPP1"
## [17] "SYNJ1"  "INPPL1" "IMPA1"  "IMPAD1"
```

For clinical data, we want to keep each variable as its own network:

```
head(groupList[["clinical"]])
```

```
## $age
## [1] "patient.age_at_initial_pathologic_diagnosis"
##
## $stage
## [1] "STAGE"
```

## Define patient similarity for each network

This function is defined by the user and tells the predictor how to create networks from the provided input data.

This function requires `dataList`,`groupList`, and `netDir` as input variables. The residual `...` parameter is to pass additional variables to `makePSN_NamedMatrix()`, notably `numCores` (number of parallel jobs).

In this particular example, the custom similarity function does the following:

1. Creates *pathway-level networks from RNA* data using the default Pearson correlation measure `makePSN_NamedMatrix(writeProfiles=TRUE,...)`
2. Creates *variable-level networks from clinical* data using a custom similarity function of normalized difference: `makePSN_NamedMatrix(writeProfiles=FALSE,simMetric="custom",customFunc=normDiff)`.

```
makeNets <- function(dataList, groupList, netDir,...) {
    netList <- c() # initialize before is.null() check
    # make RNA nets (NOTE: the check for is.null() is important!)
    # (Pearson correlation)
    if (!is.null(groupList[["BRCA_mRNAArray-20160128"]])) {
    netList <- makePSN_NamedMatrix(dataList[["BRCA_mRNAArray-20160128"]],
                rownames(dataList[["BRCA_mRNAArray-20160128"]]),
                groupList[["BRCA_mRNAArray-20160128"]],
                netDir,verbose=FALSE,
                writeProfiles=TRUE,...)
    }

    # make clinical nets (normalized difference)
    netList2 <- c()
    if (!is.null(groupList[["clinical"]])) {
    netList2 <- makePSN_NamedMatrix(dataList$clinical,
        rownames(dataList$clinical),
        groupList[["clinical"]],netDir,
        simMetric="custom",customFunc=normDiff, # custom function
        writeProfiles=FALSE,
        sparsify=TRUE,verbose=TRUE,...)
    }
    netList <- c(unlist(netList),unlist(netList2))
    return(netList)
}
```

**Note:** `dataList` and `groupList` are generic containers that can contain whatever object the user requires to create PSN. **The custom function gives the user complete flexibility in feature design**.

# Build predictor

Finally we call the function that runs the netDx predictor. We provide:

* number of train/test splits over which to collect feature scores and average performance: `numSplits`,
* maximum score for features in one round of feature selection (`featScoreMax`, set to 10)
* threshold to call feature-selected networks for each train/test split (`featSelCutoff`); only features scoring this value or higher will be used to classify test patients, and
* the information to create the PSN, including patient data (`dataList`), how variables are to be grouped into networks (`groupList`) and the custom function to generate features (`makeNetFunc`).

Change `numCores` to match the number of cores available on your machine for
parallel processing.

The call below runs 2 train/test splits. Within each split, it:

* splits data into train/test using the default split of 80:20
* score2 networks between 0 to 2 (i.e. `featScoreMax=2`)
* uses networks that score >=1 out of 2 (`featSelCutoff`) to classify test samples for that split.

These are unrealistically low values set so the example will run fast. In practice a good starting point is `featScoreMax=10`, `featSelCutoff=9` and `numSplits=100`, but these parameters depend on the sample sizes in the dataset and heterogeneity of the samples.

```
set.seed(42) # make results reproducible
outDir <- paste(tempdir(),randAlphanumString(),
    "pred_output",sep=getFileSep())
# set keepAllData=TRUE to not delete at the end of the predictor run.
# This can be useful for debugging.
out <- buildPredictor(
      dataList=brca,groupList=groupList,
      makeNetFunc=makeNets,
      outDir=outDir, ## netDx requires absolute path
      numSplits=2L,featScoreMax=2L,
      featSelCutoff=1L,
      numCores=1L,debugMode=TRUE,
      logging="none")
```

```
## Predictor started at:
```

```
## 2020-10-13 23:15:38
```

```
## Pearson similarity chosen - enforcing min. 5 patients per net.
```

```
## adding rname 'http://download.baderlab.org/netDx/java8/genemania-netdx.jar'
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/profiles/1.1.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/INTERACTIONS/1.1.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/profiles/1.2.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/INTERACTIONS/1.2.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/profiles/1.3.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/INTERACTIONS/1.3.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/1.synonyms -keepAllTies -limitTies
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.mediator.lucene.exporter.Generic2LuceneExporter /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/db.cfg /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/colours.txt
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.apps.CacheBuilder -cachedir cache -indexDir . -networkDir /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/INTERACTIONS -log /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/tmp/test.log
```

```
##  Scoring features
```

```
## Java 8 detected
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/GM_results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/GM_results/CV_1.query /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/GM_results/CV_2.query --netdx-flag true
```

```
## QueryRunner time taken: 2.1 s
```

```
##  Scoring features
```

```
## Java 8 detected
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/GM_results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/GM_results/CV_1.query /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/GM_results/CV_2.query --netdx-flag true
```

```
## QueryRunner time taken: 1.6 s
```

```
## Pearson similarity chosen - enforcing min. 5 patients per net.
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/profiles/1.1.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/INTERACTIONS/1.1.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/profiles/1.2.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/INTERACTIONS/1.2.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/profiles/1.3.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/INTERACTIONS/1.3.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.mediator.lucene.exporter.Generic2LuceneExporter /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/db.cfg /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/colours.txt
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.apps.CacheBuilder -cachedir cache -indexDir . -networkDir /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/INTERACTIONS -log /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/tmp/test.log
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/LumA/LumA_query --netdx-flag true
```

```
## Pearson similarity chosen - enforcing min. 5 patients per net.
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/profiles/1.1.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/INTERACTIONS/1.1.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/profiles/1.2.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/INTERACTIONS/1.2.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/profiles/1.3.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/INTERACTIONS/1.3.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.mediator.lucene.exporter.Generic2LuceneExporter /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/db.cfg /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/colours.txt
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.apps.CacheBuilder -cachedir cache -indexDir . -networkDir /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/INTERACTIONS -log /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/tmp/test.log
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng1/notLumA/notLumA_query --netdx-flag true
```

```
## Pearson similarity chosen - enforcing min. 5 patients per net.
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/profiles/1.1.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/INTERACTIONS/1.1.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/profiles/1.2.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/INTERACTIONS/1.2.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/profiles/1.3.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/INTERACTIONS/1.3.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/1.synonyms -keepAllTies -limitTies
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.mediator.lucene.exporter.Generic2LuceneExporter /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/db.cfg /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/colours.txt
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.apps.CacheBuilder -cachedir cache -indexDir . -networkDir /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/INTERACTIONS -log /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/tmp/test.log
```

```
##  Scoring features
```

```
## Java 8 detected
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/GM_results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/GM_results/CV_1.query /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/GM_results/CV_2.query --netdx-flag true
```

```
## QueryRunner time taken: 1.5 s
```

```
##  Scoring features
```

```
## Java 8 detected
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/GM_results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/GM_results/CV_1.query /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/GM_results/CV_2.query --netdx-flag true
```

```
## QueryRunner time taken: 1.6 s
```

```
## Pearson similarity chosen - enforcing min. 5 patients per net.
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/profiles/1.1.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/INTERACTIONS/1.1.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/profiles/1.2.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/INTERACTIONS/1.2.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/profiles/1.3.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/INTERACTIONS/1.3.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.mediator.lucene.exporter.Generic2LuceneExporter /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/db.cfg /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/colours.txt
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.apps.CacheBuilder -cachedir cache -indexDir . -networkDir /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/INTERACTIONS -log /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/tmp/test.log
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/LumA/LumA_query --netdx-flag true
```

```
## Pearson similarity chosen - enforcing min. 5 patients per net.
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/profiles/1.1.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/INTERACTIONS/1.1.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/profiles/1.2.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/INTERACTIONS/1.2.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## Making Java call
```

```
## java -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.core.evaluation.ProfileToNetworkDriver -proftype continuous -cor PEARSON -threshold off -maxmissing 100.0 -in /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/profiles/1.3.profile -out /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/INTERACTIONS/1.3.txt -syn /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/1.synonyms -keepAllTies -limitTies
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.mediator.lucene.exporter.Generic2LuceneExporter /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/db.cfg /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/colours.txt
```

```
## java -Xmx10G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.engine.apps.CacheBuilder -cachedir cache -indexDir . -networkDir /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/INTERACTIONS -log /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/tmp/test.log
```

```
## java -d64 -Xmx4G -cp /home/biocbuild/.cache/netDx/31d1242a907b_genemania-netdx.jar org.genemania.plugin.apps.QueryRunner --data /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/dataset --in flat --out flat --threads 1 --results /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA /tmp/RtmpX57lMG/QEAYJ1252R/pred_output/rng2/notLumA/notLumA_query --netdx-flag true
```

```
## Predictor completed at:
```

```
## 2020-10-13 23:19:31
```

# Examine output

The results are stored in the list object returned by the `buildPredictor()` call.
This list contains:

* `inputNets`: all input networks that the model started with.
* `Split<i>`: a list with results for each train-test split
  + `predictions`: real and predicted labels for test patients
  + `accuracy`: percent accuracy of predictions
  + `featureScores`: feature scores for each label (list with `g` entries, where `g` is number of patient labels). Each entry contains the feature selection scores for the corresponding label.
  + `featureSelected`: vector of features that pass feature selection. List of length `g`, with one entry per label.

```
summary(out)
```

```
##           Length Class  Mode
## inputNets 10     -none- character
## Split1     4     -none- list
## Split2     4     -none- list
```

```
summary(out$Split1)
```

```
##                 Length Class      Mode
## featureScores      2   -none-     list
## featureSelected    2   -none-     list
## predictions     2692   data.frame list
## accuracy           1   -none-     numeric
```

## Reformat results for further analysis

This code collects different components of model output to examine the results.

```
numSplits <- 2
st <- unique(colData(brca)$STATUS)
acc <- c()         # accuracy
predList <- list() # prediction tables

featScores <- list() # feature scores per class
for (cur in unique(st)) featScores[[cur]] <- list()

for (k in 1:numSplits) {
    pred <- out[[sprintf("Split%i",k)]][["predictions"]];
    # predictions table
    tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
                     sprintf("%s_SCORE",st))]
    predList[[k]] <- tmp
    # accuracy
    acc <- c(acc, sum(tmp$PRED==tmp$STATUS)/nrow(tmp))
    # feature scores
    for (cur in unique(st)) {
       tmp <- out[[sprintf("Split%i",k)]][["featureScores"]][[cur]]
       colnames(tmp) <- c("PATHWAY_NAME","SCORE")
       featScores[[cur]][[sprintf("Split%i",k)]] <- tmp
    }
}
```

## Compute model performance

After compiling the data above, plot accuracy for each train/test split:

```
print(acc)
```

```
## [1] 0.8208955 0.8208955
```

Create a ROC curve, a precision-recall curve, and plot average AUROC and AUPR:

```
predPerf <- plotPerf(predList, predClasses=st)
```

![plot of chunk unnamed-chunk-19](data:image/png;base64...)

## Examine feature scores and consistently high-scoring features

Use `getNetConsensus()` to convert the list data structure into a single table, one per patient label. The rows show train/test splits and the columns show features that consistently perform well.

We then use `callFeatSel()` to identify features that consistently perform well across the various train/test splits. Because this is a toy example, we set the bar very low to get some features. Here we accept a feature if it scores 1 or higher (`fsCutoff=1`) in even one split (`fsPctPass=0.05`), setting the latter to a low positive fraction.

```
featScores2 <- lapply(featScores, getNetConsensus)
summary(featScores2)
```

```
##         Length Class      Mode
## LumA    3      data.frame list
## notLumA 3      data.frame list
```

```
head(featScores2[["LumA"]])
```

```
##                                                                     PATHWAY_NAME
## 1                                      CDP-DIACYLGLYCEROL_BIOSYNTHESIS_I.profile
## 2 SUPERPATHWAY_OF_D-_I_MYO__I_-INOSITOL__1,4,5_-TRISPHOSPHATE_METABOLISM.profile
## 3                                                             UREA_CYCLE.profile
## 4                                                                   age_cont.txt
## 5                                                                 stage_cont.txt
##   Split1 Split2
## 1      2      2
## 2      2      2
## 3      2      2
## 4      1      1
## 5     NA      1
```

In practice, a recommended setting is `fsCutoff=9` and `fsPctPass=0.7` to get features that score at least 9 (out of 10) in at least 70% of the train/test splits.

```
featSelNet <- lapply(featScores2, function(x) {
    callFeatSel(x, fsCutoff=1, fsPctPass=0)
})
print(head(featScores2[["LumA"]]))
```

```
##                                                                     PATHWAY_NAME
## 1                                      CDP-DIACYLGLYCEROL_BIOSYNTHESIS_I.profile
## 2 SUPERPATHWAY_OF_D-_I_MYO__I_-INOSITOL__1,4,5_-TRISPHOSPHATE_METABOLISM.profile
## 3                                                             UREA_CYCLE.profile
## 4                                                                   age_cont.txt
## 5                                                                 stage_cont.txt
##   Split1 Split2
## 1      2      2
## 2      2      2
## 3      2      2
## 4      1      1
## 5     NA      1
```

## Visualize EnrichmentMap

An EnrichmentMap is a network-based visualization of pathway connectivity and is used in netDx to visualize themes in predictive pathway-based features. It is used in conjunction with AutoAnnotate to identify clusters, and apply auto-generated labels to these. For more information, see the [EnrichmentMap](https://www.baderlab.org/Software/EnrichmentMap) website at baderlab.org.

Use `getEMapInput_many()` to create the input that helps generate the EnrichmentMap in Cytoscape.

```
Emap_res <- getEMapInput_many(featScores2,pathList,
    minScore=1,maxScore=2,pctPass=0,out$inputNets,verbose=FALSE)
```

Write the results to files that Cytoscape can read in:

```
gmtFiles <- list()
nodeAttrFiles <- list()

for (g in names(Emap_res)) {
    outFile <- paste(outDir,sprintf("%s_nodeAttrs.txt",g),sep=getFileSep())
    write.table(Emap_res[[g]][["nodeAttrs"]],file=outFile,
        sep="\t",col=TRUE,row=FALSE,quote=FALSE)
    nodeAttrFiles[[g]] <- outFile

    outFile <- paste(outDir,sprintf("%s.gmt",g),sep=getFileSep())
    conn <- suppressWarnings(
         suppressMessages(base::file(outFile,"w")))
    tmp <- Emap_res[[g]][["featureSets"]]
    gmtFiles[[g]] <- outFile

    for (cur in names(tmp)) {
        curr <- sprintf("%s\t%s\t%s", cur,cur,
            paste(tmp[[cur]],collapse="\t"))
        writeLines(curr,con=conn)
    }
close(conn)
}
```

```
## Found more than one class "file" in cache; using the first, from namespace 'BiocGenerics'
```

```
## Also defined by 'RJSONIO'
```

```
## Found more than one class "file" in cache; using the first, from namespace 'BiocGenerics'
```

```
## Also defined by 'RJSONIO'
```

Finally, plot the EnrichmentMap. This step requires Cytoscape to be installed, along with the EnrichmentMap and AutoAnnotate apps. It also requires the Cytoscape application to be open and running on the machine running the code. This block is commented out for automatic builds on BioConductor, but a screenshot of the intended result is shown below.

```
###plotEmap(gmtFiles[[1]],nodeAttrFiles[[1]],
###         groupClusters=TRUE, hideNodeLabels=TRUE)
```

This example EnrichmentMap isn't terribly exciting because of the low number of pathway features permitted, the upper bound on feature selection scores and low number of train/test splits. But hopefully it serves its purpose to be illustrative.

![EnrichmentMap generated from example in this vignette. The small number of nodes reflects the limited number of pathways provided to the model, and also reduced parameter values for model building.](data:image/png;base64...)

Here is an example of an EnrichmentMap generated by running the above predictor with more real-world parameter values, and all available pathways:

![EnrichmentMap from the same data but using all pathways, more train/test splits and higher range of feature scores.](data:image/png;base64...)

# Visualize integrated patient similarity network based on top features

We can apply a threshold to define predictive features, and integrate these into a single patient similarity network. Such a network is useful for downstream operations such as ascertaining whether or not classes are significantly separated and visualization.

Here we define predictive features as those scoring 3 out of 3 in all train/test splits.

```
featScores2 <- lapply(featScores, getNetConsensus)
featSelNet <- lapply(featScores2, function(x) {
    callFeatSel(x, fsCutoff=2, fsPctPass=1)
})
```

We can examine the features:

```
print(featSelNet)
```

```
## $LumA
## [1] "CDP-DIACYLGLYCEROL_BIOSYNTHESIS_I.profile"
## [2] "SUPERPATHWAY_OF_D-_I_MYO__I_-INOSITOL__1,4,5_-TRISPHOSPHATE_METABOLISM.profile"
## [3] "UREA_CYCLE.profile"
##
## $notLumA
## [1] "SUPERPATHWAY_OF_D-_I_MYO__I_-INOSITOL__1,4,5_-TRISPHOSPHATE_METABOLISM.profile"
## [2] "UREA_CYCLE.profile"
```

Create a new `groupList` limited to top features:

```
topPath <- gsub(".profile","",
        unique(unlist(featSelNet)))
topPath <- gsub("_cont.txt","",topPath)
# create groupList limited to top features
g2 <- list();
for (nm in names(groupList)) {
    cur <- groupList[[nm]]
    idx <- which(names(cur) %in% topPath)
    message(sprintf("%s: %i pathways", nm, length(idx)))
    if (length(idx)>0) g2[[nm]] <- cur[idx]
}
```

```
## BRCA_mRNAArray-20160128: 3 pathways
```

```
## clinical: 0 pathways
```

Plot the integrated patient network based on the features selected above. Note that at this stage, the similarity measure is inverted into a dissimilarity measure so that nodes with greater similarity are closer (have smaller distance or dissimilarity) in the final network.

In the example below, the networks are integrated by taking the mean of the edge weights (`aggFun="MEAN"`). For the plotting we retain only the top 5% of the strongest edges (`topX=0.05`).

By setting `calcShortestPath=TRUE`, the function will also compute the pairwise shortest path for within- and across-group nodes. The result is shown as a set of violin plots and a one-sided Wilcoxon-Mann-Whitney test is used to assign significance.

As with `plotEMap()`, this method must be run on a computer with Cytoscape installed and running. For the purposes of this example, `plotCytoscape` is set to `FALSE` and a screenshot of the resulting network is provided below. To plot in Cytoscape, set `plotCytoscape=TRUE`.

```
psn <- suppressMessages(
   plotIntegratedPatientNetwork(brca,
  groupList=g2, makeNetFunc=makeNets,
  aggFun="MEAN",prune_pctX=0.30,prune_useTop=TRUE,
  numCores=1L,calcShortestPath=TRUE,
  showStats=FALSE,
  verbose=FALSE, plotCytoscape=FALSE)
)
```

```
## Warning in dir.create(paste(netDir, "profiles", sep = fsep)): '/tmp/RtmpX57lMG/
## profiles' already exists
```

![plot of chunk unnamed-chunk-28](data:image/png;base64...)

![Patient network after integrating features that scored 2 out of 2 in all train-test splits. For visualization only the top 10% strongest edges are shown. Nodes are patients, and edges are average distance across all features passing feature selection. Green indicates "LumA" status and orange indicates "nonLumA" status.](data:image/png;base64...)

The integrated PSN can also be visualized as a tSNE plot:

```
tsne <- plot_tSNE(psn$patientSimNetwork_unpruned,colData(brca))
```

```
## * Making symmetric matrix
```

```
## * Running tSNE
```

```
## * Plotting
```

![plot of chunk unnamed-chunk-29](data:image/png;base64...)

```
summary(tsne)
```

```
##                     Length Class  Mode
## N                     1    -none- numeric
## Y                   662    -none- numeric
## costs               331    -none- numeric
## itercosts            20    -none- numeric
## origD                 1    -none- numeric
## perplexity            1    -none- numeric
## theta                 1    -none- numeric
## max_iter              1    -none- numeric
## stop_lying_iter       1    -none- numeric
## mom_switch_iter       1    -none- numeric
## momentum              1    -none- numeric
## final_momentum        1    -none- numeric
## eta                   1    -none- numeric
## exaggeration_factor   1    -none- numeric
```

```
class(tsne)
```

```
## [1] "list"
```

# sessionInfo

```
sessionInfo()
```

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=C                 LC_NUMERIC=C
##  [3] LC_TIME=C                  LC_COLLATE=C
##  [5] LC_MONETARY=C              LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] curatedTCGAData_1.10.1      MultiAssayExperiment_1.14.0
##  [3] SummarizedExperiment_1.18.2 DelayedArray_0.14.1
##  [5] matrixStats_0.57.0          GenomicRanges_1.40.0
##  [7] GenomeInfoDb_1.24.2         IRanges_2.22.2
##  [9] S4Vectors_0.26.1            netDx_1.0.4
## [11] bigmemory_4.5.36            Biobase_2.48.0
## [13] BiocGenerics_0.34.0
##
## loaded via a namespace (and not attached):
##   [1] uuid_0.1-4                    AnnotationHub_2.20.2
##   [3] BiocFileCache_1.12.1          NMF_0.23.0
##   [5] plyr_1.8.6                    igraph_1.2.6
##   [7] RCy3_2.8.1                    lazyeval_0.2.2
##   [9] splines_4.0.3                 entropy_1.2.1
##  [11] BiocParallel_1.22.0           rncl_0.8.4
##  [13] ggplot2_3.3.2                 gridBase_0.4-7
##  [15] scater_1.16.2                 digest_0.6.25
##  [17] htmltools_0.5.0               foreach_1.5.0
##  [19] viridis_0.5.1                 magrittr_1.5
##  [21] memoise_1.1.0                 cluster_2.1.0
##  [23] doParallel_1.0.15             ROCR_1.0-11
##  [25] limma_3.44.3                  annotate_1.66.0
##  [27] R.utils_2.10.1                prettyunits_1.1.1
##  [29] colorspace_1.4-1              blob_1.2.1
##  [31] rappdirs_0.3.1                xfun_0.18
##  [33] dplyr_1.0.2                   crayon_1.3.4
##  [35] RCurl_1.98-1.2                bigmemory.sri_0.1.3
##  [37] graph_1.66.0                  genefilter_1.70.0
##  [39] phylobase_0.8.10              survival_3.2-7
##  [41] iterators_1.0.12              ape_5.4-1
##  [43] glue_1.4.2                    registry_0.5-1
##  [45] gtable_0.3.0                  zlibbioc_1.34.0
##  [47] XVector_0.28.0                BiocSingular_1.4.0
##  [49] kernlab_0.9-29                Rhdf5lib_1.10.1
##  [51] shape_1.4.5                   SingleCellExperiment_1.10.1
##  [53] HDF5Array_1.16.1              scales_1.1.1
##  [55] DBI_1.1.0                     edgeR_3.30.3
##  [57] rngtools_1.5                  bibtex_0.4.2.3
##  [59] Rcpp_1.0.5                    viridisLite_0.3.0
##  [61] xtable_1.8-4                  progress_1.2.2
##  [63] bit_4.0.4                     rsvd_1.0.3
##  [65] glmnet_4.0-2                  httr_1.4.2
##  [67] netSmooth_1.8.0               RColorBrewer_1.1-2
##  [69] ellipsis_0.3.1                farver_2.0.3
##  [71] pkgconfig_2.0.3               XML_3.99-0.5
##  [73] R.methodsS3_1.8.1             dbplyr_1.4.4
##  [75] locfit_1.5-9.4                RJSONIO_1.3-1.4
##  [77] labeling_0.3                  later_1.1.0.1
##  [79] howmany_0.3-1                 tidyselect_1.1.0
##  [81] rlang_0.4.8                   softImpute_1.4
##  [83] reshape2_1.4.4                AnnotationDbi_1.50.3
##  [85] BiocVersion_3.11.1            munsell_0.5.0
##  [87] tools_4.0.3                   ExperimentHub_1.14.2
##  [89] generics_0.0.2                RSQLite_2.2.1
##  [91] ade4_1.7-15                   fastmap_1.0.1
##  [93] evaluate_0.14                 stringr_1.4.0
##  [95] yaml_2.2.1                    knitr_1.30
##  [97] bit64_4.0.5                   purrr_0.3.4
##  [99] nlme_3.1-149                  mime_0.9
## [101] R.oo_1.24.0                   pracma_2.2.9
## [103] xml2_1.3.2                    compiler_4.0.3
## [105] interactiveDisplayBase_1.26.3 beeswarm_0.2.3
## [107] curl_4.3                      tibble_3.0.4
## [109] RNeXML_2.4.5                  stringi_1.5.3
## [111] highr_0.8                     RSpectra_0.16-0
## [113] lattice_0.20-41               Matrix_1.2-18
## [115] vctrs_0.3.4                   pillar_1.4.6
## [117] lifecycle_0.2.0               BiocManager_1.30.10
## [119] combinat_0.0-8                zinbwave_1.10.1
## [121] BiocNeighbors_1.6.0           data.table_1.13.0
## [123] bitops_1.0-6                  irlba_2.3.3
## [125] httpuv_1.5.4                  R6_2.4.1
## [127] promises_1.1.1                gridExtra_2.3
## [129] vipor_0.4.5                   codetools_0.2-16
## [131] MASS_7.3-53                   assertthat_0.2.1
## [133] rhdf5_2.32.4                  pkgmaker_0.31.1
## [135] withr_2.3.0                   GenomeInfoDbData_1.2.3
## [137] locfdr_1.1-8                  hms_0.5.3
## [139] grid_4.0.3                    tidyr_1.1.2
## [141] DelayedMatrixStats_1.10.1     Rtsne_0.15
## [143] shiny_1.5.0                   clusterExperiment_2.8.0
## [145] ggbeeswarm_0.6.0
```