cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - plot-coverage-dist
label: transcov_plot-coverage-dist
doc: "Plot the coverage distribution of a matrix\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_matrix
    type: File
    doc: "Input matrix (.npy)"
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - string
    default: coverage_distribution.png
    doc: "Output plot file name"
    inputBinding:
      prefix: --output-file
outputs:
  - id: plot
    type: File
    doc: "Plot image (PNG)"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
