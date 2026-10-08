# fastsimbac CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastsimbac | PASS | rewritten from the real help (positional sample size and length); simulation with trees, recombination, two populations and events gives sites and Newick trees; the -F option could not be tried with a valid frequency file |

## fastsimbac

### Tool Description
A fast simulator for sequences under the coalescent with recombination

### Metadata
- **Docker Image**: quay.io/biocontainers/fastsimbac:1.0.1_bd3ad13d8f79--h503566f_7
- **Homepage**: https://bitbucket.org/nicofmay/fastsimbac/
- **Package**: https://anaconda.org/channels/bioconda/packages/fastsimbac/overview
- **Validation**: PASS

### Original Help Text
```text
You did not specify any parameters. You must at least specify the number of chromosomes sampled and the sequence length.
Usage: <samplesize> <region in base pairs> [options]
Options: 
-s <random seed>
-d enable debugging messages
-i <iterations>
-t <mu> (mutation rate per site per 2N generations)
-C <clonalFrame> (the input clonal frame to fix simulations on, sample names must be integers from 0 on)
-b <b> (burn in: sequence length in base pairs to be used to initialize the recombination process)
-r <r> <lambda> (r = recombination (gene conversion) initiation rate per-individual, per-base pair, per-2N generations; lambda = mean length of recombination tract in base pairs)
-x <r2> <lambda2> (r2 = between-species recombination (gene conversion) initiation rate per-individual, per-base pair, per-2N generations; lambda2 = mean length of between-species recombination tract in base pairs)
-T (Print each local tree in Newick format to standard out)
-R <inputfilename> (Tab delimited file where first two columns indicate range of base pair positions scaled to the unit interval and last column is ratio with respect to base line recombination rate)
-F <inputfilename> [0|1] (Tab delimited frequency distribution file where first column indicate range of SNP allele frequencies from previous row to current row and last column is desired bin frequency. Second parameter is 1 if SNPs with derived allele freq > 1.0 should have alleles flipped, 0 otherwise)
-G <alpha> (Assign growth rate alpha across populations where alpha=-log(Np/Nr) )
-I <n> <n1> <n2> .. <mig_rate> (Assign all elements of the migration matrix for n populations.  Values in matrix set to mig_rate/(n-1) )
-m <i> <j> <m>  (Assign i,j-th element of migration matrix to m)
-ma <m_11>..<m_12>..<m_nn> (Assign values to all elements of migration matrix for n populations)
-n <i> <size>   (Pop i has size set to size*N_0) 
-g <i> <alpha>  (If used must appear after -M option)
The following options modify parameters at time t.
-eG <t> <alpha>  (Assign growth rate for all pops at time t)
-eg <t> <i> <alpha>  (Assign growth rate alpha of pop i at time t)
-eM <t> <m> (Assign migrate rate m for all elements of migration matrix at time t)
-em <t> <i> <j> <m_ij> (Assign migration rate for i,j-th element of migration matrix at time t)
-ema <t> <n> <m_11>..<m_12>..<m_nn> (Assign migration rates  within the migration matrix for n populations at time t)
-eN <t> <size> (New pop sizes at time t for all pops where new sizes = size*N_0)
-en <t> <i> <size_i> (New pop size of pop i will be set to (size_i*N_0) at time t)
-es <t> <i> <p> (Split two populations.  At time t, a proportion p of chromosomes from pop i will migrate to a population i+1)
-ej <t> <i> <j> (Join two populations.  At time t all chromosomes migrate from pop i to pop j)
```

