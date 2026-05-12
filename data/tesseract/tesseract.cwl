cwlVersion: v1.2
class: CommandLineTool
baseCommand: ""
label: tesseract
doc: Tesseract Open Source OCR Engine
inputs:
  - id: imagename
    type: File
    doc: Input image file
    inputBinding:
      position: 1
  - id: outputbase
    type: string
    doc: Base name for output file (the appropriate extension will be appended)
    inputBinding:
      position: 2
  - id: configfile
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional configuration files
    inputBinding:
      position: 3
  - id: lang
    type:
      - 'null'
      - string
    doc: Specify language(s) used for OCR.
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
  - id: out_outputbase
    type:
      type: array
      items: File
    doc: Base name for output file (the appropriate extension will be appended)
    outputBinding:
      glob: $(inputs.outputbase + ".*")
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: jitesoft/tesseract-ocr:5-5.5.2
s:url: https://github.com/tesseract-ocr/tesseract
$namespaces:
  s: https://schema.org/
