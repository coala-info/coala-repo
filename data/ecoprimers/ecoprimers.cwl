cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecoprimers
label: ecoprimers
doc: "ecoPrimers is a tool for finding PCR primers. (Note: The provided help text
  contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/dentolos19/ecoprimers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ecoprimers:1.0--h577a1d6_8
stdout: ecoprimers.out
