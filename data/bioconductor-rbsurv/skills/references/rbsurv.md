How to use the rbsurv Package

HyungJun Cho, Sukwoo Kim, Soo-heang Eo, and Jaewoo Kang

October 30, 2025

Contents

1 Introduction

2 Robust likelihood-based survival modeling

3 Algorithm

4 Example: Glioma Data

5 Argument description

6 Conclusion

1

Introduction

1

2

2

3

5

6

The rbsurv package is designed to select survival-associated genes, based on a likelihood
function. It utilizes the partial likelihood of the Cox model which has been the basis
for many of the existing methods. Our algorithm is simple and straight-forward, but
its functions such as the generation of multiple gene models and the incorporation of
significant risk factors are practical. For robustness, this package also selects survival-
associated genes by separating training and validation sets of samples because such a
cross-validation technique is essential in predictive modeling for data with large vari-
ability. It employs forward selection, generating a series of gene models and selecting an
optimal model. Furthermore, iterative runs after putting aside the previously selected
genes can discover the masked genes that may be missed by forward selection (see Cho
et al. for details). The rbsurv package employs libraries survival and Biobase.

1

2 Robust likelihood-based survival modeling

Suppose the data consists of G genes and N samples, and each sample has its ob-
served (survival or censoring) time and censoring status. Thus, it consists of the triple
(Yj, δj, Xj), j = 1, . . . , N , where Yj and δj are observed time and censoring status (usu-
ally, 1=died, 0=censored) for the j-th sample respectively, and Xj = (X1j, X2j, . . . , XKj)
is the j-th vector of the expression values for K genes (K < N and K ⊂ G). Let
Y(1) < Y(2) < . . . < Y(D) denote the ordered times with D distinct values and X(i)k be the
k-th gene associated with the sample corresponding to Y(i). The Cox proportional haz-
ards model is h(y|X1, X2, . . . , XK) = h0(y) exp((cid:80)K
k=1 βkXk), where h(y|X1, X2, . . . , XK)
is the hazard rate at time y for a sample with risk vector (X1, X2, . . . , XK), h0(y) is an
arbitrary baseline hazard rate, and βk is the coefficient for the k-th gene. The partial
likelihood for the Cox model is

D
(cid:88)

K
(cid:88)

i=1

k=1

βkX(i)k −

D
(cid:88)

ln[

(cid:88)

K
(cid:88)

exp(

i=1

j∈R(Y(i))

k=1

βkXjk)],

(1)

where R(Y(i)) is the set of all samples that are still under study at a time just prior to
Y(i). Maximizing the likelihood provides the maximum likelihood estimates (MLE) of
the coefficients, so denote the MLEs by ˆβ1, ˆβ2, . . . , ˆβk. Then, as a goodness-of-fit, we can
use the fitted partial likelihood:

loglik =

D
(cid:88)

K
(cid:88)

i=1

k=1

ˆβkX(i)k −

D
(cid:88)

ln[

(cid:88)

K
(cid:88)

exp(

ˆβkXjk)].

i=1

j∈R(Y(i))

k=1

(2)

The negative log-likelihood (-loglik) is greater than zero, so the smaller -loglik the model
better. For robustness, however, the model should be evaluated by independent valida-
tion samples rather than the training samples used for fitting the model such as

loglik∗ =

D∗
(cid:88)

K
(cid:88)

i=1

k=1

ˆβ0
kX ∗

(i)k −

D∗
(cid:88)

i=1

(cid:88)

ln[

K
(cid:88)

exp(

j∈R(Y ∗

(i))

k=1

ˆβ0
kX ∗

jk)],

(3)

where ∗ indicate the use of the validation samples and the estimates ˆβ0
k are
obtained by the training samples. For robust gene selection, we thus use training samples
for model fitting and validation samples for model validation. This cross-validation is
repeated many times independently. In other words, we fit the Cox model with a gene
(or genes) and select a gene (or genes) maximizing mean loglik∗ (i.e., minimizing the
mean negative loglik∗).

2, . . . , ˆβ0

1, ˆβ0

3 Algorithm

Suppose the data consists of expression values X for G genes and N samples. Each
sample has its observed (survival or censoring) time Y and censoring status δ. We assume

2

that expression values are already normalized and transformed in appropriate ways.
Prior gene selection such as univariate survival modeling and/or biological pre-selection
can also be performed if necessary. Univariate survival modeling can be performed in
our software program. Our algorithm is summarized as follows. R function arguments
are also included.

1. Randomly divide the samples into the training set with N (1 − p) samples and
the validation set with N p samples, e.g., p = 1/3, (n.fold=3 ). Fit a gene to the
training set of samples and obtain the parameter estimate ˆβ0
i for the gene. Then
evaluate loglik∗ with the parameter estimate, ˆβ0
i , and the validation set of samples,
(Y ∗

i ). Perform this evaluation for each gene.

i , X ∗

i , δ∗

2. Repeat the above procedure B times, e.g., B = 100, (n.iter=100 ), thus obtaining
B loglik∗s for each gene. Then select the best gene with the smallest mean negative
loglik∗ (or the largest mean loglik∗). The best gene is the most survival-associated
one that is selected by the robust likelihood-based approach.

3. Let g(1) be the selected best gene in the previous step. Adjusting for g(1), find
the next best gene by repeating the previous two steps. In other words, evaluate
g(1) + gj for every j and select an optimal two-gene model, g(1) + g(2).

4. Continue this forward gene selection procedure until fitting is impossible because
of the lack of samples, resulting in a series of K models M1 = g(1), M2 = g(1)+g(2),
. . ., MK−1 = g(1) + g(2) + . . . + g(K−1), MK = g(1) + g(2) + . . . + g(K).

5. Compute AICs for all the K candidate models, M1, M2, . . . , MK, and select an

optimal model with the smallest AIC.

6. Put aside the genes in the optimal model in the previous step. Then repeat steps
2-6. This can be repeated several times sequentially, e.g, 3 times, (n.seq=3 ),
generating multiple optimal models.

In addition, suppose that p risk factors, Z1, Z2, . . . , Zp, are available for each sample.

Then risk factors can be included in every modeling of the previous algorithm.

4 Example: Glioma Data

We demonstrate the use of the package with a microarray data set for patients with
gliomas. This real data set consists of gene expression value, survival time, and censoring
status of each of 85 patients with gliomas (Freije et al., 2004). For this study, Affymetrix
U133A and U133B chips were used and dCHIP was used to convert data files (.CEL) into
expression values with median intensity normalization. This data set originally consists
of more than 40,000 probe sets, but only a sub-dataset made up of 100 probe sets was
stored into the rbsurv package for demonstration.

To run rbsurv , the data can be prepared as follows.

3

> library(rbsurv)
> data(gliomaSet)
> gliomaSet

ExpressionSet (storageMode: lockedEnvironment)
assayData: 100 features, 85 samples

element names: exprs

protocolData: none
phenoData

sampleNames: Chip1 Chip2 ... Chip85 (85 total)
varLabels: Time Status Age Gender
varMetadata: labelDescription

featureData: none
experimentData: use 'experimentData(object)'

pubMedIds: 15374961

Annotation:

> x <- exprs(gliomaSet)
> x <- log2(x)
> time <- gliomaSet$Time
> status <- gliomaSet$Status
> z <- cbind(gliomaSet$Age, gliomaSet$Gender)
>

We here took log2-transformation without any other normalizations. An appropriate
normalization can be taken if needed. If the data is ready, rbsurv can be run as follows.

> fit <-

rbsurv(time=time, status=status, x=x, method="efron", max.n.genes=20)

Please wait... Done.

This sequentially selects genes one gene at a time to build an optimal gene model.
Once a large gene model is constructed, an optimal gene model is determined by AICs.
If there exist ties in survival times, Efron’s method is used (method="efron"). Note
that it is computationally expensive and the data is high-throughput. Therefore, you
should be patient to obtain the output. To save time, we can reduce the number of genes
considered up to 20 genes among 100 initial genes (max.n.genes=20 ). The 20 genes are
selected by fitting univariate Cox models. The above command generates the following
output.

> fit$model

4

Seq Order Gene nloglik

AIC Selected

0
110
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

0
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19

0
46
57
43
34
99
36
8
86
68
56
15
29
75
67
40
98
19
39
96

228.74 457.47
218.53 439.05 *
202.21 408.42 *
195.50 396.99 *
194.01 396.01 *
192.14 394.29 *
189.81 391.63 *
188.80 391.59 *
187.90 391.80
187.52 393.04
187.42 394.84
186.68 395.37
185.54 395.09
185.54 397.09
185.41 398.83
183.76 397.52
183.04 398.09
182.25 398.49
181.99 399.98
181.88 401.76

This large gene model contains survival-associated genes which were selected one at
a time by forward selection. Note that the first row has no gene ID because it was
fitted with no expression profile. The size of the large gene model was determined by
the numbers of samples and genes considered. The AICs tend to decrease and then
increase, while negative log-likelihoods (nlogliks) always decrease. Thus, we select an
optimal model with the smallest AIC. The selected parsimonious model consists of the
survival-associated genes, which are marked with asterisks (*).

Potential risk factors can be included in modeling and it can be run sequentially. For
example, use rbsurv(time = time, status = status, x = x, z = z, alpha = 0.05, n.seq =
3) for significant risk factors with significance level 0.05 and 3 sequential runs. All the
risk factors are included if the significance level is 1. For the detailed algorithm, refer to
Cho et al. (submitted).

5 Argument description

In this section, we describe the arguments with the following command.

library(rbsurv)
fit <- rbsurv(time=time, status=status, x=x, z=z, alpha=0.05, gene.ID=NULL,

method="efron", max.n.genes=100, n.iter=100, n.fold=3,
n.seq=3, seed = 1234)

5

Table 1: Argument description

Argument
time
status
x
z
alpha
gene.ID
method
n.iter
n.fold
n.seq
seed
max.n.genes

Description
a vector for survival times
a vector for survival status, 0=censored, 1=event
a matrix for expression values (genes in rows, samples in columns)
a matrix for risk factors
a significance level for evaluating risk factors
a vector for gene IDs; if NULL, row numbers are assigned.
a character string specifying the method for tie handling.
the number of iterations for gene selection
the number of partitions of samples
the number of sequential runs or multiple models
a seed for sample partitioning
the maximum number of genes considered

The required arguments time and status are vectors for survival times and survival
status (0=censored, 1=event) and x is a matrix for expression values (genes in rows,
samples in columns). The optional argument z is a matrix for risk factors. To include
only the significant risk factors, a significance level less than 1 is given to alpha, e.g.,
alpha = 0.05. In addition, there are several controlled arguments. gene.ID is a vector
for gene IDs; if NULL, row numbers are assigned. method is a character string specifying
the method for tie handling. One of efron, breslow , exact can be chosen. If there are no
tied death times all the methods are equivalent. In the algorithm, n.fold is the number
of partitions of samples in step 1, n.iter is the number of iterations for gene selection
in step 2, and n.seq is the number of sequential runs (or multiple models) in step 6.
seed is a seed for sample partitioning. max.n.genes is the maximum number of genes
considered. If the number of the input genes is greater than the given maximum number,
it is reduced by fitting individual Cox models and selecting the genes with the smallest
p-values. The input arguments of rbsurv are summarized in Table 1. The major output
fit$model contains survival-associated gene models with gene IDs, nlogliks, and AICs.
The genes in the optimal model with the smallest AIC are marked with asterisks (*).

6 Conclusion

This package allows ones to build multiple gene models sequentially rather than a sin-
gle gene model. Furthermore, other covariates such as age and gender can also be
incorporated into modeling with gene expression profiles. Each model contains survival-
associated genes that are selected robustly by separating training and test sets many
times.

6

References

Cho, H., Yu, A., Kim, S., Kang, J., Hong, S-M., (2009). Robust Likelihood-Based
Survival Modeling with Microarray Data. Journal of Statistical Software 29(1),
1-16. URL http://www.jstatsoft.org/v29/i01/.

Freije, W.A., Castro-Vargas, F.E., Fang, Z., Horvath, S., Cloughesy, T., Liau,
L.M., Mischel, P.S. and Nelson, S.F. (2004). Gene expression profiling of gliomas
strongly predicts survival, Cancer Research, 64:6503-6510.

7

