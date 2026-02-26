cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - reformat
label: gotree_reformat
doc: "Reformats an input tree file into different formats.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain), alias to 
      --format
    default: newick
    inputBinding:
      position: 101
      prefix: --input-format
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
