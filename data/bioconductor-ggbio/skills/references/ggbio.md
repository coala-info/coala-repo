ggbio: visualization toolkits for genomic data

Tengfei Yin1

October 30, 2025

1tengfei.yin@sbgenomics.com

Contents

1

Getting started.

1.1 Citation.

.

.

.

1.2 Introduction .

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

2

Case study: building your first tracks.

2.1 Add an ideogram track .

.

2.2 Add a gene model track .

2.2.1

Introduction .

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

2.2.2 Make gene model from OrganismDb object .

2.2.3 Make gene model from TxDb object .

.

2.2.4 Make gene model from EnsDb object .

.

.

.

.

.

.

2.2.5 Make gene model from GRangesList object .

2.3 Add a reference track .

2.3.1 Semantic zoom .

.

.

.

.

2.4 Add an alignment track .

2.5 Add a variants track .

2.6 Building your tracks .

3

4

Simple navigation .

Overview plots.

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

4.1 how to make circular plots .

4.1.1

Introduction .

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

4.1.2 Buidling circular plot layer by layer.

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

4

4

4

6

6

7

7

7

11

12

16

19

19

20

25

28

30

32

32

32

32

2

ggbio:visualization toolkits for genomic data

4.1.3 Complex arragnment of plots .

4.2 How to make grandlinear plots .

4.2.1

Introduction .

.

.

.

4.2.2 Corrdinate genome .

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

4.2.3 Convenient plotGrandLinear function .

4.2.4 How to highlight some points? .

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

4.3 How to make stacked karyogram overview plots .

4.3.1

Introduction .

.

.

.

.

.

.

.

4.3.2 Create karyogram temlate .

.

.

4.3.3 Add data on karyogram layout.

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

4.3.4 Add more data using layout_karyogram function .

4.3.5 More flexible layout of karyogram .

Link ranges to your data.

5

6

Miscellaneous .

6.1 Themes .

.

.

.

.

6.1.1 Plot theme .

6.1.2 Track theme .

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

7

Session Information .

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

39

41

41

43

43

45

46

46

46

48

51

54

55

57

57

57

62

63

3

Chapter 1

Getting started

1.1 Citation

citation("ggbio")

## To cite package 'ggbio' in publications use:

##

##

##

##

##

Tengfei Yin, Dianne Cook and Michael Lawrence (2012): ggbio: an R

package for extending the grammar of graphics for genomic data Genome

Biology 13:R77

## A BibTeX entry for LaTeX users is

##

##

##

##

##

##

##

##

##

##

##

@Article{,

title = {ggbio: an R package for extending the grammar of graphics for genomic data},

author = {Tengfei Yin and Dianne Cook and Michael Lawrence},

journal = {Genome Biology},

volume = {13},

number = {8},

pages = {R77},

year = {2012},

publisher = {BioMed Central Ltd},

}

1.2 Introduction

ggbio is a Bioconductor package building on top of ggplot2 (), leveraging the rich objects
defined by Bioconductor and its statistical and computational power, it provides a flexible
genomic visualization framework, extends the grammar of graphics into genomic data, try to
delivers high quality, highly customizable graphics to the users.

What it features

• autoplot function provides ready-to-use template for Bioconductor objects and differ-

ent types of data.

4

ggbio:visualization toolkits for genomic data

• flexible low level components to use grammar of graphics to build you graphics layer

by layer.

• layout transformation, so you could generate circular plot, grandlinear plot, stacked

overview more easily.

• flexible tracks function to bind any ggplot2 (), ggbio based plots.

5

Chapter 2

Case study: building your first
tracks

In this chapter, you will learn

• how to add ideogram track.

• How to add gene model track.

• how to add track for bam files to visualize coverage and mismatch summary.

• how to add track for vcf file to visualize the variants.

2.1 Add an ideogram track

Ideogram provides functionality to construct ideogram, check the manual for more flexible
methods. We build genome hg19, hg18, mm10, mm9 inside, so you don’t have download it
on the fly. When embed with tracks, ideogram show zoomed region highlights automatically.
xlim has special function here, is too changed highlighted zoomed region on the ideogram.

library(ggbio)

p.ideo <- Ideogram(genome = "hg19")

p.ideo

library(GenomicRanges)

## special highlights instead of zoomin!

p.ideo + xlim(GRanges("chr2", IRanges(1e8, 1e8+10000000)))

6

chr1chr1ychr2chr2yggbio:visualization toolkits for genomic data

2.2 Add a gene model track

2.2.1 Introduction

Gene model track is one of the most frequently used track in genome browser, it is composed
of genetic features CDS, UTR, introns, exons and non-genetic region. In ggbio we support
three methods to make gene model track:

• OrganismDb object: recommended, support gene symbols and other combination of

columns as label.

• TxDb object: don’t support gene symbol labeling.

• GRangesList object: flexible, if you don’t have annotation package available for the
first two methods, you could prepare a data set parsed from gtf file, you can simply use
it and plot it as gene model track.

• EnsDb object: supports gene symbol labeling, filtering etc.

2.2.2 Make gene model from OrganismDb object

OrganismDb object has a simpler API to retrieve data from different annotation resources,
so we could label our transcripts in different ways

library(ggbio)

library(Homo.sapiens)

class(Homo.sapiens)

## [1] "OrganismDb"

## attr(,"package")

## [1] "OrganismDbi"

##

data(genesymbol, package = "biovizBase")

wh <- genesymbol[c("BRCA1", "NBR1")]

wh <- range(wh, ignore.strand = TRUE)

p.txdb <- autoplot(Homo.sapiens, which

= wh)

p.txdb

7

ggbio:visualization toolkits for genomic data

autoplot(Homo.sapiens, which = wh, label.color = "black", color = "brown",

fill = "brown")

8

NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000ggbio:visualization toolkits for genomic data

To change the intron geometry, use gap.geom to control it, check out geom_alignment for
more control parameters.

autoplot(Homo.sapiens, which = wh, gap.geom = "chevron")

9

NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000ggbio:visualization toolkits for genomic data

To collapse all features, use stat ’reduce’

autoplot(Homo.sapiens, which = wh, stat = "reduce")

Label could be turned off by setting it to FALSE, you could also use expression to make a
flexible label combination from column names.

columns(Homo.sapiens)

##

##

[1] "ACCNUM"

"ALIAS"

"CDSCHROM"

"CDSEND"

"CDSID"

[6] "CDSNAME"

"CDSPHASE"

"CDSSTART"

"CDSSTRAND"

"DEFINITION"

## [11] "ENSEMBL"

"ENSEMBLPROT"

"ENSEMBLTRANS" "ENTREZID"

## [16] "EVIDENCE"

"EVIDENCEALL"

"EXONCHROM"

"EXONEND"

"ENZYME"

"EXONID"

## [21] "EXONNAME"

"EXONRANK"

"EXONSTART"

"EXONSTRAND"

"GENEID"

## [26] "GENENAME"

"GENETYPE"

"GO"

"GOALL"

"GOID"

## [31] "IPI"

## [36] "PATH"

## [41] "SYMBOL"

"MAP"

"PFAM"

"TERM"

"OMIM"

"PMID"

"ONTOLOGY"

"ONTOLOGYALL"

"PROSITE"

"REFSEQ"

"TXCHROM"

"TXEND"

## [46] "TXNAME"

"TXSTART"

"TXSTRAND"

"TXTYPE"

"TXID"

"UCSCKG"

10

NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000LOC101929767NBR2NBR1BRCA141200000412500004130000041350000ggbio:visualization toolkits for genomic data

## [51] "UNIPROT"

autoplot(Homo.sapiens, which = wh, columns = c("TXNAME", "GO"), names.expr = "TXNAME::GO")

2.2.3 Make gene model from TxDb object

TxDb doesn’t contain any gene symbol information, so we use tx_id as default for label.

library(TxDb.Hsapiens.UCSC.hg19.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

autoplot(txdb, which = wh)

11

ENST00000341165.10_3::GO:0000407ENST00000586650.5_5::GO:0000407ENST00000542611.5_1::GO:0000407ENST00000590996.6_6::GO:0000407ENST00000592304.1_1::GO:0000407ENST00000589872.1_3::GO:0000407ENST00000585505.1_1::GO:0000407ENST00000497488.2_5::GO:0000151ENST00000489037.2_6::GO:0000151ENST00000478531.6_6::GO:0000151ENST00000357654.9_14::GO:0000151ENST00000473961.6_7::GO:0000151ENST00000477152.6_7::GO:0000151ENST00000352993.7_6::GO:0000151ENST00000493919.6_6::GO:0000151ENST00000494123.6_9::GO:0000151ENST00000471181.7_10::GO:0000151ENST00000652672.2_9::GO:0000151ENST00000634433.2_7::GO:0000151ENST00000476777.6_7::GO:0000151ENST00000700081.1_1::GO:0000151ENST00000470026.6_9::GO:0000151ENST00000713676.1_2::GO:0000151ENST00000618469.2_9::GO:0000151ENST00000461574.2_7::GO:0000151ENST00000644555.2_10::GO:0000151ENST00000468300.5_6::GO:0000151ENST00000700082.1_1::GO:0000151ENST00000644379.2_11::GO:0000151ENST00000484087.6_7::GO:0000151ENST00000586385.5_5::GO:0000151ENST00000591534.5_5::GO:0000151ENST00000591849.5_5::GO:0000151ENST00000493795.5_5::GO:0000151ENST00000461221.5_5::GO:0000151ENST00000491747.6_7::GO:0000151ENST00000472490.1_3::GO:0000151ENST00000700182.1_4::GO:0000151ENST00000621897.1_4::GO:0000151ENST00000354071.8_5::GO:0000151ENST00000700183.1_3::GO:0000151ENST00000492859.5_6::GO:0000151ENST00000642945.1_7::GO:0000151ENST00000700184.1_2::GO:0000151ENST00000461798.5_4::GO:0000151ENST00000700083.1_1::GO:0000151ENST00000700185.1_1::GO:0000151ENST00000700186.1_1::GO:000015141200000412500004130000041350000ggbio:visualization toolkits for genomic data

2.2.4 Make gene model from EnsDb object

An alternative source for gene models are the EnsDb objects from the ensembldb package
that provide gene annotations provided from Ensembl. The ensembldb package provides a
rich filtering system that allows to easily fetch specific information (genes/transcripts) from
an EnsDb. The EnsDb objects provide gene symbol annotations in the column gene_name.
Alternatively, we could use tx_id to label transcripts.

In the example below we plot the gene model of the gene PHKG2. We use a GenenameFilter
to specify which gene we want to plot.

library(EnsDb.Hsapiens.v75)

ensdb <- EnsDb.Hsapiens.v75

autoplot(ensdb, GeneNameFilter("PHKG2"))

12

ENST00000497954.1_3ENST00000356906.8_3ENST00000657841.1_3ENST00000790201.1_1ENST00000790199.1_1ENST00000790202.1_1ENST00000790195.1_1ENST00000790203.1_1ENST00000790204.1_1ENST00000790196.1_1ENST00000460115.5_4ENST00000790206.1_1ENST00000790200.1_1ENST00000790197.1_1ENST00000790205.1_1ENST00000467245.5_3ENST00000790198.1_1ENST00000587322.1_4ENST00000464237.2_3ENST00000341165.10_3ENST00000586650.5_5ENST00000542611.5_1ENST00000590996.6_6ENST00000592304.1_1ENST00000589872.1_3ENST00000585505.1_1ENST00000497488.2_5ENST00000489037.2_6ENST00000478531.6_6ENST00000357654.9_14ENST00000473961.6_7ENST00000477152.6_7ENST00000352993.7_6ENST00000493919.6_6ENST00000494123.6_9ENST00000471181.7_10ENST00000652672.2_9ENST00000634433.2_7ENST00000476777.6_7ENST00000700081.1_1ENST00000470026.6_9ENST00000713676.1_2ENST00000618469.2_9ENST00000461574.2_7ENST00000644555.2_10ENST00000468300.5_6ENST00000700082.1_1ENST00000644379.2_11ENST00000484087.6_7ENST00000586385.5_5ENST00000591534.5_5ENST00000591849.5_5ENST00000493795.5_5ENST00000461221.5_5ENST00000491747.6_7ENST00000472490.1_3ENST00000700182.1_4ENST00000621897.1_4ENST00000354071.8_5ENST00000700183.1_3ENST00000492859.5_6ENST00000642945.1_7ENST00000700184.1_2ENST00000461798.5_4ENST00000700083.1_1ENST00000700185.1_1ENST00000700186.1_1ENST00000790357.1_1ENST00000790355.1_1ENST00000790354.1_1ENST00000635600.2_5ENST00000790352.1_1ENST00000790351.1_2ENST00000790358.1_1ENST00000790353.1_1ENST00000790356.1_1ENST00000659136.1_3ENST00000642336.1_3ENST00000590740.2_5ENST00000653081.1_3ENST00000634503.1_4ENST00000634994.1_3ENST00000790359.1_1ENST00000589464.1_3ENST00000589047.1_3ENST00000816293.1_241200000412500004130000041350000ggbio:visualization toolkits for genomic data

We can pass any filter class defined in the AnnotationFilter package with argument which.
Alternatively we can combine filter classes using an AnnotationFilterList or we can pass a
filter expression in form of a formula. Below we pass such a filter expression to the function.

autoplot(ensdb, ~ symbol == "PHKG2", names.expr="gene_name")

13

ENST00000328273ENST00000424889ENST00000561712ENST00000563588ENST00000563607ENST00000563913ENST00000564838ENST00000565897ENST00000565924ENST00000569684ENST0000056976230760000307640003076800030772000ggbio:visualization toolkits for genomic data

We could also specify a genomic region and fetch all transcripts overlapping that region (also
partially, i.e. with a part of an intron or an exon).

## We specify "*" as strand, thus we query for genes encoded
gr <- GRanges(seqnames = 16, IRanges(30768000, 30770000), strand = "*")
autoplot(ensdb, GRangesFilter(gr), names.expr = "gene_name")

on both strands

14

PHKG2PHKG2PHKG2PHKG2PHKG2PHKG2PHKG2PHKG2PHKG2PHKG2PHKG230760000307640003076800030772000ggbio:visualization toolkits for genomic data

Also, we can spefify directly the gene ids and plot all transcripts of these genes (not only
those overlapping with the region)

autoplot(ensdb, GeneIdFilter(c("ENSG00000196118", "ENSG00000156873")))

15

PHKG2PHKG2C16orf93C16orf93C16orf93C16orf93C16orf93C16orf93C16orf93C16orf93C16orf93C16orf93PHKG2PHKG2PHKG2307600003076500030770000ggbio:visualization toolkits for genomic data

2.2.5 Make gene model from GRangesList object

Sometimes your gene model is not available as none of OrganismDb or TxDb object, it’s may
be stored in a table, you could simple parse it into a GRangeList object.

• each group indicate one transcripts

• names of group are shown as labels

• this object must has a column contains following key word: cds, exon, intron, and it’s
not case senstitive. use type to map this column. By default, we will try to parse ’type’
column.

Let’s make a sample GRangesList object which contains all information, and fake some labels.

library(biovizBase)

gr.txdb <- crunch(txdb, which = wh)

## change column to 'model'

colnames(values(gr.txdb))[4] <- "model"
grl <- split(gr.txdb, gr.txdb$tx_id)
## fake some randome names

names(grl) <- sample(LETTERS, size = length(grl), replace = TRUE)

grl

## GRangesList object of length 86:

## $Z

## GRanges object with 1 range and 4 metadata columns:

16

ENST00000328273ENST00000424889ENST00000433909ENST00000535476ENST00000537986ENST00000541260ENST00000543128ENST00000543610ENST00000544487ENST00000544613ENST00000544643ENST00000545809ENST00000545825ENST00000546006ENST00000561712ENST00000563588ENST00000563607ENST00000563913ENST00000564838ENST00000565897ENST00000565924ENST00000569684ENST00000569762307600003076500030770000ggbio:visualization toolkits for genomic data

seqnames

<Rle>

<IRanges>

ranges strand |

tx_id
<Rle> | <character>

tx_name
<character>
306240 ENST00000497954.1_3

[1]

chr17 41231319-41231797
gene_id

model

+ |

<character> <factor>

[1]

-------

exon

seqinfo: 1 sequence from hg19 genome

##

##

##

##

##

##

##

##

##

## $H

##

## GRanges object with 7 ranges and 4 metadata columns:
tx_id
<Rle> | <character>

ranges strand |

<IRanges>

seqnames

<Rle>

##

tx_name
<character>
306241 ENST00000356906.8_3
306241 ENST00000356906.8_3
306241 ENST00000356906.8_3
306241 ENST00000356906.8_3
306241 ENST00000356906.8_3
306241 ENST00000356906.8_3
306241 ENST00000356906.8_3

[1]

[2]

[3]

[4]

[5]

[6]

[7]

[1]

[2]

[3]

[4]

[5]

[6]

[7]

chr17 41277437-41277787

chr17 41283225-41283287

chr17 41290674-41290939

chr17 41291833-41292350

chr17 41277788-41283224

chr17 41283288-41290673

chr17 41290940-41291832
gene_id

model

<character> <factor>

+ |

+ |

+ |

+ |
* |
* |
* |

10230

10230

10230

10230

10230

10230

10230

exon

exon

exon

exon

gap

gap

gap

-------

seqinfo: 1 sequence from hg19 genome

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

## $A

[1]

[2]

[3]

[4]

[5]

[1]

[2]

[3]

[4]

[5]

chr17 41277568-41277787

chr17 41290674-41292300

chr17 41305619-41305666

chr17 41277788-41290673

chr17 41292301-41305618
gene_id

model

<character> <factor>

+ |

+ |

+ |
* |
* |

10230

10230

10230

10230

10230

exon

exon

exon

gap

gap

-------

seqinfo: 1 sequence from hg19 genome

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

## GRanges object with 5 ranges and 4 metadata columns:
tx_id
<Rle> | <character>

ranges strand |

<IRanges>

seqnames

<Rle>

##

tx_name
<character>
306242 ENST00000657841.1_3
306242 ENST00000657841.1_3
306242 ENST00000657841.1_3
306242 ENST00000657841.1_3
306242 ENST00000657841.1_3

17

ggbio:visualization toolkits for genomic data

## ...

## <83 more elements>

We get our example data ready, it meets all requirements, to make it a gene model track
it’s pretty simple to use autoplot, but don’t forget mapping because we changed our column
names, asssume you store you model key words in column ’model’.

autoplot(grl, aes(type = model))

ggplot() + geom_alignment(grl, type = "model")

18

ZHAEHWXNBYUTXXHJMWKQLNFXQJCHMDIANEQVNKSMFUNMFBDCHWNONFDGILLXEDJQALIGCCYUATRUENQDXAAFFJ41200000412500004130000041350000ggbio:visualization toolkits for genomic data

2.3 Add a reference track

To add a reference track, we need to load a BSgenome object from the annotation package.
You can choose to plot the sequence as text, rect, segment.

2.3.1 Semantic zoom

Here we introduce semantic zoom in ggbio, for some plots like reference sequence, we use
pre-defined zoom level threshold to automatically assign geom to the track, unless the geom
is explicitly specified. In the example below, when your region is too wide we show text ’zoom
in to see text’, when you zoom into different level, it shows you different details. zoom is a
function we will introduce more in chapter 3 when we introduce more about navigation.

You can pass a zoom in factor into zoom function, if it’s over 1 it’s zooming out, if it’s smaller
than 1 it’s zooming in.

library(BSgenome.Hsapiens.UCSC.hg19)

bg <- BSgenome.Hsapiens.UCSC.hg19

p.bg <- autoplot(bg, which = wh)

## no geom

p.bg

19

ZHAEWXNBYUTJMKQLFCDIVSOGR41200000412500004130000041350000ggbio:visualization toolkits for genomic data

## segment

p.bg + zoom(1/100)

## rectangle

p.bg + zoom(1/1000)

## text

p.bg + zoom(1/2500)

To override a zemantic zoom threshold, you simply provide a geom explicitly.

library(BSgenome.Hsapiens.UCSC.hg19)

bg <- BSgenome.Hsapiens.UCSC.hg19

## force to use geom 'segment' at this level

autoplot(bg, which = resize(wh, width = width(wh)/2000), geom = "segment")

2.4 Add an alignment track

ggbio supports visuaization of alignemnts file stored in bam, autoplot method accepts

• bam file path (indexed)

20

zoom in to show data41200000412500004130000041350000412795004128000041280500seqsACGT41279950412800004128005041280100seqsACGTGCTTGCAGTGAGCCCAGATTGCACCACTGCATTCCAGCCTGGGTGACAGAGGGAGACTCCATCTCAAA412799904128001041280030seqsaaaaACGTggbio:visualization toolkits for genomic data

• BamFile object

• GappedAlignemnt object

It’s simple to just pass a file path to autoplot function, you can stream a chunk of region
by providing ’which’ parameter. Otherwise please use method ’estiamte’ to show overall
estiamted coverage.

fl.bam <- system.file("extdata", "wg-brca1.sorted.bam", package

= "biovizBase")

library(GenomeInfoDb) # for keepSeqlevels()

wh <- keepSeqlevels(wh, "chr17")

autoplot(fl.bam, which = wh)

geom ’gapped pair’ will show you alignments.

fl.bam <- system.file("extdata", "wg-brca1.sorted.bam", package

= "biovizBase")

wh <- keepSeqlevels(wh, "chr17")

autoplot(fl.bam, which = resize(wh, width = width(wh)/10), geom = "gapped.pair")

21

01002003004004100000041100000412000004130000041400000Coverageggbio:visualization toolkits for genomic data

To show mismatch proportion, you have to provide reference sequence, the mismatched
proportion is color coded in the bar chart.

library(BSgenome.Hsapiens.UCSC.hg19)

bg <- BSgenome.Hsapiens.UCSC.hg19

p.mis <- autoplot(fl.bam, bsgenome = bg, which = wh, stat = "mismatch")

p.mis

22

41 Mb41.1 Mb41.2 Mb41.3 Mb41.4 Mbggbio:visualization toolkits for genomic data

To view overall estimated coverage distribution, please use method ’estiamte’.
’which’ pa-
rameter also accept characters. And there is a hidden value called ’..coverage..’ to let you do
simple transformation in aes().

autoplot(fl.bam, method = "estimate")

23

05010015020025041200000412400004128000041320000CountsreadACGNTggbio:visualization toolkits for genomic data

autoplot(fl.bam, method = "estimate", which = paste0("chr", 17:18), aes(y = log(..coverage..)))

24

chr21chr22chrXchrYchrMchr16chr17chr18chr19chr20chr11chr12chr13chr14chr15chr6chr7chr8chr9chr10chr1chr2chr3chr4chr50.0e+005.0e+071.0e+081.5e+082.0e+082.5e+080.0e+005.0e+071.0e+081.5e+082.0e+082.5e+080.0e+005.0e+071.0e+081.5e+082.0e+082.5e+080.0e+005.0e+071.0e+081.5e+082.0e+082.5e+080.0e+005.0e+071.0e+081.5e+082.0e+082.5e+08050000010000001500000050000010000001500000050000010000001500000050000010000001500000050000010000001500000Coverageggbio:visualization toolkits for genomic data

2.5 Add a variants track

This track is supported by semantic zoom.

To view your variants file, you could

• Import it using package VariantAnntoation as VCF object, then use autoplot

• Convert it into VRanges object and use autoplot.

• Simply provide vcf file path in autoplot().

library(VariantAnnotation)

fl.vcf <- system.file("extdata", "17-1409-CEU-brca1.vcf.bgz", package="biovizBase")

vcf <- readVcf(fl.vcf, "hg19")

vr <- as(vcf[, 1:3], "VRanges")

vr <- renameSeqlevels(vr, value = c("17" = "chr17"))

## small region contains data

gr17 <- GRanges("chr17", IRanges(41234400, 41234530))

p.vr <- autoplot(vr, which = wh)

## none geom

p.vr

25

chr17chr180e+002e+074e+076e+078e+070e+002e+074e+076e+078e+07050000010000001500000Coverageggbio:visualization toolkits for genomic data

## rect geom

p.vr + xlim(gr17)

26

zoom in to show data41200000412500004130000041350000ggbio:visualization toolkits for genomic data

## text geom

p.vr + xlim(gr17) + zoom()

27

NA06984NA06985NA06986412344004123445041234500refACGTggbio:visualization toolkits for genomic data

You can simply overide geom

autoplot(vr, which = wh, geom = "rect", arrow = FALSE)

2.6 Building your tracks

## tks <- tracks(p.ideo, mismatch = p.mis, dbSNP = p.vr, ref = p.bs, gene = p.txdb)

## tks <- tracks(fl.bam, fl.vcf, bs, Homo.sapiens) ## default ideo = FALSE, turned on

## tks <- tracks(fl.bam, fl.vcf, bs, Homo.sapiens, ideo = TRUE)

## tks + xlim(gr17)

gr17 <- GRanges("chr17", IRanges(41234415, 41234569))

tks <- tracks(p.ideo, mismatch = p.mis, dbSNP = p.vr, ref = p.bg, gene = p.txdb,

heights = c(2, 3, 3, 1, 4)) + xlim(gr17) + theme_tracks_sunset()

tks

28

TTGACCACTTGACCACTTGACCACNA06984NA06985NA0698641234440412344604123448041234500altaaaaaaaaACGTggbio:visualization toolkits for genomic data

29

chr17chr17ymismatch050100150200250CountsreadACGNTdbSNPNA06984NA06985NA069861.001.251.501.752.001.001.251.501.752.001.001.251.501.752.00refACGTrefseqsACGTgeneNBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000Chapter 3

Simple navigation

We try to provide a simple navigation API for your plot, so you could zoom in and zoom out,
or go through view chunks one by one.

• zoom: put a factor inside and you can zoom in or zoom out

• nextView: switch to next view

• prevView: switch to previous view

Navigation function also works for tracks plot too.

## zoom in

tks + zoom()

Try following command yourself.

30

chr17chr17ymismatch050100150200250CountsreadACGNTdbSNPTAAACCTAACGCGTTATCATAGTCTCTTAGTCTCATTGAAGATGAGGCACTCTAAGATCTAAGCAACCTGTGTGCCGCCTTCGTTATACCGGTGCGACTCTCAGTAACGGCCACGAGCACTTTGTCTCGGAGCTCCGAGTGTTCACTCAGTAAACCTAACGCGTTATCATAGTCTCTTAGTCTCATTGAAGATGAGGCACTCTAAGATCTAAGCAACCTGTGTGCCGCCTTCGTTATACCGGTGCGACTCTCAGTAACGGCCACGAGCACTTTGTCTCGGAGCTCCGAGTGTTCACTCAGTAAACCTAACGCGTTATCATAGTCTCTTAGTCTCATTGAAGATGAGGCACTCTAAGATCTAAGCAACCTGTGTGCCGCCTTCGTTATACCGGTGCGACTCTCAGTAACGGCCACGAGCACTTTGTCTCGGAGCTCCGAGTGTTCACTCAGNA06984NA06985NA069861.001.251.501.752.001.001.251.501.752.001.001.251.501.752.00altaaaaaaaaACGTrefAGGTCCTCAAGGGCAGAAGAGTCACTTATGATGGAAGGGTAGCTGTTAGAAGGCTGGCTCCCATGCTGTTCTAACACAseqsaaaaACGTgeneNBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767412500004128000041310000ggbio:visualization toolkits for genomic data

## zoom in with scale

p.txdb + zoom(1/8)

## zoom out

p.txdb + zoom(2)

## next view page

p.txdb + nextView()

## previous view page

p.txdb + prevView()

Don’t forget xlim accept GRanges object (single row), so you could simply prepare a GRanges
to store the region of interests and go through them one by one.

31

Chapter 4

Overview plots

Overview is a good way to show all events at the same time, give overall summary statiics
for the whole genome.

In this chapter, we will introcue three different layouts that are used a lots in genomic data
visualization.

4.1 how to make circular plots

4.1.1 Introduction

Circular view is a special layout in ggbio , this idea has been implemented in many different
software, for example, the Circos project. However, we keep the grammar of graphics for
users, so mapping varialbes to aesthetics is very easy, ggbio leverage the data structure
defiend in Bioconductor to make this process as simple as possible.

4.1.2 Buidling circular plot layer by layer

Ok, let’s start to process some raw data to the format we want. The data used in this study
is from this a paper1. In this tutorial, We are going to

1. Visualize somatic mutation as segment.

2. Visualize inter,intro-chromosome rearrangement as links.

3. Visualize mutation score as point tracks with grid-background.

4. Add scale and ticks and labels.

5. To arrange multiple plots and legend. create multiple sample comparison.

All the raw data processed and stored in GRanges ready for use, you can simply load the
sample data from biovizBase

data("CRC", package = "biovizBase")

1http://www.nature.com/ng/journal/v43/n10/full/ng.936.html

32

ggbio:visualization toolkits for genomic data

layout_circle is depreicated, because you have to set up radius and trackWidth manually
with this function for creating circular plot.

We now present the new circle function, it accepts Granges object, and users don’t have
to specify radius, track width, you just add them one by one, it will be automatically created
from innter circle to outside, unless you specify trackWidth and radius manually. To change
default radius and trackWidth for all tracks, you simply put them in ggbio function.

• rule of thumb seqlengths, seqlevels and chromosomes names should be exactly the

same.

• to use circle, you have to use ggbio constructor at the beginning instead of ggplot.

You can use autoplot to create single track easily like

head(hg19sub)

## GRanges object with 6 ranges and 0 metadata columns:

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand

<Rle>

<IRanges> <Rle>

[1]

[2]

[3]

[4]

[5]

[6]

-------

1 1-249250621

2 1-243199373

3 1-198022430

4 1-191154276

5 1-180915260

6 1-171115067

*

*

*

*

*

*

seqinfo: 22 sequences from hg19 genome

autoplot(hg19sub, layout = "circle", fill

= "gray70")

33

ggbio:visualization toolkits for genomic data

Hoever, the low level circle function leave you more flexibility to build circular plot one by
one. Let’s start to add tracks one by one.

Let’s use the same data to create ideogram, label and scale track, it layouts the circle by the
order you created from inside to outside.

p <- ggbio() + circle(hg19sub, geom = "ideo", fill = "gray70") +

circle(hg19sub, geom = "scale", size = 2) +

circle(hg19sub, geom = "text", aes(label = seqnames), vjust = 0, size = 3)

p

To simply override the setting, you can do it globally in ggbio function or individually circle
function by specifying parametters trackWidth and radius, you can also specify the global
settin for buffer in between in ggbio like example below.

p <- ggbio(trackWidth = 10, buffer = 0, radius = 10) + circle(hg19sub, geom = "ideo", fill = "gray70") +

circle(hg19sub, geom = "scale", size = 2) +

circle(hg19sub, geom = "text", aes(label = seqnames), vjust = 0, size = 3)

p

34

0M50M100M150M200M0M50M100M150M200M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M0M50M0M50M0M50M0M50M0M0M50M12345678910111213141516171819202122ggbio:visualization toolkits for genomic data

Then we add a "rectangle" track to show somatic mutation, this will
segments.

looks like vertical

head(mut.gr)

## GRanges object with 6 ranges and 10 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

[6]

[1]

[2]

[3]

[4]

[5]

[6]

[1]

[2]

[3]

seqnames

ranges strand | Hugo_Symbol Entrez_Gene_Id

Center

<Rle> <IRanges> <Rle> |

<factor>

<integer> <factor>

1 11003085

1 62352395

1 194960885

2 10116508

2 33617747

2 73894280

+ |

+ |

+ |

- |

+ |

+ |

TARDBP

INADL

CFH

CYS1

RASGRP3

C2orf78

23435

10207

3075

192668

25780

388960

Broad

Broad

Broad

Broad

Broad

Broad

NCBI_Build
<integer> <factor>

Strand Variant_Classification Variant_Type Reference_Allele
<factor>

<factor>

<factor>

36

36

36

36

36

+

+

+

-

+

Missense

Missense

Missense

Missense

Missense

36

+
Tumor_Seq_Allele1 Tumor_Seq_Allele2
<factor>

<factor>

Missense

G

T

G

A

G

A

SNP

SNP

SNP

SNP

SNP

SNP

G

T

G

C

C

T

35

0M50M100M150M200M0M50M100M150M200M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M0M50M0M50M0M50M0M50M0M0M50M12345678910111213141516171819202122ggbio:visualization toolkits for genomic data

##

##

##

##

##

[4]

[5]

[6]

-------

C

C

T

T

T

C

seqinfo: 22 sequences from an unspecified genome

p <- ggbio() + circle(mut.gr, geom = "rect", color = "steelblue") +

circle(hg19sub, geom = "ideo", fill = "gray70") +

circle(hg19sub, geom = "scale", size = 2) +

circle(hg19sub, geom = "text", aes(label = seqnames), vjust = 0, size = 3)

p

Next, we need to add some "links" to show the rearrangement, of course, links can be used to
map any kind of association between two or more different locations to indicate relationships
like copies or fusions. To create a suitable structure to plot, please use another GRanges to
represent the end of the links, and stored as elementMetadata for the "start point" GRanges.
Here we named it as "to.gr" and will be used later.

head(crc.gr)

## GRanges object with 6 ranges and 17 metadata columns:

##

##

##

##

##

[1]

[2]

[3]

seqnames

ranges strand | individual

str1

class

span

18 56258628

<Rle> <IRanges> <Rle> |
* |
* |
* |

18 45023683

18 44496014

<factor> <integer>

<factor> <numeric>

CRC-4

CRC-4

CRC-4

1 long_range
1 long_range
0 long_range

2104165

12947165

13356670

36

0M50M100M150M200M0M50M100M150M200M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M0M50M0M50M0M50M0M50M0M0M50M12345678910111213141516171819202122ggbio:visualization toolkits for genomic data

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

0 deletion
0 inter_chr
0 inter_chr

268

NaN

NaN

[4]

[5]

[6]

[1]

[2]

[3]

[4]

[5]

[6]

8 52186319

8 37328910

8 35575394

tumreads normreads

* |
* |
* |
gene1

CRC-4

CRC-4

CRC-4

gene2

<integer> <integer> <factor> <factor>

491

265

238

94

56

53

2 MC4R

ZCCHC2

0 KIAA0427

CDH20

0 DYM

0 PXDNL

0 ZNF703

ZCCHC2

PXDNL

PAK7

0 UNC5D

RALGAPB

site1

<factor>

[1] IGR: 69Kb before MC4R(-)

[2] Intron of KIAA0427(+): 4Kb after exon 8

[3] Intron of DYM(-): 14Kb after exon 13

[4] IGR: 208Kb before PXDNL(-)

[5] IGR: 344Kb before ZNF703(+)

[6] Intron of UNC5D(+): 3Kb after exon 4

site2

<factor>

[1] Intron of ZCCHC2(+): 222bp before exon 4

[2] IGR: 134Kb before CDH20(+)

[3] Intron of ZCCHC2(+): 854bp before exon 9

[4] IGR: 208Kb before PXDNL(-)

[5] Intron of PAK7(-): 11Kb after exon 4

[6] Intron of RALGAPB(+): 839bp after exon 15

fusion

quality

score

BPresult

<factor> <numeric> <numeric> <integer>

[1] -

[2] -

1.000000

491.0000

0.994412

263.5191

[3] Protein fusion: in frame (ZCCHC2-DYM)

1.000000

238.0000

[4] -

[5] -

[6] Antisense fusion

1.000000

94.0000

0.974021

54.5452

1.000000

53.0000

to.gr

rearrangements

validation_result
<factor>

<GRanges>

<character>
[1] not_subjected_to_validation 18:58362793 intrachromosomal
[2] not_subjected_to_validation 18:57443167 intrachromosomal
[3] somatic
18:58380361 intrachromosomal
[4] not_subjected_to_validation
[5] somatic
20:9561906 interchromosomal
[6] not_subjected_to_validation 20:36595752 interchromosomal
-------

8:52186587 intrachromosomal

seqinfo: 22 sequences from an unspecified genome

-1

1

1

-1

1

1

Here in this example, we use "intrachromosomal" to label rearrangement within the same
chromosomes and use "interchromosomal" to label rearrangement in different chromosomes.

Get subset of links data for only one sample "CRC1"

37

ggbio:visualization toolkits for genomic data

gr.crc1 <- crc.gr[values(crc.gr)$individual == "CRC-1"]

Ok, add a "point" track with grid background for rearrangement data and map ‘y‘ to variable
"score", map ‘size‘ to variable "tumreads", rescale the size to a proper size range.

## manually specify radius

p <- p + circle(gr.crc1, geom = "point", aes(y = score, size = tumreads),

color = "red", grid = TRUE, radius = 30) + scale_size(range = c(1, 2.5))

p

Finally, let’s add links and map color to rearrangement types. Remember you need to specify
‘linked.to‘ parameter to the column that contain end point of the data.

## specify radius manually

p <- p + circle(gr.crc1, geom = "link", linked.to = "to.gr", aes(color = rearrangements),

p

radius = 23)

38

0M50M100M150M200M0M50M100M150M200M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M0M50M0M50M0M50M0M50M0M0M50M12345678910111213141516171819202122tumreads5.07.510.012.5ggbio:visualization toolkits for genomic data

All those code could be simply constructed by following code

p <- ggbio() +

circle(gr.crc1, geom = "link", linked.to = "to.gr", aes(color = rearrangements)) +

circle(gr.crc1, geom = "point", aes(y = score, size = tumreads),

color = "red", grid = TRUE) + scale_size(range = c(1, 2.5)) +

circle(mut.gr, geom = "rect", color = "steelblue") +

circle(hg19sub, geom = "ideo", fill = "gray70") +

circle(hg19sub, geom = "scale", size = 2) +

circle(hg19sub, geom = "text", aes(label = seqnames), vjust = 0, size = 3)

p

4.1.3 Complex arragnment of plots

In this step, we are going to make multiple sample comparison, this may require some knowl-
edge about package grid and gridExtra. We will introduce a more easy way to combine your
graphics later after this.

39

0M50M100M150M200M0M50M100M150M200M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M0M50M0M50M0M50M0M50M0M0M50M12345678910111213141516171819202122rearrangementsinterchromosomalintrachromosomaltumreads5.07.510.012.50M50M100M150M200M0M50M100M150M200M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M150M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M100M0M50M0M50M0M50M0M50M0M50M0M0M50M12345678910111213141516171819202122rearrangementsinterchromosomalintrachromosomaltumreads5.07.510.012.5ggbio:visualization toolkits for genomic data

We just want 9 single circular plots put together in one page, since we cannot keep too many
tracks, we only keep ideogram and links. Here is one sample.

grl <- split(crc.gr, values(crc.gr)$individual)

## need "unit", load grid

library(grid)

crc.lst <- lapply(grl, function(gr.cur){

print(unique(as.character(values(gr.cur)$individual)))

cols <- RColorBrewer::brewer.pal(3, "Set2")[2:1]

names(cols) <- c("interchromosomal", "intrachromosomal")

p <- ggbio() + circle(gr.cur, geom = "link", linked.to = "to.gr",

aes(color = rearrangements)) +

circle(hg19sub, geom = "ideo",

color = "gray70", fill = "gray70") +

scale_color_manual(values = cols)
labs(title = (unique(values(gr.cur)$individual))) +

+

theme(plot.margin = unit(rep(0, 4), "lines"))

})

## [1] "CRC-1"

## [1] "CRC-2"

## [1] "CRC-3"

## [1] "CRC-4"

## [1] "CRC-5"

## [1] "CRC-6"

## [1] "CRC-7"

## [1] "CRC-8"

## [1] "CRC-9"

We wrap the function in grid level to a more user-friendly high level function, called arrange
GrobByParsingLegend. You can pass your ggplot2 graphics to this function , specify the
legend you want to keep on the right, you can also specify the column/row numbers. Here
we assume all plots we have passed follows the same color scale and have the same legend,
so we only have to keep one legend on the right.

arrangeGrobByParsingLegend(crc.lst, widths = c(4, 1), legend.idx = 1, ncol = 3)

40

ggbio:visualization toolkits for genomic data

## TableGrob (1 x 2) "arrange": 2 grobs

##

z

cells

name

grob

## 1 1 (1-1,1-1) arrange gtable[arrange]

## 2 2 (1-1,2-2) arrange gtable[arrange]

4.2 How to make grandlinear plots

4.2.1 Introduction

Let’s use a subset of PLINK output (https://github.com/stephenturner/qqman/blob/master/
plink.assoc.txt.gz) as our example test data.

snp <- read.table(system.file("extdata", "plink.assoc.sub.txt", package = "biovizBase"),

require(biovizBase)

header = TRUE)

gr.snp <- transformDfToGr(snp, seqnames = "CHR", start = "BP", width = 1)

head(gr.snp)

## GRanges object with 6 ranges and 10 metadata columns:

##

##

##

##

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

[6]

seqnames

<Rle>

ranges strand |

CHR

SNP

BP

<IRanges>

<Rle> | <integer> <character> <integer>

4 10794096-10794099

14 55853742-55853755

6 55188853-55188858

17

4146033-4146049

19 46089501-46089519

1

A1

107051695
F_A

F_U

* |
* |
* |
* |
* |
* |

4

14

6

17

19

rs9291494

10794096

rs1152481

55853742

rs3134708

55188853

rs2325988

4146033

rs8103444

46089501

1

rs12072065 107051695

A2

CHISQ

P

OR

41

CRC−1CRC−2CRC−3CRC−4CRC−5CRC−6CRC−7CRC−8CRC−9rearrangementsinterchromosomalintrachromosomalggbio:visualization toolkits for genomic data

##

##

##

##

##

##

##

##

##

<character> <numeric> <numeric> <character> <numeric> <numeric> <numeric>

[1]

[2]

[3]

[4]

[5]

[6]

-------

G

G

C

G

C

0

0.3061

0.3542

0.2500

0.2551

0.3980

0.0000

0.1341

0.2805

0.2875

0.2317

0.2927

0.0000

A

A

A

A

A

C

7.5070

0.006147

1.1030

0.293600

0.3135

0.575500

0.1323

0.716100

2.1750

0.140300

NA

NA

2.8480

1.4070

0.8261

1.1360

1.5970

NA

seqinfo: 22 sequences from an unspecified genome; no seqlengths

## change the seqname order

library(GenomeInfoDb) # for keepSeqlevels()

gr.snp <- keepSeqlevels(gr.snp, as.character(1:22))

seqlengths(gr.snp)

##

1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22

## NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA

## need to assign seqlengths

data(ideoCyto, package = "biovizBase")

seqlengths(gr.snp) <- as.numeric(seqlengths(ideoCyto$hg18)[1:22])

## remove missing

gr.snp <- gr.snp[!is.na(gr.snp$P)]

## transform pvalue

values(gr.snp)$pvalue <- -log10(values(gr.snp)$P)

head(gr.snp)

## GRanges object with 6 ranges and 11 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

<Rle>

ranges strand |

CHR

SNP

BP

<IRanges>

<Rle> | <integer> <character> <integer>

4 10794096-10794099

14 55853742-55853755

6 55188853-55188858

17

4146033-4146049

19 46089501-46089519

9 81517907-81517915

* |
* |
* |
* |
* |
* |

4

14

6

17

19

9

rs9291494

10794096

rs1152481

55853742

rs3134708

55188853

rs2325988

4146033

rs8103444

46089501

rs2591

81517907

A1

F_A

F_U

A2

CHISQ

P

OR

<character> <numeric> <numeric> <character> <numeric> <numeric> <numeric>

G

G

C

G

C

C

0.3061

0.13410

0.3542

0.28050

0.2500

0.28750

0.2551

0.23170

0.3980

0.29270

0.1042

0.04878

A

A

A

A

A

T

7.5070

0.006147

1.1030

0.293600

0.3135

0.575500

0.1323

0.716100

2.1750

0.140300

1.8720

0.171200

2.8480

1.4070

0.8261

1.1360

1.5970

2.2670

[1]

[2]

[3]

[4]

[5]

[6]

[1]

[2]

[3]

[4]

[5]

[6]

pvalue

<numeric>

[1] 2.211337

[2] 0.532244

[3] 0.239955

[4] 0.145026

[5] 0.852942

[6] 0.766496

-------

42

ggbio:visualization toolkits for genomic data

##

seqinfo: 22 sequences from an unspecified genome

## done

The data is ready, we need to pay attention

• if seqlengths is missing, we use data range, so the chromosome length is not accurate

• use seqlevel to control order of chromosome

4.2.2 Corrdinate genome

In autoplot, argument coord is just used to transform the data, after that, you can use it as
common GRanges, all other geom/stat works for it.

autoplot(gr.snp, geom = "point", coord = "genome", aes(y = pvalue))

However, we recommend you to use more powerful function plotGrandLinear to generate
manhattan plot introduced in next section.

4.2.3 Convenient plotGrandLinear function

For Manhattan plot, we have a function called plotGrandLinear. aes(y = ) is required to
indicate the y value, e.g. p-value.

Color mapping is automatically figured out by ggbio following the rules

• if color present in aes(), like aes(color = seqnames), it will assume it’s mapping to

data column called ’seqnames’.

• if color is not wrapped in aes(), then this function will recylcle them to all chromo-

somes.

• if color is single character representing color, then just use one arbitrary color.

43

012312345678910111213141516171819202122pvalueggbio:visualization toolkits for genomic data

Let’s test some examples for controling colors.

plotGrandLinear(gr.snp, aes(y = pvalue), color = c("#7fc97f", "#fdc086"))

Let’s add a cutoff line

plotGrandLinear(gr.snp, aes(y = pvalue), color = c("#7fc97f", "#fdc086"),

cutoff = 3, cutoff.color = "blue", cutoff.size = 0.2)

Sometimes you use color to mapping other varibles so you may need a different to separate
chromosomes.

plotGrandLinear(gr.snp, aes(y = pvalue, color = OR), spaceline = TRUE, legend = TRUE)

44

012312345678910111213141516171819202122pvalue012312345678910111213141516171819202122pvalueggbio:visualization toolkits for genomic data

4.2.4 How to highlight some points?

You can provide a highlight GRanges, and each row highlights a set of overlaped snps, and
labeled by rownames or certain columns, there is more control in the function as parameters,
with prefix highlight.*, so you could control color, label size and color, etc.

gro <- GRanges(c("1", "11"), IRanges(c(100, 2e6), width = 5e7))

names(gro) <- c("group1", "group2")

plotGrandLinear(gr.snp, aes(y = pvalue), highlight.gr = gro)

45

012312345678910111213141516171819202122pvalueOR036912group1group2012312345678910111213141516171819202122pvalueggbio:visualization toolkits for genomic data

4.3 How to make stacked karyogram overview plots

4.3.1 Introduction

A karyotype is the number and appearance of chromosomes in the nucleus of a eukaryotic
cell2. It’s one kind of overview when we want to show distribution of certain events on the
genome, for example, binding sites for certain protein, even compare them across samples as
example shows in this section.

GRanges and Seqinfo objects are an ideal container for storing data needed for karyogram
plot. Here is the strategy we used for generating ideogram templates.

• Althouth seqlengths is not required, it’s highly recommended for plotting karyogram.
If a GRanges object contains seqlengths, we know exactly how long each chromosome
is, and will use this information to plot genome space, particularly we plot all levels
included in it, NOT JUST data space.

• If a GRanges has no seqlengths, we will

issue a warning and try to estimate the
chromosome lengths from data included. This is NOT accurate most time, so please
pay attention to what you are going to visualize and make sure set seqlengths before
hand.

4.3.2 Create karyogram temlate

Let’s first introduce how to use autoplot to generate karyogram graphic.

The most easy one is to just plot Seqinfo by using autoplot, if your GRanges object has
seqinfo with seqlengths information. Then you add data layer later.

data(ideoCyto, package = "biovizBase")

autoplot(seqinfo(ideoCyto$hg19), layout = "karyogram")

2http://en.wikipedia.org/wiki/Karyotype

46

ggbio:visualization toolkits for genomic data

To show cytobands, your data need to have cytoband information, we stored some data for
you, including hg19, hg18, mm10, mm9.

## turn on cytobands if present

biovizBase::isIdeogram(ideoCyto$hg19)

## [1] TRUE

autoplot(ideoCyto$hg19, layout = "karyogram", cytobands = TRUE)

47

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrXchrY0 Mb50 Mb100 Mb150 Mb200 Mb250 Mbggbio:visualization toolkits for genomic data

To change order or only show a subset of the karyogram, you have to manipulate seqlevels,
please check out manual for keepSeqlevels, seqlevels in GenomeInfoDb package for more
information. Or you could read the example below.

4.3.3 Add data on karyogram layout

If you have single data set stored as GRanges to show on a karyogram layout, autoplot
function is enough for you to plot the data on it.

We use a default data in package biovizBase, which is a subset of RNA editing set in human.
The data involved in this GRanges is sparse, so we cannot simply use it to make karyogram
template, otherwise, the estimated chromosome lengths will be very rough and inaccurate.
So what we need to do first is to add seglength information to this object.

data(darned_hg19_subset500, package = "biovizBase")
dn <- darned_hg19_subset500
library(GenomicRanges)

seqlengths(dn)

##

##

chr1 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19

chr2 chr20

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

## chr21 chr22 chr3 chr4 chr5

chr6

chr7

chr8

chr9

chrX

##

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

## add seqlengths

## we have seqlegnths information in another data set

seqlengths(dn) <- seqlengths(ideoCyto$hg19)[names(seqlengths(dn))]

## then we change order

library(GenomeInfoDb) # for keepSeqlevels()

dn <- keepSeqlevels(dn, paste0("chr", c(1:22, "X")))

48

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrXchrY0 Mb50 Mb100 Mb150 Mb200 Mb250 MbgieStaingneggpos100gpos25gpos50gpos75gvarstalkacenggbio:visualization toolkits for genomic data

seqlengths(dn)

##

chr1

chr2

chr3

chr4

chr5

chr6

chr7

chr8

## 249250621 243199373 198022430 191154276 180915260 171115067 159138663 146364022

##

chr9

chr10

chr11

chr12

chr13

chr14

chr15

chr16

## 141213431 135534747 135006516 133851895 115169878 107349540 102531392

90354753

##

##

chr17

chr18

chr19

chr20

chr21

chr22

chrX

81195210 78077248 59128983 63025520

48129895

51304566 155270560

autoplot(dn, layout = "karyogram")

Then we take one step further, the power of ggplot2 or ggbio is the flexible multivariate data
mapping ability in graphics, make data exploration much more convenient. In the following
example, we are trying to map a categorical variable ’exReg’ to color, this variable is included
in the data, and have three levels, ’3’ indicate 3’ utr, ’5’ means 5’ utr and ’C’ means coding
region. We have some missing values indicated as NA, in default, it’s going to be shown
in gray color, and keep in mind, since the basic geom(geometric object) is rectangle, and
genome space is very large, so change both color/fill color of the rectangle to specify both
border and filled color is necessary to get the data shown as different color, otherwise if the
region is too small, border color is going to override the fill color.

## since default is geom rectangle, even though it's looks like segment

## we still use both fill/color to map colors

autoplot(dn, layout = "karyogram", aes(color = exReg, fill = exReg))

49

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrX0 Mb50 Mb100 Mb150 Mb200 Mb250 Mbggbio:visualization toolkits for genomic data

Or you can set the missing value to particular color yo u want (NA values is not shown on
the legend).

## since default is geom rectangle, even though it's looks like segment

## we still use both fill/color to map colors

autoplot(dn, layout = "karyogram", aes(color = exReg, fill = exReg), alpha

= 0.5) +

scale_color_discrete(na.value = "brown")

50

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrX0 Mb50 Mb100 Mb150 Mb200 Mb250 MbexReg35CNAggbio:visualization toolkits for genomic data

Well, sometimes we have too many values, we want to separate them by groups and show
them at diffent height, below is a hack for that purpose and in next section, we will introduce
a more flexible and general way to add data layer by layer.

Template chromosome y limits is [0, 10], that’s why this hack works

## let's remove the NA value

dn.nona <- dn[!is.na(dn$exReg)]

## compute levels based on categories

dn.nona$levels <- as.numeric(factor(dn.nona$exReg))

## do a trcik show them at different height

p.ylim <- autoplot(dn.nona, layout = "karyogram", aes(color = exReg, fill = exReg,

ymin = (levels - 1) * 10/3,
ymax = levels * 10 /3))

4.3.4 Add more data using layout_karyogram function

In this section, a lower level function layout_karyogram is going to be introduced. This is
convenient API for constructing karyogram plot and adding more data layer by layer. Function
ggplot is just to create blank object to add layer on.

You need to pay attention to

• when you add plots layer by layer, seqnames of different data must be the same to
make sure the data are mapped to the same chromosome. For example, if you name
chromosome following schema like chr1 and use just number 1 to name other data,
they will be treated as different chromosomes.

51

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrX0 Mb50 Mb100 Mb150 Mb200 Mb250 MbexReg35CNAggbio:visualization toolkits for genomic data

• cannot use the same aesthetics mapping multiple time for different data. For example,
if you have used aes(color = ), for one data, you cannot use aes(color = ) anymore
for mapping variables from other add-on data, this is currently not allowed in ggplot2 ,
even though you expect multiple color legend shows up, this is going to confuse people
which is which. HOWEVER, color or fill without aes() wrap around, is allowed for
any track, it’s set single arbitrary color.

• Default rectangle y range is [0, 10], so when you add on more data layer by layer on
existing graphics, you can use ylim to control how to normalize your data and plot it
relative to chromosome space. For example, with default, chromosome space is plotted
between y [0, 10], if you use ylim = c(10 , 20), you will stack data right above each
chromosomes and with equal width. For geom like ’point’, which you need to specify
’y’ value in aes(), we will add 5% margin on top and at bottom of that track.

Many times we overlay different datas sets, so let’s break down the previous samples into 4
groups and treat them as different data and build them layer by layer, assign the color by
hand. You could use ylim to control where they are ploted.

## prepare the data

dn3 <- dn.nona[dn.nona$exReg == '3']

dn5 <- dn.nona[dn.nona$exReg == '5']

dnC <- dn.nona[dn.nona$exReg == 'C']

dn.na <- dn[is.na(dn$exReg)]

## now we have 4 different data sets

autoplot(seqinfo(dn3), layout = "karyogram") +

layout_karyogram(data = dn3, geom = "rect", ylim = c(0, 10/3), color = "#7fc97f") +
layout_karyogram(data = dn5, geom = "rect", ylim = c(10/3, 10/3*2), color = "#beaed4") +
layout_karyogram(data = dnC, geom = "rect", ylim = c(10/3*2, 10), color = "#fdc086") +
layout_karyogram(data = dn.na, geom = "rect", ylim = c(10, 10/3*4), color = "brown")

52

ggbio:visualization toolkits for genomic data

What’s more, you could even chagne the geom for those data

dn$pvalue <- runif(length(dn)) * 10
p <- autoplot(seqinfo(dn)) + layout_karyogram(dn, aes(x = start, y = pvalue),
geom = "point", color = "#fdc086")

p

53

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrX0 Mb50 Mb100 Mb150 Mb200 Mb250 Mbstartggbio:visualization toolkits for genomic data

4.3.5 More flexible layout of karyogram

p.ylim + facet_wrap(~seqnames)

54

chr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12chr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrX0 Mb50 Mb100 Mb150 Mb200 Mb250 Mbstartchr21chr22chrXchr16chr17chr18chr19chr20chr11chr12chr13chr14chr15chr6chr7chr8chr9chr10chr1chr2chr3chr4chr50 Mb50 Mb100 Mb150 Mb200 Mb250 Mb0 Mb50 Mb100 Mb150 Mb200 Mb250 Mb0 Mb50 Mb100 Mb150 Mb200 Mb250 Mb0 Mb50 Mb100 Mb150 Mb200 Mb250 Mb0 Mb50 Mb100 Mb150 Mb200 Mb250 MbexReg35CChapter 5

Link ranges to your data

Plot GRanges object structure and linked to a even spaced paralell coordinates plot which
represting the data in elementeMetadata.

library(TxDb.Hsapiens.UCSC.hg19.knownGene)

library(ggbio)

data(genesymbol, package = "biovizBase")

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

model <- exonsBy(txdb, by = "tx")

model17 <- subsetByOverlaps(model, genesymbol["RBM17"])

exons <- exons(txdb)

exon17 <- subsetByOverlaps(exons, genesymbol["RBM17"])

## reduce to make sure there is no overlap

## just for example

exon.new <- reduce(exon17)

## suppose

values(exon.new)$sample1 <- rnorm(length(exon.new), 10, 3)

values(exon.new)$sample2 <- rnorm(length(exon.new), 10, 10)

values(exon.new)$score <- rnorm(length(exon.new))

values(exon.new)$significant <- sample(c(TRUE,FALSE), size = length(exon.new),replace = TRUE)

## data ready

exon.new

## GRanges object with 12 ranges and 4 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

sample1

sample2

score

<Rle>

<IRanges>

<Rle> | <numeric> <numeric> <numeric>

[1]

[2]

[3]

[4]

[5]

...

[8]

[9]

[10]

[11]

[12]

chr10 6130997-6131156

chr10 6131309-6131934

chr10 6138873-6139151

chr10 6143234-6143350

chr10 6146894-6147060

+ |

+ |

+ |

+ |

+ |

13.87442

17.6188

0.878689

13.87184

26.1465

0.528159

12.62377

-14.4328

2.002467

4.22282

19.7331 -0.362154

10.60832

12.5780 -0.133433

...

...

... .

...

...

...

chr10 6151949-6152090

chr10 6154173-6154424

chr10 6154665-6155031

chr10 6155326-6155544

chr10 6155870-6159420

+ |

+ |

+ |

+ |

+ |

13.65786

14.32290 -1.101137

11.82455

15.15230 -0.779315

18.06119

29.60601 -1.143316

9.16254

3.63333

1.430691

15.97793

5.74985

0.215062

55

ggbio:visualization toolkits for genomic data

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

significant

<logical>

[1]

[2]

[3]

[4]

[5]

...

[8]

[9]

[10]

[11]

[12]

-------

TRUE

TRUE

FALSE

FALSE

TRUE

...

FALSE

FALSE

TRUE

TRUE

FALSE

seqinfo: 298 sequences (2 circular) from hg19 genome

Make the plots, you can pass a list of annotation tracks too.

p17 <- autoplot(txdb, genesymbol["RBM17"])

plotRangesLinkedToData(exon.new, stat.y = c("sample1", "sample2"), annotation = list(p17))

For more information, check the manual.

56

−100102030valuegroupsample1sample2ENST00000379888.9_4ENST00000437845.6_1ENST00000432931.5_3ENST00000446108.5_1ENST00000418631.5_2ENST00000467214.1_1ENST00000447032.1_2ENST00000481147.1_1ENST00000476706.5_1ENST00000465906.5_1ENST00000467080.1_1ENST00000496762.1_16130000614000061500006160000Chapter 6

Miscellaneous

Every plot object produced by ggplot2 is essentially a ggplot2 object, so you could use all
the tricks you know with ggplot2 on ggbio plots too, including scales, colors, themes, etc.

6.1 Themes

In ggbio, we developed some more themes to make things easier.

6.1.1 Plot theme

Plot level themes are like any other themes defined in ggplot2 , simply apply it to a plot.

p.txdb

57

ggbio:visualization toolkits for genomic data

p.txdb + theme_alignment()

58

NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000ggbio:visualization toolkits for genomic data

p.txdb + theme_clear()

p.txdb + theme_null()

59

NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC10192976741200000412500004130000041350000ggbio:visualization toolkits for genomic data

When you have multiple chromosomes encoded in seqnames, you could use theme_genome
to make a ’fake’ linear view of genome coordinates quickly by applying this theme, because
it’s not equal to chromosome lengths, it’s simply

library(GenomicRanges)

set.seed(1)

N <- 100

gr <- GRanges(seqnames = sample(c("chr1", "chr2", "chr3"),

size = N, replace = TRUE),

IRanges(start = sample(1:300, size = N, replace = TRUE),

width = sample(70:75, size = N,replace = TRUE)),

strand = sample(c("+", "-"), size = N, replace = TRUE),

value = rnorm(N, 10, 3), score = rnorm(N, 100, 30),

sample = sample(c("Normal", "Tumor"),

size = N, replace = TRUE),

pair = sample(letters, size = N,

seqlengths(gr) <- c(400, 1000, 500)

replace = TRUE))

autoplot(gr)

60

NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR2NBR1NBR1NBR1NBR1NBR1NBR1NBR1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1BRCA1LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767LOC101929767ggbio:visualization toolkits for genomic data

autoplot(gr) + theme_genome()

61

chr2chr3chr10 bp100 bp200 bp300 bp0 bp100 bp200 bp300 bp0 bp100 bp200 bp300 bpchr2chr3chr1ggbio:visualization toolkits for genomic data

6.1.2 Track theme

Track level themes are more complex, it controls whole looking of the tracks, it’s essentially
a theme object with some attributes controlling the tracks appearance.

See how we make a template, you could customize in the same way

theme_tracks_sunset

## function (bg = "#fffedb", alpha = 1, ...)

## {

##

##

##

##

##

##

##

## }

res <- theme_clear(grid.x.major = FALSE, ...)
attr(res, "track.plot.color") <- sapply(bg, scales::alpha,

alpha)

attr(res, "track.bg.color") <- bg

attr(res, "label.text.color") <- "white"

attr(res, "label.bg.fill") <- "#a52a2a"

res

## <bytecode: 0x61cadd431f88>

## <environment: namespace:ggbio>

The attributes you could control is basically passed to tracks() constructor, including

label.bg.color
label.bg.fill
label.text.color
label.text.cex
label.text.angle
track.plot.color
track.bg.color
label.width

character
character
character
numeric
numeric
character_OR_NULL
character_OR_NULL
unit

Table 6.1: tracks attributes

62

Chapter 7

Session Information

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

##

## attached base packages:

## [1] grid

stats4

stats

graphics

grDevices utils

datasets

## [8] methods

base

##

## other attached packages:

##

##

##

##

##

##

##

##

##

[1] VariantAnnotation_1.56.0
[2] Rsamtools_2.26.0
[3] SummarizedExperiment_1.40.0
[4] MatrixGenerics_1.22.0
[5] matrixStats_1.5.0
[6] GenomeInfoDb_1.46.0
[7] BSgenome.Hsapiens.UCSC.hg19_1.4.3
[8] BSgenome_1.78.0
[9] rtracklayer_1.70.0

63

ggbio:visualization toolkits for genomic data

## [10] BiocIO_1.20.0
## [11] Biostrings_2.78.0
## [12] XVector_0.50.0
## [13] biovizBase_1.58.0
## [14] EnsDb.Hsapiens.v75_2.99.0
## [15] ensembldb_2.34.0
## [16] AnnotationFilter_1.34.0
## [17] Homo.sapiens_1.3.1
## [18] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [19] org.Hs.eg.db_3.22.0
## [20] GO.db_3.22.0
## [21] OrganismDbi_1.52.0
## [22] GenomicFeatures_1.62.0
## [23] AnnotationDbi_1.72.0
## [24] Biobase_2.70.0
## [25] GenomicRanges_1.62.0
## [26] Seqinfo_1.0.0
## [27] IRanges_2.44.0
## [28] S4Vectors_0.48.0
## [29] ggbio_1.58.0
## [30] ggplot2_4.0.0
## [31] BiocGenerics_0.56.0
## [32] generics_0.1.4
## [33] knitr_1.50
##

##

##

[1] DBI_1.2.3
[4] gridExtra_2.3
[7] compiler_4.5.1

## loaded via a namespace (and not attached):
bitops_1.0-9
rlang_1.1.6
RSQLite_2.4.3
reshape2_1.4.4
pkgconfig_2.0.3
backports_1.5.0
graph_1.88.0
bit_4.6.0
cigarillo_1.0.0
highr_0.11
parallel_4.5.1
stringi_1.8.7
Rcpp_1.1.0
nnet_7.3-20
dichromat_2.0-0.1
codetools_0.2-20
tibble_3.3.0
KEGGREST_1.50.0
foreign_0.8-90
checkmate_2.3.3
BiocStyle_2.38.0
lazyeval_0.2.2
GenomicAlignments_1.46.0 XML_3.99-0.19
htmlTable_2.4.3
cli_3.6.5

##
## [10] vctrs_0.6.5
## [13] stringr_1.5.2
## [16] fastmap_1.2.0
## [19] rmarkdown_2.30
## [22] tinytex_0.57
## [25] cachem_1.1.0
## [28] blob_1.2.4
## [31] BiocParallel_1.44.0
## [34] R6_2.6.1
## [37] rpart_4.1.24
## [40] Matrix_1.7-4
## [43] rstudioapi_0.17.1
## [46] yaml_2.3.10
## [49] lattice_0.22-7
## [52] withr_3.0.2
## [55] evaluate_1.0.5
## [58] BiocManager_1.30.26
## [61] scales_1.4.0
## [64] Hmisc_5.2-4
## [67] data.table_1.17.8
## [70] colorspace_2.1-2
## [73] Formula_1.2-5

RBGL_1.86.0
magrittr_2.0.4
png_0.1-8
ProtGenerics_1.42.0
crayon_1.5.3
labeling_0.4.3
UCSC.utils_1.6.0
xfun_0.53
jsonlite_2.0.0
DelayedArray_0.36.0
cluster_2.1.8.1
RColorBrewer_1.1-3
base64enc_0.1-3
tidyselect_1.2.1
abind_1.4-8
curl_7.0.0
plyr_1.8.9
S7_0.2.0
pillar_1.11.1
RCurl_1.98-1.17
glue_1.8.0
tools_4.5.1

restfulr_0.0.16
S4Arrays_1.10.0

64

ggbio:visualization toolkits for genomic data

## [76] dplyr_1.1.4
## [79] SparseArray_1.10.0
## [82] farver_2.1.2
## [85] lifecycle_1.0.4

gtable_0.3.6
rjson_0.2.23
memoise_2.0.1
httr_1.4.7

digest_0.6.37
htmlwidgets_1.6.4
htmltools_0.5.8.1
bit64_4.6.0-1

65

