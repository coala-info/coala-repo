Package ‘chromstaRData’

February 12, 2026

Type Package

Title ChIP-seq data for Demonstration Purposes

Version 1.36.0

Date 2016-06

Author Aaron Taudt

Maintainer Aaron Taudt <aaron.taudt@gmail.com>

Description ChIP-seq data for demonstration purposes in the chromstaR package.

Depends R (>= 3.3)

License GPL-3

biocViews Mus_musculus_Data, StemCell, ChIPSeqData

NeedsCompilation no

RoxygenNote 5.0.1

PackageStatus Deprecated

git_url https://git.bioconductor.org/packages/chromstaRData

git_branch RELEASE_3_22

git_last_commit 98b94a9

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.
.

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
chromstaRData .
experiment_table .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
experiment_table_H4K20me1 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
experiment_table_SHR .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
expression_lv .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
rn4_chrominfo .

.
.
.

.
.

.
.

.
.

Index

1

2
2
2
3
3
3

4

2

experiment_table_H4K20me1

chromstaRData

ChIP-seq data from the EURATRANS project

Description

ChIP-seq data from the EURATRANS project for left-ventricle (lv) heart tissue in brown normay
(BN) and spontaneous hypertensive rat (SHR). The data was downsampled to chr12 to reduce the
file size for demonstration purposes.

Format

BED files with aligned reads.

Source

www.euratrans.eu

experiment_table

Experiment data table for EURATRANS example

Description

Experiment data table for the EURTRANS data sets of left-ventricle (lv) heart tissue for usage in
vignette examples of package chromstaR.

Format

A data.frame with columns ’file’, ’mark’, ’condition’, ’replicate’ and ’pairedEndReads’.

experiment_table_H4K20me1

Experiment data table for EURATRANS H4K20me1-example

Description

Experiment data table for the EURTRANS H4K20me1 data sets of left-ventricle (lv) heart tissue
for usage in vignette examples of package chromstaR.

Format

A data.frame with columns ’file’, ’mark’, ’condition’, ’replicate’ and ’pairedEndReads’.

experiment_table_SHR

3

experiment_table_SHR

Experiment data table for EURATRANS SHR-example

Description

Experiment data table for the EURTRANS data sets of left-ventricle (lv) heart tissue in spontaneous
hypertensive rat (SHR) for usage in vignette examples of package chromstaR.

Format

A data.frame with columns ’file’, ’mark’, ’condition’, ’replicate’ and ’pairedEndReads’.

expression_lv

Expression data for the EURATRANS project

Description

Expression values for left-ventricle (lv) heart tissue in brown norway (BN) and spontaneous hyper-
tensive rat (SHR).

Format

A data.frame with columns ’ensembl_gene_id’, ’expression_BN’ and ’expression_SHR’

rn4_chrominfo

Chromosome length information for rn4

Description

Chromosome length information for rat assembly rn4.

Format

A data.frame with chromosome and length information.

See Also

fetchExtendedChromInfoFromUCSC

Index

chromstaRData, 2

euratrans (chromstaRData), 2
experiment_table, 2
experiment_table_H4K20me1, 2
experiment_table_SHR, 3
expression_lv, 3

fetchExtendedChromInfoFromUCSC, 3

rat (chromstaRData), 2
rn4_chrominfo, 3

4

