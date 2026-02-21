Synthetic Genetic Interaction in Yeast genes

N. LeMeur and Z. Jiang

October 30, 2017

1 Introduction

Synthetic genetic interactions experiments are now being conduct to better understand cellu-
lar interactions. The generated data have already proven to be extremely valuable (Davier-
wala et al., 2005; A et al., 2004; Zhao et al., 2005). Synthetic lethality especially deﬁnes
a genetic interaction were the combination of mutations in two or more genes leads to cell
death. The implications of synthetic lethal screens have been discussed in the context of
drug development as synthetic lethal pairs could be used to selectively kill cancer cells, but
leave normal cells relatively unharmed.

In this package, we propose statistical and computational tools for a systems biology
approach in analyzing synthetic genetic interactions. Currently, our methods can be used
to ﬁnd relationships between synthetic genetic interactions and cellular organizational units
such multi-protein complexes or sequence motifs.

2 Synthetic genetic interaction data

Several synthetic genetic datasets are now publicly available. In this package we currently
propose 6 datasets:

(cid:136) A et al. (2004) Systematic genetic analysis with ordered arrays of yeast deletion

(cid:136) Pan et al. (2006) DNA integrity experiment in S. cerevisiae

(cid:136) Measday et al. (2005) Systematic yeast synthetic lethal and synthetic dosage lethal

screens identify genes required for chromosome segregation.

(cid:136) Schuldiner et al. (2005) Genetic Interaction Data (EMAP) from the yeast early secre-

tory pathway

(cid:136) Collins et al. (2007) Functional dissection of protein complexes involved in yeast chro-

mosome biology using a genetic interaction map.

1

(cid:136) Chervitz et al. (1999) Synthetic genetic interaction data from as recorded by the Sac-

charomyces Genome database in January, 2007.

In this package and as reported by most authors, we use the terms query genes for the
genes that are speciﬁcally tested by the experimenter and array genes for the target genes
usually spotted on a array (e.g., SGA, dSLAM). We note however that an analogy can be
made with the concept of bait and prey terms used in proteomic experiments (e.g., Y2H,
APMS).

2.1 Synthetic genetic array data, Tong et al. (2004)

Tong et al. (2001) used the Synthetic Genetic Array technology or SGA to investigate syn-
thetic genetic interaction in S. cerevisiae. The package SLGI contains both the raw and
preprocessed data from A et al. (2004). To access those data you ﬁrst need to load the
package SLGI and the yeast genome annotation package (org.Sc.sgd.db):

> library("SLGI")
> library("org.Sc.sgd.db")
> ##loading Tong et al data
> data(SGA)
> data(Atong)

Data SGA contains the systematic names of all the 4655 genes tested by A et al. (2004),
including both the ones that were reported as presenting synthetic genetic interactions and
the ones that were not (SGAraw corresponds to the original list parsed from table1 of Tong
et al. (2001) supplementary material).

We can verify that the genes reported by A et al. (2004) are well characterized. To that

aim, we use the yeast annotation data package org.Sc.sgd.db:

> rejected <- length(intersect(SGA, org.Sc.sgdREJECTORF))

We note that at this time 385 genes (out of the 4655) are among the rejected ORF listed
by the Saccharomyces Genome Database (SGD http://www.yeastgenome.org/). If one want
to update common gene names or alias to systematic names, one can use the following:

> updateSGA=mget(SGA, org.Sc.sgdCOMMON2ORF, ifnotfound = NA )

The tong2004raw data.frame contains the original data reported by A et al. (2004) as
Table S1 in their online supporting material. The Atong data contains the association matrix
extracted from the tong2004raw data.frame. The gene names were updated for systematic
gene names. They selected 132 query genes that are known involved in a chosen set of
molecular functions.

There are 11 essential genes found in the query genes. A et al. (2004) pointed out that
some of the query genes are partially functioning alleles of essential genes. So, we assumed

2

these genes are ﬁne. There are also 3 essential genes in the reported array genes that showed
synthetic lethal (SL) interaction with at least one of the query genes. We checked these three
genes. Two of them, ”YJL174W” and ”YPL075W” , are annotated both ”lethal” and ”viable”
in the SGD database. The other gene, ”YBR121C”, is ”lethal”. We don’t have the resources
to tract down why this gene appears on the SGA array Tong et al. (2001).

2.1.1 Synthetic lethal and synthetic dosage lethal screens, Measday et al (2005)

Measday et al. (2005) perform some systematic yeast synthetic lethal and synthetic dosage
lethal screens using the SGA approach (Tong et al., 2001). They ﬁrst tested 14 query genes
and found 84 non-essential genes that synthetically interact with at least one query gene
(SLchr). Then they tested interaction between 3 query genes and the genome wide set of
deletion strains under 3 diﬀerent temperatures. They found 141 array genes that interact at
least with one query gene (SDL). They identiﬁed genes required for chromosome segregation.

2.2 DNA integrity experiment in S. cerevisiae, Pan et al (2006)

The package contains raw and preprocessed data from Pan et al. (2006) obtained in Boeke’s
lab.

> data(Boeke2006raw)
> data(Boeke2006)

Boeke2006raw is a data frame with 5775 observations and Boeke2006 is an incidence
matrix reporting the systematic genetic interactions identiﬁed between 74 query genes and
the deletion gene set in Pan et al. (2004) (see man pages for more details).

The technology used by Boeke and collaborators is slightly diﬀerent from the approach
taken by Tong et al. (2001). The used heterozygote diploid-based synthetic lethality analyzed
by microarray (dSLAM). The 21991 probes spotted on the dSLAM array are available by
calling dSLAM.GPL1444 or dSLAM (see man pages for more details).

2.3 Genetic Interaction Data (EMAP), Schuldiner et al (2005)

and Collins (2007)

We also collected data generated by Collins and collaborators. These data are diﬀerent from
the other as they have be heavily preprocessed using their own procedure, EMAP or epistatic
miniarray proﬁles. Those data are presented as incidence matrix and are accompanied by
some metadata, e.g., systematic names and mutated allele.

> ## Schuldiner et al. (2005)
> data(gi2005)
> data(gi2005.metadata)

3

2.4 Saccharomyces Genome database

We provide synthetic genetic interaction data as recorded by the Saccharomyces Genome
database in January, 2007. Data can be accessed using SGD.SL, synthetic lethal, SGD.SynRescue,
synthetic rescue, and SGD.SynGrowthDefect, synthetic growth defect.

3 Transcription Factor data

The transcription factor binding aﬃnities data were extracted from Lee et al. (2002). They
represented as an matrix where rows are S. cerevisiae systematic gene names and columns
known transcription factor. The value in each entry represents the p-value, as reported by
Lee et al. (2002), for the transcription factor (TF) binding upstream of the gene.

> data(TFmat)

4 Example of analysis: Synthetic genetic interactions

and multi-protein complexes

To integrate synthetic genetic interactions with multi-protein complexes, we can make use of
the interactome as deﬁned in the ScISI package. The ScISI package or In Silico Interactome for
Saccharomyces cerevisiae provides an interactome built for computational experimentation.
The ScISI is binary incidence matrix where the rows are indexed by the gene locus names
and the columns are indexed by the identiﬁcation codes for the protein complexes based
on the repository from where they are obtained. This interactome is currently built from
the Intact, Gene Ontology and Mips curated databases, and estimated protein complexes
from the apComplex package. In this vignette, we will make use of a subset of the ScISI
interactome, the ScISIC data, that only contains the data from the curated databases.

> library(ScISI)
> data(ScISIC)
> ScISIC[1:5, 1:5]

EBI-913756
EBI-876785
EBI-852570
EBI-866976
EBI-1180400

EBI-913756 EBI-876785 EBI-852570 EBI-866976 EBI-1180400
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

As an example we will use the data generated by Pan et al. (2006).First, one need to
reduce the interactome matrix and genetic interaction matrix to the same list of genes. This
can be done using the gi2Interactome function.

4

> data(Boeke2006)
> data(dSLAM)
> dim(Boeke2006)

[1] 74 843

> Boeke2006red <- gi2Interactome(Boeke2006, ScISIC)
> dim(Boeke2006red)

[1] 46 320

Next we can identify multi-protein complexes that present synthetic interaction among
their proteins (within interaction) or share synthetic interaction with other multi-
protein complex (between interaction) using the getInteraction function. This
function requires the incidence matrix, the array list and the interactome of
interest.

> interact <- getInteraction(Boeke2006red, dSLAM, ScISIC)

Then, one might want to know how what are the multi-protein complexes

that share at least n interactions:

> intSummary <- iSummary(interact$bwMat, n=5)

---------Count: 7 -----------
GO:0031390 Ctf18 RFC-like complex
EBI-1252538 Ctf18 RFC-like complex
---------Count: 12 -----------
GO:0000417 HIR complex
EBI-1236334 HIR complex
---------Count: 9 -----------
GO:0030870 Mre11 complex
EBI-1236334 Mre11 complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
EBI-1236334 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0031390 Ctf18 RFC-like complex
EBI-1251060 Ctf18 RFC-like complex
---------Count: 9 -----------
GO:0000502 proteasome complex
GO:0000118 histone deacetylase complex
---------Count: 6 -----------
GO:0030015 CCR4-NOT core complex

5

GO:0000118 histone deacetylase complex
---------Count: 8 -----------
GO:0031415 NatA complex
GO:0000118 histone deacetylase complex
---------Count: 9 -----------
GO:0043529 GET complex
GO:0000118 histone deacetylase complex
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0000118 histone deacetylase complex
---------Count: 8 -----------
MIPS-370 Protein N-acetyltransferase
GO:0000118 histone deacetylase complex
---------Count: 6 -----------
MIPS-360 Proteasome
GO:0000118 histone deacetylase complex
---------Count: 7 -----------
GO:0000502 proteasome complex
GO:0000119 Not found (possibly deprecated)
---------Count: 10 -----------
GO:0043529 GET complex
GO:0000119 Not found (possibly deprecated)
---------Count: 6 -----------
GO:0005694 chromosome
GO:0000119 Not found (possibly deprecated)
---------Count: 6 -----------
GO:0000812 Swr1 complex
GO:0000151 ubiquitin ligase complex
---------Count: 6 -----------
GO:0030870 Mre11 complex
GO:0000151 ubiquitin ligase complex
---------Count: 6 -----------
GO:0035267 NuA4 histone acetyltransferase complex
GO:0000151 ubiquitin ligase complex
---------Count: 7 -----------
GO:0005694 chromosome
GO:0000151 ubiquitin ligase complex
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0000151 ubiquitin ligase complex
---------Count: 8 -----------
GO:0030529 intracellular ribonucleoprotein complex

6

GO:0000417 HIR complex
---------Count: 6 -----------
GO:0032806 carboxy-terminal domain protein kinase complex
GO:0000417 HIR complex
---------Count: 9 -----------
GO:0000508 Not found (possibly deprecated)
GO:0000502 proteasome complex
---------Count: 6 -----------
GO:0016469 proton-transporting two-sector ATPase complex
GO:0000502 proteasome complex
---------Count: 15 -----------
GO:0030529 intracellular ribonucleoprotein complex
GO:0000502 proteasome complex
---------Count: 6 -----------
GO:0030870 Mre11 complex
GO:0000502 proteasome complex
---------Count: 6 -----------
GO:0030897 HOPS complex
GO:0000502 proteasome complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0000502 proteasome complex
---------Count: 7 -----------
GO:0033263 CORVET complex
GO:0000502 proteasome complex
---------Count: 11 -----------
GO:0005694 chromosome
GO:0000502 proteasome complex
---------Count: 15 -----------
GO:0005840 ribosome
GO:0000502 proteasome complex
---------Count: 6 -----------
MIPS-240.20 HDB complex
GO:0000502 proteasome complex
---------Count: 6 -----------
MIPS-260.80 Class C Vps protein complex
GO:0000502 proteasome complex
---------Count: 6 -----------
MIPS-220 H+-transporting ATPase, vacuolar
GO:0000502 proteasome complex
---------Count: 6 -----------
GO:0030015 CCR4-NOT core complex

7

GO:0000508 Not found (possibly deprecated)
---------Count: 9 -----------
GO:0031415 NatA complex
GO:0000508 Not found (possibly deprecated)
---------Count: 14 -----------
GO:0043529 GET complex
GO:0000508 Not found (possibly deprecated)
---------Count: 7 -----------
GO:0005694 chromosome
GO:0000508 Not found (possibly deprecated)
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0000508 Not found (possibly deprecated)
---------Count: 9 -----------
MIPS-370 Protein N-acetyltransferase
GO:0000508 Not found (possibly deprecated)
---------Count: 8 -----------
GO:0030015 CCR4-NOT core complex
GO:0000812 Swr1 complex
---------Count: 8 -----------
GO:0031415 NatA complex
GO:0000812 Swr1 complex
---------Count: 6 -----------
GO:0043529 GET complex
GO:0000812 Swr1 complex
---------Count: 6 -----------
GO:0005694 chromosome
GO:0000812 Swr1 complex
---------Count: 8 -----------
MIPS-510.190.110 CCR4 complex
GO:0000812 Swr1 complex
---------Count: 8 -----------
MIPS-370 Protein N-acetyltransferase
GO:0000812 Swr1 complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0000814 ESCRT II complex
---------Count: 6 -----------
GO:0031415 NatA complex
GO:0000814 ESCRT II complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase

8

GO:0000814 ESCRT II complex
---------Count: 6 -----------
MIPS-360 Proteasome
GO:0000814 ESCRT II complex
---------Count: 6 -----------
GO:0030015 CCR4-NOT core complex
GO:0000815 ESCRT III complex
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0000815 ESCRT III complex
---------Count: 6 -----------
GO:0043529 GET complex
GO:0000938 GARP complex
---------Count: 8 -----------
GO:0043529 GET complex
GO:0005667 transcription factor complex
---------Count: 6 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0005678 Not found (possibly deprecated)
---------Count: 6 -----------
GO:0033263 CORVET complex
GO:0005678 Not found (possibly deprecated)
---------Count: 8 -----------
GO:0005694 chromosome
GO:0005678 Not found (possibly deprecated)
---------Count: 7 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0005680 anaphase-promoting complex
---------Count: 6 -----------
GO:0030870 Mre11 complex
GO:0005732 small nucleolar ribonucleoprotein complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0005871 kinesin complex
---------Count: 6 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0005875 microtubule associated complex
---------Count: 6 -----------
GO:0043529 GET complex
GO:0008023 transcription elongation factor complex
---------Count: 7 -----------
GO:0005694 chromosome

9

GO:0008540 proteasome regulatory particle, base subcomplex
---------Count: 16 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0016272 prefoldin complex
---------Count: 9 -----------
GO:0031415 NatA complex
GO:0016272 prefoldin complex
---------Count: 6 -----------
GO:0005838 proteasome regulatory particle
GO:0016272 prefoldin complex
---------Count: 9 -----------
MIPS-370 Protein N-acetyltransferase
GO:0016272 prefoldin complex
---------Count: 6 -----------
MIPS-360 Proteasome
GO:0016272 prefoldin complex
---------Count: 10 -----------
GO:0030015 CCR4-NOT core complex
GO:0016469 proton-transporting two-sector ATPase complex
---------Count: 6 -----------
GO:0031415 NatA complex
GO:0016469 proton-transporting two-sector ATPase complex
---------Count: 16 -----------
GO:0043529 GET complex
GO:0016469 proton-transporting two-sector ATPase complex
---------Count: 10 -----------
MIPS-510.190.110 CCR4 complex
GO:0016469 proton-transporting two-sector ATPase complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
GO:0016469 proton-transporting two-sector ATPase complex
---------Count: 6 -----------
GO:0031415 NatA complex
GO:0016514 SWI/SNF complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
GO:0016514 SWI/SNF complex
---------Count: 8 -----------
GO:0031415 NatA complex
GO:0016585 Not found (possibly deprecated)
---------Count: 8 -----------
MIPS-370 Protein N-acetyltransferase

10

GO:0016585 Not found (possibly deprecated)
---------Count: 10 -----------
GO:0043529 GET complex
GO:0017119 Golgi transport complex
---------Count: 11 -----------
GO:0030529 intracellular ribonucleoprotein complex
GO:0030015 CCR4-NOT core complex
---------Count: 6 -----------
GO:0030870 Mre11 complex
GO:0030015 CCR4-NOT core complex
---------Count: 6 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0030015 CCR4-NOT core complex
---------Count: 6 -----------
GO:0000274 mitochondrial proton-transporting ATP synthase, stator stalk
GO:0030015 CCR4-NOT core complex
---------Count: 6 -----------
MIPS-240.20 HDB complex
GO:0030015 CCR4-NOT core complex
---------Count: 9 -----------
MIPS-420.50 F0/F1 ATP synthase (complex V)
GO:0030015 CCR4-NOT core complex
---------Count: 12 -----------
GO:0030870 Mre11 complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 18 -----------
GO:0031415 NatA complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 9 -----------
GO:0033062 Rhp55-Rhp57 complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 8 -----------
GO:0033551 monopolin complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 11 -----------
GO:0043529 GET complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 13 -----------
GO:0005694 chromosome

11

GO:0030529 intracellular ribonucleoprotein complex
---------Count: 12 -----------
GO:0005838 proteasome regulatory particle
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 11 -----------
MIPS-510.190.110 CCR4 complex
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 18 -----------
MIPS-370 Protein N-acetyltransferase
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 12 -----------
MIPS-360 Proteasome
GO:0030529 intracellular ribonucleoprotein complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0030870 Mre11 complex
---------Count: 6 -----------
GO:0031415 NatA complex
GO:0030870 Mre11 complex
---------Count: 9 -----------
GO:0032806 carboxy-terminal domain protein kinase complex
GO:0030870 Mre11 complex
---------Count: 6 -----------
GO:0033551 monopolin complex
GO:0030870 Mre11 complex
---------Count: 6 -----------
GO:0043234 protein complex
GO:0030870 Mre11 complex
---------Count: 6 -----------
GO:0043529 GET complex
GO:0030870 Mre11 complex
---------Count: 6 -----------
GO:0046540 U4/U6 x U5 tri-snRNP complex
GO:0030870 Mre11 complex
---------Count: 10 -----------
GO:0005694 chromosome
GO:0030870 Mre11 complex
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0030870 Mre11 complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase

12

GO:0030870 Mre11 complex
---------Count: 9 -----------
MIPS-360 Proteasome
GO:0030870 Mre11 complex
---------Count: 9 -----------
GO:0031390 Ctf18 RFC-like complex
GO:0030897 HOPS complex
---------Count: 6 -----------
GO:0031415 NatA complex
GO:0030897 HOPS complex
---------Count: 8 -----------
GO:0043529 GET complex
GO:0030897 HOPS complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
GO:0030897 HOPS complex
---------Count: 6 -----------
GO:0031415 NatA complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0032806 carboxy-terminal domain protein kinase complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 12 -----------
GO:0033263 CORVET complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0033551 monopolin complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 9 -----------
GO:0033597 mitotic checkpoint complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0035267 NuA4 histone acetyltransferase complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0043529 GET complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0046695 SLIK (SAGA-like) complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
GO:0000786 nucleosome

13

GO:0031390 Ctf18 RFC-like complex
---------Count: 13 -----------
GO:0005694 chromosome
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
MIPS-125.10.10 Ddc1p-Mec3p complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 9 -----------
MIPS-260.80 Class C Vps protein complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
MIPS-310 Nuclear pore complex (NPC)
GO:0031390 Ctf18 RFC-like complex
---------Count: 9 -----------
MIPS-510.190.110 CCR4 complex
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
GO:0031390 Ctf18 RFC-like complex
---------Count: 6 -----------
MIPS-360 Proteasome
GO:0031390 Ctf18 RFC-like complex
---------Count: 8 -----------
GO:0033263 CORVET complex
GO:0031415 NatA complex
---------Count: 6 -----------
GO:0046540 U4/U6 x U5 tri-snRNP complex
GO:0031415 NatA complex
---------Count: 12 -----------
GO:0005681 spliceosomal complex
GO:0031415 NatA complex
---------Count: 13 -----------
GO:0005694 chromosome
GO:0031415 NatA complex
---------Count: 6 -----------
GO:0005840 ribosome
GO:0031415 NatA complex
---------Count: 6 -----------
MIPS-240.20 HDB complex
GO:0031415 NatA complex
---------Count: 6 -----------
MIPS-260.80 Class C Vps protein complex

14

GO:0031415 NatA complex
---------Count: 6 -----------
MIPS-510.190.50 SWI/SNF transcription activator complex
GO:0031415 NatA complex
---------Count: 6 -----------
MIPS-220 H+-transporting ATPase, vacuolar
GO:0031415 NatA complex
---------Count: 6 -----------
GO:0033551 monopolin complex
GO:0032806 carboxy-terminal domain protein kinase complex
---------Count: 6 -----------
GO:0043529 GET complex
GO:0032806 carboxy-terminal domain protein kinase complex
---------Count: 7 -----------
GO:0005694 chromosome
GO:0032806 carboxy-terminal domain protein kinase complex
---------Count: 8 -----------
GO:0043529 GET complex
GO:0033263 CORVET complex
---------Count: 8 -----------
MIPS-370 Protein N-acetyltransferase
GO:0033263 CORVET complex
---------Count: 7 -----------
MIPS-360 Proteasome
GO:0033263 CORVET complex
---------Count: 6 -----------
GO:0005694 chromosome
GO:0033551 monopolin complex
---------Count: 10 -----------
GO:0043529 GET complex
GO:0033588 Elongator holoenzyme complex
---------Count: 6 -----------
GO:0005694 chromosome
GO:0035267 NuA4 histone acetyltransferase complex
---------Count: 8 -----------
GO:0005694 chromosome
GO:0043234 protein complex
---------Count: 8 -----------
GO:0048188 Set1C/COMPASS complex
GO:0043529 GET complex
---------Count: 6 -----------
GO:0000220 vacuolar proton-transporting V-type ATPase, V0 domain

15

GO:0043529 GET complex
---------Count: 10 -----------
GO:0000221 vacuolar proton-transporting V-type ATPase, V1 domain
GO:0043529 GET complex
---------Count: 22 -----------
GO:0005694 chromosome
GO:0043529 GET complex
---------Count: 6 -----------
GO:0005840 ribosome
GO:0043529 GET complex
---------Count: 6 -----------
MIPS-133.40 Srb10p complex
GO:0043529 GET complex
---------Count: 6 -----------
MIPS-240.20 HDB complex
GO:0043529 GET complex
---------Count: 10 -----------
MIPS-260.20 Clathrin-associated protein (AP) complex
GO:0043529 GET complex
---------Count: 8 -----------
MIPS-260.80 Class C Vps protein complex
GO:0043529 GET complex
---------Count: 8 -----------
MIPS-510.40.20 Kornberg
GO:0043529 GET complex
---------Count: 16 -----------
MIPS-220 H+-transporting ATPase, vacuolar
GO:0043529 GET complex
---------Count: 12 -----------
MIPS-510.40 RNA polymerase II holoenzyme
GO:0043529 GET complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
GO:0046540 U4/U6 x U5 tri-snRNP complex
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0000274 mitochondrial proton-transporting ATP synthase, stator stalk
---------Count: 12 -----------
MIPS-370 Protein N-acetyltransferase
GO:0005681 spliceosomal complex
---------Count: 6 -----------
GO:0005694 chromosome

s mediator (SRB) complex

’

16

GO:0005694 chromosome
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
GO:0005694 chromosome
---------Count: 13 -----------
MIPS-370 Protein N-acetyltransferase
GO:0005694 chromosome
---------Count: 12 -----------
MIPS-360 Proteasome
GO:0005694 chromosome
---------Count: 12 -----------
GO:0005840 ribosome
GO:0005838 proteasome regulatory particle
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
GO:0005840 ribosome
---------Count: 13 -----------
MIPS-360 Proteasome
GO:0005840 ribosome
---------Count: 6 -----------
MIPS-510.190.110 CCR4 complex
MIPS-240.20 HDB complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
MIPS-240.20 HDB complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
MIPS-260.80 Class C Vps protein complex
---------Count: 9 -----------
MIPS-510.190.110 CCR4 complex
MIPS-420.50 F0/F1 ATP synthase (complex V)
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
MIPS-510.190.50 SWI/SNF transcription activator complex
---------Count: 6 -----------
MIPS-370 Protein N-acetyltransferase
MIPS-220 H+-transporting ATPase, vacuolar

Finally, we want to know if any of those interactions are statistically signif-
icant. To that aim we developed 2 approaches. First, using a graph theory
approach, we test whether those interactions are randomly distributed within
the interactome.

> modelBoeke <- modelSLGI(Boeke2006red,

17

+

universe= dSLAM, interactome=ScISIC,type="intM", perm=5)

A plot function allows you the visualize the result. In this case, we note that
the number of observed synthetic genetic interaction is globally higher that the
simulated data

> plot(modelBoeke,pch=20)

echo=FALSE,ﬁg=TRUE print(plot(modelBoeke,pch=20))

Note that here, for computer time eﬃciency, we only performed 5 permuta-
tions but for really analysis 100 permutations or more are strongly recommended.
Next, we can perform a Hypergeometric test to identify the multi-protein

complexes that presents a unusual number of synthetic genetic interaction.

The test2Interact function allows you to summarize the genetic interactions
within one cellular organizational unit or between 2 cellular organizational units,
taking into account all the interactions tested (positive or negative). One can
compute the global interaction matrix as follows:

> array <- dSLAM[dSLAM %in% rownames(ScISIC)]
> query <- rownames(Boeke2006)[rownames(Boeke2006) %in% rownames(ScISIC)]
> allInteract <- matrix(1, nrow=length(query), ncol=length(array),
+
> tested <- getInteraction(allInteract, dSLAM, ScISIC)

dimnames=list(query, array))

> testedInteract <- test2Interact(iMat=interact$bwMat, tMat=tested$bwMat, interactome=ScISIC)
> significant <- hyperG(cbind("Tested"=testedInteract$tested,"Interact"=testedInteract$interact),
+

sum(Boeke), nrow(Boeke2006red)*length(dSLAM))

References

Tong A et al. Global mapping of the yeast genetic interaction network. Science,

303:808–813, Feb. 2004.

S.A. Chervitz, E.T. Hester, C.A. Ball, et al. Using the Saccharomyces Genome
Database (SGD) for analysis of protein similarities and structure. 27(1):74–78,
1999.

SR Collins, KM Miller, NL Maas, A Roguev, J Fillingham, CS Chu,
M Schuldiner, M Gebbia, J Recht, M Shales, et al. Functional dissection
of protein complexes involved in yeast chromosome biology using a genetic
interaction map. Nature, 446(7137):806–810, 2007.

18

PA Davierwala, J Haynes, Z Li, RL Brost, MD Robinson, L Yu, S Mnaimneh,
H Ding, H Zhu, Y Chen, X Cheng, GW Brown, C Boone, BJ Andrews, and
TR Hughes. The synthetic genetic interaction spectrum of essential genes.
Nat Genet, 37(10):1147–1152, Oct 2005.

TI Lee, NJ Rinaldi, F Robert, et al. Transcriptional regulatory networks in

Saccharomyces cerevisiae. Science, 298:799–804, 2002.

V. Measday, K. Baetz, J. Guzzo, K. Yuen, T. Kwok, B. Sheikh, H. Ding, R. Ueta,
T. Hoac, B. Cheng, et al. Systematic yeast synthetic lethal and synthetic
dosage lethal screens identify genes required for chromosome segregation. Proc
Natl Acad Sci US A, 102(39):13956–13961, 2005.

X Pan, DS Yuan, D Xiang, X Wang, S Sookhai-Mahadeo, JS Joel S Bader,
P Hieter, F Spencer, and JD Boeke. A robust toolkit for functional proﬁling
of the yeast genome. Mol Cell, 16(3):487–496, 2004.

X Pan, P Ye, DS Yuan, et al. A DNA integrity network in the yeast Saccha-

romyces cerevisiae. Cell, 124:1069–1081, 2006.

M. Schuldiner, S.R. Collins, N.J. Thompson, V. Denic, A. Bhamidipati,
T. Punna, J. Ihmels, B. Andrews, C. Boone, J.F. Greenblatt, et al. Explo-
ration of the Function and Organization of the Yeast Early Secretory Pathway
through an Epistatic Miniarray Proﬁle. Cell, 123(3):507–519, 2005.

AH Tong, M Evangelista, AB Parsons, H Xu, GD Bader, N Page, M Robinson,
S Raghibizadeh, CW Hogue, H Bussey, B Andrews, M Tyers, and C Boone.
Systematic genetic analysis with ordered arrays of yeast deletion mutants. 294
(5550):2364 – 8, 2001.

R Zhao, M Davey, Y-C. Hsu, et al. Navigating the chaperone network: An
integrative map of physical and genetic interactions mediated by the Hsp90
chaperone. Cell, 120:715–727, 2005.

19

