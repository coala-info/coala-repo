cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmip_watden
label: cmip_watden
doc: "A tool for water density calculation (Note: The provided help text contains
  system error messages regarding container execution and does not list command-line
  arguments).\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/gelpi/CMIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmip:2.7.0--h8c3ec31_0
stdout: cmip_watden.out
