PSICQUIC

Paul Shannon

April 24, 2017

Contents

1 Introduction

2 Quick Start: ﬁnd interactions between Myc and Tp53

3 Retrieve all Myc interactions found by Agrawal et al, 2010, using tandem aﬃnity puriﬁcation

4 Gene symbols for input, “native” identifers for results

5 Add Entrez GeneIDs and HUGO Gene Symbols

6 Retrieve Interactions Among a Set of Genes

7 References

1 Introduction

1

2

3

4

4

4

5

PSICQUIC (the Proteomics Standard Initiative Common QUery InterfaCe, pronounced “psy-kick”) is “an eﬀort from the
HUPO Proteomics Standard Initiative (HUPO-PSI) to standardise the access to molecular interaction databases program-
matically”. The Bioconductor PSICQUIC package provides a traditional R function-calling (S4) interface layered on top of
the PSICQUIC REST interface, to obtain a data.frame of annotated interactions between speciﬁed proteins, each of which
is typically described by the HUGO symbol of the gene which codes for the protein of interest.

PSICQUIC is loose association of web accessible databases, “providers”, linked explicitly only by virtue of being listed
at the central PSICQUIC web site. Each provider supports the MIQL (molecular interaction query language), and each of
which returns standard columns in tab-delimited text. In typical use one queries for all of the interactions in which a protein
participates. Equally typical are queries for all known interactions between two speciﬁed proteins. These queries are easily
constrained by provider (e.g., BioGrid or IntAct), by detectionMethod, by interaction type, and/or by publicationID.
Interactions among a set of three or more genes may also be requested. The combinations of possible pairs grows non-

linearly with the number of genes, so use this option with care.

PSICQUIC may therefore be best suited to the close study of a few dozen genes or proteins of interest, rather than for
obtaining interactions for hundreds or thousands of genes or proteins. For bulk interactions, we recommend that you directly
download databases from individual PSICQUIC (or other) providers.

Approximately thirty databases currently implement PSICQUIC. They all

(cid:136) Support the molecular interaction query language (MIQL)
(cid:136) Use a controlled vocabulary describing interactions and detection methods
(cid:136) Communicate via SOAP or REST
(cid:136) Return results in XML or a tab-delimited form
(cid:136) May be interogated programmatically or via a URL in a web browser

> library(PSICQUIC)
> psicquic <- PSICQUIC()
> providers(psicquic)

1

[1] "APID Interactomes" "BioGrid"
[4] "ChEMBL"
[7] "InnateDB-All"

"HPIDb"
"IntAct"
"MatrixDB"
"Reactome-FIs"
"I2D-IMEx"
"UniProt"
"BAR"

"bhf-ucl"
"InnateDB"
"mentha"
"MINT"
"EBI-GOA-miRNA"
"InnateDB-IMEx"
"MBInfo"
"EBI-GOA-nonIntAct"

[10] "MPIDB"
[13] "Reactome"
[16] "I2D"
[19] "MolCon"
[22] "VirHostNet"
[25] "ZINC"

2 Quick Start: ﬁnd interactions between Myc and Tp53

A simple example is the best introduction to this package. Here we discover that BioGrid, Intact, Reactome, STRING and
BIND each report one or more interactions between human Myc and Tp53:

> library(PSICQUIC)
> psicquic <- PSICQUIC()
> providers(psicquic)

[1] "APID Interactomes" "BioGrid"
[4] "ChEMBL"
[7] "InnateDB-All"

"HPIDb"
"IntAct"
"MatrixDB"
"Reactome-FIs"
"I2D-IMEx"
"UniProt"
"BAR"

"bhf-ucl"
"InnateDB"
"mentha"
"MINT"
"EBI-GOA-miRNA"
"InnateDB-IMEx"
"MBInfo"
"EBI-GOA-nonIntAct"

[10] "MPIDB"
[13] "Reactome"
[16] "I2D"
[19] "MolCon"
[22] "VirHostNet"
[25] "ZINC"

> tbl <- interactions(psicquic, id=c("TP53", "MYC"), species="9606")
> dim(tbl)

[1] 9 16

Note that the several arguments to the interactions method are unspeciﬁed. They maintain their default values, and act as
wildcards in the query.

How many of the approximately twenty-ﬁve data sources reported interactions?

> table(tbl$provider)

APID Interactomes
2
Reactome-FIs
1

BioGrid
1
mentha
2

InnateDB-All
2

IntAct
1

What kind of interactions, detection methods and references were reported? (Note that the terms used in the controlled
vocabularies used by the PSICQUIC data sources are often quite long, complicating the display of extractions from our
data.frame. To get around this here, we extract selected columns in small groups so that the results will ﬁt on the page.)

> tbl[, c("provider", "type", "detectionMethod")]

provider
1 APID Interactomes
2 APID Interactomes
3
4
5
6
7
8
9

type
-
-
BioGrid psi-mi:MI:0915(physical association)
InnateDB-All psi-mi:MI:0915(physical association)
InnateDB-All psi-mi:MI:0915(physical association)
psi-mi:MI:0914(association)
IntAct
mentha
psi-mi:MI:0914(association)
mentha psi-mi:MI:0915(physical association)
-

Reactome-FIs

detectionMethod
1
psi-mi:MI:0676(tandem affinity purification)
2 psi-mi:MI:0004(affinity chromatography technology)
3 psi-mi:MI:0004(affinity chromatography technology)
4 psi-mi:MI:0004(affinity chromatography technology)
psi-mi:MI:0030(cross-linking study)
5

2

psi-mi:MI:0676(tandem affinity purification)
6
7
psi-mi:MI:0676(tandem affinity purification)
8 psi-mi:MI:0004(affinity chromatography technology)
psi-mi:MI:0046(experimental knowledge based)
9

These are quite heterogeneous. The well-established “tandem aﬃnity puriﬁcation” proteomics method probably warrants

more weight than “predictive text mining”. Let’s focus on them:

> tbl[grep("affinity", tbl$detectionMethod),
+

c("type", "publicationID", "firstAuthor", "confidenceScore", "provider")]

publicationID
type
pubmed:21150319
1
-
pubmed:21150319
-
2
pubmed:21150319
3 psi-mi:MI:0915(physical association)
pubmed:21150319
4 psi-mi:MI:0915(physical association)
psi-mi:MI:0914(association) pubmed:21150319|imex:IM-16995
6
pubmed:21150319
7
psi-mi:MI:0914(association)
pubmed:21150319
8 psi-mi:MI:0915(physical association)
provider
<NA> APID Interactomes
<NA> APID Interactomes
BioGrid
<NA>
InnateDB-All
Agrawal et al.(2010) lpr:108|hpr:108|np:1
IntAct
intact-miscore:0.35
mentha
mentha-score:0.236
mentha
mentha-score:0.236

firstAuthor
1 Agrawal, P. et al.(2010)
2 Agrawal, P. et al.(2010)
3
Agrawal P (2010)
4
6
7
8

Agrawal et al. (2010)
-
-

confidenceScore

This result demonstrates that diﬀerent providers report results from the same paper in diﬀerent ways, sometimes omitting

conﬁdence scores, and sometimes using diﬀerent (though related) terms from the PSI controlled vocabularies.

3 Retrieve all Myc interactions found by Agrawal et al, 2010, using tandem

aﬃnity puriﬁcation

These reports of TP53/Myc interactions by detection methods variously described as “aﬃnity chromotography technology”
and “tandem aﬃnity puriﬁcation”, both accompanied by a reference to the same recent paper (“Proteomic proﬁling of
Myc-associated proteins”, Agrawal et al, 2010), suggests the next task: obtain all of the interactions reported in that
paper.

> tbl.myc <- interactions(psicquic, "MYC", species="9606", publicationID="21150319")

How many were returned? From what sources? Any conﬁdence scores reported?

> dim(tbl.myc)

[1] 1745

16

> table(tbl.myc$provider)

APID Interactomes
554
mentha
524

BioGrid
107

InnateDB-All
108

IntAct
452

> table(tbl.myc$confidenceScore)

intact-miscore:0.35
402
intact-miscore:0.60
1
intact-miscore:0.69
3
lpr:108|hpr:108|np:1
108
mentha-score:0.309
1

intact-miscore:0.53
29
intact-miscore:0.64
1
intact-miscore:0.79
1
mentha-score:0.126
292
mentha-score:0.332
18

intact-miscore:0.56
9
intact-miscore:0.67
3
intact-miscore:0.97
3
mentha-score:0.236
168
mentha-score:0.416
25

3

mentha-score:0.454
4
mentha-score:0.554
4
mentha-score:0.891
2

mentha-score:0.49
3
mentha-score:0.731
1
mentha-score:0.967
1

mentha-score:0.523
1
mentha-score:0.74
1
mentha-score:1
3

4 Gene symbols for input, “native” identifers for results

PSICQUIC queries apparently expect HUGO gene symbols for input. These are translated by each provider into each
provider’s native identiﬁer type, which is nearly always a protein id of some sort. The results returned use the protein
identiﬁer native to each provider – but see notes on the use of our IDMapper class for converting these protein identiﬁers
to gene symbols and entrez geneIDs. If you submit a protein identiﬁer in a query, it is apparently used without translation,
and the interactions returned are limited to those which use exactly the protein identiﬁer you supplied. Thus the use of gene
symbols is recommended for all of your calls to the interactions method.

Here is a sampling of the identiﬁers returned by the PSICQUIC providers:

(cid:136) refseq:NP 001123512

(cid:136) uniprotkb:Q16820

(cid:136) string:9606.ENSP00000373992—uniprotkb:Q9UMJ4

(cid:136) entrez gene/locuslink:2041—BIOGRID:108355

5 Add Entrez GeneIDs and HUGO Gene Symbols

Though informative, this heterogeneity along with the frequent absence of entrez geneIDs and gene symbols limits the
immediate usefulness of these results for many prospective users. We attempt to remedy this with the IDMapper class,which
uses biomaRt and some simple parsing strategies to map these lengthy identiﬁers into both geneID and gene symobl. At this
point in the development of the PSICQUIC package, this step – which adds four columns to the results data.frame – must
be done explicitly, and is currently limited to human identiﬁers only. Support for additional species will be added.

> idMapper <- IDMapper("9606")
> tbl.myc <- addGeneInfo(idMapper,tbl.myc)
> print(head(tbl.myc$A.name))

[1] "MYC" "MAX" "MAX" "MAX" "MAX" "MAX"

> print(head(tbl.myc$B.name))

[1] "MYC" "MYC" "MYC" "MYC" "MYC" "MYC"

6 Retrieve Interactions Among a Set of Genes

If the id argument to the interactions method contains two or more gene symbols, then all interactions among all possible
pairs of those genes will be retrieved. Keep in mind that the number of unique combinations grows larger non-linearly with
the number of genes supplied, and that each unique pair becomes a distinct query to each of the speciﬁed providers.

> tbl.3 <- interactions(psicquic, id=c("ALK", "JAK3", "SHC3"),
+
> tbl.3g <- addGeneInfo(idMapper, tbl.3)
> tbl.3gd <- with(tbl.3g, as.data.frame(table(detectionMethod, type, A.name, B.name, provider)))
> print(tbl.3gd <- subset(tbl.3gd, Freq > 0))

species="9606", quiet=TRUE)

4

detectionMethod
37 psi-mi:MI:0004(affinity chromatography technology)
39
psi-mi:MI:0493(in vivo)
43 psi-mi:MI:0004(affinity chromatography technology)
45
psi-mi:MI:0493(in vivo)
154 psi-mi:MI:0004(affinity chromatography technology)
178 psi-mi:MI:0004(affinity chromatography technology)
196 psi-mi:MI:0004(affinity chromatography technology)
psi-mi:MI:0046(experimental knowledge based)
326
332
psi-mi:MI:0046(experimental knowledge based)
442 psi-mi:MI:0004(affinity chromatography technology)
466 psi-mi:MI:0004(affinity chromatography technology)
type A.name B.name
JAK3
JAK3
SHC3
SHC3
ALK
ALK
-
JAK3
SHC3
ALK
ALK

-
37
-
39
-
43
45
-
154 psi-mi:MI:0915(physical association)
178 psi-mi:MI:0915(physical association)
196 psi-mi:MI:0915(physical association)
-
326
332
-
442 psi-mi:MI:0915(physical association)
466 psi-mi:MI:0915(physical association)

JAK3
SHC3
-
ALK
ALK
JAK3
SHC3

ALK APID Interactomes
ALK APID Interactomes
ALK APID Interactomes
ALK APID Interactomes
BioGrid
BioGrid
InnateDB-All
Reactome-FIs
Reactome-FIs
mentha
mentha

provider Freq
2
1
1
1
2
1
3
1
1
2
1

7 References

(cid:136) Aranda, Bruno, Hagen Blankenburg, Samuel Kerrien, Fiona SL Brinkman, Arnaud Ceol, Emilie Chautard, Jose M. Dana et al. ”PSICQUIC and

PSISCORE: accessing and scoring molecular interactions.” Nature methods 8, no. 7 (2011): 528-529.

(cid:136) Agrawal, Pooja, Kebing Yu, Arthur R. Salomon, and John M. Sedivy. ”Proteomic proﬁling of Myc-associated proteins.” Cell Cycle 9, no. 24 (2010):

4908-4921.

5

