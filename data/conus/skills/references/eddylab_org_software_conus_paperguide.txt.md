"Design of Lightweight Stochastic Context Free Grammars
for RNA Secondary Structure Prediction"
-------------------------------------------------------
(Notes summary on how CONUS was utilized for the paper)
=======================================================
Assumptions:
------------
CONUS code has been compiled and executables are in
a directory called "bin/".
The three datasets are in a directory called "data/"
and have the names:
1) mixed80.stk LSU/SSU dataset for training
2) rfam5.stk Rfam v5 seed info for ambiguity testing
3) benchmark.stk Benchmark dataset (RNase P, SRP, tmRNA)
Grammar Correspondance:
-----------------------
The grammar codes CONUS uses are as follows:
CONUS grammar code Paper's Grammar
NUS G1
YRN G2
UNA G3
RUN G4
IVO G5
BJK G6
UYN G7
RY3 G8
BK2 G6S
Training:
---------
bin/conus\_train -g NUS -s nusmixed80.mod data/mixed80.stk
This produces a binary output file called nusmixed80.mod which
contains the NUS model trained on the mixed80.stk dataset.
Ambiguity Experiments:
----------------------
bin/reorder -m nusmixed80.mod -b N data/all\_rfam5.stk
where N is the number of suboptimals to generate and test.
Must have a trained model file for input. Only available
on the two ambiguous grammars (NUS and YRN).
Ambiguity Testing:
------------------
bin/ambtest -i -m unamixed80.mod data/all\_rfam5.stk
Will halt as soon as any sequence/structure pair fails the
ambiguity test. Note that the -i option asks ambtest to
ignore the input structure and generate a test structure by
CYK.
Plus One Grammar Check:
-----------------------
bin/pocheck -m unamixed80.mod data/all\_rfam5.stk
This verifies that all grammars give appropriately
equivalent score under a simple +1 scoring scheme.
[Note that the additional restriction of not permitting
lone pairs means that UYN and RY3 may not equal the
other 7 grammars; but they should equal each other.]
Plus One Grammar Performance:
-----------------------------
bin/conus\_fold -q -w 2 -g NUS data/benchmark.stk > nus.stk
sreformat --wussify stockholm nus.out > nus\_w.stk
compstruct data/benchmark.stk nus\_w.stk
bin/conus\_compare -w 2 -g NUS data/benchmark.stk
Trained Grammar Performance:
----------------------------
bin/conus\_fold -q -w 2 -m nusmixed80.mod data/benchmark.stk > nus.stk
sreformat --wussify stockholm nus.out > nus\_w.stk
compstruct data/benchmark.stk nus\_w.stk
bin/conus\_compare -w 2 -m nusmixed80.mod data/benchmark.stk