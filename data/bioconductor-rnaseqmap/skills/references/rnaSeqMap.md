rnaSeqMap: RNASeq analyses using xmap database
back-end

Anna Lesniewska, Michal Okoniewski

April 24, 2017

Vignette for v.2.11.1 - no Xmap database needed

Contents

1 Recent changes and updates

2 Introduction

3 Using the SeqReadsand NucleotideDistr objects

2

2

3

4 Processing schema to get the coverage measures using the ”camel wrapper” 3

5 Using Aumann-Lindell two-sliding-window algorithm to ﬁnd expressed ge-

nomic regions

3

1

1 Recent changes and updates

8.09.2012 - the vignette contains mainly the material covered by the ECCB 2012 tutorial
chunk 28.06.2012 - switched to GAlignments in RS class and used them to get coverage in
ND - corrected all the rle into Rle 04.10.2011 - added data modiﬁcation generators : gen-
eratorAddSquare(), generatorAdd(),generatorMultiply(), generatorTrunc(), generatorPeak(),
generatorSynth()

local coverage normalizations: standarizationNormalize(), densityNormalize(), min maxNormalize()
local coverage diﬀerence measures: ks test(), diﬀ area(), diﬀ derivative area(),qq plot(),

qq derivative plot(), pp plot(), pp derivative plot(), hump diﬀ1(), hump diﬀ2()

14.05.2011 - added parseGﬀ3()

2

Introduction

rnaSeqMap is a ”middleware” library for RNAseq secondary analyses.
for such operations as:

It constitutes an API

(cid:136) access to any the reads of the experiment in possibly fastest time, according to any

chromosome coordinates

(cid:136) accessing sets of reads according to genomic annotation in Ensembl

(cid:136) calculation of coverage and number of reads and transformations of those values

(cid:136) creating input for signiﬁcance analysis algorithms - from edgeR and DESeq

(cid:136) precisely ﬁnding signiﬁcant and consistent regions of expression

(cid:136) splicing analyses

(cid:136) visualizations of genes and expression regions

The library is independent from the sequencing technology and reads mappina software.
It needs either reads described as genome coordinates in the extended xmap database, or
can alternatively read data as big as they can ﬁt in the operational memory. The use with
modiﬁed xmap database is recommended, as it overcomes memory limitations - thus the
library can be eﬃciently run on not very powerful machines.

The internal features of rnaSeqMap distinctive for this piece of software are:

(cid:136) sequencing reads and annotations in one common database - extended XMAP [? ]

(cid:136) algorithm for ﬁnding irreducible regions of genomic expression - according to Aumann

and Lindell [? ]

(cid:136) nucleotide-level splicing analysis

(cid:136) connectors for further gene- and region-level expression processing to DESeq [? ] and

edgeR [? ]

(cid:136) the routines for coverage, splicing index and region mining algorithm have been imple-

mented in C for speed

2

3 Using the SeqReadsand NucleotideDistr objects

The reads are provided into the objects built according to genome coordinates from BAM
ﬁles described in the ”covdesc” ﬁle.

>
>
>

rs <- newSeqReads(ch,st, en, str);
rs <- getBamData(rs,idx.both, cvd=cvd)
nd <- getCoverageFromRS(rs, idx.both)

4 Processing schema to get the coverage measures us-

ing the ”camel wrapper”

To get the coverage diﬀerence measures described in [2] Encode the experimental design in
the sample description/covdesc ﬁle The comparison may be done between any two group of
samples (1+1, n+n, n+m) Get samples indices, eg:

> idxT <- which(samples$condition=="T")
> idxC <- which(samples$condition=="C")

Prepare the table of genome coordinates to query Encode them as GenomicRanges object,

eg:

> regions.gR <- rnaSeqMap:::.fiveCol2GRanges(tmp)

Run the wrapper for all camel comparisons

> regionsCamelMeasures <- gRanges2CamelMeasures(regions.gR,samples,idxT,idxC,sums=sums,progress=10)

Run detection ﬁltering by the density of coverage, eg:

> idx <- which(regionsCamelMeasures[,"covDensC1"]>10 | regionsCamelMeasures[,"covDensC1"]>10)
> regionsCamelMeasures <- regionsCamelMeasures[idx, ]

Order the regions by a selected measure:

> o <- order(regionsCamelMeasures[,"QQ.mm"], decreasing=T)
> regionsCamelMeasures <- regionsCamelMeasures [o, ]

5 Using Aumann-Lindell two-sliding-window algorithm

to ﬁnd expressed genomic regions

The regions will be found as new object containing mindiﬀ (second parameter value) for the
nucleotides for which there are irreducible regions of coverage with given mindiﬀ and minimal
length - minsup. For the details of the algorithm see [1, 3]

> nd.AL <- findRegionsAsND(nd, 15, minsup=5)

3

References

[1] Le´sniewska, A., Okoniewski, M. J. (2011). rnaSeqMap: a Bioconductor package for
RNA sequencing data exploration. BMC bioinformatics, 12, 200. doi:10.1186/1471-
2105-12-200

[2] Okoniewski, M. J., Le´sniewska, A., Szabelska, A., Zyprych-Walczak, J., Ryan, M.,
Wachtel, M., Morzy, T., et al. (2011). Preferred analysis methods for single genomic
regions in RNA sequencing revealed by processing the shape of coverage. Nucleic acids
research. doi:10.1093/nar/gkr1249

[3] Aumann, Y., Lindell, Y. (2003). A Statistical Theory for Quantitative Association Rules.

J. Intell. Inf. Syst., 20(3), 255–283.

4

