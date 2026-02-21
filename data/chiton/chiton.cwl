cwlVersion: v1.2
class: CommandLineTool
baseCommand: chiton
label: chiton
doc: "The provided text is a system log/error message regarding a container build
  failure and does not contain help information or argument definitions for the tool
  'chiton'.\n\nTool homepage: https://github.com/aaronmussig/chiton"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chiton:1.1.0--pyhdfd78af_0
stdout: chiton.out
