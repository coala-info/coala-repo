Extracting limma objects from limmaGUI files

James Wettenhall

April 22, 2004

This vignette gives a short example showing how to extract limma data objects from
files saved by limmaGUI. This could be used for advanced limma analysis by an expert
user after some preliminary analysis with limmaGUI by someone unfamiliar with the
command-line interface.
We will use a file SwirlLinearModelComputed.lma which has been saved from lim-
maGUI. It is available from:
http://bioinf.wehi.edu.au/limmaGUI/Swirl/SwirlLinearModelComputed.lma.
The .lma extension used by limmaGUI is simply a three-letter abbreviation of limma
(Linear Models for Microarrays). This file is in fact a standard .RData file and can be
loaded into any R session as described below.

> load("SwirlLinearModelComputed.lma")

Firstly, let’s load the limma package, so that R knows how to display objects defined by
limma classes (e.g. RGList).

> library(limma)

Now let’s have a look at the R objects available to us:

> ls()

Now let’s look at the RNA targets for this dataset:

> Targets

Now let’s look at the first 30 lines of the genelist (Genepix Array List) for this dataset:

> gal[1:30,]

The raw red and green foreground and background intensities are stored the object RG.
They can be viewed as follows:

> RG

1

Now if this .lma was saved by a recent version of limmaGUI (>=0.7.6), there should be
an object available called BCMethod which contains the current background correction
method. In old versions of limmaGUI, the only background correction method available
was "subtract", i.e. simply subtracting the background intensities from the foreground.

> BCMethod

Now let’s see what MA objects are currently available to us. MA.Available is a list
object with components "Raw" "WithinArrays", "BetweenArrays" and "Both", so for
example MA$Both would be TRUE if there is an MA object which has been normalized
both within arrays and between arrays. The four corresponding MA objects are called
MAraw, MAwithinArrays, MAbetweenArrays and MAboth. Each one is initialised to an
empty list, and if needed, it it overwritten with an appropriate MAList object.

> MA.Available

> MAraw

Now let’s see how many parameterizations have been defined (i.e. how many design
matrices).

> NumParameterizations

In this case, there is only one parameterization. Now let’s have a look at the objects
stored within this parameterization. The ’1’ in double square-brackets represents the
first parameterization.

> names(ParameterizationList[[1]])

There is an object called designList, which is a list object containing the design ma-
trix, and some information about how the user created that design matrix, in this case
by requesting a comparison between "Swirl" and "Wild Type" using drop-down com-
boboxes, rather than manually entering the matrix numerically.

> ParameterizationList[[1]]$designList

Now let’s look at the linear model fit object. Until version 0.7.7, limmaGUI used the old
lm.series from limma rather than lmFit, so the fit object was a standard R list object,
but from 0.7.7, lmFit is used so that the fit object is an object of class MArrayLM.
This means that with a fit object obtained from a new limmaGUI analysis, typing
ParameterizationList[[1]]$fit and pressing enter should display a summary of the
data in the fit object, rather than all the data.

> ParameterizationList[[1]]$fit

2

Empirical bayes statistics can be obtained from the "eb" component of ParameterizationList[[1]].
Note that recent versions of limma encourage users to calculate empirical bayes statistics
using eBayes, rather than ebayes, whereas at the time of writing limmaGUI still uses
the old ebayes method, which produces a standard list object, meaning that typing
ParameterizationList[[1]]$eb and pressing enter will display all the data in the list,
rather than a summary. The components of the empirical bayes list object can be viewed
as follows:

> names(ParameterizationList[[1]]$eb)

For example, the moderated t statistics can be obtained as follows:

> ParameterizationList[[1]]$eb$t

Other objects of interest include:

• ParameterizationList[[1]]$WhetherToNormalizeWithinArrays,

• ParameterizationList[[1]]$WhetherToNormalizeBetweenArrays,

• ParameterizationList[[1]]$WithinArrayNormalizationMethod,

• ParameterizationList[[1]]$SpotTypesForLinearModel, and

• SpotTypes.

3

