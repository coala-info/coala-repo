cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-apo-calibrate
label: meta-apo_meta-apo-calibrate
doc: "Calibration of predicted gene profiles of amplicon microbiomes\n\nTool homepage:
  https://github.com/qibebt-bioinfo/meta-apo"
inputs:
  - id: files_path_prefix
    type:
      - 'null'
      - string
    doc: List files path prefix [Optional for -l]
    inputBinding:
      position: 101
      prefix: -p
  - id: input_files_list
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files list for multiple samples
    inputBinding:
      position: 101
      prefix: -l
  - id: input_gene_profile
    type:
      - 'null'
      - File
    doc: Input a gene profile file for a single sample
    inputBinding:
      position: 101
      prefix: -i
  - id: input_ko_table
    type:
      - 'null'
      - File
    doc: Input KO table (*.ko.abd) for multiple samples
    inputBinding:
      position: 101
      prefix: -t
  - id: input_model_file
    type: File
    doc: Input model file
    inputBinding:
      position: 101
      prefix: -m
  - id: reversed_input_table
    type:
      - 'null'
      - boolean
    doc: If the input table is reversed, T(rue) or F(alse), default is false 
      [Optional for -t]
    default: false
    inputBinding:
      position: 101
      prefix: -R
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output path
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9f5acd7_4
