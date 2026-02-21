cwlVersion: v1.2
class: CommandLineTool
baseCommand: helperlibs
label: helperlibs
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages and a fatal error related to container
  image conversion and disk space.\n\nTool homepage: https://github.com/kblin/bioinf-helperlibs/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/helperlibs:0.2.1--py_0
stdout: helperlibs.out
