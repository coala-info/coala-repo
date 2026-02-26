cwlVersion: v1.2
class: CommandLineTool
baseCommand: oakvar_ov
label: oakvar_ov system setup
doc: "OakVar system setup\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: oakvar_store_account
    type:
      - 'null'
      - string
    doc: Indicates if the user has an OakVar store account
    default: N
    inputBinding:
      position: 101
      prefix: Do you already have an OakVar store account?
  - id: system_config_file
    type:
      - 'null'
      - File
    doc: System configuration file
    inputBinding:
      position: 101
      prefix: System configuration file
  - id: user_config_file
    type:
      - 'null'
      - File
    doc: User configuration file
    inputBinding:
      position: 101
      prefix: User configuration file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov system setup.out
