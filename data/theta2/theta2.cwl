cwlVersion: v1.2
class: CommandLineTool
baseCommand: theta2
label: theta2
doc: "The provided text does not contain help information for the tool 'theta2'. It
  contains error logs related to a container build failure (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/raphael-group/THetA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/theta2:0.7--py27_0
stdout: theta2.out
