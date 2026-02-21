cwlVersion: v1.2
class: CommandLineTool
baseCommand: esl-mask
label: easel_esl-mask
doc: "The provided text contains a system error message (out of disk space during
  container image extraction) rather than the tool's help documentation. Based on
  the tool name hint 'easel_esl-mask', this tool is part of the Easel sequence analysis
  library and is used to mask specific regions of sequence files.\n\nTool homepage:
  https://github.com/EddyRivasLab/easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel_esl-mask.out
