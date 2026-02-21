Creating select Interfaces for custom Anno-
tation resources

Marc Carlson and Valerie Obenchain

October 29, 2025

1

Introduction

The most common interface for retrieving data in Bioconductor is now the select
method. The interface provides a simple way of extracting data.

There are really 4 methods that work together to allow a select interface. The
1st one is columns, which tells you about what kinds of values you can retrieve as
columns in the final result.

library(RSQLite)

library(Homo.sapiens)

## Loading required package:

OrganismDbi

## Loading required package:

Seqinfo

## Loading required package:

GenomicFeatures

## Loading required package:

GenomicRanges

## Loading required package:

GO.db

##

## Loading required package:

org.Hs.eg.db

##

## Loading required package:

TxDb.Hsapiens.UCSC.hg19.knownGene

columns(Homo.sapiens)

## [1] "ACCNUM"

"ALIAS"

"CDSCHROM"

"CDSEND"

## [5] "CDSID"

"CDSNAME"

"CDSPHASE"

"CDSSTART"

## [9] "CDSSTRAND"

"DEFINITION"

"ENSEMBL"

"ENSEMBLPROT"

## [13] "ENSEMBLTRANS" "ENTREZID"

"ENZYME"

"EVIDENCE"

## [17] "EVIDENCEALL"

"EXONCHROM"

"EXONEND"

"EXONID"

## [21] "EXONNAME"

"EXONRANK"

"EXONSTART"

"EXONSTRAND"

## [25] "GENEID"

"GENENAME"

"GENETYPE"

## [29] "GOALL"

"GOID"

"IPI"

"GO"

"MAP"

## [33] "OMIM"

"ONTOLOGY"

"ONTOLOGYALL"

"PATH"

Creating select Interfaces for custom Annotation resources

## [37] "PFAM"

## [41] "SYMBOL"

## [45] "TXID"

## [49] "TXTYPE"

"PMID"

"TERM"

"TXNAME"

"UCSCKG"

"PROSITE"

"TXCHROM"

"TXSTART"

"UNIPROT"

"REFSEQ"

"TXEND"

"TXSTRAND"

The next method is keytypes which tells you the kinds of things that can be used as
keys.

keytypes(Homo.sapiens)

## [1] "ACCNUM"

"ALIAS"

"CDSID"

"CDSNAME"

## [5] "DEFINITION"

"ENSEMBL"

"ENSEMBLPROT"

"ENSEMBLTRANS"

## [9] "ENTREZID"

"ENZYME"

"EVIDENCE"

"EVIDENCEALL"

## [13] "EXONID"

"EXONNAME"

"GENEID"

"GENENAME"

## [17] "GENETYPE"

## [21] "IPI"

"GO"

"MAP"

## [25] "ONTOLOGYALL"

"PATH"

## [29] "PROSITE"

## [33] "TXID"

"REFSEQ"

"TXNAME"

"GOALL"

"OMIM"

"PFAM"

"SYMBOL"

"UCSCKG"

"GOID"

"ONTOLOGY"

"PMID"

"TERM"

"UNIPROT"

The third method is keys which is used to retrieve all the viable keys of a particular
type.

k <- head(keys(Homo.sapiens,keytype="ENTREZID"))

k

## [1] "1" "2"

"9" "10" "11" "12"

And finally there is select, which extracts data by using values supplied by the other
method.

result <- select(Homo.sapiens, keys=k,

columns=c("TXNAME","TXSTART","TXSTRAND"),

keytype="ENTREZID")

## ’select()’ returned 1:many mapping between keys and columns

head(result)

##

ENTREZID

TXNAME TXSTRAND

TXSTART

## 1

## 2

## 3

## 4

## 5

## 6

1 ENST00000596924.1_3
1 ENST00000263100.8_8
1 ENST00000850949.1_1
1 ENST00000850950.1_1
1 ENST00000600123.5_4
1 ENST00000595014.1_3

- 58856544

- 58856549

- 58856549

- 58856549

- 58858220

- 58858224

2

Creating select Interfaces for custom Annotation resources

But why would we want to implement these specific methods? It’s a fair question.
Why would we want to write a select interface for our annotation data? Why not
just save a .rda file to the data directory and be done with it? There are basically two
reasons for this. The 1st reason is convenience for end users. When your end users
can access your data using the same four methods that they use everywhere else,
they will have a more effortless time retrieving their data. And things that benefit
your users benefit you.

The second reason is that by enabling a consistent interface across all annotation
resources, we allow for things to be used in a programmatic manner. By implementing
a select interface, we are creating a universal API for the whole project.

Lets look again at the example I described above and think about what is happening.
The Homo.sapiens package is able to integrate data from many different resources
largely because the separate resources all implemented a select method. This allows
the OrganismDbi package to pull together resources from org.Hs.eg.db, GO.db and
TxDb.Hsapiens.UCSC.hg19.knownGene.

Figure 1: Packages and relationships represented by the Homo.sapiens package

If these packages all exposed different interfaces for retrieving the data, then it would
be a lot more challenging to retrieve it, and writing general code that retrieved the
appropriate data would be a lost cause. So implementing a set of select methods is
a way to convert your package from a data file into an actual resource.

3

Creating select Interfaces for custom Annotation resources

2

Creating other kinds of Annotation packages

A few more automated options already exist for generating specific kinds of annotation
packages. For users who seek to make custom chip packages, users should see the
SQLForge: An easy way to create a new annotation package with a standard database
schema. in the AnnotationForge package. And, for users who seek to make a probe
package, there is another vignette called Creating probe packages that is also in the
AnnotationForge package. And finally, for custom organism packages users should
look at the manual page for makeOrgPackageFromNCBI. This function will attempt
to make you an simplified organism package from NCBI resources. However, this
function is not meant as a way to refresh annotation packages between releases. It
is only meant for people who are working on less popular model organisms (so that
annotations can be made available in this format).

But what if you had another kind of web resource or database and you wanted to
expose it to the world using something like this new select method interface? How
could you go about this?

3

Retrieving data from a web resource

If you choose to expose a web resource, then you will need to learn some skills for
retrieving that data from the web. The R programming language has tools that can
help you interact with web resources, pulling down files that are tab delimited or
formatted as XML etc. There are also packages that can help you parse what you
retrieve. In this section we will describe some of these resources in the context of the
uniprot web service, and give examples to demonstrate how you can expose resources
like this for your own purposes.

These days many web services are exposed using a representational state transfer or
RESTful interface. An example of this are the services offered at Uniprot. Starting
with the uniprot base URI you can add details to simply indicate what it is that you
wish to retrieve.

So in the case of Uniprot the base URI for the service we want today is this:

http://www.uniprot.org/uniprot/

This URI can be extended to retrieve individual uniprot records by specifying a query
argument like this:

http://www.uniprot.org/uniprot/?query=P13368

We can then request multiple records like this:

http://www.uniprot.org/uniprot/?query=P13368+or+Q6GZX4

And we can ask that the records be returned to us in tabular form by adding another
argument like this.

http://www.uniprot.org/uniprot/?query=P13368+or+Q6GZX4&format=tab

4

Creating select Interfaces for custom Annotation resources

As you might guess, each RESTful interface is a little different, but you can easily
see how once you read the documentation for a given RESTful interface, you can
start to retrieve the data in R. Here is an example.

uri <- 'http://rest.uniprot.org/uniprotkb/search?query='

ids <- c('P13368', 'Q6GZX4')

idStr <- paste(ids, collapse=utils::URLencode(" OR "))

format <- '&format=tsv'

fullUri <- paste0(uri,idStr,format)
uquery <- .get_file(fullUri)
read.delim(uquery)

Entry

##
Entry.Name Reviewed
## 1 P13368 7LESS_DROME reviewed
## 2 Q6GZX4

Protein sevenless (EC 2.7.10.1)
001R_FRG3G reviewed Putative transcription factor 001R
Organism Length
Gene.Names

Protein.names

##

## 1 sev HD-265 CG18085 Drosophila melanogaster (Fruit fly)

2554

## 2

FV3-001R Frog virus 3 (isolate Goorha) (FV-3)

256

Exercise 1
If you use the columns argument you can also specify which columns you want
returned. So for example, you can choose to only have the sequence and id columns
returned like this:

http://www.uniprot.org/uniprot/?query=P13368+or+Q6GZX4&format=tab&columns=id,sequence

Use this detail about the uniprot web service along with what was learned above to
write a function that takes a character vector of uniprot IDs and another character
vector of columns arguments and then returns the appropriate values. Be careful to
filter out any extra records that the service returns.

Solution:

getUniprotGoodies <- function(query, columns)

{

## query and columns start as a character vectors

qstring <- paste(query, collapse="+or+")

cstring <- paste(columns, collapse=",")

uri <- 'http://www.uniprot.org/uniprot/?query='

fullUri <- paste0(uri,qstring,'&format=tab&columns=',cstring)

dat <- read.delim(fullUri)

## now remove things that were not in the specific original query...

dat <- dat[dat[,1] %in% query,]

dat

}

5

Creating select Interfaces for custom Annotation resources

3.1

Parsing XML

Data for the previous example were downloaded from Uniprot in tab-delimited format.
This is a convenient output to work with but unfortunately not always available. XML
is still very common and it is useful to have some familiarity with parsing it. In this
section we give a brief overview to using the XML package for navigating XML data.

The XML package provides functions to parse XML in both the tree-based DOM
(document object model) or the event-driven SAX (Simple API for XML). We will use
the DOM approach. The XML is first parsed into a tree-structure where the different
elements of the data are nodes. The elements are processed by traversing the tree and
generating a user-level representation of the nodes. XPath syntax is used to traverse
the nodes. A detailed description of XPath can be found at http://www.w3.org/xml.

Retrieve the data: Data will be retrieved for the same id’s as in the previous
example. Unlike tab-delimited, the XML queries cannot be subset by column so the
full record will be returned for each id. Details for what is possible with each type of
data retrieval are found at http://www.uniprot.org/faq/28.

Parse the XML into a tree structure with xmlTreeParse. When useInternalNodes=TRUE
and no handlers are specified the return value is a reference to C-level nodes. This
storage mode allows us to traverse the tree of data in C instead of R objects.

library(XML)

uri <- "http://rest.uniprot.org/uniprotkb/search?query=P13368%20OR%20Q6GZX4&format=xml"

fl <- tempfile()

download.file(uri, fl)

xml <- xmlTreeParse(fl, useInternalNodes=TRUE)

XML namespace: XML pages can have namespaces which facilitate the use of dif-
ferent XML vocabularies by resolving conflicts arising from identical tags. Namepaces
are represented by a uri pointing to an XML schema page. When a namespace is
defined on a node in an XML document it must be included in the XPath expression.

Use the xmlNamespaceDefinitions function to check if the XML has a namespace.

defs <- xmlNamespaceDefinitions(xml, recurisve=TRUE)

defs

## [[1]]

## $id

## [1] ""

##

## $uri

## [1] "http://uniprot.org/uniprot"

##

## $local

## [1] TRUE

6

Creating select Interfaces for custom Annotation resources

##

## attr(,"class")

## [1] "XMLNamespaceDefinition"

##

## $xsi

## $id

## [1] "xsi"

##

## $uri

## [1] "http://www.w3.org/2001/XMLSchema-instance"

##

## $local

## [1] TRUE

##

## attr(,"class")

## [1] "XMLNamespaceDefinition"

##

## attr(,"class")

## [1] "XMLNamespaceDefinitions"

The presence of uri’s confirm there is a namespace. Alternatively we could have
looked at the XML nodes for declarstions of the form xmlns:myNamespace="http://www.namspace.org".
We organize the namespaces and will use them directly in parsing.

ns <- structure(sapply(defs, function(x) x$uri), names=names(defs))

Parsing with XPath: There are two high level ’entry’ nodes which represent the
two id’s requested in the original query.

entry <- getNodeSet(xml, "//ns:entry", "ns")

xmlSize(entry)

## [1] 3

To get an idea of the data structure we first list the attributes of the top nodes and
extract the names.

nms <- xpathSApply(xml, "//ns:entry/ns:name", xmlValue, namespaces="ns")

attrs <- xpathApply(xml, "//ns:entry", xmlAttrs, namespaces="ns")

names(attrs) <- nms

attrs

## $`7LESS_DROME`
##

dataset

created

modified

## "Swiss-Prot" "1990-01-01" "2025-06-18"

##

version

"209"

7

Creating select Interfaces for custom Annotation resources

## $`001R_FRG3G`
dataset
##

created

modified

version

## "Swiss-Prot" "2011-06-28" "2025-04-09"

"45"

##
## $A0ABM1YJC1_AEDAL
##

dataset

created

modified

version

##

"TrEMBL" "2025-10-08" "2025-10-08"

"1"

Next, inspect the direct children of each node.

fun1 <- function(elt) unique(names(xmlChildren(elt)))

xpathApply(xml, "//ns:entry", fun1, namespaces="ns")

## [[1]]

## [1] "accession"

"name"

## [4] "gene"

## [7] "comment"

## [10] "keyword"

## [13] "sequence"

##

## [[2]]

"organism"

"protein"

"reference"

"dbReference"

"proteinExistence"

"feature"

"evidence"

## [1] "accession"

"name"

## [4] "gene"

## [7] "reference"

"organism"

"comment"

"protein"

"organismHost"

"dbReference"

## [10] "proteinExistence" "keyword"

"feature"

## [13] "evidence"

"sequence"

##

## [[3]]

## [1] "accession"

"name"

"protein"

## [4] "organism"

"reference"

"dbReference"

## [7] "proteinExistence" "keyword"

"evidence"

## [10] "sequence"

Query Q6GZX4 has 2 ’feature’ nodes and query P13368 has 48.

Q6GZX4 <- "//ns:entry[ns:accession='Q6GZX4']/ns:feature"

xmlSize(getNodeSet(xml, Q6GZX4, namespaces="ns"))

## [1] 1

P13368 <- "//ns:entry[ns:accession='P13368']/ns:feature"

xmlSize(getNodeSet(xml, P13368, namespaces="ns"))

## [1] 53

List all possible values for the ’type’ attribute of the ’feature’ nodes.

8

Creating select Interfaces for custom Annotation resources

path <- "//ns:feature"

unique(xpathSApply(xml, path, xmlGetAttr, "type", namespaces="ns"))

## [1] "chain"

"topological domain"

## [3] "transmembrane region"

"domain"

## [5] "repeat"

"region of interest"

## [7] "compositionally biased region" "active site"

## [9] "binding site"

## [11] "glycosylation site"

## [13] "sequence conflict"

"modified residue"

"mutagenesis site"

XPath allows the construction of complex queries to pull out specific subsets of data.
Here we extract the features with ‘type=sequence conflict’ for query P13368.

path <- "//ns:entry[ns:accession='P13368']/ns:feature[@type='sequence conflict']"

data.frame(t(xpathSApply(xml, path, xmlAttrs, namespaces="ns")))

##

type

description evidence ref

## 1 sequence conflict

In Ref. 1; AAA28882.

## 2 sequence conflict

In Ref. 3; AAF47992.

## 3 sequence conflict

In Ref. 3; AAF47992.

## 4 sequence conflict

In Ref. 3; AAF47992.

## 5 sequence conflict

In Ref. 3; AAF47992.

## 6 sequence conflict In Ref. 2; CAA31960/CAB55310.

## 7 sequence conflict

In Ref. 1; AAA28882.

9

9

9

9

9

9

9

1

3

3

3

3

2

1

Put the sequences in an AAStringSet and add the names.

library(Biostrings)

## Loading required package:

XVector

##

## Attaching package: ’Biostrings’

## The following object is masked from ’package:base’:

##

##

strsplit

path <- "//ns:entry/ns:sequence"

seqs <- xpathSApply(xml, path, xmlValue, namespaces="ns")

aa <- AAStringSet(unlist(lapply(seqs, function(elt) gsub("\n", "", elt)),

use.names=FALSE))

names(aa) <- nms

aa

## AAStringSet object of length 3:

##

## [1]

width seq
2554 MTMFWQQNVDHQSDEQDKQAKG...TLREVPLKDKQLYANEGVSRL 7LESS_DROME

names

9

Creating select Interfaces for custom Annotation resources

## [2]

## [3]

256 MAFSAEDVLKEYDRRRRMEALL...VLYDDSFRKIYTDLGWKFTPL 001R_FRG3G
407 MADTYDEYEETHTVTRKSVTTF...SQRLQFRFFQNIHRKQATMIQ A0ABM1YJC1_AEDAL

4

Setting up a package to expose a web service

In order to expose a web service using select, you will need to create an object that
will be loaded at the time when the package is loaded. Unlike with a database, the
purpose of this object is pretty much purely for dispatch. We just need select and
it’s friends to know which select method to call

The first step is to create an object. Creating an object is simple enough:

setClass("uniprot", representation(name="character"),

prototype(name="uniprot"))

Once you have a class defined, all you need is to make an instance of this class.
Making an instance is easy enough:

uniprot <- new("uniprot")

But of course it’s a little more complicated because one of these objects will need
to be spawned up whenever our package loads. This is acclomplished by calling the
.onLoad function in the zzz.R file. The following code will create an object, and then
assign it to the package namespace as the package loads.

.onLoad <- function(libname, pkgname)

{

}

ns <- asNamespace(pkgname)

uniprot <- new("uniprot")

assign("uniprot", uniprot, envir=ns)

namespaceExport(ns, "uniprot")

5

Creating package accessors for a web service

At this point you have all that you need to know in order to implement keytype,columns,keys
and select for your package. In this section we will explore how you could implement
some of these if you were making a package that exposed uniprot.

10

Creating select Interfaces for custom Annotation resources

5.1

Example: creating keytypes and columns methods

The keytype and columns methods are always the 1st ones you should implement.
They are the easiest, and their existence is required to be able to use keys or select.
In this simple case we only have one value that can be used as a keytype, and that
is a UNIPROT ID.

setMethod("keytypes", "uniprot",function(x){return("UNIPROT")})

uniprot <- new("uniprot")

keytypes(uniprot)

## [1] "UNIPROT"

So what about columns? Well it’s not a whole lot more complicated in this case since
we are limited to things that we can return from the web service. Since this is just
an example, lets limit it to the following fields: "ID", "SEQUENCE", "ORGANISM".

setMethod("columns", "uniprot",

function(x){return(c("ID", "SEQUENCE", "ORGANISM"))})

columns(uniprot)

## [1] "ID"

"ORGANISM" "SEQUENCE"

Also, notice how for both keytypes and columns I am using all capital letters. This
is a style adopted throughout the project.

5.2

Example 2: creating a select method

At this point we have enough to be able to make a select method.

Exercise 2
Using what you have learned above, and the helper function from earlier, define a
select method. This select method will have a default keytype of "UNIPROT".

Solution:

.select <- function(x, keys, columns){

colsTranslate <- c(id='ID', sequence='SEQUENCE', organism='ORGANISM')

columns <- names(colsTranslate)[colsTranslate %in% columns]

getUniprotGoodies(query=keys, columns=columns)

}

setMethod("select", "uniprot",

function(x, keys, columns, keytype)

{

})

.select(keys=keys, columns=columns)

11

Creating select Interfaces for custom Annotation resources

select(uniprot, keys=c("P13368","P20806"), columns=c("ID","ORGANISM"))

6

Retrieving data from a database resource

If your package is retrieving data from a database, then there are some additional
skills you will need to be able to interface with this database from R. This section
will introduce you to those skills.

6.1

Getting a connection

If all you know is the name of the SQLite database, then to get a DB connection you
need to do something like this:

drv <- SQLite()

library("org.Hs.eg.db")
con_hs <- dbConnect(drv, dbname=org.Hs.eg_dbfile())
con_hs

In cases where the connection is created on package load, we can do something like
below:

org.Hs.eg.db$conn

## or better we can use a helper function to wrap this:

AnnotationDbi::dbconn(org.Hs.eg.db)

## or we can just call the provided convenience function

## from when this package loads:
org.Hs.eg_dbconn()

6.2

Getting data out

Now we just need to get our data out of the DB. There are several useful functions
for doing this. Most of these come from the RSQLite or DBI packages. For the
sake of simplicity, I will only discuss those that are immediately useful for exploring
and extracting data from a database in this vignette. One pair of useful methods are
the dbListTables and dbListFields which are useful for exploring the schema of a
database.

head(dbListTables(con_hs))

## [1] "accessions"
## [4] "chromosome_locations" "chromosomes"

"alias"

"chrlengths"
"cytogenetic_locations"

dbListFields(con_hs, "alias")

## [1] "_id"

"alias_symbol"

12

Creating select Interfaces for custom Annotation resources

For actually executing SQL to retrieve data, you probably want to use something like
dbGetQuery. The only caveat is that this will actually require you to know a little
SQL.

dbGetQuery(con_hs, "SELECT * FROM metadata")

##

## 1

## 2

name

DBSCHEMAVERSION

Db type

## 3 Supporting package

DBSCHEMA

ORGANISM

SPECIES

EGSOURCEDATE

EGSOURCENAME

EGSOURCEURL

CENTRALID

TAXID

GOSOURCENAME

value

2.1

OrgDb

AnnotationDbi
HUMAN_DB
Homo sapiens

Human

2025-Sep24

Entrez Gene

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

EG

9606

Gene Ontology

GOSOURCEURL

http://current.geneontology.org/ontology/go-basic.obo

GOSOURCEDATE

GOEGSOURCEDATE

GOEGSOURCENAME

GOEGSOURCEURL

KEGGSOURCENAME

KEGGSOURCEURL

KEGGSOURCEDATE

GPSOURCENAME

2025-07-22

2025-Sep24

Entrez Gene

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

ftp://ftp.genome.jp/pub/kegg/genomes

KEGG GENOME

2011-Mar15

UCSC Genome Bioinformatics (Homo sapiens)

GPSOURCEURL ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/database

GPSOURCEDATE

ENSOURCEDATE

ENSOURCENAME

ENSOURCEURL

UPSOURCENAME

UPSOURCEURL

UPSOURCEDATE

UTC-Sep26

2025-Sep03

Ensembl
ftp://ftp.ensembl.org/pub/current_fasta
Uniprot

http://www.UniProt.org/

Sat Oct

4 09:48:11 2025

## 4

## 5

## 6

## 7

## 8

## 9

## 10

## 11

## 12

## 13

## 14

## 15

## 16

## 17

## 18

## 19

## 20

## 21

## 22

## 23

## 24

## 25

## 26

## 27

## 28

## 29

6.3

Some basic SQL

The good news is that SQL is pretty easy to learn. Especially if you are primarily
interested in just retrieving data from an existing database. Here is a quick run-down
to get you started on writing simple SELECT statements. Consider a table that looks
like this:

This statement:

SELECT bar FROM sna;

13

Creating select Interfaces for custom Annotation resources

Table sna
bar
foo
baz
1
boo
2

Tells SQL to get the "bar" field from the "foo" table.
called "sna" in addition to "bar", we could have written it like this:

If we wanted the other field

SELECT foo, bar FROM sna;

Or even this (* is a wildcard character here)

SELECT * FROM sna;

Now lets suppose that we wanted to filter the results. We could also have said
something like this:

SELECT * FROM sna WHERE bar='boo';

That query will only retrieve records from foo that match the criteria for bar. But
there are two other things to notice. First notice that a single = was used for testing
equality. Second notice that I used single quotes to demarcate the string. I could have
also used double quotes, but when working in R this will prove to be less convenient
as the whole SQL statement itself will frequently have to be wrapped as a string.

What if we wanted to be more general? Then you can use LIKE. Like this:

SELECT * FROM sna WHERE bar LIKE 'boo\%';

That query will only return records where bar starts with "boo", (the % character is
acting as another kind of wildcard in this context).

You will often find that you need to get things from two or more different tables at
once. Or, you may even find that you need to combine the results from two different
queries. Sometimes these two queries may even come from the same table. In any
of these cases, you want to do a join. The simplest and most common kind of join
is an inner join. Lets suppose that we have two tables:

Table sna
bar
foo
baz
1
boo
2

Table fu
bo
foo
hi
1
ca
2

And we want to join them where the records match in their corresponding "foo"
columns. We can do this query to join them:

SELECT * FROM sna,fu WHERE sna.foo=fu.foo;

Something else we can do is tidy this up by using aliases like so:

SELECT * FROM sna AS s,fu AS f WHERE s.foo=f.foo;

14

Creating select Interfaces for custom Annotation resources

This last trick is not very useful in this particular example since the query ended up
being longer than we started with, but is still great for other cases where queries can
become really long.

6.4

Exploring the SQLite database from R

Now that we know both some SQL and also about some of the methods in DBI and
RSQLite we can begin to explore the underlying database from R. How should we go
about this? Well the 1st thing we always want to know are what tables are present.
We already know how to learn this:

head(dbListTables(con_hs))

## [1] "accessions"
## [4] "chromosome_locations" "chromosomes"

"alias"

"chrlengths"
"cytogenetic_locations"

And we also know that once we have a table we are curious about, we can then look
up it’s fields using dbListFields

dbListFields(con_hs, "chromosomes")

## [1] "_id"

"chromosome"

And once we know something about which fields are present in a table, we can
compose a SQL query. perhaps the most straightforward query is just to get all the
results from a given table. We know that the SQL for that should look like:

SELECT * FROM chromosomes;

So we can now call a query like that from R by using dbGetQuery:

head(dbGetQuery(con_hs, "SELECT * FROM chromosomes"))

##

## 1

## 2

## 3

## 4

## 5

## 6

_id chromosome
19

1

2

3

4

5

6

12

8

8

8

14

Exercise 3
Now use what you have learned to explore the org.Hs.eg.db database. Now find
the table for chromosome locations in the org.Hs.eg.db database and extract it into
R. How many chromosomes are present in this table? Write a SQL query that will
retrieve chromosome locations from this table that are in chromosome 1.

Solution:

15

Creating select Interfaces for custom Annotation resources

head(dbGetQuery(con_hs, "SELECT * FROM chromosome_locations"))
## Then only retrieve human records
## Query: SELECT * FROM Anopheles_gambiae WHERE species='HOMSA'
head(dbGetQuery(con_hs, "SELECT * FROM chromosome_locations WHERE seqname='1'"))
dbDisconnect(con_hs)

7

Setting up a package to expose a SQLite database
object

For the sake of simplicity, lets look at an existing example of this in the org.Hs.eg.db
package. This package contains a .sqlite database inside of the extdata directory.
There are a couple of important details though about databases like these. The 1st
is that we recommend that the database have the same name as the package, but
end with the extension .sqlite. The second detail is that we recommend that the
metadata table contain some important fields. This is the metadata from the current
org.Hs.eg.db package.

##

## 1

## 2

name

DBSCHEMAVERSION

Db type

## 3 Supporting package

DBSCHEMA

ORGANISM

SPECIES

EGSOURCEDATE

EGSOURCENAME

EGSOURCEURL

CENTRALID

TAXID

GOSOURCENAME

## 4

## 5

## 6

## 7

## 8

## 9

## 10

## 11

## 12

## 13

## 14

## 15

## 16

## 17

## 18

## 19

## 20

## 21

## 22

## 23

## 24

## 25

value

2.1

OrgDb

AnnotationDbi
HUMAN_DB
Homo sapiens

Human

2025-Sep24

Entrez Gene

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

EG

9606

Gene Ontology

GOSOURCEURL

http://current.geneontology.org/ontology/go-basic.obo

GOSOURCEDATE

GOEGSOURCEDATE

GOEGSOURCENAME

GOEGSOURCEURL

KEGGSOURCENAME

KEGGSOURCEURL

KEGGSOURCEDATE

GPSOURCENAME

2025-07-22

2025-Sep24

Entrez Gene

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

KEGG GENOME

ftp://ftp.genome.jp/pub/kegg/genomes

2011-Mar15

UCSC Genome Bioinformatics (Homo sapiens)

GPSOURCEURL ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/database

GPSOURCEDATE

ENSOURCEDATE

ENSOURCENAME

UTC-Sep26

2025-Sep03

Ensembl

16

Creating select Interfaces for custom Annotation resources

## 26

## 27

## 28

## 29

ENSOURCEURL

UPSOURCENAME

UPSOURCEURL

UPSOURCEDATE

ftp://ftp.ensembl.org/pub/current_fasta
Uniprot

http://www.UniProt.org/

Sat Oct

4 09:48:11 2025

As you can see there are a number of very useful fields stored in the metadata table
and if you list the equivalent table for other packages you will find even more useful
information than you find here. But the most important fields here are actually the
ones called "package" and "Db type". Those fields specify both the name of the
package with the expected class definition, and also the name of the object that this
database is expected to be represented by in the R session respectively.
If you fail
to include this information in your metadata table, then loadDb will not know what
to do with the database when it is called. In this case, the class definition has been
stored in the AnnotationDbi package, but it could live anywhere you need it too. By
specifying the metadata field, you enable loadDb to find it.

Once you have set up the metadata you will need to create a class for your package
that extends the AnnotationDb class. In the case of the org.Hs.eg.db package, the
class is defined to be a OrgDb class.

showClass("OrgDb")

Finally the .onLoad call for your package will have to contain code that will call the
loadDb method. This is what it currently looks like in the org.Hs.eg.db package.

sPkgname <- sub(".db$","",pkgname)

db <- loadDb(system.file("extdata", paste(sPkgname,

".sqlite",sep=""), package=pkgname, lib.loc=libname),

packageName=pkgname)

dbNewname <- AnnotationDbi:::dbObjectName(pkgname,"OrgDb")

ns <- asNamespace(pkgname)

assign(dbNewname, db, envir=ns)

namespaceExport(ns, dbNewname)

When the code above is run (at load time) the name of the package (AKA "pkgname",
which is a parameter that will be passed into .onLoad) is then used to derive the
name for the object. Then that name, is used by onload to create an InparanoidDb
object. This object is then assigned to the namespace for this package so that it will
be loaded for the user.

8

Creating package accessors for databases

At this point, all that remains is to create the means for accessing the data in the
database. This should prove a lot less difficult than it may initially sound. For the
new interface, only the four methods that were described earlier are really required:
columns,keytypes,keys and select.

17

Creating select Interfaces for custom Annotation resources

In order to do this you need to know a small amount of SQL and a few tricks for
accessing the database from R. The point of providing these 4 accessors is to give
users of these packages a more unified experience when retrieving data from the
database. But other kinds of accessors (such as those provided for the TxDb objects)
may also be warranted.

8.1

Examples: creating a columns and keytypes method

Now lets suppose that we want to define a columns method for our org.Hs.eg.db
object. And lets also suppose that we want is for it to tell us about the actual
organisms for which we can extract identifiers. How could we do that?

.cols <- function(x)

{

}

con <- AnnotationDbi::dbconn(x)

list <- dbListTables(con)

## drop unwanted tables
unwanted <- c("map_counts","map_metadata","metadata")
list <- list[!list %in% unwanted]

# use on.exit to disconnect

# on.exit(dbDisconnect(con))

## Then just to format things in the usual way

toupper(list)

## Then make this into a method

setMethod("columns", "OrgDb", .cols(x))

## Then we can call it

columns(org.Hs.eg.db)

Notice again how I formatted the output to all uppercase characters? This is just
done to make the interface look consistent with what has been done before for the
other select interfaces. But doing this means that we will have to do a tiny bit of
extra work when we implement out other methods.

Exercise 4
Now use what you have learned to define a method for keytypes on org.Hs.eg.db.
The keytypes method should return the same results as columns (in this case). What
if you needed to translate back to the lowercase table names? Also write an quick
helper function to do that.

Solution:

setMethod("keytypes", "OrgDb", function(x) .cols(x))

## Then we can call it

keytypes(org.Hs.eg.db)

18

Creating select Interfaces for custom Annotation resources

## refactor of .cols

.getLCcolnames <- function(x)

{

}

con <- AnnotationDbi::dbconn(x)

list <- dbListTables(con)

## drop unwanted tables
unwanted <- c("map_counts","map_metadata","metadata")
# use on.exit to disconnect

# on.exit(dbDisconnect(con))

list[!list %in% unwanted]

.cols <- function(x)

{

}

list <- .getLCcolnames(x)

## Then just to format things in the usual way

toupper(list)

## Test:

columns(org.Hs.eg.db)

## new helper function:

.getTableNames <- function(x)

{

}

LC <- .getLCcolnames(x)

UC <- .cols(x)

names(UC) <- LC

UC

.getTableNames(org.Hs.eg.db)

8.2

Example: creating a keys method

Exercise 5
Now define a method for keys on the example org.Hs.eg.db. This function can be a
helper function to make it easy to extract column values after filtering the rows. The
keys method should return the keys from a given organism based on the appropriate
keytype. For example, if a table has rows that correspond to both human and non-
human IDs, it will be necessary to filter out the human rows from the result.

Solution:

.keys <- function(x, keytype)

{

19

Creating select Interfaces for custom Annotation resources

## translate keytype back to table name

tabNames <- .getTableNames(x)

lckeytype <- names(tabNames[tabNames %in% keytype])

## get a connection

con <- AnnotationDbi::dbconn(x)
sql <- paste("SELECT _id FROM", lckeytype, "WHERE species != 'HOMSA'")
res <- dbGetQuery(con, sql)

res <- as.vector(t(res))

dbDisconnect(con)

res

}

setMethod("keys", "ExampleDbClass", .keys)

## Then we would call it
keys(example.db, "TRICHOPLAX_ADHAERENS")

9

Creating a database resource from available data

Sometimes you may have a lot of data that you want to organize into a database.
Or you may have another existing database that you wish to convert into a SQLite
database. This section will deal with some simple things you can do to create and
import a SQLite database of your own.

9.1 Making a new connection

Then lets make a new database. Notice that we specify the database name with
"dbname" This allows it to be written to disc instead of just memory.

drv <- dbDriver("SQLite")

dbname <- file.path(tempdir(), "myNewDb.sqlite")

con <- dbConnect(drv, dbname=dbname)

9.2

Importing data

Imagine that we want to reate a database and then put a table in it called genePheno
to store the genes mutated and a phenotypes associated with each. Plan for genePheno
to hold the following gene IDs and phenotypes (as a toy example):

data <- data.frame(id=c(22,7,15), string=c("Blue", "Red", "Green"))

Making the table is very simple, and just involves a create table statement.

CREATE Table genePheno (id INTEGER, string TEXT);

20

Creating select Interfaces for custom Annotation resources

The SQL create table statement just indicates what the table is to be called, as well
as the different fields that will be present and the type of data each field is expected
to contain.

dbExecute(con, "CREATE Table genePheno (id INTEGER, string TEXT)")

## [1] 0

Then we can populate the SQL table:

sql <- "INSERT INTO genePheno VALUES ($id, $string)"

dbExecute(con, sql, params=data)

## [1] 3

We can check the content of the table with:

dbReadTable(con, "genePheno")

##

id string

## 1 22

Blue

## 2 7

Red

## 3 15

Green

9.3

Attaching other database resources

In SQLite it is possible to attach another database to your session and then query
across both resources as if they were the same DB.

The SQL what we want looks quite simple:

ATTACH "TxDb.Hsapiens.UCSC.hg19.knownGene.sqlite" AS db;

So in R we need to do something similar to this:

db <- system.file("extdata", "TxDb.Hsapiens.UCSC.hg19.knownGene.sqlite",

dbExecute(con, sprintf("ATTACH '%s' AS db",db))

package="TxDb.Hsapiens.UCSC.hg19.knownGene")

## [1] 0

Here we have attached a DB from one of the packages that this vignette required you
to have installed, but we could have attached any SQLite database that we provided
a path to.

Once we have attached the database, we can join to it’s tables as if they were in our
own database. All that is required is a prefix, and some knowledge about how to do
joins in SQL. In the end the SQL to take advantage of the attached database looks
like this:

SELECT * FROM db.gene AS dbg, genePheno AS gp

21

Creating select Interfaces for custom Annotation resources

WHERE dbg.gene_id=gp.id;

Then in R:

sql <- "SELECT * FROM db.gene AS dbg,

genePheno AS gp WHERE dbg.gene_id=gp.id"

res <- dbGetQuery(con, sql)

res

##

## 1

## 2

## 3

## 4

## 5

## 6

## 7

## 8

## 9

## 10

## 11

## 12

## 13

## 14

## 15

## 16

## 17

## 18

## 19

## 20

## 21

gene_id _tx_id id string
Green
15 309633 15

15 309632 15

Green

15 309630 15

Green

15 309631 15

Green

22 377545 22

22 377546 22

22 377547 22

22 377548 22

22 377549 22

22 377550 22

22 377551 22

22 377552 22

22 377553 22

22 377554 22

22 377555 22

22 377556 22

22 377557 22

22 377558 22

22 377559 22

22 377560 22

22 377561 22

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

Blue

9.4

Closing the DB connection

dbDisconnect(con)

10

Session information

The version number of R and packages loaded for generating this vignette were:

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

22

Creating select Interfaces for custom Annotation resources

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

## other attached packages:
## [1] Biostrings_2.78.0
## [2] XVector_0.50.0
## [3] XML_3.99-0.19
## [4] Homo.sapiens_1.3.1
## [5] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [6] org.Hs.eg.db_3.22.0
## [7] GO.db_3.22.0
## [8] OrganismDbi_1.52.0
## [9] GenomicFeatures_1.62.0
## [10] GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0
## [12] RSQLite_2.4.3
## [13] knitr_1.50
## [14] AnnotationForge_1.52.0
## [15] AnnotationDbi_1.72.0
## [16] IRanges_2.44.0
## [17] S4Vectors_0.48.0
## [18] Biobase_2.70.0
## [19] BiocGenerics_0.56.0
## [20] generics_0.1.4
## [21] BiocStyle_2.38.0
##

## loaded via a namespace (and not attached):
## [1] tidyselect_1.2.1
## [3] blob_1.2.4

dplyr_1.1.4
filelock_1.0.3

23

Creating select Interfaces for custom Annotation resources

## [5] bitops_1.0-9
## [7] RCurl_1.98-1.17
## [9] GenomicAlignments_1.46.0
## [11] lifecycle_1.0.4
## [13] magrittr_2.0.4
## [15] rlang_1.1.6
## [17] tools_4.5.1
## [19] rtracklayer_1.70.0
## [21] bit_4.6.0
## [23] DelayedArray_0.36.0
## [25] BiocParallel_1.44.0
## [27] purrr_1.1.0
## [29] preprocessCore_1.72.0
## [31] cli_3.6.5
## [33] crayon_1.5.3
## [35] rjson_0.2.23
## [37] cachem_1.1.0
## [39] parallel_4.5.1
## [41] restfulr_0.0.16
## [43] vctrs_0.6.5
## [45] jsonlite_2.0.0
## [47] bit64_4.6.0-1
## [49] jquerylib_0.1.4
## [51] glue_1.8.0
## [53] BiocIO_1.20.0
## [55] pillar_1.11.1
## [57] htmltools_0.5.8.1
## [59] httr2_1.2.1
## [61] dbplyr_2.5.1
## [63] lattice_0.22-7
## [65] png_0.1-8
## [67] cigarillo_1.0.0
## [69] bslib_0.9.0
## [71] xfun_0.53
## [73] pkgconfig_2.0.3

fastmap_1.2.0
BiocFileCache_3.0.0
digest_0.6.37
KEGGREST_1.50.0
compiler_4.5.1
sass_0.4.10
yaml_2.3.10
S4Arrays_1.10.0
curl_7.0.0
abind_1.4-8
withr_3.0.2
grid_4.5.1
SummarizedExperiment_1.40.0
rmarkdown_2.30
httr_1.4.7
DBI_1.2.3
affy_1.88.0
BiocManager_1.30.26
matrixStats_1.5.0
Matrix_1.7-4
bookdown_0.45
RBGL_1.86.0
affyio_1.80.0
codetools_0.2-20
tibble_3.3.0
rappdirs_0.3.3
graph_1.88.0
R6_2.6.1
evaluate_1.0.5
highr_0.11
Rsamtools_2.26.0
memoise_2.0.1
SparseArray_1.10.0
MatrixGenerics_1.22.0

24

