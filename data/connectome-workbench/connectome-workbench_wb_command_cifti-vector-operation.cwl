cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-vector-operation'
label: connectome-workbench_wb_command_cifti-vector-operation
doc: "Do a vector operation on two cifti files (that must have a multiple of 3 columns). Either input may have multiple vectors, but at least one must have exactly 3 columns. The operation must be one of DOT, CROSS, ADD, SUBTRACT.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: vectors_a
    type: File
    doc: first vector input file
    inputBinding:
      position: 1
  - id: vectors_b
    type: File
    doc: second vector input file
    inputBinding:
      position: 2
  - id: operation
    type: string
    doc: 'what vector operation to do: DOT, CROSS, ADD or SUBTRACT'
    inputBinding:
      position: 3
  - id: cifti_out
    type: string
    doc: output - the output file
    inputBinding:
      position: 4
  - id: normalize_a
    type:
      - 'null'
      - boolean
    doc: normalize vectors of first input
    inputBinding:
      position: 5
      prefix: '-normalize-a'
  - id: normalize_b
    type:
      - 'null'
      - boolean
    doc: normalize vectors of second input
    inputBinding:
      position: 5
      prefix: '-normalize-b'
  - id: normalize_output
    type:
      - 'null'
      - boolean
    doc: normalize output vectors (not valid for dot product)
    inputBinding:
      position: 5
      prefix: '-normalize-output'
  - id: magnitude
    type:
      - 'null'
      - boolean
    doc: output the magnitude of the result (not valid for dot product)
    inputBinding:
      position: 5
      prefix: '-magnitude'
outputs:
  - id: vector_cifti
    type: File
    doc: the output file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
