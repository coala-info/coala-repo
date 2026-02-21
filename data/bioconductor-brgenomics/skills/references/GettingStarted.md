# Getting Started

#### 28 August 2020

#### Package

BRGenomics 1.0.3

# 1 Installation

As of Bioconductor 3.11 (release date April 28, 2020), BRGenomics can be
installed directly from Bioconductor:

```
# install.packages("BiocManager")
BiocManager::install("BRGenomics")
```

Alternatively, the latest development version can be installed from
[GitHub](https://github.com/mdeber/BRGenomics):

```
# install.packages("remotes")
remotes::install_github("mdeber/BRGenomics@R3")
```

*BRGenomics (and Bioconductor 3.11) require R version 4.0 (release April 24,
2020). Installing the `R3` branch, as shown above, is required to install under
R 3.x.*

If you install the development version from Github and you’re using Windows,
[Rtools for Windows](https://cran.rstudio.com/bin/windows/Rtools/) is required.

# 2 Parallel Processing

By default, many BRGenomics functions use multicore processing as implemented in
the `parallel` package. BRGenomics functions that can be parallelized always
contain the argument `ncores`. If not specified, the default is to use the
global option “mc.cores” (the same option used by the `parallel` package), or
2 if that option is not set.

If you wanted to change the global default to 4 cores, for example, you would
run `options(mc.cores = 4)` at the start of your R session. If you’re unsure
how many cores your processor has, run `parallel::detectCores()`.

While performance can be memory constrained in some cases (and thus actually
hampered by excessive parallelization), substantial performance benefits can be
achieved by maximizing parallelization.

However, parallel processing is not available on Windows. To maintain
compatibility, all code in this vignette as well as the example code in the
documentation is to use a single core, i.e. `ncores = 1`.

# 3 Included Datasets

BRGenomics ships with an example dataset of PRO-seq data from Drosophila
melanogaster111 Hojoong Kwak, Nicholas J. Fuda, Leighton J. Core, John T. Lis
(2013). Precise Maps of RNA Polymerase Reveal How Promoters Direct Initiation
and Pausing. *Science* **339**(6122): 950–953.
<https://doi.org/10.1126/science.1229386>. PRO-seq is a basepair-resolution
method that uses 3’-end sequencing of nascent RNA to map the locations of
actively engaged RNA polymerases.

To keep the dataset small, we’ve only included reads mapping to the fourth
chromosome222 Chromosome 4 in Drosophila, often referred to as the “dot”
chromosome, is very small and contains very few genes.

The included datasets can be accessed using the `data()` function:

```
library(BRGenomics)
```

```
data("PROseq")
PROseq
```

```
## GRanges object with 47380 ranges and 1 metadata column:
##           seqnames    ranges strand |     score
##              <Rle> <IRanges>  <Rle> | <integer>
##       [1]     chr4      1295      + |         1
##       [2]     chr4     41428      + |         1
##       [3]     chr4     42588      + |         1
##       [4]     chr4     42590      + |         2
##       [5]     chr4     42593      + |         5
##       ...      ...       ...    ... .       ...
##   [47376]     chr4   1307742      - |         1
##   [47377]     chr4   1316537      - |         1
##   [47378]     chr4   1318960      - |         1
##   [47379]     chr4   1319004      - |         1
##   [47380]     chr4   1319369      - |         1
##   -------
##   seqinfo: 7 sequences from an unspecified genome
```

Notice that the data is contained within a `GRanges` object. GRanges objects,
from the *[GenomicRanges](https://bioconductor.org/packages/3.11/GenomicRanges)* package, are very easy to work with, and
are supported by a plethora of useful functions and packages.

The structure of the data will be described later on (in section
*“Basepair-Resolution GRanges Objects”*). For now, we’ll just note that both
annotations (e.g. genelists) and data are contained using the same GRanges
class.

We’ve included an example genelist to accompany the PRO-seq data:

```
data("txs_dm6_chr4")
txs_dm6_chr4
```

```
## GRanges object with 339 ranges and 2 metadata columns:
##         seqnames          ranges strand |     tx_name     gene_id
##            <Rle>       <IRanges>  <Rle> | <character> <character>
##     [1]     chr4        879-5039      + | FBtr0346692 FBgn0267363
##     [2]     chr4     42774-43374      + | FBtr0344900 FBgn0266617
##     [3]     chr4     44774-46074      + | FBtr0340499 FBgn0265633
##     [4]     chr4     56497-60974      + | FBtr0333704 FBgn0264617
##     [5]     chr4     56497-63124      + | FBtr0333705 FBgn0264617
##     ...      ...             ...    ... .         ...         ...
##   [335]     chr4 1192419-1196848      - | FBtr0100543 FBgn0039924
##   [336]     chr4 1192419-1196848      - | FBtr0100544 FBgn0039924
##   [337]     chr4 1225089-1230713      - | FBtr0100406 FBgn0027101
##   [338]     chr4 1225737-1230713      - | FBtr0100402 FBgn0027101
##   [339]     chr4 1225737-1230713      - | FBtr0100404 FBgn0027101
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

The GRanges above contains all Flybase annotated transcripts from chromosome 4,
with no filtering of any kind.

# 4 Basic Operations on GRanges

For users who are unfamiliar with GRanges objects, this section demonstrates a
number of basic operations.

A quick summary of the general structure: Each element of a GRanges object is
called a “range”. As you can see above, each range consists of several
components: `seqnames`, `ranges`, and `strand`. These essential attributes are
all found to the left of the vertical divider above; everything to the right of
that divider is an optional, metadata attribute.

The core attributes can be accessed using the functions `seqnames()`,
`ranges()`, and `strand()`. All metadata can be accessed using `mcols()`, and
individual columns are accessible with the `$` operator. The only reserved
metadata column is the `score` column, which is just like any other metadata
column, except that users can use the `score()` function to assess it.

All of the above functions are both “getters” and “setters”, e.g. `strand(x)`
returns the strand information, and `strand(x) <- "+"` assigns it.

These and other operations are demonstrated below.

---

*To learn more about GRanges objects, including a general overview of their
components, see the useful vignette [*An Introduction to the GenomicRanges
Package*](https://bioconductor.org/packages/release/bioc/vignettes/GenomicRanges/inst/doc/GenomicRangesIntroduction.html).
Alternatively, see the archived materials from the 2018 Bioconductor workshop [*Solving Common Bioinformatic Challenges Using GenomicRanges*](https://bioconductor.github.io/BiocWorkshops/solving-common-bioinformatic-challenges-using-genomicranges.html).
Note that this package will implement and streamline a number of common
operations, but users should still have a basic familiarity with GRanges
objects.*

---

Get the length of the genelist:

```
length(txs_dm6_chr4)
```

```
## [1] 339
```

Select the 2nd transcript:

```
txs_dm6_chr4[2]
```

```
## GRanges object with 1 range and 2 metadata columns:
##       seqnames      ranges strand |     tx_name     gene_id
##          <Rle>   <IRanges>  <Rle> | <character> <character>
##   [1]     chr4 42774-43374      + | FBtr0344900 FBgn0266617
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Select 4 transcripts:

```
tx4 <- txs_dm6_chr4[c(1, 10, 200, 300)]
tx4
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4        879-5039      + | FBtr0346692 FBgn0267363
##   [2]     chr4    69326-110059      + | FBtr0308615 FBgn0085432
##   [3]     chr4   184225-193489      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1009895-1027101      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Get the lengths of the first 4 transcripts:

```
width(tx4)
```

```
## [1]  4161 40734  9265 17207
```

Get a dataframe of the metadata for the first 4 transcripts:

```
mcols(tx4)
```

```
## DataFrame with 4 rows and 2 columns
##       tx_name     gene_id
##   <character> <character>
## 1 FBtr0346692 FBgn0267363
## 2 FBtr0308615 FBgn0085432
## 3 FBtr0089150 FBgn0039890
## 4 FBtr0309865 FBgn0025741
```

Access a single metadata column for the first 4 transcripts:

```
mcols(tx4)[, 2]
```

```
## [1] "FBgn0267363" "FBgn0085432" "FBgn0039890" "FBgn0025741"
```

```
mcols(tx4)[, "gene_id"]
```

```
## [1] "FBgn0267363" "FBgn0085432" "FBgn0039890" "FBgn0025741"
```

```
tx4$gene_id
```

```
## [1] "FBgn0267363" "FBgn0085432" "FBgn0039890" "FBgn0025741"
```

```
tx4_names <- tx4$tx_name
tx4_names
```

```
## [1] "FBtr0346692" "FBtr0308615" "FBtr0089150" "FBtr0309865"
```

Get the first gene\_id (a metadata element):

```
tx4$gene_id[1]
```

```
## [1] "FBgn0267363"
```

Remove a metadata column:

```
mcols(tx4) <- mcols(tx4)[, -1]
tx4
```

```
## GRanges object with 4 ranges and 1 metadata column:
##       seqnames          ranges strand |           X
##          <Rle>       <IRanges>  <Rle> | <character>
##   [1]     chr4        879-5039      + | FBgn0267363
##   [2]     chr4    69326-110059      + | FBgn0085432
##   [3]     chr4   184225-193489      - | FBgn0039890
##   [4]     chr4 1009895-1027101      - | FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Rename metadata:

```
names(mcols(tx4)) <- "gene_id"
tx4
```

```
## GRanges object with 4 ranges and 1 metadata column:
##       seqnames          ranges strand |     gene_id
##          <Rle>       <IRanges>  <Rle> | <character>
##   [1]     chr4        879-5039      + | FBgn0267363
##   [2]     chr4    69326-110059      + | FBgn0085432
##   [3]     chr4   184225-193489      - | FBgn0039890
##   [4]     chr4 1009895-1027101      - | FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Add metadata; same as access methods (`mcols()[]`, `mcols()$`, or simply `$`):

```
tx4$tx_name <- tx4_names
tx4
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     gene_id     tx_name
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4        879-5039      + | FBgn0267363 FBtr0346692
##   [2]     chr4    69326-110059      + | FBgn0085432 FBtr0308615
##   [3]     chr4   184225-193489      - | FBgn0039890 FBtr0089150
##   [4]     chr4 1009895-1027101      - | FBgn0025741 FBtr0309865
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Modify metadata:

```
tx4$gene_id[1] <- "gene1"
tx4$tx_name <- 1:4
tx4
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     gene_id   tx_name
##          <Rle>       <IRanges>  <Rle> | <character> <integer>
##   [1]     chr4        879-5039      + |       gene1         1
##   [2]     chr4    69326-110059      + | FBgn0085432         2
##   [3]     chr4   184225-193489      - | FBgn0039890         3
##   [4]     chr4 1009895-1027101      - | FBgn0025741         4
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Get beginning of ranges (not strand specific):

```
start(tx4)
```

```
## [1]     879   69326  184225 1009895
```

Get beginning of ranges (strand specific):

```
tx4_tss <- resize(tx4, width = 1, fix = "start")
tx4_tss
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames    ranges strand |     gene_id   tx_name
##          <Rle> <IRanges>  <Rle> | <character> <integer>
##   [1]     chr4       879      + |       gene1         1
##   [2]     chr4     69326      + | FBgn0085432         2
##   [3]     chr4    193489      - | FBgn0039890         3
##   [4]     chr4   1027101      - | FBgn0025741         4
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

```
start(tx4_tss)
```

```
## [1]     879   69326  193489 1027101
```

Remove all metadata:

```
mcols(tx4) <- NULL
tx4
```

```
## GRanges object with 4 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]     chr4        879-5039      +
##   [2]     chr4    69326-110059      +
##   [3]     chr4   184225-193489      -
##   [4]     chr4 1009895-1027101      -
##   -------
##   seqinfo: 7 sequences from dm6 genome
```