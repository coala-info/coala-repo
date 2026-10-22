cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbpore
  - download
label: tbpore_download
doc: "Download and validate the decontamination database\n\nTool homepage: https://github.com/mbhall88/tbpore/"
inputs:
  - id: output_db
    type:
      - 'null'
      - string
    doc: Download database to a specified filepath (default is /root/.tbpore/decontamination_db/remove_contam.map-ont.mmi)
    inputBinding:
      position: 101
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite if the database already exists
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: decontamination_db
    type:
      - 'null'
      - File
    doc: The downloaded decontamination database index
    outputBinding:
      glob: $(inputs.output_db)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
stdout: tbpore_download.out
