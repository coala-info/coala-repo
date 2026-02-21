# erma: epigenomics road map adventures

Vincent J. Carey, stvjc at channing.harvard.edu

#### *August 2015*

# Contents

* [1 Introduction](#introduction)
* [2 Metadata on the ChromImpute archive](#metadata-on-the-chromimpute-archive)
  + [2.1 Sample metadata](#sample-metadata)
  + [2.2 Metadata on the inferred states](#metadata-on-the-inferred-states)
* [3 Managing access to imputed chromatin states for a set of cell types](#managing-access-to-imputed-chromatin-states-for-a-set-of-cell-types)
* [4 Enumerating states in the vicinity of a gene, across cell types](#enumerating-states-in-the-vicinity-of-a-gene-across-cell-types)

# 1 Introduction

The [epigenomics road map](http://www.roadmapepigenomics.org/)
describes locations of epigenetic
marks in DNA from a variety of cell types. Of interest are
locations of
histone modifications, sites of DNA methylation,
and regions of accessible chromatin.

This package presents a selection of elements of the road
map including metadata and outputs of the ChromImpute
procedure applied to ENCODE cell lines by [Ernst and Kellis](http://dx.doi.org/10.1038/nbt.3157).

# 2 Metadata on the ChromImpute archive

## 2.1 Sample metadata

I have retrieved a [Google Docs spreadsheet](https://docs.google.com/spreadsheet/ccc?key=0Am6FxqAtrFDwdHU1UC13ZUxKYy1XVEJPUzV6MEtQOXc&usp=sharing#gid=15)
with comprehensive information. The mapmeta() function provides
access to a local DataFrame image of the file as retrieved in mid April
2015. We provide a dynamic view of a selection of columns. Use
the search box to filter records shown, for example .

```
library(DT)
library(erma)
meta = mapmeta()
```

```
## NOTE: input data had non-ASCII characters replaced by ' '.
```

```
kpc = c("Comments", "Epigenome.ID..EID.", "Epigenome.Mnemonic", "Quality.Rating",
"Standardized.Epigenome.name", "ANATOMY", "TYPE")
datatable(as.data.frame(meta[,kpc]))
```

## 2.2 Metadata on the inferred states

The chromatin states and standard colorings
used are enumerated in `states_25`:

```
data(states_25)
datatable(states_25)
```

The emission parameters of the 25 state model are depicted
in the supplementary Figure 33 of Ernst and Kellis:

```
library(png)
im = readPNG(system.file("pngs/emparms.png", package="erma"))
grid.raster(im)
```

![](data:image/png;base64...)

# 3 Managing access to imputed chromatin states for a set of cell types

I have retrieved a modest number of roadmap bed files with ChromImpute
mnemonic labeling of chromatin by states. These can be
managed with an ErmaSet instance,
a trivial extension of *[GenomicFiles](https://bioconductor.org/packages/3.8/GenomicFiles)* class.
The `cellTypes` method yields a character vector. The `colData`
component has full metadata on the cell lines available.

```
ermaset = makeErmaSet()
```

```
## NOTE: input data had non-ASCII characters replaced by ' '.
```

```
ermaset
```

```
## ErmaSet object with 0 ranges and 31 files:
## files: E002_25_imputed12marks_mnemonics.bed.gz, E003_25_imputed12marks_mnemonics.bed.gz, ..., E088_25_imputed12marks_mnemonics.bed.gz, E096_25_imputed12marks_mnemonics.bed.gz
## detail: use files(), rowRanges(), colData(), ...
## cellTypes() for type names; data(short_celltype) for abbr.
```

```
cellTypes(ermaset)[1:5]
```

```
## [1] "ES-WA7 Cells"
## [2] "H1 Cells"
## [3] "iPS DF 6.9 Cells"
## [4] "Primary B cells from peripheral blood"
## [5] "Primary T cells from cord blood"
```

```
datatable(as.data.frame(colData(ermaset)[,kpc]))
```

# 4 Enumerating states in the vicinity of a gene, across cell types

We form a GRanges representing 50kb upstream of IL33.

```
uil33 = flank(resize(range(genemodel("IL33")), 1), width=50000)
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string

## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
uil33
```

```
## GRanges object with 1 range and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]     chr9 6165786-6215785      +
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

Bind this to the ErmaSet instance.

```
rowRanges(ermaset) = uil33
ermaset
```

```
## ErmaSet object with 1 ranges and 31 files:
## files: E002_25_imputed12marks_mnemonics.bed.gz, E003_25_imputed12marks_mnemonics.bed.gz, ..., E088_25_imputed12marks_mnemonics.bed.gz, E096_25_imputed12marks_mnemonics.bed.gz
## detail: use files(), rowRanges(), colData(), ...
## cellTypes() for type names; data(short_celltype) for abbr.
```

Now query the files for cell-specific states in this interval.

```
library(BiocParallel)
register(MulticoreParam(workers=2))
suppressWarnings({
csstates = lapply(reduceByFile(ermaset, MAP=function(range, file) {
imp = import(file, which=range, genome=genome(range)[1])
seqlevels(imp) = seqlevels(range)
imp$rgb = erma:::rgbByState(imp$name)
imp
}), "[[", 1)
})
tys = cellTypes(ermaset)  # need to label with cell types
csstates = lapply(1:length(csstates), function(x) {
csstates[[x]]$celltype = tys[x]
csstates[[x]]
})
csstates[1:2]
```

```
## [[1]]
## GRanges object with 15 ranges and 3 metadata columns:
##        seqnames          ranges strand |        name         rgb
##           <Rle>       <IRanges>  <Rle> | <character> <character>
##    [1]     chr9 6161801-6166600      * |    25_Quies     #FEFEFE
##    [2]     chr9 6166601-6166800      * |    17_EnhW2     #FEFE00
##    [3]     chr9 6166801-6171200      * |    25_Quies     #FEFEFE
##    [4]     chr9 6171201-6171800      * |    17_EnhW2     #FEFE00
##    [5]     chr9 6171801-6172000      * |    16_EnhW1     #FEFE00
##    ...      ...             ...    ... .         ...         ...
##   [11]     chr9 6183401-6197400      * |    25_Quies     #FEFEFE
##   [12]     chr9 6197401-6197600      * |    19_DNase     #FEFE66
##   [13]     chr9 6197601-6208800      * |    25_Quies     #FEFEFE
##   [14]     chr9 6208801-6211000      * |      21_Het     #8990CF
##   [15]     chr9 6211001-6217800      * |    25_Quies     #FEFEFE
##            celltype
##         <character>
##    [1] ES-WA7 Cells
##    [2] ES-WA7 Cells
##    [3] ES-WA7 Cells
##    [4] ES-WA7 Cells
##    [5] ES-WA7 Cells
##    ...          ...
##   [11] ES-WA7 Cells
##   [12] ES-WA7 Cells
##   [13] ES-WA7 Cells
##   [14] ES-WA7 Cells
##   [15] ES-WA7 Cells
##   -------
##   seqinfo: 1 sequence from hg19 genome
##
## [[2]]
## GRanges object with 14 ranges and 3 metadata columns:
##        seqnames          ranges strand |        name         rgb    celltype
##           <Rle>       <IRanges>  <Rle> | <character> <character> <character>
##    [1]     chr9 6161801-6166600      * |    25_Quies     #FEFEFE    H1 Cells
##    [2]     chr9 6166601-6166800      * |    17_EnhW2     #FEFE00    H1 Cells
##    [3]     chr9 6166801-6171200      * |    25_Quies     #FEFEFE    H1 Cells
##    [4]     chr9 6171201-6173000      * |    17_EnhW2     #FEFE00    H1 Cells
##    [5]     chr9 6173001-6175400      * |      21_Het     #8990CF    H1 Cells
##    ...      ...             ...    ... .         ...         ...         ...
##   [10]     chr9 6183401-6197400      * |    25_Quies     #FEFEFE    H1 Cells
##   [11]     chr9 6197401-6197600      * |    19_DNase     #FEFE66    H1 Cells
##   [12]     chr9 6197601-6209000      * |    25_Quies     #FEFEFE    H1 Cells
##   [13]     chr9 6209001-6211000      * |      21_Het     #8990CF    H1 Cells
##   [14]     chr9 6211001-6218200      * |    25_Quies     #FEFEFE    H1 Cells
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

This sort of code underlies
the `csProfile` utility to visualize variation in state assignments
in promoter regions for various genes.

```
csProfile(ermaset[,1:5], symbol="CD28", useShiny=FALSE)
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string

## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec =
## dec, : EOF within quoted string
```

```
## Scale for 'y' is already present. Adding another scale for 'y', which will
## replace the existing scale.
```

![](data:image/png;base64...)

Set `useShiny` to `TRUE` to permit interactive selection of
region to visualize.