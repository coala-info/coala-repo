Package ‘stemHypoxia’

February 26, 2026

Type Package

Title Differentiation of Human Embryonic Stem Cells under Hypoxia gene

expression dataset by Prado-Lopez et al. (2010)

Version 1.46.0

Date 2012-09-03

Description Expression profiling using microarray technology to prove if 'Hypoxia Promotes Effi-
cient Differentiation of Human Embryonic Stem Cells to Functional Endothelium' by Prado-
Lopez et al. (2010) Stem Cells 28:407-418. Full data available at Gene Expression Omnibus se-
ries GSE37761.

Author Cristobal Fresno and Elmer A. Fernandez

Maintainer Cristobal Fresno <cristobalfresno@gmail.com>

License GPL (>=2)

Depends R (>= 2.14.1)

URL http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE37761,

http://onlinelibrary.wiley.com/doi/10.1002/stem.295/abstract

biocViews ExperimentData, Tissue, StemCell, Homo_sapiens_Data,
CancerData, MicroarrayData, TissueMicroarrayData, GEO

git_url https://git.bioconductor.org/packages/stemHypoxia

git_branch RELEASE_3_22

git_last_commit 4100dd4

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

.
design .
.
.
M .
stemHypoxia .

.
.

.
.

.
.

.

Index

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

. .
. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3
4

6

1

2

design

design

Design of gene expresion

Description

Differentiation of Human Embryonic Stem Cells under Hypoxia gene expression dataset by Prado-
Lopez et al. 2010.

Usage

data(stemHypoxia)

Format

Experimental design data.frame with samples and different treatment conditions: time points and
oxygen levels.

• time: time where the sample was processed (0, 0.5, 1, 5, 10 or 15 days).

• oxygen: level of oxygen available in the conditioned medium (1, 5 or 21 %)

• samplename: acronym to describe chips’s treatment. Note that the first two are control condi-

tions.

Details

This dataset represents the study published by Prado-Lopez et al. 2010.

• Summary: Early development of mammalian embryos occurs in an environment of relative hy-
poxia. Nevertheless, human embryonic stem cells (hESC), which are derived from the inner
cell mass of blastocyst, are routinely cultured under the same atmospheric conditions (21%
O2) as somatic cells. We hypothesized that O2 levels modulate gene expression and differen-
tiation potential of hESC, and thus, we performed gene profiling of hESC maintained under
normoxic or hypoxic (1% or 5% O2) conditions. Our analysis revealed that hypoxia downreg-
ulates expression of pluripotency markers in hESC but increases significantly the expression of
genes associated with angio- and vasculogenesis including vascular endothelial growth factor
and angiopoitein-like proteins. Consequently, we were able to efficiently differentiate hESC
to functional endothelial cells (EC) by varying O2 levels; after 24 hours at 5% O2, more than
50% of cells were CD34+. Transplantation of resulting endothelial-like cells improved both
systolic function and fractional shortening in a rodent model of myocardial infarction. More-
over, analysis of the infarcted zone revealed that transplanted EC reduced the area of fibrous
scar tissue by 50%. Thus, use of hypoxic conditions to specify the endothelial lineage suggests
a novel strategy for cellular therapies aimed at repair of damaged vasculature in pathologies
such as cerebral ischemia and myocardial infarction.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE37761

M

References

3

S. Prado-Lopez, A. Conesa, A. Arminan, M. Martinez-Losa, C. Escobedo-Lucea, C. Gandia, S.
Tarazona, D. Melguizo, D. Blesa, D. Montaner, S. Sanz-Gonzalez, P. Sepulveda, S. Gotz, J. E.
O’Connor, R. Moreno, J. Dopazo, D. J. Burks, M. Stojkovic (2010) Hypoxia Promotes Efficient
Differentiation of Human Embryonic Stem Cells to Functional Endothelium, Stem Cells 28(3):407-
418, doi:10.1002/stem.295.

Examples

## load the dataset
data(stemHypoxia)

## Exploring the experimental design data.frame
dim(design)

#22 8

## Show the head of the data.frame and its summary
head(design)
summary(design)

M

Gene expression data matrix

Description

Differentiation of Human Embryonic Stem Cells under Hypoxia gene expression dataset by Prado-
Lopez et al. 2010.

Usage

data(stemHypoxia)

Format

Agilent-014850 Whole Human Genome Microarray 4x44K G4112F, rma gene expression matrix,
where row stands for genes and columns for treatments (except the first two) respectevely.

• Gene_ID: manufacturer feature id a.k.a AGILENT_OLIGO_ID.

• GeneName: gene symbol of the corresponding feature.

• Additional columns: treatment expression (see design)

Details

This dataset represents the study published by Prado-Lopez et al. 2010.

• Summary: Early development of mammalian embryos occurs in an environment of relative hy-
poxia. Nevertheless, human embryonic stem cells (hESC), which are derived from the inner
cell mass of blastocyst, are routinely cultured under the same atmospheric conditions (21%
O2) as somatic cells. We hypothesized that O2 levels modulate gene expression and differen-
tiation potential of hESC, and thus, we performed gene profiling of hESC maintained under
normoxic or hypoxic (1% or 5% O2) conditions. Our analysis revealed that hypoxia downreg-
ulates expression of pluripotency markers in hESC but increases significantly the expression of
genes associated with angio- and vasculogenesis including vascular endothelial growth factor

4

stemHypoxia

and angiopoitein-like proteins. Consequently, we were able to efficiently differentiate hESC
to functional endothelial cells (EC) by varying O2 levels; after 24 hours at 5% O2, more than
50% of cells were CD34+. Transplantation of resulting endothelial-like cells improved both
systolic function and fractional shortening in a rodent model of myocardial infarction. More-
over, analysis of the infarcted zone revealed that transplanted EC reduced the area of fibrous
scar tissue by 50%. Thus, use of hypoxic conditions to specify the endothelial lineage suggests
a novel strategy for cellular therapies aimed at repair of damaged vasculature in pathologies
such as cerebral ischemia and myocardial infarction.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE37761

References

S. Prado-Lopez, A. Conesa, A. Arminan, M. Martinez-Losa, C. Escobedo-Lucea, C. Gandia, S.
Tarazona, D. Melguizo, D. Blesa, D. Montaner, S. Sanz-Gonzalez, P. Sepulveda, S. Gotz, J. E.
O’Connor, R. Moreno, J. Dopazo, D. J. Burks, M. Stojkovic (2010) Hypoxia Promotes Efficient
Differentiation of Human Embryonic Stem Cells to Functional Endothelium, Stem Cells 28(3):407-
418, doi:10.1002/stem.295.

R.A. Irizarry, B. Hobbs, F. Colin , Y.D. Beazer-Barclay, K. Antonellis, U. Scherf, T.P. Speed (2003)
Exploration, normalization and summaries of high density oligonucleotide array probe level data,
Biostatistics 4(2):249-64, doi: 10.1093/biostatistics/4.2.249

Examples

## load the dataset
data(stemHypoxia)

## Exploring the expression matrix M
dim(M) #40736 features x 28 sample + ID + Symbol
head(M) #Just to see some intensity values

##Boxplot of gene expressions
## Not run: boxplot(M[,-(1,2)])

stemHypoxia

Prado-Lopez et al. 2010 data package

Description

Differentiation of Human Embryonic Stem Cells under Hypoxia gene expression dataset by Prado-
Lopez et al. 2010.

Usage

data(stemHypoxia)

Format

This package contains two data.frames with the associated experimental data as follows:

• M: the microarray gene expression matrix (see M).
• design: the lm like experimental design object, describing the treatment structure (see design).

stemHypoxia

Details

5

This dataset represents the study published by Prado-Lopez et al. 2010.

• Summary: Early development of mammalian embryos occurs in an environment of relative
hyptem cells (hESC), which are derived from the inner cell mass of blastocyst, are routinely
cultured under the same atmospheric conditions (21% O2) as somatic cells. We hypothesized
that O2 levels modulate gene expression and differentiation potential of hESC, and thus, we
performed gene profiling of hESC maintained under normoxic or hypoxic (1% or 5% O2) con-
ditions. Our analysis revealed that hypoxia downregulates expression of pluripotency mark-
ers in hESC but increases significantly the expression of genes associated with angio- and
vasculogenesis including vascular endothelial growth factor and angiopoitein-like proteins.
Consequently, we were able to efficiently differentiate hESC to functional endothelial cells
(EC) by varying O2 levels; after 24 hours at 5% O2, more than 50% of cells were CD34+.
Transplantation of resulting endothelial-like cells improved both systolic function and frac-
tional shortening in a rodent model ooxia. Nevertheless, human embryonic stem cells (hESC),
which are derived from the inner cell mass of blastocyst, are routinely cultured under the same
atmospheric conditions (21% O2) as somatic cells. We hypothesized that O2 levels modulate
gene expression and differentiation potential of hESC, and thus, we performed gene profiling
of hESC maintained under normoxic or hypoxic (1% or 5% O2) conditions. Our analysis re-
vealed that hypoxia downregulates expression of pluripotency markers in hESC but increases
significantly the expression of genes associated with angio- and vasculogenesis including vas-
cular endothelial growth factor and angiopoitein-like proteins. Consequently, we were able
to efficiently differentiate hESC to functional endothelial cells (EC) by varying O2 levels;
after 24 hours at 5% O2, more than 50% of cells were CD34+. Transplantation of resulting
endothelial-like cells improved both systolic function and fractional shortening in a rodent
model of myocardial infarction. Moreover, analysis of the infarcted zone revealed that trans-
planted EC reduced the area of fibrous scar tissue by 50%. Thus, use of hypoxic conditions to
specify the endothelial lineage suggests a novel strategy for cellular therapies aimed at repair
of damaged vasculature in pathologies such as cerebral ischemia and myocardial infarction.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE37761

References

S. Prado-Lopez, A. Conesa, A. Arminan, M. Martinez-Losa, C. Escobedo-Lucea, C. Gandia, S.
Tarazona, D. Melguizo, D. Blesa, D. Montaner, S. Sanz-Gonzalez, P. Sepulveda, S. Gotz, J. E.
O’Connor, R. Moreno, J. Dopazo, D. J. Burks, M. Stojkovic (2010) Hypoxia Promotes Efficient
Differentiation of Human Embryonic Stem Cells to Functional Endothelium, Stem Cells 28(3):407-
418, doi:10.1002/stem.295.

See Also

M and design man pages for a complete description.

Index

∗ datasets

design, 2
M, 3
stemHypoxia, 4

design, 2, 3–5

M, 3, 4, 5

stemHypoxia, 4

6

