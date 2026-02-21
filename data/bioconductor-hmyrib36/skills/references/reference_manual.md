Package ‘hmyriB36’
April 11, 2019

Title YRI hapmap + expression (GENEVAR), Build 36, r23a genotypes

Description YRI hapmap + expression (GENEVAR), Build 36, r23a genotypes

Version 1.18.0

Author Vincent Carey <stvjc@channing.harvard.edu>

Maintainer Vincent Carey <stvjc@channing.harvard.edu>

Depends R (>= 2.13.0), methods, Biobase (>= 2.5.5), GGBase

Suggests GGtools, illuminaHumanv1.db

License Artistic-2.0

biocViews ExperimentData, Genome, SNPData, HapMap

git_url https://git.bioconductor.org/packages/hmyriB36

git_branch RELEASE_3_8

git_last_commit e9cd022

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

hmyriB36 .

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

hmyriB36

representations of HapMap phaseII snp data + expression data

Description

representations of HapMap snp data + expression data

Usage

# getSS("hmyriB36", "20") # for example, to get full expression, + genotypes

# on chr20

Format

ExpressionSet and SnpMatrix instances to be combined using getSS

1

2

Details

hmyriB36

Instances of class smlSet are created from two basic sources.

First, the expression data for 90 YRI families were obtained from SANGER GENEVAR project.

Second, data on forward non-redundant SNPs in these individuals the HapMap build 36 ftp site
(r23a) in march 2008. Full provenance information still to be supplied.

Value

instances of class smlSet

Note

As of March 2011 the smlSet is no longer serialized. Instead, use getSS("hmyriB36", [chrs]) to
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
hmyriB36 = getSS("hmyriB36", c("20")) # just 1 chromosome
exprs(hmyriB36)[1:4,1:4]
as(smList(hmyriB36)[[1]][1:4,1:4], "character")
library(GGtools)
library(illuminaHumanv1.db)
cptag = get("CPNE1", revmap(illuminaHumanv1SYMBOL))
tt = eqtlTests(hmyriB36[probeId(cptag),] , ~male)
topFeats(probeId(cptag), mgr=tt, ffind=1)

Index

∗Topic packages

hmyriB36, 1

ex (hmyriB36), 1

getSS, 2

hmyriB36, 1
hmyriB36-package (hmyriB36), 1

smlSet, 2

3

