cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - upload-to-gisaid
label: relecov-tools_upload-to-gisaid
doc: "parsed data to create files to upload to gisaid\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: client_id
    type:
      - 'null'
      - string
    doc: client-ID provided by clisupport@gisaid.org
    inputBinding:
      position: 101
      prefix: --client_id
  - id: frameshift
    type:
      - 'null'
      - string
    doc: frameshift notification
    inputBinding:
      position: 101
      prefix: --frameshift
  - id: gisaid_json
    type:
      - 'null'
      - File
    doc: path to validated json mapped to GISAID
    inputBinding:
      position: 101
      prefix: --gisaid_json
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'input fasta is gziped. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --gzip
  - id: input_path
    type:
      - 'null'
      - File
    doc: path to fastas folder or multifasta file
    inputBinding:
      position: 101
      prefix: --input_path
  - id: password
    type:
      - 'null'
      - string
    doc: password for the user to login
    inputBinding:
      position: 101
      prefix: --password
  - id: proxy_config
    type:
      - 'null'
      - string
    doc: 'introduce your proxy credentials as: username:password@proxy:port'
    inputBinding:
      position: 101
      prefix: --proxy_config
  - id: single
    type:
      - 'null'
      - boolean
    doc: 'input is a folder with several fasta files. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --single
  - id: token
    type:
      - 'null'
      - string
    doc: path to athentication token
    inputBinding:
      position: 101
      prefix: --token
  - id: user
    type:
      - 'null'
      - string
    doc: user name for login
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
