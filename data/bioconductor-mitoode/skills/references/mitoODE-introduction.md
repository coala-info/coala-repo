mitoODE: Dynamical modelling of phenotypes in a genome-wide
RNAi live-cell imaging assay

Gregoire Pau
pau.gregoire@gene.com

January 4, 2019

Contents

1 Introduction

2 Methods

2.1 Ordinary diﬀerential equation model
2.2 Estimation of model parameters

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Modelling time course cell count data

4 Reproducing ﬁgures

5 References

1 Introduction

1

2
2
2

2

4

5

The Mitocheck assay is a genome-wide time-lapse imaging screen that employed small-interfering RNAs
(siRNAs) to test the implication of human genes in transient biological processes such as cell division or
migration [2]. siRNAs are double-stranded RNA molecules, implicated in the RNA interference pathway, that
are used to disrupt the expression of speciﬁc genes. The screen consisted of 206592 time-lapse experiments,
using 51766 diﬀerent siRNA constructs and targeting 17293 human genes. Experiments were organised in
slides, each containing 384 siRNA spots. Each slide contained 7 to 8 negative and 8 to 11 positive control
spots. The control siRNAs were: siScrambled, a non-targeting negative control; siKIF11, targeting the gene
KIF11, which encodes a kinesin needed for centrosome segregation; siCOPB1, targeting an essential protein
binding to the Golgi vesicle and siINCENP, targeting a centromere-associated protein coding gene required
for proper chromosome segregation and cytokinesis. To allow the chromosomes to be imaged by ﬂuorescence
microscopy, a cervix carcinoma HeLa cell line stably expressing GFP-tagged H2B histone was used. Cells
were ﬁlmed starting 18 h after seeding for a duration of 48 h, with an imaging rate of one per 30 min. After
acquisition, cell nuclei were segmented, quantiﬁed and classiﬁed into one of 16 morphological classes by a
fully automated algorithm.

The mitoODE package implements a population-level dynamic model to represent the temporal evolution
of dividing cells [1]. By ﬁtting cell counts in four transient cellular states, our model yielded parameters that
quantify the dynamic eﬀects of siRNA treatments on cell population levels. Model parameters allows reliable
estimation of the penetrance and time of four disruption events of the cell cycle: quiescence, mitosis arrest,
polynucleation and cell death. The package includes the code to ﬁt any time course data to the model and
the scripts used to generate the ﬁgures and results presented in the paper.

The mitoODEdata package, the experimental companion package of mitoODE, contains the screen data
and methods to access the Mitocheck assay layout, siRNA annotation, time-lapse cell counts and the ﬁtted
phenotypes for each spot. Four cell types are considered:
interphase (referred in the Mitocheck paper as:
Interphase, Large, Elongated, Folded, Hole, SmallIrregular or UndeﬁnedCondensed), mitotic (Metaphase,
Anaphase, MetaphaseAlignment, Prometaphase or ADCCM), polynucleated (Shape1, Shape3, Grape) and
apoptotic (Apoptosis).

1

2 Methods

2.1 Ordinary diﬀerential equation model

We consider four cellular states: interphase (I), mitotic (M ), polynucleated (P ) and dead (D). We modelled
the number of cells np(t) of state p, at time t with the system S of diﬀerential equations, depicted in Fig. 1:

with:

˙nI(t) = −(cid:0)kIM(t) + kD(t)(cid:1)nI(t) + 2kMI(t)nM(t)
˙nM(t) = kIM(t)nI(t) − (cid:0)kMI(t) + kD(t) + kMP(t)(cid:1)nM(t)
˙nP(t) = kMP(t)nM(t) − kD(t)nP(t)
˙nD(t) = kD(t)nI(t) + kD(t)nM(t) + kD(t)nP(t),

IM − αIM/(cid:0)1 + exp(τIM − t)(cid:1)
MI − αMI/(cid:0)1 + exp(τMI − t)(cid:1)

kIM(t) = α0
kMI(t) = α0
kMP(t) = αMP/(cid:0)1 + exp(τMP − t)(cid:1)
kD(t) = αD/(cid:0)1 + exp(τD − t)(cid:1)

where ˙np(t) is the time derivative of np(t), with the initial conditions nI(0) = (1 − ω0)n0, nM(0) =
ω0n0, nP(0) = nD(0) = 0, and n0 is the number of cells at seeding time t = 0. In agreement with observa-
tions of untreated cells, the mitotic index at seeding time is set to ω0 = 0.05, the basal interphase-to-mitosis
transition rate to α0
MI = 0.57 h−1. To
IM = 0.025 h−1 and the basal mitosis-to-interphase transition rate α0
account for contamination of spots by normal cells, due to untransfected cells moving into the spot region, we
assumed that cell counts are a mixture of two independent, growing cell populations: a treated population,
modelled by S with parameters {(1 − µ)n0, αIM, αMI, αMP, αD, τIM, τMI, τMP, τD} and an untreated pop-
ulation, modelled by S with parameters {µn0, 0, 0, 0, 0, 0, 0, 0, 0}. In total, 10 parameters are required to
model a cell count time course: the initial cell number at seeding time n0, the normal contamination fraction
parameter µ and 8 transition parameters {αIM, αMI, αMP, αD, τIM, τMI, τMP, τD}.

2.2 Estimation of model parameters

Model parameters θ = {n0, µ, αIM, αMI, αMP, αD, τIM, τMI, τMP, τD} are estimated by penalised least
squares regression of time-course cell count data, minimising the cost function:

J(θ) =

1
#T

(cid:88)

(cid:88)

t∈T

p∈P

(cid:0)yp(t) − np(t, θ)(cid:1)2

+ λ

(cid:88)

k∈K

α2
k,

(1)

where T is the set of observed time points, yp(t) the observed number of cells of state p at time t, λ a constant
to weigh the penalty term and the set of penalised parameters K = {µ, αIM, αMI, αMP, αD}. Given the
parameters, the ODE system is integrated using the Runge-Kutta fourth-order method. Minimisation of
the penalised criterion J was achieved with the Levenberg-Marquardt algorithm, with the nls.lm pacakge,
applying a positivity constraint to the components of θ.

3 Modelling time course cell count data

The mitoODE package depends on the mitoODEdata experiment data package, containing 206592 time-course
cell counts from the Mitocheck time-lapse genome wide siRNA screen. The following example plots the time-
course cell counts of a given spot and loads them in the matrix y. The matrix contains the number of cells
of a given type (interphase i, mitotic m, polynucleated s and apoptotic a) per image. The ﬁrst image was
acquired 18 h after siRNA transfection and the following images were acquired every 30 minutes during 48 h.

> library("mitoODE")
> spotid <- 1000
> plotspot(spotid)
> y <- readspot(spotid)
> y[1:5,]

2

Figure 1: A diﬀerential equation model to quantify temporal phenotypes. Cell populations could enter and
leave states with four diﬀerent transition rates: kIM, kMI, kMP and kD.

i m s a
[1,] 65 3 1 0
[2,] 63 4 2 1
[3,] 65 5 1 1
[4,] 70 3 0 0
[5,] 71 1 0 2

To ﬁt the time-course cell counts, we ﬁrst need to set the constant parameters of the model. This is a
MI = 0.57 h−1), g.mit0

named vector with the elements: g.kim (in our model, α0
(the mitotic index at seeding time, ω0 = 0.05), and p.lambda (the regularization parameter, λ = 4).

IM = 0.025 h−1), g.kmi (α0

> pconst <- c(g.kim=0.025, g.kmi=0.57, g.mit0=0.05, p.lambda=4)

The function getp0 generates an initial condition vector of 10 parameters: him (in our model, αIM), hmi

(αMI), hmp (αMP), ha (αD), tim (τIM), tmi (τMI), tmp (τMP), ta (τD), mu (µ) and i0 (n0).

> p0 <- getp0()
> p0

him hmi hmp ha tim tmi tmp ta mu i0
0 40

0 42 42 42 42

0

0

0

The function fitmodel ﬁts the time-course cell counts to the model, using the initial condition param-
eters p0 and the constant parameters pconst. Results are the ﬁtted parameters and some ﬁtting statistics,
including: score (the cost function J), rss (the residual sum of squares) and pen (the penalty term).

3

InterphaseMitoticDeadPolynucleatedkIMkDkMPkDkDkMI> pp1 <- fitmodel(y, p0, pconst)
> round(pp1, 2)

him

pen
-0.03 0.00 0.02 0.01 33.34 61.29 18.44 54.74 0.00 42.96 16.48 16.27 0.22

i0 score

tim

tmi

tmp

rss

hmi

hmp

ha

ta

mu

imax mmax smax amax
94.42 3.28 1.23 5.43

The function plotfit displays the ﬁtted data.

> plotfit(spotid, pp1)

Figure 2: Time course cell counts (left) and ﬁtted data (dotted lines, right) of the Mitocheck spot ID 1000.

The model is sensitive to initial conditions. To decrease the risk of ﬁnding local minima, the data be ﬁtted
several times using the argument nfits, adding to the initial conditions some Gaussian noise of standard
devision sd. The following example uses 4 ﬁts to ﬁnd a better ﬁt (i.e. with a lower score) than pp1.

> set.seed(1)
> pp2 <- fitmodel(y, p0, pconst, nfits=4, sd=0.1)
> round(pp2, 2)

him

pen
-0.03 -0.57 0.03 0.00 35.27 37.48 33.09 52.68 0.00 42.36 12.96 10.45 2.52

i0 score

hmp

tim

tmi

tmp

rss

hmi

ha

ta

mu

imax mmax smax amax
96.16 3.92 2.58 3.31

4 Reproducing ﬁgures

The following functions reproduce the plots shown in the paper [1]. See the paper for details.

> loadFittedData()
> figure1()
> figure2()
> figure3a()
> figure3b()
> figure4()

4

2030405060020406080100Time after cell seeding (h)Number of cellsinterphasemitoticpolynucleateddead2030405060020406080100Time after cell seeding (h)Number of cellsinterphasemitoticpolynucleateddeadFigure 3: Time course of cell counts in four diﬀerent siRNA spots. The negative control siRNA siScrambled
led to normal cell growth in two replicated spots (top). siKIF11 led to an early accumulation of mitotic
cells, while at later times many of the arrested cells went into cell death (bottom-left). siCOPB1, which
targets an essential Golgi-binding protein, caused cell death, but no mitotic phenotypes (bottom-right).
Y-axis scales were changed to accommodate the diﬀerent dynamics of the phenotypes.

5 References

References

[1] Pau G, Walter T, Neumann B, Heriche JK, Ellenberg J, and Huber W (2013) Dynamical modelling of

phenotypes in a genome-wide RNAi live-cell imaging assay. (submitted)

[2] Neumann B, Walter T, Heriche JK, Bulkescher J, Erﬂe H, et al. (2010) Phenotypic proﬁling of the human

genome by time-lapse microscopy reveals cell division genes. Nature 464: 721–727.

5

2030405060050100150200Number of cellsinterphasemitoticpolynucleateddead2030405060050100150200203040506001020304050Time after cell seeding (h)Number of cells2030405060050100150200Time after cell seeding (h)Figure 4: Transition rates vary over time and are modelled by parametric sigmoid functions. In the negative
control spot (left), the interphase-to-mitosis transition rate kIM inﬂects at τIM = 54.5 h, as the capacity of the
spot to support a growing number of cells becomes limiting. The death transition rate kD remains constant
and null. In the siCOPB1 spot (right), the death transition rate kD inﬂects at τD = 29.4 h, indicating the
time of cell death.

6

20304050600.000.020.0420304050600.000.020.0420304050600.000.020.04Time after seeding (h)20304050600.000.020.04Time after seeding (h)2030405060050100150200Time after cell seeding (h)Number of cellsinterphasemitoticpolynucleateddead2030405060050100150200Time after cell seeding (h)Figure 5: Box plots of cell death penetrance αD estimated in control and sample wells (top). Lethal phe-
notypes induced by siKIF11 and siCOPB1 had signiﬁcantly higher cell death penetrance than the negative
siScrambled control spots. Cell count time courses of two spots containing an siRNA (MCO 0026491) tar-
geting the uncharacterised gene C3orf26 (bottom).
Induction of cell death started at τD = 30.8 h and
33.8 h.

7

siScrambledsiKIF11siINCENPsiCOPB1sample0.51.02.05.010.0Mitosis duration (h)2030405060051015202530Time after cell seeding (h)Number of cells2030405060051015202530Time after cell seeding (h)Figure 6: Box plot of mitosis duration estimated in control and sample wells (top). Prometaphase arrest
caused by siKIF11 led to a signiﬁcantly higher mitosis duration than cells in negative control spots. Cell
count time courses of two spots containing an siRNA (MCO 0020444) targeting the poorly characterised gene
CCDC9 (bottom). The overall high proportion of mitotic cells, compared to the negative controls illustrated
in Fig. 1b, is indicative of a longer mitosis duration, estimated at 5.7 h.

8

siScrambledsiKIF11siINCENPsiCOPB1sample0.0000.0050.0100.0150.020Death penetrance (1/h)2030405060020406080100Time after cell seeding (h)Number of cellsinterphasemitoticpolynucleateddead2030405060020406080100Time after cell seeding (h)Figure 7: Phenotypic map of the Mitocheck screen. Phenotypic proﬁles of all siRNA treatments were de-
rived from ﬁtted parameters and projected on two dimensions using linear discriminant analysis between
the siScrambled, siCOPB1 and siKIF11 control spots. Color contour lines denote the quantiles of control
experiments that fall into the corresponding phenotypic region. The green phenotypic region, centered on
the non-targeting negative control siScrambled, is representative of a normal growth phenotype. The orange
phenotypic region, centered on siKIF11, is representative of prometaphase arrest followed by apoptosis, while
the blue region, centered on siCOPB1, is representative of cell death without mitotic arrest. Shown are the
2190 siRNAs that induced a disruption of the cell cycle, or increased the duration of the interphase or mitosis
phases. A selection of siRNA gene targets are highlighted on the map.

9

−4−2024−2−101234 25%  50%  75%  25%  50%  75%  25%  50%  75% llllllllllllllllllllllllllllllllCOPACOPB2TP53AIP1RANRAB25C3orf26PLK1MAP2K4ANAPC1NEK9NEK10ULK4PALMCENPKCCDC9CABYRCTRLGNASDYDC2GDPD3ROR1BEND7BZW1ITGA3ASB12DDX39ACDKN2ANEK2C3orf52COPB1KIF11scrambledllllsiScrambledsiKIF11siCOPB1sample