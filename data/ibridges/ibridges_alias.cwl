cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ibridges
  - alias
label: ibridges_alias
doc: "Print existing aliases or create new ones.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: alias
    type:
      - 'null'
      - string
    doc: The new alias to be created.
    inputBinding:
      position: 1
  - id: env_path
    type:
      - 'null'
      - File
    doc: iRODS environment path.
    inputBinding:
      position: 2
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete the alias.
    inputBinding:
      position: 103
      prefix: --delete
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: cli_config
    type:
      - 'null'
      - File
    doc: Command line configuration file that stores the aliases
    outputBinding:
      glob: .ibridges/ibridges_cli.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_alias.out
