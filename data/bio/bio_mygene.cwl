cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_mygene
doc: "Download gene information from NCBI Gene.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: query
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene symbol or ID to query
    inputBinding:
      position: 1
  - id: fields
    type:
      - 'null'
      - string
    doc: fields
    inputBinding:
      position: 102
      prefix: --fields
  - id: limit
    type:
      - 'null'
      - int
    doc: download limit
    inputBinding:
      position: 102
      prefix: --limit
  - id: scopes
    type:
      - 'null'
      - string
    doc: scopes
    inputBinding:
      position: 102
      prefix: --scopes
  - id: species
    type:
      - 'null'
      - string
    doc: species
    inputBinding:
      position: 102
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_mygene.out
