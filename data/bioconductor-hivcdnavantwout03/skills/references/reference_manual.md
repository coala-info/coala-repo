Package ‘HIVcDNAvantWout03’

February 12, 2026

Version 1.50.0

Date 2005-01-31

Author Dr. Angelique van't Wout, Department of Microbiology,

University of Washington

Title T cell line infections with HIV-1 LAI (BRU)

Description The expression levels of approximately 4600 cellular RNA
transcripts were assessed in CD4+ T cell lines at different
times after infection with HIV-1BRU using DNA microarrays.
This data corresponds to the first block of a 12 block array
image (001030_08_1.GEL) in the first data set (2000095918 A)
in the first experiment (CEM LAI vs HI-LAI 24hr).
There are two data sets, which are part of a dye-swap
experiment with replicates, representing the Cy3 (green)
absorption intensities for channel 1 (hiv1raw) and the
Cy5 (red) absorption intensities for channel 2 (hiv2raw).

biocViews ExperimentData, MicroarrayData, TwoChannelData, HIVData

License GPL (>= 2)

Maintainer Chris Fraley <fraley@stat.washington.edu>

URL http://expression.microslu.washington.edu/expression/vantwoutjvi2002.html

git_url https://git.bioconductor.org/packages/HIVcDNAvantWout03

git_branch RELEASE_3_22

git_last_commit 1ea6052

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

hiv1raw .
hiv2raw .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2

4

Index

1

2

hiv2raw

hiv1raw

T cell line infections with HIV-1 LAI (BRU)

Description

The expression levels of approximately 4600 cellular RNA transcripts were assessed in CD4+ T
cell lines at different times after infection with HIV-1BRU using DNA microarrays. There are two
data sets, which are part of a dye-swap experiment with replicates, representing the Cy3 (green)
absorption intensities for channel 1 (hiv1raw) and the Cy5 (red) absorption intensities for channel
2 (hiv2raw).

Usage

data(hiv1raw)

Format

This data represents a block within a microarray image with 12x32 spots. It is stored as a vector
of length 450,000 representing a 450x1000 matrix (ordered by column) of intensities encoded for
compact (16-bit TIFF) storage.

Details

The intensities can be obtained from this data by first subtracting them from 65535, then squaring,
then multiplying by a scale factor 4.71542407E-05. In other words, a number x in the hiv1 data set
corresponds to intensity (256 ∗ 256 − 1 − x)2 ∗ .0000471542407.

Source

Dr. Angelique van’t Wout, Department of Microbiology, University of Washington

The data corresponds to the first block of a 12 block array image (‘001030\_08\_1.GEL’) in the first
data set (‘2000095918 A’) in the first experiment (‘CEM LAI vs HI-LAI 24hr’) of the following data
archive: http://expression.microslu.washington.edu/expression/vantwoutjvi2002.html

References

van’t Wout AB, Lehrman GK, Mikheeva SA, O’Keeffe GC, Katze MG, Bumgarner RE, Geiss GK
and Mullins JI, Cellular gene expression upon human immunodeficiency virus type 1 infection of
CD4(+)-T-cell lines, J Virol. 2003 Jan;77(2):1392-402.a

hiv2raw

T cell line infections with HIV-1 LAI (BRU)

Description

The expression levels of approximately 4600 cellular RNA transcripts were assessed in CD4+ T
cell lines at different times after infection with HIV-1BRU using DNA microarrays. There are two
data sets, which are part of a dye-swap experiment with replicates, representing the Cy3 (green)
absorption intensities for channel 1 (hiv1raw) and the Cy5 (red) absorption intensities for channel
2 (hiv2raw).

hiv2raw

Usage

data(hiv2raw)

Format

3

This data represents a block within a microarray image with 12x32 spots. It is stored as a vector
of length 450,000 representing a 450x1000 matrix (ordered by column) of intensities encoded for
compact (16-bit TIFF) storage.

Details

The intensities can be obtained from this data by first subtracting them from 65535, then squaring,
then multiplying by a scale factor 4.71542407E-05. In other words, a number x in the hiv1 data set
corresponds to intensity (256 ∗ 256 − 1 − x)2 ∗ .0000471542407.

Source

Dr. Angelique van’t Wout, Department of Microbiology, University of Washington

The data corresponds to the first block of a 12 block array image (‘001030\_08\_1.GEL’) in the first
data set (‘2000095918 A’) in the first experiment (‘CEM LAI vs HI-LAI 24hr’) of the following data
archive:\ http://expression.microslu.washington.edu/expression/vantwoutjvi2002.html

References

van’t Wout AB, Lehrman GK, Mikheeva SA, O’Keeffe GC, Katze MG, Bumgarner RE, Geiss GK
and Mullins JI, Cellular gene expression upon human immunodeficiency virus type 1 infection of
CD4(+)-T-cell lines, J Virol. 2003 Jan;77(2):1392-402.

Index

∗ datasets

hiv1raw, 2
hiv2raw, 2

hiv1raw, 2
hiv2raw, 2

4

