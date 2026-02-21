COHCAPanno: Illumina Methylation Array
Annotations for COHCAP

Charles Warden

October 30, 2025

COHCAP (City of Hope CpG Island Analysis Pipeline) is an algorithm to an-
alyze single-nucleotide resolution methylation data (Illumina 450k methylation
array, targeted BS-Seq, etc.). It provides QC metrics, differential methylation
for CpG Sites, differential methylation for CpG Islands, integration with gene
expression data, and visualization of methylation values.

In order to make analysis easier for Bioconductor users, pre-defined anno-
tation files for Illumina methylation arrays are created and saved in the CO-
HCAPanno package. Currently, COHCAPanno provides annotation for 27k and
450k arrays. Detailed descriptions for each annotation file can be found for each
individual file.

Targeted BS-Seq users should create custom annotation files based upon
their own data. Likewise, users with appropriate but non-standard bisulfite-
based methylation arrays can define custom annotation files (as defined in the
COHCAP package instructions).

> library("COHCAPanno")
> #450 array, UCSC CpG Islands
> data(COHCAP.450k.UCSC)
> #450k array, HMM CpG Islands
> data(COHCAP.450k.HMM)
> #27k array, UCSC CpG Islands
> data(COHCAP.27k)

1

