cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview_pip
label: seaview_pip
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages indicating a failure to build a Singularity/Apptainer
  container image due to insufficient disk space.\n\nTool homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_pip.out
