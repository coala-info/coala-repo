cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtea
label: xtea_xtea_hg19
doc: "xTEA (Transposable Element Analyzer) is a tool for identifying Transposable
  Element insertions from DNA sequencing data. Note: The provided input text contains
  system error logs rather than tool help documentation.\n\nTool homepage: https://github.com/parklab/xTea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtea:0.1.9--hdfd78af_0
stdout: xtea_xtea_hg19.out
