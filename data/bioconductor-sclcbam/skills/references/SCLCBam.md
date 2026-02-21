SCLCBam: Sequence data from chromosome
4 of a small-cell lung tumor.

Thomas Kuilman

November 4, 2025

Department of Molecular Oncology
Netherlands Cancer Institute
The Netherlands

t.kuilman@nki.nl or thomaskuilman@yahoo.com

Contents

1

2

Usage .

.

.

Reference .

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

1

1

1

Usage

To obtain the full path to the .bam file, use the getPathBamFolder() function:

> library(SCLCBam)

> getPathBamFolder()

/tmp/RtmpmRekIA/Rinst88b241e4dca69/SCLCBam/extdata

The .bam file is provided as experimental data for the CopywriteR package, which uses
off-target reads from targeted sequencing for copy number detection.

2

Reference

The dataset was downloaded from the European Nucleotide Archive using the accession
number PRJEB6954 using sample accession number SAMEA2697779, and off-target reads
on chromosome 4 were extracted. The full .bam file containing data for all chromosomes can
be downloaded from http://www.ebi.ac.uk/ena/data/view/SAMEA2697779.

