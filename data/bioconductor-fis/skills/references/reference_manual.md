Package ‘FIs’

February 12, 2026

Title Human Functional Interactions (FIs) for splineTimeR package

Version 1.38.0

Date 2020-04-14

Author Agata Michna

Maintainer Herbert Braselmann <hbraselmann@online.de>, Martin Selmans-

berger <martin.selmansberger@helmholtz-muenchen.de>

Depends R (>= 3.3)

Description Data set containing two complete lists of identified

functional interaction partners in Human. Data are derived from
Reactome and BioGRID databases.

License GPL-3

biocViews PathwayInteractionDatabase, Homo_sapiens_Data

NeedsCompilation no

git_url https://git.bioconductor.org/packages/FIs

git_branch RELEASE_3_22

git_last_commit f7fb01f

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

FIs .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

FIs

Description

Human Functional Interactions (FIs)

1

3

Data set with two complete lists of identified functional interaction partners in Human. Data are
derived from Reactome and BioGRID databases.

1

2

Usage

data(FIs)

Format

FIs

A list of two data frames with two columns describing interaction partners.

FIs_Reactome functional interactions derived from Reactome database

FIs_BioGRID functional interactions derived from BioGRID database

Details

The data sets contain unique interaction pairs. Self-loops are not considered.

Value

A list of two data frames.

Source

Reactome functional interaction pairs. Retrieved December 3, 2015 from http://www.reactome.
org/pages/download-data/

BioGRID functional interaction pairs. Retrieved December 3, 2015 from http://thebiogrid.
org/download.php

References

Croft, D., Mundo, A. F., Haw R., Milacic, M., Weiser, J., Wu, G., Caudy, M., Garapati, P., Gille-
spie, M., Kamdar, M. R., Jassal, B., Jupe, S., Matthews, L., May, B., Palatnik, S., Rothfels, K.,
Shamovsky, V., Song, H., Williams, M., Birney, E., Hermjakob, H., Stein, L., D’Eustachio, P.
(2014). The Reactome pathway knowledgebase. Nucleic Acids Research 42(Database issue), 472-
477.

Stark, C., Breitkreutz, B.-J., Reguly, T. Boucher, L., Breitkreutz, A., Tyers, M. (2006). BioGRID: a
general repository for interaction datasets. Nucleic Acids Research 34(Database issue), 535-539.

Examples

data(FIs)
names(FIs)
head(FIs$FIs_Reactome)
head(FIs$FIs_BioGRID)

Index

∗ datasets
FIs, 1

FIs, 1

3

