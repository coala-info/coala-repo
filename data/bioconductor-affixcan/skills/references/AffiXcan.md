# AffiXcan

Alessandro Lussana

Department of Molecular Biotechnologies and Health Sciences, MBC, University of Turin, Italy

alessandro.lussana@protonmail.com

#### 29 October 2025

#### Abstract

This package includes a set of functions to train and to apply statistical models to estimate GReX (genetically regulated expression).

#### Package

AffiXcan 1.3.6

# 1 Background

Understanding and predicting how genetic variation influences gene
expression is of great interest in modern biological and medical sciences.
Taking advantage of whole genome sequencing (WGS) and RNA sequencing (RNA-seq)
technologies many efforts have been made to link single nucleotide polymorphisms
(SNPs) to expression variation in cells and tissues.

The present methods to estimate the genetic contribution to gene expression do
not take into account functional information in identifying *expression
quantitative trait loci* (eQTL), i.e. those genetic variants that contribute to
explaining the variation of gene expression. Relying on SNPs as predictors
allows to make significant models of gene expression only for those genes for
which SNPs with a fairly good effect size exist, but this condition is not
satisfied for the majority of genes, despite their expression having a non-zero
heritability (h2). To address this issue, new, different strategies
to analyze genetic variability of regulatory regions and their influence on
transcription are needed.

**AffiXcan** (total binding AFFInity-eXpression sCANner) implements a functional
approach based on the
[TBA](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143627)
(Total Binding Affinity) score to make statistical models of gene expression,
being able to make significant predictions on genes for which SNPs with strong
effect size are absent. Furthermore, such a functional approach allows to make
mechanistic interpretations in terms of transcription factors binding events
that drive differential transcriptional expression. These features are of
considerable importance for eQTL discovery and to improve the capability to
estimate a [GReX](#grex) (genetically regulated expression) for a greater number
of genes, at the same time giving insights on the possible molecular mechanisms
that are involved in differential expression of genes.

In the effort to grant reproducibility and resources’ availability, AffiXcan
package includes also the functions to train the GReX models. It is our purpose
to expand and enhance these functions and, in the future, to provide data
packages to impute GReX on many different tissues with ready-to-use trained
models.

# 2 GReX

## 2.1 What is GReX?

GReX (genetically regulated expression) is the component of gene expression
(here defined as the transcript level, e.g. RPKM) explained by an individual’s
genetics.

The abundance of a transcript in a cell is determined by many factors,
including genetics, environmental factors, and disease. It can have an impact
on the cell’s physiology and alter the expression of other transcripts or
proteins, their activity and regulation. Since transcription is initiated by
the binding of transcription factors to DNA, a portion of gene expression can be
directly explained by variants in *cis* regulatory regions.

## 2.2 Why GReX?

The estimation of GReX can be useful to perform TWAS when the real total
expression profile is unknown or can not be measured, for example in those
tissues - like the brain - that are inaccessible to *in vivo* safe biopsies,
or in ancient genomes.

GReX can be also exploited to estimate the constitutive susceptibility of a
genome to a certain status, the existence of which is at least partially
influenced by gene expression.

## 2.3 Estimate GReX

Some efforts have been made to develop computational methods to predict GReX
from genotype data using mathematical models.

[Gamazon et al.](http://www.nature.com/articles/ng.3367) developed a method
consisting of multiple-SNP prediction of expression levels, where the estimated
GReX for a gene is given by an additive model in which SNPs are the independent
variables.

[AffiXcan](https://github.com/alussana/AffiXcan) takes into account the
contribution of all polymorphisms of given genomic regions that are associated
to the expression of a gene for a specific individual. This is done using affinity scores -
[TBA](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143627)
(Total Binding Affinity) - between those regions and a set of transcription
factors. A principal component analysis (PCA) is performed on these scores and
for each expressed gene a linear model is fitted.

We observed that the GReX of the majority of genes for which AffiXcan manages to
generate a significant model is not predictable by the method cited above.
Arguably, this is due to the nature of
[TBA](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143627)
score, that allows to take into account the additive small effect of all
variants in a genomic region. Furthermore, the goodness of prediction achieved
by AffiXcan on both shared and non-shared genes was significantly greater. For
brief insights on AffiXcan’s results in preliminary tests, see
[AffiXcan performance](#affixcan-performance) section.

# 3 AffiXcan Workflow

AffiXcan’s estimation of GReX is based on a functional approach that involves a
score to quantify the affinity between a Position-specific Weight Matrix (PWM) and a DNA
segment: the [Total Binding Affinity](https://journals.plos.org/plosone/article?id=10.1371/%20journal.pone.0143627) (TBA). TBA can be computed using
[vcf\_rider](http://github.com/vodkatad/vcf_rider) program, starting from phased
genotypes in vcf format.

## 3.1 Training the models

Here are described the input files needed by AffiXcan to perform the training
phase. The function **affiXcanTrain()** returns an object that can be later used
by **affiXcanImpute()** to estimate GReX. See help(“affiXcanTrain”) for usage.

### 3.1.1 TBA matrices

As a first step, AffiXcan performs a principal component analysis (PCA) on the
[TBA](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143627)
(Total Binding Affinity) scores for each regulatory region. The user has to
provide the paths to **rds** files that contain TBA matrices, in the form of
[MultiAssayExperiment](https://bioconductor.org/packages/release/bioc/html/%20MultiAssayExperiment.html) objects. A toy example of one of these objects is
shown below:

```
suppressMessages(library(MultiAssayExperiment))
tba <- readRDS(system.file("extdata","training.tba.toydata.rds",
    package="AffiXcan")) ## This is a MultiAssayExperiment object
names(assays(tba))
```

```
## [1] "chr12:57770824-57772573" "chr12:57773858-57774823"
## [3] "ENSG00000139269.2"       "ENSG00000256377.1"
```

In this case **assays(tba)** returns a list of 4 matrices, each of which
contains the log2(TBA) values for a different regulatory region.
The matrices must be named with unambiguous identifiers of the regulatory
regions. For illustrative purposes a small portion of the TBA matrix of the
region named “ENSG00000139269.2” is displayed below. Rows are individual’s IDs
and columns are PWMs:

```
assays(tba)$ENSG00000139269.2[1:5,1:4]
```

Centering and scaling (optional) of TBA values is done before computing
principal components. The user has to specify the minimum percentage of variance
to be explained by the principal components selected by AffiXcan to train the
model’s coefficients, in order to achieve a good compromise between sensibility
and overfitting.

### 3.1.2 Expression matrix

AffiXcan needs real expression values to train the models. The user has to
specify a [SummarizedExperiment](https://bioconductor.org/packages/release/%20bioc/html/SummarizedExperiment.html) object and the name (here, “values”) of
the object in **assays()** that contains the expression matrix. A toy example
with only two genes is shown below. In the expression matrix, rows are expressed
genes and columns are individual’s IDs:

```
suppressMessages(library(SummarizedExperiment))
load("../data/exprMatrix.RData")
assays(exprMatrix)$values[,1:5]
```

```
##                      HG00101   HG00102   HG00104   HG00106    HG00109
## ENSG00000139269.2 3.56579072 1.9826807 3.8173950 1.2310491 2.06907848
## ENSG00000256377.1 0.07457151 0.3549103 0.1483357 0.2571551 0.01081881
```

### 3.1.3 Gene - Region(s) associations

The user has to provide a table with the association between expressed genes and
regulatory regions. Every expressed gene must be associated to at least one
regulatory region. To fit the model for one gene, AffiXcan includes the selected
principal components of all regulatory regions associated to that gene, e.g.:

GReX\_geneA ~ PC1\_regionA1 + PC2\_regionA1 + PC3\_regionA1 + PC4\_regionA1 +
PC1\_regionA2 + PC2\_regionA2 …

The associations table’s header must contain the strings “REGULATORY\_REGION” and
“EXPRESSED\_REGION”. An example is shown below:

```
load("../data/regionAssoc.RData")
regionAssoc[1:3,]
```

Here it can be observed that the expressed gene “ENSG00000139269.2” is
associated to three different regulatory regions. The expressed genes’ names
must be the same as found in the [expression matrix](#expression-matrix) and the
regulatory regions’ names must be consistent with those used for the
[TBA matrices](#training-the-models).

### 3.1.4 Pupulation structure covariates

Finally, AffiXcan computes p-values for each model. Optionally, population
structure covariates for each individual can be passed to **affiXcanTrain** to
be included in the models to assess if the estimation of GReX is significantly
independent from the population’s genetic structure.

Here is shown an example of an R object that can be used for this purpose and
that contains the first three PCs of the population structure:

```
load("../data/trainingCovariates.RData")
head(trainingCovariates)
```

If no population structure covariates are specified, the models’ p-value are
simply computed from the f statistic of the model summary(model)$fstatistic

Benjamini-Hochberg correction for multiple testing is eventually performed on
the models’ P-values.

## 3.2 Imputing GReX

Here are described the input files needed by AffiXcan to perform the prediction
phase. The function **affiXcanImpute()** uses the output of **affiXcanTrain()**
to compute the imputed GReX values in a population of individuals.
See help(“affiXcanImpute”) for usage.

### 3.2.1 TBA matrices

TBA values for regulatory regions referring to the population for which we want
to estimate GReX are needed. The user has to provide paths to **rds** files that
contain TBA matrices, in the form of [MultiAssayExperiment](https://%20bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html) objects.
This type of data is described in the [training phase](#training-the-models)
section.

To apply the models consistently, TBA must be calculated on the same regions and
using the same PWM set as done for the training phase. The unambiguous regions’
IDs used to name the TBA matrices stored in MultiAssayExperiment objects need to
match those used in the training phase.

### 3.2.2 Eigenvectors

AffiXcan performs a matrix product between TBA values and eigenvectors to obtain
the selected principal components that will be used as variables when estimating
GReX. Eigenvectors are computed by **affiXcanTrain()** when performing principal
components analysis (PCA) on the training dataset. The user has to specify the
object in which the results of the training phase are stored.

### 3.2.3 Models’ Coefficients

For every gene the selected principal components of the TBA are multiplied by
the model’s coefficients, previously trained on the training dataset by
**affiXcanTrain()**. The user has to specify the object in which the results of
the training phase are stored.

## 3.3 Final Output

**affiXcanImpute()** returns a [SummarizedExperiment](https://bioconductor.org/%20packages/release/bioc/html/SummarizedExperiment.html) object containing a matrix
with the imputed GReX values. To access it we can use assays()$GReX as shown
below. Here it is a toy example to impute the GReX of a single gene in a cohort
of 115 individuals. In the GReX matrix the rows are genes and the columns are
individual’s IDs:

```
suppressMessages(library("AffiXcan"))

trainingTbaPaths <- system.file("extdata","training.tba.toydata.rds",
    package="AffiXcan")
data(exprMatrix)
data(regionAssoc)
data(trainingCovariates)
assay <- "values"

training <- affiXcanTrain(exprMatrix=exprMatrix, assay=assay,
    tbaPaths=trainingTbaPaths, regionAssoc=regionAssoc, cov=trainingCovariates,
    varExplained=80, scale=TRUE)
```

```
##
## AffiXcan: Training The Models
##  --> Performing Principal Components Analysis
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Training Linear Models
##  Done
```

```
testingTbaPaths <- system.file("extdata","testing.tba.toydata.rds",
    package="AffiXcan")
exprmatrix <- affiXcanImpute(tbaPaths=testingTbaPaths,
    affiXcanTraining=training, scale=TRUE)
```

```
##
## AffiXcan: Imputing Genetically Regulated Expression (GReX)
##  --> Computing Principal Components
##  --> Imputing GReX values
##  Done
```

```
grexMatrix <- assays(exprmatrix)$GReX
as.data.frame(grexMatrix)[,1:5]
```

# 4 Cross-Validation

**affiXcanTrain()** can be used in k-fold cross-validation mode by specifying
the argument *kfold* > 0. For example, with *kfold* = 5, a 5-fold cross-validation
will be performed.

Cross-validation mode is not conceived to generate final GReX models. Therefore,
the output of **affiXcanTrain()** in cross-validation mode can not be used by
**affiXcanImpute()** to make GReX imputation on new data, since it consists of
a report useful to evaluate the prediction performance for each gene in each
fold.

In the following example a 5-fold cross-validation is performed on dummy data:

```
trainingTbaPaths <- system.file("extdata","training.tba.toydata.rds",
package="AffiXcan")

data(exprMatrix)
data(regionAssoc)
data(trainingCovariates)

assay <- "values"

training <- affiXcanTrain(exprMatrix=exprMatrix, assay=assay,
tbaPaths=trainingTbaPaths, regionAssoc=regionAssoc, cov=trainingCovariates,
varExplained=80, scale=TRUE, kfold=5)
```

```
##
## AffiXcan: Performing Training With 5 Fold Cross-Validation ( 1 / 5 )
##  --> Performing Principal Components Analysis
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Training Linear Models
##  --> Computing Principal Components On Validation Set
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Imputing GReX Values
##  --> Computing Cross-Validated R^2
##  Done
##
## AffiXcan: Performing Training With 5 Fold Cross-Validation ( 2 / 5 )
##  --> Performing Principal Components Analysis
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Training Linear Models
##  --> Computing Principal Components On Validation Set
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Imputing GReX Values
##  --> Computing Cross-Validated R^2
##  Done
##
## AffiXcan: Performing Training With 5 Fold Cross-Validation ( 3 / 5 )
##  --> Performing Principal Components Analysis
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Training Linear Models
##  --> Computing Principal Components On Validation Set
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Imputing GReX Values
##  --> Computing Cross-Validated R^2
##  Done
##
## AffiXcan: Performing Training With 5 Fold Cross-Validation ( 4 / 5 )
##  --> Performing Principal Components Analysis
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Training Linear Models
##  --> Computing Principal Components On Validation Set
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Imputing GReX Values
##  --> Computing Cross-Validated R^2
##  Done
##
## AffiXcan: Performing Training With 5 Fold Cross-Validation ( 5 / 5 )
##  --> Performing Principal Components Analysis
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Training Linear Models
##  --> Computing Principal Components On Validation Set
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
##  --> Imputing GReX Values
##  --> Computing Cross-Validated R^2
##  Done
```

# 5 Parallelization

AffiXcan processes can take a certain amount of time to be completed, but all
the functions support parallelization. [BiocParallel package](http://%20bioconductor.org/packages/BiocParallel/) is required for parallel evaluation.

The user can construct a BiocParallelParam object and pass it as the BPPARAM
argument when calling **affiXcanTrain()** or **affiXcanImpute()**, or leave
BPPARAM as default for automatic parallel evaluation.

# 6 AffiXcan Performance

This section has the only purpose to briefly show the predictive performance
obtained using AffiXcan in preliminary tests, and its comparison against the
multiple-SNP prediction method described in
[Gamazon et al.](http://www.nature.com/articles/ng.3367). Much further work,
also regarding other datasets and multivariate models, is still in progress.

## 6.1 Cross-validation on GEUVADIS dataset

AffiXcan models were cross-validated on a cohort of 344 individuals of European
descent for whom phased genotype data and expression data (RNA-seq of
EBV-transformed lymphocites) are available in the
[GEUVADIS public dataset](https://www.ebi.ac.uk/arrayexpress/files/E-GEUV-1/).

The cohort was randomly splitted in a training set of 229 individuals and a
testing set of 115 individuals. The training phase was performed on the training
set, then the trained models were applied on the testing set to impute GReX.

Each gene was associated to only one regulatory region, which consisted in a
genomic window spanning upstream and downstream the Transcription Start Site
(TSS). The minimum percentage of variance of TBA to be explained by the selected
principal components was set to 80.

## 6.2 Predictive Performance

The number of genes (~3000) for which a significant model was generated by
AffiXcan was almost identical to the number of genes for which a GReX could be
imputed using the method described in
[Gamazon et al.](http://www.nature.com/articles/ng.3367)

The predictive performance was assessed observing the squared correlation
(R2) between the imputed GReX values and the real total expression
values for each gene. The overall mean of R2 values obtained with
AffiXcan was greater than the one obtained with the multiple-SNP method
(0.099 vs 0.070)

![](data:image/png;base64...)
In the graph: The R2 values from AffiXcan’s predictions, for the
>3000 genes for which a GReX could be imputed, are sorted in increasing order.

## 6.3 Predictive Performance Comparison

Remarkably, the overlap between the genes for which an imputed GReX could be
computed by the two methods is only slightly greater than one third (1123) of
the amount computed by each method. Arguably, this is due to the implementation
of [TBA score](https://journals.plos.org/plosone/article?id=10.1371/journal.%20pone.0143627) to take into account the contribution of all genetic variants in
a regulatory region, rather then only those SNPs with a greater effect size on
gene expression. Supposedly, AffiXcan manages to generate a significant model
to estimate GReX in genes where the transcriptional expression is influenced by
many variants, each contributing to GReX with a small effect size, where the
multiple-SNP prediction method fails to have good statistical predictors.
![](data:image/png;base64...)
In the graph: for each gene for which a GReX could be imputed by both methods,
a blue circle is plotted with the coordinates (R2 from multiple-SNP
method’s prediction, R2 from AffiXcan’s prediction)

Observing the squared correlation (R2) between the imputed GReX
values and the real total expression values on the shared genes, a
Wilcoxon-Mann-Whitney paired test was performed to asses if the two
distributions of R2 values were significantly different.
R2 values from AffiXcan proved to be significantly higher:
![](data:image/png;base64...)
In the graph: histogram of the differences between R2 values:
R2 from AffiXcan’s prediction - R2 from multiple-SNP
method’s prediction (computed for each gene for which a GReX could be imputed by
both methods).

## 6.4 Conclusion

In conclusion, AffiXcan could increase the amount of genes for which a GReX can
be estimated by a factor >1.6, at the same time enhancing the goodness of
prediction.