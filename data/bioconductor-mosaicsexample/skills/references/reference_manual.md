Package ‘mosaicsExample’

February 26, 2026

Type Package

Title Example data for the mosaics package, which implements MOSAiCS
and MOSAiCS-HMM, a statistical framework to analyze one-sample
or two-sample ChIP-seq data for transcription factor binding
and histone modification

Version 1.48.0

Depends R (>= 2.11.1)

Date 2015-04-30

Author Dongjun Chung, Pei Fen Kuan, Rene Welch, Sunduz Keles

Maintainer Dongjun Chung <dongjun.chung@gmail.com>

Description Data for the mosaics package, consisting of (1) chromosome 22 ChIP and control sam-

ple data from a ChIP-seq experiment of STAT1 binding and H3K4me3 modifica-
tion in MCF7 cell line from ENCODE database (HG19) and (2) chromosome 21 ChIP and con-
trol sample data from a ChIP-seq experiment of STAT1 binding, with mappability, GC con-
tent, and sequence ambiguity scores of human genome HG18.

License GPL (>= 2)

URL http://groups.google.com/group/mosaics_user_group

LazyLoad yes

biocViews ExperimentData, ChIPseqData, Homo_sapiens

git_url https://git.bioconductor.org/packages/mosaicsExample

git_branch RELEASE_3_22

git_last_commit a221875

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

exampleBinData

.

.

.

.

.

. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

exampleBinData

exampleBinData

STAT1 ChIP-seq Dataset

Description

This is the STAT1 ChIP-seq dataset used in Kuan et al. (2010).

Usage

data(exampleBinData)

Format

BinData class object containing bin-level ChIP data, control sample data, mappability score, GC
content score, and sequence ambiguity score.

Details

ChIP data and control sample data are chromosome 21 data from a ChIP-seq experiment of STAT1
binding in interferon-gamma-stimulated HeLa S3 cells (Rozowsky et al., 2009). Mappability score,
GC content score, and sequence ambiguity score are calculated from human genome HG18. See
the vignette of R package mosaics and Kuan et al. (2010) for more details.

Source

Rozowsky, J, G Euskirchen, R Auerbach, D Zhang, T Gibson, R Bjornson, N Carriero, M Snyder,
and M Gerstein (2009), "PeakSeq enables systematic scoring of ChIP-Seq experiments relative to
controls", Nature Biotechnology, 27, pp. 66–75.

References

Kuan, PF, D Chung, JA Thomson, R Stewart, and S Keles (2010), "A Statistical Framework for the
Analysis of ChIP-Seq Data", submitted (http://works.bepress.com/sunduz_keles/19/).

Examples

## Not run:
data(exampleBinData)
library(mosaics)
exampleBinData

## End(Not run)

Index

∗ datasets

exampleBinData, 2

exampleBinData, 2

3

