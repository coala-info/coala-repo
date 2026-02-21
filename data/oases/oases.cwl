cwlVersion: v1.2
class: CommandLineTool
baseCommand: oases
label: oases
doc: "Oases is a de novo transcriptome assembler for very short reads. (Note: The
  provided help text contains only system error messages regarding a container execution
  failure and does not list command-line arguments.)\n\nTool homepage: https://github.com/coin-or/qpOASES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oases:0.2.09--h7b50bb2_2
stdout: oases.out
