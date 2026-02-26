cwlVersion: v1.2
class: CommandLineTool
baseCommand: pplacer
label: pplacer
doc: "pplacer [options] [alignment]\n\nTool homepage: http://matsen.fredhutch.org/pplacer/"
inputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: add_map_identity
    type:
      - 'null'
      - boolean
    doc: Add the percent identity of the query sequence to the nearest MAP 
      sequence to each placement.
    inputBinding:
      position: 102
      prefix: --map-identity
  - id: always_refine_model
    type:
      - 'null'
      - boolean
    doc: Always refine the model before placing.
    inputBinding:
      position: 102
      prefix: --always-refine
  - id: calculate_posterior_probabilities
    type:
      - 'null'
      - boolean
    doc: Calculate posterior probabilities.
    inputBinding:
      position: 102
      prefix: -p
  - id: check_likelihood
    type:
      - 'null'
      - boolean
    doc: Write out the likelihood of the reference tree, calculated two ways.
    inputBinding:
      position: 102
      prefix: --check-like
  - id: classify_with_mrcas
    type:
      - 'null'
      - boolean
    doc: Classify with MRCAs instead of a painted tree.
    inputBinding:
      position: 102
      prefix: --mrca-class
  - id: discard_nonoverlapped
    type:
      - 'null'
      - boolean
    doc: When pre-masking, silently discard sequences which don't overlap the 
      mask.
    inputBinding:
      position: 102
      prefix: --discard-nonoverlapped
  - id: display_timing
    type:
      - 'null'
      - boolean
    doc: Display timing information after the pplacer run finishes.
    inputBinding:
      position: 102
      prefix: --timing
  - id: evaluate_all_likelihoods
    type:
      - 'null'
      - boolean
    doc: Evaluate all likelihoods to ensure that the best location was selected.
    inputBinding:
      position: 102
      prefix: --fig-eval-all
  - id: fantasy_fragment_fraction
    type:
      - 'null'
      - float
    doc: Fraction of fragments to use when running fantasy baseball.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --fantasy-frac
  - id: fantasy_likelihood_cutoff
    type:
      - 'null'
      - float
    doc: Desired likelihood cutoff for fantasy baseball mode. 0 -> no fantasy.
    inputBinding:
      position: 102
      prefix: --fantasy
  - id: fig_cutoff
    type:
      - 'null'
      - float
    doc: The cutoff for determining figs. Default is 0; specify 0 to disable.
    default: 0
    inputBinding:
      position: 102
      prefix: --fig-cutoff
  - id: gamma_alpha
    type:
      - 'null'
      - float
    doc: Specify the shape parameter for a discrete gamma model.
    inputBinding:
      position: 102
      prefix: --gamma-alpha
  - id: gamma_categories
    type:
      - 'null'
      - int
    doc: Number of categories for discrete gamma model.
    inputBinding:
      position: 102
      prefix: --gamma-cats
  - id: informative_prior_lower_bound
    type:
      - 'null'
      - float
    doc: Lower bound for the informative prior mean.
    default: 0
    inputBinding:
      position: 102
      prefix: --prior-lower
  - id: keep_factor
    type:
      - 'null'
      - float
    doc: Throw away anything that has ml_ratio below keep_factor times (best 
      ml_ratio).
    default: 0.01
    inputBinding:
      position: 102
      prefix: --keep-factor
  - id: map_mrca_file
    type:
      - 'null'
      - File
    doc: Specify a file to write out MAP sequences for MRCAs and corresponding 
      placements.
    inputBinding:
      position: 102
      prefix: --map-mrca
  - id: map_mrca_min_cutoff
    type:
      - 'null'
      - float
    doc: Specify cutoff for inclusion in MAP sequence file.
    default: 0.8
    inputBinding:
      position: 102
      prefix: --map-mrca-min
  - id: max_pendant_branch_length
    type:
      - 'null'
      - float
    doc: Set the maximum ML pendant branch length.
    default: 2
    inputBinding:
      position: 102
      prefix: --max-pend
  - id: max_pitches
    type:
      - 'null'
      - int
    doc: Set the maximum number of pitches for baseball.
    default: 40
    inputBinding:
      position: 102
      prefix: --max-pitches
  - id: max_placements_to_keep
    type:
      - 'null'
      - int
    doc: The maximum number of placements we keep.
    default: 7
    inputBinding:
      position: 102
      prefix: --keep-at-most
  - id: max_strikes
    type:
      - 'null'
      - int
    doc: Maximum number of strikes for baseball. 0 -> no ball playing.
    default: 6
    inputBinding:
      position: 102
      prefix: --max-strikes
  - id: ml_tolerance
    type:
      - 'null'
      - float
    doc: 1st stage branch len optimization tolerance (2nd stage to 1e-5).
    default: 0.01
    inputBinding:
      position: 102
      prefix: --ml-tolerance
  - id: mmap_file
    type:
      - 'null'
      - File
    doc: Instead of doing large allocations, mmap the given file. It will be 
      created if it doesn't exist.
    inputBinding:
      position: 102
      prefix: --mmap-file
  - id: no_pre_mask
    type:
      - 'null'
      - boolean
    doc: Don't pre-mask sequences before placement.
    inputBinding:
      position: 102
      prefix: --no-pre-mask
  - id: num_child_processes
    type:
      - 'null'
      - int
    doc: The number of child processes to spawn when doing placements.
    default: 2
    inputBinding:
      position: 102
      prefix: -j
  - id: num_groups
    type:
      - 'null'
      - int
    doc: Split query alignment into the specified number of groups.
    inputBinding:
      position: 102
      prefix: --groups
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Specify the directory to write place files to.
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: phyml_stats_or_raxml_info
    type:
      - 'null'
      - File
    doc: Supply a phyml stats.txt or a RAxML info file giving the model 
      parameters.
    inputBinding:
      position: 102
      prefix: -s
  - id: pp_relative_error
    type:
      - 'null'
      - float
    doc: Relative error for the posterior probability calculation.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --pp-rel-err
  - id: pretend_run
    type:
      - 'null'
      - boolean
    doc: Only check out the files then report. Do not run the analysis.
    inputBinding:
      position: 102
      prefix: --pretend
  - id: reference_alignment_filename
    type:
      - 'null'
      - File
    doc: Specify the reference alignment filename.
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_info_directory
    type:
      - 'null'
      - Directory
    doc: Specify the directory containing the reference information.
    inputBinding:
      position: 102
      prefix: -d
  - id: reference_package_path
    type:
      - 'null'
      - string
    doc: Specify the path to the reference package.
    inputBinding:
      position: 102
      prefix: -c
  - id: reference_tree_filename
    type:
      - 'null'
      - File
    doc: Specify the reference tree filename.
    inputBinding:
      position: 102
      prefix: -t
  - id: start_pendant_branch_length
    type:
      - 'null'
      - float
    doc: Starting pendant branch length.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --start-pend
  - id: strike_box_size
    type:
      - 'null'
      - float
    doc: Set the size of the strike box in log likelihood units.
    default: 3
    inputBinding:
      position: 102
      prefix: --strike-box
  - id: substitution_model
    type:
      - 'null'
      - string
    doc: 'Substitution model. Protein: LG, WAG, or JTT. Nucleotides: GTR.'
    inputBinding:
      position: 102
      prefix: -m
  - id: use_informative_prior
    type:
      - 'null'
      - boolean
    doc: Use an informative exponential prior based on rooted distance to 
      leaves.
    inputBinding:
      position: 102
      prefix: --inform-prior
  - id: use_model_frequencies
    type:
      - 'null'
      - boolean
    doc: Use model frequencies instead of reference alignment frequencies.
    inputBinding:
      position: 102
      prefix: --model-freqs
  - id: use_uniform_prior
    type:
      - 'null'
      - boolean
    doc: Use a uniform prior rather than exponential.
    inputBinding:
      position: 102
      prefix: --unif-prior
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: Set verbosity level. 0 is silent, and 2 is quite a lot.
    default: 1
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_discrepancy_tree
    type:
      - 'null'
      - boolean
    doc: Write out a tree showing the discrepancies between the best complete 
      and observed locations.
    inputBinding:
      position: 102
      prefix: --fig-eval-discrepancy-tree
  - id: write_fig_tree
    type:
      - 'null'
      - boolean
    doc: Write out a tree showing the figs on the tree.
    inputBinding:
      position: 102
      prefix: --fig-tree
  - id: write_masked_alignment
    type:
      - 'null'
      - boolean
    doc: Write alignment masked to the region without gaps in the query.
    inputBinding:
      position: 102
      prefix: --write-masked
  - id: write_pre_masked_sequences
    type:
      - 'null'
      - File
    doc: Write out the pre-masked sequences to the specified fasta file before 
      placement.
    inputBinding:
      position: 102
      prefix: --write-pre-masked
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pplacer:1.1.alpha17--0
