cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_delete
label: groopm_delete
doc: "Delete bins from a groopm database.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: bids
    type:
      type: array
      items: string
    doc: bin ids to delete
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: delete without prompting
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_delete.out
