cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - ltt
label: gotree_ltt
doc: "Compute Lineage Through Time data.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
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
  - id: image
    type:
      - 'null'
      - File
    doc: LTT plot image image output file
    default: none
    inputBinding:
      position: 101
      prefix: --image
  - id: image_height
    type:
      - 'null'
      - int
    doc: LTT plot image output heigh
    default: 4
    inputBinding:
      position: 101
      prefix: --image-height
  - id: image_width
    type:
      - 'null'
      - int
    doc: LTT plot image image output width
    default: 4
    inputBinding:
      position: 101
      prefix: --image-width
  - id: input
    type:
      - 'null'
      - File
    doc: Input tree(s) file
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
  - id: output
    type:
      - 'null'
      - File
    doc: LTT output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
