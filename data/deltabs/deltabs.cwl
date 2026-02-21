cwlVersion: v1.2
class: CommandLineTool
baseCommand: deltabs
label: deltabs
doc: "The provided text does not contain help information for the tool 'deltabs'.
  It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to lack of disk space.\n
  \nTool homepage: https://github.com/Gardner-BinfLab/deltaBS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltabs:0.1--1
stdout: deltabs.out
