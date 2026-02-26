# treekin CWL Generation Report

## treekin

### Tool Description
Compute biopolymer macrostate dynamics

### Metadata
- **Docker Image**: quay.io/biocontainers/treekin:0.5.1--hf3d7b6d_4
- **Homepage**: https://www.tbi.univie.ac.at/RNA/Barriers/
- **Package**: https://anaconda.org/channels/bioconda/packages/treekin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treekin/overview
- **Total Downloads**: 35.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
treekin 0.5.1

Compute biopolymer macrostate dynamics

Usage: treekin [OPTIONS]... [FILES]...

treekin computes a reduced dynamics of biopolymer folding by means of numeric
integration of a Markov process that generally operates at the level of
macrostates, i.e. basins of attraction of the underlying energy landscape.

treekin expects a .bar file via stdin, and optionally a rates file in the
current working directory. Both the .bar file and the rates file (default name
is rates.out) can be obtained from barriers. In case of -m I option (default)
the program needs just the rate file provided as standard input.

  -h, --help                   Print help and exit
  -V, --version                Print version and exit
  -a, --absorb=state           Make a state absorbing
  -m, --method=STRING          Select method to build transition matrix:
                                 A ==> Arrhenius-like kinetics

                                 I ==> use input as a rate matrix  (possible
                                 values="A", "I" default=`I')
      --num-err=STRING         Specify how to treat issues with numerical
                                 errors in probability:
                                 I ==> Ignore
                                 H ==> Halt the program
                                 R ==> Rescale the probability  (possible
                                 values="I", "H", "R" default=`H')
      --t0=time                Start time  (default=`0.1')
      --t8=time                Stop time  (default=`1E12')
  -T, --Temp=DOUBLE            Temperature in Celsius  (default=`37.0')
  -n, --nstates=INT            Read only first <int> states (assume
                                 quasi-stationary distribution (derivation of
                                 others is = 0))
      --p0=STRING              Set initial population of state <int> to
                                 <double>
                                 Can be given multiple times
                                 (NOTE: sum of <double> must equal 1)
                                 (example: "--p0 2=1.0" - state 2 has initial
                                 population 100 percent)
      --tinc=DOUBLE            Time scaling factor (for log time-scale)
                                 (default=`1.02')
      --degeneracy             Consider degeneracy in transition rates
                                 (default=off)
      --exponent               Use matrix-expontent routines, rather than
                                 diagonalization  (default=off)
      --dumpU                  Dump transition matrix U to file mx.txt (and to
                                 binary mx.bin - not fixed yet)  (default=off)
      --mathematicamatrix      Dump transition matrix U to Mathematica-readable
                                 file mxMat.txt  (default=off)
  -b, --bin                    Assume binary rates input  (default=off)
  -B, --bar=STRING             Read barriers input from file instead of
                                 standard input. Required in case "-m I"
                                 (rates kinetics) AND "-a" (absorbing state)
                                 is given
  -t, --fpt=STRING             Compute first passage times (FPT). Arguments:
                                 all => compute all FPT (slow)
                                 <num> - compute FPT to state <num> from all
                                 states
  -r, --recoverE               Recover from pre-ccomputes eigenvalues and
                                 eigenvectors  (default=off)
  -e, --dumpE                  Dump eigenvalues and eigenvectors to a binary
                                 recovery file and continue with iteration
                                 (default=off)
  -x, --dumpX                  Dump eigenvalues to ASCII file and exit (do not
                                 iterate)  (default=off)
      --info                   Show settings  (default=off)
  -f, --ratesfile=STRING       Read transition rates from file instead of
                                 standard input.
  -v, --verbose                Verbose output  (default=off)
  -q, --quiet                  Be silent (do not print out the output)
                                 (default=off)
      --fptfile=STRING         Filename of FPT file (provided -t option given)
      --visualize=STRING       Filename where to print a visualization of rate
                                 graph (without file subscript, two files will
                                 be generated: .dot and .eps with text and
                                 visual representation of graph)
      --just-shorten           Do not diagonalize and iterate, just shorten
                                 input (meaningfull only with -n X option or
                                 -fpt option or --visualize option)
                                 (default=off)
      --max-decrease=INT       Maximal decrease in dimension in one step
                                 (default=`1000000')
      --feps=DOUBLE            Machine precision used by LAPACK routines (and
                                 matrix aritmetic) -- if set to negative
                                 number, the lapack suggested value is used
                                 (2*DLAMCH("S") )  (default=`1E-15')
      --useplusI               Use old treekin computation where we add
                                 identity matrix to transition matrix.
                                 Sometimes less precise (maybe sometimes also
                                 more precise), in normal case it should not
                                 affect results at all.  (default=off)
      --minimal-rate=DOUBLE    Rescale all rates to be higher than the minimal
                                 rate using formula  "rate ->
                                 rate^(ln(desired_minimal_rate)/ln(minimal_rate))",
                                 where desired_minimal_rate is from input,
                                 minimal_rate is the lowest from all rates in
                                 rate matrix.
      --hard-rescale=DOUBLE    Rescale all rates by a hard exponent (usually
                                 0.0<HR<1.0). Formula: "rate ->
                                 rate^(hard-rescale)". Overrides
                                 --minimal-rate argument.
      --equil-file=STRING      Write equilibrium distribution into a file.
      --times=DOUBLE           Multiply rates with a constant number.
      --warnings               Turn all the warnings about underflow on.
                                 (default=off)
  -c, --mlapack-precision=INT  Number of bits for the eigenvalue method of the
                                 mlapack library. A value > 64 is recommended,
                                 otherwise the standard lapack method would be
                                 faster.
      --mlapack-method=STRING  The mlapack precision method. "LD", "QD",
                                 "DD", "DOUBLE", "GMP", "MPFR",
                                 "FLOAT128". You have to set
                                 mlapack-precision if "GMP", "MPFR" is
                                 selected! "LD" is the standard long double
                                 with 80 bit.
```


## Metadata
- **Skill**: generated
