cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compute
  - support
  - tbe
label: gotree_compute_support_tbe
doc: "Compute BOOtstrap Support by TransfER.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: dist_cutoff
    type:
      - 'null'
      - float
    doc: "If --moved-taxa, then this is the distance cutoff to consider a branch for moving taxa computation. It is the normalized distance to the current bootstrap tree (e.g. 0.05). Must be between 0 and 1, otherwise set to 0"
    inputBinding:
      position: 101
      prefix: --dist-cutoff
  - id: moved_taxa
    type:
      - 'null'
      - boolean
    doc: "If true, will print in log file (-l) taxa that move the most around branches"
    inputBinding:
      position: 101
      prefix: --moved-taxa
  - id: out_raw_path
    type:
      - 'null'
      - string
    doc: "If given, then prints the same tree with non normalized supports (average transfer distance) as branch names, in the form branch_id|avg_distance|branch_depth"
    inputBinding:
      position: 101
      prefix: --out-raw
  - id: per_branches
    type:
      - 'null'
      - boolean
    doc: "If true, will print in log file (-l) average taxa transfers for all taxa per banches of the reference tree"
    inputBinding:
      position: 101
      prefix: --per-branches
  - id: bootstrap_trees
    type:
      - 'null'
      - File
    doc: "Bootstrap trees input file"
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "Output log file"
    inputBinding:
      position: 101
      prefix: --log-file
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: "Output tree file, with supports"
    inputBinding:
      position: 101
      prefix: --out
  - id: reference_tree
    type:
      - 'null'
      - File
    doc: "Reference tree input file"
    inputBinding:
      position: 101
      prefix: --reftree
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "If true, progress messages will not be printed to stderr"
    inputBinding:
      position: 101
      prefix: --silent
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_raw_file
    type:
      - 'null'
      - File
    doc: "If given, then prints the same tree with non normalized supports (average transfer distance) as branch names, in the form branch_id|avg_distance|branch_depth"
    outputBinding:
      glob: "$(inputs.out_raw_path)"
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Output log file"
    outputBinding:
      glob: "$(inputs.log_file_path)"
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Output tree file, with supports"
    outputBinding:
      glob: "$(inputs.out_file_path)"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_compute_support_tbe.out
