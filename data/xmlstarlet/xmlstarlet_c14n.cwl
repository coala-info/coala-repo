cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - c14n
label: xmlstarlet_c14n
doc: "XML canonicalization\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: net
    type:
      - 'null'
      - boolean
    doc: 'Allow fetching DTDs or entities over the network.'
    inputBinding:
      position: 1
      prefix: --net
  - id: with_comments
    type:
      - 'null'
      - boolean
    doc: 'XML file canonicalization with comments (default).'
    inputBinding:
      position: 2
      prefix: --with-comments
  - id: without_comments
    type:
      - 'null'
      - boolean
    doc: 'XML file canonicalization without comments.'
    inputBinding:
      position: 2
      prefix: --without-comments
  - id: exc_with_comments
    type:
      - 'null'
      - boolean
    doc: 'Exclusive XML file canonicalization with comments.'
    inputBinding:
      position: 2
      prefix: --exc-with-comments
  - id: exc_without_comments
    type:
      - 'null'
      - boolean
    doc: 'Exclusive XML file canonicalization without comments.'
    inputBinding:
      position: 2
      prefix: --exc-without-comments
  - id: xml_file
    type: File
    doc: 'Input XML document file.'
    inputBinding:
      position: 3
  - id: xpath_file
    type:
      - 'null'
      - File
    doc: 'XML file containing the XPath expression for c14n canonicalization.'
    inputBinding:
      position: 4
  - id: inclusive_ns_list
    type:
      - 'null'
      - string
    doc: 'List of inclusive namespace prefixes (only for exclusive canonicalization), for example "n1 n2".'
    inputBinding:
      position: 5
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml c14n.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_c14n.out
