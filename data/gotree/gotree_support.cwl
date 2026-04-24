cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - support
label: gotree_support
doc: "Modify supports of branches from input trees\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    inputBinding:
      position: 101
      prefix: --input
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Cleared tree output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
