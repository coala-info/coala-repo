cwlVersion: v1.2
class: CommandLineTool
baseCommand: tesseract
label: tesseract
doc: "Performs OCR on an image and outputs the recognized text.\n\nTool homepage:
  https://github.com/tesseract-ocr/tesseract"
inputs:
  - id: imagename
    type: File
    doc: The input image file to perform OCR on.
    inputBinding:
      position: 1
  - id: outputbase
    type: string
    doc: The base name for the output file(s). Tesseract will append extensions 
      like .txt.
    inputBinding:
      position: 2
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional configuration files to customize OCR behavior.
    inputBinding:
      position: 3
  - id: languages
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify language(s) used for OCR. Can be a single language or multiple 
      languages separated by '+'.
    inputBinding:
      position: 104
      prefix: -l
  - id: list_langs
    type:
      - 'null'
      - boolean
    doc: List available languages for tesseract engine.
    inputBinding:
      position: 104
      prefix: --list-langs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tesseract:5.5.1
stdout: tesseract.out
