cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl nwindow
label: gretl_nwindow
doc: "Extending from a single node\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: jumps
    type:
      - 'null'
      - boolean
    doc: Sum of 'id jumps' away from the starting node
    inputBinding:
      position: 101
      prefix: --jumps
  - id: sequence
    type:
      - 'null'
      - string
    doc: Amount of sequence away from the starting node
    inputBinding:
      position: 101
      prefix: --sequence
  - id: step
    type:
      - 'null'
      - int
    doc: Number of steps away from the starting node
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
