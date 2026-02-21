CGHcall: Calling aberrations for array
CGH tumor profiles.

Sjoerd Vosse and Mark van de Wiel

October 29, 2025

Department of Epidemiology & Biostatistics
VU University Medical Center

mark.vdwiel@vumc.nl

Contents

1 Overview

2 Example

1 Overview

1

1

CGHcall allows users to make an objective and effective classification of their
aCGH data into copy number states (loss, normal, gain or amplification).
This document provides an overview on the usage of the CGHcall package.
For more detailed information on the algorithm and assumptions we refer
to the article (van de Wiel et al., 2007) and its supplementary material.
As example data we attached the first five samples of the Wilting dataset
(Wilting et al., 2006). After filtering and selecting only the autosomal 4709
datapoints remained.

2 Example

In this section we will use CGHcall to call and visualize the aberrations in
the dataset described above. First, we load the package and the data:

1

> library(CGHcall)
> data(Wilting)
> Wilting <- make_cghRaw(Wilting)

Next, we apply the preprocess function which:

• removes data with unknown or invalid position information.

• shrinks the data to nchrom chromosomes.

• removes data with more than maxmiss % missing values.

• imputes missing values using impute.knn from the package impute

(Troyanskaya et al., 2001).

> cghdata <- preprocess(Wilting, maxmiss=30, nchrom=22)

Changing impute.knn parameter k from 10 to 4 due to small sample size.

To be able to compare profiles they need to be normalized. In this pack-
age we first provide very basic global median or mode normalization. This
function also contains smoothing of outliers as implemented in the DNAcopy
package (Venkatraman and Olshen, 2007). Furthermore, when the propor-
tion of tumor cells is not 100% the ratios can be corrected. See the article
and the supplementary material for more information on cellularity correc-
tion (van de Wiel et al., 2007).

> norm.cghdata <- normalize(cghdata, method="median", smoothOutliers=TRUE)

Applying median normalization ...
Smoothing outliers ...

The next step is segmentation of the data. This package only provides
a wrapper function that applies the DNAcopy algorithm (Venkatraman and
It provides extra functionality by allowing to undo splits
Olshen, 2007).
differently for long and short segments, respectively.
In the example be-
low short segments are smaller than clen=10 probes, and for such segments
undo.splits is effective when segments are less than undo.SD=3 (sd) apart.
For long segments a less stringent criterion holds: undo when less than
If, for two consecutive segements,
undo.SD/relSDlong = 3/5 (sd) apart.
one is short and one is long, splits are undone in the same way as for two
consecutive short segments. To save time we will limit our analysis to the
first two samples from here on.

2

> norm.cghdata <- norm.cghdata[,1:2]
> seg.cghdata <- segmentData(norm.cghdata, method="DNAcopy",undo.splits="sdundo",undo.SD=3,
+ clen=10, relSDlong=5)

Start data segmentation ..
Analyzing: Sample.1
Analyzing: Sample.2

Post-segmentation normalization allows to better set the zero level after

segmentation.

> postseg.cghdata <- postsegnormalize(seg.cghdata)

Now that the data have been normalized and segments have been defined,
we need to determine which segments should be classified as double losses,
losses, normal, gains or amplifications. Cellularity correction is now provided
WITHIN the calling step (as opposed to some earlier of CGHcall)

> tumor.prop <- c(0.75, 0.9)
> result <- CGHcall(postseg.cghdata,nclass=5,cellularity=tumor.prop)

[1] "Total number of segments present in the data: 90"
[1] "Number of segments used for fitting the model: 90"

The result of CGHcall needs to be converted to a call object. This can

be a large object for large arrays.

> result <- ExpandCGHcall(result,postseg.cghdata)

3

To visualize the results per profile we use the plotProfile function:

> plot(result[,1])

Plotting sample AdCA10

4

0.00.20.40.60.81.0−5−4−3−2−1012345log2 ratioprobabilitychromosomesAdCA10Plot resolution: 10%123456791113151822MAD = 0.164k x 147 kbp> plot(result[,2])

Plotting sample SCC27

5

0.00.20.40.60.81.0−5−4−3−2−1012345log2 ratioprobabilitychromosomesSCC27Plot resolution: 10%123456791113151822MAD = 0.124k x 147 kbpAlternatively, we can create a summary plot of all the samples:

> summaryPlot(result)

6

Summary Plotchromosomesmean probability1234567891113151822100 % 50 %0 %50 %100 %gainslosses4k x 147 kbpOr a frequency plot::

> frequencyPlotCalls(result)

7

Frequency Plotchromosomesfrequency1234567891113151822100 % 50 %0 %50 %100 %gainslosses4k x 147 kbpReferences

Troyanskaya, O., Cantor, M., Sherlock, G., Brown, P., Hastie, T., Tibshirani,
R., Botstein, D., and Altman, R. B. (2001). Missing value estimation
methods for DNA microarrays. Bioinformatics, 17:520–525.

van de Wiel, M. A., Kim, K. I., Vosse, S. J., van Wieringen, W. N., Wilting,
S. M., and Ylstra, B. (2007). CGHcall: calling aberrations for array CGH
tumor profiles. Bioinformatics, 23:892–894.

Venkatraman, E. S. and Olshen, A. B. (2007). A faster circular binary seg-
mentation algorithm for the analysis of array CGH data. Bioinformatics,
23:657–663.

Wilting, S. M., Snijders, P. J. F., Meijer, G. A., Ylstra, B., van den Ijssel,
P. R. L. A., Snijders, A. M., Albertson, D. G., Coffa, J., Schouten, J. P.,
van de Wiel, M. A., Meijer, C. J. L. M., and Steenbergen, R. D. M.
(2006).
Increased gene copy numbers at chromosome 20q are frequent
in both squamous cell carcinomas and adenocarcinomas of the cervix. J
Pathol, 209:220–230.

8

