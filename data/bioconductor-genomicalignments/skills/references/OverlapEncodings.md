Overlap encodings

Hervé Pagès

Last modified: December 2016; Compiled: October 30, 2025

Contents

1

2

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

Load reads from a BAM file .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2.1

2.2

Load single-end reads from a BAM file .

Load paired-end reads from a BAM file .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3

Find all the overlaps between the reads and transcripts .

3.1

3.2

3.3

Load the transcripts from a TxDb object .

Single-end overlaps .
3.2.1
3.2.2

.
.
.
Find the single-end overlaps .
Tabulate the single-end overlaps .

.
.

.

.

.

.

.

Paired-end overlaps .
3.3.1
3.3.2

.
.
Find the paired-end overlaps .
.
Tabulate the paired-end overlaps .

.

.

.

.

.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.
.
.

.
.
.

.

.

.

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

Encode the overlaps between the reads and transcripts .

4.1

4.2

Single-end encodings.

Paired-end encodings.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

5

Detect “splice compatible” overlaps .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

5.1

5.2

Detect “splice compatible” single-end overlaps.
.
“Splice compatible” single-end encodings .
5.1.1
.
Tabulate the “splice compatible” single-end overlaps .
5.1.2

.
.

.
.

.
.

.
.

Detect “splice compatible” paired-end overlaps .
.
5.2.1
5.2.2

.
.
“Splice compatible” paired-end encodings .
Tabulate the “splice compatible” paired-end overlaps .

.
.

.
.

.
.

.

.

.

.
.
.

.
.
.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.

.

.
.
.

.
.
.

.

.

.

.

.
.
.

.
.
.

6

Compute the reference query sequences and project them on the
transcriptome .
.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

6.1

6.2

6.3

Compute the reference query sequences .

.

.

.

.

.

.

.

.

.

Project the single-end alignments on the transcriptome .

Project the paired-end alignments on the transcriptome .

.

.

.

.

.

.

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

2

2

4

6

6

8
8
8

10
10
10

12

12

13

14

14
14
15

17
17
18

20

20

21

22

Overlap encodings

7

Align the reads to the transcriptome .

.

.

.

.

.

.

7.1

Align the single-end reads to the transcriptome .
.
.
.
7.1.1
Find the “hits” .
.
Tabulate the “hits”
7.1.2
.
.
A closer look at the “hits” .
7.1.3

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

7.2

Align the paired-end reads to the transcriptome .

8

Detect “almost splice compatible” overlaps .

.

.

.

.
.
.
.

.

.

.

.
.
.
.

.

.

.

.
.
.
.

.

.

.

.
.
.
.

.

.

.

.
.
.
.

.

.

.

.
.
.
.

.

.

.

.
.
.
.

.

.

8.1

8.2

Detect “almost splice compatible” single-end overlaps .
8.1.1
.
8.1.2

.
“Almost splice compatible” single-end encodings .
.
Tabulate the “almost splice compatible” single-end overlaps .

.
.

.
.

.
.

Detect “almost splice compatible” paired-end overlaps .
8.2.1
.
8.2.2

.
“Almost splice compatible” paired-end encodings .
.
Tabulate the “almost splice compatible” paired-end overlaps .

.
.

.
.

.
.

9

Detect novel splice junctions .

.

.

.

9.1

9.2

By looking at single-end overlaps .

By looking at paired-end overlaps .

10

sessionInfo() .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.
.

.

.

.
.
.

.
.
.

.

.

.

.

.

.
.
.
.

.

.

.
.
.

.
.
.

.

.

.

.

23

24
24
26
26

27

27

27
27
28

29
29
30

31

31

33

33

1

Introduction

In the context of an RNA-seq experiment, encoding the overlaps between the aligned reads
and the transcripts can be used for detecting those overlaps that are “splice compatible”,
that is, compatible with the splicing of the transcript.

Various tools are provided in the GenomicAlignments package for working with overlap en-
codings. In this vignette, we illustrate the use of these tools on the single-end and paired-end
reads of an RNA-seq experiment.

2

Load reads from a BAM file

2.1

Load single-end reads from a BAM file

BAM file untreated1_chr4.bam (located in the pasillaBamSubset data package) contains
single-end reads from the “Pasilla” experiment and aligned against the dm3 genome (see ?un
treated1_chr4 in the pasillaBamSubset package for more information about those reads):

> library(pasillaBamSubset)
> untreated1_chr4()

[1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/pasillaBamSubset/extdata/untreated1_chr4.bam"

We use the readGAlignments function defined in the GenomicAlignments package to load
the reads into a GAlignments object.
It’s probably a good idea to get rid of the PCR or
optical duplicates (flag bit 0x400 in the SAM format, see the SAM Spec 1 for the details),

1http://samtools.sourceforge.net/

2

Overlap encodings

as well as reads not passing quality controls (flag bit 0x200 in the SAM format). We do this
by creating a ScanBamParam object that we pass to readGAlignments (see ?ScanBamParam
in the Rsamtools package for the details). Note that we also use use.names=TRUE in order to
load the query names (aka query template names, see QNAME field in the SAM Spec) from
the BAM file (readGAlignments will use them to set the names of the returned object):

> library(GenomicAlignments)

> flag0 <- scanBamFlag(isDuplicate=FALSE, isNotPassingQualityControls=FALSE)

> param0 <- ScanBamParam(flag=flag0)
> U1.GAL <- readGAlignments(untreated1_chr4(), use.names=TRUE, param=param0)
> head(U1.GAL)

GAlignments object with 6 alignments and 0 metadata columns:

seqnames strand

cigar

qwidth

start

end

width

njunc

<Rle> <Rle> <character> <integer> <integer> <integer> <integer> <integer>

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

-------

chr4

chr4

chr4

chr4

chr4

chr4

-

-

+

+

+

-

75M

75M

75M

75M

75M

75M

75

75

75

75

75

75

892

919

924

936

949

967

966

993

998

1010

1023

1041

75

75

75

75

75

75

0

0

0

0

0

0

seqinfo: 8 sequences from an unspecified genome

Because the aligner used to align those reads can report more than 1 alignment per original
query (i.e. per read stored in the input file, typically a FASTQ file), we shouldn’t expect the
names of U1.GAL to be unique:

> U1.GAL_names_is_dup <- duplicated(names(U1.GAL))
> table(U1.GAL_names_is_dup)

U1.GAL_names_is_dup
FALSE

TRUE

190770 13585

Storing the query names in a factor will be useful as we will see later in this document:

> U1.uqnames <- unique(names(U1.GAL))
> U1.GAL_qnames <- factor(names(U1.GAL), levels=U1.uqnames)

Note that we explicitely provide the levels of the factor to enforce their order. Otherwise
factor() would put them in lexicographic order which is not advisable because it depends
on the locale in use.

Another object that will be useful to keep near at hand is the mapping between each query
name and its first occurence in U1.GAL_qnames:

> U1.GAL_dup2unq <- match(U1.GAL_qnames, U1.GAL_qnames)

Our reads can have up to 2 skipped regions (a skipped region corresponds to an N operation
in the CIGAR):

> head(unique(cigar(U1.GAL)))

[1] "75M"

"35M6727N40M" "22M6727N53M"

"13M6727N62M"

"26M292N49M"

"62M21227N13M"

3

Overlap encodings

> table(njunc(U1.GAL))

0

1

184039 20169

2

147

Also, the following table indicates that indels were not allowed/supported during the align-
ment process (no I or D CIGAR operations):

> colSums(cigarOpTable(cigar(U1.GAL)))

M

224818

I

0

D

N

0 20463

S

0

H

0

P

0

=

0

X

0

2.2

Load paired-end reads from a BAM file

BAM file untreated3_chr4.bam (located in the pasillaBamSubset data package) contains
paired-end reads from the “Pasilla” experiment and aligned against the dm3 genome (see
?untreated3_chr4 in the pasillaBamSubset package for more information about those reads).
We use the readGAlignmentPairs function to load them into a GAlignmentPairs object:

> U3.galp <- readGAlignmentPairs(untreated3_chr4(), use.names=TRUE, param=param0)
> head(U3.galp)

GAlignmentPairs object with 6 pairs, strandMode=1, and 0 metadata columns:

seqnames strand :

ranges --

ranges

<Rle> <Rle> : <IRanges> -- <IRanges>

chr4

chr4

chr4

chr4

chr4

chr4

+ :

+ :

+ :

+ :

+ :

+ :

169-205 --

326-362

943-979 -- 1086-1122

944-980 -- 1119-1155

946-982 --

986-1022

966-1002 -- 1108-1144

966-1002 -- 1114-1150

SRR031715.1138209

SRR031714.756385

SRR031714.2355189

SRR031714.5054563

SRR031715.1722593

SRR031715.2202469

-------

seqinfo: 8 sequences from an unspecified genome

The show method for GAlignmentPairs objects displays two ranges columns, one for the first
alignment in the pair (the left column), and one for the last alignment in the pair (the right
column). The strand column corresponds to the strand of the first alignment.

> head(first(U3.galp))

GAlignments object with 6 alignments and 0 metadata columns:

seqnames strand

cigar

qwidth

start

end

width

njunc

<Rle> <Rle> <character> <integer> <integer> <integer> <integer> <integer>

SRR031715.1138209

SRR031714.756385

SRR031714.2355189

SRR031714.5054563

SRR031715.1722593

SRR031715.2202469

-------

chr4

chr4

chr4

chr4

chr4

chr4

+

+

+

+

+

+

37M

37M

37M

37M

37M

37M

37

37

37

37

37

37

169

943

944

946

966

966

205

979

980

982

1002

1002

37

37

37

37

37

37

seqinfo: 8 sequences from an unspecified genome

> head(last(U3.galp))

0

0

0

0

0

0

4

Overlap encodings

GAlignments object with 6 alignments and 0 metadata columns:

seqnames strand

cigar

qwidth

start

end

width

njunc

<Rle> <Rle> <character> <integer> <integer> <integer> <integer> <integer>

SRR031715.1138209

SRR031714.756385

SRR031714.2355189

SRR031714.5054563

SRR031715.1722593

SRR031715.2202469

-------

chr4

chr4

chr4

chr4

chr4

chr4

-

-

-

-

-

-

37M

37M

37M

37M

37M

37M

37

37

37

37

37

37

326

1086

1119

986

1108

1114

362

1122

1155

1022

1144

1150

37

37

37

37

37

37

0

0

0

0

0

0

seqinfo: 8 sequences from an unspecified genome

According to the SAM format specifications, the aligner is expected to mark each alignment
pair as proper or not (flag bit 0x2 in the SAM format). The SAM Spec only says that a pair
is proper if the first and last alignments in the pair are “properly aligned according to the
aligner”. So the exact criteria used for setting this flag is left to the aligner.

We use isProperPair to extract this flag from the GAlignmentPairs object:

> table(isProperPair(U3.galp))

FALSE

TRUE

29581 45828

Even though we could do overlap encodings with the full object, we keep only the proper
pairs for our downstream analysis:

> U3.GALP <- U3.galp[isProperPair(U3.galp)]

Because the aligner used to align those reads can report more than 1 alignment per original
query template (i.e. per pair of sequences stored in the input files, typically 1 FASTQ file for
the first ends and 1 FASTQ file for the last ends), we shouldn’t expect the names of U3.GALP
to be unique:

> U3.GALP_names_is_dup <- duplicated(names(U3.GALP))
> table(U3.GALP_names_is_dup)

U3.GALP_names_is_dup
FALSE TRUE

43659 2169

Storing the query template names in a factor will be useful:

> U3.uqnames <- unique(names(U3.GALP))
> U3.GALP_qnames <- factor(names(U3.GALP), levels=U3.uqnames)

as well as having the mapping between each query template name and its first occurence in
U3.GALP_qnames:

> U3.GALP_dup2unq <- match(U3.GALP_qnames, U3.GALP_qnames)

Our reads can have up to 1 skipped region per end:

5

Overlap encodings

> head(unique(cigar(first(U3.GALP))))

[1] "37M"

"6M58N31M" "25M56N12M" "19M62N18M" "29M222N8M" "9M222N28M"

> head(unique(cigar(last(U3.GALP))))

[1] "37M"

"19M58N18M"

"12M58N25M"

"27M2339N10M" "29M2339N8M"

"9M222N28M"

> table(njunc(first(U3.GALP)), njunc(last(U3.GALP)))

0

0 44510

1

637

1

596

85

Like for our single-end reads, the following tables indicate that indels were not allowed/supported
during the alignment process:

> colSums(cigarOpTable(cigar(first(U3.GALP))))

M

46550

I

0

D

0

N

722

S

0

H

0

P

0

> colSums(cigarOpTable(cigar(last(U3.GALP))))

M

46509

I

0

D

0

N

681

S

0

H

0

P

0

=

0

=

0

X

0

X

0

3

3.1

Find all the overlaps between the reads and tran-
scripts

Load the transcripts from a TxDb object
In order to compute overlaps between reads and transcripts, we need access to the genomic
positions of a set of known transcripts and their exons.
It is essential that the reference
genome of this set of transcripts and exons be exactly the same as the reference genome
used to align the reads.

We could use the makeTxDbFromUCSC function defined in the GenomicFeatures package to
make a TxDb object containing the dm3 transcripts and their exons retrieved from the UCSC
Genome Browser2. The Bioconductor project however provides a few annotation packages
containing TxDb objects for the most commonly studied organisms (those data packages
are sometimes called the TxDb packages). One of them is the TxDb.Dmelanogaster.UCSC.-
dm3.ensGene package. It contains a TxDb object that was made by pointing the makeTxDbFro
mUCSC function to the dm3 genome and Ensembl Genes track 3. We can use it here:

> library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)

> TxDb.Dmelanogaster.UCSC.dm3.ensGene

TxDb object:

# Db type: TxDb

# Supporting package: GenomicFeatures

2http://genome.ucsc.edu/cgi-bin/hgGateway
3See http://genome.ucsc.edu/cgi-bin/hgTrackUi?hgsid=276880911&g=ensGene for a description of this
track.

6

Overlap encodings

# Data source: UCSC

# Genome: dm3

# Organism: Drosophila melanogaster

# Taxonomy ID: 7227

# UCSC Table: ensGene

# Resource URL: http://genome.ucsc.edu/

# Type of Gene ID: Ensembl gene ID

# Full dataset: yes

# miRBase build ID: NA
# transcript_nrow: 29173
# exon_nrow: 76920
# cds_nrow: 62135
# Db created by: GenomicFeatures package from Bioconductor

# Creation time: 2015-10-07 18:15:53 +0000 (Wed, 07 Oct 2015)

# GenomicFeatures version at creation time: 1.21.30

# RSQLite version at creation time: 1.0.0

# DBSCHEMAVERSION: 1.1

> txdb <- TxDb.Dmelanogaster.UCSC.dm3.ensGene

We extract the exons grouped by transcript in a GRangesList object:

> exbytx <- exonsBy(txdb, by="tx", use.names=TRUE)

> length(exbytx) # nb of transcripts

[1] 29173

We check that all the exons in any given transcript belong to the same chromosome and
strand. Knowing that our set of transcripts is free of this sort of trans-splicing events typically
allows some significant simplifications during the downstream analysis 4. A quick and easy
way to check this is to take advantage of the fact that seqnames and strand return RleList
objects. So we can extract the number of Rle runs for each transcript and make sure it’s
always 1:

> table(elementNROWS(runLength(seqnames(exbytx))))

1

29173

> table(elementNROWS(runLength(strand(exbytx))))

1

29173

Therefore the strand of any given transcript is unambiguously defined and can be extracted
with:

> exbytx_strand <- unlist(runValue(strand(exbytx)), use.names=FALSE)

We will also need the mapping between the transcripts and their gene. We start by using
transcripts to extract this information from our TxDb object txdb, and then we construct
a named factor that represents the mapping:

4Dealing with trans-splicing events is not covered in this document.

7

Overlap encodings

> tx <- transcripts(txdb, columns=c("tx_name", "gene_id"))
> head(tx)

GRanges object with 6 ranges and 2 metadata columns:

seqnames

<Rle>

chr2L

chr2L

chr2L

ranges strand |

gene_id
<IRanges> <Rle> | <character> <CharacterList>

tx_name

7529-9484

7529-9484

7529-9484

+ | FBtr0300689

FBgn0031208

+ | FBtr0300690

FBgn0031208

+ | FBtr0330654

FBgn0031208

chr2L 21952-24237

+ | FBtr0309810

FBgn0263584

chr2L 66584-71390

+ | FBtr0306539

FBgn0067779

chr2L 67043-71081

+ | FBtr0306536

FBgn0067779

[1]

[2]

[3]

[4]

[5]

[6]

-------

seqinfo: 15 sequences (1 circular) from dm3 genome

> df <- mcols(tx)
> exbytx2gene <- as.character(df$gene_id)
> exbytx2gene <- factor(exbytx2gene, levels=unique(exbytx2gene))
> names(exbytx2gene) <- df$tx_name
> exbytx2gene <- exbytx2gene[names(exbytx)]

> head(exbytx2gene)

FBtr0300689 FBtr0300690 FBtr0330654 FBtr0309810 FBtr0306539 FBtr0306536

FBgn0031208 FBgn0031208 FBgn0031208 FBgn0263584 FBgn0067779 FBgn0067779

15682 Levels: FBgn0031208 FBgn0263584 FBgn0067779 FBgn0031213 FBgn0031214 FBgn0031216 ... FBgn0264003

> nlevels(exbytx2gene) # nb of genes

[1] 15682

3.2

Single-end overlaps

3.2.1

Find the single-end overlaps

We are ready to compute the overlaps with the findOverlaps function. Note that the
strand of the queries produced by the RNA-seq experiment is typically unknown so we use
ignore.strand=TRUE:

> U1.OV00 <- findOverlaps(U1.GAL, exbytx, ignore.strand=TRUE)

U1.OV00 is a Hits object that contains 1 element per overlap. Its length gives the number of
overlaps:

> length(U1.OV00)

[1] 563552

3.2.2

Tabulate the single-end overlaps

We will repeatedly use the 2 following little helper functions to “tabulate” the overlaps in a
given Hits object (e.g. U1.OV00), i.e. to count the number of overlaps for each element in
the query or for each element in the subject:

Number of transcripts for each alignment in U1.GAL:

8

Overlap encodings

> U1.GAL_ntx <- countQueryHits(U1.OV00)
> mcols(U1.GAL)$ntx <- U1.GAL_ntx
> head(U1.GAL)

GAlignments object with 6 alignments and 1 metadata column:

seqnames strand

cigar

qwidth

start

end

width

njunc |

<Rle> <Rle> <character> <integer> <integer> <integer> <integer> <integer> |

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

chr4

chr4

chr4

chr4

chr4

chr4

-

-

+

+

+

-

75M

75M

75M

75M

75M

75M

75

75

75

75

75

75

892

919

924

936

949

967

966

993

998

1010

1023

1041

75

75

75

75

75

75

0 |

0 |

0 |

0 |

0 |

0 |

ntx

<integer>

0

0

0

0

0

0

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

-------

seqinfo: 8 sequences from an unspecified genome

> table(U1.GAL_ntx)

U1.GAL_ntx
0

1

2

3

4

5

6

7

8

9

10

11

12

47076 9493 26146 82427 5291 14530

8158

610

1952

2099

492

4945

1136

> mean(U1.GAL_ntx >= 1)

[1] 0.7696362

76% of the alignments in U1.GAL have an overlap with at least 1 transcript in exbytx.

Note that countOverlaps can be used directly on U1.GAL and exbytx for computing U1.GAL_ntx:

> U1.GAL_ntx_again <- countOverlaps(U1.GAL, exbytx, ignore.strand=TRUE)
> stopifnot(identical(unname(U1.GAL_ntx_again), U1.GAL_ntx))

Because U1.GAL can (and actually does) contain more than 1 alignment per original query
(aka read), we also count the number of transcripts for each read:

> U1.OV10 <- remapHits(U1.OV00, Lnodes.remapping=U1.GAL_qnames)
> U1.uqnames_ntx <- countQueryHits(U1.OV10)
> names(U1.uqnames_ntx) <- U1.uqnames
> table(U1.uqnames_ntx)

U1.uqnames_ntx

0

1

2

3

4

5

6

7

8

9

10

11

12

39503 9298 18394 82346 5278 14536

9208

610

2930

2099

488

4944

1136

> mean(U1.uqnames_ntx >= 1)

[1] 0.7929287

9

Overlap encodings

78.4% of the reads have an overlap with at least 1 transcript in exbytx.

Number of reads for each transcript:

> U1.exbytx_nOV10 <- countSubjectHits(U1.OV10)
> names(U1.exbytx_nOV10) <- names(exbytx)
> mean(U1.exbytx_nOV10 >= 50)

[1] 0.009015185

Only 0.869% of the transcripts in exbytx have an overlap with at least 50 reads.

Top 10 transcripts:

> head(sort(U1.exbytx_nOV10, decreasing=TRUE), n=10)

FBtr0308296 FBtr0089175 FBtr0089176 FBtr0112904 FBtr0289951 FBtr0089243 FBtr0333672 FBtr0089186

40654

40529

40529

11735

11661

11656

10087

10084

FBtr0089187 FBtr0089172

10084

6749

3.3

Paired-end overlaps

3.3.1

Find the paired-end overlaps

Like with our single-end overlaps, we call findOverlaps with ignore.strand=TRUE:

> U3.OV00 <- findOverlaps(U3.GALP, exbytx, ignore.strand=TRUE)

Like U1.OV00, U3.OV00 is a Hits object. Its length gives the number of paired-end overlaps:

> length(U3.OV00)

[1] 113827

3.3.2

Tabulate the paired-end overlaps

Number of transcripts for each alignment pair in U3.GALP:

> U3.GALP_ntx <- countQueryHits(U3.OV00)
> mcols(U3.GALP)$ntx <- U3.GALP_ntx
> head(U3.GALP)

GAlignmentPairs object with 6 pairs, strandMode=1, and 1 metadata column:

seqnames strand :

ranges --

ranges |

ntx

<Rle> <Rle> : <IRanges> -- <IRanges> | <integer>

chr4

chr4

chr4

chr4

chr4

chr4

+ :

+ :

+ :

+ :

+ :

169-205 --

326-362 |

943-979 -- 1086-1122 |

946-982 --

986-1022 |

966-1002 -- 1108-1144 |

966-1002 -- 1114-1150 |

- : 1087-1123 --

963-999 |

0

0

0

0

0

0

SRR031715.1138209

SRR031714.756385

SRR031714.5054563

SRR031715.1722593

SRR031715.2202469

SRR031714.3544437

-------

seqinfo: 8 sequences from an unspecified genome

> table(U3.GALP_ntx)

10

Overlap encodings

U3.GALP_ntx
1
0

2

3

4

5

6

12950 2080 5854 17025 1078 3083

2021

7

70

8

9

338

370

10

59

11

803

12

97

> mean(U3.GALP_ntx >= 1)

[1] 0.7174217

71% of the alignment pairs in U3.GALP have an overlap with at least 1 transcript in exbytx.

Note that countOverlaps can be used directly on U3.GALP and exbytx for computing U3.GALP_ntx:

> U3.GALP_ntx_again <- countOverlaps(U3.GALP, exbytx, ignore.strand=TRUE)
> stopifnot(identical(unname(U3.GALP_ntx_again), U3.GALP_ntx))

Because U3.GALP can (and actually does) contain more than 1 alignment pair per original
query template, we also count the number of transcripts for each template:

> U3.OV10 <- remapHits(U3.OV00, Lnodes.remapping=U3.GALP_qnames)
> U3.uqnames_ntx <- countQueryHits(U3.OV10)
> names(U3.uqnames_ntx) <- U3.uqnames
> table(U3.uqnames_ntx)

U3.uqnames_ntx

0

1

2

3

4

5

6

11851 2061 4289 17025 1193 3084

2271

7

70

8

9

486

370

10

59

11

803

12

97

> mean(U3.uqnames_ntx >= 1)

[1] 0.7285554

72.3% of the templates have an overlap with at least 1 transcript in exbytx.

Number of templates for each transcript:

> U3.exbytx_nOV10 <- countSubjectHits(U3.OV10)
> names(U3.exbytx_nOV10) <- names(exbytx)
> mean(U3.exbytx_nOV10 >= 50)

[1] 0.00712988

Only 0.756% of the transcripts in exbytx have an overlap with at least 50 templates.

Top 10 transcripts:

> head(sort(U3.exbytx_nOV10, decreasing=TRUE), n=10)

FBtr0308296 FBtr0089175 FBtr0089176 FBtr0112904 FBtr0089243 FBtr0289951 FBtr0333672 FBtr0089186

7574

7573

7572

2750

2732

2732

2260

2260

FBtr0089187 FBtr0310542

2260

1698

11

Overlap encodings

4

4.1

Encode the overlaps between the reads and tran-
scripts

Single-end encodings
The overlap encodings are strand sensitive so we will compute them twice, once for the
“original alignments” (i.e. the alignments of the original queries), and once again for the
“flipped alignments” (i.e. the alignments of the “flipped original queries”). We extract the
ranges of the “original” and “flipped” alignments in 2 GRangesList objects with:

> U1.grl <- grglist(U1.GAL, order.as.in.query=TRUE)

> U1.grlf <- flipQuery(U1.grl) # flipped

and encode their overlaps with the transcripts:

> U1.ovencA <- encodeOverlaps(U1.grl, exbytx, hits=U1.OV00)

> U1.ovencB <- encodeOverlaps(U1.grlf, exbytx, hits=U1.OV00)

U1.ovencA and U1.ovencB are 2 OverlapsEncodings objects of the same length as Hits object
U1.OV00. For each hit in U1.OV00, we have 2 corresponding encodings, one in U1.ovencA
and one in U1.ovencB, but only one of them encodes a hit between alignment ranges and
exon ranges that are on the same strand. We use the selectEncodingWithCompatibleStrand
function to merge them into a single OverlapsEncodings of the same length. For each hit in
U1.OV00, this selects the encoding corresponding to alignment ranges and exon ranges with
compatible strand:

> U1.grl_strand <- unlist(runValue(strand(U1.grl)), use.names=FALSE)
> U1.ovenc <- selectEncodingWithCompatibleStrand(U1.ovencA, U1.ovencB,

+

+

> U1.ovenc

U1.grl_strand, exbytx_strand,
hits=U1.OV00)

OverlapEncodings object of length 563552 with 0 metadata columns:

Loffset

Roffset encoding flippedQuery

<integer> <integer> <factor>

<logical>

[1]

[2]

[3]

[4]

[5]

...

[563548]

[563549]

[563550]

[563551]

[563552]

0

4

4

4

4

3

0

0

0

0

...

...

22

23

24

24

23

0

0

0

0

0

1:i:

1:k:

1:k:

1:k:

1:k:

...

1:i:

1:i:

1:i:

1:i:

1:i:

TRUE

FALSE

TRUE

TRUE

TRUE

...

TRUE

TRUE

TRUE

TRUE

TRUE

As a convenience, the 2 above calls to encodeOverlaps + merging step can be replaced by a
single call to encodeOverlaps on U1.grl (or U1.grlf) with flip.query.if.wrong.strand=TRUE:

> U1.ovenc_again <- encodeOverlaps(U1.grl, exbytx, hits=U1.OV00, flip.query.if.wrong.strand=TRUE)
> stopifnot(identical(U1.ovenc_again, U1.ovenc))

12

Overlap encodings

Unique encodings in U1.ovenc:

> U1.unique_encodings <- levels(U1.ovenc)
> length(U1.unique_encodings)

[1] 120

> head(U1.unique_encodings)

[1] "1:c:" "1:e:" "1:f:" "1:h:" "1:i:" "1:j:"

> U1.ovenc_table <- table(encoding(U1.ovenc))
> tail(sort(U1.ovenc_table))

1:f:

1555

1:k:c:

1889

1:k:

8800

1:c: 2:jm:af:

1:i:

9523

72929

455176

Encodings are sort of cryptic but utilities are provided to extract specific meaning from them.
Use of these utilities is covered later in this document.

4.2

Paired-end encodings
Let’s encode the overlaps in U3.OV00:

> U3.grl <- grglist(U3.GALP)

> U3.ovenc <- encodeOverlaps(U3.grl, exbytx, hits=U3.OV00, flip.query.if.wrong.strand=TRUE)

> U3.ovenc

OverlapEncodings object of length 113827 with 0 metadata columns:

Loffset

Roffset

encoding flippedQuery

<integer> <integer>

<factor>

<logical>

TRUE

TRUE

FALSE

FALSE

TRUE

...

TRUE

TRUE

TRUE

TRUE

TRUE

[1]

[2]

[3]

[4]

[5]

...

[113823]

[113824]

[113825]

[113826]

[113827]

4

4

4

4

4

0 1--1:i--k:

0 1--1:i--i:

0 1--1:i--k:

0 1--1:i--k:

0 1--1:a--c:

...

...

...

22

23

24

24

23

0 1--1:i--i:

0 1--1:i--i:

0 1--1:i--i:

0 1--1:i--i:

0 1--1:i--i:

Unique encodings in U3.ovenc:

> U3.unique_encodings <- levels(U3.ovenc)
> length(U3.unique_encodings)

[1] 123

> head(U3.unique_encodings)

[1] "1--1:a--c:" "1--1:a--i:" "1--1:a--j:" "1--1:a--k:" "1--1:b--i:" "1--1:b--k:"

> U3.ovenc_table <- table(encoding(U3.ovenc))
> tail(sort(U3.ovenc_table))

13

Overlap encodings

1--1:i--m:

1--1:i--k:

1--1:c--i: 1--2:i--jm:a--af: 2--1:jm--m:af--i:

852

1--1:i--i:

100084

1485

1714

2480

2700

5

Detect “splice compatible” overlaps

We are interested in a particular type of overlap where the read overlaps the transcript in
a “splice compatible” way, that is, in a way that is compatible with the splicing of the
transcript. The isCompatibleWithSplicing function can be used on an OverlapEncodings
object to detect this type of overlap. Note that isCompatibleWithSplicing can also be used
on a character vector or factor.

5.1

Detect “splice compatible” single-end overlaps

5.1.1

“Splice compatible” single-end encodings

U1.ovenc contains 7 unique encodings compatible with the splicing of the transcript:

> sort(U1.ovenc_table[isCompatibleWithSplicing(U1.unique_encodings)])

2:jm:ag:

2:gm:af: 3:jmm:agm:aaf:

32

1:i:

455176

79

488

1:j:

1538

1:f:

1555

2:jm:af:

72929

Encodings "1:i:" (455176 occurences in U1.ovenc), "2:jm:af:" (72929 occurences in U1.ovenc),
and "3:jmm:agm:aaf:" (488 occurences in U1.ovenc), correspond to the following overlaps:

• "1:i:"

- read (no skipped region):

oooooooo

- transcript:

...

>>>>>>>>>>>>>>

...

• "2:jm:af:"

- read (1 skipped region):

ooooo---ooo

- transcript:

...

>>>>>>>>>

>>>>>>>>>

...

• "3:jmm:agm:aaf:"

- read (2 skipped regions):

oo---ooooo---o

- transcript:

...

>>>>>>>>

>>>>>

>>>>>>>

...

For clarity, only the exons involved in the overlap are represented. The transcript can of
course have more upstream and downstream exons, which is denoted by the ... on the left
side (5’ end) and right side (3’ end) of each drawing. Note that the exons represented in the
2nd and 3rd drawings are consecutive and adjacent in the processed transcript.

Encodings "1:f:" and "1:j:" are variations of the situation described by encoding "1:i:".
For "1:f:", the first aligned base of the read (or “flipped” read) is aligned with the first base
of the exon. For "1:j:", the last aligned base of the read (or “flipped” read) is aligned with
the last base of the exon:

• "1:f:"

14

Overlap encodings

- read (no skipped region):

oooooooo

- transcript:

...

>>>>>>>>>>>>>>

...

• "1:j:"

- read (no skipped region):

oooooooo

- transcript:

...

>>>>>>>>>>>>>>

...

> U1.OV00_is_comp <- isCompatibleWithSplicing(U1.ovenc)
> table(U1.OV00_is_comp) # 531797 "splice compatible" overlaps

U1.OV00_is_comp
FALSE

TRUE

31755 531797

Finally, let’s extract the “splice compatible” overlaps from U1.OV00:

> U1.compOV00 <- U1.OV00[U1.OV00_is_comp]

Note that high-level convenience wrapper findCompatibleOverlaps can be used for com-
puting the “splice compatible” overlaps directly between a GAlignments object (containing
reads) and a GRangesList object (containing transcripts):

> U1.compOV00_again <- findCompatibleOverlaps(U1.GAL, exbytx)
> stopifnot(identical(U1.compOV00_again, U1.compOV00))

5.1.2

Tabulate the “splice compatible” single-end overlaps

Number of “splice compatible” transcripts for each alignment in U1.GAL:

> U1.GAL_ncomptx <- countQueryHits(U1.compOV00)
> mcols(U1.GAL)$ncomptx <- U1.GAL_ncomptx
> head(U1.GAL)

GAlignments object with 6 alignments and 2 metadata columns:

seqnames strand

cigar

qwidth

start

end

width

njunc |

<Rle> <Rle> <character> <integer> <integer> <integer> <integer> <integer> |

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

chr4

chr4

chr4

chr4

chr4

chr4

-

-

+

+

+

-

75M

75M

75M

75M

75M

75M

75

75

75

75

75

75

892

919

924

936

949

967

966

993

998

1010

1023

1041

75

75

75

75

75

75

0 |

0 |

0 |

0 |

0 |

0 |

ntx

ncomptx

<integer> <integer>

0

0

0

0

0

0

0

0

0

0

0

0

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

-------

seqinfo: 8 sequences from an unspecified genome

> table(U1.GAL_ncomptx)

15

Overlap encodings

U1.GAL_ncomptx

0

1

2

3

4

5

6

7

8

9

10

11

51101 9848 33697 72987 5034 14021

7516

581

1789

2015

530

4389

12

847

> mean(U1.GAL_ncomptx >= 1)

[1] 0.7499401

75% of the alignments in U1.GAL are “splice compatible” with at least 1 transcript in exbytx.

Note that high-level convenience wrapper countCompatibleOverlaps can be used directly on
U1.GAL and exbytx for computing U1.GAL_ncomptx:

> U1.GAL_ncomptx_again <- countCompatibleOverlaps(U1.GAL, exbytx)
> stopifnot(identical(U1.GAL_ncomptx_again, U1.GAL_ncomptx))

Number of “splice compatible” transcripts for each read:

> U1.compOV10 <- remapHits(U1.compOV00, Lnodes.remapping=U1.GAL_qnames)
> U1.uqnames_ncomptx <- countQueryHits(U1.compOV10)
> names(U1.uqnames_ncomptx) <- U1.uqnames
> table(U1.uqnames_ncomptx)

U1.uqnames_ncomptx
2

1

0

3

4

5

6

7

8

9

10

11

42886 9711 26075 72989 5413 14044

8584

581

2706

2015

530

4389

> mean(U1.uqnames_ncomptx >= 1)

[1] 0.7751953

12

847

77.5% of the reads are “splice compatible” with at least 1 transcript in exbytx.

Number of “splice compatible” reads for each transcript:

> U1.exbytx_ncompOV10 <- countSubjectHits(U1.compOV10)
> names(U1.exbytx_ncompOV10) <- names(exbytx)
> mean(U1.exbytx_ncompOV10 >= 50)

[1] 0.008706681

Only 0.87% of the transcripts in exbytx are “splice compatible” with at least 50 reads.

Top 10 transcripts:

> head(sort(U1.exbytx_ncompOV10, decreasing=TRUE), n=10)

FBtr0308296 FBtr0089175 FBtr0089176 FBtr0089243 FBtr0289951 FBtr0112904 FBtr0089186 FBtr0089187

40309

40158

33490

11365

11332

11284

10018

9627

FBtr0333672 FBtr0089172

9568

6599

Note that this “top 10” is slightly different from the “top 10” we obtained earlier when we
counted all the overlaps.

16

Overlap encodings

5.2

Detect “splice compatible” paired-end overlaps

5.2.1

“Splice compatible” paired-end encodings

WARNING: For paired-end encodings, isCompatibleWithSplicing considers that the encod-
ing is “splice compatible” if its 2 halves are “splice compatible”. This can produce false
positives if for example the right end of the alignment is located upstream of the left end
in transcript space. The paired-end read could not come from this transcript. To eliminate
these false positives, one would need to look at the position of the left and right ends in
transcript space. This can be done with extractQueryStartInTranscript.

U3.ovenc contains 13 unique paired-end encodings compatible with the splicing of the tran-
script:

> sort(U3.ovenc_table[isCompatibleWithSplicing(U3.unique_encodings)])

1--2:f--jm:a--af:

1--1:f--j:

2--1:jm--m:af--j:

2--1:jm--m:af--f:

1--1:j--m:a--i:

2--2:jm--jm:af--af:

3

12

21

2--2:jm--mm:af--jm:aa--af:

1--1:i--m:a--i:

153

287

24

51

64

1--1:i--j:

403

1--1:f--i:

1--2:i--jm:a--af:

2--1:jm--m:af--i:

617

1--1:i--i:

100084

2480

2700

Paired-end encodings "1--1:i- (100084 occurences in U3.ovenc), "2--1:jm--m:a (2700 oc-
curences in U3.ovenc), "1--2:i--jm:a (2480 occurences in U3.ovenc), "1--1:i--m: (287
occurences in U3.ovenc), and "2--2:jm--mm:af--jm: (153 occurences in U3.ovenc), corre-
spond to the following paired-end overlaps:

• "1--1:i-

- paired-end read (no skipped region on the first end, no skipped region

on the last end):

oooo

oooo

- transcript:

...

>>>>>>>>>>>>>>>>

...

• "2--1:jm--m:a

- paired-end read (1 skipped region on the first end, no skipped region

on the last end):

ooo---o

oooo

- transcript:

...

>>>>>>>>

>>>>>>>>>>>

...

• "1--2:i--jm:a

- paired-end read (no skipped region on the first end, 1 skipped region

on the last end):

oooo

oo---oo

- transcript:

...

>>>>>>>>>>>>>>

>>>>>>>>>

...

• "1--1:i--m:

- paired-end read (no skipped region on the first end, no skipped region

on the last end):

oooo

oooo

- transcript:

...

>>>>>>>>>

>>>>>>>

...

• "2--2:jm--mm:af--jm:

17

Overlap encodings

- paired-end read (1 skipped region on the first end, 1 skipped region

on the last end):

ooo---o

oo---oo

- transcript:

...

>>>>>>

>>>>>>>

>>>>>

...

Note: switch use of “first” and “last” above if the read was “flipped”.

> U3.OV00_is_comp <- isCompatibleWithSplicing(U3.ovenc)
> table(U3.OV00_is_comp) # 106835 "splice compatible" paired-end overlaps

U3.OV00_is_comp
FALSE

TRUE

6928 106899

Finally, let’s extract the “splice compatible” paired-end overlaps from U3.OV00:

> U3.compOV00 <- U3.OV00[U3.OV00_is_comp]

Note that, like with our single-end reads, high-level convenience wrapper findCompatibleOver
laps can be used for computing the “splice compatible” paired-end overlaps directly between a
GAlignmentPairs object (containing paired-end reads) and a GRangesList object (containing
transcripts):

> U3.compOV00_again <- findCompatibleOverlaps(U3.GALP, exbytx)
> stopifnot(identical(U3.compOV00_again, U3.compOV00))

5.2.2

Tabulate the “splice compatible” paired-end overlaps

Number of “splice compatible” transcripts for each alignment pair in U3.GALP:

> U3.GALP_ncomptx <- countQueryHits(U3.compOV00)
> mcols(U3.GALP)$ncomptx <- U3.GALP_ncomptx
> head(U3.GALP)

GAlignmentPairs object with 6 pairs, strandMode=1, and 2 metadata columns:

seqnames strand :

ranges --

ranges |

ntx

ncomptx

<Rle> <Rle> : <IRanges> -- <IRanges> | <integer> <integer>

chr4

chr4

chr4

chr4

chr4

chr4

+ :

+ :

+ :

+ :

+ :

169-205 --

326-362 |

943-979 -- 1086-1122 |

946-982 --

986-1022 |

966-1002 -- 1108-1144 |

966-1002 -- 1114-1150 |

- : 1087-1123 --

963-999 |

0

0

0

0

0

0

0

0

0

0

0

0

SRR031715.1138209

SRR031714.756385

SRR031714.5054563

SRR031715.1722593

SRR031715.2202469

SRR031714.3544437

-------

seqinfo: 8 sequences from an unspecified genome

> table(U3.GALP_ncomptx)

U3.GALP_ncomptx

0

1

2

3

4

5

6

13884 2029 8094 14337 1099 2954

1865

7

84

8

9

296

332

10

89

11

699

12

66

> mean(U3.GALP_ncomptx >= 1)

[1] 0.6970411

18

Overlap encodings

69.7% of the alignment pairs in U3.GALP are “splice compatible” with at least 1 transcript in
exbytx.

Note that high-level convenience wrapper countCompatibleOverlaps can be used directly on
U3.GALP and exbytx for computing U3.GALP_ncomptx:

> U3.GALP_ncomptx_again <- countCompatibleOverlaps(U3.GALP, exbytx)
> stopifnot(identical(U3.GALP_ncomptx_again, U3.GALP_ncomptx))

Number of “splice compatible” transcripts for each template:

> U3.compOV10 <- remapHits(U3.compOV00, Lnodes.remapping=U3.GALP_qnames)
> U3.uqnames_ncomptx <- countQueryHits(U3.compOV10)
> names(U3.uqnames_ncomptx) <- U3.uqnames
> table(U3.uqnames_ncomptx)

U3.uqnames_ncomptx
2

1

0

3

4

5

6

12769 2027 6534 14337 1210 2954

2114

> mean(U3.uqnames_ncomptx >= 1)

[1] 0.7075288

7

84

8

9

444

332

10

89

11

699

12

66

70.7% of the templates are “splice compatible” with at least 1 transcript in exbytx.

Number of “splice compatible” templates for each transcript:

> U3.exbytx_ncompOV10 <- countSubjectHits(U3.compOV10)
> names(U3.exbytx_ncompOV10) <- names(exbytx)
> mean(U3.exbytx_ncompOV10 >= 50)

[1] 0.007061324

Only 0.7% of the transcripts in exbytx are “splice compatible” with at least 50 templates.

Top 10 transcripts:

> head(sort(U3.exbytx_ncompOV10, decreasing=TRUE), n=10)

FBtr0308296 FBtr0089175 FBtr0089176 FBtr0289951 FBtr0089243 FBtr0112904 FBtr0089187 FBtr0089186

7425

7419

5227

2686

2684

2640

2257

2250

FBtr0333672 FBtr0310542

2206

1650

Note that this “top 10” is slightly different from the “top 10” we obtained earlier when we
counted all the paired-end overlaps.

19

Overlap encodings

6

6.1

Compute the reference query sequences and project
them on the transcriptome

Compute the reference query sequences
The reference query sequences are the query sequences after alignment, by opposition to
the original query sequences (aka “true” or “real” query sequences) which are the query
sequences before alignment.

The reference query sequences can easily be computed by extracting the nucleotides mapped
to each read from the reference genome. This of course requires that we have access to the
In Bioconductor, the full genome sequence for the
reference genome used by the aligner.
dm3 assembly is stored in the BSgenome.Dmelanogaster.UCSC.dm3 data package 5:

> library(BSgenome.Dmelanogaster.UCSC.dm3)

> Dmelanogaster

| BSgenome object for Fly

| - organism: Drosophila melanogaster

| - provider: UCSC

| - genome: dm3

| - release date: Apr. 2006

| - 15 sequence(s):

chr2L

chr2R

chr3L

chr3R

chr4

chrX

chrU

chrM

chr2LHet

chr2RHet chr3LHet chr3RHet

chrXHet

chrYHet

chrUextra

|

|

|

| Tips: call 'seqnames()' on the object to get all the sequence names, call 'seqinfo()' to get the

| full sequence info, use the '$' or '[[' operator to access a given sequence, see '?BSgenome' for

| more information.

To extract the portions of the reference genome corresponding to the ranges in U1.grl, we
can use the extractTranscriptSeqs function defined in the GenomicFeatures package:

> library(GenomicFeatures)
> U1.GAL_rqseq <- extractTranscriptSeqs(Dmelanogaster, U1.grl)
> head(U1.GAL_rqseq)

DNAStringSet object of length 6:

width seq

names

[1]

[2]

[3]

[4]

[5]

[6]

75 GGACAACCTAGCCAGGAAAGGGGCAGAGAACCC...GCCCGAACCATTCTGTGGTGTTGGTCACCACAG SRR031729.3941844

75 CAACAACATCCCGGGAAATGAGCTAGCGGACAA...GAAAGGGGCAGAGAACCCTCTAATTGGGCCCGA SRR031728.3674563

75 CCCAATTAGAGGGTTCTCTGCCCCTTTCCTGGC...CGCTAGCTCATTTCCCGGGATGTTGTTGTGTCC SRR031729.8532600

75 GTTCTCTGCCCCTTTCCTGGCTAGGTTGTCCGC...TCCCGGGATGTTGTTGTGTCCCGGGACCCACCT SRR031729.2779333

75 TTCCTGGCTAGGTTGTCCGCTAGCTCATTTCCC...TTGTGTCCCGGGACCCACCTTATTGTGAGTTTG SRR031728.2826481

75 CAAACTTGGAGCTGTCAACAAACTCACAATAAG...GGGACACAACAACATCCCGGGAAATGAGCTAGC SRR031728.2919098

When reads are paired-end, we need to extract separately the ranges corresponding to their
first ends (aka first segments in BAM jargon) and those corresponding to their last ends (aka
last segments in BAM jargon):

5See http://bioconductor.org/packages/release/data/annotation/ for the full list of annotation packages
available in the current release of Bioconductor.

20

Overlap encodings

> U3.grl_first <- grglist(first(U3.GALP, real.strand=TRUE), order.as.in.query=TRUE)
> U3.grl_last <- grglist(last(U3.GALP, real.strand=TRUE), order.as.in.query=TRUE)

Then we extract the portions of the reference genome corresponding to the ranges in GRanges-
List objects U3.grl_first and U3.grl_last:

> U3.GALP_rqseq1 <- extractTranscriptSeqs(Dmelanogaster, U3.grl_first)
> U3.GALP_rqseq2 <- extractTranscriptSeqs(Dmelanogaster, U3.grl_last)

6.2

Project the single-end alignments on the transcriptome
The extractQueryStartInTranscript function computes for each overlap the position of the
query start in the transcript:

> U1.OV00_qstart <- extractQueryStartInTranscript(U1.grl, exbytx,
+
> head(subset(U1.OV00_qstart, U1.OV00_is_comp))

hits=U1.OV00, ovenc=U1.ovenc)

startInTranscript firstSpannedExonRank startInFirstSpannedExon

1

8

9

10

11

12

100

4229

4229

4207

4207

4187

1

5

5

5

5

5

100

137

137

115

115

95

U1.OV00_qstart is a data frame with 1 row per overlap and 3 columns:

1. startInTranscript: the 1-based start position of the read with respect to the tran-
script. Position 1 always corresponds to the first base on the 5’ end of the transcript
sequence.

2. firstSpannedExonRank: the rank of the first exon spanned by the read, that is, the

rank of the exon found at position startInTranscript in the transcript.

3. startInFirstSpannedExon: the 1-based start position of the read with respect to the

first exon spanned by the read.

Having this information allows us for example to compare the read and transcript nucleotide
sequences for each “splice compatible” overlap. If we use the reference query sequence instead
of the original query sequence for this comparison, then it should match exactly the sequence
found at the query start in the transcript.

Let’s start by using extractTranscriptSeqs again to extract the transcript sequences (aka
transcriptome) from the dm3 reference genome:

> txseq <- extractTranscriptSeqs(Dmelanogaster, exbytx)

For each “splice compatible” overlap, the read sequence in U1.GAL_rqseq must be an exact
substring of the transcript sequence in exbytx_seq:

> U1.OV00_rqseq <- U1.GAL_rqseq[queryHits(U1.OV00)]
> U1.OV00_rqseq[flippedQuery(U1.ovenc)] <- reverseComplement(U1.OV00_rqseq[flippedQuery(U1.ovenc)])
> U1.OV00_txseq <- txseq[subjectHits(U1.OV00)]

21

Overlap encodings

> stopifnot(all(

U1.OV00_rqseq[U1.OV00_is_comp] ==

narrow(U1.OV00_txseq[U1.OV00_is_comp],

start=U1.OV00_qstart$startInTranscript[U1.OV00_is_comp],
width=width(U1.OV00_rqseq)[U1.OV00_is_comp])

+

+

+

+

+ ))

Because of this relationship between the reference query sequence and the transcript sequence
of a “splice compatible” overlap, and because of the relationship between the original query
sequences and the reference query sequences, then the edit distance reported in the NM
tag is actually the edit distance between the original query and the transcript of a “splice
compatible” overlap.

6.3

Project the paired-end alignments on the transcriptome
For a paired-end read, the query start is the start of its “left end”.

> U3.OV00_Lqstart <- extractQueryStartInTranscript(U3.grl, exbytx,
+
> head(subset(U3.OV00_Lqstart, U3.OV00_is_comp))

hits=U3.OV00, ovenc=U3.ovenc)

startInTranscript firstSpannedExonRank startInFirstSpannedExon

2

7

8

9

10

11

4118

3940

3940

3692

3692

3690

5

4

4

3

3

3

26

31

31

320

320

318

Note that extractQueryStartInTranscript can be called with for.query.right.end=TRUE
if we want this information for the “right ends” of the reads:

> U3.OV00_Rqstart <- extractQueryStartInTranscript(U3.grl, exbytx,
+

hits=U3.OV00, ovenc=U3.ovenc,

+
> head(subset(U3.OV00_Rqstart, U3.OV00_is_comp))

for.query.right.end=TRUE)

startInTranscript firstSpannedExonRank startInFirstSpannedExon

2

7

8

9

10

11

4267

3948

3948

3849

3849

3831

5

4

4

3

3

3

175

39

39

477

477

459

Like with single-end reads, having this information allows us for example to compare the
read and transcript nucleotide sequences for each “splice compatible” overlap. If we use the
reference query sequence instead of the original query sequence for this comparison, then
it should match exactly the sequences of the “left” and “right” ends of the read in the
transcript.

Let’s assign the “left and right reference query sequences” to each overlap:

22

Overlap encodings

> U3.OV00_Lrqseq <- U3.GALP_rqseq1[queryHits(U3.OV00)]
> U3.OV00_Rrqseq <- U3.GALP_rqseq2[queryHits(U3.OV00)]

For the single-end reads, the sequence associated with a “flipped query” just needed to be
“reverse complemented”. For paired-end reads, we also need to swap the 2 sequences in the
pair:

> flip_idx <- which(flippedQuery(U3.ovenc))
> tmp <- U3.OV00_Lrqseq[flip_idx]
> U3.OV00_Lrqseq[flip_idx] <- reverseComplement(U3.OV00_Rrqseq[flip_idx])
> U3.OV00_Rrqseq[flip_idx] <- reverseComplement(tmp)

Let’s assign the transcript sequence to each overlap:

> U3.OV00_txseq <- txseq[subjectHits(U3.OV00)]

For each “splice compatible” overlap, we expect the “left and right reference query sequences”
of the read to be exact substrings of the transcript sequence. Let’s check the “left reference
query sequences”:

> stopifnot(all(

U3.OV00_Lrqseq[U3.OV00_is_comp] ==

narrow(U3.OV00_txseq[U3.OV00_is_comp],

start=U3.OV00_Lqstart$startInTranscript[U3.OV00_is_comp],
width=width(U3.OV00_Lrqseq)[U3.OV00_is_comp])

+

+

+

+

+ ))

and the “right reference query sequences”:

> stopifnot(all(

U3.OV00_Rrqseq[U3.OV00_is_comp] ==

narrow(U3.OV00_txseq[U3.OV00_is_comp],

start=U3.OV00_Rqstart$startInTranscript[U3.OV00_is_comp],
width=width(U3.OV00_Rrqseq)[U3.OV00_is_comp])

+

+

+

+

+ ))

7

Align the reads to the transcriptome

Aligning the reads to the reference genome is not the most efficient nor accurate way to
count the number of “splice compatible” overlaps per original query. Supporting junction
reads that align with at least 1 skipped region in their CIGAR) introduces a
reads (i.e.
significant computational cost during the alignment process. Then, as we’ve seen in the
previous sections, each alignment produced by the aligner needs to be broken into a set of
ranges (based on its CIGAR) and those ranges compared to the ranges of the exons grouped
by transcript.

A more straightforward and accurate approach is to align the reads directly to the transcrip-
tome, and without allowing the typical skipped region that the aligner needs to introduce
when aligning a junction read to the reference genome. With this approach, a “hit” be-
tween a read and a transcript is necessarily compatible with the splicing of the transcript.

23

Overlap encodings

In case of a “hit”, we’ll say that the read and the transcript are “string-based compatible”
(to differentiate from our previous notion of “splice compatible” overlaps that we will call
“encoding-based compatible” in this section).

7.1

Align the single-end reads to the transcriptome

7.1.1

Find the “hits”

The single-end reads are in U1.oqseq, the transcriptome is in exbytx_seq.

Since indels were not allowed/supported during the alignment of the reads to the reference
genome, we don’t need to allow/support them either for aligning the reads to the transcrip-
tome. Also since our goal is to find (and count) “splice compatible” overlaps between reads
and transcripts, we don’t need to keep track of the details of the alignments between the
reads and the transcripts. Finally, since BAM file untreated1_chr4.bam is not the full output
of the aligner but the subset obtained by keeping only the alignments located on chr4, we
don’t need to align U1.oqseq to the full transcriptome, but only to the subset of exbytx_seq
made of the transcripts located on chr4.

With those simplifications in mind, we write the following function that we will use to find
the “hits” between the reads and the transcriptome:

> ### A wrapper to vwhichPDict() that supports IUPAC ambiguity codes in 'qseq'

> ### and 'txseq', and treats them as such.

> findSequenceHits <- function(qseq, txseq, which.txseq=NULL, max.mismatch=0)

+ {

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

.asHits <- function(x, pattern_length)
{

query_hits <- unlist(x)
if (is.null(query_hits))

query_hits <- integer(0)

subject_hits <- rep.int(seq_len(length(x)), elementNROWS(x))
Hits(query_hits, subject_hits, pattern_length, length(x),

sort.by.query=TRUE)

}

.isHitInTranscriptBounds <- function(hits, qseq, txseq)

{

}

sapply(seq_len(length(hits)),

function(i) {

pattern <- qseq[[queryHits(hits)[i]]]

subject <- txseq[[subjectHits(hits)[i]]]

v <- matchPattern(pattern, subject,

any(1L <= start(v) & end(v) <= length(subject))

max.mismatch=max.mismatch, fixed=FALSE)

})

if (!is.null(which.txseq)) {

txseq0 <- txseq

txseq <- txseq[which.txseq]

}

24

Overlap encodings

names(qseq) <- NULL

other <- alphabetFrequency(qseq, baseOnly=TRUE)[ , "other"]
is_clean <- other == 0L # "clean" means "no IUPAC ambiguity code"

## Find hits for "clean" original queries.
qseq0 <- qseq[is_clean]
pdict0 <- PDict(qseq0, max.mismatch=max.mismatch)

m0 <- vwhichPDict(pdict0, txseq,

max.mismatch=max.mismatch, fixed="pattern")

hits0 <- .asHits(m0, length(qseq0))

hits0@nLnode <- length(qseq)
hits0@from <- which(is_clean)[hits0@from]

## Find hits for non "clean" original queries.
qseq1 <- qseq[!is_clean]
m1 <- vwhichPDict(qseq1, txseq,

max.mismatch=max.mismatch, fixed=FALSE)

hits1 <- .asHits(m1, length(qseq1))

hits1@nLnode <- length(qseq)
hits1@from <- which(!is_clean)[hits1@from]

## Combine the hits.
query_hits <- c(queryHits(hits0), queryHits(hits1))
subject_hits <- c(subjectHits(hits0), subjectHits(hits1))

if (!is.null(which.txseq)) {

## Remap the hits.

txseq <- txseq0
subject_hits <- which.txseq[subject_hits]
hits0@nRnode <- length(txseq)

}

## Order the hits.
oo <- orderIntegerPairs(query_hits, subject_hits)
hits0@from <- query_hits[oo]
hits0@to <- subject_hits[oo]

if (max.mismatch != 0L) {

## Keep only "in bounds" hits.
is_in_bounds <- .isHitInTranscriptBounds(hits0, qseq, txseq)
hits0 <- hits0[is_in_bounds]

}

hits0

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+

+ }

Let’s compute the index of the transcripts in exbytx_seq located on chr4 (findSequenceHits
will restrict the search to those transcripts):

> chr4tx <- transcripts(txdb, vals=list(tx_chrom="chr4"))
> chr4txnames <- mcols(chr4tx)$tx_name
> which.txseq <- match(chr4txnames, names(txseq))

25

Overlap encodings

We know that the aligner tolerated up to 6 mismatches per read. The 3 following commands
find the “hits” for each original query, then find the “hits” for each “flipped original query”,
and finally merge all the “hits” (note that the 3 commands take about 1 hour to complete
on a modern laptop):

> U1.sbcompHITSa <- findSequenceHits(U1.oqseq, txseq,

+

which.txseq=which.txseq, max.mismatch=6)

> U1.sbcompHITSb <- findSequenceHits(reverseComplement(U1.oqseq), txseq,

+

which.txseq=which.txseq, max.mismatch=6)

> U1.sbcompHITS <- union(U1.sbcompHITSa, U1.sbcompHITSb)

7.1.2

Tabulate the “hits”

Number of “string-based compatible” transcripts for each read:

> U1.uqnames_nsbcomptx <- countQueryHits(U1.sbcompHITS)
> names(U1.uqnames_nsbcomptx) <- U1.uqnames
> table(U1.uqnames_nsbcomptx)

U1.uqnames_nsbcomptx
1

2

0

3

4

5

6

7

8

9

10

11

40555 10080 25299 74609 5207 14265

8643

610

3410

2056

534

4588

> mean(U1.uqnames_nsbcomptx >= 1)

[1] 0.7874142

12

914

77.7% of the reads are “string-based compatible” with at least 1 transcript in exbytx.

Number of “string-based compatible” reads for each transcript:

> U1.exbytx_nsbcompHITS <- countSubjectHits(U1.sbcompHITS)
> names(U1.exbytx_nsbcompHITS) <- names(exbytx)
> mean(U1.exbytx_nsbcompHITS >= 50)

[1] 0.008809516

Only 0.865% of the transcripts in exbytx are “string-based compatible” with at least 50
reads.

Top 10 transcripts:

> head(sort(U1.exbytx_nsbcompHITS, decreasing=TRUE), n=10)

FBtr0308296 FBtr0089175 FBtr0089176 FBtr0089243 FBtr0289951 FBtr0112904 FBtr0089186 FBtr0333672

40548

40389

34275

11605

11579

11548

10059

9742

FBtr0089187 FBtr0089172

9666

6704

7.1.3 A closer look at the “hits”

[WORK IN PROGRESS, might be removed or replaced soon...]

Any “encoding-based compatible” overlap is of course “string-based compatible”:

> stopifnot(length(setdiff(U1.compOV10, U1.sbcompHITS)) == 0)

26

Overlap encodings

but the reverse is not true:

> length(setdiff(U1.sbcompHITS, U1.compOV10))

[1] 13549

7.2

Align the paired-end reads to the transcriptome

[COMING SOON...]

8

Detect “almost splice compatible” overlaps

In many aspects, “splice compatible” overlaps can be seen as perfect. We are now insterested
in a less perfect type of overlap where the read overlaps the transcript in a way that would be
“splice compatible” if 1 or more exons were removed from the transcript. In that case we say
that the overlap is “almost splice compatible” with the transcript. The isCompatibleWith
SkippedExons function can be used on an OverlapEncodings object to detect this type of
overlap. Note that isCompatibleWithSkippedExons can also be used on a character vector
of factor.

8.1

Detect “almost splice compatible” single-end overlaps

8.1.1

“Almost splice compatible” single-end encodings

U1.ovenc contains 7 unique encodings “almost splice compatible” with the splicing of the
transcript:

> sort(U1.ovenc_table[isCompatibleWithSkippedExons(U1.unique_encodings)])

2:jm:am:am:am:am:af: 2:jm:am:am:am:am:am:af:

2:gm:am:af:

2:jm:am:am:am:af:

1

1

4

3:jmm:agm:aam:aam:aaf:

3:jmm:agm:aam:aaf:

2:jm:am:am:af:

9

21

144

7

2:jm:am:af:

1015

Encodings "2:jm:am:af:" (1015 occurences in U1.ovenc), "2:jm:am:am:af:" (144 occurences
in U1.ovenc), and "3:jmm:agm:aam:aaf:" (21 occurences in U1.ovenc), correspond to the
following overlaps:

• "2:jm:am:af:"

- read (1 skipped region):

ooooo----------ooo

- transcript:

...

>>>>>>>

>>>>

>>>>>>>>

...

• "2:jm:am:am:af:"

- read (1 skipped region):

ooooo------------------ooo

- transcript:

...

>>>>>>>

>>>>

>>>>>

>>>>>>>>

...

• "3:jmm:agm:aam:aaf:"

- read (2 skipped regions):

oo---oooo-----------oo

- transcript:

...

>>>>>>>

>>>>

>>>>>

>>>>>>>>

...

> U1.OV00_is_acomp <- isCompatibleWithSkippedExons(U1.ovenc)
> table(U1.OV00_is_acomp) # 1202 "almost splice compatible" overlaps

27

Overlap encodings

U1.OV00_is_acomp
FALSE

TRUE

562350

1202

Finally, let’s extract the “almost splice compatible” overlaps from U1.OV00:

> U1.acompOV00 <- U1.OV00[U1.OV00_is_acomp]

8.1.2

Tabulate the “almost splice compatible” single-end overlaps

Number of “almost splice compatible” transcripts for each alignment in U1.GAL:

> U1.GAL_nacomptx <- countQueryHits(U1.acompOV00)
> mcols(U1.GAL)$nacomptx <- U1.GAL_nacomptx
> head(U1.GAL)

GAlignments object with 6 alignments and 3 metadata columns:

seqnames strand

cigar

qwidth

start

end

width

njunc |

<Rle> <Rle> <character> <integer> <integer> <integer> <integer> <integer> |

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

chr4

chr4

chr4

chr4

chr4

chr4

-

-

+

+

+

-

75M

75M

75M

75M

75M

75M

75

75

75

75

75

75

892

919

924

936

949

967

966

993

998

1010

1023

1041

75

75

75

75

75

75

0 |

0 |

0 |

0 |

0 |

0 |

ntx

ncomptx

nacomptx

<integer> <integer> <integer>

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

SRR031729.3941844

SRR031728.3674563

SRR031729.8532600

SRR031729.2779333

SRR031728.2826481

SRR031728.2919098

-------

seqinfo: 8 sequences from an unspecified genome

> table(U1.GAL_nacomptx)

U1.GAL_nacomptx

0

203800

1

283

2

101

3

107

4

19

5

24

6

2

7

3

8

1

9

3

10

4

11

4

12

4

> mean(U1.GAL_nacomptx >= 1)

[1] 0.002715862

Only 0.27% of the alignments in U1.GAL are “almost splice compatible” with at least 1
transcript in exbytx.

Number of “almost splice compatible” alignments for each transcript:

> U1.exbytx_nacompOV00 <- countSubjectHits(U1.acompOV00)
> names(U1.exbytx_nacompOV00) <- names(exbytx)
> table(U1.exbytx_nacompOV00)

28

Overlap encodings

U1.exbytx_nacompOV00
1

2

0

29039

20

1

50

21

3

8

32

2

3

15

34

1

4

12

44

3

5

2

55

2

6

3

59

1

7

7

77

1

8

5

170

1

9

7

10

3

12

2

13

1

14

1

17

1

18

2

> mean(U1.exbytx_nacompOV00 >= 50)

[1] 0.0001713914

Only 0.017% of the transcripts in exbytx are “almost splice compatible” with at least 50
alignments in U1.GAL.

Finally note that the “query start in transcript” values returned by extractQueryStartInTran
script are also defined for “almost splice compatible” overlaps:

> head(subset(U1.OV00_qstart, U1.OV00_is_acomp))

startInTranscript firstSpannedExonRank startInFirstSpannedExon

144226

144227

144240

144241

146615

146616

133

133

151

151

757

689

1

1

1

1

7

8

133

133

151

151

39

39

8.2

Detect “almost splice compatible” paired-end overlaps

8.2.1

“Almost splice compatible” paired-end encodings

U3.ovenc contains 5 unique paired-end encodings “almost splice compatible” with the splicing
of the transcript:

> sort(U3.ovenc_table[isCompatibleWithSkippedExons(U3.unique_encodings)])

2--1:jm--m:am--m:am--m:af--i:

1--2:i--jm:a--am:a--am:a--af:

1

5

2--2:jm--mm:am--mm:af--jm:aa--af:

1--2:i--jm:a--am:a--af:

9

53

2--1:jm--m:am--m:af--i:

73

Paired-end encodings "2--1:jm--m:am--m (73 occurences in U3.ovenc), "1--2:i--jm:a--am
(53 occurences in U3.ovenc), and "2--2:jm--mm:am--mm:af--j (9 occurences in U3.ovenc),
correspond to the following paired-end overlaps:

• "2--1:jm--m:am--m

- paired-end read (1 skipped region on the first end, no skipped region

on the last end):

ooo----------o

oooo

- transcript:

...

>>>>>

>>>>

>>>>>>>>>

...

• "1--2:i--jm:a--am

- paired-end read (no skipped region on the first end, 1 skipped region

on the last end):

oooo

oo---------oo

29

Overlap encodings

- transcript:

...

>>>>>>>>>>>

>>>

>>>>>>

...

• "2--2:jm--mm:am--mm:af--j

- paired-end read (1 skipped region on the first end, 1 skipped region

on the last end):

o----------ooo

oo---oo

- transcript:

...

>>>>>

>>>>

>>>>>>>>

>>>>>>

...

Note: switch use of “first” and “last” above if the read was “flipped”.

> U3.OV00_is_acomp <- isCompatibleWithSkippedExons(U3.ovenc)
> table(U3.OV00_is_acomp) # 141 "almost splice compatible" paired-end overlaps

U3.OV00_is_acomp
FALSE

TRUE

113686

141

Finally, let’s extract the “almost splice compatible” paired-end overlaps from U3.OV00:

> U3.acompOV00 <- U3.OV00[U3.OV00_is_acomp]

8.2.2

Tabulate the “almost splice compatible” paired-end overlaps

Number of “almost splice compatible” transcripts for each alignment pair in U3.GALP:

> U3.GALP_nacomptx <- countQueryHits(U3.acompOV00)
> mcols(U3.GALP)$nacomptx <- U3.GALP_nacomptx
> head(U3.GALP)

GAlignmentPairs object with 6 pairs, strandMode=1, and 3 metadata columns:

seqnames strand :

ranges --

ranges |

ntx

ncomptx

nacomptx

<Rle> <Rle> : <IRanges> -- <IRanges> | <integer> <integer> <integer>

chr4

chr4

chr4

chr4

chr4

chr4

+ :

+ :

+ :

+ :

+ :

169-205 --

326-362 |

943-979 -- 1086-1122 |

946-982 --

986-1022 |

966-1002 -- 1108-1144 |

966-1002 -- 1114-1150 |

- : 1087-1123 --

963-999 |

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

SRR031715.1138209

SRR031714.756385

SRR031714.5054563

SRR031715.1722593

SRR031715.2202469

SRR031714.3544437

-------

seqinfo: 8 sequences from an unspecified genome

> table(U3.GALP_nacomptx)

U3.GALP_nacomptx

0

45734

1

74

2

4

3

13

4

1

5

1

11

1

> mean(U3.GALP_nacomptx >= 1)

[1] 0.002051148

Only 0.2% of the alignment pairs in U3.GALP are “almost splice compatible” with at least 1
transcript in exbytx.

Number of “almost splice compatible” alignment pairs for each transcript:

30

Overlap encodings

> U3.exbytx_nacompOV00 <- countSubjectHits(U3.acompOV00)
> names(U3.exbytx_nacompOV00) <- names(exbytx)
> table(U3.exbytx_nacompOV00)

U3.exbytx_nacompOV00
1

5

0

29143

22

4

8

1

12

1

13

1

66

1

> mean(U3.exbytx_nacompOV00 >= 50)

[1] 3.427827e-05

Only 0.0034% of the transcripts in exbytx are “almost splice compatible” with at least 50
alignment pairs in U3.GALP.

Finally note that the “query start in transcript” values returned by extractQueryStartInTran
script are also defined for “almost splice compatible” paired-end overlaps:

> head(subset(U3.OV00_Lqstart, U3.OV00_is_acomp))

startInTranscript firstSpannedExonRank startInFirstSpannedExon

27617

27629

27641

27690

27812

42870

1549

1562

1562

1567

1549

659

12

12

12

12

12

4

45

58

58

63

45

101

> head(subset(U3.OV00_Rqstart, U3.OV00_is_acomp))

startInTranscript firstSpannedExonRank startInFirstSpannedExon

27617

27629

27641

27690

27812

42870

2135

2135

2141

2048

2136

866

14

14

14

14

14

6

Detect novel splice junctions

115

115

121

28

116

19

By looking at single-end overlaps
An alignment in U1.GAL with “almost splice compatible” overlaps but no “splice compatible”
overlaps suggests the presence of one or more transcripts that are not in our annotations.

First we extract the index of those alignments (nsj here stands for “novel splice junction”):

> U1.GAL_is_nsj <- U1.GAL_nacomptx != 0L & U1.GAL_ncomptx == 0L
> head(which(U1.GAL_is_nsj))

[1] 57972 57974 58321 67251 67266 67267

We make this an index into U1.OV00:

9

9.1

31

Overlap encodings

> U1.OV00_is_nsj <- queryHits(U1.OV00) %in% which(U1.GAL_is_nsj)

We intersect with U1.OV00_is_acomp and then subset U1.OV00 to keep only the overlaps that
suggest novel splicing:

> U1.OV00_is_nsj <- U1.OV00_is_nsj & U1.OV00_is_acomp
> U1.nsjOV00 <- U1.OV00[U1.OV00_is_nsj]

For each overlap in U1.nsjOV00, we extract the ranks of the skipped exons (we use a list for
this as there might be more than 1 skipped exon per overlap):

> U1.nsjOV00_skippedex <- extractSkippedExonRanks(U1.ovenc)[U1.OV00_is_nsj]
> names(U1.nsjOV00_skippedex) <- queryHits(U1.nsjOV00)
> table(elementNROWS(U1.nsjOV00_skippedex))

1

2

234 116

3

7

4

1

5

1

Finally, we split U1.nsjOV00_skippedex by transcript names:

> f <- factor(names(exbytx)[subjectHits(U1.nsjOV00)], levels=names(exbytx))
> U1.exbytx_skippedex <- split(U1.nsjOV00_skippedex, f)

U1.exbytx_skippedex is a named list of named lists of integer vectors. The first level of
names (outer names) are transcript names and the second level of names (inner names) are
alignment indices into U1.GAL:

> head(names(U1.exbytx_skippedex))

# transcript names

[1] "FBtr0300689" "FBtr0300690" "FBtr0330654" "FBtr0309810" "FBtr0306539" "FBtr0306536"

Transcript FBtr0089124 receives 7 hits. All of them skip exons 9 and 10:

> U1.exbytx_skippedex$FBtr0089124

$`104549`
9 10
[1]

$`104550`
9 10
[1]

$`104553`
9 10
[1]

$`104557`
9 10
[1]

$`104560`
9 10
[1]

$`104572`
9 10
[1]

$`104577`

32

Overlap encodings

[1]

9 10

Transcript FBtr0089147 receives 4 hits. Two of them skip exon 2, one of them skips exons
2 to 6, and one of them skips exon 10:

> U1.exbytx_skippedex$FBtr0089147

$`72828`
[1] 10

$`74018`
[1] 2 3 4 5 6

$`74664`
[1] 2

$`74670`
[1] 2

A few words about the interpretation of U1.exbytx_skippedex: Because of how we’ve con-
ducted this analysis, the aligments reported in U1.exbytx_skippedex are guaranteed to not
have any “splice compatible” overlaps with other known transcripts. All we can say, for
example in the case of transcript FBtr0089124, is that the 7 reported hits that skip exons 9
and 10 show evidence of one or more unknown transcripts with a splice junction that cor-
responds to the gap between exons 8 and 11. But without further analysis, we can’t make
any assumption about the exons structure of those unknown transcripts.
In particular, we
cannot assume the existence of an unknown transcript made of the same exons as transcript
FBtr0089124 minus exons 9 and 10!

9.2

By looking at paired-end overlaps

[COMING SOON...]

10

sessionInfo()

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default

BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:
[1] LC_CTYPE=en_US.UTF-8
[4] LC_COLLATE=C
[7] LC_PAPER=en_US.UTF-8
[10] LC_TELEPHONE=C

LC_NUMERIC=C
LC_MONETARY=en_US.UTF-8
LC_NAME=C
LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_TIME=en_GB
LC_MESSAGES=en_US.UTF-8
LC_ADDRESS=C

33

Overlap encodings

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics grDevices utils

datasets

methods

base

BSgenome_1.78.0
BiocIO_1.20.0

other attached packages:
[1] BSgenome.Dmelanogaster.UCSC.dm3_1.4.0
[3] rtracklayer_1.70.0
[5] TxDb.Dmelanogaster.UCSC.dm3.ensGene_3.2.2 GenomicFeatures_1.62.0
pasillaBamSubset_0.47.0
[7] AnnotationDbi_1.72.0
SummarizedExperiment_1.40.0
[9] GenomicAlignments_1.46.0
MatrixGenerics_1.22.0
[11] Biobase_2.70.0
Rsamtools_2.26.0
[13] matrixStats_1.5.0
XVector_0.50.0
[15] Biostrings_2.78.0
IRanges_2.44.0
[17] GenomicRanges_1.62.0
Seqinfo_1.0.0
[19] S4Vectors_0.48.0
generics_0.1.4
[21] BiocGenerics_0.56.0
BiocStyle_2.38.0
[23] RNAseqData.HNRNPC.bam.chr14_0.47.0

rjson_0.2.23
vctrs_0.6.5
parallel_4.5.1
Matrix_1.7-4
codetools_0.2-20
yaml_2.3.10

loaded via a namespace (and not attached):
xfun_0.53
[1] KEGGREST_1.50.0
tools_4.5.1
[5] lattice_0.22-7
RSQLite_2.4.3
[9] curl_7.0.0
cigarillo_1.0.0
[13] pkgconfig_2.0.3
htmltools_0.5.8.1
[17] compiler_4.5.1
[21] RCurl_1.98-1.17
crayon_1.5.3
[25] BiocParallel_1.44.0 DelayedArray_0.36.0 cachem_1.1.0
bookdown_0.45
[29] digest_0.6.37
SparseArray_1.10.0
[33] grid_4.5.1
rmarkdown_2.30
[37] XML_3.99-0.19
memoise_2.0.1
[41] bit_4.6.0
[45] knitr_1.50
DBI_1.2.3
[49] jsonlite_2.0.0

restfulr_0.0.16
cli_3.6.5
bit64_4.6.0-1
png_0.1-8
rlang_1.1.6
R6_2.6.1

bslib_0.9.0
bitops_1.0-9
blob_1.2.4
lifecycle_1.0.4
sass_0.4.10
jquerylib_0.1.4
abind_1.4-8
fastmap_1.2.0
S4Arrays_1.10.0
httr_1.4.7
evaluate_1.0.5
BiocManager_1.30.26

34

