Package ‘inlinedocs’

Title Convert Inline Comments to Documentation

July 22, 2025

Type Package

Version 2023.9.4

Description Generates Rd files from R source code with comments.

The main features of the default syntax are that
(1) docs are defined in comments near the relevant code,
(2) function argument names are not repeated in comments, and
(3) examples are defined in R code, not comments.
It is also easy to define a new syntax.

URL https://github.com/tdhock/inlinedocs

BugReports https://github.com/tdhock/inlinedocs/issues

Depends methods, utils, R (>= 2.9)

License GPL-2 | GPL-3

LazyLoad yes

Encoding UTF-8

Suggests future.apply, future, R.methodsS3

NeedsCompilation no

Author Toby Dylan Hocking [aut, cre],

Keith Ponting [aut],
Thomas Wutzler [aut],
Philippe Grosjean [aut],
Markus Müller [aut],
R Core Team [ctb, cph]

Maintainer Toby Dylan Hocking <toby.hocking@r-project.org>

Repository CRAN

Date/Publication 2023-10-18 18:30:02 UTC

1

2

Contents

Contents

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

3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
apply.parsers
.
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
classic.parsers .
.
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
combine .
.
.
.
4
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
combine.character .
.
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
combine.list .
.
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
combine.NULL .
.
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
decomment
.
.
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
default.parsers .
.
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
descfile.names .
.
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
do.not.generate .
.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
DocLink-class .
.
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
escape_dots .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
9
.
extra.code.docs .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
.
.
extract.docs.file .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
.
extract.docs.setClass
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
.
extract.file.parse .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
extract.xxx.chunks
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
.
fake_package_env .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
findGeneric .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
fixPackageFileNames .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
.
.
forall .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
.
forall.parsers
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
forfun .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
forfun.parsers .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
getKnownS3generics .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
.
.
getSource .
get_internal_S3_generics .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
get_S3_primitive_generics . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
is_primitive_in_base .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
kill.prefix.whitespace .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
leadingS3generic .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
lonely .
.
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
make.package.and.check .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
modify.Rd.file .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
non.descfile.names
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
nondesc.parsers .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
package.skeleton.dx .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
.
.
.
.
prefix .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
.
.
prefixed.lines
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
print.allfun .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
removeAliasesfrom.Rd.file .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
replace.one .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
save.test.result .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
.
.
.
test.file .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
.
.
test.parsers
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
.
whole.word .

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

.

.

.

.

.

.

.

apply.parsers

Index

apply.parsers

apply parsers

3

30

Description

Parse code to r objs, then run all the parsers and return the documentation list.

Usage

apply.parsers(code, parsers = default.parsers,

verbose = FALSE,
...)

Arguments

code

parsers

verbose

...

Value

Character vector of code lines.

List of Parser Functions.

Echo names of Parser Functions?

Additional arguments to pass to Parser Functions.

A list of extracted documentation from code.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

classic.parsers

classic parsers

Description

List of classic parsers which were default before 2018.

Usage

"classic.parsers"

4

combine.character

combine

combine

Description

combine lists or character strings

Usage

combine(x, y)

Arguments

x

y

Author(s)

x

y

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

combine.character

combine character

Description

combine character strings by pasting them together

Usage

## S3 method for class 'character'
combine(x,
y)

Arguments

x

y

Author(s)

x

y

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

combine.list

5

combine.list

combine list

Description

combine lists by adding elements or adding to existing elements

Usage

## S3 method for class 'list'
combine(x, y)

Arguments

x
y

Value

x
y

A list, same type as x, but with added elements from y.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

combine.NULL

combine NULL

Description

combine NULL objects.

Usage

## S3 method for class 'NULL'
combine(x, y)

Arguments

x
y

Author(s)

x
y

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

6

descfile.names

decomment

decomment

Description

Remove comment prefix and join lines of code to form a documentation string.

Usage

decomment(comments)

Arguments

comments

Value

Character vector of prefixed comment lines.

String without prefixes or newlines.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

default.parsers

default parsers

Description

List of parsers to use by default with package.skeleton.dx.

Usage

"default.parsers"

descfile.names

descfile names

Description

Names of Parser Functions that operate on the desc arg.

Usage

"descfile.names"

do.not.generate

7

do.not.generate

do not generate

Description

Make a Parser Function used to indicate that certain Rd files should not be generated.

Usage

do.not.generate(...)

Arguments

...

Value

Character strings indicating Rd files without the .Rd suffix.

A Parser Function that will delete items from the outer Documentation List.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

Examples

silly.pkg <- system.file("silly",package="inlinedocs")
owd <- setwd(tempdir())
file.copy(silly.pkg,".",recursive=TRUE)

## define a custom Parser Function that will not generate some Rd
## files
custom <- do.not.generate("SillyTest-class")
parsers <- c(default.parsers,list(exclude=custom))

## At first, no Rd files in the man subdirectory.
man.dir <- file.path("silly","man")
dir(man.dir)

## Running package.skeleton.dx will generate bare-bones files for
## those specified in do.not.generate, if they do not exist.
package.skeleton.dx("silly",parsers)
Rd.files <- c("SillyTest-class.Rd","silly.example.Rd")
Rd.paths <- file.path(man.dir,Rd.files)
stopifnot(all(file.exists(Rd.paths)))

## Save the modification times of the Rd files
old <- file.info(Rd.paths)$mtime

8

DocLink-class

## make sure there is at least 2 seconds elapsed, which is the
## resolution for recording times on windows file systems.
Sys.sleep(4)

## However, it will NOT generate Rd for files specified in
## do.not.generate, if they DO exist already.
package.skeleton.dx("silly",parsers)
mtimes <- data.frame(old,new=file.info(Rd.paths)$mtime)
rownames(mtimes) <- Rd.files
mtimes$changed <- mtimes$old != mtimes$new
print(mtimes)
stopifnot(mtimes["SillyTest-class.Rd","changed"]==FALSE)
stopifnot(mtimes["silly.example.Rd","changed"]==TRUE)

unlink("silly",recursive=TRUE)
setwd(owd)

DocLink-class

Link documentation among related functions

Description

The .DocLink class provides the basis for hooking together documentation of related classes/functions/objects.
The aim is that documentation sections missing from the child are inherited from the parent class.

Objects from the Class

Objects can be created by calls of the form new(DocLink ...)

Slots

name: (character) name of object
created: (character) how created
parent: (character) parent class or NA
code: (character) actual source lines
description: (character) preceding description block

Methods

No methods defined with class "DocLink" in the signature.

escape_dots

9

escape_dots

escape dots

Description

Convert ... to \dots

Usage

escape_dots(arg)

Arguments

arg

Author(s)

arg

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

extra.code.docs

Extract documentation from code chunks

Description

Parse R code to extract inline documentation from comments around each function. These are not
able to be retreived simply by looking at the "source" attribute. This is a Parser Function that can
be used in the parser list of package.skeleton.dx(). TODO: Modularize this into separate Parsers
Functions for S4 classes, prefixes, ##«blocks, etc. Right now it is not very clean!

Usage

extra.code.docs(code,

objs, ...)

Arguments

code

objs

...

Value

Code lines in a character vector containing multiple R objects to parse for doc-
umentation.
The objects defined in the code.

ignored

named list of lists, one for each object to document.

10

Author(s)

extract.docs.setClass

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

extract.docs.file

extract docs file

Description

Apply all parsers relevant to extract info from just 1 code file.

Usage

extract.docs.file(f,

parsers = NULL, ...)

Arguments

f

parsers

...

Author(s)

File name of R code to read and parse.

Parser Functions to use to parse the code and extract documentation.

Other arguments to pass to Parser Functions.

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

Examples

f <- system.file("silly","R","silly.R",package="inlinedocs")
extract.docs.file(f)

extract.docs.setClass S4 class inline documentation

Description

Using the same conventions as for functions, definitions of S4 classes in the form setClass("classname",...)
are also located and scanned for inline comments.

Usage

extract.docs.setClass(doc.link)

11

DocLink object as created by extract.file.parse. Note that source state-
ments are ignored when scanning for class definitions.

extract.file.parse

Arguments

doc.link

Details

Extraction of S4 class documentation is currently limited to expressions within the source code
which have first line starting with setClass("classname". These are located from the source file
(allowing also for white space around the setClass and (). Note that "classname" must be a
quoted character string; expressions returning such a string are not matched.
For class definitions, the slots (elements of the representation list) fill the role of function ar-
guments, so may be documented by ##<< comments on the same line or ### comments at the
beginning of the following line.

If there is no explicit title on the first line of setClass, then one is made up from the class name.
The class definition skeleton includes an Objects from the Class section, to which any ##details<<
documentation chunks are written. It is given a vanilla content if there are no specific ##details<<
documentation chunks.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

extract.file.parse

File content analysis

Description

Using the base parse function, analyse the file to link preceding "prefix" comments to each active
chunk. Those comments form the default description for that chunk. The analysis also looks for
S4 class "setClass" calls and R.oo setConstructorS3 and setMethodS3 calls in order to link the
documentation of those properly.

Usage

extract.file.parse(code)

Arguments

code

Lines of R source code in a character vector - note that any nested source
statements are ignored when scanning for class definitions.

12

Details

extract.xxx.chunks

If the definition chunk does not contain a description, any immediately preceding sequence consec-
utive "prefix" lines will be used instead.

Class and method definitions can take several forms, determined by expression type:

assignment (<-) Ordinary assignment of value/function;

setClass Definition of S4 class;

setConstructorS3 Definition of S3 class using R.oo package;

R.methodsS3::setMethodS3 Definition of method for S3 class using R.oo package.

Additionally, the value may be a name of a function defined elsewhere, in which case the documen-
tation should be copied from that other definition. This is handled using the concept of documenta-
tion links.
The R.methodsS3::setMethodS3 calls introduce additional complexity: they will define an addi-
tional S3 generic (which needs documentation to avoid warnings at package build time) unless one
already exists. This also is handled by "linking" documentation. A previously unseen generic is
linked to the first defining instances, subsequent definitions of that generic also link back to the first
defining instance.

Value

Returns an invisible list of .DocLink objects.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

extract.xxx.chunks

Extract documentation from a function

Description

Given source code of a function, return a list describing inline documentation in that source code.

Usage

extract.xxx.chunks(src,

name.fun = "(unnamed function)",
...)

Arguments

src

name.fun

...

The source lines of the function to examine, as a character vector.

The name of the function/chunk to use in warning messages.

ignored.

extract.xxx.chunks

Details

13

For simple functions/arguments, the argument may also be documented by appending ##<< com-
ments on the same line as the argument name. Mixing this mechanism with ### comment lines for
the same argument is likely to lead to confusion, as the ### lines are processed first.
Additionally, consecutive sections of ## comment lines beginning with ##xxx<< (where xxx is one
of the fields: alias, details, keyword, references, author, note, seealso, value, title or
description) are accumulated and inserted in the relevant part of the .Rd file.
For value, title, description and function arguments, these append to any text from "prefix"
(^### ) comment lines, irrespective of the order in the source.
When documenting S4 classes, documentation from details sections will appear under a section
Objects from the Class. That section typically includes information about construction methods
as well as other description of class objects (but note that the class Slots are documented in a
separate section).

Each separate extra section appears as a new paragraph except that:

• empty sections (no matter how many lines) are ignored;
• alias and keyword sections have special rules;
• description should be brief, so all such sections are concatenated as one paragraph;
• title should be one line, so any extra title sections are concatenated as a single line with

spaces separating the sections.

As a special case, the construct ##describe<< causes similar processing to the main function argu-
ments to be applied in order to construct a describe block within the documentation, for example to
describe the members of a list. All subsequent "same line" ##<< comments go into that block until
terminated by a subsequent ##xxx<< line.
Such regions may be nested, but not in such a way that the first element in a describe is another
describe. Thus there must be at least one ##<< comment between each pair of ##describe<<
comments.
When nested describe blocks are used, a comment-only line with ##end<< terminates the current
level only; any other valid ##xxx<< line terminates all open describe blocks.

Value

Named list of character strings extracted from comments. For each name N we will look for N{...}
in the Rd file and replace it with the string in this list (implemented in modify.Rd.file).

Note

alias extras are automatically split at new lines.
keyword extras are automatically split at white space, as all the valid keywords are single words.
The "value" section of a .Rd file is implicitly a describe block and ##value<< acts accordingly.
Therefore it automatically enables the describe block itemization (##« after list entries).

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

14

findGeneric

fake_package_env

fake package env

Description

Create a fake package environment in a way that keeps S4 working (so there is a .packageName) and
also conforms to byte-code interpreter requirements on environment structure, particularly ensuring
that the created environment is a namespace. A similar procedure (with the exception of not deleting
objects) is now in testthat (test_pkg_env).

Usage

fake_package_env()

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

findGeneric

findGeneric

Description

Copied from R-3.0.1, to support findGeneric.

Usage

findGeneric(fname, envir)

Arguments

fname

envir

Author(s)

fname

envir

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

fixPackageFileNames

15

fixPackageFileNames

fixPackageFileNames

Description

Copied from R-3.0.1, to support fixPackageFileNames.

Usage

fixPackageFileNames(list)

Arguments

list

Author(s)

list

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

forall

forall

Description

For each object in the package that satisfies the criterion checked by subfun, parse source using
FUN and return the resulting documentation list.

Usage

forall(FUN, subfun = function(x) TRUE)

Function to apply to each element in the package.

Function to select subsets of elements of the package, such as is.function. sub-
fun(x)==TRUE means FUN will be applied to x and the result will be returned.

Arguments

FUN

subfun

Value

A Parser Function.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

16

forfun.parsers

forall.parsers

forall parsers

Description

List of Parser Functions that can be applied to any object.

Usage

"forall.parsers"

forfun

forfun

Description

For each function in the package, do something.

Usage

forfun(FUN)

Arguments

FUN

Author(s)

FUN

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

forfun.parsers

forfun parsers

Description

Parsers for each function that are constructed automatically. This is a named list, and each element
is a parser function for an individual object.

Usage

"forfun.parsers"

getKnownS3generics

17

getKnownS3generics

getKnownS3generics

Description

Copied from R-3.0.1, to support getKnownS3generics.

Usage

getKnownS3generics()

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

getSource

getSource

Description

Extract a function’s source code.

Usage

getSource(fun.obj)

Arguments

fun.obj

Value

A function.

Source code lines as a character vector.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

18

get_S3_primitive_generics

get_internal_S3_generics

get internal S3 generics

Description

Copied from R-3.0.1, to support getKnownS3generics.

Usage

get_internal_S3_generics(primitive = TRUE)

Arguments

primitive

primitive

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

get_S3_primitive_generics

get S3 primitive generics

Description

Copied from R-3.0.1, to support getKnownS3generics.

Usage

get_S3_primitive_generics(include_group_generics = TRUE)

Arguments

include_group_generics

include_group_generics

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

is_primitive_in_base

19

is_primitive_in_base

is primitive in base

Description

Copied from R-3.0.1, to support getKnownS3generics.

Usage

is_primitive_in_base(fname)

Arguments

fname

Author(s)

fname

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

kill.prefix.whitespace

kill prefix whitespace

Description

Figure out what the whitespace preceding the example code is, and then delete that from every line.

Usage

kill.prefix.whitespace(ex)

Arguments

ex

Value

character vector of example code lines.

Character vector of code lines with preceding whitespace removed.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

20

leadingS3generic

leadingS3generic

check whether function name is an S3 generic

Description

Determines whether a function name looks like an S3 generic function

Usage

leadingS3generic(name,

env, ...)

Arguments

name

env

...

Details

name of function

environment to search for additional generics

ignored here

This function is one of the default parsers, but exposed as possibly of more general interest. Given
a function name of the form x.y.z it looks for the generic function x applying to objects of class y.z
and also for generic function x.y applying to objects of class z.

Assumes that the first name which matches any known generics is the target generic function, so if
both x and x.y are generic functions, will assume generic x applying to objects of class y.z

Value

If a matching generic found returns a list with a single component:

.s3method

a character vector containing generic name and object name.

If no matching generic functions are found, returns an empty list.

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

lonely

21

lonely

lonely

Description

List of parser functions that operate on single objects. This list is useful for testing these functions.

Usage

"lonely"

Examples

f <- function # title

### description

(x, ##<< arg x
y
### arg y
){
##value<< a list with elements
list(x=x, ##<< original x value
y=y, ##<< original y value
sum=x+y) ##<< their sum

##end<<

}
src <- getSource(f)
lonely$extract.xxx.chunks(src)
lonely$prefixed.lines(src)

make.package.and.check

make package and check

Description

Assemble some R code into a package and process it using R CMD check, stopping with an error
if the check resulted in any errors or warnings.

Usage

make.package.and.check(f,

parsers = default.parsers,
verbose = TRUE)

22

Arguments

f

parsers

verbose

Author(s)

non.descfile.names

R code file name from which we will make a package

Parsers to use to make the package documentation.

print the check command line?

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

modify.Rd.file

modify Rd file

Description

Add inline documentation from comments to an Rd file automatically-generated by package.skeleton.

Usage

modify.Rd.file(N, pkg,

docs, verbose = FALSE)

Arguments

N

pkg

docs

Name of function/file to which we will add documentation.

Package name.

Named list of documentation in extracted comments.

verbose

Cat messages?

Author(s)

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

non.descfile.names

non descfile names

Description

Names of Parser Functions that do NOT use the desc arg.

Usage

"non.descfile.names"

nondesc.parsers

23

nondesc.parsers

nondesc parsers

Description

Parsers that operate only on R code, independently of the description file.

Usage

"nondesc.parsers"

package.skeleton.dx

Package skeleton deluxe

Description

Generates Rd files for a package based on R code and DESCRIPTION metadata. After reading the
pkgdir/R/*.R code files to find inline documentation (by default R code in *.r files will not be used
for inlinedocs), writes docs to pkgdir/man/*.Rd files, possibly overwriting the previous files there.

Usage

package.skeleton.dx(pkgdir = "..",

parsers = NULL, namespace = FALSE,
excludePattern = "[.][rsqS]$",
verbose = FALSE)

Arguments

pkgdir

parsers

namespace

Package directory where the DESCRIPTION file lives. Your code should be in
pkgdir/R.

List of Parser functions, which will be applied in sequence to extract documen-
tation from your code. Default NULL means to first search for a definition in
the variable "parsers" in pkgdir/R/.inlinedocs.R, if that file exists. If not, we use
the list defined in options("inlinedocs.parsers"), if that is defined. If not, we use
the package global default in the variable default.parsers.
A logical indicating whether a NAMESPACE file should be generated for this
package. If TRUE, all objects whose name starts with a letter, plus all S4 methods
and classes are exported.

excludePattern A regular expression matching the files that are not to be processed e.g. because
inlinedocs can not handle them yet (like generic function definitions). Default
value means to only process inlinedocs in .R files. Set excludePattern=NULL to
process all code files, e.g. *.r files.

verbose

show messages about parser functions used?

24

Author(s)

prefix

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

Examples

owd <- setwd(tempdir())

## get the path to the silly example package that is provided with
## package inlinedocs
testPackagePath <- file.path(system.file(package="inlinedocs"),"silly")
## copy example project to the current unlocked workspace that can
## be modified
file.copy(testPackagePath,".",recursive=TRUE)

## generate documentation .Rd files for this package
package.skeleton.dx("silly")

## check the package to see if generated documentation passes
## without WARNINGs.
if(interactive()){

cmd <- sprintf("%s CMD check --as-cran silly",file.path(R.home("bin"), "R"))
print(cmd)
system(cmd)

}
## cleanup: remove the test package from current workspace again
unlink("silly",recursive=TRUE)
setwd(owd)

prefix

prefix

Description

Prefix for code comments used with grep and gsub.

Usage

"prefix"

prefixed.lines

25

prefixed.lines

prefixed lines

Description

The primary mechanism of inline documentation is via consecutive groups of lines matching the
specified prefix regular expression "^### " (i.e.
lines beginning with "### ") are collected as
follows into documentation sections:

description group starting at line 2 in the code

arguments group following each function argument

value group ending at the penultimate line of the code

These may be added to by use of the ##<< constructs described below.

Usage

prefixed.lines(src, ...)

Arguments

src

...

Author(s)

src

. . .

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

Examples

test <- function
### the description
(x,
### the first argument

y ##<< another argument
){
5

### the return value
##seealso<< foobar
}
src <- getSource(test)
prefixed.lines(src)
extract.xxx.chunks(src)

26

removeAliasesfrom.Rd.file

print.allfun

print allfun

Description

Print method for functions constructed using forall.

Usage

## S3 method for class 'allfun'
print(x, ...)

Arguments

x

...

Author(s)

x

. . .

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

removeAliasesfrom.Rd.file

removeAliasesfrom Rd file

Description

remove aliases to methodnames from the Rd file of a class automatically-generated by package.skeleton.

Usage

removeAliasesfrom.Rd.file(N,

pkg, code)

Arguments

N

pkg

code

Author(s)

Name of function/file to which we will add documentation.

Package name.
The code of the package

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

replace.one

27

replace.one

replace one

Description

Do find and replace for one element of an inner documentation list on 1 Rd file.

Usage

replace.one(torep, REP,

txt, verbose = FALSE)

Arguments

torep

REP

txt

verbose

Author(s)

tag to find.

contents of tag to put inside.

text in which to search.

cat messages?

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

save.test.result

save test result

Description

For unit tests, this is an easy way of getting a text representation of the list result of extract.docs.file.

Usage

save.test.result(f)

Arguments

f

Author(s)

R code file with inlinedocs to process with extract.docs.file.

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

28

test.parsers

test.file

test file

Description

Check an R code file with inlinedocs to see if the extract.docs.file parser accurately extracts all
the code inside! The code file should contain a variable .result which is the documentation list that
you should get when you apply extract.docs.file to the file. We check for identity of elements
of elements of the list, so the order of elements should not matter, and thus this should be a good
robust unit test.

Usage

test.file(f, CRAN.checks = TRUE,

verbose = FALSE)

Arguments

f

CRAN.checks

verbose

Author(s)

File name of R code file with inlinedocs to parse and check.

try to make a package and run CRAN checks?

Show output?

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

See Also

save.test.result

test.parsers

test parsers

Description

List of classic parsers which were default before 2018.

Usage

"test.parsers"

whole.word

29

whole.word

whole word

Description

Regex for a whole word to code/link tags.

Usage

whole.word(...)

Arguments

...

Author(s)

. . .

Toby Dylan Hocking <toby.hocking@r-project.org> [aut, cre], Keith Ponting [aut], Thomas Wut-
zler [aut], Philippe Grosjean [aut], Markus Müller [aut], R Core Team [ctb, cph]

Index

∗ documentation

extract.xxx.chunks, 12

∗ utilities

extract.xxx.chunks, 12

apply.parsers, 3

classic.parsers, 3
combine, 4, 4, 5
combine.character, 4
combine.list, 5
combine.NULL, 5

decomment, 6
default.parsers, 6, 23
descfile.names, 6
do.not.generate, 7
DocLink (DocLink-class), 8
DocLink-class, 8

escape_dots, 9
extra.code.docs, 9
extract.docs.file, 10, 27, 28
extract.docs.setClass, 10
extract.file.parse, 11
extract.xxx.chunks, 12

fake_package_env, 14
findGeneric, 14
fixPackageFileNames, 15
forall, 15, 26
forall.parsers, 16
forfun, 16
forfun.parsers, 16

get_internal_S3_generics, 18
get_S3_primitive_generics, 18
getKnownS3generics, 17, 18, 19
getSource, 17

is_primitive_in_base, 19

kill.prefix.whitespace, 19

leadingS3generic, 20
lonely, 21

make.package.and.check, 21
modify.Rd.file, 13, 22

non.descfile.names, 22
nondesc.parsers, 23

package.skeleton.dx, 6, 23
prefix, 6, 24, 25
prefixed.lines, 25
print.allfun, 26

removeAliasesfrom.Rd.file, 26
replace.one, 27

save.test.result, 27, 28
setMethodS3, 11

test.file, 28
test.parsers, 28

whole.word, 29

30

