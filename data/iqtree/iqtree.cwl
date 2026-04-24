cwlVersion: v1.2
class: CommandLineTool
baseCommand: iqtree
label: iqtree
doc: "IQ-TREE version 3.0.1 for Linux x86 64-bit built Jul  9 2025\nDeveloped by Bui
  Quang Minh, Thomas Wong, Nhan Ly-Trong, Huaiyan Ren\nContributed by Lam-Tung Nguyen,
  Dominik Schrempf, Chris Bielow,\nOlga Chernomor, Michael Woodhams, Diep Thi Hoang,
  Heiko Schmidt\n\nTool homepage: http://www.iqtree.org"
inputs:
  - id: alignment
    type:
      - 'null'
      - type: array
        items: File
    doc: PHYLIP/FASTA/NEXUS/CLUSTAL/MSF alignment file(s)
    inputBinding:
      position: 101
      prefix: -s
  - id: alignment_dir
    type:
      - 'null'
      - Directory
    doc: Directory of alignment files
    inputBinding:
      position: 101
      prefix: -s
  - id: alisim_branch_distribution
    type:
      - 'null'
      - string
    doc: "Specify a distribution, from which branch lengths of the input trees\n \
      \                           are randomly generated and overridden."
    inputBinding:
      position: 101
      prefix: --branch-distribution
  - id: alisim_branch_lengths
    type:
      - 'null'
      - string
    doc: "Specify three numbers: minimum, mean and maximum branch lengths\n      \
      \                      when generating a random tree"
    inputBinding:
      position: 101
      prefix: -rlen
  - id: alisim_branch_scale
    type:
      - 'null'
      - float
    doc: Specify a value to scale all branch lengths
    inputBinding:
      position: 101
      prefix: --branch-scale
  - id: alisim_distribution_file
    type:
      - 'null'
      - File
    doc: "Supply a definition file of distributions,\n                           \
      \ which could be used to generate random model parameters"
    inputBinding:
      position: 101
      prefix: --distribution
  - id: alisim_fundi
    type:
      - 'null'
      - string
    doc: Specify a list of taxa, and Rho (Fundi weight) for FunDi model
    inputBinding:
      position: 101
      prefix: --fundi
  - id: alisim_gz_compress
    type:
      - 'null'
      - boolean
    doc: Enable output compression but taking longer running time
    inputBinding:
      position: 101
      prefix: -gz
  - id: alisim_indel
    type:
      - 'null'
      - string
    doc: "Set the insertion and deletion rate of the indel model,\n              \
      \              relative to the substitution rate"
    inputBinding:
      position: 101
      prefix: --indel
  - id: alisim_indel_size
    type:
      - 'null'
      - string
    doc: Set the insertion and deletion size distributions
    inputBinding:
      position: 101
      prefix: --indel-size
  - id: alisim_input_alignment
    type:
      - 'null'
      - File
    doc: Specify the input sequence alignment
    inputBinding:
      position: 101
      prefix: -s
  - id: alisim_length
    type:
      - 'null'
      - int
    doc: Set the length of the root sequence
    inputBinding:
      position: 101
      prefix: --length
  - id: alisim_mdef_file
    type:
      - 'null'
      - File
    doc: Name of a NEXUS model file to define new models (see Manual)
    inputBinding:
      position: 101
      prefix: --mdef
  - id: alisim_model
    type:
      - 'null'
      - string
    doc: Specify the evolutionary model. See Manual for more detail
    inputBinding:
      position: 101
      prefix: --m
  - id: alisim_no_copy_gaps
    type:
      - 'null'
      - boolean
    doc: 'Disable copying gaps from input alignment (default: false)'
    inputBinding:
      position: 101
      prefix: --no-copy-gaps
  - id: alisim_no_unaligned
    type:
      - 'null'
      - boolean
    doc: "Disable outputing a file of unaligned sequences \n                     \
      \       when using indel models"
    inputBinding:
      position: 101
      prefix: --no-unaligned
  - id: alisim_num_alignments
    type:
      - 'null'
      - int
    doc: Set the number of output datasets
    inputBinding:
      position: 101
      prefix: --num-alignments
  - id: alisim_output_format
    type:
      - 'null'
      - string
    doc: 'Set the output format (default: phylip)'
    inputBinding:
      position: 101
      prefix: -af
  - id: alisim_output_prefix
    type:
      - 'null'
      - string
    doc: Activate AliSim and specify the output alignment filename
    inputBinding:
      position: 101
      prefix: --alisim
  - id: alisim_partition_equal
    type:
      - 'null'
      - File
    doc: Like -p but edge-linked equal partition model
    inputBinding:
      position: 101
      prefix: -q
  - id: alisim_partition_file
    type:
      - 'null'
      - File
    doc: "NEXUS/RAxML partition file\n                            Edge-linked proportional
      partition model"
    inputBinding:
      position: 101
      prefix: -p
  - id: alisim_partition_unlinked
    type:
      - 'null'
      - File
    doc: Like -p but edge-unlinked partition model
    inputBinding:
      position: 101
      prefix: -Q
  - id: alisim_random_tree
    type:
      - 'null'
      - string
    doc: Specify the model and the number of taxa to generate a random tree
    inputBinding:
      position: 101
      prefix: -t
  - id: alisim_root_seq_file
    type:
      - 'null'
      - File
    doc: Specify the root sequence from an alignment
    inputBinding:
      position: 101
      prefix: --root-seq
  - id: alisim_seed
    type:
      - 'null'
      - int
    doc: "Random seed number (default: CPU clock)\n                            Be
      careful to make the AliSim reproducible,\n                            users
      should specify the seed number"
    inputBinding:
      position: 101
      prefix: --seed
  - id: alisim_seqtype
    type:
      - 'null'
      - string
    doc: "BIN, DNA, AA, CODON, MORPH{NUM_STATES} (default: auto-detect)\n        \
      \                    For morphological data, 0<NUM_STATES<=32"
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: alisim_single_output
    type:
      - 'null'
      - boolean
    doc: Output all alignments into a single file
    inputBinding:
      position: 101
      prefix: --single-output
  - id: alisim_site_freq
    type:
      - 'null'
      - string
    doc: "Specify the option (MEAN (default), or SAMPLING, or MODEL)\n           \
      \                 to mimic the site-frequencies for mixture models from\n  \
      \                          the input alignment (see Manual)"
    inputBinding:
      position: 101
      prefix: --site-freq
  - id: alisim_site_rate
    type:
      - 'null'
      - string
    doc: "Specify the option (MEAN (default), or SAMPLING, or MODEL)\n           \
      \                 to mimic the discrete rate heterogeneity from\n          \
      \                  the input alignment (see Manual)"
    inputBinding:
      position: 101
      prefix: --site-rate
  - id: alisim_sub_level_mixture
    type:
      - 'null'
      - boolean
    doc: Enable the feature to simulate substitution-level mixture model
    inputBinding:
      position: 101
      prefix: --sub-level-mixture
  - id: alisim_tree_file
    type:
      - 'null'
      - File
    doc: Set the input tree file name
    inputBinding:
      position: 101
      prefix: -t
  - id: alisim_write_all
    type:
      - 'null'
      - boolean
    doc: Enable outputting internal sequences
    inputBinding:
      position: 101
      prefix: --write-all
  - id: allnni
    type:
      - 'null'
      - boolean
    doc: 'Perform more thorough NNI search (default: OFF)'
    inputBinding:
      position: 101
      prefix: --allnni
  - id: alninfo
    type:
      - 'null'
      - boolean
    doc: Print alignment sites statistics to .alninfo
    inputBinding:
      position: 101
      prefix: -alninfo
  - id: alpha_min
    type:
      - 'null'
      - float
    doc: 'Min Gamma shape parameter for site rates (default: 0.02)'
    inputBinding:
      position: 101
      prefix: --alpha-min
  - id: alrt_parametric
    type:
      - 'null'
      - boolean
    doc: Parametric aLRT test (Anisimova and Gascuel 2006)
    inputBinding:
      position: 101
      prefix: --alrt
  - id: alrt_replicates
    type:
      - 'null'
      - int
    doc: Replicates for SH approximate likelihood ratio test
    inputBinding:
      position: 101
      prefix: --alrt
  - id: ancestral_reconstruction
    type:
      - 'null'
      - boolean
    doc: Ancestral state reconstruction by empirical Bayes
    inputBinding:
      position: 101
      prefix: --ancestral
  - id: approximate_bayes
    type:
      - 'null'
      - boolean
    doc: approximate Bayes test (Anisimova et al. 2011)
    inputBinding:
      position: 101
      prefix: --abayes
  - id: asr_min_prob
    type:
      - 'null'
      - float
    doc: 'Min probability of ancestral state (default: equil freq)'
    inputBinding:
      position: 101
      prefix: --asr-min
  - id: assign_support
    type:
      - 'null'
      - File
    doc: Assign support values into this tree from -t trees
    inputBinding:
      position: 101
      prefix: --support
  - id: assign_suptag
    type:
      - 'null'
      - string
    doc: Node name (or ALL) to assign tree IDs where node occurs
    inputBinding:
      position: 101
      prefix: --suptag
  - id: bcor_coefficient
    type:
      - 'null'
      - float
    doc: 'Minimum correlation coefficient (default: 0.99)'
    inputBinding:
      position: 101
      prefix: --bcor
  - id: beps_tiebreak
    type:
      - 'null'
      - float
    doc: 'RELL epsilon to break tie (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --beps
  - id: blmax_optimization
    type:
      - 'null'
      - float
    doc: Max branch length for optimization (default 100)
    inputBinding:
      position: 101
      prefix: -blmax
  - id: blmin_optimization
    type:
      - 'null'
      - float
    doc: Min branch length for optimization (default 0.000001)
    inputBinding:
      position: 101
      prefix: -blmin
  - id: bnni_optimize
    type:
      - 'null'
      - boolean
    doc: Optimize UFBoot trees by NNI on bootstrap alignment
    inputBinding:
      position: 101
      prefix: --bnni
  - id: bootstrap_consensus_replicates
    type:
      - 'null'
      - int
    doc: Replicates for bootstrap + consensus tree
    inputBinding:
      position: 101
      prefix: --bcon
  - id: bootstrap_only_replicates
    type:
      - 'null'
      - int
    doc: Replicates for bootstrap only
    inputBinding:
      position: 101
      prefix: --bonly
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: Replicates for bootstrap + ML tree + consensus tree
    inputBinding:
      position: 101
      prefix: -b
  - id: burnin_trees
    type:
      - 'null'
      - int
    doc: Burnin number of trees to ignore
    inputBinding:
      position: 101
      prefix: --burnin
  - id: cf_quartet
    type:
      - 'null'
      - boolean
    doc: Write sCF for all resampled quartets to .cf.quartet
    inputBinding:
      position: 101
      prefix: --cf-quartet
  - id: cf_verbose
    type:
      - 'null'
      - boolean
    doc: Write CF per tree/locus to cf.stat_tree/_loci
    inputBinding:
      position: 101
      prefix: --cf-verbose
  - id: clock_sd
    type:
      - 'null'
      - float
    doc: 'Std-dev for lognormal relaxed clock (default: 0.2)'
    inputBinding:
      position: 101
      prefix: --clock-sd
  - id: cmax_categories
    type:
      - 'null'
      - int
    doc: 'Max categories for FreeRate model [+R] (default: 10)'
    inputBinding:
      position: 101
      prefix: --cmax
  - id: cmin_categories
    type:
      - 'null'
      - int
    doc: 'Min categories for FreeRate model [+R] (default: 2)'
    inputBinding:
      position: 101
      prefix: --cmin
  - id: complex_model_ascertainment
    type:
      - 'null'
      - boolean
    doc: Ascertainment bias correction
    inputBinding:
      position: 101
      prefix: -m
  - id: complex_model_freq_mixture
    type:
      - 'null'
      - string
    doc: Frequency mixture model with K components
    inputBinding:
      position: 101
      prefix: -m
  - id: complex_model_mixture
    type:
      - 'null'
      - string
    doc: Mixture model with K components
    inputBinding:
      position: 101
      prefix: -m
  - id: compute_connet
    type:
      - 'null'
      - boolean
    doc: Computing consensus network to .nex file
    inputBinding:
      position: 101
      prefix: --con-net
  - id: compute_contree
    type:
      - 'null'
      - boolean
    doc: Compute consensus tree to .contree file
    inputBinding:
      position: 101
      prefix: --con-tree
  - id: concordance_factor_tree
    type:
      - 'null'
      - File
    doc: Reference tree to assign concordance factor
    inputBinding:
      position: 101
      prefix: -t
  - id: consensus_trees
    type:
      - 'null'
      - File
    doc: Set of input trees for consensus reconstruction
    inputBinding:
      position: 101
      prefix: -t
  - id: constant_patterns
    type:
      - 'null'
      - string
    doc: Add constant patterns into alignment (N=no. states)
    inputBinding:
      position: 101
      prefix: -fconst
  - id: constraint_tree
    type:
      - 'null'
      - File
    doc: (Multifurcating) topological constraint tree file
    inputBinding:
      position: 101
      prefix: -g
  - id: cptime
    type:
      - 'null'
      - int
    doc: 'Minimum checkpoint interval (default: 60 sec and adapt)'
    inputBinding:
      position: 101
      prefix: --cptime
  - id: date_ci_replicates
    type:
      - 'null'
      - int
    doc: Number of replicates to compute confidence interval
    inputBinding:
      position: 101
      prefix: --date-ci
  - id: date_file
    type:
      - 'null'
      - File
    doc: File containing dates of tips or ancestral nodes
    inputBinding:
      position: 101
      prefix: --date
  - id: date_no_outgroup
    type:
      - 'null'
      - boolean
    doc: Exclude outgroup from time tree
    inputBinding:
      position: 101
      prefix: --date-no-outgroup
  - id: date_options
    type:
      - 'null'
      - string
    doc: Extra options passing directly to LSD2
    inputBinding:
      position: 101
      prefix: --date-options
  - id: date_outlier_cutoff
    type:
      - 'null'
      - float
    doc: Z-score cutoff to remove outlier tips/nodes (e.g. 3)
    inputBinding:
      position: 101
      prefix: --date-outlier
  - id: date_root
    type:
      - 'null'
      - string
    doc: Root date as a real number or YYYY-MM-DD
    inputBinding:
      position: 101
      prefix: --date-root
  - id: date_taxname
    type:
      - 'null'
      - string
    doc: Extract dates from taxon names after last '|'
    inputBinding:
      position: 101
      prefix: --date
  - id: date_tip
    type:
      - 'null'
      - string
    doc: Tip dates as a real number or YYYY-MM-DD
    inputBinding:
      position: 101
      prefix: --date-tip
  - id: dating_method
    type:
      - 'null'
      - string
    doc: 'Dating method: LSD for least square dating (default)'
    inputBinding:
      position: 101
      prefix: --dating
  - id: df_tree
    type:
      - 'null'
      - boolean
    doc: Write discordant trees associated with gDF1
    inputBinding:
      position: 101
      prefix: --df-tree
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Likelihood epsilon for parameter estimate (default 0.01)
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: fast_search
    type:
      - 'null'
      - boolean
    doc: Fast search to resemble FastTree
    inputBinding:
      position: 101
      prefix: --fast
  - id: fix_branch_lengths
    type:
      - 'null'
      - boolean
    doc: Fix branch lengths of user tree passed via -te
    inputBinding:
      position: 101
      prefix: -blfix
  - id: fix_iterations
    type:
      - 'null'
      - int
    doc: 'Fix number of iterations to stop (default: OFF)'
    inputBinding:
      position: 101
      prefix: -n
  - id: freq_empirical
    type:
      - 'null'
      - boolean
    doc: Empirically counted frequencies from alignment
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_equal
    type:
      - 'null'
      - boolean
    doc: Equal frequencies
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_f1x4
    type:
      - 'null'
      - boolean
    doc: Equal NT frequencies over three codon positions
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_f3x4
    type:
      - 'null'
      - boolean
    doc: Unequal NT frequencies over three codon positions
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_fabcd
    type:
      - 'null'
      - string
    doc: "4-digit constraint on ACGT frequency\n                       (e.g. +F1221
      means f_A=f_T, f_C=f_G)"
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_fmk
    type:
      - 'null'
      - boolean
    doc: For DNA, freq(A+C)=1/2=freq(G+T)
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_fry
    type:
      - 'null'
      - boolean
    doc: For DNA, freq(A+G)=1/2=freq(C+T)
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_fu
    type:
      - 'null'
      - boolean
    doc: Amino-acid frequencies given protein matrix
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_fws
    type:
      - 'null'
      - boolean
    doc: For DNA, freq(A+T)=1/2=freq(C+G)
    inputBinding:
      position: 101
      prefix: -m
  - id: freq_max
    type:
      - 'null'
      - boolean
    doc: Posterior maximum instead of mean approximation
    inputBinding:
      position: 101
      prefix: --freq-max
  - id: freq_optimized
    type:
      - 'null'
      - boolean
    doc: Optimized frequencies by maximum-likelihood
    inputBinding:
      position: 101
      prefix: -m
  - id: gamma_median
    type:
      - 'null'
      - boolean
    doc: 'Median approximation for +G site rates (default: mean)'
    inputBinding:
      position: 101
      prefix: --gamma-median
  - id: gcf_source_trees
    type:
      - 'null'
      - File
    doc: Set of source trees for gene concordance factor (gCF)
    inputBinding:
      position: 101
      prefix: --gcf
  - id: gentrius_alignment
    type:
      - 'null'
      - File
    doc: PHYLIP/FASTA/NEXUS/CLUSTAL/MSF alignment file(s)
    inputBinding:
      position: 101
      prefix: -s
  - id: gentrius_file
    type:
      - 'null'
      - File
    doc: File must contain either a single species-tree or a set of subtrees.
    inputBinding:
      position: 101
      prefix: --gentrius
  - id: gentrius_non_stop
    type:
      - 'null'
      - boolean
    doc: Turn off all stopping rules.
    inputBinding:
      position: 101
      prefix: -g_non_stop
  - id: gentrius_partition
    type:
      - 'null'
      - File
    doc: NEXUS/RAxML partition file
    inputBinding:
      position: 101
      prefix: -p
  - id: gentrius_print
    type:
      - 'null'
      - boolean
    doc: 'Write all generated species-trees. WARNING: there might be millions of trees!'
    inputBinding:
      position: 101
      prefix: -g_print
  - id: gentrius_print_induced
    type:
      - 'null'
      - boolean
    doc: Write induced partition subtrees.
    inputBinding:
      position: 101
      prefix: -g_print_induced
  - id: gentrius_print_lim
    type:
      - 'null'
      - int
    doc: Limit on the number of species-trees to be written.
    inputBinding:
      position: 101
      prefix: -g_print_lim
  - id: gentrius_print_m
    type:
      - 'null'
      - boolean
    doc: Write presence-absence matrix.
    inputBinding:
      position: 101
      prefix: -g_print_m
  - id: gentrius_query_file
    type:
      - 'null'
      - File
    doc: Species-trees to test for identical set of subtrees.
    inputBinding:
      position: 101
      prefix: -g_query
  - id: gentrius_rm_leaves
    type:
      - 'null'
      - int
    doc: Invoke reverse analysis for complex datasets.
    inputBinding:
      position: 101
      prefix: -g_rm_leaves
  - id: gentrius_stop_h
    type:
      - 'null'
      - string
    doc: 'Stop after NUM hours (CPU time), or use 0 to turn off this stopping rule.
      Default: 7 days.'
    inputBinding:
      position: 101
      prefix: -g_stop_h
  - id: gentrius_stop_i
    type:
      - 'null'
      - int
    doc: 'Stop after NUM intermediate trees were visited, or use 0 to turn off this
      stopping rule. Default: 10MLN trees.'
    inputBinding:
      position: 101
      prefix: -g_stop_i
  - id: gentrius_stop_t
    type:
      - 'null'
      - int
    doc: 'Stop after NUM species-trees were generated, or use 0 to turn off this stopping
      rule. Default: 1MLN trees.'
    inputBinding:
      position: 101
      prefix: -g_stop_t
  - id: jackknife_proportion
    type:
      - 'null'
      - float
    doc: 'Subsampling proportion for jackknife (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --jack-prop
  - id: jackknife_replicates
    type:
      - 'null'
      - int
    doc: Replicates for jackknife + ML tree + consensus tree
    inputBinding:
      position: 101
      prefix: -j
  - id: keep_identical
    type:
      - 'null'
      - boolean
    doc: 'Keep identical sequences (default: remove & finally add)'
    inputBinding:
      position: 101
      prefix: --keep-ident
  - id: lbp_replicates
    type:
      - 'null'
      - int
    doc: Replicates for fast local bootstrap probabilities
    inputBinding:
      position: 101
      prefix: --lbp
  - id: lmap_quartets
    type:
      - 'null'
      - int
    doc: Number of quartets for likelihood mapping analysis
    inputBinding:
      position: 101
      prefix: --lmap
  - id: lmclust_file
    type:
      - 'null'
      - File
    doc: NEXUS file containing clusters for likelihood mapping
    inputBinding:
      position: 101
      prefix: --lmclust
  - id: madd_mixture
    type:
      - 'null'
      - type: array
        items: string
    doc: List of mixture models to consider
    inputBinding:
      position: 101
      prefix: --madd
  - id: mdef_file
    type:
      - 'null'
      - File
    doc: Model definition NEXUS file (see Manual)
    inputBinding:
      position: 101
      prefix: --mdef
  - id: mem
    type:
      - 'null'
      - string
    doc: Maximal RAM usage in GB | MB | %
    inputBinding:
      position: 101
      prefix: --mem
  - id: merge_algorithm
    type:
      - 'null'
      - string
    doc: 'Set merging algorithm (default: rclusterf)'
    inputBinding:
      position: 101
      prefix: --merge
  - id: merge_model_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated model list for merging
    inputBinding:
      position: 101
      prefix: --merge-model
  - id: merge_model_usage
    type:
      - 'null'
      - string
    doc: 'Use only 1 or all models for merging (default: 1)'
    inputBinding:
      position: 101
      prefix: --merge-model
  - id: merge_partitions
    type:
      - 'null'
      - boolean
    doc: Merge partitions to increase model fit
    inputBinding:
      position: 101
      prefix: --merge
  - id: merge_rate_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated rate list for merging
    inputBinding:
      position: 101
      prefix: --merge-rate
  - id: merge_rate_usage
    type:
      - 'null'
      - string
    doc: 'Use only 1 or all rate heterogeneity (default: 1)'
    inputBinding:
      position: 101
      prefix: --merge-rate
  - id: merit_criterion
    type:
      - 'null'
      - string
    doc: 'Akaike|Bayesian information criterion (default: BIC)'
    inputBinding:
      position: 101
      prefix: --merit
  - id: mfreq_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of state frequencies
    inputBinding:
      position: 101
      prefix: --mfreq
  - id: mix_optimize
    type:
      - 'null'
      - boolean
    doc: 'Optimize mixture weights (default: detect)'
    inputBinding:
      position: 101
      prefix: --mix-opt
  - id: model_extended
    type:
      - 'null'
      - boolean
    doc: Extended model selection with FreeRate heterogeneity
    inputBinding:
      position: 101
      prefix: -m
  - id: model_extended_infer
    type:
      - 'null'
      - boolean
    doc: Extended model selection followed by tree inference
    inputBinding:
      position: 101
      prefix: -m
  - id: model_lie_markov
    type:
      - 'null'
      - string
    doc: Additionally test Lie Markov models
    inputBinding:
      position: 101
      prefix: -m
  - id: model_lie_markov_mk
    type:
      - 'null'
      - string
    doc: Additionally test Lie Markov models with MK symmetry
    inputBinding:
      position: 101
      prefix: -m
  - id: model_lie_markov_ry
    type:
      - 'null'
      - string
    doc: Additionally test Lie Markov models with RY symmetry
    inputBinding:
      position: 101
      prefix: -m
  - id: model_lie_markov_ss
    type:
      - 'null'
      - string
    doc: Additionally test strand-symmetric models
    inputBinding:
      position: 101
      prefix: -m
  - id: model_lie_markov_ws
    type:
      - 'null'
      - string
    doc: Additionally test Lie Markov models with WS symmetry
    inputBinding:
      position: 101
      prefix: -m
  - id: model_test_infer
    type:
      - 'null'
      - boolean
    doc: Standard model selection followed by tree inference
    inputBinding:
      position: 101
      prefix: -m
  - id: model_testonly
    type:
      - 'null'
      - boolean
    doc: Standard model selection (like jModelTest, ProtTest)
    inputBinding:
      position: 101
      prefix: -m
  - id: modelomatic
    type:
      - 'null'
      - boolean
    doc: Find best codon/protein/DNA models (Whelan et al. 2015)
    inputBinding:
      position: 101
      prefix: --modelomatic
  - id: mrate_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of rate heterogeneity among sites\n                       (e.g. -mrate
      E,I,G,I+G,R is used for -m MF)"
    inputBinding:
      position: 101
      prefix: --mrate
  - id: mset_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated model list (e.g. -mset WAG,LG,JTT)
    inputBinding:
      position: 101
      prefix: --mset
  - id: mset_restriction
    type:
      - 'null'
      - string
    doc: "Restrict search to models supported by other programs\n                \
      \       (raxml, phyml, mrbayes, beast1 or beast2)"
    inputBinding:
      position: 101
      prefix: --mset
  - id: msub_source
    type:
      - 'null'
      - string
    doc: "Amino-acid model source\n                       (nuclear, mitochondrial,
      chloroplast or viral)"
    inputBinding:
      position: 101
      prefix: --msub
  - id: mtree_search
    type:
      - 'null'
      - boolean
    doc: Perform full tree search for every model
    inputBinding:
      position: 101
      prefix: --mtree
  - id: nbest_retained
    type:
      - 'null'
      - int
    doc: 'Number of best trees retained during search (defaut: 5)'
    inputBinding:
      position: 101
      prefix: --nbest
  - id: ninit_parsimony
    type:
      - 'null'
      - int
    doc: 'Number of initial parsimony trees (default: 100)'
    inputBinding:
      position: 101
      prefix: --ninit
  - id: nmax_iterations
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations (default: 1000)'
    inputBinding:
      position: 101
      prefix: --nmax
  - id: nn_path_model
    type:
      - 'null'
      - File
    doc: Neural network file for substitution model (onnx format)
    inputBinding:
      position: 101
      prefix: --nn-path-model
  - id: nn_path_rates
    type:
      - 'null'
      - File
    doc: Neural network file for alpha value (onnx format)
    inputBinding:
      position: 101
      prefix: --nn-path-rates
  - id: no_outfiles
    type:
      - 'null'
      - boolean
    doc: Suppress printing output files
    inputBinding:
      position: 101
      prefix: --no-outfiles
  - id: nstep_stopping
    type:
      - 'null'
      - int
    doc: 'Iterations for UFBoot stopping rule (default: 100)'
    inputBinding:
      position: 101
      prefix: --nstep
  - id: nstop_unsuccessful
    type:
      - 'null'
      - int
    doc: 'Number of unsuccessful iterations to stop (default: 100)'
    inputBinding:
      position: 101
      prefix: --nstop
  - id: ntop_initial
    type:
      - 'null'
      - int
    doc: 'Number of top initial trees (default: 20)'
    inputBinding:
      position: 101
      prefix: --ntop
  - id: num_taxa_yule
    type:
      - 'null'
      - int
    doc: No. taxa for Yule-Harding random tree
    inputBinding:
      position: 101
      prefix: -r
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Outgroup taxon (list) for writing .treefile
    inputBinding:
      position: 101
      prefix: -o
  - id: partition_dir
    type:
      - 'null'
      - Directory
    doc: NEXUS/RAxML partition file or directory with alignments
    inputBinding:
      position: 101
      prefix: -p
  - id: partition_equal
    type:
      - 'null'
      - File
    doc: Like -p but edge-linked equal partition model
    inputBinding:
      position: 101
      prefix: -q
  - id: partition_equal_dir
    type:
      - 'null'
      - Directory
    doc: Like -p but edge-linked equal partition model
    inputBinding:
      position: 101
      prefix: -q
  - id: partition_file
    type:
      - 'null'
      - File
    doc: NEXUS/RAxML partition file or directory with alignments
    inputBinding:
      position: 101
      prefix: -p
  - id: partition_unlinked
    type:
      - 'null'
      - File
    doc: Like -p but edge-unlinked partition model
    inputBinding:
      position: 101
      prefix: -Q
  - id: partition_unlinked_dir
    type:
      - 'null'
      - Directory
    doc: Like -p but edge-unlinked partition model
    inputBinding:
      position: 101
      prefix: -Q
  - id: pathogen
    type:
      - 'null'
      - boolean
    doc: "Apply CMAPLE tree search algorithm if sequence\n                       divergence
      is low, otherwise, apply IQ-TREE algorithm."
    inputBinding:
      position: 101
      prefix: --pathogen
  - id: pathogen_alrt
    type:
      - 'null'
      - int
    doc: Specify number of replicates to compute SH-aLRT.
    inputBinding:
      position: 101
      prefix: --alrt
  - id: pathogen_force
    type:
      - 'null'
      - boolean
    doc: "Apply CMAPLE tree search algorithm regardless\n                       of
      sequence divergence."
    inputBinding:
      position: 101
      prefix: --pathogen-force
  - id: pathogen_threads
    type:
      - 'null'
      - int
    doc: "Specify number of threads used for computing\n                       branch
      supports (SH-aLRT or SPRTA)."
    inputBinding:
      position: 101
      prefix: -T
  - id: perturb_nni
    type:
      - 'null'
      - float
    doc: 'Perturbation strength for randomized NNI (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --perturb
  - id: polytomy
    type:
      - 'null'
      - boolean
    doc: Collapse near-zero branches into polytomy
    inputBinding:
      position: 101
      prefix: --polytomy
  - id: pomo_counts_file
    type:
      - 'null'
      - File
    doc: Input counts file (see manual)
    inputBinding:
      position: 101
      prefix: -s
  - id: pomo_gamma
    type:
      - 'null'
      - int
    doc: Discrete Gamma rate with n categories (default n=4)
    inputBinding:
      position: 101
      prefix: -m
  - id: pomo_model
    type:
      - 'null'
      - string
    doc: DNA substitution model (see above) used with PoMo
    inputBinding:
      position: 101
      prefix: -m
  - id: pomo_popsize
    type:
      - 'null'
      - int
    doc: 'Virtual population size (default: 9)'
    inputBinding:
      position: 101
      prefix: -m
  - id: pomo_s
    type:
      - 'null'
      - boolean
    doc: Sampled sampling
    inputBinding:
      position: 101
      prefix: -m
  - id: pomo_wb
    type:
      - 'null'
      - boolean
    doc: Weighted binomial sampling
    inputBinding:
      position: 101
      prefix: -m
  - id: pomo_wh
    type:
      - 'null'
      - boolean
    doc: Weighted hypergeometric sampling
    inputBinding:
      position: 101
      prefix: -m
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for all output files (default: aln/partition)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: presence_absence_matrix
    type:
      - 'null'
      - File
    doc: Presence-absence matrix of loci coverage.
    inputBinding:
      position: 101
      prefix: -pr_ab_matrix
  - id: quartetlh
    type:
      - 'null'
      - boolean
    doc: Print quartet log-likelihoods to .quartetlh file
    inputBinding:
      position: 101
      prefix: --quartetlh
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode, suppress printing to screen (stdout)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: radius_spr
    type:
      - 'null'
      - float
    doc: 'Radius for parsimony SPR search (default: 6)'
    inputBinding:
      position: 101
      prefix: --radius
  - id: rand_branch_lengths
    type:
      - 'null'
      - string
    doc: min, mean, and max random branch lengths
    inputBinding:
      position: 101
      prefix: --rlen
  - id: rand_tree_type
    type:
      - 'null'
      - string
    doc: UNIform | CATerpillar | BALanced random tree
    inputBinding:
      position: 101
      prefix: --rand
  - id: rate_freerate
    type:
      - 'null'
      - int
    doc: FreeRate model with n categories (default n=4)
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_freerate_unlinked
    type:
      - 'null'
      - int
    doc: FreeRate model with unlinked model parameters
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_gamma
    type:
      - 'null'
      - int
    doc: Discrete Gamma model with n categories (default n=4)
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_gamma_unlinked
    type:
      - 'null'
      - int
    doc: Discrete Gamma model with unlinked model parameters
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_heterotachy
    type:
      - 'null'
      - int
    doc: Heterotachy model with n classes
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_heterotachy_unlinked
    type:
      - 'null'
      - int
    doc: Heterotachy model with n classes and unlinked parameters
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_invariable
    type:
      - 'null'
      - boolean
    doc: A proportion of invariable sites
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_invariable_freerate
    type:
      - 'null'
      - int
    doc: Invariable sites plus FreeRate model with n categories
    inputBinding:
      position: 101
      prefix: -m
  - id: rate_invariable_gamma
    type:
      - 'null'
      - int
    doc: Invariable sites plus Gamma model with n categories
    inputBinding:
      position: 101
      prefix: -m
  - id: rcluster_max_pairs
    type:
      - 'null'
      - int
    doc: 'Max number of partition pairs (default: 10*partitions)'
    inputBinding:
      position: 101
      prefix: --rcluster-max
  - id: rcluster_percentage
    type:
      - 'null'
      - int
    doc: Percentage of partition pairs for rcluster algorithm
    inputBinding:
      position: 101
      prefix: --rcluster
  - id: rclusterf_percentage
    type:
      - 'null'
      - int
    doc: Percentage of partition pairs for rclusterf algorithm
    inputBinding:
      position: 101
      prefix: --rclusterf
  - id: redo
    type:
      - 'null'
      - boolean
    doc: Redo both ModelFinder and tree search
    inputBinding:
      position: 101
      prefix: --redo
  - id: redo_tree
    type:
      - 'null'
      - boolean
    doc: Restore ModelFinder and only redo tree search
    inputBinding:
      position: 101
      prefix: --redo-tree
  - id: runs
    type:
      - 'null'
      - int
    doc: 'Number of indepedent runs (default: 1)'
    inputBinding:
      position: 101
      prefix: --runs
  - id: safe
    type:
      - 'null'
      - boolean
    doc: Safe likelihood kernel to avoid numerical underflow
    inputBinding:
      position: 101
      prefix: --safe
  - id: sampling_method
    type:
      - 'null'
      - string
    doc: 'GENE|GENESITE resampling for partitions (default: SITE)'
    inputBinding:
      position: 101
      prefix: --sampling
  - id: scale_branch_lengths
    type:
      - 'null'
      - boolean
    doc: Scale branch lengths of user tree passed via -t
    inputBinding:
      position: 101
      prefix: -blscale
  - id: scf_alignment
    type:
      - 'null'
      - File
    doc: Sequence alignment for --scf
    inputBinding:
      position: 101
      prefix: -s
  - id: scf_partition
    type:
      - 'null'
      - File
    doc: Partition file or directory for --scf
    inputBinding:
      position: 101
      prefix: -p
  - id: scf_partition_dir
    type:
      - 'null'
      - Directory
    doc: Partition file or directory for --scf
    inputBinding:
      position: 101
      prefix: -p
  - id: scf_quartets
    type:
      - 'null'
      - int
    doc: Number of quartets for site concordance factor (sCF)
    inputBinding:
      position: 101
      prefix: --scf
  - id: scfl_likelihood
    type:
      - 'null'
      - int
    doc: Like --scf but using likelihood (recommended)
    inputBinding:
      position: 101
      prefix: --scfl
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed number, normally used for debugging purpose
    inputBinding:
      position: 101
      prefix: --seed
  - id: separate_tree
    type:
      - 'null'
      - File
    doc: Like -p but separate tree inference
    inputBinding:
      position: 101
      prefix: -S
  - id: separate_tree_dir
    type:
      - 'null'
      - Directory
    doc: Like -p but separate tree inference
    inputBinding:
      position: 101
      prefix: -S
  - id: seqtype
    type:
      - 'null'
      - string
    doc: 'BIN, DNA, AA, NT2AA, CODON, MORPH (default: auto-detect)'
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: show_lh
    type:
      - 'null'
      - boolean
    doc: Compute tree likelihood without optimisation
    inputBinding:
      position: 101
      prefix: --show-lh
  - id: site_freq_file
    type:
      - 'null'
      - File
    doc: Input site frequency model file
    inputBinding:
      position: 101
      prefix: --site-freq
  - id: sprta
    type:
      - 'null'
      - boolean
    doc: Compute SPRTA (DeMaio et al., 2024) branch supports.
    inputBinding:
      position: 101
      prefix: --sprta
  - id: sprta_other_places
    type:
      - 'null'
      - boolean
    doc: Output alternative SPRs and their SPRTA supports.
    inputBinding:
      position: 101
      prefix: --sprta-other-places
  - id: sprta_zero_branch
    type:
      - 'null'
      - boolean
    doc: Compute SPRTA supports for zero-length branches.
    inputBinding:
      position: 101
      prefix: --sprta-zero-branch
  - id: start_tree
    type:
      - 'null'
      - string
    doc: 'Starting tree (default: 99 parsimony and BIONJ)'
    inputBinding:
      position: 101
      prefix: -t
  - id: subsample_partitions
    type:
      - 'null'
      - int
    doc: Randomly sub-sample partitions (negative for complement)
    inputBinding:
      position: 101
      prefix: --subsample
  - id: subsample_seed
    type:
      - 'null'
      - int
    doc: Random number seed for --subsample
    inputBinding:
      position: 101
      prefix: --subsample-seed
  - id: substitution_model
    type:
      - 'null'
      - string
    doc: Model name string (e.g. GTR+F+I+G)
    inputBinding:
      position: 101
      prefix: -m
  - id: sup_min_support
    type:
      - 'null'
      - float
    doc: "Min split support, 0.5 for majority-rule consensus\n                   \
      \    (default: 0, extended consensus)"
    inputBinding:
      position: 101
      prefix: --sup-min
  - id: symtest
    type:
      - 'null'
      - boolean
    doc: Perform three tests of symmetry
    inputBinding:
      position: 101
      prefix: --symtest
  - id: symtest_keep_zero
    type:
      - 'null'
      - boolean
    doc: Keep NAs in the tests
    inputBinding:
      position: 101
      prefix: --symtest-keep-zero
  - id: symtest_only
    type:
      - 'null'
      - boolean
    doc: Do --symtest then exist
    inputBinding:
      position: 101
      prefix: --symtest-only
  - id: symtest_pval_cutoff
    type:
      - 'null'
      - float
    doc: 'P-value cutoff (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --symtest-pval
  - id: symtest_remove_bad
    type:
      - 'null'
      - boolean
    doc: Do --symtest and remove bad partitions
    inputBinding:
      position: 101
      prefix: --symtest-remove-bad
  - id: symtest_remove_good
    type:
      - 'null'
      - boolean
    doc: Do --symtest and remove good partitions
    inputBinding:
      position: 101
      prefix: --symtest-remove-good
  - id: symtest_type
    type:
      - 'null'
      - string
    doc: Use MARginal/INTernal test when removing partitions
    inputBinding:
      position: 101
      prefix: --symtest-type
  - id: tbe
    type:
      - 'null'
      - boolean
    doc: Transfer bootstrap expectation
    inputBinding:
      position: 101
      prefix: --tbe
  - id: terrace
    type:
      - 'null'
      - boolean
    doc: Check if the tree lies on a phylogenetic terrace
    inputBinding:
      position: 101
      prefix: --terrace
  - id: test_au
    type:
      - 'null'
      - boolean
    doc: Approximately unbiased (AU) test (Shimodaira 2002)
    inputBinding:
      position: 101
      prefix: --test-au
  - id: test_weight
    type:
      - 'null'
      - boolean
    doc: Perform weighted KH and SH tests
    inputBinding:
      position: 101
      prefix: --test-weight
  - id: threads
    type:
      - 'null'
      - string
    doc: 'No. cores/threads or AUTO-detect (default: 1)'
    inputBinding:
      position: 101
      prefix: -T
  - id: threads_max
    type:
      - 'null'
      - int
    doc: 'Max number of threads for -T AUTO (default: all cores)'
    inputBinding:
      position: 101
      prefix: --threads-max
  - id: topology_test_replicates
    type:
      - 'null'
      - int
    doc: Replicates for topology test
    inputBinding:
      position: 101
      prefix: --test
  - id: tree_dist2_set
    type:
      - 'null'
      - File
    doc: Like -rf but trees can have unequal taxon sets
    inputBinding:
      position: 101
      prefix: --tree-dist2
  - id: tree_dist_all
    type:
      - 'null'
      - boolean
    doc: Compute all-to-all RF distances for -t trees
    inputBinding:
      position: 101
      prefix: --tree-dist-all
  - id: tree_dist_set
    type:
      - 'null'
      - File
    doc: Compute RF distances between -t trees and this set
    inputBinding:
      position: 101
      prefix: --tree-dist
  - id: tree_fix
    type:
      - 'null'
      - boolean
    doc: Fix -t tree (no tree search performed)
    inputBinding:
      position: 101
      prefix: --tree-fix
  - id: tree_freq_file
    type:
      - 'null'
      - File
    doc: Input tree to infer site frequency model
    inputBinding:
      position: 101
      prefix: --tree-freq
  - id: treels
    type:
      - 'null'
      - boolean
    doc: Write locally optimal trees into .treels file
    inputBinding:
      position: 101
      prefix: --treels
  - id: trees_to_evaluate
    type:
      - 'null'
      - File
    doc: Set of trees to evaluate log-likelihoods
    inputBinding:
      position: 101
      prefix: --trees
  - id: ufboot_replicates
    type:
      - 'null'
      - int
    doc: Replicates for ultrafast bootstrap (>=1000)
    inputBinding:
      position: 101
      prefix: --ufboot
  - id: ufjack_replicates
    type:
      - 'null'
      - int
    doc: Replicates for ultrafast jackknife (>=1000)
    inputBinding:
      position: 101
      prefix: --ufjack
  - id: undo
    type:
      - 'null'
      - boolean
    doc: Revoke finished run, used when changing some options
    inputBinding:
      position: 101
      prefix: --undo
  - id: use_eigenlib
    type:
      - 'null'
      - boolean
    doc: Use Eigen3 library
    inputBinding:
      position: 101
      prefix: --eigenlib
  - id: use_nn_model
    type:
      - 'null'
      - boolean
    doc: Use neural network for tree inference
    inputBinding:
      position: 101
      prefix: --use-nn-model
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, printing more messages to screen
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wbtl
    type:
      - 'null'
      - boolean
    doc: Like --boot-trees but also writing branch lengths
    inputBinding:
      position: 101
      prefix: --wbtl
  - id: write_bootstrap_trees
    type:
      - 'null'
      - boolean
    doc: 'Write bootstrap trees to .ufboot file (default: none)'
    inputBinding:
      position: 101
      prefix: --boot-trees
  - id: write_mlrates
    type:
      - 'null'
      - boolean
    doc: Write maximum likelihood site rates to .mlrate file
    inputBinding:
      position: 101
      prefix: --mlrate
  - id: write_partlh
    type:
      - 'null'
      - boolean
    doc: Write partition log-likelihoods to .partlh file
    inputBinding:
      position: 101
      prefix: --partlh
  - id: write_rates
    type:
      - 'null'
      - boolean
    doc: Write empirical Bayesian site rates to .rate file
    inputBinding:
      position: 101
      prefix: --rate
  - id: write_sitelh
    type:
      - 'null'
      - boolean
    doc: Write site log-likelihoods to .sitelh file
    inputBinding:
      position: 101
      prefix: --sitelh
  - id: write_slm
    type:
      - 'null'
      - boolean
    doc: Write site log-likelihoods per mixture class
    inputBinding:
      position: 101
      prefix: -wslm
  - id: write_slmr
    type:
      - 'null'
      - boolean
    doc: Write site log-likelihoods per mixture+rate class
    inputBinding:
      position: 101
      prefix: -wslmr
  - id: write_slr
    type:
      - 'null'
      - boolean
    doc: Write site log-likelihoods per rate category
    inputBinding:
      position: 101
      prefix: -wslr
  - id: write_spm
    type:
      - 'null'
      - boolean
    doc: Write site probabilities per mixture class
    inputBinding:
      position: 101
      prefix: -wspm
  - id: write_spmr
    type:
      - 'null'
      - boolean
    doc: Write site probabilities per mixture+rate class
    inputBinding:
      position: 101
      prefix: -wspmr
  - id: write_spr
    type:
      - 'null'
      - boolean
    doc: Write site probabilities per rate category
    inputBinding:
      position: 101
      prefix: -wspr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iqtree:3.0.1--h503566f_0
stdout: iqtree.out
