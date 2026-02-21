cwlVersion: v1.2
class: CommandLineTool
baseCommand: qtlseq
label: qtlseq
doc: "The provided text does not contain a description of the tool as it is a container
  execution error log. QTL-seq is typically used for quantitative trait locus analysis
  using bulked segregant analysis (BSA) data.\n\nTool homepage: https://github.com/YuSugihara/QTL-seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qtlseq:2.2.9--pyhdfd78af_0
stdout: qtlseq.out
