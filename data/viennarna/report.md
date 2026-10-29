# viennarna CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| viennarna_AnalyseDists | PASS |  |
| viennarna_AnalyseSeqs | PASS |  |
| viennarna_Kinfold | PASS |  |
| viennarna_RNA2Dfold | PASS |  |
| viennarna_RNALalifold | PASS |  |
| viennarna_RNALfold | PASS |  |
| viennarna_RNAPKplex | PASS |  |
| viennarna_RNAaliduplex | PASS |  |
| viennarna_RNAalifold | PASS |  |
| viennarna_RNAcofold | PASS |  |
| viennarna_RNAconsensus_hardcons | PASS |  |
| viennarna_RNAdistance | PASS |  |
| viennarna_RNAdos | PASS |  |
| viennarna_RNAduplex | PASS |  |
| viennarna_RNAeval | PASS |  |
| viennarna_RNAfold | PASS |  |
| viennarna_RNAforester | PASS |  |
| viennarna_RNAheat | PASS |  |
| viennarna_RNAinverse | PASS |  |
| viennarna_RNAlocmin | PASS |  |
| viennarna_RNAmultifold | PASS |  |
| viennarna_RNApaln | Failed | tool bug: without -B (--printAlignment) the score printed for every pair is -9999, even for two identical sequences; with -B the score is correct |
| viennarna_RNAparconv | PASS | --dump mode only (writes the built-in Vienna 1.8.4 parameters in 2.0 format); the conversion of an old parameter file was not tested (no Vienna 1.8.4 parameter file available) |
| viennarna_RNApdist | PASS |  |
| viennarna_RNAplex | PASS |  |
| viennarna_RNAplfold | PASS |  |
| viennarna_RNAplot | PASS |  |
| viennarna_RNApvmin | PASS |  |
| viennarna_RNAsnoop | PASS |  |
| viennarna_RNAsubopt | PASS |  |
| viennarna_RNAup | PASS |  |
| viennarna_b2ct | PASS |  |
| viennarna_b2mt | PASS |  |
| viennarna_coloraln | PASS |  |
| viennarna_ct2db | PASS |  |
| viennarna_dpzoom | PASS |  |
| viennarna_kinwalker | PASS | default dangle (0) segfaults on most real sequences; ran on let-7a-1 precursor with --dangle=1 |
| viennarna_mountain | PASS |  |
| viennarna_popt | PASS |  |
| viennarna_relplot | PASS |  |
| viennarna_rotate_ss | PASS |  |

## viennarna_AnalyseDists

### Tool Description
Analyse a distance matrix. Reads a distance matrix (lower triangle) from standard input and writes a split decomposition and a cluster analysis (Ward and neighbour joining) of it.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
ANALYSEDISTS 1
NAME
AnalyseDists - Analyse a distance matrix 
SYNOPSIS
AnalyseDists [-X[swn]]
DESCRIPTION
AnalyseDists
reads a distance matrix (given as lower triangle matrix)
from stdin and writes a split decomposition and a cluster 
analysis of this distance matrix to stdout.
The line before the distance matrix must be of the form
> Y x [comments]
where 'x' gives the number of taxa, 'Y' is a single character that
indicates the type of distance and 'comment' is an arbitrary comment.
This matches the output format of, e.g., RNAdistance. 
The input data file may contain arbitrary lines before and after the 
distance matrix. All lines beginning with '> ' that are not of the 
above form are written to stdout. The program continues reading
until it encounters an EOF condition or the terminator character '@'.
A list of taxa names can be specified in the input stream. The list 
must begin with a line of the form
* [fname]
if fname is present, it will be used to name the postscript output files.
The entries have the form 'x : Taxon',
where x is the number of taxon, i.e., the corresponding row and column
of the distance matrix. The taxa list need not be complete. It must
end however with a line beginning with '*' or any of the separator
characters. The taxa list is printed on top of the output.
OPTIONS
-X[swn]
specifies the analysis methods to be used. 
[s] 
Split decomposition.
[w] 
Cluster analysis using Ward's method. A PostScript file named '[fname_]wards.ps'
is created containing a drawing of the tree.
[n]
Cluster analysis using Saitou's neighbour joining method.
A PostScript file named '[fname_]nj.ps' is created containing a drawing of the tree.
REFERENCES
```

## viennarna_AnalyseSeqs

### Tool Description
Analyse a set of sequences of common length. Reads sequences from standard input and runs statistical geometry, split decomposition, neighbour joining and Ward's method on them.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
ANALYSESEQS 1
NAME
AnalyseSeqs - Analyse a set of sequences of common length 
SYNOPSIS
AnalyseSeqs [-X[bswn]] [-Q] [-M{mask}[+|!]] [-D{H|A|G}] [-d{S|H|D|B}]
DESCRIPTION
AnalyseSeqs
reads a set of sequences from stdin and tries a variety of methods
for sequence analysis on them. Currently available are:
Statistical geometry for quadruples of sequences; THIS IS 
PRELIMINARY AND NOT WELL TESTED BY NOW.
split decomposition;
neighbour joining and Ward's variance method for reconstructing
phylogenies using various distance measures. 
For statistical geometry and the cluster methods PostScript output
is available.
The program continues reading until it encounters one of the
separator characters '@' or '%'. Only sequences of alphabetical
characters or of a specified alphabet are processed, all other
lines are ignored. The program stops reading
if it either encounters an EOF condition, or if there are no
valid sequence data between two lines beginning with separator
characters. 
A list of taxa names can be specified in the input stream. The list 
begins with a line beginning with '*'. Optionally, a file name prefix
[fn] for the PostScript output can be specified in this line.
The entries have the form 'x : Taxon',
where x is the number of taxon, i.e., of the corresponding entry in 
the list of input sequences. The taxa list need not be complete. It must
end, however, with a line beginning with '*' or any of the separator
characters. The taxa list is printed on top of the output. The specified
taxa names are used as labels in the PostScript output. 
OPTIONS
-X[bswn]
specifies the analysis methods to be used. 
[b] 
Statistical Geometry. A PostScript file named '[fn_]box.ps' giving a 
graphical representation of the statistical geometry is created. The
resulting box is a good measure of 'tree likeness' of the data set.
This is the default.
[s] 
Split decomposition. 
[w] 
Cluster analysis using Ward's method. A PostScript file named '[fn_]wards.ps' 
is created containing a drawing of the tree. 
[n]
Cluster analysis using Saitou's neighbour joining method. A PostScript 
file named '[fn_]nj.ps' is created containing a drawing of the tree. 
-Q
indicates that a statistical geometry analysis is to be performed
comparing four data sets, for instance to confirm the significance of
a proposed phylogeny. This option is only useful for statistical
geometry analysis and hence the -X option is ignored. Each of the 
four data sets must be of the form
* [filename_prefix]
# number
[list of taxa names]
*
list of sequences 
%
where number is 1,2,3,4 for the four groups to be compared.
-M{mask}[+|!]
allows one to specify a mask for the input file. '{mask}' can be one 
of the following letters indicating a predefined alphabet or 
the %-sign followed by all characters to be accepted. A + sign
at the very end of the mask indicates that the input is to be 
handled case sensitive. Default is conversion of the input to
upper case. A ! sign can be used to convert the input data to 
RY code: GgAaXx -> R, UuCcKkTt -> Y, all other letters are 
converted to *.  
-Ma 
all letters A-Z and a-z.
-Mu 
uppercase letters.
-Ml
```

## viennarna_b2ct

### Tool Description
Convert RNA secondary structures in dot-bracket notation (extended FASTA, as written by RNAfold) to Zuker connectivity table (.ct) format.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
b2ct: convert RNA secondary structures in dot-bracket notation to Zuker connectivity table (.ct) format.
The program has no help text. It reads an extended FASTA record (header, sequence, dot-bracket structure; for example RNAfold output)
from standard input and writes the connectivity table to standard output.
```

## viennarna_popt

### Tool Description
Apply a p-optimal filter to RNAsubopt output: reads the output of RNAsubopt -s from standard input and keeps the p-optimal structures.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
p-optimal filter to subopt output. usage:
RNAsubopt -s < seq | popt
```

## viennarna_kinwalker

### Tool Description
Predict RNA folding trajectories during transcription. Reads one RNA sequence from standard input and prints the intermediate structures of the predicted folding trajectory with first passage times and energy barriers.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kinwalker [OPTIONS] < SeqFile  > Outfile
Options without argument:
 -h, --help          Print usage information for kinwalker.
--init_structure     Start with a structure other than the open chain.
--interrupt          Allow interrupted folding trajectories when the barrier is exceeded.
--printfront.        Creates PS plots of front progression with index i, named front_trajectory($i).ps.
 -t, --test          Use test sequence.
 -v, --verbose       Verbose mode. Print debugging messages about program progress.

Options with argument:
--barrier_heuristic  'M' Morgan-Higgs,'S' limits small stacks,'B' Barriers,'A' all, then take minimum. Default: >M<
--dangle             Dangle value of 0,1,2 as in the ViennaRNA package. Default: >0<
--grouping           How barrier_heuristic 'M' treats conflict groups("standard" or "regroup"). Default: >standard<
--lookahead          #BP that MorganHiggs forms its subpaths from. Default: >1<
--maxkeep            Breadth of breadth first seerch in barrier_heuristic='B'. Default: >1<
--nolonely           Value of noLonelyPairs as in ViennaRNA. Default: >2<
--transcribed        #bases initially transcribed, <0 means all is transcribed. Default: >1<)
--transcription_rate #bases transcribed per second. Default: >200.000000<)
--windowsize         Max size of substructures considered for folding events during transcription, 0= all are considered. Default: >0<)
```

## viennarna_RNAforester

### Tool Description
Compare RNA secondary structures via forest alignment: pairwise or multiple alignment, structure prediction from alignment, profile search.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAforester [options]
--help                    shows this help info
--version                 shows version information
-f=file                   read input from file
--score                   compute only scores, no alignment
--noscale                 suppress output of scale
--tables                  shows dynamic programming tables
--backtrace               shows backtrace call table cells
-t                        calculate alignment top down instead of bottom up
-d                        calculate distance instead of similarity
-r                        calculate relative score
-l                        local similarity
-so=int                   local suboptimal alignments within int%
-s                        small-in-large similarity
--anchor                  use shape anchoring for speedup
-a                        affine gap scoring
-m                        multiple alignment mode
--RIBOSUM                 RIBOSUM85-60 scoring matrix (base-pair substitutions)
-cbmin=double             minimum base frequency for consensus structure
-cmin=double              minimum basepair frequency for consensus structure
-mt=double                clustering threshold
-mc=double                clustering cutoff
-p                        predict structures from sequences
-pmin=double              minimum basepair frequency for prediction
-sp=file                  save profile
-ps=file                  profile search
-pm=int                   basepair(bond) match score
-pd=int                   basepair bond indel score
-pdo=int                  basepair bond indel open score
-bm=int                   base match score
-br=int                   base mismatch score
-bd=int                   base indel score
-bdo=int                  base indel open score
-2d                       generate alignment 2D plots in postscript format
--2d_hidebasenum          hide base numbers in 2D plot
--2d_basenuminterval=n    show every n-th base number
--2d_grey                 use only grey colors in 2D plots
--2d_scale=double         scale factor for the 2d plots
--2d_fig                  generate additional fig file of 2d plot
--fasta                   generate fasta output of alignments
```

## viennarna_RNAconsensus_hardcons

### Tool Description
Read a multiple sequence alignment and a consensus structure (RNAalifold output or dot plot) and write, for each sequence, name, sequence and a constraint structure suitable for piping into RNAfold -C (legacy refold.pl mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: RNAconsensus hardcons [-h] [-a filename] [-o OUTPUT] [--turn TURN] [-r]
                             [--enforce] [-f ALIFOLD_OUTPUT] [-d filename]
                             [-t THRESHOLD]
                             [alignment_file] [structure_file]

In this mode, the program reads a multiple sequence alignment and a consensus
secondary structure, either in the form of the standard output of RNAalifold,
or in the form of a dot plot as produced by RNAalifold -p. For each sequence
in the alignment it writes the name, sequence, and constraint structure to
stdout in a format suitable for piping into RNAfold -C. The constraint string
is produced by removing from the consensus structure all gaps, as well as all
pairs not compatible with the particular sequence. If the structure is read
from a dot plot file, only pairs with probability larger than some threshold
(default 0.9) are used.

positional arguments:
  alignment_file        The multiple sequence alignment file name if not
                        specified by -a
  structure_file        The RNAalifold output or dot plot file name

options:
  -h, --help            show this help message and exit
  -a filename, --alignment filename
                        A multiple sequence alignment file name
  -o OUTPUT, --output OUTPUT
                        A file or directory where to store the output
  --turn TURN           Minimum hairpin length
  -r, --run             Run the predictions instead of producing output that
                        can be used with RNAFold
  --enforce             Enforce the structure constraint for single sequence
                        predictions

Consensus MFE:
  Map the consensus MFE structure as predicted by RNAalifold to each
  sequence in the input alignment

  -f ALIFOLD_OUTPUT, --alifold-output ALIFOLD_OUTPUT
                        The output of RNAalifold for the input alignment

Consensus Probabilities:
  Create structure constraints for each sequence in the input alignment from
  consensus base pair probabilities as predicted by RNAalifold

  -d filename, --dotplot filename
                        The dot-plot created by RNAalifold for the input
                        alignment
  -t THRESHOLD, --threshold THRESHOLD
                        Base pair probability threshold. Take only base pairs
                        with probability larger than threshold into account
```

## viennarna_ct2db

### Tool Description
Produce dot-bracket notation of an RNA secondary structure from Zuker's .ct file (extended FASTA output).

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ct2db [OPTIONS] [<input0.ct>] [<input1.ct>]...
Produce dot bracket notation of an RNA secondary structure from Zuker's .ct
file

This program converts connectivity table (.ct) files into extended FASTA format
with dot-bracket string.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -p, --no-pk                   Remove pseudoknots from structure

                                    (default=off)
  -m, --no-modified             Do not keep modified bases, i.e. replace all
                                  non-canonical nucleotides with N.

                                    (default=off)
  -v, --verbose                 Be verbose.

                                    (default=off)
      --fasta-header=STRING     Overwrite FASTA header with user-provided
                                  string.

      --filename-suffix=STRING  The filename suffix to remove when turning the
                                  filename into a FASTA header.
                                    (default=`.ct')
```

## viennarna_Kinfold

### Tool Description
Stochastic folding simulations of single-stranded nucleic acids. Reads the sequence (and optionally start and stop structures) from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Kinfold [OPTION]...
Stochastic Folding Simulations of Single-Stranded Nucleic Acids

  -h, --help            Print help and exit
      --full-help       Print help, including hidden options, and exit
  -V, --version         Print version and exit

Energy Model:
  -d, --dangle=INT      <0|1|2> set dangling end model to (none|normal|double)
                          (possible values="0", "1", "2" default=`2')
  -T, --Temp=FLOAT      simulation temperature  (default=`37')
  -P, --Par=filename    read energy-parameter-file
      --logML           use logarithmic multiloop energies instead of linear
                          (default=on)

MoveSet:
      --noShift         turn off shift-moves  (default=off)
      --noLP            forbid structures with isolated base-pairs
                          (default=off)

Simulation:
      --seed=STRING     set random number seed specify 3 integers as
                          int=int=int  (default=`clock')
      --time=FLOAT      set maxtime of simulation  (default=`500')
      --num=INT         set number of trajectories  (default=`1')
      --start           read start structure from stdin (otherwise use open
                          chain)  (default=off)
      --stop            read stop structure(s) from stdin (otherwise use MFE)
                          (default=off)
      --met             use Metropolis rule for rates (not Kawasaki rule)
                          (default=off)
      --fpt             compute first passage time (stop when a stop-structure
                          is reached)  (default=on)
      --rect            compute recurrence time (of a start structure which is
                          contained in stop structures)  (default=off)
      --grow=FLOAT      grow chain every <float> time units  (default=`0')
      --glen=INT        initial size of growing chain  (default=`15')

Output:
      --log=filename    set basename of log-file  (default=`kinout')
  -q, --silent          no output to stdout  (default=off)
  -v, --verbose         more information to stdout  (default=off)
      --lmin            output only local minima to stdout  (default=off)
      --cut=FLOAT       only print structures with E <= MFE + <float> to stdout
                          (default=`20')
Input File Format:
  1st line sequence
  2nd line start structure (if option --start is used)
  following lines are stop structures (if option --stop is used)
```

## viennarna_RNA2Dfold

### Tool Description
Compute MFE structure, partition function and representative sample structures of k,l neighborhoods. Reads a sequence and two reference structures from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNA2Dfold [OPTION]...
Compute MFE structure, partition function and representative sample structures
of k,l neighborhoods

The program partitions the secondary structure space into (basepair)distance
classes according to two fixed reference structures. It expects a sequence and
two secondary structures in dot-bracket notation as its inputs. For each
distance class, the MFE representative, Boltzmann probabilities and Gibbs free
energy is computed. Additionally, a stochastic backtracking routine allows one
to produce samples of representative suboptimal secondary structures from each
partition



  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -j, --numThreads=INT         Set the number of threads used for calculations
                                 (only available when compiled with OpenMP
                                 support)


      --noconv                 Do not automatically substitute nucleotide "T"
                                 with "U".

                                   (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


  -p, --partfunc               calculate partition function and thus, Boltzmann
                                 probabilities and Gibbs free energy

                                   (default=off)
      --stochBT=INT            backtrack a certain number of Boltzmann samples
                                 from the appropriate k,l neighborhood(s)


      --neighborhood=<k>:<l>   backtrack structures from certain
                                 k,l-neighborhood only, can be specified
                                 multiple times (<k>:<l>,<m>:<n>,...)


  -K, --maxDist1=INT           maximum distance to first reference structure
  -L, --maxDist2=INT           maximum distance to second reference structure
      --noBT                   do not backtrack structures, calculate energy
                                 contributions only

                                   (default=off)
  -c, --circ                   Assume a circular (instead of linear) RNA
                                 molecule.

                                   (default=off)

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            How to treat "dangling end" energies for bases
                                 adjacent to helices in free ends and
                                 multi-loops
                                   (possible values="0", "2" default=`2')

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAaliduplex

### Tool Description
Predict conserved RNA-RNA interactions between two alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAaliduplex [options] <file1.aln> <file2.aln>
Predict conserved RNA-RNA interactions between two alignments

The program reads two alignments of RNA sequences in CLUSTAL format and
predicts optimal and suboptimal binding sites, hybridization energies and the
corresponding structures. The calculation takes only inter-molecular base pairs
into account, for the general case use RNAcofold. The use of alignments allows
one to focus on binding sites that are evolutionary conserved. Note, that the
two input alignments need to have equal number of sequences and the same order,
i.e. the 1st sequence in file1 will be hybridized to the 1st in file2 etc.

The computed binding sites, energies, and structures are written to stdout, one
structure per line. Each line consist of: The structure in dot bracket format
with a "&" separating the two strands. The range of the structure in the two
sequences in the format  "from,to : from,to"; the energy of duplex structure
in kcal/mol.
The format is especially useful for computing the hybrid structure between a
small probe sequence and a long target sequence.



  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -e, --deltaEnergy=range      Compute suboptimal structures with energy in a
                                 certain range of the optimum (kcal/mol).
                                 Default is calculation of mfe structure only.


  -s, --sorted                 Sort output by free energy.

                                   (default=off)

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            How to treat "dangling end" energies for bases
                                 adjacent to helices in free ends and
                                 multi-loops.
                                   (default=`2')
      --noLP                   Produce structures without lonely pairs (helices
                                 of length 1).
                                   (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAalifold

### Tool Description
Calculate secondary structures for a set of aligned RNA sequences (consensus structure).

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAalifold [options] [<input0.aln>] [<input1.aln>]...
calculate secondary structures for a set of aligned RNAs

Read aligned RNA sequences from stdin or file.aln and calculate their minimum
free energy (mfe) structure, partition function (pf) and base pairing
probability matrix. Currently, input alignments have to be in CLUSTAL,
Stockholm, FASTA, or MAF format. The input format must be set manually in
interactive mode (default is Clustal), but will be determined automagically
from the input file, if not expplicitly set. It returns the mfe structure in
bracket notation, its energy, the free energy of the thermodynamic ensemble and
the frequency of the mfe structure in the ensemble to stdout.  It also produces
Postscript files with plots of the resulting secondary structure graph
("alirna.ps") and a "dot plot" of the base pairing matrix ("alidot.ps").
The file "alifold.out" will contain a list of likely pairs sorted by
credibility, suitable for viewing  with "AliDot.pl". Be warned that output
file will overwrite any existing files of the same name.



  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)
  -q, --quiet                   Be quiet.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -f, --input-format=C|S|F|M    File format of the input multiple sequence
                                  alignment (MSA).

      --mis                     Output "most informative sequence" instead of
                                  simple consensus: For each column of the
                                  alignment output the set of nucleotides with
                                  frequency greater than average in IUPAC
                                  notation.

                                    (default=off)
  -j, --jobs[=number]           Split batch input into jobs and start
                                  processing in parallel using multiple
                                  threads. A value of 0 indicates to use as
                                  many parallel threads as computation cores
                                  are available.
                                    (default=`0')
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
  -n, --continuous-ids          Use continuous alignment ID numbering when no
                                  alignment ID can be retrieved from input
                                  data.
                                    (default=off)
      --auto-id                 Automatically generate an ID for each
                                  alignment.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`alignment')

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -p, --partfunc[=INT]          Calculate the partition function and base
                                  pairing probability matrix in addition to the
                                  mfe structure. Default is calculation of mfe
                                  structure only.
                                    (default=`1')
      --MEA[=gamma]             Compute MEA (maximum expected accuracy)
                                  structure.
                                    (default=`1.')
      --sci                     Compute the structure conservation index (SCI)
                                  for the MFE consensus structure of the
                                  alignment.

                                    (default=off)
  -c, --circ                    Assume a circular (instead of linear) RNA
                                  molecule.

                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.

                                    (default=off)
  -s, --stochBT=INT             Stochastic backtrack. Compute a certain number
                                  of random structures with a probability
                                  dependend on the partition function. See -p
                                  option in RNAsubopt.


      --stochBT_en=INT          same as -s option but also print out the
                                  energies and probabilities of the backtraced
                                  structures.


  -N, --nonRedundant            Enable non-redundant sampling strategy.

                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT           Set the maximum base pair span.

                                    (default=`-1')
  -C, --constraint[=filename]   Calculate structures subject to constraints.
                                  The constraining structure will be read from
                                  'stdin', the alignment has to be given as a
                                  file name on the command line.
                                    (default=`')
      --enforceConstraint       Enforce base pairs given by round brackets '('
                                  ')' in structure constraint.

                                    (default=off)
      --SS_cons                 Use consensus structures from Stockholm file
                                  ('#=GF SS_cons') as constraint.
                                    (default=off)
      --shape=file1,file2       Use SHAPE reactivity data to guide structure
                                  predictions.


Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)
      --cfactor=DOUBLE          Set the weight of the covariance term in the
                                  energy function

                                    (default=`1.0')
      --nfactor=DOUBLE          Set the penalty for non-compatible sequences in
                                  the covariance term of the energy function

                                    (default=`1.0')
  -E, --endgaps                 Score pairs with endgaps same as gap-gap pairs.

                                    (default=off)
  -R, --ribosum_file=ribosumfile
                                use specified Ribosum Matrix instead of normal
                                  energy model.

  -r, --ribosum_scoring         use ribosum scoring matrix.
                                    (default=off)
      --old                     use old energy evaluation, treating gaps as
                                  characters.

                                    (default=off)

Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots


      --color                   Produce a colored version of the consensus
                                  structure plot "alirna.ps" (default b&w
                                  only)

                                    (default=off)
      --aln                     Produce a colored and structure annotated
                                  alignment in PostScript format in the file
                                  "aln.ps" in the current directory.

                                    (default=off)
      --aln-stk[=prefix]        Create a multi-Stockholm formatted output file.
                                    (default=`RNAalifold_results')
      --noPS                    Do not produce postscript drawing of the mfe
                                  structure.

                                    (default=off)
      --noDP                    Do not produce dot-plot postscript file
                                  containing base pair or stack
                                  probabilitities.
                                    (default=off)
Caveats:

Sequences are not weighted. If possible, do not mix very similar and dissimilar
sequences. Duplicate sequences, for example, can distort the prediction.


If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAdistance

### Tool Description
Calculate distances between RNA secondary structures (tree edit distance, string alignment, base pair distance). Reads structures from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAdistance [OPTION]...
Calculate distances between RNA secondary structures

This program reads RNA secondary structures from stdin and calculates one or
more measures for their dissimilarity, based on tree or string editing
(alignment). In addition it calculates a "base pair distance" given by the
number of base pairs present in one structure, but not the other. For
structures of different length base pair distance is not recommended.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)
  -D, --distance=fhwcFHWCP      Specify the distance representation to be used
                                  in calculations.
                                    (default=`f')
  -X, --compare=p|m|f|c         Specify the comparison directive.
                                    (default=`p')
  -S, --shapiro                 Use the Bruce Shapiro's cost matrix for
                                  comparing coarse structures.

                                    (default=off)
  -B, --backtrack[=<filename>]  Print an "alignment" with gaps of the
                                  structures, to show matching substructures.
                                  The aligned structures are written to
                                  <filename>, if specified.
                                    (default=`none')

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAdos

### Tool Description
Calculate the density of states for each energy band of an RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAdos [OPTIONS]
Calculate the density of states for each energy band of an RNA

The program reads an RNA sequence and computes the density of states for each
energy band.



  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -s, --sequence=STRING        The RNA sequence (ACGU).

  -j, --numThreads=INT         Set the number of threads used for calculations
                                 (only available when compiled with OpenMP
                                 support)



Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


  -e, --max-energy=INT         Structures are only counted until this threshold
                                 is reached. Default is 0 kcal/mol.
                                   (default=`0')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            How to treat "dangling end" energies for bases
                                 adjacent to helices in free ends and
                                 multi-loops.
                                   (default=`2')

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAduplex

### Tool Description
Compute the structure upon hybridization of two RNA strands. Reads pairs of sequences from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAduplex [OPTION]...
Compute the structure upon hybridization of two RNA strands

reads two RNA sequences from stdin or <filename> and computes optimal and
suboptimal secondary structures for their hybridization. The calculation is
simplified by allowing only inter-molecular base pairs, for the general case
use RNAcofold.
The computed optimal and suboptimal structure are written to stdout, one
structure per line. Each line consist of: The structure in dot bracket format
with a '&' separating the two strands. The range of the structure in the two
sequences in the format  "from,to : from,to"; the energy of duplex structure
in kcal/mol.
The format is especially useful for computing the hybrid structure between a
small probe sequence and a long target sequence.


  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -s, --sorted                 Sort the printed output by free energy.

                                   (default=off)
      --noconv                 Do not automatically substitute nucleotide "T"
                                 with "U".

                                   (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -e, --deltaEnergy=range      Compute suboptimal structures with energy in a
                                 certain range of the optimum (kcal/mol).
                                 Default is calculation of mfe structure only.



Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            How to treat "dangling end" energies for bases
                                 adjacent to helices in free ends and
                                 multi-loops.
                                   (default=`2')
      --noLP                   Produce structures without lonely pairs (helices
                                 of length 1).
                                   (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAeval

### Tool Description
Evaluate free energy of RNA sequences with given secondary structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAeval [OPTIONS] [<input0>] [<input1>]...
Determine the free energy of a (consensus) secondary structure for (an
alignment of) RNA sequence(s)

Evaluates the free energy of a particular (consensus) secondary structure for
an (an alignment of) RNA molecule(s). The energy unit is kcal/mol and contains
a covariance pseudo-energy term for multiple sequence alignments (--msa option)
and corresponding consensus structures.
The program will continue to read new sequences and structures until a line
consisting of the single character '@' or an end of file condition is
encountered.
If the input sequence or structure contains the separator character '&' the
program calculates the energy of the co-folding of two RNA strands, where the
'&' marks the boundary between the two strands.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose and print out energy contribution of
                                  each loop in the structure.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --infile=filename         Read a file instead of reading from stdin.

  -a, --msa                     Input is multiple sequence alignment in
                                  Stockholm 1.0 format.
                                    (default=off)
      --mis                     Output "most informative sequence" instead of
                                  simple consensus: For each column of the
                                  alignment output the set of nucleotides with
                                  frequency greater than average in IUPAC
                                  notation.

                                    (default=off)
  -j, --jobs[=number]           Split batch input into jobs and start
                                  processing in parallel using multiple
                                  threads. A value of 0 indicates to use as
                                  many parallel threads as computation cores
                                  are available.
                                    (default=`0')
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select additional algorithmic details which should be included in the
  calculations.


  -c, --circ                    Assume a circular (instead of linear) RNA
                                  molecule.

                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.

                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --shape=filename          Use SHAPE reactivity data to guide structure
                                  predictions.


      --shapeConversion=method  Select method for SHAPE reactivity conversion.

                                    (default=`O')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --logML                   Recalculate energies of structures using a
                                  logarithmic energy function for multi-loops
                                  before output.
                                    (default=off)
      --cfactor=DOUBLE          Set the weight of the covariance term in the
                                  energy function

                                    (default=`1.0')
      --nfactor=DOUBLE          Set the penalty for non-compatible sequences in
                                  the covariance term of the energy function

                                    (default=`1.0')
  -R, --ribosum_file=ribosumfile
                                use specified Ribosum Matrix instead of normal
                                  energy model.

  -r, --ribosum_scoring         use ribosum scoring matrix.
                                    (default=off)
      --old                     use old energy evaluation, treating gaps as
                                  characters.

                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAfold

### Tool Description
Calculate minimum free energy secondary structures and partition function of RNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAfold [OPTIONS] [<input0.fa>] [<input1.fa>]...
Calculate minimum free energy secondary structures and partition function of
RNAs

The program reads RNA sequences, calculates their minimum free energy (mfe)
structure and prints the mfe structure in bracket notation and its free energy.
If not specified differently using commandline arguments, input is accepted
from stdin or read from an input file, and output printed to stdout. If the -p
option was given it also computes the partition function (pf) and base pairing
probability matrix, and prints the free energy of the thermodynamic ensemble,
the frequency of the mfe structure in the ensemble, and the ensemble diversity
to stdout.

It also produces PostScript files with plots of the resulting secondary
structure graph and a "dot plot" of the base pairing matrix.
The dot plot shows a matrix of squares with area proportional to the pairing
probability in the upper right half, and one square for each pair in the
minimum free energy structure in the lower left half. For each pair i-j with
probability p>10E-6 there is a line of the form

i  j  sqrt(p)  ubox

in the PostScript file, so that the pair probabilities can be easily extracted.

Sequences may be provided in a simple text format where each sequence occupies
a single line. Output files are named "rna.ps" and "dot.ps". Existing files
of the same name will be overwritten.

It is also possible to provide sequence data in FASTA format. In this case, the
first word of the FASTA header will be used as prefix for output file names.
PostScript files "prefix_ss.ps" and "prefix_dp.ps" are produced for the
structure and dot plot, respectively. Note, however, that once FASTA input was
provided all following sequences must be in FASTA format too.

To avoid problems with certain operating systems and/or file systems the prefix
will ALWAYS be sanitized! This step substitutes any special character in the
prefix by a filename delimiter. See the --filename-delim option to change the
delimiting character according to your requirements.

The program will continue to read new sequences until a line consisting of the
single character '@' or an end of file (EOF) condition is encountered.



  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --infile=filename         Read a file instead of reading from stdin.

  -o, --outfile[=filename]      Print output to file instead of stdout.

  -j, --jobs[=number]           Split batch input into jobs and start
                                  processing in parallel using multiple
                                  threads. A value of 0 indicates to use as
                                  many parallel threads as computation cores
                                  are available.
                                    (default=`0')
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


  -p, --partfunc[=INT]          Calculate the partition function and base
                                  pairing probability matrix.
                                    (default=`1')
      --MEA[=gamma]             Compute MEA (maximum expected accuracy)
                                  structure.
                                    (default=`1.')
  -c, --circ                    Assume a circular (instead of linear) RNA
                                  molecule.

                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.

                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT           Set the maximum base pair span.

                                    (default=`-1')
  -C, --constraint[=filename]   Calculate structures subject to constraints.
                                    (default=`')
      --enforceConstraint       Enforce base pairs given by round brackets '('
                                  ')' in structure constraint.

                                    (default=off)

Experimental Structure Probing Data:
  The following arguments and siwtches control various implementations that
  allow for guiding the structure prediction with the help of additional
  (experimental) RNA structure probing data, such as SHAPE, DMS, etc.


      --sp-data=filename        Read structure probing data from an input file
                                  and guide the predictions accordingly. Must
                                  precede the strategy, i.e. a data file must
                                  be specified before the corresponding
                                  --sp-strategy option!


      --sp-strategy=strategy    Select the strategy how the probing data is
                                  used to guide the structure predictions.

                                    (default=`D')
      --shape=filename          Use SHAPE reactivity data to guide structure
                                  predictions.



Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.


  -m, --modifications[=STRING]  Allow for modified bases within the RNA
                                  sequence string.
                                    (default=`7I6P9D')
      --mod-file=STRING         Use additional modified base data from JSON
                                  file.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots


      --noPS                    Do not produce postscript drawing of the mfe
                                  structure.

                                    (default=off)
      --noDP                    Do not produce dot-plot postscript file
                                  containing base pair or stack
                                  probabilitities.
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAheat

### Tool Description
Calculate the specific heat of an RNA sequence as a function of temperature.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAheat [OPTIONS] [<input0>] [<input1>]...
calculate specific heat of RNAs

Reads RNA sequences from stdin or input files and calculates their specific
heat in the temperature range t1 to t2, from the partition function by numeric
differentiation. The result is written to stdout as a list of pairs of
temperature in C and specific heat in kcal/(mol*K).
The program will continue to read new sequences until a line consisting of the
single character '@' or an end of file condition is encountered.


  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --infile=filename        Read a file instead of reading from stdin

  -j, --jobs[=number]          Split batch input into jobs and start processing
                                 in parallel using multiple threads. A value of
                                 0 indicates to use as many parallel threads as
                                 computation cores are available.
                                   (default=`0')
      --noconv                 Do not automatically substitute nucleotide "T"
                                 with "U".

                                   (default=off)
      --auto-id                Automatically generate an ID for each sequence.
                                   (default=off)
      --id-prefix=STRING       Prefix for automatically generated IDs (as used
                                 in output file names)

                                   (default=`sequence')

Algorithms:
  Select additional algorithms which should be included in the calculations.


      --Tmin=t1                Lowest temperature.

                                   (default=`0')
      --Tmax=t2                Highest temperature.

                                   (default=`100')
      --stepsize=FLOAT         Calculate partition function every stepsize
                                 degrees C.

                                   (default=`1.')
  -m, --ipoints=ipoints        The program fits a parabola to 2*ipoints+1 data
                                 points to calculate 2nd derivatives.
                                 Increasing this parameter produces a smoother
                                 curve.

                                   (default=`2')
  -c, --circ                   Assume a circular (instead of linear) RNA
                                 molecule.

                                   (default=off)
  -g, --gquad                  Incoorporate G-Quadruplex formation into the
                                 structure prediction algorithm.

                                   (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT          Set the maximum base pair span.

                                   (default=`-1')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            How to treat "dangling end" energies for bases
                                 adjacent to helices in free ends and
                                 multi-loops
                                   (default=`2')
      --noLP                   Produce structures without lonely pairs (helices
                                 of length 1).
                                   (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAinverse

### Tool Description
Find RNA sequences with a given secondary structure (inverse folding). Reads structure and start sequence from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAinverse [OPTION]...
Find RNA sequences with given secondary structure

The program searches for sequences folding into a predefined structure, thereby
inverting the folding algorithm. Target structures (in bracket notation) and
starting sequences for the search are read alternately from stdin.
Characters in the start sequence other than "AUGC" (or the alphabet specified
with -a) will be treated as wild cards and replaced by a random character. Any
lower case characters in the start sequence will be kept fixed during the
search. If necessary, the sequence will be elongated to the length of the
structure. Thus a string of "N"s as well as a blank line specify a random
start sequence.
For each search the best sequence found and its Hamming distance to the start
sequence are printed to stdout. If the the search was unsuccessful, a structure
distance to the target is appended.
The -Fp and -R options can modify the output format, see commandline options
below.
The program will continue to read new structures and sequences until a line
consisting of the single character "@" or an end of file condition is
encountered.


  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                In conjunction with a negative value supplied to
                                 -R, print the last subsequence and
                                 substructure for each unsuccessful search.
                                   (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -F, --function=mp            Use minimum energy (-Fm), partition function
                                 folding (-Fp) or both (-Fmp).
                                   (default=`m')
  -f, --final=FLOAT            In combination with -Fp stop search when
                                 sequence is found with E(s)-F is smaller than
                                 final, where F=-kT*ln(Q).


  -R, --repeat[=INT]           Search repeatedly for the same structure.
                                 If an argument is supplied to this option it
                                 must follow the option flag immediately. E.g.:
                                 -R5
                                   (default=`1')
  -a, --alphabet=ALPHABET      Find sequences using only nucleotides from a
                                 given alphabet.



Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            How to treat "dangling end" energies for bases
                                 adjacent to helices in free ends and
                                 multi-loops
                                   (default=`2')

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNALalifold

### Tool Description
Calculate locally stable secondary structures for a set of aligned RNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNALalifold [options] <file1.aln>
calculate locally stable secondary structures for a set of aligned RNAs

reads aligned RNA sequences from stdin or file.aln and calculates locally
stable RNA secondary structure with a maximal base pair span. For a sequence of
length n and a base pair span of L the algorithm uses only O(n+L*L) memory and
O(n*L*L) CPU time. Thus it is practical to "scan" very large genomes for
short RNA
 structures.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)
  -q, --quiet                   Be quiet.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -f, --input-format=C|S|F|M    File format of the input multiple sequence
                                  alignment (MSA).

      --csv                     Create comma separated output (csv)

                                    (default=off)
      --aln[=prefix]            Produce output alignments and secondary
                                  structure plots for each hit found.

      --aln-stk[=prefix]        Add hits to a multi-Stockholm formatted output
                                  file.
                                    (default=`RNALalifold_results')
      --mis                     Output "most informative sequence" instead of
                                  simple consensus: For each column of the
                                  alignment output the set of nucleotides with
                                  frequency greater than average in IUPAC
                                  notation.

                                    (default=off)
      --split-contributions     Split the free energy contributions into
                                  separate parts
                                    (default=off)
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each
                                  alignment.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`alignment')

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


  -L, --maxBPspan=INT           Set the maximum allowed separation of a base
                                  pair to span. I.e. no pairs (i,j) with
                                  j-i>span will be allowed.

                                    (default=`70')
      --threshold=DOUBLE        Energy threshold in kcal/mol per nucleotide
                                  above which secondary structure hits are
                                  omitted in the output.

                                    (default=`-0.1')
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.

                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --shape=file1,file2       Use SHAPE reactivity data to guide structure
                                  predictions.


Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)
      --cfactor=DOUBLE          Set the weight of the covariance term in the
                                  energy function

                                    (default=`1.0')
      --nfactor=DOUBLE          Set the penalty for non-compatible sequences in
                                  the covariance term of the energy function

                                    (default=`1.0')
  -R, --ribosum_file=ribosumfile
                                use specified Ribosum Matrix instead of normal
                                  energy model.

  -r, --ribosum_scoring         use ribosum scoring matrix.
                                    (default=off)

Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots


      --aln-EPS[=prefix]        Produce colored and structure annotated
                                  subalignment for each hit.

      --aln-EPS-ss[=prefix]     Produce colored consensus secondary structure
                                  plots in PostScript format.


If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNALfold

### Tool Description
Calculate locally stable secondary structures of long RNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNALfold [OPTION]...
calculate locally stable secondary structures of RNAs

Compute locally stable RNA secondary structure with a maximal base pair span.
For a sequence of length n and a base pair span of L the algorithm uses only
O(n+L*L) memory and O(n*L*L) CPU time. Thus it is practical to "scan" very
large genomes for short RNA structures.
Output consists of a list of secondary structure components of size <= L, one
entry per line. Each output line contains the predicted local structure its
energy in kcal/mol and the starting position of the local structure.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --infile=filename         Read a file instead of reading from stdin

  -o, --outfile[=filename]      Print output to file instead of stdout.

      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


  -L, --span=INT                Set the maximum distance between any two
                                  pairing nucleotides.
                                    (default=`150')
  -z, --zscore[=DOUBLE]         Limit the output to predictions with a Z-score
                                  below a threshold.
                                    (default=`-2')
      --zscore-pre-filter       Apply the z-score filtering in the forward
                                  recursions.
                                    (default=off)
      --zscore-report-subsumed  Report subsumed structures if their z-score is
                                  less than that of the enclosing structure.
                                    (default=off)
  -b, --backtrack-global        Backtrack a global MFE structure.
                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.

                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --shape=filename          Use SHAPE reactivity data to guide structure
                                  predictions.



Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.


  -m, --modifications[=STRING]  Allow for modified bases within the RNA
                                  sequence string.
                                    (default=`7I6P9D')
      --mod-file=STRING         Use additional modified base data from JSON
                                  file.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAlocmin

### Tool Description
Calculate local minima from structures via gradient walks. Reads structures (for example RNAsubopt output) from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAlocmin [OPTION]... [FILE]...
Calculate local minima from structures via gradient walks. Example usage: 
    RNAsubopt -p 10000 < "sequence.txt" > "suboptp.txt"
    RNAlocmin -s "sequence.txt" [OPTIONS] < "suboptp.txt"

  -h, --help                 Print help and exit
      --detailed-help        Print help, including all details and hidden
                               options, and exit
      --full-help            Print help, including hidden options, and exit
  -V, --version              Print version and exit

General options:
  -s, --seq=STRING           Sequence file in FASTA format. If the sequence is
                               the first line of the input file, this is not
                               needed  (default=`seq.txt')
  -p, --previous=STRING      Previously found LM (output from RNAlocmin or
                               barriers), if specified does not need --seq
                               option
  -m, --move=STRING          Move set:
                               I ==> insertion & deletion of base pairs
                               S ==> I&D& switch of base pairs  (possible
                               values="I", "S" default=`I')
  -n, --min-num=INT          Maximal number of local minima returned
                               (0 == unlimited)  (default=`100000')
      --find-num=INT         Maximal number of local minima found
                               (default = unlimited - crawl through whole input
                               file)
  -v, --verbose-lvl=INT      Level of verbosity (0 = nothing, 4 = full)
                               WARNING: higher verbose levels increase the
                               computation time  (default=`0')
      --depth=INT            Depth of findpath search (higher value increases
                               running time linearly)  (default=`10')
      --minh=DOUBLE          Print only minima with energy barrier greater than
                               this  (default=`0.0')
  -w, --walk=STRING          Walking method used
                               D ==> gradient descent
                               F ==> use first found lower energy structure
                               R ==> use random lower energy structure (does
                               not work with --noLP and -m S options)
                               (possible values="D", "F", "R"
                               default=`D')
      --noLP                 Work only with canonical RNA structures (w/o
                               isolated base pairs, cannot be combined with
                               ranodm walk (-w R option) and shift move set (-m
                               S))  (default=off)
  -P, --paramFile=STRING     Read energy parameters from paramfile, instead of
                               using the default parameter set
  -d, --dangles=INT          How to treat "dangling end" energies for bases
                               adjacent to helices in free ends and multi-loops
                                 (default=`2')
  -k, --pseudoknots          Allow for pseudoknots according to "gfold" model
                               - H, K, L, and M types (genus one) of
                               pseudoknots are allowed (increases computation
                               time greatly), cannot be combined with shift
                               move set (-m S)  (default=off)
      --just-read            Do not expect input from stdin, just do
                               postprocessing.  (default=off)
  -N, --neighborhood         Use the Neighborhood routines to perform gradient
                               descend. Cannot be combined with shift move set
                               (-m S) and pseudoknots (-k). Test option.
                               (default=off)
      --degeneracy-off       Do not deal with degeneracy, select the
                               lexicographically first from the same energy
                               neighbors.  (default=off)
      --just-output          Do not store the minima and optimize, just compute
                               directly minima and output them. Output file can
                               contain duplicates.  (default=off)

Barrier tree:
  -b, --bartree              Generate an approximate barrier tree.
                               (default=off)
      --barr-name=STRING     Name of barrier tree output file, switches on -b
                               flag.  (default=`treeRNAloc.ps')

Kinetics (rates for treekin program):
      --barrier-file=STRING  File for saddle heights between LM (simulates the
                               output format of barriers program)
  -r, --rates                Create rates for treekin  (default=off)
  -f, --rates-file=STRING    File where to write rates, switches on -r flag
                               (default=`rates.out')
  -T, --temp=DOUBLE          Temperature in Celsius (only for rates)
                               (default=`37.0')

Flooding parameters (flooding occurs only with -r, -b, or --minh option):
      --floodPortion=DOUBLE  Fraction of minima to flood (floods first minima
                               with low number of inwalking sample structures)
                               (0.0 -> no flood; 1.0 -> try to flood all)
                               Usable only with -r or -b options.
                               (default=`0.95')
      --floodMax=INT         Flood cap - how many structures to flood in one
                               basin  (default=`1000')

Miscelaneous:
      --eRange=FLOAT         Report only LM, which energy is in range <MFE (or
                               lowest found LM), MFE+eRange> in kcal/mol.
```

## viennarna_RNAmultifold

### Tool Description
Calculate secondary structures of multiple interacting RNAs (multi-strand complexes).

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAmultifold [OPTION]... [FILE]...
Compute secondary structures of multiple interacting RNAs

The program works much like RNAfold, but allows one to specify multiple RNA
sequences which are then allowed to form conncected components. RNA sequences
are read from stdin in the usual format, i.e. each line of input corresponds to
one sequence, except for lines starting with ">" which contain the name of
the next sequence(s).
Multiple strands must be concatenated using the '&' character as separator.
RNAmultifold can compute MFE, partition function, corresponding ensemble free
energy and base pairing probabilities. These properties are either computed for
a particular arrangement (concatenation) of sequences, for the full ensemble of
the complex of input RNAs, or all complexes formed by the input sequences up to
a specified number of interacting sequences.
Output consists of a PostScript "dot plot" file containing the pair
probabilities, see the RNAfold man page for details.
The program will continue to read new sequences until a line consisting of the
single character '@' or an end of file condition is encountered.



  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -j, --jobs[=number]           Split batch input into jobs and start
                                  processing in parallel using multiple
                                  threads. A value of 0 indicates to use as
                                  many parallel threads as computation cores
                                  are available.
                                    (default=`0')
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


  -p, --partfunc[=INT]          Calculate the partition function and base
                                  pairing probability matrix in addition to the
                                  MFE structure. Default is calculation of mfe
                                  structure only.
                                    (default=`1')
  -a, --all_pf[=INT]            Compute the partition function and free
                                  energies not only for the complex formed by
                                  the input sequences (the "ABC... mutimer"),
                                  but also of all complexes formed by the input
                                  sequences up to the number of input
                                  sequences, e.g. AAA, AAB, ABB, BBB, etc.
                                    (default=`1')
  -c, --concentrations          In addition to everything listed under the -a
                                  option, read in initial monomer
                                  concentrations and compute the expected
                                  equilibrium concentrations of all possible
                                  species (A, B, AA, BB, AB, etc).
                                    (default=off)
  -f, --concfile=filename       Specify a file with initial concentrations for
                                  the input sequences.
      --absolute-concentrations Report absolute instead of relative
                                  concentrations

                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.
                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT           Set the maximum base pair span.

                                    (default=`-1')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNApaln

### Tool Description
Calculate distances between thermodynamic equilibrium structures (base pair probabilities) of RNA sequences via profile alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNApaln [OPTION]...
RNA alignment based on sequence base pairing propensities

Uses string-alignment techniques to perform fast pairwise structural alignments
of RNAs. Similar to RNApdist secondary structure is incorporated in an
approximate manner by computing base pair probabilities, which are then reduced
to a vector holding the probability that a base is paired upstream, downstream,
or remains unpaired. Such pair propsensity vectors can then be compared using
standard alignment algorithms. In contrast to RNApdist, RNApaln performs
similarity (instead of distance) alignments, considers both sequence and
structure information, and uses affine (rather than linear) gap costs. RNApaln
can perform semi-local alignments by using free end gaps, a true local
alignment mode is planned.

The same approach has since been used in the StraL program from Gerhard
Steeger's group. Since StraL has optimized parameters and a multiple alignment
mode, it be be currently the better option.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -B, --printAlignment[=filename]
                                Print an "alignment" with gaps of the
                                  profiles
                                  The aligned structures are written to
                                  filename, if specified
                                  Otherwise output is written to stdout, unless
                                  the -Xm option is set in which case
                                  "backtrack.file" is used.
                                    (default=`stdout')
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.

  -X, --mode=pmfc               Set the alignment mode to be used.

      --gapo=open               Set the gap open penalty


      --gape=ext                Set the gap extension penalty


      --seqw=w                  Set the weight of sequence (compared to
                                  structure) in the scoring function.


      --endgaps                 Use free end-gaps

                                    (default=off)

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNApdist

### Tool Description
Calculate distances between thermodynamic equilibrium structures (base pair probabilities) of RNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNApdist [OPTION]...
Calculate distances between thermodynamic RNA secondary structures ensembles

This program reads RNA sequences from stdin and calculates structure distances
between the thermodynamic ensembles of their secondary structures.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -X, --compare=p|m|f|c         Specify the comparison directive.
                                    (default=`p')
  -B, --backtrack[=<filename>]  Print an "alignment" with gaps of the
                                  profiles. The aligned structures are written
                                  to <filename>, if specified.
                                    (default=`none')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             set energy model for treatment of dangling
                                  bases.

                                    (possible values="0", "2" default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAparconv

### Tool Description
Convert energy parameter files from ViennaRNA 1.8.4 to 2.0 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAparconv [options] [<input file>] [<output file>]

Convert energy parameter files from ViennaRNA 1.8.4 to 2.0 format

Converts energy parameter files from "old" ViennaRNAPackage 1.8.4 format to
the new format used since ViennaRNAPackage 2.0.
The Program reads a valid energy parameter file or valid energy parameters from
stdin and prints the converted energy parameters to stdout or a specified
output file. Per default, the converted output file contains the whole set of
energy parameters used throughout ViennaRNAPackage 1.8.4. The user can specify
sets of energy parameters that should not be included in the output.


  -h, --help                 Print help and exit
      --detailed-help        Print help, including all details and hidden
                               options, and exit
      --full-help            Print help, including hidden options, and exit
  -V, --version              Print version and exit
  -v, --verbose              Be verbose.
                                 (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --input=filename       Specify an input file name. If argument is missing
                               the energy parameter input can be supplied via
                               'stdin'.


  -o, --output=filename      Specify an output file name. If argument is
                               missing the converted energy parameters are
                               printed to 'stdout'.


      --vanilla              Print just as much as needed to represent the
                               given energy parameters data set.
                               This option overrides all other output settings!

                                 (default=off)
      --dump                 Just dump Vienna 1.8.4 energy parameters in format
                               used since 2.0.
                               This option skips any energy parameter input!

                                 (default=off)
      --silent               Print just energy parameters and appropriate
                               comment lines but suppress all other output

                                 (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAPKplex

### Tool Description
Predict RNA secondary structures including pseudoknots. Reads sequences from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAPKplex [OPTION]...
predicts RNA secondary structures including pseudoknots

Computes RNA secondary structures by first making two sequence intervals
accessible and unpaired using the algorithm of RNAplfold and then calculating
the energy of the interaction of those two intervals. The algorithm uses
O(n^2*w^4) CPU time and O(n*w^2) memory space.
The algorithm furthermore always considers dangle=2 model.


  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


      --noconv                 Do not automatically substitute nucleotide "T"
                                 with "U".

                                   (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -c, --cutoff=FLOAT           Only consider unpaired probabities > cutoff for
                                 putative PK sites.

                                   (default=`1e-6')
  -e, --energyCutoff=DOUBLE    Energy cutoff or pseudoknot initiation cost.
                                 Minimum energy gain of a pseudoknot
                                 interaction for it to be returned. Pseudoknots
                                 with smaller energy gains are rejected.

                                   (default=`-8.10')
  -s, --subopts=DOUBLE         print suboptimal structures whose energy
                                 difference of the pseudoknot to the optimum
                                 pseudoknot is smaller than the given value.
                                   (default=`0.0')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


      --noLP                   Produce structures without lonely pairs (helices
                                 of length 1).
                                   (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAplex

### Tool Description
Find targets of a query RNA: fast RNA-RNA hybridization search.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAplex [options]

Find targets of a query RNA

reads two RNA sequences from stdin or <filename> and computes optimal and
suboptimal secondary structures for their hybridization. The calculation is
simplified by allowing only inter-molecular base pairs. Accessibility effects
can be estimated by RNAplex if a RNAplfold accessibility profile is provided.
The computed optimal and suboptimal structure are written to stdout, one
structure per line. Each line consist of: The structure in dot bracket format
with a "&" separating the two strands. The range of the structure in the two
sequences in the format  "from,to : from,to"; the energy of duplex structure
in kcal/mol.
The format is especially useful for computing the hybrid structure between a
small probe sequence and a long target sequence.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
      --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -q, --query=STRING            File containing the query sequence.

  -t, --target=STRING           File containing the target sequence.

  -a, --accessibility-dir=STRING
                                Location of the accessibility profiles.

  -b, --binary                  Allow the reading and parsing of memory dumped
                                  opening energy file
                                    (default=off)

Algorithms:
  Options which alter the computing behaviour of RNAplex.


  -l, --interaction-length=INT  Maximal length of an interaction
                                    (default=`40')
  -c, --extension-cost=INT      Cost to add to each nucleotide in a duplex
                                    (default=`0')
  -p, --probe-mode              Compute Tm for probes  (default=off)
  -Q, --probe-concentration=DOUBLE
                                Set the probe concentration for the Tm
                                  computation

                                    (default=`0.1')
  -f, --fast-folding=INT        Speedup of the target search
                                    (default=`0')
  -V, --scale-accessibility=DOUBLE
                                Rescale all opening energy by a factor V
                                    (default=`1.0')
  -A, --alignment-mode          Tells RNAplex to compute interactions based on
                                  alignments
                                    (default=off)
  -k, --convert-to-bin          If set, RNAplex will convert all opening energy
                                  file in a directory set by the -a option into
                                  binary opening energy files
                                    (default=off)
  -z, --duplex-distance=INT     Distance between target 3' ends of two
                                  consecutive duplexes
                                    (default=`0')
  -e, --energy-threshold=DOUBLE Minimal energy for a duplex to be returned
                                    (default=`-100000')
  -L, --WindowLength=INT        Tells how large the region around the target
                                  site should be for redrawing the alignment
                                  interaction
                                    (default=`1')

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


  -C, --constraint              Calculate structures subject to constraints.
                                    (default=off)

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots


  -I, --produce-ps=STRING       Draw an alignment annotated interaction from
                                  RNAplex.


If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAplfold

### Tool Description
Calculate average pair probabilities and mean unpaired probabilities for windows of an RNA. Reads sequences from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAplfold [OPTION]...
calculate locally stable secondary structure - pair probabilities

Computes local pair probabilities for base pairs with a maximal span of L. The
probabilities are averaged over all windows of size L that contain the base
pair. For a sequence of length n and a window size of L the algorithm uses only
O(n+L*L) memory and O(n*L*L) CPU time. Thus it is practical to "scan" very
large genomes for short stable RNA structures.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -c, --cutoff=FLOAT            Report only base pairs with an average
                                  probability larger than 'cutoff' in the dot
                                  plot.

                                    (default=`0.01')
  -o, --print_onthefly          Save memory by printing out everything during
                                  computation.
                                    (default=off)
  -O, --opening_energies        Switch output from probabilities to their
                                  logarithms.
                                    (default=off)
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select and change parameters of (additional) algorithms which should be
  included in the calculations.


  -W, --winsize=size            Average the pair probabilities over windows of
                                  given size.

                                    (default=`70')
  -L, --span=size               Set the maximum allowed separation of a base
                                  pair to span.

  -u, --ulength=length          Compute the mean probability that regions of
                                  length 1 to a given length are unpaired.
                                    (default=`31')

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --shape=filename          Use SHAPE reactivity data to guide structure
                                  predictions.



Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.


  -m, --modifications[=STRING]  Allow for modified bases within the RNA
                                  sequence string.
                                    (default=`7I6P9D')
      --mod-file=STRING         Use additional modified base data from JSON
                                  file.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             Specify "dangling end" model for bases
                                  adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAplot

### Tool Description
Draw RNA secondary structures (PostScript, SVG, GML, XRNA or SSV) from sequence and structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAplot [OPTIONS] [<input0>] [<input1>]...
Draw RNA Secondary Structures

The program reads (aligned) RNA sequences and structures in the format as
produced by RNAfold or Stockholm 1.0 and produces drawings of the secondary
structure graph.
Coordinates for the structure graphs are produced using either E. Bruccoleri's
naview routines, or a simple radial layout method.
For aligned sequences and consensus structures (--msa option) the graph may be
annotated by covariance information. Additionally, a color-annotated EPS
alignment figure can be produced, similar to that obtained by RNAalifold and
RNALalifold.
If the sequence was preceded by a FASTA header, or if the multiple sequence
alignment contains an ID field, these IDs will be taken as names for the output
file(s): "name_ss.ps" and "name_aln.ps". Otherwise "rna.ps" and
"aln.ps" will be used. This behavior may be over-ruled by explicitly setting
a filename prefix using the --auto-id option.
Existing files of the same name will be overwritten.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --infile=<filename>       Read a file instead of reading from stdin.
  -a, --msa                     Input is multiple sequence alignment in
                                  Stockholm 1.0 format.  (default=off)
      --mis                     Output "most informative sequence" instead of
                                  simple consensus  (default=off)
  -j, --jobs[=number]           Split batch input into jobs and start
                                  processing in parallel using multiple
                                  threads.  (default=`0')
  -f, --output-format=format    Specify output file format.  (possible
                                  values="eps", "svg", "gml", "xrna",
                                  "ssv" default=`eps')
      --pre=string              Add annotation macros to postscript file, and
                                  add the postscript code in "string" just
                                  before the code to draw the structure. This
                                  is an easy way to add annotation.
      --post=string             Same as --pre but in contrast to adding the
                                  annotation macros. E.g to mark position 15
                                  with circle use --post="15 cmark".
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots


      --covar                   Annotate covariance of base pairs in consensus
                                  structure.

                                    (default=off)
      --aln                     Produce a colored and structure annotated
                                  alignment in PostScript format in the file
                                  "aln.ps" in the current directory.

                                    (default=off)
  -t, --layout-type=INT         Choose the plotting layout algorithm.
                                  (possible values="0", "1", "2", "3",
                                  "4" default=`1')

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNApvmin

### Tool Description
Calculate a perturbation vector that minimizes the discrepancy between predicted and observed pairing probabilities (SHAPE data). Reads the sequence from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNApvmin [options] <file.shape>
Calculate a perturbation vector that minimizes discripancies between predicted
and observed pairing probabilities

The program reads a RNA sequence from stdin and uses an iterative minimization
process to calculate a perturbation vector that minimizes the discripancies
between predicted pairing probabilites and observed pairing probabilities
(deduced from given shape reactivities). Experimental data is read from a given
SHAPE file and normalized to pairing probabilities. The experimental data has
to be provided in a multiline plain text file where each line has the format
'[position] [nucleotide] [absolute shape reactivity]' (e.g. '3 A 0.7'). The
objective function used for the minimization may be weighted by choosing
appropriate values for sigma and tau.

The minimization progress will be written to stderr. Once the minimization has
terminated, the obtained perturbation vector is written to stdout.

  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -j, --numThreads=INT          Set the number of threads used for
                                  calculations.



Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.


      --shapeConversion=STRING  Specify the method used to convert SHAPE
                                  reactivities to pairing probabilities.
                                    (default=`O')
      --tauSigmaRatio=DOUBLE    Ratio of the weighting factors tau and sigma.
                                    (default=`1.0')
      --objectiveFunction=INT   The energies of the perturbation vector and the
                                  discripancies between predicted and observed
                                  pairing probabilities contribute to the
                                  objective function. This parameter defines,
                                  which function is used to process the
                                  contributions before summing them up.
                                  0 square
                                  1 absolute.

                                    (default=`0')
      --sampleSize=INT          The iterative minimization process requires to
                                  evaluate the gradient of the objective
                                  function.
                                    (default=`1000')
  -N, --nonRedundant            Enable non-redundant sampling strategy.

                                    (default=off)
      --intermediatePath=STRING Write an output file for each iteration of the
                                  minimization process.

      --initialVector=DOUBLE    Specify the vector of initial pertubations.
                                    (default=`0')
      --minimizer=ENUM          Set the minimizing algorithm used for finding
                                  an appropriate perturbation vector.
                                    (possible values="conjugate_fr",
                                  "conjugate_pr", "vector_bfgs",
                                  "vector_bfgs2", "steepest_descent",
                                  "default" default=`default')

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT           Set the maximum base pair span.

                                    (default=`-1')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAsnoop

### Tool Description
Find targets of a query H/ACA snoRNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAsnoop [options]

Find targets of a query H/ACA snoRNA

reads a target RNA sequence and a H/ACA snoRNA sequence
from a target and query file, respectively and computes optimal
and suboptimal secondary structures for their hybridization. The
calculation can be done roughly in O(nm), where is n the length
of the target sequence and m is the length of the snoRNA stem, as it
is specially tailored to the special case of H/ACA snoRNA. For general
purpose target predictions, please have a look at RNAduplex, RNAup,
RNAcofold and RNAplex. Accessibility effects can be estimated by
RNAsnoop if a RNAplfold accessibility profile is provided. 

The computed optimal and suboptimal structure are written to
stdout, one structure per line. Each line consist
of: The structure in dot bracket format with a '&' separating the
two strands. The '<>' brackets represent snoRNA intramolecular
interactions, while the '()' brackets represent intermolecular
interactions between the snoRNA and its target.

The range of the structure in the two sequences in the format
"from,to : from,to"; the energy of duplex structure in
kcal/mol. If available the opening energy are also returned.


      --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
      --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -s, --query=STRING            File containing the query sequence.

  -t, --target=STRING           File containing the target sequence.

  -S, --suffix=STRING           Specificy the suffix that was added by RNAup to
                                  the accessibility files.

                                    (default=`_u1_to_30.out')
  -P, --from-RNAplfold=STRING   Specify the directory where accessibility
                                  profile generated by RNAplfold are found.


  -U, --from-RNAup=STRING       Specify the directory where accessibility
                                  profiles generated by RNAup are found.


  -O, --output_directory=STRING Set where the generated figures should be
                                  stored.

                                    (default=`./')

Algorithms:
  Options which alter the computing behaviour of RNAplex. Please note that the
  options allowing to filter out snoRNA-RNA duplexes expect the energy to be
  given in decacal/mol instead of kcal/mol. A threshold of -2.8(kcal/mol)
  should be given as -280(decacal/mol).


  -A, --alignment-mode          Specify if RNAsnoop gets alignments or single
                                  sequences as input.

                                    (default=off)
  -f, --fast-folding=INT        Speedup of the target search.
                                    (default=`1')
  -c, --extension-cost=INT      Cost to add to each nucleotide in a duplex.
                                    (default=`0')
  -e, --energy-threshold=DOUBLE Maximal energy difference between the mfe and
                                  the desired suboptimal.
                                    (default=`-1')
  -o, --minimal-right-duplex=INT
                                Minimal Right Duplex Energy

                                    (default=`-270')
  -l, --minimal-loop-energy=INT Minimal Right Duplex Energy.
                                    (default=`-280')
  -p, --minimal-left-duplex=INT Minimal Left Duplex Energy.

                                    (default=`-170')
  -q, --minimal-duplex=INT      Minimal Duplex Energy.

                                    (default=`-1090')
  -d, --duplex-distance=INT     Distance between target 3' ends of two
                                  consecutive duplexes.
                                    (default=`2')
  -h, --minimal-stem-length=INT Minimal snoRNA stem length.

                                    (default=`5')
  -i, --maximal-stem-length=INT Maximal snoRNA stem length.

                                    (default=`120')
  -j, --minimal-duplex-box-length=INT
                                Minimal distance between the duplex end and the
                                  H/ACA box.

                                    (default=`11')
  -k, --maximal-duplex-box-length=INT
                                Maximal distance between the duplex end and the
                                  H/ACA box.

                                    (default=`16')
  -m, --minimal-snoRNA-stem-loop-length=INT
                                Minimal number of nucleotides between the
                                  beginning of stem loop and
                                  beginning of the snoRNA sequence.

                                    (default=`1')
  -n, --maximal-snoRNA-stem-loop-length=INT
                                Maximal number of nucleotides between the
                                  beginning of stem loop and
                                  beginning of the snoRNA sequence.

                                    (default=`100000')
  -v, --minimal-snoRNA-duplex-length=INT
                                Minimal distance between duplex start and
                                  snoRNA.

                                    (default=`0')
  -w, --maximal-snoRNA-duplex-length=INT
                                Maximal distance between duplex start and
                                  snoRNA.

                                    (default=`0')
  -x, --minimal-duplex-stem-energy=INT
                                Minimal duplex stem energy.

                                    (default=`-1370')
  -y, --minimal-total-energy=INT
                                Minimal total energy.

                                    (default=`100000')
  -a, --maximal-stem-asymmetry=INT
                                Maximal snoRNA stem asymmetry.

                                    (default=`30')
  -b, --minimal-lower-stem-energy=INT
                                Minimal lower stem energy.

                                    (default=`100000')
  -L, --alignmentLength=INT     Limit the extent of the interactions to L
                                  nucleotides.

                                    (default=`25')

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


  -C, --constraint              Calculate the stem structure subject to
                                  constraints.
                                    (default=off)

Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots.


  -I, --produce-ps              Draw annotated 2D structures for a list of
                                  dot-bracket structures.
                                    (default=off)
  -N, --direct-redraw           Outputs 2D interactions concurrently with the
                                  interaction calculation for each suboptimal
                                  interaction. The -I option should be
                                  preferred.

                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAsubopt

### Tool Description
Calculate suboptimal secondary structures of RNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAsubopt [OPTION]...
calculate suboptimal secondary structures of RNAs

Reads RNA sequences from stdin and (in the default -e mode) calculates all
suboptimal secondary structures within a user defined energy range above the
minimum free energy (mfe). It prints the suboptimal structures in dot-bracket
notation followed by the energy in kcal/mol to stdout. Be careful, the number
of structures returned grows exponentially with both sequence length and energy
range.

Alternatively, when used with the -p option, RNAsubopt produces Boltzmann
weighted samples of secondary structures.


  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -i, --infile=filename         Read a file instead of reading from stdin.

  -o, --outfile[=filename]      Print output to file instead of stdout.

      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select the algorithms which should be applied to the given RNA sequence(s).


  -e, --deltaEnergy=range       Compute suboptimal structures with energy in a
                                  certain range of the optimum (kcal/mol).

  -s, --sorted                  Sort the suboptimal structures by energy and
                                  lexicographical order.
                                    (default=off)
  -p, --stochBT=number          Randomly draw structures according to their
                                  probability in the Boltzmann ensemble.

  -N, --nonRedundant            Enable non-redundant sampling strategy.

                                    (default=off)
  -c, --circ                    Assume a circular (instead of linear) RNA
                                  molecule.

                                    (default=off)
  -D, --dos                     Compute density of states instead of secondary
                                  structures.
                                    (default=off)
  -z, --zuker                   Compute Zuker suboptimals instead of all
                                  suboptimal structures within an energy band
                                  around the MFE.

                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation.
                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT           Set the maximum base pair span.

                                    (default=`-1')
  -C, --constraint[=filename]   Calculate structures subject to constraints.
                                    (default=`')
      --enforceConstraint       Enforce base pairs given by round brackets '('
                                  ')' in structure constraint.

                                    (default=off)

Experimental Structure Probing Data:
  The following arguments and siwtches control various implementations that
  allow for guiding the structure prediction with the help of additional
  (experimental) RNA structure probing data, such as SHAPE, DMS, etc.


      --sp-data=filename        Read structure probing data from an input file
                                  and guide the predictions accordingly. Must
                                  precede the strategy, i.e. a data file must
                                  be specified before the corresponding
                                  --sp-strategy option!


      --sp-strategy=strategy    Select the strategy how the probing data is
                                  used to guide the structure predictions.

                                    (default=`D')
      --shape=filename          Use SHAPE reactivity data to guide structure
                                  predictions.



Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.


  -m, --modifications[=STRING]  Allow for modified bases within the RNA
                                  sequence string.
                                    (default=`7I6P9D')
      --mod-file=STRING         Use additional modified base data from JSON
                                  file.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)
      --logML                   Recompute energies of structures using a
                                  logarithmic energy function for multi-loops
                                  before output.  (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_RNAup

### Tool Description
Calculate the thermodynamics of RNA-RNA interactions (accessibility-aware). Reads sequences from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAup [OPTION]...
Calculate the thermodynamics of RNA-RNA interactions

RNAup calculates the thermodynamics of RNA-RNA interactions, by decomposing the
binding into two stages. (1) First the probability that a potential binding
sites remains unpaired (equivalent to the free energy needed to open the site)
is computed. (2) Then this accessibility is combined with the interaction
energy to obtain the total binding energy. All calculations are done by
computing partition functions over all possible conformations.


  -h, --help                   Print help and exit
      --detailed-help          Print help, including all details and hidden
                                 options, and exit
      --full-help              Print help, including hidden options, and exit
  -V, --version                Print version and exit
  -v, --verbose                Be verbose.
                                   (default=off)

I/O Options:
  Command line options for input and output (pre-)processing


  -o, --no_output_file         Do not produce an output file.

                                   (default=off)
      --no_header              Do not produce a header with the command line
                                 parameters used in the outputfile.

                                   (default=off)
      --noconv                 Do not automatically substitute nucleotide "T"
                                 with "U".

                                   (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.


  -u, --ulength=length         Specify the length of the unstructured region in
                                 the output.
                                   (default=`4')
  -c, --contributions=SHIME    Specify the contributions listed in the output.
                                   (default=`S')

Calculations of RNA-RNA interactions:
  -w, --window=INT             Set the maximal length of the region of
                                 interaction.

                                   (default=`25')
  -b, --include_both           Include the probability of unpaired regions in
                                 both (b) RNAs.
                                   (default=off)
  -5, --extend5=INT            Extend the region of interaction in the target
                                 to some residues on the 5' side.

  -3, --extend3=INT            Extend the region of interaction in the target
                                 to some residues on the 3' side.

      --interaction_pairwise   Activate pairwise interaction mode.
                                   (default=off)
      --interaction_first      Activate interaction mode using first sequence
                                 only.
                                   (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


  -C, --constraint             Apply structural constraint(s) during
                                 prediction.
                                   (default=off)

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files


  -T, --temp=DOUBLE            Rescale energy parameters to a temperature of
                                 temp C. Default is 37C.

                                   (default=`37.0')
  -P, --paramFile=paramfile    Read energy parameters from paramfile, instead
                                 of using the default parameter set.

      --salt=DOUBLE            Set salt concentration in molar (M). Default is
                                 1.021M.



Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters


  -d, --dangles=INT            Specify "dangling end" model for bases
                                 adjacent to helices in free ends and
                                 multi-loops.
                                   (default=`2')
      --noLP                   Produce structures without lonely pairs (helices
                                 of length 1).
                                   (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

## viennarna_relplot

### Tool Description
Colorize a secondary structure plot (RNAfold _ss.ps) with reliability annotation from positional entropy of a dot plot (_dp.ps) or SHAPE data.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text

usage: /usr/local/share/ViennaRNA/bin/relplot.pl [-p] [-a] FOO_ss.ps FOO_dp.ps > FOO_rss.ps

usage: /usr/local/share/ViennaRNA/bin/relplot.pl -s FOO_ss.ps FOO.shape > FOO_rss.ps
For more details run
	perldoc -F /usr/local/share/ViennaRNA/bin/relplot.pl
/range 0.8 def
/drawreliability {
  /Smax 0.2 def
  0
  coor {
    aload pop
    S 3 index get
    Smax div range mul
    invert {range exch sub} if
    dup 0 ge
    {1 1 sethsbcolor} {pop 1 1 1 setrgbcolor} ifelse
    newpath
    fsize 2 div 0 360 arc
    fill
    1 add
  } forall
} bind def
/colorbar { % xloc yloc colorbar -> []
  /STR 8 string def
  gsave
    xmin xmax add size sub 2 div
    ymin ymax add size sub 2 div translate
    size dup scale
    translate
    0.015 dup scale
    /tics 64 def
    gsave
      10 tics div 1 scale
      0 1 tics
      {
          dup 0 moveto 0.5 add
          tics div range mul
          invert {range exch sub} if
          1 1 sethsbcolor
          1 0 rlineto 0 1 rlineto -1 0 rlineto closepath fill
      } for
    grestore
    0 setgray
    -0.1 1.01 moveto (0) gsave 0.1 dup scale show grestore
    10 1.01 moveto Smax STR cvs
    gsave 0.1 dup scale dup stringwidth pop -2 div 0 rmoveto show grestore
  grestore
} bind def
/S [
] def

/invert false def
drawreliability
0.1 0.1 colorbar
```

## viennarna_rotate_ss

### Tool Description
Rotate or mirror the layout of an RNA secondary structure plot (PostScript _ss.ps).

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/share/ViennaRNA/bin/rotate_ss.pl [-a ANGLE] [-m] FOO_ss.ps > BAR_ss.ps
```

## viennarna_dpzoom

### Tool Description
Zoom into a PostScript dot plot produced by RNAfold, RNAalifold or alidot.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/share/ViennaRNA/bin/dpzoom.pl [-f first] [-l last] [dp_file]
```

## viennarna_mountain

### Tool Description
Produce Pauline Hogeweg's mountain representation from an RNAfold dot plot (_dp.ps): three data sets (pair probability mountain, mfe structure mountain, positional entropy) separated by &.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
-*-Perl-*-
Last changed Time-stamp: <2008-08-26 16:04:00 ivo>
produce Pauline Hogeweg's mountain representation *_dp.ps files
writes 3 sets of x y data separated by a "&"
the first two sets are mountain representations from base pair probabilities
and mfe structure, respectively.
definition: mm[i],mp[i] = (mean) number of base pairs enclosing base i
third set a measure of well-definedness: the entropy of the pair probs of
base i, sp[i] = -Sum p_i * ln(p_i). Well-defined regions have low entropy.

use e.g. as  mountain.pl dot.ps | xmgrace -pipe
```

## viennarna_b2mt

### Tool Description
Produce coordinates for a mountain plot from bracket notation (RNAfold output), as two columns: position and number of enclosing base pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
-*-Perl-*-
Last changed Time-stamp: <2005-03-09 19:38:25 ivo> 
produce Pauline's mountain representation from bracket notation
use e.g. as  RNAfold < foo.seq | b2mt | xmgr -pipe
definition: h=number of base pairs enclosing base
use strict;
while (<>) {
```

## viennarna_coloraln

### Tool Description
Colorize an alignment (CLUSTAL format) with a consensus secondary structure taken from a PostScript structure plot (alirna.ps); compensatory mutations are marked by color.

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: https://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
      coloraln.pl [-r] [-n] [-c columns] [-s structure.ps] file.aln

Options:
    -s file
        read file to extract the consensus structure (default: "alirna.ps")

    -c width
        break alignments into blocks of at most width columns, (default:
        120)

    -t  suppress conversion of "T" to "U", i.e. do not convert DNA to RNA,
        (default: convert to "U")

    -r  add a "ruler" below the alignment showing sequence positions

    -n  write sequence position at the end of each sequence line
```

## Metadata
- **Skill**: generated

## viennarna_RNAcofold

### Tool Description
calculate secondary structures of two RNAs with dimerization

### Metadata
- **Docker Image**: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
- **Homepage**: http://www.tbi.univie.ac.at/RNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/viennarna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RNAcofold [OPTION]... [FILE]...
calculate secondary structures of two RNAs with dimerization

The program works much like RNAfold, but allows one to specify two RNA
sequences which are then allowed to form a dimer structure. RNA sequences are
read from stdin in the usual format, i.e. each line of input corresponds to one
sequence, except for lines starting with '>' which contain the name of the next
sequence.
To compute the hybrid structure of two molecules, the two sequences must be
concatenated using the '&' character as separator.
RNAcofold can compute minimum free energy (mfe) structures, as well as
partition function (pf) and base pairing probability matrix (using the -p
switch)
Since dimer formation is concentration dependent, RNAcofold can be used to
compute equilibrium concentrations for all five monomer and (homo/hetero)-dimer
species, given input concentrations for the monomers.
Output consists of the mfe structure in bracket notation as well as PostScript
structure plots and "dot plot" files containing the pair probabilities, see
the RNAfold man page for details. In the dot plots a cross marks the chain
break between the two concatenated sequences.
The program will continue to read new sequences until a line consisting of the
single character '@' or an end of file condition is encountered.

  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit
  -v, --verbose                 Be verbose.
                                    (default=off)

I/O Options:
  Command line options for input and output (pre-)processing

  -j, --jobs[=number]           Split batch input into jobs and start
                                  processing in parallel using multiple
                                  threads. A value of 0 indicates to use as
                                  many parallel threads as computation cores
                                  are available.
                                    (default=`0')
      --noconv                  Do not automatically substitute nucleotide
                                  "T" with "U".

                                    (default=off)
      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=STRING        Prefix for automatically generated IDs (as used
                                  in output file names).
                                    (default=`sequence')

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated
  in any case.

  -p, --partfunc[=INT]          Calculate the partition function and base
                                  pairing probability matrix in addition to the
                                  mfe structure. Default is calculation of mfe
                                  structure only.
                                    (default=`1')
  -a, --all_pf[=INT]            Compute the partition function and free
                                  energies not only of the hetero-dimer
                                  consisting of the two input sequences (the
                                  'AB dimer'), but also of the homo-dimers AA
                                  and BB as well as A and B monomers.
                                    (default=`1')
  -c, --concentrations          In addition to everything listed under the -a
                                  option, read in initial monomer
                                  concentrations and compute the expected
                                  equilibrium concentrations of the 5 possible
                                  species (AB, AA, BB, A, B).
                                    (default=off)
  -f, --concfile=filename       Specify a file with initial concentrations for
                                  the two sequences.

      --centroid                Compute the centroid structure.
                                    (default=off)
      --MEA[=gamma]             Compute MEA (maximum expected accuracy)
                                  structure.
                                    (default=`1.')
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm.

                                    (default=off)

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program

      --maxBPspan=INT           Set the maximum base pair span.

                                    (default=`-1')
  -C, --constraint[=filename]   Calculate structures subject to constraints.
                                    (default=`')
      --enforceConstraint       Enforce base pairs given by round brackets '('
                                  ')' in structure constraint.

                                    (default=off)
      --shape=filename          Use SHAPE reactivity data to guide structure
                                  predictions.

      --shapeConversion=method  Select method for SHAPE reactivity conversion.

                                    (default=`O')

Energy Parameters:
  Energy parameter sets can be adapted or loaded from user-provided input files

  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.

                                    (default=`37.0')
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.

      --salt=DOUBLE             Set salt concentration in molar (M). Default is
                                  1.021M.

  -m, --modifications[=STRING]  Allow for modified bases within the RNA
                                  sequence string.
                                    (default=`7I6P9D')
      --mod-file=STRING         Use additional modified base data from JSON
                                  file.

Model Details:
  Tweak the energy model and pairing rules additionally using the following
  parameters

  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)

Plotting:
  Command line options for changing the default behavior of structure layout
  and pairing probability plots

      --noPS                    Do not produce postscript drawing of the mfe
                                  structure.

                                    (default=off)

If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```
