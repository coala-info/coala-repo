cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_pip3
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain help documentation or command-line argument
  definitions for the tool.\n\nTool homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_pip3.out
