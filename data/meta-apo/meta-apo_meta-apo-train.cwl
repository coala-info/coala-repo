cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-apo-train
label: meta-apo_meta-apo-train
doc: "Model training using gene profiles of paired WGS-amplicon microbiomes\n\nTool
  homepage: https://github.com/qibebt-bioinfo/meta-apo"
inputs:
  - id: files_path_prefix
    type:
      - 'null'
      - string
    doc: List files path prefix [Optional for -l and -L]
    inputBinding:
      position: 101
      prefix: -p
  - id: input_amplicon_ko_table
    type: File
    doc: Input KO table (*.ko.abd) of training amplicon samples
    inputBinding:
      position: 101
      prefix: -t
  - id: input_amplicon_list
    type: File
    doc: Input files list of training amplicon samples
    inputBinding:
      position: 101
      prefix: -l
  - id: input_wgs_ko_table
    type: File
    doc: Input KO table (*.ko.abd) of training WGS samples
    inputBinding:
      position: 101
      prefix: -T
  - id: input_wgs_list
    type: File
    doc: Input files list of training WGS samples
    inputBinding:
      position: 101
      prefix: -L
  - id: is_input_table_reversed
    type:
      - 'null'
      - boolean
    doc: If the input table is reversed, T(rue) or F(alse), default is false 
      [Optional for -T and -t]
    inputBinding:
      position: 101
      prefix: -R
  - id: output_mode_file
    type:
      - 'null'
      - File
    doc: Output mode file
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9f5acd7_4
stdout: meta-apo_meta-apo-train.out
