Package ‘spotSegmentation’

April 12, 2018

Version 1.52.0

Author Qunhua Li, Chris Fraley, Adrian Raftery

Department of Statistics, University of Washington

Title Microarray Spot Segmentation and Gridding for Blocks of

Microarray Spots

Description Spot segmentation via model-based clustering and gridding for
blocks within microarray slides, as described in Li et al, Robust
Model-Based Segmentation of Microarray Images, Technical Report
no. 473, Department of Statistics, University of Washington.

Depends R (>= 2.10), mclust

Note mclust package not needed for gridding

License GPL (>= 2)
Maintainer Chris Fraley <fraley@stat.washington.edu>

URL http://www.stat.washington.edu/fraley
biocViews Microarray, TwoChannel, QualityControl, Preprocessing

NeedsCompilation no

R topics documented:

.

.
plot.spotseg .
.
plotBlockImage .
.
.
.
spotgrid .
.
.
spotseg .
.
.
.
.
spotSegTest
summary.spotseg .

.
.
.

.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1
2
3
4
6
7

9

Index

plot.spotseg

Microarray Spot Segmentation Plot

Description

Plot method for the spotseg function. Displays the result obtained from microarray spot segmen-
tation via model-based clustering.

1

2

Usage

## S3 method for class 'spotseg'
plot(x,...)

plotBlockImage

Arguments

x

...

Value

An object of class "spotseg", which is the output of the function spotseg.
Unused but required by generic "plot" method.

None, other than the displayed plot.

References

Q. Li, C. Fraley, R. Bumgarner, K. Y. Yeung, and A. Raftery\ Robust model-based segmentation of
microarray images,\ Technical Report No.~473, Department of Statistics, University of Washington,
January 2005.

See Also

spotseg

Examples

data(spotSegTest)

# columns of spotSegTest:
# 1 intensities from the Cy3 (green) channel
# 2 intensities from the Cy5 (red) channel

dataTransformation <- function(x) (256*256-1-x)^2*4.71542407E-05

chan1 <- matrix(dataTransformation(spotSegTest[,1]), 144, 199)
chan2 <- matrix(dataTransformation(spotSegTest[,2]), 144, 199)

hivGrid <- spotgrid( chan1, chan2, rows = 4, cols = 6, show = TRUE)

library(mclust)

hivSeg <- spotseg( chan1, chan2, hivGrid$rowcut, hivGrid$colcut)

plot(hivSeg)

plotBlockImage

Plot Microarray Image Block

Description

Displays a block of a microarray image.

spotgrid

Usage

plotBlockImage(z,title,one)

3

Arguments

z

title

one

Value

Intensities of the image pixels, in the form a of a matrix.

A title for the image plot (optional).

Sets appropriate graphics parameters for displaying individuals spots (default:FALSE).

None, other than the displayed plot.

References

Q. Li, C. Fraley, R. Bumgarner, K. Y. Yeung, and A. Raftery\ Robust model-based segmentation of
microarray images,\ Technical Report No.~473, Department of Statistics, University of Washington,
January 2005.

See Also

spotseg

Examples

data(spotSegTest)

# columns of spotSegTest:
# 1 intensities from the Cy3 (green) channel
# 2 intensities from the Cy5 (red) channel

dataTransformation <- function(x) (256*256-1-x)^2*4.71542407E-05

chan1 <- matrix(dataTransformation(spotSegTest[,1]), 144, 199)
chan2 <- matrix(dataTransformation(spotSegTest[,2]), 144, 199)

plotBlockImage(chan1)
plotBlockImage(chan2)

spotgrid

Gridding for Blocks of Microarray Spots

Description

Determines row or column delimiters for spot locations from blocks of microarray slide image data.

Usage

spotgrid(chan1, chan2, rows = NULL, cols = NULL, span = NULL,

show = FALSE)

4

Arguments

chan1

chan2

rows

cols

span

show

Value

spotseg

matrix of pixel intensities from the ﬁrst channel.

matrix of pixel intensities from the second channel.

number of spots in a row of the image block.

number of spots in a column of the image block.

Window size for locating peak signals. This can be of length 2, in which case
the ﬁrst value is interpreted as a window size for the rows and the second as a
window size for the columns. A default is estimated from the image dimension
and number of spots.

logical variable indicating whether or not to display the gridding result.

A list with two elements, rowcut and colcut giving delimiters for the row and/or column gridding
of the slide. The indexes indicate the start of a segment of the grid, except for the last one, which
indicates the end of the grid.

References

Q. Li, C. Fraley, R. Bumgarner, K. Y. Yeung, and A. Raftery\ Robust model-based segmentation of
microarray images,\ Technical Report No.~473, Department of Statistics, University of Washington,
January 2005.

See Also

spotseg

Examples

data(spotSegTest)

# columns of spotSegTest:
# 1 intensities from the Cy3 (green) channel
# 2 intensities from the Cy5 (red) channel

dataTransformation <- function(x) (256*256-1-x)^2*4.71542407E-05

chan1 <- matrix(dataTransformation(spotSegTest[,1]), 144, 199)
chan2 <- matrix(dataTransformation(spotSegTest[,2]), 144, 199)

Grid <- spotgrid( chan1, chan2, rows = 4, cols = 6, show = TRUE)

spotseg

Microarray Spot Segmentation

Description

Microarray spot segmentation via model-based clustering.

spotseg

Usage

spotseg(chan1, chan2, rowcut, colcut, R=NULL, C=NULL,

threshold=100, hc=FALSE, show=FALSE)

5

Arguments

chan1

chan2

rowcut

colcut

R

C

threshold

hc

show

Details

matrix of pixel intensities from the ﬁrst channel.

matrix of pixel intensities from the second channel.

row delimiters for the spots. Entries are the starting row location in the close of
each spot, with the last entry being one pixel beyond the border of the last spot.
For example, from the output of spotgrid.

column delimiters for the spots. Entries are the starting column location in the
close of each spot, with the last entry being one pixel beyond the border of the
last spot. For example, from the output of spotgrid.

rows over which the spots are to be segmented. The default is to segment spots
in all rows.

columns over which the spots are to be segmented. The default is to segment
spots in all columns.
connected components of size smaller than threshold are ignored. Default:
threshold=100.

logical variable indicating whether or not EM should be initialized by hierar-
chical clustering or quantiles in model-based clustering. The default is to use
quantiles hc = FALSE, which is more efﬁcient both in terms of speed and mem-
ory usage.

logical variable indicating whether or not to display the segmentation of each in-
dividual spot as it is processed. The default is not to display the spots show = FALSE.

There are plot and summary methods that can be applied to the result.

Value

An array of the same dimensions as the image in which the pixels are labeled according to their
group within the spot area: 1=background,2=uncertain,3=sample.

Note

The mclust package is requiredfor clustering.

References

Q. Li, C. Fraley, R. Bumgarner, K. Y. Yeung, and A. Raftery\ Robust model-based segmentation of
microarray images,\ Technical Report No.~473, Department of Statistics, University of Washington,
January 2005.

See Also

summary.spotseg, plot.spotseg, spotgrid

6

Examples

data(spotSegTest)

spotSegTest

# columns of spotSegTest:
# 1 intensities from the Cy3 (green) channel
# 2 intensities from the Cy5 (red) channel

dataTransformation <- function(x) (256*256-1-x)^2*4.71542407E-05

chan1 <- matrix(dataTransformation(spotSegTest[,1]), 144, 199)
chan2 <- matrix(dataTransformation(spotSegTest[,2]), 144, 199)

Grid <- spotgrid( chan1, chan2, rows = 4, cols = 6, show = TRUE)

library(mclust)

Seg <- spotseg( chan1, chan2, Grid$rowcut, Grid$colcut)

plot(Seg)

spotSummary <- summary(Seg)

spot11 <- spotseg( chan1, chan2, Grid$rowcut, Grid$colcut,

R = 1, C = 1, show = TRUE)

spotSegTest

Spot Segmentation Test Data

Description

The two columns of this data set represent the Cy3 (green) absorption intensities for channel 1,
and the Cy5 (red) absorption intensities for channel 2 for part of a dye-swap experiment with repli-
cates. They measure expression levels of cellular RNA transcripts assessed in CD4+ T cell lines at
different times after infection with HIV-1BRU using DNA microarrays.

Usage

data(spotSegTest)

Format

Each column is a vector of intensities of 24 spots arranged in 4 rows and 6 columns, encoded
for compact (16-bit TIFF) storage. For processing each column of spotSegTest should ﬁrst be
converted to a 144x199 matrix, then applying the transformation described below.

Details

The intensities can be obtained from this data by ﬁrst subtracting them from 65535 (256*256-1),
then squaring, then multiplying by a scale factor 4.71542407E-05. In other words, a number x in
the spotSegTest data set corresponds to intensity

(256*256 - 1 - x)^2*.0000471542407

. \

summary.spotseg

Source

7

Dr. Angelique van’t Wout, Department of Microbiology, University of Washington\ The data
is a subset the ﬁrst block of a 12 block array image (‘001030_08_1.GEL’) in the ﬁrst data set
(‘2000095918 A’) in the ﬁrst experiment (‘CEM LAI vs HI-LAI 24hr’) of the following data
archive:\ http://expression.microslu.washington.edu/expression/vantwoutjvi2002.html

References

van’t Wout AB, Lehrman GK, Mikheeva SA, O’Keeffe GC, Katze MG, Bumgarner RE, Geiss
GK, Mullins JI\ Cellular gene expression upon human immunodeﬁciency virus type 1 infection of
CD4(+)-T-cell lines.\ J Virol. 2003 Jan;77(2):1392-402.

summary.spotseg

Microarray Spot Segmentation Summary

Description

Summary method for the spotseg function. Gives the estimates of foreground and background
intensity obtained from microarray spot segmentation via model-based clustering.

Usage

## S3 method for class 'spotseg'
summary(object,...)

Arguments

object

...

Value

An object of class "spotseg", which is the output of the function spotseg.
Unused, but required by generic "summary" method.

A list with two components, "channel1" and "channel2" each of which has subcomponents
"background" and "foreground", each of which in turn has subcomponents "mean" and "median",
giving the mean and median estimates of background and foreground for each channel. There will
be missing entries (value NA) whenever no foreground is detected.

References

Q. Li, C. Fraley, R. Bumgarner, K. Y. Yeung, and A. Raftery\ Robust model-based segmentation of
microarray images,\ Technical Report No.~473, Department of Statistics, University of Washington,
January 2005.

See Also

spotseg

8

Examples

data(spotSegTest)

summary.spotseg

# columns of spotSegTest:
# 1 intensities from the Cy3 (green) channel
# 2 intensities from the Cy5 (red) channel

dataTransformation <- function(x) (256*256-1-x)^2*4.71542407E-05

chan1 <- matrix(dataTransformation(spotSegTest[,1]), 144, 199)
chan2 <- matrix(dataTransformation(spotSegTest[,2]), 144, 199)

hivGrid <- spotgrid( chan1, chan2, rows = 4, cols = 6, show = TRUE)

library(mclust)

hivSeg <- spotseg( chan1, chan2, hivGrid$rowcut, hivGrid$colcut)

hivSummary <- summary(hivSeg)

Index

∗Topic cluster
spotseg, 4

∗Topic datasets

spotSegTest, 6

∗Topic manip

spotgrid, 3
spotseg, 4
∗Topic methods

plot.spotseg, 1
plotBlockImage, 2
summary.spotseg, 7

∗Topic robust

spotgrid, 3
spotseg, 4

plot.spotseg, 1, 5
plotBlockImage, 2

spotgrid, 3, 5
spotseg, 2–4, 4, 7
spotSegTest, 6
summary.spotseg, 5, 7

9

