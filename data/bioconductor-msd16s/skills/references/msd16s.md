Moderate-to-Severe diarrhea 16S dataset

November 4, 2025

This data package contains the information used to run the analyses found in "Di-
arrhea in young children from low-income countries leads to large-scale alterations in
intestinal microbiota composition". Measurements are the number of reads annotated
for a particular cluster within a given sample followed by filtering. Sequencing was per-
formed on the 454 Flex platform. Data is stored as an MRexperiment-class object. The
count matrix was generated using DNAclust (http://dnaclust.sourceforge.net/). For
more details please refer to the paper.

The help file ?msd16s describes the example dataset.

1 The Data

We start by loading the library and the data.

> suppressMessages(library(metagenomeSeq))
> library(msd16s)
> data(msd16s)

This will load the msd16s object of class MRexperiment. As described in the metagenomeSeq

vignette, print (or show) will display summary information.

> msd16s

MRexperiment (storageMode: environment)
assayData: 26044 features, 992 samples

element names: counts

protocolData: none
phenoData

sampleNames: 100259 100262 ... 602385 (992 total)
varLabels: Type Country ... Dysentery (5 total)
varMetadata: labelDescription

featureData

featureNames: 54 94 ... 276421 (26044 total)

1

fvarLabels: superkingdom phylum ... clusterCenter (10 total)
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

The data in msd16s is the substrate for the analysis described in "Diarrhea in young
children from low-income countries leads to large-scale alterations in intestinal micro-
biota composition". Included in the MRexperiment object are the counts, phenotype
and feature information.

The phenotype information can be accessed with the phenoData and pData methods:

> phenoData(msd16s)

An object of class 'AnnotatedDataFrame'

sampleNames: 100259 100262 ... 602385 (992 total)
varLabels: Type Country ... Dysentery (5 total)
varMetadata: labelDescription

> head(pData(msd16s))

Type Country Age AgeFactor Dysentery
1
100259
Case
0
100262 Control
0
Case
100267
0
Case
100274
0
Case
100275
0
Case
100277

Gambia
14
Gambia 24
17
Gambia
36
Gambia
29
Gambia
29
Gambia

[12,18)
[24,60)
[12,18)
[24,60)
[24,60)
[24,60)

The feature information including cluster representative sequence can be accessed

with the featureData and fData methods:

> featureData(msd16s)

An object of class 'AnnotatedDataFrame'

featureNames: 54 94 ... 276421 (26044 total)
varLabels: superkingdom phylum ... clusterCenter (10 total)
varMetadata: labelDescription

> head(fData(msd16s))

superkingdom
Bacteria
Bacteria
Bacteria

54
94
113

phylum
Firmicutes
Firmicutes
Firmicutes

class

family
order
Bacilli Lactobacillales Lactobacillaceae
Bacilli Lactobacillales Lactobacillaceae
Bacilli Lactobacillales Lactobacillaceae

2

117
145
202

Bacteria
Firmicutes
Bacteria Bacteroidetes Bacteroidia
Bacteria Bacteroidetes Bacteroidia

Bacilli Lactobacillales Lactobacillaceae
Prevotellaceae
Bacteroidaceae

Bacteroidales
Bacteroidales

genus

species OTU
54
Lactobacillus Lactobacillus sp. TSK G32-2
54
94
94
Lactobacillus Lactobacillus sp. TSK G32-2
113 Lactobacillus Lactobacillus sp. TSK G32-2 113
117 Lactobacillus Lactobacillus sp. TSK G32-2 117
Prevotella sp. DJF_RP53 145
145
Bacteroides fragilis 202
202

Prevotella
Bacteroides

;cellular organisms;Bacteria;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;Lactobacillus sp. TSK G32-2
54
;cellular organisms;Bacteria;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;Lactobacillus sp. TSK G32-2
94
;cellular organisms;Bacteria;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;Lactobacillus sp. TSK G32-2
113
117
;cellular organisms;Bacteria;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;Lactobacillus sp. TSK G32-2
145 ;cellular organisms;Bacteria;Bacteroidetes/Chlorobi group;Bacteroidetes;Bacteroidia;Bacteroidales;Prevotellaceae;Prevotella;Prevotella sp. DJF_RP53
;cellular organisms;Bacteria;Bacteroidetes/Chlorobi group;Bacteroidetes;Bacteroidia;Bacteroidales;Bacteroidaceae;Bacteroides;Bacteroides fragilis
202

Taxonomy

54
94
113
117
145
202

CATGCTGCCTCCCGTAGGAGTTTGGGCCGTGTCTCAGTCCCAATGTGGCCGATCAACCTCTCAGTTCGGCTACGTATCATCACCTTGGTAGGCCGTTACCCCACCAACAAGTTAATACGCCGCAGGCCCATCCAAAAGTGACAGCAAAAAGCCCGTCTTTTTACACTAGTAACGAACTACTACTAGTCGGGTCGGGTTTCGTTACTAGGTTTAGGTTTAGTCGGGTACGGTTTAAGTTACGACCCTACCGTTTTCCGTTTAACCGTAAGGTTTAGTTTACCCCCTTTCCCCCTTTTTCGGGTTTTCGGGACGGTTAGGGTTCCGTACCCGTTACGGTTTACGTTTACCTACCCCGTTACCCCGGTTCCCG
CATGCTGCCTCCCGTAGGAGTTTGGGCCGTGTCTCAGTCCCAATGTGGCCGATCAACCTCTCAGTTCGGCTACGTATCATCACCTTGGTAGGCCGTTACCCCACCAACAAGTTAATACGCCGCAGGCCCATCCAAAAGTGACAGCAAAAAGCCGTCTTTTACACTAGTACAACTACTACTAGTCGGGTCGGGTTTCGTTACTAGGTTTAGGTTTAGTCGGGTACGGTTTAAGTTACGACCCTACCGTTTTCCGTTAACCGTAAGGTTTACGTTTACCCCCTTTCCCCCTTTTCGGGTTTTCGGGACGGTTAGGGTTCCGTACCCGTTACGGTTTACGTTTACCTACCCCG
CATGCTGCCTCCCGTAGGAGTTTGGGCCGTGTCTCAGTCCCAATGTGGCCGATCAACCTCTCAGTTCGGCTACGTATCATCACCTTGGTAGGCCGTTACCCCACCAACAAGTTAATACGCCGCAGGCCCATCCAAAAGTGACAGCAAAAAGCCGTCTTTTTACACTAGTACGAACTACTACTAGTCGGGTCGGGTTTCGTTACTAGGTTTAGGTTTAGTCGGGTACGGTTTAAGTTACGACCCTACCGTTTTCCGTTTAACCGTAAGGTTTACGTTTACCCCCTTCCCCCGTTTTTCGGGTTTTCGGGACGGTTAGGGTTCCGTACCCGTTACGGTTTACGTTTA
CATGCTGCCTCCCGTAGGAGTTTGGGCCGTGTCTCAGTCCCAATGTGGCCGATCAACCTCTCAGTTCGGCTACGTATCATCACCTTGGTAGGCCGTTACCCCACCAACAAGTTAATACGCCGCAGGCCCATCCAAAAGTGACAGCAAAAGCCGTCTTTTACACTAGTACGAACTACTACTAGTCGGGTCGGGTTTCGTTACTAGGTTTAGGTTTAGTCGGGTACGGTTTAAGTTACGTACCCTACCGTTTCCGTTAACCGTAAGGTTTACGTTTACCCCCTTCCCCCGTTTTCGGGTTTCGGTACGGTTACGGGTTCCGTACCCGTTACGGTTTACCGTTACCG
CATGCTGCCTCCCGTAGGAGTTTGGACCGTGTCTCAGTTCCAATGTGGGGGACCTTCCTCTCAGAACCCCTACTGATCGTCGCCTTGGTGGGCCGTTACCCCGCCAACAAGCTAATCAGACGCATCCCCATCCATCACCGATAAATCTTTAATCTCTTTCAGATGTCTTCTAGAGACGTACTACTAGGTTAGGTTAAGTTACGTTACCTTTTACCGTTTCCGAACGGTTAAAGGTTTACCCCTTAACCCGTAAGGTAGTAGGGTCGGGACGGTTAGGGGTTAGGTAACGTACCGGTTACCGTTTACCTACCCCGTACCCGGTCGGCCCGGGTCCCGGG
CATGCTGCCTCCCGTAGGAGTTTGGACCGTGTCTCAGTTCCAATGTGGGGGACCTTCCTCTCAGAACCCCTATCCATCGAAGGCTTGGTGAGCCGTTACCTCACCAACAACCTAATGGAACGCATCCCCATCCTTTACCGGAATCCTTTAATAATGAAACCATGCGGAATCATTATGCTATCGGGTATTAATCTTTCTTTCGAAGGACGTACTCCCGGACGTAAAAGGGGCGTAAGGGTTCGGGGACTAACGGGTTTGGTTAACTTACCGTACCCGGTTTACGTCCCGACCCCGGGTTCGGCCCGACCGGGTCCGAAACCGAAAA

clusterCenter

The raw or normalized counts matrix can be accessed with the MRcounts function:

> head(MRcounts(msd16s[,1:10]))

100259 100262 100267 100274 100275 100277 100291 100292 100293 100294
0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

54
94
113
117
145
202

Using this class, the object can be easily subsetted, for example:

> msd16s_bangladesh = msd16s[,pData(msd16s)$Country == "Bangladesh"]
> msd16s_bangladesh

MRexperiment (storageMode: environment)
assayData: 26044 features, 206 samples

3

element names: counts

protocolData: none
phenoData

sampleNames: 600002 600005 ... 602385 (206 total)
varLabels: Type Country ... Dysentery (5 total)
varMetadata: labelDescription

featureData

featureNames: 54 94 ... 276421 (26044 total)
fvarLabels: superkingdom phylum ... clusterCenter (10 total)
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation:

4

