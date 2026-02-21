# An introduction to the GenomicScores package

Pau Puigdevall1 and Robert Castelo1\*

1Dept. of Medicine and Life Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*robert.castelo@upf.edu

#### 30 October 2025

#### Abstract

GenomicScores provides infrastructure to store and access genomewide position-specific scores within R and Bioconductor.

#### Package

GenomicScores 2.22.0

# 1 Getting started

*[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* is an R package distributed as part of the
Bioconductor project. To install the package, start R and enter:

```
install.packages("BiocManager")
BiocManager::install("GenomicScores")
```

Once *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* is installed, it can be loaded with the following command.

```
library(GenomicScores)
```

Often, however, *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* will be automatically loaded when
working with an annotation package that uses *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)*, such
as *[phastCons100way.UCSC.hg38](https://bioconductor.org/packages/3.22/phastCons100way.UCSC.hg38)*.

# 2 Genomewide position-specific scores

Genomewide scores assign each genomic position a numeric value denoting an
estimated measure of constraint or impact on variation at that position. They
are commonly used to filter single nucleotide variants or assess the degree of
constraint or functionality of genomic features. Genomic scores are built on
the basis of different sources of information such as sequence homology,
functional domains, physical-chemical changes of amino acid residues, etc.

One particular example of genomic scores are *phastCons scores*. They provide a
measure of conservation obtained from genomewide alignments using the program
[phast](http://compgen.cshl.edu/phast) (*Phylogenetic Analysis with Space/Time models*)
from Siepel et al. ([2005](#ref-siepel05)). The *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* package allows one to retrieve
these scores through annotation packages (Section
[4](#availability-and-retrieval-of-genomic-scores)) or as
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* resources (Section
[5](#genomic-scores-as-annotationhub-resources)).

Often, genomic scores such as phastCons are used within workflows running on
top of R and Bioconductor. The purpose of the *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)*
package is to enable an easy and interactive access to genomic scores within
those workflows.

# 3 Lossy storage of genomic scores with compressed vectors

Storing and accessing genomic scores within R is challenging when
their values cover large regions of the genome, resulting in gigabytes
of double-precision numbers. This is the case, for instance, for
phastCons (Siepel et al. [2005](#ref-siepel05)) or CADD (Kircher et al. [2014](#ref-kircher14)).

We address this problem by using *lossy compression*, also called
*quantization*, coupled with run-length encoding (Rle) vectors. Lossy
compression attempts to trade off precision for compression without
compromising the scientific integrity of the data (Zender [2016](#ref-zender16)).

Sometimes, measurements and statistical estimates under certain models
generate false precision. False precision is essentialy noise that wastes
storage space and it is meaningless from the scientific point of view
(Zender [2016](#ref-zender16)). In those circumstances, lossy compression not only saves storage
space, but also removes false precision.

The use of lossy compression leads to a subset of *quantized* values much
smaller than the original set of genomic scores, resulting in long runs of
identical values along the genome. These runs of identical values can be
further compressed using the implementation of Rle vectors available in the
*[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* Bioconductor package.

To enable a seamless access to genomic scores stored with quantized values
in compressed vectors the *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* defines the `GScores`
class of objects. This class manages the location, loading and dequantization
of genomic scores stored separately on each chromosome, while it also provides
rich metadata on the provenance, citation and licensing of the original data.

# 4 Availability and retrieval of genomic scores

The access to genomic scores through `GScores` objects is available either
through annotation packages or as *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* resources. To
find out what kind of genomic scores are available, through which mechanism,
and in which organism, we may use the function `availableGScores()`.

```
avgs <- availableGScores()
avgs
                                                 Organism      Category
AlphaMissense.v2023.hg19                     Homo sapiens Pathogenicity
AlphaMissense.v2023.hg38                     Homo sapiens Pathogenicity
MafDb.1Kgenomes.phase1.GRCh38                Homo sapiens           MAF
MafDb.1Kgenomes.phase1.hs37d5                Homo sapiens           MAF
MafDb.1Kgenomes.phase3.GRCh38                Homo sapiens           MAF
MafDb.1Kgenomes.phase3.hs37d5                Homo sapiens           MAF
MafDb.ExAC.r1.0.GRCh38                       Homo sapiens           MAF
MafDb.ExAC.r1.0.hs37d5                       Homo sapiens           MAF
MafDb.ExAC.r1.0.nonTCGA.GRCh38               Homo sapiens           MAF
MafDb.ExAC.r1.0.nonTCGA.hs37d5               Homo sapiens           MAF
MafDb.TOPMed.freeze5.hg19                    Homo sapiens           MAF
MafDb.TOPMed.freeze5.hg38                    Homo sapiens           MAF
MafDb.gnomAD.r2.1.GRCh38                     Homo sapiens           MAF
MafDb.gnomAD.r2.1.hs37d5                     Homo sapiens           MAF
MafDb.gnomADex.r2.1.GRCh38                   Homo sapiens           MAF
MafDb.gnomADex.r2.1.hs37d5                   Homo sapiens           MAF
MafH5.gnomAD.v4.0.GRCh38                     Homo sapiens           MAF
cadd.v1.3.hg19                                       <NA>          <NA>
cadd.v1.6.hg19                               Homo sapiens Pathogenicity
cadd.v1.6.hg38                               Homo sapiens Pathogenicity
fitCons.UCSC.hg19                            Homo sapiens    Constraint
linsight.UCSC.hg19                           Homo sapiens    Constraint
mcap.v1.0.hg19                               Homo sapiens Pathogenicity
phastCons100way.UCSC.hg19                    Homo sapiens  Conservation
phastCons100way.UCSC.hg38                    Homo sapiens  Conservation
phastCons27way.UCSC.dm6           Drosophila melanogaster  Conservation
phastCons30way.UCSC.hg38                     Homo sapiens  Conservation
phastCons35way.UCSC.mm39                     Mus musculus  Conservation
phastCons46wayPlacental.UCSC.hg19            Homo sapiens  Conservation
phastCons46wayPrimates.UCSC.hg19             Homo sapiens  Conservation
phastCons60way.UCSC.mm10                     Mus musculus  Conservation
phastCons7way.UCSC.hg38                      Homo sapiens  Conservation
phyloP100way.UCSC.hg19                       Homo sapiens  Conservation
phyloP100way.UCSC.hg38                       Homo sapiens  Conservation
phyloP35way.UCSC.mm39                        Mus musculus  Conservation
phyloP60way.UCSC.mm10                        Mus musculus  Conservation
                                  Installed Cached BiocManagerInstall
AlphaMissense.v2023.hg19              FALSE   TRUE              FALSE
AlphaMissense.v2023.hg38              FALSE   TRUE              FALSE
MafDb.1Kgenomes.phase1.GRCh38         FALSE  FALSE               TRUE
MafDb.1Kgenomes.phase1.hs37d5          TRUE  FALSE               TRUE
MafDb.1Kgenomes.phase3.GRCh38          TRUE  FALSE               TRUE
MafDb.1Kgenomes.phase3.hs37d5          TRUE  FALSE               TRUE
MafDb.ExAC.r1.0.GRCh38                FALSE  FALSE               TRUE
MafDb.ExAC.r1.0.hs37d5                 TRUE  FALSE               TRUE
MafDb.ExAC.r1.0.nonTCGA.GRCh38        FALSE  FALSE               TRUE
MafDb.ExAC.r1.0.nonTCGA.hs37d5        FALSE  FALSE               TRUE
MafDb.TOPMed.freeze5.hg19             FALSE  FALSE               TRUE
MafDb.TOPMed.freeze5.hg38             FALSE  FALSE               TRUE
MafDb.gnomAD.r2.1.GRCh38              FALSE  FALSE               TRUE
MafDb.gnomAD.r2.1.hs37d5              FALSE  FALSE               TRUE
MafDb.gnomADex.r2.1.GRCh38            FALSE  FALSE               TRUE
MafDb.gnomADex.r2.1.hs37d5             TRUE  FALSE               TRUE
MafH5.gnomAD.v4.0.GRCh38               TRUE  FALSE              FALSE
cadd.v1.3.hg19                        FALSE  FALSE              FALSE
cadd.v1.6.hg19                        FALSE   TRUE              FALSE
cadd.v1.6.hg38                        FALSE   TRUE              FALSE
fitCons.UCSC.hg19                     FALSE  FALSE               TRUE
linsight.UCSC.hg19                    FALSE  FALSE              FALSE
mcap.v1.0.hg19                        FALSE  FALSE              FALSE
phastCons100way.UCSC.hg19              TRUE  FALSE               TRUE
phastCons100way.UCSC.hg38              TRUE  FALSE               TRUE
phastCons27way.UCSC.dm6               FALSE  FALSE              FALSE
phastCons30way.UCSC.hg38              FALSE  FALSE              FALSE
phastCons35way.UCSC.mm39              FALSE  FALSE              FALSE
phastCons46wayPlacental.UCSC.hg19     FALSE  FALSE              FALSE
phastCons46wayPrimates.UCSC.hg19      FALSE  FALSE              FALSE
phastCons60way.UCSC.mm10              FALSE  FALSE              FALSE
phastCons7way.UCSC.hg38               FALSE  FALSE               TRUE
phyloP100way.UCSC.hg19                FALSE  FALSE              FALSE
phyloP100way.UCSC.hg38                FALSE  FALSE              FALSE
phyloP35way.UCSC.mm39                 FALSE  FALSE              FALSE
phyloP60way.UCSC.mm10                 FALSE  FALSE              FALSE
                                  AnnotationHub
AlphaMissense.v2023.hg19                   TRUE
AlphaMissense.v2023.hg38                   TRUE
MafDb.1Kgenomes.phase1.GRCh38             FALSE
MafDb.1Kgenomes.phase1.hs37d5             FALSE
MafDb.1Kgenomes.phase3.GRCh38             FALSE
MafDb.1Kgenomes.phase3.hs37d5             FALSE
MafDb.ExAC.r1.0.GRCh38                    FALSE
MafDb.ExAC.r1.0.hs37d5                    FALSE
MafDb.ExAC.r1.0.nonTCGA.GRCh38            FALSE
MafDb.ExAC.r1.0.nonTCGA.hs37d5            FALSE
MafDb.TOPMed.freeze5.hg19                 FALSE
MafDb.TOPMed.freeze5.hg38                 FALSE
MafDb.gnomAD.r2.1.GRCh38                  FALSE
MafDb.gnomAD.r2.1.hs37d5                  FALSE
MafDb.gnomADex.r2.1.GRCh38                FALSE
MafDb.gnomADex.r2.1.hs37d5                FALSE
MafH5.gnomAD.v4.0.GRCh38                  FALSE
cadd.v1.3.hg19                            FALSE
cadd.v1.6.hg19                             TRUE
cadd.v1.6.hg38                             TRUE
fitCons.UCSC.hg19                         FALSE
linsight.UCSC.hg19                        FALSE
mcap.v1.0.hg19                            FALSE
phastCons100way.UCSC.hg19                 FALSE
phastCons100way.UCSC.hg38                 FALSE
phastCons27way.UCSC.dm6                   FALSE
phastCons30way.UCSC.hg38                  FALSE
phastCons35way.UCSC.mm39                  FALSE
phastCons46wayPlacental.UCSC.hg19         FALSE
phastCons46wayPrimates.UCSC.hg19          FALSE
phastCons60way.UCSC.mm10                  FALSE
phastCons7way.UCSC.hg38                   FALSE
phyloP100way.UCSC.hg19                    FALSE
phyloP100way.UCSC.hg38                    FALSE
phyloP35way.UCSC.mm39                     FALSE
phyloP60way.UCSC.mm10                     FALSE
```

For example, if we want to use the phastCons conservation scores available
through the annotation package *[phastCons100way.UCSC.hg38](https://bioconductor.org/packages/3.22/phastCons100way.UCSC.hg38)*, we
should first install it (we only need to do this once).

```
BiocManager::install("phastCons100way.UCSC.hg38")
```

Second, we should load the package, and a `GScores` object will be created and
named after the package name, during the loading operation. It is often handy
to shorten that name.

```
library(phastCons100way.UCSC.hg38)
phast <- phastCons100way.UCSC.hg38
class(phast)
[1] "GScores"
attr(,"package")
[1] "GenomicScores"
```

Typing the name of the `GScores` object shows a summary of its contents and
some of its metadata.

```
phast
GScores object
# organism: Homo sapiens (UCSC, hg38)
# provider: UCSC
# provider version: 11May2015
# download date: Apr 10, 2018
# loaded sequences: chr5_GL000208v1_random
# number of sites: 2943 millions
# maximum abs. error: 0.05
# use 'citation()' to cite these data in publications
```

The bibliographic reference to cite the genomic score data stored in a `GScores`
object can be accessed using the `citation()` method either on the package name
(in case of annotation packages), or on the `GScores` object.

```
citation(phast)
Adam Siepel, Gill Berejano, Jakob S. Pedersen, Angie S. Hinrichs,
Minmei Hou, Kate Rosenbloom, Hiram Clawson, John Spieth, LaDeana W.
Hillier, Stephen Richards, George M. Weinstock, Richard K. Wilson,
Richard A. Gibbs, W. James Kent, Webb Miller, David Haussler (2005).
"Evolutionarily conserved elements in vertebrate, insect, worm, and
yeast genomes." _Genome Research_, *15*, 1034-1050.
doi:10.1101/gr.3715005 <https://doi.org/10.1101/gr.3715005>.
```

Other methods tracing provenance and other metadata are `provider()`,
`providerVersion()`, `organism()` and `seqlevelsStyle()`; please consult
the help page of the `GScores` class for a comprehensive list of available
methods.

```
provider(phast)
[1] "UCSC"
providerVersion(phast)
[1] "11May2015"
organism(phast)
[1] "Homo sapiens"
seqlevelsStyle(phast)
[1] "UCSC"
```

To retrieve genomic scores for specific consecutive positions we should use the
method `gscores()`, as follows.

```
gscores(phast, GRanges(seqnames="chr22",
                       IRanges(start=50528591:50528596, width=1)))
GRanges object with 6 ranges and 1 metadata column:
      seqnames    ranges strand |   default
         <Rle> <IRanges>  <Rle> | <numeric>
  [1]    chr22  50528591      * |       1.0
  [2]    chr22  50528592      * |       1.0
  [3]    chr22  50528593      * |       0.8
  [4]    chr22  50528594      * |       1.0
  [5]    chr22  50528595      * |       1.0
  [6]    chr22  50528596      * |       0.0
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
```

For a single position we may use this other `GRanges()` constructor.

```
gscores(phast, GRanges("chr22:50528593"))
GRanges object with 1 range and 1 metadata column:
      seqnames    ranges strand |   default
         <Rle> <IRanges>  <Rle> | <numeric>
  [1]    chr22  50528593      * |       0.8
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
```

We may also retrieve the score values only with the method `score()`.

```
score(phast, GRanges(seqnames="chr22",
                     IRanges(start=50528591:50528596, width=1)))
[1] 1.0 1.0 0.8 1.0 1.0 0.0
score(phast, GRanges("chr22:50528593"))
[1] 0.8
```

Let’s illustrate how to retrieve phastCons scores using data from the GWAS
catalog available through the Bioconductor package *[gwascat](https://bioconductor.org/packages/3.22/gwascat)*. For
the purpose of this vignette, we will filter the GWAS catalog data by (1)
discarding entries with `NA` values in either chromosome name or position, or
with multiple positions; (2) storing the data into a `GRanges` object, including
the GWAS catalog columns `STRONGEST SNP-RISK ALLELE` and `MAPPED_TRAIT`, and the
reference and alternate alleles, as metadata columns; (4) restricting variants
to those located in chromosomes 20 to 22; and (3) excluding variants with
multinucleotide alleles, or where reference and alternate alleles are identical.

```
library(BSgenome.Hsapiens.UCSC.hg38)
library(gwascat)

gwc <- get_cached_gwascat()
mask <- !is.na(gwc$CHR_ID) & !is.na(gwc$CHR_POS) &
        !is.na(as.integer(gwc$CHR_POS))
gwc <- gwc[mask, ]
grstr <- sprintf("%s:%s-%s", gwc$CHR_ID, gwc$CHR_POS, gwc$CHR_POS)
gwcgr <- GRanges(grstr, RISK_ALLELE=gwc[["STRONGEST SNP-RISK ALLELE"]],
                 MAPPED_TRAIT=gwc$MAPPED_TRAIT)
seqlevelsStyle(gwcgr) <- "UCSC"
mask <- seqnames(gwcgr) %in% c("chr20", "chr21", "chr22")
gwcgr <- gwcgr[mask]
ref <- as.character(getSeq(Hsapiens, gwcgr))
alt <- gsub("rs[0-9]+-", "", gwcgr$RISK_ALLELE)
mask <- (ref %in% c("A", "C", "G", "T")) & (alt %in% c("A", "C", "G", "T")) &
         nchar(alt) == 1 & ref != alt
gwcgr <- gwcgr[mask]
mcols(gwcgr)$REF <- ref[mask]
mcols(gwcgr)$ALT <- alt[mask]
```

```
gwcgr
GRanges object with 13540 ranges and 4 metadata columns:
          seqnames    ranges strand |   RISK_ALLELE           MAPPED_TRAIT
             <Rle> <IRanges>  <Rle> |   <character>            <character>
      [1]    chr20  35321981      * |   rs6088792-T            body height
      [2]    chr22  23250864      * |   rs5751614-A            body height
      [3]    chr20   6640246      * |    rs967417-C            body height
      [4]    chr20  33130847      * |   rs6059101-A     ulcerative colitis
      [5]    chr22  38148291      * |   rs2284063-G                  nevus
      ...      ...       ...    ... .           ...                    ...
  [13536]    chr20  12979237      * |   rs1321940-G sphingomyelin measur..
  [13537]    chr20  10148004      * |   rs2210584-C sphingomyelin measur..
  [13538]    chr20  11892294      * | rs397865364-C sphingomyelin measur..
  [13539]    chr20  12823511      * |   rs1413019-A sphingomyelin measur..
  [13540]    chr21  46284982      * |   rs9975588-A S100 calcium-binding..
                  REF         ALT
          <character> <character>
      [1]           C           T
      [2]           G           A
      [3]           G           C
      [4]           C           A
      [5]           A           G
      ...         ...         ...
  [13536]           A           G
  [13537]           T           C
  [13538]           T           C
  [13539]           C           A
  [13540]           G           A
  -------
  seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

Finally, let’s obtain the phastCons scores for this GWAS catalog variant set,
and examine their summary and cumulative distribution.

```
pcsco <- score(phast, gwcgr)
summary(pcsco)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
 0.0000  0.0000  0.0000  0.1217  0.0000  1.0000      38
round(cumsum(table(na.omit(pcsco))) / sum(!is.na(pcsco)), digits=2)
   0  0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9    1
0.81 0.85 0.87 0.88 0.88 0.89 0.89 0.90 0.90 0.91 1.00
```

We can observe that only 10% of the variants in chromosomes 20 to 22 have a
conservation phastCons score above 0.5. Let’s examine which traits have more
fully conserved variants.

```
xtab <- table(gwcgr$MAPPED_TRAIT[pcsco == 1])
head(xtab[order(xtab, decreasing=TRUE)])

                                     body height
                                              63
                        neuroimaging measurement
                                              34
                         mean corpuscular volume
                                              33
high density lipoprotein cholesterol measurement
                                              30
                          hemoglobin measurement
                                              26
                    BMI-adjusted waist-hip ratio
                                              23
```

# 5 Genomic scores as AnnotationHub resources

The *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (AH), is a Bioconductor web resource that
provides a central location where genomic files (e.g., VCF, bed, wig) and other
resources from standard (e.g., UCSC, Ensembl) and distributed sites, can be
found. An AH web resource creates and manages a local cache of files retrieved
by the user, helping with quick and reproducible access.

We can quickly check for the available AH resources by subsetting as follows
the resources names from the previous table obtained with `availableGScores()`.

```
rownames(avgs)[avgs$AnnotationHub]
[1] "AlphaMissense.v2023.hg19" "AlphaMissense.v2023.hg38"
[3] "cadd.v1.6.hg19"           "cadd.v1.6.hg38"
```

The selected resource can be downloaded with the function getGScores(). After
the resource is downloaded the first time, the cached copy will enable a quicker
retrieval later. Let’s download other conservation scores, the phyloP scores
(Pollard et al. [2010](#ref-pollard2010detection)), for human genome version hg38.

```
phylop <- getGScores("phyloP100way.UCSC.hg38")
```

```
phylop
GScores object
# organism: Homo sapiens (UCSC, hg38)
# provider: UCSC
# provider version: 11May2015
# download date: May 12, 2017
# loaded sequences: chr20
# maximum abs. error: 0.55
# use 'citation()' to cite these data in publications
```

Let’s retrieve the phyloP conservation scores for the previous set of GWAS
catalog variants and compare them in Figure @(fig:phastvsphylop).

```
ppsco <- score(phylop, gwcgr)
plot(pcsco, ppsco, xlab="phastCons", ylab="phyloP",
     cex.axis=1.2, cex.lab=1.5, las=1)
```

![Comparison between phastCons and phyloP conservation scores. On the y-axis, phyloP scores as function of phastCons scores on the x-axis, for a set of GWAS catalog variant in the human chromosome 22.](data:image/png;base64...)

Figure 1: Comparison between phastCons and phyloP conservation scores
On the y-axis, phyloP scores as function of phastCons scores on the x-axis, for a set of GWAS catalog variant in the human chromosome 22.

We may observe that the values match in a rather discrete manner due to the
quantization of the scores. In the case of the phastCons annotation package
*[phastCons100way.UCSC.hg38](https://bioconductor.org/packages/3.22/phastCons100way.UCSC.hg38)*, the `GScore` object gives access
in fact to two score populations, the default one in which conservation scores
are rounded to 1 decimal place, and an alternative one, named `DP2`, in which
they are rounded to 2 decimal places. To figure out what are the available
score populations in a `GScores` object, we should use the method
`populations()`.

```
populations(phast)
[1] "default" "DP2"
```

Whenever one of these populations is called `default`, this is the one used
by default. In other cases we can find out which is the default population as
follows:

```
defaultPopulation(phast)
[1] "default"
```

To use one of the available score populations we should use the argument `pop`
in the corresponding method, as follows.

```
pcsco2 <- score(phast, gwcgr, pop="DP2")
head(pcsco2)
[1] 0.00 0.00 0.00 0.14 0.00 0.00
```

Figure [2](#fig:phastvsphylop2) below shows again the comparison of phastCons
and phyloP conservation scores, this time at the higher resolution provided by
the phastCons scores rounded at two decimal places.

```
plot(pcsco2, ppsco, xlab="phastCons", ylab="phyloP",
     cex.axis=1.2, cex.lab=1.5, las=1)
```

![Comparison between phastCons and phyloP conservation scores at a higher resolution. On the y-axis, phyloP scores as function of phastCons scores on the x-axis, for a set of GWAS catalog variant in the human chromosome 22.](data:image/png;base64...)

Figure 2: Comparison between phastCons and phyloP conservation scores at a higher resolution
On the y-axis, phyloP scores as function of phastCons scores on the x-axis, for a set of GWAS catalog variant in the human chromosome 22.

## 5.1 Building an annotation package from a GScores object

Retrieving genomic scores through `AnnotationHub` resources requires an internet
connection and we may want to work with such resources offline, for instance in
high-performance computing (HPC) environments. For that purpose, we can create
ourselves an annotation package, such as
[phastCons100way.UCSC.hg38](https://bioconductor.org/packages/phastCons100way.UCSC.hg38),
from a `GScores` object corresponding to a downloaded `AnnotationHub` resource.
To do that we use the function `makeGScoresPackage()` as follows:

```
makeGScoresPackage(phast, maintainer="Me <me@example.com>",
                   author="Me", version="1.0.0")
```

```
Creating package in ./phastCons100way.UCSC.hg38
```

An argument, `destDir`, which by default points to the current working
directory, can be used to change where in the filesystem the package is created.
Afterwards, we should still build and install the package via, e.g.,
`R CMD build` and `R CMD INSTALL`, to be able to use it offline.

# 6 Retrieval of minor allele frequency data

One particular type of genomic scores that are accessible through
the `GScores` class is minor allele frequency (MAF) data.
There are currently 15 annotation packages that store MAF values
using the *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* package, named using the
prefix `MafDb` or `MafH5`; see Table [1](#tab:tableMafDb) below.

Table 1: Bioconductor annotation packages storing MAF data.

| Annotation Package | Description |
| --- | --- |
| *[MafDb.1Kgenomes.phase1.hs37d5](https://bioconductor.org/packages/3.22/MafDb.1Kgenomes.phase1.hs37d5)* | MAF data from the 1000 Genomes Project Phase 1 for the human genome version GRCh37. |
| *[MafDb.1Kgenomes.phase1.GRCh38](https://bioconductor.org/packages/3.22/MafDb.1Kgenomes.phase1.GRCh38)* | MAF data from the 1000 Genomes Project Phase 1 for the human genome version GRCh38. |
| *[MafDb.1Kgenomes.phase3.hs37d5](https://bioconductor.org/packages/3.22/MafDb.1Kgenomes.phase3.hs37d5)* | MAF data from the 1000 Genomes Project Phase 3 for the human genome version GRCh37. |
| *[MafDb.1Kgenomes.phase3.GRCh38](https://bioconductor.org/packages/3.22/MafDb.1Kgenomes.phase3.GRCh38)* | MAF data from the 1000 Genomes Project Phase 3 for the human genome version GRCh38. |
| *[MafDb.ExAC.r1.0.hs37d5](https://bioconductor.org/packages/3.22/MafDb.ExAC.r1.0.hs37d5)* | MAF data from ExAC 60706 exomes for the human genome version GRCh37. |
| *[MafDb.ExAC.r1.0.GRCh38](https://bioconductor.org/packages/3.22/MafDb.ExAC.r1.0.GRCh38)* | MAF data from ExAC 60706 exomes for the human genome version GRCh38. |
| *[MafDb.ExAC.r1.0.nonTCGA.hs37d5](https://bioconductor.org/packages/3.22/MafDb.ExAC.r1.0.nonTCGA.hs37d5)* | MAF data from ExAC 53105 nonTCGA exomes for the human genome version GRCh37. |
| *[MafDb.ExAC.r1.0.nonTCGA.GRCh38](https://bioconductor.org/packages/3.22/MafDb.ExAC.r1.0.nonTCGA.GRCh38)* | MAF data from ExAC 53105 nonTCGA exomes for the human genome version GRCh38. |
| *[MafDb.gnomAD.r2.1.hs37d5](https://bioconductor.org/packages/3.22/MafDb.gnomAD.r2.1.hs37d5)* | MAF data from gnomAD 15496 genomes for the human genome version GRCh37. |
| *[MafDb.gnomAD.r2.1.GRCh38](https://bioconductor.org/packages/3.22/MafDb.gnomAD.r2.1.GRCh38)* | MAF data from gnomAD 15496 genomes for the human genome version GRCh38. |
| *[MafDb.gnomADex.r2.1.hs37d5](https://bioconductor.org/packages/3.22/MafDb.gnomADex.r2.1.hs37d5)* | MAF data from gnomADex 123136 exomes for the human genome version GRCh37. |
| *[MafDb.gnomADex.r2.1.GRCh38](https://bioconductor.org/packages/3.22/MafDb.gnomADex.r2.1.GRCh38)* | MAF data from gnomADex 123136 exomes for the human genome version GRCh38. |
| *[MafH5.gnomAD.v4.0.GRCh38](https://bioconductor.org/packages/3.22/MafH5.gnomAD.v4.0.GRCh38)* | MAF data from gnomAD 76156 genomes for the human genome version GRCh38. |
| *[MafDb.TOPMed.freeze5.hg19](https://bioconductor.org/packages/3.22/MafDb.TOPMed.freeze5.hg19)* | MAF data from NHLBI TOPMed 62784 genomes for the human genome version GRCh37. |
| *[MafDb.TOPMed.freeze5.hg38](https://bioconductor.org/packages/3.22/MafDb.TOPMed.freeze5.hg38)* | MAF data from NHLBI TOPMed 62784 genomes for the human genome version GRCh38. |

In this type of package, the scores populations correspond to populations of
individuals from which the MAF data were derived, and all MAF data were
compressed using a precision of one significant figure for MAF < 0.1 and two
significant figures for MAF >= 0.1. Let’s load the MAF package for the
release v4.0 of gnomAD (Chen et al. [2024](#ref-chen2024genomic)).

```
library(MafH5.gnomAD.v4.0.GRCh38)

mafh5 <- MafH5.gnomAD.v4.0.GRCh38
mafh5
GScores object
# organism: Homo sapiens (UCSC, hg38)
# provider: BroadInstitute
# provider version: v4.0
# download date: Feb 19, 2024
# default scores population: AF
# number of sites: 639 millions
# maximum abs. error (def. pop.): 0.00251
# use 'citation()' to cite these data in publications

populations(mafh5)
[1] "AF"           "AF_allpopmax"
```

Let’s retrieve the gnomAD MAF values for the previous GWAS catalog variant set
and examine its distribution, and how many variants occur in less than 1% of
all gnomAD populations and what fraction do they represent among the analyzed
variants.

```
mafs <- score(mafh5, gwcgr, pop="AF_allpopmax")
summary(mafs)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
0.00001 0.19000 0.39000 0.32483 0.47000 0.50000     414
sum(mafs < 0.01, na.rm=TRUE)
[1] 352
sum(mafs < 0.01, na.rm=TRUE) / sum(!is.na(mafs))
[1] 0.026817
```

Finally, let’s examine which traits have more such rare variants.

```
xtab <- table(gwcgr$MAPPED_TRAIT[mafs < 0.01])
head(xtab[order(xtab, decreasing=TRUE)])

           response to bronchodilator, FEV/FEC ratio
                                                  18
                             mean corpuscular volume
                                                  15
               platelet component distribution width
                                                  13
                                      monocyte count
                                                  10
                                       platelet crit
                                                  10
forced expiratory volume, response to bronchodilator
                                                   8
```

# 7 Retrieval of multiple scores per genomic position

Among the score sets available as
[AnnotationHub](https://bioconductor.org/packages/AnnotationHub)
web resources shown in the previous section, some of them, such as CADD
(Kircher et al. [2014](#ref-kircher14)), M-CAP (Jagadeesh et al. [2016](#ref-jagadeesh16)) or AlphaMissense (Cheng et al. [2023](#ref-cheng2023accurate)),
provide multiple scores per genomic position that capture the tolerance to
mutations of single nucleotides. Such type of scores, often used to establish
the potential pathogenicity of variants, are sometimes released under some sort
of license for a non-commercial use. In such cases, the function `getGScores()`
will ask us interactively to accept the license. We can also set the argument
`accept.license=TRUE` to accept it non-interactively. We will illustrate such
a case using the AlphaMissense scores (Cheng et al. [2023](#ref-cheng2023accurate)).

```
am23 <- getGScores("AlphaMissense.v2023.hg38")
These data is shared under the license CC BY-NC-SA 4.0
(see https://creativecommons.org/licenses/by-nc-sa/4.0),
do you accept it? [y/n]: y
```

Let’s retrieve the AlphaMissense scores for the reference and
alternate alleles in our GWAS catalog variant set.

```
am23
GScores object
# organism: Homo sapiens (UCSC, hg38)
# provider: Google DeepMind
# provider version: v2023
# download date: Oct 10, 2023
# loaded sequences: chr20
# maximum abs. error: 0.005
# license: CC BY-NC-SA 4.0, see https://creativecommons.org/licenses/by-nc-sa/4.0
# use 'citation()' to cite these data in publications
amsco <- score(am23, gwcgr, ref=gwcgr$REF, alt=gwcgr$ALT)
summary(amsco)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
 0.0100  0.0900  0.1500  0.2472  0.3800  1.0000   12609
```

Using the cutoffs for AlphaMissense scores reported in (Cheng et al. [2023](#ref-cheng2023accurate)) to
classify variants into “likely benign”, “ambiguous” and “likely pathogenic”,
and 0.01 and 0.1 as MAF cutoffs, let’s cross-tabulate the proportions of these
two factors.

```
mask <- !is.na(amsco) & !is.na(mafs)
amscofac <- cut(amsco[mask], breaks=c(0, 0.34, 0.56, 1))
amscofac <- relevel(amscofac, ref="(0.56,1]")
maffac <- cut(mafs[mask], breaks=c(0, 0.01, 0.1, 1))
xtab <- table(maffac, amscofac)
t(xtab)
             maffac
amscofac      (0,0.01] (0.01,0.1] (0.1,1]
  (0.56,1]          39         11       7
  (0,0.34]          50        141     494
  (0.34,0.56]        3        134      39
xtab <- t(xtab / rowSums(xtab))
round(xtab, digits=2)
             maffac
amscofac      (0,0.01] (0.01,0.1] (0.1,1]
  (0.56,1]        0.42       0.04    0.01
  (0,0.34]        0.54       0.49    0.91
  (0.34,0.56]     0.03       0.47    0.07
```

Figure [3](#fig:ChengEtAl2024Fig5b) below displays graphically these
proportions in an analogous way to the one shown in Figure 5B from
Cheng et al. ([2023](#ref-cheng2023accurate)). While these proportions are quite different to the
original figure, due to the much lower number of variants analyzed here,
we still can see, like in (Cheng et al. [2023](#ref-cheng2023accurate)), that the proportion of
variants classified as *likely pathogenic* by AlphaMissense scores is much
larger for rare variants with MAF < 0.01 than for common variants with
MAF > 0.01.

![AlphaMissense predictions. Proportions of three ranges of AlphaMissense pathogenicity scores for three ranges of minor allele frequencies (MAF) derived from gnomAD, on data from the GWAS catalog. This figure is analogous to Figure 5B from @cheng2023accurate, but with much fewer variants.](data:image/png;base64...)

Figure 3: AlphaMissense predictions
Proportions of three ranges of AlphaMissense pathogenicity scores for three ranges of minor allele frequencies (MAF) derived from gnomAD, on data from the GWAS catalog. This figure is analogous to Figure 5B from Cheng et al. ([2023](#ref-cheng2023accurate)), but with much fewer variants.

# 8 Summarization of genomic scores

The input genomic ranges to the `gscores()` method may have widths larger than one
nucleotide. In those cases, and when there is only one score per position, the
`gscores()` method calculates, by default, the arithmetic mean of the scores across
each range.

```
gr1 <- GRanges(seqnames="chr22", IRanges(start=50528591:50528596, width=1))
gr1sco <- gscores(phast, gr1)
gr1sco
GRanges object with 6 ranges and 1 metadata column:
      seqnames    ranges strand |   default
         <Rle> <IRanges>  <Rle> | <numeric>
  [1]    chr22  50528591      * |       1.0
  [2]    chr22  50528592      * |       1.0
  [3]    chr22  50528593      * |       0.8
  [4]    chr22  50528594      * |       1.0
  [5]    chr22  50528595      * |       1.0
  [6]    chr22  50528596      * |       0.0
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
mean(gr1sco$default)
[1] 0.8
gr2 <- GRanges("chr22:50528591-50528596")
gscores(phast, gr2)
GRanges object with 1 range and 1 metadata column:
      seqnames            ranges strand |   default
         <Rle>         <IRanges>  <Rle> | <numeric>
  [1]    chr22 50528591-50528596      * |       0.8
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
```

However, we may change the way in which scores from multiple-nucleotide ranges are
summarized with the argument `summaryFun`, as follows.

```
gscores(phast, gr2, summaryFun=max)
GRanges object with 1 range and 1 metadata column:
      seqnames            ranges strand |   default
         <Rle>         <IRanges>  <Rle> | <numeric>
  [1]    chr22 50528591-50528596      * |         1
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
gscores(phast, gr2, summaryFun=min)
GRanges object with 1 range and 1 metadata column:
      seqnames            ranges strand |   default
         <Rle>         <IRanges>  <Rle> | <numeric>
  [1]    chr22 50528591-50528596      * |         0
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
gscores(phast, gr2, summaryFun=median)
GRanges object with 1 range and 1 metadata column:
      seqnames            ranges strand |   default
         <Rle>         <IRanges>  <Rle> | <numeric>
  [1]    chr22 50528591-50528596      * |         1
  -------
  seqinfo: 455 sequences (1 circular) from Genome Reference Consortium GRCh38 genome
```

# 9 Annotating variants with genomic scores

A typical use case of the *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* package is in the context
of annotating variants with genomic scores, such as phastCons conservation
scores. For this purpose, we load the *[VariantAnnotaiton](https://bioconductor.org/packages/3.22/VariantAnnotaiton)* and
*[TxDb.Hsapiens.UCSC.hg38.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg38.knownGene)* packages. The former will allow
us annotate variants, and the latter contains the gene annotations from UCSC
that will be used in this process.

```
library(VariantAnnotation)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
```

We annotate the location of previous set of filtered GWAS variants, using the
function `locateVariants()` from the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package.

```
loc <- locateVariants(gwcgr, txdb, AllVariants())
loc[1:3]
GRanges object with 3 ranges and 9 metadata columns:
      seqnames    ranges strand | LOCATION  LOCSTART    LOCEND   QUERYID
         <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <integer>
  [1]    chr20  35321981      - |   intron     89687     89687         1
  [2]    chr20  35321981      - |   intron     25183     25183         1
  [3]    chr22  23250864      + |   intron     70864     70864         2
             TXID         CDSID      GENEID       PRECEDEID        FOLLOWID
      <character> <IntegerList> <character> <CharacterList> <CharacterList>
  [1]      330259                     80323
  [2]      330272                 101927229
  [3]      338791                      2217
  -------
  seqinfo: 24 sequences from an unspecified genome; no seqlengths
table(loc$LOCATION)

spliceSite     intron    fiveUTR   threeUTR     coding intergenic   promoter
        48      68361        436       1499       5404       3235       8014
```

Now we annotate phastCons conservation scores on the variants and store
those annotations as an additional metadata column of the `GRanges` object.
For this specific purpose we should use the method `score()` that returns
the genomic scores as a numeric vector, instead of doing it as a metadata
column in the input ranges object, done by the `gscores()` function.

```
loc$PHASTCONS <- score(phast, loc, pop="DP2")
loc[1:3]
GRanges object with 3 ranges and 10 metadata columns:
      seqnames    ranges strand | LOCATION  LOCSTART    LOCEND   QUERYID
         <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <integer>
  [1]    chr20  35321981      - |   intron     89687     89687         1
  [2]    chr20  35321981      - |   intron     25183     25183         1
  [3]    chr22  23250864      + |   intron     70864     70864         2
             TXID         CDSID      GENEID       PRECEDEID        FOLLOWID
      <character> <IntegerList> <character> <CharacterList> <CharacterList>
  [1]      330259                     80323
  [2]      330272                 101927229
  [3]      338791                      2217
      PHASTCONS
      <numeric>
  [1]         0
  [2]         0
  [3]         0
  -------
  seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

Using the following code we can examine the distribution of phastCons
conservation scores of variants across the different annotated regions,
shown in Figure [4](#fig:plot1).

```
x <- split(loc$PHASTCONS, loc$LOCATION)
mask <- elementNROWS(x) > 0
boxplot(x[mask], ylab="phastCons score", las=1, cex.axis=1.2, cex.lab=1.5, col="gray")
points(1:length(x[mask])+0.25, sapply(x[mask], mean, na.rm=TRUE), pch=23, bg="black")
```

![Distribution of phastCons conservation scores in variants across different annotated regions. Diamonds indicate mean values.](data:image/png;base64...)

Figure 4: Distribution of phastCons conservation scores in variants across different annotated regions
Diamonds indicate mean values.

Next, we can annotate AlphaMissense and CADD scores as follows. Note that we
use the `QUERYID` column of the annotations to fetch back reference and
alternative alleles from the original data container.

```
loc$AM <- score(am23, loc,
                ref=gwcgr$REF[loc$QUERYID],
                alt=gwcgr$ALT[loc$QUERYID])
```

```
cadd
GScores object
# organism: Homo sapiens (UCSC, hg38)
# provider: UWashington
# provider version: v1.6
# download date: Oct 11, 2023
# loaded sequences: chr20
# maximum abs. error: 5
# use 'citation()' to cite these data in publications
loc$CADD <- score(cadd, loc, ref=gwcgr$REF[loc$QUERYID], alt=gwcgr$ALT[loc$QUERYID])
```

Using the code below we can produce the plot of Figure [5](#fig:am23vscadd) comparing
AlphaMissense and CADD scores and labeling the location of the variants from
which they are derived.

```
library(RColorBrewer)
par(mar=c(4, 5, 1, 1))
hmcol <- colorRampPalette(brewer.pal(nlevels(loc$LOCATION), "Set1"))(nlevels(loc$LOCATION))
plot(loc$AM, jitter(loc$CADD, factor=2), pch=19,
     col=hmcol, xlab="AlphaMissense scores", ylab="CADD scores",
     las=1, cex.axis=1.2, cex.lab=1.5, panel.first=grid())
legend("bottomright", levels(loc$LOCATION), pch=19, col=hmcol, inset=0.01)
```

![Comparison of AlphaMissense and CADD scores. Values on the y-axis are jittered to facilitate visualization.](data:image/png;base64...)

Figure 5: Comparison of AlphaMissense and CADD scores
Values on the y-axis are jittered to facilitate visualization.

# 10 Session information

```
sessionInfo()
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] RColorBrewer_1.1-3
 [2] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
 [3] GenomicFeatures_1.62.0
 [4] AnnotationDbi_1.72.0
 [5] VariantAnnotation_1.56.0
 [6] Rsamtools_2.26.0
 [7] SummarizedExperiment_1.40.0
 [8] Biobase_2.70.0
 [9] MatrixGenerics_1.22.0
[10] matrixStats_1.5.0
[11] MafH5.gnomAD.v4.0.GRCh38_3.19.0
[12] gwascat_2.42.0
[13] BSgenome.Hsapiens.UCSC.hg38_1.4.5
[14] BSgenome_1.78.0
[15] rtracklayer_1.70.0
[16] BiocIO_1.20.0
[17] Biostrings_2.78.0
[18] XVector_0.50.0
[19] GenomeInfoDb_1.46.0
[20] phastCons100way.UCSC.hg38_3.7.1
[21] GenomicScores_2.22.0
[22] GenomicRanges_1.62.0
[23] Seqinfo_1.0.0
[24] IRanges_2.44.0
[25] S4Vectors_0.48.0
[26] BiocGenerics_0.56.0
[27] generics_0.1.4
[28] knitr_1.50
[29] BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
 [4] filelock_1.0.3           bitops_1.0-9             fastmap_1.2.0
 [7] RCurl_1.98-1.17          BiocFileCache_3.0.0      GenomicAlignments_1.46.0
[10] XML_3.99-0.19            digest_0.6.37            lifecycle_1.0.4
[13] survival_3.8-3           KEGGREST_1.50.0          RSQLite_2.4.3
[16] magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6
[19] sass_0.4.10              tools_4.5.1              yaml_2.3.10
[22] data.table_1.17.8        S4Arrays_1.10.0          bit_4.6.0
[25] curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8
[28] BiocParallel_1.44.0      HDF5Array_1.38.0         withr_3.0.2
[31] purrr_1.1.0              grid_4.5.1               Rhdf5lib_1.32.0
[34] tinytex_0.57             cli_3.6.5                rmarkdown_2.30
[37] crayon_1.5.3             httr_1.4.7               rjson_0.2.23
[40] DBI_1.2.3                cachem_1.1.0             rhdf5_2.54.0
[43] splines_4.5.1            parallel_4.5.1           BiocManager_1.30.26
[46] restfulr_0.0.16          vctrs_0.6.5              Matrix_1.7-4
[49] jsonlite_2.0.0           bookdown_0.45            bit64_4.6.0-1
[52] magick_2.9.0             h5mread_1.2.0            jquerylib_0.1.4
[55] snpStats_1.60.0          glue_1.8.0               codetools_0.2-20
[58] BiocVersion_3.22.0       UCSC.utils_1.6.0         tibble_3.3.0
[61] pillar_1.11.1            rappdirs_0.3.3           htmltools_0.5.8.1
[64] rhdf5filters_1.22.0      R6_2.6.1                 dbplyr_2.5.1
[67] httr2_1.2.1              evaluate_1.0.5           lattice_0.22-7
[70] AnnotationHub_4.0.0      cigarillo_1.0.0          png_0.1-8
[73] memoise_2.0.1            bslib_0.9.0              Rcpp_1.1.0
[76] SparseArray_1.10.0       xfun_0.53                pkgconfig_2.0.3
```

# References

Chen, Siwei, Laurent C Francioli, Julia K Goodrich, Ryan L Collins, Masahiro Kanai, Qingbo Wang, Jessica Alföldi, et al. 2024. “A Genomic Mutational Constraint Map Using Variation in 76,156 Human Genomes.” *Nature* 625 (7993): 92–100.

Cheng, Jun, Guido Novati, Joshua Pan, Clare Bycroft, Akvilė Žemgulytė, Taylor Applebaum, Alexander Pritzel, et al. 2023. “Accurate Proteome-Wide Missense Variant Effect Prediction with Alphamissense.” *Science*, 1284–5.

Jagadeesh, Karthik A, Aaron M Wenger, Mark J Berger, Harendra Guturu, Peter D Stenson, David N Cooper, Jonathan A Bernstein, and Gill Bejerano. 2016. “M-Cap Eliminates a Majority of Variants of Uncertain Significance in Clinical Exomes at High Sensitivity.” *Nat. Genet.* 48 (12): 1581–6.

Kircher, Martin, Daniela M Witten, Preti Jain, Brian J O’roak, Gregory M Cooper, and Jay Shendure. 2014. “A General Framework for Estimating the Relative Pathogenicity of Human Genetic Variants.” *Nat. Genet.* 46 (3): 310–15.

Pollard, Katherine S, Melissa J Hubisz, Kate R Rosenbloom, and Adam Siepel. 2010. “Detection of Nonneutral Substitution Rates on Mammalian Phylogenies.” *Genome Research* 20 (1): 110–21.

Siepel, Adam, Gill Bejerano, Jakob S Pedersen, Angie S Hinrichs, Minmei Hou, Kate Rosenbloom, Hiram Clawson, et al. 2005. “Evolutionarily Conserved Elements in Vertebrate, Insect, Worm, and Yeast Genomes.” *Genome Res.* 15 (8): 1034–50.

Zender, Charles S. 2016. “Bit Grooming: Statistically Accurate Precision-Preserving Quantization with Compression, Evaluated in the netCDF Operators (Nco, V4. 4.8+).” *Geosci. Model Dev.* 9 (9): 3199–3211.