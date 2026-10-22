cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - cut-tails
label: transcov_cut-tails
doc: "Remove the tails of the coverage distribution of a matrix\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_matrix
    type: File
    doc: "Input matrix (.npy)"
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: "Index file of the input matrix"
    inputBinding:
      position: 2
  - id: output_file
    type:
      - 'null'
      - string
    default: tail_cutted_matrix.npy
    doc: "Output file name"
    inputBinding:
      prefix: --output-file
  - id: cut
    type:
      - 'null'
      - float
    default: 0.05
    doc: "Fraction to remove from each selected tail (0 to 1)"
    inputBinding:
      prefix: --cut
  - id: mode
    type:
      - 'null'
      - string
    default: both
    doc: "Which tail to remove: both, left or right"
    inputBinding:
      prefix: --mode
outputs:
  - id: output_matrix
    type: File
    secondaryFiles:
      - pattern: '^.index'
        required: true
    doc: "Matrix (.npy) without the cut tails, with its index file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
