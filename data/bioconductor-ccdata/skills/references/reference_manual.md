Package ‘ccdata’

February 12, 2026

Title Data for Combination Connectivity Mapping (ccmap) Package

Version 1.36.0

Author Alex Pickering

Maintainer Alex Pickering <alexvpickering@gmail.com>

Description This package contains microarray gene expression data generated

from the Connectivity Map build 02 and LINCS l1000. The data are used by
the ccmap package to find drugs and drug combinations to mimic or reverse
a gene expression signature.

Depends R (>= 3.3)

License MIT + file LICENSE

LazyData false

biocViews ExperimentData, MicroarrayData, ExpressionData

RoxygenNote 6.0.1

git_url https://git.bioconductor.org/packages/ccdata

git_branch RELEASE_3_22

git_last_commit f1f8d1c

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.
cmap_es .
.
cmap_var
.
genes
.
.
.
l1000_es .
.
.
net1 .
.
.
net2 .
xgb_mod .

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
. .
. .
. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

1

2
2
3
3
4
4
5

6

2

cmap_var

cmap_es

Effect size values for Connectivity Map build 02 drugs.

Description

Moderated unbiased effect sizes values for all 1309 drugs in the Connectivity Map build 02.

Usage

data(cmap_es)

Format

An object of class matrix with 13832 rows and 1309 columns.

Details

Calculated as described by Marot et al (see reference) using toptable from limma and effectsize
from metaMA.

Value

A matrix where columns correspond to drugs and rows to gene symbols.

References

Marot G, Foulley JL, Mayer CD, Jaffrézic F. Moderated effect size and P-value combinations for
microarray meta-analyses. Bioinformatics. 2009 Oct 15;25(20):2692-9. doi: 10.1093/bioinformat-
ics/btp444.

cmap_var

Variance values for Connectivity Map build 02 drugs.

Description

Variances of unbiased effect sizes values for all 1309 drugs in the Connectivity Map build 02.

Usage

data(cmap_var)

Format

An object of class matrix with 13832 rows and 1309 columns.

Details

Calculated as described by Marot et al (see reference) using toptable from limma and effectsize
from metaMA.

genes

Value

3

A matrix where columns correspond to drugs and rows to gene symbols.

References

Marot G, Foulley JL, Mayer CD, Jaffrézic F. Moderated effect size and P-value combinations for
microarray meta-analyses. Bioinformatics. 2009 Oct 15;25(20):2692-9. doi: 10.1093/bioinformat-
ics/btp444.

genes

HGNC symbols used for NNet predictions.

Description

Order is as required for input and produced by output of net1/net2 predictions.

Usage

data(genes)

Format

An object of class character of length 11525.

Value

A character vector of 11525 HGNC symbols.

l1000_es

Effect size values for LINCS l1000 signatures.

Description

Moderated unbiased effect sizes values for all 230829 LINCS l1000 signatures.

Usage

data(l1000_es)

Format

An object of class matrix with 1001 rows and 230829 columns.

Details

Calculated as described by Marot et al (see reference) using toptable from limma and effectsize
from metaMA.

Value

A matrix where columns correspond to perturbagens and rows to gene symbols.

4

References

net2

Marot G, Foulley JL, Mayer CD, Jaffrézic F. Moderated effect size and P-value combinations for
microarray meta-analyses. Bioinformatics. 2009 Oct 15;25(20):2692-9. doi: 10.1093/bioinformat-
ics/btp444.

net1

Neural network model 1 for treatment combinations.

Description

Contains weight matrices and bias vectors needed to make predictions.

Usage

#NA

Format

An object of class list of length 4.

Value

List with matrices W1/W2 and vectors b1/b2.

net2

Neural network model 2 for treatment combinations.

Description

Contains weight matrices and bias vectors needed to make predictions.

Usage

#NA

Format

An object of class list of length 4.

Value

List with matrices W1/W2 and vectors b1/b2.

xgb_mod

5

xgb_mod

XGBoost model for treatment combinations.

Description

Model stacks predictions from net1 and net2 with effect size values from cmap_es and variance
values from cmap_var.

Usage

#NA

Format

An object of class xgb.Booster of length 2.

Value

Object of class xgb.Booster

Index

∗ datasets

cmap_es, 2
cmap_var, 2
genes, 3
l1000_es, 3
net1, 4
net2, 4
xgb_mod, 5

cmap_es, 2
cmap_var, 2

effectsize, 2, 3

genes, 3

l1000_es, 3

net1, 4
net2, 4

toptable, 2, 3

xgb_mod, 5

6

