miRNAtap.db: microRNA Targets -
Aggregated Predictions database use

Maciej Pajak, T. Ian Simpson

September 26, 2016

Contents

1 Introduction

2 Installation

3 Workﬂow

4 Session Information

References

2

2

2

2

3

1

1

Introduction

miRNAtap.db package provides annotation data for miRNAtap performing target
prediction aggregation. Aggregation of commonly used prediction algorithm
outputs in a way that improves on performance of every single one of them on
their own when compared against experimentally derived targets.

Targets are aggregated from 5 most commonly cited prediction algorithms:
DIANA (Maragkakis et al., 2011), Miranda (Enright et al., 2003), PicTar (Lall
et al., 2006), TargetScan (Friedman et al., 2009), and miRDB (Wong and Wang,
2015).

To read more about miRNA target prediction methods used refer to the

miRNAtap package vignette available from http://www.bioconductor.org .

2

Installation

This section brieﬂy describes the necessary steps to get miRNAtap.db run-
ning on your system. We assume that the user has the R program (see the
R project at http://www.r-project.org) already installed and is familiar with
it. You will need to have R 3.2.0 or later to be able to install and run miR-
NAtap.db. The miRNAtap package is available from the Bioconductor repos-
itory at http://www.bioconductor.org To be able to install the package one
needs ﬁrst to install the core Bioconductor packages. If you have already in-
stalled Bioconductor packages on your system then you can skip the two lines
below.

> source("http://bioconductor.org/biocLite.R")
> biocLite()

Once the core Bioconductor packages are installed, we can install the miR-

NAtap package by

> source("http://bioconductor.org/biocLite.R")
> biocLite("miRNAtap.db")

3 Workﬂow

For the information about how to use the miRNA target data refer to the
miRNAtap package vignette available from http://www.bioconductor.org.

4 Session Information

(cid:136) R version 3.3.1 (2016-06-21), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_GB.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_GB.UTF-8, LC_MESSAGES=en_GB.UTF-8,

2

LC_PAPER=en_GB.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_GB.UTF-8, LC_IDENTIFICATION=C

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, stats, utils

(cid:136) Loaded via a namespace (and not attached): tools 3.3.1

References

Enright, A. J., John, B., Gaul, U., Tuschl, T., Sander, C., and Marks, D. S.

(2003). MicroRNA targets in Drosophila. Genome biology, 5(1):R1.

Friedman, R. C., Farh, K. K.-H., Burge, C. B., and Bartel, D. P. (2009). Most
mammalian mRNAs are conserved targets of microRNAs. Genome research,
19(1):92–105.

Lall, S., Grun, D., Krek, A., Chen, K., Wang, Y.-L., Dewey, C. N., Sood,
P., Colombo, T., Bray, N., Macmenamin, P., Kao, H.-L., Gunsalus, K. C.,
Pachter, L., Piano, F., and Rajewsky, N. (2006). A genome-wide map of
conserved microRNA targets in C. elegans. Current biology : CB, 16(5):460–
71.

Maragkakis, M., Vergoulis, T., Alexiou, P., Reczko, M., Plomaritou, K., Gousis,
M., Kourtis, K., Koziris, N., Dalamagas, T., and Hatzigeorgiou, A. G. (2011).
DIANA-microT Web server upgrade supports Fly and Worm miRNA target
prediction and bibliographic miRNA to disease association. Nucleic acids
research, 39(Web Server issue):W145–8.

Wong, N. and Wang, X. (2015). miRDB: An online resource for microRNA
target prediction and functional annotations. Nucleic Acids Research, 43,
Database Issue.

3

