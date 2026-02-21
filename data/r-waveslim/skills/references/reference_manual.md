Package ‘waveslim’

July 22, 2025

Version 1.8.5

Date 2024-06-02

Title Basic Wavelet Routines for One-, Two-, and Three-Dimensional

Signal Processing

Author Brandon Whitcher
Maintainer Brandon Whitcher <bwhitcher@gmail.com>
Depends R (>= 2.11.0), graphics, grDevices, stats, utils, multitaper

Suggests fftw, covr

Description Basic wavelet routines for time series (1D), image (2D) and array
(3D) analysis. The code provided here is based on wavelet methodology
developed in Percival and Walden (2000); Gencay, Selcuk and Whitcher (2001);
the dual-tree complex wavelet transform (DTCWT) from Kingsbury (1999, 2001) as
implemented by Selesnick; and Hilbert wavelet pairs (Selesnick 2001, 2002).
All figures in chapters 4-7 of GSW (2001) are reproducible using this package
and R code available at the book website(s) below.

License BSD_3_clause + file LICENSE

URL https://waveslim.blogspot.com
RoxygenNote 7.3.1

Encoding UTF-8

NeedsCompilation yes

Repository CRAN

Date/Publication 2024-06-04 13:20:03 UTC

Contents

.
.

.
.
.

.
.
.

.
acvs.andel8 .
.
.
.
.
.
afb .
ar1 .
.
.
.
.
.
bandpass.var.spp .
.
.
barbara
.
.
basis .

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
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3
4
6
6
7
8

1

2

Contents

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
blocks .
.
.
.
brick.wall
.
.
.
convolve2D .
.
.
cpi .
.
.
.
.
.
cplxdual2D .
.
.
.
.
cshift
.
.
.
.
.
css.test .
.
dau .
.
.
.
.
.
denoise.dwt.2d .
.
.
doppler
.
.
.
.
dpss.taper
.
.
.
dualfilt1 .
.
.
.
dualtree .
.
.
.
dwpt .
.
.
.
.
dwpt.2d .
.
.
.
dwpt.boot
.
.
.
dwpt.sim .
.
.
.
.
dwt
.
.
.
.
.
.
dwt.2d .
.
.
.
.
.
dwt.3d .
.
.
dwt.hilbert .
.
.
.
exchange
.
.
.
fdp.mle .
.
.
.
.
.
fdp.sdf .
find.adaptive.basis .
.
.
.
FSfarras .
.
.
.
heavisine
.
.
.
.
.
hilbert.filter
.
.
hosking.sim .
.
.
.
.
.
ibm .
.
.
.
japan .
.
.
.
.
.
jumpsine .
.
.
.
kobe .
.
.
linchirp .
.
.
.
manual.thresh .
.
.
.
mexm .
.
.
modhwt.coh .
.
.
.
modwt .
.
.
.
.
modwt.2d .
.
.
.
modwt.3d .
.
.
.
.
.
mra
.
.
.
.
.
.
.
mra.2d .
.
.
.
.
mra.3d .
.
.
.
.
.
mult.loc .
.
.
.
.
.
my.acf .
.
.
.
nile
.
.
.
.
.
.
.
ortho.basis .
.
.
.
.
.
per .

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
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
.

acvs.andel8

3

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

phase.shift .
.
phase.shift.hilbert .
.
.
plot.dwt.2d .
.
.
.
qmf
.
.
.
.
.
.
rotcumvar .
.
.
.
.
shift.2d .
.
.
.
.
sine.taper
.
spin.covariance .
.
.
.
.
spp.mle .
.
.
.
spp.var .
.
.
.
.
.
squared.gain .
.
.
.
.
stackPlot .
.
.
.
.
.
testing.hov .
.
.
.
.
tourism .
.
.
.
.
.
unemploy .
.
.
.
.
up.sample .
.
.
wave.filter .
.
.
wave.variance .
.
.
wave.variance.2d .
.
wavelet.filter
.
.
xbox .

.
.

.
.

.

.

.

Index

acvs.andel8

Description

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 79
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80

81

Autocovariance and Autocorrelation Sequences for a Seasonal Persis-
tent Process

The autocovariance and autocorrelation sequences from the time series model in Figures 8, 9, 10,
and 11 of Andel (1986). They were obtained through numeric integration of the spectral density
function.

Usage

data(acvs.andel8)

data(acvs.andel9)

data(acvs.andel10)

data(acvs.andel11)

Format

A data frame with 4096 rows and three columns: lag, autocovariance sequence, autocorrelation
sequence.

4

References

afb

Andel, J. (1986) Long memory time series models, Kypernetika, 22, No. 2, 105-123.

afb

Filter Banks for Dual-Tree Wavelet Transforms

Description

Analysis and synthesis filter banks used in dual-tree wavelet algorithms.

Usage

afb(x, af)

afb2D(x, af1, af2 = NULL)

afb2D.A(x, af, d)

sfb(lo, hi, sf)

sfb2D(lo, hi, sf1, sf2 = NULL)

sfb2D.A(lo, hi, sf, d)

Arguments

x

af

af1, af2
sf

sf1, sf2
d

lo

hi

Details

vector or matrix of observations

analysis filters. First element of the list is the low-pass filter, second element is
the high-pass filter.

analysis filters for the first and second dimension of a 2D array.

synthesis filters. First element of the list is the low-pass filter, second element is
the high-pass filter.

synthesis filters for the first and second dimension of a 2D array.

dimension of filtering (d = 1 or 2)

low-frequecy coefficients

high-frequency coefficients

The functions afb2D.A and sfb2D.A implement the convolutions, either for analysis or synthesis, in
one dimension only. Thus, they are the workhorses of afb2D and sfb2D. The output for the analysis
filter bank along one dimension (afb2D.A) is a list with two elements

lo low-pass subband

hi high-pass subband

afb

5

where the dimension of analysis will be half its original length. The output for the synthesis filter
bank along one dimension (sfb2D.A) will be the output array, where the dimension of synthesis
will be twice its original length.

Value

In one dimension the output for the analysis filter bank (afb) is a list with two elements

lo

hi

Low frequecy output

High frequency output

and the output for the synthesis filter bank (sfb) is the output signal.
In two dimensions the output for the analysis filter bank (afb2D) is a list with four elements

lo

hi[[1]]

hi[[2]]

hi[[3]]

low-pass subband

’lohi’ subband

’hilo’ subband

’hihi’ subband

and the output for the synthesis filter bank (sfb2D) is the output array.

Author(s)

Matlab: S. Cai, K. Li and I. Selesnick; R port: B. Whitcher

Examples

## EXAMPLE: afb, sfb
af = farras()$af
sf = farras()$sf
x = rnorm(64)
x.afb = afb(x, af)
lo = x.afb$lo
hi = x.afb$hi
y = sfb(lo, hi, sf)
err = x - y
max(abs(err))

## EXAMPLE: afb2D, sfb2D
x = matrix(rnorm(32*64), 32, 64)
af = farras()$af
sf = farras()$sf
x.afb2D = afb2D(x, af, af)
lo = x.afb2D$lo
hi = x.afb2D$hi
y = sfb2D(lo, hi, sf, sf)
err = x - y
max(abs(err))

## Example: afb2D.A, sfb2D.A
x = matrix(rnorm(32*64), 32, 64)

6

bandpass.var.spp

af = farras()$af
sf = farras()$sf
x.afb2D.A = afb2D.A(x, af, 1)
lo = x.afb2D.A$lo
hi = x.afb2D.A$hi
y = sfb2D.A(lo, hi, sf, 1)
err = x - y
max(abs(err))

ar1

Simulated AR(1) Series

Description

Simulated AR(1) series used in Gencay, Selcuk and Whitcher (2001).

Usage

data(ar1)

Format

A vector containing 200 observations.

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

bandpass.var.spp

Bandpass Variance for Long-Memory Processes

Description

Computes the band-pass variance for fractional difference (FD) or seasonal persistent (SP) pro-
cesses using numeric integration of their spectral density function.

Usage

bandpass.fdp(a, b, d)

bandpass.spp(a, b, d, fG)

bandpass.spp2(a, b, d1, f1, d2, f2)

bandpass.var.spp(delta, fG, J, Basis, Length)

7

barbara

Arguments

fG, f1, f2
J

Basis

Length

a

b
d, delta, d1, d2

Details

See references.

Value

Gegenbauer frequency.

Depth of the wavelet transform.

Logical vector representing the adaptive basis.

Number of elements in Basis.

Left-hand boundary for the definite integral.

Right-hand boundary for the definite integral.

Fractional difference parameter.

Band-pass variance for the FD or SP process between a and b.

Author(s)

B. Whitcher

References

McCoy, E. J., and A. T. Walden (1996) Wavelet analysis and synthesis of stationary long-memory
processes, Journal for Computational and Graphical Statistics, 5, No. 1, 26-56.

Whitcher, B. (2001) Simulating Gaussian stationary processes with unbounded spectra, Journal for
Computational and Graphical Statistics, 10, No. 1, 112-134.

barbara

Barbara Test Image

Description

The Barbara image comes from Allen Gersho’s lab at the University of California, Santa Barbara.

Usage

data(barbara)

Format

A 256 × 256 matrix.

Source

Internet.

8

basis

basis

Produce Boolean Vector from Wavelet Basis Names

Description

Produce a vector of zeros and ones from a vector of basis names.

Usage

basis(x, basis.names)

Output from the discrete wavelet package transfrom (DWPT).

Vector of character strings that describe leaves on the DWPT basis tree. See the
examples below for appropriate syntax.

Arguments

x

basis.names

Details

None.

Value

Vector of zeros and ones.

See Also

dwpt.

Examples

data(acvs.andel8)
## Not run:
x <- hosking.sim(1024, acvs.andel8[,2])
x.dwpt <- dwpt(x, "la8", 7)
## Select orthonormal basis from wavelet packet tree
x.basis <- basis(x.dwpt, c("w1.1","w2.1","w3.0","w4.3","w5.4","w6.10",
"w7.22","w7.23"))

for(i in 1:length(x.dwpt))

x.dwpt[[i]] <- x.basis[i] * x.dwpt[[i]]

## Resonstruct original series using selected orthonormal basis
y <- idwpt(x.dwpt, x.basis)
par(mfrow=c(2,1), mar=c(5-1,4,4-1,2))
plot.ts(x, xlab="", ylab="", main="Original Series")
plot.ts(y, xlab="", ylab="", main="Reconstructed Series")

## End(Not run)

blocks

9

blocks

A Piecewise-Constant Function

Description

Usage

data(blocks)

Format

blocks(x) =

11
(cid:88)

j=1

(1 + sign(x − pj))hj/2

A vector containing 512 observations.

Source

S+WAVELETS.

References

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

brick.wall

Replace Boundary Wavelet Coefficients with Missing Values

Description

Sets the first n wavelet coefficients to NA.

Usage

brick.wall(x, wf, method = "modwt")

dwpt.brick.wall(x, wf, n.levels, method = "modwpt")

brick.wall.2d(x, method = "modwt")

Arguments

x
wf
method
n.levels

DWT/MODWT/DWPT/MODWPT object
Character string; name of wavelet filter
Either dwt or modwt for brick.wall, or either dwpt or modwpt for dwpt.brick.wall
Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x),2).

10

Details

convolve2D

The fact that observed time series are finite causes boundary issues. One way to get around this is
to simply remove any wavelet coefficient computed involving the boundary. This is done here by
replacing boundary wavelet coefficients with NA.

Value

Same object as x only with some missing values.

Author(s)

B. Whitcher

References

Lindsay, R. W., D. B. Percival and D. A. Rothrock (1996). The discrete wavelet transform and the
scale anlaysis of the surface properties of sea ice, IEEE Transactions on Geoscience and Remote
Sensing, 34, No. 3, 771-787.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

convolve2D

Fast Column-wise Convolution of a Matrix

Description

Use the Fast Fourier Transform to perform convolutions between a sequence and each column of a
matrix.

Usage

convolve2D(x, y, conj = TRUE, type = c("circular", "open"))

Arguments

x

y

conj

type

MxN matrix.

numeric sequence of length N.
logical; if TRUE, take the complex conjugate before back-transforming (default,
and used for usual convolution).
character; one of circular, open (beginning of word is ok). For circular, the
two sequences are treated as circular, i.e., periodic.
For open and filter, the sequences are padded with zeros (from left and right)
first; filter returns the middle sub-vector of open, namely, the result of running
a weighted mean of x with weights y.

cpi

Details

11

This is a corrupted version of convolve made by replacing fft with mvfft in a few places. It would
be nice to submit this to the R Developers for inclusion.

Author(s)

B. Whitcher

See Also

convolve

cpi

U.S. Consumer Price Index

Description

Monthly U.S. consumer price index from 1948:1 to 1999:12.

Usage

data(cpi)

Format

A vector containing 624 observations.

Source

Unknown.

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

12

cplxdual2D

cplxdual2D

Dual-tree Complex 2D Discrete Wavelet Transform

Description

Dual-tree complex 2D discrete wavelet transform (DWT).

Usage

cplxdual2D(x, J, Faf, af)

icplxdual2D(w, J, Fsf, sf)

Arguments

x

J

Faf

af

w

Fsf

sf

2D array.

number of stages.

first stage analysis filters for tree i.

analysis filters for the remaining stages on tree i.

wavelet coefficients.

last stage synthesis filters for tree i.

synthesis filters for the preceeding stages.

Value

For the analysis of x, the output is

w

wavelet coefficients indexed by [[j]][[i]][[d1]][[d2]], where j = 1, . . . , J
(scale), i = 1 (real part) or i = 2 (imag part), d1 = 1, 2 and d2 = 1, 2, 3 (orien-
tations).

For the synthesis of w, the output is

y

output signal.

Author(s)

Matlab: S. Cai, K. Li and I. Selesnick; R port: B. Whitcher

See Also

FSfarras, farras, afb2D, sfb2D.

13

cshift

Examples

## Not run:
## EXAMPLE: cplxdual2D
x = matrix(rnorm(32*32), 32, 32)
J = 5
Faf = FSfarras()$af
Fsf = FSfarras()$sf
af = dualfilt1()$af
sf = dualfilt1()$sf
w = cplxdual2D(x, J, Faf, af)
y = icplxdual2D(w, J, Fsf, sf)
err = x - y
max(abs(err))

## End(Not run)

cshift

Miscellaneous Functions for Dual-Tree Wavelet Software

Description

Miscellaneous functions for dual-tree wavelet software.

Usage

cshift(x, m)

cshift2D(x, m)

pm(a, b)

Arguments

x
m
a, b

Value

y

u
v

Author(s)

N-point vector
amount of shift
input parameters

vector x will be shifed by m samples to the left or matrix x will be shifed by m
samples down.
(a + b) / sqrt(2)
(a - b) / sqrt(2)

Matlab: S. Cai, K. Li and I. Selesnick; R port: B. Whitcher

14

css.test

css.test

Testing the Wavelet Packet Tree for White Noise

Description

A wavelet packet tree, from the discrete wavelet packet transform (DWPT), is tested node-by-node
for white noise. This is the first step in selecting an orthonormal basis for the DWPT.

Usage

cpgram.test(y, p = 0.05, taper = 0.1)

css.test(y)

entropy.test(y)

portmanteau.test(y, p = 0.05, type = "Box-Pierce")

Arguments

y

p

taper

type

Details

wavelet packet tree (from the DWPT)

significance level
weight of cosine bell taper (cpgram.test only)
"Box-Pierce" and other recognized (portmanteau.test only)

Top-down recursive testing of the wavelet packet tree is

Value

Boolean vector of the same length as the number of nodes in the wavelet packet tree.

Author(s)

B. Whitcher

References

Brockwell and Davis (1991) Time Series: Theory and Methods, (2nd. edition), Springer-Verlag.

Brown, Durbin and Evans (1975) Techniques for testing the constancy of regression relationships
over time, Journal of the Royal Statistical Society B, 37, 149-163.

Percival, D. B., and A. T. Walden (1993) Spectral Analysis for Physical Applications: Multitaper
and Conventional Univariate Techniques, Cambridge University Press.

15

dau

See Also

ortho.basis.

Examples

data(mexm)
J <- 6
wf <- "la8"
mexm.dwpt <- dwpt(mexm[-c(1:4)], wf, J)
## Not implemented yet
## plot.dwpt(x.dwpt, J)
mexm.dwpt.bw <- dwpt.brick.wall(mexm.dwpt, wf, 6, method="dwpt")
mexm.tree <- ortho.basis(portmanteau.test(mexm.dwpt.bw, p=0.025))
## Not implemented yet
## plot.basis(mexm.tree)

dau

Digital Photograph of Ingrid Daubechies

Description

A digital photograph of Ingrid Daubechies taken at the 1993 AMS winter meetings in San Antonio,
Texas. The photograph was taken by David Donoho with a Canon XapShot video still frame camera.

Usage

data(dau)

Format

A 256 × 256 matrix.

Source

S+WAVELETS.

References

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

16

denoise.dwt.2d

denoise.dwt.2d

Denoise an Image via the 2D Discrete Wavelet Transform

Description

Perform simple de-noising of an image using the two-dimensional discrete wavelet transform.

Usage

denoise.dwt.2d(

x,
wf = "la8",
J = 4,
method = "universal",
H = 0.5,
noise.dir = 3,
rule = "hard"

)

Arguments

x

wf

J

method

H

noise.dir

rule

Details

input matrix (image)

name of the wavelet filter to use in the decomposition

depth of the decomposition, must be a number less than or equal to log(minM,N,2)
character string describing the threshold applied, only "universal" and "long-memory"
are currently implemented

self-similarity or Hurst parameter to indicate spectral scaling, white noise is 0.5

number of directions to estimate background noise standard deviation, the de-
fault is 3 which produces a unique estimate of the background noise for each
spatial direction
either a "hard" or "soft" thresholding rule may be used

See Thresholding.

Value

Image of the same dimension as the original but with high-freqency fluctuations removed.

Author(s)

B. Whitcher

References

See Thresholding for references concerning de-noising in one dimension.

17

doppler

See Also

Thresholding

Examples

## Xbox image
data(xbox)
n <- nrow(xbox)
xbox.noise <- xbox + matrix(rnorm(n*n, sd=.15), n, n)
par(mfrow=c(2,2), cex=.8, pty="s")
image(xbox.noise, col=rainbow(128), main="Original Image")
image(denoise.dwt.2d(xbox.noise, wf="haar"), col=rainbow(128),

zlim=range(xbox.noise), main="Denoised image")

image(xbox.noise - denoise.dwt.2d(xbox.noise, wf="haar"), col=rainbow(128),

zlim=range(xbox.noise), main="Residual image")

## Daubechies image
data(dau)
n <- nrow(dau)
dau.noise <- dau + matrix(rnorm(n*n, sd=10), n, n)
par(mfrow=c(2,2), cex=.8, pty="s")
image(dau.noise, col=rainbow(128), main="Original Image")
dau.denoise <- denoise.modwt.2d(dau.noise, wf="d4", rule="soft")
image(dau.denoise, col=rainbow(128), zlim=range(dau.noise),

main="Denoised image")

image(dau.noise - dau.denoise, col=rainbow(128), main="Residual image")

doppler

Sinusoid with Changing Amplitude and Frequency

Description

doppler(x) = (cid:112)x(1 − x)
(cid:18) 2.1π

(cid:19)

sin

x + 0.05

Usage

data(doppler)

Format

A vector containing 512 observations.

Source

S+WAVELETS.

18

References

dpss.taper

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

dpss.taper

Calculating Thomson’s Spectral Multitapers by Inverse Iteration

Description

This is now a wrapper to the function multitaper::dpss().

Usage

dpss.taper(n, k, nw = 4)

length of data taper(s)

number of data tapers; 1, 2, 3, ... (do not use 0!)

product of length and half-bandwidth parameter (w)

matrix of data tapers (cols = tapers)

eigenvalue associated with each data taper, discarded

Arguments

n

k

nw

Value

v

eigen

Author(s)

B. Whitcher

References

Percival, D. B. and A. T. Walden (1993) Spectral Estimation for Physical Applications: Multitaper
and Conventional Univariate Techniques, Cambridge University Press.

See Also

sine.taper.

dualfilt1

19

dualfilt1

Kingsbury’s Q-filters for the Dual-Tree Complex DWT

Description

Kingsbury’s Q-filters for the dual-tree complex DWT.

Usage

dualfilt1()

Details

These cofficients are rounded to 8 decimal places.

Value

af

sf

List (i=1,2) - analysis filters for tree i

List (i=1,2) - synthesis filters for tree i

Note: af[[2]] is the reverse of af[[1]].

Author(s)

Matlab: S. Cai, K. Li and I. Selesnick; R port: B. Whitcher

References

Kingsbury, N.G. (2000). A dual-tree complex wavelet transform with improved orthogonality and
symmetry properties, Proceedings of the IEEE Int. Conf. on Image Proc. (ICIP).

See Also

dualtree

dualtree

Dual-tree Complex Discrete Wavelet Transform

Description

One- and two-dimensional dual-tree complex discrete wavelet transforms developed by Kingsbury
and Selesnick et al.

dualtree

20

Usage

dualtree(x, J, Faf, af)

idualtree(w, J, Fsf, sf)

dualtree2D(x, J, Faf, af)

idualtree2D(w, J, Fsf, sf)

Arguments

x

J

Faf

af

w

Fsf

sf

Details

N-point vector or MxN matrix.

number of stages.

analysis filters for the first stage.

analysis filters for the remaining stages.

DWT coefficients.

synthesis filters for the last stage.

synthesis filters for the preceeding stages.

In one dimension N is divisible by 2J and N ≥ 2J−1 · length(af).

In two dimensions, these two conditions must hold for both M and N .

Value

For the analysis of x, the output is

w

DWT coefficients. Each wavelet scale is a list containing the real and imaginary
parts. The final scale (J+1) contains the low-pass filter coefficients.

For the synthesis of w, the output is

y

output signal

Author(s)

Matlab: S. Cai, K. Li and I. Selesnick; R port: B. Whitcher

See Also

FSfarras, farras, convolve, cshift, afb, sfb.

21

dwpt

Examples

## EXAMPLE: dualtree
x = rnorm(512)
J = 4
Faf = FSfarras()$af
Fsf = FSfarras()$sf
af = dualfilt1()$af
sf = dualfilt1()$sf
w = dualtree(x, J, Faf, af)
y = idualtree(w, J, Fsf, sf)
err = x - y
max(abs(err))

## Example: dualtree2D
x = matrix(rnorm(64*64), 64, 64)
J = 3
Faf = FSfarras()$af
Fsf = FSfarras()$sf
af = dualfilt1()$af
sf = dualfilt1()$sf
w = dualtree2D(x, J, Faf, af)
y = idualtree2D(w, J, Fsf, sf)
err = x - y
max(abs(err))

## Display 2D wavelets of dualtree2D.m

J <- 4
L <- 3 * 2^(J+1)
N <- L / 2^J
Faf <- FSfarras()$af
Fsf <- FSfarras()$sf
af <- dualfilt1()$af
sf <- dualfilt1()$sf
x <- matrix(0, 2*L, 3*L)
w <- dualtree2D(x, J, Faf, af)
w[[J]][[1]][[1]][N/2, N/2+0*N] <- 1
w[[J]][[1]][[2]][N/2, N/2+1*N] <- 1
w[[J]][[1]][[3]][N/2, N/2+2*N] <- 1
w[[J]][[2]][[1]][N/2+N, N/2+0*N] <- 1
w[[J]][[2]][[2]][N/2+N, N/2+1*N] <- 1
w[[J]][[2]][[3]][N/2+N, N/2+2*N] <- 1
y <- idualtree2D(w, J, Fsf, sf)
image(t(y), col=grey(0:64/64), axes=FALSE)

dwpt

(Inverse) Discrete Wavelet Packet Transforms

22

Description

dwpt

All possible filtering combinations (low- and high-pass) are performed to decompose a vector or
time series. The resulting coefficients are associated with a binary tree structure corresponding to a
partitioning of the frequency axis.

Usage

dwpt(x, wf = "la8", n.levels = 4, boundary = "periodic")

idwpt(y, y.basis)

Arguments

x

wf

n.levels

boundary

y

y.basis

Details

a vector or time series containing the data be to decomposed. This must be a
dyadic length vector (power of 2).

Name of the wavelet filter to use in the decomposition. By default this is set to
"la8", the Daubechies orthonormal compactly supported wavelet of length L=8
(Daubechies, 1992), least asymmetric family.

Specifies the depth of the decomposition.This must be a number less than or
equal to log(length(x), 2).
Character string specifying the boundary condition. If boundary=="periodic"
the default, then the vector you decompose is assumed to be periodic on its
defined interval,
if boundary=="reflection", the vector beyond its boundaries is assumed to
be a symmetric reflection of itself.
Object of S3 class dwpt.

Vector of character strings that describe leaves on the DWPT basis tree.

The code implements the one-dimensional DWPT using the pyramid algorithm (Mallat, 1989).

Value

Basically, a list with the following components

Wavelet coefficient vectors. The first index is associated with the scale of the
decomposition while the second is associated with the frequency partition within
that level.

Name of the wavelet filter used.

How the boundaries were handled.

w?.?

wavelet

boundary

Author(s)

B. Whitcher

dwpt.2d

References

23

Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation,
IEEE Transactions on Pattern Analysis and Machine Intelligence, 11(7), 674–693.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

Wickerhauser, M. V. (1994) Adapted Wavelet Analysis from Theory to Software, A K Peters.

See Also

dwt, modwpt, wave.filter.

Examples

data(mexm)
J <- 4
mexm.mra <- mra(log(mexm), "mb8", J, "modwt", "reflection")
mexm.nomean <- ts(

apply(matrix(unlist(mexm.mra), ncol=J+1, byrow=FALSE)[,-(J+1)], 1, sum),
start=1957, freq=12)

mexm.dwpt <- dwpt(mexm.nomean[-c(1:4)], "mb8", 7, "reflection")

dwpt.2d

(Inverse) Discrete Wavelet Packet Transforms in Two Dimensions

Description

All possible filtering combinations (low- and high-pass) are performed to decompose a matrix or
image. The resulting coefficients are associated with a quad-tree structure corresponding to a parti-
tioning of the two-dimensional frequency plane.

Usage

dwpt.2d(x, wf = "la8", J = 4, boundary = "periodic")

idwpt.2d(y, y.basis)

Arguments

x

wf

J

a matrix or image containing the data be to decomposed. This ojbect must be
dyadic (power of 2) in length in each dimension.

Name of the wavelet filter to use in the decomposition. By default this is set
to "la8", the Daubechies orthonormal compactly supported wavelet of length
L = 8 (Daubechies, 1992), least asymmetric family.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x), 2).

24

boundary

y

y.basis

Details

dwpt.boot

Character string specifying the boundary condition. If boundary=="periodic"
the default, then the vector you decompose is assumed to be periodic on its
defined interval,
if boundary=="reflection", the vector beyond its boundaries is assumed to
be a symmetric reflection of itself.
dwpt.2d object (list-based structure of matrices)
Boolean vector, the same length as y, where TRUE means the basis tensor should
be used in the reconstruction.

The code implements the two-dimensional DWPT using the pyramid algorithm of Mallat (1989).

Value

Basically, a list with the following components

w?.?-w?.?

Wavelet coefficient matrices (images). The first index is associated with the
scale of the decomposition while the second is associated with the frequency
partition within that level. The left and right strings, separated by the dash ‘-’,
correspond to the first (x) and second (y) dimensions.

wavelet

boundary

Name of the wavelet filter used.

How the boundaries were handled.

Author(s)

B. Whitcher

References

Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation,
IEEE Transactions on Pattern Analysis and Machine Intelligence, 11, No. 7, 674-693.

Wickerhauser, M. V. (1994) Adapted Wavelet Analysis from Theory to Software, A K Peters.

See Also

dwt.2d, modwt.2d, wave.filter.

dwpt.boot

Bootstrap Time Series Using the DWPT

Description

An adaptive orthonormal basis is selected in order to perform the naive bootstrap within nodes of
the wavelet packet tree. A bootstrap realization of the time series is produce by applying the inverse
DWPT.

dwpt.boot

Usage

25

dwpt.boot(y, wf, J = log(length(y), 2) - 1, p = 1e-04, frac = 1)

Arguments

y

wf

J

p

frac

Details

Not necessarily dyadic length time series.
Name of the wavelet filter to use in the decomposition. See wave.filter for
those wavelet filters available.

Depth of the discrete wavelet packet transform.

Level of significance for the white noise testing procedure.

Fraction of the time series that should be used in constructing the likelihood
function.

A subroutines is used to select an adaptive orthonormal basis for the piecewise-constant approxima-
tion to the underlying spectral density function (SDF). Once selected, sampling with replacement
is performed within each wavelet packet coefficient vector and the new collection of wavelet packet
coefficients are reconstructed into a bootstrap realization of the original time series.

Value

Time series of length $N$, where $N$ is the length of y.

Author(s)

B. Whitcher

References

Percival, D.B., S. Sardy, A. Davision (2000) Wavestrapping Time Series: Adaptive Wavelet-Based
Bootstrapping, in B.J. Fitzgerald, R.L. Smith, A.T. Walden, P.C. Young (Eds.) Nonlinear and
Nonstationary Signal Processing, pp. 442-471.

Whitcher, B. (2001) Simulating Gaussian Stationary Time Series with Unbounded Spectra, Journal
of Computational and Graphical Statistics, 10, No. 1, 112-134.

Whitcher, B. (2004) Wavelet-Based Estimation for Seasonal Long-Memory Processes, Technomet-
rics, 46, No. 2, 225-238.

See Also

dwpt.sim, spp.mle

26

dwpt.sim

dwpt.sim

Simulate Seasonal Persistent Processes Using the DWPT

Description

A seasonal persistent process may be characterized by a spectral density function with an asymptote
occuring at a particular frequency in [0, 1
It’s time domain representation was first noted in
passing by Hosking (1981). Although an exact time-domain approach to simulation is possible, this
function utilizes the discrete wavelet packet transform (DWPT).

2 ).

Usage

dwpt.sim(N, wf, delta, fG, M = 2, adaptive = TRUE, epsilon = 0.05)

Arguments

N

wf

delta

fG

M

adaptive

epsilon

Details

Length of time series to be generated.

Character string for the wavelet filter.

Long-memory parameter for the seasonal persistent process.

Gegenbauer frequency.

Actual length of simulated time series.
Logical; if TRUE the orthonormal basis used in the DWPT is adapted to the ideal
spectrum, otherwise the orthonormal basis is performed to a maximum depth.

Threshold for adaptive basis selection.

Two subroutines are used, the first selects an adaptive orthonormal basis for the true spectral den-
sity function (SDF) while the second computes the bandpass variances associated with the chosen
orthonormal basis and SDF. Finally, when M > N a uniform random variable is generated in order
to select a random piece of the simulated time series. For more details see Whitcher (2001).

Value

Time series of length N.

Author(s)

B. Whitcher

References

Hosking, J. R. M. (1981) Fractional Differencing, Biometrika, 68, No. 1, 165-176.

Whitcher, B. (2001) Simulating Gaussian Stationary Time Series with Unbounded Spectra, Journal
of Computational and Graphical Statistics, 10, No. 1, 112-134.

dwt

See Also

27

hosking.sim for an exact time-domain method and wave.filter for a list of available wavelet
filters.

Examples

## Generate monthly time series with annual oscillation
## library(ts) is required in order to access acf()
x <- dwpt.sim(256, "mb16", .4, 1/12, M=4, epsilon=.001)
par(mfrow=c(2,1))
plot(x, type="l", xlab="Time")
acf(x, lag.max=128, ylim=c(-.6,1))
data(acvs.andel8)
lines(acvs.andel8$lag[1:128], acvs.andel8$acf[1:128], col=2)

dwt

Discrete Wavelet Transform (DWT)

Description

This function performs a level J decomposition of the input vector or time series using the pyramid
algorithm (Mallat 1989).

Usage

dwt(x, wf = "la8", n.levels = 4, boundary = "periodic")

dwt.nondyadic(x)

idwt(y)

Arguments

x

wf

n.levels

boundary

y

a vector or time series containing the data be to decomposed. This must be a
dyadic length vector (power of 2).

Name of the wavelet filter to use in the decomposition. By default this is set to
"la8", the Daubechies orthonormal compactly supported wavelet of length L=8
(Daubechies, 1992), least asymmetric family.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x),2).
Character string specifying the boundary condition. If boundary=="periodic"
the default, then the vector you decompose is assumed to be periodic on its
defined interval,
if boundary=="reflection", the vector beyond its boundaries is assumed to
be a symmetric reflection of itself.
An object of S3 class dwt.

28

Details

dwt

The code implements the one-dimensional DWT using the pyramid algorithm (Mallat, 1989). The
actual transform is performed in C using pseudocode from Percival and Walden (2001). That means
convolutions, not inner products, are used to apply the wavelet filters.
For a non-dyadic length vector or time series, dwt.nondyadic pads with zeros, performs the or-
thonormal DWT on this dyadic length series and then truncates the wavelet coefficient vectors
appropriately.

Value

Basically, a list with the following components

d?

s?

wavelet

boundary

Wavelet coefficient vectors.

Scaling coefficient vector.

Name of the wavelet filter used.

How the boundaries were handled.

Author(s)

B. Whitcher

References

Daubechies, I. (1992) Ten Lectures on Wavelets, CBMS-NSF Regional Conference Series in Ap-
plied Mathematics, SIAM: Philadelphia.

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation,
IEEE Transactions on Pattern Analysis and Machine Intelligence, 11(7), 674–693.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

See Also

modwt, mra.

Examples

## Figures 4.17 and 4.18 in Gencay, Selcuk and Whitcher (2001).
data(ibm)
ibm.returns <- diff(log(ibm))
## Haar
ibmr.haar <- dwt(ibm.returns, "haar")
names(ibmr.haar) <- c("w1", "w2", "w3", "w4", "v4")
## plot partial Haar DWT for IBM data
par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(ibm.returns, axes=FALSE, ylab="", main="(a)")
for(i in 1:4)

dwt.2d

29

plot.ts(up.sample(ibmr.haar[[i]], 2^i), type="h", axes=FALSE,

ylab=names(ibmr.haar)[i])

plot.ts(up.sample(ibmr.haar$v4, 2^4), type="h", axes=FALSE,

ylab=names(ibmr.haar)[5])
axis(side=1, at=seq(0,368,by=23),

labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))

## LA(8)
ibmr.la8 <- dwt(ibm.returns, "la8")
names(ibmr.la8) <- c("w1", "w2", "w3", "w4", "v4")
## must shift LA(8) coefficients
ibmr.la8$w1 <- c(ibmr.la8$w1[-c(1:2)], ibmr.la8$w1[1:2])
ibmr.la8$w2 <- c(ibmr.la8$w2[-c(1:2)], ibmr.la8$w2[1:2])
for(i in names(ibmr.la8)[3:4])

ibmr.la8[[i]] <- c(ibmr.la8[[i]][-c(1:3)], ibmr.la8[[i]][1:3])

ibmr.la8$v4 <- c(ibmr.la8$v4[-c(1:2)], ibmr.la8$v4[1:2])
## plot partial LA(8) DWT for IBM data
par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(ibm.returns, axes=FALSE, ylab="", main="(b)")
for(i in 1:4)

plot.ts(up.sample(ibmr.la8[[i]], 2^i), type="h", axes=FALSE,

ylab=names(ibmr.la8)[i])

plot.ts(up.sample(ibmr.la8$v4, 2^4), type="h", axes=FALSE,

ylab=names(ibmr.la8)[5])
axis(side=1, at=seq(0,368,by=23),

labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))

dwt.2d

Two-Dimensional Discrete Wavelet Transform

Description

Performs a separable two-dimensional discrete wavelet transform (DWT) on a matrix of dyadic
dimensions.

Usage

dwt.2d(x, wf, J = 4, boundary = "periodic")

idwt.2d(y)

Arguments

x

wf

J

boundary

y

input matrix (image)

name of the wavelet filter to use in the decomposition

depth of the decomposition, must be a number less than or equal to log(minM,N,2)
only "periodic" is currently implemented
an object of class dwt.2d

dwt.2d

30

Details

See references.

Value

List structure containing the 3J + 1 sub-matrices from the decomposition.

Author(s)

B. Whitcher

References

Mallat, S. (1998) A Wavelet Tour of Signal Processing, Academic Press.

Vetterli, M. and J. Kovacevic (1995) Wavelets and Subband Coding, Prentice Hall.

See Also

modwt.2d.

Examples

## Xbox image
data(xbox)
xbox.dwt <- dwt.2d(xbox, "haar", 3)
par(mfrow=c(1,1), pty="s")
plot.dwt.2d(xbox.dwt)
par(mfrow=c(2,2), pty="s")
image(1:dim(xbox)[1], 1:dim(xbox)[2], xbox, xlab="", ylab="",

main="Original Image")

image(1:dim(xbox)[1], 1:dim(xbox)[2], idwt.2d(xbox.dwt), xlab="", ylab="",

main="Wavelet Reconstruction")

image(1:dim(xbox)[1], 1:dim(xbox)[2], xbox - idwt.2d(xbox.dwt),

xlab="", ylab="", main="Difference")

## Daubechies image
data(dau)
par(mfrow=c(1,1), pty="s")
image(dau, col=rainbow(128))
sum(dau^2)
dau.dwt <- dwt.2d(dau, "d4", 3)
plot.dwt.2d(dau.dwt)
sum(plot.dwt.2d(dau.dwt, plot=FALSE)^2)

dwt.3d

31

dwt.3d

Three Dimensional Separable Discrete Wavelet Transform

Description

Three-dimensional separable discrete wavelet transform (DWT).

Usage

dwt.3d(x, wf, J = 4, boundary = "periodic")

idwt.3d(y)

Arguments

x
wf
J
boundary
y

Author(s)

B. Whitcher

input array
name of the wavelet filter to use in the decomposition
depth of the decomposition, must be a number less than or equal to log(minZ,Y,Z,2)
only "periodic" is currently implemented
an object of class dwt.3d

dwt.hilbert

Discrete Hilbert Wavelet Transforms

Description

The discrete Hilbert wavelet transforms (DHWTs) for seasonal and time-varying time series anal-
ysis. Transforms include the usual orthogonal (decimated), maximal-overlap (non-decimated) and
maximal-overlap packet transforms.

Usage

dwt.hilbert(x, wf, n.levels = 4, boundary = "periodic", ...)

dwt.hilbert.nondyadic(x, ...)

idwt.hilbert(y)

modwt.hilbert(x, wf, n.levels = 4, boundary = "periodic", ...)

imodwt.hilbert(y)

modwpt.hilbert(x, wf, n.levels = 4, boundary = "periodic")

32

Arguments

x

wf

n.levels

boundary

...

y

Value

exchange

Real-valued time series or vector of observations.

Hilbert wavelet pair

Number of levels (depth) of the wavelet transform.
Boundary treatment, currently only periodic and reflection.

Additional parametes to be passed on.
An object of S3 class dwt.hilbert.

Hilbert wavelet transform object (list).

Author(s)

B. Whitcher

References

Selesnick, I. (200X). IEEE Signal Processing Magazine

Selesnick, I. (200X). IEEE Transactions in Signal Processing

Whither, B. and P.F. Craigmile (2004). Multivariate Spectral Analysis Using Hilbert Wavelet Pairs,
International Journal of Wavelets, Multiresolution and Information Processing, 2(4), 567–587.

See Also

hilbert.filter

exchange

Description

Exchange Rates Between the Deutsche Mark, Japanese Yen and U.S.
Dollar

Monthly foreign exchange rates for the Deutsche Mark - U.S. Dollar (DEM-USD) and Japanese
Yen - U.S. Dollar (JPY-USD) starting in 1970.

Usage

data(exchange)

Format

A bivariate time series containing 348 observations.

fdp.mle

Source

Unknown.

References

33

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Wavelet-based Maximum Likelihood Estimation for a Fractional Dif-
ference Process

fdp.mle

Description

Parameter estimation for a fractional difference (long-memory, self-similar) process is performed
via maximum likelihood on the wavelet coefficients.

Usage

fdp.mle(y, wf, J = log(length(y), 2))

Arguments

y

wf

J

Details

Dyadic length time series.
Name of the wavelet filter to use in the decomposition. See wave.filter for
those wavelet filters available.

Depth of the discrete wavelet transform.

The variance-covariance matrix of the original time series is approximated by its wavelet-based
equivalent. A Whittle-type likelihood is then constructed where the sums of squared wavelet coef-
ficients are compared to bandpass filtered version of the true spectrum. Minimization occurs only
for the fractional difference parameter d, while variance is estimated afterwards.

Value

List containing the maximum likelihood estimates (MLEs) of d and σ2, along with the value of the
likelihood for those estimates.

Author(s)

B. Whitcher

34

References

fdp.sdf

M. J. Jensen (2000) An alternative maximum likelihood estimator of long-memory processes using
compactly supported wavelets, Journal of Economic Dynamics and Control, 24, No. 3, 361-387.

McCoy, E. J., and A. T. Walden (1996) Wavelet analysis and synthesis of stationary long-memory
processes, Journal for Computational and Graphical Statistics, 5, No. 1, 26-56.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

Examples

## Figure 5.5 in Gencay, Selcuk and Whitcher (2001)
fdp.sdf <- function(freq, d, sigma2=1)
sigma2 / ((2*sin(pi * freq))^2)^d

dB <- function(x) 10 * log10(x)
per <- function(z) {
n <- length(z)
(Mod(fft(z))**2/(2*pi*n))[1:(n %/% 2 + 1)]

}
data(ibm)
ibm.returns <- diff(log(ibm))
ibm.volatility <- abs(ibm.returns)
ibm.vol.mle <- fdp.mle(ibm.volatility, "d4", 4)
freq <- 0:184/368
ibm.vol.per <- 2 * pi * per(ibm.volatility)
ibm.vol.resid <- ibm.vol.per/ fdp.sdf(freq, ibm.vol.mle$parameters[1])
par(mfrow=c(1,1), las=0, pty="m")
plot(freq, dB(ibm.vol.per), type="l", xlab="Frequency", ylab="Spectrum")
lines(freq, dB(fdp.sdf(freq, ibm.vol.mle$parameters[1],

ibm.vol.mle$parameters[2]/2)), col=2)

fdp.sdf

Spectral Density Functions for Long-Memory Processes

Description

Draws the spectral density functions (SDFs) for standard long-memory processes including frac-
tional difference (FD), seasonal persistent (SP), and seasonal fractional difference (SFD) processes.

Usage

fdp.sdf(freq, d, sigma2 = 1)

spp.sdf(freq, d, fG, sigma2 = 1)

spp2.sdf(freq, d1, f1, d2, f2, sigma2 = 1)

sfd.sdf(freq, s, d, sigma2 = 1)

35

find.adaptive.basis

Arguments

freq

d, d1, d2
sigma2

fG, f1, f2
s

Value

vector of frequencies, normally from 0 to 0.5

fractional difference parameter

innovations variance

Gegenbauer frequency

seasonal parameter

The power spectrum from an FD, SP or SFD process.

Author(s)

B. Whitcher

See Also

fdp.mle, spp.mle.

Examples

dB <- function(x) 10 * log10(x)

fdp.main <- expression(paste("FD", group("(",d==0.4,")")))
sfd.main <- expression(paste("SFD", group("(",list(s==12, d==0.4),")")))
spp.main <- expression(paste("SPP",

group("(",list(delta==0.4, f[G]==1/12),")")))

freq <- 0:512/1024

par(mfrow=c(2,2), mar=c(5-1,4,4-1,2), col.main="darkred")
plot(freq, dB(fdp.sdf(freq, .4)), type="l", xlab="frequency",

ylab="spectrum (dB)", main=fdp.main)

plot(freq, dB(spp.sdf(freq, .4, 1/12)), type="l", xlab="frequency",

ylab="spectrum (dB)", font.main=1, main=spp.main)

plot(freq, dB(sfd.sdf(freq, 12, .4)), type="l", xlab="frequency",

ylab="spectrum (dB)", main=sfd.main)

find.adaptive.basis

Determine an Orthonormal Basis for the Discrete Wavelet Packet
Transform

Description

Subroutine for use in simulating seasonal persistent processes using the discrete wavelet packet
transform.

36

Usage

find.adaptive.basis(wf, J, fG, eps)

FSfarras

Arguments

wf

J

fG

eps

Details

Character string; name of the wavelet filter.

Depth of the discrete wavelet packet transform.

Gegenbauer frequency.

Threshold for the squared gain function.

The squared gain functions for a Daubechies (extremal phase or least asymmetric) wavelet family
are used in a filter cascade to compute the value of the squared gain function for the wavelet packet
filter at the Gengenbauer frequency. This is done for all nodes of the wavelet packet table.

The idea behind this subroutine is to approximate the relationship between the discrete wavelet
transform and long-memory processes, where the squared gain function is zero at frequency zero
for all levels of the DWT.

Value

Boolean vector describing the orthonormal basis for the DWPT.

Author(s)

B. Whitcher

See Also

Used in dwpt.sim.

FSfarras

Farras nearly symmetric filters

Description

Farras nearly symmetric filters for orthogonal 2-channel perfect reconstruction filter bank and Farras
filters organized for the dual-tree complex DWT.

Usage

FSfarras()

Value

af

sf

List (i=1,2) - analysis filters for tree i

List (i=1,2) - synthesis filters for tree i

heavisine

Author(s)

Matlab: S. Cai, K. Li and I. Selesnick; R port: B. Whitcher

References

37

A. F. Abdelnour and I. W. Selesnick. “Nearly symmetric orthogonal wavelet bases”, Proc. IEEE
Int. Conf. Acoust., Speech, Signal Processing (ICASSP), May 2001.

See Also

afb, dualtree, dualfilt1.

heavisine

Sine with Jumps at 0.3 and 0.72

Description

heavisine(x) = 4 sin(4πx) − sign(x − 0.3)−

sign(0.72 − x)

Usage

data(heavisine)

Format

A vector containing 512 observations.

Source

S+WAVELETS.

References

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

38

hilbert.filter

hilbert.filter

Select a Hilbert Wavelet Pair

Description

Converts name of Hilbert wavelet pair to filter coefficients.

Usage

hilbert.filter(name)

Arguments

name

Details

Character string of Hilbert wavelet pair, see acceptable names below (e.g., "k3l3").

Simple switch statement selects the appropriate HWP. There are two parameters that define a
Hilbert wavelet pair using the notation of Selesnick (2001,2002), K and L. Currently, the only
implemented combinations (K, L) are (3,3), (3,5), (4,2) and (4,4).

Value

List containing the following items:

L

h0, g0
h1, g1

length of the wavelet filter

low-pass filter coefficients

high-pass filter coefficients

Author(s)

B. Whitcher

References

Selesnick, I.W. (2001). Hilbert transform pairs of wavelet bases. IEEE Signal Processing Letters
8(6), 170–173.

Selesnick, I.W. (2002). The design of approximate Hilbert transform pairs of wavelet bases. IEEE
Transactions on Signal Processing 50(5), 1144–1152.

See Also

wave.filter

hosking.sim

Examples

hilbert.filter("k3l3")
hilbert.filter("k3l5")
hilbert.filter("k4l2")
hilbert.filter("k4l4")

39

hosking.sim

Generate Stationary Gaussian Process Using Hosking’s Method

Description

Uses exact time-domain method from Hosking (1984) to generate a simulated time series from a
specified autocovariance sequence.

Usage

hosking.sim(n, acvs)

Arguments

n

acvs

Value

Length of series.

Autocovariance sequence of series with which to generate, must be of length at
least n.

Length n time series from true autocovariance sequence acvs.

Author(s)

B. Whitcher

References

Hosking, J. R. M. (1984) Modeling persistence in hydrological time series using fractional differ-
encing, Water Resources Research, 20, No. 12, 1898-1908.

Percival, D. B. (1992) Simulating Gaussian random processes with specified spectra, Computing
Science and Statistics, 22, 534-538.

40

Examples

ibm

dB <- function(x) 10 * log10(x)
per <- function (z) {

n <- length(z)
(Mod(fft(z))^2/(2 * pi * n))[1:(n%/%2 + 1)]

}
spp.sdf <- function(freq, delta, omega)

abs(2 * (cos(2*pi*freq) - cos(2*pi*omega)))^(-2*delta)

data(acvs.andel8)
n <- 1024
## Not run:
z <- hosking.sim(n, acvs.andel8[,2])
per.z <- 2 * pi * per(z)
par(mfrow=c(2,1), las=1)
plot.ts(z, ylab="", main="Realization of a Seasonal Long-Memory Process")
plot(0:(n/2)/n, dB(per.z), type="l", xlab="Frequency", ylab="dB",

main="Periodogram")

lines(0:(n/2)/n, dB(spp.sdf(0:(n/2)/n, .4, 1/12)), col=2)

## End(Not run)

ibm

Daily IBM Stock Prices

Description

Daily IBM stock prices spanning May~17, 1961 to November~2, 1962.

Usage

data(ibm)

Format

A vector containing 369 observations.

Source

Box, G. E.P. and Jenkins, G. M. (1976) Time Series Analysis: Forecasting and Control, Holden
Day, San Francisco, 2nd edition.

japan

41

japan

Japanese Gross National Product

Description

Quarterly Japanese gross national product from 1955:1 to 1996:4.

Usage

data(japan)

Format

A vector containing 169 observations.

Source

Unknown.

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Hecq, A. (1998) Does seasonal adjustment induce common cycles?, Empirical Economics, 59, 289-
297.

jumpsine

Sine with Jumps at 0.625 and 0.875

jumpsine(x) = 10 (cid:0)sin(4πx) + I[0.625<x≤0.875]

(cid:1)

Description

Usage

data(jumpsine)

Format

A vector containing 512 observations.

Source

S+WAVELETS.

42

References

linchirp

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

kobe

1995 Kobe Earthquake Data

Description

Seismograph (vertical acceleration, nm/sq.sec) of the Kobe earthquake, recorded at Tasmania Uni-
versity, HobarTRUE, Australia on 16 January 1995 beginning at 20:56:51 (GMTRUE) and contin-
uing for 51 minutes at 1 second intervals.

Usage

data(kobe)

Format

A vector containing 3048 observations.

Source

Data management centre, Washington University.

linchirp

Linear Chirp

Description

Usage

data(linchirp)

Format

linchirp(x) = sin(0.125πnx2)

A vector containing 512 observations.

Source

S+WAVELETS.

References

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

manual.thresh

43

manual.thresh

Wavelet Shrinkage via Thresholding

Description

Perform wavelet shrinkage using data-analytic, hybrid SURE, manual, SURE, or universal thresh-
olding.

Usage

da.thresh(wc, alpha = .05, max.level = 4, verbose = FALSE, return.thresh = FALSE)

hybrid.thresh(wc, max.level = 4, verbose = FALSE, seed = 0)

manual.thresh(wc, max.level = 4, value, hard = TRUE)

sure.thresh(wc, max.level = 4, hard = TRUE)

universal.thresh(wc, max.level = 4, hard = TRUE)

universal.thresh.modwt(wc, max.level = 4, hard = TRUE)

Arguments

wc

max.level

value

hard

alpha

verbose

seed

return.thresh

Details

wavelet coefficients

maximum level of coefficients to be affected by threshold
threshold value (only utilized in manual.thresh)
Boolean value, if hard=F then soft thresholding is used

level of the hypothesis tests
if verbose=TRUE then information is printed to the screen
sets random seed (only utilized in hybrid.thresh)
if return.thresh=TRUE then the vector of threshold values is returned, other-
wise the surviving wavelet coefficients are returned

An extensive amount of literature has been written on wavelet shrinkage. The functions here rep-
resent the most basic approaches to the problem of nonparametric function estimation. See the
references for further information.

Value

The default output is a list structure, the same length as was input, containing only those wavelet
coefficients surviving the threshold.

44

Author(s)

B. Whitcher (some code taken from R. Todd Ogden)

References

mexm

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Ogden, R. T. (1996) Essential Wavelets for Statistical Applications and Data Analysis, Birkhauser.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

Vidakovic, B. (1999) Statistical Modeling by Wavelets, John Wiley and Sons.

mexm

Mexican Money Supply

Description

Percentage changes in monthly Mexican money supply.

Usage

data(mexm)

Format

A vector containing 516 observations.

Source

Unknown.

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

modhwt.coh

45

modhwt.coh

Time-varying and Seasonal Analysis Using Hilbert Wavelet Pairs

Description

Performs time-varying or seasonal coherence and phase anlaysis between two time seris using the
maximal-overlap discrete Hilbert wavelet transform (MODHWT).

Usage

modhwt.coh(x, y, f.length = 0)

modhwt.phase(x, y, f.length = 0)

modhwt.coh.seasonal(x, y, S = 10, season = 365)

modhwt.phase.seasonal(x, y, season = 365)

Arguments

x
y
f.length
S
season

Details

MODHWT object.
MODHWT object.
Length of the rectangular filter.
Number of "seasons".
Length of the "season".

The idea of seasonally-varying spectral analysis (SVSA, Madden 1986) is generalized using the
MODWT and Hilbert wavelet pairs. For the seasonal case, S seasons are used to produce a consis-
tent estimate of the coherence and phase. For the non-seasonal case, a simple rectangular (moving-
average) filter is applied to the MODHWT coefficients in order to produce consistent estimates.

Value

Time-varying or seasonal coherence and phase between two time series. The coherence estimates
are between zero and one, while the phase estimates are between −π and π.

Author(s)

B. Whitcher

References

Madden, R.A. (1986). Seasonal variation of the 40–50 day oscillation in the tropics. Journal of the
Atmospheric Sciences 43(24), 3138–3158.

Whither, B. and P.F. Craigmile (2004). Multivariate Spectral Analysis Using Hilbert Wavelet Pairs,
International Journal of Wavelets, Multiresolution and Information Processing, 2(4), 567–587.

46

See Also

hilbert.filter

modwt

modwt

(Inverse) Maximal Overlap Discrete Wavelet Transform

Description

This function performs a level J decomposition of the input vector using the non-decimated discrete
wavelet transform. The inverse transform performs the reconstruction of a vector or time series from
its maximal overlap discrete wavelet transform.

Usage

modwt(x, wf = "la8", n.levels = 4, boundary = "periodic")

imodwt(y)

Arguments

x

wf

n.levels

boundary

y

Details

a vector or time series containing the data be to decomposed. There is no re-
striction on its length.

Name of the wavelet filter to use in the decomposition. By default this is set to
"la8", the Daubechies orthonormal compactly supported wavelet of length L=8
(Daubechies, 1992), least asymmetric family.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x),2).
Character string specifying the boundary condition. If boundary=="periodic"
the defaulTRUE, then the vector you decompose is assumed to be periodic on
its defined interval,
if boundary=="reflection", the vector beyond its boundaries is assumed to
be a symmetric reflection of itself.
an object of class "modwt"

The code implements the one-dimensional non-decimated DWT using the pyramid algorithm. The
actual transform is performed in C using pseudocode from Percival and Walden (2001). That means
convolutions, not inner products, are used to apply the wavelet filters.

The MODWT goes by several names in the statistical and engineering literature, such as, the “sta-
tionary DWT”, “translation-invariant DWT”, and “time-invariant DWT”.

The inverse MODWT implements the one-dimensional inverse transform using the pyramid algo-
rithm (Mallat, 1989).

47

modwt

Value

Basically, a list with the following components

d?

s?

wavelet

boundary

Wavelet coefficient vectors.

Scaling coefficient vector.

Name of the wavelet filter used.

How the boundaries were handled.

Author(s)

B. Whitcher

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Percival, D. B. and P. Guttorp (1994) Long-memory processes, the Allan variance and wavelets, In
Wavelets and Geophysics, pages 325-344, Academic Press.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

See Also

dwt, idwt, mra.

Examples

## Figure 4.23 in Gencay, Selcuk and Whitcher (2001)
data(ibm)
ibm.returns <- diff(log(ibm))
# Haar
ibmr.haar <- modwt(ibm.returns, "haar")
names(ibmr.haar) <- c("w1", "w2", "w3", "w4", "v4")
# LA(8)
ibmr.la8 <- modwt(ibm.returns, "la8")
names(ibmr.la8) <- c("w1", "w2", "w3", "w4", "v4")
# shift the MODWT vectors
ibmr.la8 <- phase.shift(ibmr.la8, "la8")
## plot partial MODWT for IBM data
par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(ibm.returns, axes=FALSE, ylab="", main="(a)")
for(i in 1:5)

plot.ts(ibmr.haar[[i]], axes=FALSE, ylab=names(ibmr.haar)[i])

axis(side=1, at=seq(0,368,by=23),

labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))

par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(ibm.returns, axes=FALSE, ylab="", main="(b)")
for(i in 1:5)

plot.ts(ibmr.la8[[i]], axes=FALSE, ylab=names(ibmr.la8)[i])

axis(side=1, at=seq(0,368,by=23),

48

modwt.2d

labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))

modwt.2d

Two-Dimensional Maximal Overlap Discrete Wavelet Transform

Description

Performs a separable two-dimensional maximal overlap discrete wavelet transform (MODWT) on
a matrix of arbitrary dimensions.

Usage

modwt.2d(x, wf, J = 4, boundary = "periodic")

imodwt.2d(y)

Arguments

x

wf

J

boundary

y

Details

See references.

Value

input matrix

name of the wavelet filter to use in the decomposition

depth of the decomposition
only "periodic" is currently implemented
an object of class dwt.2d

List structure containing the 3J + 1 sub-matrices from the decomposition.

Author(s)

B. Whitcher

References

Liang, J. and T. W. Parks (1994) A two-dimensional translation invariant wavelet representation and
its applications, Proceedings ICIP-94, Vol. 1, 66-70.

Liang, J. and T. W. Parks (1994) Image coding using translation invariant wavelet transforms with
symmetric extensions, IEEE Transactions on Image Processing, 7, No. 5, 762-769.

See Also

dwt.2d, shift.2d.

modwt.3d

Examples

49

## Xbox image
data(xbox)
xbox.modwt <- modwt.2d(xbox, "haar", 2)
## Level 1 decomposition
par(mfrow=c(2,2), pty="s")
image(xbox.modwt$LH1, col=rainbow(128), axes=FALSE, main="LH1")
image(xbox.modwt$HH1, col=rainbow(128), axes=FALSE, main="HH1")
frame()
image(xbox.modwt$HL1, col=rainbow(128), axes=FALSE, main="HL1")
## Level 2 decomposition
par(mfrow=c(2,2), pty="s")
image(xbox.modwt$LH2, col=rainbow(128), axes=FALSE, main="LH2")
image(xbox.modwt$HH2, col=rainbow(128), axes=FALSE, main="HH2")
image(xbox.modwt$LL2, col=rainbow(128), axes=FALSE, main="LL2")
image(xbox.modwt$HL2, col=rainbow(128), axes=FALSE, main="HL2")
sum((xbox - imodwt.2d(xbox.modwt))^2)

data(dau)
par(mfrow=c(1,1), pty="s")
image(dau, col=rainbow(128), axes=FALSE, main="Ingrid Daubechies")
sum(dau^2)
dau.modwt <- modwt.2d(dau, "d4", 2)
## Level 1 decomposition
par(mfrow=c(2,2), pty="s")
image(dau.modwt$LH1, col=rainbow(128), axes=FALSE, main="LH1")
image(dau.modwt$HH1, col=rainbow(128), axes=FALSE, main="HH1")
frame()
image(dau.modwt$HL1, col=rainbow(128), axes=FALSE, main="HL1")
## Level 2 decomposition
par(mfrow=c(2,2), pty="s")
image(dau.modwt$LH2, col=rainbow(128), axes=FALSE, main="LH2")
image(dau.modwt$HH2, col=rainbow(128), axes=FALSE, main="HH2")
image(dau.modwt$LL2, col=rainbow(128), axes=FALSE, main="LL2")
image(dau.modwt$HL2, col=rainbow(128), axes=FALSE, main="HL2")
sum((dau - imodwt.2d(dau.modwt))^2)

modwt.3d

Description

Three Dimensional Separable Maximal Ovelrap Discrete Wavelet
Transform

Three-dimensional separable maximal overlap discrete wavelet transform (MODWT).

Usage

modwt.3d(x, wf, J = 4, boundary = "periodic")

imodwt.3d(y)

mra

input array

name of the wavelet filter to use in the decomposition

depth of the decomposition
only "periodic" is currently implemented
an object of class modwt.3d

50

Arguments

x

wf

J

boundary

y

Author(s)

B. Whitcher

mra

Multiresolution Analysis of Time Series

Description

This function performs a level J additive decomposition of the input vector or time series using the
pyramid algorithm (Mallat 1989).

Usage

mra(x, wf = "la8", J = 4, method = "modwt", boundary = "periodic")

Arguments

x

wf

J

method

boundary

Details

A vector or time series containing the data be to decomposed. This must be a
dyadic length vector (power of 2) for method="dwt".

Name of the wavelet filter to use in the decomposition. By default this is set to
"la8", the Daubechies orthonormal compactly supported wavelet of length L=8
least asymmetric family.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x), 2).
Either "dwt" or "modwt".
Character string specifying the boundary condition. If boundary=="periodic"
the default, then the vector you decompose is assumed to be periodic on its
defined interval,
if boundary=="reflection", the vector beyond its boundaries is assumed to
be a symmetric reflection of itself.

This code implements a one-dimensional multiresolution analysis introduced by Mallat (1989).
Either the DWT or MODWT may be used to compute the multiresolution analysis, which is an
additive decomposition of the original time series.

51

mra

Value

Basically, a list with the following components

D?

S?

wavelet

boundary

Wavelet detail vectors.

Wavelet smooth vector.

Name of the wavelet filter used.

How the boundaries were handled.

Author(s)

B. Whitcher

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation,
IEEE Transactions on Pattern Analysis and Machine Intelligence, 11, No. 7, 674-693.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

See Also

dwt, modwt.

Examples

## Easy check to see if it works...
x <- rnorm(32)
x.mra <- mra(x)
sum(x - apply(matrix(unlist(x.mra), nrow=32), 1, sum))^2

## Figure 4.19 in Gencay, Selcuk and Whitcher (2001)
data(ibm)
ibm.returns <- diff(log(ibm))
ibm.volatility <- abs(ibm.returns)
## Haar
ibmv.haar <- mra(ibm.volatility, "haar", 4, "dwt")
names(ibmv.haar) <- c("d1", "d2", "d3", "d4", "s4")
## LA(8)
ibmv.la8 <- mra(ibm.volatility, "la8", 4, "dwt")
names(ibmv.la8) <- c("d1", "d2", "d3", "d4", "s4")
## plot multiresolution analysis of IBM data
par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(ibm.volatility, axes=FALSE, ylab="", main="(a)")
for(i in 1:5)

plot.ts(ibmv.haar[[i]], axes=FALSE, ylab=names(ibmv.haar)[i])

axis(side=1, at=seq(0,368,by=23),

labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))

par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))

52

mra.2d

plot.ts(ibm.volatility, axes=FALSE, ylab="", main="(b)")
for(i in 1:5)

plot.ts(ibmv.la8[[i]], axes=FALSE, ylab=names(ibmv.la8)[i])

axis(side=1, at=seq(0,368,by=23),

labels=c(0,"",46,"",92,"",138,"",184,"",230,"",276,"",322,"",368))

mra.2d

Multiresolution Analysis of an Image

Description

This function performs a level J additive decomposition of the input matrix or image using the
pyramid algorithm (Mallat 1989).

Usage

mra.2d(x, wf = "la8", J = 4, method = "modwt", boundary = "periodic")

Arguments

x

wf

J

method

boundary

Details

A matrix or image containing the data be to decomposed. This must be have
dyadic length in both dimensions (but not necessarily the same) for method="dwt".

Name of the wavelet filter to use in the decomposition. By default this is set to
"la8", the Daubechies orthonormal compactly supported wavelet of length L=8
least asymmetric family.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x),2).

Either "dwt" or "modwt".

Character string specifying the boundary condition. If boundary=="periodic"
the default, then the matrix you decompose is assumed to be periodic on its
defined interval,
if boundary=="reflection", the matrix beyond its boundaries is assumed to
be a symmetric reflection of itself.

This code implements a two-dimensional multiresolution analysis by performing the one-dimensional
pyramid algorithm (Mallat 1989) on the rows and columns of the input matrix. Either the DWT or
MODWT may be used to compute the multiresolution analysis, which is an additive decomposition
of the original matrix (image).

mra.2d

Value

Basically, a list with the following components

53

Wavelet detail image in the horizontal direction.

Wavelet detail image in the vertical direction.

Wavelet detail image in the diagonal direction.

Wavelet smooth image at the coarsest resolution.

Depth of the wavelet transform.

Name of the wavelet filter used.

How the boundaries were handled.

LH?

HL?

HH?

LLJ

J

wavelet

boundary

Author(s)

B. Whitcher

References

Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation,
IEEE Transactions on Pattern Analysis and Machine Intelligence, 11, No. 7, 674-693.

Mallat, S. G. (1998) A Wavelet Tour of Signal Processing, Academic Press.

See Also

dwt.2d, modwt.2d

Examples

## Easy check to see if it works...
## --------------------------------

x <- matrix(rnorm(32*32), 32, 32)
# MODWT
x.mra <- mra.2d(x, method="modwt")
x.mra.sum <- x.mra[[1]]
for(j in 2:length(x.mra))

x.mra.sum <- x.mra.sum + x.mra[[j]]

sum((x - x.mra.sum)^2)

# DWT
x.mra <- mra.2d(x, method="dwt")
x.mra.sum <- x.mra[[1]]
for(j in 2:length(x.mra))

x.mra.sum <- x.mra.sum + x.mra[[j]]

sum((x - x.mra.sum)^2)

54

mra.3d

mra.3d

Three Dimensional Multiresolution Analysis

Description

This function performs a level J additive decomposition of the input array using the pyramid algo-
rithm (Mallat 1989).

Usage

mra.3d(x, wf = "la8", J = 4, method = "modwt", boundary = "periodic")

Arguments

x

wf

J

method

boundary

Details

A three-dimensional array containing the data be to decomposed. This must be
have dyadic length in all three dimensions (but not necessarily the same) for
method="dwt".
Name of the wavelet filter to use in the decomposition. By default this is set
to "la8", the Daubechies orthonormal compactly supported wavelet of length
L = 8 least asymmetric family.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x), 2).
Either "dwt" or "modwt".
Character string specifying the boundary condition. If boundary=="periodic"
the default and only method implemented, then the matrix you decompose is
assumed to be periodic on its defined interval.

This code implements a three-dimensional multiresolution analysis by performing the one-dimensional
pyramid algorithm (Mallat 1989) on each dimension of the input array. Either the DWT or MODWT
may be used to compute the multiresolution analysis, which is an additive decomposition of the
original array.

Value

List structure containing the filter triplets associated with the multiresolution analysis.

Author(s)

B. Whitcher

References

Mallat, S. G. (1989) A theory for multiresolution signal decomposition: the wavelet representation,
IEEE Transactions on Pattern Analysis and Machine Intelligence, 11, No. 7, 674-693.

Mallat, S. G. (1998) A Wavelet Tour of Signal Processing, Academic Press.

mult.loc

See Also

dwt.3d, modwt.3d

55

mult.loc

Wavelet-based Testing and Locating for Variance Change Points

Description

This is the major subroutine for testing.hov, providing the workhorse algorithm to recursively
test and locate multiple variance changes in so-called long memory processes.

Usage

mult.loc(dwt.list, modwt.list, wf, level, min.coef, debug)

Arguments

dwt.list
modwt.list
wf
level
min.coef
debug

Details

List of wavelet vector coefficients from the dwt.
List of wavelet vector coefficients from the modwt.
Name of the wavelet filter to use in the decomposition.
Specifies the depth of the decomposition.
Minimum number of wavelet coefficients for testing purposes.
Boolean variable: if set to TRUE, actions taken by the algorithm are printed to
the screen.

For details see Section 9.6 of Percival and Walden (2000) or Section 7.3 in Gencay, Selcuk and
Whitcher (2001).

Value

Matrix.

Author(s)

B. Whitcher

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.
Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

See Also

rotcumvar, testing.hov.

56

my.acf

my.acf

Autocovariance Functions via the Discrete Fourier Transform

Description

Computes the autocovariance function (ACF) for a time series or the cross-covariance function
(CCF) between two time series.

Usage

my.acf(x)

my.ccf(a, b)

Arguments

x, a, b

time series

Details

The series is zero padded to twice its length before the discrete Fourier transform is applied. Only
the values corresponding to nonnegative lags are provided (for the ACF).

Value

The autocovariance function for all nonnegative lags or the cross-covariance function for all lags.

Author(s)

B. Whitcher

Examples

data(ibm)
ibm.returns <- diff(log(ibm))
plot(1:length(ibm.returns) - 1, my.acf(ibm.returns), type="h",

xlab="lag", ylab="ACVS", main="Autocovariance Sequence for IBM Returns")

nile

57

nile

Nile River Minima

Description

Yearly minimal water levels of the Nile river for the years 622 to 1281, measured at the Roda gauge
near Cairo (Tousson, 1925, p. 366-385). The data are listed in chronological sequence by row.

Usage

data(nile)

Format

A length 663 vector.

Details

The original Nile river data supplied by Beran only contained only 500 observations (622 to 1121).
However, the book claimed to have 660 observations (622 to 1281). The remaining observations
from the book were added, by hand, but the series still only contained 653 observations (622 to
1264).

Note, now the data consists of 663 observations (spanning the years 622-1284) as in original source
(Toussoun, 1925).

Source

Toussoun, O. (1925) M\’emoire sur l’Histoire du Nil, Volume 18 in M\’emoires a l’Institut d’Egypte,
pp. 366-404.

References

Beran, J. (1994) Statistics for Long-Memory Processes, Chapman Hall: Englewood, NJ.

ortho.basis

Derive Orthonormal Basis from Wavelet Packet Tree

Description

An orthonormal basis for the discrete wavelet transform may be characterized via a disjoint par-
titioning of the frequency axis that covers [0, 1
2 ). This subroutine produces an orthonormal basis
from a full wavelet packet tree.

Usage

ortho.basis(xtree)

58

Arguments

xtree

Details

is a vector whose entries are associated with a wavelet packet tree.

per

A wavelet packet tree is a binary tree of Boolean variables. Parent nodes are removed if any of their
children exist.

Value

Boolean vector describing the orthonormal basis for the DWPT.

Author(s)

B. Whitcher

Examples

data(japan)
J <- 4
wf <- "mb8"
japan.mra <- mra(log(japan), wf, J, boundary="reflection")
japan.nomean <-

ts(apply(matrix(unlist(japan.mra[-(J+1)]), ncol=J, byrow=FALSE), 1, sum),

start=1955, freq=4)

japan.nomean2 <- ts(japan.nomean[42:169], start=1965.25, freq=4)
plot(japan.nomean2, type="l")
japan.dwpt <- dwpt(japan.nomean2, wf, 6)
japan.basis <-

ortho.basis(portmanteau.test(japan.dwpt, p=0.01, type="other"))

# Not implemented yet
# par(mfrow=c(1,1))
# plot.basis(japan.basis)

per

Periodogram

Description

Computation of the periodogram via the Fast Fourier Transform (FFT).

Usage

per(z)

Arguments

z

time series

phase.shift

Author(s)

Author: Jan Beran; modified: Martin Maechler, Date: Sep 1995.

phase.shift

Phase Shift Wavelet Coefficients

59

Description

Wavelet coefficients are circularly shifted by the amount of phase shift induced by the wavelet
transform.

Usage

phase.shift(z, wf, inv = FALSE)

phase.shift.packet(z, wf, inv = FALSE)

Arguments

z

wf

inv

Details

DWT object

character string; wavelet filter used in DWT
Boolean variable; if inv=TRUE then the inverse phase shift is applied

The center-of-energy argument of Hess-Nielsen and Wickerhauser (1996) is used to provide a flex-
ible way to circularly shift wavelet coefficients regardless of the wavelet filter used. The results are
not identical to those used by Percival and Walden (2000), but are more flexible.
phase.shift.packet is not yet implemented fully.

Value

DWT (DWPT) object with coefficients circularly shifted.

Author(s)

B. Whitcher

References

Hess-Nielsen, N. and M. V. Wickerhauser (1996) Wavelets and time-frequency analysis, Proceed-
ings of the IEEE, 84, No. 4, 523-540.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

60

phase.shift.hilbert

phase.shift.hilbert

Phase Shift for Hilbert Wavelet Coefficients

Description

Wavelet coefficients are circularly shifted by the amount of phase shift induced by the discrete
Hilbert wavelet transform.

Usage

phase.shift.hilbert(x, wf)

Arguments

x

wf

Details

Discete Hilbert wavelet transform (DHWT) object.

character string; Hilbert wavelet pair used in DHWT

The "center-of-energy" argument of Hess-Nielsen and Wickerhauser (1996) is used to provide a
flexible way to circularly shift wavelet coefficients regardless of the wavelet filter used.

Value

DHWT (DHWPT) object with coefficients circularly shifted.

Author(s)

B. Whitcher

References

Hess-Nielsen, N. and M. V. Wickerhauser (1996) Wavelets and time-frequency analysis, Proceed-
ings of the IEEE, 84, No. 4, 523-540.

See Also

phase.shift

plot.dwt.2d

61

plot.dwt.2d

Plot Two-dimensional Discrete Wavelet Transform

Description

Organizes the wavelet coefficients from a 2D DWT into a single matrix and plots it. The coarser
resolutions are nested within the lower-lefthand corner of the image.

Usage

## S3 method for class 'dwt.2d'
plot(x, cex.axis = 1, plot = TRUE, ...)

Arguments

x

input matrix (image)

cex.axis

par plotting parameter that controls the size of the axis text

if plot = FALSE then the matrix of wavelet coefficients is returned, the default is
plot = TRUE

additional graphical parameters if necessary

plot

...

Details

The wavelet coefficients from the DWT object (a list) are reorganized into a single matrix of the
same dimension as the original image and the result is plotted.

Value

Image plot.

Author(s)

B. Whitcher

See Also

dwt.2d.

qmf

Quadrature Mirror Filter

62

qmf

Description

Computes the quadrature mirror filter from a given filter.

Usage

qmf(g, low2high = TRUE)

Filter coefficients.
Logical, default is TRUE which means a low-pass filter is input and a high-pass
filter is output. Setting low2high=F performs the inverse.

Arguments

g

low2high

Details

None.

Value

Quadrature mirror filter.

Author(s)

B. Whitcher

References

Any basic signal processing text.

See Also

wave.filter.

Examples

## Haar wavelet filter
g <- wave.filter("haar")$lpf
qmf(g)

rotcumvar

63

rotcumvar

Rotated Cumulative Variance

Description

Provides the normalized cumulative sums of squares from a sequence of coefficients with the diag-
onal line removed.

Usage

rotcumvar(x)

Arguments

x

Details

vector of coefficients to be cumulatively summed (missing values excluded)

The rotated cumulative variance, when plotted, provides a qualitative way to study the time depen-
dence of the variance of a series. If the variance is stationary over time, then only small deviations
from zero should be present. If on the other hand the variance is non-stationary, then large de-
partures may exist. Formal hypothesis testing may be performed based on boundary crossings of
Brownian bridge processes.

Value

Vector of coefficients that are the sumulative sum of squared input coefficients.

Author(s)

B. Whitcher

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

64

shift.2d

shift.2d

Circularly Shift Matrices from a 2D MODWT

Description

Compute phase shifts for wavelet sub-matrices based on the “center of energy” argument of Hess-
Nielsen and Wickerhauser (1996).

Usage

shift.2d(z, inverse = FALSE)

Arguments

z

inverse

Details

Two-dimensional MODWT object

Boolean value on whether to perform the forward or inverse operation.

The "center of energy" technique of Wickerhauser and Hess-Nielsen (1996) is employed to find
circular shifts for the wavelet sub-matrices such that the coefficients are aligned with the original
series. This corresponds to applying a (near) linear-phase filtering operation.

Value

Two-dimensional MODWT object with circularly shifted coefficients.

Author(s)

B. Whitcher

References

Hess-Nielsen, N. and M. V. Wickerhauser (1996) Wavelets and time-frequency analysis, Proceed-
ings of the IEEE, 84, No. 4, 523-540.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

See Also

phase.shift, modwt.2d.

sine.taper

Examples

65

n <- 512
G1 <- G2 <- dnorm(seq(-n/4, n/4, length=n))
G <- 100 * zapsmall(outer(G1, G2))
G <- modwt.2d(G, wf="la8", J=6)
k <- 50
xr <- yr <- trunc(n/2) + (-k:k)
par(mfrow=c(3,3), mar=c(1,1,2,1), pty="s")
for (j in names(G)[1:9]) {

image(G[[j]][xr,yr], col=rainbow(64), axes=FALSE, main=j)

}
Gs <- shift.2d(G)
for (j in names(G)[1:9]) {

image(Gs[[j]][xr,yr], col=rainbow(64), axes=FALSE, main=j)

}

sine.taper

Computing Sinusoidal Data Tapers

Description

Computes sinusoidal data tapers directly from equations.

Usage

sine.taper(n, k)

length of data taper(s)
number of data tapers

Arguments

n
k

Details

See reference.

Value

A vector or matrix of data tapers (cols = tapers).

Author(s)

B. Whitcher

References

Riedel, K. S. and A. Sidorenko (1995) Minimum bias multiple taper spectral estimation, IEEE
Transactions on Signal Processing, 43, 188-195.

66

spin.covariance

spin.covariance

Compute Wavelet Cross-Covariance Between Two Time Series

Description

Computes wavelet cross-covariance or cross-correlation between two time series.

Usage

spin.covariance(x, y, lag.max = NA)

spin.correlation(x, y, lag.max = NA)

Arguments

x

y

first time series
second time series, same length as x

lag.max

maximum lag to compute cross-covariance (correlation)

Details

See references.

Value

List structure holding the wavelet cross-covariances (correlations) according to scale.

Author(s)

B. Whitcher

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Whitcher, B., P. Guttorp and D. B. Percival (2000) Wavelet analysis of covariance with application
to atmospheric time series, Journal of Geophysical Research, 105, No. D11, 14,941-14,962.

See Also

wave.covariance, wave.correlation.

67

spp.mle

Examples

## Figure 7.9 from Gencay, Selcuk and Whitcher (2001)
data(exchange)
returns <- diff(log(exchange))
returns <- ts(returns, start=1970, freq=12)
wf <- "d4"
demusd.modwt <- modwt(returns[,"DEM.USD"], wf, 8)
demusd.modwt.bw <- brick.wall(demusd.modwt, wf)
jpyusd.modwt <- modwt(returns[,"JPY.USD"], wf, 8)
jpyusd.modwt.bw <- brick.wall(jpyusd.modwt, wf)
n <- dim(returns)[1]
J <- 6
lmax <- 36
returns.cross.cor <- NULL
for(i in 1:J) {

blah <- spin.correlation(demusd.modwt.bw[[i]], jpyusd.modwt.bw[[i]], lmax)
returns.cross.cor <- cbind(returns.cross.cor, blah)

}
returns.cross.cor <- ts(as.matrix(returns.cross.cor), start=-36, freq=1)
dimnames(returns.cross.cor) <- list(NULL, paste("Level", 1:J))
lags <- length(-lmax:lmax)
lower.ci <- tanh(atanh(returns.cross.cor) - qnorm(0.975) /

sqrt(matrix(trunc(n/2^(1:J)), nrow=lags, ncol=J, byrow=TRUE)

- 3))

upper.ci <- tanh(atanh(returns.cross.cor) + qnorm(0.975) /

sqrt(matrix(trunc(n/2^(1:J)), nrow=lags, ncol=J, byrow=TRUE)

- 3))

par(mfrow=c(3,2), las=1, pty="m", mar=c(5,4,4,2)+.1)
for(i in J:1) {

plot(returns.cross.cor[,i], ylim=c(-1,1), xaxt="n", xlab="Lag (months)",

ylab="", main=dimnames(returns.cross.cor)[[2]][i])

axis(side=1, at=seq(-36, 36, by=12))
lines(lower.ci[,i], lty=1, col=2)
lines(upper.ci[,i], lty=1, col=2)
abline(h=0,v=0)

}

Wavelet-based Maximum Likelihood Estimation for Seasonal Persis-
tent Processes

spp.mle

Description

Parameter estimation for a seasonal persistent (seasonal long-memory) process is performed via
maximum likelihood on the wavelet coefficients.

68

Usage

spp.mle

spp.mle(y, wf, J = log(length(y), 2) - 1, p = 0.01, frac = 1)

spp2.mle(y, wf, J = log(length(y), 2) - 1, p = 0.01, dyadic = TRUE, frac = 1)

Arguments

y

wf

J

p

frac

dyadic

Details

Not necessarily dyadic length time series.
Name of the wavelet filter to use in the decomposition. See wave.filter for
those wavelet filters available.

Depth of the discrete wavelet packet transform.

Level of significance for the white noise testing procedure.

Fraction of the time series that should be used in constructing the likelihood
function.

Logical parameter indicating whether or not the original time series is dyadic in
length.

The variance-covariance matrix of the original time series is approximated by its wavelet-based
equivalent. A Whittle-type likelihood is then constructed where the sums of squared wavelet coeffi-
cients are compared to bandpass filtered version of the true spectral density function. Minimization
occurs for the fractional difference parameter d and the Gegenbauer frequency fG, while the inno-
vations variance is subsequently estimated.

Value

List containing the maximum likelihood estimates (MLEs) of δ, fG and σ2, along with the value of
the likelihood for those estimates.

Author(s)

B. Whitcher

References

Whitcher, B. (2004) Wavelet-based estimation for seasonal long-memory processes, Technometrics,
46, No. 2, 225-238.

See Also

fdp.mle

spp.var

69

spp.var

Variance of a Seasonal Persistent Process

Description

Computes the variance of a seasonal persistent (SP) process using a hypergeometric series expan-
sion.

Usage

spp.var(d, fG, sigma2 = 1)

Hypergeometric(a, b, c, z)

Arguments

d

fG

sigma2

a, b, c, z

Details

Fractional difference parameter.

Gegenbauer frequency.

Innovations variance.

Parameters for the hypergeometric series.

See Lapsa (1997). The subroutine to compute a hypergeometric series was taken from Numerical
Recipes in C.

Value

The variance of an SP process.

Author(s)

B. Whitcher

References

Lapsa, P.M. (1997) Determination of Gegenbauer-type random process models. Signal Processing
63, 73-90.

Press, W.H., S.A. Teukolsky, W.T. Vetterling and B.P. Flannery (1992) Numerical Recipes in C, 2nd
edition, Cambridge University Press.

70

squared.gain

squared.gain

Squared Gain Function of a Filter

Description

Produces the modulus squared of the Fourier transform for a given filtering sequence.

Usage

squared.gain(wf.name, filter.seq = "L", n = 512)

Arguments

wf.name

filter.seq

n

Details

Character string of wavelet filter.
Character string of filter sequence. H means high-pass filtering and L means
low-pass filtering. Sequence is read from right to left.
Length of zero-padded filter. Frequency resolution will be n/2+1.

Uses cascade subroutine to compute the squared gain function from a given filtering sequence.

Value

Squared gain function.

Author(s)

B. Whitcher

See Also

wave.filter, wavelet.filter.

Examples

par(mfrow=c(2,2))
f.seq <- "H"
plot(0:256/512, squared.gain("d4", f.seq), type="l", ylim=c(0,2),

xlab="frequency", ylab="L = 4", main="Level 1")
lines(0:256/512, squared.gain("fk4", f.seq), col=2)
lines(0:256/512, squared.gain("mb4", f.seq), col=3)
abline(v=c(1,2)/4, lty=2)
legend(-.02, 2, c("Daubechies", "Fejer-Korovkin", "Minimum-Bandwidth"),

lty=1, col=1:3, bty="n", cex=1)

f.seq <- "HL"
plot(0:256/512, squared.gain("d4", f.seq), type="l", ylim=c(0,4),

xlab="frequency", ylab="", main="Level 2")

stackPlot

71

lines(0:256/512, squared.gain("fk4", f.seq), col=2)
lines(0:256/512, squared.gain("mb4", f.seq), col=3)
abline(v=c(1,2)/8, lty=2)
f.seq <- "H"
plot(0:256/512, squared.gain("d8", f.seq), type="l", ylim=c(0,2),

xlab="frequency", ylab="L = 8", main="")
lines(0:256/512, squared.gain("fk8", f.seq), col=2)
lines(0:256/512, squared.gain("mb8", f.seq), col=3)
abline(v=c(1,2)/4, lty=2)
f.seq <- "HL"
plot(0:256/512, squared.gain("d8", f.seq), type="l", ylim=c(0,4),

xlab="frequency", ylab="", main="")

lines(0:256/512, squared.gain("fk8", f.seq), col=2)
lines(0:256/512, squared.gain("mb8", f.seq), col=3)
abline(v=c(1,2)/8, lty=2)

stackPlot

Stack Plot

Description

Stack plot of an object. This function attempts to mimic a function called stack.plot in S+WAVELETS.

Usage

stackPlot(

x,
plot.type = c("multiple", "single"),
panel = lines,
log = "",
col = par("col"),
bg = NA,
pch = par("pch"),
cex = par("cex"),
lty = par("lty"),
lwd = par("lwd"),
ann = par("ann"),
xlab = "Time",
main = NULL,
oma = c(6, 0, 5, 0),
layout = NULL,
same.scale = 1:dim(x)[2],
...

)

72

Arguments

testing.hov

x
plot.type, panel, log, col, bg, pch, cex, lty, lwd, ann, xlab, main, oma, ...

ts object

See plot.ts.
Doublet defining the dimension of the panel. If not specified, the dimensions are
chosen automatically.

Vector the same length as the number of series to be plotted. If not specified, all
panels will have unique axes.

layout

same.scale

Details

Produces a set of plots, one for each element (column) of x.

Author(s)

B. Whitcher

testing.hov

Testing for Homogeneity of Variance

Description

A recursive algorithm for detecting and locating multiple variance change points in a sequence of
random variables with long-range dependence.

Usage

testing.hov(x, wf, J, min.coef = 128, debug = FALSE)

Arguments

x

wf

J

min.coef

debug

Details

Sequence of observations from a (long memory) time series.

Name of the wavelet filter to use in the decomposition.

Specifies the depth of the decomposition. This must be a number less than or
equal to log(length(x), 2).

Minimum number of wavelet coefficients for testing purposes. Empirical results
suggest that 128 is a reasonable number in order to apply asymptotic critical
values.
Boolean variable: if set to TRUE, actions taken by the algorithm are printed to
the screen.

For details see Section 9.6 of Percival and Walden (2000) or Section 7.3 in Gencay, Selcuk and
Whitcher (2001).

tourism

Value

73

Matrix whose columns include (1) the level of the wavelet transform where the variance change
occurs, (2) the value of the test statistic, (3) the DWT coefficient where the change point is located,
(4) the MODWT coefficient where the change point is located. Note, there is currently no checking
that the MODWT is contained within the associated support of the DWT coefficient. This could
lead to incorrect estimates of the location of the variance change.

Author(s)

B. Whitcher

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

See Also

dwt, modwt, rotcumvar, mult.loc.

tourism

U.S. Tourism

Description

Quarterly U.S. tourism figures from 1960:1 to 1999:4.

Usage

data(tourism)

Format

A vector containing 160 observations.

Source

Unknown.

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

74

up.sample

unemploy

U.S. Unemployment

Description

Monthly U.S. unemployment figures from 1948:1 to 1999:12.

Usage

data(unemploy)

Format

A vector containing 624 observations.

Source

Unknown.

References

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

up.sample

Upsampling of a vector

Description

Upsamples a given vector.

Usage

up.sample(x, f, y = NA)

Arguments

x

f

y

Value

vector of observations

frequency of upsampling; e.g, 2, 4, etc.

value to upsample with; e.g., NA, 0, etc.

A vector twice its length.

75

wave.filter

Author(s)

B. Whitcher

References

Any basic signal processing text.

wave.filter

Select a Wavelet Filter

Description

Converts name of wavelet filter to filter coefficients.

Usage

wave.filter(name)

Arguments

name

Details

Character string of wavelet filter.

Simple switch statement selects the appropriate filter.

Value

List containing the following items:

L

hpf

lpf

Length of the wavelet filter.

High-pass filter coefficients.

Low-pass filter coefficients.

Author(s)

B. Whitcher

References

Daubechies, I. (1992) Ten Lectures on Wavelets, CBMS-NSF Regional Conference Series in Ap-
plied Mathematics, SIAM: Philadelphia.

Doroslovacki (1998) On the least asymmetric wavelets, IEEE Transactions for Signal Processing,
46, No. 4, 1125-1130.

Morris and Peravali (1999) Minimum-bandwidth discrete-time wavelets, Signal Processing, 76, No.
2, 181-193.

Nielsen, M. (2000) On the Construction and Frequency Localization of Orthogonal Quadrature
Filters, Journal of Approximation Theory, 108, No. 1, 36-52.

76

See Also

wavelet.filter, squared.gain.

wave.variance

wave.variance

Wavelet Analysis of Univariate/Bivariate Time Series

Description

Produces an estimate of the multiscale variance, covariance or correlation along with approximate
confidence intervals.

Usage

wave.variance(x, type = "eta3", p = 0.025)

wave.covariance(x, y)

wave.correlation(x, y, N, p = 0.975)

Arguments

x

type

p

y

N

Details

first time series

character string describing confidence interval calculation; valid methods are
gaussian, eta1, eta2, eta3, nongaussian

(one minus the) two-sided p-value for the confidence interval

second time series

length of time series

The time-independent wavelet variance is basically the average of the squared wavelet coefficients
across each scale. As shown in Percival (1995), the wavelet variance is a scale-by-scale decompo-
sition of the variance for a stationary process, and certain non-stationary processes.

Value

Matrix with as many rows as levels in the wavelet transform object. The first column provides the
point estimate for the wavelet variance, covariance, or correlation followed by the lower and upper
bounds from the confidence interval.

Author(s)

B. Whitcher

wave.variance

References

77

Gencay, R., F. Selcuk and B. Whitcher (2001) An Introduction to Wavelets and Other Filtering
Methods in Finance and Economics, Academic Press.

Percival, D. B. (1995) Biometrika, 82, No. 3, 619-631.

Percival, D. B. and A. T. Walden (2000) Wavelet Methods for Time Series Analysis, Cambridge
University Press.

Whitcher, B., P. Guttorp and D. B. Percival (2000) Wavelet Analysis of Covariance with Application
to Atmospheric Time Series, Journal of Geophysical Research, 105, No. D11, 14,941-14,962.

Examples

## Figure 7.3 from Gencay, Selcuk and Whitcher (2001)
data(ar1)
ar1.modwt <- modwt(ar1, "haar", 6)
ar1.modwt.bw <- brick.wall(ar1.modwt, "haar")
ar1.modwt.var2 <- wave.variance(ar1.modwt.bw, type="gaussian")
ar1.modwt.var <- wave.variance(ar1.modwt.bw, type="nongaussian")
par(mfrow=c(1,1), las=1, mar=c(5,4,4,2)+.1)
matplot(2^(0:5), ar1.modwt.var2[-7,], type="b", log="xy",

xaxt="n", ylim=c(.025, 6), pch="*LU", lty=1, col=c(1,4,4),
xlab="Wavelet Scale", ylab="")

matlines(2^(0:5), as.matrix(ar1.modwt.var)[-7,2:3], type="b",

pch="LU", lty=1, col=3)

axis(side=1, at=2^(0:5))
legend(1, 6, c("Wavelet variance", "Gaussian CI", "Non-Gaussian CI"),

lty=1, col=c(1,4,3), bty="n")

## Figure 7.8 from Gencay, Selcuk and Whitcher (2001)
data(exchange)
returns <- diff(log(as.matrix(exchange)))
returns <- ts(returns, start=1970, freq=12)
wf <- "d4"
J <- 6
demusd.modwt <- modwt(returns[,"DEM.USD"], wf, J)
demusd.modwt.bw <- brick.wall(demusd.modwt, wf)
jpyusd.modwt <- modwt(returns[,"JPY.USD"], wf, J)
jpyusd.modwt.bw <- brick.wall(jpyusd.modwt, wf)
returns.modwt.cov <- wave.covariance(demusd.modwt.bw, jpyusd.modwt.bw)
par(mfrow=c(1,1), las=0, mar=c(5,4,4,2)+.1)
matplot(2^(0:(J-1)), returns.modwt.cov[-(J+1),], type="b", log="x",

pch="*LU", xaxt="n", lty=1, col=c(1,4,4), xlab="Wavelet Scale",
ylab="Wavelet Covariance")

axis(side=1, at=2^(0:7))
abline(h=0)

returns.modwt.cor <- wave.correlation(demusd.modwt.bw, jpyusd.modwt.bw,

N = dim(returns)[1])

par(mfrow=c(1,1), las=0, mar=c(5,4,4,2)+.1)
matplot(2^(0:(J-1)), returns.modwt.cor[-(J+1),], type="b", log="x",

pch="*LU", xaxt="n", lty=1, col=c(1,4,4), xlab="Wavelet Scale",
ylab="Wavelet Correlation")

78

wave.variance.2d

axis(side=1, at=2^(0:7))
abline(h=0)

wave.variance.2d

Wavelet Analysis of Images

Description

Produces an estimate of the multiscale variance with approximate confidence intervals using the 2D
MODWT.

Usage

wave.variance.2d(x, p = 0.025)

Arguments

x

p

Details

image

(one minus the) two-sided p-value for the confidence interval

The wavelet variance is basically the average of the squared wavelet coefficients across each scale
and direction of an image. As shown in Mondal and Percival (2012), the wavelet variance is a scale-
by-scale decomposition of the variance for a stationary spatial process, and certain non-stationary
spatial processes.

Value

Data frame with 3J+1 rows.

Author(s)

B. Whitcher

References

Mondal, D. and D. B. Percival (2012). Wavelet variance analysis for random fields on a regular
lattice. IEEE Transactions on Image Processing 21, 537–549.

wavelet.filter

79

wavelet.filter

Higher-Order Wavelet Filters

Description

Create a wavelet filter at arbitrary scale.

Usage

wavelet.filter(wf.name, filter.seq = "L", n = 512)

Arguments

wf.name

filter.seq

n

Details

Character string of wavelet filter.
Character string of filter sequence. H means high-pass filtering and L means
low-pass filtering. Sequence is read from right to left.
Length of zero-padded filter. Frequency resolution will be n/2+1.

Uses cascade subroutine to compute higher-order wavelet coefficient vector from a given filtering
sequence.

Value

Vector of wavelet coefficients.

Author(s)

B. Whitcher

References

Bruce, A. and H.-Y. Gao (1996). Applied Wavelet Analysis with S-PLUS, Springer: New York.

Doroslovacki, M. L. (1998) On the least asymmetric wavelets, IEEE Transactions on Signal Pro-
cessing, 46, No. 4, 1125-1130.

Daubechies, I. (1992) Ten Lectures on Wavelets, CBMS-NSF Regional Conference Series in Ap-
plied Mathematics, SIAM: Philadelphia.

Morris and Peravali (1999) Minimum-bandwidth discrete-time wavelets, Signal Processing, 76, No.
2, 181-193.

Nielsen, M. (2001) On the Construction and Frequency Localization of Finite Orthogonal Quadra-
ture Filters, Journal of Approximation Theory, 108, No. 1, 36-52.

See Also

squared.gain, wave.filter.

80

Examples

xbox

## Figure 4.14 in Gencay, Selcuk and Whitcher (2001)
par(mfrow=c(3,1), mar=c(5-2,4,4-1,2))
f.seq <- "HLLLLL"
plot(c(rep(0,33), wavelet.filter("mb4", f.seq), rep(0,33)), type="l",

xlab="", ylab="", main="D(4) in black, MB(4) in red")

lines(c(rep(0,33), wavelet.filter("d4", f.seq), rep(0,33)), col=2)
plot(c(rep(0,35), -wavelet.filter("mb8", f.seq), rep(0,35)), type="l",

xlab="", ylab="", main="D(8) in black, -MB(8) in red")
lines(c(rep(0,35), wavelet.filter("d8", f.seq), rep(0,35)), col=2)
plot(c(rep(0,39), wavelet.filter("mb16", f.seq), rep(0,39)), type="l",

xlab="", ylab="", main="D(16) in black, MB(16) in red")

lines(c(rep(0,39), wavelet.filter("d16", f.seq), rep(0,39)), col=2)

xbox

Image with Box and X

xbox(i, j) = I[i=n/4, 3n/4, j; n/4≤j≤3n/4]+

I[n/4≤i≤3n/4; j=n/4, 3n/4, i]

Description

Usage

data(xbox)

Format

A 128 × 128 matrix.

Source

S+WAVELETS.

References

Bruce, A., and H.-Y. Gao (1996) Applied Wavelet Analysis with S-PLUS, Springer: New York.

Index

∗ datasets

acvs.andel8, 3
ar1, 6
barbara, 7
blocks, 9
cpi, 11
dau, 15
doppler, 17
exchange, 32
heavisine, 37
ibm, 40
japan, 41
jumpsine, 41
kobe, 42
linchirp, 42
mexm, 44
nile, 57
tourism, 73
unemploy, 74
xbox, 80

∗ hplot

stackPlot, 71

∗ ts

afb, 4
bandpass.var.spp, 6
basis, 8
brick.wall, 9
convolve2D, 10
cplxdual2D, 12
cshift, 13
css.test, 14
denoise.dwt.2d, 16
dpss.taper, 18
dualfilt1, 19
dualtree, 19
dwpt, 21
dwpt.2d, 23
dwpt.boot, 24
dwpt.sim, 26

dwt, 27
dwt.2d, 29
dwt.3d, 31
dwt.hilbert, 31
fdp.mle, 33
fdp.sdf, 34
find.adaptive.basis, 35
FSfarras, 36
hilbert.filter, 38
hosking.sim, 39
manual.thresh, 43
modhwt.coh, 45
modwt, 46
modwt.2d, 48
modwt.3d, 49
mra, 50
mra.2d, 52
mra.3d, 54
mult.loc, 55
my.acf, 56
ortho.basis, 57
per, 58
phase.shift, 59
phase.shift.hilbert, 60
plot.dwt.2d, 61
qmf, 62
rotcumvar, 63
shift.2d, 64
sine.taper, 65
spin.covariance, 66
spp.mle, 67
spp.var, 69
squared.gain, 70
testing.hov, 72
up.sample, 74
wave.filter, 75
wave.variance, 76
wavelet.filter, 79

acvs.andel10 (acvs.andel8), 3

81

82

acvs.andel11 (acvs.andel8), 3
acvs.andel8, 3
acvs.andel9 (acvs.andel8), 3
afb, 4, 20, 37
afb2D, 12
afb2D (afb), 4
AntonB (dualfilt1), 19
ar1, 6

bandpass.fdp (bandpass.var.spp), 6
bandpass.spp (bandpass.var.spp), 6
bandpass.spp2 (bandpass.var.spp), 6
bandpass.var.spp, 6
barbara, 7
basis, 8
bishrink (manual.thresh), 43
blocks, 9
brick.wall, 9

convolve, 11, 20
convolve2D, 10
cpgram.test (css.test), 14
cpi, 11
cplxdual2D, 12
cshift, 13, 20
cshift2D (cshift), 13
css.test, 14

da.thresh (manual.thresh), 43
dau, 15
denoise.dwt.2d, 16
denoise.modwt.2d (denoise.dwt.2d), 16
doppler, 17
dpss.taper, 18
dualfilt1, 19, 37
dualtree, 19, 19, 37
dualtree2D (dualtree), 19
dwpt, 8, 9, 21
dwpt.2d, 23
dwpt.boot, 24
dwpt.brick.wall (brick.wall), 9
dwpt.sim, 25, 26, 36
dwt, 9, 23, 27, 47, 51, 73
dwt.2d, 24, 29, 48, 53, 61
dwt.3d, 31, 55
dwt.hilbert, 31

entropy.test (css.test), 14
exchange, 32

INDEX

farras, 12, 20
farras (FSfarras), 36
fdp.mle, 33, 35, 68
fdp.sdf, 34
find.adaptive.basis, 35
FSfarras, 12, 20, 36

heavisine, 37
hilbert.filter, 32, 38, 46
hosking.sim, 27, 39
hybrid.thresh (manual.thresh), 43
Hypergeometric (spp.var), 69

ibm, 40
icplxdual2D (cplxdual2D), 12
idualtree (dualtree), 19
idualtree2D (dualtree), 19
idwpt (dwpt), 21
idwpt.2d (dwpt.2d), 23
idwt, 47
idwt (dwt), 27
idwt.2d (dwt.2d), 29
idwt.3d (dwt.3d), 31
idwt.hilbert (dwt.hilbert), 31
imodwt (modwt), 46
imodwt.2d (modwt.2d), 48
imodwt.3d (modwt.3d), 49
imodwt.hilbert (dwt.hilbert), 31

japan, 41
jumpsine, 41

kobe, 42

linchirp, 42

manual.thresh, 43
mexm, 44
modhwt.coh, 45
modhwt.phase (modhwt.coh), 45
modwpt, 9, 23
modwpt (dwpt), 21
modwpt.hilbert (dwt.hilbert), 31
modwt, 9, 28, 46, 51, 73
modwt.2d, 24, 30, 48, 53, 64
modwt.3d, 49, 55
modwt.hilbert (dwt.hilbert), 31
mra, 28, 47, 50
mra.2d, 52
mra.3d, 54

83

wave.covariance (wave.variance), 76
wave.filter, 23–25, 27, 33, 38, 62, 68, 70,

75, 79

wave.variance, 76
wave.variance.2d, 78
wavelet.filter, 70, 76, 79

xbox, 80

INDEX

mult.loc, 55, 73
my.acf, 56
my.ccf (my.acf), 56

nile, 57

ortho.basis, 15, 57

per, 58
phase.shift, 59, 60, 64
phase.shift.hilbert, 60
plot.dwt.2d, 61
pm (cshift), 13
portmanteau.test (css.test), 14

qmf, 62

rotcumvar, 55, 63, 73

sfb, 20
sfb (afb), 4
sfb2D, 12
sfb2D (afb), 4
sfd.sdf (fdp.sdf), 34
shift.2d, 48, 64
sine.taper, 18, 65
soft (manual.thresh), 43
spin.correlation (spin.covariance), 66
spin.covariance, 66
spp.mle, 25, 35, 67
spp.sdf (fdp.sdf), 34
spp.var, 69
spp2.mle (spp.mle), 67
spp2.sdf (fdp.sdf), 34
squared.gain, 70, 76, 79
stackPlot, 71
sure.thresh (manual.thresh), 43

testing.hov, 55, 72
Thresholding, 16, 17
Thresholding (manual.thresh), 43
tourism, 73

unemploy, 74
universal.thresh (manual.thresh), 43
up.sample, 74

wave.correlation, 66
wave.correlation (wave.variance), 76
wave.covariance, 66

