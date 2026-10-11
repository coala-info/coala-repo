cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ov
  - system
  - setup
label: oakvar_ov_system_setup
doc: "Sets up the OakVar system.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: setup_file
    type:
      - 'null'
      - File
    doc: Setup file to use.
    inputBinding:
      position: 102
      prefix: -f
  - id: email
    type:
      - 'null'
      - string
    doc: Email for an OakVar store account.
    inputBinding:
      position: 102
      prefix: --email
  - id: pw
    type:
      - 'null'
      - string
    doc: Password for an OakVar store account.
    inputBinding:
      position: 102
      prefix: --pw
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Performs clean installation.
    inputBinding:
      position: 102
      prefix: --clean
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: modules
    type:
      - 'null'
      - type: array
        items: string
    doc: Modules to install.
    inputBinding:
      position: 102
      prefix: --modules
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov_system_setup.out
