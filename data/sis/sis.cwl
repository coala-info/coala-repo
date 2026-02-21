cwlVersion: v1.2
class: CommandLineTool
baseCommand: sis
label: sis
doc: "The provided text is a log of a container build failure and does not contain
  help documentation, usage instructions, or argument definitions for the tool 'sis'.\n
  \nTool homepage: http://marte.ic.unicamp.br:8747/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sis:0.1.2--py36pl5.22.0_1
stdout: sis.out
