cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - collapse
label: transcov_collapse
doc: "Collapse (sum) several matrices or tensors of the same shape into one\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: matrices
    type:
      - 'null'
      - File[]
    secondaryFiles:
      - pattern: '^.index'
        required: true
    doc: "Matrices or tensors (.npy), each with its .index file"
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - string
    default: collapsed_sample.npy
    doc: "Output file name"
    inputBinding:
      prefix: --output-file
  - id: uint32
    type:
      - 'null'
      - boolean
    doc: "Change the data type to uint32"
    inputBinding:
      prefix: --uint32
outputs:
  - id: output_matrix
    type: File
    secondaryFiles:
      - pattern: '^.index'
        required: true
    doc: "Collapsed matrix (.npy) with its index file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
