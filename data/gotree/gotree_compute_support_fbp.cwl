cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compute
  - support
  - fbp
label: gotree_compute_support_fbp
doc: "Compute classical FBP Support.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
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
stdout: gotree_compute_support_fbp.out
