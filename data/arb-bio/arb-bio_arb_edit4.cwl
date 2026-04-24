cwlVersion: v1.2
class: CommandLineTool
baseCommand: arb_edit4
label: arb-bio_arb_edit4
doc: "Edit ARB database or connect to arb-database-server\n\nTool homepage: http://www.arb-home.de"
inputs:
  - id: database
    type: string
    doc: name of database or ':' to connect to arb-database-server
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - string
    doc: loads configuration 'config'
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arb-bio:6.0.6--0
stdout: arb-bio_arb_edit4.out
