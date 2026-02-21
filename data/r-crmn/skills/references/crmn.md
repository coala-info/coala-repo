The crmn Package

Henning Redestig
henning@psc.riken.jp
RIKEN Plant Science Center
Yokohama, Japan
http://www.metabolome.jp/

February 10, 2020

Overview

CRMN (Cross-contribution Robust Multiple standard Normalization) is a nor-
malization method that can be used to normalize data that has been generated
using internal standards (ISs). It is mainly intended (but not restricted) to nor-
malize GC-MS metabolomics data. An IS is a chemical compound that is added
to the sample in a known concentration and can be used to remove bias that
arise from technical variation. Unfortunately, sometimes analytes may directly
cause variation in these standards thereby rendering them diﬃcult to use for
normalization purposes.

CRMN attempts to solve this issue by correcting the ISs for covariance with
In short, this

the experimental design before using them for normalization.
achieved by the following algorithm:

1. Pre-process data by log-transforming and z-transformation.

2. Divide data into analytes, YA, and standards, YS.

3. Remove the correlation between experimental design matrix, G and the

YS using linear regression.

4. Perform PCA on the residual of the regression model between YS and G

to extract the systematic error, TZ.

5. Remove correlation between YA and TZ using linear regression.

6. Undo pre-processing steps.

Please see Redestig et al. [1] further description.

1 Normalization methods

The package comes with access to several diﬀerent normalization methods to
use as reference or alternative to the CRMN method. These are:

1

NOMIS The method proposed by Sysi-Aho et al.

[2]. Note that this imple-
mentation was not done by the authors of the NOMIS method and any
errors should be blamed on author of this package.

One Divide each analyte by the abundance estimate of a single user-deﬁned IS.

Also known as Single.

RI Divide each analyte by the abundance estimate of the IS that is closest in

terms of its retention index.

totL2 Does not use internal standards, normalization is done by ensuring that

the square sum of each sample is the same.

Median/Avg Does not use internal standards, normalization is done by en-

suring that the median/average of each sample equals one.

2 Getting started

Installing the package: For Windows, start R and select the Packages menu,
then Install package from local zip file. Find and highlight the location
of the zip ﬁle and click on open.

For Linux/Unix, use the usual command R CMD INSTALL or use the com-

mand install.packages from within an R session.

Loading the package: To load the crmn package in your R session, type
library(crmn):

> library(crmn)
> help(package="crmn")

Help ﬁles: Detailed information on crmn package functions can be obtained
from the help ﬁles. For example, to get a description of the normalization
function normalize type help("normalize").

Sample data: A sample data set is included under the name mix. This data
has 46 analytes of which 11 are internal standards. There are 42 samples con-
taining known compositions of the measured analytes (see Redestig et al. (Un-
published)). The samples were measured in three diﬀerent batches as indicated
in the phenotypical data.

3 Examples

3.1 Input data

There are two slightly diﬀerent ﬂavors for how the data can be provided to
the normalization functions. One way is to use the ExpressionSet object type
as deﬁned by the Biobase package. This is convenient because object type
holds both information about the samples (columns) and the analytes (rows) of
the data matrix and gives programmatically useful ways to access the diﬀerent
types of data. To use this way you must ﬁrst format your data to such an

2

object, please read the documentation from Biobase on how to do this. The
ExpressionSet-object must contain information about which features are the
internal standards coded by a tag (or another column name but then you have
to specify the “where” argument to analytes and standards) component which
should be equal "IS" (or something else which you have to specify via the what
argument) for the standards. To use the RI method the feature data must also
contain the retention index of each analyte. See the dataset mix for an example.
Alternatively you can provide the data as a simple matrix (as for example
read by the read.table function). In that case you must make sure to always
pass the extra argument standards which is a logical vector indicating which
rows are the internal standards. You must also specify the design matrix to the
experiment yourself. This is of course an option when using an ExpressionSet
as well.

3.2 Normalization of a ExpressionSet

> data(mix)
> head(fData(mix))[,1:4]

mark tag

15 Marked
18 Marked
47 Marked
51 Marked
52 Marked
56 Marked

synonym

RI
I Glycolic acid (2TMS) 1066.5
Alanine, DL- (2TMS) 1097.3
I
I Nicotinic acid (1TMS) 1298.5
Fumaric acid (2TMS) 1340.6
I
I
Serine, DL- (3TMS) 1348.3
I Threonine, DL- (3TMS) 1373.1

> head(pData(mix))

STDs_1_2_1 STDs_1
STDs_1_2_2 STDs_1
STDs_1_2_3 STDs_1
STDs_1_3_1 STDs_1
STDs_1_3_2 STDs_1
STDs_1_3_3 STDs_1

type experiment runorder
3
3
3
3
3
3

uv
uv
uv
uv
uv
uv

Division of the dataset should now be possible as following.

> Ys <- standards(mix)
> Ya <- analytes(mix)
> dim(Ys)

Features Samples
42

11

> dim(Ya)

Features Samples
42

35

3

These two functions must work as they should for your data too (if you want
to the the ExpressionSet interface, otherwise see Section ??) so make sure that
they do.

To proceed with normalization we ﬁrst ﬁt a normalization model. The com-
plexity, number of principal components, is decided by the cross-validation func-
tionality of the pcaMethods package. To use CRMN we also need access to the
experimental design. This can be done automatically by specifying the relevant
factors in the pData object of the data or by directly providing a design matrix.
I.e:

> nfit <- normFit(mix, "crmn", factor="type", ncomp=2)

Is the same as doing:

> G <- model.matrix(~-1+mix$type)
> nfit <- normFit(mix, "crmn", factor=G, ncomp=2)

We proceed by not specifying the complexity but letting the cross-validation

take care of this step.

> nfit <- normFit(mix, "crmn", factor="type")
> #complexty (number of PC
> sFit(nfit)$ncomp

s):

’

PC 1
1

The variance that CRMN identiﬁed as systematic error can be visualized

using slplot, see Figure 1.

> slplot(sFit(nfit)$fit$pc, scol=as.integer(mix$runorder))

Figure 1: PCA of the systematic error TZ. Colors correspond to the known
batches.

The output from normFit is an object of class nFit and has a simple plot
and print/show function which can give basic statistics about the normalization
model, see Figure 2

To normalize the data we predict the training data. Note that we could also
have held some samples out from the training to obtain sample-independent
normalization (potentially useful for quality control purposes).

4

−20246−1.0−0.50.00.5Scores96.37% of the variance explainedPC 1PC 2STDs_1_2_1STDs_1_2_2STDs_1_2_3STDs_1_3_1STDs_1_3_2STDs_1_3_3STDs_2_1_1STDs_2_1_2STDs_2_1_3STDs_2_2_1STDs_2_2_2STDs_2_2_3STDs_2_3_1STDs_2_3_2STDs_2_3_3STDs_3_1_1STDs_3_1_2STDs_3_1_3STDs_3_2_1STDs_3_2_2STDs_3_2_3STDs_3_3_1STDs_3_3_2STDs_3_3_3STDs1_1_1STDs1_2_1STDs1_3_1STDs2_1_1STDs2_2_1STDs2_3_1STDs3_1_1STDs3_2_1STDs3_3_1STDs1_1_11STDs1_2_11STDs1_3_11STDs2_1_11STDs2_2_11STDs2_3_11STDs3_1_11STDs3_2_11STDs3_3_11−0.3−0.10.10.20.3−0.6−0.20.20.6LoadingsPC 1PC 2238239240241242243244245246247248> nfit

crmn normalization model
========================
Effect of experiment design on standards:
-----------------------------------------
Analysis of Variance Table

Df Pillai approx F num Df den Df Pr(>F)

3 1.1339

I(X)
Residuals 39
---
Signif. codes: 0 ^a˘A¨Y***^a˘A´Z 0.001 ^a˘A¨Y**^a˘A´Z 0.01 ^a˘A¨Y*^a˘A´Z 0.05 ^a˘A¨Y.^a˘A´Z 0.1 ^a˘A¨Y ^a˘A´Z 1

93 0.02344 *

1.7123

33

Captured Tz:
--------------
svd calculated PCA
Importance of component(s):
PC2

PC1

PC8
R2
0.934 0.02973 0.01409 0.00784 0.00732 0.00344 0.00171 0.0010
Cumulative R2 0.934 0.96369 0.97778 0.98562 0.99294 0.99638 0.99809 0.9991

PC4

PC6

PC3

PC5

PC7

PC10
R2
0.00053 0.0003
Cumulative R2 0.99962 0.9999

PC9

PC8
0.93396 0.02973 0.01409 0.00784 0.00732 0.00344 0.00171 0.00100
R2
Cumulative R2 0.93396 0.96369 0.97778 0.98562 0.99294 0.99638 0.99809 0.99909

PC1

PC7

PC6

PC5

PC4

PC3

PC2

PC10
R2
0.00053 0.00030
Cumulative R2 0.99962 0.99992

PC9

R2 from Tz to analytes:
-----------------------
[1] 0.6472936

> plot(nfit)

Figure 2: Basic plot function.

> normed.crmn <- normPred(nfit, mix, factor="type")

5

PC 1PC 2PC 3PC 4PC 5PC 6PC 7PC 8Tz  optimization0.00.20.40.60.81.0R2Q2llllllllllllllllllllllllllllllllllllllllll−20246−1.0−0.50.00.5Tz1Tz2lllllllllll−0.3−0.2−0.10.00.10.20.3−0.6−0.4−0.20.00.20.40.6Pz1Pz2We can compare the result with other methods. Now we do this using the
wrapper function normalize that combines normFit and normPred. See side-
by-side PCA score plots of CRMN normalized data versus One and NOMIS
normalized data in Figure 3.

> normed.one <- normalize(mix, "one", one="Hexadecanoate_13C4")
> normed.nomis <- normalize(mix, "nomis")

pch=as.integer(mix$runorder),
main="Single IS")

> pca.crmn <- pca(scale(log(t(exprs(normed.crmn)))))
> pca.one <- pca(scale(log(t(exprs(normed.one)))))
> pca.nomis <- pca(scale(log(t(exprs(normed.nomis)))))
> par(mfrow=c(1,3))
> plot(scores(pca.one), col=as.integer(mix$type),
+
+
> plot(scores(pca.nomis), col=as.integer(mix$type),
+
+
> plot(scores(pca.crmn), col=as.integer(mix$type),
+
+
>

pch=as.integer(mix$runorder),
main="NOMIS")

pch=as.integer(mix$runorder),
main="CRMN")

Figure 3: PCA of the mix using three diﬀerent normalizations. Colors indicate
the true concentration groups and plot character indicate the diﬀerent batches
(unwanted eﬀect).

6

lllllllll0510−2−10123Single ISPC1PC2lllllllll−6−4−202468−6−4−2024NOMISPC1PC2lllllllll−4−2024−4−20246CRMNPC1PC23.3 Normalization of a matrix

First we construct the required input parameters. This would of course normally
be done by using read.table to read data as obtained by programs such as
TargetSearch, HDA, metAlign etc.

> Y <- exprs(mix)
> replicates <- factor(mix$type)
> G <- model.matrix(~-1+replicates)
> isIS <- fData(mix)$tag ==

IS

’

’

Division of the dataset should now be possible as following (results hidden).

> standards(Y, isIS)
> analytes(Y, isIS)

The main business is the same as when normalizing an ExpressionSet ex-
cept that we now have to remember to pass the vector speciying the standards.

> nfit <- normFit(Y, "crmn", factors=G, ncomp=2, standards=isIS)

To normalize the data predict the training data.

> normed.crmn <- normPred(nfit, Y, factors=G, standards=isIS, ncomp=2)

and this could also have been done directly by:

> normed.crmn <- normalize(Y, "crmn", factors=G, standards=isIS, ncomp=2)

7

References

[1] Redestig, H., Fukushima, A., H., Stenlud, Moritz, T., Arita,
M., Saito, K. and Kusano, M. Compensation for systematic
cross-contribution improves normalization of mass spectrome-
try based metabolomics data Anal Chem, 2009, 81, 7974-7980

[2] Sysi-Aho, M., Katajamaa, M., Yetukuri, L. and Oresic, M
Normalization method for metabolomics data using optimal
selection of multiple internal standards BMC Bioinformatics,
2007, 8, 93

8

