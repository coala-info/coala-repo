# IMMAN

#### Minoo Ashtiani, Payman Nickchi, Abdollah Safari, Mehdi Mirzaie, Mohieddin Jafari

#### 2025-10-30

IMMAN is specified to retrieve the interlog protein network shared across diverse species. For this aim, first we exceed orthology relationships among sequences from various species by iterating over any pair of input species, and using the Needleman-Wunsch alignment algorithm and a best reciprocal hit strategy to reach the orthologues through all versus all pairwise cross-species alignments. From orthology assignment, we derive Orthologous Protein sets (OPSs), an assortment of clusters of orthologues(maximum one per species) which will conform the nodes of the so-called Interolog Protein Network (IPN).

We exceed n species-specific interlog protein networks from STRING database, where each node maps to a single OPS in the IPN, and distinguish the edges of the outcome IPN by choosing only edges linking nodes in the IPN that also are linked in at least species-specific networks (where ‘k’ is set as a parameter).

A scoring system is used by the alignment process, which can be described as a set of values specified for quantifying the likelihood of one residue that has been substituted by another in an alignment. The scoring systems used by alignment procedure is called a substitution matrix and it can be achieved from statistical analysis of residue substitution data from sets of reputable alignments of highly relevent sequences. Using identityU value which ranges from 0 to 100, user would be able to specialize how the IPNs should be larger or not. As the value of identityU gets higher, the algorithm will find much similar orthologs and vice versa. We used gapOpening and gapExtension arguments to figure numeric values of ortholog proteins. For matching alignments of proteins if we skip a protein, gapOpening argument would be incremented. The smaller the amount of gap, protein alignements are more similar to each other. The score\_threshold argument is specified for evaluating the similarity values between two proteins in substitutionMatrix. It differs from 0 to 100, however, the common use ranges from 25 to 30. The transference of interactionn among orthologs of different species called the interlog approach. We used Besthit argument to reach proteins which has the most similarity in all versus all protein alignment. If an interaction was exist between each pair of proteins of OPSs, an edge would be linked in the IPN. The coverage\_threshold specifies the number of interactions that are exist among pair of proteins of OPSs. It differs from 1 to number of species. As much as the value of coverage\_threshold was high, the final IPN would be more robust and usually smaller. NetworkShrinkage argument determine whether two similar OPSs which have ortholog proteins in common should be merged or not. If it was TRUE the resulting IPN would be smaller.

For using this package, we assume that the “IMMAN” package has been properly installed into the R environment. After installations, the “IMMAN” package can be loaded via

```
library(IMMAN)
```

For illustration, we will read two datasets from different species which can be accessed via:

```
data(FruitFly)
data(Celegance)

subFruitFly <- as.character(FruitFly$V1)[1:10]

subCelegance <- as.character(Celegance$V1)[1:10]
```

Then, we have to make a list of dataset species and set their taxanomy IDs.

```
ProteinLists = list(subFruitFly, subCelegance)

List1_Species_ID = 7227    # taxonomy ID FruitFly
List2_Species_ID = 6239    # taxonomy ID Celegance

Species_IDs  = c(List1_Species_ID, List2_Species_ID)
```

To continue, set the parameters to run the analysis. Here is a description of parameters in IMMAN. If you need more information you can refer to the paper.

identityU: Cut off value for selecting proteins whose alignment score is greater or equal than identityU.

substitutionMatrix: Which scoring matrix to be used for alignment setting gapOpening and gapExtension for alignment purposes.

For NetworkShrinkage, coverage, and BestHit refer to paper.

STRINGversion: Indicated which version of STRING database should program search in for the score of PPIs.

Then, we will set the argument values:

```
identityU = 30
substitutionMatrix = "BLOSUM62"
gapOpening = -8
gapExtension = -8
NetworkShrinkage = FALSE
coverage = 1
BestHit = TRUE
score_threshold = 400
STRINGversion="11"
```

Finally, we can run the IMMAN function:

```
output = IMMAN(ProteinLists, fileNames=NULL, Species_IDs,
              identityU, substitutionMatrix,
              gapOpening, gapExtension, BestHit,
              coverage, NetworkShrinkage,
              score_threshold, STRINGversion,
              InputDirectory = getwd())
```

```
## Step 1/4:Downloading amino acid sequences...
```

```
## Downloading amino acid sequences of List1
```

```
## Downloading amino acid sequences of List2
```

```
## Step 2/4: Alignment...
```

```
## Align List1 with List2
```

```
## Step 3/4: Detection in STRING...
```

```
## Detecting List1 in STRING
```

```
## Detecting List2 in STRING
```

```
## Step 4/4: Retrieving String Network...
```

```
## Retrieving List1
```

```
## Retrieving List2
```

```
## Producing IPN...
```

![](data:image/png;base64...)

```
## DONE!
```

In order to see some particular parts of the result, you can use:

```
output$IPNEdges
```

```
##        node1    node2
## 21   OPS0001  OPS0002
## 41   OPS0001  OPS0004
## 51   OPS0001  OPS0005
## 61   OPS0001  OPS0006
## 101  OPS0001 OPS00010
## 411  OPS0002  OPS0004
## 511  OPS0002  OPS0005
## 611  OPS0002  OPS0006
## 1011 OPS0002 OPS00010
## 412  OPS0003  OPS0004
## 612  OPS0003  OPS0006
## 81   OPS0003  OPS0008
## 512  OPS0004  OPS0005
## 613  OPS0004  OPS0006
## 811  OPS0004  OPS0008
## 1012 OPS0004 OPS00010
## 91   OPS0005  OPS0009
## 1013 OPS0005 OPS00010
## 812  OPS0006  OPS0008
## 1014 OPS0006 OPS00010
## 911  OPS0007  OPS0009
```

```
output$IPNNodes
```

```
##               node1             node2 OPSLabel
## 1  7227.FBpp0100177      6239.MTCE.31  OPS0001
## 2  7227.FBpp0070871      6239.T20G5.2  OPS0002
## 3  7227.FBpp0073568      6239.ZK652.9  OPS0003
## 4  7227.FBpp0305828   6239.C34E10.6.1  OPS0004
## 5  7227.FBpp0073290 6239.Y22D7AL.5a.2  OPS0005
## 6  7227.FBpp0298344    6239.Y37D8A.14  OPS0006
## 7  7227.FBpp0076520    6239.T08G2.3.1  OPS0007
## 8  7227.FBpp0081347     6239.F57B9.4b  OPS0008
## 9  7227.FBpp0085821      6239.B0250.5  OPS0009
## 10 7227.FBpp0071794    6239.H28O16.1a OPS00010
```

```
output$Networks
```

```
## [[1]]
##                from               to
## 1  7227.FBpp0070871 7227.FBpp0071794
## 2  7227.FBpp0070871 7227.FBpp0071794
## 3  7227.FBpp0070871 7227.FBpp0073290
## 4  7227.FBpp0070871 7227.FBpp0073290
## 5  7227.FBpp0071794 7227.FBpp0073290
## 6  7227.FBpp0071794 7227.FBpp0073290
## 7  7227.FBpp0073568 7227.FBpp0081347
## 8  7227.FBpp0073568 7227.FBpp0081347
## 9  7227.FBpp0076520 7227.FBpp0085821
## 10 7227.FBpp0076520 7227.FBpp0085821
## 11 7227.FBpp0070871 7227.FBpp0100177
## 12 7227.FBpp0070871 7227.FBpp0100177
## 13 7227.FBpp0071794 7227.FBpp0100177
## 14 7227.FBpp0071794 7227.FBpp0100177
## 15 7227.FBpp0073568 7227.FBpp0298344
## 16 7227.FBpp0073568 7227.FBpp0298344
## 17 7227.FBpp0081347 7227.FBpp0298344
## 18 7227.FBpp0081347 7227.FBpp0298344
## 19 7227.FBpp0070871 7227.FBpp0305828
## 20 7227.FBpp0070871 7227.FBpp0305828
## 21 7227.FBpp0071794 7227.FBpp0305828
## 22 7227.FBpp0071794 7227.FBpp0305828
## 23 7227.FBpp0073290 7227.FBpp0305828
## 24 7227.FBpp0073290 7227.FBpp0305828
## 25 7227.FBpp0073568 7227.FBpp0305828
## 26 7227.FBpp0073568 7227.FBpp0305828
## 27 7227.FBpp0081347 7227.FBpp0305828
## 28 7227.FBpp0081347 7227.FBpp0305828
## 29 7227.FBpp0100177 7227.FBpp0305828
## 30 7227.FBpp0100177 7227.FBpp0305828
## 31 7227.FBpp0298344 7227.FBpp0305828
## 32 7227.FBpp0298344 7227.FBpp0305828
##
## [[2]]
##               from                to
## 1  6239.C34E10.6.1     6239.F57B9.4b
## 2  6239.C34E10.6.1     6239.F57B9.4b
## 3  6239.C34E10.6.1    6239.H28O16.1a
## 4  6239.C34E10.6.1    6239.H28O16.1a
## 5  6239.C34E10.6.1      6239.MTCE.31
## 6  6239.C34E10.6.1      6239.MTCE.31
## 7   6239.H28O16.1a      6239.MTCE.31
## 8   6239.H28O16.1a      6239.MTCE.31
## 9     6239.B0250.5    6239.T08G2.3.1
## 10    6239.B0250.5    6239.T08G2.3.1
## 11 6239.C34E10.6.1      6239.T20G5.2
## 12 6239.C34E10.6.1      6239.T20G5.2
## 13  6239.H28O16.1a      6239.T20G5.2
## 14  6239.H28O16.1a      6239.T20G5.2
## 15    6239.MTCE.31      6239.T20G5.2
## 16    6239.MTCE.31      6239.T20G5.2
## 17    6239.B0250.5 6239.Y22D7AL.5a.2
## 18    6239.B0250.5 6239.Y22D7AL.5a.2
## 19 6239.C34E10.6.1 6239.Y22D7AL.5a.2
## 20 6239.C34E10.6.1 6239.Y22D7AL.5a.2
## 21  6239.H28O16.1a 6239.Y22D7AL.5a.2
## 22  6239.H28O16.1a 6239.Y22D7AL.5a.2
## 23    6239.MTCE.31 6239.Y22D7AL.5a.2
## 24    6239.MTCE.31 6239.Y22D7AL.5a.2
## 25    6239.T20G5.2 6239.Y22D7AL.5a.2
## 26    6239.T20G5.2 6239.Y22D7AL.5a.2
## 27 6239.C34E10.6.1    6239.Y37D8A.14
## 28 6239.C34E10.6.1    6239.Y37D8A.14
## 29  6239.H28O16.1a    6239.Y37D8A.14
## 30  6239.H28O16.1a    6239.Y37D8A.14
## 31    6239.MTCE.31    6239.Y37D8A.14
## 32    6239.MTCE.31    6239.Y37D8A.14
## 33    6239.T20G5.2    6239.Y37D8A.14
## 34    6239.T20G5.2    6239.Y37D8A.14
## 35 6239.C34E10.6.1      6239.ZK652.9
## 36 6239.C34E10.6.1      6239.ZK652.9
## 37   6239.F57B9.4b      6239.ZK652.9
## 38   6239.F57B9.4b      6239.ZK652.9
```

```
output$Networks[[1]]
```

```
##                from               to
## 1  7227.FBpp0070871 7227.FBpp0071794
## 2  7227.FBpp0070871 7227.FBpp0071794
## 3  7227.FBpp0070871 7227.FBpp0073290
## 4  7227.FBpp0070871 7227.FBpp0073290
## 5  7227.FBpp0071794 7227.FBpp0073290
## 6  7227.FBpp0071794 7227.FBpp0073290
## 7  7227.FBpp0073568 7227.FBpp0081347
## 8  7227.FBpp0073568 7227.FBpp0081347
## 9  7227.FBpp0076520 7227.FBpp0085821
## 10 7227.FBpp0076520 7227.FBpp0085821
## 11 7227.FBpp0070871 7227.FBpp0100177
## 12 7227.FBpp0070871 7227.FBpp0100177
## 13 7227.FBpp0071794 7227.FBpp0100177
## 14 7227.FBpp0071794 7227.FBpp0100177
## 15 7227.FBpp0073568 7227.FBpp0298344
## 16 7227.FBpp0073568 7227.FBpp0298344
## 17 7227.FBpp0081347 7227.FBpp0298344
## 18 7227.FBpp0081347 7227.FBpp0298344
## 19 7227.FBpp0070871 7227.FBpp0305828
## 20 7227.FBpp0070871 7227.FBpp0305828
## 21 7227.FBpp0071794 7227.FBpp0305828
## 22 7227.FBpp0071794 7227.FBpp0305828
## 23 7227.FBpp0073290 7227.FBpp0305828
## 24 7227.FBpp0073290 7227.FBpp0305828
## 25 7227.FBpp0073568 7227.FBpp0305828
## 26 7227.FBpp0073568 7227.FBpp0305828
## 27 7227.FBpp0081347 7227.FBpp0305828
## 28 7227.FBpp0081347 7227.FBpp0305828
## 29 7227.FBpp0100177 7227.FBpp0305828
## 30 7227.FBpp0100177 7227.FBpp0305828
## 31 7227.FBpp0298344 7227.FBpp0305828
## 32 7227.FBpp0298344 7227.FBpp0305828
```

```
output$maps
```

```
## [[1]]
##    UNIPROT_AC        STRING_id
## 1      Q9V8M5 7227.FBpp0085821
## 2      Q9VSA3 7227.FBpp0076520
## 3      P35381 7227.FBpp0071794
## 4      Q05825 7227.FBpp0305828
## 5      O02649 7227.FBpp0073290
## 6      Q9W401 7227.FBpp0070871
## 7      Q9VHS7 7227.FBpp0081347
## 8      Q9VVG6 7227.FBpp0298344
## 9      Q9VYF8 7227.FBpp0073568
## 10     P00408 7227.FBpp0100177
##
## [[2]]
##    UNIPROT_AC         STRING_id
## 1      Q9XTI0      6239.B0250.5
## 2      Q22347    6239.T08G2.3.1
## 3      Q9XXK1    6239.H28O16.1a
## 4      P46561   6239.C34E10.6.1
## 5      P50140 6239.Y22D7AL.5a.2
## 6      P34575      6239.T20G5.2
## 7      Q8I7J4     6239.F57B9.4b
## 8      P55954    6239.Y37D8A.14
## 9      P34666      6239.ZK652.9
## 10     P24894      6239.MTCE.31
```

```
output$maps[[2]]
```

```
##    UNIPROT_AC         STRING_id
## 1      Q9XTI0      6239.B0250.5
## 2      Q22347    6239.T08G2.3.1
## 3      Q9XXK1    6239.H28O16.1a
## 4      P46561   6239.C34E10.6.1
## 5      P50140 6239.Y22D7AL.5a.2
## 6      P34575      6239.T20G5.2
## 7      Q8I7J4     6239.F57B9.4b
## 8      P55954    6239.Y37D8A.14
## 9      P34666      6239.ZK652.9
## 10     P24894      6239.MTCE.31
```

# Citations

Ashtiani M, Nickchi P, Jahangiri-Tazehkand S, Safari A, Mirzaie M, Jafari M. IMMAN: an R/Bioconductor package for Interolog protein network reconstruction, mapping and mining analysis. BMC bioinformatics. 2019 Dec;20(1):73.