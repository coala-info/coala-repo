cwlVersion: v1.2
class: CommandLineTool
baseCommand: poly-qtlseq
label: poly-qtlseq
doc: "QTL-seq analysis for polyploid species. (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
stdout: poly-qtlseq.out
