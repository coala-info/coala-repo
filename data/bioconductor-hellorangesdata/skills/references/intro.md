Data for the HelloRanges Tutorial

Michael Lawrence ∗

Genentech
∗

michafla@gene.com

November 4, 2025

Package

HelloRangesData 1.36.0

Contents

1

Overview.

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

2

HelloRanges Data

1

Overview

In support of the tutorial vignette for the HelloRanges package, HelloRangesData provides an
experimental dataset on DnaseI hypersensitivity [1], as well as several annotation tracks down-
loaded from the UCSC genome browser. The files were made available as part of the bedtools
tutorial (http://quinlanlab.org/tutorials/bedtools/bedtools.html) by Aaron Quinlan.

The data are stored in files here:

> dir(system.file("extdata", package="HelloRangesData"))

[1] "cpg.bed"

[2] "exons.bed"

[3] "fBrain-DS14718.hotspot.twopass.fdr0.05.merge.bed"

[4] "fBrain-DS16302.hotspot.twopass.fdr0.05.merge.bed"

[5] "fHeart-DS15643.hotspot.twopass.fdr0.05.merge.bed"

[6] "fHeart-DS15839.hotspot.twopass.fdr0.05.merge.bed"

[7] "fHeart-DS16621.hotspot.twopass.fdr0.05.merge.bed"
[8] "fIntestine_Sm-DS16559.hotspot.twopass.fdr0.05.merge.bed"
[9] "fIntestine_Sm-DS16712.hg19.hotspot.twopass.fdr0.05.merge.bed"
[10] "fIntestine_Sm-DS16822.hotspot.twopass.fdr0.05.merge.bed"
[11] "fIntestine_Sm-DS17808.hg19.hotspot.twopass.fdr0.05.merge.bed"
[12] "fIntestine_Sm-DS18495.hg19.hotspot.twopass.fdr0.05.merge.bed"
[13] "fKidney_renal_cortex_L-DS17550.hg19.hotspot.twopass.fdr0.05.merge.bed"
[14] "fLung_L-DS17154.hg19.hotspot.twopass.fdr0.05.merge.bed"
[15] "fLung_L-DS18421.hg19.hotspot.twopass.fdr0.05.merge.bed"
[16] "fLung_R-DS15632.hotspot.twopass.fdr0.05.merge.bed"
[17] "fMuscle_arm-DS19053.hg19.hotspot.twopass.fdr0.05.merge.bed"
[18] "fMuscle_back-DS18454.hg19.hotspot.twopass.fdr0.05.merge.bed"
[19] "fMuscle_leg-DS19115.hg19.hotspot.twopass.fdr0.05.merge.bed"
[20] "fMuscle_leg-DS19158.hg19.hotspot.twopass.fdr0.05.merge.bed"
[21] "fSkin_fibro_bicep_R-DS19745.hg19.hotspot.twopass.fdr0.05.merge.bed"
[22] "fStomach-DS17659.hg19.hotspot.twopass.fdr0.05.merge.bed"

[23] "gwas.bed"

[24] "hesc.chromHmm.bed"

[25] "hg19.genome"

There are 20 BED files from the DnaseI study, as well as BED files representing the CpG
islands (‘cpg.bed’), Refseq exons (‘exons.bed’), disease-associated SNPs (‘gwas.bed’), and
functional annotations output by chromHMM given ENCODE human embrionic stem cell
ChIP-seq data (‘hesc.chromHmm.bed’). There is also a ‘hg19.genome’ file indicating the chro-
mosome lengths of the hg19 genome build.

Please see the HelloRanges vignette to learn how to work with these data with Bioconductor .

References

[1] Matthew T Maurano, Richard Humbert, Eric Rynes, Robert E Thurman, Eric Haugen,
Hao Wang, Alex P Reynolds, Richard Sandstrom, Hongzhu Qu, Jennifer Brody, et al.
Systematic localization of common disease-associated variation in regulatory dna.
Science, 337(6099):1190–1195, 2012.

2

