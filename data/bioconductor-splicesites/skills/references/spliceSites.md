Using spliceSites package

Wolfgang Kaisers, CBiBs HHU Dusseldorf

October 30, 2018

1

Introduction

The data structures and algorithms in this package work on align-gaps which are
found in alignments of RNA-seq data. The analysis starts by reading BAM-ﬁles [2],
so spliceSites assumes that the sequenced RNA is already aligned by external align-
ment software (e.g. tophat [3]). spliceSites technically builds upon CRAN package
rbamtools which performs the reading and data collecting part and CRAN package
refGenome from which processed annotation data is imported.

Splice-site information focuses on align-gaps (which are identiﬁed by the N CIGAR
tag) here in this package. Gapped alignments are highly informative because they are
calculated by specialized alignment recognition algorithms. Ungapped alignments
are only globally counted but not further traced here. This cuts out a relative small
but speciﬁc part of the alignment information. By doing this possibly valuable in-
formation but also many uncertainties are removed from the calculated models.

Align gaps are assumed to arise from splice-sites. This package technically deals
with align-gaps but heavily relies on the fact that align-gaps represent splice-sites.
That’s why the descriptions contain many switches between the align-view and the
splice-site view. An important detail at this point is that the inner align frontiers
represent exon-intron boundaries. Their positions, read-counts and the surrounding
DNA-sequence are the central objectives of the contained algorithms. In contrast,
the outer align-boundaries are merely considered as technical artifacts.

Nomenclature. Align-gaps denote gaps in individual aligns. Each align-gap cor-
responds to a single N CIGAR-item. A gap-site is the unique genomic range where
align-gaps are placed. Typically, there are many align-gaps which share one gap-site.
A gap-site is described by the framing two genomic ranges: The left range denotes
the one with the lower genomic coordinates which is on the left side of the gap in
genome-browser views. The corresponding right range denotes the one with the
higher genomic coordinates. The left-right nomenclature is independent of strand
orientation.

Each range is described by a start (left) and an and (right) position. All position
values are 1-based, which means that the leftmost character in a sequence is ad-
dressed by 1. Start and stop positions denote the 1-based position of the ﬁrst and

1

last nucleotide, respectively, which are contained in the range.

The content of one BAM-ﬁle is associated here with one biological probe.

2 Formal concepts

2.1 Quantiﬁcation of gap-site align numbers

Quantiﬁcation of align numbers for gap-sites diﬀers from the widely used FPKM
method in that gap sites are not associated with some kind of genomic extend which
is addressed by the K (kilobase of transcript). Instead number of aligns which con-
tain a speciﬁed gap-site (deﬁned by a unique left-end and right-start value) are
counted and normalized by a somehow global align number. The spliceSite package
provides two quantiﬁcation indexes.

GPTM gptm abbreviates ”Gapped Per Ten Million reads”. The value represents
the relative amount of aligns for a speciﬁc splice-site in relation to ten million aligned
reads per probe. The deﬁnition of gptm is:

gptm =

Number of aligns per gap-site
Total number of aligns

· 107.

RPMG RPMG abbreviates ”Reads Per Million Gapped”. The value represents the
relative amount of aligns for a speciﬁc splice-site in relation to one million gapped
reads per probe. The value is calculated as

rpmg =

Number of aligns per splice site
Number of gapped aligns in probe

· 106.

Both values are inﬂuenced by the size of the underlying align pool. During merge
operations, the site-speciﬁc and total align numbers are summed and the gptm
and rpmg values are recalculated. The resulting values are weighted by the align
numbers in each component and diﬀers from the mean. Both values are given as
rounded values.

3 Technical description of data structures

Like most software products, this package uses data containers and associated func-
tions.
In the following technical part, each container type will be described. The
associated functions will be speciﬁed direct subsequently for each class.

spliceSites data container The data-structures in this package can be divided
in two lineages of data containers and some additional classes which are used for
specialized tasks. The two lineages are unilateral container (derived from cRanges)
and bilateral container (derived from gapSites):

(cid:136) cRanges (centered ranges) focus on exon-intron boundaries on one side of the
gap-sites. They contain coordinates of genomic ranges (reﬁd, start, end) and
additionally a position inside. The position points to where the gap-boundary

2

(exon-intron boundary) lies inside the range. The derived classes cdRanges
and caRanges additionally contain DNA and amino acid (AA) sequences.

(cid:136) gapSites (Gapped ranges) focus on two genomic ranges which together sur-
round an gap-sites. The ranges represent two (connected) exons with an
interposed intron. The derived classes annGapSites, dnaGapSites and aa-
GapSites additionally contain annotation data, DNA-sequence and amino-
acid sequence respectively.

Additionally there is a class keyProfiler which is used to cumulate values for
gapSites in multiple Probes (BAM-ﬁles) for probe subgroups (e.g. gender speciﬁc)
and a class maxEntScore from which maxEntScores can be calculated [4].

3.1

gapSites class lineage

From the base class gapSites the lineage derives three child classes: dnaGapSites,
aaGapSites which additionally contain a sequence slot and the class annGapSites
in which annotation data is shifted into the main table.

gapSites
is the central container of the spliceSite package. gapSites objects
are intended to organize information about gap-sites. Typically the collected sites
arise from analysis of multiple probes (BAM-ﬁles). The underlying concept is to
accumulate information about the biological existance of gap-sites over the whole
experiment.
The gapSites class contains the following slots:

Name
dt
nAligns
nAlignGaps
annotation
proﬁle

Content

Type
data.frame Table containing the main (gap-site) data
numeric
numeric
data.frame Annotation data
data.frame Table describing the probes in the data source

Total number of aligns counted in the data source
Total number of align gaps counted in the data source

The nAlignGaps value counts the number of N CIGAR-items in the data source.
Therefore aligns with two or more align-gaps genereate multiple counts. It is pos-
sible albeit uncommon to have more nAlignGaps than nAligns.

gapSites keep the gap-sites data in the dt slot inside a data.frame. Each gap-site
is represented as one record (line). The table keeps 12 columns which are organized
as follows:

3

Name
id
seqid
lstart
lend
rstart
rend
gaplen
strand
nAligns
nProbes
gptm
rpmg

Content

Sequence id (usually chromosome name)
Start position of left framing range
End position left framing range
Start position of right framing range
End position of right framing range

Type
numeric Row identiﬁer
factor
numeric
numeric
numeric
numeric
numeric Number of nucleotides in gap
numeric
numeric Number of aligns
numeric Number of probes (BAM-ﬁles)
Expression quantiﬁer
numeric
Expression quantiﬁer
numeric

”+” or ”-” or ”*”

The gptm and rpmg quantiﬁer contain the previously described quantiﬁcation scores.
To be precise the lend value contains the 1-based position of the last exon nucleotide.
rstart denotes the 1-based position of the ﬁrst exon nucleotide.

dnaGapSites and aaGapSites Both classes derive from gapSites and addition-
ally contain a seq slot which contains a DNAStringSet or AAStringSet object
respectively.

annGapSites annGapSites derives from gapSites and additionally keeps infor-
mation about number of probes and annotation data (which is produced by over-
lapping). annGapSites are returned by the member function annotation for class
gapSites.

Creation of gapSites objects is done by directly reading gap-site data from BAM
ﬁles.

3.2 Reading align data from BAM-ﬁles

The spliceSite package contains four diﬀerent functions for reading gap-sites from
BAM-ﬁles. All of them return gapSites objects. getGapSites and alignGapList
read from single BAM ﬁles via bamReader. readMergedBamGaps and readTabled-
BamGaps receive names of BAM-ﬁles and return multi-probe merged gap-site data:

Function
getGapSites
alignGapList
readMergedBamGaps
readTabledBamGaps

Argument
Read range
bamReader Range within BAM-ﬁle
bamReader BAM-ﬁle
BAM-ﬁles
ﬁlenames
BAM-ﬁles
ﬁlenames

Proﬁle
no
no
no
yes

Existing BAM-indices
are an important prerequisite for reading aligns. Either
must a given bamReader contain an intitialized index or a name of BAM-index ﬁles
must be provided. By default, BAM-index ﬁles are expected to be named as the
BAM-ﬁles with a ”.bai” suﬃx.

4

getGapSites
as bamReader). The seqid argument is given as numeric 1-based index.

reads gap-sites for a given seqid from a single BAM-ﬁle (provided

> library(spliceSites)
> bam<-character(2)
> bam[1]<-system.file("extdata","rna_fem.bam",package="spliceSites")
> bam[2]<-system.file("extdata","rna_mal.bam",package="spliceSites")
> reader<-bamReader(bam[1],idx=TRUE)
> gs<-getGapSites(reader,seqid=1)
> gs

Object of class gapSites with 32 rows and 12 columns.
nAligns: 2,216

nAlignGaps: 2,297

id seqid lstart lend rstart rend gaplen nAligns strand

1 1 chr1 14730 14829 14970 15052
2 2 chr1 14944 15038 15796 15888
3 3 chr1 15909 15947 16607 16702
4 4 chr1 15953 16027 16607 16669
5 5 chr1 16730 16765 16854 16941
6 6 chr1 16682 16765 16858 16957

140
757
659
579
88
92

553
201
29
4
5
34

1 240748.803
2 87505.442
3 12625.163
1741.402
4
2176.752
5
6 14801.916

rpmg nProbes
1
1
1
1
1
1

gptm
* 2495487.37
* 907039.71
* 130866.43
18050.54
*
*
22563.18
* 153429.60

alignGapList
ﬁle and internally calls bamGapList.

also works on a given bamReader but reads gap-sites from the entire

> ga<-alignGapList(reader)
> ga

Object of class gapSites with 46 rows and 16 columns.
nAligns: 3,107

nAlignGaps: 3,368

id seqid lstart lend rstart rend gaplen nAligns nProbes nlstart qsm nmcl
8
8
8
4
5
8

0 1 chr1 14730 14829 14970 15052
1 2 chr1 14944 15038 15796 15888
2 3 chr1 15909 15947 16607 16702
3 4 chr1 15953 16027 16607 16669
4 5 chr1 16730 16765 16854 16941
5 6 chr1 16682 16765 16858 16957

8 200
8 181
8 115
4 138
5 95
8 172

140
757
659
579
88
92

553
201
29
4
5
34

1
1
1
1
1
1

gqs strand

0 1000
1 905
2 575
3 345
4 296
5 860

gptm

rpmg
* 1779851.95 164192.399
* 646926.30 59679.335
8610.451
*
1187.648
*
*
1484.561
* 109430.32 10095.012

93337.62
12874.16
16092.69

5

Both functions test the given reader for ﬁle-open status (via isOpen) and for ini-
tialized index.

readMergedBamGaps
takes a vector of BAM-ﬁle names (plus optionally names
of the corresponding BAM-index ﬁles) and reads gap-site data from each BAM-ﬁle
(via rbamtools bamGapList). gap-site data is merged into a gapSites object. The
number of ﬁles in which each align-gap site is identiﬁed is counted in the value
nProbes.

> mbg<-readMergedBamGaps(bam)
> mbg

Object of class gapSites with 71 rows and 16 columns.
nAligns: 7,171

nAlignGaps: 7,665

gptm
id seqid lstart lend rstart rend gaplen strand nAligns nProbes
1
1394.506
2 1570213.359
9761.540
1
2 520150.607
99009.901
2
12550.551
2

0 1 chr1 14713 14734 14970 15038
1 2 chr1 14730 14829 14970 15052
2 3 chr1 14970 15038 15311 15361
3 4 chr1 14944 15038 15796 15888
4 5 chr1 15909 15947 16607 16702
5 6 chr1 15933 16027 16607 16669

1
1126
7
373
71
9

235
140
272
757
659
579

*
*
*
*
*
*

0
130.463
1 146901.500
2
913.242
3 48662.753
9262.883
4
1174.168
5

rpmg nlstart qsm nmcl gqs
1
1 22
13
8 1000
8 200
7 128
2 103
8 910
8 182
8 605
8 121
8 850
8 170

takes a vector of BAM-ﬁle names (plus optionally names of
readTableBamGaps
the corresponding BAM-index ﬁles) and a proﬁle table. The proﬁle tables describes
the probe proﬁle for each BAM-ﬁle (number of BAM-ﬁles = number of rows in
proﬁle). Every column describes a categorial partition of the BAM-ﬁles. For each
category, the number of probes (=ﬁles), number of aligns and optionally gptm-
values are separately calculated. readTabledBamGaps collects gap-site data (as
readMergedBamGaps and adds proﬁle columns. The returned gapSites object
also contains a proﬁle table which can be retrieved via getProfile.

> prof<-data.frame(gender=c("f","m"))
> rtbg<-readTabledBamGaps(bam,prof=prof,rpmg=TRUE)
> rtbg

Object of class gapSites with 71 rows and 22 columns.
nAligns: 7,171

nAlignGaps: 7,665

id seqid lstart lend rstart rend gaplen strand nAligns nProbes nlstart qsm
1 22
8 200
2 103
8 182
8 121
8 170

1 1 chr1 14713 14734 14970 15038
2 2 chr1 14730 14829 14970 15052
3 3 chr1 14970 15038 15311 15361
4 4 chr1 14944 15038 15796 15888
5 5 chr1 15909 15947 16607 16702
6 6 chr1 15933 16027 16607 16669

1
1126
7
373
71
9

235
140
272
757
659
579

1
2
1
2
2
2

*
*
*
*
*
*

6

nmcl gqs
13

gptm
1
130.463
1394.506
8 1000 1570213.359 146901.500
7 128
913.242
9761.540
8 910 520150.607 48662.753
9262.883
8 605
1174.168
8 850

rpmg c.gender.f c.gender.m aln.gender.f
0
553
0
201
29
4

99009.901
12550.551

0
1
0
1
1
1

1
1
1
1
1
1

aln.gender.m rpmg.gender.f rpmg.gender.m
232.721
133348.848
1629.044
40027.926
9774.261
1163.603

0.000
164192.399
0.000
59679.335
8610.451
1187.648

1
573
7
172
42
5

1
2
3
4
5
6

1
2
3
4
5
6

> getProfile(rtbg)

gender nAligns nAlignGaps nSites cSites
46
71

3368
4297

3107
4064

46
64

f
m

1
2

infile
1 /tmp/RtmpJfji13/Rinst49fa2882e6b7/spliceSites/extdata/rna_fem.bam
2 /tmp/RtmpJfji13/Rinst49fa2882e6b7/spliceSites/extdata/rna_mal.bam

3.3

cRanges class lineage

cRanges represent genomic ranges which contain a point of interest inside. In the
present setting ranges lie around (left or right) gap-site borders. The class is in-
tended to manage sequence data which crosses exon-intron boundaries. position is
deﬁned as the 1-based position of the last exon nucleotide. For ’+’ strand, posi-
tion=4 means, that usually the 5th and 6th nucleotide are ’GT’.

From the base class cRanges the lineage derives two child classes: cdRanges and
caRanges which additionally contain a sequence slot. Sequence information is im-
portant for validation splice-sites because required intronic sequence is not contained
in the BAM-align structures an must be included from reference sequence.

cRanges
containes a data.frame in a single slot. Each centered range is rep-
resented as one record (line). The table keeps 7 columns which are organized as
follows:

7

Name
seqid
start
end
strand
position
id
nAligns

Content
Sequence id (usually chromosome name)
Start position of range
End position range
’+’ or ’-’ or ’*’

Type
factor
numeric
numeric
numeric
numeric
numeric Row identiﬁer
numeric Number of aligns

3.4 Extracting gap-site boundary ranges

xJunc functions
extract ranges from gapSites objects. lJunc and rJunc ob-
jects extract ranges around one gap-site boundaries and return cRanges objects.
The position values point to the gap-site (exon-intron) boundary.

rlJunc objects extract ranges from both sides of the gap-site and return gapSites
objects.
Inside the returned object the contained data.frame has two additional
columns (lfeatlen and rfeatlen) which mark the boundary position.

The ranges are intended to be padded with DNA-sequence. Therefore the given
strand value is used:

> ljp<-lJunc(ga,featlen=6,gaplen=6,strand=
> ljp

’

’

+

)

Object of class cRanges with 46 rows and 7 columns.

seqid start

1 chr1 14824 14835
2 chr1 15033 15044
3 chr1 15942 15953
4 chr1 16022 16033
5 chr1 16760 16771
6 chr1 16760 16771

end strand position id nAligns
553
201
29
4
5
34

6 1
6 2
6 3
6 4
6 5
6 6

+
+
+
+
+
+

> ljm<-lJunc(ga,featlen=6,gaplen=6,strand=
> ljm

’

’

-

)

Object of class cRanges with 46 rows and 7 columns.

seqid start

1 chr1 14824 14835
2 chr1 15033 15044
3 chr1 15942 15953
4 chr1 16022 16033
5 chr1 16760 16771
6 chr1 16760 16771

end strand position id nAligns
553
201
29
4
5
34

6 1
6 2
6 3
6 4
6 5
6 6

-
-
-
-
-
-

> rjp<-rJunc(ga,featlen=6,gaplen=6,strand=
> rjp

’

’

+

)

8

Object of class cRanges with 46 rows and 7 columns.

seqid start

1 chr1 14964 14975
2 chr1 15790 15801
3 chr1 16601 16612
4 chr1 16601 16612
5 chr1 16848 16859
6 chr1 16852 16863

end strand position id nAligns
553
201
29
4
5
34

6 1
6 2
6 3
6 4
6 5
6 6

+
+
+
+
+
+

> rjm<-rJunc(ga,featlen=6,gaplen=6,strand=
> rjm

’

’

-

)

Object of class cRanges with 46 rows and 7 columns.

seqid start

1 chr1 14964 14975
2 chr1 15790 15801
3 chr1 16601 16612
4 chr1 16601 16612
5 chr1 16848 16859
6 chr1 16852 16863

end strand position id nAligns
553
201
29
4
5
34

6 1
6 2
6 3
6 4
6 5
6 6

-
-
-
-
-
-

> lrjp<-lrJunc(ga,lfeatlen=6,rfeatlen=6,strand=
> lrjp

’

’

+

)

Object of class gapSites with 46 rows and 14 columns.
nAligns: 3,107

nAlignGaps: 3,368

1 1 chr1 14824 14829 14970 14975
2 2 chr1 15033 15038 15796 15801
3 3 chr1 15942 15947 16607 16612
4 4 chr1 16022 16027 16607 16612
5 5 chr1 16760 16765 16854 16859
6 6 chr1 16760 16765 16858 16863

140
757
659
579
88
92

+
+
+
+
+
+

1 164192.399
2 59679.335
8610.451
3
1187.648
4
1484.561
5
6 10095.012

rpmg nProbes lfeatlen rfeatlen
6
6
6
6
6
6

6
6
6
6
6
6

1
1
1
1
1
1

> lrjm<-lrJunc(ga,lfeatlen=6,rfeatlen=6,strand=
> lrjm

’

’

-

)

Object of class gapSites with 46 rows and 14 columns.
nAligns: 3,107

nAlignGaps: 3,368

id seqid lstart lend rstart rend gaplen strand nAligns

gptm
553 1779851.95
201 646926.30
93337.62
12874.16
16092.69
34 109430.32

29
4
5

id seqid lstart lend rstart rend gaplen strand nAligns

1 1 chr1 14824 14829 14970 14975
2 2 chr1 15033 15038 15796 15801
3 3 chr1 15942 15947 16607 16612
4 4 chr1 16022 16027 16607 16612

140
757
659
579

-
-
-
-

9

gptm
553 1779851.95
201 646926.30
93337.62
12874.16

29
4

5 5 chr1 16760 16765 16854 16859
6 6 chr1 16760 16765 16858 16863

88
92

-
-

5

16092.69
34 109430.32

1 164192.399
2 59679.335
8610.451
3
1187.648
4
5
1484.561
6 10095.012

rpmg nProbes lfeatlen rfeatlen
6
6
6
6
6
6

1
1
1
1
1
1

6
6
6
6
6
6

xCodons functions. lCodons and rCodons both take and return cRanges ob-
jects. The functions provide two tasks:

(cid:136) Shift start position for sequence extraction according to reading frame.

(cid:136) Truncate range end to full codon size.

Both operations act unilateral on ranges and so strand information must be provided
in order to decide which side of the range (left or right) represents start and end.
lCodons and rCodons take a numeric frame argument and a logical keepStrand
argument besides the cRanges object. For frame = 2 or 3, the start position is
shifted 1 or 2 nucleotides respectively. The sequence length is then truncated to
the largest contained multiple of 3. The functions then correct the position-values
in order to keep the positions pointer on the same nucleotide. When keepStrand is
FALSE’ (the default), the lCodons function sets all strand entries to ”+” and the
rCodons sets all Strand entries to ”-”.

The lCodons function should be used for ”+”-strand and the rCodons function
should be used for ”-”-strand.

> ljp1<-lCodons(ljp,frame=1)
> ljp1

Object of class cRanges with 46 rows and 8 columns.

seqid start

1 chr1 14824 14835
2 chr1 15033 15044
3 chr1 15942 15953
4 chr1 16022 16033
5 chr1 16760 16771
6 chr1 16760 16771

end strand position id nAligns frame
1
1
1
1
1
1

6 1
6 2
6 3
6 4
6 5
6 6

553
201
29
4
5
34

+
+
+
+
+
+

> ljp2<-lCodons(ljp,frame=2)
> rjm1<-rCodons(ljm,frame=1)
> rjm2<-rCodons(ljm,frame=2)

The xCodons functions provide a preparative step which allows translation of subse-
quently added DNA-sequence into AA-sequence. The strand information is therein
used to determine the fraction of DNA-sequence must be reverseComplement’ed.

10

The lrCodons function works similar as the xCodons functions but does the
same on the two gap-site enframing ranges simultaneously. lrCodons takes and
returns gapAligns objects. The strand value can be manually set (default: ’*’) for
later use by dnaGapAligns

> lr1<-lrCodons(lrjp,frame=1,strand=
> lr2<-lrCodons(lrjp,frame=2,strand=
> lr3<-lrCodons(lrjp,frame=3,strand=

’
’
’

’
’
’

+
+
+

)
)
)

The c-Operator
for cRanges and gapSites is used to combine objects made
for diﬀerent frame and strand together to one cRanges or gapSites for joint
subsequent analysis:
In the next step we transform these ranges into codons in both directions and all
three frames.

> ljpc<-c(ljp1,ljp2)
> rjmc<-c(rjm1,rjm2)
> lrj<-c(lr1,lr2,lr3)

In order to provide better readable tables there is an optional function for sorting
the combined cRanges and gapSites:

> ljpc<-sortTable(ljpc)
> rjmc<-sortTable(rjmc)
> lrj<-sortTable(lrj)

Trim and resize functions provide upper size limits or ﬁxed size for boundary
ranges in gapSites objects. trim_left works on left boundary ranges (i.e. lstart
and rend values) and trim_right works on right boundary ranges (i.e. rstart
and rend).

All four functions leave the inner boundaries (lend and rstart) unchanged.

> trim_left(lrj,3)
> trim_right(lrj,3)
> resize_left(lrj,8)
> resize_right(lrj,8)

3.5 Provide additional information

Genuine gapSites and cRanges objects contain numeric coordinate and count data
but no sequence or gene association. The conceptual idea is to add gene-annotations
and sequence data to primed coordinate containers.

Gene annotation data can be added with the annotate and annotation<-
functions. Therefore a refGenome object (ucscGenome or ensemblGenome from
package refGenome) must be provided.

> ucf<-system.file("extdata","uc_small.RData",package="spliceSites")
> uc<-loadGenome(ucf)
> juc <- getSpliceTable(uc)
> annotation(ga)<-annotate(ga, juc)

11

Adding annotation data internally works by calling the overlapJuncs functions
(refGenome package). The same mechanism also works for gapSites objects which
arise from readTabledBamGaps:

Strand information can be deduced from gene annotation. The getAnnStrand
function looks at the annotation derived strand information on both sides. When the
strand information is equal, the function takes the value as strand for the gap-site.
Otherwise the strand will be set to ’*’. The strand information can be integrated
into the internal data.frame by using the strand function.

> strand(ga)<-getAnnStrand(ga)

addGeneAligns
sites for each gene.

adds information about distribution of aligns over diﬀerent gap-

> gap<-addGeneAligns(ga)
> gap

Object of class gapSites with 46 rows and 17 columns.
nAligns: 3,107

nAlignGaps: 3,368

id seqid lstart lend rstart rend gaplen nAligns nProbes nlstart qsm nmcl
8
8
8
4
5
8

1 1 chr1 14730 14829 14970 15052
2 2 chr1 14944 15038 15796 15888
3 3 chr1 15909 15947 16607 16702
4 4 chr1 15953 16027 16607 16669
5 5 chr1 16730 16765 16854 16941
6 6 chr1 16682 16765 16858 16957

8 200
8 181
8 115
4 138
5 95
8 172

140
757
659
579
88
92

553
201
29
4
5
34

1
1
1
1
1
1

gqs strand

gptm

rpmg gene_aligns

1 1000
2 905
3 575
4 345
5 296
6 860

- 1779851.95 164192.399
- 646926.30 59679.335
8610.451
-
1187.648
-
-
1484.561
- 109430.32 10095.012

93337.62
12874.16
16092.69

639 uc001aac.4
201 uc009vis.3
34 uc009vix.2
34 uc009vix.2
610 uc009viz.2
34 uc009viv.2

gene_id gene_name
WASH7P
WASH7P
WASH7P
WASH7P
WASH7P
WASH7P

DNA-sequence can be added from a DNAStringSet (Biostrings) object via the
dnaRanges function. dnaRanges function takes a cRanges object and a DNAS-
tringSet object and adds the corresponding DNA-sequence to each contained
range. The function returns an object of class cdRanges.
We ﬁrst load an example DNAStringSet which contains the reference sequence.
The sample object dna small contains a small extract of UCSC human reference
sequence.

> dnafile<-system.file("extdata","dna_small.RData",package="spliceSites")
> load(dnafile)
> dna_small

A DNAStringSet instance of length 4

width seq

names
[1] 104000 NNNNNNNNNNNNNNNNNNNNNN...ACTCCGAGGCCATGGACGTGTT chr16
[2]

30000 NNNNNNNNNNNNNNNNNNNNNN...AGAAGCAGTGGTCGCCAGGAAT chr1

12

[3] 360000 NNNNNNNNNNNNNNNNNNNNNN...TGGAGCTCAGGGGCACCCACCA chr6
[4] 2851000 NNNNNNNNNNNNNNNNNNNNNN...ATCCTCCTGCCTCAGCCTACGC chrY

Then we create a cdRanges instance dnaRanges and then produce a seqlogo:

> ljpcd<-dnaRanges(ljpc,dna_small)
> seqlogo(ljpcd)

Amino-Acid sequences
can be obtained after the previous preparatory steps are
done. The translate function converts a cdRanges object into a caRanges ob-
ject by translating the contained DNA-sequences. The function internally uses the
Bioconductor Biostrings translate function.

> ljpca<-translate(ljpcd)

Extracting subsets
from cRanges and gapSites (and derived classes) can be
done with extractX functions. They come in two ﬂavours: extractRange and
extractByGeneName. Main application for these function is visual inspectation of
the results.

extractRange takes a cRanges or gapSites object and a triple of genomic coor-
dinates (seqid, start, end). From the given cRanges object, the stored ranges which
are contained in the range deﬁned by the coordinates is extracted and returned as
cRanges object.

> # A) For gapSites
> extractRange(ga,seqid="chr1",start=14000,end=30000)

13

123456789101112Position00.20.40.60.81ProbabilityObject of class gapSites with 32 rows and 16 columns.
nAligns: 3,107

nAlignGaps: 3,368

id seqid lstart lend rstart rend gaplen nAligns nProbes nlstart qsm nmcl
8
8
8
4
5
8

1 1 chr1 14730 14829 14970 15052
2 2 chr1 14944 15038 15796 15888
3 3 chr1 15909 15947 16607 16702
4 4 chr1 15953 16027 16607 16669
5 5 chr1 16730 16765 16854 16941
6 6 chr1 16682 16765 16858 16957

8 200
8 181
8 115
4 138
5 95
8 172

553
201
29
4
5
34

140
757
659
579
88
92

1
1
1
1
1
1

gqs strand

gptm

rpmg

- 1779851.95 164192.399 uc001aac.4
- 646926.30 59679.335 uc009vis.3
8610.451 uc009vix.2
-
1187.648 uc009vix.2
-
-
1484.561 uc009viz.2
- 109430.32 10095.012 uc009viv.2

93337.62
12874.16
16092.69

gene_id gene_name
WASH7P
WASH7P
WASH7P
WASH7P
WASH7P
WASH7P

1 1000
2 905
3 575
4 345
5 296
6 860

> # B) For cRanges
> lj<-lJunc(ga,featlen=3,gaplen=6,strand=
> extractRange(lj,seqid="chr1",start=14000,end=30000)

)

+

’

’

Object of class cRanges with 32 rows and 7 columns.

seqid start

1 chr1 14827 14835
2 chr1 15036 15044
3 chr1 15945 15953
4 chr1 16025 16033
5 chr1 16763 16771
6 chr1 16763 16771

end strand position id nAligns
553
201
29
4
5
34

3 1
3 2
3 3
3 4
3 5
3 6

+
+
+
+
+
+

extractByGeneName also takes a cRanges or gapSites object but instead of a
numeric range, a vector of gene-names and a refGenome object. The refGenome
object ﬁrst calculates a set of numerical coordinates from the given gene-names and
then calls extractRange for each set of coordinates. The resulting objects are then
concatenated.

> lj<-lJunc(ga,featlen=6,gaplen=3,strand=
> ljw<-extractByGeneName(ljp,geneNames="POLR3K",src=uc)
> ljw

+

)

’

’

Object of class cRanges with 2 rows and 7 columns.

seqid start

33 chr16 97552 97563
34 chr16 101640 101651

end strand position id nAligns
168
152

6 33
6 34

+
+

> ljw<-extractByGeneName(ljpcd,geneNames="POLR3K",src=uc)
> ljw

Object of class cdRanges with 4 rows and 8 columns.

seqid start

end strand position id nAligns frame

33 chr16 97552 97563
79 chr16 97553 97561
34 chr16 101640 101651
80 chr16 101641 101649

+
+
+
+

6 33
5 33
6 34
5 34

168
168
152
152

14

seq
1 ACGACTCTGGCA
2
CGACTCTGG
1 TGTTACCTAACA
GTTACCTAA
2

3.6 Working with amino-acid (AA) sequences

For approaching AA based views whe ﬁrst prepare longer DNA sequences for diﬀerent
frames and add DNA-sequence:

> l<-12
> lj<-lJunc(mbg,featlen=l,gaplen=l,strand=
> ljc<-c(lCodons(lj,1),lCodons(lj,2),lCodons(lj,3))
> lrj<-lrJunc(mbg,lfeatlen=l,rfeatlen=l,strand=
)
> lrjc<-c(lrCodons(lrj,1),lrCodons(lrj,2),lrCodons(lrj,3))
> jlrd<-dnaRanges(ljc,dna_small)

+

)

+

’

’

’

’

Translation of DNA sequences can simply be obtained by using translate:

> jlrt<-translate(jlrd)
> jlrt

Object of class caRanges with 213 rows and 8 columns.

seqid start

end strand position id nAligns frame

chr1 14723 14746
1
72
chr1 14724 14744
143 chr1 14725 14745
chr1 14818 14841
2
73
chr1 14819 14839
144 chr1 14820 14840

+
+
+
+
+
+

5 1
4 1
4 1
5 2
4 2
4 2

1
1
1
1126
1126
1126

seq
1 LCLWLLRW
2 SACGCCG
3 MPVAAAV
1 SQRCLEGK
2 PRDAWRE
3 PEMPGGK

truncateSeq function addresses stop codons ’*’ which may be identiﬁed in the
amino acid sequence. The function truncates the sequence when the stop-codon
appears behind (right-hand of) the position and removes rows where the stop-codon
appears before (left-hand of) the position. This removes data-sets where the exon-
intron boundary lies downstream of a stop-codon.

> jlrtt<-truncateSeq(jlrt)
> jlrtt

Object of class caRanges with 195 rows and 9 columns.

seqid start

chr1 14723 14746
1
72
chr1 14724 14744
143 chr1 14725 14745
chr1 14818 14841
2
73
chr1 14819 14839
144 chr1 14820 14840

end strand position id nAligns frame lseq
5 1
4 1
4 1
5 2
4 2
4 2

1
1
1
1126
1126
1126

seq
8 LCLWLLRW
7 SACGCCG
7 MPVAAAV
8 SQRCLEGK
7 PRDAWRE
7 PEMPGGK

+
+
+
+
+
+

1
2
3
1
2
3

trypsinCleave function performs in silico trypsinisation on the provided AA se-
quences. Trypsin sites are identiﬁed by the regex rule ”[RK](?!P)”which implements
the ”Keil”-rule. From the sequence fragments, the one which contains the position
marked gap-site (exon-intron) boundary is returned.

> jtry<-trypsinCleave(jlrtt)
> jtry<-sortTable(jtry)

15

3.7 Writing output tables

Write functions provide functionality for exporting generated tables into ’.csv’ ﬁles.

3.7.1 write.annDNA.tables

writes content of gapSites objects together with DNA-sequence segments.

> annotation(rtbg)<-annotate(rtbg, juc)
> write.annDNA.tables(rtbg, dna_small, "gapSites.csv", featlen=3, gaplen=8)

Additional columns output are added by write.annDNA.tables to the existing
tables in gapSites objects (shown in Table 1).

Table 1: Additional columns by write.annDNA.tables

Column
leftseq
rightseq

Content
Sequence of Exon-Intron boundary on left side
Sequence of Exon-Intron boundary on right side

The Sequences are obtained using the dnaRanges function called with parameters
given in table 2. DNA sequences are reverseComplemented for ’-’-Strand.

Class
cRanges

Table 2: Arguments passed to dnaRanges
Content
lJuncStrand (rJuncStrand) using
featlen and gaplen arguments
DNAStringSet (Reference sequence)
TRUE
FALSE

dnaset
useStrand
removeUnknownStrand

Note the output of write.annDNA.tables:
The sequence from which the lhbond is calculated will only coincide with the left-
seq column in rows with strand=’+’. The sequence from which the rhbond is
calculated will only coincide with the rightseq column in rows with strand=’-’.
Otherwise the Hbond is calculated from the reverseComplement’ed sequence.

3.7.2 write.ﬁles

The write.files function works on caRanges objects and produces two output
ﬁles: One ’.csv’ ﬁle which contains a copy of the data and a ’.fa’ ﬁle which contains
sequence in fasta format.

> write.files(jtry,path=getwd(),filename="proteomic",quote=FALSE)

The fasta headers contain two tags which are separated by a vertical bar ’|’. The
ﬁrst item is the id of the corresponding table row and the second item is the preﬁx
of the ﬁlename.

16

3.8 Working with alternative splice-sites

Alternative splice-sites are sites where one exon-intron boundary corresponds to
multiple counterparts. In gap-site tables, alternative sites are characterized by mul-
tiple occuring entries of lend or rstart. The alt_left_ranks function work by
putting gap-sites which share the same rstart values in a group which is identiﬁed
by the same alt_id value. Gap-sites which don’t share their rstart value with
any other gap-site have the alt_id value 0.

alt left ranks
6 numeric columns:

looks for multiple entries of rstart values and returns a table with

Content
Row identiﬁer (from gapSites object
Group number. Identiﬁes group of gap-sites which share same ; 0 for sigular entries

Name
id
alt id
diﬀ ranks Rank of gaplen inside same alt id group
gap diﬀ
nr alt

Diﬀerence in gaplen to the next greater gaplen value in group
Number of rows with same rstart value

So the rank numbering increases with gaplen (from inside to outide) and the
gap_diff values are always ≥ 0 because the row with the smallest gaplen gets
the rank 1 and gap diﬀ 0.
When the option extensive=TRUE is given, four more columns are contained in
the result table: seq (seqid), group (=rstart, by which the input table is grouped),
alt (lend) and len (gaplen).

> al<-alt_left_ranks(ga)

The alt ranks
into one table. There should be characteristic peaks at multiples of 3:

function combines the results of alt_left_ranks and alt_right_ranks

> ar<-alt_ranks(ga)

The tabled gap_diff values can be plotted with:

> plot_diff_ranks(ga)

17

plot diﬀ gives a visual overview about the congruence between gap-site positions
and the associated annotations. Diﬀerences of zero say that a gap-site boundary
exactly meets the annotated position.

> aga<-annotation(ga)
> plot_diff(aga)

18

3799table left_gap_diff0.00.51.01.52.02.53.04table right_gap_diff0.00.51.01.52.02.53.0MaxEntScores Maximum Entropy (MaxEnt) scores were developed by Gene Yeo
and Christopher Burge [4] and are widely accepted as method for quantiﬁcation
of splice-site strength for a given sequence motif from the exon-intron boundary.
MaxEnt scores can be calculated for the 5’ and the 3’ side of the splice-site. Max-
Ent scores can be calculated for vectors of sequences for a given position (1-based
position of last exon nucleotide) using the score3 and score5 functions.
For sliding window calculations on longer DNA-sequences the scoreSeq5 and score-
Seq3 functions can be used. The addMaxEnt function is used for adding MaxEnt
scores to a gapSites object.

> mes<-load.maxEnt()
> score5(mes,"CCGGGTAAGAA",4)

[1] 9.844127

> score3(mes,"CTCTACTACTATCTATCTAGATC",pos=20)

[1] 6.706947

> sq5<-scoreSeq5(mes,seq="ACGGTAAGTCAGGTAAGT")
> sq3<-scoreSeq3(mes,seq="TTTATTTTTCTCACTTTTAGAGACTTCATTCTTTCTCAAATAGGTT")
> gae<-addMaxEnt(ga,dna_small,mes)
> gae

Object of class gapSites with 46 rows and 23 columns.
nAligns: 3,107

nAlignGaps: 3,368

id seqid lstart lend rstart rend gaplen nAligns nProbes nlstart qsm nmcl

19

03647301Annotation left−gap_site distance05101520253035012142Annotation right−gap site distance01020300 1 chr1 14730 14829 14970 15052
1 2 chr1 14944 15038 15796 15888
2 3 chr1 15909 15947 16607 16702
3 4 chr1 15953 16027 16607 16669
4 5 chr1 16730 16765 16854 16941
5 6 chr1 16682 16765 16858 16957

gqs strand

gptm

0 1000
1 905
2 575
3 345
4 296
5 860

- 1779851.95 164192.399
- 646926.30 59679.335
8610.451
-
1187.648
-
-
1484.561
- 109430.32 10095.012

93337.62
12874.16
16092.69

1
1
1
1
1
1

140
757
659
579
88
92

553
201
29
4
5
34

8 200
8 181
8 115
4 138
5 95
8 172

8
8
8
4
5
8
rpmg mxe_ps5 mxe_ps3 mxe_ms5 mxe_ms3 s5strand
-
-
-
-
-
-

-30.3
-21.4
-26.1
-17.4
-19.4
-19.4

-5.3
-14.3
-13.7
-13.7
-15.8
-15.6

6.5
9.6
6.7
6.7
8.0
10.3

8.3
9.2
6.5
5.8
8.7
8.7

s3strand meStrand
-
-
-
-
-
-

-
-
-
-
-
-

0
1
2
3
4
5

> table(getMeStrand(gae))

+ - *
11 35 0

> sae<-setMeStrand(gae)
> sae

Object of class gapSites with 46 rows and 23 columns.
nAlignGaps: 0
nAligns: 0

140
757
659
579
88
92

0 1 chr1 14730 14829 14970 15052
1 2 chr1 14944 15038 15796 15888
2 3 chr1 15909 15947 16607 16702
3 4 chr1 15953 16027 16607 16669
4 5 chr1 16730 16765 16854 16941
5 6 chr1 16682 16765 16858 16957

id seqid lstart lend rstart rend gaplen nAligns nProbes nlstart qsm nmcl
8
8
8
4
5
8
rpmg mxe_ps5 mxe_ps3 mxe_ms5 mxe_ms3 s5strand
-
-
-
-
-
-

- 1779851.95 164192.399
- 646926.30 59679.335
8610.451
-
1187.648
-
-
1484.561
- 109430.32 10095.012

0 1000
1 905
2 575
3 345
4 296
5 860

8 200
8 181
8 115
4 138
5 95
8 172

-30.3
-21.4
-26.1
-17.4
-19.4
-19.4

-5.3
-14.3
-13.7
-13.7
-15.8
-15.6

6.5
9.6
6.7
6.7
8.0
10.3

93337.62
12874.16
16092.69

553
201
29
4
5
34

8.3
9.2
6.5
5.8
8.7
8.7

gqs strand

1
1
1
1
1
1

gptm

s3strand meStrand
-
-
-
-
-
-

-
-
-
-
-
-

0
1
2
3
4
5

20

HBond scores The HBond score provides a measure for the capability of a 5’
splice-site to form H-bonds with the U1 snRNA [1]. The HBond score can be
calculated for a vector of sequences

> #
> hb<-load.hbond()
> seq<-c("CAGGTGAGTTC", "ATGCTGGAGAA", "AGGGTGCGGGC", "AAGGTAACGTC", "AAGGTGAGTTC")
> hbond(hb,seq,3)

[1] 19.4 0.0 8.3 14.1 17.7

or can be added to gapSites and cdRanges objects:

> gab<-addHbond(ga,dna_small)
> # D) cdRanges
> lj<-lJunc(ga, featlen=3, gaplen=8, strand=
> ljd<-dnaRanges(lj,dna_small)
> ljdh<-addHbond(ljd)

’

’

+

)

The addHbond function algorithm is made up of three steps (left side shown, right
side analog):

(cid:136) Call to lJunc using parameters featlen=3, gaplen=8 and strand=’+’.

(cid:136) Call to dnaRanges function with useStrand=TRUE

(cid:136) C-call to hbond_score.

Because the Hbond score is only valid for the splice donor (5’ junction) site and the
addHbond function always assumes ’+’-strand on the left gap-site border and ’-’-
strand on the right gap-site border. Therefore the DNA sequence is always passed
as is on the left side and reverseComplement’ed on the right side irrespective of
strand value in the given gap-sites object.

The Hbond score is 0 when no ’GT’ is present in the ﬁrst two intron positions. Usu-
ally, lhbond >0 and rhbond =0 when strand=’+’ and lhbond=0 and hbond>0
when strand=’-’.

Note the output of write.annDNA.tables:
The sequence from which the lhbond is calculated will only coincide with the left-
seq column in rows with strand=’+’. The sequence from which the rhbond is
calculated will only coincide with the rightseq column in rows with strand=’-’.
Otherwise the Hbond is calculated from the reverseComplement’ed sequence.

3.9 Creating ExpressionSet objects containing gap-site align-

count values.

In order to provide technical requirements for analyzing expression data inside the
standard Bioconductor framework, there is a readExpSet function which produces
ExpressionSet objects with rpmg (default) and gptm expression values.

21

readExpSet
into ExpressionSet

reads gap-site aligns abundance from a given list of BAM ﬁle names

> prof<-data.frame(gender=c("f", "m"))
> rtbg<-readTabledBamGaps(bam, prof=prof, rpmg=TRUE)
> getProfile(rtbg)

gender nAligns nAlignGaps nSites cSites
46
71

3368
4297

3107
4064

46
64

f
m

1
2

infile
1 /tmp/RtmpJfji13/Rinst49fa2882e6b7/spliceSites/extdata/rna_fem.bam
2 /tmp/RtmpJfji13/Rinst49fa2882e6b7/spliceSites/extdata/rna_mal.bam

> meta<-data.frame(labelDescription=names(prof),row.names=names(prof))
> pd<-new("AnnotatedDataFrame",data=prof,varMetadata=meta)
> es<-readExpSet(bam,phenoData=pd)

There are two annotation functions for ExpressionSets which are created by read-
ExpSet: annotate and uniqueJuncAnn. Annotate ﬁnds overlaps to a given re-
fJunctions object. uniqueJuncAnn ﬁnds exact matches with known splice-sites:

> ann<-annotate(es, juc)
> ucj<-getSpliceTable(uc)
> uja<-uniqueJuncAnn(es, ucj)

From ExpressionSets, the alignment counts can directly be used as input for diﬀer-
ential expression analysis with the DESeq2 package:

> library(DESeq2)
> cds <- DESeqDataSetFromMatrix(exprs(es), colData=prof, design=~gender)
> des <- DESeq(cds)
> binom.res<-results(des)
> br <- na.omit(binom.res)
> bro <- br[order(br$padj, decreasing=TRUE),]

readCuﬀGeneFpkm reads FPKM values from all given cuﬄinks ﬁles and collects
the values into an ExpressionSet.
In order to get unique gene identiﬁer, the
contained values are grouped and for each gene the maximum FPKM values is
selected.

paste(1:n, "genes", "fpkm_tracking", sep="."),
package="spliceSites")

> n <- 10
> cuff <- system.file("extdata","cuff_files",
+
+
> gr <- system.file("extdata", "cuff_files", "groups.csv", package="spliceSites")
> groups <- read.table(gr, sep="\t", header=TRUE)
> meta <- data.frame(labelDescription=c("gender", "age-group", "location"),
+
> phenoData <- new("AnnotatedDataFrame", data=groups, varMetadata=meta)
> exset <- readCuffGeneFpkm(cuff, phenoData)

row.names=c("gen", "agg", "loc"))

22

4 Appendix

4.1 Plot read alignment depth

The function plotGeneAlignDepth draws read alignment depth based on data from a
bamReader and a refGenome object and a given gene name and a transcript name:

> bam <- system.file("extdata","rna_fem.bam",package="spliceSites")
> reader <- bamReader(bam, idx=TRUE)
> # Load annotation data
> ucf <- system.file("extdata", "uc_small.RData", package="spliceSites")
> uc <- loadGenome(ucf)

An example is shown in the following plot:

> plotGeneAlignDepth(reader, uc, gene="WASH7P", transcript="uc001aac.4",
+
+

col="slategray3", fill="slategray1",
box.col="snow3", box.border="snow4")

4.2 The keytable class

The keytable class is designed to count align data and for computation of expres-
sion values for experimental groups separately. The class is only internally used by
the readTabledBamGaps function.
Group assignment of probes (BAM-ﬁles) is done by providing a proﬁle table. Align
count values then can subsequently be added to the created object. After data-
collection a result table can be retrieved.

23

125102050100200500Alignment depth for gene WASH7PRefname: chr1Alignment depth15000200002500030000PositionChromosome  chr1 (cid:9)Gene  uc009viu.3 (cid:9)Transcript uc001aac.4For description of functionality ﬁrst artiﬁcial data is created. A proﬁle-table deﬁnes
the group association of all analyzed probes (usually each probe is one BAM-ﬁle).

> prof<-data.frame(gen=factor(c("w","m","w","w"),levels=c("m","w")),
+
+
> prof

loc=factor(c("thx","thx","abd","abd"),levels=c("thx","abd")),
ag =factor(c("y","y","m","o"),levels=c("y","m","o")))

gen loc ag
w thx y
m thx y
w abd m
w abd o

1
2
3
4

We the create artiﬁcial align-count data for several some gap-sites. The input table
key allows for multipe entries for the same site. For the output the sites are merged
(and align numbers summed) into ku.

seqid=c(1,1,2,2,3),
lend=c(10,20,10,30,10),
rstart=c(20,30,20,40,20),
nAligns=c(11,21,31,41,51))

seqid=c(1,1,2,2,4),
lend=c(10,20,10,30,50),
rstart=c(20,30,20,40,70),
nAligns=c(21,22,23,24,25))

> key1<-data.frame(id=1:5,
+
+
+
+
> key2<-data.frame(id=1:5,
+
+
+
+
> key3<-data.frame(id=1:5,
+
+
+
+
> key<-rbind(key1,key2,key3)
> # Group positions
> ku<-aggregate(data.frame(nAligns=key$nAligns),
+
+

seqid=c(1,2,4,5,5),
lend=c(10,10,60,10,20),
rstart=c(20,20,80,20,30),
nAligns=c(31,32,33,34,35))

by=list(seqid=key$seqid,lend=key$lend,rstart=key$rstart),
FUN=sum)

The next steps comes in two versions: one version where only number of probes are
counted for each site and the second version where aligns are counted for each site.
The ﬁrst example shows the probe-counting procedure: The keyProfiler object
is created from the ﬁrst probe data and subsequently data for two probes is added
(via addKeyTable).

> # Count probes
> kpc<-new("keyProfiler",keyTable=key1[,c("seqid","lend","rstart")],prof=prof)
> addKeyTable(kpc,keyTable=key2[,c("seqid","lend","rstart")],index=2)
> addKeyTable(kpc,keyTable=key3[,c("seqid","lend","rstart")],index=4)
>

The result is then appended to the grouped input table:

24

> cp<-appendKeyTable(kpc,ku,prefix="c.")
> cp

seqid lend rstart nAligns c.gen.m c.gen.w c.loc.thx c.loc.abd c.ag.y c.ag.m
0
0
0
0
0
0
0
0
0

20
30
20
40
20
70
80
20
30

10
20
10
30
10
50
60
10
20

63
43
86
65
51
25
33
34
35

2
2
2
2
1
1
0
0
0

2
2
2
2
1
1
0
0
0

2
1
2
1
1
0
1
1
1

1
0
1
0
0
0
1
1
1

1
1
2
2
3
4
4
5
5

1
1
1
1
0
1
0
0
0

c.ag.o
1
0
1
0
0
0
1
1
1

1
2
3
4
5
6
7
8
9

1
2
3
4
5
6
7
8
9

The second version counts align numbers over probes:

> # Count aligns
> kpa<-new("keyProfiler",keyTable=key1[,c("seqid","lend","rstart")],prof=prof,values=key1$nAligns)
> kpa@ev$dtb

seqid lend rstart gen.m gen.w loc.thx loc.abd ag.y ag.m ag.o
0
0
0
0
0

11
21
31
41
51

11
21
31
41
51

20
30
20
40
20

11
21
31
41
51

10
20
10
30
10

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

1
1
2
2
3

0
0
0
0
0

1
2
3
4
5

> addKeyTable(kpa,keyTable=key2[,c("seqid","lend","rstart")],index=2,values=key2$nAligns)
> addKeyTable(kpa,keyTable=key3[,c("seqid","lend","rstart")],index=4,values=key3$nAligns)
> ca<-appendKeyTable(kpa,ku,prefix="aln.")
> ca

seqid lend rstart nAligns aln.gen.m aln.gen.w aln.loc.thx aln.loc.abd
31
21
0
22
32
23
0
24
0
0
0
25
33
0
34
0

20
30
20
40
20
70
80
20

42
21
63
41
51
0
33
34

32
43
54
65
51
25
0
0

63
43
86
65
51
25
33
34

10
20
10
30
10
50
60
10

1
1
2
2
3
4
4
5

1
2
3
4
5
6
7
8

25

9

1
2
3
4
5
6
7
8
9

5

20

30

35

0

35

0

35

aln.ag.y aln.ag.m aln.ag.o
31
0
32
0
0
0
33
34
35

32
43
54
65
51
25
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

The readTableBamGaps function uses both versions simultaneously: Two keyPro-
filer objects keep probe and align data separately. The two tables are then ap-
pended to the key table subsequently.

References

[1] M Freund, C Asang, S Kammler, C Konermann, J Krummheuer, M Hipp,
I Meyer, W Gierling, S Theiss, T Preuss, D Schindler, Kjems J, and H Schaal.
A novel approach to describe a u1 snrna binding site. Nucleic Acids Research,
31:6963–6975, 2003. http://www.uni-duesseldorf.de/rna/html/hbond_
score.php.

[2] The SAM Format Specication Working Group. The sam format specication

(v1.4-r985). http://samtools.sourceforge.net/SAM1.pdf.

[3] D Kim, C Pertea, C Trapnell, H Pimentel, R Kelley, and SL Salzberg. Tophat2:
accurate alignment of transcriptomes in the presence of insertions, deletions
and gene fucions. Genome Biology, 14:R36, 2013. http://tophat.cbcb.
umd.edu/.

[4] G Yeo and CB Burge. Maximum entropy modeling of short sequence motifs
with applications to rna splicing signals. J Comput Biol, 11:377–394, 2004.
http://genes.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html.

26

