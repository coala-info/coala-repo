cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - Bin2To3
label: clair_Bin2To3
doc: "Load bin using python2, export bin using python3\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: is_export
    type:
      - 'null'
      - boolean
    doc: "If this option enabled, it is used to export instead of import"
    inputBinding:
      position: 101
      prefix: --is_export
  - id: bin_fn
    type:
      - 'null'
      - string
    doc: "If --is_export enabled, this is the export bin file path (written from the text tensors on standard input). If --is_export not enabled, use bin_file instead"
    inputBinding:
      position: 101
      prefix: --bin_fn
  - id: bin_file
    type:
      - 'null'
      - File
    doc: "Import mode (no --is_export): the bin file to read; its tensors are printed as text to standard output"
    inputBinding:
      position: 101
      prefix: --bin_fn
  - id: text_tensors
    type:
      - 'null'
      - File
    doc: "Export mode: text tensors (x, y, pos lines, as printed in import mode) read from standard input"
outputs:
  - id: exported_bin
    type:
      - 'null'
      - File
    doc: "Bin written in export mode"
    outputBinding:
      glob: "$(inputs.is_export && inputs.bin_fn ? inputs.bin_fn : [])"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdin: "$(inputs.text_tensors ? inputs.text_tensors.path : null)"
stdout: clair_Bin2To3.out
