cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcl
label: mcl
doc: "Performs Markov Cluster Algorithm (MCL) for graph clustering.\n\nTool homepage:
  https://micans.org/mcl/"
inputs:
  - id: abc_neg_log10_transform
    type:
      - 'null'
      - string
    doc: log10-transform label value, negate sign
    inputBinding:
      position: 101
      prefix: --abc-neg-log10
  - id: abc_neg_log_transform
    type:
      - 'null'
      - string
    doc: log-transform label value, negate sign
    inputBinding:
      position: 101
      prefix: --abc-neg-log
  - id: abc_tf_transform
    type:
      - 'null'
      - string
    doc: transform label values
    inputBinding:
      position: 101
      prefix: -abc-tf
  - id: allowed_neighbours
    type:
      - 'null'
      - int
    doc: allow <int> neighbours throughout computation
    inputBinding:
      position: 101
      prefix: -resource
  - id: analyze
    type:
      - 'null'
      - string
    doc: append performance/characteristics measures
    inputBinding:
      position: 101
      prefix: -analyze
  - id: assume_expanded_input_inflation
    type:
      - 'null'
      - string
    doc: assume expanded input, inflate with parameter <num>
    inputBinding:
      position: 101
      prefix: -if
  - id: check_connected
    type:
      - 'null'
      - string
    doc: analyze clustering, see whether it induces cocos
    inputBinding:
      position: 101
      prefix: -check-connected
  - id: discard_loops
    type:
      - 'null'
      - string
    doc: remove loops in input graphs if any
    inputBinding:
      position: 101
      prefix: -discard-loops
  - id: dump_interval
    type:
      - 'null'
      - string
    doc: only dump for iterand indices in this interval
    inputBinding:
      position: 101
      prefix: -dump-interval
  - id: dump_iterands_to_screen
    type:
      - 'null'
      - string
    doc: (small graphs only [#<20]) dump iterands to *screen*
    inputBinding:
      position: 101
      prefix: --show
  - id: dump_mode
    type:
      - 'null'
      - string
    doc: <mode> in chr|ite|cls|dag (cf manual page)
    inputBinding:
      position: 101
      prefix: -dump
  - id: dump_modulo
    type:
      - 'null'
      - int
    doc: only dump if the iterand index modulo <int> vanishes
    inputBinding:
      position: 101
      prefix: -dump-modulo
  - id: dump_stem
    type:
      - 'null'
      - string
    doc: use <str> to construct dump (file) names
    inputBinding:
      position: 101
      prefix: -dump-stem
  - id: estimated_ram_nodes
    type:
      - 'null'
      - int
    doc: show estimated RAM usage for graphs with <int> nodes
    inputBinding:
      position: 101
      prefix: --how-much-ram
  - id: estimated_sparse_matrix_vector_overhead
    type:
      - 'null'
      - string
    doc: estimated sparse matrix-vector overhead per summand (default 10)
    inputBinding:
      position: 101
      prefix: -sparse
  - id: expansion_thread_number
    type:
      - 'null'
      - int
    doc: expansion thread number, use with multiple CPUs
    inputBinding:
      position: 101
      prefix: -te
  - id: expect_abc_format
    type:
      - 'null'
      - string
    doc: expect abc-format (label input), write label output
    inputBinding:
      position: 101
      prefix: --abc
  - id: expect_etc_format
    type:
      - 'null'
      - string
    doc: expect etc-format (label input), write label output
    inputBinding:
      position: 101
      prefix: --etc
  - id: expect_sif_format
    type:
      - 'null'
      - string
    doc: expect sif-format (label input), write label output
    inputBinding:
      position: 101
      prefix: --sif
  - id: expect_values
    type:
      - 'null'
      - string
    doc: accept extended SIF or ETC format (label:weight fields)
    inputBinding:
      position: 101
      prefix: --expect-values
  - id: experiment_description
    type:
      - 'null'
      - string
    doc: string describing the experiment
    inputBinding:
      position: 101
      prefix: -annot
  - id: force_connected
    type:
      - 'null'
      - string
    doc: analyze clustering, make sure it induces cocos
    inputBinding:
      position: 101
      prefix: -force-connected
  - id: increase_loop_weights
    type:
      - 'null'
      - int
    doc: increase loop-weights <num>-fold
    inputBinding:
      position: 101
      prefix: -c
  - id: inverted_rigid_pruning_threshold
    type:
      - 'null'
      - int
    doc: (inverted) rigid pruning threshold (cf -z)
    inputBinding:
      position: 101
      prefix: -P
  - id: log_spec
    type:
      - 'null'
      - string
    doc: quiet level of logging
    inputBinding:
      position: 101
      prefix: -q
  - id: main_inflation_value
    type:
      - 'null'
      - float
    doc: main inflation value (default 2.0)
    inputBinding:
      position: 101
      prefix: -I
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: prepend <prefix> to mcl-created output file name
    inputBinding:
      position: 101
      prefix: -ap
  - id: output_file_suffix
    type:
      - 'null'
      - string
    doc: append <suffix> to mcl-created output file name
    inputBinding:
      position: 101
      prefix: -aa
  - id: overlap_mode
    type:
      - 'null'
      - string
    doc: what to do with overlap (default cut)
    inputBinding:
      position: 101
      prefix: -overlap
  - id: precision
    type:
      - 'null'
      - int
    doc: precision in interchange (intermediate matrices) output
    inputBinding:
      position: 101
      prefix: -digits
  - id: preprocess_inflation_parameter
    type:
      - 'null'
      - string
    doc: preprocess by applying inflation with parameter <num>
    inputBinding:
      position: 101
      prefix: -pi
  - id: preset_resource_scheme
    type:
      - 'null'
      - int
    doc: use a preset resource scheme (cf --show-schemes)
    inputBinding:
      position: 101
      prefix: -scheme
  - id: recover_max_entries
    type:
      - 'null'
      - int
    doc: recover to maximally <int> entries if needed
    inputBinding:
      position: 101
      prefix: -R
  - id: recovery_mass_percentage
    type:
      - 'null'
      - string
    doc: try recovery if mass is less than <pct>
    inputBinding:
      position: 101
      prefix: -pct
  - id: rigid_pruning_threshold
    type:
      - 'null'
      - string
    doc: the rigid pruning threshold
    inputBinding:
      position: 101
      prefix: -p
  - id: select_down_to_entries
    type:
      - 'null'
      - int
    doc: select down to <int> entries if needed
    inputBinding:
      position: 101
      prefix: -S
  - id: show_constructed_output_filename
    type:
      - 'null'
      - string
    doc: show output file name mcl would construct
    inputBinding:
      position: 101
      prefix: -az
  - id: show_constructed_suffix
    type:
      - 'null'
      - string
    doc: show the suffix mcl constructs from parameters
    inputBinding:
      position: 101
      prefix: -ax
  - id: show_default_settings
    type:
      - 'null'
      - string
    doc: show some of the default settings
    inputBinding:
      position: 101
      prefix: -z
  - id: show_jury_synopsis
    type:
      - 'null'
      - string
    doc: show the meaning of the jury pruning synopsis
    inputBinding:
      position: 101
      prefix: --jury-charter
  - id: show_log
    type:
      - 'null'
      - string
    doc: send log to stdout
    inputBinding:
      position: 101
      prefix: -show-log
  - id: show_schemes
    type:
      - 'null'
      - string
    doc: show the preset -scheme options
    inputBinding:
      position: 101
      prefix: --show-schemes
  - id: silent_mode
    type:
      - 'null'
      - string
    doc: mode silent
    inputBinding:
      position: 101
      prefix: -V
  - id: sort_mode
    type:
      - 'null'
      - string
    doc: order clustering by one of lex|size|revsize|none
    inputBinding:
      position: 101
      prefix: -sort
  - id: subcluster_file
    type:
      - 'null'
      - File
    doc: subcluster this clustering
    inputBinding:
      position: 101
      prefix: -icl
  - id: transform_matrix_values
    type:
      - 'null'
      - string
    doc: transform matrix values
    inputBinding:
      position: 101
      prefix: -tf
  - id: use_automatic_naming_and_input_dir
    type:
      - 'null'
      - string
    doc: use automatic naming and use input directory for output
    inputBinding:
      position: 101
      prefix: --d
  - id: use_tab_file
    type:
      - 'null'
      - File
    doc: expect native network format, write label output using dictionary
    inputBinding:
      position: 101
      prefix: -use-tab
  - id: use_three_digits_encode_inflation
    type:
      - 'null'
      - string
    doc: use three digits to encode inflation
    inputBinding:
      position: 101
      prefix: --i3
  - id: verbose_mode
    type:
      - 'null'
      - string
    doc: mode verbose
    inputBinding:
      position: 101
      prefix: -v
  - id: warn_pruning_entry_count_reduction
    type:
      - 'null'
      - int
    doc: warn if pruning reduces entry count by <int>
    inputBinding:
      position: 101
      prefix: -warn-factor
  - id: warn_pruning_mass_reduction_percentage
    type:
      - 'null'
      - string
    doc: warn if pruning reduces mass to <pct> weight
    inputBinding:
      position: 101
      prefix: -warn-pct
  - id: write_binary
    type:
      - 'null'
      - string
    doc: write binary output
    inputBinding:
      position: 101
      prefix: --write-binary
  - id: write_input_matrix
    type:
      - 'null'
      - File
    doc: write input matrix to file
    inputBinding:
      position: 101
      prefix: -write-graph
  - id: write_limit
    type:
      - 'null'
      - string
    doc: output the limit matrix
    inputBinding:
      position: 101
      prefix: --write-limit
  - id: write_transformed_matrix
    type:
      - 'null'
      - File
    doc: write transformed matrix to file
    inputBinding:
      position: 101
      prefix: -write-graphx
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to file <fname>
    outputBinding:
      glob: $(inputs.output_file)
  - id: write_expanded_graph_file
    type:
      - 'null'
      - File
    doc: file name to write expanded graph to
    outputBinding:
      glob: $(inputs.write_expanded_graph_file)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: use this directory for output
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
