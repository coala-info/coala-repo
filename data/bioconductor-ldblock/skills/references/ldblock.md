# ldblock package: linkage disequilibrium data structures

Vincent J. Carey, stvjc at channing.harvard.edu

#### February 2015

# Contents

* [1 Introduction](#introduction)
* [2 Import of HapMap LD data](#import-of-hapmap-ld-data)
* [3 A view of the block structure](#a-view-of-the-block-structure)
* [4 Collecting SNPs exhibiting linkage to selected SNP](#collecting-snps-exhibiting-linkage-to-selected-snp)

# 1 Introduction

There is a nice vignette in *[snpStats](https://bioconductor.org/packages/3.22/snpStats)* concerning
linkage disequilibrium (LD) analysis as supported by software
in that package.
The purpose of this package is to simplify handling of
existing population-level data on LD for the purpose
of flexibly defining LD blocks.

# 2 Import of HapMap LD data

The `hmld` function imports gzipped tabular data
from hapmap’s repository
.

```
suppressPackageStartupMessages({
 library(ldblock)
 library(GenomeInfoDb)
})
path = dir(system.file("hapmap", package="ldblock"), full=TRUE)
ceu17 = hmld(path, poptag="CEU", chrom="chr17")
```

```
## importing /tmp/RtmprIvCzR/Rinst1258d2c969aa1/ldblock/hapmap/ld_chr17_CEU.txt.gz
```

```
## done.
```

```
ceu17
```

```
## ldstruct for population CEU, chrom chr17
## dimensions: 36621 x 36621 ; statistic is Dprime
## object structure:
##       ldmat       chrom      genome      allpos      poptag   statInUse
## "dsCMatrix" "character" "character"   "numeric" "character" "character"
##       allrs
## "character"
```

# 3 A view of the block structure

For some reason knitr/render will not display this image nicely.

```
library(Matrix)
```

```
##
## Attaching package: 'Matrix'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
image(ceu17@ldmat[1:400,1:400],
   col.reg=heat.colors(120), colorkey=TRUE, useRaster=TRUE)
```

![](data:image/png;base64...)

This ignores physical distance and MAF. The bright stripes are
probably due to SNP with low MAF.

# 4 Collecting SNPs exhibiting linkage to selected SNP

We’ll use `ceu17` and the `gwascat` package to enumerate
SNP that are in LD with GWAS hits.

```
library(gwascat)
```

```
## gwascat loaded.  Use makeCurrentGwascat() to extract current image.
```

```
##  from EBI.  The data folder of this package has some legacy extracts.
```

```
load(system.file("legacy/ebicat37.rda", package="gwascat"))
#seqlevelsStyle(ebicat37) = "NCBI"  # noop?
seqlevels(ebicat37) = gsub("chr", "", seqlevels(ebicat37))
e17 = ebicat37[ which(as.character(seqnames(ebicat37)) == "17") ]
```

Some dbSNP names for GWAS hits on chr17 are

```
rsh17 = unique(e17$SNPS)
head(rsh17)
```

```
## [1] "rs11078895" "rs11891"    "rs7501939"  "rs9905704"  "rs4796793"
## [6] "rs78378222"
```

We will use `expandSnpSet` to obtain names for SNP
that were found in HapMap CEU to have which \(D' > .9\)
with any of these hits. These names are added to
the input set.

```
length(rsh17)
```

```
## [1] 530
```

```
exset = ldblock::expandSnpSet( rsh17, ldstruct= ceu17, lb=.9 )
```

```
## Warning in ldblock::expandSnpSet(rsh17, ldstruct = ceu17, lb = 0.9): dropping
## 149 rsn not matched in ld matrix
```

```
length(exset)
```

```
## [1] 13209
```

```
all(rsh17 %in% exset)
```

```
## [1] TRUE
```

Not all GWAS SNP are in the
HapMap LD resource. You can use your own LD data
as long as the format agrees with that of the HapMap distribution.