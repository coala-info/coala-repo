cwlVersion: v1.2
class: CommandLineTool
baseCommand: collect-columns
label: collect-columns
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not contain the help documentation for
  the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/biowdl/collect-columns"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/collect-columns:1.0.0--py_0
stdout: collect-columns.out
