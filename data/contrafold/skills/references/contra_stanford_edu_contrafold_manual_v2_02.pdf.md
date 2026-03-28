CONTRAfold 2.02
User Manual

(Last modiﬁed: August 14, 2008)

1

CONTRAfold 2.02 User Manual

1 of 20

Contents

1 Description

2 License (BSD)

3

Installation
3.1

*nix installation .

4 Supported ﬁle formats

. . .

. . . . . . . . . . . . . . . . . . . . . . . .

4.1

. . . . . . . . . . . . . . . . . . . . . . . .
Input ﬁle formats . . .
. . . . . . . . . . . . . . . . . . . . . . .
4.1.1 Plain text format
4.1.2
FASTA format . . . . . . . . . . . . . . . . . . . . . . . . .
4.1.3 BPSEQ format . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . .
4.2.1
FASTA format . . . . . . . . . . . . . . . . . . . . . . . . .
4.2.2 BPSEQ format . . . . . . . . . . . . . . . . . . . . . . . . .
4.2.3 Posteriors format . . . . . . . . . . . . . . . . . . . . . . .

. . .

4.2 Output formats .

5 Usage

5.1 Prediction mode . . .

. . . . . . . . . . . . . . . . . . . . . . . . .
5.1.1 A single input ﬁle . . . . . . . . . . . . . . . . . . . . . . .
5.1.2 Multiple input ﬁles . . . . . . . . . . . . . . . . . . . . . .
5.1.3 Optional arguments . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . .

. . .

.

5.2 Training mode .

6 Visualization of folded RNAs

.

.

6.1

. . .

Installation .
6.1.1
6.2 Usage .
.
6.3 Additional options . .

. . . . . . . . . . . . . . . . . . . . . . . . .
*nix installation . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . .

. .

.

.

.

.

7 Citing CONTRAfold

2

3

4
4

5
5
5
6
7
8
8
9
9

11
11
11
12
13
16

18
18
18
18
19

20

CONTRAfold 2.02 User Manual

2 of 20

1 Description

CONTRAfold is a novel algorithm for the prediction of RNA secondary struc-
ture based on conditional log-linear models (CLLMs). Unlike previous sec-
ondary structure prediction programs, CONTRAfold is the ﬁrst fully proba-
bilistic algorithm to achieve state-of-the-art accuracy in RNA secondary struc-
ture prediction.

The CONTRAfold program was developed by Chuong Do at Stanford Uni-
versity in collaboration with Daniel Woods, Seraﬁm Batzoglou. The source
code for CONTRAfold is available for download from

http://contra.stanford.edu/contrafold/

under the BSD license. The CONTRAfold logo was designed by Marina Sirota.
Any comments or suggestions regarding the program should be sent to

Chuong Do (chuongdo@cs.stanford.edu).

CONTRAfold 2.02 User Manual

3 of 20

2 License (BSD)

Copyright c(cid:13) 2006, Chuong Do
All rights reserved.

Redistribution and use in source and binary forms, with or without modiﬁ-
cation, are permitted provided that the following conditions are met:

• Redistributions of source code must retain the above copyright notice,

this list of conditions and the following disclaimer.

• Redistributions in binary form must reproduce the above copyright no-
tice, this list of conditions and the following disclaimer in the documen-
tation and/or other materials provided with the distribution.

• Neither the name of Stanford University nor the names of its contributors
may be used to endorse or promote products derived from this software
without speciﬁc prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CON-
TRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, IN-
CLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MER-
CHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DIS-
CLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CON-
TRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPE-
CIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOW-
EVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CON-
TRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTH-
ERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

CONTRAfold 2.02 User Manual

4 of 20

3

Installation

At the moment, CONTRAfold is only available for Unix-based systems (e.g.,
Linux). We will be porting CONTRAfold to other architectures and making the
binaries available.

3.1

*nix installation

To compile CONTRAfold from the source code (for a *nix machine):

1. Download the latest version of the CONTRAfold source code from

http://contra.stanford.edu/contrafold/download.html

2. Decompress the archive:

$ tar zxvf contrafold_v#_##.tar.gz

where the #’s are replaced with the appropriate version numbers for the
tar.gz you want to install. This will create a subdirectory called contrafold
inside of the current directory.

3. Change to the contrafold/src subdirectory and compile the program.

$ cd contrafold/src
$ make clean
$ make

Now, your installation is complete!

CONTRAfold 2.02 User Manual

5 of 20

4 Supported ﬁle formats

In this section, we describe the input and output ﬁle formats supported by the
CONTRAfold program.

4.1

Input ﬁle formats

CONTRAfold accepts input ﬁles which either contain only RNA sequences or
contain both sequences and (partial) structural annotations.

For the ﬁle formats that support speciﬁcation of (partial) structural annota-
tions (in particular, FASTA and BPSEQ), the provided structures must obey the
following properties:

1. Each position in the RNA sequence is marked as either unpaired, paired

to some speciﬁc nucleotide, or unknown.

2. If position i is marked as pairing with position j, then position j must be

marked as pairing with position i.

3. The (partial) structures speciﬁed must not have pseudoknots.

4. A position i cannot be marked as pairing unless its speciﬁc base-pairing

partner has been speciﬁed.

These structural annotations are generally ignored when performing predic-
tions, unless the --constraints ﬂag is speciﬁed on the command-line. These
structural annotations are required for training CONTRAfold.

The three speciﬁc input ﬁle formats supported by CONTRAfold are plain

text, FASTA and BPSEQ. We describe each of these formats in turn.

4.1.1 Plain text format

A plain text format ﬁle consists of one or more lines containing RNA sequence
data. Each of these lines may contain the letters ‘A’, ‘C’, ‘G’, ‘T’, ‘U’, or ‘N’ in
either upper or lower case (the output of the program will retain the case of
the input). Any T’s are automatically converted to U’s. Any other letters are
automatically converted to N’s. All whitespace (space, tab, newline) is ignored.
N’s are treated as masked sequence positions which are ignored during all
calculations (i.e., any scoring terms involving an N will be skipped). Other
non-whitespace characters are not permitted. Plain text ﬁles cannot contain
any secondary structural annotation.

For example, the following is a valid plain text ﬁle:

NACGACAGUGUAUCACUAGUAcuuA
GUAUGUACUAUC

AGUAGUUGUUGUAGUUC

CONTRAfold 2.02 User Manual

6 of 20

Note that the blank third line will be ignored, and the initial ‘N’ character will
be treated as a placeholder character which appears in the output folded RNA
but makes no contribution to the computations.

4.1.2 FASTA format

A FASTA format ﬁle consists of:

1. A single header line beginning with the character ‘>’ followed by a text
description of the RNA sequence. Note that the description must ﬁt on
the same line as the ‘>’ character.

2. One or more lines containing RNA sequence data. Each of these lines
may contain the letters ‘A’, ‘C’, ‘G’, ‘T’, ‘U’ or ‘N’ in either upper or lower
case (the output of the program will retain the case of the input). Any T’s
are automatically converted to U’s. Any other letters are automatically
converted to N’s. All whitespace (space, tab, newline) is ignored. N’s are
treated as masked sequence positions which are ignored during all cal-
culations (i.e., any scoring terms involving an N will be skipped). Other
non-whitespace characters are not permitted.

3. (Optional) A structural annotation for the sequence provided above. The

structural annotation requires:

(a) A single header line beginning with the character ‘>’ followed by a

description (any text after the description is ignored)

(b) One or more lines of parenthesized structural annotation. These
lines provided a structural annotation for each nucleotide in the
RNA sequence using a sequence of ‘(’, ‘)’, ‘.’, and ‘?’ characters.
A nucleotide annotated with ‘(’ pairs with the nucleotide annotated
with the matching ‘)’. A ‘.’ character indicates that the correspond-
ing nucleotide is unpaired. Finally, a ‘?’
indicates a position for
which the proper matching (either paired or unpaired) is unknown.
Observe that the parentheses in the input ﬁle must be well-balanced,
i.e., for each left parenthesis, the corresponding pairing position must
be marked with a right parenthesis (not a ‘?’), and vice versa. Since
CONTRAfold generates only non-pseudoknotted structure predic-
tions, the proper pairing will always be unambiguous.

For example, the following is a valid FASTA ﬁle:

>sequence
acggagaGUGUUGAU
CUGUGUGUUACUACU
caucuguaguucuag
uugua

Similarly, the following is a valid FASTA ﬁle with a structural annotation:

CONTRAfold 2.02 User Manual

7 of 20

>sequence
acguuggcu
>structure
(??(..).)

But the following is not (starts with the wrong header character):

# sequence
ATGACGGT

Also, the following ﬁle is not valid (because the parenthesized structure is

not properly balanced):

>sequence
acguuggcu
>structure
(..(..).?

Finally, the following ﬁle is not valid (because the structural information

header is missing):

>sequence
acguuggcu
(??(..).)

4.1.3 BPSEQ format

A BPSEQ format ﬁle is used for describing a single RNA sequence and its an-
notated secondary structure. This ﬁle format contains exactly one line for each
nucleotide in an RNA sequence. The ith line of the ﬁle contains three items
separated by single spaces:

1. The integer i (with i = 1 representing the ﬁrst nucleotide).

2. The ith character of the RNA sequence (which may be ‘A’, ‘C’, ‘G’, ‘T’,
‘U’, or ‘N’ in either upper or lower case; the output of the program will
retain the case of the input; any T’s are automatically converted to U’s;
any other letters are automatically converted to N’s). N’s are treated as
masked sequence positions which are ignored during all calculations (i.e.,
any scoring terms involving an N will be skipped)

3. The index of the character to which the ith character base pairs, if known.
If the character is known to be unpaired, then 0 appears here.
If it is
unknown whether this character base-pairs, then a -1 appears here. Note
if the BPSEQ ﬁle speciﬁes that character i base-pairs with character j,
then it must also specify that character j base-pairs with character i.

For example, the following is a BPSEQ format ﬁle:

CONTRAfold 2.02 User Manual

8 of 20

1 A 7
2 G -1
3 U -1
4 C 0
5 c -1
6 c -1
7 u 1

in which it is known that the ﬁrst and last positions base pair, and the mid-
dle position does not base pair. However, the folding of the other positions is
unknown.

However, the following is not a valid BPSEQ format ﬁle:

2 G -1
3 U -1
1 A 7
4 C 0
5 C -1
6 C -1
7 U 1

since all nucleotides in the ﬁle must appear in order.

Finally, the following is also not a valid BPSEQ format ﬁle:

1 A 7
2 G -1
3 U -1
4 C 0
5 c -1
6 c -1
7 u -1

since the ﬁrst position is speciﬁed as pairing with the last position, but not vice
versa.

4.2 Output formats

The results of a CONTRAfold secondary structure prediction are given in ei-
ther FASTA, BPSEQ, or posteriors format. We describe each of these in detail.

4.2.1 FASTA format

The FASTA output format is identical to the FASTA input format (see Sec-
tion 4.1.2) with structures. Since CONTRAfold provides predictions for the
pairing or non-pairing of every single nucleotides, no ?’s will appear in the
output.

The output will always consist of exactly four lines, where the ﬁrst and
third lines are FASTA headers for the sequence and structure, respectively, the

CONTRAfold 2.02 User Manual

9 of 20

second line speciﬁes the sequence data, and the fourth line speciﬁes the paren-
thesized structure. If a FASTA ﬁle is provided as input, then the header in the
FASTA input ﬁle will be used as the ﬁrst line header in the output ﬁle; oth-
erwise, the (relative) path to the input ﬁle is used as the header. The FASTA
header for the structure will always be “structure.” Since CONTRAfold gen-
erates only non-pseudoknotted structure predictions, the proper pairing will
always be unambiguous.

For example, the following parenthesized structure is a completion of the
valid BPSEQ ﬁle from Section 4.1.3, assuming that the input ﬁle is speciﬁed in
the ﬁle data/input.

>data/input
AGUCccu
>structure
((...))

4.2.2 BPSEQ format

The BPSEQ output format is identical to the BPSEQ input format (see Sec-
tion 4.1.3). Since CONTRAfold provides predictions for the pairing or non-
pairing of every single nucleotide, no -1’s will appear in the output.

4.2.3 Posteriors format

The posteriors output format is distinct from the BPSEQ and FASTA formats
in that it does not provide a single prediction of RNA secondary structure. In-
stead, it provides a sparse representation of the base pairing posterior probabil-
ities for pairs of letters in the RNA sequence. Speciﬁcally, the ith line contains

1. The integer i.

2. The ith character of the ﬁle.

3. A space-separated list of base-pairing probabilities of the form j:pij, where
j > i is the index of nucleotide to which the ith nucleotide might pair, and
pij is the probability that this base pairing occurs.

For example, the following is a posteriors format output:

1 A 7:0.035 9:0.10
2 G 6:0.036 8:0.11
3 U
4 C
5 C
6 C
7 U
8 C
9 A

CONTRAfold 2.02 User Manual

10 of 20

In the above, we see that nucleotide 2 has an 11% probability of pairing to
nucleotide 8. Note that each pairing probability is reported only once (i.e., on
the ith line, we show only the pairing probabilities to nucleotides j > i which
appear after the ith position in the RNA sequence).

CONTRAfold 2.02 User Manual

11 of 20

5 Usage

CONTRAfold has two modes of operation: prediction mode and training mode.

• In “prediction” mode, CONTRAfold folds new RNA sequences using ei-
ther the default parameters or a CONTRAfold-format parameter ﬁle.

• In “training” mode, CONTRAfold learns new parameters from training
data consisting of RNA sequences with pre-existing structural annota-
tions.

Most users of this software will likely only ever need to use CONTRAfold’s
prediction functionality. The optimization procedures used in the training
algorithm are fairly computationally expensive; for this purpose, the CON-
TRAfold program is designed to support automatic training in a parallel com-
puting environment via MPI (Message Passing Interface).

5.1 Prediction mode

In prediction mode, CONTRAfold predicts the secondary structure of one or
more unfolded input RNA sequence, and prints the result to either the console
or output ﬁles. The basic syntax for running CONTRAfold in prediction mode
is

$ ./contrafold predict [OPTIONS] INFILE(s)

5.1.1 A single input ﬁle

For single sequence prediction, CONTRAfold generates FASTA output (see
Section 4.1.2) to the console (i.e., stdout) by default.

For example, suppose the ﬁle “seq.fasta” contains a FASTA formatted se-

quence to be folded. Then the command

$ ./contrafold predict seq.fasta

will fold the sequence and display the results to the console in FASTA format.
CONTRAfold can also write parenthesized FASTA, BPSEQ, or posteriors

formatted output to an output ﬁle. To write FASTA output to a ﬁle,

$ ./contrafold predict seq.fasta --parens seq.parens

To write BPSEQ output to a ﬁle,

$ ./contrafold predict seq.fasta --bpseq seq.bpseq

To write all posterior pairing probabilities greater than 0.001 to a ﬁle,

$ ./contrafold predict seq.fasta --posteriors \

0.001 seq.posteriors

CONTRAfold 2.02 User Manual

12 of 20

Note that here, the backslash character is used to denote that a command-line is
broken over several lines; it is not necessary if you type everything on a single
line.

Finally, it is also possible to obtain multiple different types of output simul-

taneously. For example, the command

$ ./contrafold predict seq.fasta --parens \

seq.parens --bpseq seq.bpseq --posteriors \
0.001 seq.posteriors

will generate three different output ﬁles simultaneously.

5.1.2 Multiple input ﬁles

For multiple input ﬁles, CONTRAfold generates FASTA output (see Section 4.1.2)
to the console by default. The output is presented in the order of the input ﬁles
on the command-line. Using console output is not allowed when MPI is en-
abled, or when certain other options are selected; in general, we recommend
the usage of explicitly speciﬁed output ﬁles or subdirectories when dealing
with multiple input ﬁles (see below).

CONTRAfold can also write FASTA, BPSEQ, or posteriors formatted out-
put to several output ﬁles. In particular, CONTRAfold creates a subdirectory
(whose name is speciﬁed by the user) in which to store the results, and writes
each prediction to a ﬁle in that subdirectory of the same name as the original
ﬁle being processed.

For example, suppose that the ﬁles “seq1.fasta” and “seq2.fasta” each con-

tain a FASTA formatted sequence to be folded. Then the command

$ ./contrafold predict seq1.fasta seq2.fasta \

--parens output

will create a subdirectory called output and will place the results in the ﬁles
output/seq1.fasta and output/seq2.fasta.

Alternatively,

$ ./contrafold predict seq1.fasta seq2.fasta \

--bpseq output

and

$ ./contrafold predict seq1.fasta seq2.fasta \

--posteriors 0.001 output

generate BPSEQ and posteriors formatted outputs instead.

Observe that if multiple input ﬁles have the same base name, then over-
writing of output may occur. For example, if the input ﬁles list contains two
different ﬁles called seq/input and input, the output subdirectory will con-
tain only a single ﬁle called input.

Finally, you may also generate multiple types of output simultaneously, as
before. Remember, however, to use different output subdirectory names for
each. The command

CONTRAfold 2.02 User Manual

13 of 20

$ ./contrafold predict seq1.fasta seq2.fasta --parens \

parens_output --bpseq bpseq_output --posteriors \
0.001 posteriors_output

generates three different output subdirectories (parens output, bpseq output,
and posteriors output) each containing two ﬁles (seq1.fasta, seq2.fasta).

5.1.3 Optional arguments

CONTRAfold accepts a number of optional arguments, which alter the default
behavior of the program. To use any of these options, simply pass the option
to the CONTRAfold program on the command line. For example,

$ ./contrafold predict seq.fasta --viterbi \

--noncomplementary

The optional arguments include:

--gamma γ

This option sets the sensitivity/speciﬁcity tradeoff parameter for the max-
imum expected accuracy decoding algorithm. In particular, consider a
scoring system in which each nucleotide which is correctly base paired
gets a score of γ, and each nucleotide which is correctly not base paired
gets a score of 1. Then, CONTRAfold ﬁnds the folding of the input se-
quence with maximum expected accuracy with respect to this scoring sys-
tem.

Intuitively,

• If γ > 1, the parsing algorithm emphasizes sensitivity.
• If 0 ≤ γ ≤ 1, the parsing algorithm emphasizes speciﬁcity.

In addition, if the user speciﬁes any value of γ < 0, then CONTRAfold
tries trade-off parameters of 2k for k ∈ {−5, −4, . . . , 10}, and generates
one output ﬁle for each trade-off parameter. Note that this must be used
in conjunction with either --parens, --bpseq, or --posteriors in
order to allow for writing to output ﬁles.

For example, the command

$ ./contrafold predict seq.fasta --gamma 100000

runs the maximum expected accuracy placing almost all emphasis on
sensitivity (predict correct base pairs).
The naming convention used by CONTRAfold when γ < 0 follows some-
what different conventions from normal. Running

$ ./contrafold predict seq.fasta --gamma -1 \

--bpseq output

CONTRAfold 2.02 User Manual

14 of 20

will create the ﬁles

output/output.gamma=0.031250
output/output.gamma=0.062500
...
output/output.gamma=1024.000000

For multiple input ﬁles,

$ ./contrafold predict seq1.fasta seq2.fasta \

--gamma -1 --bpseq output

will generate

output/output.gamma=0.031250/seq1.fasta
output/output.gamma=0.031250/seq2.fasta
...
output/output.gamma=1024.000000/seq1.fasta
output/output.gamma=1024.000000/seq2.fasta.

Like before, multiple types of output (parens, BPSEQ, posteriors) may be
requested simultaneously.

--viterbi

This option uses the Viterbi algorithm to compute structures rather than
the maximum expected accuracy (posterior decoding) algorithm. The
structures generated by the Viterbi option tend to be of slightly lower ac-
curacy than posterior decoding, so this option is not enabled by default.

--noncomplementary

This option uses a folding model that allows non AU/CG/GU pairings
in the CONTRAfold output. This option is slower and generally slightly
less accurate than the default option of allowing only “canonical” base-
pairings.

--constraints

This option requires the use of BPSEQ format input ﬁles. By default,
any base pairings that are included in the BPSEQ ﬁle above are ignored.
However, if the --constraints ﬂag is used, then any base pairings in
an input BPSEQ ﬁle are treated as constraints on the allowed structures.
In particular,

1. A nucleotide mapping to a positive index i is constrained to base-

pair with nucleotide i.

CONTRAfold 2.02 User Manual

15 of 20

2. A nucleotide mapping to 0 is constrained to be unpaired.

3. A nucleotide mapping to -1 is unconstrained.

For example, given the following input BPSEQ ﬁle:

1 A -1
2 C -1
3 G -1
4 U 7
5 U 0
6 C 0
7 G 4
8 C -1
9 G -1
10 U -1

and the --constraints ﬂag, then CONTRAfold will assume that po-
sitions 4 and 7 are constrained to be base-pairing, while positions 5 and
6 are constrained to be unpaired. The base-pairing of the remaining po-
sitions is decided by CONTRAfold. The constraints must follow the re-
strictions described in Section 4.1.

--params PARAMSFILE

This option uses a trained CONTRAfold parameter ﬁle instead of the de-
fault program parameters. The format of the parameter ﬁle should be the
same as the contrafold.params.complementary ﬁle in the CON-
TRAfold source code; each line contains a single parameter name and a
parameter value.

--version

Display the program version number.

--verbose

Show detailed console output.

--partition

Compute the log partition function for the input sequence. This option
may be used in conjunction with the --constraints option in order to
determine the CONTRAfold “energy” of a given RNA secondary struc-
ture speciﬁed in a BPSEQ ﬁle. For example, to compute the energy of a
Viterbi parse generated via

$ ./contrafold predict seq.fasta --viterbi \

--bpseq seq.bpseq

CONTRAfold 2.02 User Manual

16 of 20

we can simply run

$ ./contrafold predict seq.bpseq --constraints \

--partition

Some quick notes regarding the partition function:

• When used in conjunction with partial constraints (i.e., only some of
the mappings in the input BPSEQ ﬁle are -1’s; see above), then this
option computes the log of the summed unnormalized probabilities
for all structures consistent with the partial constraints.

• In order to compute the log of the summed probabilities (which are
normalized as opposed to the quantities mentioned above), you must
also run

$ ./contrafold predict seq.bpseq --partition

and subtract this log partition value from the previous log parti-
tion value described above. Note that this quantity will always be
greater than or equal to the log-partition above, implying that the
log of the summed probabilities is necessarily non-positive (which
makes sense as probabilities are at most 1).

5.2 Training mode

In training mode, CONTRAfold infers a parameter set using RNA sequences
with known (or partially known) secondary structures in BPSEQ format. By
default, CONTRAfold uses the L-BFGS algorithm for optimization.

For example, suppose input/*.bpseq refers to a collection of 100 ﬁles

which represent sequences with known structures. Calling

$ ./contrafold train input/*.bpseq

instructs CONTRAfold to learn parameters for predict all structures in

input/*.bpseq

without using any regularization. The learned parameters after each iteration
of the optimization algorithm are stored in

optimize.params.iter1
optimize.params.iter2
...

in the current directory. The ﬁnal parameters are stored in

optimize.params.final

and a log ﬁle describing the optimization is stored in

CONTRAfold 2.02 User Manual

17 of 20

optimize.log

In general, running CONTRAfold without regularization is almost always a bad idea
because of overﬁtting. There are currently two ways to use regularization that
are supported in the CONTRAfold program:

1. Regularization may be manually speciﬁed. The current build of CON-
TRAfold uses 15 regularization hyperparameters, each of which is used
for some subset of the parameters. To specify a single value shared be-
tween all of the regularization hyperparameters manually, one can use
the --regularize ﬂag. For example,

$ ./contrafold train --regularize 1 input/*.bpseq

uses a regularization constant of 1 for each hyperparameter. In general,
we recommend that you do not perform training yourself unless you
know what you are doing; also do not hesitate to ask us.

2. The recommended usage is to use CONTRAfold’s holdout cross-validation
procedure to automatically select regularization constants. To reserve a
fraction p of the training data as a holdout set, run CONTRAfold with
the --holdout p ﬂag.
For example, to reserve 1/4th of the training set for holdout cross-validation,
use

$ ./contrafold train --holdout 0.25 \

input/*.bpseq

Note that the --holdout and --regularize ﬂags should not be used
simultaneously.

CONTRAfold 2.02 User Manual

18 of 20

6 Visualization of folded RNAs

Besides the main program, the CONTRAfold package contains some addi-
tional tools for visualization of folded RNAs:

• make coords: generates a set of coordinates for plotting a CONTRAfold

BPSEQ ﬁle.

• plot rna: converts a set of coordinates and a BPSEQ ﬁle into a viewable

PNG.

In the following subsections, we describe the installation and use of these two
tools for RNA visualization.

6.1

Installation

Currently, only UNIX installation is supported.

6.1.1 *nix installation

To compile CONTRAfold visualization tools from the source code (for a *nix
machine):

1. Install the libgd graphics development library, available from

http://www.boutell.com/gd/

2. Install the libpng PNG image library, available from

http://www.libpng.org/pub/png/libpng.html

3. Compile the visualization tools:

$ make viz

6.2 Usage

Given an input FASTA ﬁle, generating an image of the predicted CONTRAfold
structure involves three steps:

1. Generate a secondary structure prediction in BPSEQ format:

$ ./contrafold predict seq.fasta --bpseq \

seq.bpseq

2. Run the make coords program to generate an RNA layout:

$ ./make_coords output.bpseq output.coords

CONTRAfold 2.02 User Manual

19 of 20

The resulting coordinates are placed in the output.coords ﬁle.

3. Run the plot rna program to convert the layout into a PNG image:

$ ./plot_rna output.bpseq output.coords \

--png output.png

The resulting PNG is placed in the output.png ﬁle and can be viewed
with a web browser such as Mozilla Firefox. Alternatively, EPS format
output is also available:

$ ./plot_rna output.bpseq output.coords \

--eps output.eps

6.3 Additional options

The plot rna has a couple of options which you can use to control the gener-
ated PNG ﬁles:

--posteriors posteriorsf ile

If a CONTRAfold posteriors ﬁle is also available,then using the above
option will generate a PNG ﬁle in which the letters of each RNA nu-
cleotide is colored according to posterior probability conﬁdence. Black
letters indicate high conﬁdence structure whereas lighter gray letters in-
dicate lower conﬁdence structure.

--title "title"

This option allows the user to annotate the generated RNA image with
a title. Note that the title string should be surrounded with double quo-
tation marks so as to ensure that it is interpreted as a single argument to
the program.

In general, the CONTRAfold visualization tools generate RNA layouts which

tend to be visually pleasing. The layout algorithm uses a simple deterministic
layout rule, followed by a gradient-based optimization procedure. This type of
procedure is not guaranteed to generate non-overlapping layouts for all RNA
structures; in practice, however the visualization tools can provide reasonable
visualizations for a large range of RNA structures.

CONTRAfold 2.02 User Manual

20 of 20

7 Citing CONTRAfold

If you use CONTRAfold in your work, please cite:

Do, C.B., Woods, D.A., and Batzoglou, S. (2006) CONTRAfold: RNA
secondary structure prediction without physics-based models. Bioin-
formatics, 22(14): e90-e98.

Other relevant references include:

Do, C.B., Foo, C.-S., Ng, A.Y. (2007) Efﬁcient multiple hyperparame-
ter learning for log-linear models. In Advances in Neural Information
Processing Systems 20.

