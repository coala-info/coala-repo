Package ‘Illumina450ProbeVariants.db’
February 12, 2026

Type Package

Title Annotation Package combining variant data from 1000 Genomes

Project for Illumina HumanMethylation450 Bead Chip probes

Version 1.46.0

Date 2013-10-07

Author Lee Butcher
Maintainer Tiffany Morris <tiffany.morris@ucl.ac.uk>

Description Includes details on variants for each probe on the 450k bead chip for each of the four pop-

ulations (Asian, American, African and European)

License GPL-3

Depends R (>= 3.0.1)

biocViews Homo_sapiens_Data, CancerData, ChipOnChipData, SNPData

git_url https://git.bioconductor.org/packages/Illumina450ProbeVariants.db

git_branch RELEASE_3_22

git_last_commit 5d24c32

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

Illumina450ProbeVariants.db-package . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
probe.450K.VCs.af .

. .

.

.

.

1
2

5

Index

Illumina450ProbeVariants.db-package

Annotation Package combining data from 1000 Genomes Project for
Illumina HumanMethylation450 Bead Chip probes

Description

Includes details on variants for each probe on the 450k bead chip for each of the four populations
(Asian, American, African and European)

1

2

Details

probe.450K.VCs.af

Package:
Type:
Version:
Date:
License: GPL-3

Illumina450ProbeVariants.db
Package
0.99.2
2013-10-07

Author(s)

Lee Butcher, UCL Cancer Institute, Medical Genomics
Maintainer: Tiffany Morris <tiffany.morris@ucl.ac.uk>

probe.450K.VCs.af

HumanMethylation450 variant details

Description

Data Package combining data from 1000 Genomes Project for Illumina HumanMethylation450
Bead Chip probes

Usage

data(probe.450K.VCs.af)

Format

A data frame with 485512 observations on the following 30 variables.

STRAND a factor with levels to indicate whether the variant is on the forward or reverse strand F R

INFINIUM_DESIGN_TYPE a factor with levels to indicate if the probe is Type I or Type II I II

CHR a factor with levels to indicate which chromosome the probe is located on 1 2 3 4 5 6 7 8 9 10

11 12 13 14 15 16 17 18 19 20 21 22 X Y

MAPINFO a numeric vector indicating the map location on the forward strand of the probed C

start a numeric vector indicating the start location of the probe on the forward strand

end a numeric vector indicating the end location of the probe on the forward strand

probe50VC.ASN a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the Asian (ASN) population with a frequency of >1%

probe10VC.ASN a numeric vector indicating how many variants are within 10 base pairs of the

probed CG in the Asian (ASN) population with a frequency of >1%

asn.af.F a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the forward (F) strand in the Asian (ASN)
population

asn.af.R a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the reverse (R) strand in the Asian (ASN)
population

probe.450K.VCs.af

3

probe50VC.AMR a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the American (AMR) population with a frequency of >1%

probe10VC.AMR a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the American (AMR) population with a frequency of >1%

amr.af.F a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the forward (F) strand in the American (AMR)
population

amr.af.R a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the reverse (R) strand in the American (AMR)
population

probe50VC.AFR a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the African (AFR) population with a frequency of >1%

probe10VC.AFR a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the African (AFR) population with a frequency of >1%

afr.af.F a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the forward (F) strand in the African (AFR)
population

afr.af.R a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the reverse (R) strand in the African (AFR)
population

probe50VC.EUR a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the European (EUR) population with a frequency of >1%

probe10VC.EUR a numeric vector indicating how many variants are within 50 base pairs of the

probed CG in the European (EUR) population with a frequency of >1%

eur.af.F a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the forward (F) strand in the European (EUR)
population

eur.af.R a numeric vector indicating the minor allele frequency (between 0-1%) for the occurance
of the variant on the probed CG dinucleotide on the reverse (R) strand in the European (EUR)
population

probe50VC.com1pop a numeric vector indicating how many variants are within 50 base pairs of
the probed CG and are found in at least one of the four populations with a frequency of >1%
probe10VC.com1pop a numeric vector indicating how many variants are within 10 base pairs of
the probed CG and are found in at least one of the four populations with a frequency of >1%
diVC.com1pop.F a factor with levels indicating which variant occurs on the probed CG dinu-
cleotide on the forward (F) strand in at least one of the four populations with a frequency
>1% INDEL SNP SV

diVC.com1pop.R a factor with levels indicating which variant occurs on the probed CG dinu-
cleotide on the reverse (R) strand in at least one of the four populations with a frequency
>1% INDEL SNP SV

probe50VC.all a numeric vector indicating how many variants are within 50 base pairs of the

probed CG and are common to all four populations with a frequency of >1%

probe10VC.all a numeric vector indicating how many variants are within 10 base pairs of the

probed CG and are common to all four populations with a frequency of >1%

diVC.all.F a factor with levels indicating which variant occurs on the probed CG dinucleotide on

the forward (F) strand in all four populations with a frequency >1% INDEL SNP SV

diVC.all.R a factor with levels indicating which variant occurs on the probed CG dinucleotide on

the reverse (R) strand in all four populations with a frequency >1% INDEL SNP SV

4

References

probe.450K.VCs.af

Genomes Project Consortia., Abecasis, G. R., Auton, A., Brooks, L. D., DePristo, M. A., Durbin,
R. M., Handsaker, R. E., Kang, H. M., Marth, G. T., and McVean, G. A. An integrated map of
genetic variation from 1,092 human genomes. Nature, 2012.

Examples

data(probe.450K.VCs.af)

Index

∗ datasets

probe.450K.VCs.af, 2

∗ package

Illumina450ProbeVariants.db-package,

1
450kProbeVariants

(Illumina450ProbeVariants.db-package),
1

Illumina450ProbeVariants.db

(Illumina450ProbeVariants.db-package),
1

Illumina450ProbeVariants.db-package, 1

probe.450K.VCs.af, 2

5

