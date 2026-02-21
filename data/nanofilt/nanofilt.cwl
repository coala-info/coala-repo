cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanofilt
label: nanofilt
doc: "The provided text is an error log from a container runtime and does not contain
  help information or argument definitions for the tool 'nanofilt'.\n\nTool homepage:
  https://github.com/wdecoster/nanofilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanofilt:2.8.0--py_0
stdout: nanofilt.out
