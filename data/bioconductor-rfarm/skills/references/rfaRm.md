# Contents

* [1 Abstract](#abstract)
* [2 Introduction](#introduction)
* [3 Software features](#software-features)
* [4 Example](#example)
  + [4.1 Identify Rfam families of interest](#identify-rfam-families-of-interest)
  + [4.2 Convert Rfam accession to ID and vice versa](#convert-rfam-accession-to-id-and-vice-versa)
  + [4.3 Query the Rfam database for data for a specific Rfam family](#query-the-rfam-database-for-data-for-a-specific-rfam-family)
    - [4.3.1 Obtain a descriptive summary](#obtain-a-descriptive-summary)
    - [4.3.2 Obtain the consensus secondary structure and consensus sequence](#obtain-the-consensus-secondary-structure-and-consensus-sequence)
    - [4.3.3 Obtain the seed alignment used to define the Rfam family](#obtain-the-seed-alignment-used-to-define-the-rfam-family)
    - [4.3.4 Obtain the phylogenetic tree associated with a seed alignment](#obtain-the-phylogenetic-tree-associated-with-a-seed-alignment)
    - [4.3.5 Obtain the covariance model of the Rfam family](#obtain-the-covariance-model-of-the-rfam-family)
    - [4.3.6 Obtain the list of sequence regions belonging to the Rfam family](#obtain-the-list-of-sequence-regions-belonging-to-the-rfam-family)
    - [4.3.7 Obtain a list of PDB entries with 3D structures of members of the Rfam family](#obtain-a-list-of-pdb-entries-with-3d-structures-of-members-of-the-rfam-family)
* [References](#references)

rfaRm

Lara Selles Vidal,
Rafael Ayala, Guy-Bart Stan, Rodrigo Ledesma-Amaro

April 7, 2020

# 1 Abstract

The Rfam database is a collection of families of non-coding RNA and other structured RNA elements. Each family is defined by a multiple sequence alignment of family members, a consensus secondary structure and a covariance model, which integrates both multiple sequence alignment information and secondary structure information, and are related to the hidden Markov models employed by Pfam. “rfaRm” is a R package providing a client-side interface to the Rfam database. The package allows the search of the Rfam database by keywords or sequences, as well as the retrieval of all available information on specific Rfam families, such as member sequences, multiple sequence alignments, secondary structures and covariance models.

# 2 Introduction

The Rfam database (Kalvari *et al.* [2017](#ref-kalvari2017)) is a collection of RNA sequences classified into different families of non-coding RNA, cis-regulatory elements and other structured RNA. It is designed to be analogous to the Pfam database of protein families (El-Gebali *et al.* [2018](#ref-elgebali2018)). The initial step for identifying an Rfam family is to generate a manually curated seed alignment of a set of known RNA sequences, ideally including secondary structure information. The Infernal software package (Nawrocki & Eddy [2013](#ref-nawrocki2013)) is then used to build a covariance model for the family (a probabilistic profile of the sequence and secondary structure of the family), and to search for new homologs to add from a sequence database. When new homologs are added, the covariance model is updated, and the process is repeated until no new homologs are found.

Much of the information stored in Rfam could be useful if integrated within existing genomics and transcriptomics workflows and with functionalities of packages already available in BioConductor. rfaRm aims to facilitate the integration of the information provided by Rfam in existing workflows by providing an R client-side interface to the Rfam database.

# 3 Software features

rfaRm allows to search the Rfam database by keywords and sequence. In the search by keywords, the supplied keywodrs are matched against the fields of each entry, and accessions for the matching families are returned. In the search by sequence, the supplied sequence is used by Infernal to be searched against the Rfam library of covariance models, returning high-scoring hits which allow the identification of regions in the query sequence that belong to an Rfam family. Searches can be used to find RNA families of interest.

rfaRm also allows the retrieval of the information available in Rfam for each RNA family by providing a valid Rfam family identifier. The types of retrievable information for each Rfam family include:

* Summary description
* Sequence regions beloning to the Rfam family
* Consensus sequence
* Consensus secondary structure
* Secondary structure plots
* Covariance model
* Seed alignment used to define the Rfam family
* Phylogenetic tree corresponding to the seed alignment
* Plots of the phylogenetic tree
* PDB entries with 3D structures of a member of the Rfam family

The results of each query are returned as R objects that can be used to perform further analysis on the retrieved data with other R packages. Additionally, when appropriate they can also be saved to standard file formats, which can be read by commonly used Bioinformatics software.

# 4 Example

## 4.1 Identify Rfam families of interest

Rfam families can be searched by keywords with the “rfamTextSearchFamilyAccession” function. The function returns a character vector where each element is a string representing the Rfam accession for an Rfam family that matched the searched keyword. Rfam accessions are always of the “RFXXXXX” structure, where X is any digit from 0 to 9. For example, in order to search for Rfam families corresponding to riboswitches, the keyword “riboswitch” can be passed as the query to the search function. The function will output a vector with the Rfam accessions of the matching families:

```
rfamTextSearchFamilyAccession("riboswitch")
```

```
##  [1] "RF00174" "RF00059" "RF00162" "RF00504" "RF00050" "RF01051" "RF00379"
##  [8] "RF00167" "RF00168" "RF01734" "RF01750" "RF01055" "RF00634" "RF01068"
## [15] "RF00234"
```

It is also possible to perform a sequence-based search with the “rfamSequenceSearch” function. The supplied query sequence is matched against the covariance models of the Rfam families by the Infernal software in order to identify regions in the query sequence that belong to one of the Rfam families. It should be noted that sequence-based searches can occasionally take long times to finish, sometimes up to several hours. The supplied string should be an RNA sequence, containing only the standard RNA nucleotides (A, U, G and C). The function will return a nested list where each top-level element represents a high-scoring hit, and is in itself a list including information such as the Rfam family with which the hit was found, and an alignment between the query sequence and the consensus sequence of the Rfam family. In the following example, only one high-scoring hit is identified in the provided sequence: an FMN riboswitch. The alignment with the consensus sequence of the Rfam family is saved to a text file, together with its associated secondary structure annotation.

```
sequenceSearch <- rfamSequenceSearch("GGAUCUUCGGGGCAGGGUGAAAUUCCCGACCGGUGGUAUAGUCCACGAAAGUAUUUGCUUUGAUUUGGUGAAAUUCCAAAACCGACAGUAGAGUCUGGAUGAGAGAAGAUUC")

length(sequenceSearch)
```

```
## [1] 1
```

```
names(sequenceSearch)
```

```
## [1] "FMN"
```

```
## Save the aligned consensus sequence and query sequence to a text file,
## together with secondary structure annotation

writeLines(c(sequenceSearch$FMN$alignmentQuerySequence, sequenceSearch$FMN$alignmentMatch,
    sequenceSearch$FMN$alignmentHitSequence, sequenceSearch$FMN$alignmentSecondaryStructure),
    con = "searchAlignment.txt")
```

## 4.2 Convert Rfam accession to ID and vice versa

Each Rfam family has two main identifiers: its accession (a string with the RFXXXX format), and its ID (a keyword related to the Rfam family functionality or RNA type). Both can be used interchangeably with all of the query functions available in rfaRm. It is possible to obtain the ID corresponding to an accession with the “rfamFamilyAccessionToID” function, and the accession corresponding to an ID with the “rfamFamilyIDToAccession” function.

```
rfamFamilyAccessionToID("RF00174")
```

```
## [1] "Cobalamin"
```

```
rfamFamilyIDToAccession("FMN")
```

```
## [1] "RF00050"
```

## 4.3 Query the Rfam database for data for a specific Rfam family

When the accession or ID of the Rfam family of interest is known, it is possible to query the database to retrieve different types of data about the family.

### 4.3.1 Obtain a descriptive summary

A summary with a short functional description of an Rfam family can be obtained with the “rfamFamilySummary” function.

```
rfamFamilySummary("RF00174")
```

```
## $rfamReleaseNumber
## [1] "15.00"
##
## $numberSequencesSeedAlignment
## [1] "434"
##
## $sourceSeedAlignment
## [1] "Barrick JE, Breaker RR"
##
## $numberSpecies
## [1] "7605"
##
## $RNAType
## [1] "Cis-reg; riboswitch;"
##
## $numberSequencesAll
## [1] "20864"
##
## $structureSource
## [1] "Predicted; PFOLD"
##
## $description
## [1] "Cobalamin riboswitch aptamer"
##
## $rfamAccession
## [1] "RF00174"
##
## $rfamID
## [1] "Cobalamin"
##
## $comment
## [1] "Riboswitches are metabolite binding domains within certain messenger RNAs that serve as precision sensors for their corresponding targets. Allosteric rearrangement of mRNA structure is mediated by ligand binding, and this results in modulation of gene expression [1]. This family represents a cobalamin riboswitch (B12-element) which is widely distributed in 5' UTRs of vitamin B(12)-related genes in bacteria. Cobalamin in the form of adenosylcobalamin (Ado-CBL) is known to repress expression of genes for vitamin B(12) biosynthesis and be transported by a post-transcriptional regulatory mechanism, which involves direct binding of Ado-CBL to 5' UTRs [2]. Cobalamin riboswitch structure was reported in PDB:4GMA [5], 4GXY [6] and 6VMY [7]. Cobalamin riboswitch forms a junctional structure that form a pocket that recognise adenosylcobalamin and is flanked by structural elements that connects by long-range interactions."
```

```
# The summary includes, amongst other data, a brief paragraph describing the
# family

rfamFamilySummary("RF00174")$comment
```

```
## [1] "Riboswitches are metabolite binding domains within certain messenger RNAs that serve as precision sensors for their corresponding targets. Allosteric rearrangement of mRNA structure is mediated by ligand binding, and this results in modulation of gene expression [1]. This family represents a cobalamin riboswitch (B12-element) which is widely distributed in 5' UTRs of vitamin B(12)-related genes in bacteria. Cobalamin in the form of adenosylcobalamin (Ado-CBL) is known to repress expression of genes for vitamin B(12) biosynthesis and be transported by a post-transcriptional regulatory mechanism, which involves direct binding of Ado-CBL to 5' UTRs [2]. Cobalamin riboswitch structure was reported in PDB:4GMA [5], 4GXY [6] and 6VMY [7]. Cobalamin riboswitch forms a junctional structure that form a pocket that recognise adenosylcobalamin and is flanked by structural elements that connects by long-range interactions."
```

### 4.3.2 Obtain the consensus secondary structure and consensus sequence

The consensus secondary structure for an Rfam family can be retrieved, together with its consensus sequence, with the “rfamConsensusSecondaryStructure” function. RNA Secondary structure notation can be output in the WUSS or extended Dot-Bracket notations. In the example below, the consensus secondary structure of the Rfam family with accession RF00174 is retrieved in both notations, and saved to a file with the extended Dot-Bracket notation.

```
rfamConsensusSecondaryStructure("RF00174", format = "WUSS")
```

```
## [1] "uauaauuauuccgccg.c.c.G.GU....ccccccu......................aaaga.gggggguu....AAaa.GGGAA.c.cc.GG.UGc...............................aAauCCgg.gGCuGCCC.CC.GCaACUGUAA..ccgc.......gaacga.acccccaauau.............................gCCACUGgcccguaa..........................................................gggcCGGGAAGGc...gg.g..g...ga.aagcgauGAc.................................................................ccgC.gAGCCAGGAGACCuGCCg.gcg.gaggaaguaucac......................."
## [2] "::::::::[[[[-[[[.[.[.[.[[....<<<<<<_......................_____.>>>>>><_....__>(.((,,,.<.<<.<<.___...............................____>>>>.>AA<<___.__._>><<<<---..<<<<.......---<--.-<<-<<-----.............................<<<-<<<<<<_____.........................................................._>>>>>>--->>>...>>.>..>...>-.-->-------.................................................................>>>>.--aa>>->,,,)))]]]].]]].]-]]]]:::::::......................."
```

```
rfamConsensusSecondaryStructure("RF00174", format = "DB")
```

```
## [1] "uauaauuauuccgccg.c.c.G.GU....ccccccu......................aaaga.gggggguu....AAaa.GGGAA.c.cc.GG.UGc...............................aAauCCgg.gGCuGCCC.CC.GCaACUGUAA..ccgc.......gaacga.acccccaauau.............................gCCACUGgcccguaa..........................................................gggcCGGGAAGGc...gg.g..g...ga.aagcgauGAc.................................................................ccgC.gAGCCAGGAGACCuGCCg.gcg.gaggaaguaucac......................."
## [2] "........[[[[.[[[.[.[.[.[[....<<<<<<.............................>>>>>><.......>(.((....<.<<.<<.......................................>>>>.>AA<<........>><<<<.....<<<<..........<....<<.<<..................................<<<.<<<<<<................................................................>>>>>>...>>>...>>.>..>...>....>........................................................................>>>>...aa>>.>...)))]]]].]]].].]]]].............................."
```

```
rfamConsensusSecondaryStructure("RF00174", filename = "RF00174secondaryStructure.txt",
    format = "DB")
```

```
## [1] "uauaauuauuccgccg.c.c.G.GU....ccccccu......................aaaga.gggggguu....AAaa.GGGAA.c.cc.GG.UGc...............................aAauCCgg.gGCuGCCC.CC.GCaACUGUAA..ccgc.......gaacga.acccccaauau.............................gCCACUGgcccguaa..........................................................gggcCGGGAAGGc...gg.g..g...ga.aagcgauGAc.................................................................ccgC.gAGCCAGGAGACCuGCCg.gcg.gaggaaguaucac......................."
## [2] "........[[[[.[[[.[.[.[.[[....<<<<<<.............................>>>>>><.......>(.((....<.<<.<<.......................................>>>>.>AA<<........>><<<<.....<<<<..........<....<<.<<..................................<<<.<<<<<<................................................................>>>>>>...>>>...>>.>..>...>....>........................................................................>>>>...aa>>.>...)))]]]].]]].].]]]].............................."
```

The generated files with secondary structure in the extended Dot-Bracket notation can be read by the [R4RNA](https://bioconductor.org/packages/R4RNA/) package (Lai *et al.* [2012](#ref-lai2012)), and used for further analysis and plotting of the corresponding RNA.

```
secondaryStructureTable <- readVienna("RF00174secondaryStructure.txt")

plotHelix(secondaryStructureTable)
```

![](data:image/png;base64...)

It is also possible to retrieve an SVG file containing a representation of the consensus secondary structure of an Rfam family. Different types of secondary structure representations can be generated, including simple base pairing plots, plots with sequence conservation and plots with basepair conservation, amongst other types. The SVG file can be stored as a character string directly readable by the [rsvg](https://CRAN.R-project.org/package%3Drsvg) and [magick](https://cran.r-project.org/web/packages/magick/index.html) packages, or saved to a file which can be read by external software.

```
## Retrieve an SVG with a normal representation of the secondary structure of
## Rfam family RF00174 and store it into a character string, which can be read
## by rsvg after conversion from SVG string to raw data

normalSecondaryStructureSVG = rfamSecondaryStructureXMLSVG("RF00174", plotType = "norm")
rsvg(charToRaw(normalSecondaryStructureSVG))

## Retrieve an SVG with a sequence conservation representation added to the
## secondary structure of Rfam family RF00174, and save it to an SVG file

rfamSecondaryStructureXMLSVG("RF00174", filename = "RF00174SSsequenceConservation.svg",
    plotType = "cons")
```

It is also possible to directly plot the retrieved graphics to R’s graphics display, and save it to an image file such as PNG, JPEG or GIF.

```
## Plot a normal representation of the secondary structure of Rfam family
## RF00174

rfamSecondaryStructurePlot("RF00174", plotType = "norm")
```

![Smiley face](data:image/png;base64...)

```
## Save to a PNG file a plot of a representation of the secondary structure of
## Rfam family with ID FMN with sequence conservation annotation

rfamSecondaryStructurePlot("RF00050", filename = "RF00050SSsequenceConservation.png",
    plotType = "cons")
```

![Smiley face](data:image/png;base64...)

### 4.3.3 Obtain the seed alignment used to define the Rfam family

The seed multiple sequence alignment that was manually curated and used to define the Rfam family can be retrieved with the “rfamSeedAlignment” function. The function returns the seed alignment as a Biostrings MultipleAlignment object with the aligned RNA sequences. The alignment can also be written to a file in Stockholm or FASTA format. In the example below, the seed alignment for Rfam family RF00174 is written to two files, in Stockholm and FASTA format, respectively.

```
rfamSeedAlignment("RF00174", filename = "RF00174seedAlignment.stk", format = "stockholm")
```

```
## RNAMultipleAlignment with 431 rows and 200 columns
##        aln                                                  names
##   [1] GGCACCUUCGCGGCAG-A-U-G-GU...GCA-CCCCCCGGCA---------- AF010496.1/39869-...
##   [2] CCACUCAGGGCGGGCG-C-U-G-GU...GGG-CGCCCCGAG----------- AF010496.1/105318...
##   [3] GCUACUCCAACAGGCG-A-U-G-GU...GAC-GACGGUCGAAG--------- AF010496.1/116971...
##   [4] GCAAUGAGGAAGGAUU-A-A-G-GU...GCA-AAGAUCAAAAU--------- AF193754.1/4343-4143
##   [5] GGAAAUUUUUUUGCAU-A-G-G-GU...----AACGCCAAAAA--------- AF193754.1/24966-...
##   [6] AGGCUGACCGGUGCAG-C-U-G-GU...GAC-CGCCGUCAUA---------- AF263012.1/9229-9016
##   [7] GAUAAUCCAAGUCGUC-G-A-G-GU...CCG-CUGUCCAACGA--------- AF306632.1/382-182
##   [8] UCAAACAGCAACAGUA-A-A-G-GU...CGA---ACGAGUAUA--------- AJ000758.1/1191-1369
##   [9] CAUAUCGUGCAAAAAA-A-A-G-GU...GCU-GAUUGCAUUU---------- AJ000758.1/1489-1667
##   ... ...
## [423] GGCCAUAUGCCGCCGU-C-A-G-GU...GUU-CUCGCCAAAAAGGGCUCUGA AL591688.1/199976...
## [424] GUAGCCUUGCGCUUUC-G-A-G-GU...GUU-CGCUGCCAC----------- CP000094.2/355264...
## [425] --------UUACUGAA-A-U-G-GU...CGA-ACCCGCUGAA---------- AALF02000008.1/20...
## [426] GCCAUUCAGCGAAGAG-A-U-G-GU...CUG-ACAACCGAUAC--------- CP002156.1/230652...
## [427] UUUUUUAUAUAUCGAA-A-U-G-GU...CGA-ACCCGCUGUU---------- AALC02000021.1/24...
## [428] AUAUAGUAUGCGAGUA-U-U-G-GU...CGA-AAGAGCAA------------ CP003056.1/112605...
## [429] -------------------------...CGA-ACCCGUAGAA---------- AALE02000017.1/13...
## [430] AUUUGUAGUUACUGAU-A-G-G-GU...CGA-ACCCGCUGUU---------- AALD02000002.1/89...
## [431] ----GGUUAAAGCCUU-A-U-G-GU...CGA-AGCCCUAGUAA--------- URS000080E34D_408...
```

```
rfamSeedAlignment("RF00174", filename = "RF00174seedAlignment.stk", format = "fasta")
```

```
## RNAMultipleAlignment with 434 rows and 461 columns
##        aln                                                  names
##   [1] GGCACCUUCGCGGCAG-A-U-G-GU...G----------------------- AF010496.1/39869-...
##   [2] CCACUCAGGGCGGGCG-C-U-G-GU...G----------------------- AF010496.1/105318...
##   [3] GCUACUCCAACAGGCG-A-U-G-GU...A----------------------- AF010496.1/116971...
##   [4] GCAAUGAGGAAGGAUU-A-A-G-GU...A----------------------- AF193754.1/4343-4143
##   [5] GGAAAUUUUUUUGCAU-A-G-G-GU...C----------------------- AF193754.1/24966-...
##   [6] AGGCUGACCGGUGCAG-C-U-G-GU...C----------------------- AF263012.1/9229-9016
##   [7] GAUAAUCCAAGUCGUC-G-A-G-GU...C----------------------- AF306632.1/382-182
##   [8] UCAAACAGCAACAGUA-A-A-G-GU...U----------------------- AJ000758.1/1191-1369
##   [9] CAUAUCGUGCAAAAAA-A-A-G-GU...C----------------------- AJ000758.1/1489-1667
##   ... ...
## [426] GCCAUUCAGCGAAGAG-A-U-G-GU...G----------------------- CP002156.1/230652...
## [427] UUUUUUAUAUAUCGAA-A-U-G-GU...U----------------------- AALC02000021.1/24...
## [428] AUAUAGUAUGCGAGUA-U-U-G-GU...A----------------------- CP003056.1/112605...
## [429] -------------------------...U----------------------- AALE02000017.1/13...
## [430] AUUUGUAGUUACUGAU-A-G-G-GU...U----------------------- AALD02000002.1/89...
## [431] ----GGUUAAAGCCUU-A-U-G-GU...U----------------------- URS000080E34D_408...
## [432] -----------GGCGG-C-A-G-GU...------------------------ URS000080DFBC_326...
## [433] ---------GGUCAAA-U-A-G-GU...------------------------ URS0001A24B44_142...
## [434] ----GGUUAAAGCCUU-A-U-G-GU...UCGCCUUCGGGGGGAAGGUGAACA URS000080E34D_119...
```

### 4.3.4 Obtain the phylogenetic tree associated with a seed alignment

The phylogenetic tree associated to the seed alignment can be retrieved with the “rfamSeedTree” function. The tree is ouput in the New Hampshire extended format (NHX). The resulting tree is returned as a string and saved to a file, which can be directly read by the [treeio](https://bioconductor.org/packages/treeio/) package (Wang *et al.* [2019](#ref-wang2019)) or other external software.

```
seedTreeNHXString <- rfamSeedTree("RF00050", filename = "RF00050tree.nhx")

treeioTree <- read.nhx("RF00050tree.nhx")
```

A plot of the phylogenetic tree can also be directly retrieved with the “rfamSeedTreeImage” function, labeled with either species names or sequence accessions.

```
rfamSeedTreeImage("RF00164", filename = "RF00164seedTreePlot.png", label = "species")
```

![Smiley face](data:image/png;base64...)

### 4.3.5 Obtain the covariance model of the Rfam family

The covariance model describing each Rfam family can be obtained and saved to a file with the “rfamCovarianceModel” function. The file is provided in the Infernal software format.

```
rfamCovarianceModel("RF00050", filename = "RF00050covarianceModel.cm")
```

### 4.3.6 Obtain the list of sequence regions belonging to the Rfam family

A list of the sequence regions assigned to be members of an Rfam family can be retrieved with the “rfamSequenceRegions” function. The resulting dataframe contains the GenBank accessions of the containing sequences, as well as the start and end points of each sequence region belonging to the Rfam family. The sequence regions can also be saved to a tab-delimited file.

```
## By providing a filename, the sequence regions will be written to a
## tab-delimited file

sequenceRegions <- rfamSequenceRegions("RF00050", "RF00050sequenceRegions.txt")

head(sequenceRegions)
```

```
##   Sequence GenBank accession Bit score Region start position
## 1             FNFP01000007.1     132.9                 91217
## 2             JXMS01000004.1     132.6                105773
## 3                 CP009687.1     132.3               3736050
## 4                 CP016379.1     131.1               1319863
## 5             FZOJ01000009.1     130.7                155665
## 6             MIJF01000029.1     130.0                 20198
##   Region end position
## 1               91343
## 2              105633
## 3             3735924
## 4             1319739
## 5              155790
## 6               20328
##                                                                                                                           Sequence description
## 1 FNFP01000007.1 Natronincola ferrireducens strain DSM 18346 genome assembly, contig: Ga0056059_scaffold00007.7, whole genome shotgun sequence
## 2                                                                              Desulfovibrio sp. JC271 contig4, whole genome shotgun sequence.
## 3                                                                                       Clostridium aceticum strain DSM 1496, complete genome.
## 4                                                                            CP016379.1 Anoxybacter fermentans strain DY22613, complete genome
## 5                   FZOJ01000009.1 Anaerovirgula multivorans strain SCA genome assembly, contig: Ga0071125_1009, whole genome shotgun sequence
## 6                                MIJF01000029.1 Vulcanibacillus modesticaldus strain BR DSM-14931_Contig_34_85X, whole genome shotgun sequence
##                                Species NCBI tax ID
## 1           Natronincola ferrireducens      393762
## 2 Halodesulfovibrio spirochaetisodalis     1560234
## 3                 Clostridium aceticum       84022
## 4               Anoxybacter fermentans     1323375
## 5            Anaerovirgula multivorans      312168
## 6        Vulcanibacillus modesticaldus      337097
```

It should be noted that some Rfam families have too many associated sequence regions. In such cases, the list cannot be retrieved from the server.

### 4.3.7 Obtain a list of PDB entries with 3D structures of members of the Rfam family

A list of entries in the PDB database of 3D macromolecular structures (Berman *et al.* [2000](#ref-berman2000)) with experimentally solved structures for members of an Rfam family can be retrieved by using the “rfamPDBMapping” function. If available, the resulting set of entries will be returned as a dataframe, which can also be saved as a tab-delimited file if a filename is provided.

```
## By providing a filename, the matching PDB entries will be written to a
## tab-delimited file

PDBentries <- rfamPDBMapping("RF00050", "RF00050PDBentries.txt")

PDBentries
```

```
##    Rfam accession PDB ID  Chain PDB start residue PDB end residue
##            <char> <char> <char>            <char>          <char>
## 1:        RF00050   6wjr      X                 1             112
## 2:        RF00050   3f2w      X                 1             112
## 3:        RF00050   3f30      X                 1             112
## 4:        RF00050   3f2t      X                 1             112
## 5:        RF00050   3f2y      X                 1             112
## 6:        RF00050   3f2q      X                 1             112
## 7:        RF00050   6wjs      X                 1             112
## 8:        RF00050   3f2x      X                 1             112
##    CM start position CM end position eValue Bit score
##               <char>          <char> <char>    <char>
## 1:                 3             136  4e-31    110.10
## 2:                 3             136  4e-31    110.10
## 3:                 3             136  4e-31    110.10
## 4:                 3             136  4e-31    110.10
## 5:                 3             136  4e-31    110.10
## 6:                 3             136  4e-31    110.10
## 7:                 3             136  4e-31    110.10
## 8:                 3             136  4e-31    110.10
```

# References

Berman, H.M., Westbrook, J., Feng, Z., Gilliland, G., Bhat, T.N., Weissig, H., Shindyalov, I.N. & Bourne, P.E. (2000). The protein data bank. *Nucleic Acids Research*, **28**, 235–242. Retrieved from <https://doi.org/10.1093/nar/28.1.235>

El-Gebali, S., Mistry, J., Bateman, A., Eddy, S.R., Luciani, A., Potter, S.C., Qureshi, M., Richardson, L.J., Salazar, G.A., Smart, A., Sonnhammer, E.L.L., Hirsh, L., Paladin, L., Piovesan, D., Tosatto, S.C.E. & Finn, R.D. (2018). Rfam 13.0: Shifting to a genome-centric resource for non-coding rna families. *Nucleic Acids Research*, **47**, D427–D432. Retrieved from <https://doi.org/10.1093/nar/gky995>

Kalvari, I., Argasinska, J., Quinones-Olvera, N., Nawrocki, E.P., Rivas, E., Eddy, S.R., Bateman, A., Finn, R.D. & Petrov, A.I. (2017). Rfam 13.0: Shifting to a genome-centric resource for non-coding rna families. *Nucleic Acids Research*, **46**, D335–D342. Retrieved from <https://doi.org/10.1093/nar/gkx1038>

Lai, D., Proctor, J.R., Zhu, J.Y.A. & Meyer, I.M. (2012). R- chie : A web server and r package for visualizing rna secondary structures. *Nucleic Acids Research*, **40**, e95–e95. Retrieved from <https://doi.org/10.1093/nar/gks241>

Nawrocki, E.P. & Eddy, S.R. (2013). Infernal 1.1: 100-fold faster rna homology searches. *Bioinformatics*, **29**, 2933–2935. Retrieved from <https://doi.org/10.1093/bioinformatics/btt509>

Wang, L.-G., Lam, T.T.-Y., Xu, S., Dai, Z., Zhou, L., Feng, T., Guo, P., Dunn, C.W., Jones, B.R., Bradley, T., Zhu, H., Guan, Y., Jiang, Y. & Yu, G. (2019). Treeio: An r package for phylogenetic tree input and output with richly annotated and associated data. *Molecular Biology and Evolution*, **37**, 599–603. Retrieved from <https://doi.org/10.1093/molbev/msz240>