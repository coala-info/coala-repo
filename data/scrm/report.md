# scrm CWL Generation Report

## scrm

### Tool Description
Fast & accurate coalescent simulations

### Metadata
- **Docker Image**: quay.io/biocontainers/scrm:1.7.4--h9948957_5
- **Homepage**: https://scrm.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/scrm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scrm/overview
- **Total Downloads**: 27.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
scrm - Fast & accurate coalescent simulations
Version 1.7.4

Usage
--------------------------------------------------------
Call scrm follow by two integers and an arbitrary number
of options described below:

  scrm <n_samp> <n_loci> [...]

Here, n_samp is the total number of samples and n_loci
is the number of independent loci to simulate.

Options
--------------------------------------------------------
A detailed description of these options and their parameters
is provided is the manual.

Recombination:
  -r <R> <L>       Set recombination rate to R and locus length to L.
  -sr <p> <R>      Change the recombination rate R at sequence position p.
  -l <l>           Set the approximation window length to l.

Population Structure:
  -I <npop> <s1> ... <sn> [<M>]   Use an island model with npop populations,
                   where s1 to sn individuals are sampled each population.
                   Optionally assume a symmetric migration rate of M.
  -eI <t> <s1> ... <sn> [<M>]     Sample s1 to sn indiviuals from their
                   corresponding populations at time t.
  -M <M>           Assume a symmetric migration rate of M/(npop-1).
  -eM <t> <M>      Change the symmetric migration rate to M/(npop-1) at time t.
  -m <i> <j> <M>   Set the migration rate from population j to population i to M
  -em <t> <i> <j> <M>   Set the migration rate from population j to
                   population i to M at time t.
  -ma <M11> <M21> ...   Sets the (backwards) migration matrix.
  -ema <t> <M11> <M21> ...    Changes the migration matrix at time t
  -es <t> <i> <p>  Population admixture. Replaces a fraction of 1-p of
                   population i with individuals a from population npop + 1
                   which is ignored afterwards (forward in time). 
  -eps <t> <i> <j> <p>  Partial Population admixture. Replaces a fraction of 1-p of
                   population i with individuals a from population j.
  -ej <t> <i> <j>  Speciation event at time t. Creates population j
                   from individuals of population i.

Population Size Changes:
  -n <i> <n>       Set the present day size of population i to n*N0.
  -en <t> <i> <n>  Change the size of population i to n*N0 at time t.
  -eN <t> <n>      Set the present day size of all populations to n*N0.
  -g <i> <a>       Set the exponential growth rate of population i to a.
  -eg <t> <i> <a>  Change the exponential growth rate of population i to a
                   at time t.
  -G <a>           Set the exponential growth rate of all populations to a.
  -eG <t> <a>      Change the exponential growth rate of all populations to a
                   at time t.

Summary Statistics:
  -t <theta>       Set the mutation rate to theta = 4N0*mu, where mu is the 
                   neutral mutation rate per locus.
  -T               Print the simulated local genealogies in Newick format.
  -O               Print the simulated local genealogies in Oriented Forest format.
  -L               Print the TMRCA and the local tree length for each segment.
  -oSFS            Print the Site Frequency Spectrum for each locus.
  -SC [ms|rel|abs] Scaling of sequence positions. Either
                   relative (rel) to the locus length between 0 and 1,
                   absolute (abs) in base pairs or as in ms (default).
  -init <FILE>     Read genealogies at the beginning of the sequence.

Other:
  -seed <SEED> [<SEED2> <SEED3>]   The random seed to use. Takes up to three
                   integer numbers.
  -p <digits>      Specify the number of significant digits used in the output.
                   Defaults to 6.
  -v, --version    Prints the version of scrm.
  -h, --help       Prints this text.
  -print-model,    
  --print-model    Prints information about the demographic model.

Examples
--------------------------------------------------------
Five independent sites for 10 individuals using Kingman's Coalescent:
  scrm 10 5 -t 10

A sequence of 10kb from 4 individuals under the exact ARG:
  scrm 4 1 -t 10 -r 4 10000

A sequence of 100Mb using the SMC' approximation:
  scrm 4 1 -t 10 -r 4000 100000000 -l 0

Same as above, but with essentially correct linkage:
  scrm 4 1 -t 10 -r 4000 100000000 -l 100000
```


## Metadata
- **Skill**: not generated
