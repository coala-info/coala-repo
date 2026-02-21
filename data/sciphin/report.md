# sciphin CWL Generation Report

## sciphin

### Tool Description
SCIPhIN: Single-cell Inference of Phylogeny and INdividual mutations

### Metadata
- **Docker Image**: quay.io/biocontainers/sciphin:1.0.1--h077b44d_4
- **Homepage**: https://github.com/cbg-ethz/SCIPhI
- **Package**: https://anaconda.org/channels/bioconda/packages/sciphin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sciphin/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cbg-ethz/SCIPhI
- **Stars**: N/A
### Original Help Text
```text
SCIPhIN v1.0.0
Reading the config file: ... Allowed options:

Generic options:
  -h [ --help ]          Print this help

Configuration:
  --im arg               input mpileup
  --il arg               Directory from which to read intermediate results.
  --ol arg               Directory to store intermediate results.
  --ex arg               Filename of exclusion list (VCF format).
  --me arg               Filename of mutations to exclude during the sequencing
                         error rate estimation (VCF format).
  --in arg               Name of the BAM files used to create the mpileup.
  -o arg                 Prefix of output files.
  -l arg                 Maximal number of iterations per repetition. [1000000]
  --lz arg               Set to 1 if zygosity should be learned. [0]
  --zyg arg              Zygosity rate. [0]
  --sa arg               Sampling step. If a value x different from 0 is 
                         specified, every x iteration, after the burn in phase,
                         an index will be writen to disk to provide a posterior
                         sampling. [0]
  --inc arg              File name of inclusion list (VCF format) containing 
                         Variants (CHROM, POS, REF, ALT) that should be 
                         included.
  --ls arg               Number of sample iterations. [100000]
  --pr arg               Prior mutation rate [0.0001].
  -u [ --uniq ] arg      Filter mutations showing up to this number of cells 
                         from the VCF. [0]
  -e arg                 Paramter estimation rate, i.e. the fraction of loops 
                         used to estimate the different parameters. [0.2]
  --ur arg               Data usage rate increment steps. [0.1]
  --seed arg             Seed for the random number generator. [42]
  -t arg                 Tree score type [m (max), s (sum)]. [s]
  --wildOverDis arg      Overdispersion for wild type. [100]
  --mutationOverDis arg  Overdispersion for mutant type. [2]
  --wildMean arg         Mean error rate. [0.001]
  --md arg               Window size for maximum number of allowed mutations. 
                         [1]
  --sub arg              PCR substitution rate. [0]
  --mmw arg              Maximum number of mutations allowed per window. [1]
  --cwm arg              Number of cells requiered to have a mutation in order 
                         to be called. [2]
  --ncf arg              Normal cell filter. Currently there are three options:
                         (0) Do not use the normal cells for filtering; (1) use
                         a simple filtering scheme excluding mutations if the 
                         probability of being mutated is higher than not being 
                         mutated for any cell independently; (2) filter 
                         mutations where the probility that at least one cell 
                         is mutated is higher than no cell is mutated. Note 
                         that in contrast to (1) the cells are not independent 
                         and cells with no alternative support need to be 
                         explained via dropout events. [2]
  --mc arg               Minimum coverage required per cell. [1]
  --mnp arg              Number of cells which need to pass the filters.
  --ms arg               Minimum number of reads required to support the 
                         alternative. [0]
  --mf arg               Minimum required frequency of reads supporting the 
                         alternative per cell. [0]
  --mff arg              Mean of acceptable variant allele frequency across all
                         cells for a specific locus. [0.25]
  --bns arg              Loci with up to this number of alternative supporting 
                         reads in the bulk control sample will be skiped. [2]
  --bnc arg              Minimum required coverage of reads in the bulk control
                         sample. [6]
  --mnc arg              Maximum number of control cells allowed to be mutated.
                         [0]
  --unc arg              Use normal cells for tree reconstruction. [false]
  --ll arg               Compute the loss score = allow a mutation to be lost 
                         in a subtree.
  --lp arg               Compute the parallel score = allow a mutation to be 
                         acquired twice independently in the tree.
  --llp arg              Penalty when computing the loss score.
  --lpp arg              Penalty when computing the parallel score.
  --ese arg              Estimate the sequencing error rate. [1]
  --mlm arg              Use the maximum likelihood mode instead of the MCMC 
                         approach. [false]
  --chi arg              Learn the loss and parallel priors. [false]
```


## Metadata
- **Skill**: generated
