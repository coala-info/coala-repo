HMMER User’s Guide

Biological sequence analysis using proﬁle hidden Markov models

Sean R. Eddy
and the HMMER development team

http://hmmer.org
Version 3.4; Aug 2023

Copyright (C) 2023 Howard Hughes Medical Institute.

HMMER and its documentation are freely distributed under the 3-Clause BSD open source license. For a
copy of the license, see opensource.org/licenses/BSD-3-Clause.

HMMER development is supported in part by the National Human Genome Research Institute of the US
National Institutes of Health under grant number R01HG009116. The content is solely the responsibility of
the authors and does not necessarily represent the ofﬁcial views of the National Institutes of Health.

Contents

Introduction

.

7
7
. . . . . . . . . . . . . . . . . . . . . . . . . .
How to avoid reading this manual
8
Background and brief history .
. . . . . . . . . . . . . . . . . . . . . . . . . .
.
9
Problems HMMER is designed for . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . 10
HMMER uses ensemble algorithms, not optimal alignment .
Assumptions and limitations of proﬁle HMMs . . . . . . . . . . . . . . . . . . . 12
. . . . . . . . . . . . . . . . . . . . . . . . . 12
.
How to learn more .
.
. . . . . . . . . . . . . . . . . . . . . . . . . 12
.
How to cite HMMER .
. . . . . . . . . . . . . . . . . . . . . . . . . 13
How to report a bug .
.
When’s HMMER4 coming? .
. . . . . . . . . . . . . . . . . . 13
. . . .
. . . . . . . . . . . . . . . . . . . . . . . . . 15
What’s still missing .
.
. . . . . . . . . . . 15
How to avoid using this software (links to similar software)

. . .

. . .

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

.
.
.

.
.
.

.
.
.

.

.

.

.

Installation

.

.

.

.

.

.
.

.
.

.
.

17
. . . . . . . . . . . . . . . . . . 17
Quickest: install a precompiled binary package
Quick-ish: compile the source code . . . . . . . . . . . . . . . . . . . . . . . . . . 17
Geeky: compile source from our github repository . . . . . . . . . . . . . . . . . 18
. . . . . . . . . . . . . . . . . . . . . . . . . . 19
Gory details .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
System requirements .
. . . . . . . . . . . . . 21
Multicore parallelization is (almost always) default
. . . . . . . . . . . . . . . . . . . . . 21
MPI cluster parallelization is optional
. . . . . . . . . . . . . . . . . . . . . . . . . . 22
Using build directories .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
Makeﬁle targets .
. . . . . . . . . . . . . . . . . . . . . . . . . 22
.
Compiling the user guide .
. . . . . . . 23
What gets installed by make install, and where? . . . .
. . . . . 24
Installing both HMMER2 and HMMER3 . . . .
. . . . . . . . . . 25
Seeing more output from make .
. . . . . .
Staged installations in a buildroot, for a packaging system . . . . . . . . . 25
Workarounds for unusual conﬁgure/compilation problems . . . . . . . . 25

. . . . . . .
. . .

. . . . .

. . . . .

. . .

.
.
.

.
.

.

.

.

.

Tutorial

.
Tap, tap; is this thing on?
.
The programs in HMMER .
.
Running a HMMER program .

.
.

.
.
.

.
.
.

27
. . . . . . . . . . . . . . . . . . . . . . . . . . 27
. . . . . . . . . . . . . . . . . . . . . . . . . . 27
. . . . . . . . . . . . . . . . . . . . . . . . . . 28

4

sean r. eddy

.

.

.

.

.

. . .

. . . . .

. . . . .

. . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
Files used in the tutorial
. . . . . . . . . . . . . . . . . . . . . . . . . . 30
On sequence ﬁle formats, brieﬂy .
Searching a sequence database with a proﬁle . . . . . . . . . . . . . . . . . . . . 30
Step 1: build a proﬁle with hmmbuild . . . . .
. . . . . 31
Step 2: search the sequence database with hmmsearch . . . . . . . . . . . 32
Single sequence protein queries using phmmer . . . . . . . . . . . . . . . . . . . 41
Iterative protein searches using jackhmmer . . . . . . . . . . . . . . . . . . . . . 42
Searching a proﬁle database with a query sequence . . . . . . . . . . . . . . . . 44
Step 1: create a proﬁle database ﬁle . . . . . . . . . . . . . . . . . . . . . . 44
Step 2: compress and index the ﬂatﬁle with hmmpress . . . . . . . . . . . 46
Step 3: search the proﬁle database with hmmscan . . . . . . . . . . . . . . 46
. . . . . . . . . . . . . 47
Summary statistics for a proﬁle database: hmmstat
Creating multiple alignments with hmmalign . . . . . . . . . . . . . . . . . . . 49
. . . . . . . . . . . . . . . . . . . . . . . . . . 51
Searching DNA sequences .
Step 1: build a proﬁle with hmmbuild . . . . . . . . . . . . . . . . . . . . . 52
Step 2: search the DNA sequence database with nhmmer . . . . . . . . . . 52

.

.

.

.

.
.

.
.

.
.

.
.

The HMMER proﬁle/sequence comparison pipeline
.
.
.
.

57
. . . . . . . . . . . . . . . . . . . . . . . . . . 58
.
.
Null model .
. . . . . . . . . . . . . . . . . . . . . . . . . . 59
MSV ﬁlter
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . 60
Biased composition ﬁlter .
. . . . . . . . . . . . . . . . . . . . . . . . . . 61
.
Viterbi ﬁlter
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . 62
.
.
Forward ﬁlter/parser .
. . . . . . . . . . . . . . . . . . . . . . . . . 62
Domain deﬁnition .
.
.
.
Modiﬁcations to the pipeline as used for DNA search . . . . . . . . . . . . . . . 65
. . . . . . . . . . . . . . . . . . . . . . . . . . 65
SSV, not MSV.
There are no domains, but there are envelopes . . . . . . . . . . . . . . . . 66
. . . . . . . . . . . . . . . . . . . . . . . . 66
Biased composition. .

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

67
Tabular output formats
. . . . . . . . . . . . . . . . . . . . . . . . . 67
The target hits table .
The domain hits table (protein search only) . . . . . . . . . . . . . . . . . . . . . 70

.

.

.

.

.

.

.

.

.

Manual pages for HMMER programs

73
. . 73
alimask - calculate and add column mask to a multiple sequence alignment
. . . . . . . . . . . . . . . . . . . . . . . . 77
hmmalign - align sequences to a proﬁle
hmmbuild - construct proﬁles from multiple sequence alignments . . . . . . . . . 79
hmmc2 - example client for the HMMER daemon . . . . . . . . . . . . . . . . . . 85
. . . . . . . . . . . . . . . . . 86
hmmconvert - convert proﬁle ﬁle to various formats
hmmemit - sample sequences from a proﬁle . . . . . . . . . . . . . . . . . . . . . . 87
hmmfetch - retrieve proﬁles from a ﬁle . . . . . . . . . . . . . . . . . . . . . . . . . 90
hmmlogo - produce a conservation logo graphic from a proﬁle . . . . . . . . . . . 92
hmmpgmd - daemon for database search web services . . . . . . . . . . . . . . . . . 93
. . . . . . . . 95
hmmpgmd_shard - sharded daemon for database search web services
hmmpress - prepare a proﬁle database for hmmscan . . . . . . . . . . . . . . . . . 97

hmmer user’s guide

5

hmmscan - search sequence(s) against a proﬁle database . . . . . . . . . . . . . . . 98
. . . . . . . . . . . . . 103
hmmsearch - search proﬁle(s) against a sequence database
hmmsim - collect proﬁle score distributions on random sequences . . . . . . . . . 108
. . . . . . . . . . . . . . . . . . . . 114
hmmstat - summary statistics for a proﬁle ﬁle
jackhmmer - iteratively search sequence(s) against a sequence database . . . . . . 116
. . . . . . . . . . . . 125
makehmmerdb - build nhmmer database from a sequence ﬁle
nhmmer - search DNA queries against a DNA sequence database . . . . . . . . . 126
nhmmscan - search DNA sequence(s) against a DNA proﬁle database . . . . . . . 133
phmmer - search protein sequence(s) against a protein sequence database . . . . . 138

Manual pages for Easel miniapps

145
. . . . . . . . . . . 145
esl-afetch - retrieve alignments from a multi-MSA database
. . . . . . . . . . . . . 147
esl-alimanip - manipulate a multiple sequence alignment
. . . . . . . . . . . . . . . . . . . 151
esl-alimap - map two alignments to each other
. . . . . . . 153
esl-alimask - remove columns from a multiple sequence alignment
esl-alimerge - merge alignments based on their reference (RF) annotation . . . . 159
esl-alipid - calculate pairwise percent identities for all sequence . . . . . . . . . 161
esl-alirev - reverse complement a multiple alignment . . . . . . . . . . . . . . . 163
. . . . . . . . . . . 165
esl-alistat - summarize a multiple sequence alignment ﬁle
. . . . . . . . . . . . 168
esl-compalign - compare two multiple sequence alignments
esl-compstruct - calculate accuracy of RNA secondary structure predictions . . . 170
esl-construct - describe or create a consensus secondary structure . . . . . . . . 172
. . . . . . . . . . 174
esl-histplot - collate data histogram, output xmgrace dataﬁle
esl-mask - mask sequence residues with X’s (or other characters) . . . . . . . . . 175
esl-mixdchlet - ﬁtting mixture Dirichlets to count data . . . . . . . . . . . . . . . 177
. . . . . . . . . . . . . . . . . . . . . 179
esl-reformat - convert sequence ﬁle formats
. . . . . . . . . . . . . . . . 182
esl-selectn - select random subset of lines from ﬁle
. . . . . 183
esl-seqrange - determine a range of sequences for one of many parallel
. . . . . . . . . . . . . . . . 184
esl-seqstat - summarize contents of a sequence ﬁle
esl-sfetch - retrieve (sub-)sequences from a sequence ﬁle . . . . . . . . . . . . . 185
esl-shuffle - shufﬂing sequences or generating random ones . . . . . . . . . . . 188
esl-ssdraw - create postscript secondary structure diagrams . . . . . . . . . . . . 191
. . . . . . 202
esl-translate - translate DNA sequence in six frames into individual
. . . . . . . . . . . . . . . . . 205
esl-weight - calculate sequence weights in MSA(s)

Input ﬁles and formats

.

Reading from ﬁles, compressed ﬁles, and pipes

.
.gz compressed ﬁles
HMMER proﬁle HMM ﬁles .
.
.

207
. . . . . . . . . . . . . . . . . . 207
. . . . . . . . . . . . . . . . . . . . . . . . . . 209
. . . . . . . . . . . . . . . . . . . . . . . . . . 210
. . . . . . . . . . . . . . . . . . . . . . . . . . 211
. . . . . . . . . . . . . . . . . . . . . . . . 214
.
Stockholm, the recommended multiple sequence alignment format . . . . . . . 216
syntax of Stockholm markup . . . . . . . . . . . . . . . . . . . . . . . . . . 217
semantics of Stockholm markup . . . . . . . . . . . . . . . . . . . . . . . . 217

.
header section .
main model section .

.
.
.
.

.
.
.
.

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

sean r. eddy

.
.

. . . . . . . . . . . . . . . . . . . . . . . . 218
recognized #=GF annotations .
. . . . . . . . . . . . . . . . . . . . . . . . 218
recognized #=GS annotations .
recognized #=GC annotations . . . . . . . . . . . . . . . . . . . . . . . . . . 219
recognized #=GR annotations . . . . . . . . . . . . . . . . . . . . . . . . . . 219
. . . . . . . . . . . . . . . . . . . . . . . . 221
A2M multiple alignment format
.
.
. . . . . . . . . . . . . . . . . . . 221
An example A2M ﬁle .
. .
. . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . 222
Legal characters .
.
.
Determining consensus columns . . . . . . . . . . . . . . . . . . . . . . . . 222
. . . . . . . . . . . . . . . . . . . . . . . . 223
. . . . . . . . . . . . . . . . . . . . . . . . . . 223
. . . . . . . . . . . . . . . . . . . . . . . . . . 223
. . . . . . . . . . . . . . . . . . . . . . 224
. . . . . . . . . . . . . . . . . . . . . . . . 225

Fields in header line .
.
FASTA-like sequence format .
Creating a ﬁle in hmmpgmd format
.

hmmpgmd sequence database format

Score matrix ﬁles .

.
.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Acknowledgements and history

227

Introduction

Most protein sequences are composed from a relatively small number
of ancestral protein domain families. Our sampling of common pro-
tein domain families has become comprehensive and deep, while raw
sequence data continues to accumulate explosively. It has become ad-
vantageous to compare sequences against all known domain families,
instead of all known sequences.

This makes protein sequence analysis more like speech recogni-
tion. When you talk to your smartphone, it doesn’t compare your
digitized speech to everything that’s ever been said. It compares
what you say to a prebuilt dataset of statistical models of common
words and phonemes. Using machine learning techniques, each sta-
tistical model is trained on large datasets of examples spoken by
different speakers in different accents. Similarly, for each protein do-
main family, there are typically thousands of known homologs that
can be aligned into deep multiple sequence alignments. Sequence
alignments reveal a speciﬁc pattern of evolutionary conservation par-
ticular to that domain’s structure and function. These patterns can be
captured by probabilistic models.

HMMER is a software package that provides tools for making
probabilistic models of protein and DNA sequence domain families –
called proﬁle hidden Markov models, proﬁle HMMs, or just proﬁles
– and for using these proﬁles to annotate new sequences, to search
sequence databases for additional homologs, and to make deep mul-
tiple sequence alignments. HMMER underlies several comprehensive
collections of alignments and proﬁles of known protein and DNA
sequence domain families, including the Pfam database.

1

How to avoid reading this manual

I hate reading documentation. If you’re like me, you’re thinking, 229
pages of documentation, you’ve got to be joking! First I want to know
that the software compiles, runs, and gives useful results, before I’m
going to plow through some 229 tedious pages of someone’s docu-
mentation. For fellow cynics who have seen one too many software

1 pfam.org

8

sean r. eddy

packages that don’t work:

• Follow the quick installation instructions on page 17. An auto-
mated test suite is included, so you will know immediately if
something went wrong.

2

• Go to the tutorial section on page 27, which walks you through

examples of using HMMER.

Everything else, you can come back and read later.

Background and brief history

A multiple sequence alignment of a homologous family of protein
domains reveals patterns of site-speciﬁc evolutionary conservation.
Key residues may be highly conserved at certain positions; some
positions may tolerate certain substitutions while conserving physio-
chemical properties like hydrophobicity, charge, or size; some posi-
tions may be evolutionarily near-neutral and variable; insertions and
deletions are tolerated at some positions better than others. A proﬁle
is a position-speciﬁc scoring model that describes which symbols are
likely to be observed and how frequently insertions/deletions occur
at each position (column) of a multiple sequence alignment.

Pairwise sequence alignment methods such as BLAST and FASTA
use position-independent substitution score matrices such as BLOSUM
and PAM, but the desirability of position-speciﬁc models was recog-
Several groups
nized even before BLAST and FASTA were written.
introduced different position-speciﬁc alignment scoring approaches
in the 1980’s. The name “proﬁles”, introduced by Gribskov and col-
4
leagues,

was a name that stuck.

3

Proﬁles have a lot of parameters. The BLOSUM and PAM amino
acid substitution matrices have only 210 free parameters (20 × 20,
symmetric), and those parameters are averages over large collections
of many different known sequence alignments. A proﬁle typically
has at least 22 parameters for each of the ∼200 consensus positions
or so in a typical protein domain, and these thousands of parameters
are estimated for one particular sequence family alignment, not aver-
aged across all of them. Early proﬁle methods were vexed by a lack
of theoretical underpinnings for how to parameterize these models
effectively, especially for insertion and deletions.

In the 1990’s, Anders Krogh, David Haussler, and co-workers at
UC Santa Cruz recognized a parallel between proﬁles and widely
used speech recognition techniques, and they introduced proﬁle
hidden Markov models (proﬁle HMMs).
biology before, but the Krogh paper had dramatic impact because

HMMs had been used in

5

2 Nothing should go wrong.

3 R. F. Doolittle. Similar amino acid se-
quences: Chance or common ancestry?
Science, 214:149–159, 1981

4 M. Gribskov, et al. Proﬁle analysis:
Detection of distantly related proteins.
Proc. Natl. Acad. Sci. USA, 84:4355–4358,
1987

There’s ∼22 parameters per position
because there’s 20 residue scores, plus
gap-open and gap-extend penalties for
starting or extending an insertion or
deletion.

5 A. Krogh, et al. Hidden Markov
models in computational biology:
Applications to protein modeling. J.
Mol. Biol., 235:1501–1531, 1994

hmmer user’s guide

9

6 E. L. L. Sonnhammer, et al. Pfam:
A comprehensive database of protein
families based on seed alignments.
Proteins, 28:405–420, 1997

For DNA searches, BLASTN remains
about two orders of magnitude faster
than HMMER DNA searches, but is less
sensitive.

HMM technology was so well suited to addressing the vexing pa-
rameterization problem. HMMs have a formal probabilistic basis,
allowing the use of probability theory to set and to interpret the large
number of free parameters in a proﬁle, including the position-speciﬁc
gap and insertion parameters. The methods are mathematically con-
sistent and therefore automatable, which was crucial in allowing
people to make libraries of hundreds of proﬁle HMMs and apply
them on a large scale to whole genome analysis. One such database
of protein domain models is Pfam.
Historically, Pfam and HMMER
have been developed in parallel.

6

The ﬁrst implementations of proﬁle HMMs were computation-
ally intensive, including HMMER1 (1995) and HMMER2 (1998), but
HMMER3 is now typically faster than BLASTP or FASTA searches
even though it uses more complex models.

Problems HMMER is designed for

Sensitive homology searches. You’re working on a speciﬁc sequence
family, and you’ve carefully constructed a representative multiple
sequence alignment. The HMMER hmmbuild program lets you build
a proﬁle from your alignment, and the hmmsearch program lets you
search your proﬁle against a sequence database looking systemati-
cally for more homologs.

... even for single sequence queries. HMMER3 also works for single
sequence comparisons, not just for multiple alignments. Pairwise
sequence comparison is just a special case of proﬁle HMMs. HMMER
can use a BLOSUM substitution matrix to parameterize a proﬁle
built from just one sequence. HMMER3 includes two programs for
searching protein databases with single query sequences: phmmer and
jackhmmer. I believe phmmer is superior in many respects to BLASTP, and
jackhmmer to PSI-BLAST.

Automated annotation of protein domains. Various large databases
of curated alignments and HMMER models of known domains are
available, including Pfam and others. Many top ten lists of protein
domains, a de rigueur table in genome analysis papers, depend on
HMMER-based annotation. HMMER3’s hmmscan program lets you scan
a sequence against a proﬁle database to parse the sequence into its
component domains.

Curated collections of deep multiple alignments. There are thousands of
sequence families, some of which comprise hundreds of thousands
of sequences, and the raw sequence databases continue to double

10

sean r. eddy

every year or so. Clustering the entire sequence database into family
alignments is a hopeless task for manual curation, but some sort
of manual curation remains necessary for high-quality, biologically
relevant multiple alignments. Databases like Pfam are constructed
by distinguishing between a stable curated “seed” alignment of a
small number of representative sequences, and “full” alignments
of all detectable homologs. HMMER is used to make a model of
the seed and to search the database for homologs, and the hmmalign
program can automatically produce the full alignment by aligning
every sequence to the seed consensus. hmmalign scales to alignments of
millions of sequences.

HMMER uses ensemble algorithms, not optimal alignment

Most sequence search tools look for optimal high-scoring alignments.
However, sequence alignments are uncertain, and the more distantly
related sequences are, the more uncertain their alignment is. Instead
of using optimal alignment algorithms, HMMER uses ensemble
algorithms that consider all possible alignments, weighted by their
relative likelihood. This is one reason that HMMER gets more power
than tools that depend on single optimal alignment.

The use of ensemble algorithms shows up in several HMMER

features:

Explicit representation of alignment uncertainty. When HMMER shows
an alignment, it also calculates how much probability mass that this
alignment has in the ensemble – which means HMMER can anno-
tate a probabilistic conﬁdence in an alignment, or in each individual
aligned residue. Some downstream analyses that depend on align-
ments (such as phylogenetic tree inference) beneﬁt from being able to
distinguish conﬁdently aligned residues.

Sequence scores, not alignment scores. HMMER’s log-odds scores for a
sequence aren’t optimal alignment scores; they are summed over the
posterior alignment ensemble. Statistical inference theory says that
scores based on a single optimal alignment are an approximation that
breaks down when alignments are uncertain. HMMER’s calculation
is the full, unapproximated calculation.

In HMM jargon, HMMER uses the
Forward algorithm (and variants of it),
not the Viterbi algorithm.

Different speed heuristics. The ensemble (Forward) algorithm is
more computationally intensive than optimal alignment algorithms.
HMMER3’s acceleration strategy is quite different from BLAST’s.
.
HMMER implements heuristic accelerations of the HMM Forward

7

7 S. R. Eddy. Accelerated proﬁle HMM
searches. PLOS Comp. Biol., 7:e1002195,
2011

hmmer user’s guide

11

8 S. Karlin and S. F. Altschul. Methods
for assessing the statistical signiﬁcance
of molecular sequence features by using
general scoring schemes. Proc. Natl.
Acad. Sci. USA, 87:2264–2268, 1990

9 S. R. Eddy. A probabilistic model of
local sequence alignment that simpliﬁes
statistical signiﬁcance estimation. PLOS
Comput. Biol., 4:e1000069, 2008

algorithm using vectorization technology available on modern pro-
cessors.

Individually, none of these points is new. As far as alignment
ensembles go, one reason why hidden Markov models were so the-
oretically attractive in the ﬁrst place for sequence analysis is that
they are good probabilistic models for explicitly dealing with align-
ment uncertainty. The SAM proﬁle HMM software from UC Santa
Cruz has always used full probabilistic inference (the HMM For-
ward/Backward algorithms) as opposed to optimal alignment scores
(the HMM Viterbi algorithm). HMMER2 had the full HMM inference
algorithms available as command-line options, but it used Viterbi
optimal alignment by default, in part for speed reasons.

One reason why it’s been hard to deploy sequence scores for
practical large-scale use is that it wasn’t known how to accurately
calculate the statistical signiﬁcance of a log-odds score that’s been
summed over alignment uncertainty. Accurate statistical signiﬁcance
estimates are essential when one is trying to discriminate homologs
from millions of unrelated sequences in a large sequence database
search. The statistical signiﬁcance of optimal local alignment scores
is calculated by Karlin/Altschul statistics.
tics are one of the most important and fundamental advances in-
troduced by BLAST. However, Karlin/Altschul theory doesn’t apply
to HMMER’s ensemble log-odds sequence scores (HMM “Forward
scores”). The statistical signiﬁcance (E-values, or expectation values)
of HMMER sequence scores is determined by using a theoretical con-
jecture about the statistical properties of ensemble log-odds scores
9
which have been supported by numerical simulation experiments.

Karlin/Altschul statis-

8

And as far as speed goes, the pioneers of heuristic acceleration of
sequence database searches are the folks behind BLAST and FASTA,
who developed effective heuristics that closely approximate an un-
accelerated Smith/Waterman dynamic programming search. The
ﬁrst implementations of proﬁle HMM methods used dynamic pro-
gramming without heuristics (the proﬁle HMM Viterbi algorithm is
essentially Smith/Waterman, just with position-speciﬁc probability
scores), so they were more comparable in speed to Smith/Waterman
than to BLAST. Using the Forward algorithm slowed them down still
more. It was a while before I invested the time to develop heuristic
acceleration of proﬁle HMM methods. A principal design goal in
HMMER3 was to achieve at least rough speed parity with BLAST
and FASTA.

12

sean r. eddy

Assumptions and limitations of proﬁle HMMs

Proﬁle HMMs are primary sequence consensus models. They assume
that the residue at a particular position is independent of the residues
at all other positions, and they neglect any higher-order correlations.
Proﬁle HMMs are often not good models of structural RNAs, for
instance, because an HMM is not an adequate model of correlated
base pairs.

A proﬁle HMM also lacks any explicit model of the phylogenetic
relationships among a set of homologous sequences. Sequences are
instead assumed to be independently generated from the proﬁle,
which is tantamount to assuming a star phylogeny with ﬁxed branch
lengths. Ad hoc sequence weighting techniques are used to com-
pensate for the fact that typical multiple alignments include many
redundant, closely related sequences.

How to learn more

Our book Biological Sequence Analysis
behind proﬁle HMMs and HMMER.

10

describes the basic theory

HMMER’s open source development code is available on GitHub.
The GitHub issue tracker is the best way to give me suggestions, fea-
ture requests, bug reports, and pull requests.
12

is a blog where I sometimes talk about issues
as they arise in HMMER, and where you can comment or follow the
discussion.

Cryptogenomicon

11

How to cite HMMER

There has never been a paper on the HMMER software.
citation is to the web site, hmmer.org.

13

The best

You should also cite what version of the software you used. I
archive all old versions, so anyone should be able to obtain the ver-
sion you used, when exact reproducibility of an analysis is an issue.
The version number is in the header of most output ﬁles. To see
it quickly, do something like hmmscan -h to get a help page, and the
header will say:

# hmmscan :: search sequence(s) against a profile database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

So (from the second line there) this is from HMMER 3.4.
If an unenlightened, url-unfriendly journal forces you to cite dead

trees, you can cite the 2011 paper on HMMER3 acceleration.

14

Our Infernal software provides better
tools for structural RNA sequence
analysis, using proﬁle stochastic
context-free grammars, a more complex
class of probability model than HMMs.

10 R. Durbin, et al. Biological Sequence
Analysis: Probabilistic Models of Proteins
and Nucleic Acids. Cambridge University
Press, Cambridge UK, 1998
11 github.com/EddyRivasLab/hmmer

12 cryptogenomicon.org

13 And the way things are going, there
may never be!

14 S. R. Eddy. Accelerated proﬁle HMM
searches. PLOS Comp. Biol., 7:e1002195,
2011

How to report a bug

Open an issue on our issue tracker at GitHub,

15

or email me.

15 github.com/EddyRivasLab/hmmer/issues

hmmer user’s guide

13

Please give me enough information that I can reproduce the bug,
including any ﬁles. Ideally, I’d like to have a small, reproducible test
case. So if you’re reporting a bug, please send me:

• A brief description of what went wrong.

• The command line(s) that reproduce the problem.

• Copies of any ﬁles I need to run those command lines.

• Information about what kind of hardware you’re on, what operat-
ing system, and (if you compiled the software yourself rather than
running precompiled binaries), what compiler and version you
used, with what conﬁguration arguments.

Depending on how glaring the bug is, I may not need all this
information, but any work you can put into giving me a clean repro-
ducible test case doesn’t hurt and often helps.

The information about hardware, operating system, and compiler
is often important. Bugs are frequently speciﬁc to particular conﬁg-
urations of hardware/OS/compiler. I have a wide variety of systems
available for trying to reproduce bugs, and I’ll try to match your
system as closely as we can.

If you ﬁrst see a problem on some huge compute (like running a
zillion query sequences over a huge proﬁle database), it will really,
really help me if you spend a bit of time yourself trying to isolate
whether the problem really only manifests itself on that huge com-
pute, or if you can isolate a smaller test case for me. The ideal bug
report (for me) gives me everything I need to reproduce your prob-
lem in one email with at most some small attachments.

If I’m in my usual good mood, I’ll reply quickly. I’ll probably tell
you we ﬁxed the bug in our development code, and that the ﬁx will
appear in the next HMMER release. This of course doesn’t help you
much, since nobody knows when the next HMMER release is going
to be. So if possible, I’ll usually try to describe a workaround for the
bug.

If the code ﬁx is small, I might also tell you how to patch and
recompile the code yourself. You may or may not want to do this.

Remember, I’m not a company with
dedicated support staff – I’m one
person, I’ve got other stuff to do,
the Xfam team is asking me when
HMMER4’s going to be ready, and I’m
as busy as you. I’ll need to drop what
I’m doing to try to help you out. Work
with me to save me some time, and I’m
more likely to stay in my usual good
mood.

When’s HMMER4 coming?

HMMER4 has been in development since 2011.
will include:

16

Some of the stuff it

16 OK, slow development, but hey.

14

sean r. eddy

The return of glocal alignment. Slow old HMMER2 was capable of
“glocal” alignment, in which it would align a complete proﬁle to
a subsequence of a target sequence; this was great for annotating
domain structure of protein sequences, among other things. In de-
veloping our speed heuristic for HMMER3, for numerical reasons,
I had to sacriﬁce glocal alignment; HMMER3 only does local align-
ment. In HMMER4, I’ve solved the problems that prevented H3 from
using glocal alignment. H4 uses a new dual-mode proﬁle architecture,
combining local and glocal alignment modes in a single probability
model.

Memory efﬁciency. The HMMER ensemble alignment algorithms (the
HMM Forward and Backward algorithms) are expensive in memory.
For most uses, you don’t notice, but there are extreme cases where
you may. H3 can require as much as ∼ 36L2 bytes of memory for
a query sequence of length L, and for a 35Kaa titin sequence, that’s
44GB of RAM. In HMMER4, I’ve solved this with a variety of old and
new techniques.

Ensemble calculations everywhere. HMMER uses ensemble calcula-
tions (i.e., integrates over alignment uncertainty) for scoring homol-
ogous sequences and for calculating the conﬁdence in individual
aligned residues. However, when it decides how many domains are
in a sequence, and where they are, it uses an ad hoc procedure that
uses ensemble information, but is not well deﬁned. In HMMER4,
we’ve solved that problem with a new domain deﬁnition algorithm.

More processor support. One of the attractive features of the HMMER
“MSV” acceleration algorithm is that it is a very tight and efﬁcient
piece of code. The bad news is, it’s a very tight and efﬁcient piece
of assembly code. We have to write processor-speciﬁc SIMD vec-
tor instructions for each platform that HMMER runs on. HMMER
currently only supports x86 (Intel/AMD) and PowerPC platforms
(big-endian AIX PowerPC’s, not the newer crop of little-endian Linux
PowerPC’s). HMMER4 will also include support for Linux/PowerPC
and ARM NEON. It also can use the latest x86 vector instructions
(AVX and AVX-512).

Better parallelization. HMMER is so fast that it’s often input-bound,
rather than CPU-bound: that is, it takes longer just to get the se-
quences from your disk than it takes to compare them to a pro-
ﬁle. That’s been taxing the simple parallelization methods we use.
HMMER’s multithreaded parallelization really doesn’t scale well be-
yond 2-4 processors, on most machines; and possibly worse, if you’re

hmmer user’s guide

15

17 toolkit.tuebingen.mpg.de/#/tools/hhblits

on a slow ﬁlesystem (for example, if you’re reading data from a net-
work ﬁlesystem instead of from local disk). In H4, we’re working on
improving our parallelization and our data input.

What’s still missing

Two of the more important holes for me are:

I’d love to have the HMM equivalents of

Translated comparisons.
BLASTX, TBLASTN, and TBLASTX. They’ll come. In the meantime, I
translate DNA sequence to six frames, and search hypothetical ORFs
as protein sequences.

Proﬁle/proﬁle comparison. A number of pioneering papers and soft-
ware packages have demonstrated the power of proﬁle/proﬁle com-
parison for even more sensitive remote homology detection. Check
out HHBLITS from Johannes Söding’s group.

17

How to avoid using this software (links to similar software)

Other implementations of proﬁle HMM methods and position-
speciﬁc scoring matrix methods are available, including:

URL

Software
HH-SUITE www.soeding.genzentrum.lmu.de/software-and-servers-2
PSI-BLAST blast.ncbi.nlm.nih.gov
PFTOOLS
SAM

web.expasy.org/pftools
compbio.soe.ucsc.edu/sam.html

1 hmmer.org
2 github.com/EddyRivasLab/hmmer

3 Thanks to all the people who do the
packaging!

Installation

Choose one of the following three sections depending on whether
you want to install a precompiled HMMER package for your system,
or compile source code
compile from our source code distribution,
from our github repository.
We recommend that you use one of the
ﬁrst two options. You can skip the gory details section unless you’re
already proﬁcient and you want to use optional conﬁguration or
installation parameters.

2

1

Quickest: install a precompiled binary package

The easiest way to install HMMER is to install a precompiled pack-
age for your operating system.

Some examples that I know of:

3

% brew install hmmer

# OS/X, HomeBrew

% port install hmmer

# OS/X, MacPorts

% apt install hmmer

# Linux (Ubuntu, Debian...)

% dnf install hmmer

# Linux (Fedora)

% yum install hmmer

# Linux (older Fedora)

% conda install -c biocore hmmer

# Anaconda

Quick-ish: compile the source code

You can obtain the source code as a compressed .tar.gz tarball from
hmmer.org in your browser, or you can also wget it on the command
line from eddylab.org/software/hmmer/hmmer-3.4.tar.gz. Uncom-
press and untar it, and switch into the hmmer-3.4 directory. For exam-
ple:

% wget http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz

% tar xf hmmer-3.4.tar.gz

% cd hmmer-3.4

Next you’ll use ./configure to conﬁgure HMMER for your system,
but ﬁrst, decide where you want HMMER installed. By default, our
configure script will set things up to be installed under /usr/local.
HMMER programs are then installed in /usr/local/bin, and HMMER

18

sean r. eddy

man pages in /usr/local/share/man/man1/. These are the standard unix-y
places to put things, but you may need root privileges to do it (so
you might need something like sudo make install when you get to
that part below). If you want to install somewhere else, you want
to set a different install directory preﬁx using ./configure --prefix
/your/install/path, so programs and man pages will be installed in
4
/your/install/path/bin /your/install/path/share/man/man1/ respectively.
For example, you might do ./configure --prefix=${HOME}, for installation
in ${HOME}/bin/ and ${HOME}/share/man/man1 subdirectories in your own
home directory.

So, to conﬁgure and compile:

% ./configure --prefix=/your/install/path

% make

Optionally, to compile and run a test suite

5

:

% make check

The newly compiled binaries are now in the src directory. You can

run them from there, or manually copy them wherever. You don’t
have to install HMMER programs to run them. Optionally, to install
the programs and man pages, do:

% make install

Optionally, you can also install a set of additional small tools
(“miniapps”) from our Easel library. We don’t do this by default,
in case you already have a copy of Easel separately installed (from
Infernal, for example). To install Easel miniapps and their man pages
too:

% cd easel; make install

If you decide you did something wrong after the ./configure, make
distclean will clean up everything that got built and restore the distri-
bution to a pristine state, and you can start again.

Geeky: compile source from our github repository

Alternatively, you can clone our git repository master branch:

6

% git clone https://github.com/EddyRivasLab/hmmer hmmer-3.4

% cd hmmer-3.4

% git clone https://github.com/EddyRivasLab/easel

% autoconf

This is now essentially the same as if you unpacked a tarball, so

from here, follow the ./configure; make instructions above.

One difference is that our distribution tarballs include this user

4 These directories will be created, if
they didn’t already exist.

5 The test suite uses scripts, and re-
quires that you have python3 and perl.
We haven’t encountered any systems
without perl. If you don’t have python3,
make check will fail and tell you so. But
HMMER is still ﬁne, and you can install
it – running the test suite is optional!

6 As of 3.2, our git master branch is the
stable current release, as the git deities
prefer. This wasn’t true for us in the
past.

guide as a PDF, in addition to its LATEX source code. The github repo
only has the source LATEX ﬁles. To compile the PDF, see “compiling
the user guide” in the gory details below.

You need our Easel library, in addition to the HMMER repository.

We don’t guarantee that the two master branches are necessarily
compatible at all times. It’s possible that the Easel master branch has
advanced in support of an Infernal release, for example. You might
have to check out the Easel tag that corresponds to the more recent
stable HMMER release.

If you want to suggest changes to us by submitting a pull request

on GitHub, please base your changes against our develop branches.
Our master branches are for stable releases.

Gory details

System requirements

Operating system: HMMER is designed for POSIX-compatible plat-
forms, including Linux, Mac OS/X, and various UNIX OS’s. The
POSIX standard essentially includes all operating systems except
Microsoft Windows.
x86_64/Linux (both Intel and AMD), and we test releases on a wider
range of platforms.

We develop primarily on Mac OS/X and

7

8

Processor: HMMER depends on vector parallelization methods that
are processor-speciﬁc. H3 supports three types of processors: x86-
compatible (Intel/AMD) processors (SSE2 and AVX instruction sets),
ARM processors such as new Macs (NEON instructions), and some
PowerPC systems (Altivec/VMX instructions, big-endian mode only).
SSE2 is supported on Intel processors from Pentium 4 on, and
AMD processors from K8 (Athlon 64) on. This includes almost all
Intel processors since 2000 and AMD processors since 2003.

Altivec/VMX is supported on Motorola G4, IBM G5, and IBM
PowerPC processors starting with the Power6, which includes almost
all PowerPC-based desktop systems since 1999 and servers since
2007.

9

HMMER3 does not support little-endian PowerPC systems (ppc64le).

Alas, the PowerPC world has been moving toward little-endian
ppc64le, away from big-endian ppc64 and powerpc. H3’s VMX im-
plementation was originally developed on an AIX Power 7 system,
and Power 7 systems were big-endian. More recent Power 8 and 9
machines are “bi-endian”, bootable into either a big-endian or little-
endian system. IBM has stated that it really, really wants them to all
be in little-endian mode. Among common Linux/PowerPC distros,

hmmer user’s guide

19

7 Windows 10 includes a Linux subsys-
tem that allows you to install a Linux
OS inside Windows, with a bash com-
mand shell, and this should work ﬁne.
For older Windows, there are add-on
products available for making Win-
dows more POSIX-compliant and more
compatible with GNU-ish conﬁgures
and builds. One such product is Cyg-
win, www.cygwin.com, which is freely
available.
8 Many thanks to the GCC Compile
Farm Project for providing access to
some of the platforms that we use for
testing.

9 If your platform does not support
either of these vector instruction sets
– or if you’re on a ppc64le system that
supports VMX but in little-endian byte
order – the conﬁgure script will stop
with an error message.

20

sean r. eddy

Debian, Fedora, Red Hat, and openSUSE still come in either ppc64
and ppc64le ﬂavors; HMMER3 will run on the former but not the
latter. Recent Ubuntu and SUSE for PowerPC distros are only coming
in ppc64le ﬂavor, incompatible with H3.

Compiler: The source code conforms to ANSI C99 and POSIX stan-
dards. It should compile with any ANSI C99 compliant compiler,
including the freely available GNU C compiler gcc. We test the code
most frequently using the GNU gcc, Apple llvm/clang, and Intel icc
and icx compilers.

10

11

We depend on IEEE754-compliant ﬂoating point math.

Most
C compilers, including gcc and clang, are IEEE754-compliant by
default. Do not use their fast-math option. The Intel compiler icc/icx
defaults to using an unsafe “fast-math” mode. If you want to use an
Intel compiler, you must turn on IEEE754 compliance with an option
such as -fp-model strict; for example, you could conﬁgure for Intel icx
with ./configure CC=icx CFLAGS=’-O3 -fp-model=strict’.

Libraries and other installation requirements: HMMER3 does not have
any dependencies other than a C compiler. It does not require any
additional libraries to be installed by you, other than standard ANSI
C99 libraries that are already present on a system with a C99 com-
piler.

12

The HMMER distribution is bundled with a software library from
our lab called Easel.
Bundling Easel instead of making it a separate
installation requirement simpliﬁes installation. Easel is also included
in other software from our lab. For example, Infernal
bundles both
HMMER and Easel. If you install the Easel miniapps, you probably
only want to do that once, from the most recent version of HMMER,
Infernal, or Easel itself, to avoid clobbering a newer version with an
older one.

13

Our conﬁguration and compilation process uses standard UNIX
utilities. Although these utilities are supposed to be available on all
POSIX-compliant systems, there are always a few crufty old di-
nosaurs still running out there that do not support all the features
that our ./configure script and Makeﬁles are expecting. We do aim
to build cleanly on anything from supercomputers to Ebay’ed junk,
but if you have an old system, you may want to hedge your bets and
install up-to-date versions of GNU command line tools such as GNU
make and GNU grep.

Running the test suite (and some of our development tools, if
you delve deep into our codebase) requires Perl and Python3 to be
installed. If you don’t have them (which should be rare), make check
won’t work for you, but that’s ok because make and make install will

10 On OS/X, if you’re compiling the
source, make sure you have XCode
installed so that you have a C compiler.
11 With one highly technical exception;
on x86-compatible CPUs, we deliber-
ately turn on a CPU mode called FTZ
(ﬂush-to-zero).

12 bioeasel.org

13 eddylab.org/infernal

hmmer user’s guide

21

14 Set by a compile-time conﬁguration
option, p7_NCPU, in src/p7_config.h.in.

15 open-mpi.org

still work ﬁne.

Compiling the user guide itself (this document) does require ad-

ditional tools to be installed, including rman and some extra LATEX
packages, described below.

Multicore parallelization is (almost always) default

The HMMER programs that are compute intensive all support mul-
ticore parallelization using POSIX threads. By default, the conﬁgure
script will identify whether your platform supports POSIX threads
(and almost all platforms do), and it will automatically compile in
multithreading support.

To disable multithreading at compile time, compile from source

with the --disable-threads ﬂag to ./configure.

Multithreaded HMMER programs use master/worker paralleliza-

tion, with <n> worker compute threads and one master thread. The
default number of worker threads is usually two
. You can control
the number of worker threads you use with the --cpu <n> command
line option or the HMMER_NCPU environment variable. You can also turn
off multithreading, using --cpu 0.

14

hmmscan and nhmmscan are exceptions; for these two programs, we
have multithreaded parallelization turned off by default. It typically
takes the scan programs longer to read their proﬁle data from a ﬁle
on disk than it does to compute proﬁle/sequence comparisons, so
they are typically faster without the added overhead of multithread-
ing. If you happen to have some sort of lightning fast disk i/o, you
might ﬁnd that you can get higher performance using multithreading
with --cpu <n>.

If you are running HMMER on a cluster that enforces policy
on the number of cores a process can use, you may need to count
both the workers and the master: you may need to tell your cluster
management software that HMMER needs <n>+1 cores, while telling
HMMER --cpu <n>.

MPI cluster parallelization is optional

MPI (Message Passing Interface) parallelization on clusters is sup-
ported in hmmbuild and all search programs except nhmmer and nhmmscan.
To compile for MPI, you need to have an MPI library installed, such
as OpenMPI.

15

MPI support is not enabled by default. To enable MPI support
at compile time, add the --enable-mpi option to your ./configure com-
mand.

To use MPI parallelization, each program that has an MPI-parallel

mode has an --mpi command line option. This option activates a

22

sean r. eddy

master/worker parallelization mode.

The MPI implementation for hmmbuild scales well up to hundreds

of processors, and hmmsearch scales all right. The other search pro-
grams (hmmscan, phmmer, and jackhmmer) scale quite poorly, and probably
shouldn’t be used on more than tens of processors at most. Improv-
ing MPI scaling is something we’re working on.

Using build directories

The conﬁguration and compilation process from source supports the
use of separate build trees, using the GNU-standard VPATH mecha-
nism. This allows you to do separate builds for different processors
or with different conﬁguration/compilation options. All you have to
do is run the conﬁgure script from the directory you want to be the
root of your build tree. For example:

% mkdir my-hmmer-build

% cd my-hmmer-build

% ../configure

% make

This assumes you have a make that supports VPATH. If your system’s

make does not, you can install GNU make.

Makeﬁle targets

all Builds everything. Same as just saying make.

check Runs automated test suites in both HMMER and the Easel

library.

pdf Compiles this user guide.

install Installs programs and man pages.

uninstall Removes programs and man pages from where make install

put them.

clean Removes all ﬁles generated by compilation (by make). Con-
ﬁguration (ﬁles generated by ./configure) is preserved.

distclean Removes all ﬁles generated by conﬁguration (by ./configure)

and by compilation (by make).

Compiling the user guide

Compiling this User Guide from its source LATEX requires LATEX, of
course, and also the rman program from PolyGlotMan.
It use a cus-
tomized version of the Tufte-LaTeX book class

(which we include

16

17

Without the --mpi option, if you run a
program under mpirun or the equivalent
on N nodes, you’ll be running N
duplicates, not a single MPI-enabled
parallel search. Don’t do that.

16 sourceforge.net/projects/polyglotman
17 tufte-latex.github.io/tufte-latex

hmmer user’s guide

23

18 www.tug.org/texlive

19 www.macports.org

in our source code, so you don’t have to install it), and the Tufte-
LaTeX package depends on some optional LATEX packages listed at the
Tufte-LaTeX site. These packages are typically included in bundles
You can probably
in standard LATEX distributions such as TeX Live.
identify a short list of basic plus extra LATEX stuff you need to install
on your machine. For example, on my Mac OS/X laptop, using the
MacPorts package manager:

18

19

% sudo port install texlive

% sudo port install texlive-latex-extra

% sudo port install rman

Once you have these dependencies, doing:

% make pdf

in the top-level source directory builds Userguide.pdf in the subdi-

rectory documentation/userguide.

What gets installed by make install, and where?

HMMER only installs programs and man pages. There are 18 pro-
grams in HMMER and 22 in Easel (the Easel “miniapps”), each with
a man page.

Each program is free-standing. Programs don’t depend on any
details of where other ﬁles are installed, and they will run ﬁne no
matter where you copy them. Similarly the man pages can be read
in any ﬁle location with man full/path/to/manpage.man. Nonetheless, it’s
most convenient if you put the programs in a directory that’s in your
PATH and the man pages in a standard man page directory, using make
install.

The top-level Makeﬁle has variables that specify the two directo-

ries where make install installs things:

Variable What

bindir

man1dir

programs
man pages

These variables are constructed from others in accordance with

GNU Coding Standards, as follows:

Variable

Default

./configure option

prefix

/usr/local

--prefix

exec_prefix

prefix

--exec_prefix

bindir

exec_prefix/bin

--bindir

datarootdir

prefix/share

--datarootdir

mandir

datarootdir/man

--mandir

man1dir

mandir/man1

--man1dir

24

sean r. eddy

You can change any of these defaults on the ./configure command
line using the corresponding option. The most commonly used op-
tion is --prefix. For example, if you want to install HMMER in a
directory hierarchy all of its own, you might want to do something
like:

% ./configure --prefix /usr/local/hmmer-3.4

That would keep HMMER out of your system-wide directories,
which might be desirable. This is a simple way to install multiple
versions of HMMER, for example, without having them clobber
each other. Then you’d add /usr/local/hmmer-3.4/bin to your PATH and
/usr/local/hmmer-3.4/share/man to your MANPATH.

Again, these variables only affect where make install copies stuff.

HMMER and Easel programs have no pathnames compiled into
them.

Installing both HMMER2 and HMMER3

HMMER3 and HMMER2 are distinct codebases that are generally
incompatible with each other. The last release of HMMER2 was 2.3.2
in 2003. HMMER3 was ﬁrst released in 2010.

HMMER3 is superior to HMMER2 in almost all respects. One
exception is that HMMER2 is capable of global and glocal alignment,
whereas HMMER3 programs generally only use local alignment. It
turned out that some HMMER users need global/glocal alignment
more than they want the speed and statistics, so HMMER2 still has
users. I didn’t anticipate this when I wrote H3. Unfortunately, the
two packages have incompatible programs that have the same names,
so installing them both can lead to problems.

Speciﬁcally, HMMER2 installs 9 programs, 6 of which have identi-
cal names with incompatible HMMER3 programs: hmmalign, hmmbuild,
hmmconvert, hmmemit, hmmfetch, and hmmsearch.

One workaround is to install the two packages each in their
own hierarchy, as above: ./configure prefix=somewhere/hmmer-3.4 for
HMMER3, and ./configure prefix=somewhere/hmmer-2.3.2 for HMMER2.
One set of programs could be in your PATH, and you could call the
others using full pathnames.

Another workaround is simply to copy the HMMER2 programs to
an installation directory while renaming them, bypassing make install.
For example, something like:

% cp hmmalign /usr/local/bin/h2-hmmalign

% cp hmmconvert /usr/local/bin/h2-hmmconvert

...

and so on.

HMMER3’s speed depends on numer-
ical properties that only hold for local
alignment. Its statistics depend on a
statistical conjecture that only holds
well for local alignment. The internal
HMMER3 API includes global and glo-
cal alignment modes like HMMER2, but
the programs don’t use these modes.

Seeing more output from make

By default, our make hides what’s really going on with the compilation
with a pretty wrapper that we stole from the source for git. If you
want to see what the command lines really look like in all their ugly
glory, pass a V=1 option (V for “verbose”) to make, as in:

% make V=1

Staged installations in a buildroot, for a packaging system

HMMER’s make install supports staged installations, accepting the
traditional DESTDIR variable that packagers use to specify a buildroot.
For example, you can do:

% make DESTDIR=/rpm/tmp/buildroot install

Workarounds for unusual conﬁgure/compilation problems

Failure when trying to use a separate build directory.
If you try to build
in a build tree (other than the source tree) and you have any trouble
in conﬁguration or compilation, try just building in the source tree
instead. Some make versions don’t support the VPATH mechanism
needed to use separate build trees. Another workaround is to install
GNU make.

Conﬁguration fails, complaining “no acceptable grep could be found”.
We’ve seen this happen on our Sun Sparc/Solaris machine. It’s a
known issue in GNU autoconf. You can either install GNU grep, or
you can insist to ./configure that the Solaris grep (or whatever grep
you have) is ok by explicitly setting GREP to a path to one that works:

% ./configure GREP=/usr/xpg4/bin/grep

Many ‘make check’ tests fail. We have one report of a system that
failed to link multithread-capable system C libraries correctly, and
instead linked to one or more serial-only libraries.
to reproduce the problem, and are not sure what could possibly
cause it. We optimistically believe it was a one-off messed-up system,
not our fault, but then we often say things like that and they turn
out to be wrong. If it does happen, it screws all kinds of things up
with the multithreaded implementation. A workaround is to shut
threading off:

We were unable

20

% ./configure --disable-threads

This will compile code won’t parallelize across multiple cores, of

hmmer user’s guide

25

20 If you’re a pro: the telltale phenotype
of this failure is to conﬁgure with
debugging ﬂags on and recompile. Run
one of the failed unit test drivers (such
as easel/easel_utest) yourself and let it
dump core. Use a debugger to examine
the stack trace in the core. If it failed
in __errno_location(), then it’s linked a
non-thread-capable system C library.

26

sean r. eddy

course, but it will still work ﬁne on a single processor at a time (and
MPI, if you build with MPI enabled).

Tutorial

First let’s do something useful and see it work, then we’ll do a com-
plete walkthrough.

Tap, tap; is this thing on?

In the tutorial subdirectory, globins4.sto is an example of a basic
Stockholm alignment ﬁle. hmmbuild builds a proﬁle from an alignment:

% cd tutorial

% hmmbuild globins4.hmm globins4.sto

hmmsearch searches a proﬁle against a sequence database. The ﬁle
tutorial/globins45.fa is a small example of a FASTA ﬁle containing 45
globin sequences:

% hmmsearch globins4.hmm globins45.fa

This will print an output of the search results, with a table of sig-

niﬁcant hits followed by their alignments.

That’s all you need to start using HMMER for work. You can build

a proﬁle of your favorite sequence alignment if you have one; you
can also obtain alignments and proﬁles from Pfam.
real sequence databases to search from NCBI
have to worry much about sequence ﬁle formats. HMMER can read
most common alignment and sequence ﬁle formats automatically.

You can obtain

or UniProt

3

2

1

. You don’t

The programs in HMMER

In rough order of importance, the 18 HMMER programs are:

hmmbuild needs to be installed in your
PATH to be able to just type the hmmbuild
command like this. Otherwise you
need to give a path to where hmmbuild is,
which might be src/hmmbuild, if you’re
in the HMMER top level distribution
directory. If you’re new to how paths
to programs and ﬁles work on the
command line, skip ahead to running a
HMMER program for some more detail.

1 pfam.xfam.org
2 ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz
3 www.uniprot.org/downloads

28

sean r. eddy

hmmbuild

build proﬁle from input multiple alignment

hmmsearch

hmmalign make multiple sequence alignment using a proﬁle
search proﬁle against sequence database
search sequence against proﬁle database

hmmscan

hmmpress prepare proﬁle database for hmmscan

jackhmmer

nhmmscan

nhmmer

phmmer

search single sequence against sequence database
iteratively search single sequence against database
search DNA query against DNA sequence database
search DNA sequence against a DNA proﬁle database
retrieve proﬁle(s) from a proﬁle ﬁle
show summary statistics for a proﬁle ﬁle
generate (sample) sequences from a proﬁle
hmmlogo produce a conservation logo graphic from a proﬁle

hmmemit

hmmstat

hmmfetch

hmmconvert

hmmpgmd

hmmpgmd_shard

convert between different proﬁle ﬁle formats
search daemon for the hmmer.org website
sharded search daemon for the hmmer.org website

makehmmerdb prepare an nhmmer binary database

hmmsim

alimask

collect score distributions on random sequences
add column mask to a multiple sequence alignment

The programs hmmbuild, hmmsearch, hmmscan, and hmmalign are the core
functionality for protein domain analysis and annotation pipelines,
for instance using proﬁle databases like Pfam.

The phmmer and jackhmmer programs search a single protein sequence
against a protein sequence database, akin to BLASTP and PSI-BLAST.
(Internally, they just produce a proﬁle from the query sequence, then
run proﬁle searches.)

nhmmer is the equivalent of hmmsearch and phmmer, but is capable of
searching long, chromosome-size target DNA sequences. nhmmscan is
the equivalent of hmmscan, capable of using chromosome-size DNA
sequences as a query into a proﬁle database.

Running a HMMER program

After you compile HMMER, these programs are in the src/ subdi-
rectory of the top-level HMMER directory. If you run them without
arguments, they will give you a brief help message. In this chapter, I
will assume that you have installed them (with make install, perhaps)
so they’re in your PATH. So if you type hmmbuild at the command line,
you see:

% hmmbuild

Incorrect number of command line arguments.
Usage: hmmbuild [-options] <hmmfile_out> <msafile>

where basic options are:

-h

: show brief help on version and usage

nhmmer and nhmmscan were added in
HMMER3.1.

If you run a HMMER program with a
-h option and no arguments, it will give
you a brief summary of its usage and
options.

-n <s> : name the HMM <s>
-o <f> : direct summary output to file <f>, not stdout
-O <f> : resave annotated, possibly modified MSA to file <f>

To see more help on other available options, do:

hmmbuild -h

If you haven’t installed the HMMER programs, you need to spec-

ify both the program name and a path to it. This tutorial chapter
assumes that you’re in the tutorial subdirectory, where the tutorial
example data ﬁles are. From tutorial , the relative path to the com-
piled programs is ../src/. So instead of just typing hmmbuild, you could
do:

% ../src/hmmbuild

Make sure you can run a HMMER program like this before mov-

ing on. If you are stuck getting something like hmmbuild:
found, the unix shell isn’t ﬁnding the program in your PATH or you’re
not giving a correct explicit path. Consult your shell’s documenta-
tion, or a friendly local unix guru.

command not

Files used in the tutorial

The subdirectory called tutorial in the HMMER distribution contains
the ﬁles used in the tutorial. If you haven’t already, change into that
directory now.

% cd tutorial

If you do a ls, you’ll see there are several example ﬁles in the

tutorial directory:

globins4.sto An example alignment of four globin sequences, in

Stockholm format. This alignment is a subset of a fa-
mous old published structural alignment from Don
Bashford.

4

globins45.fa 45 unaligned globin sequences, in FASTA format.

hmmer user’s guide

29

The % represents your command
prompt. It’s not part of what you
type.

4 Donald Bashford, et al. Determinants
of a protein fold: Unique features of the
globin amino acid sequences. J. Mol.
Biol., 196:199–216, 1987

HBB_HUMAN A FASTA ﬁle containing the sequence of human β−hemoglobin.

fn3.sto An example alignment of ﬁbronectin type III domains.

This is a Pfam fn3 seed alignment, in Stockholm format.

Pkinase.sto The Pfam Pkinase seed alignment of protein kinase

domains.

7LESS_DROME A FASTA ﬁle containing the sequence of the Drosophila

Sevenless protein, a receptor tyrosine kinase whose
extracellular region consists of an array of several ﬁ-
bronectin type III domains.

30

sean r. eddy

MADE1.sto An example DNA alignment, a subset of the Dfam seed
alignment for the MADE1 transposable element family.

dna_target.fa A 330Kb sequence from human chromosome 1 in
FASTA format, containing four MADE1 elements.

On sequence ﬁle formats, brieﬂy

Input ﬁles for HMMER include unaligned sequence ﬁles and multi-
ple sequence alignment ﬁles. Sequence ﬁles and alignment ﬁles can
come in many different poorly standardized formats.

A commonly used format for unaligned sequence ﬁles and se-
quence databases is FASTA format. Several of the tutorial ﬁles give
you examples (globins45.fa, for example).

HMMER’s preferred alignment ﬁle format is Stockholm format,

which is also the format that Pfam alignments are in. Stockholm
allows detailed annotation of columns, residues, and sequences, and
HMMER is built to use this annotation. Stockholm also allows a ﬁle
to contain many alignments for many families (a multiple multiple
alignment ﬁle?). globins4.sto is a simple example, and fn3.sto is an
example with a lot of annotation markup.

HMMER can read several other sequence and alignment ﬁle for-
mats. By default, it autodetects what format an input ﬁle is in. Ac-
cepted unaligned sequence ﬁle formats include fasta, uniprot, genbank,
ddbj, and embl. Accepted multiple alignment ﬁle formats include
stockholm, afa (i.e. aligned FASTA), clustal, clustallike (MUSCLE, etc.),
a2m, phylip (interleaved), phylips (sequential), psiblast, and selex. These
formats are described in detail in a later chapter. Where applicable,
the programs have command line options for asserting an input for-
mat and skipping autodetection, when you don’t want to depend on
it.

HMMER also automatically detects whether a sequence or align-
ment ﬁle contains nucleotide or protein sequence data. Like format
autodetection, alphabet autodetection sometimes doesn’t work on
weird ﬁles. Where applicable, the programs have options (usually
--rna, --dna, --amino) for asserting the input alphabet type.

For more information in HMMER input ﬁles and formats, see the

formats chapter on page 207.

Searching a sequence database with a proﬁle

Now let’s go through the hmmbuild/hmmsearch example in a bit more
detail.

Stockholm format was developed
jointly with us by the Pfam curation
team.

hmmer user’s guide

31

Step 1: build a proﬁle with hmmbuild

The ﬁle globins4.sto looks like this:

# STOCKHOLM 1.0

HBB_HUMAN
HBA_HUMAN
MYG_PHYCA
GLB5_PETMA

HBB_HUMAN
HBA_HUMAN
MYG_PHYCA
GLB5_PETMA

HBB_HUMAN
HBA_HUMAN
MYG_PHYCA
GLB5_PETMA
//

........VHLTPEEKSAVTALWGKV....NVDEVGGEALGRLLVVYPWTQRFFESFGDLSTPDAVMGNPKVKAHGKKVL
.........VLSPADKTNVKAAWGKVGA..HAGEYGAEALERMFLSFPTTKTYFPHF.DLS.....HGSAQVKGHGKKVA
.........VLSEGEWQLVLHVWAKVEA..DVAGHGQDILIRLFKSHPETLEKFDRFKHLKTEAEMKASEDLKKHGVTVL
PIVDTGSVAPLSAAEKTKIRSAWAPVYS..TYETSGVDILVKFFTSTPAAQEFFPKFKGLTTADQLKKSADVRWHAERII

GAFSDGLAHL...D..NLKGTFATLSELHCDKL..HVDPENFRLLGNVLVCVLAHHFGKEFTPPVQAAYQKVVAGVANAL
DALTNAVAHV...D..DMPNALSALSDLHAHKL..RVDPVNFKLLSHCLLVTLAAHLPAEFTPAVHASLDKFLASVSTVL
TALGAILKK....K.GHHEAELKPLAQSHATKH..KIPIKYLEFISEAIIHVLHSRHPGDFGADAQGAMNKALELFRKDI
NAVNDAVASM..DDTEKMSMKLRDLSGKHAKSF..QVDPQYFKVLAAVIADTVAAG.........DAGFEKLMSMICILL

AHKYH......
TSKYR......
AAKYKELGYQG
RSAY.......

Most popular alignment formats are similar block-based formats.

They can be turned into Stockholm format with a little editing or
scripting. Don’t forget the # STOCKHOLM 1.0 line at the start of the align-
ment, nor the // at the end.

Stockholm alignments can be concatenated to create an alignment
database ﬂatﬁle containing many alignments. The Pfam database, for
example, distributes a single ﬁle containing representative alignments
for thousands of sequence families.

You ran hmmbuild to build a proﬁle from that alignment:

% hmmbuild globins4.hmm globins4.sto

and you got some output that looks like:

# hmmbuild :: profile HMM construction from multiple sequence alignments
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# input alignment file:
# output HMM file:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

globins4.sto
globins4.hmm

The Easel miniapps provide tools for
manipulating alignment ﬁles, such as
esl-afetch for extracting one alignment
by name or accession from a Pfam ﬁle.

mlen eff_nseq re/pos description
# idx name
alen
#---- -------------------- ----- ----- ----- -------- ------ -----------
171
1

globins4

0.589

nseq

0.96

149

4

# CPU time: 0.08u 0.00s 00:00:00.08 Elapsed: 00:00:00.08

If your input ﬁle had contained more than one alignment, you’d

get one line of output for each proﬁle. A single hmmbuild command
sufﬁces to turn a Pfam seed alignment ﬂatﬁle (such as Pfam-A.seed)
into a proﬁle ﬂatﬁle (such as Pfam.hmm).

The information on these lines is almost self-explanatory. The
globins4 alignment consisted of 4 sequences with 171 aligned columns
(alen). HMMER turned it into a proﬁle of 149 consensus positions
(mlen), which means it deﬁned 22 gap-containing alignment columns
to be insertions relative to consensus. The 4 sequences were only

32

sean r. eddy

counted as an “effective” total sequence number (eff_nseq) of 0.96, be-
cause they’re fairly similar to each other.
The proﬁle ended up with
a relative entropy per position (re/pos; average score, or information
content) of 0.589 bits.

5

The new proﬁle was saved to globins4.hmm. If you were to look at
this ﬁle (and you don’t have to – it’s intended for HMMER’s con-
sumption, not yours), you’d see something like:

5 It’s not unusual for this number to be
less than 1. I’ll explain why later.

no
no

no
yes

HMMER3/f [3.4 | Aug 2023]
NAME globins4
LENG 149
ALPH amino
RF
MM
CONS yes
CS
MAP
DATE Sun Aug 13 09:06:20 2023
NSEQ 4
EFFN 0.964844
CKSUM 2027839109
STATS LOCAL MSV
STATS LOCAL VITERBI
STATS LOCAL FORWARD
HMM

-9.8664
-10.7223
-4.1641
C
m->i
4.52198
4.42245
1.87270
4.17850
4.42225
3.85936

0.70955
0.70955
0.70955
D
m->d
2.96929
2.77499
1.29132
3.77264
2.77519
4.58171

A
m->m
2.36800
2.68638
0.55970
1.75819
2.68618
0.03182

COMPO

1

...

149

//

...

H
d->d

G
d->m
3.01836

F
i->i
3.20715

E
i->m
2.70577
3.40293 ...
2.73143 3.46374 2.40505 3.72514 ...
1.73023 0.19509 0.00000
3.37715 3.71018 3.31297 4.28273 ...
2.73123 3.46354 2.40513 3.72494 ...
0.61958 0.77255 0.34183 1.23951

*

W

Y

4.55599 3.63079
4.58497 3.61523

5.32308
4.58477

4.09587
3.61503

9 v - - -

2.93078
2.68634
0.21295

5.12630
4.42241
1.65128

3.29219
2.77535

2.66308 4.49202 3.60568 2.46960 ...
2.73098 3.46370 2.40469 3.72510 ...

5.42994
4.58493

4.19803
3.61420

165 k - - -

* 1.49930

0.25268 0.00000

*

The HMMER ASCII save ﬁle format is deﬁned on page 210.

Step 2: search the sequence database with hmmsearch

Presumably you have a sequence database to search. Here we’ll
use a UniProtKB/Swiss-Prot FASTA format ﬂatﬁle (not provided
in the tutorial, because of its large size), uniprot_sprot.fasta. If you
don’t have a sequence database handy, run your example search
against globins45.fa instead, which is a FASTA format ﬁle containing
45 globin sequences.

hmmsearch accepts any FASTA ﬁle as target database input. It also

accepts EMBL/UniProtKB text format, and Genbank format. It
will automatically determine what format your ﬁle is in; you don’t
have to say. An example of searching a sequence database with our
globins4.hmm proﬁle would look like:

% hmmsearch globins4.hmm uniprot_sprot.fasta > globins4.out

Have a look at the output, globins4.out. The ﬁrst section is the
header that tells you what program you ran, on what, and with what
options:

hmmer user’s guide

33

# hmmsearch :: search profile(s) against a sequence database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# query HMM file:
# target sequence database:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

globins4.hmm
uniprot_sprot.fasta

Query:
Scores for complete sequences (score includes all domains):

globins4

[M=149]

The second section is the sequence top hits list. It is a list of ranked
top hits (sorted by E-value, most signiﬁcant hit ﬁrst), formatted in a
BLAST-like style:

score

--- full sequence ---
E-value
bias
------- ------ -----
0.1
4.9e-65
0.1
6.9e-65
0.1
6.9e-65
0.1
6.9e-65
0.1
1.2e-64
0.2
2.1e-64

223.2
222.7
222.7
222.7
222.0
221.2

--- best 1 domain ---
E-value
score bias
------- ------ -----
0.1
5.5e-65
0.1
7.6e-65
0.1
7.6e-65
0.1
7.6e-65
0.1
1.3e-64
0.2
2.3e-64

223.0
222.6
222.6
222.6
221.8
221.0

-#dom-
exp

---- --

N Sequence
--------

Description
-----------

1 sp|P02024|HBB_GORGO
1.0
1.0 1 sp|P68871|HBB_HUMAN
1.0 1 sp|P68872|HBB_PANPA
1.0 1 sp|P68873|HBB_PANTR
1.0 1 sp|P02025|HBB_HYLLA
1.0 1 sp|P02033|HBB_PILBA

Hemoglobin subunit beta OS=Gorilla gor
Hemoglobin subunit beta OS=Homo sapien
Hemoglobin subunit beta OS=Pan paniscu
Hemoglobin subunit beta OS=Pan troglod
Hemoglobin subunit beta OS=Hylobates l
Hemoglobin subunit beta OS=Piliocolobu

The last two columns, obviously, are the name of each target se-
quence and optional description. The description line usually gets
truncated just to keep line lengths down to something reasonable. If
you want the full description line, and don’t mind long output line
lengths, use the --notextw option.

The most important number here is the ﬁrst one, the sequence
E-value. The E-value is the expected number of false positives (non-
homologous sequences) that scored this well or better. The E-value
is a measure of statistical signiﬁcance. The lower the E-value, the
more signiﬁcant the hit. I typically consider sequences with E-values
< 10−3 or so to be signiﬁcant hits.

The E-value is based on the sequence bit score, the second number.

This is the log-odds score for the complete sequence. Some people
like to see a bit score instead of an E-value, because the bit score
doesn’t depend on the size of the sequence database, only on the
proﬁle and the target sequence. The E-value does depend on the size
of the database you search: if you search a database ten times larger,
you get ten times the number of false positives.

The next number, the bias, is a correction term for biased sequence
composition that was applied to the sequence bit score. For instance,
for the top hit HBB_GORGO that scored 223.2 bits, the bias of 0.1 bits
means that this sequence originally scored 223.3 bits, which was
adjusted by the slight 0.1 bit biased-composition correction. The only
time you really need to pay attention to the bias value is when it’s
large, on the same order of magnitude as the sequence bit score.
Sometimes (rarely) the bias correction isn’t aggressive enough, and
allows a non-homolog to retain too much score. Conversely, the bias

The method that HMMER uses to
compensate for biased composition
remains unpublished, shamefully.

34

sean r. eddy

correction can be too aggressive sometimes, causing you to miss ho-
mologs. You can turn the biased-composition score correction off
6
with the --nonull2 option.

The next three numbers are again an E-value, score, and bias, but
only for the single best-scoring domain in the sequence, rather than
the sum of all its identiﬁed domains. The rationale for this isn’t ap-
parent in the globin example, because all the globins in this example
consist of only a single globin domain. So let’s set up a second ex-
ample, using a proﬁle of a single domain that’s commonly found in
multiple domains in a single sequence. Build a ﬁbronectin type III
domain proﬁle using the fn3.sto alignment.
analyze the sequence 7LESS_DROME, the Drosophila Sevenless receptor
tyrosine kinase:

Then use that proﬁle to

7

% hmmbuild fn3.hmm fn3.sto

% hmmsearch fn3.hmm 7LESS_DROME > fn3.out

In fn3.out, the sequence top hits list says:

6 And if you’re doing that, you may also
want to set --nobias, to turn off another
biased composition step called the bias
ﬁlter, which affects which sequences get
scored at all.

7 This happens to be a Pfam seed
alignment. It’s a good example of an
alignment with complex Stockholm
annotation.

--- full sequence ---
E-value
bias
------- ------ -----
0.9
5.6e-57

score

176.4

--- best 1 domain ---
E-value
score bias
------- ------ -----
0.9
2.3e-16

46.2

-#dom-
exp N Sequence
Description
---- -- --------
-----------
9.8 9 7LESS_DROME RecName: Full=Protein sevenless;

EC=2.7

OK, now let’s pick up the explanation where we left off. The total
sequence score of 176.4 sums up all the ﬁbronectin III domains that
were found in the 7LESS_DROME sequence. The “single best dom” score
and E-value are the bit score and E-value as if the target sequence
only contained the single best-scoring domain, without this summa-
tion.

The idea is that we might be able to detect that a sequence is
a member of a multidomain family because it contains multiple
weakly-scoring domains, even if no single domain is solidly signiﬁ-
cant on its own. On the other hand, if the target sequence happened
to be a piece of junk consisting of a set of identical internal repeats,
and one of those repeats accidentially gives a weak hit to the query
proﬁle, all the repeats will sum up and the sequence score might look
8
“signiﬁcant”.

So operationally:

• if both E-values are signiﬁcant (<< 1), the sequence is likely to be

homologous to your query.

• if the full sequence E-value is signiﬁcant but the single best do-

main E-value is not, the target sequence is probably a multidomain
remote homolog; but be wary, and watch out for the case where
it’s just a repetitive sequence.

OK, the sharp eyed reader asks, if that’s so, then why in the
globin4 output (all of which have only a single domain) do the full

8 Mathematically, alas, the correct
answer: the null hypothesis we’re
testing against is that the sequence
is a random sequence of some base
composition, and a repetitive sequence
isn’t random.

hmmer user’s guide

35

The difference between envelopes and
alignments comes up again below when
we discuss the reported coordinates of
domains and alignments in the next
section of the output.

9 Such sequences aren’t likely to show
up as signiﬁcant homologs to any
sensible query in the ﬁrst place.

sequence bit scores and best single domain bit scores not exactly
agree? For example, the top ranked hit, HBB_GORGO, has a full sequence
score of 223.2 and a single best domain score of 223.0. What’s going
on? What’s going on is that the position and alignment of that do-
main is uncertain – in this case, only very slightly so, but nonetheless
uncertain. The full sequence score is summed over all possible align-
ments of the globin proﬁle to the HBB_GORGO sequence. When HMMER
identiﬁes domains, it identiﬁes what it calls an envelope bound-
ing where the domain’s alignment most probably lies. The “single
best dom” score is calculated after the domain envelope has been
deﬁned, and the summation is restricted only to the ensemble of pos-
sible alignments that lie within the envelope. The fact that the two
scores are slightly different is therefore telling you that there’s a small
amount of probability (uncertainty) that the domain lies somewhat
outside the envelope bounds that HMMER has selected.

The two columns headed #dom are two different estimates of the
number of distinct domains that the target sequence contains. The
ﬁrst, the column marked exp, is the expected number of domains ac-
cording to HMMER’s statistical model. It’s an average, calculated as a
weighted marginal sum over all possible alignments. Because it’s an
average, it isn’t necessarily a round integer. The second, the column
marked N, is the number of domains that HMMER’s domain postpro-
cessing and annotation pipeline ﬁnally decided to identify, annotate,
and align in the target sequence. This is the number of alignments
that will show up in the domain report later in the output ﬁle.

These two numbers should be about the same. Rarely, you might

see that they’re very different, and this would usually be a sign
that the target sequence is so highly repetitive that it’s confused the
HMMER domain postprocessor.

9

The sequence top hits output continues until it runs out of se-
quences to report. By default, the report includes all sequences with
an E-value of 10.0 or less. It’s showing you the top of the noise, so
you can decide for yourself what’s interesting or not: the default out-
put is expected to contain about 10 false positives with E-values in
the range of about 1-10.

Then comes the third output section, which starts with

Domain annotation for each sequence (and alignments):

Now for each sequence in the top hits list, there will be a section

containing a table of where HMMER thinks all the domains are,
followed by the alignment inferred for each domain. Let’s use the fn3
vs. 7LESS_DROME example, because it contains lots of domains, and is
more interesting in this respect than the globin4 output. The domain
table for 7LESS_DROME looks like:

acc
----
410 .. 0.87
521 .. 0.95
914 .. 0.74
1251 .. 0.83
1384 .. 0.82
1769 .. 0.88
1891 .. 0.91
1977 .. 0.90
2107 .. 0.81

36

sean r. eddy

>> 7LESS_DROME
score

RecName: Full=Protein sevenless;

EC=2.7.10.1;

#
---

i-Evalue hmmfrom hmm to
------ ----- --------- --------- ------- -------

c-Evalue

bias

alifrom ali to
------- -------

envfrom env to
------- -------

1 ?
2 !
3 !
4 !
5 !
6 ?
7 !
8 !
9 !

-1.9
41.9
15.1
4.6
22.1
0.4
46.2
21.0
8.9

0.0
0.0
0.0
0.0
0.0
0.0
0.9
0.0
0.0

0.24
5.1e-15
1.2e-06
0.0022
7.6e-09
0.045
2.3e-16
1.7e-08
9.8e-05

0.24
5.1e-15
1.2e-06
0.0022
7.6e-09
0.045
2.3e-16
1.7e-08
9.8e-05

60
2
14
6
13
57
1
5
1

72 ..
83 ..
84 ..
36 ..
79 ..
72 ..
82 [.
74 ..
85 []

396
440
838
1206
1313
1754
1800
1904
1994

408 ..
520 ..
913 ..
1236 ..
1380 ..
1769 ..
1888 ..
1967 ..
2107 ..

395
439
827
1203
1305
1742
1800
1901
1994

Domains are reported in the order they appear in the sequence,

not in order of their signiﬁcance.

The ! or ? symbol indicates whether this domain does or does
not satisfy both per-sequence and per-domain inclusion thresholds.
Inclusion thresholds are used to determine what matches should
be considered to be “true”, as opposed to reporting thresholds that
determine what matches will be reported.
thresholds usually require a per-sequence E value of 0.01 or less and
a per-domain conditional E-value of 0.01 or less (except jackhmmer,
which requires a more stringent 0.001 for both), and reporting E-
value thresholds are set to 10.0.

By default, inclusion

10

The bit score and bias values are as described above for sequence

scores, but are the score of just one domain’s envelope.

The ﬁrst of the two E-values is the conditional E-value. It is an
attempt to measure the statistical signiﬁcance of each domain, given
that we’ve already decided that the target sequence overall is a true homolog.
It is the expected number of additional domains we’d ﬁnd with a do-
main score this big in the set of sequences reported in the top hits
list, if those sequences consisted only of random nonhomologous
sequence outside the best region that sufﬁced to deﬁne them as ho-
mologs.

The second number is the independent E-value: the signiﬁcance
of the sequence in the whole database search, if this were the only do-
main we had identiﬁed. It’s exactly the same as the “best 1 domain”
E-value in the sequence top hits list.

The different between the two E-values is not apparent in the
7LESS_DROME example because in both cases, the size of the search
space as 1 sequence. There’s a single sequence in the target se-
quence database (that’s the size of the search space that the indepen-
dent/best single domain E-value depends on). There’s one sequence
reported as a putative homolog in the sequence top hits list (that’s
the size of the search space that the conditional E-value depends on).
A better example is to see what happens when we search UniProt (I
used release 2022_02, which contains 567,483 sequences) with the fn3
proﬁle:

% hmmsearch fn3.hmm uniprot_sprot.fasta

10 The default reporting threshold of
10.0 is chosen so you get to see about
∼10 insigniﬁcant hits at the top of the
noise, so you can see what interesting
sequences might be getting tickled by
your search.

The conditional E-value is a weird
statistic, and it’s not clear I’m going to
keep it.

hmmer user’s guide

37

(If you don’t have UniProt and can’t run a command like this,
don’t worry about it - I’ll show the relevant bits here.) Now the do-
main report for 7LESS_DROME looks like:

>> sp|P13368|7LESS_DROME

Protein sevenless OS=Drosophila melanogaster OX=7227 GN=sev PE=1 SV=2

#
---

1 !
2 !
3 ?
4 !
5 !
6 !
7 ?

score

i-Evalue hmmfrom hmm to
------ ----- --------- --------- ------- -------

c-Evalue

bias

alifrom ali to
------- -------

env to
envfrom
------- -------

41.9
15.1
4.6
22.1
46.2
21.0
8.9

0.0
0.0
0.0
0.0
0.9
0.0
0.0

4.1e-12
0.00094
1.8
6.1e-06
1.9e-13
1.3e-05
0.079

2.9e-09
0.67
1.3e+03
0.0043
1.3e-10
0.0095
56

2
14
6
13
1
5
1

83 ..
84 ..
36 ..
79 ..
82 [.
74 ..
85 []

440
838
1206
1313
1800
1904
1994

520 ..
913 ..
1236 ..
1380 ..
1888 ..
1967 ..
2107 ..

439
827
1203
1305
1800
1901
1994

acc
----
521 .. 0.95
914 .. 0.74
1251 .. 0.83
1384 .. 0.82
1891 .. 0.91
1977 .. 0.90
2107 .. 0.81

Notice that almost everything’s the same (it’s the same target se-
quence, after all) except for what happens with E-values. The inde-
pendent E-value is calculated assuming a search space of all 567,483
sequences. For example, look at the highest scoring domain (domain
5 here; domain 7 above). When we only looked at a single sequence,
its score of 46.2 bits has an E-value of 2.3e-16. When we search a
database of 567,483 sequences, a hit scoring 46.2 bits would be ex-
pected to happen 567,483 times as often: 2.3e-16 × 567,483 = 1.3e-10.
In this UniProt search, 800 sequences were reported in the top hits
list (with E-values ≤ 10). If we were to assume that all 800 are true
homologs, x out the domain(s) that made us think that, and then
went looking for additional domains in those 800 sequences, we’d be
searching a smaller database of 800 sequences: the expected number
of times we’d see a hit of 46.2 bits or better is now 2.3e-16 × 800 =
1.9e-13. That’s where the conditional E-value (c-Evalue) is coming
from.

Notice that a couple of domains disappeared in the UniProt

search, because now, in this larger search space size, they’re not sig-
niﬁcant. Domain 1 (the one with the score of -1.9 bits) got a condi-
tional E-value of 0.24 × 800 = 192, and domain 6 (with a bit score of
0.4) got a c-Evalue of 0.045 × 800= 36.0. These fail the default report-
ing threshold of 10.0. Also, the domains with scores of 4.6 and 8.9
shifted from being above to below the default inclusion thresholds, so
now they’re marked with ? instead of !.

Operationally:

• If the independent E-value is signiﬁcant (<< 1), that means that

even this single domain by itself is such a strong hit that it sufﬁces
to identify the sequence as a signiﬁcant homolog with respect to
the size of the entire original database search. You can be conﬁ-
dent that this is a homologous domain.

• Once there’s one or more high-scoring domains in the sequence
already, sufﬁcient to decide that the sequence contains homologs
of your query, you can look (with some caution) at the conditional

If you calculate this yourself, you may
see some small discrepancies due to
ﬂoating point roundoff.

38

sean r. eddy

E-value to decide the statistical signiﬁcance of additional weak-
scoring domains.

In the UniProt output, for example, we’d be pretty sure of four
of the domains (1, 4, 5, and maybe 6), each of which has a strong
enough independent E-value to declare 7LESS_DROME to be an fnIII-
domain-containing protein. Domain 2 wouldn’t be signiﬁcant if it
was all we saw in the sequence, but once we decide that 7LESS_DROME
contains fn3 domains on the basis of the other hits, its conditional E-
value indicates that it’s probably an fn3 domain too. Domains 3 and
7 (the ones marked by ?) are too weak to be sure of, from this search
alone, but would be something to pay attention to.

The next four columns give the endpoints of the reported local
alignment with respect to both the query proﬁle (hmmfrom and hmm to)
and the target sequence (alifrom and ali to).

It’s not immediately easy to tell from the “to” coordinate whether

the alignment ended internally in the query or target, versus ran
all the way (as in a full-length global alignment) to the end(s). To
make this more readily apparent, with each pair of query and target
endpoint coordinates, there’s also a little symbology: .. means both
ends of the alignment ended internally, [] means both ends of the
alignment were full-length ﬂush to the ends of the query or target,
and [. and .] mean only the left or right end was ﬂush/full length.
The next two columns (envfrom and env to) deﬁne the envelope of
the domain’s location on the target sequence. The envelope is al-
most always a little wider than what HMMER chooses to show as a
reasonably conﬁdent alignment. As mentioned earlier, the envelope
represents a subsequence that encompasses most of the posterior
probability for a given homologous domain, even if precise endpoints
are only fuzzily inferrable.

Operationally, I recommend using the envelope coordinates to
annotate domain locations on target sequences, not the alignment
coordinates. Be aware that when two weaker-scoring domains are
close to each other, envelope coordinates (and, rarely, sometimes
even alignment coordinates) can and will overlap, corresponding to
the overlapping uncertainty of where one domain ends and another
begins.

The last column is the average posterior probability of the aligned

target sequence residues; effectively, the expected accuracy per
residue of the alignment.

For comparison, current UniProt consensus annotation of Seven-

less shows seven domains:

You’ll notice that for higher scoring do-
mains, the coordinates of the envelope
and the inferred alignment will tend to
be in tighter agreement, correspond-
ing to sharper posterior probability
deﬁning the location of the homologous
region.

FT
FT
FT

DOMAIN
DOMAIN
DOMAIN

440
824
1202

533
924
1290

Fibronectin type-III 1. {ECO:0000255|PROSITE-ProRule:PRU00316}.
Fibronectin type-III 2. {ECO:0000255|PROSITE-ProRule:PRU00316}.
Fibronectin type-III 3. {ECO:0000255|PROSITE-ProRule:PRU00316}.

hmmer user’s guide

39

FT
FT
FT
FT

DOMAIN
DOMAIN
DOMAIN
DOMAIN

1294
1801
1902
1995

1397
1901
1988
2117

Fibronectin type-III 4. {ECO:0000255|PROSITE-ProRule:PRU00316}.
Fibronectin type-III 5. {ECO:0000255|PROSITE-ProRule:PRU00316}.
Fibronectin type-III 6. {ECO:0000255|PROSITE-ProRule:PRU00316}.
Fibronectin type-III 7. {ECO:0000255|PROSITE-ProRule:PRU00316}.

These agree (modulo differences in start/endpoints) with the
seven strongest domains identiﬁed by HMMER. The weaker partial
domain hits (at 395-410 and 1742-1769) are also plausible homologies,
given that the extracellular domain of Sevenless is pretty much just a
big array of ∼100aa ﬁbronectin repeats.

11

Under the domain table, an “optimal posterior accuracy” align-
ment
is computed within each domain’s envelope and displayed.
For example, (skipping domain 1 because it’s weak and unconvinc-
ing), ﬁbronectin III domain 2 in your 7LESS_DROME output is shown as:

11 I. Holmes. Studies in Probabilistic
Sequence Alignment and Evolution. PhD
thesis, University of Cambridge, 1998

== domain 2

score: 41.9 bits;

conditional E-value: 5.1e-15

SBCEEEEEEESSSEEEEEEE-CSSSSSTECEEEEEEEETTSSSTEEEEEEESTCSEEEEESSSTTEEEEEEEEEEETTEEEE CS
2 aPsnlsvtevtstsltvsWtppedgngpitgYeveyrpknegeewneitvpgtttsvtltgLkpgteYevrVqavngggegp 83

fn3

aP

+++

++ l v+W+p +

ngpi+gY++++++++++ + e+ vp

s+++++L++gt+Y++ + +n++gegp

7LESS_DROME 440 APVIEHLMGLDDSHLAVHWHPGRFTNGPIEGYRLRLSSSEGNA-TSEQLVPAGRGSYIFSQLQAGTNYTLALSMINKQGEGP 520
77778899999****************************9997.***********************************997 PP

The initial header line starts with a == as a little handle for a pars-

ing script to grab hold of. I may put more information on that line
eventually.

If the proﬁle had any consensus structure or reference line annota-

tion that it inherited from your multiple alignment (#=GC SS_cons, #=GC
RF annotation in Stockholm ﬁles), that information is simply regurgi-
tated as CS or RF annotation lines here. The fn3 proﬁle had a consensus
structure annotation line.

The line starting with fn3 is the consensus of the query proﬁle:
the residue with the highest emission probability at each position.
13
Capital letters represent particularly highly conserved positions.
Dots (.) in this line indicate insertions in the target sequence with
respect to the proﬁle.

12

The midline indicates matches between the query proﬁle and tar-
get sequence. A letter indicates an exact match to the proﬁle consen-
sus. A + indicates that this residue has a positive log-odds emission
score, a “conservative substitution” given what the proﬁle expects at
that position.

14

The line starting with 7LESS_DROME is the target sequence. Dashes (-)

in this line indicate deletions in the target sequence with respect to
the proﬁle.

The bottom line represents the posterior probability (essentially
the expected accuracy) of each aligned residue. A 0 means 0-5%, 1
means 5-15%, and so on; 9 means 85-95%, and a * means 95-100%
posterior probability. You can use these posterior probabilities to
decide which parts of the alignment are well-determined or not.
You’ll often observe, for example, that expected alignment accuracy

12 For a single sequence query in phmmer,
the consensus is the sequence itself.
Oddly, this is not necessarily the high-
est probability sequence; for example,
under a BLOSUM62 scoring matrix,
where the query has an M, you are
more likely to see an aligned L, not an
M.
13 For protein models, ≥ 50% emission
probability; for DNA/DNA, ≥ 90%.

14 That is, the emission probability e(a)
for this aligned residue a is > fa, its
background frequency: it’s a likely
residue, just not the most likely one.

40

sean r. eddy

degrades around locations of insertion and deletion, which you’d
intuitively expect.

You’ll also see expected alignment accuracy degrade at the ends of
an alignment – this is because “alignment accuracy” posterior proba-
bilities currently not only includes whether the residue is aligned to
one proﬁle position versus others, but also confounded with whether
a residue should be considered to be homologous (aligned to the
proﬁle somewhere) versus not homologous at all.

These domain table and per-domain alignment reports for each se-
quence then continue, for each sequence that was in the per-sequence
top hits list.

Finally, at the bottom of the ﬁle, you’ll see some summary statis-
tics. For example, at the bottom of the globins search output, you’ll
ﬁnd something like:

It may make more sense to condition
the posterior probabilities on the
assumption that the residue is indeed
homologous: given that, how likely is it
that we’ve got it correctly aligned.

1 (149 nodes)

Internal pipeline statistics summary:
-------------------------------------
Query model(s):
Target sequences:
Passed MSV filter:
Passed bias filter:
Passed Vit filter:
Passed Fwd filter:
Initial search space (Z):
Domain search space
# CPU time: 3.67u 0.14s 00:00:03.81 Elapsed: 00:00:01.59
# Mc/sec: 19136.43
//
[ok]

(domZ):

567483 (204940973 residues searched)

20873 (0.0367817); expected 11349.7 (0.02)
17124 (0.0301754); expected 11349.7 (0.02)
2331 (0.00410761); expected 567.5 (0.001)
1129 (0.00198949); expected 5.7 (1e-05)

567483 [actual number of targets]

1129 [number of targets reported over threshold]

This gives you some idea of what’s going on in HMMER’s accel-
eration pipeline. You’ve got one query proﬁle, and the database has
567,483 target sequences. Each sequence goes through a gauntlet of
three scoring algorithms called MSV, Viterbi, and Forward, in order
of increasing sensitivity and increasing computational requirement.
MSV (the “Multi ungapped Segment Viterbi” algorithm) essen-
tially calculates the HMMER equivalent of BLAST’s sum score – an
optimal sum of ungapped high-scoring alignment segments. Unlike
BLAST, it does this calculation directly, without BLAST’s word hit
or hit extension step, using a SIMD vector-parallel algorithm. By de-
fault, HMMER is conﬁgured to allow sequences with a P-value of
≤ 0.02 through the MSV score ﬁlter.
Here, for this globin search,
about 3.7% of the database got through the MSV ﬁlter.

15

A quick check is then done to see if the target sequence is “ob-
viously” so biased in its composition that it’s unlikely to be a true
homolog. This is called the “bias ﬁlter”. If you don’t like it (it can
occasionally be overaggressive) you can shut it off with the --nobias
option. Here, 17124 sequences pass through the bias ﬁlter.

The Viterbi ﬁlter then calculates a gapped optimal alignment score.

This is more sensitive than the MSV score, but the Viterbi ﬁlter is
about four-fold slower than MSV. By default, HMMER lets sequences

15 Thus, if the database contained no
homologs and P-values were accurately
calculated, the highest scoring 2% of the
sequences will pass the ﬁlter.

hmmer user’s guide

41

with a P-value of ≤ 0.001 through this stage. Here, because there’s
about a thousand true globin homologs in this database, more than
that gets through: 2331 sequences.

Then the full Forward score is calculated, which sums over all
possible alignments of the proﬁle to the target sequence. The default
allows sequences with a P-value of ≤ 10−5 through: 1129 sequences
pass.

All sequences that make it through the three ﬁlters are then sub-

jected to a full probabilistic analysis using the HMM Forward/Backward
algorithms, ﬁrst to identify domains and assign domain envelopes;
then within each individual domain envelope, Forward/Backward
calculations are done to determine posterior probabilities for each
aligned residue, followed by optimal accuracy alignment. The results
of this step are what you ﬁnally see on the output.

Recall the difference between conditional and independent E-

values, with their two different search space sizes. These search space
sizes are reported in the statistics summary.

Finally, it reports the speed of the search in units of Mc/sec (mil-
lion dynamic programming cells per second), the CPU time, and the
elapsed time. This search took about 1.6 seconds of elapsed (wall
clock) time.

Single sequence protein queries using phmmer

The phmmer program is for searching a single sequence query against
a sequence database, much as BLASTP or FASTA would do. phmmer
works essentially just like hmmsearch does, except you provide a query
sequence instead of a query proﬁle.

Internally, HMMER builds a proﬁle from your single query se-
quence, using a simple position-independent scoring system (BLO-
SUM62 scores converted to probabilities, plus a gap-open and gap-
extend probability).

The ﬁle tutorial/HBB_HUMAN is a FASTA ﬁle containing the human
β−globin sequence as an example query. If you have a sequence
database such as uniprot_sprot.fasta, make that your target database;
otherwise, use tutorial/globins45.fa as a small example:

% phmmer HBB_HUMAN uniprot_sprot.fasta

or

% phmmer HBB_HUMAN globins45.fa

Everything about the output is essentially as previously described

for hmmsearch.

42

sean r. eddy

Iterative protein searches using jackhmmer

The jackhmmer program is for searching a single sequence query it-
eratively against a sequence database, much as PSI-BLAST would
do.

The ﬁrst round is identical to a phmmer search. All the matches that
pass the inclusion thresholds are put in a multiple alignment. In the
second (and subsequent) rounds, a proﬁle is made from these results,
and the database is searched again with the proﬁle.

Iterations continue either until no new sequences are detected
or the maximum number of iterations is reached. By default, the
maximum number of iterations is 5; you can change this with the -N
option.

Your original query sequence is always included in the multiple
alignments, whether or not it appears in the database. The “consen-
sus” columns assigned to each multiple alignment always correspond
exactly to the residues of your query, so the coordinate system of ev-
ery proﬁle is always the same as the numbering of residues in your
query sequence, 1..L for a sequence of length L.

Assuming you have UniProt or something like it handy, here’s an

example command line for a jackhmmer search:

% jackhmmer HBB_HUMAN uniprot_sprot.fasta

One difference from phmmer output you’ll notice is that jackhmmer
marks “new” sequences with a + and “lost” sequences with a -. New
sequences are sequences that pass the inclusion threshold(s) in this
round, but didn’t in the round before. Lost sequences are the oppo-
site: sequences that passed the inclusion threshold(s) in the previous
round, but have now fallen beneath (yet are still in the reported hits –
it’s possible, though rare, to lose sequences utterly, if they no longer
even pass the reporting threshold(s)). In the ﬁrst round, everything
above the inclusion thresholds is marked with a +, and nothing is
marked with a -. For example, the top of this output looks like:

# jackhmmer :: iteratively search a protein sequence against a protein database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# query sequence file:
# target sequence database:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

HBB_HUMAN
uniprot_sprot.fasta

HBB_HUMAN
Query:
Description: Human beta hemoglobin.

[L=146]

Scores for complete sequences (score includes all domains):

If it is in the database, it will almost
certainly be included in the internal
multiple alignment twice, once because
it’s the query and once because it’s a
signiﬁcant database match to itself. This
redundancy won’t screw anything up,
because sequences are downweighted
for redundancy anyway.

score

--- full sequence ---
E-value
bias
------- ------ -----
0.6
3.5e-98
0.6
3.5e-98
0.6
3.5e-98

330.5
330.5
330.5

+
+
+

score

--- best 1 domain ---
E-value
bias
------- ------ -----
0.6
3.9e-98
0.6
3.9e-98
0.6
3.9e-98

330.3
330.3
330.3

-#dom-
exp N Sequence
---- -- --------
1.0 1 sp|P68871|HBB_HUMAN
1.0 1 sp|P68872|HBB_PANPA
1.0 1 sp|P68873|HBB_PANTR

Description
-----------

Hemoglobin subunit beta OS=Homo sapien
Hemoglobin subunit beta OS=Pan paniscu
Hemoglobin subunit beta OS=Pan troglod

hmmer user’s guide

43

1e-97
3e-96
3e-95

329.0
324.2
320.9

0.7
0.5
0.6

1.1e-97
3.3e-96
3.4e-95

328.8
324.0
320.8

0.7
0.5
0.6

1.0 1 sp|P02024|HBB_GORGO
1.0 1 sp|P02025|HBB_HYLLA
1.0 1 sp|P02032|HBB_SEMEN

Hemoglobin subunit beta OS=Gorilla gor
Hemoglobin subunit beta OS=Hylobates l
Hemoglobin subunit beta OS=Semnopithec

+
+
+
...

That continues until the inclusion threshold is reached, at which
point you see a tagline “inclusion threshold” indicating where the
threshold was set:

+
+

0.2
0.0

25.0
24.6

0.00049
0.00064

0.00058
0.00075
------ inclusion threshold ------
0.012
0.0018

0.0011
0.0014

23.9
23.5

0.3
0.0

24.8
24.4

20.5
23.2

0.2
0.0

0.3
0.0

1.0 1
1.0 1

sp|Q0KIY5|MYG_KOGBR
sp|P14399|MYG_MUSAN

Myoglobin OS=Kogia breviceps OX=27615
Myoglobin OS=Mustelus antarcticus OX=7

2.0 1 sp|P81044|HBAZ_NOTEU
1.1

1 sp|O80405|LGB3_PEA

Hemoglobin subunit zeta (Fragments) OS
Leghemoglobin Lb120-1 OS=Pisum sativum

The domain output and search statistics are then shown just as in

phmmer. At the end of this ﬁrst iteration, you’ll see some output that
starts with @@ (this is a simple tag that lets you search through the ﬁle
to ﬁnd the end of one iteration and the beginning of another):

@@ New targets included:
@@ New alignment includes: 955 subseqs (was 1), including original query
@@ Continuing to next round.

954

@@
@@ Round:
@@ Included in MSA:
@@ Model size:
@@

2
955 subsequences (query + 954 subseqs from 954 targets)
146 positions

This (obviously) is telling you that the new alignment contains 955

sequences, your query plus 955 signiﬁcant matches. For round two,
it’s built a new proﬁle from this alignment. Now for round two, it
ﬁres off what’s essentially an hmmsearch of the target database with this
new proﬁle:

Scores for complete sequences (score includes all domains):

score

--- full sequence ---
E-value
bias
------- ------ -----
0.2
8.9e-71
0.3
1.5e-70
0.5
1.9e-70
0.3
2.2e-70

241.7
240.9
240.6
240.4

score

--- best 1 domain ---
E-value
bias
------- ------ -----
0.2
9.9e-71
0.3
1.7e-70
0.5
2.1e-70
0.3
2.4e-70

241.5
240.8
240.5
240.2

-#dom-
exp N Sequence
---- -- --------
1.0 1 sp|P02055|HBB_MELME
1.0 1 sp|P15449|HBB_MELCA
1.0 1 sp|P81042|HBE_NOTEU
1.0 1 sp|P23602|HBB_MUSLU

Description
-----------

Hemoglobin subunit beta OS=Meles meles
Hemoglobin subunit beta OS=Mellivora c
Hemoglobin subunit epsilon OS=Notamacr
Hemoglobin subunit beta OS=Mustela lut

...

If you skim down through this output, you’ll start seeing newly

included sequences marked with +’s, such as:

...
+
+
+

+

+

...

1e-19
1.4e-19
1.5e-19
1.7e-19
8.9e-19
1.2e-18
1.4e-18
3.3e-18
3.8e-18
6.8e-18

76.1
75.6
75.5
75.3
73.0
72.6
72.3
71.2
70.9
70.1

0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.2
0.0

1.2e-19
1.6e-19
1.8e-19
2.1e-19
9.4e-19
1.4e-18
1.6e-18
3.8e-18
4.1e-18
7.2e-18

75.8
75.4
75.3
75.0
72.9
72.3
72.1
70.9
70.8
70.1

0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.2
0.0

sp|P86880|NGB_CHAAC
Neuroglobin OS=Chaenocephalus aceratus
1.0 1
sp|P59743|NGB2_ONCMY
Neuroglobin-2 OS=Oncorhynchus mykiss O
1.0 1
sp|P86881|NGB_DISMA
Neuroglobin OS=Dissostichus mawsoni OX
1.0 1
1.0 1 sp|P59742|NGB1_ONCMY
Neuroglobin-1 OS=Oncorhynchus mykiss O
sp|P81041|HBO_NOTEU
Hemoglobin subunit omega (Fragment) OS
1.0 1
sp|Q90YJ2|NGB_DANRE
1.0 1
Neuroglobin OS=Danio rerio OX=7955 GN=
1.0 1 sp|P23216|GLBP1_GLYDI Globin, major polymeric component P1 O
1.0 1 sp|Q99JA8|NGB_RAT
Neuroglobin OS=Rattus norvegicus OX=10
1.1 1
Myoglobin (Fragment) OS=Ailuropoda mel
1.0 1 sp|P21659|GLBP2_GLYDI Globin, polymeric component P2 OS=Glyc

sp|Q7M3C1|MYG_AILME

It’s less usual to see sequences get lost (and marked with -), but it

happens.

After round 2, more distant globin sequences have been found:

44

sean r. eddy

@@ New targets included:
@@ New alignment includes: 1111 subseqs (was 955), including original query
@@ Continuing to next round.

154

@@
@@ Round:
@@ Included in MSA:
@@ Model size:
@@

3
1111 subsequences (query + 1110 subseqs from 1108 targets)
146 positions

Because new sequences were included, it keeps going to round
three, and then again to round four. After round four, the search
ends because it didn’t ﬁnd any new hits; it considers the search to be
“converged” and it stops. (It would also eventually stop at a certain
maximum number of iterations; the default maximum is 5, and you
can set a different maximum with the -N option.) The end of the
output is:

@@ New targets included:
@@ New alignment includes: 1170 subseqs (was 1170), including original query
@@
@@ CONVERGED (in 4 rounds).
@@

0

//
[ok]

The // marks the end of the results for one query. You could
search with more than one query in your input query sequence ﬁle.
There is an [ok] at the end of the search output as a signal that
the search successfully completed. This might be useful if you’re au-
tomating lots of searches and you want to be sure that they worked.

Searching a proﬁle database with a query sequence

Rather than searching a single proﬁle against a collection of se-
quences, you might want to wish to annotate a single sequence
by searching it against a collection of proﬁles of different domains.
hmmscan takes as input a query ﬁle containing one or more sequences
to annotate, and a proﬁle database to search them against. The pro-
ﬁle database might be Pfam, SMART, or TIGRFams, for example, or
another collection of your choice.

Step 1: create a proﬁle database ﬁle

A proﬁle “database” ﬁle is just a concatenation of individual proﬁle
ﬁles. To create a database ﬁle, you can either build individual proﬁle
ﬁles and concatenate them, or you can concatenate Stockholm align-
ments and use hmmbuild to build a proﬁle database from them in one
command.

Let’s create a tiny database called minifam containing proﬁles of
globin, fn3, and Pkinase (protein kinase) domains by concatenating
proﬁle ﬁles:

Either hmmsearch or hmmscan can compare
a set of proﬁles to a set of sequences.
Due to disk access patterns of the two
tools, it is usually more efﬁcient to
use hmmsearch, unless the number of
proﬁles greatly exceeds the number of
sequences.

hmmer user’s guide

45

For example, it won’t work if you
concatenate globins4.sto with other
Stockholm ﬁles, because the simple
little globins4.sto alignment doesn’t
have an ID line.

16 I can’t really help you with this.
Different sites have different cluster,
scheduler, and MPI environments.
Consult a local guru, as they say.

% hmmbuild globins4.hmm globins4.sto

% hmmbuild fn3.hmm fn3.sto

% hmmbuild Pkinase.hmm Pkinase.sto

% cat globins4.hmm fn3.hmm Pkinase.hmm > minifam

We’ll use minifam for our examples in just a bit, but ﬁrst a few
words on other ways to build proﬁle databases, especially big ones.
The other way to do it is to start with an alignment database ﬂat-
ﬁle – a concatenation of many Stockholm ﬁles – and use hmmbuild to
build a proﬁle database ﬁle from it. For example, you could obtain
the big Pfam-A.seed and/or Pfam-A.full Stockholm-format alignment
ﬂatﬁles from Pfam. hmmbuild names each proﬁle according to a #=GF ID
annotation line in each Stockholm alignment. Normally the ID line
is optional in Stockholm format, but hmmbuild has to name your new
proﬁle(s) somehow. For a single alignment, it will use your ﬁlename,
or you can use the hmmbuild -n <name> option to provide a name your-
self. For an alignment database, the only way hmmbuild can get a name
for each alignment is from alignment annotation. Of alignment ﬁle
formats, only Stockholm format provides a way to concatenate many
alignments in the same ﬁle, with a name for each alignment. For
example, from a Pfam seed alignment ﬂatﬁle Pfam-A.seed, you can do:

% hmmbuild Pfam-A.hmm Pfam-A.seed

This would probably take a couple of hours to build all 20,000
proﬁles or so in Pfam. To speed the database construction process up,
hmmbuild supports MPI parallelization. Running MPI programs can be
a little arcane, so skip this bit if you’re not in the mood.

As far as HMMER’s concerned, all you have to do is add --mpi to
the command line for hmmbuild to tell it to run in MPI master/worker
mode across many cores and/or machines, assuming you’ve com-
piled support for MPI into it (see the installation instructions). You’ll
also need to know how to invoke an MPI job in your particular clus-
ter environment, with your job scheduler and your MPI distribu-
In general, you will launch the parallel hmmbuild by using a
tion.
command like mpirun or srun that manages the MPI environment for
a speciﬁed number of processes. With the SGE (Sun Grid Engine)
scheduler and Intel MPI, an example incantation for building Pfam.hmm
from Pfam-A.seed in parallel across 128 processes:

16

% qsub -N hmmbuild -j y -o errors.out -b y -cwd -V -pe impi 128 \

’mpirun -np 128 ./hmmbuild -mpi Pfam.hmm Pfam-A.seed > hmmbuild.out’

or, an example SLURM incantation (on the eddy group partition on

our Harvard cluster):

% sbatch -J hmmbuild -e hmmbuild.err -o hmmbuild.out -p eddy -n 128 -t 6-00:00 -mem-per-cpu=4000 \

-wrap="srun -n 128 -mpi=pmi2 ./hmmbuild -mpi Pfam-A.hmm Pfam-A.seed"

46

sean r. eddy

This reduces the time to build all of Pfam to about 40 seconds.

Step 2: compress and index the ﬂatﬁle with hmmpress

hmmscan has to read a lot of proﬁles in a hurry, and HMMER’s text
ﬂatﬁles are bulky. To accelerate this, hmmscan depends on binary com-
pression and indexing of the ﬂatﬁles. First you compress and index
your proﬁle database with the hmmpress program:

% hmmpress minifam

This will produce:

done.

Working...
Pressed and indexed 3 HMMs (3 names and 2 accessions).
minifam.h3m
Models pressed into binary file:
minifam.h3i
SSI index for binary model file:
Profiles (MSV part) pressed into:
minifam.h3f
Profiles (remainder) pressed into: minifam.h3p

and you’ll see these four new binary ﬁles in the directory.

17

Step 3: search the proﬁle database with hmmscan

Now we can analyze sequences using our proﬁle database and
hmmscan.

For example, the receptor tyrosine kinase 7LESS_DROME not only has
all those ﬁbronectin type III domains on its extracellular side, it’s got
a protein kinase domain on its intracellular side. Our minifam database
has proﬁles of both fn3 and Pkinase, as well as the unrelated globins4
proﬁle. So what happens when we scan the 7LESS_DROME sequence:

% hmmscan minifam 7LESS_DROME

The header and the ﬁrst section of the output will look like:

# hmmscan :: search sequence(s) against a profile database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# query sequence file:
# target HMM database:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

7LESS_DROME
minifam

17 Their format is “proprietary”, an
open source term of art that means
both “I haven’t found time to document
them yet” and “I still might decide to
change them arbitrarily without telling
you”.

[L=2554]

7LESS_DROME
P13368

Query:
Accession:
Description: RecName: Full=Protein sevenless;
Scores for complete sequence (score includes all domains):
-#dom-
exp N

score

--- full sequence ---
E-value
bias
------- ------ -----
0.9
1.7e-56
0.0
2.3e-41

176.4
129.5

--- best 1 domain ---
E-value
score bias
------- ------ -----
0.9
0.0

7e-16
3.8e-41

46.2
128.8

EC=2.7.10.1;

Description
---- -- -------- -----------

Model

9.8 9 fn3
1.3 1

Pkinase

Fibronectin type III domain
Protein kinase domain

The output ﬁelds are in the same order and have the same mean-

ing as in hmmsearch’s output.

The size of the search space for hmmscan is the number of proﬁles
in the proﬁle database (here, 3; for a Pfam search, on the order of

hmmer user’s guide

47

20000). In hmmsearch, the size of the search space is the number of
sequences in the sequence database. This means that E-values may
differ even for the same individual proﬁle vs. sequence comparison,
depending on how you do the search.

For domain, there then follows a domain table and alignment
output, just as in hmmsearch. The fn3 annotation, for example, looks
like:

Domain annotation for each model (and alignments):
>> fn3 Fibronectin type III domain
bias

i-Evalue hmmfrom hmm to
------ ----- --------- --------- ------- -------

c-Evalue

#
---

score

alifrom ali to
------- -------

envfrom env to
------- -------

1 ?
2 !
3 !
4 !
5 !
6 ?
7 !
8 !
9 !

-1.9
41.9
15.1
4.6
22.1
0.4
46.2
21.0
8.9

0.0
0.0
0.0
0.0
0.0
0.0
0.9
0.0
0.0

0.48
1e-14
2.3e-06
0.0044
1.5e-08
0.09
4.7e-16
3.3e-08
0.0002

0.71
1.5e-14
3.5e-06
0.0066
2.3e-08
0.14
7e-16
5e-08
0.0003

60
2
14
6
13
57
1
5
1

72 ..
83 ..
84 ..
36 ..
79 ..
72 ..
82 [.
74 ..
85 []

396
440
838
1206
1313
1754
1800
1904
1994

408 ..
520 ..
913 ..
1236 ..
1380 ..
1769 ..
1888 ..
1967 ..
2107 ..

395
439
827
1203
1305
1742
1800
1901
1994

acc
----
410 .. 0.87
521 .. 0.95
914 .. 0.74
1251 .. 0.83
1384 .. 0.82
1769 .. 0.88
1891 .. 0.91
1977 .. 0.90
2107 .. 0.81

and an example alignment (of that second domain again):

== domain 2

score: 41.9 bits;

conditional E-value: 1e-14

SBCEEEEEEESSSEEEEEEE-CSSSSSTECEEEEEEEETTSSSTEEEEEEESTCSEEEEESSSTTEEEEEEEEEEETTEEEE CS
2 aPsnlsvtevtstsltvsWtppedgngpitgYeveyrpknegeewneitvpgtttsvtltgLkpgteYevrVqavngggegp 83

fn3

aP

+++

++ l v+W+p +

ngpi+gY++++++++++ + e+ vp

s+++++L++gt+Y++ + +n++gegp

7LESS_DROME 440 APVIEHLMGLDDSHLAVHWHPGRFTNGPIEGYRLRLSSSEGNA-TSEQLVPAGRGSYIFSQLQAGTNYTLALSMINKQGEGP 520
77778899999****************************9997.***********************************997 PP

You’d probably expect that except for the E-values (which depend

on database search space sizes), you should get exactly the same
scores, domain number, domain coordinates, and alignment every
time you do a comparison of the same proﬁle against the same se-
quence. Which is actually the case! But in fact, under the hood, it’s
actually not so obvious this should be, and HMMER is actually go-
ing out of its way to make it so. HMMER uses stochastic sampling
algorithms to infer some parameters, and also to infer the exact do-
main number and domain boundaries in certain difﬁcult cases. If
HMMER ran its stochastic samples “properly”, it would obtain dif-
ferent samples every time you ran a program, and all of you would
complain to me that HMMER was weird and buggy because it gave
different answers on the same problem. To suppress run-to-run varia-
tion, HMMER seeds its random number generator(s) identically every
time you do a sequence comparison. If you’re a stats expert, and you
really want to see the proper stochastic variation that results from
sampling algorithms, you can pass a command-line argument of
--seed 0 to programs that have this property (hmmbuild and the four
search programs).

Summary statistics for a proﬁle database: hmmstat

Our minifam proﬁle “database” example only contains three proﬁles,
but real proﬁle databases like Pfam can contain many thousands. The

48

sean r. eddy

hmmstat program is a utility that summarizes the content of a proﬁle
database. If you do:

% hmmstat minifam

you’ll get:

# hmmstat :: display summary statistics for a profile file
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# idx name
info p relE compKL
# ---- -------------------- ------------ -------- -------- ------ ------ ------ ------ ------
0.03
1
0.04
2
0.02
3

-
PF00041.20
PF00069.24

globins4
fn3
Pkinase

0.96
12.20
2.57

nseq eff_nseq

0.59
0.64
0.57

0.52
0.60
0.50

0.59
0.67
0.59

149
85
259

accession

M relent

4
98
38

The output is one line per proﬁle, numbered. Some of the ﬁelds

are more meaningful to you than others; some are sort of cryptic
relics of development that we haven’t cleaned up yet:

idx Number, in order in the database.

name Name of the proﬁle.

accession Accession (if present; else ’-’)

nseq Number of sequences in the alignment this proﬁle was built

from.

eff_nseq Effective sequence number. This was the “effective” number

of independent sequences that hmmbuild’s default “entropy
weighting” step decided on, given the phylogenetic similar-
ity of the nseq sequences in the input alignment.

M Length of the proﬁle in consensus residues (match states).

relent Mean relative entropy of the match state emission probabili-
ties, relative to default null background frequencies, in bits.
This is the average bit score per aligned consensus residue.
This quantity is the target of hmmbuild’s entropy weighting
procedure for determining eff_nseq.

info Mean information content per match state emission prob-

ability vector, in bits. Probably not useful to you. Infor-
mation content is just a slightly different calculation from
relent.

p relE Mean positional relative entropy, in bits. Also probably

not useful to you. This is an average relative entropy
per position that takes into account the transition (inser-
tion/deletion) probabilities. It should be a more accurate
estimation of the average bit score contributed per aligned
model consensus position.

hmmer user’s guide

49

compKL Kullback-Leibler (KL) divergence from the average compo-
sition of the proﬁle’s consensus match states to the default
background frequency distribution, in bits. The higher this
number, the more biased the residue composition of the
proﬁle is. Highly biased proﬁles may produce more false
positives in searches, and can also slow the HMMER3 ac-
celeration pipeline, by causing too many nonhomologous
sequences to pass the ﬁlters.

Creating multiple alignments with hmmalign

The ﬁle globins45.fa is a FASTA ﬁle containing 45 unaligned globin
sequences. To align all of these to the globins4 proﬁle and make a
multiple sequence alignment:

% hmmalign globins4.hmm globins45.fa

The output of this is a Stockholm format multiple alignment ﬁle.

The ﬁrst few lines of it look like:

# STOCKHOLM 1.0

MYG_ESCGI
#=GR MYG_ESCGI
MYG_HORSE
#=GR MYG_HORSE
MYG_PROGU
#=GR MYG_PROGU
MYG_SAISC
#=GR MYG_SAISC
MYG_LYCPI
#=GR MYG_LYCPI
MYG_MOUSE
...

.-VLSDAEWQLVLNIWAKVEADVAGHGQDILIRLFKGHPETLEKFDKFKHLKTEAEMKASE ...
PP ..69********************************************************* ...
g--LSDGEWQQVLNVWGKVEADIAGHGQEVLIRLFTGHPETLEKFDKFKHLKTEAEMKASE ...
PP 8..89******************************************************** ...
g--LSDGEWQLVLNVWGKVEGDLSGHGQEVLIRLFKGHPETLEKFDKFKHLKAEDEMRASE ...
PP 8..89******************************************************** ...
g--LSDGEWQLVLNIWGKVEADIPSHGQEVLISLFKGHPETLEKFDKFKHLKSEDEMKASE ...
PP 8..89******************************************************** ...
g--LSDGEWQIVLNIWGKVETDLAGHGQEVLIRLFKNHPETLDKFDKFKHLKTEDEMKGSE ...
PP 8..89******************************************************** ...
g--LSDGEWQLVLNVWGKVEADLAGHGQEVLIGLFKTHPETLDKFDKFKNLKSEEDMKGSE ...

and so on. (I’ve truncated long lines.)
First thing to notice here is that hmmalign uses both lower case and

upper case residues, and it uses two different characters for gaps.
This is because there are two different kinds of columns: “match”
columns in which residues are assigned to match states and gaps
are treated as deletions relative to consensus, and “insert” columns
where residues are assigned to insert states and gaps in other se-
quences are just padding for the alignment to accomodate those
insertions. In a match column, residues are upper case, and a ’-’ char-
acter means a deletion relative to the consensus. In an insert column,
residues are lower case, and a ’.’ is padding. A ’-’ deletion has a cost:
transition probabilities were assessed, penalizing the transition into
and out of a deletion. A ’.’ pad has no cost per se; instead, the se-
quence(s) with insertions are paying transition probabilities into and
out of their inserted residue.

This notation is only for your convenience in output ﬁles. You can
see the structure of the proﬁle reﬂected in the pattern of residues and

By default, hmmalign removes any
columns that are all deletion characters,
so the number of apparent match
columns in a displayed alignment is ≤
the actual number of match states in the
proﬁle. To prevent this trimming and
see columns for all match states, use the
--allcol option. This can be helpful if
you’re writing a postprocessor that’s
trying to keep track of what columns
are assigned to what match states in the
proﬁle.

18 A2M format is an important excep-
tion!

By arbitrary HMMER convention,
the insertion is divided in half; half
is left-justiﬁed, and the other half is
right-justiﬁed, leaving ’.’ characters in
the middle.

50

sean r. eddy

gap characters . In input ﬁles, in most alignment formats
is case-insensitive, and it does not distinguish between different
gap characters: ’-’ (dash), ’.’ (period), or even ’_’ (underscore) are
accepted as gap characters.

18

HMMER

Important: insertions relative to a proﬁle are unaligned. Suppose
one sequence has an insertion of length 10 and another has an in-
sertion of length 2 in the same place in the proﬁle. The alignment
will have ten insert columns, to accomodate the longest insertion.
The residues of the shorter insertion are thrown down in an arbi-
trary order. Notice that in the previous paragraph I oh-so-carefully
said residues are “assigned” to a state, not “aligned” to a state. For
match states, assigned and aligned are the same thing: a one-to-one
correspondence between a residue and a consensus match state in the
proﬁle. But there may be one or more residues assigned to the same
insert state.

Don’t be confused by the unaligned nature of proﬁle insertions.
You’re sure to see cases where lower-case inserted residues are “ob-
viously misaligned”. This is just because HMMER isn’t trying to
“align” them in the ﬁrst place. It’s assigning them to unaligned inser-
tions.

Enough about the sequences in the alignment. Now, notice all
those PP annotation lines. That’s posterior probability annotation, as
in the single sequence alignments that hmmscan and hmmsearch showed.
This represents the conﬁdence that each residue is assigned where it
should be.

Again, that’s “assigned”, not “aligned”. The posterior probability

assigned to an inserted residue is the probability that it is assigned
to the insert state corresponding to that column. Because the same
insert state might correspond to more than one column, the proba-
bility on an insert residue is not the probability that it belongs in that
particular column; again, if there’s a choice of column for putting an
inserted residue, that choice is arbitrary.

hmmalign currently has a, um, feature that you may dislike. Recall
that HMMER only does local alignments. Here, we know that we’ve
provided full length globin sequences, and globins4 is a full length
globin proﬁle. We’d probably like hmmalign to produce a global align-
ment. It can’t currently do that. If it doesn’t quite manage to extend
its local alignment to the full length of a target globin sequence,
you’ll get a weird-looking effect, as the nonmatching termini are
pulled out to the left or right. For example, look at the N-terminal g
in MYG_HORSE above. HMMER is about 80% conﬁdent that this residue
is nonhomologous, though any sensible person would align it into
the ﬁrst globin consensus column.

Look at the end of that ﬁrst block of Stockholm alignment, where

hmmer user’s guide

51

you’ll see:

# STOCKHOLM 1.0

MYG_ESCGI
#=GR MYG_ESCGI
MYG_HORSE
#=GR MYG_HORSE
MYG_PROGU
#=GR MYG_PROGU
MYG_SAISC
#=GR MYG_SAISC
MYG_LYCPI
#=GR MYG_LYCPI
MYG_MOUSE
...

.-VLSDAEWQLVLNIWAKVEADVAGHGQDILIRLFKGHPETLEKFDKFKHLKTEAEMKASE ...
PP ..69********************************************************* ...
g--LSDGEWQQVLNVWGKVEADIAGHGQEVLIRLFTGHPETLEKFDKFKHLKTEAEMKASE ...
PP 8..89******************************************************** ...
g--LSDGEWQLVLNVWGKVEGDLSGHGQEVLIRLFKGHPETLEKFDKFKHLKAEDEMRASE ...
PP 8..89******************************************************** ...
g--LSDGEWQLVLNIWGKVEADIPSHGQEVLISLFKGHPETLEKFDKFKHLKSEDEMKASE ...
PP 8..89******************************************************** ...
g--LSDGEWQIVLNIWGKVETDLAGHGQEVLIRLFKNHPETLDKFDKFKHLKTEDEMKGSE ...
PP 8..89******************************************************** ...
g--LSDGEWQLVLNVWGKVEADLAGHGQEVLIGLFKTHPETLDKFDKFKNLKSEEDMKGSE ...

The #=GC PP_cons line is Stockholm-format consensus posterior proba-
bility annotation for the entire column. It’s the arithmetic mean of the
per-residue posterior probabilities in that column. This should prove
useful in phylogenetic inference applications, for example, where it’s
common to mask away nonconﬁdently aligned columns of a multi-
ple alignment. The PP_cons line provides an objective measure of the
conﬁdence assigned to each column.

The #=GC RF line is Stockholm-format reference coordinate annotation,

with an x marking each column that the proﬁle considered to be
consensus.

Searching DNA sequences

HMMER was originally developed for protein sequence analysis.
The hmmsearch and hmmscan programs assume that it’s sensible to ask if
the entire target sequence is homologous (or not) to a query proﬁle.
It makes sense to say “this sequence is a probable protein kinase”
because we ﬁnd a protein kinase domain in it. What if you want to
use a DNA proﬁle to search a very long (chromosome-sized) piece
of DNA for homologous regions? We might want to identify Alu
and L1 elements in human chromosome sequences, for example.
It’s not super useful to see the 24 chromosomes ranked by E-values
in hmmsearch output – we’re only interested in the element locations.
Also, if we can avoid having to align the entire target chromosome
sequence at once, we can scan the proﬁle along the target sequence in
a much more memory-efﬁcient manner than hmmsearch/hmmscan would
do.

The nhmmer and nhmmscan programs are designed for memory-efﬁcient

DNA proﬁle searches of long DNA sequences. They were developed
in concert with the Dfam database (dfam.org), which provides align-
ments and proﬁles of DNA repeat elements for several important
genomes. The alignment tutorial/MADE1.sto is a representative align-
ment of 100 human MADE1 transposable elements, a subset of the

52

sean r. eddy

Dfam MADE1 alignment. We’ll use the MADE1 alignment to show
how nhmmer/nhmmscan work; these are similar to hmmsearch/hmmscan.

Step 1: build a proﬁle with hmmbuild

hmmbuild works for both protein and DNA proﬁles, so:

% hmmbuild MADE1.hmm MADE1.sto

and you’ll see some output that looks like:

# hmmbuild :: profile HMM construction from multiple sequence alignments
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# input alignment file:
# output HMM file:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

MADE1.sto
MADE1.hmm

W eff_nseq re/pos description
# idx name
#---- -------------------- ----- ----- ----- ----- -------- ------ -----------
1

MADE1

nseq

alen

mlen

278

100

304

80

4.23 0.708 MADE1 (MAriner Derived Element 1), a TcMar-Mariner ...

# CPU time: 0.02u 0.00s 00:00:00.02 Elapsed: 00:00:00.02

Notice the new output column with the header “W”, which is only
present when the input sequence alignment is DNA/RNA. This rep-
resents an upper bound on the length at which nhmmer expects to
ﬁnd an instance of the family. It is always larger than mlen, though
the ratio of mlen to W depends on the observed insert rate in the
seed alignment. This length is used deep in the acceleration pipeline,
and modest changes are not expected to impact results, but larger
values of W do lead to longer run time. The value can be overridden
with the --w_length or --w_beta ﬂags, at the risk of possibly missing
instances of the family that happen to be longer than W due to plen-
tiful insertions.

Step 2: search the DNA sequence database with nhmmer

We’ll use dna_target.fa as the target sequence database. It is a FASTA
format ﬁle containing one 330Kb long DNA sequence extracted from
human chromosome 1.

nhmmer accepts a target DNA sequence database in the same formats

as hmmsearch (typically FASTA). It accepts a query ﬁle of one or
more nucleotide queries; each query may be either a proﬁle model
built using hmmbuild, a sequence alignment, or a single sequence.

If a sequence or alignment is used as query input, nhmmer internally
produces the proﬁle for that alignment, then searches with that pro-
ﬁle. The proﬁle produced in this way can be written to a ﬁle speciﬁed
by the --hmmout ﬂag.

To search dna_target.fa with our MADE1.hmm proﬁle:

% nhmmer MADE1.hmm dna_target.fa

W is based on position-speciﬁc insert
rates: only 10−7 of all sequences gener-
ated from the proﬁle are expected to be
longer than W.

Using default hmmbuild parameters; if
you want more control, explicitly built
the proﬁle with hmmbuild.

hmmer user’s guide

53

This output is largely similar to that of hmmsearch. The key dif-
ference is that each hit is not to a full sequence in the target database,
but one local alignment of the proﬁle to a subsequence of a target
database sequence.

The ﬁrst section is the header that tells you what program you ran,

on what, and with what options, as above.

The second section is the top hits list. It is a list of ranked top hits
(sorted by E-value, most signiﬁcant hit ﬁrst), formatted much like the
hmmsearch output top hits list:

score

E-value
bias
------- ------ -----
7.2
6.8e-11
6.8
1.2e-08
8.2
4.1e-08
7.0
4e-06

39.9
32.8
31.0
24.7

start
end Description
----- ----- -----------

Sequence
--------
humanchr1_frag 302390 302466
humanchr1_frag 302466 302389
humanchr1_frag 174456 174498
humanchr1_frag 174493 174456

------ inclusion threshold ------

0.84

7.6

7.5

humanchr1_frag 304073 304104

For each hit, the table shows its E-value, bit score, bias, target se-

quence name and target sequence description, much like hmmsearch.

The “start” and “end” columns are the coordinates in the target

sequence where the hit is found. When the “end” is smaller than
“start”, this means the hit found on the reverse complement of the
target database sequence.

For example, note that the top hits here are coming in overlapping

pairs, corresponding to the forward and reverse strands, like the hit
to 302390..302466 on the forward strand and a hit to 302466..302389
on the reverse strand. This is because the MADE1 DNA element is a
near-perfect palindrome.

Then comes the third output section, which starts with

Annotation for each hit

(and alignments):

For each hit in the top hits list, there is a tabular line providing de-

tailed information about the hit, followed by the alignment inferred
for the hit. The ﬁrst MADE1 hit looks like:

nhmmer automatically searches both
strands.

DNA elements that have a unique ori-
entation will only hit on one strand.
nhmmer treats the two strands indepen-
dently. Palindromic elements will hit
the same region on both strands and
nhmmer will not ﬁlter the overlapping
hits.

>> humanchr1_frag
score bias

Evalue
------ ----- ---------
6.8e-11
7.2

39.9

!

hmmfrom
-------
4

hmm to
-------

alifrom

ali to

envfrom

env to

--------- ---------

--------- ---------

80 .]

302390

302466 ..

302387

302466 ..

sq len
---------
330000

acc
----
0.89

All these pieces of information are as described for hmmsearch, plus

a column for “sq len” that indicates the full length of the target se-
quence.

Under each one-line hit table is displayed the alignment inferred

between the proﬁle and the hit envelope. For example, the top hit
from above is shown as:

Alignment:
score: 39.9 bits

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx RF

54

sean r. eddy

MADE1

4 ggttggtgcaaaagtaattgcggtttttgccattacttttaatggc....aaaaaccgcaattacttttgcaccaacctaa 80

humanchr1_frag 302390 GGTCGGTGCAAAATCAATTGTGGTTTTTGCCATTGCTTTTAATTGCttttAAAA---GTAA-TGCTTTTACACCAATCTAA 302466

ggt ggtgcaaaa

aattg ggtttttgccatt cttttaat gc

aaaa

g aa t ctttt caccaa ctaa

89*******************************************966655555...4555.68**************997 PP

The alignment format is the same as for hmmsearch.
At the end of the output, you’ll see summary statistics:

Internal pipeline statistics summary:
-------------------------------------
Query model(s):
Target sequences:
Residues passing SSV filter:
Residues passing bias filter:
Residues passing Vit filter:
Residues passing Fwd filter:
Total number of hits:
5 (0.000406)
# CPU time: 0.02u 0.00s 00:00:00.02 Elapsed: 00:00:00.01
# Mc/sec: 3004.03
//
[ok]

1 (80 nodes)
1 (660000 residues searched)

73493 (0.111); expected (0.02)
49311 (0.0747); expected (0.02)

4022 (0.00609); expected (0.003)
1562 (0.00237); expected (3e-05)

This gives you some idea of what’s going on in nhmmer’s accel-
eration pipeline. You’ve got one query proﬁle, and 660000 residues
were searched (there are 330000 bases in the single sequence found
in the ﬁle; the search includes the reverse complement, doubling the
search space). The sequences in the database go through a gauntlet of
three scoring algorithms called SSV, Viterbi, and Forward, in order of
increasing sensitivity and increasing computational requirement.

SSV (the “Single ungapped Segment Viterbi” algorithm) as used in

nhmmer is closely related to the MSV algorithm used in hmmsearch, in
that it depends on ungapped alignment segments. The difference lies
in how those alignments are used. Using MSV, a sequence is either
rejected or accepted in its entirety. In the scanning-SSV ﬁlter of nhmmer,
each sequence in the database is scanned for high-scoring ungapped
alignment segments, and a window around each such segment is
extracted (merging overlapping windows), and passed on to the next
stage. By default, nhmmer is conﬁgured to allow sequence segments
Here, 73493
with a P-value of ≤ 0.02 through the SSV score ﬁlter.
bases, or about 11.1% of the database, got through the SSV ﬁlter.

19

The “bias ﬁlter” is then applied, as in hmmsearch. Here, 49311 bases,

roughly 7.5% of the database pass through the bias ﬁlter.

The Viterbi ﬁlter then calculates a gapped optimal alignment score

for each window that survived the earlier stages. This score is a
closer approximation than the SSV score of the ﬁnal score that the
window will achieve if it survives to ﬁnal processing, but the Viterbi
ﬁlter is about four-fold slower than SSV. By default, nhmmer lets
windows with a P-value of ≤ 0.001 through this stage. Here, 4022
bases, about 0.6% of the database gets through.

Then the full Forward score is calculated, which sums over all
possible alignments of the proﬁle to the window. The default allows
windows with a P-value of ≤ 10−5 through; 1562 bases passed.

19 Thus, if the database contained no
homologs and P-values were accurately
calculated, the highest scoring 2% of the
sequence will pass the ﬁlter.

hmmer user’s guide

55

All windows that make it through these ﬁlters are then subjected

to a full probabilistic analysis using the HMM Forward/Backward
algorithms, to identify hit envelopes, then determine posterior proba-
bilities for each aligned residue, followed by optimal accuracy align-
ment. The results of this step are what you ﬁnally see on the output.
The ﬁnal number of hits and fractional coverage of the database is
shown next. This is typically smaller than the fraction of the database
passing the Forward ﬁlter, as hit identiﬁcation typically trims win-
dows down to a smaller envelope.

Finally, nhmmer reports the speed of the search in units of Mc/sec
(million dynamic programming cells per second), the CPU time, and
the elapsed time.

nhmmscan is to hmmscan as nhmmer is to hmmsearch. There is not currently a

iterative DNA search analog to jackhmmer.

The HMMER proﬁle/sequence comparison pipeline

Code gurus, masochists: you can follow
along in src/p7_pipeline.c.

Now I’ll brieﬂy outline the processing pipeline for a single pro-
ﬁle/sequence comparison. This should help give you a sense of what
HMMER is doing under the hood, what sort of mistakes it may make
(rarely, of course!), and what the various results in the output ac-
tually mean. I’ll ﬁrst describe the pipeline in the context of protein
search (phmmer, hmmsearch, hmmscan, jackhmmer), then wrap back around to
discuss the modiﬁed pipeline used in nhmmer and nhmmscan.

In briefest outline, the comparison pipeline takes the following

steps:

Null model. Calculate a score term for the “null hypothesis” (a prob-
ability model of non-homology). This score correction is used to
turn all subsequent proﬁle/sequence bit scores into a ﬁnal log-
odds bit score.

MSV ﬁlter. The main acceleration heuristic. The MSV (“Multiple

Segment Viterbi”) algorithm looks for one or more high-scoring
ungapped alignments. If the MSV score passes a set threshold,
the entire sequence passes on to the next pipeline step; else it is
rejected.

Bias ﬁlter. A hack that reduces false positive MSV hits due to biased
composition sequences. A two-state HMM is constructed from the
mean residue composition of the proﬁle and the standard residue
composition of the null model, and used to score the sequence.
The MSV bit score is corrected using this as a second null hypoth-
esis. If the MSV score still passes the MSV threshold, the sequence
passes on to the next step; else it is rejected. The bias ﬁlter score
correction will also be applied to the Viterbi ﬁlter and Forward
ﬁlter scores that follow.

Viterbi ﬁlter. A more stringent accelerated ﬁlter. An optimal (max-
imum likelihood) gapped alignment score is calculated. If this
score passes a set threshold, the sequence passes to the next step;
else it is rejected.

58

sean r. eddy

Forward ﬁlter/parser. The full likelihood of the proﬁle/sequence
comparison is evaluated, summed over the entire alignment en-
semble, using the HMM Forward algorithm. This score is cor-
rected to a bit score using the null model and bias ﬁlter scores. If
the bit score passes a set threshold, the sequence passes on to the
next step; else it is rejected.

Domain identiﬁcation. Using the Forward parser results, now com-
bined with a Backward parser, posterior probabilities of domain
locations are calculated. A discrete set of putative domains (align-
ments) is identiﬁed by applying heuristics to posterior probabili-
ties. This procedure identiﬁes envelopes: subsequences on the target
sequence which contain a lot of probability mass for a match to the
proﬁle.

Alignment. For each identiﬁed domain, a full Forward/Backward al-
gorithm is performed. An ad hoc “null2” hypothesis is constructed
for each domain’s composition and used to calculate a biased com-
position score correction. A maximum expected accuracy (MEA)
alignment is calculated. This identiﬁes one MEA alignment within
each envelope.

Storage. Now we have a sequence score (and P-value); the sequence
contains one or more domains, each of which has a domain score
(and P-value), and each domain has an MEA alignment annotated
with per-residue posterior probabilities.

In more detail, each step is described below.

Null model

The “null model” calculates the probability that the target sequence
is not homologous to the query proﬁle. A HMMER bit score is the
log of the ratio of the sequence’s probability according to the proﬁle
(the homology hypothesis) over the null model probability (the non-
homology hypothesis).

The null model is a one-state HMM conﬁgured to generate “ran-
dom” sequences of the same mean length L as the target sequence,
with each residue drawn from a background frequency distribution
(a standard i.i.d. model: residues are treated as independent and
identically distributed). Currently, this background frequency distri-
bution is hardcoded as the mean residue frequencies in Swiss-Prot
50.8 (October 2006).

For technical reasons, HMMER incorporates the residue emission
probabilities of the null model directly into the proﬁle, by turning
each emission probability in the proﬁle into an odds ratio. The null

hmmer user’s guide

59

1 S. R. Eddy. A probabilistic model of
local sequence alignment that simpliﬁes
statistical signiﬁcance estimation. PLOS
Comput. Biol., 4:e1000069, 2008

model score calculation therefore is only concerned with accounting
for the remaining transition probabilities of the null model and toting
them up into a bit score correction. The null model calculation is fast,
because it only depends on the length of the target sequence, not its
sequence.

MSV ﬁlter

The sequence is aligned to the proﬁle using a specialized model that
allows multiple high-scoring local ungapped segments to match. The
optimal alignment score (Viterbi score) is calculated under this mul-
tisegment model, hence the term MSV, for “multi-segment Viterbi”.
This is HMMER’s main speed heuristic.

The MSV score is comparable to BLAST’s sum score (optimal
sum of ungapped alignment segments). Roughly speaking, MSV is
comparable to skipping the heuristic word hit and hit extension steps
of the BLAST acceleration algorithm.

The MSV ﬁlter is very, very fast. In addition to avoiding indel
calculations in the dynamic programming table, it uses reduced
precision scores scaled to 8-bit integers, enabling acceleration via
16-way parallel SIMD vector instructions.

The MSV score is a true log-odds likelihood ratio, so it obeys con-
jectures about the expected score distribution
that allow immediate
and accurate calculation of the statistical signiﬁcance (P-value) of the
MSV bit score.

1

By default, comparisons with a P-value of ≤ 0.02 pass this ﬁlter,
meaning that about 2% of nonhomologous sequences are expected
to pass. You can use the --F1 <x> option to change this threshold.
For example, --F1 0.05 would pass 5% of the comparisons, making
a search more sensitive but slower. Setting the threshold to ≥ 1.0
(--F1 99 for example) assures that all comparisons will pass. Shutting
off the MSV ﬁlter may be worthwhile if you want to make sure you
don’t miss comparisons that have a lot of scattered insertions and
deletions. Alternatively, the --max option causes the MSV ﬁlter step
(and all other ﬁlter steps) to be bypassed.

The MSV bit score is calculated as a log-odds score using the null

model for comparison. No correction for a biased composition or
repetitive sequence is done at this stage. For comparisons involving
biased sequences and/or proﬁles, more than 2% of comparisons will
pass the MSV ﬁlter. At the end of search output, there is a line like:

Passed MSV filter:

107917 (0.020272); expected 106468.8 (0.02)

which tells you how many and what fraction of comparisons
passed the MSV ﬁlter, versus how many (and what fraction) were

60

sean r. eddy

expected.

Biased composition ﬁlter

It’s possible for proﬁles and/or sequences to have biased residue
compositions that result in “signiﬁcant” log-odds bit scores not
because the sequence matches the proﬁle well, but because the se-
quence matches the null model badly.

HMMER uses fairly good methods to compensate its scores for bi-
ased composition, but these methods are computationally expensive
and applied late in the pipeline (described below).

In a few cases, proﬁles and/or target sequences are sufﬁciently

biased that too many comparisons pass the MSV ﬁlter, causing
HMMER speed performance to be severely degraded. Although
the ﬁnal scores and E-values at the end of the pipeline will be cal-
culated taking into account a “null2” model of biased composition
and simple repetition, the null2 model is dependent on a full align-
ment ensemble calculation via the Forward/Backward algorithm,
making it computationally complex, so it won’t get calculated un-
til the very end. The treatment of biased composition comparisons
is an inadequately solved problem in HMMER. As a stopgap solu-
tion to rescuing most of the speed degradation while not sacriﬁcing
too much sensitivity, an ad hoc biased composition ﬁltering step is
applied to remove highly biased comparisons.

2

On the ﬂy, a two-state HMM is constructed. One state emits
residues from the background frequency distribution (same as the
null1 model), and the other state emits residues from the mean
residue composition of the proﬁle (i.e. the expected composition of
sequences generated by the core model, including match and insert
states.)
Thus if the proﬁle is highly biased (cysteine-rich, for exam-
ple; or highly hydrophobic with many transmembrane segments),
this composition bias will be captured by this second state. This
model’s transitions are arbitrarily set such that state 1 emits an ex-
pected length of 400 at a time, and state 2 emits an expected length of
M/8 at a time (for a proﬁle of length M). An overall target sequence
length distribution is set to a mean of L, identical to the null1 model.
The sequence is then rescored using this “bias ﬁlter model” in
place of the null1 model, using the HMM Forward algorithm. (This
replaces the null1 model score at all subsequent ﬁlter steps in the
pipeline, until a ﬁnal Forward score is calculated.) A new MSV bit
score is obtained.

If the P-value of this still satisﬁes the MSV thresholds, the se-

quence passes the biased composition ﬁlter.

The --F1 <x> option controls the P-value threshold for passing the

2

p7_hmm.c:p7_hmm_SetComposition()

hmmer user’s guide

61

MSV ﬁlter score, both before (with the simple null1 model) and after
the bias composition ﬁlter is applied.

The --max option bypasses all ﬁlters in the pipeline, including the

bias ﬁlter.

The --nobias option turns off (bypasses) the biased composition
ﬁlter. The simple null model is used as a null hypothesis for MSV
and in subsequent ﬁlter steps. The biased composition ﬁlter step
compromises a small amount of sensitivity. Though it is good to have
it on by default, you may want to shut it off if you know you will
have no problem with biased composition hits.

At the end of a search output, you will see a line like:

Passed bias filter:

105665

(0.019849); expected 106468.8 (0.02)

which tells you how many and what fraction of comparisons
passed the biased composition ﬁlter, versus how many were ex-
pected. (If the ﬁlter was turned off, all comparisons pass.)

Viterbi ﬁlter

The sequence is now aligned to the proﬁle using a fast Viterbi algo-
rithm for optimal gapped alignment.

This Viterbi implementation is specialized for speed. It is imple-
mented in 8-way parallel SIMD vector instructions, using reduced
precision scores that have been scaled to 16-bit integers. Only one
row of the dynamic programming matrix is stored, so the routine
only recovers the score, not the optimal alignment itself. The reduced
representation has limited range; local alignment scores will not
underﬂow, but high scoring comparisons can overﬂow and return
inﬁnity, in which case they automatically pass the ﬁlter.

The ﬁnal Viterbi ﬁlter bit score is then computed using the appro-

priate null model log likelihood (by default the biased composition
ﬁlter model score, or if the biased ﬁlter is off, just the null model
score). If the P-value of this score passes the Viterbi ﬁlter threshold,
the sequence passes on to the next step of the pipeline.

The --F2 <x> option controls the P-value threshold for passing the
Viterbi ﬁlter score. The default is 0.001. The --max option bypasses all
ﬁlters in the pipeline.

At the end of a search output, you will see a line like:

Passed Vit filter:

2207 (0.00443803); expected 497.3 (0.001)

which tells you how many and what fraction of comparisons

passed the Viterbi ﬁlter, versus how many were expected.

62

sean r. eddy

Forward ﬁlter/parser

The sequence is now aligned to the proﬁle using the full Forward al-
gorithm, which calculates the likelihood of the target sequence given
the proﬁle, summed over the ensemble of all possible alignments.

This is a specialized time- and memory-efﬁcient Forward imple-
mentation called the “Forward parser”. It is implemented in 4-way
parallel SIMD vector instructions, in full precision (32-bit ﬂoating
point). It stores just enough information that, in combination with
the results of the Backward parser (below), posterior probabilities of
start and stop points of alignments (domains) can be calculated in
the domain deﬁnition step (below), although the detailed alignments
themselves cannot be.

The Forward ﬁlter bit score is calculated by correcting this score
using the appropriate null model log likelihood (by default the bi-
ased composition ﬁlter model score, or if the biased ﬁlter is off, just
the null model score). If the P-value of this bit score passes the For-
ward ﬁlter threshold, the sequence passes on to the next step of the
pipeline.

The bias ﬁlter score has no further effect in the pipeline. It is only
used in ﬁlter stages. It has no effect on ﬁnal reported bit scores or P-
values. Biased composition compensation for ﬁnal bit scores is done
by a more complex domain-speciﬁc algorithm, described below.

The --F3 <x> option controls the P-value threshold for passing the
Forward ﬁlter score. The default is 1e-5. The --max option bypasses all
ﬁlters in the pipeline.

At the end of a search output, you will see a line like:

Passed Fwd filter:

1076 (0.00216371); expected 5.0 (1e-05)

which tells you how many and what fraction of comparisons

passed the Forward ﬁlter, versus how many were expected.

Domain deﬁnition

A target sequence that reaches this point is very likely to contain one
or more signiﬁcant matches to the proﬁle. These matches are referred
to as “domains”, since the main use of HMMER has historically
been to match proﬁle HMMs from protein domain databases like
Pfam, and one of HMMER’s strengths is to be able to cleanly parse a
multidomain target sequence into its multiple nonoverlapping hits to
the same domain model.

The domain deﬁnition step is essentially its own pipeline, with

steps as follows:

3

3

src/p7_domaindef.c

hmmer user’s guide

63

Backward parser The counterpart of the Forward parser algorithm
is calculated in an analogous time- and memory-efﬁcient implemen-
tation. The Forward algorithm gives the likelihood of all preﬁxes of
the target sequence, summed over their alignment ensemble, and the
Backward algorithm gives the likelihood of all sufﬁxes. For any given
point of a possible model state/residue alignment, the product of the
Forward and Backward likelihoods gives the likelihood of the entire
alignment ensemble conditional on using that particular alignment
point. Thus, we can calculate things like the posterior probability that
an alignment starts or ends at a given position in the target sequence.

Domain decoding. The posterior decoding algorithm is applied, to
calculate the posterior probability of alignment starts and ends (pro-
ﬁle B and E state alignments) with respect to target sequence posi-
tion.

The sum of the posterior probabilities of alignment starts (B states)
over the entire target sequence is the expected number of domains in the
sequence.

In a tabular output (--tblout) ﬁle, this number is in the column

labeled exp.

Region identiﬁcation. A heuristic is now applied to identify a non-
overlapping set of “regions” that contain signiﬁcant probability mass
suggesting the presence of a match (alignment) to the proﬁle.

For each region, the expected number of domains is calculated
(again by posterior decoding on the Forward/Backward parser re-
sults). This number should be about 1: we expect each region to
contain one local alignment to the proﬁle.

In a tabular output (--tblout) ﬁle, the number of discrete regions
identiﬁed by this posterior decoding step is in the column labeled reg.
It ought to be almost the same as the expectation exp. If it is not, there
may be something funny going on, like a tandem repetitive element
in the target sequence (which can produce so many overlapping
weak hits that the sequence appears to be a signiﬁcant hit with lots
of domains expected somewhere, but the probability is fuzzed out over
the repetitive region and few or no good discrete alignment regions
can be identiﬁed).

Envelope identiﬁcation. Now, within each region, we will attempt to
identify envelopes. An envelope is a subsequence of the target sequence
that appears to contain alignment probability mass for a likely do-
main (one local alignment to the proﬁle).

When the region contains (cid:39)1 expected domain, envelope identi-
ﬁcation is already done: the region’s start and end points are con-

64

sean r. eddy

verted directly to the envelope coordinates of a putative domain.

There are a few cases where the region appears to contain more
than one expected domain -- where more than one domain is closely
spaced on the target sequence and/or the domain scores are weak
and the probability masses are ill-resolved from each other. These
“multidomain regions”, when they occur, are passed off to an even
more ad hoc resolution algorithm called stochastic traceback clustering.
In stochastic traceback clustering, we sample many alignments from
the posterior alignment ensemble, cluster those alignments according
to their overlap in start/end coordinates, and pick clusters that sum
up to sufﬁciently high probability. Consensus start and end points
are chosen for each cluster of sampled alignments. These start/end
points deﬁne envelopes.

These envelopes identiﬁed by stochastic traceback clustering are
not guaranteed to be nonoverlapping. It’s possible that there are alter-
native “solutions” for parsing the sequence into domains, when the
correct parsing is ambiguous. HMMER will report all high-likelihood
solutions, not just a single nonoverlapping parse.

In a tabular output (--tblout) ﬁle, the number of regions that had to

be subjected to stochastic traceback clustering is given in the column
labeled clu. This ought to be a small number (often it’s zero). The
number of envelopes identiﬁed by stochastic traceback clustering
that overlap with other envelopes is in the column labeled ov. If this
number is non-zero, you need to be careful when you interpret the
details of alignments in the output, because HMMER is going to
be showing overlapping alternative solutions. The total number of
domain envelopes identiﬁed (either by the simple method or by
stochastic traceback clustering) is in the column labeled env. It ought
to be almost the same as the expectation and the number of regions.

Maximum expected accuracy alignment. Each envelope is now aligned
to the proﬁle using the full Forward/Backward algorithm. The pro-
ﬁle is conﬁgured to “unihit” mode, so that the proﬁle expects only
one local alignment (domain) in the envelope (as opposed to multi-
ple domains). Posterior decoding is used to calculate the posterior
probability of every detailed alignment of proﬁle state to sequence
residue. The posterior decodings are used to extract a “maximum
expected accuracy” alignment. Each aligned residue is annotated
with its posterior probability in the Forward/Backward alignment
ensemble.

Currently, the Forward, Backward, and posterior decoding calcu-
lations at this step are not memory efﬁcient. They calculate matrices
requiring roughly 36ML bytes, where M is the proﬁle length and L
is the length of the envelope subsequence. Usually in hmmsearch and

It’s also possible (though rare) for
stochastic clustering to identify no
envelopes in the region.

hmmer user’s guide

65

4 I know how to ﬁx this with memory-
efﬁcient algorithms, and I’m working
on it.

hmmscan, proﬁles and envelopes are small enough that this is not a
problem. For example, a typical Pfam domain model is about 200
residues long, matching to individual target envelopes of about 200
residues each; this requires about 1.4 MB of memory in MEA align-
ment. However, in phmmer and jackhmmer programs, it’s often going to
be the case that you’re aligning an entire query sequence to an en-
tire target sequence in a single unresolved “domain” alignment. If
this is titin (about 40,000 residues), it would require 57.6 GB of RAM.
For this reason, currently, phmmer and jackhmmer can only handle query
sequences of up to a few thousand residues. If you see a “fatal excep-
tion” error complaining about failure of a large memory allocation,
you’re almost certainly seeing a prohibitive memory requirement at
this stage.

4

In a tabular output (--tblout) ﬁle, the number of domains in en-

velopes (before any signiﬁcance thresholding) is in the column
labeled dom. This will generally be the same as the number of en-
velopes.

Biased composition score correction (“null2”) An ad hoc biased com-
position score correction is calculated for each envelope, using the
posterior decoding. A corrected bit score and P-value for each enve-
lope is calculated. These null2-corrected scores are subjected to the
reporting and inclusion thresholds, at both the full sequence level
and per-domain.

Modiﬁcations to the pipeline as used for DNA search

SSV, not MSV.

In the MSV ﬁlter, one or more high-scoring ungapped segments con-
tribute to a score that, if sufﬁciently high, causes the entire sequence
to be passed on to the next stage (the bias ﬁlter). This strategy won’t
work for long DNA sequences; it doesn’t ﬁlter the human genome
much to say “there’s a hit on chromosome 1, now postprocess the
whole thing”. In the scanning-SSV (“Single ungapped Segment
Viterbi”) algorithm used in nhmmer and nhmmscan, each comparison
between a query and target is scanned for high-scoring ungapped
alignment segments, and a window around each such segment is ex-
tracted, merging overlapping windows. Each window is then passed
on to the remaining ﬁlter cascade, where it is treated as described
above for the most part. As with the MSV ﬁlter, the default P-value
threshold is 0.02, and can be controlled with the --F1 ﬂag.

The --max ﬂag also controls the amount of the sequence database
that passes the SSV ﬁlter, but instead of the threshold being set to 1.0,

66

sean r. eddy

as described for the protein pipeline, it is set to 0.4.

There are no domains, but there are envelopes

In HMMER’s protein-search programs, multiple matches of the
model to a target sequence are treated as domains contained within
a single hit for that sequence. In the DNA-search programs, each
match of the model to a subsequence is treated as an independent hit
- there’s no notion of a domain. This is largely a difference in report-
ing. Both pipelines rely on essentially the same envelope detection
code; envelopes lead to domains in protein search, and hits in DNA
search.

Biased composition.

DNA sequence is littered with regions containing tandem simple
repeats or other low complexity sequence. Without accounting for
such composition bias, we see many cases in which one part of a
hit is obviously legitimate, and serves as the anchor for a neighbor-
ing alignment segment that is clearly low-complexity garbage, one
. The null2
form of a problem known as homologous overextension.
method used in protein search delays score modiﬁcation until after
the alignment is complete, but we know that this kind of overexten-
sion can be (mostly) avoided if the model’s log odds scores account
for the composition bias of the target region while constructing the
alignment. The DNA search pipeline therefore does just this: it mod-
iﬁes the scoring scheme for each target envelope as a function of that
envelope’s sequence composition, then builds the alignment accord-
ing to that scheme.

5

5 M. W. Gonzalez and W. R Pearson.
Homologous over-extension: a chal-
lenge for iterative similarity searches.
Nucl. Acids Res., 38:2177–2189, 2010

Tabular output formats

The target hits table

The --tblout output option produces the target hits table. The target
hits table consists of one line for each different query/target compari-
son that met the reporting thresholds, ranked by decreasing statistical
signiﬁcance (increasing E-value).

tblout ﬁelds for protein search programs
grams, each line consists of 18 space-delimited ﬁelds followed by a
free text target sequence description, as follows:

In the protein search pro-

(1) target name: The name of the target sequence or proﬁle.

(2) accession: The accession of the target sequence or proﬁle, or ’-’ if

none.

(3) query name: The name of the query sequence or proﬁle.

(4) accession: The accession of the query sequence or proﬁle, or ’-’ if

none.

(5) E-value (full sequence): The expectation value (statistical signif-
icance) of the target. This is a per query E-value; i.e. calculated as
the expected number of false positives achieving this compari-
son’s score for a single query against the Z sequences in the target
dataset. If you search with multiple queries and if you want to
control the overall false positive rate of that search rather than the
false positive rate per query, you will want to multiply this per-
query E-value by how many queries you’re doing.

(6) score (full sequence): The score (in bits) for this target/query
comparison. It includes the biased-composition correction (the
“null2” model).

(7) Bias (full sequence): The biased-composition correction: the bit
score difference contributed by the null2 model. High bias scores
may be a red ﬂag for a false positive, especially when the bias

The tblout format is deliberately space-
delimited (rather than tab-delimited)
and justiﬁed into aligned columns,
so these ﬁles are suitable both for
automated parsing and for human
examination. I feel that tab-delimited
data ﬁles are difﬁcult for humans
to examine and spot check. For this
reason, I think tab-delimited ﬁles are
a minor evil in the world. Although I
occasionally receive shrieks of outrage
about this, I still stubbornly feel that
space-delimited ﬁles are just as easily
parsed as tab-delimited ﬁles.

68

sean r. eddy

score is as large or larger than the overall bit score. It is difﬁcult
to correct for all possible ways in which a nonrandom but non-
homologous biological sequences can appear to be similar, such
as short-period tandem repeats, so there are cases where the bias
correction is not strong enough (creating false positives).

(8) E-value (best 1 domain): The E-value if only the single best-scoring
domain envelope were found in the sequence, and none of the
others. If this E-value isn’t good, but the full sequence E-value
is good, this is a potential red ﬂag. Weak hits, none of which are
good enough on their own, are summing up to lift the sequence
up to a high score. Whether this is Good or Bad is not clear; the
sequence may contain several weak homologous domains, or it
might contain a repetitive sequence that is hitting by chance (i.e.
once one repeat hits, all the repeats hit).

(9) score (best 1 domain): The bit score if only the single best-scoring
domain envelope were found in the sequence, and none of the
others. (Inclusive of the null2 bias correction.]

(10) bias (best 1 domain): The null2 bias correction that was applied to

the bit score of the single best-scoring domain.

(11) exp: Expected number of domains, as calculated by posterior de-
coding on the mean number of begin states used in the alignment
ensemble.

(12) reg: Number of discrete regions deﬁned, as calculated by heuris-
tics applied to posterior decoding of begin/end state positions
in the alignment ensemble. The number of regions will generally
be close to the expected number of domains. The more different
the two numbers are, the less discrete the regions appear to be, in
terms of probability mass. This usually means one of two things.
On the one hand, weak homologous domains may be difﬁcult for
the heuristics to identify clearly. On the other hand, repetitive se-
quence may appear to have a high expected domain number (from
lots of crappy possible alignments in the ensemble, no one of
which is very convincing on its own, so no one region is discretely
well-deﬁned).

(13) clu: Number of regions that appeared to be multidomain, and

therefore were passed to stochastic traceback clustering for further
resolution down to one or more envelopes. This number is often
zero.

(14) ov: For envelopes that were deﬁned by stochastic traceback

clustering, how many of them overlap other envelopes.

hmmer user’s guide

69

(15) env: The total number of envelopes deﬁned, both by single en-
velope regions and by stochastic traceback clustering into one or
more envelopes per region.

(16) dom: Number of domains deﬁned. In general, this is the same
as the number of envelopes: for each envelope, we ﬁnd an MEA
(maximum expected accuracy) alignment, which deﬁnes the end-
points of the alignable domain.

(17) rep: Number of domains satisfying reporting thresholds. If

you’ve also saved a --domtblout ﬁle, there will be one line in it for
each reported domain.

(18) inc: Number of domains satisfying inclusion thresholds.

(19) description of target: The remainder of the line is the target’s

description line, as free text.

tblout ﬁelds for DNA search programs
In the DNA search programs,
there is less concentration on domains, and more focus on present-
ing the hit ranges. Each line consists of 15 space-delimited ﬁelds
followed by a free text target sequence description, as follows:

(1) target name: The name of the target sequence or proﬁle.

(2) accession: The accession of the target sequence or proﬁle, or ’-’ if

none.

(3) query name: The name of the query sequence or proﬁle.

(4) accession: The accession of the query sequence or proﬁle, or ’-’ if

none.

(5) hmmfrom: The position in the hmm at which the hit starts.

(6) hmm to: The position in the hmm at which the hit ends.

(7) alifrom: The position in the target sequence at which the hit

starts.

(8) ali to: The position in the target sequence at which the hit ends.

(9) envfrom: The position in the target sequence at which the sur-

rounding envelope starts.

(10) env to: The position in the target sequence at which the sur-

rounding envelope ends.

(11) sq len: The length of the target sequence..

70

sean r. eddy

(12) strand: The strand on which the hit was found (“-" when al-

ifrom>ali to).

(13) E-value: The expectation value (statistical signiﬁcance) of the

target, as above.

(14) score (full sequence): The score (in bits) for this hit. It includes

the biased-composition correction.

(15) Bias (full sequence): The biased-composition correction, as above

(16) description of target: The remainder of the line is the target’s

description line, as free text.

These tables are columnated neatly for human readability, but
do not write parsers that rely on this columnation; rely on space-
delimited ﬁelds. The pretty columnation assumes ﬁxed maximum
widths for each ﬁeld. If a ﬁeld exceeds its allotted width, it will still
be fully represented and space-delimited, but the columnation will be
disrupted on the rest of the row.

Note the use of target and query columns. A program like hmmsearch

searches a query proﬁle against a target sequence database. In an
hmmsearch tblout ﬁle, the sequence (target) name is ﬁrst, and the pro-
ﬁle (query) name is second. A program like hmmscan, on the other
hand, searches a query sequence against a target proﬁle database. In
a hmmscan tblout ﬁle, the proﬁle name is ﬁrst, and the sequence name
is second. You might say, hey, wouldn’t it be more consistent to put
the proﬁle name ﬁrst and the sequence name second (or vice versa),
so hmmsearch and hmmscan tblout ﬁles were identical? Well, ﬁrst of all,
they still wouldn’t be identical, because the target database size used
for E-value calculations is different (number of target sequences for
hmmsearch, number of target proﬁles for hmmscan, and it’s good not to
forget this. Second, what about programs like phmmer where the query
is a sequence and the targets are also sequences?

If the “domain number estimation” section of the protein table
(exp, reg, clu, ov, env, dom, rep, inc) makes no sense to you, it may
help to read the previous section of the manual, which describes the
HMMER processing pipeline, including the steps that probabilisti-
cally deﬁne domain locations in a sequence.

The domain hits table (protein search only)

In protein search programs, the --domtblout option produces the do-
main hits table. There is one line for each domain. There may be more
than one domain per sequence. The domain table has 22 whitespace-
delimited ﬁelds followed by a free text target sequence description,
as follows:

hmmer user’s guide

71

(1) target name: The name of the target sequence or proﬁle.

(2) target accession: Accession of the target sequence or proﬁle, or ’-’

if none is available.

(3) tlen: Length of the target sequence or proﬁle, in residues. This
(together with the query length) is useful for interpreting where
the domain coordinates (in subsequent columns) lie in the se-
quence.

(4) query name: Name of the query sequence or proﬁle.

(5) accession: Accession of the target sequence or proﬁle, or ’-’ if

none is available.

(6) qlen: Length of the query sequence or proﬁle, in residues.

(7) E-value: E-value of the overall sequence/proﬁle comparison (in-

cluding all domains).

(8) score: Bit score of the overall sequence/proﬁle comparison (in-

cluding all domains), inclusive of a null2 bias composition correc-
tion to the score.

(9) bias: The biased composition score correction that was applied to

the bit score.

(10) #: This domain’s number (1..ndom).

(11) of: The total number of domains reported in the sequence,

ndom.

(12) c-Evalue: The “conditional E-value”, a permissive measure of
how reliable this particular domain may be. The conditional E-
value is calculated on a smaller search space than the independent
E-value. The conditional E-value uses the number of targets that
pass the reporting thresholds. The null hypothesis test posed by
the conditional E-value is as follows. Suppose that we believe that
there is already sufﬁcient evidence (from other domains) to iden-
tify the set of reported sequences as homologs of our query; now,
how many additional domains would we expect to ﬁnd with at
least this particular domain’s bit score, if the rest of those reported
sequences were random nonhomologous sequence (i.e. outside
the other domain(s) that were sufﬁcient to identiﬁed them as ho-
mologs in the ﬁrst place)?

(13) i-Evalue: The “independent E-value”, the E-value that the se-
quence/proﬁle comparison would have received if this were the
only domain envelope found in it, excluding any others. This is a

72

sean r. eddy

stringent measure of how reliable this particular domain may be.
The independent E-value uses the total number of targets in the
target database.

(14) score: The bit score for this domain.

(15) bias: The biased composition (null2) score correction that was

applied to the domain bit score.

(16) from (hmm coord): The start of the MEA alignment of this domain
with respect to the proﬁle, numbered 1..N for a proﬁle of N con-
sensus positions.

(17) to (hmm coord): The end of the MEA alignment of this domain
with respect to the proﬁle, numbered 1..N for a proﬁle of N con-
sensus positions.

(18) from (ali coord): The start of the MEA alignment of this domain
with respect to the sequence, numbered 1..L for a sequence of L
residues.

(19) to (ali coord): The end of the MEA alignment of this domain
with respect to the sequence, numbered 1..L for a sequence of L
residues.

(20) from (env coord): The start of the domain envelope on the se-

quence, numbered 1..L for a sequence of L residues. The envelope
deﬁnes a subsequence for which their is substantial probability
mass supporting a homologous domain, whether or not a single
discrete alignment can be identiﬁed. The envelope may extend be-
yond the endpoints of the MEA alignment, and in fact often does,
for weakly scoring domains.

(21) to (env coord): The end of the domain envelope on the sequence,

numbered 1..L for a sequence of L residues.

(22) acc: The mean posterior probability of aligned residues in the

MEA alignment; a measure of how reliable the overall alignment is
(from 0 to 1, with 1.00 indicating a completely reliable alignment
according to the model).

(23) description of target: The remainder of the line is the target’s

description line, as free text.

As with the target hits table (above), this table is columnated
neatly for human readability, but you should not write parsers that
rely on this columnation; parse based on space-delimited ﬁelds in-
stead.

Manual pages for HMMER programs

alimask - calculate and add column mask to a multiple sequence alignment

Synopsis

alimask [options] msafile postmsafile

Description

alimask is used to apply a mask line to a multiple sequence alignment, based on pro-
vided alignment or model coordinates. When hmmbuild receives a masked alignment
as input, it produces a proﬁle model in which the emission probabilities at masked
positions are set to match the background frequency, rather than being set based
on observed frequencies in the alignment. Position-speciﬁc insertion and deletion
rates are not altered, even in masked regions. alimask autodetects input format, and
produces masked alignments in Stockholm format. msafile may contain only one se-
quence alignment.

A common motivation for masking a region in an alignment is that the region
contains a simple tandem repeat that is observed to cause an unacceptably high rate
of false positive hits.

In the simplest case, a mask range is given in coordinates relative to the input
alignment, using --alirange <s>. However it is more often the case that the region to
be masked has been identiﬁed in coordinates relative to the proﬁle model (e.g. based
on recognizing a simple repeat pattern in false hit alignments or in the HMM logo).
Not all alignment columns are converted to match state positions in the proﬁle (see
the --symfrac ﬂag for hmmbuild for discussion), so model positions do not necessarily
match up to alignment column positions. To remove the burden of converting model
positions to alignment positions, alimask accepts the mask range input in model co-
ordinates as well, using --modelrange <s>. When using this ﬂag, alimask determines
which alignment positions would be identiﬁed by hmmbuild as match states, a process
that requires that all hmmbuild ﬂags impacting that decision be supplied to alimask. It is
for this reason that many of the hmmbuild ﬂags are also used by alimask.

74

sean r. eddy

Options

-h Help; print a brief reminder of command line usage and all

available options.

-o <f> Direct the summary output to ﬁle <f>, rather than to stdout.

Options for Specifying Mask Range

A single mask range is given as a dash-separated pair, like --modelrange 10-20 and
multiple ranges may be submitted as a comma-separated list, --modelrange 10-20,30-42.

--modelrange <s> Supply the given range(s) in model coordinates.

--alirange <s> Supply the given range(s) in alignment coordinates.

--appendmask Add to the existing mask found with the alignment. The
default is to overwrite any existing mask.

--model2ali <s> Print model range(s) and the corresponding alignment

range(s). No masked alignment is produced. The output
is a single line for each input range, of the form
i..j -> m..n

with i & j representing model range values, and m & n repre-
senting alignment range values.

--ali2model <s> Print alignment range(s) and the corresponding model

range(s). No masked alignment is produced. Because some
alignment positions may not map to model positions, the
range(s) produced will begin with the ﬁrst alignment posi-
tion between <from> and <to> (inclusive) that maps to a
model position, and end with the ﬁnal alignment position
in that range that maps to a model position. The output is a
single line for each input range, of the form
i..j -> m..n

with i & j representing alignment range values, and m & n
representing model range values. If no alignment positions in
the range <from>..<to> map to a model position, the out-
put prints the input <from> and <to> mapping to nothing,
with the format:
i..j -> -..- (no map) .

Options for Specifying the Alphabet

--amino Assert that sequences in msafile are protein, bypassing alpha-

bet autodetection.

--dna Assert that sequences in msafile are DNA, bypassing alphabet

autodetection.

hmmer user’s guide

75

--rna Assert that sequences in msafile are RNA, bypassing alphabet

autodetection.

Options Controlling Proﬁle Construction

These options control how consensus columns are deﬁned in an alignment.

--fast Deﬁne consensus columns as those that have a fraction >=

symfrac of residues as opposed to gaps. (See below for the
--symfrac option.) This is the default.

--hand Deﬁne consensus columns in next proﬁle using reference
annotation to the multiple alignment. This allows you to
deﬁne any consensus columns you like.

--symfrac <x> Deﬁne the residue fraction threshold necessary to deﬁne a

consensus column when using the --fast option. The default
is 0.5. The symbol fraction in each column is calculated after
taking relative sequence weighting into account, and ignoring
gap characters corresponding to ends of sequence fragments
(as opposed to internal insertions/deletions). Setting this to
0.0 means that every alignment column will be assigned as
consensus, which may be useful in some cases. Setting it to
1.0 means that only columns that include 0 gaps (internal
insertions/deletions) will be assigned as consensus.

--fragthresh <x> We only want to count terminal gaps as deletions if the

aligned sequence is known to be full-length, not if it is a frag-
ment (for instance, because only part of it was sequenced).
HMMER uses a simple rule to infer fragments: if the se-
quence length L is less than or equal to a fraction <x> times
the alignment length in columns, then the sequence is han-
dled as a fragment. The default is 0.5. Setting --fragthresh 0
will deﬁne no (nonempty) sequence as a fragment; you might
want to do this if you know you’ve got a carefully curated
alignment of full-length sequences. Setting --fragthresh 1
will deﬁne all sequences as fragments; you might want to
do this if you know your alignment is entirely composed of
fragments, such as translated short reads in metagenomic
shotgun data.

Options Controlling Relative Weights

HMMER uses an ad hoc sequence weighting algorithm to downweight closely related
sequences and upweight distantly related ones. This has the effect of making models
less biased by uneven phylogenetic representation. For example, two identical se-
quences would typically each receive half the weight that one sequence would. These
options control which algorithm gets used.

76

sean r. eddy

--wpb Use the Henikoff position-based sequence weighting scheme

[Henikoff and Henikoff, J. Mol. Biol. 243:574, 1994]. This is
the default.

--wgsc Use the Gerstein/Sonnhammer/Chothia weighting algorithm

[Gerstein et al, J. Mol. Biol. 235:1067, 1994].

--wblosum Use the same clustering scheme that was used to weight data

in calculating BLOSUM substitution matrices [Henikoff and
Henikoff, Proc. Natl. Acad. Sci 89:10915, 1992]. Sequences
are single-linkage clustered at an identity threshold (default
0.62; see --wid) and within each cluster of c sequences, each
sequence gets relative weight 1/c.

--wnone No relative weights. All sequences are assigned uniform

weight.

--wid <x> Sets the identity threshold used by single-linkage cluster-

ing when using --wblosum. Invalid with any other weighting
scheme. Default is 0.62.

Other Options

--informat <s> Assert that input msafile is in alignment format <s>, bypass-
ing format autodetection. Common choices for <s> include:
stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (a2m or A2M
both work).

--outformat <s> Write the output postmsafile in alignment format <s>. Com-

mon choices for <s> include: stockholm, a2m, afa, psiblast,
clustal, phylip. The string <s> is case-insensitive (a2m or A2M
both work). Default is stockholm.

--seed <n> Seed the random number generator with <n>, an integer >=
0. If <n> is nonzero, any stochastic simulations will be repro-
ducible; the same command will give the same results. If <n>
is 0, the random number generator is seeded arbitrarily, and
stochastic simulations will vary from run to run of the same
command. The default seed is 42.

hmmer user’s guide

77

hmmalign - align sequences to a proﬁle

Synopsis

hmmalign [options] hmmfile seqfile

Description

Perform a multiple sequence alignment of all the sequences in seqfile by aligning
them individually to the proﬁle HMM in hmmfile. The new alignment is output to
stdout.

The hmmfile should contain only a single proﬁle. If it contains more, only the ﬁrst

proﬁle in the ﬁle will be used.

Either hmmfile or seqfile (but not both) may be ’-’ (dash), which means reading this

input from stdin rather than a ﬁle.

The sequences in seqfile are aligned in unihit local alignment mode. Therefore they
should already be known to contain only a single domain (or a fragment of one). The
optimal alignment may assign some residues as nonhomologous (N and C states), in
which case these residues are still included in the resulting alignment, but shoved to
the outer edges. To trim these unaligned nonhomologous residues from the result,
see the --trim option.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-o <f> Direct the output alignment to ﬁle <f>, rather than to stdout.

--mapali <f> Merge the existing alignment in ﬁle <f> into the result,

where <f> is exactly the same alignment that was used to
build the model in hmmfile. This is done using a map of align-
ment columns to consensus proﬁle positions that is stored
in the hmmfile. The multiple alignment in <f> will be exactly
reproduced in its consensus columns (as deﬁned by the pro-
ﬁle), but the displayed alignment in insert columns may be
altered, because insertions relative to a proﬁle are considered
by convention to be unaligned data.

--trim Trim nonhomologous residues (assigned to N and C states

in the optimal alignments) from the resulting multiple align-
ment output.

--amino Assert that sequences in seqfile are protein, bypassing alpha-

bet autodetection.

--dna Assert that sequences in seqfile are DNA, bypassing alphabet

autodetection.

78

sean r. eddy

--rna Assert that sequences in seqfile are RNA, bypassing alphabet

autodetection.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--outformat <s> Write the output alignment in format <s>. Common choices
for <s> include: stockholm, a2m, afa, psiblast, clustal, phylip. The
string <s> is case-insensitive (a2m or A2M both work). Default is
stockholm.

hmmer user’s guide

79

hmmbuild - construct proﬁles from multiple sequence alignments

Synopsis

hmmbuild [options] hmmfile msafile

Description

For each multiple sequence alignment in msafile build a proﬁle HMM and save it to a
new ﬁle hmmfile.

msafile may be ’-’ (dash), which means reading this input from stdin rather than a

ﬁle.

hmmfile may not be ’-’ (stdout), because sending the HMM ﬁle to stdout would

conﬂict with the other text output of the program.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-n <s> Name the new proﬁle <s>. The default is to use the name
of the alignment (if one is present in the msafile, or, failing
that, the name of the hmmfile. If msafile contains more than
one alignment, -n doesn’t work, and every alignment must
have a name annotated in the msafile (as in Stockholm #=GF
ID annotation).

-o <f> Direct the summary output to ﬁle <f>, rather than to stdout.

-O <f> After each model is constructed, resave annotated, possi-

bly modiﬁed source alignments to a ﬁle <f> in Stockholm
format. The alignments are annotated with a reference an-
notation line indicating which columns were assigned as
consensus, and sequences are annotated with what relative
sequence weights were assigned. Some residues of the align-
ment may have been shifted to accommodate restrictions of
the Plan7 proﬁle architecture, which disallows transitions
between insert and delete states.

Options for Specifying the Alphabet

--amino Assert that sequences in msafile are protein, bypassing alpha-

bet autodetection.

--dna Assert that sequences in msafile are DNA, bypassing alphabet

autodetection.

--rna Assert that sequences in msafile are RNA, bypassing alphabet

autodetection.

80

sean r. eddy

Options Controlling Proﬁle Construction

These options control how consensus columns are deﬁned in an alignment.

--fast Deﬁne consensus columns as those that have a fraction >=

symfrac of residues as opposed to gaps. (See below for the
--symfrac option.) This is the default.

--hand Deﬁne consensus columns in next proﬁle using reference
annotation to the multiple alignment. This allows you to
deﬁne any consensus columns you like.

--symfrac <x> Deﬁne the residue fraction threshold necessary to deﬁne a

consensus column when using the --fast option. The default
is 0.5. The symbol fraction in each column is calculated after
taking relative sequence weighting into account, and ignoring
gap characters corresponding to ends of sequence fragments
(as opposed to internal insertions/deletions). Setting this to
0.0 means that every alignment column will be assigned as
consensus, which may be useful in some cases. Setting it to
1.0 means that only columns that include 0 gaps (internal
insertions/deletions) will be assigned as consensus.

--fragthresh <x> We only want to count terminal gaps as deletions if the

aligned sequence is known to be full-length, not if it is a frag-
ment (for instance, because only part of it was sequenced).
HMMER uses a simple rule to infer fragments: if the range
of a sequence in the alignment (the number of alignment
columns between the ﬁrst and last positions of the sequence)
is less than or equal to a fraction <x> times the alignment
length in columns, then the sequence is handled as a frag-
ment. The default is 0.5. Setting --fragthresh 0 will deﬁne no
(nonempty) sequence as a fragment; you might want to do
this if you know you’ve got a carefully curated alignment of
full-length sequences. Setting --fragthresh 1 will deﬁne all se-
quences as fragments; you might want to do this if you know
your alignment is entirely composed of fragments, such as
translated short reads in metagenomic shotgun data.

Options Controlling Relative Weights

HMMER uses an ad hoc sequence weighting algorithm to downweight closely related
sequences and upweight distantly related ones. This has the effect of making models
less biased by uneven phylogenetic representation. For example, two identical se-
quences would typically each receive half the weight that one sequence would. These
options control which algorithm gets used.

--wpb Use the Henikoff position-based sequence weighting scheme

[Henikoff and Henikoff, J. Mol. Biol. 243:574, 1994]. This is

hmmer user’s guide

81

the default.

--wgsc Use the Gerstein/Sonnhammer/Chothia weighting algorithm

[Gerstein et al, J. Mol. Biol. 235:1067, 1994].

--wblosum Use the same clustering scheme that was used to weight data

in calculating BLOSUM substitution matrices [Henikoff and
Henikoff, Proc. Natl. Acad. Sci 89:10915, 1992]. Sequences
are single-linkage clustered at an identity threshold (default
0.62; see --wid) and within each cluster of c sequences, each
sequence gets relative weight 1/c.

--wnone No relative weights. All sequences are assigned uniform

weight.

--wid <x> Sets the identity threshold used by single-linkage cluster-

ing when using --wblosum. Invalid with any other weighting
scheme. Default is 0.62.

Options Controlling Effective Sequence Number

After relative weights are determined, they are normalized to sum to a total effective
sequence number, eff_nseq. This number may be the actual number of sequences in
the alignment, but it is almost always smaller than that. The default entropy weight-
ing method (--eent) reduces the effective sequence number to reduce the information
content (relative entropy, or average expected score on true homologs) per consensus
position. The target relative entropy is controlled by a two-parameter function, where
the two parameters are settable with --ere and --esigma.

--eent Adjust effective sequence number to achieve a speciﬁc rela-

tive entropy per position (see --ere). This is the default.

--eclust Set effective sequence number to the number of single-

linkage clusters at a speciﬁc identity threshold (see --eid).
This option is not recommended; it’s for experiments evaluat-
ing how much better --eent is.

--enone Turn off effective sequence number determination and

just use the actual number of sequences. One reason you
might want to do this is to try to maximize the relative en-
tropy/position of your model, which may be useful for short
models.

--eset <x> Explicitly set the effective sequence number for all models to

<x>.

--ere <x> Set the minimum relative entropy/position target to <x>.

Requires --eent. Default depends on the sequence alphabet.
For protein sequences, it is 0.59 bits/position; for nucleotide
sequences, it is 0.45 bits/position.

82

sean r. eddy

--esigma <x> Sets the minimum relative entropy contributed by an entire
model alignment, over its whole length. This has the effect
of making short models have higher relative entropy per
position than --ere alone would give. The default is 45.0 bits.

--eid <x> Sets the fractional pairwise identity cutoff used by single
linkage clustering with the --eclust option. The default is
0.62.

Options Controlling Priors

By default, weighted counts are converted to mean posterior probability parameter
estimates using mixture Dirichlet priors. Default mixture Dirichlet prior parameters
for protein models and for nucleic acid (RNA and DNA) models are built in. The
following options allow you to override the default priors.

--pnone Don’t use any priors. Probability parameters will simply be
the observed frequencies, after relative sequence weighting.

--plaplace Use a Laplace +1 prior in place of the default mixture Dirich-

let prior.

Options Controlling Single Sequence Scoring

By default, if a query is a single sequence from a ﬁle in fasta format, hmmbuild con-
structs a search model from that sequence and a standard 20x20 substitution ma-
trix for residue probabilities, along with two additional parameters for position-
independent gap open and gap extend probabilities. These options allow the default
single-sequence scoring parameters to be changed, and for single-sequence scoring
options to be applied to a single sequence coming from an aligned format.

--singlemx

If a single sequence query comes from a multiple sequence
alignment ﬁle, such as in stockholm format, the search model
is by default constructed as is typically done for multiple
sequence alignments. This option forces hmmbuild to use the
single-sequence method with substitution score matrix.

--mx <s> Obtain residue alignment probabilities from the built-in sub-

stitution matrix named <s>. Several standard matrices are
built-in, and do not need to be read from ﬁles. The matrix
name <s> can be PAM30, PAM70, PAM120, PAM240, BLO-
SUM45, BLOSUM50, BLOSUM62, BLOSUM80, BLOSUM90,
or DNA1. Only one of the --mx and --mxfile options may be
used.

--mxfile <mxfile> Obtain residue alignment probabilities from the substitution

matrix in ﬁle <mxfile>. The default score matrix is BLO-
SUM62 for protein sequences, and DNA1 for nucleotide
sequences (these matrices are internal to HMMER and do

hmmer user’s guide

83

not need to be available as a ﬁle). The format of a substi-
tution matrix <mxfile> is the standard format accepted by
BLAST, FASTA, and other sequence analysis software. See
ftp.ncbi.nlm.nih.gov/blast/matrices/ for example ﬁles.
(The only exception: we require matrices to be square, so
for DNA, use ﬁles like NCBI’s NUC.4.4, not NUC.4.2.)

--popen <x> Set the gap open probability for a single sequence query

model to <x>. The default is 0.02. <x> must be >= 0 and <
0.5.

--pextend <x> Set the gap extend probability for a single sequence query
model to <x>. The default is 0.4. <x> must be >= 0 and <
1.0.

Options Controlling E-value Calibration

The location parameters for the expected score distributions for MSV ﬁlter scores,
Viterbi ﬁlter scores, and Forward scores require three short random sequence simula-
tions.

--EmL <n> Sets the sequence length in simulation that estimates the
location parameter mu for MSV ﬁlter E-values. Default is
200.

--EmN <n> Sets the number of sequences in simulation that estimates

the location parameter mu for MSV ﬁlter E-values. Default is
200.

--EvL <n> Sets the sequence length in simulation that estimates the

location parameter mu for Viterbi ﬁlter E-values. Default is
200.

--EvN <n> Sets the number of sequences in simulation that estimates the

location parameter mu for Viterbi ﬁlter E-values. Default is
200.

--EfL <n> Sets the sequence length in simulation that estimates the

location parameter tau for Forward E-values. Default is 100.

--EfN <n> Sets the number of sequences in simulation that estimates the

location parameter tau for Forward E-values. Default is 200.

--Eft <x> Sets the tail mass fraction to ﬁt in the simulation that esti-
mates the location parameter tau for Forward evalues. De-
fault is 0.04.

Other Options

--cpu <n> Set the number of parallel worker threads to <n>. On mul-
ticore machines, the default is 2. You can also control this

84

sean r. eddy

number by setting an environment variable, HMMER_NCPU. There
is also a master thread, so the actual number of threads that
HMMER spawns is <n>+1. This option is not available if
HMMER was compiled with POSIX threads support turned
off.

--informat <s> Assert that input msafile is in alignment format <s>, bypass-
ing format autodetection. Common choices for <s> include:
stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (a2m or A2M
both work).

--seed <n> Seed the random number generator with <n>, an integer >=
0. If <n> is nonzero, any stochastic simulations will be repro-
ducible; the same command will give the same results. If <n>
is 0, the random number generator is seeded arbitrarily, and
stochastic simulations will vary from run to run of the same
command. The default seed is 42.

--w_beta <x> Window length tail mass. The upper bound, W, on the length
at which nhmmer expects to ﬁnd an instance of the model is
set such that the fraction of all sequences generated by the
model with length >= W is less than <x>. The default is 1e-7.

--w_length <n> Override the model instance length upper bound, W, which is
otherwise controlled by --w_beta. It should be larger than the
model length. The value of W is used deep in the acceleration
pipeline, and modest changes are not expected to impact
results (though larger values of W do lead to longer run time).

--mpi Run as a parallel MPI program. Each alignment is assigned

to a MPI worker node for construction. (Therefore, the maxi-
mum parallelization cannot exceed the number of alignments
in the input msafile.) This is useful when building large pro-
ﬁle libraries. This option is only available if optional MPI
capability was enabled at compile-time.

--stall For debugging MPI parallelization: arrest program execution
immediately after start, and wait for a debugger to attach to
the running process and release the arrest.

--maxinsertlen <n> Restrict insert length parameterization such that the expected

insert length at each position of the model is no more than
<n>.

hmmer user’s guide

85

hmmc2 - example client for the HMMER daemon

Synopsis

hmmc2 [options]

Description

Hmmc2 is a text client for the hmmpgmd or hmmpgmd_shard daemons. When run, it
opens a connection to a daemon at the speciﬁed IP address and port, and then enters
an interactive loop waiting for the user to input commands to be sent to the daemon.
See the User’s Guide for the HMMER Daemon for a discussion of hmmpgmd’s com-
mand format.

Options

-i <IP address> Specify the IP address of the daemon that hmmc2 should

connect to. Defaults to 127.0.0.1 if not provided

-p <port number> Specify the port number that the daemon is listening on.

Defaults to 51371 if not provided

-S Print the scores of any hits found during searches.

-A Print the alignment of any hits found during searches. This is
a superset of the "-S" ﬂag, so providing both is redundant.

86

sean r. eddy

hmmconvert - convert proﬁle ﬁle to various formats

Synopsis

hmmconvert [options] hmmfile

Description

The hmmconvert utility converts an input proﬁle ﬁle to different HMMER formats.

By default, the input proﬁle can be in any HMMER format, including old/obsolete

formats from HMMER2, ASCII or binary; the output proﬁle is a current HMMER3
ASCII format.

hmmfile may be ’-’ (dash), which means reading this input from stdin rather than a

ﬁle.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-a Output proﬁles in ASCII text format. This is the default.

-b Output proﬁles in binary format.
-2 Output in legacy HMMER2 ASCII text format, in ls (glocal)

mode. This allows HMMER3 models to be converted back to
a close approximation of HMMER2, for comparative studies.
--outfmt <s> Output in a HMMER3 ASCII text format other then the most

current one. Valid choices for <s> are 3/a through 3/f. The
current format is 3/f, and this is the default. The format 3/b
was used in the ofﬁcial HMMER3 release, and the others
were used in the various testing versions.

hmmer user’s guide

87

hmmemit - sample sequences from a proﬁle

Synopsis

hmmemit [options] hmmfile

Description

The hmmemit program samples (emits) sequences from the proﬁle HMM(s) in hmmfile,
and writes them to output. Sampling sequences may be useful for a variety of pur-
poses, including creating synthetic true positives for benchmarks or tests.

The default is to sample one unaligned sequence from the core probability model,

which means that each sequence consists of one full-length domain. Alternatively,
with the -c option, you can emit a simple majority-rule consensus sequence; or with
the -a option, you can emit an alignment (in which case, you probably also want to
set -N to something other than its default of 1 sequence per model).

As another option, with the -p option you can sample a sequence from a fully

conﬁgured HMMER search proﬁle. This means sampling a ‘homologous sequence’ by
HMMER’s deﬁnition, including nonhomologous ﬂanking sequences, local alignments,
and multiple domains per sequence, depending on the length model and alignment
mode chosen for the proﬁle.

The hmmfile may contain a library of HMMs, in which case each HMM will be used

in turn.

hmmfile may be ’-’ (dash), which means reading this input from stdin rather than a

ﬁle.

Common Options

-h Help; print a brief reminder of command line usage and all

available options.

-o <f> Direct the output sequences to ﬁle <f>, rather than to stdout.

-N <n> Sample <n> sequences per model, rather than just one.

Options Controlling What to Emit

The default is to sample N sequences from the core model. Alternatively, you may
choose one (and only one) of the following alternatives.

-a Emit an alignment for each HMM in the hmmfile rather than

sampling unaligned sequences one at a time.

-c Emit a plurality-rule consensus sequence, instead of sam-

pling a sequence from the proﬁle HMM’s probability distri-
bution. The consensus sequence is formed by selecting the
maximum probability residue at each match state.

88

sean r. eddy

-C Emit a fancier plurality-rule consensus sequence than the

-c option. If the maximum probability residue has p < minl
show it as a lower case ’any’ residue (n or x); if p >= minl
and < minu show it as a lower case residue; and if p >= minu
show it as an upper case residue. The default settings of
minu and minl are both 0.0, which means -C gives the same
output as -c unless you also set minu and minl to what you
want.

-p Sample unaligned sequences from the implicit search proﬁle,
not from the core model. The core model consists only of the
homologous states (between the begin and end states of a
HMMER Plan7 model). The proﬁle includes the nonhomol-
ogous N, C, and J states, local/glocal and uni/multihit algo-
rithm conﬁguration, and the target length model. Therefore
sequences sampled from a proﬁle may include nonhomol-
ogous as well as homologous sequences, and may contain
more than one homologous sequence segment. By default,
the proﬁle is in multihit local mode, and the target sequence
length is conﬁgured for L=400.

Options Controlling Emission from Proﬁles

These options require that you have set the -p option.

-L <n> Conﬁgure the proﬁle’s target sequence length model to gen-

erate a mean length of approximately <n> rather than the
default of 400.

--local Conﬁgure the proﬁle for multihit local alignment.

--unilocal Conﬁgure the proﬁle for unihit local alignment (Smith/Waterman).

--glocal Conﬁgure the proﬁle for multihit glocal alignment.

--uniglocal Conﬁgure the proﬁle for unihit glocal alignment.

Options Controlling Fancy Consensus Emission

These options require that you have set the -C option.

--minl <x> Sets the minl threshold for showing weakly conserved residues

as lower case. (0 <= x <= 1)

--minu <x> Sets the minu threshold for showing strongly conserved

residues as upper case. (0 <= x <= 1)

Other Options

--seed <n> Seed the random number generator with <n>, an integer >=
0. If <n> is nonzero, any stochastic simulations will be repro-
ducible; the same command will give the same results. If <n>

hmmer user’s guide

89

is 0, the random number generator is seeded arbitrarily, and
stochastic simulations will vary from run to run of the same
command. The default is 0: use an arbitrary seed, so different
hmmemit runs will generate different samples.

90

sean r. eddy

hmmfetch - retrieve proﬁles from a ﬁle

Synopsis

hmmfetch [options] hmmfile key

(retrieve HMM named key)
hmmfetch -f [options] hmmfile keyfile

(retrieve all HMMs listed in keyfile)

hmmfetch --index [options] hmmfile
(index hmmfile for fetching)

Description

Quickly retrieves one or more proﬁle HMMs from an hmmfile (a large Pfam database,
for example).

For maximum speed, the hmmfile should be indexed ﬁrst, using hmmfetch --index. The

index is a binary ﬁle named hmmfile.ssi. However, this is optional, and retrieval will
still work from unindexed ﬁles, albeit much more slowly.

The default mode is to retrieve a single proﬁle by name or accession, called the key.

For example:

% hmmfetch Pfam-A.hmm Caudal_act

% hmmfetch Pfam-A.hmm PF00045

With the -f option, a keyfile containing a list of one or more keys is read instead.

The ﬁrst whitespace-delimited ﬁeld on each non-blank non-comment line of the
keyfile is used as a key, and any remaining data on the line is ignored. This allows
a variety of whitespace delimited dataﬁles to be used as a keyfile.

When using -f and a keyfile, if hmmfile has been indexed, the keys are retrieved
in the order they occur in the keyfile, but if hmmfile isn’t indexed, keys are retrieved
in the order they occur in the hmmfile. This is a side effect of an implementation that
allows multiple keys to be retrieved even if the hmmfile is a nonrewindable stream,
like a standard input pipe.

In normal use (without --index or -f options), hmmfile may be ’-’ (dash), which
means reading input from stdin rather than a ﬁle. With the --index option, hmmfile
may not be ’-’; it does not make sense to index a standard input stream. With the -f
option, either hmmfile or keyfile (but not both) may be ’-’. It is often particularly useful
to read keyfile from standard input, because this allows use to use arbitrary com-
mand line invocations to create a list of HMM names or accessions, then fetch them
all to a new ﬁle, just with one command.

By default, fetched HMMs are printed to standard output in HMMER3 format.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-f The second commandline argument is a keyfile instead of a

hmmer user’s guide

91

single key. The ﬁrst ﬁeld on each line of the keyfile is used as
a retrieval key (an HMM name or accession). Blank lines and
comment lines (that start with a # character) are ignored.

-o <f> Output HMM(s) to ﬁle <f> instead of to standard output.

-O Output one retrieved HMM (by key) to a ﬁle named key. This

is a convenience for saving some typing: instead of

% hmmfetch -o RRM_1 hmmfile RRM_1

you can just type

% hmmfetch -O hmmfile RRM_1

The -O option only works if you’re retrieving a single proﬁle;
it is incompatible with -f.

--index

Instead of retrieving one or more proﬁles from hmmfile, in-
dex the hmmfile for future retrievals. This creates a hmmfile.ssi
binary index ﬁle.

92

sean r. eddy

hmmlogo - produce a conservation logo graphic from a proﬁle

Synopsis

hmmlogo [options] hmmfile

Description

hmmlogo computes letter height and indel parameters that can be used to produce a
proﬁle HMM logo. This tool is essentially a command-line interface for much of the
data underlying the Skylign logo server (skylign.org). By default, hmmlogo prints out a
table of per-position letter heights (dependent on the requested height method), then
prints a table of per-position gap probabilities. In a typical logo, the total height of a
stack of letters for one position depends on the information content of the position,
and that stack height is subdivided according to the emission probabilities of the
letters of the alphabet.

Options

-h Help; print a brief reminder of command line usage and all

available options.

--height_relent_all Total height = relative entropy (aka information content); all

letters are given a positive height. (default)

--height_relent_abovebg Total height = relative entropy (aka information content);
only letters with above-background probability are given
positive height.

--height_score Total height = sums of scores of positive-scoring letters; letter

height depends on the score of that letter at that position.
Only letters with above-background probability (positive
score) are given positive height. (Note that only letter height
is meaningful - stack height has no inherent meaning).

--no_indel Don’t print out the indel probability table.

hmmer user’s guide

93

hmmpgmd - daemon for database search web services

Synopsis

hmmpgmd [options]

Description

The hmmpgmd program is the daemon that we use internally for the hmmer.org web
server. It essentially stands in front of the search programs phmmer, hmmsearch, and
hmmscan.

To use hmmpgmd, ﬁrst an instance must be started up as a master server, and provided
with at least one sequence database (using the --seqdb ﬂag) and/or an HMM database
(using the --hmmdb ﬂag). A sequence database must be in hmmpgmd format, which
may be produced using esl-reformat. An HMM database is of the form produced
by hmmbuild. The input database(s) will be loaded into memory by the master. When
the master has ﬁnished loading the database(s), it prints the line: "Data loaded into
memory. Master is ready."

After the master is ready, one or more instances of hmmpgmd may be started as
workers. These workers may be (and typically are) on different machines from the
master, but must have access to the same database ﬁle(s) provided to the master, with
the same path. As with the master, each worker loads the database(s) into memory,
and indicates completion by printing: "Data loaded into memory. Worker is ready."
The master process and workers are expected to remain running. One or more
clients then connect to the master and submit possibly many queries. The master dis-
tributes the work of a query among the workers, collects results, and merges them
before responding to the client. Two example client programs are included in the
HMMER src directory - the C program hmmc2 and the perl script hmmpgmd_client_example.pl.
These are intended as examples only, and should be extended as necessary to meet
your needs.

A query is submitted to the master from the client as a character string. Queries
may be the sort that would normally be handled by phmmer (protein sequence vs pro-
tein database), hmmsearch (protein HMM query vs protein database), or hmmscan (protein
query vs protein HMM database).

The general form of a client query is to start with a single line of the form @[options],

followed by multiple lines of text representing either the query HMM or fasta-
formatted sequence. The ﬁnal line of each query is the separator //.

For example, to perform a phmmer type search of a sequence against a sequence
database ﬁle, the ﬁrst line is of the form @--seqdb 1, then the fasta-formatted query
sequence starting with the header line >sequence-name, followed by one or more lines of
sequence, and ﬁnally the closing //.

To perform an hmmsearch type search, the query sequence is replaced by the full text

of a HMMER-format query HMM.

To perform an hmmscan type search, the text matches that of the phmmer type search,

except that the ﬁrst line changes to @--hmmdb 1.

94

sean r. eddy

In the hmmpgmd-formatted sequence database ﬁle, each sequence can be asso-

ciated with one or more sub-databases. The --seqdb ﬂag indicates which of these
sub-databases will be queried. The HMM database format does not support sub-
databases.

Options

-h Help; print a brief reminder of command line usage and all

available options.

--master Run as the master server.

--worker <s> Run as a worker, connecting to the master server that is run-

ning on IP address <s>.

--cport <n> Port to use for communication between clients and the mas-

ter server. The default is 51371.

--wport <n> Port to use for communication between workers and the

master server. The default is 51372.

--ccncts <n> Maximum number of client connections to accept. The de-

fault is 16.

--wcncts <n> Maximum number of worker connections to accept. The

default is 32.

--pid <f> Name of ﬁle into which the process id will be written.

--seqdb <f> Name of the ﬁle (in hmmpgmd format) containing protein se-

quences. The contents of this ﬁle will be cached for searches.

--hmmdb <f> Name of the ﬁle containing protein HMMs. The contents of

this ﬁle will be cached for searches.

--cpu <n> Number of parallel threads to use (for --worker ).

hmmer user’s guide

95

hmmpgmd_shard - sharded daemon for database search web services

Synopsis

hmmpgmd_shard [options]

Description

The hmmpgmd_shard program provides a sharded version of the hmmpgmd program that we
use internally to implement high-performance HMMER services that can be accessed
via the internet. See the hmmpgmd man page for a discussion of how the base hmmpgmd pro-
gram is used. This man page discusses differences between hmmpgmd_shard and hmmpgmd.
The base hmmpgmd program loads the entirety of its database ﬁle into RAM on every
worker node, in spite of the fact that each worker node searches a predictable frac-
tion of the database(s) contained in that ﬁle when performing searches. This wastes
RAM, particularly when many worker nodes are used to accelerate searches of large
databases.

Hmmpgmd_shard addresses this by dividing protein sequence database ﬁles into

shards. Each worker node loads only 1/Nth of the database ﬁle, where N is the num-
ber of worker nodes attached to the master. HMM database ﬁles are not sharded,
meaning that every worker node will load the entire database ﬁle into RAM. Cur-
rent HMM databases are much smaller than current protein sequence databases, and
easily ﬁt into the RAM of modern servers even without sharding.

Hmmpgmd_shard is used in the same manner as hmmpgmd , except that it takes one addi-
tional argument: --num_shards <n> , which speciﬁes the number of shards that protein
databases will be divided into, and defaults to 1 if unspeciﬁed. This argument is
only valid for the master node of a hmmpgmd system (i.e., when --master is passed to the
hmmpgmd program), and must be equal to the number of worker nodes that will connect
to the master node. Hmmpgmd_shard will signal an error if more than num_shards worker
nodes attempt to connect to the master node or if a search is started when fewer than
num_shards workers are connected to the master.

Options

-h Help; print a brief reminder of command line usage and all

available options.

--master Run as the master server.

--worker <s> Run as a worker, connecting to the master server that is run-

ning on IP address <s>.

--cport <n> Port to use for communication between clients and the mas-

ter server. The default is 51371.

--wport <n> Port to use for communication between workers and the

master server. The default is 51372.

96

sean r. eddy

--ccncts <n> Maximum number of client connections to accept. The de-

fault is 16.

--wcncts <n> Maximum number of worker connections to accept. The

default is 32.

--pid <f> Name of ﬁle into which the process id will be written.

--seqdb <f> Name of the ﬁle (in hmmpgmd format) containing protein se-

quences. The contents of this ﬁle will be cached for searches.

--hmmdb <f> Name of the ﬁle containing protein HMMs. The contents of

this ﬁle will be cached for searches.

--cpu <n> Number of parallel threads to use (for --worker ).

--num_shards <n> Number of shards to divide cached sequence database(s)
into. HMM databases are not sharded, due to their small
size. This option is only valid when the --master option is
present, and defaults to 1 if not speciﬁed. Hmmpgmd_shard re-
quires that the number of shards be equal to the number of
worker nodes, and will give errors if more than num_shards
workers attempt to connect to the master node or if a search
is started with fewer than num_shards workers connected to the
master.

hmmer user’s guide

97

hmmpress - prepare a proﬁle database for hmmscan

Synopsis

hmmpress [options] hmmfile

Description

Constructs binary compressed dataﬁles for hmmscan, starting from a proﬁle database
hmmfile in standard HMMER3 format. The hmmpress step is required for hmmscan to work.
Four ﬁles are created: hmmfile.h3m, hmmfile.h3i, hmmfile.h3f, and hmmfile.h3p. The
hmmfile.h3m ﬁle contains the proﬁle HMMs and their annotation in a binary format.
The hmmfile.h3i ﬁle is an SSI index for the hmmfile.h3m ﬁle. The hmmfile.h3f ﬁle con-
tains precomputed data structures for the fast heuristic ﬁlter (the MSV ﬁlter). The
hmmfile.h3p ﬁle contains precomputed data structures for the rest of each proﬁle.

hmmfile may not be ’-’ (dash); running hmmpress on a standard input stream rather

than a ﬁle is not allowed.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-f Force; overwrites any previous hmmpress’ed dataﬁles. The
default is to bitch about any existing ﬁles and ask you to
delete them ﬁrst.

98

sean r. eddy

hmmscan - search sequence(s) against a proﬁle database

Synopsis

hmmscan [options] hmmdb seqfile

Description

hmmscan is used to search protein sequences against collections of protein proﬁles.
For each sequence in seqfile, use that query sequence to search the target database
of proﬁles in hmmdb, and output ranked lists of the proﬁles with the most signiﬁcant
matches to the sequence.

The seqfile may contain more than one query sequence. Each will be searched in

turn against hmmdb.

The hmmdb needs to be press’ed using hmmpress before it can be searched with hmmscan.

This creates four binary ﬁles, sufﬁxed .h3{fimp}.

The query seqfile may be ’-’ (a dash character), in which case the query sequences

are read from a stdin pipe instead of from a ﬁle. The hmmdb cannot be read from a
stdin stream, because it needs to have those four auxiliary binary ﬁles generated by
hmmpress.

The output format is designed to be human-readable, but is often so voluminous

that reading it is impractical, and parsing it is a pain. The --tblout and --domtblout
options save output in simple tabular formats that are concise and easier to parse.
The -o option allows redirecting the main output, including throwing it away in
/dev/null.

Options

-h Help; print a brief reminder of command line usage and all

available options.

Options for Controlling Output

-o <f> Direct the main human-readable output to a ﬁle <f> instead

of the default stdout.

--tblout <f> Save a simple tabular (space-delimited) ﬁle summarizing the
per-target output, with one data line per homologous target
model found.

--domtblout <f> Save a simple tabular (space-delimited) ﬁle summarizing

the per-domain output, with one data line per homologous
domain detected in a query sequence for each homologous
model.

--pfamtblout <f> Save an especially succinct tabular (space-delimited) ﬁle

summarizing the per-target output, with one data line per
homologous target model found.

hmmer user’s guide

99

--acc Use accessions instead of names in the main output, where

available for proﬁles and/or sequences.

--noali Omit the alignment section from the main output. This can

greatly reduce the output volume.

--notextw Unlimit the length of each line in the main output. The de-
fault is a limit of 120 characters per line, which helps in dis-
playing the output cleanly on terminals and in editors, but
can truncate target proﬁle description lines.

--textw <n> Set the main output’s line length limit to <n> characters per

line. The default is 120.

Options for Reporting Thresholds

Reporting thresholds control which hits are reported in output ﬁles (the main output,
--tblout, and --domtblout).

-E <x> In the per-target output, report target proﬁles with an E-

value of <= <x>. The default is 10.0, meaning that on aver-
age, about 10 false positives will be reported per query, so
you can see the top of the noise and decide for yourself if it’s
really noise.

-T <x> Instead of thresholding per-proﬁle output on E-value, instead

report target proﬁles with a bit score of >= <x>.

--domE <x> In the per-domain output, for target proﬁles that have al-
ready satisﬁed the per-proﬁle reporting threshold, report
individual domains with a conditional E-value of <= <x>.
The default is 10.0. A conditional E-value means the expected
number of additional false positive domains in the smaller
search space of those comparisons that already satisﬁed the
per-proﬁle reporting threshold (and thus must have at least
one homologous domain already).

--domT <x> Instead of thresholding per-domain output on E-value, in-

stead report domains with a bit score of >= <x>.

Options for Inclusion Thresholds

Inclusion thresholds are stricter than reporting thresholds. Inclusion thresholds con-
trol which hits are considered to be reliable enough to be included in an output align-
ment or a subsequent search round. In hmmscan, which does not have any alignment
output (like hmmsearch or phmmer) nor any iterative search steps (like jackhmmer), inclusion
thresholds have little effect. They only affect what domains get marked as signiﬁcant
(!) or questionable (?) in domain output.

--incE <x> Use an E-value of <= <x> as the per-target inclusion thresh-

old. The default is 0.01, meaning that on average, about 1

100

sean r. eddy

false positive would be expected in every 100 searches with
different query sequences.

--incT <x> Instead of using E-values for setting the inclusion threshold,

instead use a bit score of >= <x> as the per-target inclu-
sion threshold. It would be unusual to use bit score thresh-
olds with hmmscan, because you don’t expect a single score
threshold to work for different proﬁles; different proﬁles have
slightly different expected score distributions.

--incdomE <x> Use a conditional E-value of <= <x> as the per-domain in-
clusion threshold, in targets that have already satisﬁed the
overall per-target inclusion threshold. The default is 0.01.

--incdomT <x> Instead of using E-values, instead use a bit score of >= <x>

as the per-domain inclusion threshold. As with --incT above,
it would be unusual to use a single bit score threshold in
hmmscan.

Options for Model-speciﬁc Score Thresholding

Curated proﬁle databases may deﬁne speciﬁc bit score thresholds for each proﬁle,
superseding any thresholding based on statistical signiﬁcance alone. To use these op-
tions, the proﬁle must contain the appropriate (GA, TC, and/or NC) optional score
threshold annotation; this is picked up by hmmbuild from Stockholm format align-
ment ﬁles. Each thresholding option has two scores: the per-sequence threshold <x1>
and the per-domain threshold <x2>. These act as if -T <x1> --incT <x1> --domT <x2>
--incdomT <x2> has been applied speciﬁcally using each model’s curated thresholds.

--cut_ga Use the GA (gathering) bit scores in the model to set per-

sequence (GA1) and per-domain (GA2) reporting and inclu-
sion thresholds. GA thresholds are generally considered to
be the reliable curated thresholds deﬁning family member-
ship; for example, in Pfam, these thresholds deﬁne what gets
included in Pfam Full alignments based on searches with
Pfam Seed models.

--cut_nc Use the NC (noise cutoff) bit score thresholds in the model to
set per-sequence (NC1) and per-domain (NC2) reporting and
inclusion thresholds. NC thresholds are generally considered
to be the score of the highest-scoring known false positive.

--cut_tc Use the NC (trusted cutoff) bit score thresholds in the model

to set per-sequence (TC1) and per-domain (TC2) reporting
and inclusion thresholds. TC thresholds are generally consid-
ered to be the score of the lowest-scoring known true positive
that is above all known false positives.

hmmer user’s guide

101

Control of the Acceleration Pipeline

HMMER3 searches are accelerated in a three-step ﬁlter pipeline: the MSV ﬁlter, the
Viterbi ﬁlter, and the Forward ﬁlter. The ﬁrst ﬁlter is the fastest and most approx-
imate; the last is the full Forward scoring algorithm. There is also a bias ﬁlter step
between MSV and Viterbi. Targets that pass all the steps in the acceleration pipeline
are then subjected to postprocessing -- domain identiﬁcation and scoring using the
Forward/Backward algorithm. Changing ﬁlter thresholds only removes or includes
targets from consideration; changing ﬁlter thresholds does not alter bit scores, E-
values, or alignments, all of which are determined solely in postprocessing.

--max Turn off all ﬁlters, including the bias ﬁlter, and run full For-

ward/Backward postprocessing on every target. This in-
creases sensitivity somewhat, at a large cost in speed.

--F1 <x> Set the P-value threshold for the MSV ﬁlter step. The de-

fault is 0.02, meaning that roughly 2% of the highest scoring
nonhomologous targets are expected to pass the ﬁlter.

--F2 <x> Set the P-value threshold for the Viterbi ﬁlter step. The de-

fault is 0.001.

--F3 <x> Set the P-value threshold for the Forward ﬁlter step. The

default is 1e-5.

--nobias Turn off the bias ﬁlter. This increases sensitivity somewhat,
but can come at a high cost in speed, especially if the query
has biased residue composition (such as a repetitive sequence
region, or if it is a membrane protein with large regions of
hydrophobicity). Without the bias ﬁlter, too many sequences
may pass the ﬁlter with biased queries, leading to slower
than expected performance as the computationally intensive
Forward/Backward algorithms shoulder an abnormally
heavy load.

Other Options

--nonull2 Turn off the null2 score corrections for biased composition.

-Z <x> Assert that the total number of targets in your searches is

<x>, for the purposes of per-sequence E-value calculations,
rather than the actual number of targets seen.

--domZ <x> Assert that the total number of targets in your searches is
<x>, for the purposes of per-domain conditional E-value
calculations, rather than the number of targets that passed
the reporting thresholds.

--seed <n> Set the random number seed to <n>. Some steps in postpro-

cessing require Monte Carlo simulation. The default is to
use a ﬁxed seed (42), so that results are exactly reproducible.

102

sean r. eddy

Any other positive integer will give different (but also re-
producible) results. A choice of 0 uses an arbitrarily chosen
seed.

--qformat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--cpu <n> Set the number of parallel worker threads to <n>. The de-
fault is 0, meaning off (no thread-level parallelization), be-
cause hmmscan is typically i/o bound and the extra overhead
of our current multithreaded implementation isn’t worth-
while. You can also control this number by setting an envi-
ronment variable, HMMER_NCPU. There is also a master thread, so
the actual number of threads that HMMER spawns is at least
<n>+1. This option is not available if HMMER was compiled
with POSIX threads support turned off.

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--mpi Run under MPI control with master/worker parallelization
(using mpirun, for example, or equivalent). Only available if
optional MPI support was enabled at compile-time.

hmmer user’s guide

103

hmmsearch - search proﬁle(s) against a sequence database

Synopsis

hmmsearch [options] hmmfile seqdb

Description

hmmsearch is used to search one or more proﬁles against a sequence database. For each
proﬁle in hmmfile, use that query proﬁle to search the target database of sequences in
seqdb, and output ranked lists of the sequences with the most signiﬁcant matches to
the proﬁle. To build proﬁles from multiple alignments, see hmmbuild.

Either the query hmmfile or the target seqdb may be ’-’ (a dash character), in which
case the query proﬁle or target database input will be read from a stdin pipe instead
of from a ﬁle. Only one input source can come through stdin, not both. An exception
is that if the hmmfile contains more than one proﬁle query, then seqdb cannot come
from stdin, because we can’t rewind the streaming target database to search it with
another proﬁle.

The output format is designed to be human-readable, but is often so voluminous

that reading it is impractical, and parsing it is a pain. The --tblout and --domtblout
options save output in simple tabular formats that are concise and easier to parse.
The -o option allows redirecting the main output, including throwing it away in
/dev/null.

Options

-h Help; print a brief reminder of command line usage and all

available options.

Options for Controlling Output

-o <f> Direct the main human-readable output to a ﬁle <f> instead

of the default stdout.

-A <f> Save a multiple alignment of all signiﬁcant hits (those satisfy-

ing inclusion thresholds) to the ﬁle <f>.

--tblout <f> Save a simple tabular (space-delimited) ﬁle summarizing the
per-target output, with one data line per homologous target
sequence found.

--domtblout <f> Save a simple tabular (space-delimited) ﬁle summarizing

the per-domain output, with one data line per homologous
domain detected in a query sequence for each homologous
model.

--acc Use accessions instead of names in the main output, where

available for proﬁles and/or sequences.

104

sean r. eddy

--noali Omit the alignment section from the main output. This can

greatly reduce the output volume.

--notextw Unlimit the length of each line in the main output. The de-
fault is a limit of 120 characters per line, which helps in dis-
playing the output cleanly on terminals and in editors, but
can truncate target proﬁle description lines.

--textw <n> Set the main output’s line length limit to <n> characters per

line. The default is 120.

Options Controlling Reporting Thresholds

Reporting thresholds control which hits are reported in output ﬁles (the main output,
--tblout, and --domtblout). Sequence hits and domain hits are ranked by statistical
signiﬁcance (E-value) and output is generated in two sections called per-target and
per-domain output. In per-target output, by default, all sequence hits with an E-value
<= 10 are reported. In the per-domain output, for each target that has passed per-
target reporting thresholds, all domains satisfying per-domain reporting thresholds
are reported. By default, these are domains with conditional E-values of <= 10. The
following options allow you to change the default E-value reporting thresholds, or to
use bit score thresholds instead.

-E <x> In the per-target output, report target sequences with an
E-value of <= <x>. The default is 10.0, meaning that on
average, about 10 false positives will be reported per query,
so you can see the top of the noise and decide for yourself if
it’s really noise.

-T <x> Instead of thresholding per-proﬁle output on E-value, instead
report target sequences with a bit score of >= <x>.

--domE <x> In the per-domain output, for target sequences that have

already satisﬁed the per-proﬁle reporting threshold, report
individual domains with a conditional E-value of <= <x>.
The default is 10.0. A conditional E-value means the expected
number of additional false positive domains in the smaller
search space of those comparisons that already satisﬁed the
per-target reporting threshold (and thus must have at least
one homologous domain already).

--domT <x> Instead of thresholding per-domain output on E-value, in-

stead report domains with a bit score of >= <x>.

Options for Inclusion Thresholds

Inclusion thresholds are stricter than reporting thresholds. Inclusion thresholds con-
trol which hits are considered to be reliable enough to be included in an output
alignment or a subsequent search round, or marked as signiﬁcant ("!") as opposed
to questionable ("?") in domain output.

hmmer user’s guide

105

--incE <x> Use an E-value of <= <x> as the per-target inclusion thresh-

old. The default is 0.01, meaning that on average, about 1
false positive would be expected in every 100 searches with
different query sequences.

--incT <x> Instead of using E-values for setting the inclusion threshold,
instead use a bit score of >= <x> as the per-target inclusion
threshold. By default this option is unset.
--incdomE <x> Use a conditional E-value of <= <x> as the per-domain in-
clusion threshold, in targets that have already satisﬁed the
overall per-target inclusion threshold. The default is 0.01.
--incdomT <x> Instead of using E-values, use a bit score of >= <x> as the

per-domain inclusion threshold.

Options for Model-speciﬁc Score Thresholding

Curated proﬁle databases may deﬁne speciﬁc bit score thresholds for each proﬁle,
superseding any thresholding based on statistical signiﬁcance alone. To use these
options, the proﬁle must contain the appropriate (GA, TC, and/or NC) optional score
threshold annotation; this is picked up by hmmbuild from Stockholm format alignment
ﬁles. Each thresholding option has two scores: the per-sequence threshold <x1>
and the per-domain threshold <x2> These act as if -T <x1> --incT <x1> --domT <x2>
--incdomT <x2> has been applied speciﬁcally using each model’s curated thresholds.

--cut_ga Use the GA (gathering) bit scores in the model to set per-

sequence (GA1) and per-domain (GA2) reporting and inclu-
sion thresholds. GA thresholds are generally considered to
be the reliable curated thresholds deﬁning family member-
ship; for example, in Pfam, these thresholds deﬁne what gets
included in Pfam Full alignments based on searches with
Pfam Seed models.

--cut_nc Use the NC (noise cutoff) bit score thresholds in the model to
set per-sequence (NC1) and per-domain (NC2) reporting and
inclusion thresholds. NC thresholds are generally considered
to be the score of the highest-scoring known false positive.

--cut_tc Use the TC (trusted cutoff) bit score thresholds in the model

to set per-sequence (TC1) and per-domain (TC2) reporting
and inclusion thresholds. TC thresholds are generally consid-
ered to be the score of the lowest-scoring known true positive
that is above all known false positives.

Options Controlling the Acceleration Pipeline

HMMER3 searches are accelerated in a three-step ﬁlter pipeline: the MSV ﬁlter, the
Viterbi ﬁlter, and the Forward ﬁlter. The ﬁrst ﬁlter is the fastest and most approx-
imate; the last is the full Forward scoring algorithm. There is also a bias ﬁlter step

106

sean r. eddy

between MSV and Viterbi. Targets that pass all the steps in the acceleration pipeline
are then subjected to postprocessing -- domain identiﬁcation and scoring using the
Forward/Backward algorithm. Changing ﬁlter thresholds only removes or includes
targets from consideration; changing ﬁlter thresholds does not alter bit scores, E-
values, or alignments, all of which are determined solely in postprocessing.

--max Turn off all ﬁlters, including the bias ﬁlter, and run full For-

ward/Backward postprocessing on every target. This in-
creases sensitivity somewhat, at a large cost in speed.

--F1 <x> Set the P-value threshold for the MSV ﬁlter step. The de-

fault is 0.02, meaning that roughly 2% of the highest scoring
nonhomologous targets are expected to pass the ﬁlter.

--F2 <x> Set the P-value threshold for the Viterbi ﬁlter step. The de-

fault is 0.001.

--F3 <x> Set the P-value threshold for the Forward ﬁlter step. The

default is 1e-5.

--nobias Turn off the bias ﬁlter. This increases sensitivity somewhat,
but can come at a high cost in speed, especially if the query
has biased residue composition (such as a repetitive sequence
region, or if it is a membrane protein with large regions of
hydrophobicity). Without the bias ﬁlter, too many sequences
may pass the ﬁlter with biased queries, leading to slower
than expected performance as the computationally intensive
Forward/Backward algorithms shoulder an abnormally
heavy load.

Other Options

--nonull2 Turn off the null2 score corrections for biased composition.

-Z <x> Assert that the total number of targets in your searches is

<x>, for the purposes of per-sequence E-value calculations,
rather than the actual number of targets seen.

--domZ <x> Assert that the total number of targets in your searches is
<x>, for the purposes of per-domain conditional E-value
calculations, rather than the number of targets that passed
the reporting thresholds.

--seed <n> Set the random number seed to <n>. Some steps in postpro-

cessing require Monte Carlo simulation. The default is to
use a ﬁxed seed (42), so that results are exactly reproducible.
Any other positive integer will give different (but also re-
producible) results. A choice of 0 uses a randomly chosen
seed.

hmmer user’s guide

107

--tformat <s> Assert that target sequence ﬁle seqfile is in format <s>, by-

passing format autodetection. Common choices for <s>
include: fasta, embl, genbank. Alignment formats also work;
common choices include: stockholm, a2m, afa, psiblast, clustal,
phylip. For more information, and for codes for some less
common formats, see main documentation. The string <s> is
case-insensitive (fasta or FASTA both work).

--cpu <n> Set the number of parallel worker threads to <n>. On mul-
ticore machines, the default is 2. You can also control this
number by setting an environment variable, HMMER_NCPU. There
is also a master thread, so the actual number of threads that
HMMER spawns is <n>+1. This option is not available if
HMMER was compiled with POSIX threads support turned
off.

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--mpi Run under MPI control with master/worker parallelization
(using mpirun, for example, or equivalent). Only available if
optional MPI support was enabled at compile-time.

108

sean r. eddy

hmmsim - collect proﬁle score distributions on random sequences

Synopsis

hmmsim [options] hmmfile

Description

The hmmsim program generates random sequences, scores them with the model(s) in
hmmfile, and outputs various sorts of histograms, plots, and ﬁtted distributions for the
resulting scores.

hmmsim is not a mainstream part of the HMMER package and most users would
have no reason to use it. It is used to develop and test the statistical methods used to
determine P-values and E-values in HMMER3. For example, it was used to generate
most of the results in a 2008 paper on H3’s local alignment statistics (PLoS Comp Bio
4:e1000069, 2008; http://www.ploscompbiol.org/doi/pcbi.1000069).

Because it is a research testbed, you should not expect it to be as robust as other

programs in the package. For example, options may interact in weird ways; we
haven’t tested nor tried to anticipate all different possible combinations.

The main task is to ﬁt a maximum likelihood Gumbel distribution to Viterbi scores

or an maximum likelihood exponential tail to high-scoring Forward scores, and to
test that these ﬁtted distributions obey the conjecture that lambda log_2 for both the
Viterbi Gumbel and the Forward exponential tail.

The output is a table of numbers, one row for each model. Four different para-
metric ﬁts to the score data are tested: (1) maximum likelihood ﬁts to both location
(mu/tau) and slope (lambda) parameters; (2) assuming lambda=log_2, maximum
likelihood ﬁt to the location parameter only; (3) same but assuming an edge-corrected
lambda, using current procedures in H3 [Eddy, 2008]; and (4) using both parameters
determined by H3’s current procedures. The standard simple, quick and dirty statis-
tic for goodness-of-ﬁt is ’E@10’, the calculated E-value of the 10th ranked top hit,
which we expect to be about 10.

In detail, the columns of the output are:

name Name of the model.

tailp Fraction of the highest scores used to ﬁt the distribution.

For Viterbi, MSV, and Hybrid scores, this defaults to 1.0 (a
Gumbel distribution is ﬁtted to all the data). For Forward
scores, this defaults to 0.02 (an exponential tail is ﬁtted to the
highest 2% scores).

mu/tau Location parameter for the maximum likelihood ﬁt to the

data.

lambda Slope parameter for the maximum likelihood ﬁt to the data.

E@10 The E-value calculated for the 10th ranked high score (’E@10’)
using the ML mu/tau and lambda. By deﬁnition, this ex-
pected to be about 10, if E-value estimation were accurate.

hmmer user’s guide

109

mufix Location parameter, for a maximum likelihood ﬁt with a
known (ﬁxed) slope parameter lambda of log_2 (0.693).
E@10fix The E-value calculated for the 10th ranked score using muﬁx

and the expected lambda = log_2 = 0.693.

mufix2 Location parameter, for a maximum likelihood ﬁt with an

edge-effect-corrected lambda.

E@10fix2 The E-value calculated for the 10th ranked score using mu-

ﬁx2 and the edge-effect-corrected lambda.

pmu Location parameter as determined by H3’s estimation proce-

dures.

plambda Slope parameter as determined by H3’s estimation proce-

dures.

pE@10 The E-value calculated for the 10th ranked score using pmu,

plambda.

At the end of this table, one more line is printed, starting with # and summarizing

the overall CPU time used by the simulations.

Some of the optional output ﬁles are in xmgrace xy format. xmgrace is powerful

and freely available graph-plotting software.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-a Collect expected Viterbi alignment length statistics from each
simulated sequence. This only works with Viterbi scores
(the default; see --vit). Two additional ﬁelds are printed in
the output table for each model: the mean length of Viterbi
alignments, and the standard deviation.

-v

(Verbose). Print the scores too, one score per line.

-L <n> Set the length of the randomly sampled (nonhomologous)

sequences to <n>. The default is 100.

-N <n> Set the number of randomly sampled sequences to <n>. The

default is 1000.

--mpi Run under MPI control with master/worker parallelization

(using mpirun, for example, or equivalent). Only available
if optional MPI support was enabled at compile-time. It is
parallelized at the level of sending one proﬁle at a time to an
MPI worker process, so parallelization only helps if you have
more than one proﬁle in the hmmfile, and you want to have at
least as many proﬁles as MPI worker processes.

110

sean r. eddy

Options Controlling Output

-o <f> Save the main output table to a ﬁle <f> rather than sending it

to stdout.

--afile <f> When collecting Viterbi alignment statistics (the -a option),

for each sampled sequence, output two ﬁelds per line to a ﬁle
<f>: the length of the optimal alignment, and the Viterbi bit
score. Requires that the -a option is also used.

--efile <f> Output a rank vs. E-value plot in XMGRACE xy format
to ﬁle <f>. The x-axis is the rank of this sequence, from
highest score to lowest; the y-axis is the E-value calculated
for this sequence. E-values are calculated using H3’s default
procedures (i.e. the pmu, plambda parameters in the output
table). You expect a rough match between rank and E-value if
E-values are accurately estimated.

--ffile <f> Output a "ﬁlter power" ﬁle to <f>: for each model, a line

with three ﬁelds: model name, number of sequences passing
the P-value threshold, and fraction of sequences passing
the P-value threshold. See --pthresh for setting the P-value
threshold, which defaults to 0.02 (the default MSV ﬁlter
threshold in H3). The P-values are as determined by H3’s
default procedures (the pmu,plambda parameters in the
output table). If all is well, you expect to see ﬁlter power
equal to the predicted P-value setting of the threshold.

--pfile <f> Output cumulative survival plots (P(S>x)) to ﬁle <f> in XM-

GRACE xy format. There are three plots: (1) the observed
score distribution; (2) the maximum likelihood ﬁtted distribu-
tion; (3) a maximum likelihood ﬁt to the location parameter
(mu/tau) while assuming lambda=log_2.

--xfile <f> Output the bit scores as a binary array of double-precision
ﬂoats (8 bytes per score) to ﬁle <f>. Programs like Easel’s
esl-histplot can read such binary ﬁles. This is useful when
generating extremely large sample sizes.

Options Controlling Model Conﬁguration (mode)

H3 only uses multihit local alignment ( --fs mode), and this is where we believe the
statistical ﬁts. Unihit local alignment scores (Smith/Waterman; --sw mode) also obey
our statistical conjectures. Glocal alignment statistics (either multihit or unihit) are
still not adequately understood nor adequately ﬁtted.

--fs Collect multihit local alignment scores. This is the default.

"fs" comes from HMMER2’s historical terminology for multi-
hit local alignment as ’fragment search mode’.

hmmer user’s guide

111

--sw Collect unihit local alignment scores. The H3 J state is dis-
abled. "sw" comes from HMMER2’s historical terminology
for unihit local alignment as ’Smith/Waterman search mode’.

--ls Collect multihit glocal alignment scores. In glocal (global/local)
alignment, the entire model must align, to a subsequence of
the target. The H3 local entry/exit transition probabilities are
disabled. ’ls’ comes from HMMER2’s historical terminology
for multihit local alignment as ’local search mode’.

--s Collect unihit glocal alignment scores. Both the H3 J state

and local entry/exit transition probabilities are disabled. ’s’
comes from HMMER2’s historical terminology for unihit
glocal alignment.

Options Controlling Scoring Algorithm

--vit Collect Viterbi maximum likelihood alignment scores. This is

the default.

--fwd Collect Forward log-odds likelihood scores, summed over

alignment ensemble.

--hyb Collect ’Hybrid’ scores, as described in papers by Yu and
Hwa (for instance, Bioinformatics 18:864, 2002). These in-
volve calculating a Forward matrix and taking the maximum
cell value. The number itself is statistically somewhat unmo-
tivated, but the distribution is expected be a well-behaved
extreme value distribution (Gumbel).

--msv Collect MSV (multiple ungapped segment Viterbi) scores,

using H3’s main acceleration heuristic.

--fast For any of the above options, use H3’s optimized production
implementation (using SIMD vectorization). The default is to
use the "generic" implementation (slow and non-vectorized).
The optimized implementations sacriﬁce a small amount of
numerical precision. This can introduce confounding noise
into statistical simulations and ﬁts, so when one gets super-
concerned about exact details, it’s better to be able to factor
that source of noise out.

Options Controlling Fitted Tail Masses for Forward

In some experiments, it was useful to ﬁt Forward scores to a range of different tail
masses, rather than just one. These options provide a mechanism for ﬁtting an
evenly-spaced range of different tail masses. For each different tail mass, a line is
generated in the output.

112

sean r. eddy

--tmin <x> Set the lower bound on the tail mass distribution. (The de-
fault is 0.02 for the default single tail mass.)

--tmax <x> Set the upper bound on the tail mass distribution. (The de-

fault is 0.02 for the default single tail mass.)

--tpoints <n> Set the number of tail masses to sample, starting from --tmin

and ending at --tmax. (The default is 1, for the default 0.02
single tail mass.)

--tlinear Sample a range of tail masses with uniform linear spacing.
The default is to use uniform logarithmic spacing.

Options Controlling H3 Parameter Estimation Methods

H3 uses three short random sequence simulations to estimating the location parame-
ters for the expected score distributions for MSV scores, Viterbi scores, and Forward
scores. These options allow these simulations to be modiﬁed.

--EmL <n> Sets the sequence length in simulation that estimates the
location parameter mu for MSV E-values. Default is 200.

--EmN <n> Sets the number of sequences in simulation that estimates the

location parameter mu for MSV E-values. Default is 200.

--EvL <n> Sets the sequence length in simulation that estimates the

location parameter mu for Viterbi E-values. Default is 200.

--EvN <n> Sets the number of sequences in simulation that estimates the

location parameter mu for Viterbi E-values. Default is 200.

--EfL <n> Sets the sequence length in simulation that estimates the

location parameter tau for Forward E-values. Default is 100.

--EfN <n> Sets the number of sequences in simulation that estimates the

location parameter tau for Forward E-values. Default is 200.

--Eft <x> Sets the tail mass fraction to ﬁt in the simulation that esti-
mates the location parameter tau for Forward evalues. De-
fault is 0.04.

Debugging Options

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--seed <n> Set the random number seed to <n>. The default is 0, which
makes the random number generator use an arbitrary seed,
so that different runs of hmmsim will almost certainly generate

hmmer user’s guide

113

a different statistical sample. For debugging, it is useful to
force reproducible results, by ﬁxing a random number seed.

Experimental Options

These options were used in a small variety of different exploratory experiments.

--bgflat

Set the background residue distribution to a uniform dis-
tribution, both for purposes of the null model used in cal-
culating scores, and for generating the random sequences.
The default is to use a standard amino acid background fre-
quency distribution.

--bgcomp Set the background residue distribution to the mean compo-
sition of the proﬁle. This was used in exploring some of the
effects of biased composition.

--x-no-lengthmodel Turn the H3 target sequence length model off. Set the self-
transitions for N,C,J and the null model to 350/351 instead;
this emulates HMMER2. Not a good idea in general. This
was used to demonstrate one of the main H2 vs. H3 differ-
ences.

--nu <x> Set the nu parameter for the MSV algorithm -- the expected
number of ungapped local alignments per target sequence.
The default is 2.0, corresponding to a E->J transition prob-
ability of 0.5. This was used to test whether varying nu has
signiﬁcant effect on result (it doesn’t seem to, within rea-
son). This option only works if --msv is selected (it only affects
MSV), and it will not work with --fast (because the opti-
mized implementations are hardwired to assume nu=2.0).

--pthresh <x> Set the ﬁlter P-value threshold to use in generating ﬁlter

power ﬁles with --ffile. The default is 0.02 (which would be
appropriate for testing MSV scores, since this is the default
MSV ﬁlter threshold in H3’s acceleration pipeline.) Other
appropriate choices (matching defaults in the acceleration
pipeline) would be 0.001 for Viterbi, and 1e-5 for Forward.

114

sean r. eddy

hmmstat - summary statistics for a proﬁle ﬁle

Synopsis

hmmstat [options] hmmfile

Description

The hmmstat utility prints out a tabular ﬁle of summary statistics for each proﬁle in
hmmfile.

hmmfile may be ’-’ (a dash character), in which case proﬁles are read from a stdin

pipe instead of from a ﬁle.

The columns are:

idx The index of this proﬁle, numbering each proﬁle in the ﬁle

starting from 1.

name The name of the proﬁle.

accession The optional accession of the proﬁle, or "-" if there is none.

nseq The number of sequences that the proﬁle was estimated

from.

eff_nseq The effective number of sequences that the proﬁle was es-
timated from, after HMMER applied an effective sequence
number calculation such as the default entropy weighting.

M The length of the model in consensus residues (match states).

relent Mean relative entropy per match state, in bits. This is the

expected (mean) score per consensus position. This is what
the default entropy-weighting method for effective sequence
number estimation focuses on, so for default HMMER3 mod-
els, you expect this value to reﬂect the default target for
entropy-weighting.

info Mean information content per match state, in bits. Probably
not useful. Information content is a slightly different calcula-
tion than relative entropy.

p relE Mean positional relative entropy, in bits. This is a fancier

version of the per-match-state relative entropy, taking into
account the transition (insertion/deletion) probabilities;
it may be a more accurate estimation of the average score
contributed per model consensus position.

compKL Kullback-Leibler divergence from the default background

frequency distribution to the average composition of the
proﬁle’s consensus match states, in bits. The higher this
number, the more biased the residue composition of the
proﬁle is. Highly biased proﬁles can slow the HMMER3

hmmer user’s guide

115

acceleration pipeline, by causing too many nonhomologous
sequences to pass the ﬁlters.

Options

-h Help; print a brief reminder of command line usage and all

available options.

116

sean r. eddy

jackhmmer - iteratively search sequence(s) against a sequence database

Synopsis

jackhmmer [options] seqfile seqdb

Description

jackhmmer iteratively searches each query sequence in seqfile against the target se-
quence(s) in seqdb. The ﬁrst iteration is identical to a phmmer search. For the next iter-
ation, a multiple alignment of the query together with all target sequences satisfy-
ing inclusion thresholds is assembled, a proﬁle is constructed from this alignment
(identical to using hmmbuild on the alignment), and proﬁle search of the seqdb is done
(identical to an hmmsearch with the proﬁle).

The query seqfile may be ’-’ (a dash character), in which case the query sequences

are read from a stdin pipe instead of from a ﬁle. The seqdb needs to be a ’normal’
sequence ﬁle. It cannot be read from a stdin stream, because jackhmmer needs to do
multiple passes over the database. It cannot be a compressed (gzipped) ﬁle either,
because we treat gzipped ﬁles essentially as stdin streams, calling an external decom-
pression program.

The output format is designed to be human-readable, but is often so voluminous

that reading it is impractical, and parsing it is a pain. The --tblout and --domtblout
options save output in simple tabular formats that are concise and easier to parse.
The -o option allows redirecting the main output, including throwing it away in
/dev/null.

Options

-h Help; print a brief reminder of command line usage and all

available options.

-N <n> Set the maximum number of iterations to <n>. The default is
5. If N=1, the result is equivalent to a phmmer search.

Options Controlling Output

By default, output for each iteration appears on stdout in a somewhat human read-
able, somewhat parseable format. These options allow redirecting that output or
saving additional kinds of output to ﬁles, including checkpoint ﬁles for each iteration.

-o <f> Direct the human-readable output to a ﬁle <f>.

-A <f> After the ﬁnal iteration, save an annotated multiple align-

ment of all hits satisfying inclusion thresholds (also including
the original query) to <f> in Stockholm format.

--tblout <f> After the ﬁnal iteration, save a tabular summary of top se-

quence hits to <f> in a readily parseable, columnar, whitespace-
delimited format.

hmmer user’s guide

117

--domtblout <f> After the ﬁnal iteration, save a tabular summary of top do-

main hits to <f> in a readily parseable, columnar, whitespace-
delimited format.

--chkhmm prefix At the start of each iteration, checkpoint the query HMM,

saving it to a ﬁle named prefix-n.hmm where n is the iteration
number (from 1..N).

--chkali prefix At the end of each iteration, checkpoint an alignment of

all domains satisfying inclusion thresholds (e.g. what will
become the query HMM for the next iteration), saving it to
a ﬁle named prefix-n.sto in Stockholm format, where n is the
iteration number (from 1..N).

--acc Use accessions instead of names in the main output, where

available for proﬁles and/or sequences.

--noali Omit the alignment section from the main output. This can

greatly reduce the output volume.

--notextw Unlimit the length of each line in the main output. The de-
fault is a limit of 120 characters per line, which helps in dis-
playing the output cleanly on terminals and in editors, but
can truncate target proﬁle description lines.

--textw <n> Set the main output’s line length limit to <n> characters per

line. The default is 120.

Options Controlling Single Sequence Scoring (ﬁrst Iteration)

By default, the ﬁrst iteration uses a search model constructed from a single query
sequence. This model is constructed using a standard 20x20 substitution matrix for
residue probabilities, and two additional parameters for position-independent gap
open and gap extend probabilities. These options allow the default single-sequence
scoring parameters to be changed.

--popen <x> Set the gap open probability for a single sequence query

model to <x>. The default is 0.02. <x> must be >= 0 and <
0.5.

--pextend <x> Set the gap extend probability for a single sequence query
model to <x>. The default is 0.4. <x> must be >= 0 and <
1.0.

--mx <s> Obtain residue alignment probabilities from the built-in

substitution matrix named <s>. Several standard matrices
are built-in, and do not need to be read from ﬁles. The ma-
trix name <s> can be PAM30, PAM70, PAM120, PAM240,
BLOSUM45, BLOSUM50, BLOSUM62, BLOSUM80, or BLO-
SUM90. Only one of the --mx and --mxfile options may be
used.

118

sean r. eddy

--mxfile mxfile Obtain residue alignment probabilities from the substitution
matrix in ﬁle mxfile. The default score matrix is BLOSUM62
(this matrix is internal to HMMER and does not have to be
available as a ﬁle). The format of a substitution matrix mxfile
is the standard format accepted by BLAST, FASTA, and other
sequence analysis software. See ftp.ncbi.nlm.nih.gov/blast/matrices/
for example ﬁles. (The only exception: we require matrices
to be square, so for DNA, use ﬁles like NCBI’s NUC.4.4, not
NUC.4.2.)

Options Controlling Reporting Thresholds

Reporting thresholds control which hits are reported in output ﬁles (the main output,
--tblout, and --domtblout). In each iteration, sequence hits and domain hits are ranked
by statistical signiﬁcance (E-value) and output is generated in two sections called per-
target and per-domain output. In per-target output, by default, all sequence hits with
an E-value <= 10 are reported. In the per-domain output, for each target that has
passed per-target reporting thresholds, all domains satisfying per-domain reporting
thresholds are reported. By default, these are domains with conditional E-values
of <= 10. The following options allow you to change the default E-value reporting
thresholds, or to use bit score thresholds instead.

-E <x> Report sequences with E-values <= <x> in per-sequence

output. The default is 10.0.

-T <x> Use a bit score threshold for per-sequence output instead of

an E-value threshold (any setting of -E is ignored). Report
sequences with a bit score of >= <x>. By default this option
is unset.

-Z <x> Declare the total size of the database to be <x> sequences,
for purposes of E-value calculation. Normally E-values are
calculated relative to the size of the database you actually
searched (e.g. the number of sequences in target_seqdb). In
some cases (for instance, if you’ve split your target sequence
database into multiple ﬁles for parallelization of your search),
you may know better what the actual size of your search
space is.

--domE <x> Report domains with conditional E-values <= <x> in per-
domain output, in addition to the top-scoring domain per
signiﬁcant sequence hit. The default is 10.0.

--domT <x> Use a bit score threshold for per-domain output instead of

an E-value threshold (any setting of --domE is ignored). Report
domains with a bit score of >= <x> in per-domain output, in
addition to the top-scoring domain per signiﬁcant sequence
hit. By default this option is unset.

hmmer user’s guide

119

--domZ <x> Declare the number of signiﬁcant sequences to be <x> se-

quences, for purposes of conditional E-value calculation
for additional domain signiﬁcance. Normally conditional
E-values are calculated relative to the number of sequences
passing per-sequence reporting threshold.

Options Controlling Inclusion Thresholds

Inclusion thresholds control which hits are included in the multiple alignment and
proﬁle constructed for the next search iteration. By default, a sequence must have a
per-sequence E-value of <= 0.001 (see -E option) to be included, and any additional
domains in it besides the top-scoring one must have a conditional E-value of <=
0.001 (see --domE option). The difference between reporting thresholds and inclusion
thresholds is that inclusion thresholds control which hits actually get used in the next
iteration (or the ﬁnal output multiple alignment if the -A option is used), whereas
reporting thresholds control what you see in output. Reporting thresholds are gener-
ally more loose so you can see borderline hits in the top of the noise that might be of
interest.

--incE <x> Include sequences with E-values <= <x> in subsequent itera-

tion or ﬁnal alignment output by -A. The default is 0.001.

--incT <x> Use a bit score threshold for per-sequence inclusion instead

of an E-value threshold (any setting of --incE is ignored).
Include sequences with a bit score of >= <x>. By default this
option is unset.

--incdomE <x> Include domains with conditional E-values <= <x> in sub-

sequent iteration or ﬁnal alignment output by -A, in addition
to the top-scoring domain per signiﬁcant sequence hit. The
default is 0.001.

--incdomT <x> Use a bit score threshold for per-domain inclusion instead
of an E-value threshold (any setting of --incdomE is ignored).
Include domains with a bit score of >= <x>. By default this
option is unset.

Options Controlling Acceleration Heuristics

HMMER3 searches are accelerated in a three-step ﬁlter pipeline: the MSV ﬁlter, the
Viterbi ﬁlter, and the Forward ﬁlter. The ﬁrst ﬁlter is the fastest and most approxi-
mate; the last is the full Forward scoring algorithm, slowest but most accurate. There
is also a bias ﬁlter step between MSV and Viterbi. Targets that pass all the steps in
the acceleration pipeline are then subjected to postprocessing -- domain identiﬁca-
tion and scoring using the Forward/Backward algorithm. Essentially the only free
parameters that control HMMER’s heuristic ﬁlters are the P-value thresholds con-
trolling the expected fraction of nonhomologous sequences that pass the ﬁlters. Set-
ting the default thresholds higher will pass a higher proportion of nonhomologous

120

sean r. eddy

sequence, increasing sensitivity at the expense of speed; conversely, setting lower P-
value thresholds will pass a smaller proportion, decreasing sensitivity and increasing
speed. Setting a ﬁlter’s P-value threshold to 1.0 means it will passing all sequences,
and effectively disables the ﬁlter. Changing ﬁlter thresholds only removes or includes
targets from consideration; changing ﬁlter thresholds does not alter bit scores, E-
values, or alignments, all of which are determined solely in postprocessing.

--max Maximum sensitivity. Turn off all ﬁlters, including the bias

ﬁlter, and run full Forward/Backward postprocessing on
every target. This increases sensitivity slightly, at a large cost
in speed.

--F1 <x> First ﬁlter threshold; set the P-value threshold for the MSV
ﬁlter step. The default is 0.02, meaning that roughly 2% of
the highest scoring nonhomologous targets are expected to
pass the ﬁlter.

--F2 <x> Second ﬁlter threshold; set the P-value threshold for the

Viterbi ﬁlter step. The default is 0.001.

--F3 <x> Third ﬁlter threshold; set the P-value threshold for the For-

ward ﬁlter step. The default is 1e-5.

--nobias Turn off the bias ﬁlter. This increases sensitivity somewhat,
but can come at a high cost in speed, especially if the query
has biased residue composition (such as a repetitive sequence
region, or if it is a membrane protein with large regions of
hydrophobicity). Without the bias ﬁlter, too many sequences
may pass the ﬁlter with biased queries, leading to slower
than expected performance as the computationally intensive
Forward/Backward algorithms shoulder an abnormally
heavy load.

Options Controlling Proﬁle Construction (later Iterations)

jackhmmer always includes your original query sequence in the alignment result at ev-
ery iteration, and consensus positions are always deﬁned by that query sequence.
That is, a jackhmmer proﬁle is always the same length as your original query, at every
iteration. Therefore jackhmmer gives you less control over proﬁle construction than
hmmbuild does; it does not have the --fast, or --hand, or --symfrac options. The only pro-
ﬁle construction option available in jackhmmer is --fragthresh:

--fragthresh <x> We only want to count terminal gaps as deletions if the

aligned sequence is known to be full-length, not if it is a frag-
ment (for instance, because only part of it was sequenced).
HMMER uses a simple rule to infer fragments: if the se-
quence length L is less than or equal to a fraction <x> times
the alignment length in columns, then the sequence is han-
dled as a fragment. The default is 0.5. Setting --fragthresh 0

hmmer user’s guide

121

will deﬁne no (nonempty) sequence as a fragment; you might
want to do this if you know you’ve got a carefully curated
alignment of full-length sequences. Setting --fragthresh 1
will deﬁne all sequences as fragments; you might want to
do this if you know your alignment is entirely composed of
fragments, such as translated short reads in metagenomic
shotgun data.

Options Controlling Relative Weights

Whenever a proﬁle is built from a multiple alignment, HMMER uses an ad hoc se-
quence weighting algorithm to downweight closely related sequences and upweight
distantly related ones. This has the effect of making models less biased by uneven
phylogenetic representation. For example, two identical sequences would typically
each receive half the weight that one sequence would (and this is why jackhmmer isn’t
concerned about always including your original query sequence in each iteration’s
alignment, even if it ﬁnds it again in the database you’re searching). These options
control which algorithm gets used.

--wpb Use the Henikoff position-based sequence weighting scheme

[Henikoff and Henikoff, J. Mol. Biol. 243:574, 1994]. This is
the default.

--wgsc Use the Gerstein/Sonnhammer/Chothia weighting algorithm

[Gerstein et al, J. Mol. Biol. 235:1067, 1994].

--wblosum Use the same clustering scheme that was used to weight data

in calculating BLOSUM substitution matrices [Henikoff and
Henikoff, Proc. Natl. Acad. Sci 89:10915, 1992]. Sequences
are single-linkage clustered at an identity threshold (default
0.62; see --wid) and within each cluster of c sequences, each
sequence gets relative weight 1/c.

--wnone No relative weights. All sequences are assigned uniform

weight.

--wid <x> Sets the identity threshold used by single-linkage cluster-

ing when using --wblosum. Invalid with any other weighting
scheme. Default is 0.62.

Options Controlling Effective Sequence Number

After relative weights are determined, they are normalized to sum to a total effective
sequence number, eff_nseq. This number may be the actual number of sequences in
the alignment, but it is almost always smaller than that. The default entropy weight-
ing method (--eent) reduces the effective sequence number to reduce the information
content (relative entropy, or average expected score on true homologs) per consensus
position. The target relative entropy is controlled by a two-parameter function, where
the two parameters are settable with --ere and --esigma.

122

sean r. eddy

--eent Adjust effective sequence number to achieve a speciﬁc rela-

tive entropy per position (see --ere). This is the default.

--eclust Set effective sequence number to the number of single-

linkage clusters at a speciﬁc identity threshold (see --eid).
This option is not recommended; it’s for experiments evaluat-
ing how much better --eent is.

--enone Turn off effective sequence number determination and

just use the actual number of sequences. One reason you
might want to do this is to try to maximize the relative en-
tropy/position of your model, which may be useful for short
models.

--eset <x> Explicitly set the effective sequence number for all models to

<x>.

--ere <x> Set the minimum relative entropy/position target to <x>.

Requires --eent. Default depends on the sequence alphabet;
for protein sequences, it is 0.59 bits/position.

--esigma <x> Sets the minimum relative entropy contributed by an entire
model alignment, over its whole length. This has the effect
of making short models have higher relative entropy per
position than --ere alone would give. The default is 45.0 bits.

--eid <x> Sets the fractional pairwise identity cutoff used by single
linkage clustering with the --eclust option. The default is
0.62.

Options Controlling Priors

In proﬁle construction, by default, weighted counts are converted to mean poste-
rior probability parameter estimates using mixture Dirichlet priors. Default mixture
Dirichlet prior parameters for protein models and for nucleic acid (RNA and DNA)
models are built in. The following options allow you to override the default priors.

--pnone Don’t use any priors. Probability parameters will simply be
the observed frequencies, after relative sequence weighting.

--plaplace Use a Laplace +1 prior in place of the default mixture Dirich-

let prior.

Options Controlling E-value Calibration

Estimating the location parameters for the expected score distributions for MSV ﬁlter
scores, Viterbi ﬁlter scores, and Forward scores requires three short random sequence
simulations.

--EmL <n> Sets the sequence length in simulation that estimates the
location parameter mu for MSV ﬁlter E-values. Default is
200.

hmmer user’s guide

123

--EmN <n> Sets the number of sequences in simulation that estimates

the location parameter mu for MSV ﬁlter E-values. Default is
200.

--EvL <n> Sets the sequence length in simulation that estimates the

location parameter mu for Viterbi ﬁlter E-values. Default is
200.

--EvN <n> Sets the number of sequences in simulation that estimates the

location parameter mu for Viterbi ﬁlter E-values. Default is
200.

--EfL <n> Sets the sequence length in simulation that estimates the

location parameter tau for Forward E-values. Default is 100.

--EfN <n> Sets the number of sequences in simulation that estimates the

location parameter tau for Forward E-values. Default is 200.

--Eft <x> Sets the tail mass fraction to ﬁt in the simulation that esti-
mates the location parameter tau for Forward evalues. De-
fault is 0.04.

Other Options

--nonull2 Turn off the null2 score corrections for biased composition.

-Z <x> Assert that the total number of targets in your searches is

<x>, for the purposes of per-sequence E-value calculations,
rather than the actual number of targets seen.

--domZ <x> Assert that the total number of targets in your searches is
<x>, for the purposes of per-domain conditional E-value
calculations, rather than the number of targets that passed
the reporting thresholds.

--seed <n> Seed the random number generator with <n>, an integer

>= 0. If <n> is >0, any stochastic simulations will be repro-
ducible; the same command will give the same results. If <n>
is 0, the random number generator is seeded arbitrarily, and
stochastic simulations will vary from run to run of the same
command. The default seed is 42.

--qformat <s> Assert that input query seqfile is in format <s>, bypassing

format autodetection. Common choices for <s> include:
fasta, embl, genbank. Alignment formats also work; common
choices include: stockholm, a2m, afa, psiblast, clustal, phylip.
jackhmmer always uses a single sequence query to start its
search, so when the input seqfile is an alignment, jackhmmer
reads it one unaligned query sequence at a time, not as an
alignment. For more information, and for codes for some less
common formats, see main documentation. The string <s> is
case-insensitive (fasta or FASTA both work).

124

sean r. eddy

--tformat <s> Assert that the input target sequence seqdb is in format <s>.

See --qformat above for accepted choices for <s>.

--cpu <n> Set the number of parallel worker threads to <n>. On mul-
ticore machines, the default is 2. You can also control this
number by setting an environment variable, HMMER_NCPU. There
is also a master thread, so the actual number of threads that
HMMER spawns is <n>+1. This option is not available if
HMMER was compiled with POSIX threads support turned
off.

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--mpi Run under MPI control with master/worker parallelization
(using mpirun, for example, or equivalent). Only available if
optional MPI support was enabled at compile-time.

hmmer user’s guide

125

makehmmerdb - build nhmmer database from a sequence ﬁle

Synopsis

makehmmerdb [options] seqfile binaryfile

Description

makehmmerdb is used to create a binary ﬁle from a DNA sequence ﬁle. This binary ﬁle
may be used as a target database for the DNA search tool nhmmer. Using default set-
tings in nhmmer, this yields a roughly 10-fold acceleration with small loss of sensitivity
on benchmarks.

Options

Other Options

-h Help; print a brief reminder of command line usage and all

available options.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--bin_length <n> Bin length. The binary ﬁle depends on a data structure called

the FM index, which organizes a permuted copy of the se-
quence in bins of length <n>. Longer bin length will lead to
smaller ﬁles (because data is captured about each bin) and
possibly slower query time. The default is 256. Much more
than 512 may lead to notable reduction in speed.

--sa_freq <n> Sufﬁx array sample rate. The FM index structure also sam-

ples from the underlying sufﬁx array for the sequence database.
More frequent sampling (smaller value for <n>) will yield
larger ﬁle size and faster search (until ﬁle size becomes large
enough to cause I/O to be a bottleneck). The default value is
8. Must be a power of 2.

--block_size <n> The input sequence is broken into blocks of size <n> mil-

lion letters. An FM index is built for each block, rather than
building an FM index for the entire sequence database. De-
fault is 50. Larger blocks do not seem to yield substantial
speed increase.

126

sean r. eddy

nhmmer - search DNA queries against a DNA sequence database

Synopsis

nhmmer [options] queryfile seqdb

Description

nhmmer is used to search one or more nucleotide queries against a nucleotide sequence
database. For each query in queryfile, use that query to search the target database
of sequences in seqdb, and output a ranked list of the hits with the most signiﬁcant
matches to the query. A query may be either a proﬁle model built using hmmbuild, a
sequence alignment, or a single sequence. Sequence based queries can be in a number
of formats (see --qformat), and can typically be autodetected. Note that only Stock-
holm format supports queries made up of more than one sequence alignment.

Either the query queryfile or the target seqdb may be ’-’ (a dash character), in which
case the query ﬁle or target database input will be read from a <stdin> pipe instead
of from a ﬁle. Only one input source can come through <stdin>, not both. If the
queryfile contains more than one query, then seqdb cannot come from stdin, because
we can’t rewind the streaming target database to search it with another proﬁle.

If the query is sequence-based (unaligned or aligned), a new ﬁle containing the
HMM(s) built from the input(s) in queryfile may optionally be produced, with the
ﬁlename set using the --hmmout ﬂag.

The output format is designed to be human-readable, but is often so voluminous
that reading it is impractical, and parsing it is a pain. The --tblout option saves out-
put in a simple tabular format that is concise and easier to parse. The -o option al-
lows redirecting the main output, including throwing it away in /dev/null.

Options

-h Help; print a brief reminder of command line usage and all

available options.

Options for Controlling Output

-o <f> Direct the main human-readable output to a ﬁle <f> instead

of the default stdout.

-A <f> Save a multiple alignment of all signiﬁcant hits (those satisfy-

ing "inclusion thresholds") to the ﬁle <f>.

--tblout <f> Save a simple tabular (space-delimited) ﬁle summarizing the
per-target output, with one data line per homologous target
sequence found.

--dfamtblout <f> Save a tabular (space-delimited) ﬁle summarizing the per-hit
output, similar to --tblout but more succinct.

hmmer user’s guide

127

--aliscoresout <f> Save to ﬁle a list of per-position scores for each hit. This

is useful, for example, in identifying regions of high score
density for use in resolving overlapping hits from different
models.

--hmmout <f> If queryfile is sequence-based, write the internally-computed

HMM(s) to ﬁle <f>.

--acc Use accessions instead of names in the main output, where

available for proﬁles and/or sequences.

--noali Omit the alignment section from the main output. This can

greatly reduce the output volume.

--notextw Unlimit the length of each line in the main output. The de-
fault is a limit of 120 characters per line, which helps in dis-
playing the output cleanly on terminals and in editors, but
can truncate target proﬁle description lines.

--textw <n> Set the main output’s line length limit to <n> characters per

line. The default is 120.

Options Controlling Single Sequence Scoring

By default, if a query is a single sequence from a ﬁle in fasta format, nhmmer uses
a search model constructed from that sequence and a standard 20x20 substitution
matrix for residue probabilities, along with two additional parameters for position-
independent gap open and gap extend probabilities. These options allow the default
single-sequence scoring parameters to be changed, and for single-sequence scoring
options to be applied to a single sequence coming from an aligned format.

--singlemx

If a single sequence query comes from a multiple sequence
alignment ﬁle, such as in Stockholm format, the search model
is by default constructed as is typically done for multiple
sequence alignments. This option forces nhmmer to use the
single-sequence method with substitution score matrix.

--mxfile<mxfile Obtain residue alignment probabilities from the substitution
matrix in ﬁle mxfile. The default score matrix is DNA1 (this
matrix is internal to HMMER and does not have to be avail-
able as a ﬁle). The format of a substitution matrix mxfile is the
standard format accepted by BLAST, FASTA, and other se-
quence analysis software. See ftp.ncbi.nlm.nih.gov/blast/matrices/
for example ﬁles. (The only exception: we require matrices
to be square, so for DNA, use ﬁles like NCBI’s NUC.4.4, not
NUC.4.2.)

--popen <x> Set the gap open probability for a single sequence query

model to <x>. The default is 0.02. <x> must be >= 0 and <
0.5.

128

sean r. eddy

--pextend <x> Set the gap extend probability for a single sequence query
model to <x>. The default is 0.4. <x> must be >= 0 and <
1.0.

Options Controlling Reporting Thresholds

Reporting thresholds control which hits are reported in output ﬁles (the main output,
--tblout, and --dfamtblout). Hits are ranked by statistical signiﬁcance (E-value).

-E <x> Report target sequences with an E-value of <= <x>. The de-
fault is 10.0, meaning that on average, about 10 false positives
will be reported per query, so you can see the top of the noise
and decide for yourself if it’s really noise.

-T <x> Instead of thresholding output on E-value, instead report

target sequences with a bit score of >= <x>.

Options for Inclusion Thresholds

Inclusion thresholds are stricter than reporting thresholds. Inclusion thresholds con-
trol which hits are considered to be reliable enough to be included in an output
alignment or a subsequent search round, or marked as signiﬁcant ("!") as opposed
to questionable ("?") in hit output.

--incE <x> Use an E-value of <= <x> as the inclusion threshold. The de-

fault is 0.01, meaning that on average, about 1 false positive
would be expected in every 100 searches with different query
sequences.

--incT <x> Instead of using E-values for setting the inclusion thresh-

old, use a bit score of >= <x> as the inclusion threshold. By
default this option is unset.

Options for Model-speciﬁc Score Thresholding

Curated proﬁle databases may deﬁne speciﬁc bit score thresholds for each proﬁle,
superseding any thresholding based on statistical signiﬁcance alone. To use these op-
tions, the proﬁle must contain the appropriate (GA, TC, and/or NC) optional score
threshold annotation; this is picked up by hmmbuild from Stockholm format alignment
ﬁles. For a nucleotide model, each thresholding option has a single per-hit thresh-
old <x> This acts as if -T <x> --incT <x> has been applied speciﬁcally using each
model’s curated thresholds.

--cut_ga Use the GA (gathering) bit score threshold in the model to

set per-hit reporting and inclusion thresholds. GA thresholds
are generally considered to be the reliable curated thresholds
deﬁning family membership; for example, in Dfam, these
thresholds are applied when annotating a genome with a

hmmer user’s guide

129

model of a family known to be found in that organism. They
may allow for minimal expected false discovery rate.

--cut_nc Use the NC (noise cutoff) bit score threshold in the model

to set per-hit reporting and inclusion thresholds. NC thresh-
olds are less stringent than GA; in the context of Pfam, they
are generally used to store the score of the highest-scoring
known false positive.

--cut_tc Use the TC (trusted cutoff) bit score threshold in the model
to set per-hit reporting and inclusion thresholds. TC thresh-
olds are more stringent than GA, and are generally consid-
ered to be the score of the lowest-scoring known true positive
that is above all known false positives; for example, in Dfam,
these thresholds are applied when annotating a genome with
a model of a family not known to be found in that organism.

Options Controlling the Acceleration Pipeline

HMMER3 searches are accelerated in a three-step ﬁlter pipeline: the scanning-SSV
ﬁlter, the Viterbi ﬁlter, and the Forward ﬁlter. The ﬁrst ﬁlter is the fastest and most
approximate; the last is the full Forward scoring algorithm. There is also a bias ﬁl-
ter step between SSV and Viterbi. Targets that pass all the steps in the acceleration
pipeline are then subjected to postprocessing -- domain identiﬁcation and scoring
using the Forward/Backward algorithm. Changing ﬁlter thresholds only removes
or includes targets from consideration; changing ﬁlter thresholds does not alter bit
scores, E-values, or alignments, all of which are determined solely in postprocessing.

--max Turn off (nearly) all ﬁlters, including the bias ﬁlter, and run

full Forward/Backward postprocessing on most of the target
sequence. In contrast to phmmer and hmmsearch, where this ﬂag
really does turn off the ﬁlters entirely, the --max ﬂag in nhmmer
sets the scanning-SSV ﬁlter threshold to 0.4, not 1.0. Use of
this ﬂag increases sensitivity somewhat, at a large cost in
speed.

--F1 <x> Set the P-value threshold for the SSV ﬁlter step. The default
is 0.02, meaning that roughly 2% of the highest scoring non-
homologous targets are expected to pass the ﬁlter.

--F2 <x> Set the P-value threshold for the Viterbi ﬁlter step. The de-

fault is 0.001.

--F3 <x> Set the P-value threshold for the Forward ﬁlter step. The

default is 1e-5.

--nobias Turn off the bias ﬁlter. This increases sensitivity somewhat,
but can come at a high cost in speed, especially if the query
has biased residue composition (such as a repetitive sequence
region, or if it is a membrane protein with large regions of

130

sean r. eddy

hydrophobicity). Without the bias ﬁlter, too many sequences
may pass the ﬁlter with biased queries, leading to slower
than expected performance as the computationally intensive
Forward/Backward algorithms shoulder an abnormally
heavy load.

Options for Specifying the Alphabet

--dna Assert that sequences in msafile are DNA, bypassing alphabet

autodetection.

--rna Assert that sequences in msafile are RNA, bypassing alphabet

autodetection.

Options Controlling Seed Search Heuristic

When searching with nhmmer, one may optionally precompute a binary version of
the target database, using makehmmerdb, then search against that database. Using de-
fault settings, this yields a roughly 10-fold acceleration with small loss of sensitivity
on benchmarks. This is achieved using a heuristic method that searches for seeds
(ungapped alignments) around which full processing is done. This is essentially a
replacement to the SSV stage. (This method has been extensively tested, but should
still be treated as somewhat experimental.) The following options only impact nhmmer
if the value of --tformat is hmmerdb. Changing parameters for this seed-ﬁnding step will
impact both speed and sensitivity - typically faster search leads to lower sensitivity.

--seed_max_depth <n> The seed step requires that a seed reach a speciﬁed bit score

in length no longer than <n>. By default, this value is 15.
Longer seeds allow a greater chance of meeting the bit score
threshold, leading to diminished ﬁltering (greater sensitivity,
slower run time).

--seed_sc_thresh <x> The seed must reach score <x> (in bits). The default is 15.0

bits. A higher threshold increases ﬁltering stringency, leading
to faster run times and lower sensitivity.

--seed_sc_density <x> Either all preﬁxes or all sufﬁxes of a seed must have bit den-

sity (bits per aligned position) of at least <x>. The default
is 0.8 bits/position. An increase in the density requirement
leads to increased ﬁltering stringency, thus faster run times
and lower sensitivity.

--seed_drop_max_len <n> A seed may not have a run of length <n> in which the score
drops by --seed_drop_lim or more. Basically, this prunes seeds
that go through long slightly-negative seed extensions. The
default is 4. Increasing the limit causes (slightly) diminished
ﬁltering efﬁciency, thus slower run times and higher sensitiv-
ity. (minor tuning option)

hmmer user’s guide

131

--seed_drop_lim <x> In a seed, there may be no run of length --seed_drop_max_len
in which the score drops by --seed_drop_lim. The default is
0.3 bits. Larger numbers mean less ﬁltering. (minor tuning
option)

--seed_req_pos <n> A seed must contain a run of at least <n> positive-scoring

matches. The default is 5. Larger values mean increased
ﬁltering. (minor tuning option)

--seed_ssv_length <n> After ﬁnding a short seed, an ungapped alignment is ex-

tended in both directions in an attempt to meet the --F1 score
threshold. The window through which this ungapped align-
ment extends is length <n>. The default is 70. Decreasing
this value slightly reduces run time, at a small risk of re-
duced sensitivity. (minor tuning option)

Other Options

--qformat <s> Assert that input queryfile is a sequence ﬁle (unaligned or
aligned), in format <s>, bypassing format autodetection.
Common choices for <s> include: fasta, embl, genbank. Align-
ment formats also work, and will serve as the basis for auto-
matic creation of a proﬁle HMM used for searching; common
choices include: stockholm, a2m, afa, psiblast, clustal, phylip.
For more information, and for codes for some less common
formats, see main documentation.

--qsingle_seqs Force queryfile to be read as individual sequences, even if it
is in an msa format. For example, if the input is in aligned
stockholm format, the --qsingle_seqs ﬂag will cause each se-
quence in that alignment to be used as a separate query
sequence.

--tformat <s> Assert that target sequence database seqdb is in format <s>,
bypassing format autodetection. Common choices for <s>
include: fasta, embl, genbank, fmindex. Alignment formats also
work; common choices include: stockholm, a2m, afa, psiblast,
clustal, phylip. For more information, and for codes for some
less common formats, see main documentation. The string
<s> is case-insensitive (fasta or FASTA both work). The for-
mat fmindex indicates that the database ﬁle is a binary ﬁle
produced using makehmmerdb.

--nonull2 Turn off the null2 score corrections for biased composition.

-Z <x> For the purposes of per-hit E-value calculations, Assert

that the total size of the target database is <x> million nu-
cleotides, rather than the actual number of targets seen.

132

sean r. eddy

--seed <n> Set the random number seed to <n>. Some steps in postpro-

cessing require Monte Carlo simulation. The default is to
use a ﬁxed seed (42), so that results are exactly reproducible.
Any other positive integer will give different (but also re-
producible) results. A choice of 0 uses a randomly chosen
seed.

--w_beta <x> Window length tail mass. The upper bound, W, on the length
at which nhmmer expects to ﬁnd an instance of the model is
set such that the fraction of all sequences generated by the
model with length >= W is less than <x>. The default is 1e-7.
This ﬂag may be used to override the value of W established
for the model by hmmbuild, or when the query is sequence-
based.

--w_length <n> Override the model instance length upper bound, W, which
is otherwise controlled by --w_beta. It should be larger than
the model length. The value of W is used deep in the accel-
eration pipeline, and modest changes are not expected to
impact results (though larger values of W do lead to longer
run time). This ﬂag may be used to override the value of W
established for the model by hmmbuild, or when the query is
sequence-based.

--watson Only search the top strand. By default both the query se-
quence and its reverse-complement are searched.

--crick Only search the bottom (reverse-complement) strand. By

default both the query sequence and its reverse-complement
are searched.

--cpu <n> Set the number of parallel worker threads to <n>. On mul-
ticore machines, the default is 2. You can also control this
number by setting an environment variable, HMMER_NCPU. There
is also a master thread, so the actual number of threads that
HMMER spawns is <n>+1. This option is not available if
HMMER was compiled with POSIX threads support turned
off.

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--mpi Run under MPI control with master/worker parallelization
(using mpirun, for example, or equivalent). Only available if
optional MPI support was enabled at compile-time.

hmmer user’s guide

133

nhmmscan - search DNA sequence(s) against a DNA proﬁle database

Synopsis

nhmmscan [options] hmmdb seqfile

Description

nhmmscan is used to search nucleotide sequences against collections of nucleotide
proﬁles. For each sequence in seqfile, use that query sequence to search the target
database of proﬁles in hmmdb, and output ranked lists of the proﬁles with the most
signiﬁcant matches to the sequence.

The seqfile may contain more than one query sequence. It can be in FASTA format,

or several other common sequence ﬁle formats (genbank, embl, and uniprot, among
others), or in alignment ﬁle formats (stockholm, aligned fasta, and others). See the
--qformat option for a complete list.

The hmmdb needs to be press’ed using hmmpress before it can be searched with nhmmscan.

This creates four binary ﬁles, sufﬁxed .h3{fimp}.

The query seqfile may be ’-’ (a dash character), in which case the query sequences

are read from a stdin pipe instead of from a ﬁle. The hmmdb cannot be read from a
stdin stream, because it needs to have the four auxiliary binary ﬁles generated by
hmmpress.

The output format is designed to be human-readable, but is often so voluminous
that reading it is impractical, and parsing it is a pain. The --tblout option saves out-
put in a simple tabular format that is concise and easier to parse. The -o option al-
lows redirecting the main output, including throwing it away in /dev/null.

Options

-h Help; print a brief reminder of command line usage and all

available options.

Options for Controlling Output

-o <f> Direct the main human-readable output to a ﬁle <f> instead

of the default stdout.

--tblout <f> Save a simple tabular (space-delimited) ﬁle summarizing

the per-hit output, with one data line per homologous target
model hit found.

--dfamtblout <f> Save a tabular (space-delimited) ﬁle summarizing the per-hit
output, similar to --tblout but more succinct.

--aliscoresout <f> Save to ﬁle a list of per-position scores for each hit. This

is useful, for example, in identifying regions of high score
density for use in resolving overlapping hits from different
models.

134

sean r. eddy

--acc Use accessions instead of names in the main output, where

available for proﬁles and/or sequences.

--noali Omit the alignment section from the main output. This can

greatly reduce the output volume.

--notextw Unlimit the length of each line in the main output. The de-
fault is a limit of 120 characters per line, which helps in dis-
playing the output cleanly on terminals and in editors, but
can truncate target proﬁle description lines.

--textw <n> Set the main output’s line length limit to <n> characters per

line. The default is 120.

Options for Reporting Thresholds

Reporting thresholds control which hits are reported in output ﬁles (the main output,
--tblout, and --dfamtblout). Hits are ranked by statistical signiﬁcance (E-value).

-E <x> Report target proﬁles with an E-value of <= <x>. The default
is 10.0, meaning that on average, about 10 false positives will
be reported per query, so you can see the top of the noise and
decide for yourself if it’s really noise.

-T <x> Instead of thresholding output on E-value, instead report

target proﬁles with a bit score of >= <x>.

Options for Inclusion Thresholds

Inclusion thresholds are stricter than reporting thresholds. Inclusion thresholds con-
trol which hits are considered to be reliable enough to be included in an output align-
ment or a subsequent search round. In nhmmscan, which does not have any alignment
output (like nhmmer), inclusion thresholds have little effect. They only affect what hits
get marked as signiﬁcant (!) or questionable (?) in hit output.

--incE <x> Use an E-value of <= <x> as the inclusion threshold. The de-

fault is 0.01, meaning that on average, about 1 false positive
would be expected in every 100 searches with different query
sequences.

--incT <x> Instead of using E-values for setting the inclusion threshold,

use a bit score of >= <x> as the inclusion threshold. It would
be unusual to use bit score thresholds with hmmscan, because
you don’t expect a single score threshold to work for differ-
ent proﬁles; different proﬁles have slightly different expected
score distributions.

Options for Model-speciﬁc Score Thresholding

Curated proﬁle databases may deﬁne speciﬁc bit score thresholds for each proﬁle,
superseding any thresholding based on statistical signiﬁcance alone. To use these op-

hmmer user’s guide

135

tions, the proﬁle must contain the appropriate (GA, TC, and/or NC) optional score
threshold annotation; this is picked up by hmmbuild from Stockholm format alignment
ﬁles. For a nucleotide model, each thresholding option has a single per-hit thresh-
old <x> This acts as if -T <x> --incT <x> has been applied speciﬁcally using each
model’s curated thresholds.

--cut_ga Use the GA (gathering) bit score threshold in the model to

set per-hit reporting and inclusion thresholds. GA thresholds
are generally considered to be the reliable curated thresholds
deﬁning family membership; for example, in Dfam, these
thresholds are applied when annotating a genome with a
model of a family known to be found in that organism. They
may allow for minimal expected false discovery rate.

--cut_nc Use the NC (noise cutoff) bit score threshold in the model

to set per-hit reporting and inclusion thresholds. NC thresh-
olds are less stringent than GA; in the context of Pfam, they
are generally used to store the score of the highest-scoring
known false positive.

--cut_tc Use the TC (trusted cutoff) bit score threshold in the model
to set per-hit reporting and inclusion thresholds. TC thresh-
olds are more stringent than GA, and are generally consid-
ered to be the score of the lowest-scoring known true positive
that is above all known false positives; for example, in Dfam,
these thresholds are applied when annotating a genome with
a model of a family not known to be found in that organism.

Control of the Acceleration Pipeline

HMMER3 searches are accelerated in a three-step ﬁlter pipeline: the scanning-SSV
ﬁlter, the Viterbi ﬁlter, and the Forward ﬁlter. The ﬁrst ﬁlter is the fastest and most
approximate; the last is the full Forward scoring algorithm. There is also a bias ﬁl-
ter step between SSV and Viterbi. Targets that pass all the steps in the acceleration
pipeline are then subjected to postprocessing -- domain identiﬁcation and scoring
using the Forward/Backward algorithm. Changing ﬁlter thresholds only removes
or includes targets from consideration; changing ﬁlter thresholds does not alter bit
scores, E-values, or alignments, all of which are determined solely in postprocessing.

--max Turn off (nearly) all ﬁlters, including the bias ﬁlter, and run

full Forward/Backward postprocessing on most of the target
sequence. In contrast to hmmscan, where this ﬂag really does
turn off the ﬁlters entirely, the --max ﬂag in nhmmscan sets the
scanning-SSV ﬁlter threshold to 0.4, not 1.0. Use of this ﬂag
increases sensitivity somewhat, at a large cost in speed.

--F1 <x> Set the P-value threshold for the MSV ﬁlter step. The de-

fault is 0.02, meaning that roughly 2% of the highest scoring

136

sean r. eddy

nonhomologous targets are expected to pass the ﬁlter.

--F2 <x> Set the P-value threshold for the Viterbi ﬁlter step. The de-

fault is 0.001.

--F3 <x> Set the P-value threshold for the Forward ﬁlter step. The

default is 1e-5.

--nobias Turn off the bias ﬁlter. This increases sensitivity somewhat,
but can come at a high cost in speed, especially if the query
has biased residue composition (such as a repetitive sequence
region, or if it is a membrane protein with large regions of
hydrophobicity). Without the bias ﬁlter, too many sequences
may pass the ﬁlter with biased queries, leading to slower
than expected performance as the computationally intensive
Forward/Backward algorithms shoulder an abnormally
heavy load.

Other Options

--nonull2 Turn off the null2 score corrections for biased composition.

-Z <x> Assert that the total number of targets in your searches is

<x>, for the purposes of per-sequence E-value calculations,
rather than the actual number of targets seen.

--seed <n> Set the random number seed to <n>. Some steps in postpro-

cessing require Monte Carlo simulation. The default is to
use a ﬁxed seed (42), so that results are exactly reproducible.
Any other positive integer will give different (but also re-
producible) results. A choice of 0 uses an arbitrarily chosen
seed.

--qformat <s> Assert that input query seqfile is in format <s>, bypassing

format autodetection. Common choices for <s> include:
fasta, embl, genbank. Alignment formats also work; common
choices include: stockholm, a2m, afa, psiblast, clustal, phylip.
For more information, and for codes for some less common
formats, see main documentation. The string <s> is case-
insensitive (fasta or FASTA both work).

--w_beta <x> Window length tail mass. The upper bound, W, on the length
at which nhmmer expects to ﬁnd an instance of the model is
set such that the fraction of all sequences generated by the
model with length >= W is less than <x>. The default is 1e-7.
This ﬂag may be used to override the value of W established
for the model by hmmbuild.

--w_length <n> Override the model instance length upper bound, W, which
is otherwise controlled by --w_beta. It should be larger than

hmmer user’s guide

137

the model length. The value of W is used deep in the accel-
eration pipeline, and modest changes are not expected to
impact results (though larger values of W do lead to longer
run time). This ﬂag may be used to override the value of W
established for the model by hmmbuild.

--watson Only search the top strand. By default both the query se-
quence and its reverse-complement are searched.

--crick Only search the bottom (reverse-complement) strand. By

default both the query sequence and its reverse-complement
are searched.

--cpu <n> Set the number of parallel worker threads to <n>. The de-
fault is 0, meaning off (no thread-level parallelization), be-
cause nhmmscan is typically i/o bound and the extra overhead
of our current multithreaded implementation isn’t worth-
while. You can also control this number by setting an envi-
ronment variable, HMMER_NCPU. There is also a master thread, so
the actual number of threads that HMMER spawns is at least
<n>+1. This option is not available if HMMER was compiled
with POSIX threads support turned off.

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--mpi Run under MPI control with master/worker parallelization
(using mpirun, for example, or equivalent). Only available if
optional MPI support was enabled at compile-time.

138

sean r. eddy

phmmer - search protein sequence(s) against a protein sequence database

Synopsis

phmmer [options] seqfile seqdb

Description

phmmer is used to search one or more query protein sequences against a protein se-
quence database. For each query sequence in seqfile, use that sequence to search the
target database of sequences in seqdb, and output ranked lists of the sequences with
the most signiﬁcant matches to the query.

Either the query seqfile or the target seqdb may be ’-’ (a dash character), in which
case the query sequences or target database input will be read from a <stdin> pipe
instead of from a ﬁle. Only one input source can come through <stdin>, not both.
An exception is that if the seqfile contains more than one query sequence, then seqdb
cannot come from <stdin>, because we can’t rewind the streaming target database to
search it with another query.

The output format is designed to be human-readable, but is often so voluminous

that reading it is impractical, and parsing it is a pain. The --tblout and --domtblout
options save output in simple tabular formats that are concise and easier to parse.
The -o option allows redirecting the main output, including throwing it away in
/dev/null.

Options

-h Help; print a brief reminder of command line usage and all

available options.

Options for Controlling Output

-o <f> Direct the main human-readable output to a ﬁle <f> instead

of the default stdout.

-A <f> Save a multiple alignment of all signiﬁcant hits (those satisfy-
ing inclusion thresholds) to the ﬁle <f> in Stockholm format.

--tblout <f> Save a simple tabular (space-delimited) ﬁle summarizing the
per-target output, with one data line per homologous target
sequence found.

--domtblout <f> Save a simple tabular (space-delimited) ﬁle summarizing

the per-domain output, with one data line per homologous
domain detected in a query sequence for each homologous
model.

--acc Use accessions instead of names in the main output, where

available for proﬁles and/or sequences.

hmmer user’s guide

139

--noali Omit the alignment section from the main output. This can

greatly reduce the output volume.

--notextw Unlimit the length of each line in the main output. The de-
fault is a limit of 120 characters per line, which helps in dis-
playing the output cleanly on terminals and in editors, but
can truncate target proﬁle description lines.

--textw <n> Set the main output’s line length limit to <n> characters per

line. The default is 120.

Options Controlling Scoring System

The probability model in phmmer is constructed by inferring residue probabilities
from a standard 20x20 substitution score matrix, plus two additional parameters
for position-independent gap open and gap extend probabilities.

--popen <x> Set the gap open probability for a single sequence query

model to <x>. The default is 0.02. <x> must be >= 0 and <
0.5.

--pextend <x> Set the gap extend probability for a single sequence query
model to <x>. The default is 0.4. <x> must be >= 0 and <
1.0.

--mx <s> Obtain residue alignment probabilities from the built-in

substitution matrix named <s>. Several standard matrices
are built-in, and do not need to be read from ﬁles. The ma-
trix name <s> can be PAM30, PAM70, PAM120, PAM240,
BLOSUM45, BLOSUM50, BLOSUM62, BLOSUM80, or BLO-
SUM90. Only one of the --mx and --mxfile options may be
used.

--mxfile mxfile Obtain residue alignment probabilities from the substitution
matrix in ﬁle mxfile. The default score matrix is BLOSUM62
(this matrix is internal to HMMER and does not have to be
available as a ﬁle). The format of a substitution matrix mxfile
is the standard format accepted by BLAST, FASTA, and other
sequence analysis software. See ftp.ncbi.nlm.nih.gov/blast/matrices/
for example ﬁles. (The only exception: we require matrices
to be square, so for DNA, use ﬁles like NCBI’s NUC.4.4, not
NUC.4.2.)

Options Controlling Reporting Thresholds

Reporting thresholds control which hits are reported in output ﬁles (the main output,
--tblout, and --domtblout). Sequence hits and domain hits are ranked by statistical
signiﬁcance (E-value) and output is generated in two sections called per-target and
per-domain output. In per-target output, by default, all sequence hits with an E-value

140

sean r. eddy

<= 10 are reported. In the per-domain output, for each target that has passed per-
target reporting thresholds, all domains satisfying per-domain reporting thresholds
are reported. By default, these are domains with conditional E-values of <= 10. The
following options allow you to change the default E-value reporting thresholds, or to
use bit score thresholds instead.

-E <x> In the per-target output, report target sequences with an
E-value of <= <x>. The default is 10.0, meaning that on
average, about 10 false positives will be reported per query,
so you can see the top of the noise and decide for yourself if
it’s really noise.

-T <x> Instead of thresholding per-proﬁle output on E-value, instead
report target sequences with a bit score of >= <x>.

--domE <x> In the per-domain output, for target sequences that have

already satisﬁed the per-proﬁle reporting threshold, report
individual domains with a conditional E-value of <= <x>.
The default is 10.0. A conditional E-value means the expected
number of additional false positive domains in the smaller
search space of those comparisons that already satisﬁed the
per-target reporting threshold (and thus must have at least
one homologous domain already).

--domT <x> Instead of thresholding per-domain output on E-value, in-

stead report domains with a bit score of >= <x>.

Options Controlling Inclusion Thresholds

Inclusion thresholds are stricter than reporting thresholds. They control which hits
are included in any output multiple alignment (the -A option) and which domains
are marked as signiﬁcant ("!") as opposed to questionable ("?") in domain output.

--incE <x> Use an E-value of <= <x> as the per-target inclusion thresh-

old. The default is 0.01, meaning that on average, about 1
false positive would be expected in every 100 searches with
different query sequences.

--incT <x> Instead of using E-values for setting the inclusion threshold,
instead use a bit score of >= <x> as the per-target inclusion
threshold. By default this option is unset.

--incdomE <x> Use a conditional E-value of <= <x> as the per-domain in-
clusion threshold, in targets that have already satisﬁed the
overall per-target inclusion threshold. The default is 0.01.

--incdomT <x> Instead of using E-values, use a bit score of >= <x> as the
per-domain inclusion threshold. By default this option is
unset.

hmmer user’s guide

141

Options Controlling the Acceleration Pipeline

HMMER3 searches are accelerated in a three-step ﬁlter pipeline: the MSV ﬁlter, the
Viterbi ﬁlter, and the Forward ﬁlter. The ﬁrst ﬁlter is the fastest and most approxi-
mate; the last is the full Forward scoring algorithm, slowest but most accurate. There
is also a bias ﬁlter step between MSV and Viterbi. Targets that pass all the steps in
the acceleration pipeline are then subjected to postprocessing -- domain identiﬁca-
tion and scoring using the Forward/Backward algorithm. Essentially the only free
parameters that control HMMER’s heuristic ﬁlters are the P-value thresholds con-
trolling the expected fraction of nonhomologous sequences that pass the ﬁlters. Set-
ting the default thresholds higher will pass a higher proportion of nonhomologous
sequence, increasing sensitivity at the expense of speed; conversely, setting lower P-
value thresholds will pass a smaller proportion, decreasing sensitivity and increasing
speed. Setting a ﬁlter’s P-value threshold to 1.0 means it will passing all sequences,
and effectively disables the ﬁlter. Changing ﬁlter thresholds only removes or includes
targets from consideration; changing ﬁlter thresholds does not alter bit scores, E-
values, or alignments, all of which are determined solely in postprocessing.

--max Maximum sensitivity. Turn off all ﬁlters, including the bias

ﬁlter, and run full Forward/Backward postprocessing on
every target. This increases sensitivity slightly, at a large cost
in speed.

--F1 <x> First ﬁlter threshold; set the P-value threshold for the MSV
ﬁlter step. The default is 0.02, meaning that roughly 2% of
the highest scoring nonhomologous targets are expected to
pass the ﬁlter.

--F2 <x> Second ﬁlter threshold; set the P-value threshold for the

Viterbi ﬁlter step. The default is 0.001.

--F3 <x> Third ﬁlter threshold; set the P-value threshold for the For-

ward ﬁlter step. The default is 1e-5.

--nobias Turn off the bias ﬁlter. This increases sensitivity somewhat,
but can come at a high cost in speed, especially if the query
has biased residue composition (such as a repetitive sequence
region, or if it is a membrane protein with large regions of
hydrophobicity). Without the bias ﬁlter, too many sequences
may pass the ﬁlter with biased queries, leading to slower
than expected performance as the computationally intensive
Forward/Backward algorithms shoulder an abnormally
heavy load.

Options Controlling E-value Calibration

Estimating the location parameters for the expected score distributions for MSV ﬁlter
scores, Viterbi ﬁlter scores, and Forward scores requires three short random sequence
simulations.

142

sean r. eddy

--EmL <n> Sets the sequence length in simulation that estimates the
location parameter mu for MSV ﬁlter E-values. Default is
200.

--EmN <n> Sets the number of sequences in simulation that estimates

the location parameter mu for MSV ﬁlter E-values. Default is
200.

--EvL <n> Sets the sequence length in simulation that estimates the

location parameter mu for Viterbi ﬁlter E-values. Default is
200.

--EvN <n> Sets the number of sequences in simulation that estimates the

location parameter mu for Viterbi ﬁlter E-values. Default is
200.

--EfL <n> Sets the sequence length in simulation that estimates the

location parameter tau for Forward E-values. Default is 100.

--EfN <n> Sets the number of sequences in simulation that estimates the

location parameter tau for Forward E-values. Default is 200.

--Eft <x> Sets the tail mass fraction to ﬁt in the simulation that esti-
mates the location parameter tau for Forward evalues. De-
fault is 0.04.

Other Options

--nonull2 Turn off the null2 score corrections for biased composition.

-Z <x> Assert that the total number of targets in your searches is

<x>, for the purposes of per-sequence E-value calculations,
rather than the actual number of targets seen.

--domZ <x> Assert that the total number of targets in your searches is
<x>, for the purposes of per-domain conditional E-value
calculations, rather than the number of targets that passed
the reporting thresholds.

--seed <n> Seed the random number generator with <n>, an integer

>= 0. If <n> is >0, any stochastic simulations will be repro-
ducible; the same command will give the same results. If <n>
is 0, the random number generator is seeded arbitrarily, and
stochastic simulations will vary from run to run of the same
command. The default seed is 42.

--qformat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. phmmer always
uses a single sequence query to start its search, so when the
input seqfile is an alignment, phmmer reads it one unaligned

hmmer user’s guide

143

query sequence at a time, not as an alignment. For more in-
formation, and for codes for some less common formats, see
main documentation. The string <s> is case-insensitive (fasta
or FASTA both work). --tformat <s> Assert that target sequence
database seqdb is in format <s>, bypassing format autodetec-
tion. See --qformat above for list of accepted format codes for
<s>.

--cpu <n> Set the number of parallel worker threads to <n>. On mul-
ticore machines, the default is 2. You can also control this
number by setting an environment variable, HMMER_NCPU. There
is also a master thread, so the actual number of threads that
HMMER spawns is <n>+1. This option is not available if
HMMER was compiled with POSIX threads support turned
off.

--stall For debugging the MPI master/worker version: pause after
start, to enable the developer to attach debuggers to the run-
ning master and worker(s) processes. Send SIGCONT signal
to release the pause. (Under gdb: (gdb) signal SIGCONT) (Only
available if optional MPI support was enabled at compile-
time.)

--mpi Run under MPI control with master/worker parallelization
(using mpirun, for example, or equivalent). Only available if
optional MPI support was enabled at compile-time.

144

sean r. eddy

Manual pages for Easel miniapps

esl-afetch - retrieve alignments from a multi-MSA database

Synopsis

esl-afetch [options] msafile key
(single MSA retrieval)

esl-afetch -f [options] msafile keyfile

(multiple MSA retrieval, from a ﬁle of keys)

esl-afetch --index msafile

(index an MSA ﬁle for retrieval)

Description

esl-afetch retrieves the alignment named key from an alignment database in ﬁle
msafile. The msafile is a "multiple multiple alignment" ﬁle in Stockholm (e.g. native
Pfam or Rfam) format. The key is either the name (ID) of the alignment, or its acces-
sion number (AC).

Alternatively, esl-afetch -f provides the ability to fetch many alignments at once.
The -f option has it interpret the second argument as a keyfile, a ﬁle consisting of
one name or accession per line.

The msafile should ﬁrst be SSI indexed with esl-afetch --index for efﬁcient retrieval.

An SSI index is not required, but without one alignment retrieval may be painfully
slow.

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

-f

Interpret the second argument as a keyfile instead of as just
one key. The keyfile contains one name or accession per line.
This option doesn’t work with the --index option.

-o <f> Output retrieved alignments to a ﬁle <f> instead of to stdout.

-O Output retrieved alignment to a ﬁle named key. This is a

convenience for saving some typing: instead of

146

sean r. eddy

% esl-afetch -o RRM_1 msafile RRM_1

you can just type

% esl-afetch -O msafile RRM_1

The -O option only works if you’re retrieving a single align-
ment; it is incompatible with -f.

--index

Instead of retrieving a key, the special command esl-afetch
--index msafile produces an SSI index of the names and ac-
cessions of the alignments in the msafile. Indexing should be
done once on the msafile to prepare it for all future fetches.

hmmer user’s guide

147

esl-alimanip - manipulate a multiple sequence alignment

Synopsis

esl-alimanip [options] msafile

Description

esl-alimanip can manipulate the multiple sequence alignment(s) in msafile in various
ways. Options exist to remove speciﬁc sequences, reorder sequences, designate refer-
ence columns using Stockholm "#=GC RF" markup, and add annotation that numbers
columns.

The alignments can be of protein or DNA/RNA sequences. All alignments in the
same msafile must be either protein or DNA/RNA. The alphabet will be autodetected
unless one of the options --amino, --dna, or --rna are given.

Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

-o <f> Save the resulting, modiﬁed alignment in Stockholm format

to a ﬁle <f>. The default is to write it to standard output.

--informat <s> Assert that msafile is in alignment format <s>, bypassing
format autodetection. Common choices for <s> include:
stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (a2m or A2M
both work).

--outformat <s> Write the output in alignment format <s>. Common choices
for <s> include: stockholm, a2m, afa, psiblast, clustal, phylip. The
string <s> is case-insensitive (a2m or A2M both work). Default is
stockholm.

--devhelp Print help, as with -h, but also include undocumented devel-

oper options. These options are not listed below, are under
development or experimental, and are not guaranteed to
even work correctly. Use developer options at your own risk.
The only resources for understanding what they actually do
are the brief one-line description printed when --devhelp is
enabled, and the source code.

Expert Options

--lnfract <x> Remove any sequences with length less than <x> fraction the

length of the median length sequence in the alignment.

148

sean r. eddy

--lxfract <x> Remove any sequences with length more than <x> fraction
the length of the median length sequence in the alignment.

--lmin <n> Remove any sequences with length less than <n> residues.

--lmax <n> Remove any sequences with length more than <n> residues.

--rfnfract <x> Remove any sequences with nongap RF length less than <x>

fraction the nongap RF length of the alignment.

--detrunc <n> Remove any sequences that have all gaps in the ﬁrst <n>

non-gap #=GC RF columns or the last <n> non-gap #=GC RF
columns.

--xambig <n> Remove any sequences that has more than <n> ambiguous

(degenerate) residues.

--seq-r <f> Remove any sequences with names listed in ﬁle <f>. Se-
quence names listed in <f> can be separated by tabs, new
lines, or spaces. The ﬁle must be in Stockholm format for this
option to work.

--seq-k <f> Keep only sequences with names listed in ﬁle <f>. Sequence

names listed in <f> can be separated by tabs, new lines, or
spaces. By default, the kept sequences will remain in the
original order they appeared in msafile, but the order from
<f> will be used if the --k-reorder option is enabled. The ﬁle
must be in Stockholm format for this option to work.

--small With --seq-k or --seq-r, operate in small memory mode.

The alignment(s) will not be stored in memory, thus --seq-k
and --seq-r will be able to work on very large alignments
regardless of the amount of available RAM. The alignment
ﬁle must be in Pfam format and --informat pfam and one of
--amino, --dna, or --rna must be given as well.

--k-reorder With --seq-k <f>, reorder the kept sequences in the output
alignment to the order from the list ﬁle <f>.
--seq-ins <n> Keep only sequences that have at least 1 inserted residue

after nongap RF position <n>.

--seq-ni <n> With --seq-ins require at least <n> inserted residues in a

sequence for it to be kept.

--seq-xi <n> With --seq-ins allow at most <n> inserted residues in a se-

quence for it to be kept.

--trim <f> File <f> is an unaligned FASTA ﬁle containing truncated

versions of each sequence in the msafile. Trim the sequences
in the alignment to match their truncated versions in <f>.
If the alignment output format is Stockholm (the default
output format), all per-column (GC) and per-residue (GR)
annotation will be removed from the alignment when --trim

hmmer user’s guide

149

is used. However, if --t-keeprf is also used, the reference
annotation (GC RF) will be kept.

--t-keeprf Specify that the ’trimmed’ alignment maintain the original
reference (GC RF) annotation. Only works in combination
with --trim.

--minpp <x> Replace all residues in the alignments for which the posterior
probability annotation (#=GR PP) is less than <x> with gaps.
The PP annotation for these residues is also converted to
gaps. <x> must be greater than 0.0 and less than or equal to
0.95.

--tree <f> Reorder sequences by tree order. Perform single linkage

clustering on the sequences in the alignment based on se-
quence identity given the alignment to deﬁne a ’tree’ of the
sequences. The sequences in the alignment are reordered ac-
cording to the tree, which groups similar sequences together.
The tree is output in Newick format to <f>.

--reorder <f> Reorder sequences to the order listed in ﬁle <f>. Each se-

quence in the alignment must be listed in <f>. Use --k-reorder
to reorder only a subset of sequences to a subset alignment
ﬁle. The ﬁle must be in Stockholm format for this option to
work.

--mask2rf <f> Read in the ’mask’ ﬁle <f> and use it to deﬁne new #=GC RF
annotation for the alignment. <f> must be a single line, with
exactly <alen> or <rflen> characters, either the full alignment
length or the number of nongap #=GC RF characters, respec-
tively. Each character must be either a ’1’ or a ’0’. The new
#=GC RF markup will contain an ’x’ for each column that
is a ’1’ in lane mask ﬁle, and a ’.’ for each column that is a
’0’. If the mask is of length <rflen> then it is interpreted as
applying to only nongap RF characters in the existing RF an-
notation, all gap RF characters will remain gaps and nongap
RF characters will be redeﬁned as above.

--m-keeprf With --mask2rf, do not overwrite existing nongap RF charac-
ters that are included by the input mask as ’x’, leave them as
the character they are.

--num-all Add annotation to the alignment numbering all of the

columns in the alignment.

--num-rf Add annotation to the alignment numbering the non-gap

(non ’.’) #=GC RF columns of the alignment.

--rm-gc <s> Remove certain types of #=GC annotation from the align-

ment. <s> must be one of: RF, SS_cons, SA_cons, PP_cons.

150

sean r. eddy

--sindi Annotate individual secondary structures for each sequence

by imposing the consensus secondary structure deﬁned by
the #=GC SS_cons annotation.

--post2pp Update Infernal’s cmalign 0.72-1.0.2 posterior probability

"POST" annotation to "PP" annotation, which is read by other
miniapps, including esl-alimask and esl-alistat.

--amino Assert that the msafile contains protein sequences.

--dna Assert that the msafile contains DNA sequences.

--rna Assert that the msafile contains RNA sequences.

hmmer user’s guide

151

esl-alimap - map two alignments to each other

Synopsis

esl-alimap [options] msafile1 msafile2

Description

esl-alimap is a highly specialized application that determines the optimal alignment
mapping of columns between two alignments of the same sequences. An alignment
mapping deﬁnes for each column in alignment 1 a matching column in alignment
2. The number of residues in the aligned sequences that are in common between the
two matched columns are considered ’shared’ by those two columns.

For example, if the nth residue of sequence i occurs in alignment 1 column x and
alignment 2 column y, then only a mapping of alignment 1 and 2 that includes col-
umn x mapping to column y would correctly map and share the residue.

The optimal mapping of the two alignments is the mapping which maximizes the
sum of shared residues between all pairs of matching columns. The fraction of total
residues that are shared is reported as the coverage in the esl-alimap output.

Only the ﬁrst alignments in msafile1 and msafile2 will be mapped to each other.
If the ﬁles contain more than one alignment, all alignments after the ﬁrst will be
ignored.

The two alignments (one from each ﬁle) must contain exactly the same sequences
(if they were unaligned, they’d be identical) in precisely the same order. They must
also be in Stockholm format.

The output of esl-alimap differs depending on whether one or both of the align-
ments contain reference (#=GC RF) annotation. If so, the coverage for residues from
nongap RF positions will be reported separately from the total coverage.

esl-alimap uses a dynamic programming algorithm to compute the optimal map-
ping. The algorithm is similar to the Needleman-Wunsch-Sellers algorithm but the
scores used at each step of the recursion are not residue-residue comparison scores
but rather the number of residues shared between two columns. The --mask-a2a <f>,
--mask-a2rf <f>, --mask-rf2a <f>, and --mask-rf2rf <f> options create ’mask’ ﬁles that
pertain to the optimal mapping in slightly different ways. A mask ﬁle consists of a
single line, of only ’0’ and ’1’ characters. These denote which positions of the align-
ment from msafile1 map to positions of the alignment from msafile2 as described be-
low for each of the four respective masking options. These masks can be used to
extract only those columns of the msafile1 alignment that optimally map to columns
of the msafile2 alignment using the esl-alimask miniapp. To extract the correspond-
ing set of columns from msafile2 (that optimally map to columns of the alignment
from msafile1), it is necessary to rerun the program with the order of the two msaﬁles
reversed, save new masks, and use esl-alimask again.

152

sean r. eddy

Options

-h Print brief help; includes version number and summary of all

options.

-q Be quiet; don’t print information the optimal mapping of
each column, only report coverage and potentially save
masks to optional output ﬁles.

--mask-a2a <f> Save a mask of ’0’s and ’1’s to ﬁle <f>. A ’1’ at position x

means that position x of the alignment from msafile1 maps to
an alignment position in the alignment from msafile2 in the
optimal map.

--mask-a2rf <f> Save a mask of ’0’s and ’1’s to ﬁle <f>. A ’1’ at position x

means that position x of the alignment from msafile1 maps to
a nongap RF position in the alignment from msafile2 in the
optimal map.

--mask-rf2a <f> Save a mask of ’0’s and ’1’s to ﬁle <f>. A ’1’ at position

x means that nongap RF position x of the alignment from
msafile1 maps to an alignment position in the alignment from
msafile2 in the optimal map.

--mask-rf2rf <f> Save a mask of ’0’s and ’1’s to ﬁle <f>. A ’1’ at position

x means that nongap RF position x of the alignment from
msafile1 maps to a nongap RF position in the alignment from
msafile2 in the optimal map.

--submap <f> Specify that all of the columns from the alignment from

msafile1 exist identically (contain the same residues from all
sequences) in the alignment from msafile2. This makes the
task of mapping trivial. However, not all columns of msafile1
must exist in msafile2. Save the mask to ﬁle <f>. A ’1’ at
position x of the mask means that position x of the alignment
from msafile1 is the same as position y of msafile2, where y is
the number of ’1’s that occur at positions <= x in the mask.

--amino Assert that msafile1 and msafile2 contain protein sequences.

--dna Assert that msafile1 and msafile2 contain DNA sequences.

--rna Assert that the msafile1 and msafile2 contain RNA sequences.

hmmer user’s guide

153

esl-alimask - remove columns from a multiple sequence alignment

Synopsis

esl-alimask [options] msafile maskfile

(remove columns based on a mask in an input ﬁle)

esl-alimask -t [options] msafile coords

(remove a contiguous set of columns at the start and end of an alignment)

esl-alimask -g [options] msafile

(remove columns based on their frequency of gaps)

esl-alimask -p [options] msafile

(remove columns based on their posterior probability annotation)

esl-alimask --rf-is-mask [options] msafile

(only remove columns that are gaps in the RF annotation)
The -g and -p options may be used in combination.

Description

esl-alimask reads a single input alignment, removes some columns from it (i.e. masks
it), and outputs the masked alignment.

esl-alimask can be run in several different modes.
esl-alimask runs in "mask ﬁle mode" by default when two command-line argu-

ments (msafile and maskfile) are supplied. In this mode, a bit-vector mask in the
maskfile deﬁnes which columns to keep/remove. The mask is a string that may only
contain the characters ’0’ and ’1’. A ’0’ at position x of the mask indicates that column
x is excluded by the mask and should be removed during masking. A ’1’ at position
x of the mask indicates that column x is included by the mask and should not be re-
moved during masking. All lines in the maskfile that begin with ’#’ are considered
comment lines and are ignored. All non-whitespace characters in non-comment lines
are considered to be part of the mask. The length of the mask must equal either the
total number of columns in the (ﬁrst) alignment in msafile, or the number of columns
that are not gaps in the RF annotation of that alignment. The latter case is only valid
if msafile is in Stockholm format and contains ’#=GC RF’ annotation. If the mask
length is equal to the non-gap RF length, all gap RF columns will automatically be
removed.

esl-alimask runs in "truncation mode" if the -t option is used along with two
command line arguments (msafile and coords). In this mode, the alignment will be
truncated by removing a contiguous set of columns from the beginning and end of
the alignment. The second command line argument is the coords string, that speciﬁes
what range of columns to keep in the alignment, all columns outside of this range
will be removed. The coords string consists of start and end coordinates separated by
any nonnumeric, nonwhitespace character or characters you like; for example, 23..100,
23/100, or 23-100 all work. To keep all alignment columns beginning at 23 until the end
of the alignment, you can omit the end; for example, 23: would work. If the --t-rf
option is used in combination with -t, the coordinates in coords are interpreted as

154

sean r. eddy

non-gap RF column coordinates. For example, with --t-rf, a coords string of 23-100
would remove all columns before the 23rd non-gap residue in the "#=GC RF" annota-
tion and after the 100th non-gap RF residue.

esl-alimask runs in "RF mask" mode if the --rf-is-mask option is enabled. In this
mode, the alignment must be in Stockholm format and contain ’#=GC RF’ annotation.
esl-alimask will simply remove all columns that are gaps in the RF annotation.

esl-alimask runs in "gap frequency mode" if -g is enabled. In this mode columns
for which greater than <f> fraction of the aligned sequences have gap residues will
be removed. By default, <f> is 0.5, but this value can be changed to <f> with the
--gapthresh <f> option. In this mode, if the alignment is in Stockholm format and has
RF annotation, then all columns that are gaps in the RF annotation will automatically
be removed, unless --saveins is enabled.

esl-alimask runs in "posterior probability mode" if -p is enabled. In this mode,
masking is based on posterior probability annotation, and the input alignment must
be in Stockholm format and contain ’#=GR PP’ (posterior probability) annotation
for all sequences. As a special case, if -p is used in combination with --ppcons, then
the input alignment need not have ’#=GR PP’ annotation, but must contain ’#=GC
PP_cons’ (posterior probability consensus) annotation.

Characters in Stockholm alignment posterior probability annotation (both ’#=GR
PP’ and ’#=GC PP_cons’) can have 12 possible values: the ten digits ’0-9’, ’*’, and ’.’.
If ’.’, the position must correspond to a gap in the sequence (for ’#=GR PP’) or in the
RF annotation (for ’#=GC PP_cons’). A value of ’0’ indicates a posterior probability
of between 0.0 and 0.05, ’1’ indicates between 0.05 and 0.15, ’2’ indicates between 0.15
and 0.25 and so on up to ’9’ which indicates between 0.85 and 0.95. A value of ’*’ in-
dicates a posterior probability of between 0.95 and 1.0. Higher posterior probabilities
correspond to greater conﬁdence that the aligned residue belongs where it appears in
the alignment.

When -p is enabled with --ppcons <x>, columns which have a consensus posterior
probability of less than <x> will be removed during masking, and all other columns
will not be removed.

When -p is enabled without --ppcons, the number of each possible PP value in each
column is counted. If <x> fraction of the sequences that contain aligned residues (i.e.
do not contain gaps) in a column have a posterior probability greater than or equal
to <y>, then that column will not be removed during masking. All columns that do
not meet this criterion will be removed. By default, the values of both <x> and <y>
are 0.95, but they can be changed with the --pfract <x> and --pthresh <y> options,
respectively.

In posterior probability mode, all columns that have 0 residues (i.e. that are 100%

gaps) will be automatically removed, unless the --pallgapok option is enabled, in
which case such columns will not be removed.

Importantly, during posterior probability masking, unless --pavg is used, PP an-
notation values are always considered to be the minimum numerical value in their
corresponding range. For example, a PP ’9’ character is converted to a numerical
posterior probability of 0.85. If --pavg is used, PP annotation values are considered

hmmer user’s guide

155

to be the average numerical value in their range. For example, a PP ’9’ character is
converted to a numerical posterior probability of 0.90.

In posterior probability mode, if the alignment is in Stockholm format and has RF
annotation, then all columns that are gaps in the RF annotation will automatically be
removed, unless --saveins is enabled.

A single run of esl-alimask can perform both gap frequency-based masking and

posterior probability-based masking if both the -g and -p options are enabled. In
this case, a gap frequency-based mask and a posterior probability-based mask are
independently computed. These two masks are combined to create the ﬁnal mask
using a logical ’and’ operation. Any column that is to be removed by either the gap
or PP mask will be removed by the ﬁnal mask.

With the --small option, esl-alimask will operate in memory saving mode and the
required RAM for the masking will be minimal (usually less than a Mb) and indepen-
dent of the alignment size. To use --small, the alignment alphabet must be speciﬁed
with either --amino, --dna, or --rna, and the alignment must be in Pfam format (non-
interleaved, 1 line/sequence Stockholm format). Pfam format is the default output
format of INFERNAL’s cmalign program. Without --small the required RAM will be
equal to roughly the size of the ﬁrst input alignment (the size of the alignment ﬁle
itself if it only contains one alignment).

Output

By default, esl-alimask will print only the masked alignment to stdout and then exit.
If the -o <f> option is used, the alignment will be saved to ﬁle <f> , and information
on the number of columns kept and removed will be printed to stdout. If -q is used in
combination with -o, nothing is printed to stdout.

The mask(s) computed by esl-alimask when the -t, -p, -g, or --rf-is-mask options are

used can be saved to output ﬁles using the options --fmask-rf <f>, --fmask-all <f>,
--gmask-rf <f>, --gmask-all <f>, --pmask-rf <f>, and --pmask-all <f>. In all cases, <f>
will contain a single line, a bit vector of length <n>, where <n> is the either the total
number of columns in the alignment (for the options sufﬁxed with ’all’) or the num-
ber of non-gap columns in the RF annotation (for the options sufﬁxed with ’rf’). The
mask will be a string of ’0’ and ’1’ characters: a ’0’ at position x in the mask indicates
column x was removed (excluded) by the mask, and a ’1’ at position x indicates col-
umn x was kept (included) by the mask. For the ’rf’ sufﬁxed options, the mask only
applies to non-gap RF columns. The options beginning with ’f’ will save the ’ﬁnal’
mask used to keep/remove columns from the alignment. The options beginning with
’g’ save the masks based on gap frequency and require -g. The options beginning
with ’p’ save the masks based on posterior probabilities and require -p.

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

156

sean r. eddy

-o <f> Output the ﬁnal, masked alignment to ﬁle <f> instead of

to stdout. When this option is used, information about the
number of columns kept/removed is printed to stdout.

-q Be quiet; do not print anything to stdout. This option can

only be used in combination with the -o option.

--small Operate in memory saving mode. Required RAM will be in-

dependent of the size of the input alignment to mask, instead
of roughly the size of the input alignment. When enabled,
the alignment must be in Pfam Stockholm (non-interleaved 1
line/seq) format (see esl-reformat) and the output alignment
will be in Pfam format.

--informat <s> Assert that input msafile is in alignment format <s>. Com-

mon choices for <s> include: stockholm, a2m, afa, psiblast,
clustal, phylip. For more information, and for codes for some
less common formats, see main documentation. The string
<s> is case-insensitive (a2m or A2M both work). Default is
stockholm format, unless --small is used, in which case pfam
format (non-interleaved Stockholm) is assumed.

--outformat <s> Write the output msafile in alignment format <s>. Common

choices for <s> include: stockholm, a2m, afa, psiblast, clustal,
phylip. The string <s> is case-insensitive (a2m or A2M both
work). Default is stockholm, unless --small is enabled, in which
case pfam (noninterleaved Stockholm) is the default output
format.

--fmask-rf <f> Save the non-gap RF-length ﬁnal mask used to mask the

alignment to ﬁle <f>. The input alignment must be in Stock-
holm format and contain ’#=GC RF’ annotation for this op-
tion to be valid. See the OUTPUT section above for more
details on output mask ﬁles.

--fmask-all <f> Save the full alignment-length ﬁnal mask used to mask the

alignment to ﬁle <f>. See the OUTPUT section above for
more details on output mask ﬁles.

--amino Specify that the input alignment is a protein alignment. By
default, esl-alimask will try to autodetect the alphabet, but if
the alignment is sufﬁciently small it may be ambiguous. This
option deﬁnes the alphabet as protein. Importantly, if --small
is enabled, the alphabet must be speciﬁed with either --amino,
--dna, or --rna.

--dna Specify that the input alignment is a DNA alignment.

--rna Specify that the input alignment is an RNA alignment.

--t-rf With -t, specify that the start and end coordinates deﬁned

in the second command line argument coords correspond to

hmmer user’s guide

157

non-gap RF coordinates. To use this option, the alignment
must be in Stockholm format and have "#=GC RF" annota-
tion. See the DESCRIPTION section for an example of using
the --t-rf option.

--t-rmins With -t, specify that all columns that are gaps in the refer-

ence (RF) annotation in between the speciﬁed start and end
coordinates be removed. By default, these columns will be
kept. To use this option, the alignment must be in Stockholm
format and have "#=GC RF" annotation.

--gapthresh <x> With -g, specify that a column is kept (included by mask)

if no more than <f> fraction of sequences in the alignment
have a gap (’.’, ’-’, or ’_’) at that position. All other columns
are removed (excluded by mask). By default, <x> is 0.5.

--gmask-rf <f> Save the non-gap RF-length gap frequency-based mask used
to mask the alignment to ﬁle <f>. The input alignment must
be in Stockholm format and contain ’#=GC RF’ annotation
for this option to be valid. See the OUTPUT section above for
more details on output mask ﬁles.

--gmask-all <f> Save the full alignment-length gap frequency-based mask
used to mask the alignment to ﬁle <f>. See the OUTPUT
section above for more details on output mask ﬁles.

--pfract <x> With -p, specify that a column is kept (included by mask)
if the fraction of sequences with a non-gap residue in that
column with a posterior probability of at least <y> (from
--pthresh <y>) is <x> or greater. All other columns are re-
moved (excluded by mask). By default <x> is 0.95.

--pthresh <y> With -p, specify that a column is kept (included by mask) if

<x> (from --pfract <x>) fraction of sequences with a non-gap
residue in that column have a posterior probability of at least
<y>. All other columns are removed (excluded by mask). By
default <y> is 0.95. See the DESCRIPTION section for more
on posterior probability (PP) masking. Due to the granularity
of the PP annotation, different <y> values within a range
covered by a single PP character will be have the same effect
on masking. For example, using --pthresh 0.86 will have the
same effect as using --pthresh 0.94.

--pavg <x> With -p, specify that a column is kept (included by mask) if
the average posterior probability of non-gap residues in that
column is at least <x>. See the DESCRIPTION section for
more on posterior probability (PP) masking.

--ppcons <x> With -p, use the ’#=GC PP_cons’ annotation to deﬁne which

columns to keep/remove. A column is kept (included by

158

sean r. eddy

mask) if the PP_cons value for that column is <x> or greater.
Otherwise it is removed.

--pallgapok With -p, do not automatically remove any columns that are
100% gaps (i.e. contain 0 aligned residues). By default, such
columns will be removed.

--pmask-rf <f> Save the non-gap RF-length posterior probability-based mask
used to mask the alignment to ﬁle <f>. The input alignment
must be in Stockholm format and contain ’#=GC RF’ anno-
tation for this option to be valid. See the OUTPUT section
above for more details on output mask ﬁles.

--pmask-all <f> Save the full alignment-length posterior probability-based

--keepins

mask used to mask the alignment to ﬁle <f>. See the OUT-
PUT section above for more details on output mask ﬁles.

If -p and/or -g is enabled and the alignment is in Stockholm
or Pfam format and has ’#=GC RF’ annotation, then allow
columns that are gaps in the RF annotation to possibly be
kept. By default, all gap RF columns would be removed
automatically, but with this option enabled gap and non-gap
RF columns are treated identically. To automatically remove
all gap RF columns when using a maskfile , then deﬁne the
mask in maskfile as having length equal to the non-gap RF
length in the alignment. To automatically remove all gap RF
columns when using -t, use the --t-rmins option.

esl-alimerge - merge alignments based on their reference (RF) annotation

hmmer user’s guide

159

Synopsis

esl-alimerge [options] alifile1 alifile2

(merge two alignment ﬁles)
esl-alimerge --list [options] listfile

(merge many alignment ﬁles listed in a ﬁle)

Description

esl-alimerge reads more than one input alignments, merges them into a single align-
ment and outputs it.

The input alignments must all be in Stockholm format. All alignments must have
reference (’#=GC RF’) annotation. Further, the RF annotation must be identical in all
alignments once gap characters in the RF annotation (’.’,’-’,’_’) have been removed.
This requirement allows alignments with different numbers of total columns to be
merged together based on consistent RF annotation, such as alignments created by
successive runs of the cmalign program of the INFERNAL package using the same
CM. Columns which have a gap character in the RF annotation are called ’insert’
columns.

All sequence data in all input alignments will be included in the output alignment

regardless of the output format (see --outformat option below). However, sequences
in the merged alignment will usually contain more gaps (’.’) than they did in their re-
spective input alignments. This is because esl-alimerge must add 100% gap columns to
each individual input alignment so that insert columns in the other input alignments
can be accomodated in the merged alignment.

If the output format is Stockholm or Pfam, annotation will be transferred from the
input alignments to the merged alignment as follows. All per-sequence (’#=GS’) and
per-residue (’#=GR’) annotation is transferred. Per-ﬁle (’#=GF’) annotation is trans-
ferred if it is present and identical in all alignments. Per-column (’#=GC’) annotation
is transferred if it is present and identical in all alignments once all insert positions
have been removed and the ’#=GC’ annotation includes zero non-gap characters in
insert columns.

With the --list <f> option, <f> is a ﬁle listing alignment ﬁles to merge. In the list

ﬁle, blank lines and lines that start with ’#’ (comments) are ignored. Each data line
contains a single word: the name of an alignment ﬁle to be merged. All alignments in
each ﬁle will be merged.

With the --small option, esl-alimerge will operate in memory saving mode and the
required RAM for the merge will be minimal (should be only a few Mb) and inde-
pendent of the alignment sizes. To use --small, all alignments must be in Pfam format
(non-interleaved, 1 line/sequence Stockholm format). You can reformat alignments to
Pfam using the esl-reformat Easel miniapp. Without --small the required RAM will be
equal to roughly the size of the ﬁnal merged alignment ﬁle which will necessarily be
at least the summed size of all of the input alignment ﬁles to be merged and some-

160

sean r. eddy

times several times larger. If you’re merging large alignments or you’re experiencing
very slow performance of esl-alimerge, try reformatting to Pfam and using --small.

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

-o <f> Output merged alignment to ﬁle <f> instead of to stdout.

-v Be verbose; print information on the size of the alignments

being merged, and the annotation transferred to the merged
alignment to stdout. This option can only be used in combi-
nation with the -o option (so that the printed info doesn’t
corrupt the output alignment ﬁle).

--small Operate in memory saving mode. Required RAM will be

independent of the sizes of the alignments to merge, instead
of roughly the size of the eventual merged alignment. When
enabled, all alignments must be in Pfam Stockholm (non-
interleaved 1 line/seq) format; see esl-reformat(1). The output
alignment will be in Pfam format.

--rfonly Only include columns that are not gaps in the GC RF annota-

tion in the merged alignment.

--outformat <s> Write the output alignment in format <s>. Common choices
for <s> include: stockholm, a2m, afa, psiblast, clustal, phylip. The
string <s> is case-insensitive (a2m or A2M both work). Default is
stockholm.

--rna Specify that the input alignments are RNA alignments. By

default esl-alimerge will try to autodetect the alphabet, but if
the alignment is sufﬁciently small it may be ambiguous. This
option deﬁnes the alphabet as RNA.

--dna Specify that the input alignments are DNA alignments.

--amino Specify that the input alignments are protein alignments.

esl-alipid - calculate pairwise percent identities for all sequence

hmmer user’s guide

161

pairs in an MSA

Synopsis

esl-alipid [options] msafile

Description

esl-alistat calculates the pairwise percent identity of each sequence pair in in the
MSA(s) in msafile. For each sequence pair, it outputs a line of <seqname1> <seqname2>
<%id> <nid> <denomid> <%match> <nmatch> <denommatch> where <%id>
is the percent identity, <nid> is the number of identical aligned pairs, and <denomid> is
the denominator used for the calculation: the shorter of the two (unaligned) sequence
lengths. The %identity is deﬁned as 100*nid/denomid.

The last three ﬁelds are the pairwise percent match calculation, in the pair-HMM
sense of a "match state" that aligns two residues XY (whether identical or different)
versus delete -Y and insert X- states that have a residue in one sequence and a gap
character in the other. That is, the %match is the percentage of the alignment that
consists of aligned residues as opposed to insertions or deletions in either sequence.
The %match is deﬁned as 100*nmatch/denommatch.

There are many ways that one could choose a denominator for these percentages.
We always deﬁne %id using MIN(len1,len2) as the denominator. In multiple sequence
alignments, you will often have short sequence fragments which may have very little
overlap, or even none at all. Several ways to calculate %identity, such as ignoring
columns with gaps (100* n_identities / (n_identities + n_mismatches)) , or dividing
by the total alignment length (100 * n_identities / ali_len), are not robust to having
overlapping fragments or long indels, because you can get spuriously high or low
%id’s.

For both %identity and %match calculations, alignments of a gap character in both

sequences, --, aren’t counted. Also, if the denominator is zero (which can happen,
when two sequence fragments in the same MSA don’t overlap each other), the result-
ing % is deﬁned to be 0.

If msafile is - (a single dash), alignment input is read from stdin.
Only canonical residues are counted toward <nid> and <n>. Degenerate residue

codes are not counted.

Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

--informat <s> Assert that input msafile is in alignment format <s>, bypass-
ing format autodetection. Common choices for <s> include:

162

sean r. eddy

stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (a2m or A2M
both work).

--amino Assert that the msafile contains protein sequences.

--dna Assert that the msafile contains DNA sequences.

--rna Assert that the msafile contains RNA sequences.

hmmer user’s guide

163

esl-alirev - reverse complement a multiple alignment

Synopsis

esl-alirev [options] msafile

Description

esl-alirev reads the multiple alignment in msafile and outputs its reverse complement
to stdout.

An example of where you might need to do this is when you’ve downloaded a
chunk of multiway genomic alignment from one of the genome browsers, but your
RNA of interest is on the opposite strand.

Any per-column and per-residue annotation lines are reversed as well, including

Stockholm format and old SELEX format annotations. Annotations that Easel rec-
ognizes as secondary structure annotation (a consensus structure line, individual
secondary structure lines) will be "reverse complemented" to preserve proper brack-
eting orders: for example, ...<<<...>>> is reverse complemented to <<<...>>>...,
not simply reversed to >>>...<<<..., which would be wrong.

If msafile is - (a single dash), alignment input is read from stdin.
By default the output alignment is written in the same format as the input align-

ment. See the --outformat option to use a different output format.

Because the alignment is parsed into Easel’s digital internal representation, the

output alignment may differ in certain details from the original alignment; these
details should be inconsequential but may catch your eye. One is that if you have a
reference annotation line, Easel’s output will put consensus residues in upper case,
nonconsensus (inserted) residues in lower case. Another is that the headers for some
formats, such as Clustal format, are written with an arbitrary version number - so
you may ﬁnd yourself revcomping an alignment in "MUSCLE (3.7) multiple sequence
alignment" format and it could come out claiming to be a "CLUSTAL 2.1 multiple
sequence alignment", just because Easel writes all of its Clustal format alignment ﬁles
with that header.

The msafile must contain nucleic acid sequences (DNA or RNA). The alphabet will

be autodetected by default. See the --dna or --rna options to assert an alphabet.

Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

--informat <s> Assert that input msafile is in alignment format <s>, bypass-
ing format autodetection. Common choices for <s> include:
stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (a2m or A2M
both work).

164

sean r. eddy

--outformat <s> Write the output alignment in alignment format <s>. Com-

mon choices for <s> include: stockholm, a2m, afa, psiblast,
clustal, phylip. The string <s> is case-insensitive (a2m or
A2M both work). Default is to use same format as the input
msafile.

--dna Assert that the msafile contains DNA sequences.

--rna Assert that the msafile contains RNA sequences.

hmmer user’s guide

165

esl-alistat - summarize a multiple sequence alignment ﬁle

Synopsis

esl-alistat [options] msafile

Description

esl-alistat summarizes the contents of the multiple sequence alignment(s) in msafile,
such as the alignment name, format, alignment length (number of aligned columns),
number of sequences, average pairwise % identity, and mean, smallest, and largest
raw (unaligned) lengths of the sequences.

If msafile is - (a single dash), multiple alignment input is read from stdin.
The --list, --icinfo, --rinfo, --pcinfo, --psinfo, --cinfo, --bpinfo, and --iinfo options al-
low dumping various statistics on the alignment to optional output ﬁles as described
for each of those options below.

The --small option allows summarizing alignments without storing them in mem-
ory and can be useful for large alignment ﬁles with sizes that approach or exceed the
amount of available RAM. When --small is used, esl-alistat will print fewer statistics
on the alignment, omitting data on the smallest and largest sequences and the aver-
age identity of the alignment. --small only works on Pfam formatted alignments (a
special type of non-interleaved Stockholm alignment in which each sequence occurs
on a single line) and --informat pfam must be given with --small. Further, when --small
is used, the alphabet must be speciﬁed with --amino, --dna, or --rna.

Options

Expert Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

-1 Use a tabular output format with one line of statistics per
alignment in msafile. This is most useful when msafile con-
tains many different alignments (such as a Pfam database in
Stockholm format).

--informat <s> Assert that input msafile is in alignment format <s>, bypass-
ing format autodetection. Common choices for <s> include:
stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (a2m or A2M
both work).

--amino Assert that the msafile contains protein sequences.

--dna Assert that the msafile contains DNA sequences.

--rna Assert that the msafile contains RNA sequences.

166

sean r. eddy

--small Operate in small memory mode for Pfam formatted align-

ments. --informat pfam and one of --amino, --dna, or --rna must
be given as well.

--list <f> List the names of all sequences in all alignments in msafile to

ﬁle <f>. Each sequence name is written on its own line.

--icinfo <f> Dump the information content per position in tabular format
to ﬁle <f>. Lines preﬁxed with "#" are comment lines, which
explain the meanings of each of the tab-delimited ﬁelds.

--rinfo <f> Dump information on the frequency of gaps versus nongap

residues per position in tabular format to ﬁle <f>. Lines
preﬁxed with "#" are comment lines, which explain the mean-
ings of each of the tab-delimited ﬁelds.

--pcinfo <f> Dump per column information on posterior probabilities
in tabular format to ﬁle <f>. Lines preﬁxed with "#" are
comment lines, which explain the meanings of each of the
tab-delimited ﬁelds.

--psinfo <f> Dump per sequence information on posterior probabilities

in tabular format to ﬁle <f>. Lines preﬁxed with "#" are
comment lines, which explain the meanings of each of the
tab-delimited ﬁelds.

--iinfo <f> Dump information on inserted residues in tabular format to

ﬁle <f>. Insert columns of the alignment are those that are
gaps in the reference (#=GC RF) annotation. This option only
works if the input ﬁle is in Stockholm format with reference
annotation. Lines preﬁxed with "#" are comment lines, which
explain the meanings of each of the tab-delimited ﬁelds.

--cinfo <f> Dump per-column residue counts to ﬁle <f>. If used in com-

bination with --noambig ambiguous (degenerate) residues
will be ignored and not counted. Otherwise, they will be
marginalized. For example, in an RNA sequence ﬁle, a ’N’
will be counted as 0.25 ’A’, 0.25 ’C’, 0.25 ’G’, and 0.25 ’U’.

--noambig With --cinfo, do not count ambiguous (degenerate) residues.

--bpinfo Dump per-column basepair counts to ﬁle <f>. Counts appear

for each basepair in the consensus secondary structure (an-
notated as "#=GC SS_cons"). Only basepairs from sequences
for which both paired positions are canonical residues will be
counted. That is, any basepair that is a gap or an ambiguous
(degenerate) residue at either position of the pair is ignored
and not counted.

--weight With --icinfo, --rinfo, --pcinfo, --iinfo, --cinfo, and --bpinfo,
weight counts based on #=GS WT annotation in the input

hmmer user’s guide

167

msafile. A residue or basepair from a sequence with a weight
of <x> will be considered <x> counts. By default, raw, un-
weighted counts are reported; corresponding to each se-
quence having an equal weight of 1.

168

sean r. eddy

esl-compalign - compare two multiple sequence alignments

Synopsis

esl-compalign [options] trusted_file test_file

Description

esl-compalign evaluates the accuracy of a predicted multiple sequence alignment with
respect to a trusted alignment of the same sequences.

The trusted_file and test_file must contain the same number of alignments. Each
predicted alignment in the test_file will be compared against a single trusted align-
ment from the trusted_file. The ﬁrst alignments in each ﬁle correspond to each other
and will be compared, the second alignment in each ﬁle correspond to each other
and will be compared, and so on. Each corresponding pair of alignments must con-
tain the same sequences (i.e. if they were unaligned they would be identical) in the
same order in both ﬁles. Further, both alignment ﬁles must be in Stockholm format
and contain ’reference’ annotation, which appears as "#=GC RF" per-column markup
for each alignment. The number of nongap (non ’.’ characters) in the reference (RF)
annotation must be identical between all corresponding alignments in the two ﬁles.

esl-compalign reads an alignment from each ﬁle, and compares them based on their
’reference’ annotation. The number of correctly predicted residues for each sequence
is computed as follows. A residue that is in the Nth nongap RF column in the trusted
alignment must also appear in the Nth nongap RF column in the predicted alignment
to be counted as ’correct’, otherwise it is ’incorrect’. A residue that appears in a gap
RF column in the trusted alignment between nongap RF columns N and N+1 must
also appear in a nongap RF column in the predicted alignment between nongap RF
columns N and N+1 to be counted as ’correct’, otherwise it is incorrect.

The default output of esl-compalign lists each sequence and the number of correctly
and incorrectly predicted residues for that sequence. These counts are broken down
into counts for residues in the predicted alignments that occur in ’match’ columns
and ’insert’ columns. A ’match’ column is one for which the RF annotation does not
contain a gap. An ’insert’ column is one for which the RF annotation does contain a
gap.

Options

-h Print brief help; includes version number and summary of all

options.

-c Print per-column statistics instead of per-sequence statistics.

-p

Print statistics on accuracy versus posterior probability val-
ues. The test_file must be annotated with posterior probabil-
ities (#=GR PP) for this option to work.

Expert Options

--p-mask <f> This option may only be used in combination with the -p

hmmer user’s guide

169

option. Read a "mask" from ﬁle <f>. The mask ﬁle must con-
sist of a single line, of only ’0’ and ’1’ characters. There must
be exactly RFLEN characters where RFLEN is the number
of nongap characters in the RF annotation of all alignments
in both trusted_file and test_file. Positions of the mask that
are ’1’ characters indicate that the corresponding nongap
RF position is included by the mask. The posterior proba-
bility accuracy statistics for match columns will only per-
tain to positions that are included by the mask, those that
are excluded will be ignored from the accuracy calculation.
--c2dfile <f> Save a ’draw ﬁle’ to ﬁle <f> which can be read
into the esl-ssdraw miniapp. This draw ﬁle will deﬁne two
postscript pages for esl-ssdraw. The ﬁrst page will depict the
frequency of errors per match position and frequency of gaps
per match position, indicated by magenta and yellow, respec-
tively. The darker magenta, the more errors and the darker
yellow, the more gaps. The second page will depict the fre-
quency of errors in insert positions in shades of magenta,
the darker the magenta the more errors in inserts after each
position. See esl-ssdraw documentation for more information
on these diagrams.

--amino Assert that trusted_file and test_file contain protein se-

quences.

--dna Assert that trusted_file and test_file contain DNA sequences.

--rna Assert that the trusted_file and test_file contain RNA se-

quences.

170

sean r. eddy

esl-compstruct - calculate accuracy of RNA secondary structure predictions

Synopsis

esl-compstruct [options] trusted_file test_file

Description

esl-compstruct evaluates the accuracy of RNA secondary structure predictions on a
per-base-pair basis. The trusted_file contains one or more sequences with trusted
(known) RNA secondary structure annotation. The test_file contains the same se-
quences, in the same order, with predicted RNA secondary structure annotation.
esl-compstruct reads the structures and compares them, and calculates both the sen-
sitivity (the number of true base pairs that are correctly predicted) and the positive
predictive value (PPV; the number of predicted base pairs that are true). Results are
reported for each individual sequence, and in summary for all sequences together.
Both ﬁles must contain secondary structure annotation in WUSS notation. Only

SELEX and Stockholm formats support structure markup at present.

The default deﬁnition of a correctly predicted base pair is that a true pair (i,j) must

exactly match a predicted pair (i,j).

Mathews and colleagues (Mathews et al., JMB 288:911-940, 1999) use a more re-
laxed deﬁnition. Mathews deﬁnes "correct" as follows: a true pair (i,j) is correctly
predicted if any of the following pairs are predicted: (i,j), (i+1,j), (i-1,j), (i,j+1), or (i,j-
1). This rule allows for "slipped helices" off by one base. The -m option activates this
rule for both sensitivity and for speciﬁcity. For speciﬁcity, the rule is reversed: pre-
dicted pair (i,j) is considered to be true if the true structure contains one of the ﬁve
pairs (i,j), (i+1,j), (i-1,j), (i,j+1), or (i,j-1).

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

-m Use the Mathews relaxed accuracy rule (see above), instead

of requiring exact prediction of base pairs.

-p Count pseudoknotted base pairs towards the accuracy, in ei-
ther trusted or predicted structures. By default, pseudoknots
are ignored.

Normally, only the trusted_file would have pseudoknot annotation, since most

RNA secondary structure prediction programs do not predict
pseudoknots. Using the -p option allows you to penalize the
prediction program for not predicting known pseudoknots.
In a case where both the trusted_file and the test_file have
pseudoknot annotation, the -p option lets you count pseudo-
knots in evaluating the prediction accuracy. Beware, however,

hmmer user’s guide

171

the case where you use a pseudoknot-capable prediction
program to generate the test_file, but the trusted_file does
not have pseudoknot annotation; in this case, -p will penal-
ize any predicted pseudoknots when it calculates speciﬁcity,
even if they’re right, because they don’t appear in the trusted
annotation. This is probably not what you’d want to do.

Expert Options

--quiet Don’t print any verbose header information. (Used by re-

gression test scripts, for example, to suppress version/date
information.)

172

sean r. eddy

esl-construct - describe or create a consensus secondary structure

Synopsis

esl-construct [options] msafile

Description

esl-construct reports information on existing consensus secondary structure annota-
tion of an alignment or derives new consensus secondary structures based on struc-
ture annotation for individual aligned sequences.

The alignment ﬁle must contain either individual sequence secondary structure an-
notation (Stockholm #=GR SS), consensus secondary structure annotation (Stockohlm
#=GC SS_cons), or both. All structure annotation must be in WUSS notation (Vienna
dot paranetheses notation will be correctly interpreted). At present, the alignment ﬁle
must be in Stockholm format and contain RNA or DNA sequences.

By default, esl-construct generates lists the sequences in the alignment that have
structure annotation and the number of basepairs in those structures. If the alignment
also contains consensus structure annotation, the default output will list how many of
the individual basepairs overlap with the consensus basepairs and how many conﬂict
with a consensus basepair.

For the purposes of this miniapp, a basepair ’conﬂict’ exists between two basepairs
in different structures, one between columns i and j and the other between columns k
and l, if (i == k and j != l) or (j == l and i != k).

esl-construct can also be used to derive a new consensus structure based on struc-
ture annotation for individual sequences in the alignment by using any of the follow-
ing options: -x, -r, -c, --indi <s>, --ffreq <x>, --fmin. These are described below. All
of these options require the -o <f> option be used as well to specify that a new align-
ment ﬁle <f> be created. Differences between the new alignment(s) and the input
alignment(s) will be limited to the the consensus secondary structure (#=GC SS_cons)
annotation and possibly reference (#=GC RF) annotation.

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

-a List all alignment positions that are involved in at least one
conﬂicting basepair in at least one sequence to the screen,
and then exit.

-v Be verbose; with no other options, list individual sequence

basepair conﬂicts as well as summary statistics.

-x Compute a new consensus structure as the maximally sized
set of basepairs (greatest number of basepairs) chosen from
all individual structures that contains 0 conﬂicts. Output

hmmer user’s guide

173

the alignment with the new SS_cons annotation. This option
must be used in combination with the -o option.

-r Remove any consensus basepairs that conﬂict with >= 1

individual basepair and output the alignment with the new
SS_cons annotation. This option must be used in combination
with the -o option.

-c Deﬁne a new consensus secondary structure as the individ-

ual structure annotation that has the maximum number of
consistent basepairs with the existing consensus secondary
structure annotation. This option must be used in combina-
tion with the -o option.

--rfc With -c, set the reference annotation (#=GC RF) as the se-
quence whose individual structure becomes the consensus
structure.

--indi <s> Deﬁne a new consensus secondary structure as the individ-

ual structure annotation from sequence named <s>. This
option must be used in combination with the -o option.

--rfindi With --indi <s>, set the reference annotation (#=GC RF) as

the sequence named <s>.

--ffreq <x> Deﬁne a new consensus structure as the set of basepairs

between columns i:j that are paired in more than <x> fraction
of the individual sequence structures. This option must be
used in combination with the -o option.

--fmin Same as --ffreq <x> except ﬁnd the maximal <x> that gives
a consistent consensus structure. A consistent structure has
each base (alignment position) as a member of at most 1
basepair.

-o <s>, Output the alignment(s) with new consensus structure anno-

tation to ﬁle <f>.

--pfam With -o, specify that the alignment output format be Pfam

format, a special type of non-interleaved Stockholm on which
each sequence appears on a single line.

-l <f> Create a new ﬁle <f> that lists the sequences that have at

least one basepair that conﬂicts with a consensus basepair.

--lmax <n> With -l, only list sequences that have more than <n> base-

pairs that conﬂict with the consensus structure to the list
ﬁle.

174

sean r. eddy

esl-histplot - collate data histogram, output xmgrace dataﬁle

Synopsis

esl-histplot [options] datafile

Description

esl-histplot summarizes numerical data in the input ﬁle datafile.

One real-numbered value is taken from each line of the input ﬁle. Each line is split
into whitespace-delimited ﬁelds, and one ﬁeld is converted to data. By default this is
the ﬁrst ﬁeld; this can be changed by the -f option.

Default output is a survival plot (Prob(value > x)) in xmgrace XY data format, to

stdout. Output may be directed to a ﬁle with the -o option.

If datafile is - (a single dash), input lines are read from stdin instead of opening a

ﬁle.

Options

-f <n> Read data from whitespace-delimited ﬁeld <n> on each line,
instead of the ﬁrst ﬁeld. Fields are numbered starting from 1.

-h

Print brief help; includes version number and summary of all
options, including expert options.

-o <f> Send output to ﬁle <f> instead of stdout.

hmmer user’s guide

175

esl-mask - mask sequence residues with X’s (or other characters)

Synopsis

esl-mask [options] seqfile maskfile

Description

esl-mask reads lines from maskfile that give start/end coordinates for regions in each
sequence in seqfile, masks these residues (changes them to X’s), and outputs the
masked sequence.

The maskfile is a space-delimited ﬁle. Blank lines and lines that start with ’#’ (com-
ments) are ignored. Each data line contains at least three ﬁelds: seqname, start, and end.
The seqname is the name of a sequence in the seqfile, and start and end are coordinates
deﬁning a region in that sequence. The coordinates are indexed <1..L> with respect
to a sequence of length <L>.

By default, the sequence names must appear in exactly the same order and number

as the sequences in the seqfile. This is easy to enforce, because the format of maskfile
is also legal as a list of names for esl-sfetch, so you can always fetch a temporary
sequence ﬁle with esl-sfetch and pipe that to esl-mask. (Alternatively, see the -R option
for fetching from an SSI-indexed seqfile.)

The default is to mask the region indicated by <start>..<end>. Alternatively, every-

thing but this region can be masked; see the -r reverse masking option.

The default is to mask residues by converting them to X’s. Any other masking
character can be chosen (see -m option), or alternatively, masked residues can be low-
ercased (see -l option).

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

-l Lowercase; mask by converting masked characters to lower

case and unmasked characters to upper case.

-m <c> Mask by converting masked residues to <c> instead of the

default X.

-o <f> Send output to ﬁle <f> instead of stdout.

-r Reverse mask; mask everything outside the region start..end,

as opposed to the default of masking that region.

-R Random access; fetch sequences from seqfile rather than

requiring that sequence names in maskfile and seqfile come in
exactly the same order and number. The seqfile must be SSI
indexed (see esl-sfetch --index.)

-x <n> Extend all masked regions by up to <n> residues on each

side. For normal masking, this means masking <start>-

176

sean r. eddy

<n>..<end>+<n>. For reverse masking, this means masking
1..<start>-1+<n> and <end>+1-<n>..L in a sequence of length
L.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

hmmer user’s guide

177

esl-mixdchlet - ﬁtting mixture Dirichlets to count data

Synopsis

esl-mixdchlet fit [options] Q K in_countfile out_mixchlet

(train a new mixture Dirichlet)

esl-mixdchlet score [options] mixdchlet_file counts_file

(calculate log likelihood of count data, given mixture Dirichlet)

esl-mixdchlet gen [options] mixdchlet_file

(generate synthetic count data from mixture Dirichlet)

esl-mixdchlet sample [options]

(sample a random mixture Dirichlet for testing)

Description

The esl-mixdchlet miniapp is for training mixture Dirichlet priors, such as the priors
used in HMMER and Infernal. It has four subcommands: fit, score, gen, and sample.
The most important subcommand is fit, which is the subcommand for ﬁtting a new
mixture Dirichlet distribution to a collection of count vectors (for example, emission
or transition count vectors from Pfam or Rfam training sets).

Speciﬁcally, esl-mixdchlet fit ﬁts a new mixture Dirichlet distribution with Q mix-
ture components to the count vectors (of alphabet size K ) in input ﬁle in_countfile,
and saves the mixture Dirichlet into output ﬁle out_mixdchlet.

The input count vector ﬁle in_countfile contains one count vector of length K ﬁelds
per line, for any number of lines. Blank lines and lines starting in # (comments) are
ignored. Fields are nonnegative real values; they do not have to be integers, because
they can be weighted counts.

The format of a mixture Dirichlet ﬁle out_mixdchlet is as follows. The ﬁrst line has
two ﬁelds, K Q, where K is the alphabet size and Q is the number of mixture compo-
nents. The next Q lines consist of K+1 ﬁelds. The ﬁrst ﬁeld is the mixture coefﬁcient
q_k, followed by K ﬁelds with the Dirichlet alpha[k][a] parameters for this component.
The esl-mixdchlet score subcommand calculates the log likelihood of the count vec-

tor data in counts_file, given the mixture Dirichlet in mixdchlet_file.

The esl-mixdchlet gen subcommand generates synthetic count data, given a mixture

Dirichlet.

The esl-mixdchlet sample subcommand creates a random mixture Dirichlet distribu-

tion and outputs it to standard output.

Options for Fit Subcommand

-h Print brief help speciﬁc to the fit subcommand.

-s <seed> Set random number generator seed to nonnegative integer

<seed>. Default is 0, which means to use a quasirandom
arbitrary seed. Values >0 give reproducible results.

178

sean r. eddy

Options for Score Subcommand

-h Print brief help speciﬁc to the score subcommand.

Options for Gen Subcommand

-h Print brief help speciﬁc to the gen subcommand.

-s <seed> Set random number generator seed to nonnegative integer

<seed>. Default is 0, which means to use a quasirandom
arbitrary seed. Values >0 give reproducible results.

-M <M> Generate <M> counts per sampled vector. (Default 100.)
-N <N> Generate <N> count vectors. (Default 1000.)

Options for Sample Subcommand

-h Print brief help speciﬁc to the sample subcommand.

-s <seed> Set random number generator seed to nonnegative integer

<seed>. Default is 0, which means to use a quasirandom
arbitrary seed. Values >0 give reproducible results.
-K <K> Set the alphabet size to <K>. (Default is 20, for amino acids.)
-Q <Q> Set the number of mixture components to <Q>. (Default is 9.)

hmmer user’s guide

179

esl-reformat - convert sequence ﬁle formats

Synopsis

esl-reformat [options] format seqfile

Description

esl-reformat reads the sequence ﬁle seqfile in any supported format, reformats it into a
new format speciﬁed by format, then outputs the reformatted text.

The format argument must (case-insensitively) match a supported sequence ﬁle for-
mat. Common choices for format include: fasta, embl, genbank. If seqfile is an alignment
ﬁle, alignment output formats also work. Common choices include: stockholm, a2m, afa,
psiblast, clustal, phylip. For more information, and for codes for some less common
formats, see main documentation. The string <s> is case-insensitive (fasta or FASTA
both work).

Unaligned format ﬁles cannot be reformatted to aligned formats. However, aligned

formats can be reformatted to unaligned formats, in which case gap characters are
simply stripped out.

Options

-d DNA; convert U’s to T’s, to make sure a nucleic acid se-

quence is shown as DNA not RNA. See -r.

-h Print brief help; includes version number and summary of all

options, including expert options.

-l Lowercase; convert all sequence residues to lower case. See

-u.

-n For DNA/RNA sequences, converts any character that’s not
unambiguous RNA/DNA (e.g. ACGTU/acgtu) to an N.
Used to convert IUPAC ambiguity codes to N’s, for software
that can’t handle all IUPAC codes (some public RNA folding
codes, for example). If the ﬁle is an alignment, gap characters
are also left unchanged. If sequences are not nucleic acid
sequences, this option will corrupt the data in a predictable
fashion.

-o <f> Send output to ﬁle <f> instead of stdout.

-r RNA; convert T’s to U’s, to make sure a nucleic acid se-

quence is shown as RNA not DNA. See -d.

-u Uppercase; convert all sequence residues to upper case. See

-l.

-x For DNA sequences, convert non-IUPAC characters (such

as X’s) to N’s. This is for compatibility with benighted peo-

180

sean r. eddy

ple who insist on using X instead of the IUPAC ambiguity
character N. (X is for ambiguity in an amino acid residue).

Warning: like the -n option, the code doesn’t check that you are actually giving

it DNA. It simply literally just converts non-IUPAC DNA
symbols to N. So if you accidentally give it protein sequence,
it will happily convert most every amino acid residue to an
N.

Expert Options

--gapsym <c> Convert all gap characters to <c>. Used to prepare alignment

ﬁles for programs with strict requirements for gap symbols.
Only makes sense if the input seqfile is an alignment.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--mingap

If seqfile is an alignment, remove any columns that contain
100% gap or missing data characters, minimizing the overall
length of the alignment. (Often useful if you’ve extracted a
subset of aligned sequences from a larger alignment.)

--keeprf When used in combination with --mingap, never remove a

column that is not a gap in the reference (#=GC RF) anno-
tation, even if the column contains 100% gap characters in
all aligned sequences. By default with --mingap, nongap RF
columns that are 100% gaps in all sequences are removed.

--nogap Remove any aligned columns that contain any gap or missing
data symbols at all. Useful as a prelude to phylogenetic anal-
yses, where you only want to analyze columns containing
100% residues, so you want to strip out any columns with
gaps in them. Only makes sense if the ﬁle is an alignment
ﬁle.

--wussify Convert RNA secondary structure annotation strings (both
consensus and individual) from old "KHS" format, ><, to
the new WUSS notation, <>. If the notation is already in
WUSS format, this option will screw it up, without warning.
Only SELEX and Stockholm format ﬁles have secondary
structure markup at present.

--dewuss Convert RNA secondary structure annotation strings from
the new WUSS notation, <>, back to the old KHS format,

hmmer user’s guide

181

><. If the annotation is already in KHS, this option will
corrupt it, without warning. Only SELEX and Stockholm
format ﬁles have secondary structure markup.

--fullwuss Convert RNA secondary structure annotation strings from
simple (input) WUSS notation to full (output) WUSS nota-
tion.

--replace <s> <s> must be in the format <s1>:<s2> with equal numbers
of characters in <s1> and <s2> separated by a ":" symbol.
Each character from <s1> in the input ﬁle will be replaced
by its counterpart (at the same position) from <s2>. Note
that special characters in <s> (such as " ") may need to be
preﬁxed by a "\" character.

--small Operate in small memory mode for input alignment ﬁles in
Pfam format. If not used, each alignment is stored in mem-
ory so the required memory will be roughly the size of the
largest alignment in the input ﬁle. With --small, input align-
ments are not stored in memory. This option only works in
combination with --informat pfam and output format pfam or
afa.

182

sean r. eddy

esl-selectn - select random subset of lines from ﬁle

Synopsis

esl-selectn [options] nlines filename

Description

esl-selectn selects nlines lines at random from ﬁle filename and outputs them on stdout.

If filename is - (a single dash), input is read from stdin.
Uses an efﬁcient reservoir sampling algorithm that only requires only a single pass

through filename, and memory storage proportional to nlines (and importantly, not
to the size of the ﬁle filename itself). esl-selectn can therefore be used to create large
scale statistical sampling experiments, especially in combination with other Easel
miniapplications.

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

--seed <d> Set the random number seed to <d>, an integer >= 0. The
default is 0, which means to use a randomly selected seed.
A seed > 0 results in reproducible identical samples from
different runs of the same command.

hmmer user’s guide

183

esl-seqrange - determine a range of sequences for one of many parallel

processes

Synopsis

esl-sfetch [options] seqfile procidx nproc

Description

esl-seqrange reads an SSI-indexed seqfile and determines the range of sequence indices
in that ﬁle that process number procidx out of nproc total processes should operate on
during a parallel processing of seqfile.

The seqfile must be indexed ﬁrst using esl-sfetch --index seqfile. This creates an SSI

index ﬁle seqfile.ssi. An SSI ﬁle is required in order for esl-seqrange to work.

Sequence index ranges are calculated using a simple rule: the number of sequences
for each process should be identical, or as close as possible to identical, across all pro-
cesses. The lengths of the sequences are not considered (even though they probably
should be).

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

184

sean r. eddy

esl-seqstat - summarize contents of a sequence ﬁle

Synopsis

esl-seqstat [options] seqfile

Description

esl-seqstat summarizes the contents of the seqfile. It prints the format, alphabet type,
number of sequences, total number of residues, and the mean, smallest, and largest
sequence length.

If seqfile is - (a single dash), sequence input is read from stdin.

Options

Expert Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

-a Additionally show a summary statistic line showing the

name, length, and description of each individual sequence.
Each of these lines is preﬁxed by an = character, in order to
allow these lines to be easily grepped out of the output.

-c Additionally print the residue composition of the sequence

ﬁle.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--amino Assert that the seqfile contains protein sequences.

--dna Assert that the seqfile contains DNA sequences.

--rna Assert that the seqfile contains RNA sequences.

hmmer user’s guide

185

esl-sfetch - retrieve (sub-)sequences from a sequence ﬁle

Synopsis

esl-sfetch [options] seqfile key

(retrieve a single sequence by key)
esl-sfetch -c from..to [options] seqfile key

(retrieve a single subsequence by key and coords)

esl-sfetch -f [options] seqfile keyfile

(retrieve multiple sequences using a ﬁle of keys)

esl-sfetch -Cf [options] seqfile subseq-coord-file

(retrieve multiple subsequences using ﬁle of keys and coords)

esl-sfetch --index msafile

(index a sequence ﬁle for retrievals)

Description

esl-sfetch retrieves one or more sequences or subsequences from seqfile.

The seqfile must be indexed using esl-sfetch --index seqfile. This creates an SSI

index ﬁle seqfile.ssi.

To retrieve a single complete sequence, do esl-sfetch seqfile key, where key is the

name or accession of the desired sequence.

To retrieve a single subsequence rather than a complete sequence, use the -c
start..end option to provide start and end coordinates. The start and end coordinates
are provided as one string, separated by any nonnumeric, nonwhitespace character or
characters you like; see the -c option below for more details.

To retrieve more than one complete sequence at once, you may use the -f option,
and the second command line argument will specify the name of a keyfile that con-
tains a list of names or accessions, one per line; the ﬁrst whitespace-delimited ﬁeld on
each line of this ﬁle is parsed as the name/accession.

To retrieve more than one subsequence at once, use the -C option in addition to -f,
and now the second argument is parsed as a list of subsequence coordinate lines. See
the -C option below for more details, including the format of these lines.

In DNA/RNA ﬁles, you may extract (sub-)sequences in reverse complement orien-
tation in two different ways: either by providing a from coordinate that is greater than
to, or by providing the -r option.

When the -f option is used to do multiple (sub-)sequence retrieval, the ﬁle argu-
ment may be - (a single dash), in which case the list of names/accessions (or subse-
quence coordinate lines) is read from standard input. However, because a standard
input stream can’t be SSI indexed, (sub-)sequence retrieval from stdin may be slow.

Options

-h Print brief help; includes version number and summary of all

options, including expert options.

186

sean r. eddy

-c coords Retrieve a subsequence with start and end coordinates spec-

iﬁed by the coords string. This string consists of start and
end coordinates separated by any nonnumeric, nonwhites-
pace character or characters you like; for example, -c 23..100,
-c 23/100, or -c 23-100 all work. To retrieve a sufﬁx of a sub-
sequence, you can omit the end ; for example, -c 23: would
work. To specify reverse complement (for DNA/RNA se-
quence), you can specify from greater than to; for example, -c
100..23 retrieves the reverse complement strand from 100 to
23.

-f

Interpret the second argument as a keyfile instead of as just
one key. The ﬁrst whitespace-limited ﬁeld on each line of
keyfile is interpreted as a name or accession to be fetched.
This option doesn’t work with the --index option. Any other
ﬁelds on a line after the ﬁrst one are ignored. Blank lines and
lines beginning with # are ignored.

-o <f> Output retrieved sequences to a ﬁle <f> instead of to stdout.

-n <s> Rename the retrieved (sub-)sequence <s>. Incompatible with

-f.

-r Reverse complement the retrieved (sub-)sequence. Only

accepted for DNA/RNA sequences.

-C Multiple subsequence retrieval mode, with -f option (re-

quired). Speciﬁes that the second command line argument
is to be parsed as a subsequence coordinate ﬁle, consist-
ing of lines containing four whitespace-delimited ﬁelds:
new_name, from, to, name/accession. For each such line, sequence
name/accession is found, a subsequence from..to is extracted,
and the subsequence is renamed new_name before being output.
Any other ﬁelds after the ﬁrst four are ignored. Blank lines
and lines beginning with # are ignored.

-O Output retrieved sequence to a ﬁle named key. This is a con-

venience for saving some typing: instead of

% esl-sfetch -o SRPA_HUMAN swissprot SRPA_HUMAN

you can just type

% esl-sfetch -O swissprot SRPA_HUMAN

The -O option only works if you’re retrieving a single align-
ment; it is incompatible with -f.

--index

Instead of retrieving a key, the special command esl-sfetch
--index seqfile produces an SSI index of the names and ac-
cessions of the alignments in the seqfile. Indexing should be
done once on the seqfile to prepare it for all future fetches.

hmmer user’s guide

187

Expert Options

--informat <s> Assert that seqfile is in format <s>, bypassing format autode-
tection. Common choices for <s> include: fasta, embl, genbank.
Alignment formats also work; common choices include:
stockholm, a2m, afa, psiblast, clustal, phylip. For more informa-
tion, and for codes for some less common formats, see main
documentation. The string <s> is case-insensitive (fasta or
FASTA both work).

188

sean r. eddy

esl-shuffle - shufﬂing sequences or generating random ones

Synopsis

esl-shuffle [options] seqfile
(shufﬂe sequences)
esl-shuffle -G [options]

(generate random sequences)

esl-shuffle -A [options] msafile

(shufﬂe multiple sequence alignments)

Description

esl-shuffle has three different modes of operation.

By default, esl-shuffle reads individual sequences from seqfile, shufﬂes them,
and outputs the shufﬂed sequences. By default, shufﬂing is done by preserving
monoresidue composition; other options are listed below.

With the -G option, esl-shuffle generates some number of random sequences of
some length in some alphabet. The -N option controls the number (default is 1), the
-L option controls the length (default is 0), and the --amino, --dna, and --rna options
control the alphabet.

With the -A option, esl-shuffle reads one or more multiple alignments from msafile

shufﬂes them, and outputs the shufﬂed alignments. By default, the alignment is
shufﬂed columnwise (i.e. column order is permuted). Other options are listed below.

General Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

-o <f> Direct output to a ﬁle named <f> rather than to stdout.

-N <n> Generate <n> sequences, or <n> perform independent shuf-

ﬂes per input sequence or alignment.

-L <n> Generate sequences of length <n>, or truncate output shuf-

ﬂed sequences or alignments to a length of <n>.

Sequence Shufﬂing Options

These options only apply in default (sequence shufﬂing) mode. They are mutually
exclusive.

-m Monoresidue shufﬂing (the default): preserve monoresidue

composition exactly. Uses the Fisher/Yates algorithm (aka
Knuth’s "Algorithm P").

-d Diresidue shufﬂing; preserve diresidue composition exactly.

Uses the Altschul/Erickson algorithm (Altschul and Erick-

hmmer user’s guide

189

son, 1986). A more efﬁcient algorithm (Kandel and Winkler
1996) is known but has not yet been implemented in Easel.

-0 0th order Markov generation: generate a sequence of the
same length with the same 0th order Markov frequencies.
Such a sequence will approximately preserve the monoresidue
composition of the input.

-1 1st order Markov generation: generate a sequence of the
same length with the same 1st order Markov frequencies.
Such a sequence will approximately preserve the diresidue
composition of the input.

-r Reversal; reverse each input.

-w <n> Regionally shufﬂe the input in nonoverlapping windows of

size <n> residues, preserving exact monoresidue composition
in each window.

Multiple Alignment Shufﬂing Options

-b Sample columns with replacement, in order to generate a

bootstrap-resampled alignment dataset.

-v Shufﬂe residues with each column independently; i.e., per-
mute residue order in each column ("vertical" shufﬂing).

Sequence Generation Options

One of these must be selected, if -G is used.

--amino Generate amino acid sequences.

--dna Generate DNA sequences.

--rna Generate RNA sequences.

Expert Options

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--seed <n> Specify the seed for the random number generator, where

the seed <n> is an integer greater than zero. This can be used
to make the results of esl-shuffle reproducible. If <n> is
0, the random number generator is seeded arbitrarily and

190

sean r. eddy

stochastic simulations will vary from run to run. Arbitrary
seeding (0) is the default.

hmmer user’s guide

191

esl-ssdraw - create postscript secondary structure diagrams

Synopsis

esl-ssdraw [options] msafile postscript_template postscript_output_file

Description

esl-ssdraw reads an existing template consensus secondary structure diagram from
postscript_template and creates new postscript diagrams including the template struc-
ture but with positions colored differently based on alignment statistics such as fre-
quency of gaps per position, average posterior probability per position or information
content per position. Additionally, all or some of the aligned sequences can be drawn
separately, with nucleotides or posterior probabilities mapped onto the corresponding
positions of the consensus structure.

The alignment must be in Stockholm format with per-column reference annota-
tion (#=GC RF). The sequences in the alignment must be RNA or DNA sequences.
The postscript_template ﬁle must contain one page that includes <rﬂen> consensus
nucleotides (positions), where <rﬂen> is the number of nongap characters in the ref-
erence (RF) annotation of the ﬁrst alignment in msafile. The speciﬁc format required
in the postscript_template is described below in the INPUT section. Postscript diagrams
will only be created for the ﬁrst alignment in msafile.

Output

By default (if run with zero command line options), esl-ssdraw will create a six or
seven page postscript_output_file, with each page displaying a different alignment
statistic. These pages display the alignment consensus sequence, information con-
tent per position, mutual information per position, frequency of inserts per position,
average length of inserts per position, frequency of deletions (gaps) per position,
and average posterior probability per position (if posterior probabilites exist in the
alignment) If -d is enabled, all of these pages plus additional ones, such as individ-
ual sequences (see discussion of --indi below) will be drawn. These pages can be
selected to be drawn individually by using the command line options --cons, --info,
--mutinfo, --ifreq, --iavglen, --dall, and --prob. The calculation of the statistics for each
of these options is discussed below in the description for each option. Importantly,
only so-called ’consensus’ positions of the alignment will be drawn. A consensus
position is one that is a nongap nucleotide in the ’reference’ annotation of the Stock-
holm alignment (#=GC RF) read from msafile.

By default, a consensus sequence for the input alignment will be calculated and
displayed on the alignment statistic diagrams. The consensus sequence is deﬁned
as the most common nucleotide at each consensus position of the alignment. The
consensus sequence will not be displayed if the --no-cnt option is used. The --cthresh,
--cambig, and --athresh options affect the deﬁnition of the consensus sequence as ex-
plained below in the descriptions for those options.

192

sean r. eddy

If the --tabfile <f> option is used, a tab-delimited text ﬁle <f> will be created
that includes per-position lists of the numerical values for each of the calculated
statistics that were drawn to postscript_output_file. Comment lines in <f> are preﬁxed
with a ’#’ character and explain the meaning of each of the tab-delimited columns
and how each of the statistics was calculated. If --indi is used, esl-ssdraw will create
diagrams showing each sequence in the alignment on a separate page, with aligned
nucleotides in their corresponding position in the structure diagram. By default,
basepaired nucleotides will be colored based on their basepair type: either Watson-
Crick (A:U, U:A, C:G, or G:C), G:U or U:G, or non-canonical (the other ten possible
basepairs). This coloring can be turned off with the --no-bp option. Also by default,
nucleotides that differ from the most common nucleotide at each aligned consensus
position will be outlined. If the most common nucleotide occurs in more than 75% of
sequences that do not have a gap at that position, the outline will be bold. Outlining
can be turned off with the --no-ol option.

With --indi, if the alignment contains posterior probability annotation (#=GR PP),

the postscript_output_file will contain an additional page for each sequence drawn
with positions colored by the posterior probability of each aligned nucleotide. No
posterior probability pages will be drawn if the --no-pp option is used.

esl-ssdraw can also be used to draw ’mask’ diagrams which color positions of the
structure one of two colors depending on if they are included or excluded by a mask.
This is enabled with the --mask-col <f> option. <f> must contain a single line of
<rﬂen> characters, where <rﬂen> is the the number of nongap RF characters in the
alignment. The line must contain only ’0’ and ’1’ characters. A ’0’ at position <x>
of the string indicates position <x> is excluded from the mask, and a ’1’ indicates
position <x> is included by the mask. A page comparing the overlap of the <f>
mask from --mask-col and another mask in <f2> will be created if the --mask-diff <f2>
option is used.

If the --mask <f> option is used, positions excluded by the mask in <f> will be
drawn differently (as open circles by default) than positions included by the mask.
The style of the masked positions can be modiﬁed with the --mask-u, --mask-x, and
--mask-a options.

Finally, two different types of input ﬁles can be used to customize output diagrams

using the --dfile and --efile options, as described below.

Input

The postscript_template_file is a postscript ﬁle that must be in a very speciﬁc format in
order for esl-ssdraw to work. The speciﬁcs of the format, described below, are likely
to change in future versions of esl-ssdraw. The postscript_output_file ﬁles generated
by esl-ssdraw will not be valid postscript_template_file format (i.e. an output ﬁle from
esl-ssdraw cannot be used as an postscript_template_file in a subsequent run of the
program).

An example postscript_template_file (’trna-ssdraw.ps’) is included with the Easel

distribution in the ’testsuite/’ subdirectory of the top-level ’easel’ directory.

hmmer user’s guide

193

The postscript_template_file is a valid postscript ﬁle. It includes postscript com-
mands for drawing a secondary structure. The commands specify x and y coordi-
nates for placing each nucleotide on the page. The postscript_template_file might also
contain commands for drawing lines connecting basepaired positions and tick marks
indicating every tenth position, though these are not required, as explained below.
If you are unfamiliar with the postscript language, it may be useful for you to
know that a postscript page is, by default, 612 points wide and 792 points tall. The
(0,0) coordinate of a postscript ﬁle is at the bottom left corner of the page, (0,792) is
the top left, (612,0) is the bottom right, and (612,792) is the top right. esl-ssdraw uses
8 point by 8 point cells for drawing positions of the consensus secondary structure.
The ’scale’ section of the postscript_template_file allows for different ’zoom levels’, as
described below. Also, it is important to know that postscript lines beginning with
’%’ are considered comments and do not include postscript commands.

An esl-ssdraw postscript_template_file contains n >= 1 pages, each specifying a
consensus secondary structure diagram. Each page is delimited by a ’showpage’
line in an ’ignore’ section (as described below). esl-ssdraw will read all pages of the
postscript_template_file and then choose the appropriate one that corresponds with the
alignment in msafile based on the consensus (nongap RF) length of the alignment. For
an alignment of consensus length <rﬂen>, the ﬁrst page of postscript_template_file
that has a structure diagram with consensus length <rﬂen> will be used as the tem-
plate structure for the alignment.

Each page of postscript_template_file contains blocks of text organized into seven

different possible sections. Each section must begin with a single line ’% begin
<sectionname>’ and end with a single line ’% end <sectionname>’ and have n
>= 1 lines in between. On the begin and end lines, there must be at least one space
between the ’%’ and the ’begin’ or ’end’. <sectionname> must be one of the fol-
lowing: ’modelname’, ’legend’, ’scale’, ’regurgitate’, ’ignore’, ’text positiontext’, ’text
nucleotides’, ’lines positionticks’, or ’lines bpconnects’. The n >=1 lines in between
the begin and end lines of each section must be in a speciﬁc format that differs for
each section as described below.

Importantly, each page must end with an ’ignore’ section that includes a single line
’showpage’ between the begin and end lines. This lets esl-ssdraw know that a page has
ended and another might follow.

Each page of a postscript_template_file must include a single ’modelname’ sec-
tion. This section must include exactly one line in between its begin and end lines.
This line must begin with a ’%’ character followed by a single space. The remain-
der of the line will be parsed as the model name and will appear on each page of
postscript_output_file in the header section. If the name is more than 16 characters, it
will be truncated in the output.

Each page of a postscript_template_file must include a single ’legend’ section. This

section must include exactly one line in between its begin and end lines. This line
must be formatted as ’% <d1> <f1> <f2> <d2> <f3>’, where <d1> is an integer
specifying the consensus position with relation to which the legend will be placed;
<f1> and <f2> specify the x and y axis offsets for the top left corner of the legend

194

sean r. eddy

relative to the x and y position of consensus position <d1>; <d2> speciﬁes the size
of a cell in the legend and <f3> speciﬁes how many extra points should be between
the right hand edge of the legend and the end of the page. the offset of the right hand
end of the legend . For example, the line ’% 34 -40. -30. 12 0.’ specﬁes that the legend
be placed 40 points to the left and 30 points below the 34th consensus position, that
cells appearing in the legend be squares of size 12 points by 12 points, and that the
right hand side of the legend ﬂush against the right hand edge of the printable page.
Each page of a postscript_template_file must include a single ’scale’ section. This
section must include exactly one line in between its begin and end lines. This line
must be formatted as ’<f1> <f2> scale’, where <f1> and <f2> are both positive
real numbers that are identical, for example ’1.7 1.7 scale’ is valid, but ’1.7 2.7 scale’
is not. This line is a valid postscript command which speciﬁes the scale or zoom level
on the pages in the output. If <f1> and <f2> are ’1.0’ the default scale is used for
which the total size of the page is 612 points wide and 792 points tall. A scale of 2.0
will reduce this to 306 points wide by 396 points tall. A scale of 0.5 will increase it
to 1224 points wide by 1584 points tall. A single cell corresponding to one position
of the secondary structure is 8 points by 8 points. For larger RNAs, a scale of less
than 1.0 is appropriate (for example, SSU rRNA models (about 1500 nt) use a scale of
about 0.6), and for smaller RNAs, a scale of more than 1.0 might be desirable (tRNA
(about 70 nt) uses a scale of 1.7). The best way to determine the exact scale to use is
trial and error.

Each page of a postscript_template_file can include n >= 0 ’regurgitate’ sections.
These sections can include any number of lines. The text in this section will not be
parsed by esl-ssdraw but will be included in each page of postscript_output_file. The
format of the lines in this section must therefore be valid postscript commands. An
example of content that might be in a regurgitate section are commands to draw lines
and text annotating the anticodon on a tRNA secondary structure diagram.

Each page of a postscript_template_file must include at least 1 ’ignore’ section.
One of these sections must include a single line that reads ’showpage’. This sec-
tion should be placed at the end of each page of the template ﬁle. Other ignore sec-
tions can include any number of lines. The text in these section will not be parsed
by esl-ssdraw nor will it be included in each page of postscript_output_file. An ignore
section can contain comments or postscript commands that draw features of the
postscript_template_file that are unwanted in the postscript_output_file.

Each page of a postscript_template_file must include a single ’text nucleotides’ sec-
tion. This section must include exactly <rﬂen> lines, indicating that the consensus
secondary structure has exactly <rﬂen> nucleotide positions. Each line must be of
the format ’(<c>) <x> <y> moveto show’ where <c> is a nucleotide (this can be
any character actually), and <x> and <y> are the coordinates specifying the loca-
tion of the nucleotide on the page, they should be positive real numbers. The best
way to determine what these coordinates should be is manually by trial and error,
by inspecting the resulting structure as you add each nucleotide. Note that esl-ssdraw
will color an 8 point by 8 point cell for each position, so nucleotides should be placed
about 8 points apart from each other.

hmmer user’s guide

195

Each page of a postscript_template_file may or may not include a single ’text po-
sitiontext’ section. This section can include n >= 1 lines, each specifying text to be
placed next to speciﬁc positions of the structure, for example, to number them. Each
line must be of the format ’(<s>) <x> <y> moveto show’ where <s> is a string
of text to place at coordinates (<x>,<y>) of the postscript page. Currently, the best
way to determine what these coordinates is manually by trial and error, by inspecting
the resulting diagram as you add each line.

Each page of a postscript_template_file may or may not include a single ’lines po-
sitionticks’ section. This section can include n >= 1 lines, each specifying the loca-
tion of a tick mark on the diagram. Each line must be of the format ’<x1> <y1>
<x2> <y2> moveto show’. A tick mark (line of width 2.0) will be drawn from point
(<x1>,<y1>) to point (<x2>,<y2>) on each page of postscript_output_file. Cur-
rently, the best way to determine what these coordinates should be is manually by
trial and error, by inspecting the resulting diagram as you add each line.

Each page of a postscript_template_file may or may not include a single ’lines bp-
connects’ section. This section must include <nbp> lines, where <nbp> is the num-
ber of basepairs in the consensus structure of the input msafile annotated as #=GC
SS_cons. Each line should connect two basepaired positions in the consensus struc-
ture diagram. Each line must be of the format ’<x1> <y1> <x2> <y2> moveto
show’. A line will be drawn from point (<x1>,<y1>) to point (<x2>,<y2>) on each
page of postscript_output_file. Currently, the best way to determine what these coordi-
nates should be is manually by trial and error, by inspecting the resulting diagram as
you add each line.

Required Memory

The memory required by esl-ssdraw will be equal to roughly the larger of 2 Mb and
the size of the ﬁrst alignment in msafile. If the --small option is used, the memory
required will be independent of the alignment size. To use --small the alignment must
be in Pfam format, a non-interleaved (1 line/seq) version of Stockholm format. If the
--indi option is used, the required memory may exceed the size of the alignment by
up to ten-fold, and the output postscript_output_file may be up to 50 times larger than
the msafile.

Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

-d Draw the default set of alignment summary diagrams: con-
sensus sequence, information content, mutual information,
insert frequency, average insert length, deletion frequency,
and average posterior probability (if posterior probability
annotation exists in the alignment). These diagrams are also
drawn by default (if zero command line options are used),

196

sean r. eddy

but using the -d option allows the user to add additional
pages, such as individual aligned sequences with --indi.

--mask <f> Read the mask from ﬁle <f>, and draw positions differ-

ently in postscript_output_file depending on whether they are
included or excluded by the mask. <f> must contain a sin-
gle line of length <rﬂen> with only ’0’ and ’1’ characters.
<rﬂen> is the number of nongap characters in the reference
(#=GC RF) annotation of the ﬁrst alignment in msafile A ’0’
at position <x> of the mask indicates position <x> is ex-
cluded by the mask, and a ’1’ indicates that position <x> is
included by the mask.

--small Operate in memory saving mode. Without --indi, required

RAM will be independent of the size of the alignment in
msafile. With --indi, the required RAM will be roughly ten
times the size of the alignment in msafile. For --small to work,
the alignment must be in Pfam Stockholm (non-interleaved 1
line/seq) format.

--rf Add a page to postscript_output_file showing the reference

sequence from the #=GC RF annotation in msafile. By default,
basepaired nucleotides will be colored based on what type of
basepair they are. To turn this off, use --no-bp. This page is
drawn by default (if zero command-line options are used).

--info Add a page to postscript_output_file with consensus (nongap

RF) positions colored based on their information content
from the alignment. Information content is calculated as 2.0 -
H, where H = sum_x p_x log_2 p_x for x in {A,C,G,U}. This
page is drawn by default (if zero command-line options are
used).

--mutinfo Add a page to postscript_output_file with basepaired consen-

sus (nongap RF) positions colored based on the amount of
mutual information they have in the alignment. Mutual in-
formation is sum_{x,y} p_{x,y} log_2 ((p_x * p_y) / p_{x,y},
where x and y are the four possible bases A,C,G,U. p_x is
the fractions of aligned sequences that have nucleotide x of
in the left half (5’ half) of the basepair. p_y is the fraction
of aligned sequences that have nucleotide y in the position
corresponding to the right half (3’ half) of the basepair. And
p_{x,y} is the fraction of aligned sequences that have base-
pair x:y. For all p_x, p_y and p{x,y} only sequences that that
have a nongap nucleotide at both the left and right half of the
basepair are counted. This page is drawn by default (if zero
command-line options are used).

hmmer user’s guide

197

--ifreq Add a page to postscript_output_file with each consensus
(nongap RF) position colored based on the fraction of se-
quences that span each position that have at least 1 inserted
nucleotide after the position. A sequence s spans consensus
position x that is actual alignment position a if s has at least
one nongap nucleotide aligned to a position b <= a and at
least one nongap nucleotide aligned to a consensus position
c >= a. This page is drawn by default (if zero command-line
options are used).

--iavglen Add a page to postscript_output_file with each consensus
(nongap RF) position colored based on average length of
insertions that occur after it. The average is calculated as the
total number of inserted nucleotides after position x, divided
by the number of sequences that have at least 1 inserted
nucleotide after position x (so the minimum possible average
insert length is 1.0).

--dall Add a page to postscript_output_file with each consensus
(nongap RF) position colored based on the fraction of se-
quences that have a gap (delete) at the position. This page is
drawn by default (if zero command-line options are used).

--dint Add a page to postscript_output_file with each consensus
(nongap RF) position colored based on the fraction of se-
quences that have an internal gap (delete) at the position.
An internal gap in a sequence is one that occurs after (5’ of)
the sequence’s ﬁrst aligned nucleotide and after (3’ of) the
sequence’s ﬁnal aligned nucleotide. This page is drawn by
default (if zero command-line options are used).

--prob Add a page to postscript_output_file with positions colored
based on average posterior probability (PP). The alignment
must contain #=GR PP annotation for all sequences. PP an-
notation is converted to numerical PP values as follows: ’*’ =
0.975, ’9’ = 0.90, ’8’ = 0.80, ’7’ = 0.70, ’6’ = 0.60, ’5’ = 0.50, ’4’
= 0.40, ’3’ = 0.30, ’2’ = 0.20, ’1’ = 0.10, ’0’ = 0.025. This page is
drawn by default (if zero command-line options are used).

--span Add a page to postscript_output_file with consensus (nongap
RF) positions colored based on the fraction of sequences that
’span’ the position. A sequence s spans consensus position x
that is actual alignment position a if s has at least one nongap
nucleotide aligned to a position b <= a and at least one non-
gap nucleotide aligned to a consensus position c >= a. This
page is drawn by default (if zero command-line options are
used).

198

sean r. eddy

Options for Drawing Individual Aligned Sequences

--indi Add a page displaying the aligned nucleotides in their cor-

responding consensus positions of the structure diagram for
each aligned sequence in the alignment. By default, base-
paired nucleotides will be colored based on what type of
basepair they are. To turn this off, use --no-bp. If posterior
probability information (#=GR PP) exists in the alignment,
one additional page per sequence will be drawn displaying
the posterior probabilities.

-f With --indi, force esl-ssdraw to create a diagram, even if it is

predicted to be large (> 100 Mb). By default, if the predicted
size exceeds 100 Mb, esl-ssdraw will fail with a warning.

Options for Omitting Parts of the Diagrams

--no-leg Omit the legend on all pages of postscript_output_file.

--no-head Omit the header on all pages of postscript_output_file.

--no-foot Omit the footer on all pages of postscript_output_file.

Options for Simple Two-color Mask Diagrams

--mask-col With --mask, postscript_output_file will contain exactly 1 page

showing positions included by the mask as black squares,
and positions excluded as pink squares.

--mask-diff <f> With --mask <f2> and mask-col, postscript_output_file will con-
tain one additional page comparing the mask from <f> and
the mask from <f2>. Positions will be colored based on
whether they are included by one mask and not the other,
excluded by both masks, and included by both masks.

Expert Options for Controlling Individual Sequence Diagrams

--no-pp When used in combination with --indi, do not draw posterior
probability structure diagrams for each sequence, even if the
alignment has PP annotation.

--no-bp Do not color basepaired nucleotides based on their basepair

type.

--no-ol When used in combination with --indi, do not outline nu-
cleotides that differ from the majority rule consensus nu-
cleotide given the alignment.

--no-ntpp When used in combination with --indi, do not draw nu-

cleotides on the individual sequence posterior probability
diagrams.

hmmer user’s guide

199

Expert Options Related to Consensus Sequence Deﬁnition

--no-cnt Do not draw consensus nucleotides on alignment statistic

diagrams (such as information content diagrams). By default,
the consensus nucleotide is deﬁned as the most frequent
nucleotide in the alignment at the corresponding position.
Consensus nucleotides that occur in at least <x> fraction
of the aligned sequences (that do not contain a gap at the
position) are capitalized. By default <x> is 0.75, but can be
changed with the --cthresh <x> option.

--cthresh <x> Specify the threshold for capitalizing consensus nucleotides

deﬁned by the majority rule (i.e. when --cambig is not en-
abled) as <x>.

--cambig Change how consensus nucleotides are calculated from ma-

jority rule to the least ambiguous IUPAC nucleotide that
represents at least <x> fraction of the nongap nucleotides at
each consensus position. By default <x> is 0.9, but can be
changed with the --athresh <x> option.

--athresh <x> With --cambig, specify the threshold for deﬁning consensus
nucleotides is the least ambiguous IUPAC nucleotide that
represents at least <x> fraction of the nongap nucleotides at
each position.

Expert Options Controlling Style of Masking Positions

--mask-u With --mask, change the style of masked columns to squares.

--mask-x With --mask, change the style of masked columns to x’s.

--mask-a With --mask and --mask-u or --mask-x draw the alternative style

of square or ’x’ masks.

Expert Options Related to Input Files

--dfile <f> Read the ’draw ﬁle’ <f> which speciﬁes numerical values

for each consensus position in one or more postscript pages.
For each page, the draw ﬁle must include <rﬂen>+3 lines
(<rﬂen> is deﬁned in the DESCRIPTION section). The ﬁrst
three lines are special. The following <rﬂen> ’value lines’
each must contain a single number, the numerical value for
the corresponding position. The ﬁrst of the three special
lines deﬁnes the ’description’ for the page. This should be
text that describes what the numerical values refer to for the
page. The maximum allowable length is roughly 50 char-
acters (the exact maximum length depends on the template

200

sean r. eddy

ﬁle and the program will report an informative error mes-
sage upon execution if it is exceeded). The second special
line deﬁnes the ’legend header’ line that which will appear
immediately above the legend. It has a maximum allowable
length of about 30 characters. The third special line per page
must contain exactly 7 numbers, which must be in increasing
order, each separated by a space. These numbers deﬁne the
numerical ranges for the six different colors used to draw
the consensus positions on the page. The ﬁrst number de-
ﬁnes the minimum value for the ﬁrst color (blue) and must
be less than or equal to the minimum value from the value
lines. The second number deﬁnes the minimum value for the
second color (turquoise). The third, fourth, ﬁfth and sixth
numbers deﬁne the minimum values for the third, fourth,
ﬁfth and sixth colors (light green, yellow, orange, red), and
the seventh ﬁnal number deﬁnes the maximum value for red
and must be equal to or greater than the maximum value
from the value lines. After the <rﬂen> value lines, there
must exist a special line with only ’//’, signifying the end
of a page. The draw ﬁle <f> must end with this special ’//’
line, even if it only includes a single page. A draw ﬁle spec-
ifying <n> pages should include exactly <n> * (<rﬂen> +
4) lines.

--efile <f> Read the ’expert draw ﬁle’ <f> which speciﬁes the colors

and nucleotides to draw on each consensus position in one
or more postscript pages. Unlike with the --dfile option, no
legend will be drawn when --efile is used. For each page,
the draw ﬁle must include <rﬂen> lines, each with four
or ﬁve tab-delimited tokens. The ﬁrst four tokens on line
<x> specify the color to paint position <x> and must be
real numbers between 0 and 1. The four numbers specify
the cyan, magenta, yellow and black values, respectively,
in the CMYK color scheme for the postscript ﬁle. The ﬁfth
token on line <x> speciﬁes which nucleotide to write on
position <x> (on top of the colored background). If the ﬁfth
token does not exist, no nucleotide will be written. After
the <rﬂen> lines, there must exist a special line with only
’//’, signifying the end of a page. The expert draw ﬁle <f>
must end with this special ’//’ line, even if it only includes a
single page. A expert draw ﬁle specifying <n> pages should
include exactly <n> * (<rﬂen> + 1) lines.

--ifile <f> Read insert information from the ﬁle <f>, which may have

been created with INFERNAL’s cmalign(1) program. The insert
information in msafile will be ignored and the information

hmmer user’s guide

201

from <f> will supersede it. Inserts are columns that are gaps
in the reference (#=GC RF) annotation.

202

sean r. eddy

esl-translate - translate DNA sequence in six frames into individual

ORFs

Synopsis

esl-translate [options] seqfile

Description

Given a seqfile containing DNA or RNA sequences, esl-translate outputs a six-frame
translation of them as individual open reading frames in FASTA format.

By default, only open reading frames greater than 20aa are reported. This mini-

mum ORF length can be changed with the -l option.

By default, no speciﬁc initiation codon is required, and any amino acid can start
an open reading frame. This is so esl-translate may be used on sequence fragments,
eukaryotic genes with introns, or other cases where we do not want to assume that
ORFs are complete coding regions. This behavior can be changed. With the -m op-
tion, ORFs start with an initiator AUG Met. With the -M option, ORFs start with any
of the initiation codons allowed by the genetic code. For example, the "standard" code
(NCBI transl_table 1) allows AUG, CUG, and UUG as initiators. When -m or -M are
used, an initiator is always translated to Met (even if the initiator is something like
UUG or CUG that doesn’t encode Met as an elongator).

If seqfile is - (a single dash), input is read from the stdin pipe. This (combined with

the output being a standard FASTA ﬁle) allows esl-translate to be used in command
line incantations. If seqfile ends in .gz, it is assumed to be a gzip-compressed ﬁle, and
Easel will try to read it as a stream from gunzip -c.

Output Format

The output FASTA name/description line contains information about the source and
coordinates of each ORF. Each ORF is named orf1, etc., with numbering starting from
1, in order of their start position on the top strand followed by the bottom strand.
The rest of the FASTA name/desc line contains 4 additional ﬁelds, followed by the
description of the source sequence:

source=<s> <s> is the name of the source DNA/RNA sequence.

coords=start..end Coords, 1..L, for the translated ORF in a source DNA se-

quence of length L. If start is greater than end, the ORF is on
the bottom (reverse complement) strand. The start is the ﬁrst
nucleotide of the ﬁrst codon; the end is the last nucleotide of
the last codon. The stop codon is not included in the coordi-
nates (unlike in CDS annotation in GenBank, for example.)

length=<n> Length of the ORF in amino acids.

hmmer user’s guide

203

frame=<n> Which frame the ORF is in. Frames 1..3 are the top strand;
4..6 are the bottom strand. Frame 1 starts at nucleotide 1.
Frame 4 starts at nucleotide L.

Alternative Genetic Codes

By default, the "standard" genetic code is used (NCBI transl_table 1). Any NCBI
genetic code transl_table can be selected with the -c option, as follows:

1

Standard

2 Vertebrate mitochondrial

3 Yeast mitochondrial

4 Mold, protozoan, coelenterate mitochondrial; Mycoplasma/Spiroplasma

5

Invertebrate mitochondrial

6 Ciliate, dasycladacean, Hexamita nuclear

9

10

Echinoderm and ﬂatworm mitochondrial

Euplotid nuclear

11 Bacterial, archaeal; and plant plastid

12 Alternative yeast

13 Ascidian mitochondrial

14 Alternative ﬂatworm mitochondrial

16 Chlorophycean mitochondrial

21

22

23

24

Trematode mitochondrial

Scenedesmus obliquus mitochondrial

Thraustochytrium mitochondrial

Pterobranchia mitochondrial

25 Candidate Division SR1 and Gracilibacteria

As of this writing, more information about the genetic codes in the NCBI transla-

tion tables is at http://www.ncbi.nlm.nih.gov/Taxonomy/ at a link titled Genetic codes.

Iupac Degeneracy Codes in Dna

DNA sequences may contain IUPAC degeneracy codes, such as N, R, Y, etc. If all
codons consistent with a degenerate codon translate to the same amino acid (or
to a stop), that translation is done; otherwise, the codon is translated as X (even if
one or more compatible codons are stops). For example, in the standard code, UAR
translates to * (stop), GGN translates to G (glycine), NNN translates to X, and UGR
translates to X (it could be either a UGA stop or a UGG Trp).

Degenerate initiation codons are handled essentially the same. If all codons con-

sistent with the degenerate codon are legal initiators, then the codon is allowed to

204

sean r. eddy

initiate a new ORF. Stop codons are never a legal initiator (not only with -m or -M but
also with the default of allowing any amino acid to initiate), so degenerate codons
consistent with a stop cannot be initiators. For example, NNN cannot initiate an
ORF, nor can UGR -- even though they translate to X. This means that we don’t trans-
late long stretches of N’s as long ORFs of X’s, which is probably a feature, given the
prevalence of artiﬁcial runs of N’s in genome sequence assemblies.

Degenerate DNA codons are not translated to degenerate amino acids other than
X, even when that is possible. For example, SAR and MUH are decoded as X, not Z
(Q|E) and J (I|L). The extra complexity needed for a degenerate to degenerate transla-
tion doesn’t seem worthwhile.

Options

-h Print brief help. Includes version number and summary
of all options. Also includes a list of the available NCBI
transl_tables and their numerical codes, for the -c option.

-c <id> Choose alternative genetic code <id> where <id> is the nu-

merical code of one of the NCBI transl_tables.

-l <n> Set the minimum reported ORF length to <n> aa.

-m Require ORFs to start with an initiator codon AUG (Met).

-M Require ORFs to start with an initiator codon, as speciﬁed by

the allowed initiator codons in the NCBI transl_table. In the
default Standard code, AUG, CUG, and UUG are allowed as
initiators. An initiation codon is always translated as Met,
even if it does not normally encode Met as an elongator.

-W Use a memory-efﬁcient windowed sequence reader. The de-
fault is to read entire DNA sequences into memory, which
may become memory limited for some very large eukaryotic
chromosomes. The windowed reader cannot reverse comple-
ment a nonrewindable input stream, so either seqfile must be
a ﬁle, or you must use --watson to limit translation to the top
strand.

--informat <s> Assert that input seqfile is in format <s>, bypassing format
autodetection. Common choices for <s> include: fasta, embl,
genbank. Alignment formats also work; common choices in-
clude: stockholm, a2m, afa, psiblast, clustal, phylip. For more
information, and for codes for some less common formats,
see main documentation. The string <s> is case-insensitive
(fasta or FASTA both work).

--watson Only translate the top strand.

--crick Only translate the bottom strand.

hmmer user’s guide

205

esl-weight - calculate sequence weights in MSA(s)

Synopsis

esl-weight [options] msafile

Description

esl-weight calculates individual sequence weights for each alignment in msafile and
outputs a new multiple sequence alignment ﬁle in Stockholm format with the weights
annotated in Stockholm-format #=GS seqname WT weight lines. The default weighting
algorithm is the Gerstein/Sonnhammer/Chothia algorithm.

If msafile is - (a single dash), MSA input is read from stdin.

Options

-h

Print brief help; includes version number and summary of all
options, including expert options.

-g Use the Gerstein/Sonnhammer/Chothia weighting algo-

rithm; this is the default.

-p Use the Henikoff position-based weighting algorithm. This is

faster and more memory efﬁcient than the default.

-b

"BLOSUM weights": use approximately the same rule used
in constructing the BLOSUM score matrices. This involves
single-linkage clustering at some fractional identity threshold
(default 0.62; see --id option), then for each cluster, splitting
a total weight of one uniformly amongst all sequences in the
cluster.

Expert Options

--id <x> Sets the fractional identity threshold used by the BLOSUM
weighting rule (option -b; required), to a number 0<=x<=1.
Default is 0.62.

--amino Assert that the msafile contains protein sequences.

--dna Assert that the msafile contains DNA sequences.

--rna Assert that the msafile contains RNA sequences.

1 Indeed, such wizardly incantations are
a point of pride.

Input ﬁles and formats

Reading from ﬁles, compressed ﬁles, and pipes

Generally, HMMER programs read their sequence and/or proﬁle
input from ﬁles. Unix power users often ﬁnd it convenient to string
For example, you
an incantation of commands together with pipes.
might extract a subset of query sequences from a larger ﬁle using
a one-liner combination of scripting commands (python, perl, awk,
whatever). To facilitate the use of HMMER programs in such incanta-
tions, you can almost always use an argument of ’-’ (dash) in place of
a ﬁlename, and the program will take its input from a standard input
pipe instead of opening a ﬁle.

1

For example, the following three commands are equivalent, and

give essentially identical output:

% hmmsearch globins4.hmm uniprot_sprot.fasta

% cat globins4.hmm | hmmsearch - uniprot_sprot.fasta

% cat uniprot_sprot.fasta | hmmsearch globins4.hmm -

Most Easel “miniapp” programs share the same pipe-reading

ability.

Because the programs for proﬁle HMM fetching (hmmfetch) and
sequence fetching (esl-sfetch) can fetch any number of proﬁles or
sequences by names/accessions given in a list, and these programs
can also read these lists from a stdin pipe, you can craft incantations
that generate subsets of queries or targets on the ﬂy. For example:

% esl-sfetch -index uniprot_sprot.fasta

% cat mytargs.list | esl-sfetch -f uniprot_sprot.fasta - | hmmsearch globins4.hmm -

This takes a list of sequence names/accessions in mytargets.list,
fetches them one by one from UniProt (note that we index the UniProt
ﬁle ﬁrst, for fast retrieval; and note that esl-sfetch is reading its
<namefile> list of names/accessions through a pipe using the ’-’ ar-
gument), and pipes them to an hmmsearch. It should be obvious from
this that we can replace the cat mytargets.list with any incantation
that generates a list of sequence names/accessions (including SQL

208

sean r. eddy

database queries).

Ditto for piping subsets of proﬁles. Supposing you have a copy of

Pfam in Pfam-A.hmm:

% hmmfetch -index Pfam-A.hmm

% cat myqueries.list | hmmfetch -f Pfam.hmm - | hmmsearch - uniprot_sprot.fasta

This takes a list of query proﬁle names/accessions in myqueries.list,

fetches them one by one from Pfam, and does an hmmsearch with
each of them against UniProt. As above, the cat myqueries.list part
can be replaced by any suitable incantation that generates a list of
proﬁle names/accessions.

There are three kinds of cases where using ’-’ is restricted or
doesn’t work. A fairly obvious restriction is that you can only use
one ’-’ per command; you can’t do a hmmsearch - - that tries to read
both proﬁle queries and sequence targets through the same stdin
pipe. Second, another case is when an input ﬁle must be obligately
associated with additional, separately generated auxiliary ﬁles, so
reading data from a single stream using ’-’ doesn’t work because
the auxiliary ﬁles aren’t present (in this case, using ’-’ will be pro-
hibited by the program). An example is hmmscan, which needs its
<hmmfile> argument to be associated with four auxiliary ﬁles named
<hmmfile>.h3{mifp} that hmmpress creates, so hmmscan does not permit a ’-’
for its <hmmfile> argument. Finally, when a command would require
multiple passes over an input ﬁle, the command will generally abort
after the ﬁrst pass if you are trying to read that ﬁle through a stan-
dard input pipe (pipes are nonrewindable in general; a few HMMER
or Easel programs will buffer input streams to make multiple passes
possible, but this is not usually the case). An example would be
trying to search a ﬁle containing multiple proﬁle queries against a
streamed target database:

% cat myqueries.list | hmmfetch -f Pfam.hmm > many.hmms

% cat mytargets.list | esl-sfetch -f uniprot_sprot.fasta - | hmmsearch many.hmms -

This will fail. Unfortunately the above business about how it will
“generally abort after the ﬁrst pass” means it fails weirdly. The ﬁrst
query proﬁle search will succeed, and its output will appear; then an
error message will be generated when hmmsearch sees the second proﬁle
query and oops, suddenly realizes it is unable to rewind the target
sequence database stream. This is inherent in how it reads the proﬁle
HMM query ﬁle sequentially as a stream (which is what’s allowing it
to read input from stdin pipes in the ﬁrst place), one model at a time:
it doesn’t see there’s more than one query model in the ﬁle until it
gets to the second model.

This case isn’t too restricting because the same end goal can be

hmmer user’s guide

209

achieved by reordering the commands. In cases where you want to
do multiple queries against multiple targets, you always want to be
reading the queries from a stdin pipe, not the targets:

% cat mytargets.list | esl-sfetch -f uniprot_sprot.fasta > mytarget.seqs

% cat myqueries.list | hmmfetch -f Pfam.hmm - | hmmsearch - mytarget.seqs

So in this multiple queries/multiple targets case of using stdin
pipes, you just have to know, for any given program, which ﬁle it
considers to be queries and which it considers to be targets. (That is,
the logic in searching many queries against many targets is “For each
query: search the target database; then rewind the target database to
the beginning.”) For hmmsearch, the proﬁles are queries and sequences
are targets. For hmmscan, the reverse.

In general, HMMER and Easel programs document in their man
page whether (and which) command line arguments can be replaced
by ’-’. You can always check by trial and error, too. The worst that
can happen is a “Failed to open ﬁle -” error message, if the program
can’t read from pipes.

.gz compressed ﬁles

In general, HMMER programs and Easel miniapps can also read .gz
compressed ﬁles; they will uncompress them on the ﬂy. You need to
have gunzip installed on your system for this to work.

A signiﬁcant exception is jackhmmer, which needs to do multiple
iterations over the same input sequence database. Because it needs to
rewind and read the same target database more than once, jackhmmer
won’t accept a standard input stream as the database argument (un-
like most other programs); and because we treat compressed ﬁles as
standard input streams, by opening a pipe from an external decom-
pression program, jackhmmer won’t accept a compressed seq database
ﬁle either. If a program can’t accept stdin or a .gz ﬁle, it’ll tell you, by
failing with an informative error message.

210

sean r. eddy

HMMER proﬁle HMM ﬁles

A HMMER proﬁle ﬁle looks like this, with ...’s marking elisions made
for clarity and space:

2

2 This is the globins4.hmm proﬁle from
the tutorial.

no
no

no
yes

HMMER3/f [3.4 | Aug 2023]
NAME globins4
LENG 149
ALPH amino
RF
MM
CONS yes
CS
MAP
DATE Sun Aug 13 09:06:20 2023
NSEQ 4
EFFN 0.964844
CKSUM 2027839109
STATS LOCAL MSV
STATS LOCAL VITERBI
STATS LOCAL FORWARD
HMM

-9.8664
-10.7223
-4.1641
C
m->i
4.52198
4.42245
1.87270
4.17850
4.42225
3.85936

0.70955
0.70955
0.70955
D
m->d
2.96929
2.77499
1.29132
3.77264
2.77519
4.58171

A
m->m
2.36800
2.68638
0.55970
1.75819
2.68618
0.03182

COMPO

1

...

149

//

E
i->m

F
i->i

G
d->m

H
d->d

...

W

Y

3.46374
0.19509

2.70577 3.20715 3.01836 3.40293 ...
2.73143
3.72514 ...
1.73023
3.37715 3.71018 3.31297 4.28273 ...
3.72494 ...
2.73123
1.23951
0.61958

2.40505
0.00000

2.40513
0.34183

3.46354
0.77255

*

4.55599 3.63079
4.58497 3.61523

5.32308 4.09587
4.58477 3.61503

9 v - - -

5.42994 4.19803
4.58493 3.61420

165 k - - -

2.93078
2.68634
0.21295

5.12630
4.42241
1.65128

3.29219
2.77535

2.66308 4.49202 3.60568 2.46960 ...
2.73098
3.72510 ...
* 1.49930

3.46370
2.40469
0.25268 0.00000

*

A proﬁle ﬁle consists of one or more proﬁles. Each proﬁle starts

with a format version identiﬁer (here, HMMER3/f) and ends with //
on a line by itself. The format version identiﬁer allows backward
compatibility as the HMMER software evolves: it tells the parser this
3
ﬁle is from HMMER3’s save ﬁle format version f.
allows multiple proﬁles to be concatenated.

The closing //

The format is divided into two regions. The ﬁrst region contains
textual information and miscalleneous parameters in a roughly tag-
value scheme. This section ends with a line beginning with the key-
word HMM. The second region is a tabular, whitespace-limited format
for the main model parameters.

All probability parameters are all stored as negative natural log

probabilities with ﬁve digits of precision to the right of the deci-
mal point, rounded. For example, a probability of 0.25 is stored as
− log 0.25 = 1.38629. The special case of a zero probability is stored
as ’*’.

Spacing is arranged for human readability, but the parser only

cares that ﬁelds are separated by at least one space character.

A more detailed description of the format follows.

3 HMMER 3.0 used 3/b format.
HMMER 3.1 and 3.2 use 3/f format.
Some alpha test versions of 3.0 used
3/a format. Internal development ver-
sions of 3.1 used 3/c, 3/d, and 3/e
formats.

hmmer user’s guide

211

header section

The header section is parsed line by line in a tag/value format. Each
line type is either mandatory or optional as indicated.

HMMER3/f Unique identiﬁer for the save ﬁle format version; the /f
means that this is HMMER3 proﬁle ﬁle format version f.
When HMMER3 changes its save ﬁle format, the revision code
advances. This way, parsers can be backwards compatible. The
remainder of the line after the HMMER3/f tag is free text that is
ignored by the parser. HMMER currently writes its version
number and release date in brackets here, e.g. [3.4 | Aug 2023]
in this example. Mandatory.

NAME <s> Model name; <s> is a single word containing no spaces or
tabs. The name is normally picked up from the #=GF ID line
from a Stockholm alignment ﬁle. If this is not present, the
name is created from the name of the alignment ﬁle by remov-
ing any ﬁle type sufﬁx. For example, an otherwise nameless
HMM built from the alignment ﬁle rrm.slx would be named
rrm. Mandatory.

ACC <s> Accession number; <s> is a one-word accession number. This
is picked up from the #=GF AC line in a Stockholm format align-
ment. Optional.

DESC <s> Description line; <s> is a one-line free text description. This is

picked up from the #=GF DE line in a Stockholm alignment ﬁle.
Optional.

LENG <d> Model length; <d>, a positive nonzero integer, is the number

of match states in the model. Mandatory.

MAXL <d> Max instance length; <d>, a positive nonzero integer, is the

upper bound on the length at which and instance of the model
is expected to be found. Used only by nhmmer and nhmm-
scan. Optional.

ALPH <s> Symbol alphabet type. For biosequence analysis models, <s>

is amino, DNA, or RNA (case insensitive). There are also other ac-
cepted alphabets for purposes beyond biosequence analysis,
including coins, dice, and custom. This determines the symbol
alphabet and the size of the symbol emission probability dis-
tributions. If amino, the alphabet size K is set to 20 and the sym-
bol alphabet to “ACDEFGHIKLMNPQRSTVWY” (alphabetic
order); if DNA, the alphabet size K is set to 4 and the symbol
alphabet to “ACGT”; if RNA, the alphabet size K is set to 4 and
the symbol alphabet to “ACGU”. Mandatory.

212

sean r. eddy

RF <s> Reference annotation ﬂag; <s> is either no or yes (case insensi-
tive). If yes, the reference annotation character ﬁeld for each
match state in the main model (see below) is valid; if no, these
characters are ignored. Reference column annotation is picked
up from a Stockholm alignment ﬁle’s #=GC RF line. It is propa-
gated to alignment outputs, and also may optionally be used
to deﬁne consensus match columns in proﬁle HMM construc-
tion. Optional; assumed to be no if not present.

MM <s> Model masked ﬂag; <s> is either no or yes (case insensitive).

If yes, the model mask annotation character ﬁeld for each
match state in the main model (see below) is valid; if no, these
characters are ignored. Indicates that the proﬁle model was
created such that emission probabilities at masked positions
are set to match the background frequency, rather than being
set based on observed frequencies in the alignment. Position-
speciﬁc insertion and deletion rates are not altered, even in
masked regions. Optional; assumed to be no if not present.

CONS <s> Consensus residue annotation ﬂag; <s> is either no or yes (case

insensitive). If yes, the consensus residue ﬁeld for each match
state in the main model (see below) is valid. If no, these charac-
ters are ignored. Consensus residue annotation is determined
when models are built. For models of single sequences, the
consensus is the same as the query sequence. For models of
multiple alignments, the consensus is the maximum likeli-
hood residue at each position. Upper case indicates that the
model’s emission probability for the consensus residue is ≥ an
arbitrary threshold (0.5 for protein models, 0.9 for DNA/RNA
models).

CS <s> Consensus structure annotation ﬂag; <s> is either no or yes (case

insensitive). If yes, the consensus structure character ﬁeld for
each match state in the main model (see below) is valid; if no
these characters are ignored. Consensus structure annotation
is picked up from a Stockholm ﬁle’s #=GC SS_cons line, and
propagated to alignment displays. Optional; assumed to be no
if not present.

MAP <s> Map annotation ﬂag; <s> is either no or yes (case insensitive).
If set to yes, the map annotation ﬁeld in the main model
(see below) is valid; if no, that ﬁeld will be ignored. The
HMM/alignment map annotates each match state with the
index of the alignment column from which it came. It can be
used for quickly mapping any subsequent HMM alignment

hmmer user’s guide

213

4 HMMER does not use dates for any
purpose other than human-readable
annotation, so it is no more prone than
you are to Y2K, Y2038, or any other
date-related eschatology.

back to the original multiple alignment, via the model. Op-
tional; assumed to be no if not present.

DATE <s> Date the model was constructed; <s> is a free text date string.

4
This ﬁeld is only used for logging purposes.

Optional.

COM [<n>] <s> Command line log; <n> counts command line numbers,
and <s> is a one-line command. There may be more than one
COM line per save ﬁle, each numbered starting from n = 1.
These lines record every HMMER command that modiﬁed
the save ﬁle. This helps us reproducibly and automatically
log how Pfam models have been constructed, for example.
Optional.

NSEQ <d> Sequence number; <d> is a nonzero positive integer, the num-

ber of sequences that the HMM was trained on. This ﬁeld is
only used for logging purposes. Optional.

EFFN <f> Effective sequence number; <f> is a nonzero positive real,

the effective total number of sequences determined by hmmbuild
during sequence weighting, for combining observed counts
with Dirichlet prior information in parameterizing the model.
This ﬁeld is only used for logging purposes. Optional.

CKSUM <d> Training alignment checksum; <d> is a nonnegative un-

signed 32-bit integer. This number is calculated from the train-
ing sequence data, and used in conjunction with the alignment
map information to verify that a given alignment is indeed the
alignment that the map is for. Optional.

GA <f> <f> Pfam gathering thresholds GA1 and GA2. See Pfam docu-

mentation of GA lines. Optional.

TC <f> <f> Pfam trusted cutoffs TC1 and TC2. See Pfam documenta-

tion of TC lines. Optional.

NC <f> <f> Pfam noise cutoffs NC1 and NC2. See Pfam documenta-

tion of NC lines. Optional.

STATS <s1> <s2> <f1> <f2> Statistical parameters needed for E-value cal-

culations. <s1> is the model’s alignment mode conﬁguration:
currently only LOCAL is recognized. <s2> is the name of the score
distribution: currently MSV, VITERBI, and FORWARD are recognized.
<f1> and <f2> are two real-valued parameters controlling loca-
tion and slope of each distribution, respectively; µ and λ for
Gumbel distributions for MSV and Viterbi scores, and τ and λ
for exponential tails for Forward scores. λ values must be pos-
itive. All three lines or none of them must be present: when all

214

sean r. eddy

three are present, the model is considered to be calibrated for
E-value statistics. Optional.

HMM Flags the start of the main model section. Solely for human

readability of the tabular model data, the symbol alphabet is
shown on the HMM line, aligned to the ﬁelds of the match and
insert symbol emission distributions in the main model below.
The next line is also for human readability, providing column
headers for the state transition probability ﬁelds in the main
model section that follows. Though unparsed after the HMM
tag, the presence of two header lines is mandatory: the parser
always skips the line after the HMM tag line.

COMPO <f>*K The ﬁrst line in the main model section may be an op-
tional line starting with COMPO: these are the model’s overall
average match state emission probabilities, which are used as
a background residue composition in the “ﬁlter null” model.
The K ﬁelds on this line are log probabilities for each residue
in the appropriate biosequence alphabet’s order. Optional.

main model section

All the remaining ﬁelds are mandatory.

The ﬁrst two lines in the main model section are atypical.

5

They

contain information for the core model’s BEGIN node. This is stored
as model node 0, and match state 0 is treated as the BEGIN state. The
begin state is mute, so there are no match emission probabilities. The
ﬁrst line is the insert 0 emissions. The second line contains the tran-
sitions from the begin state and insert state 0. These seven numbers
are: B → M1, B → I0, B → D1; I0 → M1, I0 → I0; then a 0.0 and a ’*’,
because by convention, nonexistent transitions from the nonexistent
delete state 0 are set to log 1 = 0 and log 0 = −∞ = ‘*’.

The remainder of the model has three lines per node, for M nodes

(where M is the number of match states, as given by the LENG line).
These three lines are (K is the alphabet size in residues):

Match emission line The ﬁrst ﬁeld is the node number (1 . . . M).

The parser veriﬁes this number as a consistency
check (it expects the nodes to come in order).
The next K numbers for match emissions, one
per symbol, in alphabetic order.

The next ﬁeld is the MAP annotation for this
node. If MAP was yes in the header, then this is
an integer, representing the alignment column
index for this match state (1..alen); otherwise,
this ﬁeld is ‘-’.

5 That is, the ﬁrst two lines after the
optional COMPO line. Don’t be confused
by the presence of an optional COMPO
line here. The COMPO line is placed in
the model section, below the residue
column headers, because it’s an array of
numbers much like residue scores, but
it’s not really part of the model.

hmmer user’s guide

215

The next ﬁeld is the CONS consensus residue
for this node. If CONS was yes in the header,
then this is a single character, representing the
consensus residue annotation for this match
state; otherwise, this ﬁeld is ‘-’.

The next ﬁeld is the RF annotation for this node.
If RF was yes in the header, then this is a single
character, representing the reference annotation
for this match state; otherwise, this ﬁeld is ‘-’.

The next ﬁeld is the MM mask value for this
node. If MM was yes in the header, then this is a
single ’m’ character, indicating that the position
was identiﬁed as a masked position during
model construction; otherwise, this ﬁeld is ‘-’.

The next ﬁeld is the CS annotation for this node.
If CS was yes, then this is a single character,
representing the consensus structure at this
match state; otherwise this ﬁeld is ‘-’.

Insert emission line The K ﬁelds on this line are the insert emission

scores, one per symbol, in alphabetic order.

State transition line The seven ﬁelds on this line are the transi-
tions for node k, in the order shown by the
transition header line: Mk → Mk+1, Ik, Dk+1;
Ik → Mk+1, Ik; Dk → Mk+1, Dk+1.

For transitions from the ﬁnal node M, match
state M + 1 is interpreted as the END state E,
and there is no delete state M + 1; therefore the
ﬁnal Mk → Dk+1 and Dk → Dk+1 transitions
are always * (zero probability), and the ﬁnal
Dk → Mk+1 transition is always 0.0 (probability
1.0).

Finally, the last line of the format is the “//” record separator.

216

sean r. eddy

Stockholm, the recommended multiple sequence alignment format

The Pfam and Rfam Consortiums have developed a multiple se-
quence alignment format called “Stockholm format” that allows rich
and extensible annotation.

Most popular multiple alignment ﬁle formats can be changed into
a minimal Stockholm format ﬁle just by adding a Stockholm header
line and a trailing // terminator:

# STOCKHOLM 1.0

HBB_HUMAN
HBA_HUMAN
MYG_PHYCA
GLB5_PETMA

HBB_HUMAN
HBA_HUMAN
MYG_PHYCA
GLB5_PETMA

HBB_HUMAN
HBA_HUMAN
MYG_PHYCA
GLB5_PETMA
//

........VHLTPEEKSAVTALWGKV....NVDEVGGEALGRLLVVYPWTQRFFESFGDLSTPDAVMGNPKVKAHGKKVL
.........VLSPADKTNVKAAWGKVGA..HAGEYGAEALERMFLSFPTTKTYFPHF.DLS.....HGSAQVKGHGKKVA
.........VLSEGEWQLVLHVWAKVEA..DVAGHGQDILIRLFKSHPETLEKFDRFKHLKTEAEMKASEDLKKHGVTVL
PIVDTGSVAPLSAAEKTKIRSAWAPVYS..TYETSGVDILVKFFTSTPAAQEFFPKFKGLTTADQLKKSADVRWHAERII

GAFSDGLAHL...D..NLKGTFATLSELHCDKL..HVDPENFRLLGNVLVCVLAHHFGKEFTPPVQAAYQKVVAGVANAL
DALTNAVAHV...D..DMPNALSALSDLHAHKL..RVDPVNFKLLSHCLLVTLAAHLPAEFTPAVHASLDKFLASVSTVL
TALGAILKK....K.GHHEAELKPLAQSHATKH..KIPIKYLEFISEAIIHVLHSRHPGDFGADAQGAMNKALELFRKDI
NAVNDAVASM..DDTEKMSMKLRDLSGKHAKSF..QVDPQYFKVLAAVIADTVAAG.........DAGFEKLMSMICILL

AHKYH......
TSKYR......
AAKYKELGYQG
RSAY.......

The ﬁrst line in the ﬁle must be # STOCKHOLM 1.x, where x is a minor

version number for the format speciﬁcation (and which currently
has no effect on my parsers). This line allows a parser to instantly
identify the ﬁle format.

In the alignment, each line contains a name, followed by the
aligned sequence. A dash, period, underscore, or tilde (but not
whitespace) denotes a gap. If the alignment is too long to ﬁt on one
line, the alignment may be split into multiple blocks, with blocks sep-
arated by blank lines. The number of sequences, their order, and their
names must be the same in every block. Within a given block, each
(sub)sequence (and any associated #=GR and #=GC markup, see below)
is of equal length, called the block length. Block lengths may differ
from block to block. The block length must be at least one residue,
and there is no maximum.

Other blank lines are ignored. You can add comments anywhere to

the ﬁle (even within a block) on lines starting with a #.

All other annotation is added using a tag/value comment style.

The tag/value format is inherently extensible, and readily made
backwards-compatible; unrecognized tags will simply be ignored.
Extra annotation includes consensus and individual RNA or protein
secondary structure, sequence weights, a reference coordinate system
for the columns, and database source information including name,
accession number, and coordinates (for subsequences extracted from
a longer source sequence) See below for details.

hmmer user’s guide

217

syntax of Stockholm markup

There are four types of Stockholm markup annotation, for per-ﬁle,
per-sequence, per-column, and per-residue annotation:

#=GF <tag> <s> Per-ﬁle annotation. <s> is a free format text line of

annotation type <tag>. For example, #=GF DATE April 1, 2000. Can
occur anywhere in the ﬁle, but usually all the #=GF markups occur
in a header.

#=GS <seqname> <tag> <s> Per-sequence annotation. <s> is a free for-

mat text line of annotation type tag associated with the sequence
named <seqname>. For example, #=GS seq1 SPECIES_SOURCE Caenorhabditis
elegans. Can occur anywhere in the ﬁle, but in single-block formats
(e.g. the Pfam distribution) will typically follow on the line after
the sequence itself, and in multi-block formats (e.g. HMMER out-
put), will typically occur in the header preceding the alignment
but following the #=GF annotation.

#=GC <tag> <..s..> Per-column annotation. <..s..> is an aligned text
line of annotation type <tag>. #=GC lines are associated with a se-
quence alignment block; <..s..> is aligned to the residues in the
alignment block, and has the same length as the rest of the block.
Typically #=GC lines are placed at the end of each block.

#=GR <seqname> <tag> <..s..> Per-residue annotation. <..s..> is an
aligned text line of annotation type <tag>, associated with the
sequence named <seqname>. #=GR lines are associated with one se-
quence in a sequence alignment block; <..s..> is aligned to the
residues in that sequence, and has the same length as the rest of
the block. Typically #=GR lines are placed immediately following the
aligned sequence they annotate.

semantics of Stockholm markup

Any Stockholm parser will accept syntactically correct ﬁles, but is
not obligated to do anything with the markup lines. It is up to the
application whether it will attempt to interpret the meaning (the
semantics) of the markup in a useful way. At the two extremes are
the Belvu alignment viewer and the HMMER proﬁle hidden Markov
model software package.

Belvu simply reads Stockholm markup and displays it, without
trying to interpret it at all. The tag types (#=GF, etc.) are sufﬁcient to
tell Belvu how to display the markup: whether it is attached to the
whole ﬁle, sequences, columns, or residues.

HMMER uses Stockholm markup to pick up a variety of informa-

tion from the Pfam multiple alignment database. The Pfam consor-

218

sean r. eddy

tium therefore agrees on additional syntax for certain tag types, so
HMMER can parse some markups for useful information. This ad-
ditional syntax is imposed by Pfam, HMMER, and other software of
mine, not by Stockholm format per se. You can think of Stockholm as
akin to XML, and what my software reads as akin to an XML DTD, if
you’re into that sort of structured data format lingo.

The Stockholm markup tags that are parsed semantically by my

software are as follows:

recognized #=GF annotations

ID <s> Identiﬁer. <s> is a name for the alignment; e.g. “rrm”. One

word. Unique in ﬁle.

AC <s> Accession. <s> is a unique accession number for the align-
ment; e.g. “PF00001”. Used by the Pfam database, for in-
stance. Often a alphabetical preﬁx indicating the database
(e.g. “PF”) followed by a unique numerical accession. One
word. Unique in ﬁle.

DE <s> Description. <s> is a free format line giving a description of
the alignment; e.g. “RNA recognition motif proteins”. One
line. Unique in ﬁle.

AU <s> Author. <s> is a free format line listing the authors respon-
sible for an alignment; e.g. “Bateman A”. One line. Unique
in ﬁle.

GA <f> <f> Gathering thresholds. Two real numbers giving HMMER

bit score per-sequence and per-domain cutoffs used in
gathering the members of Pfam full alignments.

NC <f> <f> Noise cutoffs. Two real numbers giving HMMER bit score

per-sequence and per-domain cutoffs, set according to
the highest scores seen for unrelated sequences when
gathering members of Pfam full alignments.

TC <f> <f> Trusted cutoffs. Two real numbers giving HMMER bit

score per-sequence and per-domain cutoffs, set according
to the lowest scores seen for true homologous sequences
that were above the GA gathering thresholds, when gather-
ing members of Pfam full alignments.

recognized #=GS annotations

WT <f> Weight. <f> is a positive real number giving the relative weight

for a sequence, usually used to compensate for biased repre-
sentation by downweighting similar sequences. Usually the

hmmer user’s guide

219

weights average 1.0 (e.g. the weights sum to the number of se-
quences in the alignment) but this is not required. Either every
sequence must have a weight annotated, or none of them can.

AC <s> Accession. <s> is a database accession number for this se-

quence. (Compare the #=GF AC markup, which gives an acces-
sion for the whole alignment.) One word.

DE <s> Description. <s> is one line giving a description for this se-

quence. (Compare the #=GF DE markup, which gives a descrip-
tion for the whole alignment.)

recognized #=GC annotations

RF Reference line. Any character is accepted as a markup for
a column. The intent is to allow labeling the columns with
some sort of mark.

MM Model mask line. An ’m’ indicates that the column lies within
a masked range, so that hmmbuild should produce emissions
matching the background for a match state corresponding to
that alignment column. Otherwise, a ’.’ is used.

SS_cons Secondary structure consensus. For protein alignments, DSSP

codes or gaps are accepted as markup: [HGIEBTSCX.-_],
where H is alpha helix, G is 3/10-helix, I is p-helix, E is ex-
tended strand, B is a residue in an isolated b-bridge, T is a
turn, S is a bend, C is a random coil or loop, and X is un-
known (for instance, a residue that was not resolved in a
crystal structure).

SA_cons Surface accessibility consensus. 0-9, gap symbols, or X are ac-
cepted as markup. 0 means <10% accessible residue surface
area, 1 means <20%, 9 means <100%, etc. X means unknown
structure.

recognized #=GR annotations

SS Secondary structure consensus. See #=GC SS_cons above.

SA Surface accessibility consensus. See #=GC SA_cons above.

PP Posterior probability for an aligned residue. This represents the
probability that this residue is assigned to the HMM state cor-
responding to this alignment column, as opposed to some other
state. (Note that a residue can be conﬁdently unaligned: a residue
in an insert state or ﬂanking N or C state may have high posterior
probability.) The posterior probability is encoded as 11 possible

220

sean r. eddy

characters 0-9*+: 0.0 ≤ p < 0.05 is coded as 0, 0.05 ≤ p < 0.15 is
coded as 1, (... and so on ...), 0.85 ≤ p < 0.95 is coded as 9, and
0.95 ≤ p ≤ 1.0 is coded as ’*’. Gap characters appear in the PP line
where no residue has been assigned.

hmmer user’s guide

221

A2M multiple alignment format

HMMER’s Easel library routines are capable of writing alignments in
UC Santa Cruz “A2M” (alignment to model) format, the native input
format for the UCSC SAM proﬁle HMM software package.

To select A2M format, use the format code a2m: for example, to

reformat a Stockholm alignment to A2M:

esl-reformat a2m myali.sto

Easel currently does not read A2M format, and it currently only

writes in what UCSC calls “dotless” A2M format.

The most ofﬁcial documentation for A2M format appears to be at
http://compbio.soe.ucsc.edu/a2m-desc.html. You may refer to that
document if anything in the brief description below is unclear.

An example A2M ﬁle

This alignment:

seq1 ACDEF...GHIKLMNPQTVWY
seq2 ACDEF...GHIKLMNPQTVWY
seq3 ---EFmnrGHIKLMNPQT---

is encoded in A2M format as:

>seq1 Sequence 1 description
ACDEFGHIKLMNPQTVWY
>seq2 Sequence 2 description
ACDEFGHIKLMNPQTVWY
>seq3 Sequence 3 description
---EFmnrGHIKLMNPQT---

A2M format looks a lot like aligned FASTA format. A crucial
difference is that the aligned sequences in a “dotless” A2M ﬁle do
not necessarily all have the same number of characters. The format
distinguishes between “consensus columns” (where residues are in
upper case and gaps are a dash, ‘-’) and “insert columns” (where
residues are in lower case and gaps are dots, ‘.’, that aren’t explicitly
shown in the format – hence “dotless” A2M). The position and num-
ber of gaps in insert columns (dots) is implicit in this representation.
An advantage of this format is its compactness.

This representation only works if all insertions relative to consen-

sus are considered to be unaligned characters. That is how inser-
tions are handled by proﬁle HMM implementations like SAM and
HMMER, and proﬁle SCFG implementations like Infernal.

Thus every sequence must have the same number of consensus
columns (upper case letters plus ‘-’ characters), and may have addi-
tional lower case letters for insertions.

222

sean r. eddy

Legal characters

A2M (and SAM) do not support some special characters such as ‘*’
(not-a-residue) or ‘˜’ (missing data). Easel outputs these characters
as gaps: either ‘-’ in a consensus column, or nothing in an insert
column.

The SAM software parses only a subset of legal ambiguity codes
for amino acids and nucleotides. For amino acids, it only reads {BXZ}
in addition to the 20 standard one-letter codes. For nucleotides, it
only reads {NRY} in addition to {ACGTU}. With one crucial excep-
tion, it treats all other letters as X or N.

The crucial exception is ‘O’. SAM reads an ‘O’ as the position of a

“free insertion module” (FIM), a concept speciﬁc to SAM-style pro-
ﬁle HMMs. This has no impact on nucleic acid sequences, where
‘O’ is not a legal character. But in amino acid sequences, ‘O’ means
pyrrolysine, one of the unusual genetically-encoded amino acids.
This means that A2M format alignments must not contain pyrroly-
sine residues, lest they be read as FIMs. For this reason, Easel con-
verts ‘O’ residues to ‘X’ when it writes an amino acid alignment in
A2M format.

Determining consensus columns

Writing A2M format requires knowing which alignment columns
are supposed to be considered consensus and which are considered
inserts. If the alignment was produced by HMMER or Infernal, then
the alignment has so-called “reference annotation” (what appears as
a #=GC RF line in Stockholm format) marking the consensus columns.
Often, an alignment has no reference annotation; for example, if it
has been read from an alignment format that has no reference anno-
tation line (only Stockholm and SELEX formats support reference an-
notation). In this case, Easel internally generates a “reasonable” guess
at consensus columns, using essentially the same procedure that
HMMER’s hmmbuild program uses by default: sequence fragments (se-
quences <50% of the mean sequence length in the alignment overall)
are ignored, and for the remaining sequences, any column containing
≥ 50% residues is considered to be a consensus column.

hmmer user’s guide

223

hmmpgmd sequence database format

The hmmpgmd sequence database format closely resembles the
FASTA format, with slight modiﬁcation to support use within HMMER’s
hmmpgmd daemon.

The hmmpgmd program enables search of one or more sequence
databases (e.g. NR, SwissProt, UniProt) within a single instance,
having loaded a single sequence ﬁle into memory. Because the set
of sequences found within the various databases may overlap, the
hmmpgmd format allows each sequence to be stored once, and in-
cludes a small piece of metadata that indicates, for each sequence,
the list of source databases in which the sequence is found. When a
search is performed in hmmpgmd, a single target database is speciﬁed,
and search is restricted to sequences belonging to that database.

Furthermore, because a single sequence might be found multi-
ple times within a single sequence database, hmmpgmd is designed to
compute E-values not just on the total number of non-redundant se-
quences within a database, but on the total number of sequences in
the original (possibly redundant) database, provided those redundant
counts are given in the hmmpgmd-formatted ﬁle.

The hmmpgmd ﬁle begins with a single line containing various counts

describing the contents of the ﬁle, of the form

#res_cnt seq_cnt db_cnt cnt_1 fullcnt_1 cnt_2 fullcnt_2 . . . date_stamp

Fields in header line

res_cnt Number of residues in the sequence ﬁle.

seq_cnt Number of sequences in the sequence ﬁle.

db_cnt Number of databases in the sequence ﬁle.

cnt_i Of the sequnces in the ﬁle, the number that belong to database
i. Note that if the ﬁle contains only a single database, this will
match seq_cnt.

fullcnt_i For database i, the number of sequences that should be
used in computing E-values. If redundant sequences were
collapsed out of the original database, this may be larger than
cnt_i.

FASTA-like sequence format

In the main body of the sequence ﬁle, database sequences are stored
sequentially, with each entry consisting of a one-line FASTA-like
header followed by one or more lines containing the amino acid
sequence, like

224

sean r. eddy

>1 100
ACDEFGHIKLMNPQTVWY
>2 010
ACDKLMNPQTVWYEFGHI
>3 111
EFMNRGHIKLMNPQT

Note that the per-entry header line is made up of two parts. The

ﬁrst part is a numeric, incrementing sequence identiﬁer (the i’th
entry has the identiﬁer i). The second part is a bit string indicat-
ing database membership. In this example, sequence 1 is found in
database 1, sequence 2 is found in database 2, and sequence 3 found
in databases 1, 2, and 3. The number of bits in each bit string should
match db_cnt.

Because hmmpgmd accepts only numeric sequence identiﬁers, it is
necessary to keep track of the mapping between each numeric se-
quence identiﬁer and the corresponding meta data (e.g. name, ac-
cession, description) external to the hmmpgmd-format ﬁle, and
post-process hmmpgmd seach results to apply those ﬁelds to the tar-
get sequence information. Depending on the size of the map list,
this might be easily acheived with a simple perl array, or might
require a more heavy-duty mapping backend such as mongodb
(http://www.mongodb.org).

Creating a ﬁle in hmmpgmd format

The HMMER-Easel tool esl-reformat is able to convert a ﬁle in un-
aligned fasta format into an hmmpgmd format ﬁle, such as

esl-reformat -id_map mydb.hmmpgmd.map hmmpgmd mydb.fasta > mydb.hmmpgmd

The optional -id_map ﬂag captures sequence name and description
information into a simple tabular ﬁle, to be used for mapping those
values back to hmmpgmd query hits.

hmmer user’s guide

225

6 S. F. Altschul. Amino acid substitution
matrices from an information theoretic
perspective. J. Mol. Biol., 219:555–565,
1991

Score matrix ﬁles

Proﬁle HMMs can be built from single sequences, not just from
multiple sequence alignments. For example, the phmmer and jackhmmer
search programs take a single sequence query as an input, and nhmmer
can as well. For single sequence queries, the probability parame-
ters for residue alignments are derived from a substitution score
matrix, such as BLOSUM62. Scores are converted to probabilities
6
as described by Altschul (1991).
. The scores can be arbitrary, but
they must satisfy a couple of conditions so they can be interpreted
as implicit log-odds probabilities: there must be at least one positive
score, and the expected score (on nonhomologous alignments) must
be negative.

The default score matrix for protein alignments is BLOSUM62; for

DNA, a matrix we call DNA1. Using the -mx option (for programs
that can use score matrices), you can choose instead one of several al-
ternative protein score matrices: PAM30, PAM70, PAM120, PAM240,
BLOSUM45, BLOSUM50, BLOSUM80, and BLOSUM90. For example,
you could use -mx BLOSUM50.

The -mxfile option allows you to provide a score matrix as a ﬁle.

You can download many standard score matrice ﬁles from NCBI
at ftp://ftp.ncbi.nlm.nih.gov/blast/matrices/. HMMER can read
almost any of these ﬁles, with one exception: because it requires the
score matrix to be symmetrical (same number of residues in rows and
columns), the NCBI NUC.4.4 matrix for DNA works, but the alternative
short-form format NUC.4.2 does not work. The scores in these two ﬁles
are identical, so just use NUC.4.4, and ﬁles like it.

Here’s a simple example ﬁle:

# My score matrix
#

G

A T

C
A 1 -3 -3 -3
T -3 1 -3 -3
G -3 -3 1 -3
1
C -3 -3 -3

In more detail, the rules for the format are:

• Blank lines are ignored.

• A # indicates a comment. Anything after it is ignored. Lines that

start with # are ignored like blank lines.

• The ﬁrst data line is a header line, labeling each column with n
single residue characters (case-insensitive). A nucleic matrix has
4 ≤ n ≤ 16: at least the four canonical residues ACGT (or U, for you
RNA zealots), and it may also contain any or all ambiguity codes
RYMKSWHBVDN*. A protein matrix has 20 ≤ n27; it must contain at least

226

sean r. eddy

the 20 canonical residues ACDEFGHIKLMNPQRSTVWY, and may contain any
or all ambiguity codes BJZOU. These residues can be in any order,
but the rows must be in the same order as the columns.

• The next n data lines are the rows of a square n × n score matrix:

– Fields in the row are whitespace-delimited (tabs or spaces).

– Optionally, each row can start with its single residue label.

Therefore each row has either n + 1 ﬁelds if there is a leading la-
bel, or n ﬁelds if not. Rows and columns are in the same order.

– Each score is an integer. Plus signs are optional.

• The ﬁle may not contain any additional lines (other than com-

ments or blank lines).

HMMER only uses the scores for canonical residues, and uses
them to calculate probabilities. If scores for ambiguous residue codes
are provided, HMMER ignores them; it has its own logic for dealing
with the probability of ambiguous residues, given the probability of
canonical residues.

Acknowledgements and history

HMMER 1 was developed on slow weekends in the lab at the MRC
Laboratory of Molecular Biology, Cambridge UK, while I was a post-
doc with Richard Durbin and John Sulston. I thank the Human Fron-
tier Science Program and the National Institutes of Health for their
enlightened support, though they thought they had funded me to
study the genetics of neural development in C. elegans.

The ﬁrst public release of HMMER (1.8) was in April 1995, shortly

after I moved to the Department of Genetics at Washington Univer-
sity in St. Louis. A few bugﬁx releases followed. A number of more
serious modiﬁcations and improvements went into HMMER 1.9 code,
but 1.9 was never released. Some versions of HMMER 1.9 escaped
St. Louis and make it to some genome centers, but 1.9 was never
supported. HMMER 1.9 burned down and sank into the swamp in
1996.

HMMER 2 was a nearly complete rewrite, based on the new Plan 7
model architecture, begun in November 1996. I thank the Washington
University Dept. of Genetics, the NIH National Human Genome
Research Institute, and Monsanto for their support during this time.
I also thank the Biochemistry Academic Contacts Committee at Eli
Lilly & Co. for a gift that paid for the trusty Linux laptop on which
much of HMMER 2 was written. Much of HMMER2 was written
in coffee shops, airport lounges, transoceanic ﬂights, and Graeme
Mitchison’s kitchen. The source code still contains a disjointed record
of where and when various bits were written.

HMMER then settled for a while into a comfortable middle age,
like its author: still actively maintained, though dramatic changes
seemed increasingly unlikely. HMMER 2.1.1 was the stable release
for three years, from 1998-2001. HMMER 2.2g was intended to be
a beta release, but became the de facto stable release for two more
years, 2001-2003. The ﬁnal release of the HMMER2 series, 2.3, was
assembled in spring 2003. The last bugﬁx release, 2.3.2, came out in
October 2003.

If the world worked as I hoped, the combination of our 1998 book
Biological Sequence Analysis and the existence of HMMER2 as a proof

228

sean r. eddy

of principle would have motivated the widespread adoption of prob-
abilistic modeling methods for sequence database searching. We
would declare Victory! and move on. Indeed, probabilistic modeling
did become important in the ﬁeld, and the other authors of Biological
Sequence Analysis did move on. Richard Durbin moved on to human
genomics; Anders Krogh moved on to pioneer a number of other
probabilistic approaches for other biological sequence analysis prob-
lems; Graeme Mitchison moved on to quantum computing; I moved
on to noncoding structural RNAs.

Yet BLAST continued (and continues) to be the most widely used
search program. HMMs seemed to be widely considered to be a mys-
terious and orthogonal black box, rather than a natural theoretical
basis for important applications like BLAST. The NCBI seemed to be
slow to adopt HMM methods. This nagged at me. The revolution
was unﬁnished!

When my group moved to Janelia Farm in 2006, I had to make a
decision about what we should spend time on. It had to be some-
thing “Janelian”: something that I would work on with my own
hands; something difﬁcult to accomplish under the usual reward
structures of academic science; something that would make a dif-
ference. I decided that we should aim to replace BLAST with a new
generation of software, and I launched the HMMER3 project.

Coicidentally, an embedded systems engineer named Michael
Farrar contacted me in January 2007. As a side hobby, Farrar has
developed an efﬁcient new “striped” method for using SIMD vector
instructions to accelerate Smith/Waterman sequence alignment. He
had used it to accelerate Bill Pearson’s SSEARCH program by 10-
20x, and wanted to know if his ideas could be applied in HMMER.
He published a short Bioinformatics paper later in 2007 on the
SSEARCH work, as a solo author with no academic afﬁliation. In
December 2007, working from Michael’s description, I implemented
striped SIMD vectorization for HMMER, and one pleasant day, I re-
alized how to do the fast ﬁlter we now call the SSV and MSV ﬁlters.
Michael and I started corresponding frequently by email. We met for
coffee at the Starbucks on Church Street in Cambridge in early 2008,
and I started trying to recruit him to Janelia Farm. We negotiated off
and on for a year, and he joined the group in June 2009. HMMER3.0
was ﬁrst released in March 2010.

HMMER is still my baby, but it is also the work of several people

who have come through my lab and other collaborators, includ-
ing contributions from Bill Arndt, Dawn Brooks, Nick Carter, Sergi
Castellano, Alex Coventry, Michael Farrar, Rob Finn, Ian Holmes,
Steve Johnson, Bjarne Knudsen, Diana Kolbe, Eric Nawrocki, Elena
Rivas, Walt Shands, and Travis Wheeler.

7

7 I write “I” in this guide, but a few
parts of it were ﬁrst written by Travis.
I think there’s probably some stuff that
was ﬁrst written by Ewan Birney in
here too.

hmmer user’s guide

229

I thank Scott Yockel, James Cuff, and the Harvard Odyssey team

for our computing environment at Harvard, and Goran Ceric and
his team for our previous environment at Janelia Farm. Without
the skills of the teams at our high-performance computing centers,
we would be nowhere. HMMER testing can spin up hundreds or
thousands of processors at a time, an unearthly amount of computing
power.

In the olden days, the MRC-LMB computational molecular biology

discussion group contributed many ideas to HMMER. In particular,
I thank Richard Durbin, Graeme Mitchison, Erik Sonnhammer, Alex
Bateman, Ewan Birney, Gos Micklem, Tim Hubbard, Roger Sewall,
David MacKay, and Cyrus Chothia.

The UC Santa Cruz HMM group, led by David Haussler and in-

cluding Richard Hughey, Kevin Karplus, Anders Krogh (now in
Copenhagen) and Kimmen Sjölander, was a source of knowledge,
friendly competition, and occasional collaboration. All scientiﬁc
competitors should be so gracious. The Santa Cruz folks have never
complained, at least not in my earshot, that HMMER started as sim-
ply a re-implementation of their original ideas, just to teach myself
what HMMs were.

In many places, I’ve reimplemented algorithms described in the
literature. These are too numerous to thank here. The original ref-
erences are given in the code. However, I’ve borrowed more than
once from the following folks that I’d like to be sure to thank: Steve
Altschul, Pierre Baldi, Phillip Bucher, Warren Gish, Steve and Jorja
Henikoff, Anders Krogh, and Bill Pearson.

HMMER is primarily developed on Apple OS/X and GNU/Linux

machines, but is tested on a variety of hardware. Over the years,
Compaq, IBM, Intel, Sun Microsystems, Silicon Graphics, Hewlett-
Packard, Paracel, and nVidia have provided generous hardware
support that makes this possible. I’m endebted to the free software
community for the development tools I use: an incomplete list in-
cludes GNU gcc, gdb, emacs, and autoconf; valgrind; Subversion and
Git; Perl and Python; LATEX; PolyglotMan; and the UNIX and Linux
operating systems.

Finally, I’d like to cryptically thank Dave “Mr. Frog” Pare and Tom

“Chainsaw” Ruschak for an unrelated open source software product
that was historically instrumental in HMMER’s development, for
reasons that are best not discussed while sober.

