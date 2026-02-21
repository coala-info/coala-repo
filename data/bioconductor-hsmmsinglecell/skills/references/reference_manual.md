Package ‘HSMMSingleCell’

Type Package

Title Single-cell RNA-Seq for differentiating human skeletal muscle

February 12, 2026

myoblasts (HSMM)

Version 1.30.0

Date 2014-03-11

Author Cole Trapnell

Maintainer Cole Trapnell <cole@broadinstitute.org>

Description Skeletal myoblasts undergo a well-characterized sequence of morphological and tran-

scriptional changes during differentiation. In this experiment, primary human skeletal mus-
cle myoblasts (HSMM) were expanded under high mitogen conditions (GM) and then differenti-
ated by switching to low-mitogen media (DM). RNA-Seq libraries were se-
quenced from each of several hundred cells taken over a time-course of serum-induced differenti-
ation. Between 49 and 77 cells were captured at each of four time points (0, 24, 48, 72 hours) fol-
lowing serum switch using the Fluidigm C1 microfluidic system. RNA from each cell was iso-
lated and used to construct mRNA-Seq libraries, which were then sequenced to a depth of ~4 mil-
lion reads per library, resulting in a complete gene expression profile for each cell.

License Artistic-2.0

biocViews ExperimentData, RNASeqData

LazyLoad yes

Depends R (>= 2.10)

git_url https://git.bioconductor.org/packages/HSMMSingleCell

git_branch RELEASE_3_22

git_last_commit 02d56cb

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

HSMMSingleCell-package . .
. .
.
HSMM .

.

.

.

.

.

.

.

.

Index

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3

4

1

2

HSMMSingleCell-package

HSMMSingleCell-package

A single-cell RNA-Seq study of differentiating human skeletal muscle
myoblasts

Description

Skeletal myoblasts undergo a well-characterized sequence of morphological and transcriptional
changes during differentiation. In this experiment, primary human skeletal muscle myoblasts (HSMM)
were expanded under high mitogen conditions (GM) and then differentiated by switching to low-
mitogen media (DM). RNA-Seq libraries were sequenced from each of several hundred cells taken
over a time-course of serum-induced differentiation. Between 49 and 77 cells were captured at each
of four time points (0, 24, 48, 72 hours) following serum switch using the Fluidigm C1 microfluidic
system. RNA from each cell was isolated and used to construct mRNA-Seq libraries, which were
then sequenced to a depth of approximately 4 million reads per library, resulting in a complete gene
expression profile for each cell.

For single-cell mRNA sequencing, dissociated cells were captured and processed with the C1
Single-Cell Auto Prep System (Fluidigm) following manufacturer’s protocol 100-5950. Starting
with a suspension of cells at a concentration of approximately 250 cells per microliter, up to 96
single cells are captured in each C1 microfluidic device. In this study, we used one C1 capture chip
at 0, 24, 48, and 72 hours after switching to differentiation medium, for a total of four indepen-
dent captures. After imaging with a microscope to identify which sites have captured a single cell,
processing of the cells occurs within the C1 instrument to perform the steps of cell lysis, cDNA
synthesis with reverse transcriptase, and PCR amplification of each cDNA library. The cDNA
synthesis and PCR use reagents from the SMARTer Ultra Low RNA Kit for Illumina Sequencing
(Clontech 634936). The SMARTer chemistry utilizes a strand-switching mechanism so that both
the 1st and 2nd strands of cDNA are synthesized in a single reaction. Following harvest from the
C1 microfluidic device, each cDNA library is subjected to tagmentation (simultaneous fragmen-
tation and tagging with sequencing adapters) using the Nextera XT DNA Sample Preparation Kit
(Illumina FC-131-1096) as described in Fluidigm protocol 100-5950. PCR amplification of the
tagmented cDNA uses Index Primers from the Nextera XT DNA Sample Preparation Index Kit
(Illumina FC-131-1002). Following PCR, the cDNA libraries from individual cells are pooled and
purified using AMPure XP beads (Agencourt Bioscience Corp A63880) as described in Fluidigm
protocol 100-5950. Libraries that contained fewer than 1 million reads or for which less than 80%
of fragments mapped to non-mitochondrial protein coding genes were excluded.

Details

Package: monocle
Package
Type:
0.99.0
Version:
2013-11-19
Date:
License: Artistic-2.0

Author(s)

Cole Trapnell Maintainer: Cole Trapnell <cole@broadinstitute.org>

HSMM

References

Trapnell, Cacchiarelli, et al

3

HSMM

Single-cell expression data for HSMM cells

Description

This dataset contains expression profiles from a time-series study of differentiating human skeletal
muscle myoblasts (HSMM). Expression values are in FPKM units, as calculated with the Cufflinks
package.

Usage

HSMM

Format

a CellDataSet object, as provided by the monocle package.

Author(s)

Cole Trapnell, 03-17-2014

Source

monocle

Index

∗ package

HSMMSingleCell-package, 2

HSMM, 3
HSMMSingleCell

(HSMMSingleCell-package), 2

HSMMSingleCell-package, 2

4

