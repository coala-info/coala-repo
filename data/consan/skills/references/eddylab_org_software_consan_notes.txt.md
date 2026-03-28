Data Format:
============
The datasets are provided in Consan's preferred format,
STOCKHOLM 1.0. See XXX for more information on the
STOCKHOLM format.
Conus uses the style of structure notation with base pairing
symbols '>' and '<'. [For a particular pair the symbols point
to each other.]
Technially we are corrupting the STOCKHOLM format by using it to
annotate and represent single sequences (instead of the multiple
sequence alignments for which it was intended) as well.
Structure format: (STOCHOLM 1.0)
--------------------------------
Using STOCKOLM format to annotate alignments:
Example:
# STOCKHOLM 1.0
#=GS RD0260 DE GUC PHAGE T5 VIRUS
#=GS RE6781 DE CPC HORDEUM VULGARE CY PLA
RD0260 GCGACCGGGGCUGGCUUGGUAAUGGUACUCCCCUGUCACGGGAGAGAAUG
RE6781 UCCGUCGUAGUCUAGGUGGUUAGGAUACUCGGCUCUCACCCGAGAGA-CC
#=GC SS\_cons >>>>>>>..>>>>.........<<<<.>>>>>.......<<<<<.....>
RD0260 UGGGUUCAAAUCCCAUCGGUCGCGCCA
RE6781 CGGGUUCGAGUCCCGGCGACGGAACCA
#=GC SS\_cons >>>>.......<<<<<<<<<<<<....
//
Using STOCKOLM format to annotate single sequences:
Example:
# STOCKHOLM 1.0
#=GS DA252 DE DA2521 trna
DA252 GGGGGUAUAGCUCAGUUGGUAGAGCGCUGCCUUUGCAAGGCAGAUGUCAG
#=GR DA252 SS >>>>>>>..>>>>........<<<<.>>>>>.......<<<<<.....>>
DA252 CGGUUCGAGUCCGCUUUAUCUCCA
#=GR DA252 SS >>>.......<<<<<.<<<<<<<.
//
The DataSets:
=============
The sequences in the training set (mixed80.stk) were obtained
from the European Ribosomal Database in December 2002. They
were culled to remove sequences containing more than 5% ambiguous
bases or less than 40% base pairing. The resulting set was
filtered at 80% identity.
For comparing parameterizations, the Rfam.v7.pub80.stk.
Random 100 sequence in 5S and tRNA family for comparison to
single sequence methods R100.stk. The same as R100 but with
an informant sequence R100.pairs.stk.
The percent identity balanced set, used as the primary testing
set (percid.stk).
The Dynalign dataset is not redistributable, please contact
David Mathews (David\_Mathews@urmc.rochester.edu).
The Stemloc dataset is extracted from Rfam v6.1 to reproduce
the dataset described in Holmes (2005).