cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi-conda
label: kipoi-conda
doc: "A tool for managing Conda environments for Kipoi models. (Note: The provided
  input text contains system logs and error messages rather than command-line help
  documentation, so no arguments could be extracted.)\n\nTool homepage: https://github.com/kipoi/kipoi-conda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi-conda:0.1.6--py_0
stdout: kipoi-conda.out
