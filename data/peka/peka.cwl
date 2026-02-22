cwlVersion: v1.2
class: CommandLineTool
baseCommand: peka
label: peka
doc: "Position-dependent k-mer analysis (Note: The provided text contains system error
  messages regarding disk space and container extraction rather than tool help text;
  no arguments could be extracted from the input).\n\nTool homepage: https://github.com/ulelab/peka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peka:1.0.2--pyhdfd78af_0
stdout: peka.out
