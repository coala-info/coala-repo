cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plassembler
  - download
label: plassembler_download
doc: "Downloads Plassembler DB\n\nTool homepage: https://github.com/gbouras13/plassembler"
inputs:
  - id: database
    type: string
    doc: Directory where database will be stored.
    inputBinding:
      position: 101
      prefix: --database
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the database directory.
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the downloaded database
    outputBinding:
      glob: $(inputs.database)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
stdout: plassembler_download.out
