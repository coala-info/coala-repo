cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbitk
label: ncbitk
doc: "Sync your collection with the latest assembly versions or download the latest
  assembly summary and taxonomy dump.\n\nTool homepage: https://github.com/andrewsanchez/NCBITK"
inputs:
  - id: genbank
    type: string
    doc: Genbank identifier
    inputBinding:
      position: 1
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Species to include
    inputBinding:
      position: 2
  - id: from_file
    type:
      - 'null'
      - File
    doc: Specify a file to read input from
    inputBinding:
      position: 103
      prefix: --from-file
  - id: local_assembly
    type:
      - 'null'
      - boolean
    doc: Use your local copies of assembly summary and taxonomy dump
    inputBinding:
      position: 103
      prefix: --local-assembly
  - id: no_update
    type:
      - 'null'
      - boolean
    doc: Do not sync your collection with the latest assembly versions
    inputBinding:
      position: 103
      prefix: --no-update
  - id: status
    type:
      - 'null'
      - boolean
    doc: Show the current status of your genome collection
    inputBinding:
      position: 103
      prefix: --status
  - id: update
    type:
      - 'null'
      - boolean
    doc: Sync your collection with the latest assembly versions
    inputBinding:
      position: 103
      prefix: --update
  - id: update_assembly
    type:
      - 'null'
      - boolean
    doc: Download the latest assembly summary and taxonomy dump
    inputBinding:
      position: 103
      prefix: --update-assembly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbitk:1.0a17--py_0
stdout: ncbitk.out
