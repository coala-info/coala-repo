cwlVersion: v1.2
class: CommandLineTool
baseCommand: telseq
label: telseq
doc: "Telseq is a tool for estimating telomere length from whole genome sequencing
  data.\n\nTool homepage: https://github.com/zd1/telseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telseq:0.0.2--h06902ac_8
stdout: telseq.out
