cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview_mim
label: seaview_mim
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_mim.out
