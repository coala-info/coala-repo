cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview_python
label: seaview_python
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_python.out
