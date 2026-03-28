# REF-EVAL: A toolkit of reference-based scores for *de novo* transcriptome sequence assembly evaluation

## Overview

REF-EVAL computes a number of reference-based scores. These scores measure
the quality of a transcriptome assembly relative to a collection of reference
sequences. For information about how to run REF-EVAL, see “Usage” and the
sections following it below. For information about the score definitions, see
“Score definitions” and the sections following it below.

## Usage

As an optional first step, estimate the “true” assembly, using [REF-EVAL-ESTIMATE-TRUE-ASSEMBLY](http://deweylab.biostat.wisc.edu/detonate/ref-eval-estimate-true-assembly.html).
Alternatively, you can use the full-length reference transcript sequences
directly as a reference.

From now on, we will call the estimated “true” assembly or the collection
of full-length reference sequences (whichever you choose to use) the reference.
Let's assume that the assembly of interest is in A.fa, and the
reference is in B.fa.

If you want to compute alignment-based scores (see --scores below
for more info), align the assembly to the reference and vice versa using [Blat](http://genome.ucsc.edu/FAQ/FAQblat.html). We recommend fairly
unrestrictive settings, in order to generate many candidate alignments.

```
$ blat -minIdentity=80 B.fa A.fa A_to_B.psl
$ blat -minIdentity=80 A.fa B.fa B_to_A.psl
```

If you want to compute weighted variants of scores, use [RSEM](http://deweylab.biostat.wisc.edu/rsem/)
to compute the expression of the assembly and reference relative to the given
reads. Let's assume that the reads are in reads.fq.

```
$ rsem-prepare-reference --no-polyA A.fa A_ref
$ rsem-prepare-reference --no-polyA B.fa B_ref
$ rsem-calculate-expression -p 24 --no-bam-output reads.fq A_ref A_expr
$ rsem-calculate-expression -p 24 --no-bam-output reads.fq B_ref B_expr
```

Finally, run REF-EVAL. To compute everything, run:

```
$ ./ref-eval --scores=nucl,pair,contig,kmer,kc \
             --weighted=both \
             --A-seqs A.fa \
             --B-seqs B.fa \
             --A-expr A_expr.isoforms.results \
             --B-expr B_expr.isoforms.results \
             --A-to-B A_to_B.psl \
             --B-to-A B_to_A.psl \
             --num-reads 5000000 \
             --readlen 76 \
             --kmerlen 76 \
             | tee scores.txt
```

To only compute the kmer compression score (and its dependencies), run:

```
$ ./ref-eval --scores=kc \
             --A-seqs A.fa \
             --B-seqs B.fa \
             --B-expr B_expr.isoforms.results \
             --num-reads 5000000 \
             --readlen 76 \
             --kmerlen 76 \
             | tee scores.txt
```

To only compute the unweighted reference-based scores, run:

```
$ ./ref-eval --scores=nucl,pair,contig \
             --weighted=no \
             --A-seqs A.fa \
             --B-seqs B.fa \
             --A-to-B A_to_B.psl \
             --B-to-A B_to_A.psl \
             | tee scores.txt
```

To only compute the scores discussed in the DETONATE paper, run:

```
$ ./ref-eval --paper \
             --A-seqs A.fa \
             --B-seqs B.fa \
             --B-expr B_expr.isoforms.results \
             --A-to-B A_to_B.psl \
             --B-to-A B_to_A.psl \
             --num-reads 5000000 \
             --readlen 76 \
             --kmerlen 76 \
             | tee scores.txt
```

The scores will be written to standard output (hence, above, to scores.txt).
Progress information is written to standard error. Further details about the
arguments to REF-EVAL are described below. Further details about the scores
themselves are given under “Score definitions” below.

## Usage: Score specification

--scores arg
:   The groups of scores to compute, separated by commas (e.g.,
    --scores=nucl,contig,kc). It is more efficient to compute all
    the scores you are interested in using one invocation of REF-EVAL
    instead of using multiple invocations that each compute one score. The
    available score groups are as follows:

    Alignment-based score groups:

    * nucl: nucleotide precision, recall, and F1.
    * contig: contig precision, recall, and F1.
    * pair: pair precision, recall, and F1.

    Alignment-free score groups:

    * kmer: kmer Kullback-Leibler divergence, Jensen-Shannon
      divergence, and Hellinger distance.
    * kc: kmer recall, number of nucleotides, and kmer
      compression score.

    Required unless --paper is given.

--weighted arg
:   A string indicating whether to compute weighted or unweighted
    variants of scores, or both (e.g., --weighted=yes):

    * yes: compute weighted variants of scores.
    * no: compute unweighted variants of scores.
    * both: compute both weighted and unweighted variants of scores.

    In weighted variants, the expression levels (TPM) of the assembly
    and reference sequences are taken into account, and hence need to be
    specified using --A-expr and --B-expr. Unweighted
    variants are equivalent to weighted variants with uniform
    expression.

    The distinction between weighted and unweighted variants doesn't
    make sense for the KC score, so this option is ignored by the KC score.

    Required unless --paper or only --score=kc is
    given.

--paper
:   As an alternative to the above, if you are only interested in
    computing the scores described in the main text of our paper [1], you
    can pass the --paper flag instead of the --scores and
    --weighted options. In that case, the following scores will be
    computed:

    Alignment-based scores:

    * unweighted nucleotide F1
    * unweighted contig F1

    Alignment-free score groups:

    * weighted kmer compression score

    For obvious reasons, the --scores and --weighted
    options are incompatible with this flag.

    [1] Bo Li\*, Nathanael Fillmore\*, Yongsheng Bai, Mike Collins, James A.
    Thompson, Ron Stewart, Colin N. Dewey. Evaluation of *de novo*
    transcriptome assemblies from RNA-Seq data.

## Usage: Input and output specification

--A-seqs arg
:   The assembly sequences, in FASTA format. Required.

--B-seqs arg
:   The reference sequences, in FASTA format. Required.

--A-expr arg
:   The assembly expression, for use in weighted scores, as produced by
    RSEM in a file called \*.isoforms.results. Required for
    weighted variants of scores.

--B-expr arg
:   The reference expression, for use in weighted scores, as produced by
    RSEM in a file called \*.isoforms.results. Required for
    weighted variants of scores.

--A-to-B arg
:   The alignments of the assembly to the reference. The file format is
    specified by --alignment-type. Required for alignment-based
    scores.

--B-to-A arg
:   The alignments of the reference to the assembly. The file format is
    specified by --alignment-type. Required for alignment-based
    scores.

--alignment-type arg
:   The type of alignments used, either blast or psl.
    Default: psl. Currently BLAST support is experimental, not
    well tested, and not recommended.

## Usage: Options that modify the score definitions (and hence output)

--strand-specific
:   If this flag is present, it is assumed that all the assembly and
    reference sequences have the same orientation. Thus, alignments or kmer
    matches that are to the reverse strand are ignored.

--readlen arg
:   This option only applies to the KC scores. The read length of the
    reads used to build the assembly, used in the denominator of the ICR.
    Required for KC scores.

--num-reads arg
:   This option only applies to the KC scores. The number of reads used
    to build the assembly, used in the denominator of the ICR. Required for
    KC scores.

--kmerlen arg
:   This option only applies to the kmer and KC scores. This is the
    length (“k”) of the kmers used in the definition of the KC and kmer
    scores. Required for KC and kmer scores.

--min-frac-identity arg
:   This option only applies to contig scores. Alignments with fraction
    identity less than this threshold are ignored. The fraction identity
    of an alignment is min(x/y, x/z), where

    * $x$ is the number of bases in the assembly sequence that are
      aligned to an identical base in the reference sequence,
      according to the alignment,
    * $y$ is the number of bases in the assembly sequence, and
    * $z$ is the number of bases in the reference sequence.

    Default: 0.99.

--max-frac-indel arg
:   This option only applies to contig scores. Alignments with fraction
    indel greater than this threshold are ignored. For psl alignments, the
    fraction indel of an alignment is $\max(w/y, x/z)$, where

    * $w$ is the number of bases that are inserted in the assembly
      sequence, according to the alignment (“Q gap bases”),
    * $x$ is the number of bases that are inserted in the reference
      sequence, according to the alignment (“T gap bases”),
    * $y$ is the number of bases in the assembly sequence, and
    * $z$ is the number of bases in the reference sequence.

    For blast alignments, the fraction indel of an alignment is
    $\max(x/y, x/z)$, where

    * $x$ is the number of gaps bases that are inserted in the
      reference sequence, according to the alignment (“gaps”),
    * $y$ is the number of bases in the assembly sequence, and
    * $z$ is the number of bases in the reference sequence.

    Default: 0.01.

--min-segment-len arg
:   This option only applies to nucleotide and pair scores. Alignment
    segments that contain fewer than this number of bases will be
    discarded. Default: 100. In the DETONATE paper, this was set to the
    read length.

## Usage: Options that modify the algorithm, but not the score definitions

--hash-table-type arg
:   The type of hash table to use, either “sparse” or “dense”. This
    is only relevant for KC and kmer scores. The sparse table is slower but
    uses less memory. The dense table is faster but uses more memory.
    Default: “sparse”.

--hash-table-numeric-type arg
:   The numeric type to use to store values in the hash table, either
    “double” or “float”. This is only relevant for KC and kmer scores.
    Using single-precision floating point numbers (“float”) requires less
    memory than using double-precision (“double”), but may also result in
    more numerical error. Note that we use double-precision numbers
    throughout our calculations even if single-precision numbers are stored
    in the table, so the additional error should be minimal. Default:
    “double”.

--hash-table-fudge-factor arg
:   This is only relevant for KC and kmer scores. When the hash table is
    created, its initial capacity is set as the total worst-case number of
    possible kmers in the assembly and reference, based on each sequence's
    length, divided by the fudge factor. The default, 2.0, is often
    reasonable because (1) most kmers should be shared by the assembly and
    the reference, and (2) many kmers will be repeated several times.
    However, if you have a lot of memory or a really bad assembly, you
    could try a smaller number. Default: 2.0.

## Usage: Options to include additional output

--trace arg
:   If given, the prefix for additional output that provides details
    about the REF-EVAL scores; if not given, no such output is produced.
    Currently, the only such output is as follows.

    * (--trace).{weighted,unweighted}\_contig\_{precision,recall}\_matching
      is a TSV file that describes the matching used to compute the
      weighted or unweighted contig precision or recall. (Details about
      the matching are given in the section on score definitions below.)
      For recall, each row corresponds to a reference sequence $b$.
      Column 1 contains $b$'s name. If $b$ is matched to a contig $a$,
      then the remaining columns are as follows:
      + Column 2 contains $a$'s name.
      + Column 3 contains the weight of the edge between $b$ and
        $a$. (This is set to the uniform weights $1/|B|$ in the
        unweighted case, although the maximum cardinality matching
        algorithm does not actually use these weights.)
      + Column 4 contains the names of all the contigs $a'$ that
        are adjacent to $b$ in the bipartite graph that the
        matching is based on, separated by commas. Thus, this
        column lists all the contigs $a'$ that have a "good enough"
        match with the reference sequence $b$, according to the
        criteria used to build the bipartite graph. (See the
        section below on score definitions for details.)Otherwise, if $b$ is not matched to any contig, columns 2 and 3
      contain "NA". For precision, the file has the same format, but with
      the reference and the assembly interchanged. In other words, each
      row corresponds to a contig $a$ and contains information about its
      matching to a reference sequence $b$, or all "NA" values if $a$ was
      not matched.

## Usage: General options

-? [ --help ]
:   Display this information.

## Score definitions

In the next few sections, we define the scores computed by REF-EVAL.
Throughout, $A$ denotes the assembly, and $B$ denotes the reference. (As
discussed under “Usage” above, the reference can be either an estimate of the
“true” assembly or a collection of full-length reference transcripts.) Both
$A$ and $B$ are thought of as sets of sequences. $A$ is a set of contigs, and
$B$ is a set of reference sequences.

## Score definitions: contig precision, recall, and F1

The contig recall is defined as follows:

* Align the assembly $A$ to the reference $B$. Notation: each alignment $l$
  is between a contig $a$ in $A$ and an reference sequence $b$ in $B$.
* Throw out alignments that are to the reverse strand, if
  --strand-specific is present.
* Throw out alignments whose fraction identity is less than
  --min-frac-identity (q.v.\ for the definition of “fraction
  identity”).
* Throw out alignments whose fraction indel is greater than
  --max-frac-indel (q.v.\ for the definition of “fraction indel”).
* Construct a bipartite graph from the remaining alignments, in which there
  is an edge between $a$ and $b$ iff there is a remaining alignment $l$ of
  $a$ to $b$.
* If --weighted=yes, specify a weight for each edge between $a$ and
  $b$, namely $\tau(b)$, the relative abundance of $b$ within the
  reference, as specified in --B-expr.
* The unweighted contig recall is the number of edges in the maximum
  cardinality matching of this graph, divided by the number of sequences in
  the reference $B$.
* The weighted contig recall is the weight of the maximum weight matching
  of this graph.

The contig precision is defined as follows: Interchange the assembly and the
reference, and compute the contig recall.

The contig F1 is the harmonic mean of the precision and recall.

## Score definitions: nucleotide precision, recall, and F1

The nucleotide recall is defined as follows:

* Align the assembly $A$ to the reference $B$. Notation: each alignme