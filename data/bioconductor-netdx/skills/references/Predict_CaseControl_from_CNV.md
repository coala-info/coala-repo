# TL;DR

```
suppressMessages(require(netDx))
suppressMessages(require(GenomicRanges))

# read patient CNVs
phenoFile <- paste(path.package("netDx"), "extdata", "AGP1_CNV.txt",
    sep=getFileSep())
pheno   <- read.delim(phenoFile,sep="\t",header=TRUE,as.is=TRUE)
# sample metadata table must have ID and STATUS columns
colnames(pheno)[1] <- "ID"

# create GRanges object.
# Must have ID and LOCUS_NAMES in metadata
cnv_GR    <- GRanges(pheno$seqnames,
        IRanges(pheno$start,pheno$end),
        ID=pheno$ID,LOCUS_NAMES=pheno$Gene_symbols)
pheno <- pheno[!duplicated(pheno$ID),]

pathFile <- fetchPathwayDefinitions(
    "February",2018,verbose=TRUE)
pathwayList <- readPathways(pathFile)

# get gene coordinates, use hg18
# cache for faster local access
require(BiocFileCache)
geneURL <- paste("http://download.baderlab.org/netDx/",
    "supporting_data/refGene.hg18.bed",sep="")
cache <- rappdirs::user_cache_dir(appname = "netDx")
bfc <- BiocFileCache::BiocFileCache(cache,ask=FALSE)
geneFile <- bfcrpath(bfc,geneURL)
genes <- read.delim(geneFile,sep="\t",header=FALSE,as.is=TRUE)
genes <- genes[which(genes[,4]!=""),]
gene_GR     <- GRanges(genes[,1],
        IRanges(genes[,2],genes[,3]),
    name=genes[,4]
)

# create GRangesList of pathway ranges
path_GRList <- mapNamedRangesToSets(gene_GR,pathwayList)

outDir <- paste(tempdir(),randAlphanumString(),
    "ASD",sep=getFileSep()) ## absolute path
if (file.exists(outDir)) unlink(outDir,recursive=TRUE); dir.create(outDir)

message("Getting java version for debugging")
    java_ver <- suppressWarnings(
        system2("java", args="--version",stdout=TRUE,stderr=NULL)
    )
print(java_ver)
message("***")

predictClass    <- "case"
out <- buildPredictor_sparseGenetic(
            pheno, cnv_GR, predictClass,
      path_GRList,
        outDir=outDir, ## absolute path
      numSplits=3L, featScoreMax=3L,
      enrichLabels=TRUE,numPermsEnrich=3L,
      numCores=2L)

# plot ROC curve. Note that the denominator only includes
# patients with events in networks that are label-enriched
dat <- out$performance_denEnrichedNets
plot(0,0,type="n",xlim=c(0,100),ylim=c(0,100),
    las=1, xlab="False Positive Rate (%)",
    ylab="True Positive Rate (%)",
    bty='n',cex.axis=1.5,cex.lab=1.3,
    main="ROC curve - Patients in label-enriched pathways")
points(dat$other_pct,dat$pred_pct,
      col="red",type="o",pch=16,cex=1.3,lwd=2)

# calculate AUROC and AUPR
tmp <- data.frame(
    score=dat$score,
    tp=dat$pred_ol,fp=dat$other_ol,
    # tn: "-" that were correctly not called
    tn=dat$other_tot - dat$other_ol,
    # fn: "+" that were not called
    fn=dat$pred_tot - dat$pred_ol)

stats <- netDx::perfCalc(tmp)
tmp <- stats$stats
message(sprintf("PRAUC = %1.2f\n", stats$prauc))
message(sprintf("ROCAUC = %1.2f\n", stats$auc))

# examine pathway-level scores; these are
# cumulative across the splits - here, each of three
# splits has a max feature score of three, so
# a feature can score a max of (3 + 3 + 3) = 9.
print(head(out$cumulativeFeatScores))
```

# Introduction

netDx natively handles missing data, making it suitable to build predictors with sparse genetic data such as somatic DNA mutations, frequently seen in cancer, and from DNA Copy Number Variations (CNV). This example demonstrates how to use netDx to build a predictor from sparse genetic data. Here we build a case/control classifier for Autism Spectrum Disorder (ASD) diagnosis, starting from rare CNVs. The data is from [Pinto et al. (2014) AJHG 94:677)(<https://pubmed.ncbi.nlm.nih.gov/24768552-convergence-of-genes-and-cellular-pathways-dysregulated-in-autism-spectrum-disorders/>) .

# Design and Adapting the Algorithm for Sparse Event Data

In this design, we group CNVs by pathways. The logic behind the grouping is prior evidence showing that genetic events in diseases tend to converge on cellular processes of relevance to the pathophysiology of the disease. For example, see the Pinto et al. paper referenced in the previous section.

## Label enrichment

In this design, similarity is defined as a binary function, a strategy that has advantages and drawbacks. In plain terms, ***if two patients share a mutation in a pathway, their similarity for that pathway is 1.0 ; otherwise it is zero.*** This binary definition, while conceptually intuitive, increases the false positive rate in the `netDx` feature selection step. That is, networks with even a single case sample will get a high feature score, regardless of whether that network is enriched for case samples.

To counter this problem, we introduce a ***label-enrichment*** step in the feature selection. A bias measure is first computed for each network, such that a network with only cases has +1; one with only controls has a score of -1; and one with an equal number of both has a score of zero. Label-enrichment compares the bias in each real network, to the bias in that network in label-permuted data. It then assigns an empirical p-value for the proportion of times a label-permuted network has a bias as high as the real network. Only networks with a p-value below a user-assigned threshold pass label-enrichment, and feature selection is limited to these networks. In `netDx`, label-enrichment is enabled by setting `enrichLabels=TRUE` in the call to `buildPredictor_sparseGenetic()`.

## Cumulative feature scoring

The other difference between this design and those with non-sparse data, is the method of feature scoring. The user specifies a parameter which indicates the number of times to split the data and run feature selection. The algorithm then runs feature selection `numSplits` times, each time leaving 1/`numSplits` of the samples out. In each split, features are scored between 0 and `featScoreMax`, using the same approach
as is used for continuous-valued input. Feature scores are then added across the splits so that a feature can score as high as `numSplits*featScoreMax`.

## Evaluating model performance

For a given cutoff for features, a patient is called a “case” if they have a genetic event in pathways that pass feature selection at that cutoff; otherwise, at that cutoff, they are labelled a “control”. These calls are used to generate the false positive and true positive rates across the various cutoffs, which ultimately generates an ROC curve.

# Setup

```
suppressMessages(require(netDx))
suppressMessages(require(GenomicRanges))
```

# Data

CNV coordinates are read in, and converted into a `GRanges` object. As always, the sample metadata table, here the `pheno` object, must have `ID` and `STATUS` columns.

```
outDir <- paste(tempdir(),randAlphanumString(),
    "ASD",sep=getFileSep()) ## must be absolute path
if (file.exists(outDir)) unlink(outDir,recursive=TRUE);
dir.create(outDir)
```

```
## Warning in dir.create(outDir): cannot create dir '/tmp/RtmpX57lMG/HWTSC5751L/
## ASD', reason 'No such file or directory'
```

```
cat("* Setting up sample metadata\n")
```

```
## * Setting up sample metadata
```

```
phenoFile <- paste(path.package("netDx"), "extdata", "AGP1_CNV.txt",
    sep=getFileSep())
pheno   <- read.delim(phenoFile,sep="\t",header=TRUE,as.is=TRUE)
colnames(pheno)[1] <- "ID"
head(pheno)
```

```
##        ID seqnames    start      end    Gene_symbols Pathogenic STATUS
## 3  1020_4     chr3  4110452  4145874                         no   case
## 4  1030_3    chr10 56265896 56361311                         no   case
## 5  1030_3     chr7 64316996 64593616 ZNF92,LOC441242         no   case
## 7  1045_3     chr3 83206919 83239473                         no   case
## 11 1050_3     chr6 57021412 57062509        KIAA1586         no   case
## 16 1116_4     chr1 30334653 30951250                         no   case
```

```
cnv_GR    <- GRanges(pheno$seqnames,IRanges(pheno$start,pheno$end),
                        ID=pheno$ID,LOCUS_NAMES=pheno$Gene_symbols)
pheno <- pheno[!duplicated(pheno$ID),]
```

# Group CNVs by pathways

The `fetchPathwayDefinitions()` function downloads pathway definitions from `baderlab.org`
but users may provide custom `.gmt` files as well. In the example below, gene coordinates
for the hg18 genome build are automatically fetched from a remote location, and converted to a `GRanges` object. The function
`mapNamedRangesToSets()` is used to group this `GRanges` object into pathway-level sets.

```
pathFile <- fetchPathwayDefinitions("February",2018,verbose=TRUE)
```

```
## Fetching http://download.baderlab.org/EM_Genesets/February_01_2018/Human/symbol/Human_AllPathways_February_01_2018_symbol.gmt
```

```
## adding rname 'http://download.baderlab.org/EM_Genesets/February_01_2018/Human/symbol/Human_AllPathways_February_01_2018_symbol.gmt'
```

```
pathwayList <- readPathways(pathFile)
```

```
## ---------------------------------------
```

```
## File: 31d12f1bb0f_Human_AllPathways_February_01_2018_symbol.gmt
```

```
## Read 3199 pathways in total, internal list has 3163 entries
```

```
##  FILTER: sets with num genes in [10, 200]
```

```
##    => 1044 pathways excluded
##    => 2119 left
```

```
# get gene coordinates, use hg18
# cache for faster local access
require(BiocFileCache)
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
geneURL <- paste("http://download.baderlab.org/netDx/",
    "supporting_data/refGene.hg18.bed",sep="")
cache <- rappdirs::user_cache_dir(appname = "netDx")
bfc <- BiocFileCache::BiocFileCache(cache,ask=FALSE)
geneFile <- bfcrpath(bfc,geneURL)
```

```
## adding rname 'http://download.baderlab.org/netDx/supporting_data/refGene.hg18.bed'
```

```
genes <- read.delim(geneFile,sep="\t",header=FALSE,as.is=TRUE)
genes <- genes[which(genes[,4]!=""),]
gene_GR     <- GRanges(genes[,1],IRanges(genes[,2],genes[,3]),
   name=genes[,4])
```

Group gene extents into pathway-based sets, which effectively creates grouping rules for netDx. The function `mapNamedRangesToSets()` does this grouping, generating a `GRangesList` object.

```
path_GRList <- mapNamedRangesToSets(gene_GR,pathwayList)
```

# Run predictor

Once the phenotype matrix and grouping rules are set up, the predictor is called using `buildPredictor_sparseGenetic()`. Note that unlike with non-sparse data,
the user does not provide a custom similarity function in this application; currently, the only option available is the binary similarity defined above. As discussed above, setting `enrichLabels=TRUE` to enable label-enrichment is highly recommended to reduce false positive rate.

```
predictClass    <- "case"
out <-
   buildPredictor_sparseGenetic(pheno, cnv_GR, predictClass,
                             path_GRList,
                             outDir=outDir, ## absolute path
                             numSplits=3L, featScoreMax=3L,
                             enrichLabels=TRUE,numPermsEnrich=3L,
                             numCores=2L)
```

```
## making rangesets
```

```
## * Preparing patient-locus matrix
```

```
##  3291 unique patients, 10417 unique locus symbols
```

```
## Time difference of 20.69517 secs
```

```
## * Writing networks
```

```
## Time difference of 10.70126 secs
```

```
## counting patients in net
```

```
## updating nets
```

```
## * Resampling train/test samples
```

```
##  (+) case : 582 total ; 388 train, 194 held-out per
```

```
##  (-) (!case): 647 total ; 432 train, 215 held-out per
```

```
##  1 (+): 194 test (1-194);
```

```
##      1 (-): 215 test
```

```
##  2 (+): 194 test (195-388);
```

```
##      2 (-): 215 test
```

```
##  3 (+): 194 test (389-582);
```

```
##      3 (-): 217 test
```

```
## ----------------------------------------
```

```
## Resampling round 1
```

```
## ----------------------------------------
```

```
##          TT_STATUS
## STATUS    TEST TRAIN
##   case     194   388
##   control  215   432
```

```
## # patients: train only
```

```
## [1] 820
```

```
## Training only:
```

```
## Limiting to 1326 networks
```

```
## Limiting to 819 patients
```

```
## Running label enrichment
```

```
## Got 1326 networks
```

```
## Total 819 subjects ; 387 of class case, 432 other
```

```
## * Computing real (+,+) (+,-)
```

```
##    user  system elapsed
##   0.767   0.216  17.377
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## -1.0000 -0.5840  0.2000  0.1472  1.0000  1.0000
```

```
##
##  1326 of 1326 networks have ENR >= -1.0 -> filter
```

```
## * Computing shuffled
```

```
## [1] 736
```

```
## Limiting to 736 networks
```

```
## Limiting to 567 patients
```

```
## Score features for this train/test split
```

```
## Time difference of 20.98831 secs
```

```
## ----------------------------------------
```

```
## Resampling round 2
```

```
## ----------------------------------------
```

```
##          TT_STATUS
## STATUS    TEST TRAIN
##   case     194   388
##   control  215   432
```

```
## # patients: train only
```

```
## [1] 820
```

```
## Training only:
```

```
## Limiting to 1333 networks
```

```
## Limiting to 818 patients
```

```
## Running label enrichment
```

```
## Got 1333 networks
```

```
## Total 818 subjects ; 387 of class case, 431 other
```

```
## * Computing real (+,+) (+,-)
```

```
##    user  system elapsed
##   0.916   0.178  18.317
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## -1.0000 -0.6667  0.3333  0.1645  1.0000  1.0000
```

```
##
##  1333 of 1333 networks have ENR >= -1.0 -> filter
```

```
## * Computing shuffled
```

```
## [1] 769
```

```
## Limiting to 769 networks
```

```
## Limiting to 519 patients
```

```
## Score features for this train/test split
```

```
## Time difference of 17.06982 secs
```

```
## ----------------------------------------
```

```
## Resampling round 3
```

```
## ----------------------------------------
```

```
##          TT_STATUS
## STATUS    TEST TRAIN
##   case     194   388
##   control  217   430
```

```
## # patients: train only
```

```
## [1] 818
```

```
## Training only:
```

```
## Limiting to 1365 networks
```

```
## Limiting to 818 patients
```

```
## Running label enrichment
```

```
## Got 1365 networks
```

```
## Total 818 subjects ; 388 of class case, 430 other
```

```
## * Computing real (+,+) (+,-)
```

```
##    user  system elapsed
##   0.770   0.139  18.775
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## -1.00000 -0.66667  0.07143  0.10627  1.00000  1.00000
```

```
##
##  1365 of 1365 networks have ENR >= -1.0 -> filter
```

```
## * Computing shuffled
```

```
## [1] 599
```

```
## Limiting to 599 networks
```

```
## Limiting to 462 patients
```

```
## Score features for this train/test split
```

```
## Time difference of 11.96438 secs
```

# Plot results

Feature selection identifies pathways that are consistently enriched for the label
of interest; here, “case” status. From the diagnostic point of view, a patient with a
genetic event in a selected feature - here, a CNV in a feature-selected pathway -
is labelled a “case”. “True positives” are therefore cases with CNVs in feature-selected
pathways, while “false positives” are controls with CNVs in feature-selected pathways.
These definitions are used to compute the ROC curve below.

```
dat <- out$performance_denEnrichedNets
plot(0,0,type="n",xlim=c(0,100),ylim=c(0,100),
    las=1, xlab="False Positive Rate (%)",
    ylab="True Positive Rate (%)",
    bty='n',cex.axis=1.5,cex.lab=1.3,
    main="ROC curve - Patients in label-enriched pathways")
points(dat$other_pct,dat$pred_pct,
      col="red",type="o",pch=16,cex=1.3,lwd=2)
```

![plot of chunk unnamed-chunk-7](data:image/png;base64...)

We can also compute the AUROC and AUPR from scratch.

```
tmp <- data.frame(
    score=dat$score,
    tp=dat$pred_ol,fp=dat$other_ol,
    # tn: "-" that were correctly not called
    tn=dat$other_tot - dat$other_ol,
    # fn: "+" that were not called
    fn=dat$pred_tot - dat$pred_ol)

stats <- netDx::perfCalc(tmp)
tmp <- stats$stats
message(sprintf("PRAUC = %1.2f\n", stats$prauc))
```

```
## PRAUC = 0.49
```

```
message(sprintf("ROCAUC = %1.2f\n", stats$auc))
```

```
## ROCAUC = 0.68
```

Pathway scores are also added across the splits, for a total of 9 across the 3 splits
(3 + 3 + 3).

```
# now get pathway score
print(head(out$cumulativeFeatScores))
```

```
##                                                                                                                             PATHWAY_NAME
## NEUROTRANSMITTER_RECEPTORS_AND_POSTSYNAPTIC_SIGNAL_TRANSMISSION_cont.txt NEUROTRANSMITTER_RECEPTORS_AND_POSTSYNAPTIC_SIGNAL_TRANSMISSION
## NABA_ECM_AFFILIATED_cont.txt                                                                                         NABA_ECM_AFFILIATED
## NICOTINIC_ACETYLCHOLINE_RECEPTOR_SIGNALING_PATHWAY_cont.txt                           NICOTINIC_ACETYLCHOLINE_RECEPTOR_SIGNALING_PATHWAY
## L1CAM_INTERACTIONS_cont.txt                                                                                           L1CAM_INTERACTIONS
## HUNTINGTON_DISEASE_cont.txt                                                                                           HUNTINGTON_DISEASE
## G2_M_TRANSITION_cont.txt                                                                                                 G2_M_TRANSITION
##                                                                          SCORE
## NEUROTRANSMITTER_RECEPTORS_AND_POSTSYNAPTIC_SIGNAL_TRANSMISSION_cont.txt     8
## NABA_ECM_AFFILIATED_cont.txt                                                 8
## NICOTINIC_ACETYLCHOLINE_RECEPTOR_SIGNALING_PATHWAY_cont.txt                  8
## L1CAM_INTERACTIONS_cont.txt                                                  8
## HUNTINGTON_DISEASE_cont.txt                                                  7
## G2_M_TRANSITION_cont.txt                                                     7
```