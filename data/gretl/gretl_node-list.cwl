cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl_node-list
label: gretl_node-list
doc: "Statistics for each node\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: feature
    type:
      - 'null'
      - type: array
        items: string
    doc: "Name the features you need. If nothing is used, report everything.\n   \
      \                             Example -f 'Length,Core'"
    inputBinding:
      position: 101
      prefix: --feature
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: pansn
    type:
      - 'null'
      - string
    doc: Separate by first entry in Pan-SN spec
    inputBinding:
      position: 101
      prefix: --pansn
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
