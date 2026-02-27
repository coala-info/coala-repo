ratCHRLOC

February 25, 2026

ratCHRLOC

Bioconductor annotation data package

Description

The annotation package was built using a downloadable R package - AnnBuilder (download and
build your own) from www.bioconductor.org using the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Thu Aug 30 09:57:40 2007

ratCHRLOC

Y

The function ratCHRLOC() provides information about the binary data files

ratCHRLOC10END

An annotation data file for transciption ending location of genes on
chromosome 10

Description

ratCHRLOC10END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 10 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

1

2

ratCHRLOC10START

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC10END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC10START

An annotation data file for transciption starting locations of genes on
chromosome 10

Description

ratCHRLOC10START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 10 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

3

ratCHRLOC11END

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC10START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC11END

An annotation data file for transciption ending location of genes on
chromosome 11

Description

ratCHRLOC11END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 11 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:
Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC11END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

4

ratCHRLOC11START

ratCHRLOC11START

An annotation data file for transciption starting locations of genes on
chromosome 11

Description

ratCHRLOC11START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 11 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC11START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC12END

5

ratCHRLOC12END

An annotation data file for transciption ending location of genes on
chromosome 12

Description

ratCHRLOC12END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 12 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC12END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

6

ratCHRLOC12START

ratCHRLOC12START

An annotation data file for transciption starting locations of genes on
chromosome 12

Description

ratCHRLOC12START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 12 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC12START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC13END

7

ratCHRLOC13END

An annotation data file for transciption ending location of genes on
chromosome 13

Description

ratCHRLOC13END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 13 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC13END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

8

ratCHRLOC13START

ratCHRLOC13START

An annotation data file for transciption starting locations of genes on
chromosome 13

Description

ratCHRLOC13START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 13 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC13START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC14END

9

ratCHRLOC14END

An annotation data file for transciption ending location of genes on
chromosome 14

Description

ratCHRLOC14END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 14 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC14END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

10

ratCHRLOC14START

ratCHRLOC14START

An annotation data file for transciption starting locations of genes on
chromosome 14

Description

ratCHRLOC14START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 14 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC14START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC15END

11

ratCHRLOC15END

An annotation data file for transciption ending location of genes on
chromosome 15

Description

ratCHRLOC15END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 15 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC15END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

12

ratCHRLOC15START

ratCHRLOC15START

An annotation data file for transciption starting locations of genes on
chromosome 15

Description

ratCHRLOC15START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 15 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC15START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC16END

13

ratCHRLOC16END

An annotation data file for transciption ending location of genes on
chromosome 16

Description

ratCHRLOC16END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 16 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC16END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

14

ratCHRLOC16START

ratCHRLOC16START

An annotation data file for transciption starting locations of genes on
chromosome 16

Description

ratCHRLOC16START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 16 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC16START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC17END

15

ratCHRLOC17END

An annotation data file for transciption ending location of genes on
chromosome 17

Description

ratCHRLOC17END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 17 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC17END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

16

ratCHRLOC17START

ratCHRLOC17START

An annotation data file for transciption starting locations of genes on
chromosome 17

Description

ratCHRLOC17START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 17 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC17START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC18END

17

ratCHRLOC18END

An annotation data file for transciption ending location of genes on
chromosome 18

Description

ratCHRLOC18END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 18 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC18END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

18

ratCHRLOC18START

ratCHRLOC18START

An annotation data file for transciption starting locations of genes on
chromosome 18

Description

ratCHRLOC18START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 18 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC18START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC19END

19

ratCHRLOC19END

An annotation data file for transciption ending location of genes on
chromosome 19

Description

ratCHRLOC19END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 19 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC19END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

20

ratCHRLOC19START

ratCHRLOC19START

An annotation data file for transciption starting locations of genes on
chromosome 19

Description

ratCHRLOC19START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 19 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC19START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC1END

21

ratCHRLOC1END

An annotation data file for transciption ending location of genes on
chromosome 1

Description

ratCHRLOC1END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 1 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC1END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

22

ratCHRLOC1START

ratCHRLOC1START

An annotation data file for transciption starting locations of genes on
chromosome 1

Description

ratCHRLOC1START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 1 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC1START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC20END

23

ratCHRLOC20END

An annotation data file for transciption ending location of genes on
chromosome 20

Description

ratCHRLOC20END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 20 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC20END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

24

ratCHRLOC20START

ratCHRLOC20START

An annotation data file for transciption starting locations of genes on
chromosome 20

Description

ratCHRLOC20START maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number 20 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC20START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC2END

25

ratCHRLOC2END

An annotation data file for transciption ending location of genes on
chromosome 2

Description

ratCHRLOC2END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 2 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC2END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

26

ratCHRLOC2START

ratCHRLOC2START

An annotation data file for transciption starting locations of genes on
chromosome 2

Description

ratCHRLOC2START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 2 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC2START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC3END

27

ratCHRLOC3END

An annotation data file for transciption ending location of genes on
chromosome 3

Description

ratCHRLOC3END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 3 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC3END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

28

ratCHRLOC3START

ratCHRLOC3START

An annotation data file for transciption starting locations of genes on
chromosome 3

Description

ratCHRLOC3START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 3 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC3START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC4END

29

ratCHRLOC4END

An annotation data file for transciption ending location of genes on
chromosome 4

Description

ratCHRLOC4END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 4 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC4END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

30

ratCHRLOC4START

ratCHRLOC4START

An annotation data file for transciption starting locations of genes on
chromosome 4

Description

ratCHRLOC4START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 4 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC4START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC5END

31

ratCHRLOC5END

An annotation data file for transciption ending location of genes on
chromosome 5

Description

ratCHRLOC5END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 5 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC5END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

32

ratCHRLOC5START

ratCHRLOC5START

An annotation data file for transciption starting locations of genes on
chromosome 5

Description

ratCHRLOC5START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 5 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC5START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC6END

33

ratCHRLOC6END

An annotation data file for transciption ending location of genes on
chromosome 6

Description

ratCHRLOC6END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 6 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC6END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

34

ratCHRLOC6START

ratCHRLOC6START

An annotation data file for transciption starting locations of genes on
chromosome 6

Description

ratCHRLOC6START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 6 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC6START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC7END

35

ratCHRLOC7END

An annotation data file for transciption ending location of genes on
chromosome 7

Description

ratCHRLOC7END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 7 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC7END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

36

ratCHRLOC7START

ratCHRLOC7START

An annotation data file for transciption starting locations of genes on
chromosome 7

Description

ratCHRLOC7START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 7 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC7START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC8END

37

ratCHRLOC8END

An annotation data file for transciption ending location of genes on
chromosome 8

Description

ratCHRLOC8END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 8 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC8END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

38

ratCHRLOC8START

ratCHRLOC8START

An annotation data file for transciption starting locations of genes on
chromosome 8

Description

ratCHRLOC8START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 8 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC8START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOC9END

39

ratCHRLOC9END

An annotation data file for transciption ending location of genes on
chromosome 9

Description

ratCHRLOC9END maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number 9 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC9END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

40

ratCHRLOC9START

ratCHRLOC9START

An annotation data file for transciption starting locations of genes on
chromosome 9

Description

ratCHRLOC9START maps Entrez Gene identifiers to the transciption starting locations of genes on
chromosome number 9 corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can
be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOC9START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOCCYTOLOC

41

ratCHRLOCCYTOLOC

An annotation data file for Cytoband locations on chromosomes

Description

ratCHRLOCCYTOLOC maps chromosome numbers and the locations of cytobands on chromo-
soms

Details

This is an environment object containing key and value pairs. Keys are chromosome numbers and
values are the locations of cytobands on correponding chromosoms. The mapped values are lists of
named vectors. The names of lists are cytoband identifiers (e. g. qA2, ...). Each list contains a vector
of two elements of integers for the starting and ending locations of the band on the chromosome
defined by the key the lists mapped to. Names of the vectors indicate whether the value is for the
starting or ending location.

Mappings were based on the following source(s):

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

Examples

bands <- as.list(ratCHRLOCCYTOLOC)
# cytobands on chromosome number 1
names(bands[[1]])
# The start and end locations for one band on chromosome number 1
bands[[1]][[1]]

ratCHRLOCENTREZID2CHR An annotation data file that maps Entrez Gene identifiers to chromo-

some number

Description

ratCHRLOCENTREZID2CHR maps Entrez Gene identifiers to the chromosome numbers the genes
represented by the Locuslink identifiers reside

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers
and values are the corresponding chromosome numbers the genes reside. Values are vectors of
length 1 or more depending on whether a give Entrez Gene identifier can be mapped to one or more
chromosomes.

Mappings were derived from data provided by:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

ratCHRLOCXEND

42

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOCENTREZID2CHR)
if(length(xx) > 0){
# Get the value of the first Entrez Gene id
xx[1]
# Get the values for a few Entrez Gene identifiers
if(length(xx) >= 3){
xx[1:3]
}
}

ratCHRLOCQC

Quality control information for ratCHRLOC

Description

ratCHRLOCQC is an R environment that provides quality control information for ratCHRLOC

Details

This file contains quality control information that can be displayed by typing ratCHRLOC() after
loading the package using library(ratCHRLOC). The follow items are included:

Date built: Date when the package was built.

Number of probes: total number of probes included

Probe number missmatch: if the total number of probes of any of the data file is different from a
base file used to check the data files the name of the data file will be listed

Probe missmatch: if any of probes in a data file missmatched that of the base file, the name of the
data file will be listed

Mappings found for probe based files: number of mappings obtained for the total number of probes

Mappings found for non-probe based files: total number of mappings obtained

ratCHRLOCXEND

An annotation data file for transciption ending location of genes on
chromosome X

Description

ratCHRLOCXEND maps Entrez Gene identifiers to the transciption ending location of genes on
chromosome number X corresponding to the Entrez Gene identifiers

ratCHRLOCXSTART

Details

43

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption ending location for genes. The ending positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the largest end value found for the Entrez Gene
identifier. Names of chromosome location values can be "Confident" when the gene can be con-
fidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in UCSC
data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOCXEND)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

ratCHRLOCXSTART

An annotation data file for transciption starting locations of genes on
chromosome X

Description

ratCHRLOCXSTART maps Entrez Gene identifiers to the transciption starting locations of genes
on chromosome number X corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can

44

ratCHRLOCXSTART

be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Rattus_norvegicus/database/. Built: No build info available.

Package built: Thu Aug 30 09:57:40 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(ratCHRLOCXSTART)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

Index

∗ datasets

ratCHRLOC, 1
ratCHRLOC10END, 1
ratCHRLOC10START, 2
ratCHRLOC11END, 3
ratCHRLOC11START, 4
ratCHRLOC12END, 5
ratCHRLOC12START, 6
ratCHRLOC13END, 7
ratCHRLOC13START, 8
ratCHRLOC14END, 9
ratCHRLOC14START, 10
ratCHRLOC15END, 11
ratCHRLOC15START, 12
ratCHRLOC16END, 13
ratCHRLOC16START, 14
ratCHRLOC17END, 15
ratCHRLOC17START, 16
ratCHRLOC18END, 17
ratCHRLOC18START, 18
ratCHRLOC19END, 19
ratCHRLOC19START, 20
ratCHRLOC1END, 21
ratCHRLOC1START, 22
ratCHRLOC20END, 23
ratCHRLOC20START, 24
ratCHRLOC2END, 25
ratCHRLOC2START, 26
ratCHRLOC3END, 27
ratCHRLOC3START, 28
ratCHRLOC4END, 29
ratCHRLOC4START, 30
ratCHRLOC5END, 31
ratCHRLOC5START, 32
ratCHRLOC6END, 33
ratCHRLOC6START, 34
ratCHRLOC7END, 35
ratCHRLOC7START, 36
ratCHRLOC8END, 37
ratCHRLOC8START, 38
ratCHRLOC9END, 39
ratCHRLOC9START, 40
ratCHRLOCCYTOLOC, 41

ratCHRLOCENTREZID2CHR, 41
ratCHRLOCQC, 42
ratCHRLOCXEND, 42
ratCHRLOCXSTART, 43

ratCHRLOC, 1
ratCHRLOC10END, 1
ratCHRLOC10START, 2
ratCHRLOC11END, 3
ratCHRLOC11START, 4
ratCHRLOC12END, 5
ratCHRLOC12START, 6
ratCHRLOC13END, 7
ratCHRLOC13START, 8
ratCHRLOC14END, 9
ratCHRLOC14START, 10
ratCHRLOC15END, 11
ratCHRLOC15START, 12
ratCHRLOC16END, 13
ratCHRLOC16START, 14
ratCHRLOC17END, 15
ratCHRLOC17START, 16
ratCHRLOC18END, 17
ratCHRLOC18START, 18
ratCHRLOC19END, 19
ratCHRLOC19START, 20
ratCHRLOC1END, 21
ratCHRLOC1START, 22
ratCHRLOC20END, 23
ratCHRLOC20START, 24
ratCHRLOC2END, 25
ratCHRLOC2START, 26
ratCHRLOC3END, 27
ratCHRLOC3START, 28
ratCHRLOC4END, 29
ratCHRLOC4START, 30
ratCHRLOC5END, 31
ratCHRLOC5START, 32
ratCHRLOC6END, 33
ratCHRLOC6START, 34
ratCHRLOC7END, 35
ratCHRLOC7START, 36
ratCHRLOC8END, 37
ratCHRLOC8START, 38

45

46

INDEX

ratCHRLOC9END, 39
ratCHRLOC9START, 40
ratCHRLOCCYTOLOC, 41
ratCHRLOCENTREZID2CHR, 41
ratCHRLOCLOCUSID2CHR

(ratCHRLOCENTREZID2CHR), 41
ratCHRLOCMAPCOUNTS (ratCHRLOCQC), 42
ratCHRLOCQC, 42
ratCHRLOCXEND, 42
ratCHRLOCXSTART, 43

