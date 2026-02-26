cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_manage_db.rb
label: protk_manage_db.rb
doc: "Manage named protein databases.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: command
    type: string
    doc: Command to execute (add, remove, update, list, help)
    inputBinding:
      position: 1
  - id: dbname
    type: string
    doc: Name of the protein database
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_manage_db.rb.out
