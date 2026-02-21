cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-count-barcodes
label: htseq_htseq-count-barcodes
doc: "A tool from the HTSeq package for counting barcodes. (Note: The provided input
  text contains system error messages regarding container image conversion and disk
  space, rather than the tool's help documentation. Consequently, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/htseq/htseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq:2.0.9--py311h8fb3dee_0
stdout: htseq_htseq-count-barcodes.out
