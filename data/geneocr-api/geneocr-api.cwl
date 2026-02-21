cwlVersion: v1.2
class: CommandLineTool
baseCommand: geneocr-api
label: geneocr-api
doc: "Gene OCR API (Note: The provided text contains system error logs rather than
  tool help documentation, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/bedapub/geneocr-api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/geneocr-api:1.0_cv1
stdout: geneocr-api.out
