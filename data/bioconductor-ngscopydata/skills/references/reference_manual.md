Package ‘NGScopyData’
February 26, 2026

Type Package

Version 1.30.0

Date 2014-08-08 11:47:26 EDT

Title Subset of BAM files of human tumor and pooled normal sequencing

data (Zhao et al. 2014) for the NGScopy package

Description Subset of BAM files of human lung tumor and pooled normal

samples by targeted panel sequencing. [Zhao et al 2014.
Targeted Sequencing in Non-Small Cell Lung Cancer (NSCLC) Using
the University of North Carolina (UNC) Sequencing Assay
Captures Most Previously Described Genetic Aberrations in
NSCLC. In preparation.] Each sample is a 10 percent random
subsample drawn from the original sequencing data. The pooled
normal sample has been rescaled accroding to the total number
of normal samples in the ``pool''. Here provided is the
subsampled data on chr6 (hg19).

License GPL (>=2)

LazyData yes

URL http:

//www.bioconductor.org/packages/release/data/experiment/html/NGScopyData.html

biocViews ExperimentData, CancerData, LungCancerData, SequencingData

Author Xiaobei Zhao [aut, cre, cph]
Maintainer Xiaobei Zhao <xiaobei@binf.ku.dk>

git_url https://git.bioconductor.org/packages/NGScopyData

git_branch RELEASE_3_22

git_last_commit c673704

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

NGScopyData-package .
.
tps_27.chr6 .
.
tps_90.chr6 .
.
tps_N8.chr6 .

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

2
2
3
3

1

2

Index

tps_27.chr6

5

NGScopyData-package

Subset of BAM files of human tumor and pooled normal sequencing
data (Zhao et al. 2014) for the NGScopy package

Description

Subset of BAM files of human tumor and pooled normal samples by targeted panel sequencing
(Zhao et al. 2014). Each sample is a 10 percent random subsample drawn from the original se-
quencing data. The pooled normal sample has been rescaled accroding to the total number of
normal samples in the "pool". Here provided is the subsampled data on chr6 (hg19).

Usage

tps_90.chr6()
tps_27.chr6()
tps_N8.chr6()

Author(s)

Xiaobei Zhao

References

Zhao et al (2014), Targeted Sequencing in Non-Small Cell Lung Cancer (NSCLC) Using the Uni-
versity of North Carolina (UNC) Sequencing Assay Captures Most Previously Described Genetic
Aberrations in NSCLC. In preparation

See Also

NGScopy

tps_27.chr6

A subset of tumor sample (ID: 27) by targeted panel sequencing

Description

A subset of tumor sample (ID: 27) by targeted panel sequencing, a 10 percent random subsample
drawn from chr6, hg19 (Zhao et al. 2014).

Usage

tps_27.chr6()

Value

character, the path of the (sorted) bam file and its index file

Author(s)

Xiaobei Zhao

tps_90.chr6

See Also

NGScopyData NGScopy

Examples

require(NGScopyData)
tps_27.chr6()

3

tps_90.chr6

A subset of tumor sample (ID: 90) by targeted panel sequencing

Description

A subset of tumor sample (ID: 90) by targeted panel sequencing, a 10 percent random subsample
drawn from chr6, hg19 (Zhao et al. 2014).

Usage

tps_90.chr6()

Value

character, the path of the (sorted) bam file and its index file

Author(s)

Xiaobei Zhao

See Also

NGScopyData NGScopy

Examples

require(NGScopyData)
tps_90.chr6()

tps_N8.chr6

A subset of pooled normal sample (ID: N8) by targeted panel sequenc-
ing

Description

A subset of pooled normal sample (ID: N8) by targeted panel sequencing, a 10 percent random
subsample, rescaled by the total number of normal samples in the "pool", drawn from chr6, hg19
(Zhao et al. 2014).

Usage

tps_N8.chr6()

4

Value

character, the path of the (sorted) bam file and its index file

tps_N8.chr6

Author(s)

Xiaobei Zhao

See Also

NGScopyData NGScopy

Examples

require(NGScopyData)
tps_N8.chr6()

Index

∗ package

NGScopyData-package, 2

NGScopyData, 3, 4
NGScopyData (NGScopyData-package), 2
NGScopyData-package, 2

tps_27.chr6, 2
tps_90.chr6, 3
tps_N8.chr6, 3

5

