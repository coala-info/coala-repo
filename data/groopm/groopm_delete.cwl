cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - delete
label: groopm_delete
doc: "Delete bins from a groopm database.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse) and modified in place
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
  - id: database_out
    type: File
    doc: The GroopM database after the command ran (updated in place)
    outputBinding:
      glob: $(inputs.database.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database.basename)
        entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_delete.out
