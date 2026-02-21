Package ‘BiocCaseStudies’

April 15, 2019

Title BiocCaseStudies: Support for the Case Studies Monograph

Version 1.44.0

Author R. Gentleman, W. Huber, F. Hahne, M. Morgan, S. Falcon

Description Software and data to support the case studies.

Maintainer Bioconductor Package Maintainer

<maintainer@bioconductor.org>

License Artistic-2.0

LazyLoad true

Collate init.R requiredLibs.R resample.R mySessionInfo.R colors.R

ﬁxedWidthCat.R

Depends tools, methods, utils, Biobase

Suggests affy (>= 1.17.3), affyPLM (>= 1.15.1), affyQCReport (>=

1.17.0), ALL (>= 1.4.3), annaffy (>= 1.11.1), annotate (>=
1.17.3), AnnotationDbi (>= 1.1.6), apComplex (>= 2.5.0),
Biobase (>= 1.17.5), bioDist (>= 1.11.3), biocGraph (>= 1.1.1),
biomaRt (>= 1.13.5), CCl4 (>= 1.0.6), CLL (>= 1.2.4), Category
(>= 2.5.0), class (>= 7.2-38), cluster (>= 1.11.9), convert (>=
1.15.0), gcrma (>= 2.11.1), geneﬁlter (>= 1.17.6), geneplotter
(>= 1.17.2), GO.db (>= 2.0.2), GOstats (>= 2.5.0), graph (>=
1.17.4), GSEABase (>= 1.1.13), hgu133a.db (>= 2.0.2),
hgu95av2.db, hgu95av2cdf (>= 2.0.0), hgu95av2probe (>= 2.0.0),
hopach (>= 1.13.0), KEGG.db (>= 2.0.2), kohonen (>= 2.0.2),
lattice (>= 0.17.2), latticeExtra (>= 0.3-1), limma (>=
2.13.1), MASS (>= 7.2-38), MLInterfaces (>= 1.13.17), multtest
(>= 1.19.0), org.Hs.eg.db (>= 2.0.2), ppiStats (>= 1.5.4),
randomForest (>= 4.5-20), RBGL (>= 1.15.6), RColorBrewer (>=
1.0-2), Rgraphviz (>= 1.17.11), vsn (>= 3.4.0), weaver (>=
1.5.0), xtable (>= 1.5-2), yeastExpData (>= 0.9.11)

biocViews Infrastructure

git_url https://git.bioconductor.org/packages/BiocCaseStudies

git_branch RELEASE_3_8

git_last_commit 2b671b5

git_last_commit_date 2018-10-30

Date/Publication 2019-04-15

1

2

R topics documented:

ﬁxedWidthCat

.

.

.
.
ﬁxedWidthCat .
.
markup .
.
.
.
mySessionInfo .
parseLibVers
.
.
requiredPackages .
.
resample .

.

.

.

.

.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3
4
5
5
6

7

Index

fixedWidthCat

Control the output of show methods

Description

fixedWidthCat makes sure that the output of a show method ﬁts on the page by inserting lines
breaks into long strings.

numName converts an integer to it’s literal name.

sepInt prints integers with a comma as separator between 1000s

Usage

fixedWidthCat(x, width=getOption("width"))

Arguments

x

width

Value

An R object which is to be shown.

The number of characters after which lines are to be broken.

A character vector of the output with long lines broken

Author(s)

Florian Hahne

Examples

long <- paste(rep(letters[1:24], 5), sep="", collapse="")
fixedWidthCat(long)

markup

3

markup

Markup commands.

Description

Usage of predeﬁned markup commands for layout of Bioc Case Studies book.

Details

The following markup commands, LaTeX makros and environments are available for controling the
layout and structure of the book:

• Ex:environment for exercise chunks.

• solution:environment for solutions to the exercises.

• \myincfig:macro for ﬁgure environments with three parameters: (1) ﬁgure ﬁlename (2) ﬁgure

width (3) ﬁgure caption

• \solfig:macro for ﬁgure environments within solution chunks. This is necessary because

LaTex doesn’t allow for ﬂoats within minipage environments.

• \myref:reference to other labs/chapters. For the book this is a simplewrapper around ref ig-
noring the second argument, for the labs this command is replaced in the useRlabs.sty ﬁle
allowing for referencing bbetween the individual documents.

• \booklab:macro for conditional text input with two parameters. The ﬁrst parameter will be

used for the book while the second will be used for the labs.

The following makros will automatically create index entries as side effect. Apart from that they do
text highlighting as well.

• \R:the R language glyph (in sans serif font)

• \Rpackage:an R package (in bold font)

• \Rclass:an R class (in italics)

• \Rmethod:an R method (in small typewriter font)

• \Rfunction:an R function (in small typewriter font)

Implicit index terms can be generated using

• \indexTerm:with the optional ﬁrst argument giving the actual term and the second argument
giving a string that appears in the text. E.g. indexTerm[tree]{trees} would give you "trees"
in the text but create an index for "tree". Omitting the optional ﬁrst argument will create an
index for the same string that appears in the text.

Some more usful text markup that doesn’t create indices:

• \Robject:an R object (in small typewriter font)

• \Rfunarg:the agument to an R function (in italics)

• \code:typewriter font

• \term:whatever \{emph} is set to

• \file:italics

• \reg:The registered trademark glyph

4

mySessionInfo

The following environments are used to structure the document and for parsing . They do not
impose any layout.

• chapterheader:this contains title, authors and abstract of the chapter/lab

• chapterbody:this contains the actual chapter body

• chaptertrailer:this contains session info and references for a chapter

• \yaa:This is a wrapper for input also setting the graphics include path. Its ﬁrst parameter is

ﬁlename, second parameter is graphics path

Color and options

• colors:There are some predeﬁned colors that should be used consistantly throughout the whole
book for things like histograms, barplots, etc. They are deﬁned by BiocCaseStudies as
objects lcol1, lcol2 and lcol3 for light colors, and dcol1, dcol2 and dcol3 for dark colors.

• Sweave options:The boolean option hideme can be used in Sweave code chunks that should
not be part of the Stangle output. This only effects Stangle, so a "regular" Sweave will evaluate
these chunks. The intention is to have the possibility for sanity checks or conditional code
evaluation which should not confuse the users when they work with the extracted code.

Author(s)

Florian Hahne

mySessionInfo

Wrapper around sessionInfo

Description

This will produce the LaTeX output for the sessionInfo and the references at the end of each lab.

Usage

mySessionInfo(ref=TRUE)

Arguments

ref

logical controlling whether to include references

Value

This function is called for its side effects

Author(s)

Florian Hahne

parseLibVers

5

parseLibVers

Parse the library versions

Description

This is a helper function to check for valid package versions

Usage

parseLibVers()

Value

Called for its side effects

Author(s)

Florian Hahne

requiredPackages

check for missing and outdated packages

Description

Both functions compare the Depends ﬁeld of the DESCRIPTION of the BiocCaseStudies package.
requiredPackages is run before a build of the book.
It throws an error if there are any miss-
ing or outdated packages. packages2install returns a character vector of packages that need
(re)installing.

Usage

requiredPackages(load=FALSE)
packages2install()

Arguments

load

Logical. Should all packages be loaded?

Value

requiredPackages returns invisible(NULL). The function is called for its side effects. packages2install
returns a character vector that can be passed to the install function from the BiocManager pack-
age.

Author(s)

Florian Hahne

resample

6

Examples

## Not run:

if (!requireNamespace("BiocManager", quietly = TRUE))

install.packages("BiocManager")
BiocManager::install(packages2install())

## End(Not run)

resample

Resample from ALL ExpressionSet and plot

Description

A function to resample samples from each class of an ExpressionSet and plot the results calculated
by a function that returns the number of differentially expressed genes between the classes.

Usage

resample(x, selfun, groupsize = 6 * (1:6), nrep = 25)

Arguments

x

selfun

An ExpressionSet object derived from the ALL data package.

A function that takes the resampling subset of the ExpressionSet and computes
the number of differentially expressed genes between the two classes

groupsize

The number of samples for each class

nrep

number of iterations of resampling procedure

Value

The function is called for the side effect of producing a plot.

Author(s)

Florian Hahne

Index

∗Topic misc

fixedWidthCat, 2
markup, 3
mySessionInfo, 4
parseLibVers, 5
requiredPackages, 5
resample, 6

booklab (markup), 3

dcol1 (markup), 3
dcol2 (markup), 3
dcol3 (markup), 3

Ex (markup), 3

fixedWidthCat, 2

indexTerm (markup), 3

lcol1 (markup), 3
lcol2 (markup), 3
lcol3 (markup), 3

markup, 3
myincfig (markup), 3
myref (markup), 3
mySessionInfo, 4

numName (fixedWidthCat), 2

packages2install (parseLibVers), 5
parseLibVers, 5

requiredPackages, 5
resample, 6

sepInt (fixedWidthCat), 2
solfig (markup), 3
solution (markup), 3

7

