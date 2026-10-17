cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel
label: pybel_manage_networks_drop
doc: "Drop a network by its identifier or drop all networks.\n\nTool homepage: https://pybel.readthedocs.io"
arguments:
  - position: 2
    valueFrom: manage
  - position: 3
    valueFrom: networks
  - position: 4
    valueFrom: drop
inputs:
  - id: database
    type: string
    doc: "SQLite database file name used as the connection (sqlite:///NAME); created when it does not exist"
    inputBinding:
      position: 1
      prefix: -c
      valueFrom: sqlite:///$(self)
  - id: database_in
    type:
      - 'null'
      - File
    doc: Existing database to use (staged as a writable copy under the name given by database).
  - id: network_id
    type:
      - 'null'
      - int
    doc: "Identifier of network to drop"
    inputBinding:
      position: 10
      prefix: --network-id
  - id: yes
    type:
      - 'null'
      - boolean
    doc: "Drop all networks without confirmation if no identifier is given"
    inputBinding:
      position: 10
      prefix: --yes
outputs:
  - id: database_out
    type: File
    doc: Database file after the command
    outputBinding:
      glob: $(inputs.database)
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database)
        entry: $(inputs.database_in)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_manage_networks_drop.out
