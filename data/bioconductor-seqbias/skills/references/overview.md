seqbias
Assessing and Adjusting for Technical Bias
in High Throughput Sequencing Data

Daniel Jones
<dcjones@cs.washington.edu>

Computer Science & Engineering

University of Washington

October 30, 2018

1 Introduction

This package is designed as a means to assess and adjust for technical bias
in high-throughput sequencing datasets, RNA-Seq being a speciﬁc target. As
noted in previous studies, RNA-Seq is often subject to protocol speciﬁc bias.
That is, the number of reads mapping to a particular position of the genome is
dependent on the the surrounding nucleotide sequence (as well as the abun-
dance of the RNA transcript) [1] [3]. Accounting for this bias increases unifor-
mity of coverage and may result in more accurate quantiﬁcation.

The approach implemented here trains a simple Bayesian network clas-
siﬁer and uses it to evaluate the per position bias. This builds off work done
by Hansen, et. al. [1], available in the Genominator Bioconductor package.
Another approach is taken by Li, et. al. [3] in the mseq package, available from
CRAN.

For this vignette, we will use some example data taken from Mortazavi, et.
al. [4] (NCBI accession number SRR001358). Because of space constraints, we
have mapped the reads (using Bowtie [2]) to an artiﬁcial genome consisting
of approximately 100kb of exonic DNA.
This “artiﬁcial genome” is given as,

> library(seqbias)
> library(Rsamtools)
> ref_fn <- system.file( "extra/example.fa", package = "seqbias" )
> ref_f <- FaFile( ref_fn )
> open.FaFile( ref_f )

And the mapped reads,

> reads_fn <- system.file( "extra/example.bam", package = "seqbias" )

1

2 Assessment

As a natural ﬁrst step, we would like to assess whether our sample is signiﬁ-
cantly biased. If this proves to be the case, we may wish to correct for this. A
simple procedure to do so will be covered in the next section.

To assess the nucleotide frequency we will use a very simple procedure:

1. Generate a random sample of intervals across our reference genome.

2. Extract sequences for these intervals from a FASTA ﬁle.

3. Extract read counts across these intervals from a BAM ﬁle.

4. Using these sequences and counts, compute and plot nucleotide or k-

mer frequencies.

Sampling

For this step, we could use collection of known exons, but trustworthy anno-
tations are not always available, and biasing the analysis by known exons may
be a concern in some instances. Fortunately, seqbias provides a function to
generate random intervals.

First, we extract a vector of sequence lengths, in the reference genome.
Given an FASTA ﬁle than has been indexed with the samtools faidx com-
mand, we can use the Rsamtools package to read off the sequence lengths
and to extract the sequence. First, the lengths,

> ref_seqs <- scanFaIndex( ref_f )

Once we have this, we generate 5 intervals of 100kb.

It most cases we
would want to generate a larger sample, but since we are working here with
small reference sequence with dense coverage, we can get an accurate mea-
surement with a few intervals.

> I <- random.intervals( ref_seqs, n = 5, m = 100000 )

Sequences

Next we extract the nucleotide sequences,

> seqs <- scanFa( ref_f, I )

The scanFa function does not respect strand, so we must be sure to per-

form the reverse complement ourselves.

> neg_idx <- as.logical( I@strand ==
> seqs[neg_idx] <- reverseComplement( seqs[neg_idx] )

-

)

’

’

2

Counts

Finally, we count the number of reads mapping to each position in our sam-
pled intervals.

> counts <- count.reads( reads_fn, I, binary = T )

Unless the binary argument is FALSE, this function returns a 0-1 vector,
where a position is 0 if no reads map to it, and 1 if at least one read maps to
it. This is a more robust way to measure sequencing bias, as the frequencies
can not get dominated by a few very high peaks.

Frequencies

At last, we compute the k-mer frequency (where k = 1, by default).

> freqs <- kmer.freq( seqs, counts )

A nice way to plot this is with the ggplot2 package, if available.

y = freq,
ylim = c(0.15,0.4),
color = seq,
data = freqs,
geom = "line" )

P <- P + facet_grid( seq ~ . )
print(P)

P <- qplot( x = pos,

> if( require(ggplot2) ) {
+
+
+
+
+
+
+
+
+ } else {
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

par( mar = c(5,1,1,1), mfrow = c(4,1) )
with( subset( freqs, seq == "a" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "a", type =

with( subset( freqs, seq == "c" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "c", type =

with( subset( freqs, seq == "g" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "g", type =

with( subset( freqs, seq == "t" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "t", type =

’

’

l

’

’

l

’

’

l

’

’

l

) )

) )

) )

) )

Doing so will produce the following plot,

3

The x-axis shows the nucleotide position relative to the read start. Nega-
tive number occur in the genome to the left of mapped reads. In this set, the
reads consist of positions 0-24.

We can see a clear bias here in positions 0-15, approximately. The rest of
the plot looks relatively ﬂat, as we would expect if the experiment was mea-
suring abundance only and not a biased by the nucleotide sequence. In the
next section we will adjust read counts to account for this.

3 Compensation

Training

To begin, we must ﬁt a seqbias model to our dataset. This done very easily
with the seqbias.fit function. This will take only a few seconds, but when
more reads are available a more accurate model can be trained at the expense
of the training procedure taking up to several minutes.

> sb <- seqbias.fit( ref_fn, reads_fn, L = 5, R = 15 )

The L and R arguments control the maximum number of positions to the
left and right of the read start that may be considered. The model tries to con-
sider only informative positions, so increasing these numbers will increase
training time, but should never have a negative effect the accuracy of the
model.

Prediction

Once we have trained the seqbias model, we can use it to predict the sequenc-
ing bias across a set of intervals.

4

acgt−50−25025500.150.200.250.300.350.400.150.200.250.300.350.400.150.200.250.300.350.400.150.200.250.300.350.40posfreqseqacgt> bias <- seqbias.predict( sb, I )

Adjustment

To adjust, we will can simply divide the counts vectors by the bias vectors.
‘

‘

> counts.adj <- mapply( FUN =

/

, counts, bias, SIMPLIFY = F )

The post-adjustment nucleotide frequencies can then be measured as be-

fore,

> freqs.adj <- kmer.freq( seqs, counts.adj )

And plotted,

y = freq,
ylim = c(0.15,0.4),
color = seq,
data = freqs.adj,
geom = "line" )

P <- P + facet_grid( seq ~ . )
print(P)

P <- qplot( x = pos,

> if( require(ggplot2) ) {
+
+
+
+
+
+
+
+
+ } else {
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

par( mar = c(5,1,1,1), mfrow = c(4,1) )
with( subset( freqs.adj, seq == "a" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "a", type =

with( subset( freqs.adj, seq == "c" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "c", type =

with( subset( freqs.adj, seq == "g" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "g", type =

with( subset( freqs.adj, seq == "t" ),

plot( freq ~ pos, ylim = c(0.15,0.4), sub = "t", type =

’

’

l

’

’

l

’

’

l

’

’

l

) )

) )

) )

) )

The plot below results,

5

Compared to the ﬁrst ﬁgure, the improvement is clear.

4 Save / Load

If the model is ﬁt using a large number of reads, it can take several minutes
to train. To avoid repeatedly reﬁtting the model, seqbias provides a mecha-
nism to save and load the model to a YAML ﬁle with the seqbias.save and
seqbias.load functions.

> seqbias.save( sb, "my_seqbias_model.yml" )
> # load the model sometime later
> sb <- seqbias.load( ref_fn, "my_seqbias_model.yml" )

Note when loading the model, we need to provide a reference sequence.

The seqbias object keeps track of the reference sequence to make seqbias.predict
more convenient.

5 Session Info

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

6

acgt−50−25025500.150.200.250.300.350.400.150.200.250.300.350.400.150.200.250.300.350.400.150.200.250.300.350.40posfreqseqacgtLAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats4
[8] methods

base

stats

graphics grDevices utils

datasets

other attached packages:

Rsamtools_1.34.0
[1] ggplot2_3.1.0
[4] Biostrings_2.50.0
XVector_0.22.0
[7] GenomeInfoDb_1.18.0 IRanges_2.16.0

seqbias_1.30.0
GenomicRanges_1.34.0
S4Vectors_0.20.0

[10] BiocGenerics_0.28.0

loaded via a namespace (and not attached):
compiler_3.5.1
bindr_0.1.1
zlibbioc_1.28.0
gtable_0.2.0
bindrcpp_0.2.2
dplyr_0.7.7
tidyselect_0.2.5
BiocParallel_1.16.0
magrittr_1.5
colorspace_1.3-2
RCurl_1.95-4.11
crayon_1.3.4

[1] Rcpp_0.12.19
[4] plyr_1.8.4
[7] tools_3.5.1
[10] tibble_1.4.2
[13] rlang_0.3.0.1
[16] withr_2.1.2
[19] grid_3.5.1
[22] R6_2.3.0
[25] reshape2_1.4.3
[28] assertthat_0.2.0
[31] stringi_1.2.4
[34] munsell_0.5.0

pillar_1.3.0
bitops_1.0-6
digest_0.6.18
pkgconfig_2.0.2
GenomeInfoDbData_1.2.0
stringr_1.3.1
glue_1.3.0
purrr_0.2.5
scales_1.0.0
labeling_0.3
lazyeval_0.2.1

References

[1] Kasper Hansen, Steven Brenner, and Sandrine Dudoit. Biases in Illumina
transcriptome sequencing caused by random hexamer priming. Nucleic
acids research, pages 1–7, April 2010.

[2] Ben Langmead, Cole Trapnell, Mihai Pop, and Steven Salzberg. Ultrafast
and memory-efﬁcient alignment of short DNA sequences to the human
genome. Genome biology, 10(3):R25, 2009.

[3] Jun Li, Hui Jiang, and Wing Hung Wong. Modeling non-uniformity in
short-read rates in RNA-Seq data. Genome Biology, 11(5):R50, 2010.

7

[4] Ali Mortazavi, Brian Williams, Kenneth Mccue, Lorian Schaeffer, and Bar-
bara Wold. Mapping and quantifying mammalian transcriptomes by
RNA-Seq. Nature Methods, 5(7):1–8, 2008.

8

