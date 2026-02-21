# ACE vignette

Jos B. Poell

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
  + [1.1 Why use ACE?](#why-use-ace)
  + [1.2 How ACE works](#how-ace-works)
* [2 Running ACE](#running-ace)
  + [2.1 Installation](#installation)
  + [2.2 Getting started](#getting-started)
  + [2.3 ACE output](#ace-output)
    - [2.3.1 rds-file](#rds-file)
    - [2.3.2 rds subdirectories](#rds-subdirectories)
    - [2.3.3 ploidies subdirectories](#ploidies-subdirectories)
    - [2.3.4 summaries](#summaries)
    - [2.3.5 likelyfits subdirectory](#likelyfits-subdirectory)
    - [2.3.6 individual sample subdirectories](#individual-sample-subdirectories)
    - [2.3.7 fitpicker tables](#fitpicker-tables)
  + [2.4 Model selection](#model-selection)
  + [2.5 Examining single samples](#examining-single-samples)
* [3 Advanced functions](#advanced-functions)
  + [3.1 getadjustedsegments](#getadjustedsegments)
  + [3.2 linkvariants](#linkvariants)
  + [3.3 analyzegenomiclocations](#analyzegenomiclocations)
  + [3.4 postanalysisloop](#postanalysisloop)
* [4 Advanced use](#advanced-use)
  + [4.1 Considerations for larger data sets](#considerations-for-larger-data-sets)
  + [4.2 Error methods](#error-methods)
  + [4.3 Penalizing lower cellularities](#penalizing-lower-cellularities)
  + [4.4 Chromosomal subsets](#chromosomal-subsets)
  + [4.5 Sex chromosomes](#sex-chromosomes)
* [5 Additional Functionality (accessory functions)](#additional-functionality-accessory-functions)
  + [5.0.1 ACEcall](#acecall)
  + [5.0.2 twosamplecompare](#twosamplecompare)
  + [5.0.3 squaremodelsummary](#squaremodelsummary)
  + [5.0.4 loopsquaremodel](#loopsquaremodel)
* [6 Information](#information)
  + [6.1 Contact](#contact)
  + [6.2 License](#license)
  + [6.3 Reference](#reference)
  + [6.4 Session information](#session-information)

# 1 Introduction

## 1.1 Why use ACE?

You want to know the percentage of tumor cells in your sample(s) and you have (preferably whole-genome) NGS data.
You want pretty copy number profiles of your samples.
You want to know how many copies are present of a certain chromosomal segment, or even gene, or mutation!

## 1.2 How ACE works

ACE is a an absolute copy number estimator that scales copy number data to fit with integer copy numbers. For this it uses segmented data from the QDNAseq package, which in turn uses a number of dependencies. Note: make sure QDNAseq fetches the bin annotations from the same genome build as the one used for aligning the sequencing data! On with ACE! In brief: ACE will run QDNAseq or use its output rds-file(s) of segmented data. It will subsequently run through all samples in the object(s), for which it will create individual subdirectories. For each sample, it will calculate how well the segments fit (the relative error) to integer copy numbers for each percentage of “tumor cells” (cells with divergent segments). Note that it does not estimate for a lower percentage than 5. ACE will output a graph with relative errors (all errors relative to the largest error). Said graph can be used to quickly identify the most likely fit. ACE selects all “minima” and saves the corresponding copy number plots. The “best fit” (lowest error) is not by definition the most likely fit! ACE will run models for a general tumor ploidy of 2N, but you can expand this to include any ploidy of your choosing. The program needs to make one assumption: the median bin segment value corresponds with the tumor’s general ploidy. If the median bin segment value of a sample (the “standard”) lies on a segment that happens to be 3N, but you only ran ACE on 2N, you can run that sample individually using the singlemodel function with argument ploidy = 3 (see section “examining single samples”). If the standard happens to be on a subclonal segment, you either have to manually change the standard, or use the squaremodel function (again, see below). The output of ACE is designed in such a way that it is “easy” to quickly analyze multiple samples. Bear in mind that it is absolutely necessary to manually select the most likely models! I have made a conscious decision not to let ACE “autopick” the best model. See below for a manual how to most efficiently pick the most likely models from your output. Let’s get started!

# 2 Running ACE

## 2.1 Installation

ACE is available through Bioconductor. In R, enter the commands:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
# BiocManager::install()
BiocManager::install("ACE")
```

The development version of ACE will be available on GitHub and can be installed as follows:

```
# install.packages("devtools")
devtools::install_github("tgac-vumc/ACE")
```

## 2.2 Getting started

The ACE package includes segmented data derived from low-coverage whole genome sequencing, which will be used throughout this vignette. The mapped sequencing data has been processed through the QDNAseq package. Users of ACE, however, are most likely to start from their own bam-files, not the pre-processed segmented data. runACE, the core functionality of ACE, will run a default set of QDNAseq functions if bam-files are provided as the data source (make sure the genome builds correspond, I cannot stress this enough). If you wish to run the code below, make sure the file paths are correct. To get started, I recommend using a directory that only contains a few bam-files. The function runACE is designed to automatically analyze all samples in a directory. Input should be either segmented QDNAseq-objects or aligned bam-files. For details on all arguments, consult the runACE documentation. Let’s get started!

```
# specify the directory containing your bam-files
userpath <- tempdir()
# if you do not want the output in the same directory, use argument outputdir
runACE(userpath, filetype='bam', binsizes = c(100, 1000),
       ploidies = c(2,4), imagetype='png')
```

If you do not have aligned bam-files ready to go, you can use the data provided in the package:

```
data("copyNumbersSegmented")
# specify the directory in which to create the output
userpath <- tempdir()
saveRDS(file.path(userpath,"copyNumbersSegmented.rds"))
runACE(userpath, filetype='rds', ploidies = c(2,4), imagetype='png')
```

## 2.3 ACE output

### 2.3.1 rds-file

This is the segmented QDNAseq object; obviously not created when using rds-file as input. It can be used if you want to run ACE again with slightly different parameters. More importantly, you can use this file to examine individual samples in downstream analyses.

### 2.3.2 rds subdirectories

ACE creates a subdirectory for each rds-file. In case of bam-files as input, the subdirectories have the names of the binsizes.

### 2.3.3 ploidies subdirectories

For each analyzed tumor ploidy, ACE makes a subdirectory. In this case: 2N and 4N

### 2.3.4 summaries

summary\_errors: error lists of all the models
summary\_likelyfits: copy number plots of the best fit and the last minimum of each sample, with the corresponding error list plots.
I would recommend using the likelyfits for model selection.
Summary files can become quite big / huge depending on sample size and bin size. See below how to deal with this.

### 2.3.5 likelyfits subdirectory

This subdirectory contains the individual copy number graphs of the likelyfits.

### 2.3.6 individual sample subdirectories

These subdirectories have a summary file with all the fits for the corresponding sample and the error list plot. Individual copy number graphs are available in the subdirectory “graphs”.

### 2.3.7 fitpicker tables

This tab-delimited file can be used during selection of most likely models. Especially handy when analyzing a large number of samples. More instructions below.

## 2.4 Model selection

Having this massive pile of output can be daunting, how do you make sense of it all?
First of all, if you have multiple bin sizes, you generally only need a single bin size for your model selection. I recommend using a relatively large bin size. File sizes are smaller and segmentation is often more robust. You can probably find the corresponding model in the smaller binsizes as well, if you prefer to use those for copy number graphs. Cellularities between corresponding models made with different bin sizes are usually very similar, but some fits may be “missed”. The most likely fit of a tumor is generally 1) the fit with the smallest error, or 2) the fit at the highest cellularity, so those two are presented in the summary\_likelyfits file. When you open this file, you see for each sample three plots in a row (in case of imagetype = ‘pdf’, it will make a new page from each plot). The first two of the three are copy number plots of the best fit (lowest relative error) and the last minimum, respectively. The third plot is the error list, which shows the relative error of the fit at each tested “cellularity” (tumor cell percentage). In most cases you will be able to pick a good fit from these graphs. The individual graph is then available in the likelyfits subdirectory. If none of the models fit well, or you think there might be a better fit possible, you can look at all fits in the summary file, available in the subdirectory of that sample. If there are still no good fits (e.g. the tumor has a ploidy of 3N and you did not include this ploidy), you have to do model fitting on this sample separately (see below).

You might want to go through your samples a bit more systematically, especially if you have many samples. You can open the fitpicker.tsv file, go through the fits of the summary file and note in the likely\_fit column of the picker table which fit you chose. Just leave open any samples of which you are not sure. The handy thing about the fitpicker files is that they have the list of your sample names and they have the list of cellularities.

Another feature that might help going through a lot of samples, is using the “penalty” parameter in the runACE call. This parameter penalizes fits at lower cellularities. Doing so greatly improves the chance that the best fit is also the most likely fit, but comes at the cost of precision at high cellularities and comes at the cost of sensitivity at low cellularities (but only at the lowest end of the spectrum, let’s say below 10%). More about this later.

In the two examples given below, it is quite obvious what the most likely appropriate models are: for sample 1 it is the “lastminimum” with a general ploidy of 2N and cellularity of 0.79, and for sample 2 it is the “bestfit” with a general ploidy of 2N and cellularity of 0.38. Examining the error plots of these samples draws a great picture of how obvious the right model can be for the trained eye, while it can be deceivingly tricky to rely on a simple computer algorithm to make the pick.

To reproduce some of the output created by runACE (which is only written to file), I have included the following code. The functions used will be explained in more detail later:

```
data("copyNumbersSegmented")
object <- copyNumbersSegmented
model1 <- singlemodel(object, QDNAseqobjectsample = 1)
bestfit1 <- model1$minima[tail(which(model1$rerror==min(model1$rerror)), 1)]
besterror1 <- min(model1$rerror)
lastfit1 <- tail(model1$minima, 1)
lasterror1 <- tail(model1$rerror, 1)
singleplot(object, QDNAseqobjectsample = 1, cellularity = bestfit1,
           error = besterror1, standard = model1$standard,
           title = "sample1 - binsize 1000 kbp - 379776 reads - 2N fit 1")
```

![](data:image/png;base64...)

```
singleplot(object, QDNAseqobjectsample = 1, cellularity = lastfit1,
           error = lasterror1, standard = model1$standard,
           title = "sample1 - binsize 1000 kbp - 379776 reads - 2N fit 7")
```

![](data:image/png;base64...)

```
model1$errorplot + ggtitle("sample1 - errorlist") +
  theme(plot.title = element_text(hjust = 0.5))
```

![](data:image/png;base64...)

```
model2 <- singlemodel(object, QDNAseqobjectsample = 2)
singleplot(object, QDNAseqobjectsample = 2, 0.38, 0.183,
           title = "sample2 - binsize 1000 kbp - 369331 reads - 2N fit 3")
```

![](data:image/png;base64...)

```
singleplot(object, QDNAseqobjectsample = 2, 0.94, 0.998,
           title = "sample2 - binsize 1000 kbp - 369331 reads - 2N fit 6")
```

![](data:image/png;base64...)

```
model2$errorplot +  ggtitle("sample2 - errorlist") +
  theme(plot.title = element_text(hjust = 0.5))
```

![](data:image/png;base64...)

So this should allow you to find the “easy” fits, what about those tricky ones?

## 2.5 Examining single samples

There are several reasons why you might want to zoom in on a single sample. Like mentioned before, it is necessary when the automatically generated fits are no good. Also, you might just be interested in a single sample from your object. Or perhaps you don’t want to create all the output, but just see the plots on your graphics device or put the segment data in a dataframe. Here is what to do!

The primary tools for examining single samples are the functions singlemodel and singleplot. Let’s say you don’t like the fit of sample2, because you’re superconvinced that it is mainly a 3N tumor.

```
data("copyNumbersSegmented")
object <- copyNumbersSegmented
# Since you're convinced the mode is 3N, you can run the singlemodel function to
# fit at ploidy = 3
model <- singlemodel(object, QDNAseqobjectsample = 2, ploidy = 3)
ls(model)
```

```
## [1] "errorlist" "errorplot" "method"    "minima"    "penalty"   "ploidy"
## [7] "rerror"    "standard"
```

```
model$minima
```

```
## [1] 0.14 0.20 0.46
```

```
model$rerror
```

```
## [1] 0.2426503 0.2180412 0.2449059
```

```
model$errorplot
```

![](data:image/png;base64...)

```
# Examining the errors can give you a feel for the fits. Experience tells
# us the last fit is probably the right one, so let's check out the copy number
# plot. Specify the same parameters, now including the cellularity derived from
# the model.
singleplot(object, QDNAseqobjectsample = 2, cellularity = 0.46, ploidy = 3)
```

![](data:image/png;base64...)

```
# That is actually a very nice fit, let's run with it!
# You can now save the plot however you like.
```

Model fitting as performed by singlemodel, but also runACE, starts with setting the median segment value of a sample to the specified integer ploidy (default = 2). This usually works very well, but in some cases the median segment value may lie on a subclonal segment. Using the argument “standard” you can specify the segment value that should correspond with the ploidy.

```
# To use data from QDNAseq-objects, ACE parses it into data frames referred to
# as "templates". Because we will look at sample2 several times, we can just
# create a variable with this data frame.
template <- objectsampletotemplate(object, index = 2)
head(template)
```

```
##   bin chr   start   end copynumbers segments
## 1   1   1       1 1e+06          NA       NA
## 2   2   1 1000001 2e+06          NA       NA
## 3   3   1 2000001 3e+06          NA       NA
## 4   4   1 3000001 4e+06          NA       NA
## 5   5   1 4000001 5e+06          NA       NA
## 6   6   1 5000001 6e+06          NA       NA
```

```
head(na.exclude(template))
```

```
##    bin chr    start     end copynumbers  segments
## 7    7   1  6000001 7.0e+06   1.1070897 0.9743061
## 8    8   1  7000001 8.0e+06   0.9997716 0.9743061
## 9    9   1  8000001 9.0e+06   1.0081438 0.9743061
## 10  10   1  9000001 1.0e+07   1.0739445 0.9743061
## 11  11   1 10000001 1.1e+07   0.9892931 0.9743061
## 12  12   1 11000001 1.2e+07   1.0517785 0.9743061
```

```
# The template has the raw data from QDNAseq
median(na.exclude(template$segments))
```

```
## [1] 1.002168
```

```
# That number looks familiar ... but suppose I am not happy with it?
# You could find the values of all segments by doing
unique(na.exclude(template$segments))
```

```
##  [1] 0.9743061 1.1786904 1.1922945 0.9903714 1.1978319 1.1886100 0.9937348
##  [8] 1.5721273 0.9799809 1.0021684 1.1956154 0.8105095 1.5493462 1.3703144
## [15] 0.9659909 0.9863428 0.9623434 1.1405094 0.7075958 1.1459254 1.0497091
## [22] 0.7818852 0.9873491 0.9796466 1.1794238 0.9116813 1.1959847 1.1448412
## [29] 1.1816252 0.9981159 0.9646637 0.9957557 1.4448269 0.7753297 0.9587029
```

```
# Personally I like the rle function, because it also shows you the "length" of
# a segment
segmentdata <- rle(as.vector(na.exclude(template$segments)))
plot(rep(segmentdata$values, segmentdata$lengths))
```

![](data:image/png;base64...)

```
# Yes, it can be that easy to make something resembling a copy number plot :-)
# Let's say we are sure that the segment with value 0.8105095 is 2N, we can use
# that number as new standard. First we need to find a good model that fits with
# this hypothesis
model <- singlemodel(template, ploidy = 2, standard = 0.8105095)
data.frame(model$minima, model$rerror)
```

```
##   model.minima model.rerror
## 1         0.16    0.1548715
## 2         0.19    0.1166904
## 3         0.23    0.1092674
## 4         0.32    0.2156666
## 5         0.46    0.1359516
## 6         0.65    0.5761402
```

```
singleplot(template, cellularity = 0.46, ploidy = 2, standard = 0.8105095)
```

![](data:image/png;base64...)

```
# Choosing a lower standard shifts the absolute copy numbers up
# As a result we ended up with the exact same model as the 3N fit
# Note that I can directly use the template for the singlemodel and singleplot functions
```

Instead of tinkering with the standard and ploidy, you can also let ACE find the ploidy that matches the standard. This is what the function squaremodel allows you to do. Instead of the boring error plots, you now get a colorful view of the relative error as a function of both ploidy and cellularity! Awesome! User beware though. You’ll find that ACE can make great fits at interesting ploidies, but they may not always make sense from a biological perspective. On top of the penalty for low cellularities, you can consider to use a penalty for ploidies (penploidy) that diverge a lot from two. All that trickiness urges me to advise against the use of this function as the primary means of finding fits. That, and the fact that the function takes more time to compute. Instead, use it to troubleshoot difficult samples or create visually appealing output to impress your colleagues. The function has some options to specify the range of ploidy (ptop and pbottom) and the resolution on the y-axis (prows).

```
# Let's continue with the template we made for sample 2, and just see what happens...
# Since the output of this one is pretty big, I'm saving it to a variable
sqmodel <- squaremodel(template)
ls(sqmodel)
```

```
## [1] "errordf"     "errormatrix" "matrixplot"  "method"      "minimadf"
## [6] "minimatrix"  "penalty"     "penploidy"   "standard"
```

```
# Yes, you get a lot of bang for your buck. You get back the parameters it used,
# but also the errors of all combinations tested in both a matrix and a
# dataframe, and where minima are found. But the fun comes in form of the
# matrixplot.
sqmodel$matrixplot + ggtitle("Sky on fire")
```

![](data:image/png;base64...)

```
# You can find your minima of interest in the minimadf
# Note that the minima are sorted by their relative error
head(sqmodel$minimadf, 10)
```

```
##      ploidy cellularity      error minimum
## 1741   4.28        0.17 0.05328177    TRUE
## 2036   4.16        0.24 0.05824397    TRUE
## 4338   3.20        0.22 0.06103995    TRUE
## 4044   3.32        0.16 0.06425776    TRUE
## 3853   3.40        0.17 0.06608677    TRUE
## 2271   4.08        0.67 0.07255001    TRUE
## 4654   3.08        0.50 0.07261166    TRUE
## 7044   2.08        0.40 0.07261166    TRUE
## 6640   2.24        0.20 0.09449726    TRUE
## 6547   2.28        0.23 0.09577809    TRUE
```

```
# Guess I was warned about this ... squaremodel is a bit fithappy; time to put
# the thumbscrews on the fit
squaremodel(template, penalty = 0.5, penploidy = 0.5)$matrixplot
```

![](data:image/png;base64...)

```
# Much better. Additionally you can play around with the range and resolution
sqmodel <- squaremodel(template, prows = 150, ptop = 3.3, pbottom = 1.8,
                       penalty = 0.5, penploidy = 0.5)
sqmodel$matrixplot
```

![](data:image/png;base64...)

```
# Going for higher ploidy resolution is not recommended! Not only will it take
# much longer to run, it will start distinguishing minima that correspond with
# basically the same model.
head(sqmodel$minimadf, 10)
```

```
##       ploidy cellularity      error minimum
## 11653   2.09        0.41 0.05553175    TRUE
## 2063    3.09        0.51 0.06854872    TRUE
## 1170    3.18        0.22 0.08952663    TRUE
## 10388   2.22        0.24 0.10271854    TRUE
## 10576   2.20        0.20 0.10859807    TRUE
## 108     3.29        0.16 0.11371655    TRUE
## 8940    2.37        0.16 0.14101573    TRUE
## 9515    2.31        0.15 0.14252424    TRUE
## 5582    2.72        0.18 0.15298995    TRUE
## 6254    2.65        0.18 0.15355438    TRUE
```

```
singleplot(template, cellularity = 0.41, ploidy = 2.08)
```

![](data:image/png;base64...)

```
# Perhaps this fit is a little bit better than our original 2N fit,
# but the difference is negligible.
```

This gives you all the tools to find the right fit, and customize your data and plots!

# 3 Advanced functions

## 3.1 getadjustedsegments

We have made our pick for the most likely fit. Besides plotting, we can also get the segment information in a data frame. Plus we can get some clue whether a segment is truly subclonal by examining its distance to the closest integer copy number.

```
# Let's use the template dataframe we already created in the previous section
# for sample2. For cellularity and ploidy I'll use the original 2N fit
segmentdf <- getadjustedsegments(template, cellularity = 0.38)
head(segmentdf)
```

```
##   Chromosome     Start      End Num_Bins Segment_Mean Segment_Mean2 Segment_SE
## 1          1   6000001 1.53e+08       88     1.853674      1.861052 0.04181002
## 2          1 153000001 2.47e+08       71     2.927053      2.939692 0.06503895
## 3          2   1000001 2.43e+08      162     2.998498      3.006641 0.03647978
## 4          3         1 4.70e+07       35     1.938045      1.950609 0.08913917
## 5          3  47000001 1.95e+08      113     3.027579      3.038532 0.04951716
## 6          4   1000001 4.90e+07       36     2.979148      2.985244 0.06557257
##   Copies P_log10
## 1      2  -3.051
## 2      3  -0.451
## 3      3  -0.068
## 4      2  -0.237
## 5      3  -0.360
## 6      3  -0.085
```

The first five columns are basically what you need as input for ABSOLUTE when it comes to segment data (although for ABSOLUTE you will need to run the function with argument log=TRUE). Again, keep in mind that the genomic locations of the segments are associated with a certain genome build. The first segment mean is the adjusted value calculated from the QDNAseq value. The second segment mean is manually calculated from the adjusted copy number values of the individual bins. I do not know why they are different, but luckily the difference is pretty marginal. Those individual bin values allow us to calculate the standard error of a segment value. This error can be useful to make statements about the subclonality of a segment. I have calculated a P-value, which is the chance that, if the segment had a real value that is the closest integer copy number, it would end up with a segment mean as extreme as seen in Segment\_Mean2. This P-value must be interpreted with EXTREME caution, because certain biases can easily create very low P-values.

## 3.2 linkvariants

Imagine we also have mutation data available for these samples. You can use this function to append the segment data at the genomic locations of the mutations. That’s already pretty cool, but this function also calculates how many mutant copies it thinks there are, using the mutation frequency. Programs I use have these frequencies represented as percentages, not fractions. If the mutant copies don’t make sense, try multiplying with 100. If you also supply read depth, you can calculate confidence intervals for frequency and mutant copies. You can also use this function to determine copies of heterozygous germline variants. Use help(linkvariants) for further documentation.

```
# Luck has it, we actually have mutation data for these samples. Bad luck has
# it, quality was very low, so calculated mutant copies are not very precise.
# We use the segment data frame created in the previous section.
# Mutation data can be provided as a file or as a data frame. The result will be
# printed to file or returned as a supplemented data frame respectively.
# I will create the mutation data frame manually here.
Gene <- c("CASP8", "CDKN2A", "TP53")
Chromosome <- c(2, 9, 17)
Position <- c(202149589, 21971186, 7574003)
Frequency <- c(47.46, 36.28, 43.48)
variantdf <- data.frame(Gene, Chromosome, Position, Frequency)
linkvariants(variantdf, segmentdf, cellularity = 0.38,
                 chrindex = 2, posindex = 3, freqindex = 4)
```

```
##     Gene Chromosome  Position Frequency Copynumbers Variant_copies
## 1  CASP8          2 202149589     47.46    3.006641       2.975646
## 2 CDKN2A          9  21971186     36.28    1.820867       1.844484
## 3   TP53         17   7574003     43.48    1.993213       2.285470
```

As mentioned, the mutation data for both samples was appalling, so don’t be discouraged :-) You’ll do better. Keep in mind that the program assumes the mutations only occur in tumor cells. Be sure to filter out your SNPs, and analyze those separately using the argument hetSNPs = TRUE!

## 3.3 analyzegenomiclocations

Perhaps we just want to know for one or a few specific locations how many copies are in the tumor. Or we quickly want to look up a single mutation without creating a bunch of output (files). That’s what this function is for. Again, we need our adjusted segment data from the getadjustedsegments function. Then it is a simple matter of entering the genomic location:

```
analyzegenomiclocations(segmentdf, Chromosome = 1, Position = 26365569)
```

```
##   Chromosome Position Copynumbers
## 1          1 26365569    1.861052
```

Multiple locations can be entered by providing vectors. Make sure they are the same length!

```
chr <- c(1,2,3)
pos <- c(2000000,4000000,6000000)
analyzegenomiclocations(segmentdf, Chromosome = chr, Position = pos)
```

```
##   Chromosome Position Copynumbers
## 1          1    2e+06          NA
## 2          2    4e+06    3.006641
## 3          3    6e+06    1.950609
```

It will return NA if there is no copy number info for the given position.

You can also provide a vector with frequencies to calculate mutant copies. Note: to make this calculation, you will also have to provide the cellularity (the same number as you used to create the segmentdf dataframe).

```
freq <- c(38,19,0)
analyzegenomiclocations(segmentdf=segmentdf, cellularity = 0.38,
                        Chromosome = chr, Position = pos, Frequency = freq)
```

```
##   Chromosome Position Frequency Copynumbers Mutant_copies
## 1          1    2e+06        38          NA            NA
## 2          2    4e+06        19    3.006641      1.191262
## 3          3    6e+06         0    1.950609      0.000000
```

## 3.4 postanalysisloop

This function was created to automate the above functions in case of larger data sets. You need to have picked your best fits, and recorded the variables cellularity, ploidy, and standard. If ploidy is not given, it will default to 2. If standard is not given, it will retrieve it from the QDNAseq-object. Short description of the default functionality (for the full run-down, consult the function documentation). The function loops through a QDNAseq-object. For each sample, it will try to find the model variables by looking through the models-file’s first column. Using the variables, it will calculate adjusted segments and link the mutation data. It will also print new plots for the models, which are returned by the function in a list. Output of this function is generally written to disk, although you can use it to just capture all the copy number plots in a list. You can adjust the code below to run it locally.

```
# Set the correct path
userpath <- tempdir()
# This function needs a models-file, which should like like this
sample <- c("sample1", "sample2")
cellularity <- c(0.79, 0.38)
ploidy <- c(2, 2)
standard <- c(1, 1)
models <- data.frame(sample, cellularity, ploidy, standard)
write.table(models, file.path(userpath, "models.tsv"), quote = FALSE,
            sep = "\t", na = "", row.names = FALSE)
# Let's make sure we have some mutation data to analyze
# For simplicity, I will just use the same mutation data for both samples
write.table(mutationdf, file.path(userpath, "sample1_mutations.tsv"),
            quote = FALSE, sep = "\t", na = "", row.names = FALSE)
write.table(mutationdf, file.path(userpath, "sample2_mutations.tsv"),
            quote = FALSE, sep = "\t", na = "", row.names = FALSE)
# Let's go!
postanalysisloop(object, inputdir = userpath, postfix = "_mutations",
                 chrindex = 2, posindex = 3, freqindex = 4,
                 outputdir = file.path(userpath,"output_loop"), imagetype = 'png')
# note that mutation data is optional!
```

That should cover most of it. The sections below cover some advanced and / or situational issues

# 4 Advanced use

## 4.1 Considerations for larger data sets

The model-fitting functionality of ACE is very fast, but some other steps in the process may be hampered by having lots of input. Here are some tips and considerations:
If you already have the (segmented!) rds-file(s), use that instead of bam-files. When using bam-files, the function runs the samples through QDNAseq, which has to download bin annotations for all bin sizes. Then it has to bin the samples, normalize the bins, and subsequently segment the bins. Obviously you can save a lot of time and space by reducing the number of bin sizes analyzed, and even more so, using relatively large bin sizes. Try using 500 or 1000 kbp!

The imagetype is perhaps not so important for speed, but it is important for file size and convenience. PDF gives you vector art quality, but its size is directly related to the number of data points. Again, small bin sizes blow up your file size and cause the resulting PDFs to take a long time to load. For anything with binsize 100 kbp and smaller, you might want to go with png.

The summary files can especially become very large. The program might crash if you use png and you have too many samples in your object or directory. For this reason I have created the printsummaries argument. You can set it to FALSE if you don’t want any summary files, or you can set it to 2 if you only want the summary of error lists.

## 4.2 Error methods

To be a bit blunt, the error method is just a means to an end. That said, it is possible that the default error method “RMSE” (root mean squared error) does not give the desired result. Imagine two segments: a segment with 100 bins and adjusted segment value 2.2 and a segment with 50 bins and adjusted segment value 2.4. Both segments will best fit to 2N. In case of RMSE, the error of the segments is (roughly) calculated as follows. sqrt((100x(2.2-2)^2 + 50x(2.4-2)^2)/2) = sqrt((4 + 8)/2). You can see the segment of 50 bins constributes more to the error than the segment of 100 bins, because RMSE penalizes quadratically heavier for larger deviations. Is this what you want to do? That depends. You can argue the opposite: I find it more important that my long segments close to the absolute copy numbers are penalized for deviating, whereas my smaller segments can easily be subclonal and should be penalized relatively less. In that case you can try “SMRE” which as the name implies does it the other way around (takes the square of the mean rooted error, wait, is that even a thing?). If you don’t feel all that adventurous, you can go for the mean absolute error, “MAE”, which indeed does not do any squaring or rooting, but just averages all errors. Nice and simple. From my experience: I still like to start with “RMSE”, because it seems best at giving a few good fits. Sometimes you find your segments a little overextended, in which case your actual cellularity is probably just a few percentage points higher. In this case, you can quickly run the singlemodel function with method = “MAE”, or just try to get the perfect fit by manually adjusting the cellularity. Remember: means to an end.

## 4.3 Penalizing lower cellularities

This parameter was added to penalize fits at lower cellularities. A prime example why you would want to do this can be seen in sample1 of this walkthrough. The penalty parameter corrects each error by dividing it with the cellularity to the power of the penalty. In case of 0, it divides by 1 and has no effect (i.e. no penalty). In case of 1, it divides by the cellularity, meaning an error at a cellularity of 0.05 becomes 20 times bigger. This will generally be too stringent, especially if you are analyzing samples that actually have a small fraction of aberrant cells. I like to use 0.5 which penalizes with the inverse of the square root of the cellularity.

## 4.4 Chromosomal subsets

* Generally, ACE will use data from 22 autosomes. Since QDNAseq is also available for mouse data, runACE should work for mice as well, since they have fewer chromosomes.
* The singlemodel and squaremodel functions have an argument to exclude chromosomes. If chromosomes such as sex chromosomes and mitochondrial DNA have no segmented data (as is the default of QDNAseq), they will not influence these functions. If they have segmented data, but you do not want to use them for model fitting, you have to exclude them: exclude = c(“X”, “Y”, “MT”). You can obviously also use the argument “exclude” to exclude specific autosomes.
* If the argument “onlyautosomes” is available, setting this to FALSE will include data from all other chromosomes.
* If the argument “chrsubset” is available, you can use this to specify which chromosomes should be included in the analysis. In plotting functions, you cannot “skip” chromosomes. For instance, chrsubset = c(3:7, 10:12) will plot chromosomes 3 through 12.

## 4.5 Sex chromosomes

Sex chromosomes may introduce biases in fitting, and were therefore excluded in the first versions of ACE. However … the fact that males only have a single germline X chromosome can help out in determining fits. By the same token, not accounting for this will give erroneous results when including sex chromosomes in the plots. This is also an issue when associating variant allele frequencies with copy number data, when variants are located on the X chromosome. The package now contains an argument to correct for this: sgc, short for single germline copy. With this argument you can specify which chromosomes are only present with one germline copy. So when analyzing copy number data of a male individual, specify sgc = c(“X”, “Y”). The following functions have this option: singlemodel, squaremodel, singleplot, ACEcall, getadjustedsegments, analyzegenomiclocations, and linkvariants. Since it is necessary to know up front for which samples to use this argument, it has not been included in functions that analyze all samples in an object. An exception is postanalysisloop, because this function already uses per sample information. It is possible to add gender information to the input models using the genderci option. Please consult the documentation.

# 5 Additional Functionality (accessory functions)

Detailed information and examples for below functions can be found in their respective documentation

### 5.0.1 ACEcall

ACE was not created to perform “calling” of segments. That said, ACEcall can help visualizing gains and losses.

```
ACEcall(object, 2, cellularity = 0.39)$calledplot
```

![](data:image/png;base64...)

### 5.0.2 twosamplecompare

Sometimes it is useful to compare two copy number profiles. You can compare a tumor sample with a matched normal, but you can also compare two samples from the same clonal origin that were separated in space or time, and see if changes have occurred. Additionally, it returns calculations on correlation of segments between the two samples.

```
# I don't think these two samples are very much related
tsc <- twosamplecompare(object, index1 = 1, index2 = 2,
                        cellularity1 = 0.79, cellularity2 = 0.39)
tsc$compareplot
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

### 5.0.3 squaremodelsummary

If you want to quickly visualize the copy number plots that correspond with the best fits from a squaremodel call, this function makes a summary. Its default is to print the output to file, but this can be suppressed. It will return the plots as a list.

```
# Let's see some more fits for sample1!
sms <- squaremodelsummary(object, QDNAseqobjectsample = 1,
                          squaremodel(object, 1, penalty = 0.5, penploidy = 0.5),
                          printplots = FALSE)
sms[[3]]
```

![](data:image/png;base64...)

### 5.0.4 loopsquaremodel

This function makes squaremodels for all samples in a QDNAseq-object! It can be viewed as the squaremodel equivalent of ploidyplotloop. In contrast though, it is possible to run this function without writing anything to file. It can return a list with the squaremodels, or specific items from the squaremodel (see function documentation). The object summary is a single file with all matrixplots. When printplots = TRUE, the squaremodel summaries are saved to file.

```
# I like squaremodels
lsm <- loopsquaremodel(object, printplots = FALSE, printobjectsummary = FALSE,
                       penalty = 0.5, penploidy = 0.5, returnmodels = TRUE)
class(lsm)
```

```
## [1] "list"
```

```
length(lsm)
```

```
## [1] 2
```

```
class(lsm[[1]])
```

```
## [1] "list"
```

```
ls(lsm[[1]])
```

```
##  [1] "errordf"     "errormatrix" "matrixplot"  "method"      "minimadf"
##  [6] "minimatrix"  "penalty"     "penploidy"   "samplename"  "standard"
```

```
lsm[[1]]$samplename
```

```
## [1] "sample1"
```

```
lsm[[1]]$matrixplot
```

![](data:image/png;base64...)

The following functions fall outside the scope of this vignette. For those I would like to refer to the function documentation in R:

correlationmatrix

segmentstotemplate

compresstemplate

templatefromequalsegments

forcesegmentsontemplate

# 6 Information

## 6.1 Contact

ACE was developed by Jos B. Poell at the VU Medical Center in the department of otolaryngology and head and neck surgery in collaboration with the department of pathology. Source code is available through GitHub: <https://github.com/tgac-vumc/ACE>
Questions regarding ACE can be sent to j.poell@amsterdamumc.nl or rh.brakenhoff@amsterdamumc.nl

## 6.2 License

ACE is licensed under GPL

## 6.3 Reference

ACE: Absolute Copy number Estimation from low-coverage whole-genome sequencing data.
Poell JB, Mendeville M, Sie D, Brink A, Brakenhoff RH, Ylstra B.
Bioinformatics. 2018 Dec 28. doi: 10.1093/bioinformatics/bty1055

## 6.4 Session information

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
## [1] ggplot2_4.0.0       QDNAseq_1.46.0      Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      ACE_1.28.0
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         impute_1.84.0        xfun_0.53
##  [4] bslib_0.9.0          vctrs_0.6.5          tools_4.5.1
##  [7] bitops_1.0-9         stats4_4.5.1         parallel_4.5.1
## [10] tibble_3.3.0         pkgconfig_2.0.3      R.oo_1.27.1
## [13] RColorBrewer_1.1-3   S7_0.2.0             S4Vectors_0.48.0
## [16] lifecycle_1.0.4      compiler_4.5.1       farver_2.1.2
## [19] Rsamtools_2.26.0     Biostrings_2.78.0    tinytex_0.57
## [22] statmod_1.5.1        Seqinfo_1.0.0        codetools_0.2-20
## [25] CGHcall_2.72.0       htmltools_0.5.8.1    sass_0.4.10
## [28] yaml_2.3.10          marray_1.88.0        pillar_1.11.1
## [31] crayon_1.5.3         jquerylib_0.1.4      R.utils_2.13.0
## [34] BiocParallel_1.44.0  cachem_1.1.0         limma_3.66.0
## [37] magick_2.9.0         parallelly_1.45.1    tidyselect_1.2.1
## [40] digest_0.6.37        future_1.67.0        dplyr_1.1.4
## [43] bookdown_0.45        listenv_0.9.1        labeling_0.4.3
## [46] fastmap_1.2.0        grid_4.5.1           cli_3.6.5
## [49] magrittr_2.0.4       dichromat_2.0-0.1    future.apply_1.20.0
## [52] withr_3.0.2          scales_1.4.0         rmarkdown_2.30
## [55] XVector_0.50.0       matrixStats_1.5.0    globals_0.18.0
## [58] R.methodsS3_1.8.2    DNAcopy_1.84.0       CGHbase_1.70.0
## [61] evaluate_1.0.5       knitr_1.50           GenomicRanges_1.62.0
## [64] IRanges_2.44.0       rlang_1.1.6          Rcpp_1.1.0
## [67] glue_1.8.0           BiocManager_1.30.26  jsonlite_2.0.0
## [70] R6_2.6.1
```