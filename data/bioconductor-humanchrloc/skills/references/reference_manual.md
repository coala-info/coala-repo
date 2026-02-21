humanCHRLOC

February 11, 2026

humanCHRLOC

Bioconductor annotation data package

Description

The annotation package was built using a downloadable R package - AnnBuilder (download and
build your own) from www.bioconductor.org using the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Thu Aug 30 09:54:07 2007

humanCHRLOC

Y

The function humanCHRLOC() provides information about the binary data files

humanCHRLOC10END

An annotation data file for transciption ending location of genes on
chromosome 10

Description

humanCHRLOC10END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 10 corresponding to the Entrez Gene identifiers

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

humanCHRLOC10START

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC10END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC10START

An annotation data file for transciption starting locations of genes on
chromosome 10

Description

humanCHRLOC10START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 10 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

3

humanCHRLOC11END

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC10START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC11END

An annotation data file for transciption ending location of genes on
chromosome 11

Description

humanCHRLOC11END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 11 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC11END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

4

humanCHRLOC11START

humanCHRLOC11START

An annotation data file for transciption starting locations of genes on
chromosome 11

Description

humanCHRLOC11START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 11 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC11START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC12END

5

humanCHRLOC12END

An annotation data file for transciption ending location of genes on
chromosome 12

Description

humanCHRLOC12END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 12 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC12END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

6

humanCHRLOC12START

humanCHRLOC12START

An annotation data file for transciption starting locations of genes on
chromosome 12

Description

humanCHRLOC12START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 12 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC12START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC13END

7

humanCHRLOC13END

An annotation data file for transciption ending location of genes on
chromosome 13

Description

humanCHRLOC13END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 13 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC13END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

8

humanCHRLOC13START

humanCHRLOC13START

An annotation data file for transciption starting locations of genes on
chromosome 13

Description

humanCHRLOC13START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 13 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC13START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC14END

9

humanCHRLOC14END

An annotation data file for transciption ending location of genes on
chromosome 14

Description

humanCHRLOC14END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 14 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC14END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

10

humanCHRLOC14START

humanCHRLOC14START

An annotation data file for transciption starting locations of genes on
chromosome 14

Description

humanCHRLOC14START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 14 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC14START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC15END

11

humanCHRLOC15END

An annotation data file for transciption ending location of genes on
chromosome 15

Description

humanCHRLOC15END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 15 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC15END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

12

humanCHRLOC15START

humanCHRLOC15START

An annotation data file for transciption starting locations of genes on
chromosome 15

Description

humanCHRLOC15START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 15 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC15START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC16END

13

humanCHRLOC16END

An annotation data file for transciption ending location of genes on
chromosome 16

Description

humanCHRLOC16END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 16 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC16END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

14

humanCHRLOC16START

humanCHRLOC16START

An annotation data file for transciption starting locations of genes on
chromosome 16

Description

humanCHRLOC16START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 16 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC16START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC17END

15

humanCHRLOC17END

An annotation data file for transciption ending location of genes on
chromosome 17

Description

humanCHRLOC17END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 17 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC17END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

16

humanCHRLOC17START

humanCHRLOC17START

An annotation data file for transciption starting locations of genes on
chromosome 17

Description

humanCHRLOC17START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 17 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC17START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC18END

17

humanCHRLOC18END

An annotation data file for transciption ending location of genes on
chromosome 18

Description

humanCHRLOC18END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 18 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC18END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

18

humanCHRLOC18START

humanCHRLOC18START

An annotation data file for transciption starting locations of genes on
chromosome 18

Description

humanCHRLOC18START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 18 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC18START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC19END

19

humanCHRLOC19END

An annotation data file for transciption ending location of genes on
chromosome 19

Description

humanCHRLOC19END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 19 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC19END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

20

humanCHRLOC19START

humanCHRLOC19START

An annotation data file for transciption starting locations of genes on
chromosome 19

Description

humanCHRLOC19START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 19 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC19START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC1END

21

humanCHRLOC1END

An annotation data file for transciption ending location of genes on
chromosome 1

Description

humanCHRLOC1END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 1 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC1END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

22

humanCHRLOC1START

humanCHRLOC1START

An annotation data file for transciption starting locations of genes on
chromosome 1

Description

humanCHRLOC1START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 1 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC1START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC20END

23

humanCHRLOC20END

An annotation data file for transciption ending location of genes on
chromosome 20

Description

humanCHRLOC20END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 20 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC20END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

24

humanCHRLOC20START

humanCHRLOC20START

An annotation data file for transciption starting locations of genes on
chromosome 20

Description

humanCHRLOC20START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 20 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC20START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC21END

25

humanCHRLOC21END

An annotation data file for transciption ending location of genes on
chromosome 21

Description

humanCHRLOC21END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 21 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC21END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

26

humanCHRLOC21START

humanCHRLOC21START

An annotation data file for transciption starting locations of genes on
chromosome 21

Description

humanCHRLOC21START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 21 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC21START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC22END

27

humanCHRLOC22END

An annotation data file for transciption ending location of genes on
chromosome 22

Description

humanCHRLOC22END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 22 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC22END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

28

humanCHRLOC22START

humanCHRLOC22START

An annotation data file for transciption starting locations of genes on
chromosome 22

Description

humanCHRLOC22START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 22 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC22START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC2END

29

humanCHRLOC2END

An annotation data file for transciption ending location of genes on
chromosome 2

Description

humanCHRLOC2END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 2 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC2END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

30

humanCHRLOC2START

humanCHRLOC2START

An annotation data file for transciption starting locations of genes on
chromosome 2

Description

humanCHRLOC2START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 2 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC2START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC3END

31

humanCHRLOC3END

An annotation data file for transciption ending location of genes on
chromosome 3

Description

humanCHRLOC3END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 3 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC3END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

32

humanCHRLOC3START

humanCHRLOC3START

An annotation data file for transciption starting locations of genes on
chromosome 3

Description

humanCHRLOC3START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 3 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC3START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC4END

33

humanCHRLOC4END

An annotation data file for transciption ending location of genes on
chromosome 4

Description

humanCHRLOC4END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 4 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC4END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

34

humanCHRLOC4START

humanCHRLOC4START

An annotation data file for transciption starting locations of genes on
chromosome 4

Description

humanCHRLOC4START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 4 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC4START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC5END

35

humanCHRLOC5END

An annotation data file for transciption ending location of genes on
chromosome 5

Description

humanCHRLOC5END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 5 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC5END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

36

humanCHRLOC5START

humanCHRLOC5START

An annotation data file for transciption starting locations of genes on
chromosome 5

Description

humanCHRLOC5START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 5 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC5START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC6END

37

humanCHRLOC6END

An annotation data file for transciption ending location of genes on
chromosome 6

Description

humanCHRLOC6END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 6 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC6END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

38

humanCHRLOC6START

humanCHRLOC6START

An annotation data file for transciption starting locations of genes on
chromosome 6

Description

humanCHRLOC6START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 6 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC6START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC7END

39

humanCHRLOC7END

An annotation data file for transciption ending location of genes on
chromosome 7

Description

humanCHRLOC7END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 7 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC7END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

40

humanCHRLOC7START

humanCHRLOC7START

An annotation data file for transciption starting locations of genes on
chromosome 7

Description

humanCHRLOC7START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 7 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC7START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC8END

41

humanCHRLOC8END

An annotation data file for transciption ending location of genes on
chromosome 8

Description

humanCHRLOC8END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 8 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC8END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

42

humanCHRLOC8START

humanCHRLOC8START

An annotation data file for transciption starting locations of genes on
chromosome 8

Description

humanCHRLOC8START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 8 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC8START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOC9END

43

humanCHRLOC9END

An annotation data file for transciption ending location of genes on
chromosome 9

Description

humanCHRLOC9END maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number 9 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC9END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

44

humanCHRLOC9START

humanCHRLOC9START

An annotation data file for transciption starting locations of genes on
chromosome 9

Description

humanCHRLOC9START maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number 9 corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOC9START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOCCYTOLOC

45

humanCHRLOCCYTOLOC

An annotation data file for Cytoband locations on chromosomes

Description

humanCHRLOCCYTOLOC maps chromosome numbers and the locations of cytobands on chro-
mosoms

Details

This is an environment object containing key and value pairs. Keys are chromosome numbers and
values are the locations of cytobands on correponding chromosoms. The mapped values are lists of
named vectors. The names of lists are cytoband identifiers (e. g. qA2, ...). Each list contains a vector
of two elements of integers for the starting and ending locations of the band on the chromosome
defined by the key the lists mapped to. Names of the vectors indicate whether the value is for the
starting or ending location.

Mappings were based on the following source(s):
Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

Examples

bands <- as.list(humanCHRLOCCYTOLOC)
# cytobands on chromosome number 1
names(bands[[1]])
# The start and end locations for one band on chromosome number 1
bands[[1]][[1]]

humanCHRLOCENTREZID2CHR

An annotation data file that maps Entrez Gene identifiers to chromo-
some number

Description

humanCHRLOCENTREZID2CHR maps Entrez Gene identifiers to the chromosome numbers the
genes represented by the Locuslink identifiers reside

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers
and values are the corresponding chromosome numbers the genes reside. Values are vectors of
length 1 or more depending on whether a give Entrez Gene identifier can be mapped to one or more
chromosomes.

Mappings were derived from data provided by:
Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

humanCHRLOCXEND

46

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOCENTREZID2CHR)
if(length(xx) > 0){
# Get the value of the first Entrez Gene id
xx[1]
# Get the values for a few Entrez Gene identifiers
if(length(xx) >= 3){
xx[1:3]
}
}

humanCHRLOCQC

Quality control information for humanCHRLOC

Description

humanCHRLOCQC is an R environment that provides quality control information for humanCHRLOC

Details

This file contains quality control information that can be displayed by typing humanCHRLOC()
after loading the package using library(humanCHRLOC). The follow items are included:

Date built: Date when the package was built.

Number of probes: total number of probes included

Probe number missmatch: if the total number of probes of any of the data file is different from a
base file used to check the data files the name of the data file will be listed

Probe missmatch: if any of probes in a data file missmatched that of the base file, the name of the
data file will be listed

Mappings found for probe based files: number of mappings obtained for the total number of probes

Mappings found for non-probe based files: total number of mappings obtained

humanCHRLOCXEND

An annotation data file for transciption ending location of genes on
chromosome X

Description

humanCHRLOCXEND maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number X corresponding to the Entrez Gene identifiers

humanCHRLOCXSTART

Details

47

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOCXEND)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOCXSTART

An annotation data file for transciption starting locations of genes on
chromosome X

Description

humanCHRLOCXSTART maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number X corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can

48

humanCHRLOCYEND

be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOCXSTART)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOCYEND

An annotation data file for transciption ending location of genes on
chromosome Y

Description

humanCHRLOCYEND maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number Y corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

humanCHRLOCYSTART

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

49

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOCYEND)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

humanCHRLOCYSTART

An annotation data file for transciption starting locations of genes on
chromosome Y

Description

humanCHRLOCYSTART maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number Y corresponding to the Entrez Gene identifiers

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
currentGenomes//Homo_sapiens/database/. Built: No build info available.

Package built: Thu Aug 30 09:54:07 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

humanCHRLOCYSTART

50

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(humanCHRLOCYSTART)
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

humanCHRLOC, 1
humanCHRLOC10END, 1
humanCHRLOC10START, 2
humanCHRLOC11END, 3
humanCHRLOC11START, 4
humanCHRLOC12END, 5
humanCHRLOC12START, 6
humanCHRLOC13END, 7
humanCHRLOC13START, 8
humanCHRLOC14END, 9
humanCHRLOC14START, 10
humanCHRLOC15END, 11
humanCHRLOC15START, 12
humanCHRLOC16END, 13
humanCHRLOC16START, 14
humanCHRLOC17END, 15
humanCHRLOC17START, 16
humanCHRLOC18END, 17
humanCHRLOC18START, 18
humanCHRLOC19END, 19
humanCHRLOC19START, 20
humanCHRLOC1END, 21
humanCHRLOC1START, 22
humanCHRLOC20END, 23
humanCHRLOC20START, 24
humanCHRLOC21END, 25
humanCHRLOC21START, 26
humanCHRLOC22END, 27
humanCHRLOC22START, 28
humanCHRLOC2END, 29
humanCHRLOC2START, 30
humanCHRLOC3END, 31
humanCHRLOC3START, 32
humanCHRLOC4END, 33
humanCHRLOC4START, 34
humanCHRLOC5END, 35
humanCHRLOC5START, 36
humanCHRLOC6END, 37
humanCHRLOC6START, 38
humanCHRLOC7END, 39
humanCHRLOC7START, 40
humanCHRLOC8END, 41

humanCHRLOC8START, 42
humanCHRLOC9END, 43
humanCHRLOC9START, 44
humanCHRLOCCYTOLOC, 45
humanCHRLOCENTREZID2CHR, 45
humanCHRLOCQC, 46
humanCHRLOCXEND, 46
humanCHRLOCXSTART, 47
humanCHRLOCYEND, 48
humanCHRLOCYSTART, 49

humanCHRLOC, 1
humanCHRLOC10END, 1
humanCHRLOC10START, 2
humanCHRLOC11END, 3
humanCHRLOC11START, 4
humanCHRLOC12END, 5
humanCHRLOC12START, 6
humanCHRLOC13END, 7
humanCHRLOC13START, 8
humanCHRLOC14END, 9
humanCHRLOC14START, 10
humanCHRLOC15END, 11
humanCHRLOC15START, 12
humanCHRLOC16END, 13
humanCHRLOC16START, 14
humanCHRLOC17END, 15
humanCHRLOC17START, 16
humanCHRLOC18END, 17
humanCHRLOC18START, 18
humanCHRLOC19END, 19
humanCHRLOC19START, 20
humanCHRLOC1END, 21
humanCHRLOC1START, 22
humanCHRLOC20END, 23
humanCHRLOC20START, 24
humanCHRLOC21END, 25
humanCHRLOC21START, 26
humanCHRLOC22END, 27
humanCHRLOC22START, 28
humanCHRLOC2END, 29
humanCHRLOC2START, 30
humanCHRLOC3END, 31
humanCHRLOC3START, 32

51

INDEX

52

humanCHRLOC4END, 33
humanCHRLOC4START, 34
humanCHRLOC5END, 35
humanCHRLOC5START, 36
humanCHRLOC6END, 37
humanCHRLOC6START, 38
humanCHRLOC7END, 39
humanCHRLOC7START, 40
humanCHRLOC8END, 41
humanCHRLOC8START, 42
humanCHRLOC9END, 43
humanCHRLOC9START, 44
humanCHRLOCCYTOLOC, 45
humanCHRLOCENTREZID2CHR, 45
humanCHRLOCLOCUSID2CHR

(humanCHRLOCENTREZID2CHR), 45

humanCHRLOCMAPCOUNTS (humanCHRLOCQC), 46
humanCHRLOCQC, 46
humanCHRLOCXEND, 46
humanCHRLOCXSTART, 47
humanCHRLOCYEND, 48
humanCHRLOCYSTART, 49

