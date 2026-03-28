# LoRDEC 0.6 - README file

## 1 Overview

Program for correcting sequencing errors in PacBio reads using highly accurate short reads (e.g. Illumina).

## 2 Reference

L. Salmela, and E. Rivals. LoRDEC: accurate and efficient long read error correction. Bioinformatics 30(24):3506-3514, 2014.

Access: <http://bioinformatics.oxfordjournals.org/content/30/24/3506>

## 3 System Requirements

LoRDEC has been tested on Linux. Compiling the program requires gcc version 4.5 or newer, Boost C++ libraries (e.g. libboost1.48-dev package or newer), and GATB Core library.

## 4 Installation

1. Unpack LoRDEC-0.6.tar.gz.
2. cd LoRDEC-0.6
3. Download the GATB Core library from <http://gatb-core.gforge.inria.fr/>. LoRDEC has been tested with GATB Core 1.0.6. Either download the binary version or follow the instructions to build the GATB Core library from the sources.
   * for linux systems type: make installdep
4. Modify the GATB variable in Makefile in the LoRDEC-0.6 directory to point to your installation of GATB Core library.
5. Run make in directory LoRDEC-0.6.

## 5 Usage

### 5.1 Error correction:

lordec-correct [parameters]

Required parameters:
-2, –shortreads=<short read FASTA/Q files or prebuilt DBG file without .h5 extension>
-i, –longreads=<long read FASTA/Q file>
-k, –kmerlen=<k-mer size>
-o, –correctedreadfile=<output file for corrected long reads>
-s, –solidthreshold=<solidity abundance threshold for k-mers>

Optional parameters:
-t, –trials=<number of target k-mers> Default: 5
-b, –branch=<maximum number of branches to explore> Default: 200
-e, –errorrate=<maximum error rate> Default: 0.4
-T, –threads=<number of threads> Default: use all cores
-S, –statfile=<path statistics file> Default: not generated

The input FASTA/Q files can be compressed. Several Illumina files can be specified as a comma seprated list (e.g. reads1.fa,reads2.fq,reads3.fq.gz).

LoRDEC outputs the corrected reads to the given file in FASTA format. The regions that remain weak after the correction are outputted in lower case characters and the solid regions are outputted in upper case characters.

### 5.2 Trimming corrected reads

To trim the weak regions from the beginning and end of the corrected reads:

lordec-trim -i <corrected reads file> -o <trimmed reads file>

To trim all weak regions and split the reads on inner weak regions:

lordec-trim-split -i <corrected reads file> -o <trimmed reads file>

The read names of the trimmed and split reads consists of two parts separated by an underscore. The first part is the name of the original read and the second part is a running index of the extracted solid regions from that read.

### 5.3 Statistics:

To generate statistics on solid and weak k-mers:

lordec-stat -2 <Short read FASTA/Q file> -k <k-mer size> -s <solid k-mer threshold> -i <PacBio FASTA/Q file> -S <output stat file> [-T <number of threads>]

The format of the output statistics file is as follows. There is one line for each read with the following information:

1. nb of solid k-mers in the read
2. nb of k-mers in the read
3. nb of starting weak k-mers i.e. length of the weak head (-1 if no solid k-mers at all)
4. nb of weak k-mers in the tail i.e. length of the weak tail
5. list of the lengths of solid k-mers runs

### 5.4 Statistics on paths

LoRDEC can generate statistics on the explored paths while correcting reads. To turn on the path statistics run LoRDEC with an additional parameter, -s, –statfile=<path statistics file>.

Be warned that the path statistics file can be huge when running LoRDEC on large data sets. The format of the file is as follows. The lines with format solid[i]=<position> tell the position of the source solid k-mer. If running LoRDEC with only one thread the following lines will be for paths with that k-mer as source. If more threads are used, the lines are interleaved in a random fashion. For each path a line with 5 fields is outputted:

1. expected path length as the difference between the source and target k-mer in the read
2. status of path search:
   0: path was found and the source and tarket k-mers do not belong to the same run of solid k-mers
   1: path was found and the source and target k-mers belong to the same run of solid k-mers
   2: the expected path length is too long, skipped
   3: the search branched too much, stop;
   4: no path was found
3. length of the found path
4. edit distance between the path and the weak region in the read
5. type of path searched for
   END2END: from one kmer to another
   TAIL: head or tail of read
   GAPEXTEND: extension of gap up to half its length

### 5.5 Build and save the de Bruijn Graph

To correct long reads or to generate k-mer statistics, LoRDEC builds a de Bruijn Graph from the short reads file. This program allows to build and save the graph in a file before doing such analyses, and then to load the graph file instead of computing it from the short read file. This saves time if you reuse the graph several times. The graph is saved in [Hierarchical Data Format](http://fr.wikipedia.org/wiki/Hierarchical_Data_Format) (HDF5: version 5).

lordec-build-SR-graph [-T <number of threads>] -2 <FASTA file> -k <k-mer size> -s <solid k-mer threshold> -g <out graph file

reads the <FASTA file> of short reads, then builds and save their de Bruijn graph for k-mers of length <k-mer size> and occurring at least <solid k-mer threshold> time

## 6 Examples

Below, we provide simple examples of command lines for running the programs of this package.

### 6.1 Error correction

lordec-correct -2 illumina.fasta -k 19 -s 3 -i pacbio.fasta -o pacbio-corrected.fasta

* Error correction with several short read files
  + One PacBio file: pacbio-mini.fa
  + Two Illumina files: ill-test-5K-1.fa and ill-test-5K-2.fa
  + command for correcting the PacBio file using the two files of Illumina reads:

  lordec-correct -2 ill-test-5K-1.fa,ill-test-5K-2.fa -k 19 -s 3 -i pacbio-mini.fa -o my-corrected-pacbio-reads.fa &> mylog.log

  + the "&> mylog.log" at the end, redirect the standard error to a log file and avoids long message to appear on the screen.

### 6.2 Trimming

lordec-trim -i pacbio-corrected.fasta -o pacbio-corrected-trim.fasta

lordec-trim-split -i pacbio-corrected.fasta -o pacbio-corrected-trim-split.fasta

### 6.3 Statistics

lordec-stat -2 illumina.fasta -k 19 -s 3 -i pacbio-corrected.fasta -S pacbio-corrected-stats.txt

### 6.4 Graph building

lordec-build-SR-graph -2 illumina.fasta -k 19 -s 3 -g illumina-19-3.h5

## 7 Changes

### 7.1 Version 0.5

1. LoRDEC works with the last version of GATB-core (gatb-core-1.0.6-Linux): adaptation to the last interface of GATB for building the graph and reading files of sequences.
2. Commands lordec-correct, lordec-stat, and lordec-build-SR-graph accepts as input for short reads a file which contains a list of filenames containing reads.
3. A target named "installdep" was added to the Makefile to install the last GATB-core version before compiling LoRDEC.

### 7.2 Version 0.4.1

Fixed a bug which can cause overflow of stack allocated memory.

### 7.3 Version 0.4

Allowing multiple Illumina files: Multiple short read files can now be given as a comma-separated list.

By default GATB 1.0.5 is used. If you wish to link against older GATB use the compiler flag -DOLDGATB.

### 7.4 Version 0.3

Options have changed and they are now parsed with getopt.

Generating path statistics no longer requires recompiling.

Maximum read length increased to 500000.

Clarfied usage for prebuilding DBG.

### 7.5 Version 0.2

The code is compatible with GATB Core 1.0.4.

Date: 2015-03-05 16:00:38 CET

Author: Leena Salmela (leena.salmela@cs.helsinki), Eric Rivals (rivals@lirmm.fr)

Org version 7.8.02 with Emacs version 23

[Validate XHTML 1.0](http://validator.w3.org/check?uri=referer)