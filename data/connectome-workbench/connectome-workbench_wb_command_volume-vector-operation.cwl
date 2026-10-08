cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-vector-operation
label: connectome-workbench_wb_command_volume-vector-operation
doc: "Does a vector operation on two volume files (that must have a multiple of 3 subvolumes). Either of the inputs may have multiple vectors (more than 3 subvolumes), but not both (at least one must have exactly 3 subvolumes). The -magnitude and -normalize-output options may not be specified together, or with the DOT operation.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: vectors_a
    type: File
    doc: "first vector input file"
    inputBinding:
      position: 1
  - id: vectors_b
    type: File
    doc: "second vector input file"
    inputBinding:
      position: 2
  - id: operation
    type: string
    doc: "what vector operation to do: DOT, CROSS, ADD or SUBTRACT"
    inputBinding:
      position: 3
  - id: volume_out
    type: string
    doc: "output - the output file"
    inputBinding:
      position: 4
  - id: normalize_a
    type:
      - 'null'
      - boolean
    doc: "normalize vectors of first input"
    inputBinding:
      position: 5
      prefix: -normalize-a
  - id: normalize_b
    type:
      - 'null'
      - boolean
    doc: "normalize vectors of second input"
    inputBinding:
      position: 6
      prefix: -normalize-b
  - id: normalize_output
    type:
      - 'null'
      - boolean
    doc: "normalize output vectors (not valid for dot product)"
    inputBinding:
      position: 7
      prefix: -normalize-output
  - id: magnitude
    type:
      - 'null'
      - boolean
    doc: "output the magnitude of the result (not valid for dot product)"
    inputBinding:
      position: 8
      prefix: -magnitude
outputs:
  - id: output_volume
    type: File
    doc: "the output file"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
