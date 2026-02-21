cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmip_watden90
label: cmip_watden90
doc: "A tool from the CMIP (Classical Molecular Interaction Potentials) suite. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/gelpi/CMIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmip:2.7.0--h8c3ec31_0
stdout: cmip_watden90.out
