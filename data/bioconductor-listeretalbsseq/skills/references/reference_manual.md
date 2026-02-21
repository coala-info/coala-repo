Package ‘ListerEtAlBSseq’

Title BS-seq data of H1 and IMR90 cell line excerpted from Lister et

February 12, 2026

al. 2009

Version 1.42.0

Date 2015-04-02

Description Base resolution bisulfite sequencing data of Human DNA methylomes

Depends R (>= 3.1.1), methylPipe

Suggests BSgenome.Hsapiens.UCSC.hg18

License Artistic 2.0

biocViews ExperimentData, Homo_sapiens_Data, SequencingData

git_url https://git.bioconductor.org/packages/ListerEtAlBSseq

git_branch RELEASE_3_22

git_last_commit fafe5e3

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Author Mattia Pelizzola [aut],
Kamal Kishore [aut],
Mattia Furlan [ctb, cre]

Maintainer Mattia Furlan <mattia.furlan@iit.it>

Contents

H1.WGBS .
.
IMR90.WGBS .

.

.

Index

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

2
2

3

1

2

IMR90.WGBS

H1.WGBS

BS-seq data of H1 cell line

Description

BS-seq data of H1 cell line from Lister et al. 2009

Details

This is the BS-seq dataset of H1 cell line (Lister et al. 2009). The dataset has been stored in BSdata
class of package methylPipe and can directly be used for further analysis using the package.

Examples

library(BSgenome.Hsapiens.UCSC.hg18)
h1data <- system.file('extdata', 'mc_h1_tabix.txt.gz', package='ListerEtAlBSseq')
h1uncov <- system.file('extdata', 'uncov_GR_h1.Rdata', package='ListerEtAlBSseq')
load(h1uncov)
H1.WGBS <- BSdata(file=h1data, uncov=uncov_GR_h1, org=Hsapiens)

IMR90.WGBS

BS-seq data of IMR90 cell line

Description

BS-seq data of IMR90 cell line from Lister et al. 2009

Details

This is the BS-seq dataset of IMR90 cell line (Lister et al. 2009). The dataset has been stored in
BSdata class of package methylPipe and can directly be used for further analysis using the package.

Examples

library(BSgenome.Hsapiens.UCSC.hg18)
imr90data <- system.file('extdata', 'mc_i90_tabix.txt.gz', package='ListerEtAlBSseq')
imr90uncov <- system.file('extdata', 'uncov_GR_imr90.Rdata', package='ListerEtAlBSseq')
load(imr90uncov)
IMR90.WGBS <- BSdata(file=imr90data, uncov=uncov_GR_imr90, org=Hsapiens)

Index

∗ datasets

H1.WGBS, 2
IMR90.WGBS, 2

H1.WGBS, 2

IMR90.WGBS, 2

3

