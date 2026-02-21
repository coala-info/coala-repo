cwlVersion: v1.2
class: CommandLineTool
baseCommand: oatk_rotate
label: oatk_rotate
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/c-zhou/oatk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0
stdout: oatk_rotate.out
