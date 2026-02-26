cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - index
label: yame_index
doc: "The index file name default to <in.cx>.idx\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx_file
    type: File
    doc: Input .cx file
    inputBinding:
      position: 1
  - id: add_sample
    type:
      - 'null'
      - string
    doc: add one sample to the end of the index
    inputBinding:
      position: 102
      prefix: '-1'
  - id: output_to_console
    type:
      - 'null'
      - boolean
    doc: output index to console
    inputBinding:
      position: 102
      prefix: -c
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: tab-delimited sample name list (use first column)
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_index.out
