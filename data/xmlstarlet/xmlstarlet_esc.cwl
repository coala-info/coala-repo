cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - esc
label: xmlstarlet_esc
doc: "Escape special XML characters\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: text
    type:
      - 'null'
      - string
    doc: 'String to convert; if missing, stdin is used.'
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml esc.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_esc.out
