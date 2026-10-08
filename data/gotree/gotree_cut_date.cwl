cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - cut
  - date
label: gotree_cut_date
doc: "Cut the input tree by keeping only parts in date window.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_tree
    type: File
    doc: "Input tree(s) file"
    inputBinding:
      position: 101
      prefix: --input
  - id: max_date
    type:
      - 'null'
      - float
    doc: "Maximum date to cut the tree (0=no max date)"
    inputBinding:
      position: 101
      prefix: --max-date
  - id: min_date
    type:
      - 'null'
      - float
    doc: "Minimum date to cut the tree"
    inputBinding:
      position: 101
      prefix: --min-date
  - id: output_file_path
    type: string
    doc: "Forest output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
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
