# secedo CWL Generation Report

## secedo

### Tool Description
secedo -i <input_dir> -o <output_dir> arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/secedo:1.0.7--ha041835_4
- **Homepage**: https://github.com/ratschlab/secedo
- **Package**: https://anaconda.org/channels/bioconda/packages/secedo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/secedo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-10-02
- **GitHub**: https://github.com/ratschlab/secedo
- **Stars**: N/A
### Original Help Text
```text
secedo: secedo -i <input_dir> -o <output_dir> arguments

  Flags from /opt/conda/conda-bld/secedo_1759410852252/work/secedo_main.cpp:
    -arma_kmeans (Whether to use Armadillo's k-means implementation or our own
      (which is very simple, but it weights the Fiedler vector higher, reducing
      the effect of the curse of dimensionality) type: bool default: false
    -chromosomes (The chromosomes on which to run the algorithm) type: string
      default: "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X"
    -clustering (If provided read the clustering from this file and only
      perform variant calling) type: string default: ""
    -clustering_type (How to perform spectral clustering. One of FIEDLER,
      SPECTRAL2, SPECTRAL6. See spectral_clustering.hpp for details.)
      type: string default: "SPECTRAL6"
    -compute_read_stats (If set to true, the algorithm will compute the maximum
      fragment length and the longest fragment for each pileup file
      (expensive)) type: bool default: false
    -expectation_maximization (If true, the spectral clustering results will be
      refined using an Expectation Maximization algorithm) type: bool
      default: false
    -heterozygous_prob (The probability that a locus is heterozygous in the
      human genome) type: double default: 0.001
    -homozygous_filtered_rate (The fraction of homozygous non-informative loci,
      i.e. the probability that cells at a filtered locus actually have
      identical homozygous genotype.) type: double default: 0.5
    -i (Input file or directory containing 'pileup' textual or binary format
      from an alignment, as written by preprocessing.py) type: string
      default: "./"
    -labels_file (Input file containing labels) type: string default: ""
    -log_level (The log verbosity: debug, trace, info, warn, error, critical,
      off) type: string default: "trace"
    -map_file (If not empty, maps positions in --reference_genome to positions
      in the haploid genome that --reference_genome is based on (e.g. to
      GRCh38)) type: string default: ""
    -max_cell_count (Maximum expected cell count, used to initialize the cell
      grouping) type: uint32 default: 10000
    -max_coverage (Positions with higher coverage are considered anomalies and
      discarded) type: uint32 default: 100
    -merge_count (Pool data from  merge_count consecutive cells as if they were
      a single cell, in  order to artificially increase coverage. Only works on
      synthetic data where we know consecutive cells are part of the same
      cluster!) type: uint32 default: 1
    -merge_file (File containing cell grouping. Cells in the same group are
      treated as if they were a single cell. Useful for artificially increasing
      coverage for testing.) type: string default: ""
    -min_cluster_size (Stop clustering when the size of a cluster is below this
      value) type: uint32 default: 100
    -mutation_rate (epsilon, estimated frequency of mutated loci in the
      pre-processed data set) type: double default: 0.01
    -normalization (How to normalize the similarity matrix. One of ADD_MIN,
      EXPONENTIATE, SCALE_MAX_1) type: string default: "ADD_MIN"
    -num_threads (Number of threads to use) type: uint32 default: 8
    -o (Directory where the output will be written.) type: string default: "./"
    -pos_file (When present, only consider positions in this file. The file
      must have 2 columns, first one is chromosome id, second is position.)
      type: string default: ""
    -reference_genome (The genome against which variants are called, if
      provided. The fasta file must have 2x24 sections, with the maternal
      chromosome being followed by the paternal chromosome) type: string
      default: ""
    -seq_error_rate (Sequencing errors rate, denoted by theta) type: double
      default: 0.01
    -termination (Which criteria to use for determining if a Simple or
      Multivariate Gaussian matches the data better (AIC/BIC)) type: string
      default: "BIC"
    -tumor_purity (Estimated tumor purity (proportion of healthy vs total
      cells). Only used in the first level of clustering. Values can be
      1->10%/90%, 2->20%/80%, 3->30%/70%, 4->40%/60% or 5->50%) type: uint32
      default: 5



  Flags from /opt/conda/conda-bld/secedo_1759410852252/work/third_party/gflags/src/gflags.cc:
    -flagfile (load flags from file) type: string default: ""
    -fromenv (set flags from the environment [use 'export FLAGS_flag1=value'])
      type: string default: ""
    -tryfromenv (set flags from the environment if present) type: string
      default: ""
    -undefok (comma-separated list of flag names that it is okay to specify on
      the command line even if the program does not define a flag with that
      name.  IMPORTANT: flags in this list that have arguments MUST use the
      flag=value format) type: string default: ""

  Flags from /opt/conda/conda-bld/secedo_1759410852252/work/third_party/gflags/src/gflags_completions.cc:
    -tab_completion_columns (Number of columns to use in output for tab
      completion) type: int32 default: 80
    -tab_completion_word (If non-empty, HandleCommandLineCompletions() will
      hijack the process and attempt to do bash-style command line flag
      completion on this value.) type: string default: ""

  Flags from /opt/conda/conda-bld/secedo_1759410852252/work/third_party/gflags/src/gflags_reporting.cc:
    -help (show help on all flags [tip: all flags can have two dashes])
      type: bool default: false currently: true
    -helpfull (show help on all flags -- same as -help) type: bool
      default: false
    -helpmatch (show help on modules whose name contains the specified substr)
      type: string default: ""
    -helpon (show help on the modules named by this flag value) type: string
      default: ""
    -helppackage (show help on all modules in the main package) type: bool
      default: false
    -helpshort (show help on only the main module for this program) type: bool
      default: false
    -helpxml (produce an xml version of help) type: bool default: false
    -version (show version and build info and exit) type: bool default: false
```

