# sciphi CWL Generation Report

## sciphi

### Tool Description
SCIPhI: Single-cell Identification of Polymorphism in Heterogeneous Inter-clonal populations. A tool for tree reconstruction and variant calling from single-cell sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/sciphi:0.1.7--h077b44d_6
- **Homepage**: https://github.com/cbg-ethz/SCIPhI
- **Package**: https://anaconda.org/channels/bioconda/packages/sciphi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sciphi/overview
- **Total Downloads**: 14.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cbg-ethz/SCIPhI
- **Stars**: N/A
### Original Help Text
```text
SCIPhI v0.1.7
Reading the config file: ... Allowed options:

Generic options:
  -h [ --help ]          Print this help

Configuration:
  --in arg               Name of the BAM files used to create the mpileup.
  --il arg               Directory from which to read intermediate results.
  --ex arg               File name of exclusion list (VCF format), containing 
                         loci which should be ignored.
  --me arg               File name of mutations to exclude during the 
                         sequencing error rate estimation (VCF format).
  --inc arg              File name of inclusion list (VCF format) containing 
                         Variants (CHROM, POS, REF, ALT) that should be 
                         included.
  -o arg                 Prefix of output files.
  --ol arg               This option is deprecated. The index will be saved in 
                         a folder specified with -o in "last_index". If 
                         desired, one can continue from here to explore more 
                         search space.
  --sa arg               Sampling step. If a value x different from 0 is 
                         specified, every x iteration, after the burn in phase,
                         an index will be writen to disk to provide a posterior
                         sampling. [0]
  -l arg                 Maximal number of iterations before sampling form the 
                         posterior distribution of the mutation to cell 
                         assignment. [1000000]
  --ls arg               Number of iterations in which the mutation to cell 
                         assignment is sampled. [100000]
  --lz arg               Set to 1 if zygosity should be learned. The zygosity 
                         rate is the fraction of mutations which are homozygous
                         in all cells. [0]
  --zyg arg              Zygosity rate. [0]
  --pr arg               Prior mutation rate [0.0001].
  -u [ --uniq ] arg      Mark loci with this number of cells being mutated as 
                         "PASS". [1]
  -e arg                 Parameter estimation rate, i.e. the fraction of loops 
                         used to estimate the different parameters. [0.2]
  --ur arg               Data usage rate increment steps. In order to speed up 
                         the algorithm one can choose to iteratively add more 
                         and more of the candidate loci while learning the tree
                         model. For example, 0.1 would mean to start with 10% 
                         of the data, then use 20%, and so on. Per default, all
                         data is used from the start. [1]
  --seed arg             Seed for the random number generator. [42]
  -t arg                 Tree score type [m (max), s (sum)]. [s]
  --wildMean arg         Mean error rate. If the sequencing error rate should 
                         not be learned "--ese 0" one can specify it. [0.001]
  --wildOverDis arg      Initial overdispersion for wild type. The 
                         overdispersion is learned during the tree traversal. 
                         [100]
  --mutationOverDis arg  Initial overdispersion for mutant type. The 
                         overdispersion is learned during the tree 
                         traversal.[2]
  --ese arg              Estimate the sequencing error rate. [1]
  --sub arg              PCR substitution rate. An error early during the PCR 
                         amplification can result in high allele fractions. 
                         These are typically filtered out by requiring at least
                         two cells to be mutated. However, sometimes the PCR 
                         error in one cell is a real mutation in others. If in 
                         such a scenario the coverage for the cell with the PCR
                         error is high, SCIPhI will introduce false positives. 
                         This can be avoided by specifying the PCR error rate. 
                         As these events are rather unlikely very small values,
                         such as 0.0000001 should be chosen. In practice 0 
                         works very well.  [0]
  --md arg               Window size in which only x (see option "--mmw") 
                         mutations are allowed to be present. Some sequences 
                         are prone to produce sequencing errors, which can be 
                         avoided by specifying a range in which only x 
                         mutations are allowed. [1]
  --mmw arg              Maximum number of mutations allowed per window. [1]
  --cwm arg              Number of tumor cells required to have a mutation in 
                         order to be called. [2]
  --mnp arg              Number of cells which need to pass the filters 
                         described below. [2]
  --mc arg               Minimum coverage required per cell. [1]
  --ms arg               Minimum number of reads required to support the 
                         alternative. [3]
  --mf arg               Minimum required frequency of reads supporting the 
                         alternative per cell. [0]
  --mff arg              Mean of acceptable variant allele frequency across all
                         cells for a specific locus. Mapping artifacts may 
                         result in low allele frequencies across cells. In 
                         order to filter these events out we apply a 
                         log-likelihood ratio test where the sequencing error 
                         model has a mean of this value. [0.25]
  --bns arg              Loci with up to this number of alternative supporting 
                         reads in the bulk control sample will be skipped as 
                         germline. [2]
  --bnc arg              Minimum required coverage of reads in the bulk control
                         sample. [6]
  --ncf arg              Normal cell filter. Currently there are three options:
                         (0) Do not use the normal cells for filtering; (1) use
                         a simple filtering scheme excluding mutations if the 
                         probability of being mutated is higher than not being 
                         mutated for any cell independently; (2) filter 
                         mutations where the probability that at least one cell
                         is mutated is higher than no cell is mutated. Note 
                         that in contrast to (1) the cells are not independent 
                         and cells with no alternative support need to be 
                         explained via dropout events. [1]
  --mnc arg              Maximum number of control cells allowed to be mutated.
                         [0]
  --unc arg              Use normal cells for tree reconstruction. [false]
```


## Metadata
- **Skill**: generated
