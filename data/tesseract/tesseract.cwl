cwlVersion: v1.2
class: CommandLineTool
baseCommand: tesseract
label: tesseract
doc: "Tesseract Open Source OCR Engine: recognise text in an image and write it as
  plain text, hOCR, TSV, PDF and other formats.\n\nTool homepage: https://github.com/tesseract-ocr/tesseract"
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
  - id: tessdata_dir
    type:
      - 'null'
      - string
    doc: Specify the location of tessdata path.
    inputBinding:
      position: 3
      prefix: --tessdata-dir
  - id: user_words
    type:
      - 'null'
      - File
    doc: Specify the location of user words file.
    inputBinding:
      position: 3
      prefix: --user-words
  - id: user_patterns
    type:
      - 'null'
      - File
    doc: Specify the location of user patterns file.
    inputBinding:
      position: 3
      prefix: --user-patterns
  - id: dpi
    type:
      - 'null'
      - int
    doc: Specify DPI for input image.
    inputBinding:
      position: 3
      prefix: --dpi
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Specify logging level. LEVEL can be ALL, TRACE, DEBUG, INFO, WARN, ERROR,
      FATAL or OFF.
    inputBinding:
      position: 3
      prefix: --loglevel
  - id: lang
    type:
      - 'null'
      - string
    doc: Specify language(s) used for OCR, LANG[+LANG].
    inputBinding:
      position: 3
      prefix: -l
  - id: config_variables
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -c
    doc: Set value for config variables, VAR=VALUE. Multiple -c arguments are
      allowed.
    inputBinding:
      position: 3
  - id: psm
    type:
      - 'null'
      - string
    doc: Specify page segmentation mode, PSM name or number (0 to 13).
    inputBinding:
      position: 3
      prefix: --psm
  - id: oem
    type:
      - 'null'
      - string
    doc: Specify OCR engine mode, OEM name or number (0 to 3).
    inputBinding:
      position: 3
      prefix: --oem
  - id: configfile
    type:
      - 'null'
      - type: array
        items: string
    doc: Config files or output format names (for example txt, pdf, hocr, tsv,
      alto); must come after the options.
    inputBinding:
      position: 4
outputs:
  - id: out_outputbase
    type:
      type: array
      items: File
    doc: Output files; the extension depends on the config files used (default .txt)
    outputBinding:
      glob: $(inputs.outputbase + ".*")
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tesseract:5.5.1
s:url: https://github.com/tesseract-ocr/tesseract
$namespaces:
  s: https://schema.org/
