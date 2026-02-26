cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsc27093
label: fastsimcoal2_fsc27093
doc: "fastSimcoal2 (ver 2.7.0.9 - 11.04.22)\n\nTool homepage: http://cmpg.unibe.ch/software/fastsimcoal27/"
inputs:
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: 'output the whole DNA sequence, incl. monomorphic sites '
    inputBinding:
      position: 101
      prefix: --allsites
  - id: ascertainment_deme
    type:
      - 'null'
      - int
    doc: "This is the deme id where ascertainment is performed\n                 \
      \          when simulating SNPs. Default: no ascertainment."
    default: 0
    inputBinding:
      position: 101
      prefix: --ascDeme
  - id: ascertainment_size
    type:
      - 'null'
      - int
    doc: "number of ascertained chromosomes used to define SNPs in\n             \
      \              a given deme. Optional parameter. Default value is 2"
    default: 2
    inputBinding:
      position: 101
      prefix: --ascSize
  - id: brent_tolerance
    type:
      - 'null'
      - float
    doc: "tolerance for Brent optimization\n                           Default = 0.01.
      Smaller value imply more precise estimations\n                           but
      require more computation time (min;max) = (1e-1;1e-5)"
    default: 0.01
    inputBinding:
      position: 101
      prefix: --brentol
  - id: cores
    type:
      - 'null'
      - int
    doc: "number of openMP threads for parameter estimation\n                    \
      \       (default=1, max=numBatches, use 0 to let openMP choose optimal value)"
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: definition_file
    type:
      - 'null'
      - File
    doc: name of parameter definition file (optional)
    inputBinding:
      position: 101
      prefix: --dfile
  - id: definition_file_simple
    type:
      - 'null'
      - File
    doc: "same as -f, but only uses simple parameters defined\n                  \
      \         in template file. Complex params are recomputed"
    inputBinding:
      position: 101
      prefix: --dFile
  - id: derived_site_frequency_spectrum
    type:
      - 'null'
      - boolean
    doc: "computes derived site frequency spectrum\n                           (for
      SNP or DNA as SNP (-s) data only)."
    inputBinding:
      position: 101
      prefix: --dsfs
  - id: dnatosnp
    type:
      - 'null'
      - int
    doc: "output DNA as SNP data, and specify maximum no. of SNPs\n              \
      \             to output (use 0 to output all SNPs)."
    default: 2000
    inputBinding:
      position: 101
      prefix: --dnatosnp
  - id: estimation_file
    type:
      - 'null'
      - File
    doc: "parameter prior definition file (optional)\n                           Parameters
      drawn from specified distributions are \n                           substituted
      into template file."
    inputBinding:
      position: 101
      prefix: --estfile
  - id: folded_sfs
    type:
      - 'null'
      - boolean
    doc: computes the 1D and 2D MAF SFS by simply folding the DAF SFS
    inputBinding:
      position: 101
      prefix: --foldedSFS
  - id: genotypic
    type:
      - 'null'
      - boolean
    doc: generates arlequin projects with genotypic data
    inputBinding:
      position: 101
      prefix: --genotypic
  - id: header
    type:
      - 'null'
      - boolean
    doc: generates header in site frequency spectrum files
    inputBinding:
      position: 101
      prefix: --header
  - id: individual_genotype_table
    type:
      - 'null'
      - boolean
    doc: generates an individual genotype table
    inputBinding:
      position: 101
      prefix: --indgenot
  - id: infinite_site_model
    type:
      - 'null'
      - boolean
    doc: "generates DNA mutations according to an\n                           infinite
      site (IS) mutation model"
    inputBinding:
      position: 101
      prefix: --inf
  - id: initial_values_file
    type:
      - 'null'
      - File
    doc: "specifies a file (*.pv) containing initial parameter values\n          \
      \                 for parameter optimization"
    inputBinding:
      position: 101
      prefix: --initValues
  - id: input_file
    type:
      - 'null'
      - File
    doc: name of parameter file
    inputBinding:
      position: 101
      prefix: --ifile
  - id: jobs
    type:
      - 'null'
      - boolean
    doc: "output one simulated or bootstrapped SFS per file\n                    \
      \       in a separate directory for easier analysis\n                      \
      \     (requires -d or -m and -s0 options)"
    inputBinding:
      position: 101
      prefix: --jobs
  - id: keep_memory
    type:
      - 'null'
      - int
    doc: "number of simulated polymorphic sites kept in memory\n                 \
      \          If the simulated no. is larger, then temporary files\n          \
      \                 are created. Default value is 10000"
    default: 10000
    inputBinding:
      position: 101
      prefix: --keep
  - id: log_precision
    type:
      - 'null'
      - int
    doc: "precision for computation of logs of random numbers. Max value is 23\n \
      \                          Default value is 23 (full precision). Recommended
      lower value is 18"
    default: 23
    inputBinding:
      position: 101
      prefix: --logprecision
  - id: max_likelihood
    type:
      - 'null'
      - boolean
    doc: "perform parameter estimation by max lhood from SFS\n                   \
      \        values between iterations"
    inputBinding:
      position: 101
      prefix: --maxlhood
  - id: min_num_loops
    type:
      - 'null'
      - int
    doc: "number of  loops (ECM cycles) for which the lhood is \n                \
      \           computed on both monomorphic and polymorphic sites\n           \
      \                if REFERENCE parameter is defined"
    default: 2
    inputBinding:
      position: 101
      prefix: --minnumloops
  - id: min_sfs_count
    type:
      - 'null'
      - float
    doc: "minimum observed SFS entry count taken into account in\n               \
      \            likelihood computation (default = 1, but value can be < 1. e.g\
      \  0.5)"
    default: 1
    inputBinding:
      position: 101
      prefix: --minSFSCount
  - id: minor_site_frequency_spectrum
    type:
      - 'null'
      - boolean
    doc: "computes minor site frequency spectrum\n                           (for
      SNP or DNA as SNP (-s) data only)"
    inputBinding:
      position: 101
      prefix: --msfs
  - id: multi_sfs
    type:
      - 'null'
      - boolean
    doc: generate or use multidimensional SFS
    inputBinding:
      position: 101
      prefix: --multiSFS
  - id: no_arlequin_output
    type:
      - 'null'
      - boolean
    doc: does not generate Arlequin output
    inputBinding:
      position: 101
      prefix: --noarloutput
  - id: no_singleton
    type:
      - 'null'
      - boolean
    doc: ignores singletons in likelihood computation
    inputBinding:
      position: 101
      prefix: --nosingleton
  - id: num_batches
    type:
      - 'null'
      - int
    doc: "max. no. of batches for multi-threaded runs\n                          \
      \ (default=12)"
    default: 12
    inputBinding:
      position: 101
      prefix: --numBatches
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: "number of bootstraps to perform on polymorphic sites to extract SFS\n  \
      \                         (should be used in addition to -s0 and -j options)"
    default: 10
    inputBinding:
      position: 101
      prefix: --numboot
  - id: num_estimations
    type:
      - 'null'
      - int
    doc: "number of draws from parameter priors (optional)\n                     \
      \      Listed parameter values are substituted in template file"
    default: 10
    inputBinding:
      position: 101
      prefix: --numest
  - id: num_loops
    type:
      - 'null'
      - int
    doc: "number of loops (ECM cycles) to perform during\n                       \
      \    lhood maximization. Default is 20"
    default: 20
    inputBinding:
      position: 101
      prefix: --numloops
  - id: num_simulations
    type:
      - 'null'
      - int
    doc: "number of simulations to perform\n                           Also applies
      for parameter estimation"
    default: 1000
    inputBinding:
      position: 101
      prefix: --numsims
  - id: output_tree
    type:
      - 'null'
      - boolean
    doc: outputs coalescent tree in nexus format
    inputBinding:
      position: 101
      prefix: --tree
  - id: phased
    type:
      - 'null'
      - boolean
    doc: "specifies that phase is known in arlequin output\n                     \
      \      default: phase is unknown"
    inputBinding:
      position: 101
      prefix: --phased
  - id: pooled_sfs
    type:
      - 'null'
      - boolean
    doc: "computes pooled SFS over all samples.\n                           Assumes
      -d or -m, but not -u flag activated"
    inputBinding:
      position: 101
      prefix: --pooledsfs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: minimal message output to console
    inputBinding:
      position: 101
      prefix: --quiet
  - id: record_mrca
    type:
      - 'null'
      - boolean
    doc: "records tMRCAs for each non recombining segment and outputs\n          \
      \                 results in <generic name>_mrca.txt. Beware: huge slow down
      of computing time"
    inputBinding:
      position: 101
      prefix: --recordMRCA
  - id: remove_zero_sfs
    type:
      - 'null'
      - boolean
    doc: "do not take into account monomorphic sites for SFS\n                   \
      \        likelihood computation"
    inputBinding:
      position: 101
      prefix: --removeZeroSFS
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator (positive integer <= 1E6)
    inputBinding:
      position: 101
      prefix: --seed
  - id: template_file
    type:
      - 'null'
      - File
    doc: name of template parameter file (optional)
    inputBinding:
      position: 101
      prefix: --tplfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastsimcoal2:27093--hdfd78af_0
stdout: fastsimcoal2_fsc27093.out
