cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmvc
label: mmvc
doc: "The provided text does not contain help information for the tool 'mmvc'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the tool's image due to lack of disk space.\n\nTool homepage: https://github.com/veg/mmvc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmvc:1.0.2--1
stdout: mmvc.out
