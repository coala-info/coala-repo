# cofold CWL Generation Report

## cofold

### Tool Description
FAIL to generate CWL: cofold not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/cofold:2.0.4--h87f3376_5
- **Homepage**: https://github.com/jujubix/cofold
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/cofold/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jujubix/cofold
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: cofold not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: cofold not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## cofold_CoFold

### Tool Description
Calculate minimum free energy secondary structures and partition function of RNAs

### Metadata
- **Docker Image**: quay.io/biocontainers/cofold:2.0.4--h87f3376_5
- **Homepage**: https://github.com/jujubix/cofold
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
RNAfold 2.0.4

Calculate minimum free energy secondary structures and partition function of 
RNAs

Usage: RNAfold [OPTIONS]...

The program reads RNA sequences from stdin, calculates their minimum free 
energy (mfe) structure and prints to stdout the mfe structure in bracket 
notation and its free energy. If the -p option was given it also computes the 
partition function (pf) and base pairing probability matrix, and prints the 
free energy of the thermodynamic ensemble, the frequency of the mfe structure 
in the ensemble, and the ensemble diversity to stdout.

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
first word (max. 42 char) of the FASTA header will be used for output file 
names. PostScript files "name_ss.ps" and "name_dp.ps" are produced for the 
structure and dot plot, respectively.
Once FASTA input was provided all following sequences must be in FASTA format 
too.
The program will continue to read new sequences until a line consisting of the 
single character @ or an end of file condition is encountered.



  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden 
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit

General Options:
  Below are command line options which alter the general behavior of this 
  program
  

  -C, --constraint              Calculate structures subject to constraints.
                                    (default=off)
      --noconv                  Do not automatically substitude nucleotide 
                                  "T" with "U"
                                  
                                    (default=off)
      --noPS                    Do not produce postscript drawing of the mfe 
                                  structure.
                                  
                                    (default=off)

Algorithms:
  Select additional algorithms which should be included in the calculations.
  The Minimum free energy (MFE) and a structure representative are calculated 
  in any case.
  

  -p, --partfunc[=INT]          Calculate the partition function and base 
                                  pairing probability matrix.
                                    (default=`1')
      --MEA[=gamma]             Calculate an MEA (maximum expected accuracy) 
                                  structure, where the expected accuracy is 
                                  computed from the pair probabilities: each 
                                  base pair (i,j) gets a score 2*gamma*p_ij and 
                                  the score of an unpaired base is given by the 
                                  probability of not forming a pair.
                                    (default=`1.')
  -c, --circ                    Assume a circular (instead of linear) RNA 
                                  molecule.
                                    (default=off)

Model Details:
  -T, --temp=DOUBLE             Rescale energy parameters to a temperature of 
                                  temp C. Default is 37C.
                                  

  -4, --noTetra                 Do not include special tabulated stabilizing 
                                  energies for tri-, tetra- and hexaloop 
                                  hairpins. Mostly for testing.
                                  
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
  -P, --paramFile=paramfile     Read energy parameters from paramfile, instead 
                                  of using the default parameter set.


If in doubt our program is right, nature is at fault.
Comments should be sent to rna@tbi.univie.ac.at.
```

