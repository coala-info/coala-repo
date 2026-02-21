MAMMaL: (M)ultinomial (A)pproximate (M)ixture (Ma)ximum (L)ikelihood

Accelerated Estimation of Frequency Classes in Site-heterogeneous Proﬁle Mixture Models

1

Version 1.1.3

June 20, 2022

Edward Susko

Department of Mathematics and Statistics, Dalhousie University

Introduction

The main program mammal takes as input a number of classes, a sequence ﬁle and a tree and outputs

estimated frequencies for classes using the methods described in Susko, Lincker and Roger (2018). Instal-

lation information is available towards the end of this document. As a convention for referring to models

that use the estimated frequencies, we recommend, for instance, LG+MAM20+G for a model that has an LG

exchangeability matrix, gamma rate variation and 20 frequency classes constructed using the MAMMaL

software.

The program mammal can be run at the command line with

$ mammal -s seqfile -t treefile -c number_of_classes [OPTIONS]

A brief description of the options and output is given below. Additional information is available in

subsequent sections.

-s seqfile: The input sequence ﬁle. Note: The format must comply with PHYLIP conventions. See

below for additional details.

-t treefile: A Newick tree ﬁle. Used to determine high-rate sites.

-c number_of_classes: The number of frequency classes.

-h: Use hierarchical clustering to get starting frequencies with the base R clustering routines. Default:
The C-series frequencies of Le et. al. (2008) are used if the number of classes are in {10, 20, . . . , 60}.

-l: Don’t use likelihood weighting. Default: Use likelihood weights.

-q quantile: Use sites with rates > q × 100th percentile of mean DGPE rates. Default: 0.75.

-C penalty: The penalty parameter, η in Susko, Lincker and Roger (2018). Default: η = 5.

The output consists of three text ﬁles:

estimated-frequencies: Each row gives the amino acid frequencies for a class. Update: Unlike in

Version 1.0, the overall frequencies in the data set are not included as the last row in the ﬁle.

esmodel.nex: A nexus ﬁle that can be used with the options -mdef esmodel.nex, -m LG+ESmodel+G

to deﬁne a mixture model for ML estimation using IQ-TREE (Nguyen et al. 2015). If you wish to

include a +F class replace -m LG+ESmodel+G with -m LG+ESmodel+F+G

2

estimated-weights: Each entry gives the estimated weights for a class.

If these are 0 it indicates a

potential problem with the corresponding frequency classes. You might consider running with a

small number of classes.

Note: The program creates a number of ﬁles preﬁxed with tmp which are removed upon conclusion. If
you have ﬁles of the form tmp.* in the directory where mammal is run, they should be renamed or moved.

An additional ﬁle, rate_est.dat is created giving rate estimates for size with rates > q × 100th percentile

of mean DGPE rates.

3

Input

Additional Information about Program Usage

-s seqfile: The ﬁle should conform to the requirements of the PHYLIP package (Felsenstein, 1989,
2004). Sequence names should be 10 characters long and padded by blanks. The names should
match the names used in the input treeﬁle. Input can be either interleaved or sequential with one
caveat: The lines 2 through m + 2, where m is the number of taxa, must contain the name of taxa
followed by sequence data. For instance the start of a sequence ﬁle might be

ANLLLLIVPI LI...

INIISLIIPI LL...

6 3414

Homsa

Phovi

...

but not

6 3414

Homsa

ANLLLLIVPI LI...

Phovi

INIISLIIPI LL...

...

which would be allowed under the sequential format by PHYLIP.

Additional information is available at

http://evolution.genetics.washington.edu/phylip/doc/sequence.html

-t treefile: The tree should conform to the Newick standard. A discussion of this standard as imple-

mented in PHYLIP is given at

http://evolution.genetics.washington.edu/phylip/newicktree.html

and a more formal description is available at

http://evolution.genetics.washington.edu/phylip/newick_doc.html

-h: The default hierarchical clustering routine in R is used. This routine can require more memory than

is available if the number of sites in the alignment is large. The default starting frequencies when

the number of classes are in {10, 20, . . . , 60} are the C-series classes, so using hierarchical starting

frequencies is not strictly necessary.

Susko, Lincker and Roger (2018) references the Rclusterpp package of Linderman and Bruggner

(2013), which was available in version 1.0 of the MAMMaL software. We have since removed this op-

tion as the package has been archived on the CRAN repository and the last version in that repository

had a bug.

Output

estimated-frequencies: Each row gives the amino acid frequencies for a class. On any given row, the

ordering of frequencies is the conventional ordering expected by most packages, alphabetical on their

three-letter codes:

4

A

R

N

D

C

Q

E

G

H

Ala Arg Asn Asp Cys Gln Glu Gly His

L

K

M

F

P

S

T W Y

I

Ile

V

Leu Lys Met Phe Pro

Ser Thr Trp Tyr Val

esmodel.nex: A nexus ﬁle that can be used to ﬁt a mixture model with IQ-TREE at the command line

through

$ iqtree -s seqfile -m LG+ESmodel+G -mdef esmodel.nex [OPTIONS]

With no options, it will ﬁt the mixture and search for the best tree. The term ESmodel should always
be present in the model statement. The example above ﬁts a model that has the LG exchangeability
matrix and a discretized gamma rates-across-sites model on top of the mixture. The elements of the
model can be changed. See

http://www.iqtree.org/doc/Command-Reference#general-options

for additional information about options and specifying substitution models (search ‘Specifying sub-

stitution models’ on that page).

System Requirements and Installation
Requirements and Installation of External Packages The main program mammal is an R language
script ﬁle that eﬀectively pastes together results from a number of smaller programs, some of which were
written in R and some in C. To install the package you will need a C compiler, a working installation of
the R statistical package and the R package quadprog of Turlach and Weingessel (2013). The statistical
package R is freely available at https://cran.r-project.org. Once R is installed, the quadprog R
package can be installed at the R command line with

> install.packages("quadprog")

The source code has been compiled and tested using gcc computers running Linux and Mac OS X. While
the program has not been tested on another platform, it should compile under any Linux distribution as
well as Mac OS X. On Mac OS, to install gcc, bring up a terminal and type

$ xcode-select --install

Installation

1. Download and unpack the software

$ tar zxf mammal.tgz

This will create a directory mammal that contains the source code.

2. Change directories to mammal and create the main program ﬁles with the make command

5

$ cd mammal

$ make

$ chmod a+x mammal

The default installation assumes the gcc compiler is available. To use a diﬀerent compiler, change

the variable CC in Makefile.

3. Copy the program ﬁles

dgpe mammal-sigma mult-data mult-mix-lwt charfreq

to a location in your PATH or to a known directory. If the directory that these ﬁles are copied to is
not in your PATH, you should change the line bindir <- "" in the ﬁle mammal to

bindir <- "dir_with_files/"

where dir_with_files is the name of the directory that the ﬁles above have been copied to.

4. Copy the C-series frequencies

C10.aafreq.dat, ..., C60.aafreq.dat

to a known directory. Change cseries.dir <- "" to cseries.dir <- "dir_with_files" where

dir_with_files is the name of the directory that the ﬁles above have been copied to.

5. Copy the ﬁle mammal to a location in your PATH.

6. The source code and directory can be removed:

$ cd ../

$ rm -rf mammal.tgz mammal/

References

Felsenstein, J. (2004). PHYLIP Phylogeny Inference Package (version 3.6). Distributed by the author.

Department of Genome Sciences, University of Washington, Seattle.

Felsenstein, J. (1989). PHYLIP - Phylogeny Inference Package (version 3.2). Cladistics 5: 164-166.

Le S.Q., Gascuel O., Lartillot N. (2008). Empirical proﬁle mixture models for phylogenetic reconstruction.

Bioinformatics. 24:23172323.

Linderman, M. and Bruggner, R. (2013). Rclusterpp: Linkable C++ clustering. R package version 0.2.3.

6

Nguyen L.T., Schmidt H.A., von Haeseler A., Minh B.Q. (2015). IQ-TREE: A fast and eﬀective stochastic

algorithm for estimating maximum likelihood phylogenies.. Mol. Biol. Evol., 32:268-274.

Susko, E., Lincker, L. and Roger, A.J. (2018). Accelerated Estimation of Frequency Classes in Site-

heterogeneous Proﬁle Mixture Models. Mol Biol. Evol. 35:1266–1283.

Turlach, B.A. and Weingessel, A. (2013). quadprog: Functions to solve quadratic programming problems.

R package version 1.5-5.

