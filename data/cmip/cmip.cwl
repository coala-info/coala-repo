cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmip
label: cmip
doc: "Classical Molecular Interaction Potentials\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/gelpi/CMIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmip:2.7.0--h8c3ec31_0
stdout: cmip.out
