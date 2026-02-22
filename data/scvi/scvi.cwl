cwlVersion: v1.2
class: CommandLineTool
baseCommand: scvi
label: scvi
doc: "The provided text contains system error logs related to a container execution
  failure (no space left on device) and does not contain the actual help text or usage
  information for the scvi tool. As a result, no arguments could be extracted.\n\n\
  Tool homepage: https://github.com/YosefLab/scVI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvi:0.6.8--py_0
stdout: scvi.out
