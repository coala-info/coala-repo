cwlVersion: v1.2
class: CommandLineTool
baseCommand: esl-seqstat
label: easel_esl-seqstat
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container environment failure (no space left on device).\n
  \nTool homepage: https://github.com/EddyRivasLab/easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel_esl-seqstat.out
