cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_conda
doc: "SeaView is a multiplatform, graphical user interface for multiple sequence alignment
  and molecular phylogeny. (Note: The provided text appears to be a container build
  error log rather than help text, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_conda.out
