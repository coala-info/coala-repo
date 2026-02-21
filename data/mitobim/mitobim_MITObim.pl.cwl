cwlVersion: v1.2
class: CommandLineTool
baseCommand: MITObim.pl
label: mitobim_MITObim.pl
doc: "MITObim (Mitochondrial Iterative Assembler) is a tool for mitochondrial genome
  assembly.\n\nTool homepage: https://github.com/chrishah/MITObim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
stdout: mitobim_MITObim.pl.out
