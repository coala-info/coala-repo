cwlVersion: v1.2
class: CommandLineTool
baseCommand: phytop
label: phytop
doc: "Phytop is a tool for phylogenetic analysis (Note: The provided text contains
  system error logs rather than help documentation, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/zhangrengang/phytop/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phytop:0.3--pyhdc42f0e_0
stdout: phytop.out
