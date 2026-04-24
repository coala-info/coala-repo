cwlVersion: v1.2
class: CommandLineTool
baseCommand: datavzrd
label: datavzrd
doc: "A tool to create visual HTML reports from collections of CSV/TSV tables.\n\n\
  Tool homepage: https://github.com/datavzrd/datavzrd"
inputs:
  - id: config
    type: File
    doc: Config file containing file paths and settings
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Activates debug mode. Javascript files are not minified
    inputBinding:
      position: 102
      prefix: --debug
  - id: overwrite_output
    type:
      - 'null'
      - boolean
    doc: Overwrites the contents of the given output directory if it is not 
      empty
    inputBinding:
      position: 102
      prefix: --overwrite-output
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbose mode (-v, -vv, -vvv, etc.)
    inputBinding:
      position: 102
      prefix: --verbose
  - id: webview_url
    type:
      - 'null'
      - string
    doc: Sets the URL of the webview host. Note that when using the link the row
      data can temporarily occur (in base64-encoded form) in the server logs of 
      the given webview host
    inputBinding:
      position: 102
      prefix: --webview-url
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datavzrd:2.23.2
