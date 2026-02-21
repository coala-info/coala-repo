fitCons.UCSC.hg19

February 11, 2026

fitCons.UCSC.hg19-package

Annotation package for UCSC human fitCons scores of fitness conse-
quence of functional annotations

Description

This annotation package stores fitCons scores from UCSC for the human genome (hg19), corre-
sponding to fitness consequences of functional annotations. The data are stored in the form of Rle
objects and are loaded automatically as an object of class GScores. The name of the exposed ob-
ject matches the name of the package and part of the filename that contained the data imported
into the package. The class definition and methods to access GScores objects are found in the
GenomicScores software package.

Format

fitCons.UCSC.hg19 GScores object containing fitCons conservation scores from UCSC for the human genome (hg19) downloaded on March 2018 from http://http://siepellab.labsites.cshl.edu.

Author(s)

R. Castelo

Source

Gulko B, Gronau I, Hubisz MJ, Siepel A. Probabilities of fitness consequences for point mutations
across the human genome. Nat. Genet. 2015 Aug;47:276-83. (http://www.nature.com/ng/journal/v47/n3/full/ng.3196.html)

CSHL website of the Siepel Lab (URL: http://http://siepellab.labsites.cshl.edu) [March,
2018, accessed]

See Also

GScores GenomicScores

1

fitCons.UCSC.hg19-package

2

Examples

library(GenomicRanges)
library(fitCons.UCSC.hg19)

ls("package:fitCons.UCSC.hg19")

fitcons <- fitCons.UCSC.hg19
citation(fitcons)
gscores(fitcons, GRanges("chr7:117232380-117232384"))

Index

∗ data

fitCons.UCSC.hg19-package, 1

∗ package

fitCons.UCSC.hg19-package, 1

fitCons.UCSC.hg19, 1
fitCons.UCSC.hg19

(fitCons.UCSC.hg19-package), 1

fitCons.UCSC.hg19-package, 1

GenomicScores, 1
GScores, 1

Rle, 1

3

