cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle meta
label: eagle_meta
doc: "Manage meta information for eagle-data-files.\n\nTool homepage: https://bitbucket.org/christopherschroeder/eagle"
inputs:
  - id: input
    type: File
    doc: the eagle-data-file
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: the name of the meta information
    inputBinding:
      position: 2
  - id: delete
    type:
      - 'null'
      - boolean
    doc: delete the meta information
    inputBinding:
      position: 103
      prefix: --delete
  - id: set_meta_info
    type:
      - 'null'
      - string
    doc: write this value as meta information
    inputBinding:
      position: 103
      prefix: --s
  - id: storelist
    type:
      - 'null'
      - type: array
        items: string
    doc: a list containing key value pairs to store
    inputBinding:
      position: 103
      prefix: --storelist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
stdout: eagle_meta.out
