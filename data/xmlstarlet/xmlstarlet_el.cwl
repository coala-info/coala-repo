cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - el
label: xmlstarlet_el
doc: "Display the element structure of an XML document\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: attributes
    type:
      - 'null'
      - boolean
    doc: 'Show attributes as well.'
    inputBinding:
      position: 1
      prefix: -a
  - id: attributes_values
    type:
      - 'null'
      - boolean
    doc: 'Show attributes and their values.'
    inputBinding:
      position: 1
      prefix: -v
  - id: unique
    type:
      - 'null'
      - boolean
    doc: 'Print out sorted unique lines.'
    inputBinding:
      position: 1
      prefix: -u
  - id: depth
    type:
      - 'null'
      - int
    doc: 'Print out sorted unique lines up to this depth.'
    inputBinding:
      position: 1
      prefix: -d
      separate: false
  - id: xml_file
    type: File
    doc: 'Input XML document file (stdin is used if missing).'
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml el.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_el.out
