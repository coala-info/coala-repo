Package ‘GGdata’

April 11, 2019

Title all 90 hapmap CEU samples, 47K expression, 4mm SNP

Description data exemplars dealing with hapmap SNP reports, GWAS, etc.

Version 1.20.0

Author VJ Carey <stvjc@channing.harvard.edu>

Maintainer VJ Carey <stvjc@channing.harvard.edu>

biocViews ExperimentData, HapMap, Genome, SequencingData,

MicroarrayData, SNPData

Depends R (>= 2.12.0), methods, Biobase (>= 2.5.5), GGBase, snpStats,

illuminaHumanv1.db, AnnotationDbi

Enhances GGtools

LazyLoad yes

License LGPL

git_url https://git.bioconductor.org/packages/GGdata

git_branch RELEASE_3_8

git_last_commit 8febeb6

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

hmceuB36 .

.

.

.

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

hmceuB36

representations of HapMap snp data + expression data

Description

representations of HapMap snp data + expression data

Usage

# getSS("GGdata", "20") # for example, to get full expression, + genotypes

# on chr20

1

2

Format

hmceuB36

ExpressionSet and SnpMatrix instances to be combined using getSS

Details

Instances of class smlSet are created from two basic sources.

First, the expression data for 90 CEU families in CEPH were obtained from SANGER GENEVAR
project.

Second, data on forward non-redundant SNPs in these individuals the HapMap build 36 ftp site in
march 2008. Full provenance information still to be supplied.

Value

instances of class smlSet

Note

As of March 2011 the smlSet is no longer serialized. Instead, use getSS("GGdata", [chrs]) to
create an smlSet with all probes and selected chromosomes. There is an instance of ExpressionSet-class
named ex in the data folder of this package that will be united with genotype data using getSS.

Author(s)

Vince Carey <stvjc@channing.harvard.edu>

References

Cheung VG., Spielman RS., Ewens KG., Weber TM., Morley M & Burdick JT.: Mapping de-
terminants of human gene expression by regional and whole genome association. Nature, 437:
1365-1369, 2005

Examples

library(GGtools)
hmceuB36 = getSS("GGdata", c("20")) # just 1 chromosome
exprs(hmceuB36)[1:4,1:4]
as(smList(hmceuB36)[[1]][1:4,1:4], "character")
library(GGtools)
library(illuminaHumanv1.db)
cptag = get("CPNE1", revmap(illuminaHumanv1SYMBOL))
tt = eqtlTests(hmceuB36[probeId(cptag),] , ~male)
topFeats(probeId(cptag), mgr=tt, ffind=1)

Index

∗Topic packages

hmceuB36, 1

ex (hmceuB36), 1

getSS, 2

hmceuB36, 1
hmceuB36-package (hmceuB36), 1

smlSet, 2

3

