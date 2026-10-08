cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fusion_report
  - sync
label: fusion-report_sync
doc: "Synchronize databases\n\nTool homepage: https://github.com/matq007/fusion-report"
inputs:
  - id: output_path
    type: string
    doc: Output directory
    inputBinding:
      position: 1
  - id: cosmic_usr
    type:
      - 'null'
      - string
    doc: COSMIC username
    inputBinding:
      position: 101
      prefix: --cosmic_usr
  - id: cosmic_passwd
    type:
      - 'null'
      - string
    doc: COSMIC password
    inputBinding:
      position: 101
      prefix: --cosmic_passwd
  - id: cosmic_token
    type:
      - 'null'
      - string
    doc: COSMIC token
    inputBinding:
      position: 101
      prefix: --cosmic_token
  - id: qiagen
    type:
      - 'null'
      - boolean
    doc: Use QIAGEN to download COSMIC db (commercial usage)
    inputBinding:
      position: 101
      prefix: --qiagen
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the databases
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
