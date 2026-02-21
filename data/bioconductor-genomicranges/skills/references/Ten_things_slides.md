10 things (maybe) you didn’t know about GenomicRanges,
Biostrings, and Rsamtools

Hervé Pagès
hpages.on.github@gmail.com

June 2016

1. Inner vs outer metadata columns

> mcols(grl)$id <- paste0("ID", seq_along(grl))
> grl
GRangesList object of length 3:
$gr1
GRanges object with 1 range and 2 metadata columns:
ranges strand |

seqnames

<Rle> <IRanges>
3-6

score

GC
<Rle> | <integer> <numeric>
0.45

+ |

Chrom2

[1]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

5

$gr2
GRanges object with 2 ranges and 2 metadata columns:
ranges strand |

seqnames

score

<Rle> <IRanges>
7-9
13-15

Chrom1
Chrom1

[1]
[2]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

3
4

GC
<Rle> | <integer> <numeric>
0.3
0.5

+ |
- |

$gr3
GRanges object with 2 ranges and 2 metadata columns:
ranges strand |

seqnames

score

GC
<Rle> | <integer> <numeric>
0.4
0.1

- |
- |

6
2

<Rle> <IRanges>
1-3
4-9

Chrom1
Chrom2

[1]
[2]
-------

seqinfo: 2 sequences from an unspecified genome; no seqlengths

1. Inner vs outer metadata columns

> mcols(grl)
DataFrame with 3 rows and 1 column

# outer mcols

id
<character>
ID1
ID2
ID3

gr1
gr2
gr3
> mcols(unlist(grl, use.names=FALSE)) # inner mcols
DataFrame with 5 rows and 2 columns

score

GC
<integer> <numeric>
0.45
0.30
0.50
0.40
0.10

5
3
4
6
2

1
2
3
4
5

2. invertStrand()

Works out-of-the-box on any object that has a strand() getter and setter ==>
no need to implement specific methods.

> gr
GRanges object with 10 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
1-10
2-10
3-10
...
8-10
9-10
10

GC
<Rle> | <integer> <numeric>
1.000000
0.888889
0.777778
...
0.222222
0.111111
10 0.000000

a
b
c
.
h
i
j
-------
seqinfo: 3 sequences from an unspecified genome; no seqlengths

- |
+ |
+ |
... .
+ |
- |
- |

chr2
chr2
chr2
...
chr3
chr3
chr3

1
2
3
...
8
9

2. invertStrand()

> invertStrand(gr)
GRanges object with 10 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
1-10
2-10
3-10
...
8-10
9-10
10

GC
<Rle> | <integer> <numeric>
1.000000
0.888889
0.777778
...
0.222222
0.111111
10 0.000000

a
b
c
.
h
i
j
-------
seqinfo: 3 sequences from an unspecified genome; no seqlengths

+ |
- |
- |
... .
- |
+ |
+ |

chr2
chr2
chr2
...
chr3
chr3
chr3

1
2
3
...
8
9

2. invertStrand()

> grl
GRangesList object of length 3:
$gr1
GRanges object with 1 range and 2 metadata columns:
ranges strand |

seqnames

<Rle> <IRanges>
3-6

score

GC
<Rle> | <integer> <numeric>
0.45

+ |

Chrom2

[1]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

5

$gr2
GRanges object with 2 ranges and 2 metadata columns:
ranges strand |

seqnames

<Rle> <IRanges>
7-9
13-15

Chrom1
Chrom1

[1]
[2]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

3
4

score

GC
<Rle> | <integer> <numeric>
0.3
0.5

+ |
- |

$gr3
GRanges object with 2 ranges and 2 metadata columns:
ranges strand |

seqnames

score

<Rle> <IRanges>
1-3
4-9

Chrom1
Chrom2

[1]
[2]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

6
2

GC
<Rle> | <integer> <numeric>
0.4
0.1

- |
- |

2. invertStrand()

> invertStrand(grl)
GRangesList object of length 3:
$gr1
GRanges object with 1 range and 2 metadata columns:
ranges strand |

seqnames

<Rle> <IRanges>
3-6

score

GC
<Rle> | <integer> <numeric>
0.45

- |

5

Chrom2

[1]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

$gr2
GRanges object with 2 ranges and 2 metadata columns:
ranges strand |

seqnames

score

<Rle> <IRanges>
7-9
13-15

Chrom1
Chrom1

[1]
[2]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

3
4

GC
<Rle> | <integer> <numeric>
0.3
0.5

- |
+ |

$gr3
GRanges object with 2 ranges and 2 metadata columns:
ranges strand |

seqnames

<Rle> <IRanges>
1-3
4-9

Chrom1
Chrom2

[1]
[2]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

6
2

score

GC
<Rle> | <integer> <numeric>
0.4
0.1

+ |
+ |

3. extractList()

Extract groups of elements from a vector-like object and return them in a
list-like object.

> cvg <- Rle(c(0L, 2L, 5L, 1L, 0L), c(10, 6, 3, 4, 15))
> cvg

integer-Rle of length 38 with 5 runs
3
5

Lengths: 10 6
2
Values : 0

4 15
1 0

> i <- IRanges(c(16, 19, 9), width=5, names=letters[1:3])
> i

IRanges object with 3 ranges and 0 metadata columns:

end

start

width
<integer> <integer> <integer>
5
5
5

16
19
9

20
23
13

a
b
c

3. extractList()

> extractList(cvg, i)

RleList of length 3
$a
integer-Rle of length 5 with 3 runs

Lengths: 1 3 1
Values : 2 5 1

$b
integer-Rle of length 5 with 2 runs

Lengths: 1 4
Values : 5 1

$c
integer-Rle of length 5 with 2 runs

Lengths: 2 3
Values : 0 2

3. extractList()

i can be an IntegerList object:
> i <- IntegerList(c(25:20), NULL, seq(from=2, to=length(cvg), by=2))
> i
IntegerList of length 3
[[1]] 25 24 23 22 21 20
[[2]] integer(0)
[[3]] 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
> extractList(cvg, i)
RleList of length 3
[[1]]
integer-Rle of length 6 with 2 runs

Lengths: 2 4
Values : 0 1

[[2]]
integer-Rle of length 0 with 0 runs

Lengths:
Values :

[[3]]
integer-Rle of length 19 with 5 runs

Lengths: 5 3 1 2 8
Values : 0 2 5 1 0

4. ’with.revmap’ arg for reduce() and (now) disjoin()

> ir

IRanges object with 6 ranges and 2 metadata columns:

id

end

start

width |

score
<integer> <integer> <integer> | <character> <integer>
3
2
1
0
-1
-2

3 |
3 |
3 |
3 |
3 |
3 |

13
14
15
4
9
8

11
12
13
2
7
6

a
b
c
d
e
f

[1]
[2]
[3]
[4]
[5]
[6]

> ir2 <- reduce(ir, with.revmap=TRUE)
> ir2

start

IRanges object with 3 ranges and 1 metadata column:
revmap
<integer> <integer> <integer> | <IntegerList>
4
6,5
1,2,3

3 |
4 |
5 |

[1]
[2]
[3]

width |

4
9
15

2
6
11

end

4. ’with.revmap’ arg for reduce() and disjoin()

> revmap <- mcols(ir2)$revmap
> extractList(mcols(ir)$id, revmap)
CharacterList of length 3
[[1]] d
[[2]] f e
[[3]] a b c
> extractList(mcols(ir)$score, revmap)
IntegerList of length 3
[[1]] 0
[[2]] -2 -1
[[3]] 3 2 1
> mcols(ir2) <- DataFrame(id=extractList(mcols(ir)$id, revmap),
+
> ir2
IRanges object with 3 ranges and 2 metadata columns:

score=extractList(mcols(ir)$score, revmap))

end

start

width |

score
<integer> <integer> <integer> | <CharacterList> <IntegerList>
0
-2,-1
3,2,1

d
f,e
a,b,c

3 |
4 |
5 |

4
9
15

2
6
11

id

[1]
[2]
[3]

5. Zero-width ranges

findOverlaps/countOverlaps support zero-width ranges.

> sliding_query <- IRanges(1:6, width=0)
> sliding_query

IRanges object with 6 ranges and 0 metadata columns:

end

start

width
<integer> <integer> <integer>
0
0
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

1
2
3
4
5
6

[1]
[2]
[3]
[4]
[5]
[6]

> countOverlaps(sliding_query, IRanges(3, 4))
[1] 0 0 0 1 0 0

But you have to specify minoverlap=0 for this to work (default is 1).

> countOverlaps(sliding_query, IRanges(3, 4), minoverlap=0)
[1] 0 0 0 1 0 0

6. Biostrings::replaceAt()

Perform multiple substitutions at arbitrary positions in a set of sequences.

> library(Biostrings)
> library(hgu95av2probe)
> probes <- DNAStringSet(hgu95av2probe)
> probes

DNAStringSet object of length 201800:

width seq

[1]
[2]
[3]
...
[201798]
[201799]
[201800]

25 TGGCTCCTGCTGAGGTCCCCTTTCC
25 GGCTGTGAATTCCTGTACATATTTC
25 GCTTCAATTCCATTATGTTTTAATG

... ...

25 TTCTGTCAAAGCATCATCTCAACAA
25 CAAAGCATCATCTCAACAAGCCCTC
25 GTGCTCCTTGTCAACAGCGCACCCA

6. Biostrings::replaceAt()

Replace 3rd and 4th nucleotides by pattern -++-.

> replaceAt(probes, at=IRanges(3, 4), value="-++-")

DNAStringSet object of length 201800:

width seq

[1]
[2]
[3]
...
[201798]
[201799]
[201800]

27 TG-++-TCCTGCTGAGGTCCCCTTTCC
27 GG-++-GTGAATTCCTGTACATATTTC
27 GC-++-CAATTCCATTATGTTTTAATG

... ...

27 TT-++-GTCAAAGCATCATCTCAACAA
27 CA-++-GCATCATCTCAACAAGCCCTC
27 GT-++-TCCTTGTCAACAGCGCACCCA

6. Biostrings::replaceAt()

If supplied pattern is empty, then performs deletions.

> replaceAt(probes, at=IRanges(3, 4), value="")

DNAStringSet object of length 201800:

width seq

[1]
[2]
[3]
...
[201798]
[201799]
[201800]

23 TGTCCTGCTGAGGTCCCCTTTCC
23 GGGTGAATTCCTGTACATATTTC
23 GCCAATTCCATTATGTTTTAATG

... ...

23 TTGTCAAAGCATCATCTCAACAA
23 CAGCATCATCTCAACAAGCCCTC
23 GTTCCTTGTCAACAGCGCACCCA

6. Biostrings::replaceAt()

If at is a zero-with range, then performs insertions.

> replaceAt(probes, at=IRanges(4, 3), value="-++-")

DNAStringSet object of length 201800:

width seq

[1]
[2]
[3]
...
[201798]
[201799]
[201800]

29 TGG-++-CTCCTGCTGAGGTCCCCTTTCC
29 GGC-++-TGTGAATTCCTGTACATATTTC
29 GCT-++-TCAATTCCATTATGTTTTAATG

... ...

29 TTC-++-TGTCAAAGCATCATCTCAACAA
29 CAA-++-AGCATCATCTCAACAAGCCCTC
29 GTG-++-CTCCTTGTCAACAGCGCACCCA

6. Biostrings::replaceAt()

Use it in combination with vmatchPattern to replace all the occurences of a
given pattern with another pattern:

> midx <- vmatchPattern("VCGTT", probes, fixed=FALSE)
> replaceAt(probes, at=midx, value="-++-")

DNAStringSet object of length 201800:

width seq

[1]
[2]
[3]
...
[201798]
[201799]
[201800]

25 TGGCTCCTGCTGAGGTCCCCTTTCC
25 GGCTGTGAATTCCTGTACATATTTC
25 GCTTCAATTCCATTATGTTTTAATG

... ...

25 TTCTGTCAAAGCATCATCTCAACAA
25 CAAAGCATCATCTCAACAAGCCCTC
25 GTGCTCCTTGTCAACAGCGCACCCA

7. GRanges as a subscript

> cvg <- RleList(chr1=101:120, chr2=2:-8, chr3=31:40)
> gr
GRanges object with 10 ranges and 2 metadata columns:

score

seqnames

ranges strand |

<Rle> <IRanges>
1-10
2-10
3-10
...
8-10
9-10
10

GC
<Rle> | <integer> <numeric>
1.000000
0.888889
0.777778
...
0.222222
0.111111
10 0.000000

a
b
c
.
h
i
j
-------
seqinfo: 3 sequences from an unspecified genome; no seqlengths

- |
+ |
+ |
... .
+ |
- |
- |

chr2
chr2
chr2
...
chr3
chr3
chr3

1
2
3
...
8
9

7. GRanges as a subscript

> cvg[gr]

RleList of length 10
$chr2
integer-Rle of length 10 with 10 runs
1 1 1 1

Lengths: 1
Values : 2

1 1 1 1
1
1 0 -1 -2 -3 -4 -5 -6 -7

$chr2
integer-Rle of length 9 with 9 runs

Lengths: 1
Values : 1

1 1 1 1
1 1 1 1
0 -1 -2 -3 -4 -5 -6 -7

$chr2
integer-Rle of length 8 with 8 runs

Lengths: 1
1 1 1
Values : 0 -1 -2 -3 -4 -5 -6 -7

1 1 1 1

$chr2
integer-Rle of length 7 with 7 runs

Lengths: 1
1 1
Values : -1 -2 -3 -4 -5 -6 -7

1 1 1 1

$chr1
integer-Rle of length 6 with 6 runs
Lengths:
1
1
Values : 105 106 107 108 109 110

1

1

1

1

...
<5 more elements>

8. BSgenomeViews objects

> library(BSgenome.Mmusculus.UCSC.mm10)
> genome <- BSgenome.Mmusculus.UCSC.mm10
> library(TxDb.Mmusculus.UCSC.mm10.knownGene)
> txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene
> ex <- exons(txdb, columns=c("exon_id", "tx_name", "gene_id"))
> v <- Views(genome, ex)

8. BSgenomeViews objects

> v

BSgenomeViews object with 447558 views and 3 metadata columns:

dna |
<DNAStringSet> |
+ [AAGGAAAGAG...TAGAGAAATG] |
+ [GTGCTTGCTT...ACAAAAATAT] |
+ [TTCTTCTGTG...TACCTTCAAT] |
... .
- [CTGTGGTCCT...CAGAGAAATG] |
- [CTCTCTGCTG...CAGAGAAATG] |
- [AGCTGTCCCG...GCCTTCTCAG] |

...

seqnames
<Rle>

ranges strand
<IRanges> <Rle>

[1]
[2]
[3]
...

...
[447556] chrUn_JH584304
[447557] chrUn_JH584304
[447558] chrUn_JH584304

chr1 3073253-3074322
chr1 3102016-3102125
chr1 3252757-3253236
...
58564-58835
58564-59690
59592-59667
tx_name

exon_id
<integer>

gene_id
<CharacterList> <CharacterList>

1 ENSMUST00000193812.1
2 ENSMUST00000082908.1
3 ENSMUST00000192857.1
...
447556 ENSMUST00000179505.7
447557 ENSMUST00000178343.1
447558 ENSMUST00000179505.7

[1]
[2]
[3]
...
[447556]
[447557]
[447558]
-------
seqinfo: 239 sequences (1 circular) from mm10 genome

...

...
66776
66776
66776

8. BSgenomeViews objects

> af <- alphabetFrequency(v, baseOnly=TRUE)
> head(af)

A

C

G

20

45 20

[1,] 376 160 206 328
[2,]
25
[3,] 138 105 86 151
29
[4,]
[5,]
33
[6,] 208 258 204 256

28 14
57 39

30
20

T other
0
0
0
0
0
0

9. Pile-up statistics on a BAM file with Rsamtools::pileup()

> library(Rsamtools)
> library(RNAseqData.HNRNPC.bam.chr14)
> fl <- RNAseqData.HNRNPC.bam.chr14_BAMFILES[1]
> sbp <- ScanBamParam(which=GRanges("chr14", IRanges(1, 53674770)))
> pp <- PileupParam(distinguish_nucleotides=FALSE,
+
+
+
+
> res <- pileup(fl, scanBamParam=sbp, pileupParam=pp)

distinguish_strands=FALSE,
min_mapq=13,
min_base_quality=10,
min_nucleotide_depth=4)

9. Pile-up statistics on a BAM file with Rsamtools::pileup()

> dim(res)

[1] 248409

> head(res)

seqnames

4

pos count

1
2
3
4
5
6

chr14 19681651
chr14 19681655
chr14 19681657
chr14 19681658
chr14 19681661
chr14 19681662

which_label
4 chr14:1-53674770
4 chr14:1-53674770
4 chr14:1-53674770
4 chr14:1-53674770
4 chr14:1-53674770
4 chr14:1-53674770

10. Merging 2 GRanges objects (added this week)

> x
GRanges object with 2 ranges and 3 metadata columns:
ranges strand |

seqnames

a2
<Rle> | <numeric> <integer> <numeric>
6
8

[1]
[2]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

<Rle> <IRanges>
chr1
1-1000
chr2 2000-3000

0.45
NA

* |
* |

score

5
7

a1

> y
GRanges object with 3 ranges and 3 metadata columns:
ranges strand |

seqnames

b2
<Rle> | <numeric> <integer> <numeric>
1
-2
1

[1]
[2]
[3]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

<Rle> <IRanges>
150-151
chr2
chr1
1-10
chr2 2000-3000

0.70
0.82
0.10

* |
* |
* |

score

0
5
1

b1

10. Merging 2 GRanges objects

> merge(x, y)
GRanges object with 1 range and 5 metadata columns:
ranges strand |

seqnames

score

[1]

<Rle> <IRanges>
chr2 2000-3000

b1
<Rle> | <numeric> <integer> <numeric> <integer>
1

0.1

* |

a2

a1

8

7

b2
<numeric>
1

[1]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

10. Merging 2 GRanges objects

> merge(x, y, all=TRUE)
GRanges object with 4 ranges and 5 metadata columns:
ranges strand |

seqnames

score

[1]
[2]
[3]
[4]

<Rle> <IRanges>
1-10
chr1
1-1000
chr1
chr2
150-151
chr2 2000-3000

a1

b1
<Rle> | <numeric> <integer> <numeric> <integer>
5
<NA>
0
1

0.82
0.45
0.70
0.10

<NA>
5
<NA>
7

* |
* |
* |
* |

NA
6
NA
8

a2

b2
<numeric>
-2
NA
1
1

[1]
[2]
[3]
[4]
-------
seqinfo: 2 sequences from an unspecified genome; no seqlengths

