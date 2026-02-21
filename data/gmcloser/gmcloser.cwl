cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmcloser
label: gmcloser
doc: "The provided text does not contain help information or a description of the
  tool; it is a fatal error message indicating a failure to build a container due
  to lack of disk space.\n\nTool homepage: https://sourceforge.net/projects/gmcloser/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmcloser:1.6.2--0
stdout: gmcloser.out
