Package ‘MMDiffBamSubset’

February 26, 2026

Type Package

Title Example ChIP-Seq data for the MMDiff package

Version 1.46.0

Date 2016-10-12

Author Gabriele Schweikert

Maintainer Gabriele Schweikert <G.Schweikert@ed.ac.uk>

Description Subset of BAM files, including WT_2.bam, Null_2.bam,

Resc_2.bam, Input.bam from the ``Cfp1'' experiment (see Clouaire et
al., Genes Dev. 2012). Data is available under ArrayExpress
accession numbers E-ERAD-79.
Additionally, corresponding subset of peaks called by MACS

biocViews ExperimentData, Genome, StemCell, Mus_musculus_Data,

DNASeqData, ChIPSeqData, ArrayExpress

Suggests MMDiff2

License LGPL

git_url https://git.bioconductor.org/packages/MMDiffBamSubset

git_branch RELEASE_3_22

git_last_commit 6bd89ce

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

MMDiffBamSubset-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

4

Index

1

2

MMDiffBamSubset-package

MMDiffBamSubset-package

Utilities returning the paths to the sample sheet Cfp1.csv,
to
the BAM files WT_2.bam, Null_2.bam, Resc_2.bam and In-
put.bam, as well as corresponding peak files WT_2_Macs_peaks.xls,
Null_2_Macs_peaks.xls Resc_2_Macs_peaks.xls

Description

Cfp1.csv Sample Sheet containing meta information about the experiment.

BAM files each containing subsets of original files with reads mapping to region ch1:3000000...75000000.
The data is available as part of ArrayExpress Experiment E-ERAD-79, which contains ChIP-Seq
of mice cells to assess the link between histone modification states of H3K4me3 with respect to the
mediator proteins Cfp1.

WT_2.bam: organism: Mus musculus; Cell type: ES cells, Immunoprecipitate: H3K4me3

Null_2.bam: organism: Mus musculus; Cell type: Cfp1 -/- ES cells, Immunoprecipitate: H3K4me3

Resc_2.bam: organism: Mus musculus; Cell type: Cfp1-/- ES cells and wtCfp1 rescue cDNA,
Immunoprecipitate: H3K4me3

Input.bam: organism: Mus musculus; input_DNA (pooled from different cell types)

WT.AB2, Null.AB2, Resc.AB2 and Input return the path to those files.

Additionally, subsets of peaks called by MACS[2] are provided.

WT.AB2.Peaks, Null.AB2.Peaks and Resc.AB2.Peaks return the path to the respective peak files.

Usage

Cfp1.Exp()
WT.AB2()
Null.AB2()
Resc.AB2()
Input()
WT.AB2.Peaks()
Null.AB2.Peaks()
Resc.AB2.Peaks()

Details

See the MMDiff package or [1] for details about the experiment (ChIP-seq, H3K4me3, Mus mus-
culus). BAM files contain single-end reads aligned to reference genome NBCI37/mm9

References

[1] Clouaire T et al.
H3K4me3 deposition in embryonic stem cells. Genes Dev. August 1, 2012 26: 1714–1728

(2012). Cfp1 integrates both CpG content and gene activity for accurate

[2] Zhang Y et al.
9(9):R137.

(20078). Model-based analysis of ChIP-Seq (MACS). Genome Biol 2008,

MMDiffBamSubset-package

3

Examples

Cfp1.Exp()
WT.AB2()
Null.AB2()
Resc.AB2()
Input()
WT.AB2.Peaks()
Null.AB2.Peaks()
Resc.AB2.Peaks()

Index

∗ utilities

MMDiffBamSubset-package, 2

Cfp1.Exp (MMDiffBamSubset-package), 2

Input (MMDiffBamSubset-package), 2

MMDiffBamSubset

(MMDiffBamSubset-package), 2

MMDiffBamSubset-package, 2

Null.AB2 (MMDiffBamSubset-package), 2

Resc.AB2 (MMDiffBamSubset-package), 2

WT.AB2 (MMDiffBamSubset-package), 2

4

