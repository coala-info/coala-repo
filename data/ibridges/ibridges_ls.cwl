cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_ls
label: ibridges_ls
doc: "List a collection on iRODS.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_coll
    type:
      - 'null'
      - string
    doc: Path to remote iRODS location starting with 'irods:'.
    inputBinding:
      position: 1
  - id: icommands
    type:
      - 'null'
      - boolean
    doc: Display available data objects/collections in iCommands form.
    inputBinding:
      position: 102
      prefix: --icommands
  - id: long_form
    type:
      - 'null'
      - boolean
    doc: Display available data objects/collections in long form.
    inputBinding:
      position: 102
      prefix: --long
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: Show metadata for each iRODS location, only in combination with 
      -i/--icommands.
    inputBinding:
      position: 102
      prefix: --metadata
  - id: nocolor
    type:
      - 'null'
      - boolean
    doc: Disable printing with color.
    inputBinding:
      position: 102
      prefix: --nocolor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_ls.out
