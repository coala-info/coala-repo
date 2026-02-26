cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges init
label: ibridges_init
doc: "Create a cached password for future use.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: irods_env_path_or_alias
    type:
      - 'null'
      - string
    doc: The path to your iRODS environment JSON file or an alias for an 
      environment.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_init.out
