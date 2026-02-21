RpsiXML: An R programmatic interface with PSI

Jitao David Zhang and Tony Chiang

October 30, 2017

Abstract

We demonstrate the use and capabilities of the software package RpsiXML by ex-
amples. Thie package provides a programmatic interface with those databases which
adhere to the PSI-MI XML2.5 standardization for molecular interactions. Each exper-
imental dataset from any of the databases can be read into R and converted into a
psimi25Graph object upon which computatational analyses can be conducted.

1 Introduction

Molecular interactions play an important role in the organizational and functional hierarchy
of cells and tissues. Such molecular interaction data has been made publicly available on a
wide variety of public databases. Statistical and computational analysis of these datasets
necessitates the automated capability of downloading, extracting, parsing, and converting
these data into a uniform structure.

Recently, the Protein Standardization Initiative has developed the PSI-MI 2.5 XML
schema for documenting molecular interaction data. While XML is a particularly good
format for data storage and exchange, it is less amenable to compuatational analysis. The
contents of the XML ﬁles need to be parsed and transformed in structures upon which
computation analysis is more feasible and apropros.

The Bioconductor software package RpsiXML serves as a programmatic interface be-
tween the R statistical environment and the PSI-MI 2.5 XML ﬁles. This software should
be able to parse the XML ﬁles from any database which implement a valid PSI-MI 2.5
schema; currently, the databases that are supported by RpsiXML are:

1. IntAct

2. MINT

3. DIP

4. HPRD

1

5. BioGRID

6. MIPS/CORUM

7. MatrixDB

8. MPact

We plan to support other databases which are now porting to the PSI-MI XML2.5 schema.

In this vignette, we demonstrate the basic functionalities of RpsiXML.

2 Preliminaries

2.1 Obtaining the XML Files

Each of the data repositories has its own FTP or download site from which the PSI-MI 2.5
XML ﬁles can be obtained. Here we list each database as well as the location of each FTP
or download site:

ftp://ftp.ebi.ac.uk/pub/databases/intact/current/psi25
ftp://mint.bio.uniroma2.it/pub/release/psi/2.5/current/
http://dip.doe-mbi.ucla.edu/dip/Download.cgi
http://www.hprd.org/download
http://www.thebiogrid.org/downloads.php

IntAct
Mint
DIP
HPRD
The BioGRID
CORUM/MIPS http://mips.gsf.de/genre/proj/corum
not published yet
MatrixDB
ftp://ftpmips.gsf.de/yeast/PPI
MPact

The DIP repository requires one to create a login account before accessing the data. Each of
the PSI-MI XML2.5 ﬁles should be downloaded to the local ﬁle directory which is accessible
by the R environment.

We have downloaded XML ﬁles from each of the molecular interaction data repository
listed above; we have, however, modiﬁed these datasets by truncating most of the data so
as to provide the user with helpful sample XML ﬁles that is not to large. If the user has the
source package, these sample XML ﬁles can be found within the inst/estdata/psi25ﬁles/
directory of the package. Otherwise, once the package has been loaded, each ﬁle can be
loaded into an R session with the following calls:

(First we load the package) (Then we create a path to the ﬁles)

> xmlDir <- system.file("/extdata/psi25files",package="RpsiXML")
> gridxml <- file.path(xmlDir, "biogrid_200804_test.xml")

The ﬁrst line of code above creates a path to the desired directory while the second line
constructs the path to the biogrid sample ﬁle in a platform independent manner.

2

Table 2.1 gives the names of the sample XML ﬁles with the corresponding database

repository:

IntAct

intact 2008 test.xml
intact complexSample.xm
mint 200711 test.xml
dip 2008 test.xml
hprd 200709 test.xml
biogrid 200804 test.xml

Mint
DIP
HPRD
The BioGRID
CORUM/MIPS mips 2007 test.xml
MatrixDB

matrixdb 20080609.xml

It should be noted that IntAct has two diﬀerent kinds of sample XML ﬁles: the ”test”
ﬁle stores the bait-prey interaction data while the ”complex” ﬁle stores manually curated
protein complex membership information. For the scope of this vignette, we will focus on
the IntAct ﬁles as our working examples, but we encourage the reader to work explore the
other ﬁles as well.

2.2 XML into R

There are two diﬀerent methods for parsing the PSI-MI XML2.5 ﬁles:

2.2.1 parsePsimi25Interaction

The ﬁrst method relies on the function parsePsimi25Interaction which systematically
searches over the XML tree structure and returns the ﬁelds (nodes) of interest. First we
obtain the XML ﬁle we wish to parse:

> intactxml <- file.path(xmlDir, "intact_2008_test.xml")
> intactComplexxml <- file.path(xmlDir,"intact_complexSample.xml")

and then we parse the ﬁle using the parsePsimi25Interaction function:

> intactSample <- parsePsimi25Interaction(intactxml, INTACT.PSIMI25,verbose=FALSE)
> intactComplexSample <- parsePsimi25Complex(intactComplexxml, INTACT.PSIMI25,verbose=FALSE)

The two arguments taken by parsePsimi25Interaction is:

1. A character vector with the relative path to the ﬁle of interest (can also be an URL).

2. A supported data repository source ﬁle R object.

3

Because each database repository implements the PSI-MI XML2.5 standards in slightly
varing ways, it is necessary to track these diﬀerences and to tell the parsing function
which implementation to expect. Each of the database supported by RpsiXML has its
own corresponding source class object (INTACT.PSIMI25, MINT.PSIMI25, DIP.PSIMI25,
HPRD.PSIMI25, BIOGRID.PSIMI25, and MIPS.PSIMI25).

The output from the parsePsimi25Interaction is an object of type psimi25InteractionEntry

or psimi25ComplexEntry depending on the type of input XML ﬁle. Each is a class used
to carry all of the information obtained from the XML ﬁles be it interaction or complex.
From each of these classes, we can obtain various types of information:

(From the intactSample object)

> interact <- interactions(intactSample)[1:3]
> interact

[[1]]
interaction ( EBI-1580529 ):

----------------------------------------------------------------
[ source database ]: intact
[ source experiment ID ]: EBI-1580529
[ interaction type ]: spr
[ experiment ]: pubmed 18296487
[ participant ]: A4JYH2 A4JYL6
[ bait ]: 8
[ bait UniProt ]: A4JYL6
[ prey ]: 4
[ prey UniProt ]: A4JYH2
[ confidence value ]: NA

[[2]]
interaction ( EBI-1580520 ):

----------------------------------------------------------------
[ source database ]: intact
[ source experiment ID ]: EBI-1580520
[ interaction type ]: spr
[ experiment ]: pubmed 18296487
[ participant ]: Q7ZU88 A4JYH2
[ bait ]: 13
[ bait UniProt ]: Q7ZU88
[ prey ]: 4
[ prey UniProt ]: A4JYH2
[ confidence value ]: NA

4

[[3]]
interaction ( EBI-1580511 ):

----------------------------------------------------------------
[ source database ]: intact
[ source experiment ID ]: EBI-1580511
[ interaction type ]: spr
[ experiment ]: pubmed 18296487
[ participant ]: Q5J1R9 Q7SX76
[ bait ]: 25
[ bait UniProt ]: Q7SX76
[ prey ]: 21
[ prey UniProt ]: Q5J1R9
[ confidence value ]: NA

> organismName(intactSample)[1:3]

[1] "Brachydanio rerio" "Homo sapiens"

"Rattus norvegicus"

> releaseDate(intactSample)

[1] "2008-03-28"

(Looking within each interaction)

> lapply(interact, participant)[1:3]

[[1]]

A4JYH2

A4JYL6
"A4JYH2" "A4JYL6"

[[2]]

Q7ZU88

A4JYH2
"Q7ZU88" "A4JYH2"

[[3]]

Q5J1R9

Q7SX76
"Q5J1R9" "Q7SX76"

> sapply(interact, bait)[1:3]

[1] "A4JYL6" "Q7ZU88" "Q7SX76"

5

> sapply(interact, prey)[1:3]

[1] "A4JYH2" "A4JYH2" "Q5J1R9"

> sapply(interact, pubmedID)[1:3]

[1] "18296487" "18296487" "18296487"

Most of the information from the extracted data is self-explanatory; we will, however,
highlight some important pieces. The interact object is the output of the interactions
method which provides all the pertinent details for each interaction. This object is a
list of the psimi25Interaction class. Upon each individual psimi25Interaction class, there
exists methods to extract the individual pieces of information. The participant method
returns the two proteins which were involved in the interaction. If available, the bait and
prey methods returns the proteins which serve as their namesake. Each interaction is also
indexed by the pubmed ID which can also be extracted.

(From the complexSample object)

> comp <- complexes(intactComplexSample)[1:2]
> sapply(comp, complexName)

[1] "BCL-2 homodimer"

"BAD:BCL-2 heterodimer"

2.2.2 psimi25XML2Graph

While the parsing can be accomplished via the parsePsimi25Interaction function, the
output of this function is not readily accessible for computational analysis. For this case,
the function psimi25XML2Graph is a better choice. For instance we can construct the
bait-prey graph from the IntAct sample XML ﬁle:

> intactGraph <- psimi25XML2Graph(intactxml, INTACT.PSIMI25,
+

type="interaction",verbose=FALSE)

1 Entries found
Parsing entry 1

Parsing experiments: ..
Parsing interactors:

3% =>
6% ==>
10% ====>
13% =====>

6

16% ======>
19% ========>
23% =========>
26% ==========>
29% ============>
32% =============>
35% ==============>
39% ================>
42% =================>
45% ==================>
48% ===================>
52% =====================>
55% ======================>
58% =======================>
61% ========================>
65% ==========================>
68% ===========================>
71% ============================>
74% ==============================>
77% ===============================>
81% ================================>
84% ==================================>
87% ===================================>
90% ====================================>
94% ======================================>
97% =======================================>
100% ========================================>
Parsing interactions:

.............................................................................................

> nodes(intactGraph)

[1] "A0S0K7" "A2CF10" "A3KPA0" "A4JYD4" "A4JYD8" "A4JYF6" "A4JYF7" "A4JYG1"
[9] "A4JYG2" "A4JYG3" "A4JYG4" "A4JYI5" "A4JYK9" "A4JYL3" "A4JYL6" "A4JYL8"
[17] "A4JYM3" "A4JYP5" "A4JYS0" "P04218" "P09326" "Q5J1R9" "Q5W433" "Q6NW92"
[25] "Q7SX76" "Q7ZU88" "Q90413" "Q90YM1" "Q9BZW8" "A4JYH2" "A4JYF3"

> degree(intactGraph)

$inDegree
A0S0K7 A2CF10 A3KPA0 A4JYD4 A4JYD8 A4JYF6 A4JYF7 A4JYG1 A4JYG2 A4JYG3 A4JYG4
1

3

1

5

5

2

3

3

1

1

1

7

2

A4JYI5 A4JYK9 A4JYL3 A4JYL6 A4JYL8 A4JYM3 A4JYP5 A4JYS0 P04218 P09326 Q5J1R9
4

1
Q5W433 Q6NW92 Q7SX76 Q7ZU88 Q90413 Q90YM1 Q9BZW8 A4JYH2 A4JYF3
0

2

2

8

1

1

1

5

7

1

1

1

0

1

1

4

1

1

5

$outDegree
A0S0K7 A2CF10 A3KPA0 A4JYD4 A4JYD8 A4JYF6 A4JYF7 A4JYG1 A4JYG2 A4JYG3 A4JYG4
1
A4JYI5 A4JYK9 A4JYL3 A4JYL6 A4JYL8 A4JYM3 A4JYP5 A4JYS0 P04218 P09326 Q5J1R9
5

1
Q5W433 Q6NW92 Q7SX76 Q7ZU88 Q90413 Q90YM1 Q9BZW8 A4JYH2 A4JYF3
1

1

5

2

3

3

3

1

1

2

2

6

7

1

1

1

5

1

3

1

1

1

2

1

2

0

And we can also build a protein complex membership hyper-graph from the sample

complex XML ﬁle:

> intactHG <- psimi25XML2Graph(intactxml, INTACT.PSIMI25, type="complex",verbose=FALSE)

There is a caveat for the function psimi25XML2Graph; it does not decipher between
the data within the XML ﬁle insomuch that if it is all bait/prey, then it will generate one
large graph. If you are sure that you would like to take all the data and create one large
graphical structure, then a call to this function is appropriate. Otherwise, if some of the
data within the XML ﬁles should be separated, a call to this function is not recommended.

2.2.3 separateXMLDataByExpt

A diﬀerent way to transform the XML data into graphs is to call the searapteXMLDataBy-
Expt function. This function will parse bait-prey data into distinct graphs indexed by the
pubmed IDs. Note that this function cannot be called upon XML ﬁles that record manually
curated protein complexes since there is rarely an associated pubmed ID for this type of
data.

> graphs <- separateXMLDataByExpt(xmlFiles = intactxml, psimi25source=INTACT.PSIMI25,
+
+

type="indirect", directed=TRUE, abstract=TRUE,
verbose=FALSE)

1 Entries found
Parsing entry 1

Parsing experiments: ..
Parsing interactors:

3% =>

8

6% ==>
10% ====>
13% =====>
16% ======>
19% ========>
23% =========>
26% ==========>
29% ============>
32% =============>
35% ==============>
39% ================>
42% =================>
45% ==================>
48% ===================>
52% =====================>
55% ======================>
58% =======================>
61% ========================>
65% ==========================>
68% ===========================>
71% ============================>
74% ==============================>
77% ===============================>
81% ================================>
84% ==================================>
87% ===================================>
90% ====================================>
94% ======================================>
97% =======================================>
100% ========================================>
Parsing interactions:

.............................................................................................

Now we look at the input parameters:

(cid:136) xmlFiles - a character vector of the relative path to the PSI-MI XML2.5 ﬁles relative

to the R working directory.

(cid:136) psimi25source - A supported data repository source R object

(cid:136) type - character either ”direct” or ”indirect” signaling the type of interaction wanted

(cid:136) directed - a logical to determine if the graph returned is either directed or not

9

(cid:136) abstract - a logical to determine whether or not the function should also get the

abstract information for each dataset from NCBI

> graphs

‘

‘

18296487

$
A graphNEL graph with directed edges
Number of Nodes = 31
Number of Edges = 70
[1] "psimi25Graph"
attr(,"package")
[1] "RpsiXML"

> abstract(graphs$

18296487

)

‘

’

‘

’

An object of class
Title: Large-scale screening for novel low-affinity extracellular

pubMedAbst

:

protein interactions.

PMID: 18296487
Authors: KM Bushell, C S~Aullner, B Schuster-Boeckler, A Bateman, GJ

Wright

Journal: Genome Res
Date: Apr 2008

It should be noted that if you are going to parse a large number of XML ﬁles, it is not
recommended to automatically get the abstract information since NCBI has been known
to refuse and later ban IP addresses that consistenly demand a high volume of information.
For this reason, the abstract parameter has been set to FALSE as a default.

One can manually obtain the abstract information as follows:

> getAbstractByPMID(names(graphs))

‘

‘

18296487

$
An object of class
Title: Large-scale screening for novel low-affinity extracellular

pubMedAbst

:

’

’

protein interactions.

PMID: 18296487
Authors: KM Bushell, C S~Aullner, B Schuster-Boeckler, A Bateman, GJ

Wright

Journal: Genome Res
Date: Apr 2008

10

3 Converting Node IDs

The bait/prey information (when downloaded and converted into an R graph object) is
encoded by the UniProtKB identiﬁcation schema. UniProtKB appears to be the most
universal naming scheme, and so it oﬀers consistency across databases. If there is a need
to convert the names of the nodes from the UniProtKB IDs to some other naming scheme,
there is two ways of doing so:

(cid:136) use the R package biomaRt

(cid:136) use the built in method translateID

The beneﬁts of using biomaRt is that it lets you communicate with Biomart and obtain
the latest annotations and translations. The drawback is that it is a non-trivial task and
is beyond the scope of this vignette. The drawbacks of translateID is that only the
naming schemes supported (i.e. arbitrarily chosen) by each database can be supported by
RpsiXML. The beneﬁt is the ease and simplicity of use.

> graphs1 <- translateID(graphs[[1]], to="intact")
> nodes(graphs1)

[1] "EBI-1579594" "EBI-1579611" "EBI-1579361" "EBI-1579591" "EBI-1579656"
[6] "EBI-1579619" "EBI-1579578" "EBI-1579667" "EBI-1579332" "EBI-1579335"
[11] "EBI-1579266" "EBI-1579373" "EBI-1579400" "EBI-1579353" "EBI-1579616"
[16] "EBI-1579370" "EBI-1579304" "EBI-1579664" "EBI-1579603" "EBI-915817"
[21] "EBI-714770" "EBI-1579627" "EBI-1579381" "EBI-1579483" "EBI-1579511"
[26] "EBI-1579427" "EBI-1579413" "EBI-1579680" "EBI-1580565" "EBI-1579530"
[31] "EBI-1579465"

If a particular node cannot be mapped to the naming schema, it will retain the Unipro-

tKB ID.

4 Conclusion

Once the XML ﬁles have been downloaded, parsed, and converted into R grpah objects,
there are a number of applicable methods and tools available within R and Bioconductor
upon which these data graphs can be analyzed. Some (but not all) packages include:
RBGL, ppiStats, apComplex , etc.

11

