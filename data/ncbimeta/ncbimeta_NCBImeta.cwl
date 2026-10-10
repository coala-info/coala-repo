cwlVersion: v1.2
class: CommandLineTool
baseCommand: [NCBImeta]
label: ncbimeta_NCBImeta
doc: "NCBImeta: efficient and comprehensive metadata retrieval from the NCBI databases into a local SQLite database.\n\nTool homepage: https://github.com/ktmeaton/NCBImeta"
inputs:
  - id: config
    type: File
    doc: "Path to the yaml configuration file (ex. config.yaml)."
    inputBinding:
      position: 1
      prefix: --config
  - id: output_directory
    type: string
    doc: "Name of the OUTPUT_DIR set in the configuration file; collected as the result directory."
  - id: flat
    type:
      - 'null'
      - boolean
    doc: "Do not create sub-directories in the output directory."
    inputBinding:
      position: 1
      prefix: --flat
  - id: email
    type:
      - 'null'
      - string
    doc: "User email to override the parameter in the config file."
    inputBinding:
      position: 1
      prefix: --email
  - id: api
    type:
      - 'null'
      - string
    doc: "User API key to override the parameter in the config file."
    inputBinding:
      position: 1
      prefix: --api
  - id: force_pause_seconds
    type:
      - 'null'
      - int
    doc: "FORCE_PAUSE_SECONDS to override the parameter in the config file."
    inputBinding:
      position: 1
      prefix: --force-pause-seconds
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress logging of each record to the console."
    inputBinding:
      position: 1
      prefix: --quiet
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debugging mode."
    inputBinding:
      position: 1
      prefix: --debug
outputs:
  - id: results
    type: Directory
    doc: Output directory with the SQLite database and logs.
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: NCBImeta.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbimeta:0.8.3--pyhdfd78af_0
