# How to Assemble a chromLocation Object

Robert Gentleman and Rohit Satyam1

1Vignette translation from Sweave to Rmarkdown / HTML

#### 30 October, 2025

#### Package

geneplotter 1.88.0

In order to use the various `geneplotter` functions you will
need to assemble an object of class `chromLocation`.
This is relatively straightforward if you have access to a Bioconductor
data package. In this example we will consider using the
*[hu6800.db](https://bioconductor.org/packages/3.22/hu6800.db)* data package to construct our object. This vignette
was built with version 3.13.0 of
the package.

```
library("annotate")
library("hu6800.db")
lens <- unlist(eapply(hu6800CHR, length))
table(lens)
## lens
##    1    2
## 7122    7
wh2 = mget(names(lens)[lens==2], env = hu6800CHR)
wh2[1]
## $D49410_at
## [1] "X" "Y"
```

So somehow 7 of the genes are mapped to two
different chromosomes. Based on [OMIM](https://www.omim.org/) the these genes
are localized to the so called *pseudoautosomal region* where the X and Y
chromosomes are similar and there is actual recombination going on
between them. So, we will take the expedient measure of assigning each of them
to just one chromosome.

```
chrs2 <- unlist(eapply(hu6800CHR, function(x) x[1]))
chrs2 <- factor(chrs2)
length(chrs2)
## [1] 7129
table(unlist(chrs2))
##
##   1  10  11  12  13  14  15  16  17  18  19   2  20  21  22   3   4   5   6   7
## 613 224 366 377  97 204 164 245 391  92 365 407 139  78 148 336 246 266 371 273
##   8   9   X   Y
## 219 236 279  13
```

Now we are ready to obtain the chromosome location data and
orientation. The chromosome location data tells us the (approximate)
location of the gene on the chromosome. The positions for both the
sense and antisense strand are number of base pairs measured from the
`p` (5’ end of the sense strand) to `q` (3’ end of the sense strand) arms.
Chromosomes are double stranded and the gene is encoded on only one of
those two strands. The strands are labeled plus and minus (sense and
antisense). We use both the location and the orientation when making
plots.

```
strand <- as.list(hu6800CHRLOC)
splits <- split(strand, chrs2)
length(splits)
## [1] 24
names(splits)
##  [1] "1"  "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "2"  "20" "21" "22"
## [16] "3"  "4"  "5"  "6"  "7"  "8"  "9"  "X"  "Y"
```

Now we have processed the data and are ready to construct a new
`chromLocation` object.

```
 newChrClass <- buildChromLocation("hu6800")
```

And finally we can test it by calling `cPlot`.

```
library(geneplotter)
## Loading required package: lattice
## Reorder Chromosomes
newChrClass@chromLocs <- newChrClass@chromLocs[order(as.numeric(names(newChrClass@chromLocs)))]
## Warning in eval(quote(list(...)), env): NAs introduced by coercion
newChrClass@chromInfo <- newChrClass@chromInfo[order(as.numeric(names(newChrClass@chromInfo)))]
## Warning in eval(quote(list(...)), env): NAs introduced by coercion
cPlot(newChrClass,useChroms = as.character(c(names(splits),"X","Y","M")))
```

![](data:image/png;base64...)