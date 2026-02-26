cwlVersion: v1.2
class: CommandLineTool
baseCommand: PretextGraph
label: pretextgraph_PretextGraph
doc: "PretextMap Version 0.0.9\n\nTool homepage: https://github.com/wtsi-hpag/PretextGraph"
inputs:
  - id: debug_bedgraph
    type:
      - 'null'
      - File
    doc: debug bedgraph file
    inputBinding:
      position: 101
      prefix: -f
  - id: graph_name
    type: string
    doc: graph name
    inputBinding:
      position: 101
      prefix: -n
  - id: input_pretext
    type: File
    doc: input.pretext
    inputBinding:
      position: 101
      prefix: -i
  - id: noise_filter
    type:
      - 'null'
      - boolean
    doc: '0: disable NOISE FILTER, 1: enable NOISE FILTER'
    default: 1
    inputBinding:
      position: 101
      prefix: -nf
outputs:
  - id: output_pretext
    type:
      - 'null'
      - File
    doc: output.pretext
    outputBinding:
      glob: $(inputs.output_pretext)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextgraph:0.0.9--h9948957_1
