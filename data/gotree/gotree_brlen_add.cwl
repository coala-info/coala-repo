cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - brlen
  - add
label: gotree_brlen_add
doc: "Add the given length to all branches of the tree.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: add_length
    type:
      - 'null'
      - float
    doc: "Length to add to all branches"
    inputBinding:
      position: 101
      prefix: --add-length
  - id: output_file_path
    type: string
    doc: "Output tree file"
    inputBinding:
      position: 101
      prefix: --output
  - id: no_external
    type:
      - 'null'
      - boolean
    doc: "Do not apply to external branches or nodes (passes --external=false). Original option: Applies to external branches"
    inputBinding:
      position: 101
      prefix: --external=false
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type: File
    doc: "Input tree"
    inputBinding:
      position: 101
      prefix: --input
  - id: no_internal
    type:
      - 'null'
      - boolean
    doc: "Do not apply to internal branches or nodes (passes --internal=false). Original option: Applies to internal branches"
    inputBinding:
      position: 101
      prefix: --internal=false
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
