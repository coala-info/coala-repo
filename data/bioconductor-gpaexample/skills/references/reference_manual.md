Package ‘gpaExample’

February 12, 2026

Type Package

Title Example data for the GPA package (Genetic analysis incorporating

Pleiotropy and Annotation)

Version 1.22.0

Depends R (>= 4.0.0)

Date 2020-02-24

Author Dongjun Chung, Carter Allen

Maintainer Dongjun Chung <dongjun.chung@gmail.com>

Description

Example data for the GPA package, consisting of the p-values of 1,219,805 SNPs for five psychi-
atric disorder GWAS from the psychiatric GWAS consortium (PGC), with the annota-
tion data using genes preferentially expressed in the central nervous system (CNS).

License GPL (>= 2)

URL http://dongjunchung.github.io/GPA/

LazyData FALSE

biocViews ExperimentData, Homo_sapiens_Data, SNPData

NeedsCompilation no

git_url https://git.bioconductor.org/packages/gpaExample

git_branch RELEASE_3_22

git_last_commit 0141dbb

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

exampleData

.

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

4

Index

1

2

exampleData

exampleData

PGC GWAS Dataset and Annotation Dataset

Description

This is the PGC GWAS dataset and annotation dataset used in Chung et al. (2013).

Usage

data(exampleData)

Format

A list with two matrices as elements. Two matrices of sizes 1,219,805 x 5 and 1,219,805 x 1,
exampleData$pval and exampleData$ann, contain the p-values of 1,219,805 SNPs for five psy-
chiatric disorder GWAS (ADHD, ASD, BPD, MDD, SCZ) from the psychiatric GWAS consortium
(PGC) and the binary annotation data using genes preferentially expressed in the central nervous
system (CNS), respectively.

Details

Five columns of the matrix exampleData$pval correspond to attention deficit-hyperactivity dis-
order (ADHD), autism spectrum disorder (ASD), bipolar disorder (BPD), major depressive disor-
der (MDD), and schizophrenia (SCZ). Detailed information about these data sets is provided in
Cross-Disorder Group of the Psychiatric Genomics Consortium (2013a, 2013b). Summary statis-
tics of these five psychiatric disorders were downloaded from the section for cross-disorder analysis
at the Psychiatric Genomics Consortium (PGC) website (https://pgc.unc.edu/Sharing.php).
exampleData$ann provides annotation data using genes preferentially expressed in the central ner-
vous system (CNS) (Lee et al., 2012; Raychaudhuri et al., 2010), where the entries corresponding
to SNPs within 50-kb of the genes from the CNS set were set to be one and zero otherwise. See the
vignette of R package GPA and Chung et al. (2013) for more details.

Source

Cross-Disorder Group of the Psychiatric Genomics Consortium (2013a), "Genetic relationship be-
tween five psychiatric disorders estimated from genome-wide SNPs", Nature Genetics, 45:984–994.

Cross-Disorder Group of the Psychiatric Genomics Consortium (2013b), "Identification of risk
loci with shared effects on five major psychiatric disorders: a genome-wide analysis", Lancet,
381:1371–1379.

Lee SH, DeCandia TR, Ripke S, Yang J, Sullivan PF, et al. (2012), "Estimating the proportion of
variation in susceptibility to schizophrenia captured by common SNPs", Nature Genetics, 44:247–
250.

Raychaudhuri S, Korn JM, McCarroll SA, Altshuler D, Sklar P, et al. (2010), "Accurately assess-
ing the risk of schizophrenia conferred by rare copy-number variation affecting genes with brain
function", PLoS Genetics, 6:e1001097.

References

Chung D, Yang C, Li C, Gelernter J, and Zhao H (2013), "GPA: A statistical approach to prioritizing
GWAS results by integrating pleiotropy and annotation", To appear in PLoS Genetics.

exampleData

Examples

data(exampleData)
head(exampleData)

3

Index

∗ datasets

exampleData, 2

exampleData, 2

4

