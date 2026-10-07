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
      valueFrom: $(self.basename)
  - id: tables
    type:
      - 'null'
      - type: array
        items: File
    doc: CSV/TSV tables named in the config file; staged in the working 
      directory so the relative paths in the config resolve
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
      - boolean
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
  - id: output_path
    type: string
    doc: Output file
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory with the HTML report
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config)
      - $(inputs.tables)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datavzrd:2.23.2
