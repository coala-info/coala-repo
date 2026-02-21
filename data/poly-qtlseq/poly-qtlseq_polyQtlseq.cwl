cwlVersion: v1.2
class: CommandLineTool
baseCommand: polyQtlseq
label: poly-qtlseq_polyQtlseq
doc: "QTL-seq analysis for polyploid species. Note: The provided help text contains
  only container execution logs and error messages, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
stdout: poly-qtlseq_polyQtlseq.out
