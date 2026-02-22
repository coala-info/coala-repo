cwlVersion: v1.2
class: CommandLineTool
baseCommand: paragone
label: paragone
doc: "Paragone is a tool for identifying and characterizing paralogous genes. (Note:
  The provided text contains system error messages regarding disk space and container
  conversion rather than tool help text; therefore, no arguments could be extracted.)\n\
  \nTool homepage: https://github.com/chrisjackson-pellicle/ParaGone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragone:1.1.3--pyhdfd78af_2
stdout: paragone.out
