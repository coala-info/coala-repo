snapCGH: Segmentation,
Normalization and Processing of aCGH Data
Users’ Guide

ML Smith, JC Marioni, TJ Hardcastle, NP Thorne

May 2, 2019

Citing snapCGH

If you have used snapCGH in your work please cite the package using the following:

Smith, M.L., Marioni, J.C., Hardcastle, T.J., Thorne, N.P.
snapCGH: Segmentation, Normalization and Processing of aCGH Data Users’ Guide,
Bioconductor, 2006

If you make use of the function runBioHMM, please cite:

Marioni, J. C., Thorne, N. P., and Tavar´e, S. (2006).
BioHMM: a heterogeneous hidden Markov model for segmenting array CGH data.
Bioinformatics 22, 1144 - 1146

Introduction

This document outlines some of the commands used to read in, investigate and subsequently
segment array CGH data. The ﬁles analysed represent 2 breast cancer cell lines obtained
from Jessica M Pole and Paul AW Edwards.

> library(snapCGH)

snapCGH is designed to be used in conjunction with limma and so it will automatically
load that library before proceeding. In addition to limma, the following packages are also
loaded: GLAD, DNAcopy, tilingArray and aCGH . Each of these impliments an alternative
segmentation method that may be applied to the data.

1

Reading Data

We read in the samples and create the initial RG object using the following commands.

> datadir <- system.file("testdata", package="snapCGH")
> targets <- readTargets("targets.txt", path=datadir)
> RG1 <- read.maimages(targets$FileName, path=datadir, source = "genepix")

Positional information about the clones on the array (e.g. which chromosome and the
position on the chromosome a clone if from) can be incorporated using the readPosition-
alInfo function. This function accepts either an RGList or MAList along with an argument
specifying which array platform the data was produced on. Currently the only supported
platforms are Agilent, Bluefuse and Nimblegen, but this should expand in the near future.
If your platform isn’t supported or readPostitionalInfo returns an error (e.g. if the a
new version of the array output data becomes incompatible with the current function) then
the positional information can be read in separately using the read.clonesinfo function.
In order to do this it is necessary to create a clones info ﬁle. Such a ﬁle (which can be
created using Excel and saved as a ’txt’ ﬁle) must contain columns called Position and Chr
which give the position along a chromosome (in Mb) and the chromosome to which a clone
belongs. The X and Y chromosomes can be labelled either as X and Y or 23 and 24. Both
instances are handled by read.clonesinfo. The clones info ﬁle must be ordered in the
same way as the clones are ordered in the array output data.

The second command adds information about the structure of the slide (blocks/rows/columns)

to the RG object. Finally we read in a spot types ﬁle. This ﬁle contains information about
the control status of particular spots on the array and allows speciﬁc spots to be highlighted
in many of the plotting functions. The content of a spot types ﬁle is covered extensively
within the limma manual.

> RG1 <- read.clonesinfo("cloneinfo.txt", RG1, path=datadir)
> RG1$printer <- getLayout(RG1$genes)
> types <- readSpotTypes("SpotTypes.txt", path=datadir)
> RG1$genes$Status <- controlStatus(types, RG1)
>

Commonly, when aCGH experiments are carried out the reference channel is dyed using
Cy5 and the test channel is dyed using Cy3. This is the opposite way to expression data.
In order to take this into account we need to specify which channel is the reference within
our RGList. To do this we create a design vector with each column corresponding to an
array in the experiment. A value of 1 indicates that the Cy3 channel is the reference, whilst
a value of -1 equates to Cy5 being the reference, as is the case in this example.

> RG1$design <- c(-1,-1)

We now proceed to use the function backgroundCorrect to remove the background
In this example we have chosen the method ’minimum’ which

intensity for each spot.

2

subtracts the background value from the forground. Any intensity which is zero or neg-
ative after the background subtraction is set equal to half the minimum of the positive
corrected intensities for that array. For other background correction methods please see the
appropriate help ﬁle.

> RG2 <- backgroundCorrect(RG1, method="minimum")

Next, we normalise the data. Here we will carry out a (global) median normalisation.
Other options for normalization methods are: none, loess, printtiploess, composite and
robustspline. The output of the normalization function is a new type of object called an
MAList. This is composed of the log2 ratios, intensities, gene and slide layout information
which it gleans from the RG object. If you feel that no normalisation is required then it is
possible to skip this stage and proceed directly onto the next step maintaining the RGList.

> MA <- normalizeWithinArrays(RG2, method="median")

We are now ready to process the data with the purpose of segmenting the dataset into
regions corresponding to sections of the genome where there are the same number of copy
number gains or losses.

Firstly, we use the processCGH to ’tidy up’ the MAList object. The method.of.averaging
option deﬁnes how clones of the same type should be averaged.
If this is speciﬁed the
duplicates are removed following the averaging leaving only one occurence of each clone
set. The ID argument is used to indicate the name of the column containing a unique
identiﬁer for each clone type. It is this identiﬁer that is used when averaging replicates. As
mentioned above this function accepts both RGLists and MALists.

> MA2 <- processCGH(MA,method.of.averaging=mean, ID = "ID")

Segmentation

We are now ready to ﬁt the segmentation method. For larger data sets this step can take a
long time (several hours). In this example we call the homogeneous hidden Markov model
available in the aCGH package.

> SegInfo.Hom <- runHomHMM(MA2, criteria = "AIC")

At the current time there are methods for calling four other segmentation algorithms in
addition to the method shown above. Three of these are included as wrapper functions to
methods available in other packages, speciﬁcally: DNAcopy, GLAD and tilingArray. These
functions can be called using the following code:

> SegInfo.GLAD <- runGLAD(MA2)
> SegInfo.DNAcopy <- runDNAcopy(MA2)
> SegInfo.TilingArray <- runTilingArray(MA2)

3

The ﬁnal method, called BioHMM, is a heterogeneous hidden Markov model and is
maintained within snapCGH . It can be called using the following command. By default it
incorporates the distance between clones into the model assigning a higher probability of
state change to clones that are a larger distance apart on a chromosome. This option is
control using the argument useCloneDists.

> SegInfo.Bio <- runBioHMM(MA2)

We now deal with the fact that the segmentation methods sometimes have a tendency to
ﬁt states whose means are very close together. We overcome this problem by merging states
whose means are within a given threshold. There are two diﬀerent methods for carrying out
the merging process. For more information on their diﬀerences please see the appropriate
page in the helpﬁles.

> SegInfo.Hom.merged <- mergeStates(SegInfo.Hom, MergeType = 1)

We are now ready to use any of the plotting functions available in the library.

Plotting Functions

The library comes with a variety of plotting functions that provide visual representations
of the data at various stages of the analysis process. Firstly we will look at the genomePlot
function. This function takes either an MAList or a SegList object (in this example we’ve
used an MAList) and plots the M-value for each gene against it’s position on the genome.
The array argument indicates which array is plotted. This function utilizes the spot types
data that was read in earlier to highlight speciﬁc genes of interest.

> genomePlot(MA2, array = 1)

4

It is also possible to look at speciﬁc chromosomes, rather than the entire genome as in
the previous example. Which particular chromosome is to be plotted is speciﬁed using the
chrom.to.plot argument.

> genomePlot(MA2, array = 1, chrom.to.plot = 8)

5

−2.0−1.5−1.0−0.50.00.51.01.52.0135791113151719212468101214161820221   10Mbslide28Log2RatiolllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllThe plotSegmentedGenome function provides a visual representation of the observed
M-values overlayed with the predicted states produced by the segementation algorithm. It
requires a SegList as input.

> plotSegmentedGenome(SegInfo.Hom.merged, array = 1)

6

020406080100120140−2.0−1.5−1.0−0.50.00.51.01.52.0Distance along chromosome (Mb)81   10Mbslide28Log2RatiolllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllUsing the argument chrom.to.plot it is possible to specify individual chromosomes to
plot. Additionally the function can accept more than one SegList allowing visual compar-
ison between segmentation methods.

The following example applies the DNAcopy algorithm to the data, merges it and then
plots both that segmentation method and the homogeneous HMM on the same axis, coloring
them blue and green respectively.

> Seg.DNAcopy <- runDNAcopy(MA2)
> SegInfo.DNAcopy.merged <- mergeStates(Seg.DNAcopy)
> plotSegmentedGenome(SegInfo.DNAcopy.merged, SegInfo.Hom.merged, array = 1,
+

chrom.to.plot = 1, colors = c("blue", "green"))

7

−2.0−1.5−1.0−0.50.00.51.01.52.0135791113151719212468101214161820221   10Mbslide28Log2RatiolllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllInteractive Plotting Functions

snapCGH includes several interactive plotting functions to allow users to view data on a
large scale and the focus in on particular areas of intrest.

The ﬁrst of these is zoomGenome. This function splits the screen in two horizontally and
plots the same as plotSegmentedGenome in the upper half. It is then possible to click on
any of the chromosomes displayed and the selected chromosome is plotted in the lower half
of the graphics window. Clicking to either side of the plot will end the interactivity.

In the example below we have plotted the ﬁrst array in the SegInfo.Hom.merged object

and then clicked on chromosome eight.

> zoomGenome(SegInfo.Hom.merged, array = 1)

8

050100150200−2.0−1.5−1.0−0.50.00.51.01.52.0Distance along chromosome (Mb)11   10Mbslide28Log2RatiolllllllllllllllllllllllllzoomChromosome is an equivalent function for focusing on speciﬁc areas in a speciﬁc
chromosome. The layout is the same as in the zoomGenome but this time the upper plot is
of a speciﬁed chromosome. Click in two location on this plot and the selected region of the
chromosome will be plotted below. The region of focus is also indicated in the upper plot.
Clicking twice again will change the focus region. This function accepts either an MAList
or multiple SegList objects.

> zoomChromosome(SegInfo.Hom.merged, array = 1, chrom.to.plot = 8)

Simulating Data

Simulated data is often used to assess the eﬃcacy of segmentation methods so snapCGH
also provides facilities for simulating aCGH data. None of the currently available simu-
lation schemes take into account the spatial nature of aCGH data, they simply generate
ordered log2 ratios. However with the development2 of new segmentation methods, such as
BioHMM, new simulation schemes are needed. In particular the simulation scheme avail-
able in snapCGH allows diﬀerentiation between tiled and non-tiled regions to emulated
diﬀerent array technologies.

9

The function simulateData generates a SegList of 22 chromosomes with the number of
arrays speciﬁed by the argument nArrays. The function has a mulitude of additional argu-
ments for specifying the speciﬁc type of data you wish to simulate. These are documented
in the appropriate helpﬁle.

> simulation <- simulateData(nArrays = 4)

In the following example we run the homogeneous HMM and the DNAcopy algorithm
on the simulated data. The function compareSegmentations can be used to evaluate the
performance of a segmentation methods against the known truth of the simulated data.
It returns true positive and false discovery rates for breakpoint detection in each supplied
SegList. The argument oﬀset, which can take an integer between 0 and 2, speciﬁes how
close the algorithm needs to be to a real breakpoint before it is scored.

> Sim.HomHMM <- runHomHMM(simulation)
> Sim.DNAcopy <- runDNAcopy(simulation)
> rates <- compareSegmentations(simulation, offset = 0, Sim.HomHMM, Sim.DNAcopy)

10

The output from compareSegmentations is a list containing two matrices. The ﬁrst of
these, $TPR, contains the true positive rate, whilst the second, $FDR, holds the false discovery
rate. Both of these matrices are arranged such that a row represents a segmentation method
and each column is an array.

> rates

$TPR

Sample 1 Sample 2 Sample 3 Sample 4
HomHMM 0.3559322 0.4545455 0.4857143 0.5217391
DNAcopy 0.6271186 0.7636364 0.6428571 0.6666667

$FDR

Sample 1 Sample 2

Sample 4
HomHMM 0.5434783 0.687500 0.53424658 0.38983051
DNAcopy 0.1190476 0.106383 0.08163265 0.09803922

Sample 3

Shown below are boxplots of the rates object.

11

> par(mfrow = c(1,2))
> boxplot(rates$TPR ~ row(rates$TPR), col = c("red", "blue"), main = "True Positive Rate")
> boxplot(rates$FDR ~ row(rates$FDR), col = c("red", "blue"), main = "False Discovery Rate")

12

120.40.50.60.7True Positive Raterow(rates$TPR)rates$TPR120.10.20.30.40.50.60.7False Discovery Raterow(rates$FDR)rates$FDR