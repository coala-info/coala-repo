Data Format:
============
The datasets are provided in CONUS's preferred format,
STOCKHOLM 1.0. [Technially we are corrupting the STOCKHOLM
format by using it to annotate and represent single
sequences instead of the multiple sequence alignments for
which it was intended.] See XXX for more information on
the STOCKHOLM format.
Conus uses the style of structure notation with base pairing
symbols '>' and '<'. [For a particular pair the symbols point
to each other.]
----
Example:
# STOCKHOLM 1.0
#=GS DA252 DE DA2521 trna
DA252 GGGGGUAUAGCUCAGUUGGUAGAGCGCUGCCUUUGCAAGGCAGAUGUCAG
#=GR DA252 SS >>>>>>>..>>>>........<<<<.>>>>>.......<<<<<.....>>
DA252 CGGUUCGAGUCCGCUUUAUCUCCA
#=GR DA252 SS >>>.......<<<<<.<<<<<<<.
//
The Sets:
=========
The sequences in the training set were obtained
from the European Ribosomal Database in December 2002. They
were culled to remove sequences containing more than 5% ambiguous
bases or less than 40% base pairing. The resulting set was
filtered at 80% identity. The resulting training set is a
collection of 278 sequences with equal numbers of LSU and SSU.
The benchmarking testing set is a collection of 403 sequences
consisting of 225 RNase P's obtained from Jim Brown's Ribonuclease
P database, 81 SRP's from Christian Zweib's Signal Recognition
Particle database, and 97 tmRNA's from Christian Zweib's database.
To obtain this set each family's multiple sequence alignment was
filtered at 80% sequence identity and the structure of each
remaining sequence was obtained from the parental database.
Sequences containing ambiguous bases were removed.
The ambiguity test set is a collection of 2455 sequences from
174 different families with the Rfam v5 seed alignments. This
set was built from family alignments which were each filtered
at 80%. Sequences containing ambiguous bases were removed.
CONUS data tools:
=================
weedamb -- takes in a dataset in CONUS preferred format and
removes any sequence which contains ambiguous bases
scheck -- the most rudimentary of structure integrity checks
stk2ct -- converts a CONUS preferred stockholm file into a CT file