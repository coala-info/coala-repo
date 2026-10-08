Source: https://ccb.jhu.edu/software/ELPH/ (ELPH home page)

The ELPH Home Page

ELPH : Estimated Locations of Pattern Hits

Overview
ELPH is a general-purpose Gibbs sampler for finding motifs in a
set of DNA or protein sequences. The program takes as input a set
containing anywhere from a few dozen to thousands of sequences,
and searches through them for the most common motif, assuming that
each sequence contains one copy of the motif. We have used ELPH
to find patterns such as ribosome binding sites (RBSs) and exon
splicing enhancers (ESEs). See below for instructions on downloading
the complete system, including source code.
An online tool that uses ELPH output for identifying exon splicing enhancers can be found here.

System requirements
ELPH is released as source code and was tested on Linux RedHat 6.x+, Sun Solaris, and Alpha OSF1, but should work on any Unix system.
Obtaining ELPH
This software is OSI
Certified Open Source Software .

To download the complete ELPH system, just click here .
After downloading, uncompress the distribution file by typing:
% tar -xzf ELPH.tar.gz
A directory named 'ELPH/' will be created which contains the executable, training data sets, and other supporting files.
Documentation
A basic user manual for ELPH is available here. (Note: that link, man.html, returned "404 Not Found" when this page was saved in October 2026; Readme.ELPH holds the same option list.)

Contact Information
Use this form to contact us.

Acknowledgements
The project is supported in part by NSF Award MCB-0114792, "Arabidopsis 2010: Pre-mRNA Splicing Signals in
Arabidopsis".
Back to the CBCB Software Page

Download: ftp://ftp.cbcb.umd.edu/pub/software/elph/ELPH-0.1.5.tar.gz (the home page link; the Debian/BioContainers package uses ELPH 1.0.1)
