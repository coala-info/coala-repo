cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_setup
label: ibridges_setup
doc: "Use templates to create an iRODS environment json.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: server_name
    type:
      - 'null'
      - string
    doc: Server name to create your irods_environment.json for.
    inputBinding:
      position: 1
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all available server names.
    inputBinding:
      position: 102
      prefix: --list
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the irods environment file.
    inputBinding:
      position: 102
      prefix: --overwrite
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Store the environment to a file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
