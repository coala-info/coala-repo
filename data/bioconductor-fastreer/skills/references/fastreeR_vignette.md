# fastreeR Vignette

Anestis Gkanogiannis\*

\*anestis@gkanogiannis.com

#### 30 October 2025

#### Package

fastreeR 2.0.0

# Contents

* [1 About fastreeR](#about-fastreer)
* [2 Installation](#installation)
* [3 Preparation](#preparation)
  + [3.1 Allocate RAM and load required libraries](#allocate-ram-and-load-required-libraries)
  + [3.2 Download sample vcf file](#download-sample-vcf-file)
  + [3.3 Download sample fasta files](#download-sample-fasta-files)
* [4 Functions on vcf files](#functions-on-vcf-files)
  + [4.1 Sample Statistics](#sample-statistics)
  + [4.2 Calculate distances from vcf](#calculate-distances-from-vcf)
  + [4.3 Histogram of distances](#histogram-of-distances)
  + [4.4 Plot tree from `fastreeR::dist2tree`](#plot-tree-from-fastreerdist2tree)
  + [4.5 Bootstrapping example](#bootstrapping-example)
    - [4.5.1 Bootstrap support explained](#bootstrap-support-explained)
    - [4.5.2 Interpretation guidance](#interpretation-guidance)
    - [4.5.3 Bootstrap example (small, runnable)](#bootstrap-example-small-runnable)
    - [4.5.4 Optional: nicer plotting with ggtree](#optional-nicer-plotting-with-ggtree)
  + [4.6 Command-line examples](#command-line-examples)
  + [4.7 JVM / rJava troubleshooting tips](#jvm-rjava-troubleshooting-tips)
  + [4.8 Reproducibility note](#reproducibility-note)
  + [4.9 Plot tree from `stats::hclust`](#plot-tree-from-statshclust)
  + [4.10 Hierarchical Clustering](#hierarchical-clustering)
* [5 Functions on fasta files](#functions-on-fasta-files)
  + [5.1 Calculate distances from fasta](#calculate-distances-from-fasta)
  + [5.2 Histogram of distances](#histogram-of-distances-1)
  + [5.3 Plot tree from `fastreeR::dist2tree`](#plot-tree-from-fastreerdist2tree-1)
  + [5.4 Plot tree from `stats::hclust`](#plot-tree-from-statshclust-1)
* [6 Session Info](#session-info)

# 1 About fastreeR

The goal of fastreeR is to provide functions for calculating distance matrix,
building phylogenetic tree or performing hierarchical clustering
between samples, directly from a VCF or FASTA file.

# 2 Installation

To install `fastreeR` package:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("fastreeR")
```

# 3 Preparation

## 3.1 Allocate RAM and load required libraries

**No more GBs of RAM!** Only the distance matrix is kept in memory:

* `4 bytes x (#samples²) x #threads`
* Example: 1000 samples with 32 threads → **~128MB RAM**

**VCF caching is minimal:**
Only **2 VCF lines per thread** are pre-cached.

* In the simple diploid case (e.g., `0/1`, `1|0`), each genotype requires ~4 characters (8 bytes).
* For 1000 samples and 32 threads, this adds up to **~1MB RAM**.

JVM will need at least 64-128 MB in order to efficiently run.

**Total memory footprint: just a few hundred MB, even for large datasets.**

~~You should allocate minimum 10 bytes per sample per variant of RAM for the JVM.
The more RAM you allocate, the faster the execution will be (less pauses
for garbage collection).~~

In order to allocate RAM, a special parameter needs to be passed while JVM
initializes. JVM parameters can be passed by setting `java.parameters` option.
The `-Xmx` parameter, followed (without space) by an integer value and a
letter, is used to tell JVM what is the maximum amount of heap RAM that it can
use. The letter in the parameter (uppercase or lowercase), indicates RAM units.

For example, parameters `-Xmx1024m` or `-Xmx1024M` or `-Xmx1g` or `-Xmx1G`, all
allocate 1 Gigabyte or 1024 Megabytes of maximum RAM for JVM.

```
options(java.parameters="-Xmx1G")
unloadNamespace("fastreeR")
library(fastreeR)
library(utils)
library(ape)
library(stats)
library(grid)
library(BiocFileCache)
library(ggtree)
```

## 3.2 Download sample vcf file

We download, in a temporary location, a small vcf file
from 1K project, with around 150 samples and 100k variants (SNPs and INDELs).
We use `BiocFileCache` for this retrieval process
so that it is not repeated needlessly.
If for any reason we cannot download, we use the small sample vcf from
`fastreeR` package.

```
bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
tempVcfUrl <-
    paste0("https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/",
        "1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/",
        "supporting/related_samples/",
        "ALL.chrX.shapeit2_integrated_snvindels_v2a_related_samples_27022019.",
        "GRCh38.phased.vcf.gz")
tempVcf <- BiocFileCache::bfcquery(bfc,field = "rname", "tempVcf")$rpath[1]
if(is.na(tempVcf) || is.null(tempVcf)) {
    tryCatch(
    { tempVcf <- BiocFileCache::bfcadd(bfc,"tempVcf",fpath=tempVcfUrl)[[1]]
    },
    error=function(cond) {
        tempVcf <- system.file("extdata", "samples.vcf.gz", package="fastreeR")
    },
    warning=function(cond) {
        tempVcf <- system.file("extdata", "samples.vcf.gz", package="fastreeR")
    }
    )
}
if(!file.exists(tempVcf) ||  file.size(tempVcf) == 0L) {
    tempVcf <- system.file("extdata", "samples.vcf.gz", package="fastreeR")
}
```

## 3.3 Download sample fasta files

We download, in temporary location, some small bacterial genomes.
We use `BiocFileCache` for this retrieval process
so that it is not repeated needlessly.
If for any reason we cannot download, we use the small sample fasta from
`fastreeR` package.

```
tempFastasUrls <- c(
    #Mycobacterium liflandii
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Mycobacterium_liflandii/latest_assembly_versions/",
        "GCF_000026445.2_ASM2644v2/GCF_000026445.2_ASM2644v2_genomic.fna.gz"),
    #Pelobacter propionicus
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Pelobacter_propionicus/latest_assembly_versions/",
        "GCF_000015045.1_ASM1504v1/GCF_000015045.1_ASM1504v1_genomic.fna.gz"),
    #Rickettsia prowazekii
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Rickettsia_prowazekii/latest_assembly_versions/",
        "GCF_000022785.1_ASM2278v1/GCF_000022785.1_ASM2278v1_genomic.fna.gz"),
    #Salmonella enterica
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Salmonella_enterica/reference/",
        "GCF_000006945.2_ASM694v2/GCF_000006945.2_ASM694v2_genomic.fna.gz"),
    #Staphylococcus aureus
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Staphylococcus_aureus/reference/",
        "GCF_000013425.1_ASM1342v1/GCF_000013425.1_ASM1342v1_genomic.fna.gz")
)
tempFastas <- list()
for (i in seq(1,5)) {
    tempFastas[[i]] <- BiocFileCache::bfcquery(bfc,field = "rname",
                                                paste0("temp_fasta",i))$rpath[1]
    if(is.na(tempFastas[[i]])) {
        tryCatch(
        { tempFastas[[i]] <-
            BiocFileCache::bfcadd(bfc, paste0("temp_fasta",i),
                                                fpath=tempFastasUrls[i])[[1]]
        },
        error=function(cond) {
            tempFastas <- system.file("extdata", "samples.fasta.gz",
                                                        package="fastreeR")
            break
        },
        warning=function(cond) {
            tempFastas <- system.file("extdata", "samples.fasta.gz",
                                                        package="fastreeR")
            break
        }
        )
    }
    if(!file.exists(tempFastas[[i]])) {
        tempFastas <- system.file("extdata", "samples.fasta.gz",
                                                        package="fastreeR")
        break
    }
    if(file.size(tempFastas[[i]]) == 0L) {
        tempFastas <- system.file("extdata", "samples.fasta.gz",
                                                        package="fastreeR")
        break
    }
}
```

# 4 Functions on vcf files

## 4.1 Sample Statistics

```
myVcfIstats <- fastreeR::vcf2istats(inputFile = tempVcf)
plot(myVcfIstats[,7:9])
```

![Sample statistics from vcf file](data:image/png;base64...)

Figure 1: Sample statistics from vcf file

## 4.2 Calculate distances from vcf

The most time consuming process is calculating distances between samples.
Assign more processors in order to speed up this operation.

```
myVcfDist <- fastreeR::vcf2dist(inputFile = tempVcf, threads = 1)
```

## 4.3 Histogram of distances

```
graphics::hist(myVcfDist, breaks = 100, main=NULL,
                                xlab = "Distance", xlim = c(0,max(myVcfDist)))
```

![Histogram of distances from vcf file](data:image/png;base64...)

Figure 2: Histogram of distances from vcf file

We note two distinct groups of distances. One around of
distance value 0.05 and the second around distance value 0.065.

## 4.4 Plot tree from `fastreeR::dist2tree`

Notice that the generated tree is ultrametric.

```
myVcfTree <- fastreeR::dist2tree(inputDist = myVcfDist)
plot(ape::read.tree(text = myVcfTree), direction = "down", cex = 0.3)
ape::add.scale.bar()
ape::axisPhylo(side = 2)
```

![Tree from vcf with fastreeR](data:image/png;base64...)

Figure 3: Tree from vcf with fastreeR

Of course the same can be achieved directly from the vcf file,
without calculating distances.

```
myVcfTree <- fastreeR::vcf2tree(inputFile = tempVcf, threads = 1)
plot(ape::read.tree(text = myVcfTree), direction = "down", cex = 0.3)
ape::add.scale.bar()
ape::axisPhylo(side = 2)
```

![Tree from vcf with fastreeR](data:image/png;base64...)

Figure 4: Tree from vcf with fastreeR

As expected from the histogram of distances, two groups of samples also
emerge in the tree. The two branches, one at height around 0.055 and the second
around height 0.065, are clearly visible.

## 4.5 Bootstrapping example

You can request streaming bootstrap replicates directly from the VCF source
by setting the `bootstrap` parameter. The Java backend will perform the
requested number of replicates and encode bootstrap support values at internal
nodes in the returned Newick string. The following example shows how to call
`vcf2tree` with bootstrapping and how to inspect the node support values using
`ape`.

### 4.5.1 Bootstrap support explained

Setting the `bootstrap` parameter instructs the Java backend to resample
variants (SNP columns) and compute replicate trees. The per-node support is calculated as
the percentage of replicates that contain the same bipartition (standard
bootstrap). These support values are encoded in the Newick string returned by
`vcf2tree` and are accessible after parsing the Newick with
`ape::read.tree()` (they typically appear in `tree$node.label`).

### 4.5.2 Interpretation guidance

As a rule of thumb, interpret bootstrap values roughly as:

* more than 90% : strong support
* 70-89% : moderate support
* < 70% : weak support

These are heuristic guidelines and should be used with caution.

### 4.5.3 Bootstrap example (small, runnable)

The chunk below runs a modest number of replicates so it is safe for local
testing. For production use, increase `bt_reps` to 100-1000 as appropriate.

```
# Calculate a tree with a small number of bootstrap replicates (adjust as needed)
bt_reps <- 10
myBootTree <- fastreeR::vcf2tree(inputFile = tempVcf, threads = 1, bootstrap = bt_reps)

# Parse with ape and inspect bootstrap support (stored in node.label)
tr <- ape::read.tree(text = myBootTree)
# robust parse: remove anything but digits and dot, then as.numeric
raw_lbls <- tr$node.label
node_support <- if (!is.null(raw_lbls)) {
  # turn "", NA or non-numeric into NA
  s <- gsub("[^0-9.]", "", raw_lbls)
  s[s == ""] <- NA
  as.numeric(s)
} else {
  numeric(0)
}
print(head(tr$node.label))
#> [1] ""    "100" ""    ""    ""    ""
plot(tr, direction = "down", cex = 0.3)
if (length(node_support) > 0) {
  # round and show as integers, place without frames
  ape::nodelabels(text = round(node_support, 0),
                  cex = 0.7,
                  frame = "none",
                  adj = c(-0.2, 0.5))      # adjust to move labels slightly off-node

  # optional: color labels by support
  cols <- ifelse(node_support >= 90, "black",
                 ifelse(node_support >= 70, "orange", "red"))
  ape::nodelabels(text = round(node_support, 0), cex = 0.7, frame = "none", col = cols)

  # colour the branch behind each internal node
  bgcols <- ifelse(node_support >= 90, "lightgreen",
                   ifelse(node_support >= 70, "khaki", "lightpink"))
  ape::nodelabels(text = round(node_support, 0), cex = 0.7, frame = "circle", bg = bgcols, col = "black")
}
```

![Tree from vcf with fastreeR and bootstrap support (ape)](data:image/png;base64...)

Figure 5: Tree from vcf with fastreeR and bootstrap support (ape)

### 4.5.4 Optional: nicer plotting with ggtree

If you have `ggtree` installed, you can produce a more polished plot and
annotate node supports.

```
  # internal node numbers are Ntip+1 : Ntip+Nnode
  ntips <- ape::Ntip(tr)
  nints <- ape::Nnode(tr)
  internal_nodes <- (ntips + 1):(ntips + nints)

  df_nodes <- data.frame(node = internal_nodes, support = node_support)

  # Create categorical support classes for coloring and define colors
  df_nodes$category <- cut(df_nodes$support,
                           breaks = c(-Inf, 69, 89, Inf),
                           labels = c("weak", "moderate", "strong"))

  fills <- c(strong = "lightgreen", moderate = "khaki", weak = "lightpink")
  cols <- c(strong = "black", moderate = "orange", weak = "red")

  p <- ggtree(tr) + geom_tiplab(size = 2)

  # Attach node support data to the tree plotting data and add colored points + labels
  p <- p %<+% df_nodes +
      ggtree::geom_point2(aes(subset = !isTip, fill = category), shape = 21,
                          color = "black", size = 3, show.legend = FALSE) +
      ggtree::geom_text2(aes(subset = !isTip, label = round(support, 0)),
                          hjust = -0.2, size = 2, show.legend = FALSE) +
      scale_fill_manual(values = fills)

  print(p)
```

![Tree from vcf with fastreeR and bootstrap support (ggtree)](data:image/png;base64...)

Figure 6: Tree from vcf with fastreeR and bootstrap support (ggtree)

## 4.6 Command-line examples

Run from the Python CLI (local JVM memory allocation via `--mem`):

```
python fastreeR.py VCF2TREE -i input.vcf -o output_with_boot.nwk --threads 8 --bootstrap 100 --mem 1024
```

Or using Docker:

```
docker run --rm -v $(pwd):/data gkanogiannis/fastreer:latest \
    VCF2TREE -i /data/input.vcf -o /data/output_with_boot.nwk --threads 8 --bootstrap 100 --mem 1024
```

These commands produce a Newick tree file with bootstrap support values encoded
at internal nodes; parse it in R with `ape::read.tree()` to inspect `node.label`.

## 4.7 JVM / rJava troubleshooting tips

If you encounter `rJava` initialization errors or out-of-memory issues when
calling `vcf2tree()` from R, set the JVM heap before loading the package, for
example:

```
# set JVM max heap to 2GB before loading fastreeR
options(java.parameters = '-Xmx2G')
library(fastreeR)
```

Also ensure Java 11+ is installed and on your PATH. On Windows, point R to
the correct Java installation (matching 64/32-bit R) if needed.

## 4.8 Reproducibility note

Bootstrapping is stochastic. Results may vary
across runs and environments. You can also save and share the generated
Newick output for deterministic downstream analyses.

## 4.9 Plot tree from `stats::hclust`

For comparison, we generate a tree by using `stats` package and distances
calculated by `fastreeR`.

```
myVcfTreeStats <- stats::hclust(myVcfDist)
plot(myVcfTreeStats, ann = FALSE, cex = 0.3)
```

![Tree from vcf with stats::hclust](data:image/png;base64...)

Figure 7: Tree from vcf with stats::hclust

Although it does not initially look very similar, because it is not ultrametric,
it is indeed quite the same tree. We note again the two groups (two branches)
of samples and the 4 samples, possibly clones, that they show very close
distances between them.

## 4.10 Hierarchical Clustering

We can identify the two groups of samples, apparent from the hierarchical tree,
by using `dist2clusters`
or `vcf2clusters`
or `tree2clusters`.
By playing a little with the `cutHeight` parameter, we find that a
value of `cutHeight=0.067` cuts the tree into two branches.
The first group contains 106 samples and the second 44.

```
myVcfClust <- fastreeR::dist2clusters(inputDist = myVcfDist, cutHeight = 0.067)
#>  ..done.
if (length(myVcfClust) > 1) {
    tree <- myVcfClust[[1]]
    clusters <- myVcfClust[[2]]
    tree
    clusters
}
#> [1] "1 106 HG00124 HG00153 HG00247 HG00418 HG00427 HG00501 HG00512 HG00577 HG00578 HG00635 HG00702 HG00716 HG00733 HG00866 HG00983 HG01195 HG01274 HG01278 HG01322 HG01347 HG01452 HG01453 HG01473 HG01477 HG01480 HG01482 HG01483 HG01590 HG01983 HG01995 HG02024 HG02046 HG02218 HG02288 HG02344 HG02347 HG02363 HG02372 HG02377 HG02381 HG02387 HG02388 HG02524 HG02525 HG02781 HG03487 HG03606 HG03618 HG03621 HG03633 HG03639 HG03650 HG03656 HG03699 HG03700 HG03715 HG03723 HG03761 HG03794 HG03797 HG03799 HG03806 HG03811 HG03842 HG03845 HG03847 HG03901 HG03904 HG03929 HG03948 HG03972 HG03982 HG03988 HG04024 HG04037 HG04050 HG04053 HG04055 HG04058 HG04114 HG04127 HG04128 HG04132 HG04135 HG04147 HG04149 HG04150 HG04174 HG04191 HG04192 NA07346 NA11993 NA12891 NA12892 NA19660 NA19675 NA19685 NA19737 NA19797 NA19798 NA20336 NA20344 NA20526 NA20871 NA20893 NA20898"
#> [2] "2 44 HG02478 HG02762 HG02869 HG02964 HG02965 HG03033 HG03034 HG03076 HG03249 HG03250 HG03306 HG03307 HG03309 HG03312 HG03339 HG03361 HG03373 HG03383 HG03408 HG03454 HG03493 HG03508 HG03566 HG03569 HG03574 HG03582 NA18487 NA19150 NA19240 NA19311 NA19313 NA19373 NA19381 NA19382 NA19396 NA19444 NA19453 NA19469 NA19470 NA19985 NA20313 NA20322 NA20341 NA20361"
```

# 5 Functions on fasta files

Similar analysis we can perform when we have samples represented as
sequences in a fasta file.

## 5.1 Calculate distances from fasta

Use of the downloaded sample fasta file :

```
myFastaDist <- fastreeR::fasta2dist(tempFastas, kmer = 6)
```

Or use the provided by `fastreeR` fasta file of 48 bacterial RefSeq :

```
myFastaDist <- fastreeR::fasta2dist(
    system.file("extdata", "samples.fasta.gz", package="fastreeR"), kmer = 6)
```

## 5.2 Histogram of distances

```
graphics::hist(myFastaDist, breaks = 100, main=NULL,
                                xlab="Distance", xlim = c(0,max(myFastaDist)))
```

![Histogram of distances from fasta file](data:image/png;base64...)

Figure 8: Histogram of distances from fasta file

## 5.3 Plot tree from `fastreeR::dist2tree`

```
myFastaTree <- fastreeR::dist2tree(inputDist = myFastaDist)
plot(ape::read.tree(text = myFastaTree), direction = "down", cex = 0.3)
ape::add.scale.bar()
ape::axisPhylo(side = 2)
```

![Tree from fasta with fastreeR](data:image/png;base64...)

Figure 9: Tree from fasta with fastreeR

## 5.4 Plot tree from `stats::hclust`

```
myFastaTreeStats <- stats::hclust(myFastaDist)
plot(myFastaTreeStats, ann = FALSE, cex = 0.3)
```

![Tree from fasta with stats::hclust](data:image/png;base64...)

Figure 10: Tree from fasta with stats::hclust

# 6 Session Info

```
utils::sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
#>  [3] LC_TIME=en_GB                 LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
#>  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
#> [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] grid      stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] ggtree_4.0.1        BiocFileCache_3.0.0 dbplyr_2.5.1
#> [4] ape_5.8-1           fastreeR_2.0.0      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6            xfun_0.54               bslib_0.9.0
#>  [4] ggplot2_4.0.0           httr2_1.2.1             htmlwidgets_1.6.4
#>  [7] rJava_1.0-11            lattice_0.22-7          vctrs_0.6.5
#> [10] tools_4.5.1             generics_0.1.4          yulab.utils_0.2.1
#> [13] curl_7.0.0              parallel_4.5.1          tibble_3.3.0
#> [16] RSQLite_2.4.3           blob_1.2.4              R.oo_1.27.1
#> [19] pkgconfig_2.0.3         ggplotify_0.1.3         RColorBrewer_1.1-3
#> [22] S7_0.2.0                lifecycle_1.0.4         stringr_1.5.2
#> [25] compiler_4.5.1          farver_2.1.2            treeio_1.34.0
#> [28] tinytex_0.57            fontLiberation_0.1.0    fontquiver_0.2.1
#> [31] ggfun_0.2.0             htmltools_0.5.8.1       sass_0.4.10
#> [34] yaml_2.3.10             lazyeval_0.2.2          pillar_1.11.1
#> [37] jquerylib_0.1.4         tidyr_1.3.1             R.utils_2.13.0
#> [40] cachem_1.1.0            magick_2.9.0            fontBitstreamVera_0.1.1
#> [43] nlme_3.1-168            tidyselect_1.2.1        aplot_0.2.9
#> [46] digest_0.6.37           stringi_1.8.7           dplyr_1.1.4
#> [49] purrr_1.1.0             bookdown_0.45           labeling_0.4.3
#> [52] fastmap_1.2.0           cli_3.6.5               magrittr_2.0.4
#> [55] patchwork_1.3.2         dynamicTreeCut_1.63-1   dichromat_2.0-0.1
#> [58] withr_3.0.2             filelock_1.0.3          gdtools_0.4.4
#> [61] scales_1.4.0            rappdirs_0.3.3          bit64_4.6.0-1
#> [64] rmarkdown_2.30          bit_4.6.0               R.methodsS3_1.8.2
#> [67] memoise_2.0.1           evaluate_1.0.5          knitr_1.50
#> [70] gridGraphics_0.5-1      rlang_1.1.6             ggiraph_0.9.2
#> [73] Rcpp_1.1.0              glue_1.8.0              tidytree_0.4.6
#> [76] DBI_1.2.3               BiocManager_1.30.26     jsonlite_2.0.0
#> [79] R6_2.6.1                systemfonts_1.3.1       fs_1.6.6
```