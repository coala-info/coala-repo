cwlVersion: v1.2
class: CommandLineTool
baseCommand: longphase
label: longphase
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/twolinin/longphase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longphase:2.0--h13024bc_0
stdout: longphase.out
