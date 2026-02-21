cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangbank_db
label: pangbank-api_pangbank_db
doc: "Pangbank database management tool\n\nTool homepage: https://github.com/labgem/pangbank-api"
inputs:
  - id: command
    type: string
    doc: The command to execute (add-collection-release, list-collections, delete-collection,
      or genome-metadata)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
stdout: pangbank-api_pangbank_db.out
