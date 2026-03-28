# pourrna CWL Generation Report

## pourrna_pourRNA

### Tool Description
Explore RNA energy landscapes

### Metadata
- **Docker Image**: quay.io/biocontainers/pourrna:1.2.0--h6bb024c_0
- **Homepage**: https://github.com/ViennaRNA/pourRNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pourrna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pourrna/overview
- **Total Downloads**: 15.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ViennaRNA/pourRNA
- **Stars**: N/A
### Original Help Text
```text
pourRNA 1.2.0

Explore RNA energy landscapes

Usage: pourRNA [OPTIONS]...

pourRNA takes an RNA sequence as input and explores the landscape topology
locally. This means the flooding algorithm will be applied for each gradient
basin. The partition function for the basin and also for the transitions to
neighbored minima will be calculated during the flooding. This approach
consumes more computations than global flooding, because the contact surface
for two neighbored states is calculated twice. The advantage of pourRNA is,
that the filtering techniques can be calculated locally. The filters are used
to prune non-relevant transitions directly after flooding a gradient basin. As
a result, the transition rates for the filtered landscape topology can be
calculated faster than with global approaches. The advantage increases with
increasing size of the energy landscape.


  -h, --help                    Print help and exit
  -V, --version                 Print version and exit

General Options:
      --sequence=STRING         The RNA sequence of the molecule
                                    (default=`ACUGUAUGCGCGU')
      --start-structure=STRING  the start structure of the exploration defining
                                  the first gradient basin; defaults to the
                                  open chain

      --start-structure-file=STRING
                                File with start structures (one per line)

      --final-structure=STRING  the final structure of the exploration defining
                                  the last gradient basin

      --max-threads=INT         Sets the maximum number of threads for
                                  parallelized computation.

      --skip-diagonal           Skip the computation of the diagonal of the
                                  rate matrix (it can be skipped because some
                                  post-processing tools like treekin compute it
                                  per default).  (default=off)

Filter:
      --filter-best-k=INT       reduces outgoing transitions to the best K for
                                  each gradient basin

      --dynamic-best-k          Increases K if the MFE structure is not
                                  explored.
                                    (default=off)
      --max-neigh-e=DOUBLE      reduces outgoing transitions to the neighbored
                                  minima, for which the energy is lower than
                                  the energy of the current minimum plus the
                                  filter value. (E(neighbored minimum) <
                                  E(current minimum) + filterValue) for each
                                  gradient basin.

      --max-to-queue=INT        Sets the maximum number of states to be stored
                                  in the priority queue of the flooder.

      --max-to-hash=INT         Sets the maximum number of states to be hashed
                                  for a gradient walk.

      --dynamic-max-to-hash     Sets the dynamicMaxToHash variable for
                                  estimating the maximal number of states to be
                                  hashed in a gradient walk, by considering the
                                  maximal available physical memory and the
                                  number of threads. This reduces the
                                  probability of swapping.
                                    (default=off)
      --max-energy=DOUBLE       Sets the maximum energy that a state is allowed
                                  to have to be considered by the flooder (in
                                  kcal/mol).
                                    (default=`5')
      --delta-e=DOUBLE          Set the maximum energy difference that states
                                  in a basin can have w.r.t. the local minimum
                                  (in kcal/mol).
                                    (default=`65536')
      --max-bp-dist-add=INT     Increases the maximum base pair distance for
                                  direct neighbor minima to be explored. Needs
                                  a start structure and a final structure in
                                  order to work. For all discovered minima m
                                  holds: bp_dist(m, start-structure) +
                                  bp_dist(m, final-structure) <
                                  d(start-structure, final-structure) +
                                  maxBPdist_add.
                                  If this parameter is given, the explorative
                                  flooding will not stop at the final
                                  structure! Instead
                                  it will explore all minima on the direct path
                                  and at its borders. This helps to evaluate
                                  optimal refolding paths
                                  in a post-processing step.
                                    (default=`65536')

RNA model parameters:
  -T, --temperature=DOUBLE      Set the temperature for the free energy
                                  calculation (in °C). (If "T" is set and
                                  "B" not, "B" is equals "T").
                                    (default=`37')
  -G, --gas-constant=DOUBLE     Set the gas constant in [kcal/(K*mol)]. You
                                  need this in order to compare the rate matrix
                                  with the results of other tools.
                                  ViennaRNA package: 0.00198717 kcal/(K*mol)
                                  Barriers:          0.00198717 kcal/(K*mol)
                                  ELL Library:       0.0019871588 kcal/(K*mol)
                                    (default=`0.00198717')
  -d, --dangling-end=INT        How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops.
                                    (default=`2')
  -B, --boltzmann-temp=DOUBLE   Set the temperature for the Boltzmann weight
                                  (in °C).
                                    (default=`37')
  -M, --energy-model=INT        Set the energy model. 0=Turner model 2004,
                                  1=Turner model 1999, 2=Andronescu model, 2007
                                    (default=`0')
      --move-set=INT            Move set: 0 = insertion and deletion, 1 = shift
                                  moves, 2 = no lonely pair moves.
                                    (default=`0')

Output files:
      --transition-prob=STRING  If provided, the transition probability matrix
                                  will be written to the given file name or
                                  'STDOUT' when to write to standard output

      --energy-file=STRING      File to store all energies.

      --binary-rates-file=STRING
                                File to store all rates in a treekin readable
                                  format.

      --binary-rates-file-sparse=STRING
                                File to store all rates in a sparse binary
                                  format: First value is the number of states
                                  (uint_32), then <uint_32 from>, <uint_32
                                  number of how many value pairs to>, <value
                                  pair <uint_32 to, double rate from, to>> etc.

      --saddle-file=STRING      Store all saddles in a CSV file.
      --barriers-like-output=STRING
                                Output the rates file and the structures in a
                                  format similar to the tool barriers. For the
                                  same prefix is used for both files.
      --partition-functions=STRING
                                If provided, the partition function matrix will
                                  be written to the given file name.

      --dot-plot=STRING         If provided, the dotPlot will be written to the
                                  given file name. The dotPlot contains the
                                  base pair probabilities for all structures in
                                  the (filtered) energy landscape.

      --dot-plot-per-basin=STRING
                                Creates a dotplot for each gradient basin in
                                  the enrgy landscape. It shows the Maximum
                                  Expected Accuracy (MEA) structure in the
                                  upper right triangle and the basin
                                  representative in the lower left triangle.

  -v, --verbose                 Verbose.
                                    (default=off)
```


## pourrna_RNAsubopt

### Tool Description
calculate suboptimal secondary structures of RNAs

### Metadata
- **Docker Image**: quay.io/biocontainers/pourrna:1.2.0--h6bb024c_0
- **Homepage**: https://github.com/ViennaRNA/pourRNA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pourrna/overview
- **Validation**: PASS

### Original Help Text
```text
RNAsubopt 2.4.11

calculate suboptimal secondary structures of RNAs

Usage: RNAsubopt [OPTIONS]...

reads RNA sequences from stdin and (in the default -e mode) calculates all
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

General Options:
  Command line options which alter the general behavior of this program


  -v, --verbose                 Be verbose

                                    (default=off)
      --noconv                  Do not automatically substitude nucleotide
                                  "T" with "U"

                                    (default=off)
  -i, --infile=<filename>       Read a file instead of reading from stdin

  -o, --outfile[=<filename>]    Print output to file instead of stdout

      --auto-id                 Automatically generate an ID for each sequence.
                                    (default=off)
      --id-prefix=prefix        Prefix for automatically generated IDs (as used
                                  in output file names)

                                    (default=`sequence')

Structure Constraints:
  Command line options to interact with the structure constraints feature of
  this program


      --maxBPspan=INT           Set the maximum base pair span

                                    (default=`-1')
  -C, --constraint[=<filename>] Calculate structures subject to constraints.
                                    (default=`')
      --batch                   Use constraints for multiple sequences.
                                    (default=off)
      --canonicalBPonly         Remove non-canonical base pairs from the
                                  structure constraint

                                    (default=off)
      --enforceConstraint       Enforce base pairs given by round brackets ( )
                                  in structure constraint

                                    (default=off)
      --shape=<filename>        Use SHAPE reactivity data in the folding
                                  recursions (does not work for Zuker
                                  suboptimals and stochastic backtracking yet)


      --shapeMethod=[D/Z/W] + [optional parameters]
                                Specify the method how to convert SHAPE
                                  reactivity data to pseudo energy
                                  contributions
                                    (default=`D')
      --shapeConversion=M/C/S/L/O  + [optional parameters]
                                Specify the method used to convert SHAPE
                                  reactivities to pairing probabilities when
                                  using the SHAPE approach of Zarringhalam et
                                  al.
                                    (default=`O')

Algorithms:
  Select the algorithms which should be applied to the given RNA sequence.


  -e, --deltaEnergy=range       Compute suboptimal structures with energy in a
                                  certain range of the optimum (kcal/mol).
                                  Default is calculation of mfe structure only.


      --deltaEnergyPost=range   Only print structures with energy within range
                                  of the mfe after post reevaluation of
                                  energies.

  -s, --sorted                  Sort the suboptimal structures by energy.
                                    (default=off)
  -p, --stochBT=number          Instead of producing all suboptimals in an
                                  energy range, produce a random sample of
                                  suboptimal structures, drawn with
                                  probabilities equal to their Boltzmann
                                  weights via stochastic backtracking in the
                                  partition function. The -e and -p options are
                                  mutually exclusive.


      --stochBT_en=number       Same as "--stochBT" but also print out the
                                  energies and probabilities of the backtraced
                                  structures.


  -N, --nonRedundant            Enable non-redundant sampling strategy.

                                    (default=off)
  -c, --circ                    Assume a circular (instead of linear) RNA
                                  molecule.

                                    (default=off)
  -D, --dos                     Compute density of states instead of secondary
                                  structures
                                    (default=off)
  -z, --zuker                   Compute Zuker suboptimals instead of all
                                  suboptimal structures within an engery band
                                  around the MFE.

                                    (default=off)
  -g, --gquad                   Incoorporate G-Quadruplex formation into the
                                  structure prediction algorithm
                                  (no support of G-quadruplex prediction for
                                  stochastic backtracking and Zuker-style
                                  suboptimals yet)

                                    (default=off)

Model Details:
  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of
                                  temp C. Default is 37C.


  -4, --noTetra                 Do not include special tabulated stabilizing
                                  energies for tri-, tetra- and hexaloop
                                  hairpins.
                                    (default=off)
  -d, --dangles=INT             How to treat "dangling end" energies for
                                  bases adjacent to helices in free ends and
                                  multi-loops
                                    (default=`2')
      --noLP                    Produce structures without lonely pairs
                                  (helices of length 1).
                                    (default=off)
      --noGU                    Do not allow GU pairs

                                    (default=off)
      --noClosingGU             Do not allow GU pairs at the end of helices

                                    (default=off)
      --logML                   Recalculate energies of structures using a
                                  logarithmic energy function for multi-loops
                                  before output.  (default=off)
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead
                                  of using the default parameter set.


If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```


## Metadata
- **Skill**: generated
