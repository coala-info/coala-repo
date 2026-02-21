# *RNAdecay* Vignette: Normalization, Modeling, and Visualization of RNA Decay Data

#### Reed Sorenson | reed.sorenson@utah.edu | Department of Biology | University of Utah

#### 2025-11-14

# I. DATA NORMALIZATION AND CORRECTION

The functions and code of the `RNAdecay` package were written for the purpose of analyzing decreasing levels of RNA abundance as measured by RNA short read sequencing (RNA-seq) after inhibition of transcription. Tissue is treated to block transcription (e.g., using a chemical such as cordycepin or ActinomycinD) and collected at regular intervals (referred to as the RNA decay time course, e.g., T0, T30, T60 refer to 0, 30, and 60 min of blocked transcription). Total RNA is extracted from the tissue and measured by RNA-seq. Although we wrote this package to analyze RNA-seq data, it could also be adapted to analyze individual gene data from quantitative reverse transcription polymerase chain reaction (qRT-PCR) measures, however, normalization (as herein described) is best performed using a number of stable reference genes.

Raw (Illumina) RNA-seq data are typically libraries made of up 10M-250M short (50 nt) sequences. These sequences are aligned to the genome and counted based on the location of their alignment in annotated genomic ranges (e.g., genes, exons, etc). Read counts for each gene are normalized to the size of their respective RNA-seq library for comparison to libraries generated from other biological material, therefore, read counts are expressed as reads per million (RPM). We begin RNA decay analysis in this package with RPM RNA abundance data.

## 1. T0 NORMALIZATION

Prior to modeling RNA decay, we normalize the read counts to the initial (T0) RNA abundance, the transcript level just prior to blocking transcription. This is unique for each gene, and, in an experiment with multiple replicates (reps), we use the mean value for all T0 reps. All RPM values in the time course are divided by the mean T0 value. For example:

```
# you can see that in this fabricated data the RNAs have a half-life of ~30 min
RPM_geneX <- data.frame(T0 = c(150, 135, 148), T30 = c(72, 76, 69), T60 = c(35, 35, 30),
                     row.names = paste0("rep", 1:3))
RPM_geneX
```

```
##       T0 T30 T60
## rep1 150  72  35
## rep2 135  76  35
## rep3 148  69  30
```

```
RPM_geneX_T0norm <- RPM_geneX/mean(RPM_geneX$T0)
RPM_geneX_T0norm
```

```
##             T0       T30       T60
## rep1 1.0392610 0.4988453 0.2424942
## rep2 0.9353349 0.5265589 0.2424942
## rep3 1.0254042 0.4780600 0.2078522
```

```
colMeans(RPM_geneX_T0norm)
```

```
##        T0       T30       T60
## 1.0000000 0.5011547 0.2309469
```

*The following workflow depends on beginning with a data frame of RPM values with column names consisting of unique, non-nested variable tags separated by underscores (‘\_’), with rownames as unique gene identifiers.* Here, we use with built-in example data (from [Sorenson et al., 2018](http://www.pnas.org/content/early/2018/01/30/1712312115.short)) which we will use throughout this workflow. It has 4 genotypes, 8 time points, and 4 biological replicates for 128 samples (columns) and 118 genes (rows).

```
library(RNAdecay)
RPMs <- RNAdecay::RPMs # built-in example data
RPMs[1:2, c(1:11, 128)] # NOTE: not showing all columns here
```

```
##           WT_00_r1  WT_07_r1  WT_15_r1  WT_30_r1  WT_60_r1 WT_120_r1 WT_240_r1
## AT1G02860 10.35838  9.772902  9.682167  9.298616  8.478808  7.007951  5.482903
## AT1G09660 19.77509 17.684298 19.717329 15.455808 15.164023 13.912843 10.342748
##           WT_480_r1 sov_00_r1 sov_07_r1 sov_15_r1 vs_480_r4
## AT1G02860  6.523851  11.78139  11.85849  9.238458  25.50327
## AT1G09660 11.261410  21.48637  19.33097 18.476917  17.56892
```

Biological replicate data columns are indexed using the `cols()` function.

```
cols(patterns = c("WT", "00"), df = RPMs) #gives the column indices that contain both tags in the column names
```

```
## WT_00_r1 WT_00_r2 WT_00_r3 WT_00_r4
##        1       33       65       97
```

```
colnames(RPMs)[cols(patterns = c("WT", "00"), RPMs, "WT", "00")]
```

```
## [1] "WT_00_r1" "WT_00_r2" "WT_00_r3" "WT_00_r4"
```

```
# NOTE: this is based on grep pattern matching so tags MUST be unique and non-nested (i.e. one entire label should not be part of another).
```

The mean and standard error (SE) RPM values are calculated by looping over label combinations and binding the values together in a new data frame.

```
# create a directory for results output
wrdir <- paste0(tempdir(),"/DecayAnalysis/Example analysis results 1")
if(!file.exists(wrdir)) dir.create(wrdir, recursive = TRUE)

# specify sample tags from colnames of RPMs
treatment <- c("WT", "sov", "vcs", "vs") # NOTE: I did not use 'vcs sov' for the name of the double mutant, or cols(df=RPMs, patterns = c("vcs", "00")) would have indexed all T0 samples of both "vcs" and "vcs" sov"; instead, I used 'vs'.
reps <- c("r1", "r2", "r3", "r4")
tdecay <- c("00", "07", "15", "30", "60", "120", "240", "480") #again NO nesting of one label in another hence "00" instead of "0".
```

Loop over the treatments and timepoints to subset the appropriate columns, and calculate mean and SE of replicates.

```
mean_RPM <- data.frame("geneID" = rownames(RPMs))
SE_RPM <- data.frame("geneID" = rownames(RPMs))
for(g in treatment){
  for(t in tdecay){
    mean_RPM <- cbind(mean_RPM, rowMeans(RPMs[, cols(df=RPMs, patterns = c(g, t))]))
    names(mean_RPM)[length(mean_RPM)] <- paste0(g, "_", t)
    SE_RPM <- cbind(SE_RPM, apply(X = RPMs[, cols(df=RPMs, patterns = c(g, t))], MARGIN = 1, FUN = stats::sd)/sqrt(length(reps)))
    names(SE_RPM)[length(SE_RPM)] <- paste0(g, "_", t)
  }}
mean_RPM[1:2, ]
```

```
##              geneID    WT_00    WT_07    WT_15    WT_30     WT_60    WT_120
## AT1G02860 AT1G02860 10.30576 10.92457 12.07227 10.18583  7.951206  5.978875
## AT1G09660 AT1G09660 17.67649 17.60419 17.01889 15.56747 15.591995 13.271012
##              WT_240    WT_480  sov_00  sov_07   sov_15   sov_30    sov_60
## AT1G02860  4.907999  5.427231 10.4751 11.5972 10.76603 10.01565  7.483476
## AT1G09660 10.672795 10.035496 19.6877 19.3090 19.11892 18.04514 16.465382
##             sov_120   sov_240   sov_480   vcs_00   vcs_07   vcs_15   vcs_30
## AT1G02860  5.882106  4.932124  5.242097 15.21011 16.66707 16.86892 14.45997
## AT1G09660 13.815930 10.919155 11.141820 30.52888 28.87662 29.98092 26.93621
##             vcs_60   vcs_120   vcs_240   vcs_480    vs_00    vs_07    vs_15
## AT1G02860 12.41270  9.471179  7.028314  6.223005 23.98874 25.13802 24.56582
## AT1G09660 26.31798 24.230218 23.312002 22.954986 24.06467 23.25254 24.05339
##              vs_30    vs_60   vs_120   vs_240   vs_480
## AT1G02860 25.85643 23.09965 21.47141 20.11297 19.47309
## AT1G09660 21.89650 20.80315 22.72681 20.65078 20.31687
```

```
SE_RPM[1:2, ]
```

```
##              geneID     WT_00     WT_07     WT_15     WT_30     WT_60    WT_120
## AT1G02860 AT1G02860 0.4482383 0.5495215 0.8677714 0.6957607 0.1826975 0.4938045
## AT1G09660 AT1G09660 1.0154376 0.9293058 0.9753225 0.9843020 1.3145629 0.7515276
##              WT_240    WT_480    sov_00    sov_07    sov_15    sov_30    sov_60
## AT1G02860 0.2494622 0.5508578 0.4671639 0.5698232 0.6208221 0.4900057 0.2521764
## AT1G09660 0.6203130 0.8833117 0.7574344 0.4105105 0.5440400 0.9838571 0.8045619
##             sov_120   sov_240   sov_480   vcs_00    vcs_07    vcs_15    vcs_30
## AT1G02860 0.4775238 0.6288319 0.2047149 1.065802 0.5303556 0.5052474 0.8726631
## AT1G09660 0.7516455 0.4322530 0.7700577 1.149763 1.9180603 0.9563549 0.5693349
##              vcs_60   vcs_120   vcs_240   vcs_480    vs_00    vs_07    vs_15
## AT1G02860 0.5491621 0.7702577 0.2626263 0.4689800 1.547137 1.006693 1.481889
## AT1G09660 0.9244970 1.2275583 1.2626453 0.9924902 2.215020 2.072957 1.388435
##              vs_30    vs_60    vs_120    vs_240   vs_480
## AT1G02860 2.374982 2.469157 2.7944529 1.5576869 2.059173
## AT1G09660 1.515420 1.204576 0.7517306 0.4056269 1.758722
```

```
# write output to file
write.table(x = mean_RPM, paste0(wrdir, "/RPM_mean.txt"), sep = "\t")
write.table(x = SE_RPM,   paste0(wrdir, "/RPM_SE.txt"), sep = "\t")
```

Optionally, an RPM-based filtering step could be applied at this point to remove lowly expressed genes, for example.

```
filt1 <- rep(TRUE, 118) # we will not filter in this example, so the filter value for each gene is set to TRUE.
```

Replicate mean T0 RPM values are then used to normalize gene level data.

```
mT0norm <- data.frame(row.names = rownames(RPMs)[filt1])
for(g in treatment){
  mean_T0reps <- rowMeans(RPMs[filt1, cols(df=RPMs, patterns=c(g, "00"))])
  for(r in reps){
    df <- RPMs[filt1, colnames(RPMs)[cols(df=RPMs, patterns=c(g, r))]]
    df <- df[, 1:length(tdecay)]/mean_T0reps
    mT0norm <- cbind(mT0norm, df)
  }}
write.table(x = mT0norm, file = paste0(wrdir, "/T0 normalized.txt"),  sep = "\t")
```

The mean and standard error of the T0 normalized data are then calculated for replicate samples.

```
mean_mT0norm <- data.frame(row.names = rownames(mT0norm))
for(g in treatment){
  for(t in tdecay){
    mean_mT0norm <- cbind(mean_mT0norm, rowMeans(mT0norm[, cols(df=mT0norm, patterns=c(g, t))]))
    names(mean_mT0norm)[length(names(mean_mT0norm))] <- paste0(g, "_", t)
  }}

SE_mT0norm <- data.frame(row.names = rownames(mT0norm))
for(g in treatment){
  for(t in tdecay){
    SE_mT0norm <- cbind(SE_mT0norm, apply(X = mT0norm[, cols(df=mT0norm, patterns=c(g, t))], MARGIN = 1, FUN = function(x) stats::sd(x)/sqrt(length(reps))))
    names(SE_mT0norm)[length(names(SE_mT0norm))] <- paste0(g, "_", t)
  }}

# write output to file
write.table(x = mean_mT0norm, file = paste0(wrdir, "/T0 normalized_Mean.txt"),  sep = "\t")
write.table(x = SE_mT0norm, file = paste0(wrdir, "/T0 normalized_SE.txt"),  sep = "\t")
```

## 2. DECAY FACTOR CORRECTION

After inhibition of RNA synthesis, RNA degradation continues causing the total pool of RNA in cells to decrease. As this occurs, very stable RNAs become a much larger proportion of the total RNA pool even though their concentration in the cell remains nearly constant. RNA-seq RPM data is scaled to a normalized library size (i.e. to the total RNA pool), and, because of this, abundance of stable RNAs appears to increase. The apparent increase in abundance of stable genes is proportional to the reduction in the total pool of RNA, therefore, we can use it to apply a correction to the data. We call this decay factor correction. The decay factor is estimated based on the RPM increase (relative to the T0 samples) of a set of stable and abundant reference genes.

We selected 30 genes with high abundance on which to calculate the decay factors for each sample. These were then used to correct abundance in each of the respective samples. A unique decay factor is calculated for each treatment at each time point.

First, make a vector of ’geneID’s of abundant and stable reference genes present in the data set.

```
stablegenes <- c( "ATCG00490", "ATCG00680", "ATMG00280", "ATCG00580", "ATCG00140", "AT4G38970", "AT2G07671", "ATCG00570", "ATMG00730", "AT2G07727", "AT2G07687", "ATMG00160" ,"AT3G11630", "ATMG00060", "ATCG00600", "ATMG00220", "ATMG01170", "ATMG00410", "AT1G78900", "AT3G55440", "ATMG01320", "AT2G21170" ,"AT5G08670", "AT5G53300", "ATMG00070", "AT1G26630", "AT5G48300", "AT2G33040", "AT5G08690", "AT1G57720")
```

Mean T0 normalized values of stable genes are then pulled out of the `mean_mT0norm` data frame and used to calculate the decay factor for each set of replicate samples.

```
stabletable <- mean_mT0norm[stablegenes, ]
normFactors <- colMeans(stabletable)
write.table(x <- normFactors, paste0(wrdir, "/Normalziation Decay Factors.txt"), sep = "\t")
normFactors_mean <- matrix(normFactors, nrow = length(tdecay))
normFactors_SE <- matrix(apply(X = stabletable, MARGIN = 2, function(x) stats::sd(x)/sqrt(length(stablegenes))), nrow = length(tdecay))
t.decay <- c(0, 7.5, 15, 30, 60, 120, 240, 480)
rownames(normFactors_mean) <- t.decay
rownames(normFactors_SE) <- t.decay
colnames(normFactors_mean) <- treatment
colnames(normFactors_SE) <- treatment
list(normalizationFactors = normFactors_mean, SE = normFactors_SE)
```

```
## $normalizationFactors
##           WT      sov      vcs       vs
## 0   1.000000 1.000000 1.000000 1.000000
## 7.5 1.036541 1.018474 1.019401 1.006349
## 15  1.039264 1.049762 1.030781 1.016110
## 30  1.093192 1.089058 1.068392 1.057446
## 60  1.159184 1.150108 1.143107 1.127042
## 120 1.244396 1.254913 1.238043 1.211260
## 240 1.360045 1.361653 1.355177 1.331136
## 480 1.518916 1.524910 1.508710 1.490484
##
## $SE
##               WT          sov          vcs           vs
## 0   3.764009e-18 9.219900e-18 8.416579e-18 5.323112e-18
## 7.5 7.187629e-03 6.156141e-03 6.354406e-03 3.671789e-03
## 15  8.350257e-03 8.745853e-03 4.268441e-03 7.639774e-03
## 30  1.018092e-02 9.213515e-03 8.169738e-03 9.683929e-03
## 60  8.408549e-03 9.406738e-03 7.099825e-03 1.257889e-02
## 120 1.081113e-02 1.397098e-02 1.073154e-02 1.346151e-02
## 240 1.827014e-02 1.776487e-02 1.474298e-02 1.564277e-02
## 480 3.641681e-02 4.239630e-02 3.448004e-02 3.649816e-02
```

Generate a matrix of the same dimensions as `mT0norm` with the appropriate decay factors in the same respective positions.

```
nF <- vector()
ind <- sapply(names(normFactors), function(x) grep(x, colnames(mT0norm)))
for(i in 1:ncol(ind)){
nF[ind[, i]] <- colnames(ind)[i]
}
normFactorsM <- t(matrix(rep(normFactors[nF], nrow(mT0norm)), ncol = nrow(mT0norm)))
rm(nF, ind)
```

Apply the decay factor corrections.

```
mT0norm_2 <- data.frame(mT0norm/normFactorsM,
                     row.names = rownames(mT0norm))

write.table(mT0norm_2, paste0(wrdir, "/T0 normalized and decay factor corrected.txt"), sep = "\t")
```

Rearrange the RNA decay data into a long form data frame for modeling and visualization.

```
mT0norm_2.1 <- reshape2::melt(as.matrix(mT0norm_2), varnames = c("geneID", "variable"))
mT0norm_2.1 <- cbind(mT0norm_2.1, reshape2::colsplit(mT0norm_2.1$variable, "_", names = c("treatment", "t.decay", "rep")))

mT0norm_2.1 <- mT0norm_2.1[, colnames(mT0norm_2.1) !=  "variable"]
mT0norm_2.1 <- mT0norm_2.1[, c(1, 3, 4, 5, 2)]
colnames(mT0norm_2.1) <- c("geneID", "treatment", "t.decay", "rep", "value")
mT0norm_2.1$rep <- gsub("r", "rep", mT0norm_2.1$rep)
mT0norm_2.1$t.decay <- as.numeric(gsub("7", "7.5", as.numeric(mT0norm_2.1$t.decay)))
mT0norm_2.1$treatment <- factor(mT0norm_2.1$treatment,levels = c("WT","sov","vcs","vs"))
mT0norm_2.1$rep <- factor(mT0norm_2.1$rep, levels = paste0("rep",1:4))
write.table(x = mT0norm_2.1,  file = paste0(wrdir,
"/ExampleDecayData+stableGenes.txt"), sep = "\t")
```

Following the steps in this vignette, the resulting normalized data frame should be identical to the one supplied in this package called decay\_data. To check:

```
table(RNAdecay::decay_data[,1:4] == mT0norm_2.1[,1:4]) # should be all TRUE no FALSE
```

```
##
##  TRUE
## 60416
```

The normalized data is now ready to be used for modeling decay rates.

# II. MODELING DECAY RATES

RNA degradation is typically modeled with a constant exponential decay model. This model assumes a constant decay rate throughout the decay time course. However, a number of issues might violate this assumption. For example, decay might depend on continuous transcription of rapidly turned over components of decay machinery; inhibition of this transcription would cause slowed decay due to lost supply of decay components. Alternatively, decay rate might be regulated (e.g., diurnally) leading to a slow change in decay rate over a long decay time course. Feedback due to slowed transcription could also lead to slowed RNA decay. We, therefore, apply both a constant exponential decay model and a time-dependent exponential decay model. However, besides these possibilies, other distinct mechanisms could lead to an apparent slowing of RNA decay. For example, because RNA-seq reads are pooled from multiple cell types and mapped to genes, distinct gene mRNA subpopulations might have different decay rates (i.e., different splice isoforms, or the same mRNA in different cell types of a multicellular organism) that are are averaged when these are pooled together. We believe that for these the time-dependent exponential decay model will also better capture this average than a constant exponential decay model.

The dynamic nature of RNA decay can be a point of gene regulation. To identify treatments that might affect decay rate, we model all possibilities of treatment effect on both [initital] decay rates (\(\alpha\)) and decay of decay rates (\(\beta\)) using maximum likelihood modeling. This is done by running the modeling with constraints on treatment decay rates (i.e., constraining decay rates of treatments to be equal or allowing them to combinatorially vary in independent groups). This can be done with up to four treatments in this package. Modeling is performed one gene at a time with each set of constraints, and then each set of parameter estimates (from each set of contraints) are compared using the AICc statistic. In this package, we refer to these as equivalence constraint groupings.

For the detailed mathematical framework of the decaying decay model see [Sorenson et. al. (2018)](http://www.pnas.org/content/early/2018/01/30/1712312115.short). Below we describe the steps of the algorithmic implementation and walk though an example data set.

## 3. LOAD NORMALIZED AND CORRECTED DATA AND CHECK THE FORMAT

Load normalized and corrected data and check the format: the following script requires a data frame with five columns with the following column names exactly: “geneID”, “treatment”, “t.decay”, “rep”, “value”:

```
* geneID    = gene identifiers (`factor`)
* treatment = experimental treatment or genotype (`factor`)
* t.decay   = time after transcriptional inhibition (`numeric`)
* rep       = biological replicate number (`factor`)
* value     = RNA abundance normalized to library size, decay factor and mean T0 values (`numeric`)
```

```
library(RNAdecay)
decay_data <- RNAdecay::decay_data # built-in example data

# make new directory for results
wrdir <- paste0(tempdir(),"/DecayAnalysis/Example analysis results 2")
if(!file.exists(wrdir)) dir.create(wrdir, recursive = TRUE)
```

Rename factor levels and specify level order of `decay_data$treatment` for sorting and making figures. The example data set is already ordered, but when data is read from a text file (e.g., .csv) factor levels are ordered automatically and should be reordered according to user preference now to avoid later headaches.

```
levels(decay_data$treatment) # This can not be longer than 4 elements for modeling.
```

```
## [1] "WT"  "sov" "vcs" "vs"
```

```
# reorder factor levels if necessary (skipped here):
# decay_data$treatment <- factor(decay_data$treatment, levels = levels(decay_data$treatment)[c(4, 1, 2, 3)]) # numbers here refer to the current order position in the factor levels() - the order of the numbers designates the new position

levels(decay_data$treatment)[4] <- "vcs.sov"
levels(decay_data$treatment)
```

```
## [1] "WT"      "sov"     "vcs"     "vcs.sov"
```

Sort the `decay_data` data frame as follows (*NOTE: REQUIRED step for proper indexing below*).

```
decay_data <- decay_data[order(decay_data$t.decay), ]
decay_data <- decay_data[order(decay_data$rep), ]
decay_data <- decay_data[order(as.numeric(decay_data$treatment)), ]
decay_data <- decay_data[order(decay_data$geneID), ]
ids <- as.character(unique(decay_data$geneID)) # 118 in example set
decay_data[1:10, ]
```

```
##         geneID treatment t.decay  rep     value
## 1    AT1G02860        WT     0.0 rep1 1.0051056
## 119  AT1G02860        WT     7.5 rep1 0.9148649
## 237  AT1G02860        WT    15.0 rep1 0.9039961
## 355  AT1G02860        WT    30.0 rep1 0.8253565
## 473  AT1G02860        WT    60.0 rep1 0.7097449
## 591  AT1G02860        WT   120.0 rep1 0.5464521
## 709  AT1G02860        WT   240.0 rep1 0.3911804
## 827  AT1G02860        WT   480.0 rep1 0.4167638
## 945  AT1G02860        WT     0.0 rep2 1.1086173
## 1063 AT1G02860        WT     7.5 rep2 1.1531651
```

## 4. GENERATE MATRICES OF \(\alpha\) AND \(\beta\) EQUIVALENCE CONSTRAINT GROUPS

Create objects and set varables used in the modeling based on `decay_data`.

```
# (no changes needed here - just execute the code)
nEquivGrp <- if (length(unique(decay_data$treatment)) == 2) {2} else
  if (length(unique(decay_data$treatment)) == 3) {5} else
    if (length(unique(decay_data$treatment)) == 4) {15}
genoSet <- 1:(length(unique(decay_data$rep)) * length(unique(decay_data$t.decay)))
nTreat <- length(unique(decay_data$treatment))
nSet <- length(genoSet)*nTreat
groups <- groupings(decay_data)
mods <- data.frame(
  "a" = as.vector(sapply(1:nEquivGrp, function(x) {rep(x, nEquivGrp + 1)})),
  "b" = rep(1:(nEquivGrp + 1), nEquivGrp),
  row.names = paste0("mod", 1:(nEquivGrp*(nEquivGrp+1)))
)
```

Create a colormap of model groups.

```
group_map(decaydata = decay_data, path = paste0(wrdir, "/Model grouping colormap.pdf"), nEquivGrp = nEquivGrp, groups = groups, mods = mods)
```

```
## png
##   2
```

This file (“Model grouping colormap.pdf”) should now be in your working directory. It is a color map reference for understanding model constraints. For example, model 1 has all different colored boxes representing unconstrained \(\alpha\)s and unconstrained betas, whereas, the second to last model has only two box colors - one for all \(\alpha\)s indicating that they all have constrained equivalence and the other indicating that all \(\beta\)s also have constrained equivalence. Constant decay models (i.e., \(\beta\)s = 0) are indicated with gray color in the \(\beta\) columns.

## 5. MODEL OPTIMIZATION

Determine the bounds for \(\alpha\) and \(\beta\) parameters. The bounds on \(\alpha\) and \(\beta\) are related to distinguishing constant decay, and decaying decay as described in the modeling supplement of [Sorenson et al., 2018](http://www.pnas.org/content/early/2018/01/30/1712312115.short).

*Care should be taken in determining these bounds given each experimental design.* We have provided functions to aid in selection of the lower bounds of \(\alpha\) and \(\beta\) (`a_low` and `b_low`, respectively), and upper bound for \(\alpha\) (`a_high`). These functions calculate limits based on the time points data were collected. For example, if abundance for an unstable mRNA is measured at the first time point to be 0.02% of the initial (T0) abundance, the information needed to estimate this decay rate was not collected. So, `a_high` caluclates the maximum estimatable decay rate based on the time at which the first decay data point was collected. Similarly, the lower bound for \(\beta\) is required to distinguish the constant decay model (`const_decay`) from the decaying decay model (`decaying_decay`). The upper bound for \(\beta\) is required to distinguish the no decay model (`const_decay(0,t)`) from decaying decay model. If \(\beta\) is too small 1-exp(-\(\beta\)\*t) ~ -\(\beta\)\*t and c(t) ~ exp(-\(\alpha\)\*t); therefore, we can’t distinguish between constant decay and decaying decay models. If \(\beta\) is too big 1-exp(-\(\beta\)\*t) ~ 1 and c(t) ~ exp(-\(\alpha\)/\(\beta\)), a constant, we can’t distinguish between no decay and decaying decay models. Refer to [Sorenson et al. (2018)](http://www.pnas.org/content/early/2018/01/30/1712312115.short) supplemental material for more detail about how we calculated the bounds for \(\alpha\) and \(\beta\).

```
a_bounds <- c(a_low(max(decay_data$t.decay)),
             a_high(min(unique(decay_data$t.decay)[unique(decay_data$t.decay)>0])))
b_bounds <- c(b_low(max(decay_data$t.decay)), 0.075)
a_bounds;b_bounds
```

```
## [1] 0.0001 0.7100
```

```
## [1] 0.001 0.075
```

Modeling is accomplished using the `mod_optimization` function. The function takes as arguments, the gene identifier, \(\alpha\) and \(\beta\) bounds, the `decay_data` data frame, a vector of model names to run optimization for (e.g., as `c("mod1", "mod239", ... )`, the equivalence constraint matrix (defined as `groups` above), and a matrix to specify which contstraint groupings to use for \(\alpha\) and \(\beta\) parameters (defined as `mods` above), respectively, for each model, and a results folder (which will be made if it doesn’t already exist) to which the results are written. A number of other arguments are available as well, see help file for details using `?mod_optimization`.

Efficient model parameter optimization is accomplished using objective functions coded as binary dynamically linked shared libraries. These libraries are compiled from functions coded in the C++ language using functionality of the `TMB` package. The compiled files are dynamically linked library (\*.dll, for Windows) or shared object (\*.so, linux and Mac) files for each of the objective functions. If RNAdecay is installed from source, compiling C++ code will require a compiler be installed separatedly on your system (e.g., Rtools34 or later for Windows, <https://cran.r-project.org/bin/windows/Rtools/>; Xcode comand line tools for Mac, <http://railsapps.github.io/xcode-command-line-tools.html>; R development package for Linux, r-base-dev). If you don’t already have one of these installed, install one and restart R. C++ source files are located in the installed ‘RNAdecay/src’ folder. The compiled (shared library) files should also be written to this same folder upon installation.

Test the modeling on a couple of genes on a handful of models.

```
mod_optimization("AT2G18150", decay_data, group = groups, mod = mods, a_bounds, b_bounds, c("mod1", "mod2", "mod16", "mod239", "mod240"), file_only = FALSE, path = wrdir)
```

```
## AT2G18150 done
```

```
##           geneID    mod     alpha_WT    alpha_sov    alpha_vcs alpha_vcs.sov
## mod1   AT2G18150   mod1 0.0001000011 0.0005096462 0.0008160564  0.0019003637
## mod2   AT2G18150   mod2 0.0001000012 0.0001000005 0.0008160548  0.0019003739
## mod16  AT2G18150  mod16 0.0001000003 0.0001000002 0.0006962181  0.0016237439
## mod239 AT2G18150 mod239 0.0009407433 0.0009407433 0.0009407433  0.0009407433
## mod240 AT2G18150 mod240 0.0001403765 0.0001403765 0.0001403765  0.0001403765
##           beta_WT    beta_sov    beta_vcs beta_vcs.sov    sigma2    logLik nPar
## mod1   0.07499999 0.074999746 0.001000000  0.001000000 0.1155597 -43.51417    9
## mod2   0.07499931 0.001000003 0.001000003  0.001000003 0.1162461 -43.89319    7
## mod16  0.00000000 0.000000000 0.000000000  0.000000000 0.1178604 -44.77586    5
## mod239 0.01558834 0.015588337 0.015588337  0.015588337 0.1314419 -51.75597    3
## mod240 0.00000000 0.000000000 0.000000000  0.000000000 0.1321416 -52.09573    2
##        nStarts  J     range.LL nUnique.LL      C.alpha       C.beta
## mod1        50 50 9.826572e-06          1 5.235016e-04 2.810667e-05
## mod2        50 46 4.761196e-04          3 8.856078e-05 1.016522e-04
## mod16       50 38 1.953649e-02         13 2.909955e-04 0.000000e+00
## mod239      50 50 0.000000e+00          1 2.358263e-07 2.028587e-07
## mod240      50 50 3.765876e-13          1 6.230922e-08 0.000000e+00
##               C.tot     AICc AICc_est
## mod1   5.516082e-04 106.5538 106.5538
## mod2   1.902129e-04 102.7197 102.7197
## mod16  2.909955e-04 100.0435 100.0435
## mod239 4.386850e-07 109.7055 109.7055
## mod240 6.230922e-08 108.2875 108.2875
```

```
mod_optimization("AT4G09680", decay_data, group = groups, mod = mods, a_bounds, b_bounds, c("mod1", "mod2", "mod16", "mod239", "mod240"), file_only = FALSE, path = wrdir)
```

```
## AT4G09680 done
```

```
##           geneID    mod    alpha_WT   alpha_sov   alpha_vcs alpha_vcs.sov
## mod1   AT4G09680   mod1 0.006151427 0.008553631 0.008342841   0.004383190
## mod2   AT4G09680   mod2 0.006151427 0.007880245 0.009021613   0.004316542
## mod16  AT4G09680  mod16 0.004257736 0.005375819 0.006498702   0.002395319
## mod239 AT4G09680 mod239 0.006823760 0.006823760 0.006823760   0.006823760
## mod240 AT4G09680 mod240 0.004351118 0.004351118 0.004351118   0.004351118
##            beta_WT    beta_sov    beta_vcs beta_vcs.sov      sigma2    logLik
## mod1   0.003531260 0.005527378 0.003470373  0.004653506 0.003781782 175.33971
## mod2   0.003531260 0.004501912 0.004501912  0.004501912 0.003862530 173.98757
## mod16  0.000000000 0.000000000 0.000000000  0.000000000 0.007170759 134.39147
## mod239 0.004544744 0.004544744 0.004544744  0.004544744 0.008177741 125.98159
## mod240 0.000000000 0.000000000 0.000000000  0.000000000 0.012303559  99.83933
##        nPar nStarts  J     range.LL nUnique.LL      C.alpha       C.beta
## mod1      9      50 50 1.691092e-11          1 2.049438e-07 4.095106e-07
## mod2      7      50 50 3.001333e-11          1 2.132652e-07 3.814879e-07
## mod16     5      50 50 7.929657e-12          1 1.853857e-07 0.000000e+00
## mod239    3      50 50 7.929657e-12          1 8.479370e-08 2.696959e-07
## mod240    2      50 50 0.000000e+00          1 9.466260e-09 0.000000e+00
##               C.tot      AICc  AICc_est
## mod1   6.144544e-07 -331.1540 -331.1540
## mod2   5.947531e-07 -333.0418 -333.0418
## mod16  1.853857e-07 -258.2911 -258.2911
## mod239 3.544896e-07 -245.7696 -245.7696
## mod240 9.466260e-09 -195.5827 -195.5827
```

Next, run all the models on each and every gene. This requires significant computational resources depending on data set size, number of models, and computing speed. The sample data set has 8 time points x 4 replicates each x 4 treatments (= 128 samples) for 118 genes and requires about 10 h processor time. 20000 genes at ~5 min each is ~70 d processor time, so be sure to test a few different models on a few handfuls of genes to feel comfortable running all the modeling. We recommend parallel processing (on multiple processor cores) using `parallel::mclapply` to cut overall time. If this function is unavailable on your machine (e.g., on *Windows*) you can use lapply, but it will take much longer. `mod_optimization()` writes results to file in tab-delimited form, and, optionally, can also return them as a data frame object.

```
####### To run all genes in parallel use:
# parallel::mclapply(ids, FUN = mod_optimization,
#                    data = decay_data, group = groups, mod = mods,
#                    alpha_bounds = a_bounds, beta_bounds = b_bounds,
#                    models = paste0("mod", 1:240),
#                    path = paste0(wrdir, "/modeling_results"),
#   mc.cores = getOption("mc.cores",  15L), # set the number of compute cores to use here (e.g., 9L = 9 cores, 11L = 11 cores)
#   mc.preschedule = TRUE,
#   mc.set.seed = TRUE,
#   mc.silent = FALSE,
#   mc.cleanup = TRUE,
#   mc.allow.recursive = TRUE)
```

The entire example data set takes ~ 10 h processor time with lapply so for this example we will randomly select one gene ID to run here.

```
test_ids <- sample(ids, 1) # NOTE: that everytime this line is run it generates a different random sampling, therefore the gene modeled below will be different each time this code is run. To test the exact gene shown in the vignette make a new character vector of the gene id reported below and pass it to the gene argument of mod_optimization using lapply instead of passing 'test_ids' as we do here.
test_ids
```

```
## [1] "AT2G34050"
```

```
a <- proc.time()[3]
models <- lapply(X = test_ids, # alternatively use `ids` here to complete the entire sample data set, but be prepared to wait ~ 10 h. These gene IDs will get passed one at time to the "gene" argument of mod_optimization() and return a list of the results data frame.
                FUN = mod_optimization,
                data = decay_data,
                group = groups,
                mod = mods,
                alpha_bounds = a_bounds,
                beta_bounds = b_bounds,
                models = rownames(mods),
                path = paste0(wrdir, "/modeling_results"),
                file_only = FALSE)
```

```
## AT2G34050 done
```

```
names(models) <- test_ids
b <- proc.time()[3]
(b-a)/60/length(test_ids) # gives you average min per gene
```

```
## elapsed
##  3.1029
```

For each gene, read in the results data frame written by `mod_optimization` as an element of a single list object.

```
models <- lapply( paste0( wrdir, "/modeling_results/", test_ids, "_results.txt"), read.delim, header = TRUE )
names(models) <- test_ids
```

## 6. MODEL SELECTION

The AICc statistic is used to compare model performance. Better models have lower AICc values. Select a single model for each gene based on the lowest AICc statistic. We will continue here with the `RNAdecay::models` data included in the package which uses all 118 genes from the sample data set `RNAdecay::decay_data`.

```
models <- RNAdecay::models # built-in example data, comment this line out to continue with your own modelling output
results <- t(sapply(models, function(x) x[x[, "AICc"] == min(x[, "AICc"]), ]))
results <- as.data.frame(results)
results[, 1:2] <- sapply(as.data.frame(results[, 1:2]), function(x) as.character(unlist(x)))
results[, -c(1,2)] <- sapply(results[, -c(1,2)], unlist)
write.table(results, file = paste0(wrdir,"/best model results.txt"), sep = "\t")
results <- read.delim(paste0(wrdir,"/best model results.txt"))
```

Generate some graphics to visualize results.

```
library(ggplot2)
pdf(paste0(wrdir,"/distributions of stats.pdf"))
p <- ggplot(results)
print(p+geom_histogram(aes(x = sigma2), bins = 300)+
        coord_cartesian(xlim = c(0,0.5))+
        geom_vline(xintercept = 0.0625,color = "red2")+
        plain_theme())
print(p+stat_bin(aes(x = sigma2), breaks = c(seq(0,0.25,0.25/50),1), geom = "bar")+coord_cartesian(xlim = c(0,0.25)))
print(p+stat_ecdf(aes(sigma2), geom = "line")+
        coord_cartesian(xlim = c(0,0.5)))
print(p+stat_ecdf(aes(sqrt(sigma2)), geom = "line")+
        coord_cartesian(xlim = c(0,sqrt(0.5))))
print(p+geom_histogram(aes(x = range.LL), bins = 60))
print(p+geom_histogram(aes(x = nUnique.LL), bins = 60))
dev.off()
```

```
## png
##   2
```

```
pdf(paste0(wrdir,"/lowest AICc model counts.pdf"), height = 8, width = 32)
p <- ggplot(data = data.frame(
  model = as.integer(gsub("mod","",names(table(results$mod)))),
  counts = as.integer(table(results$mod))))+
  geom_bar(aes(x = model, y = counts), stat = "identity")+
  scale_x_continuous(limits = c(0,nrow(mods)), breaks = seq(0,nrow(mods),5))+
  ggtitle("model distribution of absolute lowest AICs")
print(p+plain_theme(25))
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_bar()`).
```

```
dev.off()
```

```
## png
##   2
```

Because two models are considered to perform differently if their AICc value difference is >2, any models that have AICc values within two of the model with the lowest AICc are considered to have performed similarly. The number of models performing similarly to the best model are plotted as a histogram here. The number of different alpha groupings represented in these models is also plotted.

```
min_mods <- sapply(models, function(x) which (x[, "AICc"] < (2+min(x[, "AICc"]))))
min_alpha_mods <- lapply(min_mods, function(x) unique(mods[x, "a"]))

pdf(paste0(wrdir,"/number of models that performed similar to the one selected.pdf"))
barplot(height = table(sapply(min_mods, length)), xlab = "No. models in the lowest AICc group (not more than 2 different from lowest)",
        ylab = "No. genes")
barplot(height = table(sapply(min_alpha_mods, length)), xlab = "No. alpha groups in the lowest AICc group (not more than 2 different from lowest)",
        ylab = "No. genes")
dev.off()
```

```
## png
##   2
```

Build the modeling results data frame. Group genes with similar \(\alpha\) groupings and then group genes with similar \(\beta\) groupings.

```
results <- read.delim(paste0(wrdir,"/best model results.txt"))
results$alpha_grp <- mods[as.character(results$mod), "a"]
results$beta_grp <- mods[as.character(results$mod), "b"]
results$mod <- as.numeric(gsub("mod", "", as.character(results$mod)))

results$alphaPattern <- sapply(rownames(results), function(x) {
  paste0(gsub("alpha_", "", colnames(results)[3:(2+nTreat)][order(unlist(round(results[x, 3:(2+nTreat)], 4)))]), collapse = "<=")
  })
results$alphaPattern <- paste0(results$alpha_grp, "_", results$alphaPattern)
results$betaPattern <- sapply(rownames(results), function(x){
  paste0(gsub("beta_", "", colnames(results)[(3+nTreat):(2+2*nTreat)][order(unlist(round(results[x, (3+nTreat):(2+2*nTreat)], 4)))]), collapse = "<=")
  })
results$betaPattern <- paste0(results$beta_grp, "_", results$betaPattern)

results <- results[order(rownames(results)), ]
results <- results[order(results$beta_grp), ]
results <- results[order(results$alphaPattern), ]
results <- results[order(results$alpha_grp), ]

results$alphaPattern <- factor(results$alphaPattern, levels = as.character(unique(results$alphaPattern)))

results <- data.frame(results[, 3:(2*nTreat+3), 2], results[, c("AICc", "alpha_grp", "beta_grp", "alphaPattern", "betaPattern")])
results$nEqMods <- sapply(min_mods[rownames(results)], length)
results$nEqAgp <- sapply(min_alpha_mods[rownames(results)], length)

# Customize: add columns of relative alphas and betas as desired, e.g.:
results$rA_sov.WT    <- results$alpha_sov      / results$alpha_WT
results$rA_vcs.WT    <- results$alpha_vcs      / results$alpha_WT
results$rA_vcssov.WT <- results$alpha_vcs.sov  / results$alpha_WT

write.table(results, paste0(wrdir,"/alphas+betas+mods+grps+patterns+relABs.txt"), sep = "\t")

results <- read.delim(paste0(wrdir,"/alphas+betas+mods+grps+patterns+relABs.txt"), header = TRUE, colClasses =  c(NA, rep("numeric", 2+2*nTreat), rep("integer", 2), rep("character", 2), rep("integer", 2), rep("numeric", 3)))
# results$alpha_subgroup <- factor(results$alpha_subgroup, levels = unique(results$alpha_subgroup))
results$alphaPattern <- factor(results$alphaPattern, levels = unique(results$alphaPattern))
results$betaPattern <- factor(results$betaPattern, levels = unique(results$betaPattern))
results[1:3, ]
```

```
##             alpha_WT  alpha_sov  alpha_vcs alpha_vcs.sov    beta_WT   beta_sov
## AT1G69760 0.05813074 0.06732814 0.01556491   0.006992057 0.02257430 0.02257430
## AT2G01430 0.08379579 0.05122255 0.01793076   0.014767874 0.07500000 0.07500000
## AT5G11090 0.07968370 0.06943801 0.01926957   0.030393364 0.07125452 0.07125452
##              beta_vcs beta_vcs.sov      sigma2      AICc alpha_grp beta_grp
## AT1G69760 0.005966764  0.002746884 0.009627945 -214.7804         1       11
## AT2G01430 0.014944595  0.014944595 0.017846952 -137.8476         1       12
## AT5G11090 0.011931300  0.027141770 0.007789566 -241.9016         1       11
##                      alphaPattern              betaPattern nEqMods nEqAgp
## AT1G69760 1_vcs.sov<=vcs<=WT<=sov 11_vcs.sov<=vcs<=WT<=sov       8      2
## AT2G01430 1_vcs.sov<=vcs<=sov<=WT 12_vcs<=vcs.sov<=WT<=sov       4      2
## AT5G11090 1_vcs<=vcs.sov<=sov<=WT 11_vcs<=vcs.sov<=WT<=sov       3      2
##           rA_sov.WT rA_vcs.WT rA_vcssov.WT
## AT1G69760 1.1582193 0.2677570    0.1202816
## AT2G01430 0.6112783 0.2139816    0.1762365
## AT5G11090 0.8714205 0.2418258    0.3814251
```

All files were written to the `wrdir`. The modeling results are now ready to be visualized.

# III. DATA VISULIZATION

## 7. LOAD DECAY DATA AND MODELING RESULTS (AND, OPTIONALLY, GENE DESCRIPTIONS)

Load normalized read data and reorder factor levels of “treatment” as you would like them to appear in the plot key and in the order you want them to plot.

```
library(RNAdecay)
decay_data <- RNAdecay::decay_data # built-in package example data; comment this line out to use your own decay_data
decay_data$treatment <- factor(decay_data$treatment, levels = c("WT", "sov", "vcs", "vs")) # you must type them identically in the new order
levels(decay_data$treatment)[4] <- "vcs.sov"
decay_data[1:4,]
```

```
##      geneID treatment t.decay  rep     value
## 1 AT1G02860        WT       0 rep1 1.0051056
## 2 AT1G09660        WT       0 rep1 1.1187229
## 3 AT1G13360        WT       0 rep1 1.0821496
## 4 AT1G22470        WT       0 rep1 0.9173587
```

Load modeling results.

```
results <- RNAdecay::results # built-in package example data; comment this line out to use your own results
# For example:
# results <- read.delim(paste0(tempdir(),"/DecayAnalysis/Example analysis results 2/alphas+betas+mods+grps+patterns+relABs.txt"), header = TRUE, colClasses =  c(NA, rep("numeric", 9), rep("integer", 3), rep("character", 3), rep("numeric", 6)))
# results$alpha_subgroup <- factor(results$alpha_subgroup, levels = unique(results$alpha_subgroup))
results[1:3, ]
```

```
##              alpha_WT   alpha_sov   alpha_vcs alpha_vcs.sov     beta_WT
## AT1G02860 0.006571237 0.006571237 0.006571237   0.002956901 0.004372148
## AT1G09660 0.006349482 0.006349482 0.006349482   0.003583661 0.005964932
## AT1G13360 0.065720699 0.065720699 0.019776977   0.019776977 0.027849987
##              beta_sov    beta_vcs beta_vcs.sov      sigma2 mod alpha_grp
## AT1G02860 0.004372148 0.004372148  0.004372148 0.013891487  79         5
## AT1G09660 0.005964932 0.009436538  0.005964932 0.006533780  68         5
## AT1G13360 0.027849987 0.005538462  0.005538462 0.004749049 188        12
##           beta_grp alpha_subgroup             alphaPattern
## AT1G02860       15            5.1  5_vcs.sov<=WT<=sov<=vcs
## AT1G09660        4            5.1  5_vcs.sov<=WT<=sov<=vcs
## AT1G13360       12           12.1 12_vcs<=vcs.sov<=WT<=sov
##                        betaPattern rA_WT rA_sov    rA_vcs rA_vcssov nEqMods
## AT1G02860 15_WT<=sov<=vcs<=vcs.sov     1      1 1.0000000 0.4499763       9
## AT1G09660  4_WT<=sov<=vcs.sov<=vcs     1      1 1.0000000 0.5644021      13
## AT1G13360 12_vcs<=vcs.sov<=WT<=sov     1      1 0.3009246 0.3009246       4
##           nEqAgp
## AT1G02860      3
## AT1G09660      4
## AT1G13360      2
```

Optionally, for printing gene descriptions directly on the plot, load a gene description file and then generate a character vector of descriptions with elements named with geneIDs (e.g., for *Arabidopsis thaliana*, download and unzip <https://www.arabidopsis.org/download_files/Genes/TAIR10_genome_release/gene_description_20131231.txt.gz>, and place it in your working directory).

```
# gene_desc <- read.delim("gene_description_20140101.txt"), quote = NULL, comment = '', header = FALSE)
# gene_desc[, 1] <- substr(gene_desc[, 1], 1, 9)
# gene_desc <- data.frame(gene_desc[!duplicated(gene_desc[, 1]), ], row.names = 1)
# colnames(gene_desc) <- c("type", "short description", "long description", "computational description")
# descriptions <- gene_desc[, "long description"]
# names(descriptions) <- rownames(gene_desc)

descriptions <- c(
  "Encodes a ubiquitin E3 ligase with RING and SPX domains that is involved in mediating immune responses and mediates degradation of PHT1s at plasma membranes.  Targeted by MIR827. Ubiquitinates PHT1;3, PHT1;2, PHT1;1/AtPT1 and PHT1;4/AtPT2.",
  "",
  "Related to Cys2/His2-type zinc-finger proteins found in higher plants. Compensated for a subset of calcineurin deficiency in yeast. Salt tolerance produced by ZAT10 appeared to be partially dependent on ENA1/PMR2, a P-type ATPase required for Li+ and Na+ efflux in yeast. The protein is localized to the nucleus, acts as a transcriptional repressor and is responsive to chitin oligomers. Also involved in response to photooxidative stress.",
  "Encodes a stress enhanced protein that localizes to the thylakoid membrane and whose mRNA is upregulated in response to high light intensity.  It may be involved in chlorophyll binding."
  )
names(descriptions) <- c("AT1G02860","AT5G54730", "AT1G27730", "AT4G34190")
```

## 8. PRINT DECAY PLOTS TO PDF

Plot a single gene using `decay_plot`. If you do not have a gene desription file, do not include “Desc” in the `what` argument (see `?decay_plot`).

```
p <- decay_plot(geneID = "AT1G02860",
              xlim = c(0, 350),
              ylim = c(0, 1.25),
              xticks = 1:5*100,
              yticks = 0:5/4,
              alphaSZ  =  12,
              what  =  c("meanSE", "reps", "models"),
              treatments  =  c("WT", "vcs.sov"),
              colors = c("darkblue", "red3"),
              DATA = decay_data,
              mod.results = results,
              gdesc = descriptions)
# print(p+plain_theme(8, 1, leg.pos = c(0.7, 0.8))) #this will print the plot to your current graphics device (dev.cur() tells you what that is), if you do not have a graphics device open (e.g., "null device") initiate one (e.g., use quartz(),pdf(), or windows(); dev.off() closes the device and writes the file).
```

Plot one or multiple genes; write them to a pdf file.

```
# make new directory for results
wrdir <- paste0(tempdir(),"/DecayAnalysis/Example analysis results 3")
if(!file.exists(wrdir)) dir.create(wrdir, recursive = TRUE)

pdf(paste0(wrdir, "/decay plot example.pdf"), width = 10, height = 8)
p <- decay_plot(geneID = "AT1G02860",
              xlim = c(0, 500),
              ylim = c(0, 1.25),
              xticks = 1:5*100,
              yticks = 0:5/4,
              alphaSZ = 10,
              what = c("Desc","meanSE", "reps", "models","alphas&betas"),
              treatments = c("WT", "vcs.sov"),
              colors = c("darkblue", "red3"),
              DATA = decay_data,
              mod.results = results,
              gdesc = descriptions)
print(p+plain_theme(32, 1, leg.pos = 'right'))
dev.off()
```

```
## png
##   2
```

```
# plot multiple genes
ids <- c("AT5G54730", "AT1G27730", "AT4G34190")
# or e.g.,
# ids <- rownames(results[results$alpha_WT > 0.1, ])

pdf(paste0(wrdir, "/multiple RNA decay plots.pdf"), width = 10, height = 7)
for(i in ids){
  p <- decay_plot(i,
                what = c("meanSE", "models", "Desc"),
                mod.results = results,
                gdesc = descriptions,
                treatments = c("WT","sov","vcs","vcs.sov"),
                DATA = decay_data)
  print(p+plain_theme(13.8, 1, leg.pos = 'right'))
  cat(i, " plotted.\n")
}
```

```
## AT5G54730  plotted.
```

```
## AT1G27730  plotted.
```

```
## AT4G34190  plotted.
```

```
dev.off()
```

```
## png
##   2
```

Plot one or multiple genes using hl\_plot; write them to a pdf file.

```
pdf(paste0(wrdir, "/halflife plot example.pdf"), width = 10, height = 8)

p <- hl_plot(geneID = "AT1G02860",
             gene_symbol = "SYG1",
             df_decay_rates = RNAdecay::results,
             hl_dist_treatment = "WT",
             hl_treatment = c("WT","sov","vcs","vcs.sov"),
             arrow_lab_loc = "key"
             )

print(p)
```

```
## Warning: Using linewidth for a discrete variable is not advised.
```

```
## Warning: Removed 20 rows containing non-finite outside the scale range
## (`stat_bin()`).
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

```
dev.off()
```

```
## png
##   2
```

```
# plot multiple genes
ids <- c("AT5G54730", "AT1G27730", "AT4G34190")
# or e.g.,
# ids <- rownames(results[results$alpha_WT > 0.1, ])

pdf(paste0(wrdir, "/multiple halflife plots.pdf"), width = 4, height = 4)
for(i in ids) {

p <- hl_plot(geneID = i,
             df_decay_rates = RNAdecay::results,
             hl_dist_treatment = "WT",
             hl_treatment = c("WT","sov","vcs","vcs.sov"),
             arrow_lab_loc = "plot"
             )
  print(p+plain_theme(8, 1,leg.pos = 'right'))
  cat(i, " plotted.\n")

  }
```

```
## Warning: Removed 20 rows containing non-finite outside the scale range (`stat_bin()`).
## Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

```
## AT5G54730  plotted.
```

```
## Warning: Removed 20 rows containing non-finite outside the scale range (`stat_bin()`).
## Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

```
## AT1G27730  plotted.
```

```
## Warning: Removed 20 rows containing non-finite outside the scale range (`stat_bin()`).
## Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

```
## AT4G34190  plotted.
```

```
dev.off()
```

```
## png
##   2
```

## 9. Session Information of Most Recent Update

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_4.0.1   RNAdecay_1.30.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4       gtable_0.3.6       jsonlite_2.0.0     dplyr_1.1.4
##  [5] compiler_4.5.1     gtools_3.9.5       tidyselect_1.2.1   Rcpp_1.1.0
##  [9] stringr_1.6.0      bitops_1.0-9       dichromat_2.0-0.1  jquerylib_0.1.4
## [13] scales_1.4.0       yaml_2.3.10        fastmap_1.2.0      lattice_0.22-7
## [17] R6_2.6.1           plyr_1.8.9         labeling_0.4.3     generics_0.1.4
## [21] knitr_1.50         tibble_3.3.0       nloptr_2.2.1       pillar_1.11.1
## [25] bslib_0.9.0        RColorBrewer_1.1-3 TMB_1.9.18         rlang_1.1.6
## [29] cachem_1.1.0       stringi_1.8.7      xfun_0.54          caTools_1.18.3
## [33] sass_0.4.10        S7_0.2.1           cli_3.6.5          withr_3.0.2
## [37] magrittr_2.0.4     digest_0.6.38      grid_4.5.1         lifecycle_1.0.4
## [41] vctrs_0.6.5        KernSmooth_2.23-26 evaluate_1.0.5     glue_1.8.0
## [45] farver_2.1.2       reshape2_1.4.5     rmarkdown_2.30     pkgconfig_2.0.3
## [49] tools_4.5.1        htmltools_0.5.8.1  gplots_3.2.0
```