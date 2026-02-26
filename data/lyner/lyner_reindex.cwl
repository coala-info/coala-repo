cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - reindex
label: lyner_reindex
doc: "Reindex the matrix.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Input matrix file
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_matrix
    type:
      - 'null'
      - File
    doc: Output matrix file
    outputBinding:
      glob: $(inputs.output_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
