prot2D : Statistical Tools for volume data from 2D
Gel Electrophoresis

S´ebastien Artigaud *

October 30, 2017

Contents

1 Introduction

2 Input data for prot2D

3 Getting started

4 prot2D workﬂow

4.1 Vizualize and Normalize volume data . . . . . . . . . . . . . . . .
4.2 Coerce data into an ExpressionSet . . . . . . . . . . . . . . . . .
4.3 Find diﬀerentially expressed proteins . . . . . . . . . . . . . . . .

5 Simulation of 2D Volume data

6 Session Info

7 References

1 Introduction

1

2

2

2
2
3
4

5

7

8

This document brieﬂy describes how to use the prot2D package. An R package
designed to analyze (i.e. Normalize and select signiﬁcant spots) data issued from
2D SDS PAGE experiments. prot2D provides a simple interface for analysing
data from 2D gel experiments. Functions for normalization as well as selecting
signiﬁcant spots are provided. Furthermore, a function to simulates realistic 2D
Gel volume data is also provided.If you use this package please cite :

(cid:136) Artigaud, S., Gauthier, O. & Pichereau, V. (2013) ”Identifying diﬀeren-
tially expressed proteins in two-dimensional electrophoresis experiments:
inputs from transcriptomics statistical tools.” Bioinformatics, vol.29 (21):
2729-2734.

*Laboratoire des Sciences de l’Environnement Marin, LEMAR UMR 6539, Universit´e de

Bretagne Occidentale, Institut Universitaire Europ´een de la Mer, 29280 Plouzan´e, France

1

Table 1: Example of input data for prot2D with 3 replicates gels in each condition

Replicates Condition 1 Replicates Condition 2
Gel1(cid:48) Gel2(cid:48) Gel3(cid:48)
Gel1 Gel2
X1(cid:48),1 X2(cid:48),1 X3(cid:48),1
Spot1 X1,1 X2,1
X1(cid:48),2 X2(cid:48),2 X3(cid:48),2
Spot2 X1,2 X2,2
Spoti X1,i X2,i
X3(cid:48),i
X1(cid:48),i X2(cid:48),i

Gel3
X3,1
X3,2
X3,i

2 Input data for prot2D

prot2D uses raw 2D volume data intensities as input, datasets must be
exported from specialized Image Software in the form of a dataframe of
volume data Xj,i with gels j as columns and spots i as rows. Note that
the name of columns should therefore corresponds to the names of the
gels and the names of the rows to the name of the spots. The replicates
for each condition should be ordered in the following columns (see Table
1). Furthermore, another dataframe is needed to describe the experiment
with the names of gels as rownames and a single column giving the two
level of condition for data.

3 Getting started

To load the prot2D package into your R envirnoment type:

> library(prot2D)

In this tutorial we will be using the pecten dataset obtained from a 2-
DE experiment performed on proteins from the gills of Pecten maximus
subjected to a temperature challenge. 766 spots were identiﬁed with 6
replicates per condition, therefore the dataset is a dataframe of 766 rows
and 12 columns (for details, see Artigaud et al., 2013). pecten.fac de-
scribe the data by giving the names of the gels (as rownames) and the
condition for the temperature challenge (15C = control vs 25C) in the
”Condition” column, load by typing:

> data(pecten)
> data(pecten.fac)

4 prot2D workﬂow

4.1 Vizualize and Normalize volume data

Vizualization

Dudoit et al. (2002) proposed a method for the visualization of artifacts
in microarray datasets, called the MA-plot, which was transposed for pro-
teomics data as the Ratio-Intensity plot (Meunier et al., 2005; R-I plot).

2

It consists in plotting the intensity log2-ratio (R) against mean log10 in-
tensity (I):

R = log2

mean(VCond2)
mean(VCond1)

(1)

The intensity (I) is the log10 of the mean of volume data in condition 2
by the mean of volume data in condition 1 :

I = log10(mean(VCond2) × mean(VCond1))

(2)

Where VCond1 and VCond2 are spot volumes for conditions 1 and 2, respec-
tively. In prot2D, R-I plot can be easily displayed with RIplot:

> RIplot(pecten, n1=6, n2=6)

RIplot requires data supplied as a dataframe or a matrix as well as the
number of replicates for each conditions.

Normalization

2D Gel Volume data must be normalized in order to remove systemic vari-
ation prior to data analysis. Two widely used methods are provided, the
”Variance Stabilizing Normalization” (vsn) and the ”Quantiles, Normaliza-
tion”. The principle of the ”quantiles normalization” is to set each quantile
of each column (i.e. the spots volume data of each gels) to the mean of that
quantile across gels. The intention is to make all the normalized columns
have the same empirical distribution. Whereas the vsn methods relies on
a transformation h, of the parametric form h(x)= arsinh(a+bx) (Huber
et al., 2002). The parameters of h together with those of the calibration
between experiments are estimated with a robust variant of maximum-
likelihood estimation. Both methods recentered the data around a zero
log ratio, nevertheless for low values of intensities the vsn normalized data
seems to be less eﬃcient in order to recentered the cloud of points. Users
are thus advised to use the quantiles normalization via a call to Norm.qt.

> pecten.norm <- Norm.qt(pecten, n1=6, n2=6, plot=TRUE)

>

4.2 Coerce data into an ExpressionSet

Prior to analysis for ﬁnding diﬀerentially expressed proteins, data must be
coerced into an ExpressionSet. This can be done easily with ES.prot,
which requires a matrix of normalized volume data, the number of repli-
cates in each condition and a dataframe giving the condition for the ex-
periment.

> ES.p <- ES.prot(pecten.norm, n1=6, n2=6, f=pecten.fac)

The matrix of spots intensities (i.e. Volume) is log2 transformed and
stored in the assayData slot of the ExpressionSet. Furthermore, the
log2-ratio is computed and stored in the featureData slot.

3

Figure 1: Ratio-Intensity plot showing Quantiles normalization

4.3 Find diﬀerentially expressed proteins

As described in Artigaud et al (2013) prot2D provide functions adapted
from microarray analysis (from the st, samr, limma, fdrtool package). 2-
DE experiments analysis require a variant of the t-statistic that is suitable
for high-dimensional data and large-scale multiple testing. For this pur-
pose, in the last few years, various test procedures have been suggested.
prot2D provides:

– the classical Student’s t-test (in ttest.Prot function)

– two tests especially modiﬁed for micro-array analysis : Efron’s t-
test (2001; efronT.Prot function) and the modiﬁed t-test used in
Signiﬁcance Analysis for Microarray (Tusher et al, 2001; samT.Prot
function).

– two methods that take advantage of hierarchical Bayes methods for
estimation of the variance across genes: the ”moderate t-test” from
Smyth (2004; modT.Prot function) and the ”Shrinkage t” statistic test
from Opgen-Rhein and Strimmer (2007; shrinkT.Prot function).

As statistical tests allowing the identiﬁcation of diﬀerentially expressed
proteins must take into account a correction for multiple tests in order to
avoid false conclusions. prot2D also provide diﬀerent methods to estimate
the False Discovery Rate :

– the classical FDR estimator of Benjamini and Hochberg (1995).

4

– the local FDR estimator of Strimmer (2008).
– the ”robust FDR” estimator of Pounds and Cheng (2006).

ttest.Prot function, modT.Prot function, samT.Prot function, efronT.Prot
function or shrinkT.Prot function can be used to ﬁnd diﬀerentially ex-
pressed proteins and the diﬀerent FDR mode of calculation are imple-
mented with the method.fdr argument. However, the moderate t-test
with the FDR correction of Benjamini and Hochberg was ﬁnd to be the
best combination in terms of sensitivity and speciﬁcity. Thus, users are
advised to use this combination by typing :

> ES.diff <- modT.Prot(ES.p, plot=TRUE, fdr.thr=0.1,
+

method.fdr="BH" )

Number of up-regulated spots in Condition 2
[1] 0
Number of down-regulated spots in Condition 2
[1] 1

The function returns an ExpressionSet containing only the spots declared
as signiﬁcant. A plot can also be generated to vizualize the FDR cut-oﬀ.
Additionally, it can be usefull to select only the spots with an absolute
ratio greater than 2, as they are often considered as the most biologically
relevant proteins, this can be done by adding the command Fold2=T. The
names of the selected spots can be retrieved with :

> featureNames(ES.diff)

[1] "2607"

Displaying fold change (as log2(ratio)) for selected spots

> head(fData(ES.diff))

ratio
2607 -1.912657

Volume normalized data for selected spots

> head(exprs(ES.diff))

Br_23865 Br_23883 Br_23884 Br_23728 Br_23729 Br_23730 Br_23731 Br_23732
23.454 20.22889 22.34141 23.07774 23.0274 22.63096 20.07119

2607 23.21036

Br_23733 Br_23875 Br_23876 Br_23877
2607 21.07323 20.52232 20.02905 19.53711

5 Simulation of 2D Volume data

In order to compare FDR and the responses of the diﬀerent tests as well
as the inﬂuence of the number of replicates, simulated data ca be used.
Sim.Prot.2D simulates realistic 2D Gel volume data, based on parameters
estimate from real dataset. Volume data are computed following these
steps (see Smyth, 2004 and Artigaud et al., 2013 for details) :

5

– Log2 mean volumes from data are computed for each spot.

– Means are used as input parameters in order to simulate a normal
distribution (with no diﬀerential expression between conditions) for
each spot with standard deviations computed as described by Smyth
(2004).

– A deﬁne proportion p0 of the spots are randomly picked for introduc-
ing diﬀerential expression in both conditions (p0/2 in each condition).

The Sim.Prot.2D returns an ExpressionSet of simulated volume data
(log2 transformed) with 2 conditions (”Cond1” and ”Cond2” in pheno-
Data) slot of the ExpressionSet.The spots diﬀerentially generated can
be retrieve with notes. Simulate data based on ”pecten”

> Sim.data <- Sim.Prot.2D(data=pecten, nsp=700,
+

nr=10, p0=0.1, s2_0=0.2, d0=3)

Compare diﬀerent methods for ﬁnding diﬀerentially expressed proteins

> res.stud <- ttest.Prot(Sim.data, fdr.thr=0.1, plot=FALSE)

Number of up-regulated spots in Condition 2
[1] 23
Number of down-regulated spots in Condition 2
[1] 25

> res.mo <- modT.Prot(Sim.data, fdr.thr=0.1, plot=FALSE)

Number of up-regulated spots in Condition 2
[1] 34
Number of down-regulated spots in Condition 2
[1] 26

Names of the spots selected by student’s t-test with an FDR of 0.1

> featureNames(res.stud)

[1] "14" "17" "30" "36" "37" "52" "54" "69" "70" "122" "129" "130"
[13] "150" "153" "158" "163" "173" "186" "213" "225" "236" "239" "249" "250"
[25] "253" "258" "269" "304" "307" "308" "313" "358" "380" "433" "444" "447"
[37] "457" "494" "502" "543" "554" "564" "575" "579" "621" "639" "659" "676"

Names of the spots selected by modT-test with an FDR of 0.1

> featureNames(res.mo)

[1] "10" "14" "27" "30" "36" "37" "44" "51" "52" "54" "69" "70"
[13] "92" "120" "121" "122" "129" "130" "150" "154" "158" "163" "166" "167"
[25] "173" "186" "225" "236" "252" "253" "257" "279" "284" "302" "304" "308"
[37] "313" "334" "358" "380" "401" "417" "429" "433" "444" "457" "494" "502"
[49] "543" "554" "564" "575" "579" "602" "621" "639" "659" "662" "676" "677"

Names of the diﬀerentially generated spots

6

> notes(Sim.data)$SpotSig

[1] "14" "30" "54" "88" "120" "121" "129" "130" "154" "173" "186" "225"
[13] "236" "252" "253" "263" "300" "313" "334" "380" "433" "460" "463" "543"
[25] "575" "602" "610" "621" "644" "676" "10" "27" "36" "37" "51" "52"
[37] "62" "69" "70" "92" "119" "150" "158" "163" "164" "257" "272" "279"
[49] "284" "304" "308" "358" "398" "401" "417" "444" "457" "460" "494" "502"
[61] "554" "564" "579" "610" "659" "662" "677"

6 Session Info

> sessionInfo()

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] grid
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:

[1] prot2D_1.16.0
[4] Mulcom_1.28.0
[7] spam_2.1-1

MASS_7.3-47
maps_3.2.0
limma_3.34.0

qvalue_2.10.0
fields_9.0
dotCall64_0.9-04
BiocGenerics_0.24.0 samr_2.0
st_1.2.5
entropy_1.2.1

[10] Biobase_2.38.0
[13] matrixStats_0.52.2 impute_1.52.0
[16] sda_1.3.7
corpcor_1.6.9
[19] fdrtool_1.2.15

loaded via a namespace (and not attached):

[1] Rcpp_0.12.13
[5] munsell_0.4.3
[9] plyr_1.8.4
[13] tibble_1.3.4
[17] compiler_3.4.2

splines_3.4.2

magrittr_1.5
colorspace_1.3-2 rlang_0.1.2
tools_3.4.2
reshape2_1.4.2
scales_0.5.0

gtable_0.2.0
ggplot2_2.2.1

statmod_1.4.30
stringr_1.2.0
lazyeval_0.2.1
stringi_1.1.5

7

7 References

Artigaud, S., Gauthier, O. & Pichereau, V. (2013) ”Identifying diﬀeren-
tially expressed proteins in two-dimensional electrophoresis experiments:
inputs from transcriptomics statistical tools.” Bioinformatics, vol.29 (21):
2729-2734.

Benjamini, Y. & Hochberg, Y. (1995) ”Controlling the false discovery rate:
a practical and powerful approach to multiple testing” Journal of the Royal
Statistical Society. Series B. Methodological.: 289-300.

Dudoit, S., Yang, Y.H., Callow, M.J., & Speed, T.P. (2002) ”Statistical
methods for identifying diﬀerentially expressed genes in replicated cDNA
microarray experiments” Statistica Sinica, vol. 12: 111-139.

Efron, B., Tibshirani, R., Storey, J.D., & Tusher, V. (2001) ”Empirical
Bayes Analysis of a Microarray Experiment” Journal of the American Sta-
tistical Association, vol. 96 (456): 1151-1160.

Huber, W., Heydebreck, von, A., Sultmann, H., Poustka, A., & Vingron,
M. (2002) ”Variance stabilization applied to microarray data calibration
and to the quantiﬁcation of diﬀerential expression” Bioinformatics, vol. 18
(Suppl 1): S96-S104.

Meunier, B., Bouley, J., Piec, I., Bernard, C., Picard, B., & Hocquette,
J.-F. (2005) ”Data analysis methods for detection of diﬀerential protein ex-
pression in two-dimensional gel electrophoresis” Analytical Biochemistry,
vol. 340 (2): 226-230.

Opgen-Rhein, R. & Strimmer, K. (2007) ”Accurate Ranking of Diﬀeren-
tially Expressed Genes by a Distribution-Free Shrinkage Approach” Sta-
tistical Applications in Genetics and Molecular Biology, vol. 6 (1).

Pounds, S. & Cheng, C. (2006) ”Robust estimation of the false discovery
rate” Bioinformatics, vol. 22 (16): 1979-1987.

Smyth, G.K. (2004) ”Linear models and empirical bayes methods for as-
sessing diﬀerential expression in microarray experiments.” Statistical Ap-
plications in Genetics and Molecular Biology, vol. 3: Article3.

Strimmer, K. (2008) ”A uniﬁed approach to false discovery rate estima-
tion.” BMC Bioinformatics, vol. 9: 303.

Tusher, V.G., Tibshirani, R., & Chu, G. (2001) ”Signiﬁcance analysis of
microarrays applied to the ionizing radiation response” Proceedings of the
National Academy of Sciences of the United States of America, vol. 98
(9): 5116-5121.

8

