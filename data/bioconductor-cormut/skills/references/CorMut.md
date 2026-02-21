Detecting the correlated mutations based on
selection pressure with CorMut

Zhenpeng Li

October 30, 2018

Contents

1

Introduction

2 Methods

3

Implementation

1

Introduction

1

2

3

In genetics, the Ka/Ks ratio is the ratio of the number of non-synonymous substitutions
per non-synonymous site (Ka) to the number of synonymous substitutions per synony-
mous site (Ks)[1]. Ka/Ks ratio was used as an indicator of selective pressure acting on
a protein-coding gene. A Ka/Ks ratio of 1 indicates neutral selection, i.e., the observed
ratio of non-synonymous mutations versus synonymous mutations exactly matches the
ratio expected under a random mutation model. Thus, amino acid changes are neither
being selected for nor against. A Ka/Ks value of <1 indicates negative selection pres-
sure. That is to say most amino acid changes are deleterious and are selected against,
producing an imbalance in the observed mutations that favors synonymous mutations.
In the condition of Ka/Ks>1 , it indicates that amino acid changes are favored, i.e.,
they increase the organism’s ﬁtness. This unusual condition may reﬂect a change in the
function of a gene or a change in environmental conditions that forces the organism to
adapt. For example, highly variable viruses mutations which confer resistance to new
antiviral drugs might be expected to undergo positive selection in a patient population
treated with these drugs, such as HIV and HCV.
The concept of correlated mutations is one of the basic ideas in evolutionary biology.
The amino acid substitution rates are expected to be limited by functional constraints.
Given the functional constraints operating on gene, a mutation in one position can be
compensated by an additional mutation. Then mutation patterns can be formed by cor-
related mutations responsible for speciﬁc conditions.
Here, we developed an R/Bioconductor package to detect the correlated mutations
among positive selection sites by combining ka/ks ratio and correlated mutations anal-
ysis. The deﬁnition of Ka/Ks is based on Chen et al[2]. CorMut provides functions
for computing kaks for individual site or speciﬁc amino acids and detecting correlated
mutations among them. Two methods are provided for detecting correlated mutations,

1

including conditional selection pressure and mutual information, the computation con-
sists of two steps: First, the positive selection sites are detected; Second, the mutation
correlations are computed among the positive selection sites. Note that the ﬁrst step is
optional. Meanwhile, CorMut facilitates the comparison of the correlated mutations
between two conditions by the means of correlated mutation network.

2 Methods

2.1 Ka/Ks calculation for individual codon position and speciﬁc amino acid substitu-
tions
The Ka/Ks values for individual codon (speciﬁc amino acid substitutions) were deter-
mined as described by Chen et al. The Ka/Ks of individual codon (speciﬁc amino acid
substitution (X2Y) for a codon) was computed as follows:

Ka
Ks =

NY
NS
nY,tft+nY,v fv
nS,t ft+nS,v fv

where NY and NS are the count of samples with nonsynonymous mutations(X2Y mu-
tation) at that codon and the count samples with of synonymous mutations observed
at that codon respectively. Then, NY/NS is normalized by the ratio expected under
a random mutation model (i.e., in the absence of any selection pressure), which was
represented as the denominator of the formula. In the random mutation model, ft and
fv indicate the transition and transversion frequencies respectively, and they were mea-
sured from the entire data set according to the following formulas: ft = Nt/ntS and fv
= Nv/nvS, where S is the total number of samples; Nt and Nv are the numbers of ob-
served transition and transversion mutations, respectively; nt and nv are the number of
possible transitions and transversions in the focused region (simply equal to its length
L and 2L respectively).LOD conﬁdence score for a codon or mutation X2Y to be under
positive selection pressure was calculated by the following formula:

LOD = −log10p(i ≥ NY aXa|N, q,

(cid:16) Ka
Ks

(cid:17)

Y |Xa

= 1) = −log10

N
(cid:80)
i=NY aXa

(cid:18) N
i

(cid:19)

qi(1 − q)N −i

Where N = NYaXa + NYsXa and q as deﬁned above. If LOD > 2, the positive selection
is signiﬁcant.
2.2 Mutual information
MI content was adopted as a measure of the correlation between residue substitu-
tions[3]. Accordingly, each of the N columns in the multiple sequence alignment gen-
erated for a protein of N codons is considered as a discrete random variable Xi(1 ≤
i ≤ N ). When compute Mutual information between codons, Xi(1 ≤ i ≤ N ) takes
on one of the 20 amino acid types with some probability, then compute the Mutual
information between two sites for speciﬁc amino acid substitutions, Xi(1 ≤ i ≤ N )
were only divided two parts (the speciﬁc amino acid mutation and the other) with some
probability. Mutual information describes the mutual dependence of the two random
variables Xi, Xj, The MI associated the random variables Xi and Xj corresponding to
the ith and jth columns is deﬁned as
I(Xi, Xj) = S(Xi) + S(Xj) − S(Xi, Xj) = S(Xi) − S(Xi|Xj)
Where
S(Xi) = − (cid:80)
allxi

P (Xi = xi) log P (Xi = xi)

is the entropy of Xi,
S(Xi|Xj) = − (cid:80)
allxi

(cid:80)
allxj

P (Xi = xi, Xj = xj) log P (Xi = xi|Xj = xj)

2

is the conditional entropy of Xi given Xj, S(Xi, Xj) is the joint entropy of Xi and Xj.
Here P(Xi = xi, Xj = xj) is the joint probability of occurrence of amino acid types xi
and xj at the ith and jth positions, respectively, P(Xi = xi) and P(Xj = xj) are the corre-
sponding singlet probabilities.
I(Xi, Xj) is the ijth element of the N × N MI matrix I corresponding to the examined
multiple sequence alignment.
2.3 Jaccard index
Jaccard index measures similarity between two variables, and it has been widely used
to measure the correlated mutations. For a pair of mutations X and Y, the Jaccard index
is calculated as Nxy/(Nxy+Nx0+Ny0), where Nxy represents the number of sequences
where X and Y are jointly mutated, Nx0 represents the number of sequences with only
X mutation, but not Y, and Ny0 represents the sequences with only Y mutation, but not
X. The computation was deemed to effectively avoid the exaggeration of rare mutation
pairs where the number of sequences without either X or Y is very large.

3

Implementation

3.1 Process the multiple sequence alignment ﬁles seqFormat replace the raw bases
with common bases and delete the gaps according to the reference sequence. As one
raw base has several common bases, then a base causing amino acid mutation will be
randomly chosen. Here, HIV protease sequences of treatment-naive and treatment will
be used as examples.

> library(CorMut)
> examplefile=system.file("extdata","PI_treatment.aln",package="CorMut")
> examplefile02=system.file("extdata","PI_treatment_naive.aln",package="CorMut")
> example=seqFormat(examplefile)
> example02= seqFormat(examplefile02)

3.2 Compute kaks for individual codon

> result=kaksCodon(example)
> fresult=filterSites(result)
> head(fresult)

mutation

lod

kaks

freq
3 150.500000 52.827378 1.0000
8.500000 24.207139 0.7367
10
12 15.000000 5.106647 0.0967
2.538855 3.208047 0.1167
19
3.233179 3.131694 0.1000
24
4.300086 4.600433 0.2633
35

1
2
3
4
5
6

3.3 Compute kaks for individual amino acid mutation

> result=kaksAA(example)
> fresult=filterSites(result)
> head(fresult)

position mutation

freq
V3I 404.841453111799 179.656919924817 0.9967

kaks

lod

1

3

3

2
3
4
5
6

10
12
12
12
12

L10I 106.510984639863 194.782739610876 0.6033
T12N 6.45113051800455
0.01
T12P 61.1996817820207 4.49416430538097 0.0267
T12E 15.0526378753439
Inf 0.0233
T12S 38.2498011137629 2.04605159081416 0.0167

Inf

3.4 Compute the conditional kaks(conditional selection pressure) among codons

> result=ckaksCodon(example)

> plot(result)

> fresult=filterSites(result)
> head(fresult)

ckaks

lod
position1 position2
17 24.2071393392468
10
12
30 5.10664651261475
19 1.84210526315789 3.20804706405523
24 3.33333333333333 3.13169395564291
35 13.1666666666667
4.6004332373075
142 31.4550748700319
37

3
3
3
3
3
3

1
2
3
4
5
6

3.5 Compute the conditional kaks(conditional selection pressure) among amino acid
mutations

> result=ckaksAA(example)

4

lllllllllllllllllll3101219243537414854626371737782909399> plot(result)

> fresult=filterSites(result)
> head(fresult)

position1 position2 ckaks

1
2
3
4
5
6

V3I
V3I
V3I
V3I
V3I
V3I

lod
L10I 13.92 226.78
T12N
Inf
10.89
T12P
Inf
T12E
6.8
T12S
18.68
I13V

4
9
8
6
33

3.6 Compute the mutual information among codons
An instance with two matrixes will be returned, they are mutation information ma-
trix and p matrix, The ijth element of the N × N MI matrix indicates the mutation
information or p value between position i and position j.

> result=miCodon(example)

> plot(result)

5

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllV3IL10IT12NT12PT12ET12SI13VI15VL19IK20IL24IV32IE35DM36IS37NS37DS37ES37HR41KK45RM46LM46II47VG48VF53LI54VR57KD60EI62VL63PI64VH69KA71VI72VG73SG73TT74SV77IV82AV82TI84VI85VL90MI93LE34QK43TQ58EL63QL63SA71IA71LI72EI72QL76VC95FL63AL33IK70TL89MS37AG48TG48M> fresult=filterSites(result)
> head(fresult)

position1 position2

1
2
3
4
5
6

10
19
37
37
41
48

mi
3 0.0223403798434836

p.value
0.016674589534501
12 0.128809592522988 0.00406939387449132
19 0.0747160966532552
0.016674589534501
35 0.075806272221832 0.00406939387449132
37
0.06512044936218 0.00657363625879368
10 0.0897750853050767 0.00406939387449132

3.7 Compute the mutual information among individual amino acid mutations

An instance with two matrixes will be returned, they are mutation information ma-
trix and p matrix, The ijth element of the N × N MI matrix indicates the mutation
information or p value between two amino acid mutations.

> result=miAA(example)

> plot(result)

6

lllllllllllllllllll1031912373541482454626371737782909399> fresult=filterSites(result)
> head(fresult)

position1 position2

1
2
3
4
5
6

L10I
T12N
T12E
I13V
I13V
I15V

p.value
mi
V3I 0.00309067986573841 7.90929048032942e-40
0.040207170030247
L10I 8.64708687707827e-05
L10I 0.000640519978094889 1.63583633828262e-09
3.1062662483976e-05
T12S 0.00478659729991238 6.31583852904427e-63
V3I 0.00051661973913858 7.31371985853487e-07

V3I 0.000389134320368023

3.8 Compute the Jaccard index among individual amino acid mutations
An instance with two matrixes will be returned, they are Jaccard index matrix and
p matrix, The ijth element of the N × N MI matrix indicates the Jaccard index or p
value between two amino acid mutations.

> result=jiAA(example)

> plot(result)

7

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllL10IV3IT12NT12EI13VT12SI15VT12PL19IK20IL24IV32IL33IE34QE35DM36IS37NS37DS37ES37AS37HR41KK43TK45RM46LM46II47VG48VG48TG48MF53LI54VR57KQ58ED60EI62VL63PL63QL63AL63SI64VH69KK70TA71VA71IA71LI72VI72EI72QG73SG73TT74SL76VV77IV82AV82TI84VI85VL89ML90MI93LC95F> fresult=filterSites(result)
> head(fresult)

position1 position2

1
2
3
4

T12P
L19I
T12E
T12E

p.value
JI
0.0203598174209213
K14R 0.192307692307692
0.00322947408828938
I15V 0.228070175438596
I15V 0.162790697674419 0.000394448679750347
0.0203598174209213
L19I 0.172413793103448

3.9 Comparison of the correlated mutations between two conditions by the means of
correlated mutation network

biCompare compare the correlated mutation relationship between two conditions,
such as HIV treatment-naive and treatment. The result of biCompare can be visualized
by plot method. Only positive selection codons or amino acid mutations were displayed
on the plot, blue nodes indicate the distinct positive codons or amino acid mutations
of the ﬁrst condition, that is to say these nodes will be non-positive selection in sec-
ond condition. While red nodes indicate the distinct positive codons or amino acid
mutations appeared in the second condition. plot also has an option for displaying the
unchanged positive selection nodes in both conditions. If plotUnchanged is FALSE,
the unchanged positive selection nodes in both conditions will not be displayed.

> biexample=biCkaksAA(example02,example)
> result=biCompare(biexample)

> plot(result)

8

lllllT12PK14RL19II15VT12EReferences

[1] Hurst, L. D. The Ka/Ks ratio: diagnosing the form of sequence evolution. Trends

in genetics: TIG 18, 486 (2002).

[2] Chen, L., Perlina, A., Lee, C. J. Positive selection detection in 40,000 human
immunodeﬁciency virus (HIV) type 1 sequences automatically identiﬁes drug re-
sistance and positive ﬁtness mutations in HIV protease and reverse transcriptase.
Journal of virology 78, 3722-3732 (2004).

[3] Cover, T. M., Thomas, J. A., Wiley, J. Elements of information theory. 6, (Wiley

Online Library: 1991).

9

T12EL33IM46IG48VL63AL63QL63SA71VV82AI85VL89ML90MC95FK14RS37AL38FE65DH69NK20IL24IV32IE34QK43TK45RM46LI47VF53LI54VQ58EK70TG73SG73TT74SL76VV82TI84VT12EL33IM46IG48VL63AL63QL63SA71VV82AI85VL89ML90MC95FK14RS37AL38FE65DH69NK20IL24IV32IE34QK43TK45RM46LI47VF53LI54VQ58EK70TG73SG73TT74SL76VV82TI84V