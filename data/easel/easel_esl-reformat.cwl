cwlVersion: v1.2
class: CommandLineTool
baseCommand: esl-reformat
label: easel_esl-reformat
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to insufficient disk space.\n\nTool homepage: https://github.com/EddyRivasLab/easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel_esl-reformat.out
