cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - val
label: xmlstarlet_val
doc: "Validate XML document(s): well-formedness, DTD, XSD or Relax-NG\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: well_formed
    type:
      - 'null'
      - boolean
    doc: 'Validate well-formedness only (default).'
    inputBinding:
      position: 1
      prefix: -w
  - id: dtd
    type:
      - 'null'
      - File
    doc: 'Validate against this DTD file.'
    inputBinding:
      position: 1
      prefix: -d
  - id: net
    type:
      - 'null'
      - boolean
    doc: 'Allow network access.'
    inputBinding:
      position: 1
      prefix: --net
  - id: xsd
    type:
      - 'null'
      - File
    doc: 'Validate against this XSD schema.'
    inputBinding:
      position: 1
      prefix: -s
  - id: embed
    type:
      - 'null'
      - boolean
    doc: 'Validate using embedded DTD.'
    inputBinding:
      position: 1
      prefix: -E
  - id: relaxng
    type:
      - 'null'
      - File
    doc: 'Validate against this Relax-NG schema.'
    inputBinding:
      position: 1
      prefix: -r
  - id: err
    type:
      - 'null'
      - boolean
    doc: 'Print verbose error messages on stderr.'
    inputBinding:
      position: 1
      prefix: -e
  - id: stop
    type:
      - 'null'
      - boolean
    doc: 'Stop on first error.'
    inputBinding:
      position: 1
      prefix: -S
  - id: list_bad
    type:
      - 'null'
      - boolean
    doc: 'List only files which do not validate.'
    inputBinding:
      position: 1
      prefix: -b
  - id: list_good
    type:
      - 'null'
      - boolean
    doc: 'List only files which validate.'
    inputBinding:
      position: 1
      prefix: -g
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not list files (return result code only).'
    inputBinding:
      position: 1
      prefix: -q
  - id: xml_files
    type:
      type: array
      items: File
    doc: 'Input XML document file(s) or URI.'
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml val.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_val.out
