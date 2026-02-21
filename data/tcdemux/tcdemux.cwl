cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcdemux
label: tcdemux
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for the tool 'tcdemux'.\n\nTool homepage: https://github.com/TomHarrop/tcdemux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tcdemux:0.1.1--pyhdfd78af_0
stdout: tcdemux.out
