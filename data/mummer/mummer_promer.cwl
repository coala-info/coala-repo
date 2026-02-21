cwlVersion: v1.2
class: CommandLineTool
baseCommand: promer
label: mummer_promer
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Apptainer/Singularity)
  failing to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321h503566f_21
stdout: mummer_promer.out
