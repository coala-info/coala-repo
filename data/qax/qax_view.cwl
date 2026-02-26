cwlVersion: v1.2
class: CommandLineTool
baseCommand: view
label: qax_view
doc: "View (a la `cat`) the content of data files in one artifact.\n\nTool homepage:
  https://github.com/telatin/qax"
inputs:
  - id: inputfile
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: datafiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional data files
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Accept artifact with non caninical extension
    inputBinding:
      position: 103
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qax:0.9.8--h515fd9b_0
stdout: qax_view.out
