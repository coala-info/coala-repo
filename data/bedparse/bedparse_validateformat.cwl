cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedparse
  - validateFormat
label: bedparse_validateformat
doc: "Checks whether the BED file provided adheres to the BED format specifications.\n\
  Optionally, it can fix field speration errors.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the BED file.
    inputBinding:
      position: 1
  - id: fix_separators
    type:
      - 'null'
      - boolean
    doc: If the fields are separated by multiple spaces (e.g. when copy-pasting 
      BED files), replace them into tabs.
    inputBinding:
      position: 102
      prefix: --fixSeparators
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_validateformat.out
