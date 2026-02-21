Package ‘KOdata’

February 12, 2026

Type Package

Title LINCS Knock-Out Data Package

Version 1.36.0

Date 2016-06-23

Author Shana White

Maintainer Shana White <vandersm@mail.uc.edu>

Description Contains consensus genomic signatures (CGS) for
experimental cell-line specific gene knock-outs as well as
baseline gene expression data for a subset of experimental
cell-lines. Intended for use with package KEGGlincs.

License MIT + file LICENSE

LazyData TRUE

RoxygenNote 5.0.1

Depends R (>= 3.3.0)

biocViews ExpressionData, CancerData, Homo_sapiens_Data

NeedsCompilation no

git_url https://git.bioconductor.org/packages/KOdata

git_branch RELEASE_3_22

git_last_commit ee9254c

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

gene_cell_info .
.
KOdata .
.
KO_data .

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
2
3

4

1

2

KOdata

gene_cell_info

Baseline expression information for genes across cell lines

Description

This data set contains baseline expression measurements for genes in cell lines [without any exper-
imental perturbations] as profiled by the LINCS data consortium

Usage

data(gene_cell_info)

Format

A data frame with 1703457 observations on the following 6 variables.

• pr_gene_symbola character vector

• cella character vector

• basex_affxa numeric vector

• basex_rnaseqa numeric vector

• copy_numbera numeric vector

• is_expresseda logical vector

Value

A data.frame object

KOdata

KOdata: an R data package designed to be used with KEGGlincs

Description

KOdata: an R data package designed to be used with KEGGlincs

KO_data

3

KO_data

LINCS knock-out data

Description

This data set contains consensus genome signatures (CGS) that are the result of experimental knock-
out studies conducted by the BROAD Institute.

Usage

data(KO_data)

Format

A data frame with 36720 observations on the following 9 variables.

• cell_id a character vector

• pert_desc a character vector

• pert_time a numeric vector

• dn100_bing a character vector

• dn100_full a character vector

• dn50_lm a character vector

• up100_bing a character vector

• up100_full a character vector

• up50_lm a character vector

Value

A data.frame object

References

http://lincsportal.ccs.miami.edu

Index

∗ datasets

gene_cell_info, 2
KO_data, 3

gene_cell_info, 2

KO_data, 3
KOdata, 2
KOdata-package (KOdata), 2

4

