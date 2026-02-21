cwlVersion: v1.2
class: CommandLineTool
baseCommand: figaro
label: figaro
doc: "Figaro is a tool for identifying the optimal trimming positions for 16S rRNA
  gene sequencing data. (Note: The provided help text contains only system error messages
  and no usage information.)\n\nTool homepage: https://github.com/Zymo-Research/figaro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/figaro:1.1.2--hdfd78af_0
stdout: figaro.out
