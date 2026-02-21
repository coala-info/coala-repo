The NanoStringDiff package

Hong Wang1, Chi Wang2,3∗

1Department of Statistics , University of Kentucky,Lexington, KY;

2Markey Cancer Center, University of Kentucky, Lexington, KY ;

3Department of Biostatistics, University of Kentucky, Lexington, KY;

hong.wang@uky.edu

October 30, 2025

Abstract

This vignette introduces the use of the Bioconductor package NanoStringDiff, which is de-

signed for differential analysis based on NanoString nCouner Data. NanoStringDiff considers a

generalized linear model of the negative binomial family to characterize count data and allows for

multi-factor design. Data normalization is incorporated in the model framework by including data

normalization parameters estimated from positive controls, negative controls and housekeeping

genes embedded in the nCounter system. Present method propose an empirical Bayes shrinkage

approach to estimate the dispersion parameter and a likelihood ratio test to identify differential

expression genes.

∗to whom correspondence should be addressed

1

The NanoStringDiff package

Contents

1 Citation

2 Quick Start

3 Data Input

3.1 Create NanoStringSet from csv.file

. . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.2 Create NanoStringSet from matrix

. . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Differential Expression Analysis for Single Factor Experiment

4.1 Two Group Comparisons . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

3

4
4

6

8
8

4.2 Pairwise Comparisons

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10

4.3 Multigroup Comparisons . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14

5 Differential Expression Analysis for Multifactor Experiment

14
5.1 Nested Interactions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14

5.2 All Interactions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15

6 Session Info

16

The NanoStringDiff package

1 Citation

3

The package NanoStringDiff implements statistical methods from the following publication.

If you

use NanoStringDiff in the published research, please cite:

Hong Wang, Craig Horbinski, Hao Wu, Yinxing Liu,Arnold J. Stromberg and Chi Wang: A Negative

Binomial Model-Based Method for Differential Expression Analysis Based on NanoString nCounter

Data.(Manuscript)

2 Quick Start

This section show the most basic steps for a differential expression analysis for NanoString nCounter

Data:

1. Create a NanoStringSet object using createNanoStingSet or createNanoStringSetFromCsv

(see examples in the Data Input section). In this section we use NanoStringData directly, which

is an object of NanoStringSet contained in the package.

2. Make a design matrix to describe treatment conditions.

3. Estimate norlamization factors including positive size factors, housekeeping size factors and back-

ground noise using estNormalizationFactors

4. Perform a likelihood ratio test using glm.LRT.

> library("Biobase")

> library("NanoStringDiff")

> data(NanoStringData)

> pheno=pData(NanoStringData)

> design.full=model.matrix(~0+pheno$group)

> NanoStringData=estNormalizationFactors(NanoStringData)

> result=glm.LRT(NanoStringData,design.full,contrast=c(1,-1))

Here, the data NanoStringData contained in the package is an animal data, we called MoriData[1].

Mori et al tried to study the possible reasons responsible for the widespread miRNA repression observed

in cancer, global microRNA expression in mouse liver normal tissues and liver tumors induced by deletion

of Nf2 (merlin) profiled by nCounter Mouse miRNA Expression Assays. Expressions of 599 miRNAs

were profiled for two replicates in each group.

The NanoStringDiff package

3 Data Input

4

NanoStringDiff works on matrix of integer read counts from NanoString nCounter analyzer with endo-

genes, positive control genes, negative control genes and housekeeping control genes. For the matrix,

rows corresponding to genes and columns to independent samples or replicates. The counts represent

the total number of reads aligning to each gene (or other genomic locus).

The count values must be raw counts of NanoString nCounter data, since data normalization is incor-

porated in the model framework by including data normalization parameters estimated from positive

controls, negative controls and housekeeping genes using function estNormalizationFactors. Hence,

please do not supply normalized counts.

There must be have six positive control genes order by different concentrations from high to low, since

NanoString nCounter analyzer provide six different samll positive controls with six different concen-

trations in the 30 uL hybridization: 128 fM, 32 fM, 8 fM, 2 fM, 0.5 fM, and 0.125 fM. No such

restriction for negative control genes and housekeeping control genes.Nanostring recommends at least

three housekeeping genes, but the more that are included, the more accurate the normalization will be.

3.1 Create NanoStringSet from csv.file

The data produced by the nCounter Digital Analyzer are exported as a Reporter Code Count (RCC)

file. RCC files are comma-separated text(.csv) files that contain the counts for each gene in a sample

and the data for each sample hybridization are contained in a separate RCC file. So before you call

createNanoStringSetFromCsv to creat a NanoStringSet object, you should create a csv.file to

combine all interesting samples together, and the first three columns shoud be "CodeClass", "Name"
ane "Accession", the counts data contained from the 4th column to the last column.

Note:

1. The 1st column "CodeClass" should specify the function of genes as "Positive", "Negative","Housekeeping"

or "Endogenous".

2. Some data set have "Spikein" genes, you need delete these "spikein" genes or you could just

leave there if you use createNanoStringSetFromCsv to creat NanoStringSet object(See ex-

ample in the Data Input section). But NanoStringDiff only works with "positive", "negative",

housekeeping" and "endogenous".

The "csv.file" should looks like as following Figure:

When you created a csv.file, you will specify a variable which points on the directory in which your

The NanoStringDiff package

5

Figure 1: Example of csv.file pattern

csv.file is located

> directory <- "/path/to/your/files/"

However, for demonstration purposes only, the following line of code points to the directory for the

"Mori.csv" in the NanoStringDiff package.

> directory <- system.file("extdata", package="NanoStringDiff", mustWork=TRUE)

> path<-paste(directory,"Mori.csv",sep="/")

The phenotype informations of the data should be stored as data frame.

> designs=data.frame(group=c("Normal","Normal","Tumor","Tumor"))

> designs

group

1 Normal

2 Normal

3

Tumor

The NanoStringDiff package

4

Tumor

> library("NanoStringDiff")

6

> NanoStringData=createNanoStringSetFromCsv(path,header=TRUE,designs)

There are 4 samples imported;

There are

618 genes imported with:code.class

endogenous1 endogenous2 housekeeping

negative

positive

spikein

566

33

4

6

6

3

> NanoStringData

NanoStringSet (storageMode: lockedEnvironment)

assayData: 599 features, 4 samples

element names: exprs

protocolData: none

phenoData

sampleNames: Normal.1 Normal.2 Tumor.1 Tumor.2

varLabels: group

varMetadata: labelDescription

featureData: none

experimentData: use 'experimentData(object)'

Annotation:

3.2 Create NanoStringSet from matrix

If you already read your positive control genes, negative control genes, housekeeping control genes and

endogous into R session separately and stored as matrix, then you can use createNanoStringSet to

create a NanoStringSet object.

> endogenous=matrix(rpois(100,50),25,4)

> colnames(endogenous)=paste("Sample",1:4)

> positive=matrix(rpois(24,c(128,32,8,2,0.5,0.125)*80),6,4)

> colnames(positive)=paste("Sample",1:4)

> negative=matrix(rpois(32,10),8,4)

> colnames(negative)=paste("Sample",1:4)

> housekeeping=matrix(rpois(12,100),3,4)

> colnames(housekeeping)=paste("Sample",1:4)

The NanoStringDiff package

7

> designs=data.frame(group=c("Control","Control","Treatment","Treatment"),

+

+

gender=c("Male","Female","Female","Male"),

age=c(20,40,39,37))

> NanoStringData1=createNanoStringSet(endogenous,positive,

+

> NanoStringData1

negative,housekeeping,designs)

NanoStringSet (storageMode: lockedEnvironment)

assayData: 25 features, 4 samples

element names: exprs

protocolData: none

phenoData

sampleNames: Sample 1 Sample 2 Sample 3 Sample 4

varLabels: group gender age

varMetadata: labelDescription

featureData: none

experimentData: use 'experimentData(object)'

Annotation:

> pData(NanoStringData1)

group gender age

Sample 1

Control

Male

Sample 2

Control Female

Sample 3 Treatment Female

Sample 4 Treatment

Male

20

40

39

37

> head(exprs(NanoStringData1))

Sample 1 Sample 2 Sample 3 Sample 4

1

2

3

4

5

6

51

48

48

41

50

59

51

57

53

49

49

56

56

62

48

57

61

49

56

52

60

54

43

62

The NanoStringDiff package

8

4 Differential Expression Analysis for Single Factor Experi-

ment

For general experiments, once normalization factors obtained using estNormalizationFactors, given

a design matrix and contrast, we can proceed with testing procedures for determing differential ex-

pression using the generalized linear model (GLM) likelihood ratio test. The testing can be done by

using the function glm.LRT and return a list with a component is table including: logFC ,lr, pvalue and

qvalue(adjust p value using the procedure of Benjamini and Hochberg).

4.1 Two Group Comparisons

The simplest and most common type of experimental design is two group comparison,like treatment

group vs control group. As a brief example, consider a simple situation with control group and treatment

group, each with two replicates, and the researcher wants to make comparisons between them. Here,

we still use NanoSreingData1 we created above to demonstrate this example.

Make design matrix using model.matrix:

> pheno=pData(NanoStringData1)

> group=pheno$group

> design.full=model.matrix(~0+group)

> design.full

groupControl groupTreatment

0

0

1

1

1

2

3

4

1

1

0

0

attr(,"assign")

[1] 1 1

attr(,"contrasts")

attr(,"contrasts")$group

[1] "contr.treatment"

Note that there is no intercept column in the dasign matrix, each column is for each group, since we

include 0+ in the model formula.

If the researcher want compare Treatment to Control, that is Treatment- Control, the contrast vector

The NanoStringDiff package

9

is try to the comparison -1*Control+1*Treatment, so the contrast is :

> contrast=c(-1,1)

Estimate normalization factors and return the same object with positiveFactor, negativeFactor and

housekeepingFactor slots filled or replaced:

> NanoStringData1=estNormalizationFactors(NanoStringData1)

> positiveFactor(NanoStringData1)

Sample 1

Sample 2

Sample 3

Sample 4

0.9914714 0.9951201 0.9985617 1.0148468

> negativeFactor(NanoStringData1)

Sample 1 Sample 2 Sample 3 Sample 4

9

10

8

10

> housekeepingFactor(NanoStringData1)

Sample 1

Sample 2

Sample 3

Sample 4

1.0030165 0.9334484 1.0871143 0.9691453

Generalize linear model likelihood ratio test:

> result=glm.LRT(NanoStringData1,design.full,contrast=contrast)

> head(result$table)

logFC

lr

pvalue

qvalue

1

2

0.07352544 0.078357710 0.7795355 0.9453376

0.05515012 0.045058169 0.8318971 0.9453376

3 -0.04157817 0.199317714 0.6552721 0.9400447

4

0.28659069 1.069277734 0.3011086 0.9380698

5 -0.02267247 0.003795015 0.9508784 0.9508784

6 -0.15237871 0.403437928 0.5253191 0.9380698

> str(result)

List of 11

$ table

:'data.frame':

25 obs. of

4 variables:

..$ logFC : num [1:25] 0.0735 0.0552 -0.0416 0.2866 -0.0227 ...

..$ lr

: num [1:25] 0.0784 0.0451 0.1993 1.0693 0.0038 ...

The NanoStringDiff package

10

..$ pvalue: num [1:25] 0.78 0.832 0.655 0.301 0.951 ...

..$ qvalue: num [1:25] 0.945 0.945 0.94 0.938 0.951 ...

$ dispersion

: num [1:25] 0.00624 0.00625 0.00619 0.00626 0.00619 ...

$ log.dispersion: num [1:25] -5.08 -5.08 -5.08 -5.07 -5.08 ...

$ design.full

: num [1:4, 1:2] 1 1 0 0 0 0 1 1

..- attr(*, "dimnames")=List of 2

.. ..$ : chr [1:4] "1" "2" "3" "4"

.. ..$ : chr [1:2] "groupControl" "groupTreatment"

..- attr(*, "assign")= int [1:2] 1 1

..- attr(*, "contrasts")=List of 1

.. ..$ group: chr "contr.treatment"

$ design.reduce : num [1:4, 1] 0.707 0.707 0.707 0.707

..- attr(*, "dimnames")=List of 2

.. ..$ : chr [1:4] "1" "2" "3" "4"

.. ..$ : NULL

$ Beta.full

: num [1:25, 1:2] 3.76 3.8 3.75 3.61 3.73 ...

$ mean.full

: num [1:25, 1:4] 43.1 44.6 42.6 36.8 41.5 ...

..- attr(*, "dimnames")=List of 2

.. ..$ : NULL

.. ..$ : chr [1:4] "1" "2" "3" "4"

$ Beta.reduce

: num [1:25] 3.79 3.82 3.71 3.71 3.71 ...

$ mean.reduce

: num [1:25, 1:4] 44.3 45.6 40.8 41.1 41 ...

$ m0

$ sigma

: num -9.49

: num 0.124

Note that the text Treatment compare to Control tells you that the estimates of logFC is log2(Treatment/Control).

4.2 Pairwise Comparisons

Now consider a researcher has three treatment groups say A, B and C, and researcher wants to compare

each groups like: B compare to A, C compare to A, and B compare to C.

First create an object of NanoStringSet with pseudo data:

> endogenous=matrix(rpois(300,50),25,12)

> colnames(endogenous)=paste("Sample", 1:12)

> colnames(endogenous)=paste("Sample",1:12)

The NanoStringDiff package

11

> positive=matrix(rpois(72,c(128,32,8,2,0.5,0.125)*80),6,12)

> negative=matrix(rpois(96,10),8,12)

> housekeeping=matrix(rpois(36,100),3,12)

> designs=data.frame(group=c(rep("A",4),rep("B",4),rep("C",4)),

+

+

gender=rep(c("Male","Male","Female","Female"),3),

age=c(20,40,39,37,29,47,23,45,34,65,35,64))

> NanoStringData2=createNanoStringSet(endogenous,positive,

+

> NanoStringData2

negative,housekeeping,designs)

NanoStringSet (storageMode: lockedEnvironment)

assayData: 25 features, 12 samples

element names: exprs

protocolData: none

phenoData

sampleNames: Sample 1 Sample 2 ... Sample 12 (12 total)

varLabels: group gender age

varMetadata: labelDescription

featureData: none

experimentData: use 'experimentData(object)'

Annotation:

> pData(NanoStringData2)

group gender age

Sample 1

Sample 2

Sample 3

Sample 4

Sample 5

Sample 6

Sample 7

Sample 8

Sample 9

Sample 10

A

A

Male

Male

A Female

A Female

B

B

Male

Male

B Female

B Female

Male

C

C

20

40

39

37

29

47

23

45

34

Male 65

Sample 11

C Female 35

The NanoStringDiff package

Sample 12

C Female 64

Make design matrix only consider one experimential factor group:

12

> pheno=pData(NanoStringData2)

> group=pheno$group

> design.full=model.matrix(~0+group)

> design.full

groupA groupB groupC

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

1

1

1

1

0

0

0

0

0

0

0

0

0

0

0

0

1

1

1

1

0

0

0

0

0

0

0

0

0

0

0

0

1

1

1

1

attr(,"assign")

[1] 1 1 1

attr(,"contrasts")

attr(,"contrasts")$group

[1] "contr.treatment"

Estimate normalization factors:

> NanoStringData2=estNormalizationFactors(NanoStringData2)

B compare to A, the contrast should be (-1,1,0)

> result=glm.LRT(NanoStringData2,design.full,contrast=c(-1,1,0))

C compare to A, the contrast should be (-1,0,1)

> result=glm.LRT(NanoStringData2,design.full,contrast=c(-1,0,1))

B compare to c, the contrast should be (0,1,-1)

The NanoStringDiff package

13

> result=glm.LRT(NanoStringData2,design.full,contrast=c(0,1,-1))

The other way to creat a design matrix in R is to include an intercept term to represents the base

level of the factor. We just omitte the 0+ in the model formula when we create design matrix using

model.matrix function:

> design.full=model.matrix(~group)

> design.full

(Intercept) groupB groupC

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

0

0

0

1

1

1

1

0

0

0

0

0

0

0

0

0

0

0

0

1

1

1

1

attr(,"assign")

[1] 0 1 1

attr(,"contrasts")

attr(,"contrasts")$group

[1] "contr.treatment"

In this sitution, the first coefficient measure the log scaler of baseline mean expression level in group A,

and the second and third column are now relative to the baseline, not represent the mean expression
level in group B and C. So, if we want to compare B to A, now that is equivalent to test the 2nd
coefficient equal to 0.

> result=glm.LRT(NanoStringData2,design.full,Beta=2)

Beta=3 means compare C to A:

> result=glm.LRT(NanoStringData2,design.full,Beta=3)

The NanoStringDiff package

14

4.3 Multigroup Comparisons

NanoStringDiff can do multigroup comparisons, for example if we want compare group A to the average

of group B and C,

> design.full=model.matrix(~0+group)

> result=glm.LRT(NanoStringData2,design.full,contrast=c(1,-1/2,-1/2))

5 Differential Expression Analysis for Multifactor Experi-

ment

In this section, we still use NanoStringData2 in examples, but the above examples all cotnsider

single factor treatment condition , now we include the other experiment factor gender to consider

multifactor problems.

5.1 Nested Interactions

First, we form the design matrix use factors group and interaction between group and gender:

> design=pData(NanoStringData2)[,c("group","gender")]

> group=design$group

> gender=design$gender

> design.full=model.matrix(~group+group:gender)

> design.full

(Intercept) groupB groupC groupA:genderMale groupB:genderMale

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

0

0

0

1

1

1

1

0

0

0

0

0

0

0

0

0

0

0

1

1

1

1

1

0

0

0

0

0

0

0

0

0

0

0

0

0

1

1

0

0

0

0

0

The NanoStringDiff package

15

12

1

0

1

0

0

groupC:genderMale

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

0

0

0

0

0

0

0

0

1

1

0

0

attr(,"assign")

[1] 0 1 1 2 2 2

attr(,"contrasts")

attr(,"contrasts")$group

[1] "contr.treatment"

attr(,"contrasts")$gender

[1] "contr.treatment"

Here, we consider the mean expression level of female in group A as the baseline expression level, if we

want to test the effect of gender in group A, we can use Beta=4,

> result=glm.LRT(NanoStringData2,design.full,Beta=4)

Compare treatment group B to A ignore the effect the gender,

> result=glm.LRT(NanoStringData2,design.full,Beta=2)

Consider the interaction effect between gender and group B compare to A:

> result=glm.LRT(NanoStringData2,design.full,Beta=c(2,5))

5.2 All Interactions

We also can form a design matrix consider all interactions:

The NanoStringDiff package

16

> design.full=model.matrix(~group+gender+group:gender)

Which is equivalent to:

> design.full=model.matrix(~group*gender)

> design.full

(Intercept) groupB groupC genderMale groupB:genderMale groupC:genderMale

0

0

0

0

1

1

0

0

0

0

0

0

0

0

0

0

0

0

0

0

1

1

0

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

0

0

0

1

1

1

1

0

0

0

0

0

0

0

0

0

0

0

0

1

1

1

1

1

1

0

0

1

1

0

0

1

1

0

0

attr(,"assign")

[1] 0 1 1 2 3 3

attr(,"contrasts")

attr(,"contrasts")$group

[1] "contr.treatment"

attr(,"contrasts")$gender

[1] "contr.treatment"

Test the gender effect in Treatment group B:

> result=glm.LRT(NanoStringData2,design.full,Beta=4:5)

6 Session Info

> toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

The NanoStringDiff package

17

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,

LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,

LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, NanoStringDiff 1.40.0, generics 0.1.4

• Loaded via a namespace (and not attached): Rcpp 1.1.0, compiler 4.5.1, matrixStats 1.5.0,

tools 4.5.1

References

[1] Masaki Mori, Robinson Triboulet, Morvarid Mohseni, Karin Schlegelmilch, Kriti Shrestha, Fer-

nando D Camargo, and Richard I Gregory. Hippo signaling regulates microprocessor and links
cell-density-dependent mirna biogenesis to cancer. Cell, 156(5):893–906, 2014.

