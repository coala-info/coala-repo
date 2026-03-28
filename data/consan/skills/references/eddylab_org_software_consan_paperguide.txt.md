"Efficient pairwise RNA structure prediction and alignment using
sequence alignment constraints" BMC Bioinformatics 7:41 2006.
(Notes summary on how CONUS was utilized for the paper)
----------------------------------------------------------------
Assumptions:
CONSAN code has been compiled and is in a directory called "consan/".
The datasets are in a directory called "data/" with the names:
\*) mix80.stk LSU/SSU dataset for training
\*) Rfam.v7.pub80.stk Rfam dataset for training comparison
\*) R100.stk Random 100 tRNA and 100 5S RNA sequences
\*) R100.pairs.stk Above set with an "informant" sequence (ie. pairs)
3) percid.stk 5S + tRNA dataset, percent identity balanced
4) stemloc.stk Dataset for stemloc comparison (Holmes ref)
Brief descriptions and basic usage:
\* strain\_ml (training; generates a model parameter file e.g. model.mod)
> strain\_ml -s model.mod trainingset.stk
\* sfold (structural alignment of two sequences)
> sfold -m model.mod seq1.fa seq2.fa
\* scompare (structural alignment of two sequences with comparison to a
given pairwise alignment; essentially a wrapper around sfold)
> scompare -m model.mod alignment.stk
Because the paper presents almost entirely comparative results, the
majority of this work is presented using scompare. However, if you just
have two sequences, you will instead prefer to use sfold. For all three
programs, running with the -h option will briefly describe available options.
===========================================================================
\*\*\*\* WARNING: \*\*\*\*
===========================================================================
The Consan algorithm is inherently resource intensive. Runtime scales
as N^6 in the length of the sequences being compared and memory scales
as N^4 in the length of the sequences being compared. Currently, Consan
assumes it will be used responsibly and therefore does only minimal
checking before proceeding with memory allocations. It can and will
attempt to utilize more resources than your machine has available. This
is a very bad idea and is strongly advised against.
===========================================================================
Training:
---------
consan/mltrain -s mixed80.mod data/mixed80.stk
This produces a binary output file called mixed80.mod which defines the
parameters as trained on mixed80.stk.
Training Set Comparison:
------------------------
First train the grammar based on the Rfam published dataset:
consan/mltrain -s rfam7.mod data/Rfam.v7.pub80.stk
Then generate parameter comparison table as follows:
consan/src/utilities/cModel mix80.mod rfam7.mod
Bootstrapping (in general):
---------------------------
The scompare (Consan) and conus\_compare (Conus) routines produce estimates
of the basepair sensitivity, basepair PPV, and alignment accuracy (for scompare
only). These numbers should be considered as ESTIMATES only.
For complete comparison statistics (as presented in the paper):
\*\*\* For single sequence:
Reformat output to "wuss" structure annotation (necessary for compstruct):
consan/src/squid/sreformat --wuss stockholm reference.stk > reference.wuss.stk
consan/src/squid/sreformat --wuss stockholm prediction.stk > prediction.wuss.stk
Compare reference structures to prediction:
consan/src/squid/compstruct reference.wuss.stk prediction.wuss.stk > prediction.compstruct
Reformat to bootstrap input:
consan/src/boot/bsinput.pl prediction.compstruct > prediction.bsinput
\*\*\* Pairwise sequence:
[Reformatting to wuss is not necessary.]
Compare reference alignments to prediction:
consan/src/utilities/comppair reference.stk prediction.stk > prediction.comppair
Reformat to bootstrap input:
consan/src/boot/bsinputTOT.pl prediction.comppair > prediction.bsinput
\*\*\* Bootstrap: (both single sequence and pairwise comparisons)
consan/src/boot/bstats prediction.bsinput
The default bootstrap settings (used in the paper) are 10000 samples. For
reference, alternative samplings can be set using the -i option. For more
information use the -h option.
[\*\*\*Note that the alignment numbers will be random and irrelvant when
bootstrapping single sequence folding.\*\*\*]
Comparison to Single Sequence Folding (Table 1):
------------------------------------------------
Train the single sequence grammar Gs:
consan/src/conus-1.1/conus\_train -g RY2 -s Gs.mod data/mix80.stk
Run the R100 dataset using Gs:
consan/src/conus-1.1/conus\_compare -m Gs.mod -N data/R100.stk
[Note that the above utilizes a slightly modified version of Conus. In
Conus's grammar encoding, the Gs grammar is known as RY2. The -N is
required to turn off stacking parameterization (making it comparable
to the pairSCFG). For more on Conus, see
http://selab.wustl.edu/people/robin/conus/]
Run pairSCFG on the R100.pairs dataset and R100 (self vs self):
consan/src/scompare -f -m mixed80.stk data/R100.pairs.stk
The -f options runs the full (unconstrained) pairSCFG. This takes
a \*long\* time and at least 2 Gb of memory for all 5S pairs. The output
includes summary information which can be suppressed with the -S option.
[Generating self vs self comparison uses the R100 dataset but introduces
an informant sequence which is identical to the individual sequence. The
name of the informant must necessarily be different from the original
sequence to be a proper STOCKHOLM file (ie. "self"). Once generated,
the dataset is ran identically to R100.pairs.]
EXTERNAL PROGRAM:
Running mfold on the R100 dataset:
[mfold is an external program -- it is not provided as part of the
Consan package. Its usage is described here to reproduce the
performance of Table 1 and Figure 4.]
> mfold MAX=750 P=20 W=0 SEQ=seqname.fa
[mfold requires FASTA to be 80 or less characters per line.]
Constrained algorithm versus full Sankoff (Figure 4):
-----------------------------------------------------
Run pairSCFG on the percid dataset:
consan/src/scompare -f -m mixed80.stk data/percid.stk
Run constrained pairSCFG on the percid dataset:
consan/src/scompare -m mixed80.stk data/percid.stk
The default constraints are posteriors > 0.95 and a protection
window of 20 nucleotides. These can be changed using
-Z  to change the posterior cutoff and -W
to change the window size.
[See "Comparison to Single Sequence Folding" above for information
on running Gs and mfold.]
EXTERNAL PROGRAM:
Running Clustalw on the percid dataset:
Posterior Evaluation (Figure 5 & 6):
------------------------------------
Calculate accuracy of posterior probabilities:
consan/src/utilities/pincheck -z 4 data/percid.stk
Calculate accuracy of pins selected for given posterior
cutoff (-Z) and protection window (-W):
consan/src/utilities/pincheck -z 6 -Z 0.95 -W 20 data/percid.stk
[The program pincheck can determine a number of different
statistics about pins. For a brief description of evalutation
metrics use the -h option.]
EXTERNAL Sankoff Implementations (Figure 7):
---------------------------------------------
Dynalign:
dynalign seq1.seq seq2.seq seq1.ct seq2.ct pair.aln 15 0.4 1 0 0 0 0
seq1.seq and seq2.seq are required to be in dynalign's SEQ format.
seq1.ct, seq2.ct, and pair.aln are filenames for output.
Stemloc:
stemloc -g -na 100 -nf 1000
PMcomp:
RNAfold -p -noLP < seqname1.fa
RNAfold -p -noLP < seqname2.fa
pmcomp.pl sname1\_dp.ps sname2\_dp.ps
Note that RNAfold outputs a file called sname\_dp.ps for an input
fasta file with ">sname" as the descriptor line.
FOLDALIGN:
foldalign -global -max\_diff 25 -score\_matrix global.fmat seqpair.fa
Expects fasta file (seqpair.fa) to contain the two sequences for
alignment.