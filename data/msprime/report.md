# msprime CWL Generation Report

## msprime_mspms

### Tool Description
mspms is an ms-compatible interface to the msprime library. It simulates the coalescent with recombination for a variety of demographic models and outputs the results in a text-based format. It supports a subset of the functionality available in ms and aims for full compatibility.

### Metadata
- **Docker Image**: quay.io/biocontainers/msprime:0.4.0--py35_gsl1.16_0
- **Homepage**: https://github.com/tskit-dev/msprime
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msprime/overview
- **Total Downloads**: 76.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tskit-dev/msprime
- **Stars**: N/A
### Original Help Text
```text
usage: mspms [-h] [-V] [--mutation-rate theta] [--trees]
             [--recombination rho num_loci] [--structure value [value ...]]
             [--migration-matrix-entry dest source rate]
             [--migration-matrix entry [entry ...]]
             [--migration-rate-change t x]
             [--migration-matrix-entry-change time dest source rate]
             [--migration-matrix-change entry [entry ...]]
             [--growth-rate alpha]
             [--population-growth-rate population_id alpha]
             [--population-size population_id size]
             [--growth-rate-change t alpha]
             [--population-growth-rate-change t population_id alpha]
             [--size-change t x] [--population-size-change t population_id x]
             [--population-split t dest source]
             [--admixture t population_id proportion]
             [--random-seeds x1 x2 x3] [--precision PRECISION]
             sample_size num_replicates

mspms is an ms-compatible interface to the msprime library. It simulates the
coalescent with recombination for a variety of demographic models and outputs
the results in a text-based format. It supports a subset of the functionality
available in ms and aims for full compatibility.

positional arguments:
  sample_size           The number of individuals in the sample
  num_replicates        Number of independent replicates

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit

Behaviour:
  --mutation-rate theta, -t theta
                        Mutation rate theta=4*N0*mu
  --trees, -T           Print out trees in Newick format
  --recombination rho num_loci, -r rho num_loci
                        Recombination at rate rho=4*N0*r where r is the rate
                        of recombination between the ends of the region being
                        simulated; num_loci is the number of sites between
                        which recombination can occur

Structure and migration:
  --structure value [value ...], -I value [value ...]
                        Sample from populations with the specified deme
                        structure. The arguments are of the form
                        'num_populations n1 n2 ... [4N0m]', specifying the
                        number of populations, the sample configuration, and
                        optionally, the migration rate for a symmetric island
                        model
  --migration-matrix-entry dest source rate, -m dest source rate
                        Sets an entry M[dest, source] in the migration matrix
                        to the specified rate. source and dest are (1-indexed)
                        population IDs. Multiple options can be specified.
  --migration-matrix entry [entry ...], -ma entry [entry ...]
                        Sets the migration matrix to the specified value. The
                        entries are in the order M[1,1], M[1, 2], ..., M[2,
                        1],M[2, 2], ..., M[N, N], where N is the number of
                        populations.
  --migration-rate-change t x, -eM t x
                        Set the symmetric island model migration rate to x /
                        (npop - 1) at time t
  --migration-matrix-entry-change time dest source rate, -em time dest source rate
                        Sets an entry M[dest, source] in the migration matrix
                        to the specified rate at the specified time. source
                        and dest are (1-indexed) population IDs.
  --migration-matrix-change entry [entry ...], -ema entry [entry ...]
                        Sets the migration matrix to the specified value at
                        time t.The entries are in the order M[1,1], M[1, 2],
                        ..., M[2, 1],M[2, 2], ..., M[N, N], where N is the
                        number of populations.

Demography:
  --growth-rate alpha, -G alpha
                        Set the growth rate to alpha for all populations.
  --population-growth-rate population_id alpha, -g population_id alpha
                        Set the growth rate to alpha for a specific
                        population.
  --population-size population_id size, -n population_id size
                        Set the size of a specific population to size*N0.
  --growth-rate-change t alpha, -eG t alpha
                        Set the growth rate for all populations to alpha at
                        time t
  --population-growth-rate-change t population_id alpha, -eg t population_id alpha
                        Set the growth rate for a specific population to alpha
                        at time t
  --size-change t x, -eN t x
                        Set the population size for all populations to x * N0
                        at time t
  --population-size-change t population_id x, -en t population_id x
                        Set the population size for a specific population to x
                        * N0 at time t
  --population-split t dest source, -ej t dest source
                        Move all lineages in population dest to source at time
                        t. Forwards in time, this corresponds to a population
                        split in which lineages in source split into dest. All
                        migration rates for population source are set to zero.
  --admixture t population_id proportion, -es t population_id proportion
                        Split the specified population into a new population,
                        such that the specified proportion of lineages remains
                        in the population population_id. Forwards in time this
                        corresponds to an admixture event. The new population
                        has ID num_populations + 1. Migration rates to and
                        from the new population are set to 0, and growth rate
                        is 0 and the population size for the new population is
                        N0.

Miscellaneous:
  --random-seeds x1 x2 x3, -seeds x1 x2 x3
                        Random seeds (must be three integers)
  --precision PRECISION, -p PRECISION
                        Number of values after decimal place to print

If you use msprime in your work, please cite the following paper: Jerome
Kelleher, Alison M Etheridge and Gilean McVean (2016), "Efficient Coalescent
Simulation and Genealogical Analysis for Large Sample Sizes", PLoS Comput Biol
12(5): e1004842. doi: 10.1371/journal.pcbi.1004842
```

