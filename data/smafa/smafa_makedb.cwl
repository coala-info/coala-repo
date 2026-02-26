cwlVersion: v1.2
class: CommandLineTool
baseCommand: smafa makedb
label: smafa_makedb
doc: "Generate a searchable database\n\nTool homepage: https://github.com/wwood/smafa"
inputs:
  - id: input_file
    type: File
    doc: Subject sequences to search against
    inputBinding:
      position: 101
      prefix: --input
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Unless there is an error, do not print logging information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: database_file
    type: File
    doc: Output DB filename
    outputBinding:
      glob: $(inputs.database_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
