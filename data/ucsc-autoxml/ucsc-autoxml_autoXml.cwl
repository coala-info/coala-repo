cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoXml
label: ucsc-autoxml_autoXml
doc: "Generate structures code and parser for XML file from DTD-like spec\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: dtdx_file
    type: File
    doc: DTD-like spec file
    inputBinding:
      position: 1
  - id: root_name
    type: string
    doc: Root element name for generated code
    inputBinding:
      position: 2
  - id: comment
    type:
      - 'null'
      - string
    doc: Comment to appear at top of generated code files
    inputBinding:
      position: 103
      prefix: -comment
  - id: generate_main
    type:
      - 'null'
      - boolean
    doc: Put in a main routine that's a test harness
    inputBinding:
      position: 103
      prefix: -main
  - id: picky
    type:
      - 'null'
      - boolean
    doc: Generate parser that rejects stuff it doesn't understand
    inputBinding:
      position: 103
      prefix: -picky
  - id: positive_values_only
    type:
      - 'null'
      - boolean
    doc: Don't write out optional attributes with negative values
    inputBinding:
      position: 103
      prefix: -positive
  - id: structure_prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to structure names. By default same as root
    inputBinding:
      position: 103
      prefix: -prefix
  - id: text_field_name
    type:
      - 'null'
      - string
    doc: what to name text between start/end tags
    inputBinding:
      position: 103
      prefix: -textField
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autoxml:482--h0b57e2e_0
stdout: ucsc-autoxml_autoXml.out
