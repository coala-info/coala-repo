cwlVersion: v1.2
class: CommandLineTool
baseCommand: matOptimize
label: usher_matOptimize
doc: 'matOptimize (v0.6.6): optimizes a mutation-annotated tree (MAT) by parsimony-improving
  subtree-prune-and-regraft moves.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: vcf
  type:
  - 'null'
  - File
  doc: Input VCF file (in uncompressed or gzip-compressed .gz format)
  inputBinding:
    position: 101
    prefix: --vcf
- id: tree
  type:
  - 'null'
  - File
  doc: Input tree file
  inputBinding:
    position: 101
    prefix: --tree
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
- id: load_mutation_annotated_tree
  type:
  - 'null'
  - File
  doc: Load mutation-annotated tree object
  inputBinding:
    position: 101
    prefix: --load-mutation-annotated-tree
- id: save_mutation_annotated_tree
  type: string
  doc: Save output mutation-annotated tree object to the specified filename [REQUIRED]
  inputBinding:
    position: 101
    prefix: --save-mutation-annotated-tree
- id: epps_on_branch_len
  type:
  - 'null'
  - string
  doc: Output a newick with number of equally parsimonious placements on the branch
    length field
  inputBinding:
    position: 101
    prefix: --epps_on_branch_len
- id: radius
  type:
  - 'null'
  - int
  doc: 'Radius in which to restrict the SPR moves. [default: -1]'
  inputBinding:
    position: 101
    prefix: --radius
- id: profitable_src_log
  type:
  - 'null'
  - string
  doc: 'The file to log from which node a profitable move can be found. [default:
    /dev/null]'
  inputBinding:
    position: 101
    prefix: --profitable-src-log
- id: ambi_protobuf
  type:
  - 'null'
  - File
  doc: Continue from intermediate protobuf
  inputBinding:
    position: 101
    prefix: --ambi-protobuf
- id: minutes_between_save
  type:
  - 'null'
  - int
  doc: 'Minutes between saving intermediate protobuf [default: 0]'
  inputBinding:
    position: 101
    prefix: --minutes-between-save
- id: min_improvement
  type:
  - 'null'
  - float
  doc: 'Minimum improvement in the parsimony score as a fraction of the previous score
    in ordder to perform another iteration. [default: 0.000500000024]'
  inputBinding:
    position: 101
    prefix: --min-improvement
- id: drift_iteration
  type:
  - 'null'
  - int
  doc: 'Iterations permiting equally parsimonious moves after parsimony score no longer
    improves [default: 0]'
  inputBinding:
    position: 101
    prefix: --drift_iteration
- id: do_not_write_intermediate_files
  type:
  - 'null'
  - boolean
  doc: Do not write intermediate files.
  inputBinding:
    position: 101
    prefix: --do-not-write-intermediate-files
- id: max_iterations
  type:
  - 'null'
  - int
  doc: 'Maximum number of optimization iterations to perform. [default: 1000]'
  inputBinding:
    position: 101
    prefix: --max-iterations
- id: max_hours
  type:
  - 'null'
  - float
  doc: 'Maximium number of hours to run [default: 0]'
  inputBinding:
    position: 101
    prefix: --max-hours
- id: transposed_vcf_path
  type:
  - 'null'
  - File
  doc: Auxiliary transposed VCF for ambiguous bases, used in combination with usher
    protobuf (-i)
  inputBinding:
    position: 101
    prefix: --transposed-vcf-path
- id: diff_file_path
  type:
  - 'null'
  - File
  doc: Diff file from MAPLE, used with newick tree (-t)
  inputBinding:
    position: 101
    prefix: --diff_file_path
- id: reference
  type:
  - 'null'
  - File
  doc: Reference file, use with diff file (-D)
  inputBinding:
    position: 101
    prefix: --reference
- id: node_proportion
  type:
  - 'null'
  - float
  doc: 'the proportion of nodes to search [default: 2]'
  inputBinding:
    position: 101
    prefix: --node_proportion
- id: node_sel
  type:
  - 'null'
  - int
  doc: Random seed for selecting nodes to search
  inputBinding:
    position: 101
    prefix: --node_sel
- id: drift_nwk_file
  type:
  - 'null'
  - string
  doc: Newick filename stem for drifting
  inputBinding:
    position: 101
    prefix: --drift_nwk_file
- id: black_list_node_file
  type:
  - 'null'
  - File
  doc: Nodes that won't be moved
  inputBinding:
    position: 101
    prefix: --black_list_node_file
- id: no_reduce_back_mutations
  type:
  - 'null'
  - boolean
  doc: skip FS that reduce back mutations in the end
  inputBinding:
    position: 101
    prefix: --no_reduce_back_mutations
outputs:
- id: save_mutation_annotated_tree_file
  type: File
  doc: Output file named by --save-mutation-annotated-tree. Save output mutation-annotated
    tree object to the specified filename [REQUIRED]
  outputBinding:
    glob: $(inputs.save_mutation_annotated_tree)
- id: epps_on_branch_len_file
  type:
  - 'null'
  - File
  doc: Output file named by --epps_on_branch_len. Output a newick with number of equally
    parsimonious placements on the branch length field
  outputBinding:
    glob: '${ return inputs.epps_on_branch_len ? inputs.epps_on_branch_len : []; }'
- id: profitable_src_log_file
  type:
  - 'null'
  - File
  doc: Output file named by --profitable-src-log. The file to log from which node
    a profitable move can be found.
  outputBinding:
    glob: '${ return inputs.profitable_src_log ? inputs.profitable_src_log : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matOptimize_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
