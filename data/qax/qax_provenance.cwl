cwlVersion: v1.2
class: CommandLineTool
baseCommand: provenance
label: qax_provenance
doc: "Print ancestry of an artifact\n\nTool homepage: https://github.com/telatin/qax"
inputs:
  - id: inputfile
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: font
    type:
      - 'null'
      - string
    doc: Font name for the PDF
    inputBinding:
      position: 102
      prefix: --font
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Generate PDF of the graph (requires -o and "dot" installed)
    inputBinding:
      position: 102
      prefix: --pdf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: dotfile
    type:
      - 'null'
      - File
    doc: Save graphviz graph (dot format)
    outputBinding:
      glob: $(inputs.dotfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qax:0.9.8--h515fd9b_0
