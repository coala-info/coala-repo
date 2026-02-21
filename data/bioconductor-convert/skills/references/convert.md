Converting Between Microarray Data Classes:
the convert Package Version 1.1.7

Gordon Smyth and James Wettenhall

May 12, 2004

The convert package provides the ability to convert between microarray data formats
(object classes) defined in the packages Biobase, limma and marray. Conversion is done
using the function as from the methods package. For example, if x is a marrayNorm
object produced by the marrayNorm package, then

> y <- as(x, "MAList")

will produce a MAList object y, useful in the limma package.

The following data classes are supported:

• RGList (limma). A simple list-based class for storing red and green channel fore-
ground and background intensities and associated information for a batch of spot-
ted microarrays.

• MAList (limma). A simple list-based class for storing M -values and A-values and

associated information for a batch of spotted microarrays.

• marrayRaw (marray). Stores red and green channel foreground and background
intensities and associate information for a batch of spotted microarrays. Analogous
to RGList.

• marrayNorm (marray). Stores red and green channel foreground and background
intensities and associate information for a batch of spotted microarrays. Analogous
to MAList.

• ExpressionSet (Biobase). Stores microarray expression data, one value for each
probe for each array and associated phenotypic data. Links out to an external
annotation library for probe information. Commonly used for single channel data
such as Affymetrix or for pre-processed two-color data in the form of log-ratios
ready for cluster analysis or classification.

The convert package provides conversion to and from RGList and marrayRaw, to and
from MAList and marrayNorm, and from MAList and marrayNorm to ExpressionSet.

1

