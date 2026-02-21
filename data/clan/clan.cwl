cwlVersion: v1.2
class: CommandLineTool
baseCommand: clan
label: clan
doc: "CLAN (CLustering ANalysis) is a tool for the clustering of protein sequences
  based on their similarity.\n\nTool homepage: https://sourceforge.net/projects/clan-mapping/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clan:0.05--hc9558a2_0
stdout: clan.out
