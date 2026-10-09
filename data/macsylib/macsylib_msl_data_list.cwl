cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, list]
label: macsylib_msl_data_list
doc: "List installed packages.\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: outdated
    type:
      - 'null'
      - boolean
    doc: "List outdated packages."
    inputBinding:
      position: 1
      prefix: --outdated
  - id: uptodate
    type:
      - 'null'
      - boolean
    doc: "List uptodate packages"
    inputBinding:
      position: 2
      prefix: --uptodate
  - id: org
    type:
      - 'null'
      - string
    doc: "The name of Model organization (default macsy-models)"
    inputBinding:
      position: 3
      prefix: --org
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: "the path of the alternative root directory containing package instead used canonical locations"
    inputBinding:
      position: 4
      prefix: --models-dir
  - id: long
    type:
      - 'null'
      - boolean
    doc: "in addition displays the path where is store each package"
    inputBinding:
      position: 5
      prefix: --long
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "alias for -l/--long option"
    inputBinding:
      position: 6
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_list.out
