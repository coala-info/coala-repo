cwlVersion: v1.2
class: CommandLineTool
baseCommand: esl-alimanip
label: easel_esl-alimanip
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a failure to build a SIF image due to
  lack of disk space.\n\nTool homepage: https://github.com/EddyRivasLab/easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel_esl-alimanip.out
