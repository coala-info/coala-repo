cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oakvar
  - ov
  - module
  - install
label: oakvar_ov module install
doc: "Installs OakVar modules.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: module_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Modules to install. May be regular expressions.
    inputBinding:
      position: 1
  - id: clean
    type:
      - 'null'
      - boolean
    doc: removes temporary installation directory
    inputBinding:
      position: 102
      prefix: --clean
  - id: file
    type:
      - 'null'
      - File
    doc: Use a file with module names to install
    inputBinding:
      position: 102
      prefix: --file
  - id: force
    type:
      - 'null'
      - boolean
    doc: Install module even if latest version is already installed
    inputBinding:
      position: 102
      prefix: --force
  - id: force_data
    type:
      - 'null'
      - boolean
    doc: Download data even if latest data is already installed
    inputBinding:
      position: 102
      prefix: --force-data
  - id: no_fetch
    type:
      - 'null'
      - boolean
    doc: Skip fetching the latest store
    inputBinding:
      position: 102
      prefix: --no-fetch
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Install module even if latest version is already installed
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress stdout output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: skip_data
    type:
      - 'null'
      - boolean
    doc: Skip installing data
    inputBinding:
      position: 102
      prefix: --skip-data
  - id: skip_dependencies
    type:
      - 'null'
      - boolean
    doc: Skip installing dependencies
    inputBinding:
      position: 102
      prefix: --skip-dependencies
  - id: urls
    type:
      - 'null'
      - type: array
        items: string
    doc: Install from URLs
    inputBinding:
      position: 102
      prefix: --url
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Proceed without prompt
    inputBinding:
      position: 102
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov module install.out
