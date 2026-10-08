cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - merge
label: gotree_merge
doc: "Merges two rooted trees by adding a new root connecting two former roots.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: compared_tree
    type: File
    doc: "Compared tree input file"
    inputBinding:
      position: 101
      prefix: --compared
  - id: output_file_path
    type: string
    doc: "Merged tree output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: reference_tree
    type: File
    doc: "Reference tree input file"
    inputBinding:
      position: 101
      prefix: --reftree
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
