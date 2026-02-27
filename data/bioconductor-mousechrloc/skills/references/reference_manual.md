mouseCHRLOC

February 25, 2026

mouseCHRLOC

Bioconductor annotation data package

Description

The annotation package was built using a downloadable R package - AnnBuilder (download and
build your own) from www.bioconductor.org using the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Mus_musculus/database/. Built: No build info available.

Thu Aug 30 09:55:54 2007

mouseCHRLOC

Y

The function mouseCHRLOC() provides information about the binary data files

mouseCHRLOC10END

An annotation data file for transciption ending location of genes on
chromosome 10

Description

mouseCHRLOC10END maps Entrez Gene identifiers to the transciption ending location of genes
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

mouseCHRLOC10START

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC10END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC10START

An annotation data file for transciption starting locations of genes on
chromosome 10

Description

mouseCHRLOC10START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

3

mouseCHRLOC11END

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC10START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC11END

An annotation data file for transciption ending location of genes on
chromosome 11

Description

mouseCHRLOC11END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC11END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

4

mouseCHRLOC11START

mouseCHRLOC11START

An annotation data file for transciption starting locations of genes on
chromosome 11

Description

mouseCHRLOC11START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC11START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC12END

5

mouseCHRLOC12END

An annotation data file for transciption ending location of genes on
chromosome 12

Description

mouseCHRLOC12END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC12END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

6

mouseCHRLOC12START

mouseCHRLOC12START

An annotation data file for transciption starting locations of genes on
chromosome 12

Description

mouseCHRLOC12START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC12START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC13END

7

mouseCHRLOC13END

An annotation data file for transciption ending location of genes on
chromosome 13

Description

mouseCHRLOC13END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC13END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

8

mouseCHRLOC13START

mouseCHRLOC13START

An annotation data file for transciption starting locations of genes on
chromosome 13

Description

mouseCHRLOC13START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC13START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC14END

9

mouseCHRLOC14END

An annotation data file for transciption ending location of genes on
chromosome 14

Description

mouseCHRLOC14END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC14END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

10

mouseCHRLOC14START

mouseCHRLOC14START

An annotation data file for transciption starting locations of genes on
chromosome 14

Description

mouseCHRLOC14START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC14START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC15END

11

mouseCHRLOC15END

An annotation data file for transciption ending location of genes on
chromosome 15

Description

mouseCHRLOC15END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC15END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

12

mouseCHRLOC15START

mouseCHRLOC15START

An annotation data file for transciption starting locations of genes on
chromosome 15

Description

mouseCHRLOC15START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC15START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC16END

13

mouseCHRLOC16END

An annotation data file for transciption ending location of genes on
chromosome 16

Description

mouseCHRLOC16END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC16END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

14

mouseCHRLOC16START

mouseCHRLOC16START

An annotation data file for transciption starting locations of genes on
chromosome 16

Description

mouseCHRLOC16START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC16START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC17END

15

mouseCHRLOC17END

An annotation data file for transciption ending location of genes on
chromosome 17

Description

mouseCHRLOC17END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC17END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

16

mouseCHRLOC17START

mouseCHRLOC17START

An annotation data file for transciption starting locations of genes on
chromosome 17

Description

mouseCHRLOC17START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC17START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC18END

17

mouseCHRLOC18END

An annotation data file for transciption ending location of genes on
chromosome 18

Description

mouseCHRLOC18END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC18END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

18

mouseCHRLOC18START

mouseCHRLOC18START

An annotation data file for transciption starting locations of genes on
chromosome 18

Description

mouseCHRLOC18START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC18START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC19END

19

mouseCHRLOC19END

An annotation data file for transciption ending location of genes on
chromosome 19

Description

mouseCHRLOC19END maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC19END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

20

mouseCHRLOC19START

mouseCHRLOC19START

An annotation data file for transciption starting locations of genes on
chromosome 19

Description

mouseCHRLOC19START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC19START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC1END

21

mouseCHRLOC1END

An annotation data file for transciption ending location of genes on
chromosome 1

Description

mouseCHRLOC1END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC1END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

22

mouseCHRLOC1START

mouseCHRLOC1START

An annotation data file for transciption starting locations of genes on
chromosome 1

Description

mouseCHRLOC1START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC1START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC2END

23

mouseCHRLOC2END

An annotation data file for transciption ending location of genes on
chromosome 2

Description

mouseCHRLOC2END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC2END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

24

mouseCHRLOC2START

mouseCHRLOC2START

An annotation data file for transciption starting locations of genes on
chromosome 2

Description

mouseCHRLOC2START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC2START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC3END

25

mouseCHRLOC3END

An annotation data file for transciption ending location of genes on
chromosome 3

Description

mouseCHRLOC3END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC3END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

26

mouseCHRLOC3START

mouseCHRLOC3START

An annotation data file for transciption starting locations of genes on
chromosome 3

Description

mouseCHRLOC3START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC3START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC4END

27

mouseCHRLOC4END

An annotation data file for transciption ending location of genes on
chromosome 4

Description

mouseCHRLOC4END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC4END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

28

mouseCHRLOC4START

mouseCHRLOC4START

An annotation data file for transciption starting locations of genes on
chromosome 4

Description

mouseCHRLOC4START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC4START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC5END

29

mouseCHRLOC5END

An annotation data file for transciption ending location of genes on
chromosome 5

Description

mouseCHRLOC5END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC5END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

30

mouseCHRLOC5START

mouseCHRLOC5START

An annotation data file for transciption starting locations of genes on
chromosome 5

Description

mouseCHRLOC5START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC5START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC6END

31

mouseCHRLOC6END

An annotation data file for transciption ending location of genes on
chromosome 6

Description

mouseCHRLOC6END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC6END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

32

mouseCHRLOC6START

mouseCHRLOC6START

An annotation data file for transciption starting locations of genes on
chromosome 6

Description

mouseCHRLOC6START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC6START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC7END

33

mouseCHRLOC7END

An annotation data file for transciption ending location of genes on
chromosome 7

Description

mouseCHRLOC7END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC7END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

34

mouseCHRLOC7START

mouseCHRLOC7START

An annotation data file for transciption starting locations of genes on
chromosome 7

Description

mouseCHRLOC7START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC7START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC8END

35

mouseCHRLOC8END

An annotation data file for transciption ending location of genes on
chromosome 8

Description

mouseCHRLOC8END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC8END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

36

mouseCHRLOC8START

mouseCHRLOC8START

An annotation data file for transciption starting locations of genes on
chromosome 8

Description

mouseCHRLOC8START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC8START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOC9END

37

mouseCHRLOC9END

An annotation data file for transciption ending location of genes on
chromosome 9

Description

mouseCHRLOC9END maps Entrez Gene identifiers to the transciption ending location of genes on
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC9END)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

38

mouseCHRLOC9START

mouseCHRLOC9START

An annotation data file for transciption starting locations of genes on
chromosome 9

Description

mouseCHRLOC9START maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOC9START)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOCCYTOLOC

39

mouseCHRLOCCYTOLOC

An annotation data file for Cytoband locations on chromosomes

Description

mouseCHRLOCCYTOLOC maps chromosome numbers and the locations of cytobands on chro-
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

Examples

bands <- as.list(mouseCHRLOCCYTOLOC)
# cytobands on chromosome number 1
names(bands[[1]])
# The start and end locations for one band on chromosome number 1
bands[[1]][[1]]

mouseCHRLOCENTREZID2CHR

An annotation data file that maps Entrez Gene identifiers to chromo-
some number

Description

mouseCHRLOCENTREZID2CHR maps Entrez Gene identifiers to the chromosome numbers the
genes represented by the Locuslink identifiers reside

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers
and values are the corresponding chromosome numbers the genes reside. Values are vectors of
length 1 or more depending on whether a give Entrez Gene identifier can be mapped to one or more
chromosomes.

Mappings were derived from data provided by:
Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

mouseCHRLOCXEND

40

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOCENTREZID2CHR)
if(length(xx) > 0){
# Get the value of the first Entrez Gene id
xx[1]
# Get the values for a few Entrez Gene identifiers
if(length(xx) >= 3){
xx[1:3]
}
}

mouseCHRLOCQC

Quality control information for mouseCHRLOC

Description

mouseCHRLOCQC is an R environment that provides quality control information for mouseCHRLOC

Details

This file contains quality control information that can be displayed by typing mouseCHRLOC()
after loading the package using library(mouseCHRLOC). The follow items are included:

Date built: Date when the package was built.

Number of probes: total number of probes included

Probe number missmatch: if the total number of probes of any of the data file is different from a
base file used to check the data files the name of the data file will be listed

Probe missmatch: if any of probes in a data file missmatched that of the base file, the name of the
data file will be listed

Mappings found for probe based files: number of mappings obtained for the total number of probes

Mappings found for non-probe based files: total number of mappings obtained

mouseCHRLOCXEND

An annotation data file for transciption ending location of genes on
chromosome X

Description

mouseCHRLOCXEND maps Entrez Gene identifiers to the transciption ending location of genes
on chromosome number X corresponding to the Entrez Gene identifiers

mouseCHRLOCXSTART

Details

41

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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOCXEND)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOCXSTART

An annotation data file for transciption starting locations of genes on
chromosome X

Description

mouseCHRLOCXSTART maps Entrez Gene identifiers to the transciption starting locations of
genes on chromosome number X corresponding to the Entrez Gene identifiers

Details

This is an environment object containing key and value pairs. Keys are Entrez Gene identifiers and
values are the transciption starting location for genes. The starting positions for genes on both the
sense and antisense strand are number of base pairs measured from the p (5’ end of the sense strand)
to q (3’ end of the sense strand) arms. Values for the antisense strand have a leading "-" sign (e. g.
-1234567).

Values for keys are named vectors derived from the smallest starting value found for the Entrez
Gene identifier. Names of chromosome location values can be "Confident" when the gene can

42

mouseCHRLOCYEND

be confidently placed on a chromosome and "Unconfident" otherwise (denoted by "\_random" in
UCSC data).

Mappings were derived from the following public data sources:

Golden Path:http://gopher6/compbio/annotationSourceData/hgdownload.cse.ucsc.edu/goldenPath/
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOCXSTART)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOCYEND

An annotation data file for transciption ending location of genes on
chromosome Y

Description

mouseCHRLOCYEND maps Entrez Gene identifiers to the transciption ending location of genes
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

mouseCHRLOCYSTART

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

43

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOCYEND)
if(length(xx) > 0){
# Get the value of the first key
xx[1]
# Get the values for a few keys
if(length(xx) >= 3){

xx[1:3]

}
}

mouseCHRLOCYSTART

An annotation data file for transciption starting locations of genes on
chromosome Y

Description

mouseCHRLOCYSTART maps Entrez Gene identifiers to the transciption starting locations of
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
currentGenomes//Mus_musculus/database/. Built: No build info available.

Package built: Thu Aug 30 09:55:54 2007

References

http://www.genome.ucsc.edu/goldenPath/hg16/database/

mouseCHRLOCYSTART

44

Examples

require("annotate") || stop("annotate unavailable")
xx <- as.list(mouseCHRLOCYSTART)
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

mouseCHRLOC, 1
mouseCHRLOC10END, 1
mouseCHRLOC10START, 2
mouseCHRLOC11END, 3
mouseCHRLOC11START, 4
mouseCHRLOC12END, 5
mouseCHRLOC12START, 6
mouseCHRLOC13END, 7
mouseCHRLOC13START, 8
mouseCHRLOC14END, 9
mouseCHRLOC14START, 10
mouseCHRLOC15END, 11
mouseCHRLOC15START, 12
mouseCHRLOC16END, 13
mouseCHRLOC16START, 14
mouseCHRLOC17END, 15
mouseCHRLOC17START, 16
mouseCHRLOC18END, 17
mouseCHRLOC18START, 18
mouseCHRLOC19END, 19
mouseCHRLOC19START, 20
mouseCHRLOC1END, 21
mouseCHRLOC1START, 22
mouseCHRLOC2END, 23
mouseCHRLOC2START, 24
mouseCHRLOC3END, 25
mouseCHRLOC3START, 26
mouseCHRLOC4END, 27
mouseCHRLOC4START, 28
mouseCHRLOC5END, 29
mouseCHRLOC5START, 30
mouseCHRLOC6END, 31
mouseCHRLOC6START, 32
mouseCHRLOC7END, 33
mouseCHRLOC7START, 34
mouseCHRLOC8END, 35
mouseCHRLOC8START, 36
mouseCHRLOC9END, 37
mouseCHRLOC9START, 38
mouseCHRLOCCYTOLOC, 39
mouseCHRLOCENTREZID2CHR, 39
mouseCHRLOCQC, 40

mouseCHRLOCXEND, 40
mouseCHRLOCXSTART, 41
mouseCHRLOCYEND, 42
mouseCHRLOCYSTART, 43

mouseCHRLOC, 1
mouseCHRLOC10END, 1
mouseCHRLOC10START, 2
mouseCHRLOC11END, 3
mouseCHRLOC11START, 4
mouseCHRLOC12END, 5
mouseCHRLOC12START, 6
mouseCHRLOC13END, 7
mouseCHRLOC13START, 8
mouseCHRLOC14END, 9
mouseCHRLOC14START, 10
mouseCHRLOC15END, 11
mouseCHRLOC15START, 12
mouseCHRLOC16END, 13
mouseCHRLOC16START, 14
mouseCHRLOC17END, 15
mouseCHRLOC17START, 16
mouseCHRLOC18END, 17
mouseCHRLOC18START, 18
mouseCHRLOC19END, 19
mouseCHRLOC19START, 20
mouseCHRLOC1END, 21
mouseCHRLOC1START, 22
mouseCHRLOC2END, 23
mouseCHRLOC2START, 24
mouseCHRLOC3END, 25
mouseCHRLOC3START, 26
mouseCHRLOC4END, 27
mouseCHRLOC4START, 28
mouseCHRLOC5END, 29
mouseCHRLOC5START, 30
mouseCHRLOC6END, 31
mouseCHRLOC6START, 32
mouseCHRLOC7END, 33
mouseCHRLOC7START, 34
mouseCHRLOC8END, 35
mouseCHRLOC8START, 36
mouseCHRLOC9END, 37
mouseCHRLOC9START, 38

45

46

INDEX

mouseCHRLOCCYTOLOC, 39
mouseCHRLOCENTREZID2CHR, 39
mouseCHRLOCLOCUSID2CHR

(mouseCHRLOCENTREZID2CHR), 39

mouseCHRLOCMAPCOUNTS (mouseCHRLOCQC), 40
mouseCHRLOCQC, 40
mouseCHRLOCXEND, 40
mouseCHRLOCXSTART, 41
mouseCHRLOCYEND, 42
mouseCHRLOCYSTART, 43

