cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_pasta.py
label: pasta_run_pasta.py
doc: "PASTA performs iterative realignment and tree inference, similar to SATe, but
  uses a very different merge algorithm which improves running time, memory usage,
  and accuracy.\n\nTool homepage: https://github.com/smirarab/pasta"
inputs:
  - id: settings_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Configuration files containing settings
    inputBinding:
      position: 1
  - id: after_blind_iter_term_limit
    type:
      - 'null'
      - int
    doc: Maximum number of iterations after entering blind mode.
    inputBinding:
      position: 102
      prefix: --after-blind-iter-term-limit
  - id: after_blind_iter_without_imp_limit
    type:
      - 'null'
      - int
    doc: Maximum number of iterations without improvement after entering blind mode.
    inputBinding:
      position: 102
      prefix: --after-blind-iter-without-imp-limit
  - id: after_blind_time_term_limit
    type:
      - 'null'
      - float
    doc: Maximum time (seconds) after entering blind mode.
    inputBinding:
      position: 102
      prefix: --after-blind-time-term-limit
  - id: after_blind_time_without_imp_limit
    type:
      - 'null'
      - float
    doc: Maximum time (seconds) since last improvement after entering blind mode.
    inputBinding:
      position: 102
      prefix: --after-blind-time-without-imp-limit
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: If used, then the input file be will treated as aligned for the purposes
      of the first round of tree inference
    inputBinding:
      position: 102
      prefix: --aligned
  - id: aligner
    type:
      - 'null'
      - string
    doc: The name of the alignment program to use for subproblems.
    inputBinding:
      position: 102
      prefix: --aligner
  - id: alignment_suffix
    type:
      - 'null'
      - string
    doc: suffix for alignment name
    inputBinding:
      position: 102
      prefix: --alignment-suffix
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Automatically identify default values for max_subproblem_size, number of
      cpus, tools, breaking strategy, masking criteria, and stopping criteria.
    inputBinding:
      position: 102
      prefix: --auto
  - id: blind_after_iter_without_imp
    type:
      - 'null'
      - int
    doc: Maximum number of iterations without an improvement before switching to blind
      mode.
    inputBinding:
      position: 102
      prefix: --blind-after-iter-without-imp
  - id: blind_after_time_without_imp
    type:
      - 'null'
      - float
    doc: Maximum time (seconds) without an improvement before switching to blind mode.
    inputBinding:
      position: 102
      prefix: --blind-after-time-without-imp
  - id: blind_after_total_iter
    type:
      - 'null'
      - int
    doc: Maximum number of iterations before switching to blind mode.
    inputBinding:
      position: 102
      prefix: --blind-after-total-iter
  - id: blind_after_total_time
    type:
      - 'null'
      - float
    doc: Maximum time (seconds) before switching to blind mode.
    inputBinding:
      position: 102
      prefix: --blind-after-total-time
  - id: break_strategy
    type:
      - 'null'
      - string
    doc: The method for choosing an edge when bisecting the tree during decomposition
    inputBinding:
      position: 102
      prefix: --break-strategy
  - id: build_mst
    type:
      - 'null'
      - boolean
    doc: Construct the spanning tree using minimum spanning tree algorithm
    inputBinding:
      position: 102
      prefix: --build-MST
  - id: datatype
    type:
      - 'null'
      - string
    doc: Specify DNA, RNA, or Protein to indicate what type of data is specified.
    inputBinding:
      position: 102
      prefix: --datatype
  - id: input
    type: File
    doc: input sequence file
    inputBinding:
      position: 102
      prefix: --input
  - id: iter_limit
    type:
      - 'null'
      - int
    doc: The maximum number of iterations that the PASTA algorithm will run.
    inputBinding:
      position: 102
      prefix: --iter-limit
  - id: iter_without_imp_limit
    type:
      - 'null'
      - int
    doc: The maximum number of iterations without an improvement in score.
    inputBinding:
      position: 102
      prefix: --iter-without-imp-limit
  - id: job
    type:
      - 'null'
      - string
    doc: job name
    inputBinding:
      position: 102
      prefix: --job
  - id: keepalignmenttemps
    type:
      - 'null'
      - boolean
    doc: Keep even the realignment temporary running files (requires keeptemp)
    inputBinding:
      position: 102
      prefix: --keepalignmenttemps
  - id: keeptemp
    type:
      - 'null'
      - boolean
    doc: Keep temporary running files?
    inputBinding:
      position: 102
      prefix: --keeptemp
  - id: mask_gappy_sites
    type:
      - 'null'
      - float
    doc: The minimum number of non-gap characters required in each column passed to
      tree estimation.
    inputBinding:
      position: 102
      prefix: --mask-gappy-sites
  - id: max_mem_mb
    type:
      - 'null'
      - int
    doc: The maximum memory available to OPAL (Java heap size).
    inputBinding:
      position: 102
      prefix: --max-mem-mb
  - id: max_subproblem_frac
    type:
      - 'null'
      - float
    doc: The maximum size of subproblems as a proportion of total leaves.
    inputBinding:
      position: 102
      prefix: --max-subproblem-frac
  - id: max_subproblem_size
    type:
      - 'null'
      - int
    doc: The maximum size (number of leaves) of subproblems.
    inputBinding:
      position: 102
      prefix: --max-subproblem-size
  - id: max_subtree_diameter
    type:
      - 'null'
      - float
    doc: The maximum diameter of each subtree.
    inputBinding:
      position: 102
      prefix: --max-subtree-diameter
  - id: merger
    type:
      - 'null'
      - string
    doc: The name of the alignment program to use to merge subproblems.
    inputBinding:
      position: 102
      prefix: --merger
  - id: min_subproblem_size
    type:
      - 'null'
      - int
    doc: The minimum size (number of leaves) of subproblems.
    inputBinding:
      position: 102
      prefix: --min-subproblem-size
  - id: missing
    type:
      - 'null'
      - string
    doc: How to deal with missing data symbols (Ambiguous or Absent)
    inputBinding:
      position: 102
      prefix: --missing
  - id: move_to_blind_on_worse_score
    type:
      - 'null'
      - boolean
    doc: Move to blind mode as soon as a worse score is encountered.
    inputBinding:
      position: 102
      prefix: --move-to-blind-on-worse-score
  - id: multilocus
    type:
      - 'null'
      - boolean
    doc: Analyze multi-locus data? NOT SUPPORTED IN CURRENT PASTA version.
    inputBinding:
      position: 102
      prefix: --multilocus
  - id: no_blind_mode_is_final
    type:
      - 'null'
      - boolean
    doc: PASTA will never leave blind mode once it has entered it.
    inputBinding:
      position: 102
      prefix: --no-blind-mode-is-final
  - id: no_return_final_tree_and_alignment
    type:
      - 'null'
      - boolean
    doc: Return the best likelihood tree and alignment pair instead of those from
      the last iteration.
    inputBinding:
      position: 102
      prefix: --no-return-final-tree-and-alignment
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: The number of processing cores to assign to PASTA.
    inputBinding:
      position: 102
      prefix: --num-cpus
  - id: raxml_search_after
    type:
      - 'null'
      - boolean
    doc: Perform a tree search using RAxML on the masked alignment after PASTA algorithm
      completion.
    inputBinding:
      position: 102
      prefix: --raxml-search-after
  - id: start_tree_search_from_current
    type:
      - 'null'
      - boolean
    doc: Use the tree from the previous iteration as a starting tree for the search
      tool.
    inputBinding:
      position: 102
      prefix: --start-tree-search-from-current
  - id: temporaries
    type:
      - 'null'
      - Directory
    doc: directory that will be the parent for this job's temporary file
    inputBinding:
      position: 102
      prefix: --temporaries
  - id: time_limit
    type:
      - 'null'
      - float
    doc: Maximum time (seconds) that PASTA will continue starting new iterations.
    inputBinding:
      position: 102
      prefix: --time-limit
  - id: time_without_imp_limit
    type:
      - 'null'
      - float
    doc: Maximum time (seconds) since the last improvement in score.
    inputBinding:
      position: 102
      prefix: --time-without-imp-limit
  - id: tree_estimator
    type:
      - 'null'
      - string
    doc: The name of the tree inference program to use to find trees on fixed alignments.
    inputBinding:
      position: 102
      prefix: --tree-estimator
  - id: treefile
    type:
      - 'null'
      - File
    doc: starting tree file
    inputBinding:
      position: 102
      prefix: --treefile
  - id: treeshrink_filter
    type:
      - 'null'
      - boolean
    doc: Filter inferred FastTree by TreeShrink for long branch outliers.
    inputBinding:
      position: 102
      prefix: --treeshrink-filter
  - id: two_phase
    type:
      - 'null'
      - boolean
    doc: Simply call the sequence aligner then the tree estimator without the PASTA
      algorithm.
    inputBinding:
      position: 102
      prefix: --two-phase
  - id: untrusted
    type:
      - 'null'
      - boolean
    doc: Parse input file using a more careful procedure (slower, more memory).
    inputBinding:
      position: 102
      prefix: --untrusted
outputs:
  - id: exportconfig
    type:
      - 'null'
      - File
    doc: Export the configuration to the specified file and exit.
    outputBinding:
      glob: $(inputs.exportconfig)
  - id: timesfile
    type:
      - 'null'
      - File
    doc: optional file that will store the times of events during the PASTA run
    outputBinding:
      glob: $(inputs.timesfile)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: directory for output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasta:1.9.3--py312hccd54bf_0
