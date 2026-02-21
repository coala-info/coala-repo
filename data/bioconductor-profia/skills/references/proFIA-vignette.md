# *proFIA*: Preprocessing data from flow injection analysis coupled to high-resolution mass spectrometry (FIA-HRMS)

#### *Alexis Delabriere and Etienne Thevenot*

#### *2017-04-24*

# Contents

* [1 Context](#context)
* [2 Workflow](#workflow)
* [3 The ***plasFIA*** data package](#the-plasfia-data-package)
* [4 Hands-on](#hands-on)
  + [4.1 Peak detection with `proFIAset`](#peak-detection-with-profiaset)
  + [4.2 Peak grouping with `group.FIA`](#peak-grouping-with-group.fia)
  + [4.3 Peak table with `makeDataMatrix`](#peak-table-with-makedatamatrix)
  + [4.4 Imputation with `imputeMissingValues.WKNN_T`](#imputation-with-imputemissingvalues.wknn_t)
  + [4.5 Quality evaluation with `plot`](#quality-evaluation-with-plot)
  + [4.6 Running the whole workflow with `analyzeAcquisitionFIA`](#running-the-whole-workflow-with-analyzeacquisitionfia)
  + [4.7 Export](#export)
  + [4.8 Examples of downstream statistical analyzes](#examples-of-downstream-statistical-analyzes)
* [5 Session info](#session-info)

# 1 Context

Flow injection analysis (FIA) is becoming more and more used in the context of high-throughput profiling, because of an increased resolution of mass spectrometers (HRMS). The data produced however are complex and affected by matrix effect which makes their processing difficult. The ***proFIA*** bioconductor package provides the first workflow to process FIA-HRMS raw data and generate the peak table. By taking into account the high resolution and the information of matrix effect available from multiple scans, the algorithms are robust and provide maximum information about ions m/z and intensitie using the full capability of modern mass spectrometers.

# 2 Workflow

![proFIA workflow](data:image/png;base64...)

The first step generates the `proFIAset` object, which will be further processed during the workflow. The object contains initial information about the sample and the classes (when subdirectories for the raw data are present), as well as all results froom the processing (e.g., detected peaks, grouping, etc.). At each step, the data quality can be checked by a grphical overview using the `plot` function. For convenience, the 3 processing functions and methods from the workflow (`proFIAset`, `group.FIA`, and `imputeMissingValues.WKNN_T`) have been wrapped into a single `analyzeAcquisitionFIA` function. The final *dataMatrix* can be exported, as well as the 2 supplementary tables containing the *sampleMetadata* and the *variableMetadata*.

Note that the 3 exported ‘.tsv’ files can be directly used in the Galaxy-based [Workflow4metabolomics](http://workflow4metabolomics.org) infrastructure for subsequent statistical analysis and annotation (Giacomoni et al. 2015).

# 3 The ***plasFIA*** data package

A real data set consisting of human plasma spiked with 40 molecules at 3 increasing concentrations was acquired on an Orbitrap mass spectrometer with 2 replicates, in the positive ionization mode (U. Hohenester and C. Junot, [LEMM laboratory](http://ibitecs.cea.fr/drf/ibitecs/english/Pages/units/spi/lemm.aspx), CEA, [MetaboHUB](http://www.metabohub.fr/index.php?lang=en&Itemid=473)). The 10 files are available in the ***plasFIA*** bioconductor data package, in the mzML format (centroid mode).

# 4 Hands-on

## 4.1 Peak detection with `proFIAset`

We first load the two packages containing the software and the dataset:

```
# loading the packages
library(proFIA)
library(plasFIA)
```

```
# finding the directory of the raw files
path <- system.file(package="plasFIA", "mzML")
list.files(path)
```

```
## [1] "C100A.mzML" "C100B.mzML" "C10A.mzML"  "C10B.mzML"  "C1A.mzML"
## [6] "C1B.mzML"
```

The first step of the workflow is the **proFIAset** function which takes as input the path to the raw files. This function performs noise model building, followed by m/z strips detection and filtering. The important parameters to keep in mind are:

* `noiseEstimation` (logical): shall noise model be constructed to filter signal? (recommended).
* `ppm` and `dmz` (numeric): maximum deviation between scans during strips detection in ppm. If the deviation in absolute in mz is lower than dmz, *dmz* is taken over *ppm* to account for low masses bias.
* `parallel` (logical): shall parallel computation be used.

Note: 1. As all files need to be processed 2 times, one for noise estimation and one for model estimation, this step is the most time consuming of the workflow. 2. The `ppm` parameter is the most important of the workflow; the package was designed to work optimally for high-resolution data with an accuracy inferior or equal to 5 ppm.

```
# defining the ppm parameter adapted to the Orbitrap Fusion
ppm <- 2

# performing the first step of the workflow
plasSet <- proFIAset(path, ppm=ppm, parallel=FALSE)
```

```
## Warning in nls.lm(par = initpar, fn = matResiduals, observed = tMat, type = "gaussian", : lmdif: info = -1. Number of iterations has reached `maxiter' == 100.

## Warning in nls.lm(par = initpar, fn = matResiduals, observed = tMat, type = "gaussian", : lmdif: info = -1. Number of iterations has reached `maxiter' == 100.

## Warning in nls.lm(par = initpar, fn = matResiduals, observed = tMat, type = "gaussian", : lmdif: info = -1. Number of iterations has reached `maxiter' == 100.
```

The quality of peak detection can be assessed by using the `plotRaw` method to visualize the corresponding areas in the raw data.

```
# loading the spiked molecules data frame
data("plasMols")

# plotting the raw region aroung the Diphenhydramine mass signal
plasMols[7,]
```

```
##    formula           names classes     mass mass_M+H
## 7 C17H21NO Diphenhydramine Benzene 255.1623 256.1696
```

```
mzrange <- c(plasMols[7,"mass_M+H"]-0.1,plasMols[7,"mass_M+H"]+0.1)
plotRaw(plasSet, type="r", sample=3, ylim=mzrange, size=0.6)
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

![](data:image/png;base64...)

In the example above, we see that a signal at 256.195 m/z corresponding to the solvent has been correctly discarded by ***proFIA***.

```
# plotting the filter Dipehnhydramine region.
plotRaw(plasSet, type="p", sample=3, ylim=mzrange, size=0.6)
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

![](data:image/png;base64...)

Peak detection in ***proFIA*** is based on matched filtering. It therefore relies on a peak model which is tuned on the signals from the most intense ions. The `plotModelFlowgrams` method allows to check visually the consistency of these reconstructed filters.

```
# plotting the injection peak
plotSamplePeaks(plasSet)
```

![](data:image/png;base64...)

## 4.2 Peak grouping with `group.FIA`

The second step of the workflow consists in matching the signals between the samples. The `group.FIA` methods uses an estimation of the density in the mass dimension. The two important parameters are:

* `ppmGroup` (numeric): accuracy of the mass spectrometer; must be inferior or equal to the corresponding value in `proFIAset`,
* `fracGroup` (numeric): minimum fraction of samples with detected peaks in at least one class for a group to be created.

```
# selecting the parameters
ppmgroup <- 1

# due to the experimental design, sample fraction was set to 0.2
fracGroup <- 0.2

# grouping
plasSet <- group.FIA(plasSet, ppmGroup=ppmgroup, fracGroup=fracGroup)
```

```
##
##  812  groups have been done .
```

The groups may be visualized using the **plotFlowgrams** function, which take as input a mass and a ppm tolerance, or an index.

```
#plotting the EICs of the parameters.
plotFlowgrams(plasSet,mz=plasMols[4,"mass_M+H"])
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

```
## Create profile matrix with method 'bin' and step 1 ...
```

```
## OK
```

![](data:image/png;base64...)

At this stage, it is possible to check whether a molecule (i.e., a group) has been detected in the dataset by using the `findMzGroup` method.

```
# Searching for match group with 2 ppm tolerance
lMatch <- findMzGroup(plasSet,plasMols[,"mass_M+H"],tol=3)

# index of the 40 molecules which may be used with plotEICs
molFound <- data.frame(names=plasMols[,"names"],found=lMatch)
head(molFound)
```

```
##                          names found
## 1            Acetyl-L-carnitin   184
## 2            3-Methylhistamine    26
## 3                    Panthenol   191
## 4                    Metformin    34
## 5                 Azelaic acid    NA
## 6 D-erythro-Dihydrosphingosine   374
```

```
#Getting the molecules which are not detected
plasMols[which(is.na(lMatch)),]
```

```
##    formula                           names            classes     mass
## 5  C9H16O4                    Azelaic acid Dicarboxylic Acids 188.1049
## 16 C6H10O5 3-Hydroxy-3-methylglutaric acid Dicarboxylic Acids 162.0528
##    mass_M+H
## 5  189.1121
## 16 163.0601
```

We see that molecules 5 and 16 were not found, which is coherent with their chemical classes as they are both Dicarboxylic Acids, which ionizes in negative modes.

## 4.3 Peak table with `makeDataMatrix`

The data matrix (*peak table*) can be built with the `makeDataMatrix` method: ion intensities can be computed either as the areas of the peaks (`maxo=F`) which is considered to be more robust, or as the maximum intensities (`maxo=T`).

```
# building the data matrix
plasSet <- makeDataMatrix(plasSet, maxo=FALSE)
```

## 4.4 Imputation with `imputeMissingValues.WKNN_T`

Imputation of the data matrix is performed by using a weighted k-nearest neighbours approach. A good number for k is half the size of the smaller class. \* *k* (numeric): number of neighbours

```
# k is supposed to be 3 at minimum, however here we have only 2 sample by class, the results of the imputation are irrelevant.
k <- 3

#Missing values  imputation
plasSet <- imputeMissingValues.WKNN_TN(plasSet, k=k)

#Because of the too high k, we reinitialize the data matrix.
plasSet <- makeDataMatrix(plasSet)
```

It is good to note that *k* should be greater than 2 because the K-Nearest Neighbour algorithm for truncated distribution is based on correlation for measuring the similarity. As there is 2 replicates in each sample in this case k should have been set to 1, we fix *k* to 3 for demonstration purpose.

## 4.5 Quality evaluation with `plot`

Plot allows you yo obtain a quick overview of the data, by plotting a summary of the acquisition :

```
plot(plasSet)
```

```
## PCA
## 6 samples x 812 variables
## standard scaling of predictors
##       R2X(cum) pre ort
## Total    0.784   2   0
```

![](data:image/png;base64...) Note that all the graph are not all present at each step of the workflow. A small discussion of the content of each graph is given there :

* *Number of peaks* The upper graph show the number of relevant signal found in each sample, and labels the peaks in three cathegories. Peaks shifted in time correspond to peak which are outside the detected sample peak, and are probably results of rentention in the windows. Peak sufferient from shape distrosion are often affected by an heavy matrix effect, these 2 cathegories may indicate an issue in the acquisition. Well-behaved peak correspond to peak which follow the sample injection peak. For proFIA to perform optimally, the majority of these peak shloud be in this cathegory.
* *Injection Peaks* This give an overview of all the smaples injections peaks regressed by proFIA, if the Flow Injection condition are the same, they should have close shapes.
* *Density of m/z of found features* This plot is present after the goruping phase. The density of the found features. This plot may allows the spotting of a missed band detection, resulting in no group at the end of the range of m/z, which can be caused by a wrong *dmz* or *ppm* parmeter.
* *PCA* This graph is present after the data matrix construvtion. A simple ACP of the log intensity, allows you to quickly spot abherrant value in one acquisition.

## 4.6 Running the whole workflow with `analyzeAcquisitionFIA`

The whole workflow described previously can be run by a single call to the *analyzeAcquisitionFIA* function:

```
#selecting the parameters
ppm <- 2
ppmgroup <- 1
fracGroup <- 0.2
k <- 3

# running the whole workflow in a single step
plasSet <- analyzeAcquisitionFIA(path, ppm=ppm, ppmGroup=ppmgroup, k=k,fracGroup = fracGroup,parallel=FALSE)

# Running the wholoe workflow in a single step, using parallelism
# with the BiocParallel package
plasSet <- analyzeAcquisitionFIA(path, ppm=ppm, ppmGroup=ppmgroup, k=k,fracGroup = fracGroup,parallel=TRUE)
```

## 4.7 Export

The processed data can be exported either as:

* A peak table in a format similar to the XCMS output.
* An *ExpressionSet* object (see the [Biobase](http://bioconductor.org/packages/release/bioc/html/Biobase.html) bioconductor package).
* A peak table which may be created using the *exportPeakTable* function.
* 3 .tsv tabular files corresponding to the *dataMatrix*, the *sampleMetadata*, and the *variableMetadata*, and which are compatible with the [Workflow4metabolomics](http://workflow4metabolomics.org) format.

```
#Expression Set.
eset <- exportExpressionSet(plasSet)
eset
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 812 features, 6 samples
##   element names: exprs
## protocolData: none
## phenoData: none
## featureData
##   featureNames: M101.9499 M102.0550 ... M599.4031 (812 total)
##   fvarLabels: mzMed scanMin ... signalOverSolventPvalueMean (8
##     total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
#Peak Table.
pt <- exportPeakTable(plasSet)

#3 Tables:
dm <- exportDataMatrix(plasSet)
vm <- exportVariableMetadata(plasSet)
```

## 4.8 Examples of downstream statistical analyzes

Univariate and multivariate analyzes can be applied to the processed peak table. As an example, we perform a modeling of the spiking dilution with Orthogonal Partial Least Squares, by using the [ropls](http://bioconductor.org/packages/release/bioc/html/ropls.html) bioconductor package. This allows us to illustrate the efficiency of the matrix effect indicator.

```
library(ropls)

data("plasSamples")
vconcentration <- plasSamples[,"concentration_ng_ml"]
#vconcentration=(c(100,100,1000,1000,10000,10000)*10^-10)
peakTable <- exportPeakTable(plasSet,mval="zero")

###Cutting the useless column
dataMatrix <- peakTable[,1:nrow(phenoClasses(plasSet))]
```

```
## OPLS
## 6 samples x 812 variables and 1 response
## standard scaling of predictors and response(s)
##       R2X(cum) R2Y(cum) Q2(cum)  RMSEE pre ort pR2Y  pQ2
## Total    0.782    0.999   0.934 0.0413   1   1 0.15 0.15
```

```
plasSet.opls <- opls(t(peakTable),scale(log10(vconcentration)),predI = NA,log10L = TRUE, orthoI = NA)
```

As the variance explained Q2 is close to 0.8, so the fitted model explains the majority of the variance. The score plot and the observation diagnostic show that there as no aberrant deviation between samples. As the compounds are spiked with an increasing concentration of chemicals, this should be visible of the first components. The second effect affecting the experiment is the matrix effect. We expect the second compoennts of the model to represent suppressed peaks. We can easely see this by checking the VIP on the main components versus vip on the orthogonal component :

```
matEfInd <- peakTable$corSampPeakMean
nnaVl <- !is.na(matEfInd)
matEfInd <- matEfInd[nnaVl]
ordVi <- order(matEfInd)
matEfInd <- matEfInd[ordVi]
vipVn <- getVipVn(plasSet.opls)[nnaVl]
orthoVipVn <- getVipVn(plasSet.opls, orthoL = TRUE)[nnaVl]
colVc <- rev(rainbow(sum(nnaVl), end = 4/6))
plot(vipVn[ordVi], orthoVipVn[ordVi], pch = 16, col = colVc,
     xlab = "VIP", ylab = "VIP_ortho", main = "VIP_ortho vs VIP.",lwd=3)

##Adding the point corresponding to samples.
points(getVipVn(plasSet.opls)[lMatch],getVipVn(plasSet.opls, orthoL = TRUE)[lMatch], cex=1.2,pch=1,col="black",lwd=2)
legend("topright", legend = c(round(rev(range(matEfInd)), 2),"Spiked molecules."), pch=c(16,16,1),col = c(rev(colVc[c(1, length(colVc))]),1))
```

![](data:image/png;base64...) We see that the VIP of the first component are high when matrix effect is reduced and especially high for spiked molecules. The second axes seems to represent matrix effect. This illustrate the capacity of proFIA to extract interesting signal from raw data and to provides usefull visualisation to assess the quality of the data. The two clusters are probably caused by molecules naturally present in the plasma and molecules not present in the plasma.

# 5 Session info

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
## R version 3.4.0 (2017-04-21)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.2 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ropls_1.8.0         plasFIA_1.2.5       proFIA_1.2.0
##  [4] xcms_1.52.0         MSnbase_2.2.0       ProtGenerics_1.8.0
##  [7] mzR_2.10.0          Rcpp_0.12.10        BiocParallel_1.10.0
## [10] Biobase_2.36.0      BiocGenerics_0.22.0 BiocStyle_2.4.0
##
## loaded via a namespace (and not attached):
##  [1] minpack.lm_1.2-1       zoo_1.8-0              splines_3.4.0
##  [4] lattice_0.20-35        colorspace_1.3-2       htmltools_0.3.5
##  [7] stats4_3.4.0           yaml_2.1.14            pracma_2.0.4
## [10] vsn_3.44.0             XML_3.98-1.6           survival_2.41-3
## [13] affy_1.54.0            RColorBrewer_1.1-2     affyio_1.46.0
## [16] foreach_1.4.3          plyr_1.8.4             mzID_1.14.0
## [19] stringr_1.2.0          zlibbioc_1.22.0        munsell_0.4.3
## [22] pcaMethods_1.68.0      gtable_0.2.0           codetools_0.2-15
## [25] evaluate_0.10          knitr_1.15.1           miscTools_0.6-22
## [28] IRanges_2.10.0         doParallel_1.0.10      BiocInstaller_1.26.0
## [31] MassSpecWavelet_1.42.0 preprocessCore_1.38.0  scales_0.4.1
## [34] backports_1.0.5        limma_3.32.0           S4Vectors_0.14.0
## [37] FNN_1.1                maxLik_1.3-4           RANN_2.5
## [40] impute_1.50.0          ggplot2_2.2.1          digest_0.6.12
## [43] stringi_1.1.5          grid_3.4.0             rprojroot_1.2
## [46] quadprog_1.5-5         tools_3.4.0            sandwich_2.3-4
## [49] magrittr_1.5           lazyeval_0.2.0         tibble_1.3.0
## [52] MASS_7.3-47            Matrix_1.2-9           rmarkdown_1.4
## [55] iterators_1.0.8        MALDIquant_1.16.2      multtest_2.32.0
## [58] compiler_3.4.0
```

Giacomoni, F., G. Le Corguillé, M. Monsoor, M. Landi, P. Pericard, M. Pétéra, C. Duperier, et al. 2015. “Workflow4Metabolomics: A Collaborative Research Infrastructure for Computational Metabolomics.” *Bioinformatics* 31 (9): 1493–5. doi:[10.1093/bioinformatics/btu813](https://doi.org/10.1093/bioinformatics/btu813).