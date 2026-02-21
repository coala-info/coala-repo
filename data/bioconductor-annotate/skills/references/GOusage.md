Basic GO Usage

R. Gentleman

October 29, 2025

Introduction

In this vignette we describe some of the basic characteristics of the data available from the
Gene Ontology (GO), (The Gene Ontology Consortium, 2000) and how these data have been
incorporated into Bioconductor. We assume that readers are familiar with the basic DAG
structure of GO and with the mappings of genes to GO terms that are provide by GOA (Camon
et al., 2004). We consider these basic structures and properties quite briefly.

GO, itself, is a structured terminology. The ontology describes genes and gene products
and is divided into three separate ontologies. One for cellular component (CC), one for molec-
ular function (MF) and one for biological process (BP). We maintain those same distinctions
were appropriate. The relationship between terms is a parent-child one, where the parents of
any term are less specific than the child. The mapping in either direction can be one to many
(so a child may have many parents and a parent may have many children). There is a single
root node for all ontologies as well as separate root nodes for each of the three ontologies
named above. These terms are structured as a directed acyclic graph (or a DAG).

GO itself is only the collection of terms; the descriptions of genes, gene products, what
they do, where they do it and so on. But there is no direct association of genes to terms. The
assignment of genes to terms is carried out by others, in particular the GOA project (Camon
et al., 2004). It is this assignment that makes GO useful for data analysis and hence it is the
combined relationship between the structure of the terms and the assignment of genes to terms
that is the concern of the GO.db package.

The basis for child-parent relationships in GO can be either an is-a relationship, where the
child term is a more specific version of the parent. Or, it can be a has-a, or part-of relationship
where the child is a part of the parent. For example a telomere is a part-of a chromosome.

Genes are assigned to terms on the basis of their LocusLink ID. For this reason we make
most of our mappings and functions work for LocusLink identifiers. Users of specific chips,
or data with other gene identifiers should first map their identifiers to LocusLink before using
GOstats.

A gene is mapped only to the most specific terms that are applicable to it (in each ontol-
ogy). Then, all less specific terms are also applicable and they are easily obtained by traversing
the set of parent relationships down to the root node. In practice many of these mappings are

1

precomputed and easily obtained from the different hash tables provided by the GO.db pack-
age.

Mapping of a gene to a term can be based on many different things. GO and GOA provide
an extensive set of evidence codes, some of which are given in Table 1, but readers are referred
to the GO web site and the documentation for the GO.db package for a more comprehensive
listing. Clearly for some investigations one will want to exclude genes that were mapped
according to some of the evidence codes.

IMP inferred from mutant phenotype
inferred from genetic interaction
IGI
inferred from physical interaction
IPI
ISS
inferred from sequence similarity
IDA inferred from direct assay
IEP
IEA inferred from electronic annotation
TAS traceable author statement
NAS non-traceable author statement
ND no biological data available
inferred by curator
IC

inferred from expression pattern

Table 1: GO Evidence Codes

In some sense TAS is probably the most reliable of the mappings. IEA is a weak associa-
tion and is based on electronic information, no human curator has examined or confirmed this
association. As we shall see later, IEA is also the most common evidence code.

The sets of mappings of interest are roughly divided into three parts. First there is the basic
description of the terms etc., these are provided in the GOTERMS hash table. Each element
of this hash table is named using its GO identifier (these are all of the form GO: followed by
seven digits). Each element is an instance of the GOTerms class. A complete description of
this class can be obtained from the appropriate manual page (use class?GOTerms). From
these data we can find the text string describing the term, which ontology it is in as well as
some other basic information.

There are also a set of hash tables that contain the information about parents and children.
They are provided as hash tables (the XX in the names below should be substituted for one of
BP, MF, or CC.

• GOXXPARENTS: the parents of the term

• GOXXANCESTOR: the parents, and all their parents and so on.

• GOXXCHILDREN: the children of the term

• GOXXOFFSPRING: the children, their children and so on out to the leaves of the GO

graph.

2

For the GOXXPARENTS mappings (only) information about the nature of the relationship

is included.

>

GOTERM$"GO:0003700"

GOID: GO:0003700
Term: DNA-binding transcription factor activity
Ontology: MF
Definition: A transcription regulator activity that modulates

transcription of gene sets via selective and non-covalent binding
to a specific double-stranded genomic DNA sequence (sometimes
referred to as a motif) within a cis-regulatory region. Regulatory
regions include promoters (proximal and distal) and enhancers.
Genes are transcriptional units, and include bacterial operons.

Synonym: GO:0000130
Synonym: GO:0001071
Synonym: GO:0001130
Synonym: GO:0001131
Synonym: GO:0001151
Synonym: GO:0001199
Synonym: GO:0001204
Synonym: DNA binding transcription factor activity
Synonym: gene-specific transcription factor activity
Synonym: sequence-specific DNA binding transcription factor activity
Synonym: nucleic acid binding transcription factor activity
Synonym: transcription factor activity
Synonym: bacterial-type DNA binding transcription factor activity
Synonym: bacterial-type RNA polymerase core promoter proximal region
sequence-specific DNA binding transcription factor activity

Synonym: bacterial-type RNA polymerase transcription enhancer

sequence-specific DNA binding transcription factor activity

Synonym: bacterial-type RNA polymerase transcription factor activity,

metal ion regulated sequence-specific DNA binding

Synonym: bacterial-type RNA polymerase transcription factor activity,

sequence-specific DNA binding

Synonym: metal ion regulated sequence-specific DNA binding

bacterial-type RNA polymerase transcription factor activity

Synonym: metal ion regulated sequence-specific DNA binding

transcription factor activity

Synonym: sequence-specific DNA binding bacterial-type RNA polymerase

transcription factor activity

Synonym: transcription factor activity, bacterial-type RNA polymerase

core promoter proximal region sequence-specific binding

3

Synonym: transcription factor activity, bacterial-type RNA polymerase

proximal promoter sequence-specific DNA binding

Synonym: transcription factor activity, bacterial-type RNA polymerase

transcription enhancer sequence-specific binding

Synonym: transcription factor activity, metal ion regulated

sequence-specific DNA binding

Secondary: GO:0000130
Secondary: GO:0001071
Secondary: GO:0001130
Secondary: GO:0001131
Secondary: GO:0001151
Secondary: GO:0001199
Secondary: GO:0001204

>

GOMFPARENTS$"GO:0003700"

isa
"GO:0140110"

>

GOMFCHILDREN$"GO:0003700"

isa
"GO:0000981" "GO:0001216" "GO:0001217" "GO:0016987" "GO:0098531"

isa

isa

isa

isa

>

Here we see that the term GO:0003700 has two parents, that the relationships are is-a and
that it has one child. One can then follow this chains of relationships or use the ANCESTOR
and OFFSPRING hash tables to get more information.

The mappings of genes to GO terms is not contained in the GO package. Rather these map-
pings are held in each of the chip and organism specific data packages, such as hgu95av2GO
and org.Hs.egGO are contained within packages hgu95av2.db and org.Hs.eg.db
respectively. These mappings are from a Entrez Gene ID to the most specific applicable GO
terms. Each such entry is a list of lists where the innermost list has these names:

• GOID: the GO identifier

• Evidence: the evidence code for the assignment

• Ontology: the ontology the GO identifier belongs to (one of BP, MF, or CC).

Some genes are mapped to a GO identifier based on two or more evidence codes. Currently
these appear as separate entries. So you may want to remove duplicate entries if you are not
interested in evidence codes. However, as more sophisticated use is made of these data it will
be important to be able to separate out mappings according to specific evidence codes.

In this next example we consider the gene with Entrez Gene ID 4121, this corresponds to

Affymetrix ID 39613_at.

4

>
>

ll1 = hgu95av2GO[["39613_at"]]
length(ll1)

[1] 32

>

sapply(ll1, function(x) x$Ontology)

"BP"

"BP"

"BP"

"BP"

GO:0005975 GO:0006486 GO:0036503 GO:0036503 GO:0045047 GO:1904381 GO:1904381
"BP"
GO:1904382 GO:0000139 GO:0000139 GO:0000139 GO:0005783 GO:0005783 GO:0005793
"CC"
GO:0005794 GO:0005794 GO:0005829 GO:0016020 GO:0016020 GO:0016020 GO:0031410
"CC"
GO:0070062 GO:0004571 GO:0004571 GO:0004571 GO:0004571 GO:0005509 GO:0005509
"MF"

"CC"

"BP"

"BP"

"CC"

"CC"

"MF"

"CC"

"CC"

"CC"

"CC"

"CC"

"CC"

"BP"

"CC"

"CC"

"MF"

"CC"

"MF"
GO:0005515 GO:0015923 GO:0016787 GO:0016798
"MF"

"MF"

"MF"

"MF"

"MF"

"MF"

>

We see that there are 32 different mappings. We can get only those mappings for the BP
ontology by using getOntology. We can get the evidence codes using getEvidence
and we can drop those codes we do not wish to use by using dropECode.

> getOntology(ll1, "BP")

[1] "GO:0005975" "GO:0006486" "GO:0036503" "GO:0045047" "GO:1904381"
[6] "GO:1904382"

> getEvidence(ll1)

"IEA"

"IDA"

"IEA"

"IBA"

GO:0005975 GO:0006486 GO:0036503 GO:0036503 GO:0045047 GO:1904381 GO:1904381
"TAS"
GO:1904382 GO:0000139 GO:0000139 GO:0000139 GO:0005783 GO:0005783 GO:0005793
"IDA"
GO:0005794 GO:0005794 GO:0005829 GO:0016020 GO:0016020 GO:0016020 GO:0031410
"IDA"
GO:0070062 GO:0004571 GO:0004571 GO:0004571 GO:0004571 GO:0005509 GO:0005509
"TAS"

"IEA"

"IEA"

"IDA"

"IDA"

"IBA"

"IEA"

"IBA"

"TAS"

"IDA"

"HDA"

"IEA"

"TAS"

"TAS"

"IEA"

"IMP"

"TAS"

"IEA"

"IBA"

"HDA"

"IMP"
GO:0005515 GO:0015923 GO:0016787 GO:0016798
"IEA"

"IEA"

"IPI"

"TAS"

> zz = dropECode(ll1)
> getEvidence(zz)

5

"IBA"

"IDA"

GO:0036503 GO:0036503 GO:0045047 GO:1904381 GO:1904382 GO:0000139 GO:0000139
"TAS"
GO:0005783 GO:0005783 GO:0005793 GO:0005794 GO:0005829 GO:0016020 GO:0016020
"TAS"
GO:0031410 GO:0070062 GO:0004571 GO:0004571 GO:0004571 GO:0005509 GO:0005515
"IPI"

"IMP"

"IDA"

"IDA"

"IBA"

"TAS"

"IMP"

"HDA"

"TAS"

"IBA"

"IBA"

"HDA"

"TAS"

"IDA"

"TAS"

"IDA"

"IDA"
GO:0015923
"TAS"

>

A Basic Description of GO

We now characterize GO and some of its properties. First we list some of the specific GO IDs
that might be of interest (please feel free to propose even more).

• GO:0003673 is the GO root.

• GO:0003674 is the MF root.

• GO:0005575 is the CC root.

• GO:0008150 is the BP root.

• GO:0000004 is biological process unknown

• GO:0005554 is molecular function unknown

• GO:0008372 is cellular component unknown

We can find out how many terms are in each of the different ontologies by:

>
>

zz = Ontology(GOTERM)
table(unlist(zz))

BP
25699

CC
4052

MF universal
1

10155

>

Or we can ask about the number of is-a and partof relationships in each of the three differ-

ent ontologies.

>
>

BPisa = eapply(GOBPPARENTS, function(x) names(x))
table(unlist(BPisa))

6

44495
positively regulates
2608

isa negatively regulates
2607
regulates
2980

part of
4772

>
>

MFisa = eapply(GOMFPARENTS, function(x) names(x))
table(unlist(MFisa))

isa part of
8

12588

>
>

CCisa = eapply(GOCCPARENTS, function(x) names(x))
table(unlist(CCisa))

isa part of
1818

4640

>

Working with GO

Finding terms that have specific character strings in them is easily accomplished using grep.
In the next example we first convert the data from GOTERM into a character vector to make it
easier to do multiple searches.

>
>

goterms = unlist(Term(GOTERM))
whmf = grep("fertilization", goterms)

So we see that there are 15 terms with the string “fertilization” in them in the ontology.

They can be accessed by subsetting the goterms object.

>

goterms[whmf]

"fusion of sperm to egg plasma membrane involved in single fertilization"

"double fertilization forming a zygote and endosperm"

"double fertilization forming two zygotes"

7

"single fertilization"

GO:0007338

GO:0007342

GO:0009566

"fertilization"

GO:0009567

GO:0009677

"respiratory burst at fertilization"

"fertilization envelope"

"negative regulation of fertilization"

"fusion of sperm to egg plasma membrane involved in double fertilization forming two zygotes"

"fusion of sperm to egg plasma membrane involved in double fertilization forming a zygote and endosperm"

"regulation of double fertilization forming a zygote and endosperm"

"regulation of fertilization"

"male-female gamete recognition during double fertilization forming a zygote and endosperm"

"prevention of polyspermy during double fertilization"

"positive regulation of fertilization"

GO:0045729

GO:0060387

GO:0060467

GO:0061935

GO:0061936

GO:0080154

GO:0080155

GO:0080173

GO:0160071

GO:1905516

>

Working with chip specific meta-data

In some cases users will want to restrict their attention to the set of terms etc that map to genes
that were assayed in the experiments that they are working with. To do this you should first
get the appropriate chip specific meta-data file. Here we demonstrate some of the examples on
the Affymetrix HGu95av2 chips and so use the package hgu95av2.db. Each of these packages
has a data environment whose name is the basename of the package with a GO suffix, so in
this case hgu95av2GO. Note that if there are many manufacturer ids that map to the same
Entrez Gene identifier then these will be duplicate entries (with different keys).

We can get all the MF terms for our Affymetrix data.

> affyGO = eapply(hgu95av2GO, getOntology)
> table(sapply(affyGO, length))

1

2

3

4

0
1324
16

5
823 974 1193 1228 1146
21
19
30
53
41
38
2
3

20
41
40
4

18
60
35
4

17
131 106
34
7

32
4

7
884
23
21

8
850
24
16

9
760
25
24

10
479
26
7

11
419
27
8

12

13

14

403 233 189 163

28
4

29
7

30
10

15

31

8

6
973
22
32
43
2

8

>

How many of these probes have multiple GO terms associated with them? What do we do

if we want to compare two genes that have multiple GO terms associated with them?

What about evidence codes? To find these we apply a similar function to the affyGO terms.

> affyEv = eapply(hgu95av2GO, getEvidence)
> table(unlist(affyEv, use.names=FALSE))

EXP
872
IMP

HDA
6977
IPI
23314 18588

HEP
55
ISA
1343

HMP
114
ISM
1

HTP
617
ISO
292

IBA
47989
ISS
28280

IC
1356
NAS
11097

>

IDA

IEP
IEA
1108
78081 180452
RCA
TAS
156 35103

ND
72

IGI
2217

> test1 = eapply(hgu95av2GO, dropECode, c("IEA", "NR"))
> table(unlist(sapply(test1, getEvidence),
+

use.names=FALSE))

HMP
HEP
HDA
EXP
114
55
872 6977
ISO
ISM
NAS
ISS
292 28280 11097
1

IC

IDA
1356 78081

IBA
HTP
617 47989
RCA
TAS
156 35103

ND
72

IEP
1108

IGI

ISA
2217 23314 18588 1343

IPI

IMP

These functions make is somewhat straightforward to select subsets of the GO terms that

are specific to different evidence codes.

References

E. Camon, M. Magrane, D. Barrell, V. Lee, E. Dimmer, D. Binns J. Maslen, N. Harte,
R. Lopez, and R. Apweiler. The Gene Ontology annotation (GOA) database: sharing knowl-
edge in Uniprot with Gene Ontology. Nucleic Acids Research, 32:D262–D266, 2004.

The Gene Ontology Consortium. Gene Ontology: tool for the unification of biology. Nature

Genetics, 25:25–29, 2000.

9

