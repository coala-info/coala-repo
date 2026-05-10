cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amdirt
  - download
label: amdirt_download
doc: "Download a table from the amdirt repository\n\nTool homepage: https://github.com/SPAAM-community/AMDirT"
inputs:
  - id: release
    type:
      - 'null'
      - string
    doc: Release tag to download
    inputBinding:
      position: 101
      prefix: --release
  - id: table
    type:
      - 'null'
      - string
    doc: AncientMetagenomeDir table to download 
      [ancientmetagenome-environmental|ancientmetagenome-hostassociated|ancientsinglegenome-hostassociated|test]
    inputBinding:
      position: 101
      prefix: --table
  - id: table_type
    type:
      - 'null'
      - string
    doc: Type of table to download [samples|libraries|dates]
    inputBinding:
      position: 101
      prefix: --table_type
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
