Package ‘CLL’

February 12, 2026

Type Package

Title A Package for CLL Gene Expression Data

Version 1.50.0

Author Elizabeth Whalen

Maintainer Robert Gentleman <rgentlem@fhcrc.org>

Description The CLL package contains the chronic lymphocytic leukemia (CLL)

gene expression data. The CLL data had 24 samples that were either classified
as progressive or stable in regards to disease progression. The data came
from Dr. Sabina Chiaretti at Division of Hematology, Department of Cellular
Biotechnologies and Hematology, University La Sapienza, Rome, Italy and
Dr. Jerome Ritz at Department of Medicine, Brigham and Women's Hospital,
Harvard Medical School, Boston, Massachusetts.

Depends R (>= 2.10), affy (>= 1.23.4), Biobase (>= 2.5.5)

License LGPL

biocViews ExperimentData, CancerData, LeukemiaCancerData,

MicroarrayData

git_url https://git.bioconductor.org/packages/CLL

git_branch RELEASE_3_22

git_last_commit 86106a6

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

CLL-package .
.
CLLbatch .
.
.
.
disease .
.
.
nsFilter
.
.
sCLLex .
.
.
.
.
sFiltert .
.
sFiltertBH .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

1

2
2
3
4
5
6
6

8

2

CLLbatch

CLL-package

A package for CLL gene expression data

Description

The CLL package contains the chronic lymphocytic leukemia (CLL) gene expression data. The
CLL data had 24 samples that were either classified as progressive or stable in regards to disease
progression. The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology,
Department of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and
Dr. Jerome Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical
School, Boston, Massachusetts.

Details

Package: CLL
Type:
Version:
Date:
License: LGPL

Package
1.0
2006-07-10

Author(s)

Elizabeth Whalen

Maintainer: Elizabeth Whalen <ewhalen@hsph.harvard.edu>

Examples

data(sCLLex)

CLLbatch

The AffyBatch object for the CLL microarray data

Description

The AffyBatch object has 24 samples that were affixed to Affymetrix hgu95av2 arrays. These 24
samples came from 24 CLL patients that were either classified as stable or progressive in regards to
disease progression.

Usage

data(CLLbatch)

disease

Format

3

An AffyBatch object with 24 samples and 12,625 genes. The Affymetrix hgu95av2 array was used.

cdfName the name of the CDF file: HG\_U95Av2

nrow the number of rows for each chip: 640

ncol the number of columns for each chip: 640

exprs the matrix containing one probe per row and one array per column (dimensions: 409,600 by

24)

se.exprs the matrix for standard errors: not calculated yet so has dimensions 0 by 0

description no information is available for the description slot, which is of class MIAME

annotation "hgu95av2"

notes there are no notes for this object

reporterInfo unknown (NULL)

phenoData a data frame with one variable: sample (more phenotype data can be found in the

disease data frame)

classVersion no version

Source

The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology, Department
of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and Dr. Jerome
Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical School, Boston,
Massachusetts.

Examples

data(CLLbatch)

disease

The phenotype data for the CLL microarray data

Description

The disease data frame consists of two variables: SampleID, which is the CEL file for the sample,
and Disease, which is whether the sample came from a patient that was stable or progressive in
terms of CLL disease progression.

Usage

data(disease)

Format

A data frame with 24 observations on the following 2 variables.

SampleID a character string refer to the CEL file of the sample

Disease a factor with levels progres. stable; this variable refers to whether the patient was

progressive or stable in regards to CLL disease progression

4

Source

nsFilter

The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology, Department
of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and Dr. Jerome
Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical School, Boston,
Massachusetts.

Examples

data(disease)

nsFilter

Nonspecific filtering boolean values for the sCLLex ExpressionSet ob-
ject

Description

nsFilter is the nonspecific filtering boolean values for the sCLLex ExpressionSet object. One filter
was use: genes with an IQR greater than or equal to the median IQR (IQR performed on the rows
of the expression matrix) have a TRUE value (passed the filter) and those that had an IQR less than
the median have a FALSE value (did not pass the filter). We only filtered on variation.

Usage

data(nsFilter)

Format

A named vector of logicals. The names are the Affymetrix identifiers and the values are booleans.

Source

The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology, Department
of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and Dr. Jerome
Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical School, Boston,
Massachusetts.

Examples

data(nsFilter)
data(sCLLex)
sCLLexF<-sCLLex[nsFilter, ]

sCLLex

5

sCLLex

The ExpressionSet object for the CLL microarray data

Description

The ExpressionSet object was obtained by performing gcrma on the AffyBatch object (CLLbatch).
Two arrays were of questionable quality so these two arrays (CLL1 and CLL10) were removed
before performing gcrma on CLLbatch. The sCLLex ExpressionSet object has 22 samples and
12,625 genes. The Affymetrix hug95av2 arrays were used and the 22 samples came from 22 CLL
patients that were either classified as stable or progressive in regards to disease progression.

Usage

data(sCLLex)

Format

An ExpressionSet object with 22 samples and 12,625 genes. The Affymetrix hgu95av2 array was
used and gcrma was used for preprocessing the AffyBatch object.

exprs the matrix containing estimates expression levels with rows as genes and columns as patients

(dimensions: 12,625 by 22)

se.exprs the matrix with standard error estimates (gcrma returns a 0 by 0 matrix)

description no information is available for the description slot, which is of class MIAME

annotation "hgu95av2"

notes there are no notes for this object

reporterInfo unknown (NULL)

phenoData a data frame with two variables: SampleID and Disease (from the disease data frame);
SampleID is the CEL file and Disease is a factor with 2 levels: progressive or stable, based on
the patient’s CLL disease progression

classVersion no version

Source

The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology, Department
of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and Dr. Jerome
Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical School, Boston,
Massachusetts.

Examples

data(sCLLex)

6

sFiltertBH

sFiltert

Boolean values for specific filtering based on the t-test

Description

sFiltert is a named vector of booleans indicating whether a gene passed the specific and non-specific
filtering steps. The specific filtering was to perform row t-tests and a TRUE value was obtained if
the p-value was less than 0.005. So to have a TRUE value in sFiltert, the gene must have a row t-test
p-value less than 0.005, an interquartile range of at least 0.5 on the log2 scale, and at least 25% of
the samples had an expression value greater than 100 on the normal scale (the last 2 criteria were
the nonspecific filters).

A TRUE value indicates that the gene passed the filtering step and should be included in further
analysis.

Usage

data(sFiltert)

Format

A named vector of logicals. The names correspond to the Affymetrix identifiers and the values are
booleans indicating whether the gene passed the nonspecific and specific filtering (based on t-test
p-values).

Source

The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology, Department
of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and Dr. Jerome
Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical School, Boston,
Massachusetts.

Examples

data(sFiltert)
data(sCLLex)
sCLLexSF<-sCLLex[sFiltert, ]

sFiltertBH

Boolean values for specific filtering based on the t-test

Description

sFiltert is a named vector of booleans indicating whether a gene passed the specific and non-specific
filtering steps. The nonspecific filtering step was described in the nsFilter man page. The specific fil-
tering was to perform row t-tests, then perform p-value adjustment using the Benjamini & Hochberg
method (using the mt.rawp2adjp function in the multtest package with the "BH" procedure), and
finally include the gene if its adjusted p-value was less than 0.35. So to have a TRUE value in
sFiltertBH, the gene must have an IQR greater than or equal to the median IQR and must have a
BH adjusted p-value less than 0.35.

A TRUE value indicates that the gene passed the filtering step and should be included in further
analysis.

sFiltertBH

Usage

data(sFiltert)

Format

7

A named vector of logicals. The names correspond to the Affymetrix identifiers and the values
are booleans indicating whether the gene passed the nonspecific and specific filtering (based on
adjusted t-test p-values).

Source

The CLL microarray data came from Dr. Sabina Chiaretti at Division of Hematology, Department
of Cellular Biotechnologies and Hematology, University La Sapienza, Rome, Italy and Dr. Jerome
Ritz at Department of Medicine, Brigham and Women’s Hospital, Harvard Medical School, Boston,
Massachusetts.

Examples

data(sFiltertBH)
data(sCLLex)
sCLLexSF<-sCLLex[sFiltertBH, ]

Index

∗ datasets

CLLbatch, 2
disease, 3
nsFilter, 4
sCLLex, 5
sFiltert, 6
sFiltertBH, 6

∗ package

CLL-package, 2

CLL (CLL-package), 2
CLL-package, 2
CLLbatch, 2

disease, 3

nsFilter, 4

sCLLex, 5
sFiltert, 6
sFiltertBH, 6

8

