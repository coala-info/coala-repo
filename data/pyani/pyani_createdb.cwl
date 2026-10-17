cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - createdb
label: pyani_createdb
doc: "Create an empty pyani SQLite database.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: logfile
    type:
      - 'null'
      - string
    doc: "logfile location"
    inputBinding:
      position: 10
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "report verbose progress to log"
    inputBinding:
      position: 10
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "report debug messages to log"
    inputBinding:
      position: 10
      prefix: --debug
  - id: disable_tqdm
    type:
      - 'null'
      - boolean
    doc: "Turn off tqdm progress bar"
    inputBinding:
      position: 10
      prefix: --disable_tqdm
  - id: dbpath
    type: string
    default: .pyani/pyanidb
    doc: "path to pyani database (default: .pyani/pyanidb)"
    inputBinding:
      position: 10
      prefix: --dbpath
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force creation of new empty database"
    inputBinding:
      position: 10
      prefix: -f
outputs:
  - id: database
    type: File
    doc: New empty pyani database
    outputBinding:
      glob: $(inputs.dbpath)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
