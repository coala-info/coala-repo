# MUMmer

* [Home](../index.html)
* [Manual](../manual/manual.html)
* [Installation](../install/install.html)
* [Tutorials](../tutorial/tutorial.html)
* [Downloads](https://github.com/mummer4/mummer/releases)

# Description

MUMmer is a system for rapidly aligning entire genomes. The current version (release 4.x) can find all 20 base pair maximal exact matches between two bacterial genomes of ~5 million base pairs each in 20 seconds, using 90 MB of memory, on a typical 1.8 GHz Linux desktop computer. MUMmer can also align incomplete genomes; it handles the 100s or 1000s of contigs from a shotgun sequencing project with ease, and will align them to another set of contigs or a genome, using the nucmer utility included with the system. The promer utility takes this a step further by generating alignments based upon the six-frame translations of both input sequences. Promer permits the alignment of genomes for which the proteins are similar but the DNA sequence is too divergent to detect similarity. See the nucmer and promer readme files in the "docs/" subdirectory for more details. MUMmer is open source, so all we ask is that you cite our most recent paper in any publications that use this system:

#### Version 3.0

Open source MUMmer 3.0 is described in "[Versatile and open software for comparing large genomes](../publications/MUMmer3.pdf)." S. Kurtz, A. Phillippy, A.L. Delcher, M. Smoot, M. Shumway, C. Antonescu, and S.L. Salzberg, *Genome Biology* (2004), 5:R12.

#### Version 2.1

MUMmer 2.1, NUCmer, and PROmer are described in "[Fast Algorithms for Large-scale Genome Alignment and Comparision](../publications/MUMmer2.pdf)." A.L. Delcher, A. Phillippy, J. Carlton, and S.L. Salzberg, *Nucleic Acids Research* (2002), Vol. 30, No. 11 2478-2483.

#### Version 1.0

MUMmer 1.0 is described in "[Alignment of Whole Genomes](../publications/MUMmer.pdf)." A.L. Delcher, S. Kasif, R.D. Fleischmann, J. Peterson, O. White, and S.L. Salzberg, *Nucleic Acids Research*, 27:11 (1999), 2369-2376.

# Running MUMmer4.x

MUMmer4.x is comprised of many various utilities and scripts. For general purposes, the programs nucmer, and promer will be all that is needed. See their descriptions in the "RUNNING THE MUMmer PROGRAMS" section, or refer to their individual documentation in the "docs/" subdirectory. Refer to the "RUNNING THE MUMmer UTILITIES" section for a brief description of all of the utilities in this directory.

### Simple use case

Given a file containing a single reference sequence (ref.seq) in FASTA format and another file containing multiple sequences in FastA format (qry.seq) type the following at the command line:
./nucmer -p &ltprefix> ref.seq qry.seq
To produce the following files:
&ltprefix&gt.delta
Please read the utility-specific documentation in the "docs/" subdirectory for descriptions of these files and information on how to change the alignment parameters for the scripts (minimum match length, etc.), or see the notes below in the "RUNNING THE MUMmer SCRIPTS" section for a brief explanation.
To see a simple gnuplot output, if you have gnuplot installed, run the perl script mummerplot on the output files. This script can be run on mummer output (.out), or nucmer/promer output (.delta). Edit the &ltprefix&gt.gp file that is created to change colors, line thicknesses, etc. or explore the \&ltprefix&gt.[fr]plot file to see the data collection.
./mummerplot -p &ltprefix> &ltprefix&gt.out

# Running the MUMmer Scripts

Because of MUMmer's modular design, it may be necessary to use a number of separate programs to produce the desired output. The MUMmer scripts attempt to simplify this process by wrapping various utilities into packages that can perform standard alignment requests. Listed below are brief descriptions and usage definitions for these scripts. Please refer to the "docs/" subdirectory for a more detailed description of each script.

### nucmer

#### Description:

nucmer is for the all-vs-all comparison of nucleotide sequences contained in multi-FastA data files. It is best used for highly similar sequence that may have large rearrangements. Common use cases are: comparing two unfinished shotgun sequencing assemblies, mapping an unfinished sequencing assembly to a finished genome, and comparing two fairly similar genomes that may have large rearrangements and duplications. Please refer to "docs/nucmer.README" for more information regarding this script and its output, or type nucmer -h for a list of its options.

USAGE:
nucmer [options] &ltreference> &ltquery>
[options] type 'nucmer -h' for a list of options.
&ltreference> specifies the multi-FastA sequence file that contains
the reference sequences, to be aligned with the queries.
&ltquery> specifies the multi-FastA sequence file that contains
the query sequences, to be aligned with the references.
OUTPUT:
out.delta the delta encoded alignments between the reference and
query sequences. This file can be parsed with any of
the show-\* programs which are described in the "RUNNING
THE MUMmer UTILITIES" section.

#### Notes:

All output coordinates reference the forward strand of the involved sequence, regardless of the match direction. Also, nucmer now uses only matches that are unique in the reference sequence by default, use the '--mum' or '--maxmatch' options to change this behavior.

### promer

#### Description:

promer is for the protein level, all-vs-all comparison of nucleotide sequences contained in multi-FastA data files. The nucleotide input files are translated in all 6 reading frames and then aligned to one another via the same methods as nucmer. It is best used for highly divergent sequences that may have moderate to high similarity on the protein level. Common use cases are: identifying syntenic regions between highly divergent genomes, comparative genome annotation i.e. using an already annotated genome to help in the annotation of a newly sequenced genome, and the general comparison of two fairly divergent genomes that have large rearrangements and may only be similar on the protein level. Please refer to "docs/promer.README" for more information regarding this script and its output, or type promer -h for a list of its options.

USAGE:
promer [options] &ltreference> &ltquery>
[options] type 'promer -h' for a list of options.
&ltreference> specifies the multi-FastA sequence file that contains
the reference sequences, to be aligned with the queries.
&ltquery> specifies the multi-FastA sequence file that contains
the query sequences, to be aligned with the references.
OUTPUT:
out.delta the delta encoded alignments between the reference and
query sequences. This file can be parsed with any of
the show-\* programs which are described in the "RUNNING
THE MUMmer UTILITIES" section.

#### Notes:

All output coordinates reference the forward strand of the involved sequence, regardless of the match direction, and are measured in nucleotides with the exception of the delta integers which are measured in amino acids (1 delta int = 3 nucleotides). Also, promer now uses only matches that are unique in the reference sequence by default, use the '--mum' or '--maxmatch' options to change this behavior.

#### Notes:

All output coordinates reference their respective strand. This means that for all reverse matches, the coordinates that reference the query sequence will be relative to the reverse complement of the query sequence. Please use nucmer or promer if this coordinate system is confusing.

### dnadiff

#### Description:

This script is a wrapper around nucmer that builds an alignment using default parameters, and runs many of nucmer's helper scripts to process the output and report alignment statistics, SNPs, breakpoints, etc. It is designed for evaluating the sequence and structural similarity of two highly similar sequence sets. E.g. comparing two different assemblies of the same organism, or comparing two strains of the same species. Please refer to "docs/dnadiff.README" for more information regarding this script and its output, or type 'dnadiff -h' for a list of its options.

USAGE: dnadiff [options] &ltreference> &ltquery>
or dnadiff [options] -d &ltdelta file>
&ltreference> Set the input reference multi-FASTA filename
&ltquery> Set the input query multi-FASTA filename
or
&ltdelta file> Unfiltered .delta alignment file from nucmer
OUTPUT:
.report - Summary of alignments, differences and SNPs
.delta - Standard nucmer alignment output
.1delta - 1-to-1 alignment from delta-filter -1
.mdelta - M-to-M alignment from delta-filter -m
.1coords - 1-to-1 coordinates from show-coords -THrcl .1delta
.mcoords - M-to-M coordinates from show-coords -THrcl .mdelta
.snps - SNPs from show-snps -rlTHC .1delta
.rdiff - Classified ref breakpoints from show-diff -rH .mdelta
.qdiff - Classified qry breakpoints from show-diff -qH .mdelta
.unref - Unaligned reference IDs and lengths (if applicable)
.unqry - Unaligned query IDs and lengths (if applicable)

#### Notes:

The report file generated by this script can be useful for comparing the differences between two similar genomes or assemblies. The other outputs generated by this script are in unlabeled tabular format, so please refer to the utility specific documentation for interpreting them. A full description of the report file is given in "docs/dnadiff.README".

# Running the MUMmer Utilities

The MUMmer package consists of various utilities that can interact with the mummer program. mummer performs all maximal and maximal unique matching, and all other utilities were designed to process the input and output of this program and its related scripts, in order to extract additional information from the output. Listed below are the descriptions and usage definitions for these utilities.

### annotate

#### Description

This program reads the output of the gaps program and adds alignment information to it. Part of the original MUMmer1.0 pipeline and can only be used on the output of the gaps program.

USAGE:
annotate &ltgapsfile> &ltseq2>
&ltgapsfile> the output of the 'gaps' program.
&ltseq2> the file containing the second sequence in the comparison.
OUTPUT:
stdout the 'gaps' output interspersed with the alignments of
the gaps between adjacent MUMs. An alignment of a
gap comes after the second MUM defining the gap, and
alignment errors are marked with a '^' character.
witherrors.gaps the 'gaps' output with an appended column that lists
the number of alignment errors for each gap.

#### Notes

This program will eventually be dropped in favor of the combineMUMs or nucmer match extenders, but persists for the time being.

### combineMUMs

#### Description

This program reads the output of the mgaps program and adds alignment information to it. Part of the MUMmer4.x pipeline and can only be used on the output of the mgaps program. This -D option alters this behavior and only outputs the positions of difference, e.g. SNPs.

USAGE:
combineMUMs [options] &ltreference> &ltquery> &ltmgapsfile>
[options] type 'combineMUMs -h' for a list of options.
&ltreference> the FastA reference file used in the comparison.
&ltquery> the multi-FastA reference file used in the comparison.
&ltmgapsfile> the output of the 'mgaps' program run on the match
list produced by 'mummer' for the reference and query
files.
OUTPUT:
stdout the 'mgaps' output interspersed with the alignments
of the gaps between adjacent MUMs. An alignment of a
gap comes after the second MUM defining the gap, and
alignment errors are marked with a '^' character. At
the end of each cluster is a summary line (keyword
"Region") noting the bounds of the cluster in the
reference and query sequences, the total number of
errors for the region, the length of the region and
the percent error of the region.
witherrors.gaps the 'mgaps' output with an appended column that lists
the number of alignment errors for each gap.

### delta-filter

#### Description

This program filters a delta alignment file produced by either nucmer or promer, leaving only the desired alignments which are output to stdout in the same delta format as the input. Its primary function is the LIS algorithm which calculates the longest increasing subset of alignments. This allows for the calculation of a global set of alignments (i.e. 1-to-1 and mutually consistent order) with the -g option or locally consistent with -1 or -m. Reference sequences can be mapped to query sequences with -r, or queries to references with -q. This allows the user to exclude chance and repeat induced alignments, leaving only the "best" alignments between the two data sets. Filtering can also be performed on length, identity, and uniquenes.

USAGE:
delta-filter [options] &ltdeltafile>
[options] type 'delta-filter -h' for a list of options.
&ltdeltafile> the .delta output file from either nucmer or promer.
OUTPUT:
stdout The same delta alignment format as output by nucmer and promer.

#### Notes

For most cases the -m option is recommended, however -1 is useful for applications that require a 1-to-1 mapping, such as SNP finding. Use the -q option for mapping query contigs to their best reference location.

### exact-tandems

#### Description

This script finds exact tandem repeats in a specified FastA sequence file. It is a post-processor for repeat-match and provides a simple interface and output for tandem repeat detection.

USAGE:
exact-tandems &ltfile> &ltmin match>
&ltfile> the single sequence in FastA format to search for repeats.
&ltmin match> the minimum match length for the tandems.
OUTPUT:
stdout 4 columns, the start of the tandem repeat, the total extent
of the repeat region, the length of each repetitive unit, and
to total copies of the repetitive unit involved.

### mgaps

#### Description

This program reads a list of matches between a single-FastA reference and a multi-FastA query file and outputs clusters of matches that lie on similar diagonals and within a reasonable distance. Part of the MUMmer4.x pipeline and the output of mummer need not be processed before passing it to this program, so long as mummer was run on a 1-vs-many or 1-vs-1 dataset.

USAGE:
mgaps [options] < &ltmatchlist>
[options] type 'mgaps -h' for a list of options.
&ltmatchlist> A list of matches separated by their sequence FastA tags.
The columns of the match list should be start in
reference, start in query, and length of the match.
OUTPUT:
stdout An ordered set of the input matches, separated by headers.
Individual clusters are separated by a '#' character and
sets of clusters from different sequences are separated by
the FastA header tag for the query sequence.

#### Notes

It is often very helpful to adjust the clustering parameters. Check mgaps -h for the list of parameters and check the source for a better idea of how each parameter affects the result. Often, it is helpful to run this program a number of times with different parameters until the desired result is achieved.

### mummer

#### Description

This is the core program of the MUMmer package. It 