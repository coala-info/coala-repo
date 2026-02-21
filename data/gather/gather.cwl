cwlVersion: v1.2
class: CommandLineTool
baseCommand: gather
label: gather
doc: "The provided text does not contain help information or usage instructions for
  the tool 'gather'. It consists of error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/Neuroimmunology-UiO/gather"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gather:1.0.1--pyh7e72e81_1
stdout: gather.out
