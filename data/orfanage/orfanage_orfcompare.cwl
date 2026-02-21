cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - orfanage
  - orfcompare
label: orfanage_orfcompare
doc: "The provided text contains system error messages and does not include help documentation
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/alevar/ORFanage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfanage:1.2.0--ha666654_1
stdout: orfanage_orfcompare.out
