cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitobim
label: mitobim
doc: "MITObim (Mitochondrial Iterative Assembler) is a tool for mitochondrial genome
  assembly. Note: The provided help text contains only system error messages and no
  usage information.\n\nTool homepage: https://github.com/chrishah/MITObim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
stdout: mitobim.out
