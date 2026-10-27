cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - fo
label: xmlstarlet_fo
doc: "Format an XML document\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: noindent
    type:
      - 'null'
      - boolean
    doc: 'Do not indent.'
    inputBinding:
      position: 1
      prefix: -n
  - id: indent_tab
    type:
      - 'null'
      - boolean
    doc: 'Indent output with tabulation.'
    inputBinding:
      position: 1
      prefix: -t
  - id: indent_spaces
    type:
      - 'null'
      - int
    doc: 'Indent output with this number of spaces.'
    inputBinding:
      position: 1
      prefix: -s
  - id: omit_decl
    type:
      - 'null'
      - boolean
    doc: 'Omit xml declaration.'
    inputBinding:
      position: 1
      prefix: -o
  - id: net
    type:
      - 'null'
      - boolean
    doc: 'Allow network access.'
    inputBinding:
      position: 1
      prefix: --net
  - id: recover
    type:
      - 'null'
      - boolean
    doc: 'Try to recover what is parsable.'
    inputBinding:
      position: 1
      prefix: -R
  - id: dropdtd
    type:
      - 'null'
      - boolean
    doc: 'Remove the DOCTYPE of the input docs.'
    inputBinding:
      position: 1
      prefix: -D
  - id: nocdata
    type:
      - 'null'
      - boolean
    doc: 'Replace cdata section with text nodes.'
    inputBinding:
      position: 1
      prefix: -C
  - id: nsclean
    type:
      - 'null'
      - boolean
    doc: 'Remove redundant namespace declarations.'
    inputBinding:
      position: 1
      prefix: -N
  - id: encode
    type:
      - 'null'
      - string
    doc: 'Output in the given encoding (utf-8, unicode...).'
    inputBinding:
      position: 1
      prefix: -e
  - id: html
    type:
      - 'null'
      - boolean
    doc: 'Input is HTML.'
    inputBinding:
      position: 1
      prefix: -H
  - id: xml_file
    type: File
    doc: 'Input XML document.'
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml fo.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_fo.out
