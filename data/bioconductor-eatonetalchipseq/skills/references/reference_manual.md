Package ‘EatonEtAlChIPseq’

February 12, 2026

Title ChIP-seq data of ORC-binding sites in Yeast excerpted from Eaton

et al. 2010

Description ChIP-seq analysis subset from ``Conserved nucleosome positioning

defines replication origins'' (PMID 20351051)

Version 0.48.0

Author Patrick Aboyoun <paboyoun@fhcrc.org>

Maintainer Patrick Aboyoun <paboyoun@fhcrc.org>

Depends GenomicRanges (>= 1.5.42), ShortRead, rtracklayer

License Artistic 2.0

biocViews ExperimentData, Saccharomyces_cerevisiae_Data,

SequencingData, ChIPSeqData, GEO

git_url https://git.bioconductor.org/packages/EatonEtAlChIPseq

git_branch RELEASE_3_22

git_last_commit 17b8b47

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

orcAligns .
.
orcPeaks .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1
2

4

Index

orcAligns

Alignments of ChIP-seq data to yeast chromosome XIV

Description

MAQ alignments to yeast chromosome XIV of ChIP-seq data of ORC-binding sites in yeast from
Eaton et al. 2010

1

2

Usage

data(orcAlignsRep1)
data(orcAlignsRep2)

Details

orcPeaks

This is the subset of alignments from two ChIP-seq replicates of origin recognition complex (ORC)
binding to chromosome XIV of Saccharomyces cerevisiae. The alignments were created using
MAQ (Li et al. 2008) alignment software with a maximum mismatch of 3 bases and a minimum
Phred quality score of 35.

Source

MAQ alignments extracted from ftp://ftp.ncbi.nih.gov/pub/geo/DATA/supplementary/samples/
GSM424nnn/GSM424494/GSM424494_wt_G2_orc_chip_rep1.mapview.txt.gz and ftp://ftp.ncbi.
nih.gov/pub/geo/DATA/supplementary/samples/GSM424nnn/GSM424494/GSM424494_wt_G2_orc_
chip_rep2.mapview.txt.gz

References

Conserved nucleosome positioning defines replication origins. Eaton ML, Galani K, Kang S, Bell
SP, MacAlpine DM. Genes Dev. 2010 Apr 15;24(8):748-53.

Examples

data(orcAlignsRep1)
data(orcAlignsRep2)

orcAlignsRep1
orcAlignsRep2

orcPeaks

Peaks from ChIP-seq alignments to yeast chromosome XIV

Description

Peaks on yeast chromosome XIV of ChIP-seq data of ORC-binding sites in yeast from Eaton et al.
2010

Usage

data(orcPeaksRep1)
data(orcPeaksRep2)

Details

This is the subset of Saccharomyces cerevisiae chromosome XIV peaks from two ChIP-seq repli-
cates of a origin recognition complex (ORC) binding experiment.

orcPeaks

Source

3

ChIP-seq peaks extracted from ftp://ftp.ncbi.nih.gov/pub/geo/DATA/supplementary/samples/
GSM424nnn/GSM424494/GSM424494_wt_G2_orc_chip_rep1.bed.gz and ftp://ftp.ncbi.nih.
gov/pub/geo/DATA/supplementary/samples/GSM424nnn/GSM424494/GSM424494_wt_G2_orc_chip_
rep2.bed.gz

References

Conserved nucleosome positioning defines replication origins. Eaton ML, Galani K, Kang S, Bell
SP, MacAlpine DM. Genes Dev. 2010 Apr 15;24(8):748-53.

Examples

data(orcPeaksRep1)
data(orcPeaksRep2)

Index

∗ datasets

orcAligns, 1
orcPeaks, 2

orcAligns, 1
orcAlignsRep1 (orcAligns), 1
orcAlignsRep2 (orcAligns), 1
orcPeaks, 2
orcPeaksRep1 (orcPeaks), 2
orcPeaksRep2 (orcPeaks), 2

4

