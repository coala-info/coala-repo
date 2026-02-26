cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl window
label: gretl_window
doc: "Sliding window analysis (path-centric)\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: metric
    type:
      - 'null'
      - string
    doc: "Which metric do you wanna have reported? Example: 'similarity', 'nodesize',
      'depth'"
    default: similarity
    inputBinding:
      position: 101
      prefix: --metric
  - id: node
    type:
      - 'null'
      - boolean
    doc: 'Window on node level ([default: off] -> on sequence)'
    inputBinding:
      position: 101
      prefix: --node
  - id: pansn
    type:
      - 'null'
      - string
    doc: Separate by first entry in Pan-SN spec
    default: \n
    inputBinding:
      position: 101
      prefix: --pansn
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size
    default: 100000
    inputBinding:
      position: 101
      prefix: --step-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of a single window
    default: 100000
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output
    type: File
    doc: Output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
