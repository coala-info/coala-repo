cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - plot-coverage-dist
label: transcov_plot-coverage-dist
doc: "Plot coverage distribution from a coverage matrix.\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_matrix
    type: File
    doc: Input coverage matrix file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov_plot-coverage-dist.out
