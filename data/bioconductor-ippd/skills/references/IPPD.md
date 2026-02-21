IPPD package vignette

Martin Slawski 1
Rene Hussong 2
Andreas Hildebrandt 3
Matthias Hein 1

ms@cs.uni-saarland.de
rene.hussong@uni.lu
andreas.hildebrandt@uni-mainz.de
hein@cs.uni-saarland.de

1 Saarland University, Department of Computer Science, Machine Learning Group,

Saarbr¨ucken, Germany

2 Luxembourg Centre for Systems Biomedicine, University of Luxembourg, Luxemburg
3 Johannes Gutenberg-University Mainz, Institute for Computer Science, Mainz, Germany

,

Abstract

This is the vignette of the Bioconductor add-on package IPPD which implements
automatic isotopic pattern extraction from a raw protein mass spectrum. Basically, the
user only has to provide mass/charge channels and corresponding intensities, which are
automatically decomposed into a list of monoisotopic peaks. IPPD can handle several
charge states as well as overlaps of peak patterns.

1 Aims and scope of IPPD

A crucial challenge in the analysis of protein mass spectrometry data is to automatically
process the raw spectrum to a list of peptide masses. IPPD is tailored to spectra where pep-
tides emerge in the form of isotope patterns, i.e. one observes several peaks for each peptide
mass at a given charge state due to the natural abundance of heavy isotopes. Datasets
with a size of up to 100,000 mass/charge channels and the presence of isotope patterns
at multiple charge states frequently exhibiting overlap make the manual annotation of a
raw spectrum a tedious task. IPPD provides functionality to perform this task in a fully
automatic, transparent and user-customizable way. Basically, one feeds the raw spectrum
into one single function to obtain a list of monoisotopic peaks described by a mass/charge
channel, a charge and an intensity. What makes our approach particularly user-friendly
is its dependence on only a small set of easily interpretable parameters. We also oﬀer a
method to display the decomposition of the spectrum graphically, thereby facilitating a
manual validation of the output.

2 Methodology

2.1 Template model

In the context of this package, a protein mass spectrum is understood as a sequence of pairs
{xi, yi}n
i=1, where xi = mi/zi is a mass (mi) per charge (zi) value (measured in Thomson)
and yi is the intensity, i.e. the abundance of a particular mass (modulo charge state),

1

Figure 1: Illustration of the template construction as described in the text. The left panel
depicts diﬀerent templates of diﬀerent charge states (1 to 4). The right panel zooms at the
charge two template ϕ2.

observed at xi, i = 1, . . . , n, which are assumed to be in an increasing order. The yi are
modeled as a linear combination of template functions representing prior knowledge about
peak shapes and the composition of isotopic patterns. If our model were exact, we could
write

y = Φβ∗, y = (y1, . . . , yn)(cid:62),

(1)

where Φ is a matrix template functions and β∗ a vector of weights for each template. Only
a small fraction of all templates are needed to ﬁt the signal, i.e. β∗ is highly sparse. Since
y ≥ 0, where ’≥’ is understood componentwise, all template functions are nonnegative and
accordingly β∗ ≥ 0. Model (1) can equivalently be written as

y = (cid:2) Φ1

. . . ΦC






(cid:3)

β∗
1
...
β∗
C




 =

C
(cid:88)

c=1

Φcβ∗
c ,

(2)

where Φc, β∗
c denote the matrix of template functions and weight vector to ﬁt isotopic
patterns of a particular charge state c, c = 1, . . . , C. Each submatrix Φc can in turn
be divided into columns ϕc,1, . . . , ϕc,pc, where the entries of each column vector store the
evaluations of a template ϕcj , j = 1, . . . , pc, at the xi, i = 1, . . . , n. Each template ϕc,j
depends on parameter mc,j describing the m/z position at which ϕc,j is placed. A template
ϕc,j is used to ﬁt an isotopic pattern of peaks composed of several single peaks, which is
modeled as

ϕc,j =

(cid:88)

k∈Zc,j

ac,j,k ψc,j,k,θc,j , Zc,j ⊂ Z

(3)

where the ψc,j,k are functions representing a peak of a single isotope within an isotopic
pattern. They depend on mc,j and a parameter vector θc,j. The nonnegative weights
ac,j,k reﬂect the relative abundance of the isotope indexed by k. The ac,j,k are computed

2

10001002100410061008101010120.00.20.40.60.81.0xjj((x))jj1jj2jj3jj4100410051006100710080.00.20.40.60.81.0xjj((x))oooooooyy0yy--1yy1yy2yy3yy4yy5omk    k==--1    ……    5ak    k==--1    ……    5according to the averagine model (Senko et al. [1995]) and hence are ﬁxed in advance. Each
ψc,j,k is linked to a location mc,j,k at which it attains its maximum. The mc,j,k are calculated
from mc,j as mc,j,k = mc,j + κ k
c , where κ equals 1 Dalton (≈ 1.003). The rationale behind
Eq. (3) and the deﬁnitions that follow is the fact that the location of the most intense
isotope is taken as characteristic location of the template, i.e. we set mc,j,0 = mc,j so that
the remaining mc,j,k, k (cid:54)= 0, are computed by shifting mc,j in both directions on the m/z
axis. By ’most intense isotope’, we mean that ac,j,0 = maxk ac,j,k = 1. The set Zc,j is a
subset of the integers which depends on the averagine model and a pre-speciﬁed tolerance,
i.e. we truncate summation in Eq. (3) if the weights drop below that tolerance. Figure 1
illustrates the construction scheme and visualizes our notation.

2.2 Peak shape

In an idealized setting, the ψc,j,k are delta functions at speciﬁc locations.
In practice,
however, the shape of a peak equals that of a bump which may exhibit some skewness. In
the case of no to moderate skewness, we model peaks by Gaussian functions:

ψc,j,k(x) = exp

−

(cid:18)

(x − mc,j,k)2
σc,j

(cid:19)

.

(4)

The parameter to be determined is θc,j = σc,j > 0. In the case of considerable skewness,
peaks are modeled by exponentially modiﬁed Gaussian (EMG) functions, see for instance
Grushka [1972], Marco and Bombi [2001], and Schulz-Trieglaﬀ et al. [2007] in the context
of protein mass spectrometry:

ψc,j,k(x) =

1
αc,j

exp

F (t) =

(cid:90) t

−∞

1
√
2π

(cid:32) σ2
c,j
2α2
c,j
(cid:18)
u2
2

−

exp

(cid:19)

du.

µc,j − (x − mc,j,k)
αc,j

(cid:33) (cid:18)

1 − F

(cid:18) σc,j
αc,j

+

µc,j − (x − mc,j,k)
σc,j

(cid:19)(cid:19)

,

+

(5)

The EMG function involves a vector of three parameters θc,j = (αc,j, σc,j, µc,j)(cid:62) ∈ R+ ×
R+ × R. The parameter αc,j controls the additional length of the right tail as compared to
a Gaussian. For αc,j ↓ 0, the EMG function becomes a Gaussian. For our ﬁtting approach
as outlined in Section 2.3, it is crucial to estimate the θc,j, which are usually unknown,
from the data as good as possible. To this end, we model each component θl of θ as a
linear combination of known functions gl,m of x = m/z and an error component εl, i.e.

θl(x) =

Ml(cid:88)

m=1

νl,mgl,m(x) + εl(x).

(6)

In the case of no prior knowledge about the gl,m, we model θl as a constant independent
of x. In most cases, it is sensible to assume a linear trend, i.e. θl(x) = νl,1 + νl,2x. In order
to ﬁt a model of the form (6), we have to collect information from the data {xi, yi}n
i=1. To
be precise, we proceed according to the following steps.

1. We apply a simple peak detection algorithm to the spectrum to identify disjoint

regions Rr ⊂ {1, . . . , n}, r = 1, . . . , R, of well-resolved peaks.

3

2. For each region r, we ﬁt the chosen peak shape to the data {xi, yi}i∈Rr using nonlinear

least squares:

min
θ

(cid:88)

i∈Rr

(yi − ψθ(xi))2,

(7)

yielding an estimate (cid:98)θr((cid:98)xr), where (cid:98)xr denotes an estimation for the mode of the peak
in region Rr.

3. The sequence {(cid:98)xr, (cid:98)θr}R
νl,m in model (6).

r=1 is then used as input for the estimation of the parameters

Step 2.
is easily solved by the general purpose nonnegative least squares routine nls in
R:::stats for a Gaussian peak shape. For the EMG, we have to perform a grid search over
all three parameters to ﬁnd a suitable starting value, which is then passed to the general
purpose optimization routine optim in R:::stats with the option method = "BFGS" and
a speciﬁcation of a closed form expression of the gradient via the argument gr. For step
3., we use least absolute deviation regression because of the presence of outliers arising
from less well-resolved, wiggly or overlapping peaks. The whole procedure is performed by
the function fitModelParameters as demonstrated below. After loading the package, we
access the real world dataset myo500 and extract m/z channels (x) and the corresponding
intensities (y). For computational convenience and since they contain very few relevant
information, we discard all channels above 2500.

R> library(IPPD)
R> data(myo500)
R> x <- myo500[,"mz"]
R> y <- myo500[,"intensities"]
R> y <- y[x <= 2500]
R> x <- x[x <= 2500]

To have a look at the data, we plot the ﬁrst 1000 (x,y) pairs:

R> layout(matrix(c(1,2), 1, 2))
R> plot(x[1:1000], y[1:1000], xlab = expression(x[1]~~ldots~~x[1000]),

cex.lab = 1.5, cex.axis = 1.25, ylab = expression(y))

R> plot(x[x >= 804 & x <= 807], y[x >= 804 & x <= 807],

xlab = "x: 804 <= x <= 807",
cex.lab = 1.5, cex.axis = 1.25, ylab = expression(y), type = "b")

R> layout(matrix(1))
R>

4

In the plot, one identiﬁes a prominent peak pattern beginning at about 804, which is
zoomed at in the right panel.
We now apply fitModelParameters to ﬁt model (6) for the width parameter σ of a Gaus-
sian function (4). For simplicity, we take g1(x) = 1, g2(x) = x. The model is speciﬁed by
using an R formula interface.

R> fitGauss <- fitModelParameters(mz = x, intensities = y,

model = "Gaussian", fitting = "model", formula.sigma = formula(~mz),
control = list(window = 6, threshold = 200))

An analogous command for the EMG (5) with the model formulae α(x) = ν1,1 + ν1,2x,
σ(x) = ν2,1 + ν2,2x, µ(x) = ν3,1 is given by

R> fitEMG <- fitModelParameters(mz = x, intensities = y,

model = "EMG", fitting = "model",

formula.alpha = formula(~mz),
formula.sigma = formula(~mz),
formula.mu = formula(~1),
control = list(window = 6, threshold = 200))

Inspecting the results, we ﬁnd that R = 55 peak regions are used to ﬁt an EMG pa-
rameter model. Moreover, it turns out that the EMG model is a more appropriate peak
model for the data when visually comparing the list of mean residual sums of squares of
the EMG ﬁts and the Gauss ﬁts extracted from slot(fitEMG, "peakfitresults") and

5

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll8008100100200300400x1  …  x1000ylllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll804.0805.5807.0050100150200250300350x: 804 <= x <= 807yslot(fitGauss, "peakfitresults"), respectively. The ﬁgure shows an example where
the EMG shape comes relatively close to the observed data. A long right tail indicates
that a Gaussian would yield a rather poor ﬁt here.

R> show(fitEMG)

’

’

Peak model
number of peaks used: 55

EMG

fitted as fuction of m/z

R> mse.EMG <- data.frame(mse = slot(fitEMG,"peakfitresults")[,"rss"]

R> mse.Gauss <- data.frame(mse = slot(fitGauss,"peakfitresults")[,"rss"]

/ slot(fitEMG,"peakfitresults")[,"datapoints"],
peakshape = rep("EMG", nrow( slot(fitEMG,"peakfitresults"))))

/ slot(fitGauss,"peakfitresults")[,"datapoints"],
peakshape = rep("Gaussian", nrow( slot(fitGauss,"peakfitresults"))))

R> mses <- rbind(mse.EMG, mse.Gauss)
R> with(mses, boxplot(mse ~ peakshape, cex.axis = 1.5, cex.lab = 1.5, ylab = "MSE"))
R>

R> visualize(fitEMG, type = "peak", cex.lab = 1.5, cex.axis = 1.25)

6

llllllllllllllEMGGaussian0.000.040.080.12MSETo assess the ﬁt of the two linear models for the EMG parameters α and σ, we use again
the function visualize as follows:

R> visualize(fitEMG, type = "model", modelfit = TRUE,

parameters = c("sigma", "alpha"),
cex.lab = 1.5, cex.axis = 1.25)

R>

7

lllllllllllllllllllllllllllllllll941.3941.4941.5941.6941.7941.8941.901000200030004000xyWhile the ﬁt for σ seems to be reasonable except for some extreme outliers, the ﬁt for α
is not fully convincing. Nevertheless, in the absence of further knowledge, the ﬁt produces
good results in the template matching step detailed in the next section.

2.3 Template ﬁtting

Once all necessary parameters have been determined, the positions at which the templates
In general, one has to choose positions from the interval
are placed have to be ﬁxed.
[x1, xn]. We instead restrict us to a suitable subset of the ﬁnite set {xi}n
i=1. The deviations
from the true positions is then at least in the order of the sampling rate, but this can
be improved by means of a postprocessing step described in 2.4. Using the whole set
{xi}n
i=1 may be computationally infeasible if n is large. Such an approach would be at
least computationally wasteful, since ’genuine’ peaks patterns occur very sparsely in the
spectrum. Therefore, we apply a pre-selection step on the basis of what we term ’local noise
level’ (LNL). The LNL is deﬁned as a quantile (typically the median) of the intensities yi
falling into a sliding window of ﬁxed width around a speciﬁc position. Given the LNL,
we place templates on an xi (one for each charge state) if and only if the corresponding
yi exceeds the LNL at xi by a factor factor.place, which typically equals three or four
and has to be speciﬁed by the user. Given the positions of the templates, we compute the
matrix Φ according to Eqs. (1) and (3). It then remains to estimate the coeﬃcient vector
β∗ on the basis of two structural assumptions, sparsity and nonnegativity of all quantities
involved. Related approaches in the literature (Du and Angeletti [2006], Renard et al.
[2008]) account for sparsity of β∗ by using (cid:96)1-regularized regression (Tibshirani [1996]).
We here argue empirically that (cid:96)1 regularization is not the best to do, since it entails the

8

lllllllllllllllllllllllllllllllllllllllllllllllllllllll800140020000.000.020.040.06m/za(mz)lllllllllllllllllllllllllllllllllllllllllllllllllllllll800140020000.0250.0300.0350.040m/zs(mz)selection of a tuning parameter which is diﬃcult to choose in our setting, and secondly the
structural constraints concerning nonnegativity turn out to be so strong that sparsity is
more conveniently achieved by ﬁtting followed by hard thresholding. We ﬁrst determine

(cid:98)β ∈ argmin

β

(cid:107)y − Φβ(cid:107)q

q , q = 1 or q = 2,

subject to β ≥ 0.

(8)

The optimization problem (8) is a quadratic (q = 2) or linear (q = 1) program and is solved
using standard techniques (Boyd and Vandenberghe [2004]); we omit further details here.
We remark that in the presence of high noise, it is helpful to subtract the LNL from y.
Concerning the choice of q, we point out that q = 1 can cope better with deviations from
model assumptions, i.e. deviations from the averagine model or from the peak model and
thus may lead to a reduction of the number of false positives.

2.4 Postprocessing

Given an estimate (cid:98)β, we deﬁne Mc = {mc,j : (cid:98)βc,j > 0} ⊂ {xi}n
i=1, c = 1, . . . , C, as the
set of all template locations where the corresponding coeﬃcient exceeds 0, separately for
each charge. Due to a limited sampling rate, diﬀerent sources of noise and model misﬁt,
the locations in the sets {Mc}C
c=1 may still deviate considerably from the set of true peak
pattern locations. Speciﬁcally, the sets {Mc}C
c=1 tend to be too large, mainly caused by
what we term ’peak splitting’: for the reasons just mentioned, it frequently occurs that
several templates are used to ﬁt the same peak. This can at least partially be corrected by
means of the following merging procedure.

1. Separately for each c, divide the sets Mc into groups Gc,1, . . . , Gc,Gc of ’adjacent’
positions. Positions are said to be adjacent if their distance on the m/z scale is
below a certain tolerance as speciﬁed via a parts per million (ppm) value.

2. For each c = 1, . . . , C and each group gc = 1, . . . , Gc, we solve the following optimiza-

tion problem.

( (cid:101)mc,g, (cid:101)βc,g) = min
mc,g,βc,g

(cid:13)
(cid:13)
(cid:13)
(cid:13)
(cid:13)
(cid:13)

mc,j ∈Gc,g

(cid:88)

(cid:98)βc,jψmc,j − βc,gψmc,g

(cid:13)
2
(cid:13)
(cid:13)
(cid:13)
(cid:13)
(cid:13)

L2

(9)

In plain words, we take the ﬁtted function resulting from the functions {ψmc,j } rep-
resenting the most intense peak of each peak pattern in the same group and then
(cid:101)mc,g placed at location (cid:101)mc,g and weighted by (cid:101)βc,g such that
determine a function ψ
(cid:101)βc,gψ
(cid:101)mc,g approximates the ﬁt of multiple functions {ψmc,j } best (in a least squares
sense).

3. One ends up with sets (cid:102)Mc = { (cid:101)mc,g}Gc

g=1 and coeﬃcients { (cid:101)βc,g}Gc

g=1, c = 1, . . . , C.

The additional beneﬁt of step 2. as compared to the selection of the function with the
largest coeﬃcient as proposed in Renard et al. [2008] is that, in the optimal case, we are
able to determine the peak pattern location even more accurate as predetermined by a lim-
ited sampling rate. The integral in (9) can be solved analytically for a Gaussian function,
and we resort to numeric approximations for the EMG function.
The sets {Mc} tend to be too large in the sense that they still contain noise peak patterns.

9

Therefore, we apply hard thresholding to the { (cid:101)βc,g}Gc
g=1, c = 1, . . . , C, discarding all posi-
tions where the corresponding coeﬃcients is less than a signiﬁcance level times the LNL,
where the signﬁcance level has to be speciﬁed by the user.

3 Case study

We continue the data analysis starting in Section 2.2. The methodology of the Sections 2.3
and 2.4 is implemented in the function getPeaklist. For the computation of the template
functions, we recycle the object fitEMG obtained in Section 2.2.

R> EMGlist <- getPeaklist(mz = x, intensities = y, model = "EMG",

model.parameters = fitEMG,
loss = "L2", trace = FALSE,
control.localnoise = list(factor.place = 2),
control.basis = list(charges = c(1, 2)),
control.postprocessing = list(ppm = 200))

R> show(EMGlist)

’

’

peaklist

(with postprocessing)

An object of class
Loss function used: L2
Peak model used: EMG
number of peaks: 1222
charge states used: 1,2

R>

The argument list can be summarized as follows: we compute EMG templates for charges
1 and 2; templates are placed on all m/z-positions in the spectrum where the intensity is at
least two times the LNL; the ﬁt is least squares (loss = L2); postprocessing is performed
by merging peaks within a tolerance of 200 ppm. Subsequently, only the patterns with
signal-to-noise ratio bigger than three are maintained. The result is of the following form.

R> threshold(EMGlist, threshold = 3, refit = TRUE, trace = FALSE)

ratio
loc_init loc_most_intense charge
5.342441
1
4.969646
1
6.217552
1
4.887852
1
6.568443
1
7.949552
1
5.768424
1
3.651298
1
5.643985
1
5.174355
1
7.312978
1
1
3.602532
1 6892.94440 4066.651292 12.549000 324.061781

amplitude localnoise
50.281829
9.411770
50.671012 10.196100
9.411770
58.518172
40.891818
8.366010
87.579020 13.333300
8.888890
70.662696
8.104580
46.750652
9.411770
34.365178
7.581700
42.791001
8.366010
43.288706
8.888890
65.004254
9.934640
35.789856

quant
79.45389
80.37673
93.78790
65.96983
142.84891
115.99279
77.96504
57.32357
71.88843
72.76197
109.42451
60.26112

800.4642
808.2414
829.2292
842.4935
864.4065
877.0373
908.4247
908.9339
923.4380
924.4543
927.4746
927.9689
941.4672

[1,] 800.4642
[2,] 808.2414
[3,] 829.2292
[4,] 842.4935
[5,] 864.4065
[6,] 877.0373
[7,] 908.4247
[8,] 908.9339
[9,] 923.4380
[10,] 924.4543
[11,] 927.4746
[12,] 927.9689
[13,] 941.4672

10

[14,] 941.6761
[15,] 942.4249
[16,] 949.4364
[17,] 952.5318
[18,] 954.4819
[19,] 963.4553
[20,] 967.4826
[21,] 969.4694
[22,] 985.4424
[23,] 991.5025
[24,] 992.0244
[25,] 999.4665
[26,] 1023.4509
[27,] 1057.4478
[28,] 1086.5573
[29,] 1125.5187
[30,] 1151.4789
[31,] 1168.6235
[32,] 1192.7011
[33,] 1271.6609
[34,] 1297.6800
[35,] 1360.7611
[36,] 1361.7379
[37,] 1378.8379
[38,] 1394.8413
[39,] 1474.6387
[40,] 1484.6606
[41,] 1500.6588
[42,] 1501.6659
[43,] 1502.6668
[44,] 1506.9383
[45,] 1518.6637
[46,] 1519.6113
[47,] 1524.6527
[48,] 1534.6603
[49,] 1546.6550
[50,] 1588.8538
[51,] 1589.8317
[52,] 1606.8601
[53,] 1622.8482
[54,] 1628.8462
[55,] 1632.8754
[56,] 1643.8448
[57,] 1650.8348
[58,] 1660.8520
[59,] 1661.8523
[60,] 1675.8106
[61,] 1683.8293
[62,] 1687.8674
[63,] 1712.6676

941.6761
942.4249
949.4364
952.5318
954.4819
963.4553
967.4826
969.4694
985.4424
991.5025
992.0244
999.4665
1023.4509
1057.4478
1086.5573
1125.5187
1151.4789
1168.6235
1192.7011
1271.6609
1297.6800
1360.7611
1361.7379
1378.8379
1394.8413
1474.6387
1484.6606
1500.6588
1501.6659
1502.6668
1506.9383
1518.6637
1519.6113
1524.6527
1534.6603
1546.6550
1588.8538
1589.8317
1606.8601
1622.8482
1628.8462
1632.8754
1643.8448
1650.8348
1660.8520
1661.8523
1675.8106
1683.8293
1687.8674
1712.6676

11

7.581700

143.24711

68.802829

42.204271
44.665674
62.306880
86.918604
84.650178

136.02533
272.44888
71.82305
76.12937
106.30197
148.96394
145.36799
262.70495
125.58555
143.73336
126.08040
153.66239
72.98976
61.60009
163.03327
82.20092
97.87418
88.01377
73.30719

72.468390
7.320260
9.411770
82.684219
72.510535 10.196100
88.037291
41.206802
34.042067
88.434884
43.611929
51.214203
45.630787
37.510877

5.902260
80.240040 13.594800
1
9.601384
160.650358 16.732000
1
5.765406
7.320260
1
5.694871
7.843140
1
8.104580
7.687860
1
6.535950 13.298542
1
8.104580 10.444733
1
152.821229 10.457500 14.613553
1
9.899702
1
8.785193
1
7.111595
1
7.320260 12.026525
1
6.304639
6.535950
1
7.320260
4.650390
1
6.013070 14.707110
1
6.415982
6.797390
1
8.904294
5.751630
1
7.272406
6.274510
1
1
5.739162
6.535950
1 3373.99415 1646.830819 10.457500 157.478443
9.074855
1
1 3817.19024 1720.274080 13.071900 131.600921
1 1393.40685
627.304821 20.653600 30.372662
1 2998.58307 1325.589300 15.686300 84.506181
6.334589
1
1
6.418622
227.682827 11.764700 19.353050
1
5.101342
1
1
4.801339
1 6512.56220 2644.229262 27.973900 94.524870
1 1362.38924
551.970349 18.039200 30.598383
1 3192.43549 1285.329891 14.902000 86.252174
4.376488
1
6.075241
1
8.815704
1
7.032249
1
6.527180
1
1
5.543280
1 47659.91284 18289.702134 27.451000 666.267245
8.104580 13.244782
1
9.531868
7.843140
1
1
9.041984
9.673200
110.772870 10.980400 10.088236
1
8.700436
1
1
8.330109
1 7081.99299 2625.671094 20.392200 128.758599
7.294820
1
6.443252
1
6.660319
1
6.657610
1

67.506458 15.424800
9.411770
57.178770
108.323839 12.287600
71.701513 10.196100
80.203379 12.287600
79.707376 14.379100

282.49197
197.47847
231.62212
295.36538
219.30843
346.30112

167.74746
142.45911
271.31959
180.74626
206.84694
205.68651

133.39966
154.37366
554.64563
187.02460
237.91115

9.411770
128.490258 15.424800

76.020197 14.902000
96.654308 20.130700

51.492824
42.112772
50.496544
41.773239

140.11613
115.18493
138.47730
116.18272

7.058820
6.535950
7.581700
6.274510

107.343397
74.759773
87.464920

57.963577
63.766703

9.150330
9.934640

81.886503

[64,] 1717.8060
[65,] 1718.8742
[66,] 1753.7102
[67,] 1777.8665
[68,] 1798.8819
[69,] 1815.9052
[70,] 1831.9004
[71,] 1837.8935
[72,] 1847.8954
[73,] 1852.9575
[74,] 1853.9657
[75,] 1869.9595
[76,] 1885.0257
[77,] 1885.9545
[78,] 1897.9419
[79,] 1901.0127
[80,] 1919.0078
[81,] 1937.0230
[82,] 1953.0164
[83,] 1958.9972
[84,] 1963.0361
[85,] 1969.9485
[86,] 1981.0615
[87,] 1982.0622
[88,] 1994.0448
[89,] 1995.0238
[90,] 1998.0483
[91,] 2004.0431
[92,] 2008.0804
[93,] 2039.0826
[94,] 2052.9999
[95,] 2092.1287
[96,] 2098.0541
[97,] 2105.0082
[98,] 2109.1722
[99,] 2110.1592
[100,] 2126.1453
[101,] 2132.1398
[102,] 2136.1764
[103,] 2154.1284
[104,] 2157.9980
[105,] 2166.1065
[106,] 2172.1089
[107,] 2188.0666
[108,] 2211.1144
[109,] 2226.1425
[110,] 2233.0991
[111,] 2257.0072
[112,] 2283.2155
[113,] 2284.1745

1717.8060
1718.8742
1753.7102
1777.8665
1798.8819
1815.9052
1831.9004
1837.8935
1848.9034
1853.9655
1854.9737
1870.9675
1886.0337
1886.9625
1898.9499
1902.0207
1920.0158
1938.0310
1954.0244
1960.0052
1964.0441
1970.9565
1982.0695
1983.0702
1995.0528
1996.0318
1999.0563
2005.0511
2009.0884
2040.0906
2054.0079
2093.1367
2099.0621
2106.0162
2110.1802
2111.1672
2127.1533
2133.1478
2137.1844
2155.1364
2159.0060
2167.1145
2173.1169
2189.0746
2212.1224
2227.1505
2234.1071
2258.0152
2284.2235
2285.1825

12

54.759202 10.980400

81.788588 13.594800

111.106409
124.420732
125.769264

38.969904
49.010187
73.321530
100.565706

6.274510
6.535950
5.490200
6.013070
7.581700

36.153297
28.084804
31.479802
36.931121
60.387426

100.80201
78.34668
89.35262
106.10370
175.36393

116.41446
146.46839
219.18520
300.77264
244.80593

5.761932
1
4.296973
1
5.733817
1
6.141808
1
1
7.964893
1 9222.23376 3149.090677 24.052300 130.926800
5.751630 19.317378
1
327.93247
6.274510 19.829554
1
368.32791
6.274510 20.044476
1
373.94066
4.986995
162.82771
1
956.199297 12.549000 76.197251
1 2843.33423
6.013070 23.939442
143.949541
1
428.17483
9.150330 78.367738
717.090660
1 2133.58704
5.475894
9.673200
52.969416
157.60489
1
5.578186
4.444440
24.791914
73.78245
1
6.311151
4.705880
29.699519
88.40198
1
8.192489
6.013070
49.262012
146.81338
1
1 10570.00554 3542.208390 27.712400 127.820340
3.660130 10.647137
1
3.921570 12.497593
1
6.013070 12.193693
1
4.444440 22.627306
1
1
6.016167
1 5026.37446 1679.171934 15.686300 107.047037
3.921570 11.220583
1
7.303013
3.660130
1
8.536571
3.398690
1
6.971296
3.660130
1
3.660130 12.332836
1
6.504666
2.875820
1
9.718631
2.352940
1
7.359818
3.660130
1
3.137260
1
8.099884
3.398690 16.801440
1
6.911806
1
1 5284.54566 1749.046494 14.117600 123.891206
2.352940 11.205485
1
8.419757
2.352940
1
9.278630
2.614380
1
6.520374
2.091500
1
1.830070
1
7.505682
2.352940 10.350173
1
6.003700
1.830070
1
1.633987
1
7.429897
2.091500 10.719924
1
1.633987 20.458655
1
1.633987
1
6.762378
1.633987 14.603469
1
2.091500 28.323550
1
3.733739
2.091500
1

44.002302
26.729978
29.013159
25.515850
45.139784
18.706247
22.867355
26.937889
25.411441
57.102886
81.315327 11.764700

26.365834
19.811183
24.257865
13.637363
13.735924
24.353337
10.987191
12.140359
22.420721
33.429187
11.049641
23.861885
59.238704
7.809115

79.78905
59.98968
73.48454
41.38739
41.70303
73.99919
33.40553
36.97220
68.46039
102.26718
33.83283
73.28383
182.53729
24.06579

131.82282
80.08364
86.94219
76.49392
135.36306
56.21698
68.78940
81.25674
76.68433
172.43705
245.65930

[114,] 2427.2620

2428.2700

1

50.99018

16.211010

1.633987

9.921134

R>

The results can be examined in detail graphically. We ﬁnally present some selected regions
to demonstrate that our method performs well. The pre-deﬁned method visualize can be
used display the template ﬁtting at several stages for regions within selected m/z intervals
as speciﬁed by the arguments lower and upper.

R> visualize(EMGlist, x, y, lower= 963, upper = 973,

fit = FALSE, fittedfunction = TRUE, fittedfunction.cut = TRUE,
localnoise = TRUE, quantile = 0.5,
cutoff.functions = 3)

R>

R> visualize(EMGlist, x, y, lower= 1502, upper = 1510,

fit = FALSE, fittedfunction = TRUE, fittedfunction.cut = TRUE,
localnoise = TRUE, quantile = 0.5,
cutoff.functions = 2)

R>
R>

13

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll9649669689709720100200signalx[ff]intensities[ff]9649669689709720100200postprocessedx[ff]amplpro[i] * basispro$Phi[, colindex]In the m/z range [963, 973] a charge-1 peak overlaps with a more intense charge two peak.
A further overlap occurs in the interval [1502, 1510], and it is correctly resolved.
An even more challenging problem, in which it is already diﬃcult to unravel the overlap
by visual inspection, is displayed in the following plot.

R> visualize(EMGlist, x, y, lower= 1360, upper = 1364,

fit = FALSE, fittedfunction = TRUE, fittedfunction.cut = TRUE,
localnoise = TRUE, quantile = 0.5,
cutoff.functions = 2)

R>

14

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll15021504150615081510015003000signalx[ff]intensities[ff]15021504150615081510015003000postprocessedx[ff]amplpro[i] * basispro$Phi[, colindex]4 Extension to process LC-MS runs

In the preceding sections, it has been demonstrated how IPPD can be used to process single
spectrums. For LC-MS, multiple spectra, one for a sequence of retention times {tl}L
l=1, have
to be processed. In this context, a single spectrum is referred to as scan. The resulting data
can be displayed as in Figure 2 by plotting intensities over the plane deﬁned by retention
times and m/z-values. IPPD oﬀers basic functionality to process this kind of data. Support
for mzXML format as well as an implementation of the sweep line scheme as suggested in
Schulz-Trieglaﬀ et al. [2008] is provided, which is brieﬂy demonstrated in the sequel.

R> directory <- system.file("data", package = "IPPD")
R> download.file("http://www.ml.uni-saarland.de/code/IPPD/CytoC_1860-2200_500-600.mzXML",

destfile = paste(directory, "/samplefile", sep = ""),
quiet = TRUE)

R> data <- read.mzXML(paste(directory, "/samplefile", sep = ""))
R>

The sweep line scheme aggregates the peaklists of multiple scans by looking for blocks of
consecutive retention times at which there is signal at nearby m/z-positions. The output
is a quadruple consisting of a retention time interval, a m/z-position, a charge state and

15

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1360136113621363136401000signalx[ff]intensities[ff]1360136113621363136401000postprocessedx[ff]amplpro[i] * basispro$Phi[, colindex]Figure 2: Graphical display of the sample mzXML ﬁle used in the code.

a quantiﬁcation of the intensity. The intervals are found by sequentially processing the
results of getPeaklist, where the results of each peaklist will lead to extensions of existing
interval of preceding lists or to the creation of new intervals; intervals are closed once they
have not been extended after processing more than gap additional peaklists, where gap
is a parameter to be speciﬁed by the user. For more details, we refer to Schulz-Trieglaﬀ
et al. [2008]. The function analyzeLCMS runs getPeaklist for each scan and then calls
the function sweepline, which can as well be run independently from analyzeLCMS to
aggregate the results. While there is a default setting, parameters can be changed by
passing appropriate arguments.

R> processLCMS <- analyzeLCMS(data,

arglist.getPeaklist = list(control.basis = list(charges = c(1,2,3))),
arglist.threshold = list(threshold = 10),
arglist.sweepline = list(minboxlength = 20))

R> boxes <- processLCMS$boxes

The output can be displayed as follows. The retention time intervals are given by the two
columns rt_begin and rt_end, the corresponding m/z-positions are given by the column
loc. Quantitive information is contained in the column quant. The output is visualized by
means of a contour plot, where the contour lines depict intensities over the plane deﬁned
by m/z-positions and retention times. The intervals of the output are drawn as red lines.

R> print(boxes)

[1,] 503.3474
[2,] 505.8353
[3,] 520.3157
[4,] 521.6749

loc charge
1
4804929 2093.26 2113.46
2 58628590 2067.62 2097.79
1
4060317 2097.79 2118.62
3 174362565 1929.97 1971.22

quant rt_begin rt_end npeaks gapcount
6
13
11
6

26
34
22
57

16

[5,] 534.3278
[6,] 535.3383
[7,] 546.8268
[8,] 549.3673
[9,] 584.8515
[10,] 585.3650
[11,] 585.3691
[12,] 597.3784

2 82024006 2068.95 2099.10
1 242848614 2099.10 2150.15
2 43092586 2112.83 2137.57
1 10241899 1882.23 1925.06
2 358822314 2090.02 2155.51
2 17016750 2132.31 2155.51
2 13830263 2175.63 2193.95
2 10873799 1882.96 1906.53

35
70
37
56
91
31
25
35

12
9
2
8
10
5
3
1

R> rtlist <- lapply(data$scan, function(x)

as.numeric(sub("([^0-9]*)([0-9|.]+)([^0-9]*)", "\\2", x$scanAttr)))

R> rt <- unlist(rtlist)
R> nscans <- length(rt)
R> npoints <- length(data$scan[[1]]$mass)
R> Y <- matrix(unlist(lapply(data$scan, function(x) x$peaks)),

nrow = nscans,
ncol = npoints,
byrow = TRUE)

R> contour(rt, data$scan[[1]]$mass, Y, xlab = "t", ylab = "mz",

levels = 10^(seq(from = 5, to = 6.75, by = 0.25)),
drawlabels = FALSE)

R> for(i in 1:nrow(boxes))

lines(c(boxes[i,"rt_begin"], boxes[i,"rt_end"]), rep(boxes[i,"loc"], 2), col = "red")

R>
R>

17

References

S. Boyd and L. Vandenberghe. Convex Optimization. Cambridge University Press, 2004.

P. Du and R. Angeletti. Automatic Deconvolution of Isotope Resolved Mass Spectra Using
Variable Selection and Quantized Peptide Mass Distribution. Analytical Chemistry, 78:
3385–3392, 2006.

E. Grushka. Characterization of Exponentially Modiﬁed Gaussian Peaks in Chromatogra-

phy. Analytical Chemistry, 44:1733–1738, 1972.

V. Marco and G. Bombi. Mathematical functions for the representation of chromatographic

peaks. Journal of Chromatography A, 931:1–30, 2001.

B. Renard, M. Kirchner, H. Steen, J. Steen, and F. Hamprecht. NITPICK: peak identiﬁ-

cation for mass spectrometry data. BMC Bioinformatics, 9:355, 2008.

O. Schulz-Trieglaﬀ, R. Hussong, C. Gr¨opl, A. Hildebrandt, and K. Reinert. A Fast and
Accurate Algorithm for the Quantiﬁcation of Peptides from Mass Spectrometry Data.
In Proceedings of the Eleventh Annual International Conference on Research in Compu-
tational Molecular Biology (RECOMB 2007), pages 437–487, 2007.

O. Schulz-Trieglaﬀ, R. Hussong, C. Gr¨opl, A. Leinenbach, A. Hildebrandt, C. Huber, and
K. Reinert. Computational quantiﬁcation of peptides from LC-MS data. Journal of
Computational Biology, 15:685–704, 2008.

18

tmz18501900195020002050210021502200500520540560580600M. Senko, S. Beu, and F. McLaﬀerty. Determination of Monoisotopic Masses and Ion
Populations for Large Biomolecules from Resolved Isotopic Distributions. Journal of the
American Society for Mass Spectrometry, 6:229–233, 1995.

R. Tibshirani. Regression shrinkage and variable selection via the lasso. Journal of the

Royal Statistical Society Series B, 58:671–686, 1996.

19

