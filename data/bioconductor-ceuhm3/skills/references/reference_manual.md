Package ‘ceuhm3’

April 11, 2019

Title ceuhm3: genotype (HapMap phase III) and expression data for CEPH

CEU cohort

Version 0.20.0

Author VJ Carey

Description ceuhm3: genotype (HapMap phase III) and expression data for CEPH CEU cohort

Depends R (>= 2.12.0), GGBase, Biobase

Imports GGtools

Maintainer VJ Carey <stvjc@channing.harvard.edu>

License Artistic-2.0

LazyLoad yes

biocViews SNPData, HapMap

git_url https://git.bioconductor.org/packages/ceuhm3

git_branch RELEASE_3_8

git_last_commit 953195b

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

ceuhm3-package

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

ceuhm3-package

ceuhm3 HapMap phase III genotype calls for CEU subpopulation

Description

ceuhm3 HapMap phase III genotype calls for CEU subpopulation

1

2

Details

ceuhm3-package

Package:
Version:
Depends:
License:
LazyLoad:
Built:

ceuhm3
0.0.0
GGBase
Artistic-2.0
yes
R 2.12.0; ; 2010-07-16 13:28:01 UTC; unix

There are multiple representations of HapMap Phase III genotypes in this package. First, the full
data derived from HapMap are provided in ceuhm3.sms. Second, the samples for which March 2007
expression data was provided by Wellcome Trust GENEVAR project are coupled in the hm3ceuSMS
data set. Finally genomic coordinates for all referenced SNP are in hm3ceuLocs.

Author(s)

VJ Carey

Maintainer: VJ Carey <stvjc@channing.harvard.edu>

Examples

library(GGtools)
h3_20 = getSS("ceuhm3", "chr20")
t1 = gwSnpTests(genesym("CPNE1")~male, h3_20, chrnum("chr20"))
topSnps(t1)

Index

∗Topic package

ceuhm3-package, 1

ceuhm3 (ceuhm3-package), 1
ceuhm3-package, 1
ceuhm3.sml (ceuhm3-package), 1

ex (ceuhm3-package), 1

hm3ceuLocs (ceuhm3-package), 1
hm3ceuSMS (ceuhm3-package), 1

3

