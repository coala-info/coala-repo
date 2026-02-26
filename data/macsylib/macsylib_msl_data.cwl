cwlVersion: v1.2
class: CommandLineTool
baseCommand: msl_data
label: macsylib_msl_data
doc: "Model Management Tool\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: available
    type:
      - 'null'
      - boolean
    doc: List Models available on macsy-models
    inputBinding:
      position: 102
      prefix: available
  - id: check
    type:
      - 'null'
      - boolean
    doc: "check if the directory is ready to be publish as data\n                \
      \        package"
    inputBinding:
      position: 102
      prefix: check
  - id: cite
    type:
      - 'null'
      - boolean
    doc: How to cite a package.
    inputBinding:
      position: 102
      prefix: cite
  - id: definition
    type:
      - 'null'
      - boolean
    doc: show a model definition
    inputBinding:
      position: 102
      prefix: definition
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download model packages.
    inputBinding:
      position: 102
      prefix: download
  - id: freeze
    type:
      - 'null'
      - boolean
    doc: List installed models in requirements format.
    inputBinding:
      position: 102
      prefix: freeze
  - id: info
    type:
      - 'null'
      - boolean
    doc: Show information about packages.
    inputBinding:
      position: 102
      prefix: info
  - id: init
    type:
      - 'null'
      - boolean
    doc: "Create a template for a new data package (REQUIRE\n                    \
      \    git/GitPython installation)"
    inputBinding:
      position: 102
      prefix: init
  - id: install
    type:
      - 'null'
      - boolean
    doc: Install Model packages.
    inputBinding:
      position: 102
      prefix: install
  - id: list
    type:
      - 'null'
      - boolean
    doc: List installed packages.
    inputBinding:
      position: 102
      prefix: list
  - id: search
    type:
      - 'null'
      - boolean
    doc: Discover new packages.
    inputBinding:
      position: 102
      prefix: search
  - id: show
    type:
      - 'null'
      - boolean
    doc: show the structure of model package
    inputBinding:
      position: 102
      prefix: show
  - id: uninstall
    type:
      - 'null'
      - boolean
    doc: Uninstall packages.
    inputBinding:
      position: 102
      prefix: uninstall
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Give more output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data.out
