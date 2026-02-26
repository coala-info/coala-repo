cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - info
label: yame_info
doc: "Report information about a YAME file.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_file
    type: File
    doc: Input YAME file
    inputBinding:
      position: 1
  - id: one_record_per_file
    type:
      - 'null'
      - boolean
    doc: Report one record per file.
    inputBinding:
      position: 102
      prefix: '-1'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_info.out
