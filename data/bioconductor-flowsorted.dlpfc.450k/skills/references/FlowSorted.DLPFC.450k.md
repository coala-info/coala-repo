FlowSorted.DLPFC.450k User’s Guide
A Public Illumina 450k Dataset

Andrew E. Jaffe

Modified: April 8, 2014. Compiled: November 4, 2025

1

Introduction

The FlowSorted.DLPFC.450k package contains publicly available Illumina HumanMethylation450
(“450k”) DNA methylation microarray data from a recent publication by Guintivano et al. 2013
[1], consisting of 58 samples, formatted as an RGChannelSet object for easy integration and
normalization using existing Bioconductor packages. For example, this dataset may be useful
“example” data for other packages exploring, normalizing, or analyzing DNA methylation data.

Researchers may find this package useful as these samples represent two different cellular
populations of brain tissue generated on the same 29 individuals using flow sorting, a experimental
procedure that can separate heterogeneous biological samples like brain into more pure cellular
populations, like neurons and non-neurons using NeuN labeling [2]. This data can be directly
integrated with the minfi Bioconductor package to estimate cellular composition in users’ frontal
cortex Illumina 450k samples using a modified version of the algorithm described in Houseman et
al. 2012 [3] and Guintivano et al 2013 [1].

References

[1] J. Guintivano, M. J. Aryee, and Z. A. Kaminsky. A cell epigenotype specific model for the
correction of brain cellular heterogeneity bias and its application to age, brain region and major
depression. Epigenetics, 8(3):290–302, 2013. doi:10.4161/epi.23924.

[2] A. Matevossian and S. Akbarian. Neuronal nuclei isolation from human postmortem brain

tissue. J Vis Exp, (20):914, 2008. doi:10.3791/914.

[3] Eugene A Houseman, William P Accomando, Devin C Koestler, Brock C Christensen, Car-
men J Marsit, Heather H Nelson, John K Wiencke, and Karl T Kelsey. Dna methylation ar-
rays as surrogate measures of cell mixture distribution. BMC Bioinformatics, 13(1):86, 2012.
doi:10.1186/1471-2105-13-86.

1

