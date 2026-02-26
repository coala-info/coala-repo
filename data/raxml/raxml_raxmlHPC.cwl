cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxmlHPC
label: raxml_raxmlHPC
doc: "RAxML (Randomized Axelerated Maximum Likelihood) is a program for phylogenetic
  tree inference using maximum likelihood.\n\nTool homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: select algorithm
    inputBinding:
      position: 101
      prefix: -f
  - id: asc_corr
    type:
      - 'null'
      - string
    doc: Allows to specify the type of ascertainment bias correction you wish to
      use.
    inputBinding:
      position: 101
      prefix: --asc-corr
  - id: auto_prot_criterion
    type:
      - 'null'
      - string
    doc: When using automatic protein model selection you can chose the 
      criterion for selecting these models.
    default: ml
    inputBinding:
      position: 101
      prefix: --auto-prot
  - id: binary_constraint_tree
    type:
      - 'null'
      - File
    doc: Specify the file name of a binary constraint tree.
    inputBinding:
      position: 101
      prefix: -r
  - id: binary_model_parameter_file
    type:
      - 'null'
      - File
    doc: Specify the file name of a binary model parameter file that has 
      previously been generated with RAxML using the -f e tree evaluation 
      option.
    inputBinding:
      position: 101
      prefix: -R
  - id: bootstop_perms
    type:
      - 'null'
      - int
    doc: specify the number of permutations to be conducted for the 
      bootstopping/bootstrap convergence test.
    default: 100
    inputBinding:
      position: 101
      prefix: --bootstop-perms
  - id: bootstopping_analysis
    type:
      - 'null'
      - string
    doc: 'a posteriori bootstopping analysis. Use: "-I autoFC" for the frequency-based
      criterion, "-I autoMR" for the majority-rule consensus tree criterion, "-I autoMRE"
      for the extended majority-rule consensus tree criterion, "-I autoMRE_IGN" for
      metrics similar to MRE, but include bipartitions under the threshold whether
      they are compatible or not.'
    inputBinding:
      position: 101
      prefix: -I
  - id: bootstrap_random_seed
    type:
      - 'null'
      - int
    doc: Specify an integer number (random seed) and turn on bootstrapping
    inputBinding:
      position: 101
      prefix: -b
  - id: compute_parsimony_starting_tree_only
    type:
      - 'null'
      - boolean
    doc: If you want to only compute a parsimony starting tree with RAxML 
      specify "-y", the program will exit after computation of the starting tree
    inputBinding:
      position: 101
      prefix: -y
  - id: consensus_tree_labeling
    type:
      - 'null'
      - string
    doc: Compute consensus trees labelled by IC supports and the overall TC 
      value as proposed in Salichos and Rokas 2013.
    inputBinding:
      position: 101
      prefix: -L
  - id: consensus_tree_type
    type:
      - 'null'
      - string
    doc: Compute majority rule consensus tree with "-J MR" or extended majority 
      rule consensus tree with "-J MRE" or strict consensus tree with "-J 
      STRICT".
    inputBinding:
      position: 101
      prefix: -J
  - id: constraint_tree_file
    type:
      - 'null'
      - File
    doc: specify the file name of a multifurcating constraint tree
    inputBinding:
      position: 101
      prefix: -g
  - id: disable_pattern_compression
    type:
      - 'null'
      - boolean
    doc: Disable pattern compression.
    inputBinding:
      position: 101
      prefix: -H
  - id: disable_rate_heterogeneity
    type:
      - 'null'
      - boolean
    doc: Disable rate heterogeneity among sites model and use one without rate 
      heterogeneity instead.
    inputBinding:
      position: 101
      prefix: -V
  - id: disable_undetermined_sequence_check
    type:
      - 'null'
      - boolean
    doc: Disable check for completely undetermined sequence in alignment.
    inputBinding:
      position: 101
      prefix: -O
  - id: enable_cat_model_for_large_trees
    type:
      - 'null'
      - boolean
    doc: enable ML tree searches under CAT model for very large trees without 
      switching to GAMMA in the end (saves memory).
    inputBinding:
      position: 101
      prefix: -F
  - id: epa_accumulated_threshold
    type:
      - 'null'
      - float
    doc: specify an accumulated likelihood weight threshold for which different 
      placements of read are printed to file.
    inputBinding:
      position: 101
      prefix: --epa-accumulated-threshold
  - id: epa_keep_placements
    type:
      - 'null'
      - int
    doc: specify the number of potential placements you want to keep for each 
      read in the EPA algorithm.
    default: 7
    inputBinding:
      position: 101
      prefix: --epa-keep-placements
  - id: epa_prob_threshold
    type:
      - 'null'
      - float
    doc: specify a percent threshold for including potential placements of a 
      read depending on the maximum placement weight for this read.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --epa-prob-threshold
  - id: estimate_partition_branch_lengths
    type:
      - 'null'
      - boolean
    doc: Switch on estimation of individual per-partition branch lengths.
    inputBinding:
      position: 101
      prefix: -M
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: specify an exclude file name, that contains a specification of 
      alignment positions you wish to exclude.
    inputBinding:
      position: 101
      prefix: -E
  - id: flag_check
    type:
      - 'null'
      - boolean
    doc: When using this option, RAxML will only check if all command line flags
      specifed are available and then exit with a message listing all invalid 
      command line flags or with a message stating that all flags are valid.
    inputBinding:
      position: 101
      prefix: --flag-check
  - id: initial_rearrangement_setting
    type:
      - 'null'
      - string
    doc: Initial rearrangement setting for the subsequent application of 
      topological changes phase
    inputBinding:
      position: 101
      prefix: -i
  - id: likelihood_epsilon
    type:
      - 'null'
      - float
    doc: set model optimization precision in log likelihood units for final 
      optimization of tree topology
    inputBinding:
      position: 101
      prefix: -e
  - id: mesquite_output
    type:
      - 'null'
      - boolean
    doc: Print output files that can be parsed by Mesquite.
    inputBinding:
      position: 101
      prefix: --mesquite
  - id: ml_search_convergence_criterion
    type:
      - 'null'
      - boolean
    doc: ML search convergence criterion. This will break off ML searches if the
      relative Robinson-Foulds distance between the trees obtained from two 
      consecutive lazy SPR cycles is smaller or equal to 1%.
    inputBinding:
      position: 101
      prefix: -D
  - id: multi_state_substitution_model
    type:
      - 'null'
      - string
    doc: Specify one of the multi-state substitution models (max 32 states) 
      implemented in RAxML.
    inputBinding:
      position: 101
      prefix: -K
  - id: multiple_trees_file
    type:
      - 'null'
      - File
    doc: Specify the file name of a file containing multiple trees e.g. from a 
      bootstrap that shall be used to draw bipartition values onto a tree 
      provided with "-t"
    inputBinding:
      position: 101
      prefix: -z
  - id: no_bfgs
    type:
      - 'null'
      - boolean
    doc: Disables automatic usage of BFGS method to optimize GTR rates on 
      unpartitioned DNA datasets
    inputBinding:
      position: 101
      prefix: --no-bfgs
  - id: no_seq_check
    type:
      - 'null'
      - boolean
    doc: Disables checking the input MSA for identical sequences and entirely 
      undetermined sites.
    inputBinding:
      position: 101
      prefix: --no-seq-check
  - id: num_alternative_runs
    type:
      - 'null'
      - string
    doc: Specify the number of alternative runs on distinct starting trees
    default: '1'
    inputBinding:
      position: 101
      prefix: -#
  - id: num_rate_categories
    type:
      - 'null'
      - int
    doc: Specify number of distinct rate catgories for RAxML when model of rate 
      heterogeneity is set to CAT
    default: 25
    inputBinding:
      position: 101
      prefix: -c
  - id: num_runs
    type:
      - 'null'
      - string
    doc: Specify the number of alternative runs on distinct starting trees
    default: '1'
    inputBinding:
      position: 101
      prefix: -N
  - id: num_threads
    type:
      - 'null'
      - int
    doc: PTHREADS VERSION ONLY! Specify the number of threads you want to run.
    inputBinding:
      position: 101
      prefix: -T
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the name of a single outgroup or a comma-separated list of 
      outgroups, eg "-o Rat" or "-o Rat,Mouse", in case that multiple outgroups 
      are not monophyletic the first name in the list will be selected as 
      outgroup, don't leave spaces between taxon names!
    inputBinding:
      position: 101
      prefix: -o
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: FULL (!) path to the directory into which RAxML shall write its output 
      files
    inputBinding:
      position: 101
      prefix: -w
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
    doc: Specify a random number seed for the parsimony inferences.
    inputBinding:
      position: 101
      prefix: -p
  - id: partition_assignment_file
    type:
      - 'null'
      - File
    doc: Specify the file name which contains the assignment of models to 
      alignment partitions for multiple models of substitution.
    inputBinding:
      position: 101
      prefix: -q
  - id: placement_threshold
    type:
      - 'null'
      - float
    doc: enable the ML-based evolutionary placement algorithm heuristics by 
      specifiyng a threshold value (fraction of insertion branches to be 
      evaluated using slow insertions under ML).
    inputBinding:
      position: 101
      prefix: -G
  - id: print_bootstrapped_trees_with_lengths
    type:
      - 'null'
      - boolean
    doc: Specifies that bootstrapped trees should be printed with branch 
      lengths.
    inputBinding:
      position: 101
      prefix: -k
  - id: print_identical_sequences
    type:
      - 'null'
      - boolean
    doc: specify that RAxML shall automatically generate a .reduced alignment 
      with all undetermined columns removed, but without removing exactly 
      identical sequences
    inputBinding:
      position: 101
      prefix: --print-identical-sequences
  - id: protein_model_file
    type:
      - 'null'
      - File
    doc: Specify the file name of a user-defined AA (Protein) substitution 
      model.
    inputBinding:
      position: 101
      prefix: -P
  - id: quartet_grouping_file
    type:
      - 'null'
      - File
    doc: Pass a quartet grouping file name defining four groups from which to 
      draw quartets
    inputBinding:
      position: 101
      prefix: -Y
  - id: quartets_without_replacement
    type:
      - 'null'
      - boolean
    doc: specify that quartets are randomly subsampled, but without replacement.
    inputBinding:
      position: 101
      prefix: --quartets-without-replacement
  - id: rapid_bootstrap_random_seed
    type:
      - 'null'
      - int
    doc: Specify an integer number (random seed) and turn on rapid bootstrapping
    inputBinding:
      position: 101
      prefix: -x
  - id: save_memory_sev_implementation
    type:
      - 'null'
      - boolean
    doc: Try to save memory by using SEV-based implementation for gap columns on
      large gappy alignments
    inputBinding:
      position: 101
      prefix: -U
  - id: secondary_structure_file
    type:
      - 'null'
      - File
    doc: Specify the name of a secondary structure file.
    inputBinding:
      position: 101
      prefix: -S
  - id: secondary_structure_subst_model
    type:
      - 'null'
      - string
    doc: Specify one of the secondary structure substitution models implemented 
      in RAxML.
    inputBinding:
      position: 101
      prefix: -A
  - id: sequence_file
    type: File
    doc: Specify the name of the alignment data file in PHYLIP format
    inputBinding:
      position: 101
      prefix: -s
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Disables printout of warnings related to identical sequences and 
      entirely undetermined sites in the alignment
    inputBinding:
      position: 101
      prefix: --silent
  - id: sliding_window_size
    type:
      - 'null'
      - int
    doc: Sliding window size for leave-one-out site-specific placement bias 
      algorithm
    default: 100
    inputBinding:
      position: 101
      prefix: -W
  - id: start_ml_optimization_random_tree
    type:
      - 'null'
      - boolean
    doc: start ML optimization from random starting tree
    inputBinding:
      position: 101
      prefix: -d
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
    doc: Same as the "-y" option below, however the parsimony search is more 
      superficial.
    inputBinding:
      position: 101
      prefix: -X
  - id: use_hky85_model
    type:
      - 'null'
      - boolean
    doc: specify that all DNA partitions will evolve under the HKY85 model, this
      overrides all other model specifications for DNA partitions.
    inputBinding:
      position: 101
      prefix: --HKY85
  - id: use_jukes_cantor_model
    type:
      - 'null'
      - boolean
    doc: specify that all DNA partitions will evolve under the Jukes-Cantor 
      model, this overrides all other model specifications for DNA partitions.
    inputBinding:
      position: 101
      prefix: --JC69
  - id: use_k80_model
    type:
      - 'null'
      - boolean
    doc: specify that all DNA partitions will evolve under the K80 model, this 
      overrides all other model specifications for DNA partitions.
    inputBinding:
      position: 101
      prefix: --K80
  - id: use_median_for_gamma_approximation
    type:
      - 'null'
      - boolean
    doc: use the median for the discrete approximation of the GAMMA model of 
      rate heterogeneity
    inputBinding:
      position: 101
      prefix: -u
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
    doc: Enable verbose output for the "-L" and "-f i" options. This will 
      produce more, as well as more verbose output files
    inputBinding:
      position: 101
      prefix: -C
  - id: wc_criterion_threshold
    type:
      - 'null'
      - float
    doc: specify a floating point number between 0.0 and 1.0 that will be used 
      as cutoff threshold for the MR-based bootstopping criteria.
    default: 0.03
    inputBinding:
      position: 101
      prefix: -B
  - id: weight_file
    type:
      - 'null'
      - File
    doc: Specify a column weight file name to assign individual weights to each 
      column of the alignment.
    inputBinding:
      position: 101
      prefix: -a
  - id: write_intermediate_tree_files
    type:
      - 'null'
      - boolean
    doc: Specifies that intermediate tree files shall be written to file during 
      the standard ML and BS tree searches.
    inputBinding:
      position: 101
      prefix: -j
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3
stdout: raxml_raxmlHPC.out
