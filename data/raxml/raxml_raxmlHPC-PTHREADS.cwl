cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxmlHPC-PTHREADS
label: raxml_raxmlHPC-PTHREADS
doc: "RAxML version 8.2.12\n\nTool homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "select algorithm:\n\n              \"-f a\": rapid Bootstrap analysis and
      search for best-scoring ML tree in one program run\n              \"-f A\":
      compute marginal ancestral states on a ROOTED reference tree provided with \"\
      -t\"\n              \"-f b\": draw bipartition information on a tree provided
      with \"-t\" based on multiple trees\n                      (e.g., from a bootstrap)
      in a file specified by \"-z\"\n              \"-f B\": optimize br-len scaler
      and other model parameters (GTR, alpha, etc.) on a tree provided with \"-t\"\
      .\n                      The tree needs to contain branch lengths. The branch
      lengths will not be optimized, just scaled by a single common value.\n     \
      \         \"-f c\": check if the alignment can be properly read by RAxML\n \
      \             \"-f C\": ancestral sequence test for Jiajie, users will also
      need to provide a list of taxon names via -Y separated by whitespaces\n    \
      \          \"-f d\": new rapid hill-climbing \n                      DEFAULT:
      ON\n              \"-f D\": rapid hill-climbing with RELL bootstraps\n     \
      \         \"-f e\": optimize model+branch lengths for given input tree under
      GAMMA/GAMMAI only\n              \"-f E\": execute very fast experimental tree
      search, at present only for testing\n              \"-f F\": execute fast experimental
      tree search, at present only for testing\n              \"-f g\": compute per
      site log Likelihoods for one or more trees passed via\n                    \
      \  \"-z\" and write them to a file that can be read by CONSEL\n            \
      \          The model parameters will be estimated on the first tree only!\n\
      \              \"-f G\": compute per site log Likelihoods for one or more trees
      passed via\n                      \"-z\" and write them to a file that can be
      read by CONSEL.\n                      The model parameters will be re-estimated
      for each tree\n              \"-f h\": compute log likelihood test (SH-test)
      between best tree passed via \"-t\"\n                      and a bunch of other
      trees passed via \"-z\" \n                      The model parameters will be
      estimated on the first tree only!\n              \"-f H\": compute log likelihood
      test (SH-test) between best tree passed via \"-t\"\n                      and
      a bunch of other trees passed via \"-z\" \n                      The model parameters
      will be re-estimated for each tree\n              \"-f i\": calculate IC and
      TC scores (Salichos and Rokas 2013) on a tree provided with \"-t\" based on
      multiple trees\n                      (e.g., from a bootstrap) in a file specified
      by \"-z\"\n              \"-f I\": a simple tree rooting algorithm for unrooted
      trees.\n                      It roots the tree by rooting it at the branch
      that best balances the subtree lengths\n                      (sum over branches
      in the subtrees) of the left and right subtree.\n                      A branch
      with an optimal balance does not always exist!\n                      You need
      to specify the tree you want to root via \"-t\".\n              \"-f j\": generate
      a bunch of bootstrapped alignment files from an original alignemnt file.\n \
      \                     You need to specify a seed with \"-b\" and the number
      of replicates with \"-#\" \n              \"-f J\": Compute SH-like support
      values on a given tree passed via \"-t\".\n              \"-f k\": Fix long
      branch lengths in partitioned data sets with missing data using the\n      \
      \                branch length stealing algorithm.\n                      This
      option only works in conjunction with \"-t\", \"-M\", and \"-q\".\n        \
      \              It will print out a tree with shorter branch lengths, but having
      the same likelihood score.\n              \"-f m\": compare bipartitions between
      two bunches of trees passed via \"-t\" and \"-z\" \n                      respectively.
      This will return the Pearson correlation between all bipartitions found\n  \
      \                    in the two tree files. A file called RAxML_bipartitionFrequencies.outpuFileName\n\
      \                      will be printed that contains the pair-wise bipartition
      frequencies of the two sets\n              \"-f n\": compute the log likelihood
      score of all trees contained in a tree file provided by\n                  \
      \    \"-z\" under GAMMA or GAMMA+P-Invar\n                      The model parameters
      will be estimated on the first tree only!\n              \"-f N\": compute the
      log likelihood score of all trees contained in a tree file provided by\n   \
      \                   \"-z\" under GAMMA or GAMMA+P-Invar\n                  \
      \    The model parameters will be re-estimated for each tree\n             \
      \ \"-f o\": old and slower rapid hill-climbing without heuristic cutoff\n  \
      \            \"-f p\": perform pure stepwise MP addition of new sequences to
      an incomplete starting tree and exit\n              \"-f P\": perform a phylogenetic
      placement of sub trees specified in a file passed via \"-z\" into a given reference
      tree\n                      in which these subtrees are contained that is passed
      via \"-t\" using the evolutionary placement algorithm.\n              \"-f q\"\
      : fast quartet calculator\n              \"-f r\": compute pairwise Robinson-Foulds
      (RF) distances between all pairs of trees in a tree file passed via \"-z\" \n\
      \                      if the trees have node labales represented as integer
      support values the program will also compute two flavors of\n              \
      \        the weighted Robinson-Foulds (WRF) distance\n              \"-f R\"\
      : compute all pairwise Robinson-Foulds (RF) distances between a large reference
      tree  passed via \"-t\" \n                      and many smaller trees (that
      must have a subset of the taxa of the large tree) passed via \"-z\".\n     \
      \                 This option is intended for checking the plausibility of very
      large phylogenies that can not be inspected\n                      visually
      any more.\n              \"-f s\": split up a multi-gene partitioned alignment
      into the respective subalignments \n              \"-f S\": compute site-specific
      placement bias using a leave one out test inspired by the evolutionary placement
      algorithm\n              \"-f t\": do randomized tree searches on one fixed
      starting tree\n              \"-f T\": do final thorough optimization of ML
      tree from rapid bootstrap search in stand-alone mode\n              \"-f u\"\
      : execute morphological weight calibration using maximum likelihood, this will
      return a weight vector. \n                      you need to provide a morphological
      alignment and a reference tree via \"-t\" \n              \"-f v\": classify
      a bunch of environmental sequences into a reference tree using thorough read
      insertions\n                      you will need to start RAxML with a non-comprehensive
      reference tree and an alignment containing all sequences (reference + query)\n\
      \              \"-f V\": classify a bunch of environmental sequences into a
      reference tree using thorough read insertions\n                      you will
      need to start RAxML with a non-comprehensive reference tree and an alignment
      containing all sequences (reference + query)\n                      WARNING:
      this is a test implementation for more efficient handling of multi-gene/whole-genome
      datasets!\n              \"-f w\": compute ELW test on a bunch of trees passed
      via \"-z\" \n                      The model parameters will be estimated on
      the first tree only!\n              \"-f W\": compute ELW test on a bunch of
      trees passed via \"-z\" \n                      The model parameters will be
      re-estimated for each tree\n              \"-f x\": compute pair-wise ML distances,
      ML model parameters will be estimated on an MP \n                      starting
      tree or a user-defined tree passed via \"-t\", only allowed for GAMMA-based\n\
      \                      models of rate heterogeneity\n              \"-f y\"\
      : classify a bunch of environmental sequences into a reference tree using parsimony\n\
      \                      you will need to start RAxML with a non-comprehensive
      reference tree and an alignment containing all sequences (reference + query)\n\
      \n              DEFAULT for \"-f\": new rapid hill climbing"
    inputBinding:
      position: 101
      prefix: -f
  - id: ascertainment_bias_correction
    type:
      - 'null'
      - string
    doc: "Allows to specify the type of ascertainment bias correction you wish to
      use. There are 3\n                 types available:\n                 --asc-corr=lewis:
      the standard correction by Paul Lewis\n                 --asc-corr=felsenstein:
      a correction introduced by Joe Felsenstein that allows to explicitely specify\n\
      \                                         the number of invariable sites (if
      known) one wants to correct for.\n                 --asc-corr=stamatakis: a
      correction introduced by myself that allows to explicitely specify\n       \
      \                                 the number of invariable sites for each character
      (if known) one wants to correct for."
    inputBinding:
      position: 101
      prefix: --asc-corr
  - id: auto_protein_model_criterion
    type:
      - 'null'
      - string
    doc: "When using automatic protein model selection you can chose the criterion
      for selecting these models.\n                  RAxML will test all available
      prot subst. models except for LG4M, LG4X and GTR-based models, with and without
      empirical base frequencies.\n                  You can chose between ML score
      based selection and the BIC, AIC, and AICc criteria.\n\n                  DEFAULT:
      ml"
    inputBinding:
      position: 101
      prefix: --auto-prot
  - id: binary_constraint_tree
    type:
      - 'null'
      - File
    doc: "Specify the file name of a binary constraint tree.\n              this tree
      does not need to be comprehensive, i.e. must not contain all taxa"
    inputBinding:
      position: 101
      prefix: -r
  - id: binary_model_param_file
    type:
      - 'null'
      - File
    doc: "Specify the file name of a binary model parameter file that has previously
      been generated\n              with RAxML using the -f e tree evaluation option.
      The file name should be: \n              RAxML_binaryModelParameters.runID"
    inputBinding:
      position: 101
      prefix: -R
  - id: bootstop_permutations
    type:
      - 'null'
      - int
    doc: "specify the number of permutations to be conducted for the bootstopping/bootstrap
      convergence test.\n                  The allowed minimum number is 100!\n\n\
      \                  DEFAULT: 100"
    default: 100
    inputBinding:
      position: 101
      prefix: --bootstop-perms
  - id: bootstopping_analysis
    type:
      - 'null'
      - string
    doc: "a posteriori bootstopping analysis. Use:\n             \"-I autoFC\" for
      the frequency-based criterion\n             \"-I autoMR\" for the majority-rule
      consensus tree criterion\n             \"-I autoMRE\" for the extended majority-rule
      consensus tree criterion\n             \"-I autoMRE_IGN\" for metrics similar
      to MRE, but include bipartitions under the threshold whether they are compatible\n\
      \                              or not. This emulates MRE but is faster to compute.\n\
      \              You also need to pass a tree file containg several bootstrap
      replicates via \"-z\" "
    inputBinding:
      position: 101
      prefix: -I
  - id: bootstrap_random_seed
    type:
      - 'null'
      - int
    doc: "Specify an integer number (random seed) and turn on bootstrapping\n\n  \
      \            DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -b
  - id: compute_parsimony_starting_tree_only
    type:
      - 'null'
      - boolean
    doc: "If you want to only compute a parsimony starting tree with RAxML specify
      \"-y\",\n              the program will exit after computation of the starting
      tree\n\n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -y
  - id: consensus_tree_labeling
    type:
      - 'null'
      - string
    doc: "Compute consensus trees labelled by IC supports and the overall TC value
      as proposed in Salichos and Rokas 2013.\n             Compute a majority rule
      consensus tree with \"-L MR\" or an extended majority rule consensus tree with
      \"-L MRE\".\n             For a custom consensus threshold >= 50%, specify \"\
      -L T_<NUM>\", where 100 >= NUM >= 50.\n             You will of course also
      need to provide a tree file containing several UNROOTED trees via \"-z\"!"
    inputBinding:
      position: 101
      prefix: -L
  - id: consensus_tree_type
    type:
      - 'null'
      - string
    doc: "Compute majority rule consensus tree with \"-J MR\" or extended majority
      rule consensus tree with \"-J MRE\"\n              or strict consensus tree
      with \"-J STRICT\". For a custom consensus threshold >= 50%, specify T_<NUM>,
      where 100 >= NUM >= 50.\n              Options \"-J STRICT_DROP\" and \"-J MR_DROP\"\
      \ will execute an algorithm that identifies dropsets which contain\n       \
      \       rogue taxa as proposed by Pattengale et al. in the paper \"Uncovering
      hidden phylogenetic consensus\".\n              You will also need to provide
      a tree file containing several UNROOTED trees via \"-z\""
    inputBinding:
      position: 101
      prefix: -J
  - id: constraint_tree_file
    type:
      - 'null'
      - File
    doc: "specify the file name of a multifurcating constraint tree\n            \
      \  this tree does not need to be comprehensive, i.e. must not contain all taxa"
    inputBinding:
      position: 101
      prefix: -g
  - id: disable_pattern_compression
    type:
      - 'null'
      - boolean
    doc: "Disable pattern compression.\n\n              DEFAULT: ON"
    inputBinding:
      position: 101
      prefix: -H
  - id: disable_rate_heterogeneity
    type:
      - 'null'
      - boolean
    doc: "Disable rate heterogeneity among sites model and use one without rate heterogeneity
      instead.\n              Only works if you specify the CAT model of rate heterogeneity.\n\
      \n              DEFAULT: use rate heterogeneity"
    inputBinding:
      position: 101
      prefix: -V
  - id: disable_undetermined_sequence_check
    type:
      - 'null'
      - boolean
    doc: "Disable check for completely undetermined sequence in alignment.\n     \
      \         The program will not exit with an error message when \"-O\" is specified.\n\
      \n              DEFAULT: check enabled"
    inputBinding:
      position: 101
      prefix: -O
  - id: enable_ml_tree_searches_cat_model
    type:
      - 'null'
      - boolean
    doc: "enable ML tree searches under CAT model for very large trees without switching
      to \n              GAMMA in the end (saves memory).\n              This option
      can also be used with the GAMMA models in order to avoid the thorough optimization\
      \ \n              of the best-scoring ML tree in the end.\n\n              DEFAULT:
      OFF"
    inputBinding:
      position: 101
      prefix: -F
  - id: epa_accumulated_threshold
    type:
      - 'null'
      - float
    doc: "specify an accumulated likelihood weight threshold for which different placements
      of read are printed\n                  to file. Placements for a read will be
      printed until the sum of their placement weights has reached the threshold value.\n\
      \                  Note that, this option can neither be used in combination
      with --epa-prob-threshold nor with --epa-keep-placements!"
    inputBinding:
      position: 101
      prefix: --epa-accumulated-threshold
  - id: epa_keep_placements
    type:
      - 'null'
      - int
    doc: "specify the number of potential placements you want to keep for each read
      in the EPA algorithm.\n                  Note that, the actual values printed
      will also depend on the settings for --epa-prob-threshold=threshold !\n\n  \
      \                DEFAULT: 7"
    default: 7
    inputBinding:
      position: 101
      prefix: --epa-keep-placements
  - id: epa_prob_threshold
    type:
      - 'null'
      - float
    doc: "specify a percent threshold for including potential placements of a read
      depending on the \n                  maximum placement weight for this read.
      If you set this value to 0.01 placements that have a placement weight of 1 per
      cent of\n                  the maximum placement will still be printed to file
      if the setting of --epa-keep-placements allows for it\n\n                  DEFAULT:
      0.01"
    default: 0.01
    inputBinding:
      position: 101
      prefix: --epa-prob-threshold
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: "specify an exclude file name, that contains a specification of alignment
      positions you wish to exclude.\n              Format is similar to Nexus, the
      file shall contain entries like \"100-200 300-400\", to exclude a\n        \
      \      single column write, e.g., \"100-100\", if you use a mixed model, an
      appropriately adapted model file\n              will be written."
    inputBinding:
      position: 101
      prefix: -E
  - id: flag_check
    type:
      - 'null'
      - boolean
    doc: "When using this option, RAxML will only check if all command line flags
      specifed are available and then exit\n                   with a message listing
      all invalid command line flags or with a message stating that all flags are
      valid."
    inputBinding:
      position: 101
      prefix: --flag-check
  - id: initial_rearrangement_setting
    type:
      - 'null'
      - string
    doc: "Initial rearrangement setting for the subsequent application of topological\
      \ \n              changes phase"
    inputBinding:
      position: 101
      prefix: -i
  - id: likelihood_epsilon
    type:
      - 'null'
      - float
    doc: "set model optimization precision in log likelihood units for final\n   \
      \           optimization of tree topology\n\n              DEFAULT: 0.1   for
      models not using proportion of invariant sites estimate\n                  \
      \     0.001 for models using proportion of invariant sites estimate"
    inputBinding:
      position: 101
      prefix: -e
  - id: mesquite_output
    type:
      - 'null'
      - boolean
    doc: "Print output files that can be parsed by Mesquite.\n\n              DEFAULT:
      Off"
    inputBinding:
      position: 101
      prefix: --mesquite
  - id: ml_search_convergence_criterion
    type:
      - 'null'
      - boolean
    doc: "ML search convergence criterion. This will break off ML searches if the
      relative \n              Robinson-Foulds distance between the trees obtained
      from two consecutive lazy SPR cycles\n              is smaller or equal to 1%.
      Usage recommended for very large datasets in terms of taxa. \n             \
      \ On trees with more than 500 taxa this will yield execution time improvements
      of approximately 50%\n              While yielding only slightly worse trees.\n\
      \n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -D
  - id: multi_state_substitution_model
    type:
      - 'null'
      - string
    doc: "Specify one of the multi-state substitution models (max 32 states) implemented
      in RAxML.\n              Available models are: ORDERED, MK, GTR\n\n        \
      \      DEFAULT: GTR model "
    inputBinding:
      position: 101
      prefix: -K
  - id: multiple_trees_file
    type:
      - 'null'
      - File
    doc: "Specify the file name of a file containing multiple trees e.g. from a bootstrap\n\
      \              that shall be used to draw bipartition values onto a tree provided
      with \"-t\",\n              It can also be used to compute per site log likelihoods
      in combination with \"-f g\"\n              and to read a bunch of trees for
      a couple of other options (\"-f h\", \"-f m\", \"-f n\")."
    inputBinding:
      position: 101
      prefix: -z
  - id: no_bfgs
    type:
      - 'null'
      - boolean
    doc: "Disables automatic usage of BFGS method to optimize GTR rates on unpartitioned
      DNA datasets\n\n              DEFAULT: BFGS on"
    inputBinding:
      position: 101
      prefix: --no-bfgs
  - id: no_sequence_check
    type:
      - 'null'
      - boolean
    doc: "Disables checking the input MSA for identical sequences and entirely undetermined
      sites.\n                     Enabling this option may save time, in particular
      for large phylogenomic alignments.\n                     Before using this,
      make sure to check the alignment using the \"-f c\" option!\n\n            \
      \  DEFAULT: Off "
    inputBinding:
      position: 101
      prefix: --no-seq-check
  - id: num_categories
    type:
      - 'null'
      - int
    doc: "Specify number of distinct rate catgories for RAxML when model of rate heterogeneity
      is set to CAT\n              Individual per-site rates are categorized into
      numberOfCategories rate \n              categories to accelerate computations.\
      \ \n\n              DEFAULT: 25"
    default: 25
    inputBinding:
      position: 101
      prefix: -c
  - id: num_runs_or_bootstopping
    type:
      - 'null'
      - string
    doc: "Specify the number of alternative runs on distinct starting trees\n    \
      \          In combination with the \"-b\" option, this will invoke a multiple
      boostrap analysis\n              Note that \"-N\" has been added as an alternative
      since \"-#\" sometimes caused problems\n              with certain MPI job submission
      systems, since \"-#\" is often used to start comments.\n              If you
      want to use the bootstopping criteria specify \"-# autoMR\" or \"-# autoMRE\"\
      \ or \"-# autoMRE_IGN\"\n              for the majority-rule tree based criteria
      (see -I option) or \"-# autoFC\" for the frequency-based criterion.\n      \
      \        Bootstopping will only work in combination with \"-x\" or \"-b\"\n\n\
      \              DEFAULT: 1 single analysis"
    inputBinding:
      position: 101
      prefix: -N
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "PTHREADS VERSION ONLY! Specify the number of threads you want to run.\n\
      \              Make sure to set \"-T\" to at most the number of CPUs you have
      on your machine,\n              otherwise, there will be a huge performance
      decrease!"
    inputBinding:
      position: 101
      prefix: -T
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "Specify the name of a single outgroup or a comma-separated list of outgroups,
      eg \"-o Rat\" \n              or \"-o Rat,Mouse\", in case that multiple outgroups
      are not monophyletic the first name \n              in the list will be selected
      as outgroup, don't leave spaces between taxon names!"
    inputBinding:
      position: 101
      prefix: -o
  - id: output_file_name
    type: string
    doc: Specifies the name of the output file.
    inputBinding:
      position: 101
      prefix: -n
  - id: parsimony_random_seed
    type:
      - 'null'
      - int
    doc: "Specify a random number seed for the parsimony inferences. This allows you
      to reproduce your results\n              and will help me debug the program."
    inputBinding:
      position: 101
      prefix: -p
  - id: partition_assignment_file
    type:
      - 'null'
      - File
    doc: "Specify the file name which contains the assignment of models to alignment\n\
      \              partitions for multiple models of substitution. For the syntax
      of this file\n              please consult the manual."
    inputBinding:
      position: 101
      prefix: -q
  - id: partition_branch_lengths
    type:
      - 'null'
      - boolean
    doc: "Switch on estimation of individual per-partition branch lengths. Only has
      effect when used in combination with \"-q\"\n              Branch lengths for
      individual partitions will be printed to separate files\n              A weighted
      average of the branch lengths is computed by using the respective partition
      lengths\n\n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -M
  - id: placement_threshold
    type:
      - 'null'
      - float
    doc: "enable the ML-based evolutionary placement algorithm heuristics\n      \
      \        by specifiyng a threshold value (fraction of insertion branches to
      be evaluated\n              using slow insertions under ML)."
    inputBinding:
      position: 101
      prefix: -G
  - id: print_bootstrapped_trees_with_branch_lengths
    type:
      - 'null'
      - boolean
    doc: "Specifies that bootstrapped trees should be printed with branch lengths.\n\
      \              The bootstraps will run a bit longer, because model parameters
      will be optimized\n              at the end of each run under GAMMA or GAMMA+P-Invar
      respectively.\n\n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -k
  - id: print_identical_sequences
    type:
      - 'null'
      - boolean
    doc: "specify that RAxML shall automatically generate a .reduced alignment with
      all\n                  undetermined columns removed, but without removing exactly
      identical sequences\n\n                  DEFAULT: identical sequences will also
      be removed in the .reduced file"
    inputBinding:
      position: 101
      prefix: --print-identical-sequences
  - id: protein_model_file
    type:
      - 'null'
      - File
    doc: "Specify the file name of a user-defined AA (Protein) substitution model.
      This file must contain\n              420 entries, the first 400 being the AA
      substitution rates (this must be a symmetric matrix) and the\n             \
      \ last 20 are the empirical base frequencies"
    inputBinding:
      position: 101
      prefix: -P
  - id: quartet_grouping_file
    type:
      - 'null'
      - File
    doc: "Pass a quartet grouping file name defining four groups from which to draw
      quartets\n              The file input format must contain 4 groups in the following
      form:\n              (Chicken, Human, Loach), (Cow, Carp), (Mouse, Rat, Seal),
      (Whale, Frog);\n              Only works in combination with -f q !"
    inputBinding:
      position: 101
      prefix: -Y
  - id: quartets_without_replacement
    type:
      - 'null'
      - boolean
    doc: "specify that quartets are randomly subsampled, but without replacement.\n\
      \n                  DEFAULT: random sampling with replacements"
    inputBinding:
      position: 101
      prefix: --quartets-without-replacement
  - id: random_starting_tree
    type:
      - 'null'
      - boolean
    doc: "start ML optimization from random starting tree \n\n              DEFAULT:
      OFF"
    inputBinding:
      position: 101
      prefix: -d
  - id: rapid_bootstrap_random_seed
    type:
      - 'null'
      - int
    doc: "Specify an integer number (random seed) and turn on rapid bootstrapping\n\
      \              CAUTION: unlike in version 7.0.4 RAxML will conduct rapid BS
      replicates under \n              the model of rate heterogeneity you specified
      via \"-m\" and not by default under CAT"
    inputBinding:
      position: 101
      prefix: -x
  - id: secondary_structure_file
    type:
      - 'null'
      - File
    doc: "Specify the name of a secondary structure file. The file can contain \"\
      .\" for \n              alignment columns that do not form part of a stem and
      characters \"()<>[]{}\" to define \n              stem regions and pseudoknots"
    inputBinding:
      position: 101
      prefix: -S
  - id: secondary_structure_subst_model
    type:
      - 'null'
      - string
    doc: "Specify one of the secondary structure substitution models implemented in
      RAxML. The same nomenclature as in the PHASE manual is used, available models:
      S6A, S6B, S6C, S6D, S6E, S7A, S7B, S7C, S7D, S7E, S7F, S16, S16A, S16B\n\n \
      \             DEFAULT: 16-state GTR model (S16)"
    inputBinding:
      position: 101
      prefix: -A
  - id: sequence_file
    type: File
    doc: Specify the name of the alignment data file in PHYLIP format
    inputBinding:
      position: 101
      prefix: -s
  - id: silent_output
    type:
      - 'null'
      - boolean
    doc: "Disables printout of warnings related to identical sequences and entirely
      undetermined sites in the alignment\n\n              DEFAULT: Off"
    inputBinding:
      position: 101
      prefix: --silent
  - id: sliding_window_size
    type:
      - 'null'
      - int
    doc: "Sliding window size for leave-one-out site-specific placement bias algorithm\n\
      \              only effective when used in combination with \"-f S\" \n\n  \
      \            DEFAULT: 100 sites"
    default: 100
    inputBinding:
      position: 101
      prefix: -W
  - id: substitution_model
    type: string
    doc: Model of Binary (Morphological), Nucleotide, Multi-State, or Amino Acid
      Substitution
    inputBinding:
      position: 101
      prefix: -m
  - id: superficial_parsimony_search
    type:
      - 'null'
      - boolean
    doc: "Same as the \"-y\" option below, however the parsimony search is more superficial.\n\
      \              RAxML will only do a randomized stepwise addition order parsimony
      tree reconstruction\n              without performing any additional SPRs.\n\
      \              This may be helpful for very broad whole-genome datasets, since
      this can generate topologically\n              more different starting trees.\n\
      \n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -X
  - id: use_hky85_model
    type:
      - 'null'
      - boolean
    doc: "specify that all DNA partitions will evolve under the HKY85 model, this
      overrides all other model specifications for DNA partitions.\n\n           \
      \       DEFAULT: Off"
    inputBinding:
      position: 101
      prefix: --HKY85
  - id: use_jukes_cantor_model
    type:
      - 'null'
      - boolean
    doc: "specify that all DNA partitions will evolve under the Jukes-Cantor model,
      this overrides all other model specifications for DNA partitions.\n\n      \
      \            DEFAULT: Off"
    inputBinding:
      position: 101
      prefix: --JC69
  - id: use_k80_model
    type:
      - 'null'
      - boolean
    doc: "specify that all DNA partitions will evolve under the K80 model, this overrides
      all other model specifications for DNA partitions.\n\n                  DEFAULT:
      Off"
    inputBinding:
      position: 101
      prefix: --K80
  - id: use_median_discrete_gamma
    type:
      - 'null'
      - boolean
    doc: "use the median for the discrete approximation of the GAMMA model of rate
      heterogeneity\n\n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -u
  - id: use_sev_implementation_for_gaps
    type:
      - 'null'
      - boolean
    doc: "Try to save memory by using SEV-based implementation for gap columns on
      large gappy alignments\n              The technique is described here: http://www.biomedcentral.com/1471-2105/12/470\n\
      \              This will only work for DNA and/or PROTEIN data and only with
      the SSE3 or AVX-vextorized version of the code."
    inputBinding:
      position: 101
      prefix: -U
  - id: user_starting_tree
    type:
      - 'null'
      - File
    doc: Specify a user starting tree file name in Newick format
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose_output_L_f_i
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output for the \"-L\" and \"-f i\" options. This will produce
      more, as well as more verbose output files\n\n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -C
  - id: wc_criterion_threshold
    type:
      - 'null'
      - float
    doc: "specify a floating point number between 0.0 and 1.0 that will be used as
      cutoff threshold for the MR-based bootstopping criteria. The recommended setting
      is 0.03.\n\n              DEFAULT: 0.03 (recommended empirically determined
      setting)"
    inputBinding:
      position: 101
      prefix: -B
  - id: weight_file
    type:
      - 'null'
      - File
    doc: Specify a column weight file name to assign individual weights to each 
      column of the alignment. Those weights must be integers separated by any 
      type and number of whitespaces whithin a separate file, see file 
      "example_weights" for an example.
    inputBinding:
      position: 101
      prefix: -a
  - id: write_intermediate_tree_files
    type:
      - 'null'
      - boolean
    doc: "Specifies that intermediate tree files shall be written to file during the
      standard ML and BS tree searches.\n\n              DEFAULT: OFF"
    inputBinding:
      position: 101
      prefix: -j
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "FULL (!) path to the directory into which RAxML shall write its output files\n\
      \n              DEFAULT: current directory"
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3
