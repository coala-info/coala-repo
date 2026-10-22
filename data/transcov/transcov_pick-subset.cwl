cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - pick-subset
label: transcov_pick-subset
doc: "Pick a row-wise subset of a matrix or tensor by row identifiers\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_sample
    type: File
    doc: "Input matrix or tensor (.npy)"
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: "Index file of the input sample"
    inputBinding:
      position: 2
  - id: ids_file
    type: File
    doc: "File with the row identifiers to keep, one per line (first column)"
    inputBinding:
      position: 3
  - id: output_file
    type:
      - 'null'
      - string
    default: subset_sample.npy
    doc: "Output file name"
    inputBinding:
      prefix: --output-file
outputs:
  - id: output_matrix
    type: File
    secondaryFiles:
      - pattern: '^.index'
        required: true
    doc: "Subset matrix (.npy) with its index file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
