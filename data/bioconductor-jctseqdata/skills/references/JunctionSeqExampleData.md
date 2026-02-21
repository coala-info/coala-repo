The QoRTs Analysis Pipeline
Example Walkthrough

Stephen Hartley
National Human Genome Research Institute
National Institutes of Health

November 1, 2018

QoRTs v1.0.1
JunctionSeq v1.12.0

Contents

1 Overview

2 Data Contained in this package

2.1 Example Dataset . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Annotation Files
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Count Files
2.4 Even smaller dataset . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.5 R Data Objects . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Recreating this data package

4 References

5 Legal

1 Overview

1

2
2
3
6
9
9

10

14

14

This package contains data produced by the QoRTs [4] software package, which is a fast, eﬃcient, and
portable multifunction toolkit designed to assist in the analysis, quality control, and data management
of RNA-Seq datasets. Its primary function is to aid in the detection and identiﬁcation of errors, biases,
and artifacts produced by paired-end high-throughput RNA-Seq technology. In addition, it can produce
count data designed for use with diﬀerential expression 1 and diﬀerential exon usage tools 2, as well as
individual-sample and/or group-summary genome track ﬁles suitable for use with the UCSC genome
browser (or any compatible browser).

1Such as DESeq, DESeq2 [1] or edgeR [5]
2Such as DEXSeq [2] or JunctionSeq

1

The QoRTs package is composed of two parts: a java jar-ﬁle (for data processing) and a companion R
package (for generating tables, ﬁgures, and plots). The java utility is written in the Scala programming
language (v2.11.1), however, it has been compiled to java byte-code and does not require an installation
of Scala (or any other external libraries) in order to function. The entire QoRTs toolkit can be used in
almost any operating system that supports java and R.

The most recent release of QoRTs is available on the QoRTs github page.
A complete and comprehensive walkthrough demontrating a full set of analyses using DESeq2,
edgeR, DEXSeq, and JunctionSeq, is available online, along with a full example dataset (ﬁle is 200mb)
with example bam ﬁles (ﬁle is 1.1gb).

2 Data Contained in this package

The example dataset is derived from a set of rat pineal gland samples, which were multiplexed and
sequenced across six sequencer lanes. All samples are paired-end, 2x101 base-pair, strand-speciﬁc RNA-
Seq. They were ribosome-depleted using the ”Ribo-zero Gold” protocol and aligned via RNA-STAR.
For the sake of simplicity, the example dataset was limited to only six samples and three lanes.
However, the bam ﬁles alone would still occupy 18 gigabytes of disk space, which would make it
unsuitable for distribution as an example dataset. To further reduce the example bamﬁle sizes, only
reads that mapped to chromosomes chr14, chr15, chrX, and chrM were included. Additionally, all the
selected chromosomes EXCEPT for chromosome 14 were randomly downsampled to 30 percent of their
original read counts. A few genes had additional ﬁctional transcripts added, to test and demonstrate
various tools’ handling of certain edge cases. The original dataset from which these samples were derived
is described elsewhere [3]. The original complete dataset is available on the NCBI Gene Expression
Omnibus, series accession number GSE63309.

THIS DATASET IS INTENDED FOR DEMONSTRATION AND TESTING PURPOSES ONLY.
Due to the various alterations that have been made to reduce ﬁle sizes and improve portability, it is
really not suitable for any actual analyses.

2.1 Example Dataset

For simplicity, we renamed the samples SAMP1 through SAMP6, and renamed the conditions ”CASE”
and ”CTRL” for night and day, respectively.

Thus: there are 6 samples: 3 ”cases” and 3 ”controls”:

#Read the decoder:
decoder.file <- system.file("extdata/annoFiles/decoder.bySample.txt",

decoder <- read.table(decoder.file,

package="JctSeqData");

header=TRUE,
stringsAsFactors=FALSE);

print(decoder);

##
## 1
## 2
## 3
## 4

sample.ID group.ID
CASE
CASE
CASE
CTRL

SAMP1
SAMP2
SAMP3
SAMP4

2

## 5
## 6

SAMP5
SAMP6

CTRL
CTRL

2.2 Annotation Files

There are several gtf or gﬀ annotation ﬁles included in the data package:

#The original gtf file, from Ensembl
# (all but a few genes were removed, to save space):
anno.original.gtf.file <- system.file("extdata/annoFiles/anno-original.gtf.gz",

head(read.table(anno.original.gtf.file,sep='\t'));

package="JctSeqData");

V4

V3

gene 182678 194072

exon 194056 194072

CDS 194056 194072 . -

V5 V6 V7 V8
##
V2
V1
## 1 chr14 ensembl
. - .
## 2 chr14 ensembl transcript 182678 194072 . - .
. - .
## 3 chr14 ensembl
## 4 chr14 ensembl
0
. - .
## 5 chr14 ensembl
## 6 chr14 ensembl
1
##
## 1
gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding;
## 2
## 3
gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 1; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; exon_id ENSRNOE00000562558; exon_version 1;
## 4 gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 1; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; protein_id ENSRNOP00000064731; protein_version 2;
gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; exon_id ENSRNOE00000487067; exon_version 2;
## 5
## 6 gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; protein_id ENSRNOP00000064731; protein_version 2;

CDS 192862 193068 . -

exon 192862 193068

#Modified gtf file, with a few genes
# changed to make them into a better test dataset:
anno.gtf.file <- system.file("extdata/annoFiles/anno.gtf.gz",

head(read.table(anno.gtf.file,sep='\t'));

package="JctSeqData");

V4

V3

gene 182678 194072

exon 194056 194072

CDS 194056 194072 . -

V5 V6 V7 V8
##
V2
V1
## 1 chr14 ensembl
. - .
## 2 chr14 ensembl transcript 182678 194072 . - .
. - .
## 3 chr14 ensembl
## 4 chr14 ensembl
0
. - .
## 5 chr14 ensembl
1
## 6 chr14 ensembl
##
## 1
gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding;
## 2
## 3
gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 1; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; exon_id ENSRNOE00000562558; exon_version 1;
## 4 gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 1; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; protein_id ENSRNOP00000064731; protein_version 2;
## 5
gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; exon_id ENSRNOE00000487067; exon_version 2;
## 6 gene_id ENSRNOG00000050954; gene_version 2; transcript_id ENSRNOT00000073973; transcript_version 2; exon_number 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding; transcript_name AABR07014016.1-201; transcript_source ensembl; transcript_biotype protein_coding; protein_id ENSRNOP00000064731; protein_version 2;

CDS 192862 193068 . -

exon 192862 193068

3

gene_id ENSRNOG00000050954; gene_version 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding;

gene_id ENSRNOG00000050954; gene_version 2; gene_name AABR07014016.1; gene_source ensembl; gene_biotype protein_coding;

V9

V9

#"Flattened" gff file, for DEXSeq:
DEX.gff.file <- system.file("extdata/annoFiles/DEXSeq.flat.gff.gz",

head(read.table(DEX.gff.file,sep='\t'));

package="JctSeqData");

V4

V3

V1

V2

##
V5 V6 V7 V8
## 1 chr14 QoRT_forDEXSeq aggregate_gene 182678 194072 . - .
exonic_part 182678 183555 . - .
## 2 chr14 QoRT_forDEXSeq
exonic_part 184707 184830 . - .
## 3 chr14 QoRT_forDEXSeq
exonic_part 186229 186453 . - .
## 4 chr14 QoRT_forDEXSeq
exonic_part 189146 189973 . - .
## 5 chr14 QoRT_forDEXSeq
exonic_part 190013 190189 . - .
## 6 chr14 QoRT_forDEXSeq
V9
##
## 1
gene_id ENSRNOG00000050954
## 2 gene_id ENSRNOG00000050954; transcripts ENSRNOT00000073973; exonic_part_number 001
## 3 gene_id ENSRNOG00000050954; transcripts ENSRNOT00000073973; exonic_part_number 002
## 4 gene_id ENSRNOG00000050954; transcripts ENSRNOT00000073973; exonic_part_number 003
## 5 gene_id ENSRNOG00000050954; transcripts ENSRNOT00000073973; exonic_part_number 004
## 6 gene_id ENSRNOG00000050954; transcripts ENSRNOT00000073973; exonic_part_number 005

#"Flattened" gff file, for JunctionSeq
# (w/o novel splice junctions):
JS.gff.file <- system.file("extdata/annoFiles/JunctionSeq.flat.gff.gz",
package="JctSeqData");

head(read.table(JS.gff.file,sep='\t'));

V3

V4

V2

V1

##
V5 V6 V7 V8
## 1 chr14 ScalaUtils aggregate_gene 182678 194072 . - .
exonic_part 182678 183555 . - .
## 2 chr14 ScalaUtils
exonic_part 184707 184830 . - .
## 3 chr14 ScalaUtils
exonic_part 186229 186453 . - .
## 4 chr14 ScalaUtils
exonic_part 189146 189973 . - .
## 5 chr14 ScalaUtils
exonic_part 190013 190189 . - .
## 6 chr14 ScalaUtils
##
## 1 gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 000; aggregateGeneStrand -; geneCt 1; tx_ct 1; tx_strands -
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 001; gene_set ENSRNOG00000050954
## 2
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 002; gene_set ENSRNOG00000050954
## 3
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 003; gene_set ENSRNOG00000050954
## 4
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 004; gene_set ENSRNOG00000050954
## 5
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 005; gene_set ENSRNOG00000050954
## 6

V9

#"Flattened" gff file, for JunctionSeq
# (w/ novel splice junctions):
JS.novel.gff.file <-

system.file("extdata/annoFiles/withNovel.forJunctionSeq.gff.gz",

head(read.table(JS.novel.gff.file,sep='\t'));

package="JctSeqData");

4

V1

V3

V2

V4

##
V5 V6 V7 V8
## 1 chr14 ScalaUtils aggregate_gene 182678 194072 . - .
exonic_part 182678 183555 . - .
## 2 chr14 ScalaUtils
exonic_part 184707 184830 . - .
## 3 chr14 ScalaUtils
exonic_part 186229 186453 . - .
## 4 chr14 ScalaUtils
exonic_part 189146 189973 . - .
## 5 chr14 ScalaUtils
## 6 chr14 ScalaUtils
exonic_part 190013 190189 . - .
##
## 1 gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 000; aggregateGeneStrand -; geneCt 1; tx_ct 1; tx_strands -
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 001; gene_set ENSRNOG00000050954
## 2
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 002; gene_set ENSRNOG00000050954
## 3
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 003; gene_set ENSRNOG00000050954
## 4
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 004; gene_set ENSRNOG00000050954
## 5
gene_id ENSRNOG00000050954; tx_set ENSRNOT00000073973; num 005; gene_set ENSRNOG00000050954
## 6

V9

There are several other annotation ﬁles as well:

#rn6 chrom.sizes file, from UCSC:
rn6.chrom.sizes <- system.file("extdata/annoFiles/rn6.chrom.sizes",

head(read.table(rn6.chrom.sizes,sep='\t'));

package="JctSeqData");

V1

V2
##
## 1 chr1 282763074
## 2 chr2 266435125
## 3 chr4 184226339
## 4 chr3 177699992
## 5 chr5 173707219
## 6 chrX 159970021

#stripped-down chrom.sizes file
# only includes chr14, chrX, chrM, and loose chr14 contigs:
chrom.sizes <- system.file("extdata/annoFiles/chrom.sizes",

head(read.table(chrom.sizes,sep='\t'));

package="JctSeqData");

V1

##
## 1
## 2 chr14_KL568057v1_random
## 3 chr14_KL568053v1_random
## 4 chr14_KL568054v1_random
## 5 chr14_KL568059v1_random
## 6 chr14_KL568052v1_random

V2
chr14 115493446
35355
33884
31451
27955
23128

#mapping of ensembl id to gene symbol:
ensid.2.symbol.file <- system.file("extdata/annoFiles/ensid.2.symbol.txt",

head(read.table(ensid.2.symbol.file,sep='\t',header=TRUE));

package="JctSeqData");

5

##
## 1 ENSRNOG00000002227
## 2 ENSRNOG00000002224
## 3 ENSRNOG00000002225
## 4 ENSRNOG00000030149
## 5 ENSRNOG00000038572
## 6 ENSRNOG00000054570

ENS_GENEID geneSymbol
Kit
Yipf7
Scarb2
Adgrl3
Ncapg
U4

2.3 Count Files

There are numerous count ﬁles included in this data package, intended for use with various external
analysis packages:

For use with DESeq, DESeq2, edgeR, limma-voom, or similar gene-level, count-based diﬀerential

expression tools, we can use the gene-level counts:

#Recall the decoder:
print(decoder);

##
## 1
## 2
## 3
## 4
## 5
## 6

sample.ID group.ID
CASE
CASE
CASE
CTRL
CTRL
CTRL

SAMP1
SAMP2
SAMP3
SAMP4
SAMP5
SAMP6

#Gene level counts:
gene.count.files <- system.file(paste0("extdata/cts/",

decoder$sample.ID,
"/QC.geneCounts.formatted.for.DESeq.txt.gz"
),

package="JctSeqData");

#One of the count files:
read.table(gene.count.files[1])[1:10,]

V2
##
V1
0
## 1 ENSRNOG00000000035
1
## 2 ENSRNOG00000000041
103
## 3 ENSRNOG00000000043
## 4 ENSRNOG00000000044
417
## 5 ENSRNOG00000000048 2391
7
## 6 ENSRNOG00000000060
## 7 ENSRNOG00000000062
205
## 8 ENSRNOG00000000064 1224
31
## 9 ENSRNOG00000000065
1
## 10 ENSRNOG00000000070

6

For use with DEXSeq or similar exon-level, count-based diﬀerential exon usage tools, we can use

the exon-level counts:

#Exon level counts:
exon.count.files <- system.file(paste0("extdata/cts/",

decoder$sample.ID,
"/QC.exonCounts.formatted.for.DEXSeq.txt.gz"
),

package="JctSeqData");

#Part of One of the count files:
read.table(exon.count.files[1])[110:130,]

##
V1 V2
## 110 ENSRNOG00000033073:003 0
## 111 ENSRNOG00000033073:004 0
## 112 ENSRNOG00000033073:005 0
## 113 ENSRNOG00000033073:006 0
## 114 ENSRNOG00000031928:001 0
## 115 ENSRNOG00000031928:002 0
## 116 ENSRNOG00000031928:003 0
## 117 ENSRNOG00000031928:004 0
## 118 ENSRNOG00000040213:001 20
## 119 ENSRNOG00000040213:002 11
## 120 ENSRNOG00000058018:001 1
## 121 ENSRNOG00000058018:002 0
## 122 ENSRNOG00000052352:001 5
## 123 ENSRNOG00000052352:002 1
## 124 ENSRNOG00000049828:001 30
## 125 ENSRNOG00000049828:002 10
## 126 ENSRNOG00000049828:003 6
## 127 ENSRNOG00000049828:004 10
## 128 ENSRNOG00000049828:005 18
## 129 ENSRNOG00000049828:006 17
## 130 ENSRNOG00000049828:007 8

For use with JunctionSeq, we can use a combined gene/exon/junction count ﬁle:

#JunctionSeq counts:
JS.count.files <- system.file(
paste0("extdata/cts/",

decoder$sample.ID,
"/QC.spliceJunctionAndExonCounts.forJunctionSeq.txt.gz"
),

package="JctSeqData");

#Part of one of the count files:
read.table(JS.count.files[1])[526:552,]

7

V2
##
V1
8
## 526 ENSRNOG00000024112:J043
3
## 527 ENSRNOG00000024112:J044
## 528 ENSRNOG00000024112:J045
1
## 529 ENSRNOG00000000044:A000 417
## 530 ENSRNOG00000000044:E001 188
43
## 531 ENSRNOG00000000044:E002
52
## 532 ENSRNOG00000000044:E003
59
## 533 ENSRNOG00000000044:E004
39
## 534 ENSRNOG00000000044:E005
46
## 535 ENSRNOG00000000044:E006
37
## 536 ENSRNOG00000000044:E007
53
## 537 ENSRNOG00000000044:E008
35
## 538 ENSRNOG00000000044:E009
44
## 539 ENSRNOG00000000044:E010
30
## 540 ENSRNOG00000000044:E011
15
## 541 ENSRNOG00000000044:J012
23
## 542 ENSRNOG00000000044:J013
21
## 543 ENSRNOG00000000044:J014
20
## 544 ENSRNOG00000000044:J015
18
## 545 ENSRNOG00000000044:J016
30
## 546 ENSRNOG00000000044:J017
27
## 547 ENSRNOG00000000044:J018
19
## 548 ENSRNOG00000000044:J019
14
## 549 ENSRNOG00000000044:J020
0
## 550 ENSRNOG00000000044:J021
## 551 ENSRNOG00000000048:A000 2391
38
## 552 ENSRNOG00000000048:E001

A similar ﬁle is available with novel splice junctions included:

#JunctionSeq counts:
JS.novel.count.files <- system.file(

paste0("extdata/cts/",

decoder$sample.ID,
"/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz"
),

package="JctSeqData");

#Part of one of the count files:
read.table(JS.novel.count.files[1])[526:553,]

V2
##
V1
8
## 526 ENSRNOG00000024112:J043
3
## 527 ENSRNOG00000024112:J044
## 528 ENSRNOG00000024112:J045
1
## 529 ENSRNOG00000000044:A000 417

8

## 530 ENSRNOG00000000044:E001 188
43
## 531 ENSRNOG00000000044:E002
52
## 532 ENSRNOG00000000044:E003
59
## 533 ENSRNOG00000000044:E004
39
## 534 ENSRNOG00000000044:E005
46
## 535 ENSRNOG00000000044:E006
37
## 536 ENSRNOG00000000044:E007
53
## 537 ENSRNOG00000000044:E008
35
## 538 ENSRNOG00000000044:E009
44
## 539 ENSRNOG00000000044:E010
30
## 540 ENSRNOG00000000044:E011
15
## 541 ENSRNOG00000000044:J012
23
## 542 ENSRNOG00000000044:J013
21
## 543 ENSRNOG00000000044:J014
20
## 544 ENSRNOG00000000044:J015
18
## 545 ENSRNOG00000000044:J016
30
## 546 ENSRNOG00000000044:J017
27
## 547 ENSRNOG00000000044:J018
19
## 548 ENSRNOG00000000044:J019
14
## 549 ENSRNOG00000000044:J020
0
## 550 ENSRNOG00000000044:J021
## 551 ENSRNOG00000000044:N022
9
## 552 ENSRNOG00000000048:A000 2391
38
## 553 ENSRNOG00000000048:E001

2.4 Even smaller dataset

A similar set of count ﬁles are available for an even smaller, cut-down dataset. This dataset may be
useful for running quick and easy tests.

All the count ﬁles are available in the ”extdata/tiny/” directory instead of the ”extdata/cts/”

directory. The annotation ﬁles are also available in the ”extdata/tiny” directory.

2.5 R Data Objects

This package comes with a few R data objects as well, generated by JunctionSeq for running the
JunctionSeq examples. You can load these using the commands:

To load the full dataset:

data(fullExampleDataSet,package="JctSeqData");

To load the ”tiny” dataset:

data(exampleDataSet,package="JctSeqData");

9

3 Recreating this data package

Only a small selection of the data generated and used in the pipeline walkthrough has been packaged
and distributed in the JctSeqData R package. The data had to be reorganized in order to ﬁt with the
R package format. This section describes exactly how the JctSeqData package was generated.

First you must download the full example output (ﬁle is 200mb). Optionally, you can also download

the example bam ﬁles (ﬁle is 1.1gb).

Now we copy over the template and add in the data generated in this walkthrough:

#make sure JctSeqData doesn't already exist:
rm -rf outputData/JctSeqData
#Copy over the template
cp -R inputData/JctSeqData-template outputData/JctSeqData
#Copy original annotation files:
cp inputData/annoFiles/*.* outputData/JctSeqData/inst/extdata/annoFiles/
#Copy additional generated annotation files:
cp outputData/forJunctionSeq.gff.gz

\

outputData/JctSeqData/inst/extdata/annoFiles/JunctionSeq.flat.gff.gz

cp outputData/forDEXSeq.gff.gz

\

outputData/JctSeqData/inst/extdata/annoFiles/DEXSeq.flat.gff.gz

cp outputData/countTables/orphanSplices.gff.gz

\

outputData/JctSeqData/inst/extdata/annoFiles/

cp outputData/countTables/withNovel.forJunctionSeq.gff.gz \

outputData/JctSeqData/inst/extdata/annoFiles/

#Copy count tables:
cp -R outputData/countTables/* outputData/JctSeqData/inst/extdata/cts/

10

Next we generate the ”tiny” dataset used in the JunctionSeq examples and for rapid testing. This

is done simply by using ”egrep” to extract a subset of the genes from the various ﬁles:

cd outputData/JctSeqData/inst/extdata/
#Make a "egrep" regex string to extract the desired genes:
FILTER="ENSRNOG00000048600|ENSRNOG00000045591|etc. etc.";
#Note: this is only the start of the full regex string.
#
#

see file inputData/JctSeqData-template/inst/extdata/tinyGeneList.txt
for a full list of the extracted genes.

#Subsample annotation files:
zcat annoFiles/anno.gtf.gz | \
egrep $FILTER - | \
gzip -c - > tiny/anno.gtf.gz

zcat annoFiles/JunctionSeq.flat.gff.gz | \

egrep $FILTER - | \
gzip -c - > tiny/JunctionSeq.flat.gff.gz

zcat cts/withNovel.forJunctionSeq.gff.gz | \

egrep $FILTER - | \
gzip -c - > tiny/withNovel.forJunctionSeq.gff.gz

zcat cts/withNovel.forJunctionSeq.gff.gz | \

egrep $FILTER - | \
gzip -c - > tiny/withNovel.forJunctionSeq.gff.gz

#Subsample count files:
while read line
do

mkdir ./tiny/$line
echo $line
zcat cts/$line/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz | \

egrep $FILTER - | \
gzip -c - > tiny/$line/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz

zcat cts/$line/QC.exonCounts.formatted.for.DEXSeq.txt.gz | \

egrep $FILTER - | \
gzip -c - > tiny/$line/QC.exonCounts.formatted.for.DEXSeq.txt.gz

zcat cts/$line/QC.geneCounts.formatted.for.DESeq.txt.gz | \

egrep $FILTER - | \
gzip -c - > tiny/$line/QC.geneCounts.formatted.for.DESeq.txt.gz

zcat cts/$line/QC.spliceJunctionAndExonCounts.forJunctionSeq.txt.gz | \

egrep $FILTER - | \
gzip -c - > tiny/$line/QC.spliceJunctionAndExonCounts.forJunctionSeq.txt.gz

zcat cts/$line/QC.spliceJunctionCounts.knownSplices.txt.gz | \

egrep $FILTER - | \
gzip -c - > tiny/$line/QC.spliceJunctionCounts.knownSplices.txt.gz

done < annoFiles/sampleID.list.txt
cd ../../../../

11

We can install this almost-ﬁnished version of the package using the command:

R CMD INSTALL outputData/JctSeqData

Next, we build the serialized ”Rdata” ﬁles in R. To do this, ﬁrst we load the datasets:

#Read the decoder:
decoder.file <- system.file("extdata/annoFiles/decoder.bySample.txt",

decoder <- read.table(decoder.file,

package="JctSeqData");

header=TRUE,
stringsAsFactors=FALSE);

#Here are the full-size count and gff files:
gff.file.FULL <- system.file("extdata/cts/withNovel.forJunctionSeq.gff.gz",

countFiles.FULL <- system.file(paste0("extdata/cts/",

package="JctSeqData");

decoder$sample.ID,
"/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz"),
package="JctSeqData");

#Here are the "tiny" subset count and gff files:
gff.file.TINY <- system.file("extdata/tiny/withNovel.forJunctionSeq.gff.gz",

countFiles.TINY <- system.file(paste0("extdata/tiny/",

package="JctSeqData");

decoder$sample.ID,
"/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz"),
package="JctSeqData");

12

Next, we generate the full dataset:

jscs2 <- runJunctionSeqAnalyses(sample.files = countFiles,

sample.names = decoder$sample.ID,
condition=factor(decoder$group.ID),
flat.gff.file = gff.file);

And save it:

save(jscs2, file = "outputData/JctSeqData/data/fullExampleDataSet.RData");

And then generate the ”tiny” dataset:

jscs <- runJunctionSeqAnalyses(sample.files = countFiles.TINY,

sample.names = decoder$sample.ID,
condition=factor(decoder$group.ID),
flat.gff.file = gff.file.TINY);

And save it:

save(jscs, file = "outputData/JctSeqData/data/tinyExampleDataSet.RData");

13

4 References

References

[1] S. Anders and W. Huber. Diﬀerential expression analysis for sequence count data. Genome Biology,

11:R106, 2010.

[2] S. Anders, A. Reyes, and W. Huber. Detecting diﬀerential usage of exons from RNA-seq data.

Genome Research, 22:2008, 2012.

[3] S. W. Hartley, S. L. Coon, L. E. Savastano, J. C. Mullikin, C. Fu, D. C. Klein, and N. C. S. Program.
Neurotranscriptomics: The eﬀects of neonatal stimulus deprivation on the rat pineal transcriptome.
PloS ONE, 10(9), 2015.

[4] S. W. Hartley and J. C. Mullikin. Qorts: a comprehensive toolset for quality control and data

processing of rna-seq experiments. BMC bioinformatics, 16(1):224, 2015.

[5] M. D. Robinson and G. K. Smyth. Moderated statistical tests for assessing diﬀerences in tag

abundance. Bioinformatics, 23:2881, 2007.

5 Legal

This document and related software is ”United States Government Work” under the terms of the
United States Copyright Act. It was written as part of the authors’ oﬃcial duties for the United States
Government and thus cannot be copyrighted. This software is freely available to the public for use
without a copyright notice. Restrictions cannot be placed on its present or future use.

Although all reasonable eﬀorts have been taken to ensure the accuracy and reliability of the software
and data, the National Human Genome Research Institute (NHGRI) and the U.S. Government does
not and cannot warrant the performance or results that may be obtained by using this software or
data. NHGRI and the U.S. Government disclaims all warranties as to performance, merchantability or
ﬁtness for any particular purpose.

In any work or product derived from this material, proper attribution of the authors as the source
of the software or data should be made, using ”NHGRI Genome Technology Branch” as the citation.
NOTE: The QoRTs Scala package includes (internally) the sam-JDK library (sam-1.113.jar), from

picard tools, which is licensed under the MIT license:

The MIT License
Copyright (c) 2009 The Broad Institute
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

14

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

The MIT license and copyright information can also be accessed using the command:

java -jar /path/to/jarfile/QoRTs.jar "?" samjdkinfo

JunctionSeq is based on the DEXSeq and DESeq2 packages, and is licensed with the GPL v3 license:

JunctionSeq is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

JunctionSeq is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with JunctionSeq. If not, see <http://www.gnu.org/licenses/>.

Other software mentioned in this document are subject to their own respective licenses.

15

