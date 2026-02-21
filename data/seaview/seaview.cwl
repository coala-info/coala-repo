cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview
doc: "SeaView is a multiplatform, graphical user interface for multiple sequence alignment
  and molecular phylogeny. (Note: The provided text is an error log and does not contain
  usage information or arguments).\n\nTool homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview.out
