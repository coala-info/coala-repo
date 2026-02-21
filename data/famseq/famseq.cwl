cwlVersion: v1.2
class: CommandLineTool
baseCommand: famseq
label: famseq
doc: "A tool for family-based variant calling and filtering (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  http://bioinformatics.mdanderson.org/main/FamSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famseq:1.0.3--h7d875b9_3
stdout: famseq.out
