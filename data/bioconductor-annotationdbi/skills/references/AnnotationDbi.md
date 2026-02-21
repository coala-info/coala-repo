How to use bimaps from the ".db" annota-
tion packages

Marc Carlson, Hervé Pagès, Seth Falcon, Nianhua Li

October 29, 2025

NOTE The ‘bimap’ interface to annotation resources is not recommend; instead, use
the approach in the vignette Introduction To Bioconductor Annotation Packages.

1

Introduction

1.0.1 Purpose

AnnotationDbi is used primarily to create mapping objects that allow easy access
from R to underlying annotation databases. As such, it acts as the R interface for all
the standard annotation packages. Underlying each AnnotationDbi supported anno-
tation package is at least one (and often two) annotation databases. AnnotationDbi
also provides schemas for theses databases. For each supported model organism, a
standard gene centric database is maintained from public sources and is packaged up
as an appropriate organism or "org" package.

1.0.2 Database Schemas

For developers, a lot of the benefits of having the information loaded into a real
database will require some knowledge about the database schema. For this reason
the schemas that were used in the creation of each database type are included in
AnnotationDbi. The currently supported schemas are listed in the DBschemas direc-
tory of AnnotationDbi. But it is also possible to simply print out the schema that a
package is currently using by using its "_dbschema" method.

There is one schema/database in each kind of package. These schemas specify which
tables and indices will be present for each package of that type. The schema that a
particular package is using is also listed when you type the name of the package as
a function to obtain quality control information.

The code to make most kinds of the new database packages is also included in
AnnotationDbi. Please see the vignette on SQLForge for more details on how to
make additional database packages.

How to use bimaps from the ".db" annotation packages

1.0.3

Internal schema Design of org packages

The current design of the organism packages is deliberately simple and gene centric.
Each table in the database contains a unique kind of information and also an internal
identifier called _id. The internal _id has no meaning outside of the context of a
single database. But _id does connect all the data within a single database.

As an example if we wanted to connect the values in the genes table with the values
in the kegg table, we could simply join the two tables using the internal _id column.
It is very important to note however that _id does not have any absolute significance.
That is, it has no meaning outside of the context of the database where it is used. It
is tempting to think that an _id could have such significance because within a single
database, it looks and behaves similarly to an entrez gene ID. But _id is definitely
NOT an entrez gene ID. The entrez gene IDs are in another table entirely, and can
be connected to using the internal _id just like all the other meaningful information
inside these databases. Each organism package is centered around one type of gene
identifier. This identifier is found as the gene_id field in the genes table and is both
the central ID for the database as well as the foreign key that chip packages should
join to.

The chip packages are ’lightweight’, and only contain information about the basic
probe to gene mapping. You might wonder how such packages can provide access
to all the other information that they do. This is possible because all the other data
provided by chip packages comes from joins that are performed by AnnotationDbi
behind the scenes at run time. All chip packages have a dependency on at least
one organism package. The name of the organism package being depended on can
be found by looking at its "ORGPKG" value. To learn about the schema from the
appropriate organism package, you will need to look at the "_dbschema" method for
that package. In the case of the chip packages, the gene_id that in these packages
is mapped to the probe_ids, is used as a foreign key to the appropriate organism
package.

Specialized packages like the packages for GO and KEGG, will have their own schemas
but will also adhere to the use of an internal _id for joins between their tables. As
with the organism packages, this _id is not suitable for use as a foreign key.

For a complete listing of the different schemas used by various packages, users can use
the available.dbschemas function. This list will also tell you which model organisms
are supported.

library(DBI)

library(org.Hs.eg.db)

## Loading required package:

AnnotationDbi

## Loading required package:

stats4

## Loading required package:

BiocGenerics

## Loading required package:

generics

2

How to use bimaps from the ".db" annotation packages

##

## Attaching package: ’generics’

## The following objects are masked from ’package:base’:

##

##

##

##

as.difftime, as.factor, as.ordered, intersect, is.element,

setdiff, setequal, union

## Attaching package: ’BiocGenerics’

## The following objects are masked from ’package:stats’:

##

##

IQR, mad, sd, var, xtabs

## The following objects are masked from ’package:base’:

##

##

##

##

##

##

##

Filter, Find, Map, Position, Reduce, anyDuplicated, aperm,

append, as.data.frame, basename, cbind, colnames, dirname,

do.call, duplicated, eval, evalq, get, grep, grepl, is.unsorted,

lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,

pmin.int, rank, rbind, rownames, sapply, saveRDS, table, tapply,

unique, unsplit, which.max, which.min

## Loading required package:

Biobase

## Welcome to Bioconductor

##

##

##

##

Vignettes contain introductory material; view with

’browseVignettes()’. To cite Bioconductor, see

’citation("Biobase")’, and for packages ’citation("pkgname")’.

## Loading required package:

IRanges

## Loading required package:

S4Vectors

##

## Attaching package: ’S4Vectors’

## The following object is masked from ’package:utils’:

##

##

findMatches

## The following objects are masked from ’package:base’:

##

##

##

I, expand.grid, unname

library(AnnotationForge)

available.dbschemas()

3

How to use bimaps from the ".db" annotation packages

2

Examples

2.0.1 Basic information

The AnnotationDbi package provides an interface to SQLite-based annotation pack-
ages. Each SQLite-based annotation package (identified by a “.db” suffix in the
package name) contains a number of AnnDbBimap objects in place of the environ-
ment objects found in the old-style environment-based annotation packages. The
API provided by AnnotationDbi allows you to treat the AnnDbBimap objects like
environment instances. For example, the functions [[, get, mget, and ls all behave
In
the same as they did with the older environment based annotation packages.
addition, new methods like [, toTable, subset and others provide some additional
flexibility in accessing the annotation data.

library(hgu95av2.db)

##

The same basic set of objects is provided with the db packages:

ls("package:hgu95av2.db")

## [1] "hgu95av2"

"hgu95av2.db"

## [3] "hgu95av2ACCNUM"

"hgu95av2ALIAS2PROBE"

## [5] "hgu95av2CHR"

"hgu95av2CHRLENGTHS"

## [7] "hgu95av2CHRLOC"

"hgu95av2CHRLOCEND"

## [9] "hgu95av2ENSEMBL"

"hgu95av2ENSEMBL2PROBE"

## [11] "hgu95av2ENTREZID"

"hgu95av2ENZYME"

## [13] "hgu95av2ENZYME2PROBE" "hgu95av2GENENAME"

## [15] "hgu95av2GO"

"hgu95av2GO2ALLPROBES"

## [17] "hgu95av2GO2PROBE"

"hgu95av2MAP"

## [19] "hgu95av2MAPCOUNTS"

"hgu95av2OMIM"

## [21] "hgu95av2ORGANISM"

"hgu95av2ORGPKG"

## [23] "hgu95av2PATH"

"hgu95av2PATH2PROBE"

## [25] "hgu95av2PFAM"

"hgu95av2PMID"

## [27] "hgu95av2PMID2PROBE"

"hgu95av2PROSITE"

## [29] "hgu95av2REFSEQ"

## [31] "hgu95av2UNIPROT"
## [33] "hgu95av2_dbconn"
## [35] "hgu95av2_dbschema"

"hgu95av2SYMBOL"
"hgu95av2_dbInfo"
"hgu95av2_dbfile"

Exercise 1
Start an R session and use the library function to load the hgu95av2.db software
package. Use search() to see that an organism package was also loaded and then
use the approriate "_dbschema" methods to the schema for the hgu95av2.db and
org.Hs.eg.db packages.

4

How to use bimaps from the ".db" annotation packages

It is possible to call the package name as a function to get some QC information
about it.

qcdata = capture.output(hgu95av2())

head(qcdata, 20)

## [1] "Quality control information for hgu95av2:"

## [2] ""

## [3] ""

## [4] "This package has the following mappings:"

## [5] ""

## [6] "hgu95av2ACCNUM has 12625 mapped keys (of 12625 keys)"

## [7] "hgu95av2ALIAS2PROBE has 37476 mapped keys (of 261726 keys)"

## [8] "hgu95av2CHR has 11683 mapped keys (of 12625 keys)"

## [9] "hgu95av2CHRLENGTHS has 595 mapped keys (of 711 keys)"

## [10] "hgu95av2CHRLOC has 11637 mapped keys (of 12625 keys)"

## [11] "hgu95av2CHRLOCEND has 11637 mapped keys (of 12625 keys)"

## [12] "hgu95av2ENSEMBL has 11609 mapped keys (of 12625 keys)"

## [13] "hgu95av2ENSEMBL2PROBE has 10016 mapped keys (of 42336 keys)"

## [14] "hgu95av2ENTREZID has 11683 mapped keys (of 12625 keys)"

## [15] "hgu95av2ENZYME has 2137 mapped keys (of 12625 keys)"

## [16] "hgu95av2ENZYME2PROBE has 785 mapped keys (of 975 keys)"

## [17] "hgu95av2GENENAME has 11683 mapped keys (of 12625 keys)"

## [18] "hgu95av2GO has 11475 mapped keys (of 12625 keys)"

## [19] "hgu95av2GO2ALLPROBES has 20621 mapped keys (of 22131 keys)"

## [20] "hgu95av2GO2PROBE has 15988 mapped keys (of 18864 keys)"

Alternatively, you can get similar information on how many items are in each of the
provided maps by looking at the MAPCOUNTs:

hgu95av2MAPCOUNTS

To demonstrate the environment API, we’ll start with a random sample of probe set
IDs.

all_probes <- ls(hgu95av2ENTREZID)
length(all_probes)

## [1] 12625

set.seed(0xa1beef)
probes <- sample(all_probes, 5)
probes

## [1] "39758_f_at" "34055_at"

"34045_at"

"38348_at"

"40584_at"

The usual ways of accessing annotation data are also available.

5

How to use bimaps from the ".db" annotation packages

hgu95av2ENTREZID[[probes[1]]]

## [1] "3916"

hgu95av2ENTREZID$"31882_at"

## [1] "9136"

syms <- unlist(mget(probes, hgu95av2SYMBOL))

syms

## 39758_f_at
"LAMP1"
##

34055_at
"ACVR1B"

34045_at
"CT62"

38348_at
"ACOX2"

40584_at
"NUP88"

The annotation packages provide a huge variety of information in each package.
Some common types of information include gene symbols (SYMBOL), GO terms
(GO), KEGG pathway IDs (KEGG), ENSEMBL IDs (ENSEMBL) and chromosome
start and stop locations (CHRLOC and CHRLOCEND). Each mapping will have a
manual page that you can read to describe the data in the mapping and where it
came from.

?hgu95av2CHRLOC

Exercise 2
For the probes in ’probes’ above, use the annotation mappings to find the chromosome
start locations.

2.0.2 Manipulating Bimap Objects

Many filtering operations on the annotation Bimap objects require conversion of
the AnnDbBimap into a list.
In general, converting to lists will not be the most
efficient way to filter the annotation data when using a SQLite-based package. Com-
pare the following two examples for how you could get the 1st ten elements of the
hgu95av2SYMBOL mapping. In the 1st case we have to get the entire mapping into
list form, but in the second case we first subset the mapping object itself and this
allows us to only convert the ten elements that we care about.

system.time(as.list(hgu95av2SYMBOL)[1:10])

## vs:

system.time(as.list(hgu95av2SYMBOL[1:10]))

There are many different kinds of Bimap objects in AnnotationDbi, but most of them
are of class AnnDbBimap. All /RclassBimap objects represent data as a set of left
and right keys. The typical usage of these mappings is to search for right keys that
match a set of left keys that have been supplied by the user. But sometimes it is
also convenient to go in the opposite direction.

6

How to use bimaps from the ".db" annotation packages

The annotation packages provide many reverse maps as objects in the package name
space for backwards compatibility, but the reverse mappings of almost any map is
also available using revmap. Since the data are stored as tables, no extra disk space
is needed to provide reverse mappings.

unlist(mget(syms, revmap(hgu95av2SYMBOL)))

LAMP1
##
## "39758_f_at"
ACVR1B5
##
"39199_at"
NUP882
"40804_at"

##

##

##

ACVR1B1

ACVR1B2
"34055_at" "34056_g_at"
CT62
"34045_at"

ACVR1B6
"921_s_at"

ACVR1B3
"34415_at"
ACOX2
"38348_at"

ACVR1B4
"36451_at"
NUP881
"40584_at"

So now that you know about the revmap function you might try something like this:

as.list(revmap(hgu95av2PATH)["00300"])

## $`00300`
## [1] "36132_at" "35870_at"

Note that in the case of the PATH map, we don’t need to use revmap(x) because
hgu95av2.db already provides the PATH2PROBE map:

x <- hgu95av2PATH

## except for the name, this is exactly revmap(x)

revx <- hgu95av2PATH2PROBE

revx2 <- revmap(x, objName="PATH2PROBE")

revx2

## PATH2PROBE map for chip hgu95av2 (object of class "ProbeAnnDbBimap")

identical(revx, revx2)

## [1] TRUE

as.list(revx["00300"])

## $`00300`
## [1] "36132_at" "35870_at"

Note that most maps are reversible with revmap, but some (such as the more complex
GO mappings), are not. Why is this? Because to reverse a mapping means that there
has to be a "value" that will always become the "key" on the newly reversed map. And
GO mappings have several distinct possibilities to choose from (GO ID, Evidence code
or Ontology). In non-reversible cases like this, AnnotationDbi will usually provide a
pre-defined reverse map. That way, you will always know what you are getting when
you call revmap

7

How to use bimaps from the ".db" annotation packages

While we are on the subject of GO and GO mappings, there are a series of spe-
cial methods for GO mappings that can be called to find out details about these
IDs. Term,GOID, Ontology, Definition,Synonym, and Secondary are all useful ways
of getting additional information about a particular GO ID. For example:

Term("GO:0000018")

##

##

GO:0000018

## "regulation of DNA recombination"

Definition("GO:0000018")

##

GO:0000018

## "Any process that modulates the frequency, rate or extent of DNA recombination, a DNA metabolic process in which a new genotype is formed by reassortment of genes resulting in gene combinations different from those that were present in the parents."

Exercise 3
Given the following set of RefSeq IDs: c("NG_005114","NG_007432","NG_008063"),
Find the Entrez Gene IDs that would correspond to those. Then find the GO terms
that are associated with those entrez gene IDs.

org.Hs.eg.db packages.

2.0.3

The Contents and Structure of Bimap Objects

Sometimes you may want to display or subset elements from an individual map. A
Bimap interface is available to access the data in table (data.frame) format using [
and toTable.

head(toTable(hgu95av2GO[probes]))

probe_id

##
## 1 34055_at GO:0000082
## 2 34055_at GO:0001701
## 3 34055_at GO:0001942
## 4 34055_at GO:0006355
## 5 34055_at GO:0007165
## 6 34055_at GO:0007178

go_id Evidence Ontology
BP
IDA

IEA

IEA

IDA

IDA

IEA

BP

BP

BP

BP

BP

The toTable function will display all of the information in a Bimap. This includes
both the left and right values along with any other attributes that might be attached
to those values. The left and right keys of the Bimap can be extracted using Lkeys
If is is necessary to only display information that is directly associated
and Rkeys.
with the left to right links in a Bimap, then the links function can be used. The
links returns a data frame with one row for each link in the bimap that it is applied
to. It only reports the left and right keys along with any attributes that are attached
to the edge between these two values.

8

How to use bimaps from the ".db" annotation packages

Note that the order of the cols returned by toTable does not depend on the direction
of the map. We refer to it as an ’undirected method’:

toTable(x)[1:6, ]

probe_id path_id
04010

##
## 1 1000_at
## 2 1000_at
## 3 1000_at
## 4 1000_at
## 5 1000_at
## 6 1000_at

toTable(revx)[1:6, ]

probe_id path_id
04010

##
## 1 1000_at
## 2 1000_at
## 3 1000_at
## 4 1000_at
## 5 1000_at
## 6 1000_at

04012

04062

04114

04150

04270

04012

04062

04114

04150

04270

Notice however that the Lkeys are always on the left (1st col), the Rkeys always in
the 2nd col

For length() and keys(), the result does depend on the direction, hence we refer to
these as ’directed methods’:

length(x)

## [1] 12625

length(revx)

## [1] 229

allProbeSetIds <- keys(x)

allKEGGIds <- keys(revx)

There are more ’undirected’ methods listed below:

junk <- Lkeys(x)

# same for all maps in hgu95av2.db (except pseudo-map

Llength(x)

## [1] 12625

# MAPCOUNTS)

# nb of Lkeys

junk <- Rkeys(x)

# KEGG ids for PATH/PATH2PROBE maps, GO ids for

# GO/GO2PROBE/GO2ALLPROBES maps, etc...

Rlength(x)

# nb of Rkeys

9

How to use bimaps from the ".db" annotation packages

## [1] 229

Notice how they give the same result for x and revmap(x)

You might be tempted to think that Lkeys and Llength will tell you all that you want
to know about the left keys. But things are more complex than this, because not all
keys are mapped. Often, you will only want to know about the keys that are mapped
(ie. the ones that have a corresponding Rkey). To learn this you want to use the
mappedkeys or the undirected variants mappedLkeys and mappedRkeys. Similarily, the
count.mappedkeys, count.mappedLkeys and count.mappedRkeys methods are very
fast ways to determine how many keys are mapped. Accessing keys like this is usually
very fast and so it can be a decent strategy to subset the mapping by 1st using the
mapped keys that you want to find.

x = hgu95av2ENTREZID[1:10]

## Directed methods

mappedkeys(x)

# mapped keys

## [1] "1000_at"
## [6] "1005_at"

"1001_at"
"1006_at"

"1002_f_at" "1003_s_at" "1004_at"
"1007_s_at" "1008_f_at" "1009_at"

count.mappedkeys(x)

# nb of mapped keys

## [1] 10

## Undirected methods

mappedLkeys(x)

# mapped left keys

## [1] "1000_at"
## [6] "1005_at"

"1001_at"
"1006_at"

"1002_f_at" "1003_s_at" "1004_at"
"1007_s_at" "1008_f_at" "1009_at"

count.mappedLkeys(x)

# nb of mapped Lkeys

## [1] 10

If you want to find keys that are not mapped to anything, you might want to use
isNA.

y = hgu95av2ENTREZID[isNA(hgu95av2ENTREZID)]

# usage like is.na()

Lkeys(y)[1:4]

## [1] "1037_at"

"1047_s_at" "1089_i_at" "108_g_at"

Exercise 4
How many probesets do not have a GO mapping for the hgu95av2.db package? How
many have no mapping? Find a probeset that has a GO mapping. Now look at the
GO mappings for this probeset in table form.

10

How to use bimaps from the ".db" annotation packages

2.0.4 Some specific examples

Lets use what we have learned to get information about the probes that are are not
assigned to a chromosome:

x <- hgu95av2CHR

Rkeys(x)

## [1] "19" "12" "8"

"14" "3"

"2"

"17" "16" "9"

"X"

"6"

"1"

"7"

## [14] "10" "11" "22" "5" "18" "15" "Y"

"20" "21" "4"

"13" "MT" "Un"

chroms <- Rkeys(x)[23:24]

chroms

## [1] "4" "13"

Rkeys(x) <- chroms

toTable(x)

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

## 22

## 23

## 24

## 25

## 26

## 27

## 28

## 29

4

4

4

4

4

4

4

4

13

13

13

13

probe_id chromosome
1029_s_at
4
1036_at
1058_at
1065_at
1115_at
1189_at
1198_at
1219_at
1220_g_at
1249_at
1285_at
1303_at
1325_at
1348_s_at
1369_s_at
1377_at
1378_g_at
1451_s_at
1503_at
1507_s_at
1527_s_at
1528_at
1529_at
1530_g_at
1531_at
1532_g_at
1538_s_at
1542_at
1545_g_at

13

13

13

13

13

13

13

13

13

13

4

4

4

4

4

4

11

How to use bimaps from the ".db" annotation packages

## 30

## 31

## 32

## 33

## 34

## 35

## 36

## 37

## 38

## 39

## 40

## 41

## 42

## 43

## 44

## 45

## 46

## 47

## 48

## 49

## 50

## 51

## 52

## 53

## 54

## 55

## 56

## 57

## 58

## 59

## 60

## 61

## 62

## 63

## 64

## 65

## 66

## 67

## 68

## 69

## 70

## 71

## 72

## 73

## 74

1567_at
1570_f_at
1571_f_at
1593_at
1597_at
1598_g_at
159_at
1600_at
1604_at
1605_g_at
1616_at
1624_at
1629_s_at
1653_at
1670_at
1672_f_at
1679_at
1708_at
1709_g_at
170_at
1720_at
1721_g_at
1731_at
1732_at
1819_at
1828_s_at
1836_at
1883_s_at
1888_s_at
1900_at
1905_s_at
1913_at
1914_at
1931_at
1934_s_at
1943_at
1954_at
1963_at
1964_g_at
1968_g_at
1987_at
1988_at
1989_at
1990_g_at
2044_s_at

13

13

13

4

13

13

4

4

4

4

13

4

4

4

13

13

4

4

4

13

4

4

4

4

13

4

4

4

4

13

13

4

13

13

4

4

4

13

13

4

4

4

13

13

13

12

How to use bimaps from the ".db" annotation packages

## 91

## 96

## 81

## 83

## 76

## 87

## 80

## 82

## 85

## 75

## 84

## 78

## 77

## 86

## 79

2062_at
2092_s_at
214_at
215_g_at
252_at
253_g_at
260_at
281_s_at
31314_at
31320_at
31333_at
31345_at
31349_at
31356_at
## 88
## 89 31382_f_at
31404_at
## 90
31408_at
31464_at
## 92
## 93 31465_g_at
## 94 31516_f_at
31543_at
## 95
31562_at
31584_at
31628_at
## 98
## 99 31631_f_at
## 100 31639_f_at
## 101 31640_r_at
## 102 31670_s_at
31684_at
## 103
31686_at
31706_at
31744_at
31753_at
31790_at
31792_at
31805_at
## 110
## 111 31811_r_at
31847_at
## 112
31849_at
31851_at
## 114
## 115 31876_r_at
31894_at
## 116
## 117 31969_i_at
## 118 31970_r_at
## 119 32006_r_at

## 107

## 108

## 109

## 113

## 106

## 104

## 105

## 97

4

4

4

4

13

13

4

4

4

13

4

4

4

4

4

13

4

13

13

13

4

13

13

13

4

13

13

4

4

4

4

4

13

13

4

4

4

13

13

13

4

4

4

4

4

13

How to use bimaps from the ".db" annotation packages

## 137

## 138

## 141

## 140

## 139

## 133

## 129

## 130

## 132

## 122

## 131

## 120 32026_s_at
32080_at
## 121
32102_at
32145_at
## 123
## 124 32146_s_at
32147_at
## 125
32148_at
## 126
## 127 32180_s_at
32220_at
## 128
32299_at
32337_at
32349_at
32353_at
32357_at
32368_at
## 134
## 135 32393_s_at
32439_at
## 136
32446_at
32449_at
32465_at
32482_at
32506_at
32570_at
32580_at
32595_at
32602_at
32641_at
32675_at
32703_at
32768_at
32769_at
32770_at
32771_at
32812_at
32822_at
32832_at
32862_at
32906_at
32979_at
## 158
## 159 32986_s_at
32998_at
## 160
33013_at
## 161
## 162 33068_f_at
## 163 33069_f_at
33100_at
## 164

## 152

## 153

## 154

## 156

## 155

## 157

## 147

## 145

## 149

## 150

## 143

## 148

## 144

## 151

## 142

## 146

4

4

13

4

4

13

13

4

13

4

13

4

4

4

13

4

13

4

4

4

13

4

4

4

4

4

13

4

4

13

4

4

4

4

4

4

13

13

4

13

4

4

4

4

4

14

How to use bimaps from the ".db" annotation packages

## 186

## 181

## 182

## 179

## 180

## 178

## 168

## 174

## 177

## 175

## 176

33150_at
## 165
## 166 33151_s_at
33155_at
## 167
33156_at
33168_at
## 169
## 170 33171_s_at
33172_at
## 171
## 172 33173_g_at
33199_at
## 173
33208_at
33241_at
33249_at
33267_at
33276_at
33299_at
33318_at
33356_at
33359_at
33369_at
## 183
## 184 33370_r_at
33382_at
## 185
33483_at
33488_at
33490_at
33494_at
33519_at
33520_at
33525_at
33526_at
33529_at
33536_at
33544_at
33564_at
33576_at
33584_at
33596_at
33657_at
33687_at
33700_at
33733_at
33791_at
33823_at
33827_at
33837_at
33859_at

## 197

## 198

## 200

## 208

## 199

## 201

## 209

## 202

## 203

## 207

## 205

## 204

## 206

## 191

## 194

## 192

## 196

## 189

## 188

## 190

## 187

## 195

## 193

4

4

4

4

13

4

4

4

13

13

4

4

4

13

4

13

4

4

4

4

4

4

4

4

4

4

13

4

4

4

4

4

4

13

4

4

4

13

13

4

13

4

13

4

13

15

How to use bimaps from the ".db" annotation packages

## 224

## 231

## 229

## 230

## 225

## 219

## 216

## 221

## 222

## 217

## 223

## 215

## 220

## 214

## 218

## 210

33975_at
33990_at
## 211
## 212 33991_g_at
33992_at
## 213
33997_at
34021_at
34022_at
34026_at
34029_at
34048_at
34051_at
34058_at
34075_at
34122_at
34131_at
34144_at
34145_at
## 226
## 227 34170_s_at
34181_at
## 228
34198_at
34211_at
34225_at
34239_at
## 232
## 233 34240_s_at
34247_at
## 234
34248_at
## 235
## 236 34275_s_at
34284_at
## 237
34307_at
34319_at
34324_at
34334_at
34335_at
34341_at
## 243
## 244 34342_s_at
34353_at
## 245
34398_at
34411_at
34423_at
34459_at
## 249
## 250 34476_r_at
34482_at
## 251
34512_at
34551_at
34564_at

## 242

## 254

## 252

## 248

## 247

## 253

## 246

## 238

## 239

## 240

## 241

4

4

4

4

4

4

4

13

4

4

13

4

4

4

4

4

4

4

4

4

13

4

13

13

4

4

4

13

13

4

13

13

13

4

4

4

13

4

4

13

4

4

4

4

4

16

How to use bimaps from the ".db" annotation packages

## 275

## 274

## 276

## 269

## 270

## 271

## 273

## 272

## 263

## 257

## 262

## 264

## 256

## 255

34565_at
34578_at
34583_at
34596_at
## 258
## 259 34637_f_at
## 260 34638_r_at
34657_at
## 261
34672_at
34745_at
34803_at
34898_at
## 265
## 266 34953_i_at
## 267 34954_r_at
34955_at
## 268
34973_at
34984_at
34988_at
35020_at
35021_at
35025_at
35028_at
35039_at
35053_at
35061_at
35063_at
35081_at
35105_at
35107_at
35110_at
35131_at
35134_at
35140_at
35147_at
35164_at
35181_at
## 289
## 290 35182_f_at
35193_at
## 291
35213_at
35214_at
35215_at
35220_at
35285_at
35306_at
35344_at
35356_at

## 287

## 297

## 293

## 295

## 299

## 292

## 298

## 288

## 294

## 296

## 283

## 282

## 285

## 279

## 281

## 286

## 280

## 284

## 277

## 278

4

13

13

4

4

4

13

13

4

13

4

4

4

13

4

4

4

4

4

4

4

4

4

4

4

13

13

13

13

4

4

13

13

4

4

4

13

13

4

4

4

4

4

13

4

17

How to use bimaps from the ".db" annotation packages

## 320

## 321

## 316

## 317

## 319

## 318

## 311

## 307

## 300

35357_at
35371_at
## 301
## 302 35372_r_at
35400_at
## 303
35410_at
## 304
## 305 35435_s_at
35437_at
## 306
35469_at
35470_at
## 308
## 309 35471_g_at
35481_at
## 310
35507_at
35523_at
## 312
## 313 35554_f_at
## 314 35555_r_at
35564_at
## 315
35591_at
35656_at
35662_at
35664_at
35678_at
35698_at
35725_at
35730_at
35777_at
35793_at
35827_at
35837_at
35845_at
## 328
## 329 35871_s_at
35877_at
## 330
35904_at
## 331
## 332 35939_s_at
35940_at
## 333
35949_at
35972_at
35989_at
35991_at
36012_at
36013_at
36017_at
36021_at
36031_at
36046_at
36047_at

## 334

## 336

## 342

## 337

## 335

## 344

## 340

## 339

## 338

## 343

## 341

## 326

## 325

## 324

## 322

## 327

## 323

4

4

4

13

4

4

4

13

13

13

13

4

4

13

13

4

4

13

4

4

4

4

13

4

4

4

4

4

4

4

13

13

13

13

13

13

4

4

13

4

13

4

13

4

4

18

How to use bimaps from the ".db" annotation packages

## 365

## 366

## 362

## 361

## 363

## 364

## 356

## 348

## 351

## 349

## 355

## 357

## 346

## 347

## 350

## 345

36065_at
36080_at
36143_at
36157_at
36188_at
36194_at
36212_at
36243_at
## 352
## 353 36247_f_at
36269_at
## 354
36274_at
36358_at
36363_at
36433_at
## 358
## 359 36434_r_at
36510_at
## 360
36521_at
36606_at
36622_at
36627_at
36659_at
36717_at
36788_at
367_at
36814_at
36830_at
36913_at
36914_at
36915_at
36918_at
36939_at
## 375
## 376 36968_s_at
36990_at
## 377
37006_at
37019_at
37023_at
37056_at
37058_at
37062_at
37067_at
37079_at
37099_at
37109_at
37154_at
37170_at

## 380

## 381

## 382

## 389

## 388

## 379

## 387

## 384

## 383

## 378

## 385

## 386

## 367

## 368

## 373

## 374

## 369

## 370

## 372

## 371

4

4

4

4

13

4

13

4

4

4

13

4

4

4

4

13

13

4

4

4

13

4

13

13

4

13

4

4

4

4

4

13

4

4

4

13

4

4

4

13

13

13

13

13

4

19

How to use bimaps from the ".db" annotation packages

## 407

## 409

## 408

## 406

## 392

## 393

## 395

## 397

## 394

## 391

## 396

## 398

## 390

37172_at
37173_at
37187_at
37206_at
37219_at
37223_at
37243_at
37244_at
37280_at
37282_at
## 399
## 400 37291_r_at
37303_at
## 401
## 402 37322_s_at
## 403 37323_r_at
## 404 37356_r_at
37366_at
## 405
37404_at
37416_at
37472_at
37518_at
37520_at
## 410
## 411 37521_s_at
## 412 37522_r_at
37571_at
## 413
37578_at
37593_at
37619_at
37658_at
## 417
## 418 37707_i_at
## 419 37708_r_at
37723_at
## 420
37747_at
37748_at
37752_at
37757_at
37840_at
37852_at
37926_at
37930_at
37964_at
38008_at
38016_at
38024_at
## 432
## 433 38025_r_at
38035_at
## 434

## 422

## 430

## 425

## 429

## 423

## 426

## 427

## 424

## 428

## 431

## 414

## 416

## 421

## 415

13

4

4

4

4

4

4

13

4

4

4

13

4

4

4

4

4

4

4

13

4

4

4

13

4

13

4

13

4

4

4

4

4

4

13

4

4

13

13

4

4

4

4

4

13

20

How to use bimaps from the ".db" annotation packages

## 450

## 455

## 451

## 449

## 452

## 453

## 454

## 443

## 438

## 448

## 437

## 444

## 436

## 435

38065_at
38102_at
38120_at
38168_at
38254_at
## 439
## 440 38304_r_at
## 441 38350_f_at
38353_at
## 442
38375_at
38438_at
38485_at
## 445
## 446 38488_s_at
38489_at
## 447
38587_at
38606_at
38615_at
38639_at
38643_at
38649_at
38714_at
38715_at
38736_at
## 456
## 457 38751_i_at
## 458 38752_r_at
38767_at
## 459
38768_at
38778_at
38821_at
38825_at
38838_at
38854_at
38891_at
38923_at
38957_at
38972_at
38988_at
39028_at
39032_at
39037_at
39056_at
39083_at
39131_at
39132_at
## 477
## 478 39208_i_at
## 479 39209_r_at

## 467

## 471

## 470

## 469

## 472

## 475

## 468

## 473

## 474

## 476

## 464

## 463

## 466

## 465

## 461

## 462

## 460

4

13

4

4

4

13

13

13

13

4

4

4

4

4

4

13

4

4

13

4

4

4

4

4

4

4

4

4

4

4

4

4

4

13

13

4

13

13

4

4

4

13

4

4

4

21

How to use bimaps from the ".db" annotation packages

## 499

## 500

## 494

## 498

## 501

## 482

## 490

## 489

## 486

## 481

## 487

## 488

## 480

39224_at
39256_at
39257_at
39269_at
## 483
## 484 39295_s_at
39333_at
## 485
39337_at
39355_at
39369_at
39380_at
39382_at
39405_at
## 491
## 492 39469_s_at
39475_at
## 493
39481_at
39488_at
## 495
## 496 39489_g_at
39535_at
## 497
39554_at
39555_at
39576_at
39579_at
39600_at
39634_at
## 503
## 504 39662_s_at
39665_at
## 505
39680_at
39690_at
39698_at
39734_at
39746_at
39748_at
## 511
## 512 39758_f_at
39777_at
## 513
39786_at
39847_at
39850_at
39851_at
39852_at
39878_at
39897_at
39924_at
39929_at
39955_at
39960_at

## 522

## 524

## 519

## 514

## 516

## 517

## 518

## 515

## 523

## 520

## 521

## 509

## 510

## 508

## 507

## 506

## 502

4

13

13

13

4

13

4

4

4

4

4

13

13

4

4

13

13

4

4

4

4

13

4

4

4

4

4

4

4

4

4

13

13

13

4

4

4

4

13

13

4

13

4

13

4

22

How to use bimaps from the ".db" annotation packages

## 545

## 543

## 546

## 542

## 544

## 534

## 532

## 531

## 535

## 536

## 533

## 525

39979_at
40018_at
## 526
## 527 40058_s_at
## 528 40059_r_at
## 529 40060_r_at
40067_at
## 530
40072_at
40082_at
400_at
40114_at
40121_at
40148_at
40180_at
## 537
## 538 40181_f_at
40199_at
## 539
## 540 40217_s_at
40218_at
## 541
40225_at
40226_at
40272_at
40310_at
40312_at
40323_at
40349_at
40354_at
40392_at
## 550
## 551 40404_s_at
40449_at
## 552
40454_at
40456_at
40473_at
40492_at
40530_at
40570_at
## 558
## 559 40576_f_at
40633_at
## 560
40681_at
40697_at
40710_at
40711_at
40727_at
40746_at
## 566
## 567 40770_f_at
40772_at
## 568
40773_at

## 557

## 564

## 569

## 562

## 561

## 563

## 565

## 553

## 554

## 555

## 547

## 556

## 548

## 549

13

13

4

4

4

13

13

4

13

4

4

4

13

13

4

4

4

4

4

4

4

13

4

4

4

13

13

4

4

4

13

4

4

13

4

13

13

4

4

4

4

4

4

4

4

23

How to use bimaps from the ".db" annotation packages

## 590

## 589

## 580

## 579

## 572

## 571

## 570

40818_at
40828_at
40839_at
40853_at
## 573
## 574 40880_r_at
40893_at
## 575
408_at
## 576
## 577 40908_r_at
40943_at
## 578
40970_at
40990_at
40991_at
## 581
## 582 40992_s_at
## 583 40993_r_at
## 584 41014_s_at
## 585 41024_f_at
## 586 41025_r_at
## 587 41026_f_at
41069_at
## 588
41071_at
41104_at
41118_at
## 591
## 592 41119_f_at
41145_at
## 593
41148_at
41182_at
41191_at
41276_at
41277_at
## 598
## 599 41300_s_at
41301_at
## 600
41308_at
## 601
## 602 41309_g_at
41317_at
## 603
## 604 41318_g_at
41319_at
## 605
## 606 41376_i_at
## 607 41377_f_at
41391_at
## 608
41392_at
41402_at
41434_at
41436_at
41456_at
41459_at

## 613

## 609

## 610

## 614

## 612

## 611

## 594

## 596

## 595

## 597

4

13

13

4

4

13

4

13

4

13

4

4

4

4

4

4

4

4

13

4

4

13

13

4

4

13

4

13

13

13

13

4

4

13

13

13

4

4

4

4

4

4

13

4

13

24

How to use bimaps from the ".db" annotation packages

## 630

## 629

## 631

## 627

## 619

## 626

## 628

41470_at
## 615
## 616 41491_s_at
## 617 41492_r_at
41493_at
## 618
41534_at
41555_at
## 620
## 621 41556_s_at
41585_at
## 622
## 623 41667_s_at
## 624 41668_r_at
41697_at
## 625
41801_at
41806_at
41860_at
431_at
504_at
507_s_at
579_at
618_at
630_at
631_g_at
655_at
690_s_at
692_s_at
764_s_at
820_at
886_at
931_at
936_s_at
948_s_at
963_at
975_at
990_at
991_g_at

## 647

## 648

## 644

## 635

## 638

## 637

## 642

## 645

## 643

## 636

## 641

## 634

## 633

## 646

## 632

## 639

## 640

4

13

13

13

4

4

4

4

13

13

4

4

4

13

4

4

4

4

4

4

4

4

4

4

4

4

4

13

4

4

13

4

13

13

To get this in the classic named-list format:

z <- as.list(revmap(x)[chroms])

names(z)

## [1] "4" "13"

z[["Y"]]

## NULL

25

How to use bimaps from the ".db" annotation packages

Many of the common methods for accessing Bimap objects return things in list
format. This can be convenient. But you have to be careful about this if you
want to use unlist(). For example the following will return multiple probes for each
chromosome:

chrs = c("12","6")

mget(chrs, revmap(hgu95av2CHR[1:30]), ifnotfound=NA)

## $`12`
## [1] "1018_at"
##
## $`6`
## [1] "1007_s_at" "1026_s_at" "1027_at"

"1019_g_at" "101_at"

"1021_at"

But look what happens here if we try to unlist that:

unlist(mget(chrs, revmap(hgu95av2CHR[1:30]), ifnotfound=NA))

##

##

##

##

121

122
"1018_at" "1019_g_at"

123
"101_at"

63
"1027_at"

124

62
"1021_at" "1007_s_at" "1026_s_at"

61

Yuck! One trick that will sometimes help is to use Rfunctionunlist2. But be careful
here too. Depending on what step comes next, Rfunctionunlist2 may not really help
you...

unlist2(mget(chrs, revmap(hgu95av2CHR[1:30]), ifnotfound=NA))

##

##

##

##

12

12
"1018_at" "1019_g_at"

12
"101_at"

6
"1027_at"

12

6
"1021_at" "1007_s_at" "1026_s_at"

6

Lets ask if the probes in ’pbids’ mapped to cytogenetic location "18q11.2"?

x <- hgu95av2MAP
pbids <- c("38912_at", "41654_at", "907_at", "2053_at", "2054_g_at",

"40781_at")

x <- subset(x, Lkeys=pbids, Rkeys="18q11.2")

toTable(x)

## [1] probe_id
## <0 rows> (or 0-length row.names)

cytogenetic_location

To coerce this map to a named vector:

pb2cyto <- as.character(x)

pb2cyto[pbids]

26

How to use bimaps from the ".db" annotation packages

## <NA> <NA> <NA> <NA> <NA> <NA>

##

NA

NA

NA

NA

NA

NA

The coercion of the reverse map works too but issues a warning because of the
duplicated names for the reasons stated above:

cyto2pb <- as.character(revmap(x))

2.0.5 Accessing probes that map to multiple targets

In many probe packages, some probes are known to map to multiple genes. The
reasons for this can be biological as happens in the arabidopsis packages, but usually
it is due to the fact that the genome builds that chip platforms were based on were
less stable than desired. Thus what may have originally been a probe designed to
measure one thing can end up measuring many things. Usually you don’t want to use
probes like this, because if they manufacturer doesn’t know what they map to then
their usefullness is definitely suspect. For this reason, by default all chip packages
will normally hide such probes in the standard mappings. But sometimes you may
want access to the answers that the manufacturer says such a probe will map to. In
such cases, you will want to use the toggleProbes method. To use this method, just
call it on a standard mapping and copy the result into a new mapping (you cannot
alter the original mapping). Then treat the new mapping as you would any other
mapping.

## How many probes?

dim(hgu95av2ENTREZID)

## [1] 11683

2

## Make a mapping with multiple probes exposed

multi <- toggleProbes(hgu95av2ENTREZID, "all")

## How many probes?

dim(multi)

## [1] 12973

2

If you then decide that you want to make a mapping that has only multiple mappings
or you wish to revert one of your maps back to the default state of only showing the
single mappings then you can use toggleProbes to switch back and forth.

## Make a mapping with ONLY multiple probes exposed

multiOnly <- toggleProbes(multi, "multiple")

## How many probes?

dim(multiOnly)

## [1] 1290

2

## Then make a mapping with ONLY single mapping probes

27

How to use bimaps from the ".db" annotation packages

singleOnly <- toggleProbes(multiOnly, "single")

## How many probes?

dim(singleOnly)

## [1] 11683

2

Finally, there are also a pair of test methods hasMultiProbes and hasSingleProbes
that can be used to see what methods a mapping presently has exposed.

## Test the multiOnly mapping

hasMultiProbes(multiOnly)

## [1] TRUE

hasSingleProbes(multiOnly)

## [1] FALSE

## Test the singleOnly mapping

hasMultiProbes(singleOnly)

## [1] FALSE

hasSingleProbes(singleOnly)

## [1] TRUE

2.0.6 Using SQL to access things directly

While the mapping objects provide a lot of convenience, sometimes there are definite
benefits to writing a simple SQL query. But in order to do this, it is necessary to
know a few things. The 1st thing you will need to know is some SQL. Fortunately,
it is quite easy to learn enough basic SQL to get stuff out of a database. Here are 4
basic SQL things that you may find handy:

First, you need to know about SELECT statements. A simple example would look
something like this:

SELECT * FROM genes;

Which would select everything from the genes table.

SELECT gene_id FROM genes;

Will select only the gene_id field from the genes table.

Second you need to know about WHERE clauses:

SELECT gene_id,_id FROM genes WHERE gene_id=1;

Will only get records from the genes table where the gene_id is = 1.

Thirdly, you will want to know about an inner join:

28

How to use bimaps from the ".db" annotation packages

SELECT * FROM genes,chromosomes WHERE genes._id=chromosomes._id;

This is only slightly more complicated to understand. Here we want to get all the
records that are in both the ’genes’ and ’chromosomes’ tables, but we only want ones
where the ’_id’ field is identical. This is known as an inner join because we only want
the elements that are in both of these tables with respect to ’_id’. There are other
kinds of joins that are worth learning about, but most of the time, this is all you will
need to do.

Finally, it is worthwhile to learn about the AS keyword which is useful for making
long queries easier to read. For the previous example, we could have written it this
way to save space:

SELECT * FROM genes AS g,chromosomes AS c WHERE g._id=c._id;

In a simple example like this you might not see a lot of savings from using AS, so
lets consider what happens when we want to also specify which fields we want:

SELECT g.gene_id,c.chromosome FROM genes AS g,chromosomes AS c WHERE
g._id=c._id;

Now you are most of the way there to being able to query the databases directly. The
only other thing you need to know is a little bit about how to access these databases
from R. With each package, you will also get a method that will print the schema
for its database, you can view this to see what sorts of tables are present etc.

org.Hs.eg_dbschema()

To access the data in a database, you will need to connect to it. Fortunately, each
package will automatically give you a connection object to that database when it
loads.

org.Hs.eg_dbconn()

You can use this connection object like this:

query <- "SELECT gene_id FROM genes LIMIT 10;"
result = dbGetQuery(org.Hs.eg_dbconn(), query)
result

Exercise 5
Retrieve the entrez gene ID and chromosome by using a database query. Show how
you could do the same thing by using toTable

2.0.7 Combining data from multiple annotation packages at the SQL level

For a more complex example, consider the task of obtaining all gene symbols which
are probed on a chip that have at least one GO BP ID annotation with evidence code
IMP, IGI, IPI, or IDA. Here is one way to extract this using the environment-based
packages:

29

How to use bimaps from the ".db" annotation packages

## Obtain SYMBOLS with at least one GO BP

## annotation with evidence IMP, IGI, IPI, or IDA.

system.time({

bpids <- eapply(hgu95av2GO, function(x) {

if (length(x) == 1 && is.na(x))

NA

else {

sapply(x, function(z) {

if (z$Ontology == "BP")

z$GOID

else

NA

})

}

})

bpids <- unlist(bpids)

bpids <- unique(bpids[!is.na(bpids)])

g2p <- mget(bpids, hgu95av2GO2PROBE)

wantedp <- lapply(g2p, function(x) {

x[names(x) %in% c("IMP", "IGI", "IPI", "IDA")]

})

wantedp <- wantedp[sapply(wantedp, length) > 0]

wantedp <- unique(unlist(wantedp))

ans <- unlist(mget(wantedp, hgu95av2SYMBOL))

})

length(ans)

ans[1:10]

All of the above code could have been reduced to a single SQL query with the SQLite-
based packages. But to put together this query, you would need to look 1st at the
schema to know what tables are present:

hgu95av2_dbschema()

This function will give you an output of all the create table statements that were
used to generate the hgu95av2 database. In this case, this is a chip package, so you
will also need to see the schema for the organism package that it depends on. To
learn what package it depends on, look at the ORGPKG value:

hgu95av2ORGPKG

Then you can see that schema by looking at its schema method:

30

How to use bimaps from the ".db" annotation packages

org.Hs.eg_dbschema()

So now we can see that we want to connect the data in the go_bp, and symbol tables
from the org.Hs.eg.sqlite database along with the probes data in the hgu95av2.sqlite
database. How can we do that?

It turns out that one of the great conveniences of SQLite is that it allows other
databases to be ‘ATTACHed’. Thus, we can keep our data in many differnt databases,
and then ’ATTACH’ them to each other in a modular fashion. The databases for
a given build have been built together and frozen into a single version specifically
to allow this sort of behavoir. To use this feature, the SQLite ATTACH command
requires the filename for the database file on your filesystem. Fortunately, R provides
a nice system independent way of getting that information. Note that the name of
the database is always the same as the name of the package, with the suffix ’.sqlite’.:

orgDBLoc = system.file("extdata", "org.Hs.eg.sqlite", package="org.Hs.eg.db")

attachSQL = paste("ATTACH '", orgDBLoc, "' AS orgDB;", sep = "")
dbGetQuery(hgu95av2_dbconn(), attachSQL)

## Warning in result_fetch(res@ptr, n = n):
and ‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘

Did you mean

‘dbExecute()‘, ‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

## data frame with 0 columns and 0 rows

Finally, you can assemble a cross-db sql query and use the helper function as follows.
Note that when we want to refer to tables in the attached database, we have to use
the ’orgDB’ prefix that we specified in the ’ATTACH’ query above.:

system.time({
SQL <- "SELECT DISTINCT probe_id,symbol FROM probes, orgDB.gene_info AS gi, orgDB.genes AS g, orgDB.go_bp AS bp WHERE bp._id=g._id AND gi._id=g._id AND probes.gene_id=g.gene_id AND bp.evidence IN ('IPI', 'IDA', 'IMP', 'IGI')"
zz <- dbGetQuery(hgu95av2_dbconn(), SQL)
})

##

##

user

system elapsed

0.105

0.034

0.139

#its a good idea to always DETACH your database when you are finished...
dbGetQuery(hgu95av2_dbconn(), "DETACH orgDB"

)

## Warning in result_fetch(res@ptr, n = n):
and ‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘

Did you mean

‘dbExecute()‘, ‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

## data frame with 0 columns and 0 rows

Exercise 6
Retrieve the entrez gene ID, chromosome location information and cytoband infom-
ration by using a single database query.

31

How to use bimaps from the ".db" annotation packages

Exercise 7
Expand on the example in the text above to combine data from the hgu95av2.db and
org.Hs.eg.db with the GO.db package so as to include the GO ID, and term definition
in the output.

## Warning in result_fetch(res@ptr, n = n):
and ‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘

Did you mean

‘dbExecute()‘, ‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

## Warning in result_fetch(res@ptr, n = n):
and ‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘

Did you mean

‘dbExecute()‘, ‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

## Warning in result_fetch(res@ptr, n = n):
and ‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘

Did you mean

‘dbExecute()‘, ‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

## Warning in result_fetch(res@ptr, n = n):
and ‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘

Did you mean

‘dbExecute()‘, ‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

The version number of R and packages loaded for generating the vignette were:

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

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

## [7] methods

base

##

## other attached packages:

32

How to use bimaps from the ".db" annotation packages

## [1] hgu95av2.db_3.13.0
## [3] org.Hs.eg.db_3.22.0
## [5] IRanges_2.44.0
## [7] Biobase_2.70.0
## [9] generics_0.1.4
## [11] knitr_1.50
##

AnnotationForge_1.52.0
AnnotationDbi_1.72.0
S4Vectors_0.48.0
BiocGenerics_0.56.0
DBI_1.2.3

## loaded via a namespace (and not attached):
## [1] bit_4.6.0
BiocStyle_2.38.0
## [4] BiocManager_1.30.26 highr_0.11
## [7] blob_1.2.4
## [10] Seqinfo_1.0.0
## [13] fastmap_1.2.0
## [16] XML_3.99-0.19
## [19] cachem_1.1.0
## [22] RSQLite_2.4.3
## [25] digest_0.6.37
## [28] evaluate_1.0.5
## [31] httr_1.4.7
## [34] htmltools_0.5.8.1

bitops_1.0-9
png_0.1-8
R6_2.6.1
rlang_1.1.6
xfun_0.53
memoise_2.0.1
GO.db_3.22.0
RCurl_1.98-1.17
tools_4.5.1

compiler_4.5.1
crayon_1.5.3
Biostrings_2.78.0
yaml_2.3.10
XVector_0.50.0
KEGGREST_1.50.0
bit64_4.6.0-1
cli_3.6.5
vctrs_0.6.5
rmarkdown_2.30
pkgconfig_2.0.3

33

