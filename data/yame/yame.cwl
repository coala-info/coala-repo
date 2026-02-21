cwlVersion: v1.2
class: CommandLineTool
baseCommand: yame
label: yame
doc: "YAME (Yet Another Metagenomics Encoder) - A tool for processing metagenomics
  data.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.0.5--h96c455f_0
stdout: yame.out
