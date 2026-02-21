cwlVersion: v1.2
class: CommandLineTool
baseCommand: tesseract
label: tesseract
doc: "Tesseract Open Source OCR Engine\n\nTool homepage: https://github.com/tesseract-ocr/tesseract"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tesseract:5.5.1
stdout: tesseract.out
