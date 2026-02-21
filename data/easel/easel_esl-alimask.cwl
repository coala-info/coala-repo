cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - esl-alimask
label: easel_esl-alimask
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to pull or build the container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/EddyRivasLab/easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel_esl-alimask.out
