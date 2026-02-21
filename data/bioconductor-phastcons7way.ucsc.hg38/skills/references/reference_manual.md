phastCons7way.UCSC.hg38

February 11, 2026

phastCons7way.UCSC.hg38-package

Annotation package for UCSC human phastCons scores from 7 verte-
brate species

Description

This annotation package stores phastCons conservation scores from UCSC for the human genome
(hg38), calculated from genome-wide multiple alignments with other 99 vertebrate species. The
data are stored in the form of Rle objects and are loaded automatically as an object of class GScores.
The name of the exposed object matches the name of the package and part of the filename that
contained the data imported into the package. The class definition and methods to access GScores
objects are found in the GenomicScores software package.

Format

phastCons7way.UCSC.hg38 GScores object containing phastCons conservation scores from UCSC for the human genome (hg38) calculated from 7 vertebrate species and downloaded in March 2018 from http://genome.ucsc.edu.

Author(s)

R. Castelo

Source

Siepel A, Bejerano G, Pedersen JS, Hinrichs AS, Hou M, Rosenbloom K, Clawson H, Spieth J,
Hillier LW, Richards S, et al. Evolutionarily conserved elements in vertebrate, insect, worm, and
yeast genomes. Genome Res. 2005 Aug;15(8):1034-50. (http://www.genome.org/cgi/doi/10.1101/gr.3715005)

UCSC Genome Browser (URL: http://genome.ucsc.edu) [March, 2018, accessed]

See Also

GScores GenomicScores

1

phastCons7way.UCSC.hg38-package

2

Examples

library(GenomicRanges)
library(phastCons7way.UCSC.hg38)

ls("package:phastCons7way.UCSC.hg38")

phast <- phastCons7way.UCSC.hg38
phast
citation(phast)
gscores(phast, GRanges("chr7:117592326-117592330"))

Index

∗ data

phastCons7way.UCSC.hg38-package, 1

∗ package

phastCons7way.UCSC.hg38-package, 1

GenomicScores, 1
GScores, 1

phastCons7way.UCSC.hg38, 1
phastCons7way.UCSC.hg38

(phastCons7way.UCSC.hg38-package),
1

phastCons7way.UCSC.hg38-package, 1

Rle, 1

3

