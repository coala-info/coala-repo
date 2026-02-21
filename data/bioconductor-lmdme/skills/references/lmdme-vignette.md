lmdme: Linear Models on Designed Multivariate
Experiments in R

Cristóbal Fresno
Universidad Católica de Córdoba

Mónica G Balzarini
Universidad Nacional de Córdoba

Elmer A Fernández
Universidad Católica de Córdoba

Abstract

This introduction to linear model on designed multivariate experiments of the R pack-
age lmdme is a (slightly) modified version of Fresno et al. (2014), published in the Journal
of Statistical Software.

The lmdme package (Fresno and Fernández 2013a) decomposes analysis of variance
(ANOVA) through linear models on designed multivariate experiments, allowing ANOVA-
principal component analysis (APCA) and ANOVA-simultaneous component analysis
It also extends both methods with
(ASCA) in R (R Development Core Team 2012).
the application of partial least squares (PLS) through the specification of a desired out-
put matrix. The package is freely available on the Bioconductor website (Gentleman et al.
2004), licensed under GNU general public license.

ANOVA decomposition methods for designed multivariate experiments are becoming
popular in “omics” experiments (transcriptomics, metabolomics, etc.), where measure-
ments are performed according to a predefined experimental design (Smilde et al. 2005),
with several experimental factors or including subject-specific clinical covariates, such as
those present in current clinical genomic studies. ANOVA-PCA and ASCA are well-suited
methods for studying interaction patterns on multidimensional datasets. However, cur-
rent R implementation of APCA is only available for Spectra data in ChemoSpec package
(Hanson 2012), whereas ASCA (Nueda et al. 2007) is based on average calculations on
the indices of up to three design matrices. Thus, no statistical inference on estimated
effects is provided. Moreover, ASCA is not available in R package format.

Here, we present an R implementation for ANOVA decomposition with PCA/PLS
analysis that allows the user to specify (through a flexible formula interface), almost any
linear model with the associated inference on the estimated effects, as well as to display
functions to explore results both of PCA and PLS. We describe the model, its imple-
mentation and one high-throughput microarray example applied to interaction pattern
analysis.

Keywords: linear model, ANOVA decomposition, PCA, PLS, designed experiments, R.

2

lmdme: Linear Models on Designed Multivariate Experiments in R

1. Introduction

Current “omics” experiments (proteomics, transcriptomics, metabolomics or genomics) are
multivariate in nature. Modern technology allows us to explore the whole genome or a big
subset of the proteome, where each gene/protein is in essence a variable explored to elucidate
its relationship with an outcome. In addition, these experiments are including an increasing
number of experimental factors (time, dose, etc.) from design or subject-specific information,
such as age, gender and linage, and are available for analysis. Hence, to decipher experi-
mental design or subject-specific patterns, some multivariate approaches should be applied,
with principal component analysis (PCA) and partial least squares regression (PLS) being
the most common. However, it is known that working with raw data might mask information
of interest. Therefore, analysis of variance (ANOVA)-based decomposition is becoming pop-
ular to split variability sources before applying such multivariate approaches. Seminal works
on genomics were that of De Haan et al. (2007) on ANOVA-PCA (APCA) and of Smilde
et al. (2005) on ANOVA-SCA (ASCA) models. However, to the best of our knowledge R
implementation of APCA is only available for Spectra data, ChemoSpec R package by Han-
son (2012). Regarding ASCA, as there is no R package for this model, it can only be used
by uploading script-function files resulting from a MATLAB code translation (Nueda et al.
2007). In addition, ASCA only accepts up to three design matrices, which limits its use and
makes it difficult. Moreover, coefficient estimations are based on average calculations using
binary design matrices, without any statistical inference over them.
Here, we provide a flexible linear model-based decomposition framework. Almost any model
can be specified, according to the experimental design, by means of a flexible formula inter-
face. Because coefficient estimation is carried out by means of maximum likelihood, statistical
significance is naturally given. The framework also provides both capacity to perform PCA
and PLS analysis on appropriate ANOVA decomposition results, as well as graphical repre-
sentations. The implementation is well-suited for direct analysis of gene expression matrices
(variables on rows) from high-throughput data such as microarray or RNA-seq experiments.
Below we provide an examples to introduce the user to the package applications, through the
exploration of interaction patterns on a microarray experiment.

2. The model

A detailed explanation of ANOVA decomposition and multivariate analysis can be found in
Smilde et al. (2005) and Zwanenburg et al. (2011). Briefly and without the loss of generality,
let us assume a microarray experiment where the expression of (G1, G2, . . . , Gg) genes are
arrayed in a chip. In this context, let us consider an experimental design with two main factors:
A, with a levels (A1, A2, . . . , Ai, . . . , Aa) and B, with b levels (B1, B2, . . . , Bj, . . . , Bb),
with replicates R1, R2,
, Rr for each A × B combination levels. After pre-
processing steps are performed as described in (Smyth 2004), each chip is represented by a
column vector of gene expression measurements of g × 1. Then, the whole experimental data
is arranged into a g × n expression matrix (X), where n = a × b × r. In this data scheme,
single gene measurements across the different treatment combinations (Ai × Bj) are presented
in a row on the X matrix, as depicted in Figure 1. An equivalent X matrix structure needs
to be obtained for 2D-DIGE or RNA-seq experiments and so forth.

, Rk,

. . .

. . .

Cristóbal Fresno, Mónica G Balzarini, Elmer A Fernández

3

h
c
a
e

r
o
f

s
l
e
v
e
l

n
o
i
s
s
e
r
p
x
e

,
n
e
h
T

.
p
i
h
c

e
h
t

r
×
b
×
a
=
n

f
o

l
a
t
o
t

a

g
n
i
d
l
e
i
y

,
s
p
i
h
c

e
h
t

n
o

n
o

d
e
t
t
o
p
s

e
r
a

s
e
n
e
G

)
A

.
n
o
i
s
s
e
r
p
x
e

e
n
e
g

y
a
r
r
a
o
r
c
i
m

f
o

n
o
i
t
a
t
n
e
s
e
r
p
e
r

a
t
a
D

:
1

e
r
u
g
i
F

d
e
r
u
s
a
e
m
e
b

n
a
c

k
R
s
e
t
a
c
i
l
p
e
r

r
i
e
h
t

d
n
a

j

i

B
A
s
l
e
v
e
l

r
o
t
c
a
f

t
n
e
m
t
a
e
r
t

f
o

n
o
i
t
a
n
i
b
m
o
c

e
s
e
h
t

,
n
e
h
T
)
C

.
s
l
e
v
e
l

n
o
i
s
s
e
r
p
x
e

f
o

r
o
t
c
e
v

n
m
u
l
o
c

a

s
a

d
e
t
e
r
p
r
e
t
n
i

n
e
h
t

s
i

)
y
a
r
r
a
o
r
c
i
m

(

p
i
h
c

h
c
a
e

f
o

n
o
i
s
s
e
r
p
x
e

e
n
e
G

)
B

.
s
y
a
r
r
a
o
r
c
i
m

l
l
a

r
e
d
n
u

s
t
n
e
m
e
r
u
s
a
e
m
n
o
i
s
s
e
r
p
x
E

.

X
x
i
r
t
a
m
n
o
i
s
s
e
r
p
x
e

e
n
e
g

t
n
e
m

i
r
e
p
x
e

e
h
t

g
n
i
c
u
d
o
r
p

s
n
m
u
l
o
c

y
b

d
e
n
i
b
m
o
c

e
b

l
l
i

w
s
r
o
t
c
e
v

n
m
u
l
o
c

A
V
O
N
A
e
h
t

o
t

d
e
t
c
e
j
b
u
s

e
r
a
w
o
r

a

n
o

s
t
n
e
m
e
r
u
s
a
e
m

,
s
u
h
T

.
s
w
o
r

x
i
r
t
a
m
X
e
h
t

y
b

d
e
t
n
e
s
e
r
p
e
r

e
r
a

e
n
e
g

a

r
o
f

s
n
o
i
t
a
n
i
b
m
o
c

t
n
e
m
t
a
e
r
t

.
)
1
(

f
o

l
e
d
o
m

G1GgA1B1AaB1TreatmentsAiBjFactorn=abrLevelGenes…G1GgA1B2AaB2A1BbAaBbA1B1AaBbR1R1RrReplicates…A1B1AaBbRr……Xijk = m + ai+ bj+ aibj+ eijkA)B)C)1nMicroarrays4

lmdme: Linear Models on Designed Multivariate Experiments in R

Regardless of data generation, the ANOVA model for each gene (row) in X can be expressed
as (1):

xijk = µ + αi + βj + αi × βj + εijk
Where xijk is the measured expression for “some” gene, at combination “ij” of factors A and
B for the k replicate; µ is the overall mean; α, β and α × β are the main and interaction
effects respectively; and the error term εijk ∼ N (0, σ2). In addition, (1) can also be expressed
in matrix form for all genes into (2):

(1)

X = Xµ + Xα + Xβ + Xαβ + E = X

Xl + E

(2)

l∈{µ,α,β,αβ}

Where Xl, E matrices are of dimension g ×n and contain the level means of the corresponding
l − th term and the random error respectively. However, in the context of linear models Xl
can also be written as a linear combination of two matrix multiplications in the form of (3):

X = X

Xl + E = X

l∈{µ,α,β,αβ}

l∈{µ,α,β,αβ}

BlZT
l

+ E = BµZT
µ

+ . . . + BαβZT
αβ

+ E =

µ1⊤ + BαZT
α

+ . . . + BαβZT
αβ

+ E (3)

Where Bl and Zl are referenced in the literature as coefficient and model matrices of dimen-
sions g × m(l) and n × m(l), respectively, and m(l) is the number of levels of factor l. The first
term is usually called intercept, with Bµ = µ and Zµ = 1 being of dimension g × 1 and n × 1,
respectively. In this example, all Zl are binary matrices, identifying whether a measurement
belongs (“1”) or not (“0”) to the corresponding factor.
In the implementations provided by Smilde et al. (2005) and Nueda et al. (2007), the estima-
tion of the coefficient matrices is based on calculations of averages using the design matrix (up
to three design matrices Zα,β,αβ), to identify the average samples. In theory, these authors
fully decompose the original matrix as shown in (1). On the contrary, in this package the
model coefficients are estimated, iteratively, by the maximum likelihood approach, using the
lmFit function provided by limma package (Smyth et al. 2011). Consequently, three desirable
features are also incorporated:

1. Flexible formula interface to specify any potential model. The user only needs to
provide: i) The gene expression matrix (X), ii) The experimental data.frame (design)
with treatment structure, and iii) The model in a formula style, just as in an ordinary
lm R function. Internal model.matrix call, will automatically build the appropriate Z
matrices, overcoming the constraint on factorial design size, and tedious model matrix
definitions.

2. Hypothesis tests on coefficient Bl matrices. A T test is automatically carried out for
the s − th gene model, to test whether or not the o − th coefficient is equal to zero, i.e.,
H0 : bso = 0 vs H1 : bso ̸= 0. In addition, an F test is performed to simultaneously
determine whether or not all bso are equal to zero.

3. Empirical Bayes correction can also be achieved through the eBayes limma function. It
uses an empirical Bayes method to shrink the row/gene-wise sample variances towards
a common value and to augment the degrees of freedom for the individual variances
(Smyth 2004).

Cristóbal Fresno, Mónica G Balzarini, Elmer A Fernández

5

By contrast, De Haan et al. (2007) estimate the main and interaction effects by overall mean
subtraction. Hence, genes need to be treated as an additional factor. Meanwhile, in Smilde
et al. (2005) and Nueda et al. (2007) implementations, the estimations are obtained on a gene-
by-gene basis, as in (1). Therefore, in a two-way factor experiment, such as time × oxygen,
De Haan’s model includes two additional double interactions and a triple interaction, because
genes are treated as a factor, unlike the models of Smilde and Nueda.

2.1. The decomposition algorithm

The ANOVA model (2) is decomposed iteratively using (3), where in each step the l − th
coefficients ˆBl, ˆEl matrices and ˆσ2
are estimated. Then, the particular term contribution
matrix ˆXl = ˆBlZ⊤
is subtracted from the preceding residuals to feed the next model, as
depicted in (4):

l

l

X = Xµ + Xα + Xβ + Xαβ + E = X

Xl + E

l∈{µ,α,β,αβ}

step µ : X = Xµ + Eµ ⇒ X = ˆBµZ⊤
step α : Eµ = Xα + Eα ⇒ ˆEµ = ˆBαZ⊤

+ ˆEµ ⇒ ˆEµ = X − ˆBµZ⊤
+ ˆEα ⇒ ˆEα = ˆEµ − ˆBαZ⊤

µ

µ

α

α

...

...

step l : El−1 = Xl + El ⇒ ˆEl−1 = ˆBlZ⊤

+ ˆEl ⇒ ˆEl = ˆEl−1 − ˆBlZ⊤

l

(4)

l

...

...

step αβ : Eβ = Xαβ + E ⇒ ˆEβ = ˆBαβZ⊤

αβ

+ ˆE ⇒ ˆE = ˆEβ − ˆBαβZ⊤

αβ

Where the hat (“∧”) denotes estimated coefficients. In this implementation, the first step
always estimates the intercept term, i.e., formula=∼1 in R style, with ˆBµ = ˆµ and Zµ =
i.e.,
1. The following models will only include the l − th factor without the intercept,
formula=∼lth_term-1, where lth_term stands for α, β or αβ in this example. This proce-
dure is quite similar to the one proposed by Harrington et al. (2005).

2.2. PCA and PLS analyses

These methods explain the variance/covariance structure of a set of observations (e.g., genes)
through a few linear combinations of variables (e.g., experimental conditions). Both methods
can be applied to the l − th ANOVA decomposed step of (4) to deal with different aspects:

• PCA concerns with the variance of a single matrix, usually with the main objectives
of reducing and interpreting data. Accordingly, depending on the matrix to which it
is applied, there are two possible methods: ASCA, when PCA is applied to coefficient
matrix, ˆBl, (Smilde et al. 2005); and APCA when PCA is calculated on the residual,
ˆEl−1. The latter is conceptually an ASCA and is usually applied to, Xl + E, i.e., the
mean factor matrix Xl, plus the error of the fully decomposed model E of (1), as in
De Haan et al. (2007).

• PLS not only generalizes but also combines features from PCA and regression to explore
the covariance structure between input and some output matrices, as described by Abdi
and Williams (2010) and Shawe-Taylor and Cristianini (2004). It is particularly useful

6

lmdme: Linear Models on Designed Multivariate Experiments in R

when one or several dependent variables (outputs - O) must be predicted from a large
and potentially highly correlated set of independent variables (inputs). In our implemen-
tation, the input can be either the coefficient matrix ˆBl or the residual ˆEl−1. According
to the choice, the respective output matrix will be a diagonal O=diag(nrow( ˆBl)) or
design matrix O = Zl. In addition, users can specify their own output matrix, O, to
verify a particular hypothesis. For instance, in functional genomics it could be the Gene
Ontology class matrix as used in gene set enrichment analysis (GSEA) by Subramanian
et al. (2005).

When working with the coefficient matrix, the user will not have to worry about the expected
number of components in X (rank of the matrix, given the number of replicates per treatment
level), as suggested by Smilde et al. (2005), because the components are directly summarized
in the coefficient ˆBl matrix. In addition, for both PCA/PLS, the lmdme package (Fresno and
Fernández 2013a) also offers different methods to visualize results, e.g., biplot, loadingplot
and screeplot or leverage calculation, in order to filter out rows/genes as in Tarazona et al.
(2012).

3. Example

In this section we provide an overview of lmdme package by Fresno and Fernández (2013a).
The example consists of an application of the analysis of gene expression interaction pattern,
where we address: How to define the model, undertake ANOVA decomposition, perform
PCA/PLS analysis and visualize the results.
From here onwards, some outputs were removed for reasons of clarity and the examples were
performed with options(digits=4).

3.1. Package overview

The original data files for the first example are available at Gene Expression Omnibus (Edgar
et al. 2002), with accession GSE37761 and stemHypoxia package (Fresno and Fernández
In this dataset, Prado-Lopez et al. (2010) studied
2013b) on the Bioconductor website.
differentiation of human embryonic stem cells under hypoxia conditions. They measured
gene expression at different time points under controlled oxygen levels. This experiment has
a typical two-way ANOVA structure, where factor A stands for “time” with a = 3 levels
{0.5, 1, 5 days}, factor B stands for “oxygen” with b = 3 levels {1, 5, 21%} and r = 2
replicates, yielding a total of 18 samples. The remainder of the dataset was excluded in
order to have a balanced design, as suggested by Smilde et al. (2005) to fulfil orthogonality
assumptions in ANOVA decomposition.
First, we need to load stemHypoxia package to access R objects calling data("stemHypoxia"),
which will then load the experimental design and gene expression intensities M.

R> library("stemHypoxia")
R> data("stemHypoxia")

Now we manipulate the design object to maintain only those treatment levels which create a
balanced dataset. Then, we change rownames(M) of each gene in M, with their corresponding
M$Gene_ID.

Cristóbal Fresno, Mónica G Balzarini, Elmer A Fernández

7

R> timeIndex<-design$time %in% c(0.5, 1, 5)
R> oxygenIndex<-design$oxygen %in% c(1, 5, 21)
R> design<-design[timeIndex & oxygenIndex, ]
R> design$time<-as.factor(design$time)
R> design$oxygen<-as.factor(design$oxygen)
R> rownames(M)<-M$Gene_ID
R> M<-M[, colnames(M) %in% design$samplename]

Now we can explore microarray gene expression data present on the M matrix, with g =
40736 rows (individuals/genes) and n = 18 columns (samples/microarrays). In addition, the
experimental design data.frame contains main effect columns (e.g., time and oxygen) and the
sample names (samplename). A brief summary of these objects is shown using head function:

R> head(design)

time oxygen samplename
12h_1_1
1
12h_1_2
1
12h_5_1
5
12h_5_2
5
12h_21_1
21
12h_21_2
21

0.5
0.5
0.5
0.5
0.5
0.5

3
4
5
6
7
8

R> head(M)[, 1:3]

A_24_P66027
A_32_P77178
A_23_P212522
A_24_P934473
A_24_P9671
A_32_P29551

7.182
6.385
9.562
6.288

12h_1_1 12h_1_2 12h_5_1
8.225
7.512
6.440
6.035
9.211
9.390
6.265
6.397
12.007 11.995 12.282
9.360
9.273
10.176

Once the preprocessing of the experiment data is completed, library("lmdme") should be
loaded. This instruction will automatically load the required packages: limma (Smyth et al.
2011) and pls (Mevik et al. 2011). Once the data are loaded, the ANOVA decomposition of
Section 2.1 can be carried out using (4) calling lmdme function with the model formula, actual
data and experimental design.

R> library("lmdme")
R> fit<-lmdme(model=~time*oxygen, data=M, design=design)
R> fit

lmdme object:
Data dimension: 40736 x 18
Design (head):

8

3
4
5
6
7
8

lmdme: Linear Models on Designed Multivariate Experiments in R

time oxygen samplename
12h_1_1
1
12h_1_2
1
12h_5_1
5
12h_5_2
5
12h_21_1
21
12h_21_2
21

0.5
0.5
0.5
0.5
0.5
0.5

Model:~time * oxygen
Model decomposition:

Step

Names
~ 1
1 (Intercept)
~ -1 + time
time
2
3
~ -1 + oxygen
oxygen
4 time:oxygen ~ -1 + time:oxygen

Formula CoefCols
1
3
3
9

1
2
3
4

The results of lmdme will be stored inside the fit object, which is an S4 R class. By invoking
the fit object, a brief description of the data and design used are shown as well as the
Model applied and a summary of the decomposition. This data.frame describes the applied
Formula and Names for each Step, as well as the amount of estimated coefficients for each
gene (CoefCols).
At this point, we can choose those subjects/genes in which at least one interaction coefficient
is statistically different from zero (F test on the coefficients) with a threshold p value of 0.001
and perform ASCA on the interaction coefficient term, and PLS against the identity matrix
(default option).

term="time:oxygen", subset=id, scale="row")

R> id<-F.p.values(fit, term="time:oxygen")<0.001
R> decomposition(fit, decomposition="pca", type="coefficient",
+
R> fit.plsr<-fit
R> decomposition(fit.plsr, decomposition="plsr", type="coefficient",
+

term="time:oxygen", subset=id, scale="row")

These instructions will perform ASCA and PLS decomposition over the scale="row" version
of the 305 selected subjects/genes (subset=id) on fit and fit.plsr object, respectively.
The results will be stored inside these objects. In addition, we have explicitly indicated the
decomposition type="coefficient" (default value) in order to apply it to the coefficient
matrix, on "time:oxygen" interaction term ( ˆBαβ).
Now, we can visualize the associated biplots (see Figure 2 (a) and (b)).

R> biplot(fit, xlabs="o", expand=0.7)
R> biplot(fit.plsr, which="loadings", xlabs="o",
+
+

ylabs=colnames(coefficients(fit.plsr, term="time:oxygen")),
var.axes=TRUE)

For visual clarity, xlabs are changed with the "o" symbol, instead of using the rownames(M)
with manufacturer ids, and second axis with the expand=0.7 option to avoid cutting off

Cristóbal Fresno, Mónica G Balzarini, Elmer A Fernández

9

(a) ANOVA simultaneous component analysis

(b) ANOVA partial least squares

Figure 2: Biplot on the decomposed interaction coefficients (time×oxygen) on genes satisfying
the F test with p value < 0.001. Notice that the interaction matrix in the ASCA model is of
rank 9. Thus, 9 arrows are expected and the score of the 305 selected subjects are projected
onto the space spanned by the first two principal components in Figure 2(a).

loading labels. In addition, PLS biplot is modified from the default pls behavior to obtain a
graph similar to ASCA output (which="loadings"). Accordingly, ylabs is changed to match
the corresponding coefficients of the interaction term and var.axes is set to TRUE.
The ASCA biplot of the first two components (see Figure 2(a)), explain over 70% of the
coefficient variance. The genes are arranged in an elliptical shape. Thus, it can be observed
that some genes tend to interact with different combinations of time and oxygen. A similar
behavior is observed in PLS biplot of Figure 2(b).

−0.10−0.050.000.050.100.15−0.10−0.050.000.050.100.15time:oxygenPC1(50.61%)PC2(23.68%)ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo−30−20−10010203040−30−20−10010203040time0.5:oxygen1time1:oxygen1time5:oxygen1time0.5:oxygen5time1:oxygen5time5:oxygen5time0.5:oxygen21time1:oxygen21time5:oxygen21−0.15−0.10−0.050.000.050.100.15−0.15−0.10−0.050.000.050.100.15time:oxygenComp 1Comp 2ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo−0.03−0.010.000.010.020.03−0.03−0.010.000.010.020.03time0.5:oxygen1time1:oxygen1time5:oxygen1time0.5:oxygen5time1:oxygen5time5:oxygen5time0.5:oxygen21time1:oxygen21time5:oxygen2110

lmdme: Linear Models on Designed Multivariate Experiments in R

The interaction effect on the fit object can also be displayed using the loadingplot function
(see Figure 3). For every combination of two consecutive levels of factors (time and oxygen),
the figure shows an interaction effect on the first component, which explains 50.61% of the
total variance of the “time:oxygen” term.

R> loadingplot(fit, term.x="time", term.y="oxygen")

Figure 3: ANOVA simultaneous component analysis loadingplot on genes satisfying the
F test with p value < 0.001 on the interaction coefficients (time × oxygen).

In the case of an ANOVA-PCA/PLS analysis, the user only needs to change the type="residuals"
parameter in the decomposition function and perform a similar exploration.

time:oxygentimePC−1− Exp. Var. (50.61%)−0.4−0.20.00.20.40.515oxygen=1oxygen=5oxygen=21Cristóbal Fresno, Mónica G Balzarini, Elmer A Fernández

11

Acknowledgements

Funding: This work was supported by the National Agency for Promoting Science and Tech-
nology, Argentina (PICT00667/07 to E.A.F. and PICT 2008-0807 BID to E.A.F.), Córdoba
Ministry of Science and Technology, Argentina (PID2008 to E.A.F and PIP2009 to M.G.B.),
Catholic University of Córdoba, Argentina and National Council of Scientific and Technical
Research (CONICET), Argentina.

References

Abdi H, Williams L (2010). “Principal Component Analysis.” Wiley Interdisciplinary Reviews:

Computational Statistics, 2(4), 433–459.

De Haan J, Wehrens R, Bauerschmidt S, Piek E, Van Schaik R, Buydens L (2007). “In-
terpretation of ANOVA Models for Microarray Data Using PCA.” Bioinformatics, 23(2),
184–190.

Edgar R, Domrachev M, Lash AE (2002). “Gene Expression Omnibus: NCBI Gene Expression
and Hybridization Array Data Repository.” Nucleic Acids Research, 30(1), 207–210. ISSN
1362-4962. doi:10.1093/nar/30.1.207. URL http://dx.doi.org/10.1093/nar/30.1.
207.

Fresno C, Balzarini MG, Fernández EA (2014).

Multivariate Experiments in R.”
http://www.jstatsoft.org/v56/i07/.

“lmdme: Linear Models on Designed
Journal of Statistical Software, 56(7), 1–16. URL

Fresno C, Fernández EA (2013a).

lmdme: Linear Model Decomposition for Designed Mul-
tivariate Experiments. R package version 1.2.1, URL http://www.bioconductor.org/
packages/release/bioc/html/lmdme.html.

Fresno C, Fernández EA (2013b). stemHypoxia: Differentiation of Human Embryonic Stem
Cells Under Hypoxia Gene Expression Dataset by Prado-Lopez et al. (2010). R package ver-
sion 0.99.3, URL http://www.bioconductor.org/packages/release/data/experiment/
html/stemHypoxia.html.

Gentleman RC, Carey VJ, Bates DM, others (2004). “Bioconductor: Open Software Devel-
opment for Computational Biology and Bioinformatics.” Genome Biology, 5, R80. URL
http://genomebiology.com/2004/5/10/R80.

Hanson BA (2012). ChemoSpec: Exploratory Chemometrics for Spectroscopy. R package

version 1.51-2, URL http://CRAN.R-project.org/package=ChemoSpec.

Harrington PdB, Vieira N, Espinoza J, Nien J, Romero R, Yergey A (2005). “Analysis of
Variance–Principal Component Analysis: A Soft Tool for Proteomic Discovery.” Analytica
Chimica Acta, 544(1), 118–127.

Mevik BH, Wehrens R, Liland KH (2011). pls: Partial Least Squares and Principal Component
Regression. R package version 2.3-0, URL http://CRAN.R-project.org/package=pls.

12

lmdme: Linear Models on Designed Multivariate Experiments in R

Nueda M, Conesa A, Westerhuis J, Hoefsloot H, Smilde A, Talón M, Ferrer A (2007). “Discov-
ering Gene Expression Patterns in Time Course Microarray Experiments by ANOVA–SCA.”
Bioinformatics, 23(14), 1792–1800.

Prado-Lopez S, Conesa A, Armiñán A, Martínez-Losa M, Escobedo-Lucea C, Gandia C,
Tarazona S, Melguizo D, Blesa D, Montaner D, et al. (2010). “Hypoxia Promotes Efficient
Differentiation of Human Embryonic Stem Cells to Functional Endothelium.” Stem Cells,
28(3), 407–418.

R Development Core Team (2012). R: A Language and Environment for Statistical Computing.
R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http:
//www.R-project.org.

Shawe-Taylor J, Cristianini N (2004). Kernel Methods for Pattern Analysis. Cambridge
University Press. ISBN 9780521813976. URL http://books.google.com.ar/books?id=
9i0vg12lti4C.

Smilde A, Jansen J, Hoefsloot H, Lamers R, Van Der Greef J, Timmerman M (2005).
“ANOVA-Simultaneous Component Analysis (ASCA): A New Tool for Analysing Designed
Metabolomics Data.” Bioinformatics, 21(13), 3043–3048.

Smyth GK (2004). “Linear Models and Empirical Bayes Methods for Assessing Differential
Expression in Microarray Experiments.” Statistical Applications in Genetics and Molecular
Biology, 3(1), Article 3.

Smyth GK, Ritchie M, Silver J, Wettenhall J, Thorne N, Langaas M, Ferkingstad E, Davy
M, Pepin F, Choi D, McCarthy D, Wu D, Oshlack A, de Graaf C, Hu Y, Shi W, Phipson
B (2011).
limma: Linear Models for Microarray Data. R package version 3.12.1, URL
http://www.bioconductor.org/packages/2.10/bioc/html/limma.html.

Subramanian A, Tamayo P, Mootha V, Mukherjee S, Ebert B, Gillette M, Paulovich A,
Pomeroy S, Golub T, Lander E, et al. (2005).
“Gene Set Enrichment Analysis: A
Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” Proceed-
ings of the National Academy of Sciences of the United States of America, 102(43), 15545–
15550.

Tarazona S, Prado-López S, Dopazo J, Ferrer A, Conesa A (2012). “Variable Selection for
Multifactorial Genomic Data.” Chemometrics and Intelligent Laboratory Systems, 110(1),
113–122.

Zwanenburg G, Hoefsloot H, Westerhuis J, Jansen J, Smilde A (2011). “ANOVA-Principal
Component Analysis and ANOVA-Simultaneous Component Analysis: A Comparison.”
Journal of Chemometrics, 25(10), 561–567.

Cristóbal Fresno, Mónica G Balzarini, Elmer A Fernández

13

Session Info

R> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats
[7] base

graphics grDevices utils

datasets

methods

other attached packages:
[1] lmdme_1.52.0

pls_2.8-5

stemHypoxia_1.45.0

loaded via a namespace (and not attached):
[1] compiler_4.5.1 limma_3.66.0

tools_4.5.1

statmod_1.5.1

Affiliation:
Cristóbal Fresno & Elmer A Fernández
Bioscience Data Mining Group
Faculty of Engineering
Universidad Católica de Córdoba
X5016DHK Córdoba, Argentina
E-mail: cfresno@bdmg.com.ar, efernandez@bdmg.com.ar
URL: http://www.bdmg.com.ar/

Mónica G Balzarini

14

lmdme: Linear Models on Designed Multivariate Experiments in R

Biometry Department
Faculty of Agronomy
Universidad Nacional de Córdoba
X5000JVP Córdoba, Argentina
E-mail: mbalzari@gmail.com
URL: http://www.infostat.com.ar/

