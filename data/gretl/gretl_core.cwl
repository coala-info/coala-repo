cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl_core
label: gretl_core
doc: "General graph similarity statistics\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
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
  - id: statistics
    type:
      - 'null'
      - string
    doc: similarity, depth, node degree
    inputBinding:
      position: 101
      prefix: --stats
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
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
