A quick introduction to GRanges and GRangesList objects

Hervé Pagès
hpages.on.github@gmail.com
–
Michael Lawrence
lawrence.michael@gene.com

July 2015

GRanges objects

The GRanges() constructor
GRanges accessors
Vector operations on GRanges objects
Range-based operations on GRanges objects

GRangesList objects

The GRangesList() constructor
GRangesList accessors
Vector operations on GRangesList objects
List operations on GRangesList objects
Range-based operations on GRangesList objects

Other resources

The GRanges class is a container for...

... storing a set of genomic ranges (a.k.a. genomic regions or genomic intervals).

▶ Each genomic range is described by a chromosome name, a start, an end, and a

strand.

▶ start and end are both 1-based positions relative to the 5’ end of the plus strand

of the chromosome, even when the range is on the minus strand.

▶ start and end are both considered to be included in the interval (except when the

range is empty).

▶ The width of the range is the number of genomic positions included in it. So

width = end - start + 1.

▶ end is always >= start, except for empty ranges (a.k.a. zero-width ranges) where

end = start - 1.

Note that the start is always the leftmost position and the end the rightmost, even
when the range is on the minus strand.
Gotcha: A TSS is at the end of the range associated with a transcript located on the
minus strand.

The GRanges() constructor

> library(GenomicRanges)
> gr1 <- GRanges(seqnames=Rle(c("ch1", "chMT"), c(2, 4)),
+
+
> gr1

ranges=IRanges(16:21, 20),
strand=rep(c("+", "-", "*"), 2))

GRanges object with 6 ranges and 0 metadata columns:

seqnames

ranges strand
<Rle>
+
-
*
+
-
*

<Rle> <IRanges>
16-20
17-20
18-20
19-20
20
21-20

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

ch1
ch1
chMT
chMT
chMT
chMT

GRanges accessors: length(), seqnames(), ranges()

> length(gr1)

[1] 6

> seqnames(gr1)

factor-Rle of length 6 with 2 runs

Lengths:
Values : ch1

2

4
chMT

Levels(2): ch1 chMT

> ranges(gr1)

IRanges object with 6 ranges and 0 metadata columns:

end

start

width
<integer> <integer> <integer>
5
4
3
2
1
0

16
17
18
19
20
21

20
20
20
20
20
20

[1]
[2]
[3]
[4]
[5]
[6]

GRanges accessors: start(), end(), width(), strand()

> start(gr1)

[1] 16 17 18 19 20 21

> end(gr1)

[1] 20 20 20 20 20 20

> width(gr1)

[1] 5 4 3 2 1 0

> strand(gr1)

factor-Rle of length 6 with 6 runs

Lengths: 1 1 1 1 1 1
Values : + - * + - *

Levels(3): + - *

> strand(gr1) <- c("-", "-", "+")
> strand(gr1)

factor-Rle of length 6 with 4 runs

Lengths: 2 1 2 1
Values : - + - +

Levels(3): + - *

GRanges accessors: names()

> names(gr1) <- LETTERS[1:6]
> gr1

GRanges object with 6 ranges and 0 metadata columns:

seqnames

ranges strand
<Rle>
-
-
+
-
-
+

<Rle> <IRanges>
16-20
17-20
18-20
19-20
20
21-20

A
B
C
D
E
F
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

ch1
ch1
chMT
chMT
chMT
chMT

> names(gr1)

[1] "A" "B" "C" "D" "E" "F"

GRanges accessors: mcols()

Like with most Bioconductor vector-like objects, metadata columns can be added to a
GRanges object:

> mcols(gr1) <- DataFrame(score=11:16, GC=seq(1, 0, length=6))
> gr1

GRanges object with 6 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
16-20
17-20
18-20
19-20
20
21-20

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.2
0.0

A
B
C
D
E
F
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

ch1
ch1
chMT
chMT
chMT
chMT

- |
- |
+ |
- |
- |
+ |

11
12
13
14
15
16

> mcols(gr1)

DataFrame with 6 rows and 2 columns

score

GC
<integer> <numeric>
1.0
0.8
0.6
0.4
0.2
0.0

11
12
13
14
15
16

A
B
C
D
E
F

GRanges accessors: seqinfo(), seqlevels(), seqlengths()

> seqinfo(gr1)

Seqinfo object with 2 sequences from an unspecified genome; no seqlengths:

seqnames seqlengths isCircular genome
<NA>
NA
ch1
<NA>
NA
chMT

NA
NA

> seqlevels(gr1)

[1] "ch1"

"chMT"

> seqlengths(gr1)

ch1 chMT
NA

NA

> seqlengths(gr1) <- c(50000, 800)
> seqlengths(gr1)

ch1 chMT
800

50000

Vector operations on GRanges objects

What we call vector operations are operations that work on any ordinary vector:

▶ length(), names()
▶ Single-bracket subsetting: [
▶ Combining: c()
▶ split(), relist()
▶ Comparing: ==, !=, match(), %in%, duplicated(), unique()
▶ Ordering: <=, >=, <, >, order(), sort(), rank()

GRanges objects support all these vector operations ==> They’re considered
vector-like objects.

Vector operations on GRanges objects: Single-bracket subsetting

> gr1[c("F", "A")]

GRanges object with 2 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
21-20
16-20

chMT
ch1

score

GC
<Rle> | <integer> <numeric>
0
1

F
A
-------
seqinfo: 2 sequences from an unspecified genome

+ |
- |

16
11

> gr1[strand(gr1) == "+"]

GRanges object with 2 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
18-20
21-20

score

GC
<Rle> | <integer> <numeric>
0.6
0.0

+ |
+ |

13
16

chMT
chMT

C
F
-------
seqinfo: 2 sequences from an unspecified genome

Vector operations on GRanges objects: Single-bracket subsetting

> gr1 <- gr1[-5]
> gr1

GRanges object with 5 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
16-20
17-20
18-20
19-20
21-20

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1
ch1
chMT
chMT
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

Vector operations on GRanges objects: Combining

> gr2 <- GRanges(seqnames="ch2",
+
+
+
> gr12 <- c(gr1, gr2)
> gr12

ranges=IRanges(start=c(2:1,2), width=6),
score=15:13,
GC=seq(0, 0.4, length=3))

GRanges object with 8 ranges and 2 metadata columns:

seqnames

ranges strand |

A
B
C
.

<Rle> <IRanges>
16-20
17-20
18-20
...
2-7
1-6
2-7

ch1
ch1
chMT
...
ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
...
0.0
0.2
0.4

- |
- |
+ |
... .
* |
* |
* |

11
12
13
...
15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

Vector operations on GRanges objects: Comparing

> gr12[length(gr12)] == gr12

[1] FALSE FALSE FALSE FALSE FALSE

TRUE FALSE TRUE

> duplicated(gr12)

[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE TRUE

> unique(gr12)

GRanges object with 7 ranges and 2 metadata columns:

seqnames

ranges strand |

A
B
C
D
F

<Rle> <IRanges>
16-20
17-20
18-20
19-20
21-20
2-7
1-6

ch1
ch1
chMT
chMT
chMT
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0
0.0
0.2

- |
- |
+ |
- |
+ |
* |
* |

11
12
13
14
16
15
14

-------
seqinfo: 3 sequences from an unspecified genome

Vector operations on GRanges objects: Ordering

> sort(gr12)

GRanges object with 8 ranges and 2 metadata columns:

seqnames

ranges strand |

A
B
C
.

<Rle> <IRanges>
16-20
17-20
18-20
...
1-6
2-7
2-7

ch1
ch1
chMT
...
ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
...
0.2
0.0
0.4

- |
- |
+ |
... .
* |
* |
* |

11
12
13
...
14
15
13

-------
seqinfo: 3 sequences from an unspecified genome

Splitting a GRanges object

> split(gr12, seqnames(gr12))

GRangesList object of length 3:
$ch1
GRanges object with 2 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
16-20
17-20

ch1
ch1

score

GC
<Rle> | <integer> <numeric>
1.0
0.8

- |
- |

A
B
-------
seqinfo: 3 sequences from an unspecified genome

11
12

$chMT
GRanges object with 3 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
18-20
19-20
21-20

GC
<Rle> | <integer> <numeric>
0.6
0.4
0.0

C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

chMT
chMT
chMT

+ |
- |
+ |

13
14
16

$ch2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

Exercise 1

a. Load the GenomicRanges package.

b. Open the man page for the GRanges class and run the examples in it.

c. Extract from GRanges object gr the elements (i.e. ranges) with a score between 4

and 8.

d. Split gr by strand.

An overview of range-based operations

Intra range transformations
shift(), narrow(), resize(), flank()

Coverage and slicing
coverage(), slice()

Inter range transformations
range(), reduce(), gaps(), disjoin()

Finding/counting overlapping
ranges
findOverlaps(), countOverlaps()

Range-based set operations
union(), intersect(), setdiff(),
punion(), pintersect(), psetdiff(),
pgap()

Finding the nearest range neighbor
nearest(), precede(), follow()

and more...

Examples of some common range-based operations

Range-based operations on GRanges objects

> gr2

seqnames

GRanges object with 3 ranges and 2 metadata columns:
ranges strand |

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

* |
* |
* |

15
14
13

score

> shift(gr2, 50)

seqnames

GRanges object with 3 ranges and 2 metadata columns:
ranges strand |

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

<Rle> <IRanges>
52-57
51-56
52-57

* |
* |
* |

ch2
ch2
ch2

15
14
13

score

Range-based operations on GRanges objects (continued)

> gr1

GRanges object with 5 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
16-20
17-20
18-20
19-20
21-20

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1
ch1
chMT
chMT
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

> resize(gr1, 12)

GRanges object with 5 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
9-20
9-20
18-29
9-20
21-32

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1
ch1
chMT
chMT
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

Range-based operations on GRanges objects (continued)

> gr1

GRanges object with 5 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
16-20
17-20
18-20
19-20
21-20

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1
ch1
chMT
chMT
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

> flank(gr1, 3)

GRanges object with 5 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
21-23
21-23
15-17
21-23
18-20

GC
<Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1
ch1
chMT
chMT
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

Range-based operations on GRanges objects (continued)

> gr3 <- shift(gr1, c(35000, rep(0, 3), 100))
> width(gr3)[c(3,5)] <- 117
> gr3

score

seqnames
<Rle>

GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

> range(gr3)

GRanges object with 3 ranges and 0 metadata columns:

seqnames

<Rle> <IRanges>
ch1 17-35020
18-237
19-20

ranges strand
<Rle>
-
+
-

[1]
[2]
[3]
-------
seqinfo: 2 sequences from an unspecified genome

chMT
chMT

Range-based operations on GRanges objects (continued)

> gr3

score

seqnames
<Rle>

GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

> reduce(gr3)

seqnames
<Rle>
ch1
17-20
ch1 35016-35020
18-237
19-20

GRanges object with 4 ranges and 0 metadata columns:
ranges strand
<IRanges> <Rle>
-
-
+
-

[1]
[2]
[3]
[4]
-------
seqinfo: 2 sequences from an unspecified genome

chMT
chMT

Range-based operations on GRanges objects (continued)

> gr3

score

seqnames
<Rle>

GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

> gaps(gr3)

GRanges object with 10 ranges and 0 metadata columns:

seqnames

ranges strand
<Rle>
+
-
-
...
-
-
*

<Rle> <IRanges>
1-50000
ch1
ch1
1-16
ch1 21-35015
...
...
1-18
chMT
21-800
chMT
1-800
chMT

[1]
[2]
[3]
...
[8]
[9]
[10]
-------
seqinfo: 2 sequences from an unspecified genome

Range-based operations on GRanges objects (continued)

> gr3

score

seqnames
<Rle>

GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 2 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

> disjoin(gr3)

seqnames
<Rle>
ch1
17-20
ch1 35016-35020
18-120
121-134
135-237
19-20

GRanges object with 6 ranges and 0 metadata columns:
ranges strand
<IRanges> <Rle>
-
-
+
+
+
-

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 2 sequences from an unspecified genome

chMT
chMT
chMT
chMT

Exercise 2

Using GRanges object gr created at Exercise 1:

a. Shift the ranges in gr by 1000 positions to the right.

b. What method is called when doing shift() on a GRanges object? Find the man

page for this method.

Coverage

> cvg12 <- coverage(gr12)
> cvg12

RleList of length 3
$ch1
integer-Rle of length 50000 with 4 runs

Lengths:
Values :

15
0

1
1

4 49980
0
2

$chMT
integer-Rle of length 800 with 4 runs

Lengths: 17
0
Values :

1
1

2 780
0
2

$ch2
integer-Rle of length 7 with 3 runs

Lengths: 1 5 1
Values : 1 3 2

Coverage (continued)

> mean(cvg12)

ch1

ch2
0.000180 0.006250 2.571429

chMT

> max(cvg12)

ch1 chMT
2

2

ch2
3

Slicing the coverage

> sl12 <- slice(cvg12, lower=1)
> sl12

RleViewsList object of length 3:
$ch1
Views on a 50000-length Rle subject

views:

start end width

[1]

16 20

5 [1 2 2 2 2]

$chMT
Views on a 800-length Rle subject

views:

start end width

[1]

18 20

3 [1 2 2]

$ch2
Views on a 7-length Rle subject

views:

start end width

[1]

1

7

7 [1 3 3 3 3 3 2]

> elementNROWS(sl12)

ch1 chMT
1

1

ch2
1

> sl12$chMT

Views on a 800-length Rle subject

views:

start end width

[1]

18 20

3 [1 2 2]

> mean(sl12$chMT)

[1] 1.666667

> max(sl12$chMT)

[1] 2

findOverlaps()

Load aligned reads from a BAM file:

> library(pasillaBamSubset)
> untreated1_chr4()

[1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/pasillaBamSubset/extdata/untreated1_chr4.bam"

> library(GenomicAlignments)
> reads <- readGAlignments(untreated1_chr4())

and store them in a GRanges object:

> reads <- as(reads, "GRanges")
> reads[1:4]

GRanges object with 4 ranges and 0 metadata columns:

seqnames

ranges strand
<Rle>
-
-
+
+

<Rle> <IRanges>
892-966
chr4
919-993
chr4
chr4
924-998
chr4 936-1010

[1]
[2]
[3]
[4]
-------
seqinfo: 8 sequences from an unspecified genome

findOverlaps() (continued)

Load the gene ranges from a TxDb package:

> library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)
> txdb <- TxDb.Dmelanogaster.UCSC.dm3.ensGene
> dm3_genes <- genes(txdb)

and find the overlaps between the reads and the genes:

> hits <- findOverlaps(reads, dm3_genes)
> head(hits)

Hits object with 6 hits and 0 metadata columns:

queryHits subjectHits
<integer>
<integer>
11499
6296
11499
6304
11499
6305
11499
6310
11499
6311
11499
6312

[1]
[2]
[3]
[4]
[5]
[6]
-------
queryLength: 204355 / subjectLength: 15682

Exercise 3

a. Recreate GRanges objects reads and dm3_genes from previous slides.

b. What method is called when calling findOverlaps() on them? Open the man

page for this method.

c. Find the overlaps between the 2 objects but this time the strand should be

ignored.

Exercise 4

In this exercise we want to get the exon sequences for the dm3 genome.

a. Extract the exon ranges from txdb.

b. Load the BSgenome.Dmelanogaster.UCSC.dm3 package.

c. Use getSeq() to extract the exon sequences from the BSgenome object in

BSgenome.Dmelanogaster.UCSC.dm3 .

The GRangesList class is a container for...

storing a list of compatible GRanges objects.

compatible means:

▶ they are relative to the same genome,
▶ AND they have the same metadata columns (accessible with the mcols()

accessor).

The GRangesList() constructor

> grl <- GRangesList(gr3, gr2)
> grl

seqnames
<Rle>

GRangesList object of length 2:
[[1]]
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

[[2]]
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

GRangesList accessors

> length(grl)

[1] 2

> seqnames(grl)

> strand(grl)

RleList of length 2
[[1]]
factor-Rle of length 5 with 2 runs

RleList of length 2
[[1]]
factor-Rle of length 5 with 4 runs

Lengths:
Values : ch1

2

3
chMT

Levels(3): ch1 chMT ch2

Lengths: 2 1 1 1
Values : - + - +

Levels(3): + - *

[[2]]
factor-Rle of length 3 with 1 run

[[2]]
factor-Rle of length 3 with 1 run

Lengths:
3
Values : ch2

Levels(3): ch1 chMT ch2

Lengths: 3
Values : *

Levels(3): + - *

GRangesList accessors (continued)

> ranges(grl)

> start(grl)

IRangesList object of length 2:
[[1]]
IRanges object with 5 ranges and 0 metadata columns:

IntegerList of length 2
[[1]] 35016 17 18 19 121
[[2]] 2 1 2

end

start

width
<integer> <integer> <integer>
5
4
117
2
117

35020
20
134
20
237

35016
17
18
19
121

A
B
C
D
F

end

start

width
<integer> <integer> <integer>
6
6
6

7
6
7

2
1
2

[[2]]
IRanges object with 3 ranges and 0 metadata columns:

> end(grl)

IntegerList of length 2
[[1]] 35020 20 134 20 237
[[2]] 7 6 7

> width(grl)

IntegerList of length 2
[[1]] 5 4 117 2 117
[[2]] 6 6 6

GRangesList accessors (continued)

> names(grl) <- c("TX1", "TX2")
> grl

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

GRangesList accessors (continued)

> mcols(grl)$geneid <- c("GENE1", "GENE2")
> mcols(grl)

DataFrame with 2 rows and 1 column

geneid
<character>
GENE1
GENE2

TX1
TX2

> grl

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

GRangesList accessors (continued)

> seqinfo(grl)

Seqinfo object with 3 sequences from an unspecified genome:

seqnames seqlengths isCircular genome
<NA>
ch1
<NA>
chMT
<NA>
ch2

50000
800
NA

NA
NA
NA

Vector operations on GRangesList objects

Only the following vector operations are supported on GRangesList objects:

▶ length(), names()
▶ Single-bracket subsetting: [
▶ Combining: c()

Vector operations on GRangesList objects

> grl[c("TX2", "TX1")]

GRangesList object of length 2:
$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

score

seqnames
<Rle>

$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

Vector operations on GRangesList objects (continued)

> c(grl, GRangesList(gr3))

seqnames
<Rle>

GRangesList object of length 3:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

score

seqnames
<Rle>

[[3]]
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

List operations on GRangesList objects

What we call list operations are operations that work on an ordinary list:

▶ Double-bracket subsetting: [[
▶ elementNROWS(), unlist()
▶ lapply(), sapply(), endoapply()
▶ mendoapply() (not covered in this presentation)

GRangesList objects support all these list operations ==> They’re considered list-like
objects.

elementNROWS() and unlist()

> grl[[2]]

GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

> elementNROWS(grl)

TX1 TX2
3

5

> unlisted <- unlist(grl, use.names=FALSE)
> unlisted

# same as c(grl[[1]], grl[[2]])

GRanges object with 8 ranges and 2 metadata columns:
ranges strand |

score

seqnames
<Rle>

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
...
0.0
0.2
0.4

ch1 35016-35020
17-20
ch1
18-134
chMT
...
...
2-7
ch2
1-6
ch2
2-7
ch2

- |
- |
+ |
... .
* |
* |
* |

11
12
13
...
15
14
13

A
B
C
.

-------
seqinfo: 3 sequences from an unspecified genome

relist()

> grl100 <- relist(shift(unlisted, 100), grl)
> grl100

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35116-35120
117-120
ch1
118-234
chMT
119-120
chMT
221-337
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
102-107
101-106
102-107

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

endoapply()

> grl100b <- endoapply(grl, shift, 100)
> grl100b

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35116-35120
117-120
ch1
118-234
chMT
119-120
chMT
221-337
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
102-107
101-106
102-107

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

> mcols(grl100)

DataFrame with 2 rows and 0 columns

> mcols(grl100b)

DataFrame with 2 rows and 1 column

geneid
<character>
GENE1
GENE2

TX1
TX2

Range-based operations on GRangesList objects

> grl

> shift(grl, 100)

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35116-35120
117-120
ch1
118-234
chMT
119-120
chMT
221-337
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

seqnames

ranges strand |

<Rle> <IRanges>
102-107
101-106
102-107

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

-------
seqinfo: 3 sequences from an unspecified genome

shift(grl, 100) is equivalent to endoapply(grl, shift, 100)

Range-based operations on GRangesList objects (continued)

> grl

> flank(grl, 10)

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35021-35030
21-30
ch1
8-17
chMT
21-30
chMT
111-120
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

seqnames

ranges strand |

<Rle> <IRanges>
-8-1
-9-0
-8-1

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

-------
seqinfo: 3 sequences from an unspecified genome

-------
seqinfo: 3 sequences from an unspecified genome

flank(grl, 10) is equivalent to endoapply(grl, flank, 10)

Range-based operations on GRangesList objects (continued)

> grl

> range(grl)

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

GRangesList object of length 2:
$TX1
GRanges object with 3 ranges and 0 metadata columns:

seqnames

<Rle> <IRanges>
ch1 17-35020
18-237
19-20

ranges strand
<Rle>
-
+
-

[1]
[2]
[3]
-------
seqinfo: 3 sequences from an unspecified genome

chMT
chMT

$TX2
GRanges object with 1 range and 0 metadata columns:

seqnames

<Rle> <IRanges>
1-7

ch2

ranges strand
<Rle>
*

[1]
-------
seqinfo: 3 sequences from an unspecified genome

-------
seqinfo: 3 sequences from an unspecified genome

range(grl) is equivalent to endoapply(grl, range)

Range-based operations on GRangesList objects (continued)

> grl

> reduce(grl)

seqnames
<Rle>

GRangesList object of length 2:
$TX1
GRanges object with 5 ranges and 2 metadata columns:
ranges strand |

GC
<IRanges> <Rle> | <integer> <numeric>
1.0
0.8
0.6
0.4
0.0

A
B
C
D
F
-------
seqinfo: 3 sequences from an unspecified genome

ch1 35016-35020
17-20
ch1
18-134
chMT
19-20
chMT
121-237
chMT

- |
- |
+ |
- |
+ |

11
12
13
14
16

score

$TX2
GRanges object with 3 ranges and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7
1-6
2-7

ch2
ch2
ch2

score

GC
<Rle> | <integer> <numeric>
0.0
0.2
0.4

* |
* |
* |

15
14
13

GRangesList object of length 2:
$TX1
GRanges object with 4 ranges and 0 metadata columns:
ranges strand
<IRanges> <Rle>
-
-
+
-

[1]
[2]
[3]
[4]
-------
seqinfo: 3 sequences from an unspecified genome

seqnames
<Rle>
ch1
17-20
ch1 35016-35020
18-237
19-20

chMT
chMT

$TX2
GRanges object with 1 range and 0 metadata columns:

seqnames

<Rle> <IRanges>
1-7

ranges strand
<Rle>
*

ch2

[1]
-------
seqinfo: 3 sequences from an unspecified genome

-------
seqinfo: 3 sequences from an unspecified genome

reduce(grl) is equivalent to endoapply(grl, reduce)

Range-based operations on GRangesList objects (continued)

> grl2

> setdiff(grl2, grl3)

seqnames

GRangesList object of length 2:
$TX1
GRanges object with 1 range and 2 metadata columns:
GC
<Rle> | <integer> <numeric>
0.6

C
-------
seqinfo: 3 sequences from an unspecified genome

<Rle> <IRanges>
18-134

ranges strand |

score

chMT

+ |

13

$TX2
GRanges object with 1 range and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7

ch2

score

GC
<Rle> | <integer> <numeric>
0

* |

15

GRangesList object of length 2:
$TX1
GRanges object with 2 ranges and 0 metadata columns:

seqnames

<Rle> <IRanges>
18-21
131-134

ranges strand
<Rle>
+
+

chMT
chMT

[1]
[2]
-------
seqinfo: 3 sequences from an unspecified genome

$TX2
GRanges object with 0 ranges and 0 metadata columns:

seqnames

<Rle> <IRanges>

ranges strand
<Rle>

-------
seqinfo: 3 sequences from an unspecified genome

-------
seqinfo: 3 sequences from an unspecified genome

> grl3

GRangesList object of length 2:
[[1]]
GRanges object with 1 range and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
22-130

chMT

score

GC
<Rle> | <integer> <numeric>
0.6

+ |

13

-------
seqinfo: 3 sequences from an unspecified genome

[[2]]
GRanges object with 1 range and 2 metadata columns:

seqnames

ranges strand |

<Rle> <IRanges>
2-7

ch2

score

GC
<Rle> | <integer> <numeric>
0

* |

15

-------
seqinfo: 3 sequences from an unspecified genome

setdiff(grl2, grl) is equivalent to mendoapply(setdiff, grl2, grl)

Other resources

▶ Great slides from Michael on ranges sequences and alignments:

http://bioconductor.org/help/course-materials/2014/CSAMA2014/2_
Tuesday/lectures/Ranges_Sequences_and_Alignments-Lawrence.pdf
▶ Vignettes in the GenomicRanges package (browseVignettes("GenomicRanges")).
▶ GRanges and GRangesList man pages in the GenomicRanges package.
▶ Vignettes and GAlignments man page in the GenomicAlignments package.
▶ Bioconductor support site: http://support.bioconductor.org/
▶ The genomic ranges paper: Michael Lawrence, Wolfgang Huber, Hervé Pagès,
Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T. Morgan, Vincent
J. Carey. Software for Computing and Annotating Genomic Ranges. PLOS
Computational Biology, 4(3), 2013.

