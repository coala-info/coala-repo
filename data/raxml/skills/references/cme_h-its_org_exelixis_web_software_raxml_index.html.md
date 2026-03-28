* [The Exelixis Lab](../../../index.html)
* [News](../../../news.html)
* [Research](../../../research.html)
* [Publications](../../../publications.html)
* [Software](../../../software.html)
* [Teaching](../../../teaching.html)
* [Talks](../../../talks.html)
* [Outreach](../../../outreach.html)
* [People](../../../people.html)
* [Jobs](../../../jobs.html)
* [Contact Us](../../../contact.html)

# The Exelixis Lab

Enabling Research in Evolutionary Biology

* Download
* [Source code](https://github.com/stamatak/standard-RAxML)
* Links
* [Publication](http://bioinformatics.oxfordjournals.org/content/22/21/2688.long)
* [Documentation](#documentation)
* [Google group](#user)
* [GUI](#gui)
* [Web services](#web)
* [Helper scripts](#helper)

### RAxML - Randomized Axelerated Maximum Likelihood

#### New RAxML citation

When using RAxML please cite the following paper:
A. Stamatakis: "RAxML Version 8: A tool for Phylogenetic Analysis and Post-Analysis of Large Phylogenies". In *Bioinformatics*, 2014,
[open access](http://bioinformatics.oxfordjournals.org/content/early/2014/01/21/bioinformatics.btu033.abstract?keytype=ref&ijkey=VTEqgUJYCDcf0kP).

#### Latest code download

Get the most up-to-date RAxML version from [github](https://github.com/stamatak/standard-RAxML).

#### Documentation

* **new RAxML version 8.0.0 manual** [PDF](../../../php/countManualNew.php)
* copy of the old v704 manual: [PDF](../../../php/countManual7.0.4.php)
* For a basic step by step tutorial using some more recent
  features see [RAxML step-by-step tutorial](hands_on.html)
* For a basic step by step tutorial by Pavlos Pavlidis on how
  to install and run RAxML on a Linux cluster see [RAxML on cluster step-by-step tutorial](cluster.html)
* For a video explaining the evolutionary placement algorithm
  for short reads see [Alexis
  talking about evolutionary placement of short reads](http://www.scivee.tv/node/16283)
* [Video of Alexis
  talking about evolutionary placement of short reads at the Joint Genome
  Institute](http://www.scivee.tv/node/16283)
* Some nice [slides](../../../resource/doc/Phylo100225.pdf) by Wayne
  Pfeiffer (SDSC) on the hybrid MPI/Pthreads version of RAxML and the
  hybrid MPI/OpenMP version of MrBayes
* some useful [slides](../../../resource/doc/pattengale-recomb09.pdf)
  by Nick Pattengale explaining the bootstrap convergence criteria
  implemented in RAxML
* Antonis Rokas has written a nice [chapter](../../../resource/doc/2011_Rokas_CPMB.pdf) about hands-on phylogeny reconstruction that uses RAxML as example program
* A tutorial on how to [install and run RAxML on a MAC in less than a minute](http://www.sfu.ca/biology2/staff/dc/raxml/) by Dave Carmean

#### User Support

Please send all your questions and feature request to the RAxML [google group](https://groups.google.com/forum/?hl=en#!forum/raxml).
Before posting, keep in mind that a google group actually has a search function!
Emails to Exelixis lab members regarding RAxML will not be answered. Messages posted via github will also not be answered.

#### RAxML memory requirements

Since datasets are getting larger here is a formula to estimate RAxML
memory requirements:
Given an alignment of *n* taxa and *m* distinct patterns the memory
consumption is approximately:

** MEM(AA+GAMMA) = (n-2) \* m \* (80 \* 8) bytes
* MEM(AA+CAT) = (n-2) \* m \* (20 \* 8) bytes
* MEM(DNA+GAMMA) = (n-2) \* m \* (16 \* 8) bytes
* MEM(DNA+CAT) = (n-2) \* m \* (4 \* 8) bytes*
To convert bytes to MB or GB you can use this [on-line converter](http://www.whatsabyte.com/P1/byteconverter.html)

You may also use th on-line calculator below:

taxa (n):
pattern (m):

AA+GAMMA
AA+CAT
DNA+GAMMA
DNA+CAT

Required size:

(n-2) \* m \* (x \* 8) bytes = MEM

#### Web-Servers for evolutionary placement of short reads

Web-Servers for phylogenetic
placement of short sequence reads (including alignment and
visualization tools):

* advanced [Swiss Server](http://mltreemap.org/)
  with pre-computed trees, please cite this [paper](http://www.biomedcentral.com/1471-2164/11/461) when
  using it
* basic [German
  Server](http://sco.h-its.org/raxml) without pre-computed trees, please cite this [paper](http://sysbio.oxfordjournals.org/content/60/3/291.short) when using it

#### Web-Servers for tree building

co-maintaned by Exelixis Lab:

* [Vital
  IT unit of the Swiss Institute of Bioinformatics](http://phylobench.vital-it.ch/raxml-bb/)
* [CIPRES
  portal](http://www.phylo.org/sub_sections/portal/) at San Diego Supercomputer Center
* [New beta-versio](http://www.phylo.org/portal2/login%21input.action)n of
  the CIPRES portal that provides a full workbench.

  I recently found this youtube video (in Spanish) with a nice tutorial on how to use
  the CIPRES portal:

not maintained by the Exelixis Lab:

* [Bioportal in
  Norway (University of Oslo)](http://www.bioportal.uio.no/)
* Trex on-line [Web-Server](http://www.trex.uqam.ca/index.php?action=raxml&project=trex) at  Université du Québec à Montréal

#### Graphical User Interfaces (GUIs)

* Daniele Silvestro and Ingo Michalak at the [Senckenberg Museum and Research
  Center](http://www.senckenberg.de/) have started developing a GUI for RAxML that runs under
  MACs, Windows, and Linux. The code for the GUI is available [here](http://sourceforge.net/projects/raxmlgui/). Please send
  suggestions and comments to Daniele Silvestro at senckenberg de
* Jacek Kominek from
  the University of Gdansk in Poland has developed this nice GUI [here](https://sourceforge.net/projects/wxraxml/)

#### Helper Scripts and Tools

##### Phylogenetic Binning tool

Phylogenetic binning tool for
paper on "Morphology-based phylogenetic
binning of the lichen genera Allographa and Graphis via molecular site
wieght calibration" by Simon Berger
available for download [here](../../../php/countSourceBinning.php)
tech report [PDF](../../../php/rrdr2010-6.php) and [paper](http://www.ingentaconnect.com/content/iapt/tax/2011/00000060/00000005/art00020)

##### File Conversion scripts

* shell script by Andre Aberer for [fasta to phylip conversion](../../../resource/download/software/convert.sh)
* matlab programs by Lowie Li for [fasta to phylip](../../../resource/download/software/ConvertFasta2Phylip.m) and [phylip to fasta](../../../resource/download/software/ConvertPhylip2Fasta.m) conversion

##### Wrapper Scripts

Apurva
Narechania at the American Museum of Natural
history has kindly put togetehr a couple of wrapper scripts for RAxML
:-)

* [raxml\_launch\_serially.sh](../../../resource/download/software/raxml_launch_serially.sh):
  A simple shell script that launches one job after the other awaiting
  for completion of each job.
* [raxml\_nexusPartConvert.pl:](../../../resource/download/software/raxml_nexusPartConvert.pl)
  A Perl script that parses a partitioned alignment in Nexus format
  with charsets and produces a partition guide file to be fed to RAxML
  with -q. Preliminary - works with DNA or AA, but not the two together
  yet, so not suitable for mixed-molecule data. Unless the output gets
  redirected to a file with ">", it will appear on screen.
* [raxml\_wrapper.pl](../../../resource/download/software/raxml_wrapper.pl):
  A Perl script that reads a raxml.config file with common run
  parameters and executes a directory of Phylip alignment files in batch,
  then outputs the results in another directory. See the documentation
  with "perldoc ./raxml\_wrapper.pl".

Guy
Leonard at Exeter has updated his wrapper environment
called [easyRax](http://projects.exeter.ac.uk/ceem/easyRAx.html)

Alexis
has developed a couple of perls scripts

A [perl
script](../../../resource/download/software/bsBranchLengths.pl) for computing bootstrap branch lengths with RAxML. This
script can be used to perform the following task with RAxML:

* Given a
  best-known ML tree, generate a number of Bootstrap replicates and just
  re-estimate the branch lengths for that given fixed tree topology on
  each Bootstrap replicate.
* To invoke the script call it as follows: "perl bsBranchLengths.pl
  alignmentFileName treeFileName numberOfReplicates".  The
  script assumes that the RAxML executable is located in the directory
  where you execute it. Otherwise, if RAxML is located in your Linux/Unix
  path just replace every occurence of "./raxmlHPC"
  by "raxmlHPC" in the
  script. The bootstrapped trees with branch lengths will be written into
  a file called "bsTrees".
* This script is intended for use with programs that infer
  divergence
  time estimates.

A [perl
script](../../../resource/download/software/ProteinModelSelection.pl) for finding the best protein substitution model

* Here
  is a little perl-script that will automatically determine the
  best-scoring AA substitution model on a fixed starting tree.  Note
  that raxmlHPC must be in your $PATH for this to work.
* For unpartitioned datasets execute it like this: perl ProteinModelSelection.pl
  alignmentFile.phylip > outfile The outfile will then contain
  the best-scoring AA model to use with RAxML.
* For partitioned datasets execute it like this: perl ProteinModelSelection.pl
  alignmentFile.phylip partitionData.txt > outfile The outfile
  will then contain the best-scoring AA model for every partition.

James Munro has written
a [Guide
to install RAxML on MACs](http://hymenoptera.ucr.edu/index.php?option=com_content&task=view&id=62&Itemid=8)

Olaf Bininda-Emonds has
written [batchRAxML.pl](http://www.molekularesystematik.uni-oldenburg.de/33997.html).
This nice script by my good colleague from Munich times Olaf
Bininda-Emonds provides a wrapper around RAxML to easily analyze a set
of data files according to a common set of the search criteria. Also
organizes the RAxML output into a set of subdirectories.

Frank Kauff has written [PYRAXML2](http://www.lutzonilab.net/downloads/).
Frank Kauff at University of Kaiserslautern (formerly at Duke
University) has written this cool script that reads NEXUS-style data
files and prepares the necessary input files and command-line options
for RAxML-VI-HPC. You can download the BETA-version here: [PYRAXML2](http://www.lutzonilab.net/downloads/) It requires
PYTHON and BIOPYTHON to be installed on your computer.

#### Old RAxML code versions

* RAxML v7.2.8 alpha release source
  code available [here](../../../php/countSource728.php)
* RAxML v7.2.7 (alpha) available for download [here](../../../php/countSource727.php)
* RAxML v7.2.6 available for download [here](../../../php/countSource726.php) and here is a windows [executable](../../../php/count726Win.php)
* RAxML v7.2.5 (alpha) available for download [here](../../../php/countSource725.php) and here is a windows [executable](../../../php/count725Win.php)
* RAxML v7.2.4(alpha) available for download [here](../../../php/countSource724.php)
* RAxML v7.2.3 (alpha) available for download [here](../../../php/countSource723.php)
* RAxML v7.2.2 available for download [here](../../../php/countSource722.php) and [download windows executable](../../../php/countWin722.php)
* RAxML v7.2.1 (alpha) available for download [here](../../../php/countSource721.php) windows executable [here](../../../php/countWin721.php)
* RAxML v7.2.0 (alpha) available for download [here](../../../php/countSource720.php)
* RAxML v7.1.0 (alpha) available for download [here](../../../php/countSource.php)
* RAxML v7.0.4 available for download [here](../../../php/count704.php)
* RAxML v7.0.3 available for download [here](../../../php/r703-source.php)

+ [Windows executable.](../../../php/countWin703.php) Graham
  Jones has provided a nice [PDF](../../../resource/doc/runRAXML.PDF)
  on How to run RAxML under XP and Vista.
+ [Mac executable](../../../php/countIMAC.php) (iMAC)
+ [Mac executable](../../../php/countIMACP.php) (iMAC
  Pthreads-version)
+ [Mac executable](../../../php/countMACG5.php) (PowerMac G5)
+ [Mac executable](../../../php/countMACG5P.php) (PowerMac G5
  Pthreads-version)

* [RAxML-VI-HPC (version 2.2.3)](../../../php/countSource223.php)and a comprehensive [Manual (v2.2.3)](../../../php/countManual223.php)* [RAxML-VI-HPC (version
    2.0.2)](../../../resource/download/oldPage/RAxML-VI-HPC-2.0.tar.gz) and a comprehensive [Manual
    (v2.0)](../../../resource/download/oldPage/RAxML-MANUAL.2.0.pdf)
  * [RAxML-VI-HPC (version
    1.0)](../../../resource/download/oldPage/RAxML-VI-HPC-1.0.tar.gz) and a comprehensive [Manual
    (v1.0)](../../../resource/download/oldPage/RAxML-MANUAL.pdf)
  * [RAxML-VI:](../../../resource/download/oldPage/RAxML-VI-Version-1.0.tar.gz)
    Sequential program with significantly accelerated hill-climbing search
    algorithm for huge alignment data.
  * [RAxML-III:](../../../resource/download/oldPage/RAXML_III_RELEASE.TGZ)
    Sequential program, includes more models of nucleotide substitution
    than RAxML-II.
  * [RAxML-II:](../../../resource/download/oldPage/RAXML_II_RELEASE.TGZ) Sequential,
    Parallel, and Distributed implementation of RAxML with less model
    functionality.

#### On-line material for some old RAxML papers

Material (alignments) for 2008 Systematic
Biology paper on the rapid bootstrap algorithm

* test datasets available [here](../../../resource/download/data/RapidBS-DATA.tar.bz2)

Material (test datasets) for 2007 Supercomputing paper on parallelizing
RAxML on the IBM BlueGene/L

* test datasets available [here](../../../resource/download/oldPage/datasets.tar.bz2)

Material for HICOMB2006
paper: "Phylogenetic Models of Rate Heterogeneity: A High Performance
Computing Perspective"

* Click [here](../../../resource/download/oldPage/raw_data.txt) for a table with the experimental raw
  data

**Material for
HPCC05 paper: “Parallel Divide-and-Conquer Phylogeny Reconstruction by
Maximum Likelihood”**

* [Initial and final optimization
  phase of RAxML for an alignment with 150 sequences](../../../resource/download/oldPage/150.jpg)
* [Program Flow of
  P-Rec-I-DCM-3(RAxML)](../../../resource/download/oldPage/flow.jpg)
* [Speedup value: Time to
  complete one iteration of P-Rec-I-DCM3 for datasets 1-5 and 1 up to 16
  processors](../../../resource/download/oldPage/speedup.jpg)

Material
on RAxML-VI performance:

* 1,000 taxa [plot](../../../resource/download/oldPage/1000.png) [alignment](../../../resource/download/oldPage/1000_ARB) Alignment of 1,000 sequences
  from the ARB database containing Eucarya, Bacteria, Archaea by Harald
  Meier, TU München![](chrome://editor/content/images/tag-comment.gif)
* 1,497 taxa [plot](../../../resource/download/oldPage/1497.png) Alignment
  of 1,497 Bacteria by Josh Wilcox, Pace Lab, University of Colorado at
  Boulder, for more information on this alignment please contact the [Pace Lab](http://pacelab.colorado.edu/)
* 1,663 taxa [plot](../../../resource/download/oldPage/1663.png) [alignment](../../../resource/download/oldPage/1663_ARB) Alignment of 1,663 sequences
  from the ARB database containing Eucarya, Bacteria, Archaea by Harald
  Meier, TU München
* 1,728 taxa [plot](../../../resource/download/oldPage/1728.pn