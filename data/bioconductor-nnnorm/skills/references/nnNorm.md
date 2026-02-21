Bioconductor’s nnNorm package

Adi L. Tarca1,2,3

October 30, 2025

1Department of Computer Science, Wayne State University
2Bioinformatics and Computational Biology Unit of the NIH Perinatology Research Branch
3Center for Molecular Medicine and Genetics, Wayne State University
http://bioinformaticsprb.med.wayne.edu/tarca/

1 Overview

The nnNorm package provides utilities to detect and correct for spatial bias with two color DNA
microarrays (or paired single channel data). The normalization implemented in nnNorm package is
based on neural networks models. Functionality to compare the distributions of the normalized log
ratios is also provided. For the simpler case when only intensity normalization is desired (univariate
distortion color model, similar to print tip loess normalization), we provide functionality to plot the
bias estimate against the level of intensity for every print tip group.

This document provides only a basic introduction to the nnNorm package. A more extended descrip-
tion is available in the nnNormGuide.pdf document. For a detailed description of the principles and
algorithmic implemented by this package consult Tarca and Cooke (2005).

We demonstrate the functionality of this package using the swirl data set from the marray package.
To load the swirl dataset in a object called swirl of type marrayRaw we use the following lines:

> library(marray)
> data(swirl)

Now we perform normalization with the method maNormNN available in the nnNorm package. This
function returns a marrayNorm object (containing the normalized log ratios).

> library(nnNorm)
> swirl_n<-maNormNN(swirl[,1:2])

Processing array 1 of 2
****************
Processing array 2 of 2
****************

If data is available in a RGList or MAList object (see limma package) they can be easily converted
to a marrayRaw object using functionality of the library convert. For more details on the nnNorm
package Please consult nnNormGuide.pdf.

1

References

A. L. Tarca and J. E. K. Cooke. A robust neural networks approach for spatial and intensity-

dependent normalization of cdna microarray data. Bioinformatics, 21(11):2674–2683, 2005.

2

