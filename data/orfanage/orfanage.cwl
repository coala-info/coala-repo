cwlVersion: v1.2
class: CommandLineTool
baseCommand: orfanage
label: orfanage
doc: "ORFanage: Open Reading Frame annotation refinement and gene expansion (Note:
  The provided help text contains only system error messages and no argument definitions).\n
  \nTool homepage: https://github.com/alevar/ORFanage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfanage:1.2.0--ha666654_1
stdout: orfanage.out
