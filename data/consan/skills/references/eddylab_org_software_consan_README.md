Consan - pairwise stochastic context-free grammar for RNA structural alignment
Version 1.1 (September 2006)
Copyright (C) 2006 HHMI/Washington University School of Medicine
--------------------------------------------------------------------
o About this software...
Consan is an implementation of a pairwise stochastic context-free
grammar for RNA structural alignment, both unconstrained and
constrained on alignment pins.
o Getting Consan
WWW home: http://selab.genetics.wustl.edu/people/robin/consan/
o Installing Consan
See the file INSTALL for brief instructions.
You should also read the following files:
LICENSE -- Full text of the GNU Public License, version 2
o Getting started with Consan
There are three executables: strain\_ml, sfold, and scompare.
Brief descriptions and basic usage:
\* strain\_ml (training; generates a model parameter file e.g. model.mod)
> strain\_ml -s model.mod trainingset.stk
\* sfold (structural alignment of two sequences)
> sfold -m model.mod seq1.fa seq2.fa
\* scompare (structural alignment of two sequences with comparison to a
given pairwise alignment; essentially a wrapper around sfold)
> scompare -m model.mod alignment.stk
Run any of the above programs with the -h options for more options.
See the file paperguide.txt for examples of how the software was
used in the paper (see reference below).
o References for Consan
Dowell, R.D. and S.R. Eddy "Efficient pairwise RNA structure prediction
and alignment using sequence alignment constraints" BMC Bioinformatics
7:41 2006.
o Reporting bugs
These programs are under active development. Though this
release has been tested and appears to be stable, bugs may crop up. If
you use these programs, please help me out and e-mail me with
suggestions, comments, and bug reports. (rdd@mit.edu)
Robin Dowell & Sean Eddy
Howard Hughes Medical Institute and Dept. of Genetics
Washington University School of Medicine, St. Louis, Missouri, USA
-------------------------------------------------------------------