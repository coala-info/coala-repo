cwlVersion: v1.2
class: CommandLineTool
baseCommand: b2bTools
label: b2btools
doc: "Bio2Byte Tool - Command Line Interface\n\nTool homepage: https://bio2byte.be/"
inputs:
  - id: agmata
    type:
      - 'null'
      - boolean
    doc: Run AgMata predictor
    inputBinding:
      position: 101
      prefix: --agmata
  - id: disomine
    type:
      - 'null'
      - boolean
    doc: Run DisoMine predictor
    inputBinding:
      position: 101
      prefix: --disomine
  - id: dynamine
    type:
      - 'null'
      - boolean
    doc: Run DynaMine predictor
    inputBinding:
      position: 101
      prefix: --dynamine
  - id: efoldmine
    type:
      - 'null'
      - boolean
    doc: Run EFoldMine predictor
    inputBinding:
      position: 101
      prefix: --efoldmine
  - id: input_file
    type: File
    doc: File to process
    inputBinding:
      position: 101
      prefix: --input_file
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: Path to tabular metadata file
    inputBinding:
      position: 101
      prefix: --metadata_file
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Execution mode: Single Sequence or MSA Analysis'
    inputBinding:
      position: 101
      prefix: --mode
  - id: psper
    type:
      - 'null'
      - boolean
    doc: Run PSPer predictor
    inputBinding:
      position: 101
      prefix: --psper
  - id: sep
    type:
      - 'null'
      - string
    doc: Tabular separator
    inputBinding:
      position: 101
      prefix: --sep
  - id: sequence_id
    type:
      - 'null'
      - string
    doc: Sequence to extract results instead of getting all the results
    inputBinding:
      position: 101
      prefix: --sequence_id
  - id: short_ids
    type:
      - 'null'
      - boolean
    doc: Trim sequence ids (up to 20 chars per seq)
    inputBinding:
      position: 101
      prefix: --short_ids
outputs:
  - id: output_json_file
    type: File
    doc: Path to JSON output file
    outputBinding:
      glob: $(inputs.output_json_file)
  - id: output_tabular_file
    type:
      - 'null'
      - File
    doc: Path to tabular output file
    outputBinding:
      glob: $(inputs.output_tabular_file)
  - id: distribution_json_file
    type:
      - 'null'
      - File
    doc: Path to distribution output JSON file
    outputBinding:
      glob: $(inputs.distribution_json_file)
  - id: distribution_tabular_file
    type:
      - 'null'
      - File
    doc: Path to distribution output JSON file
    outputBinding:
      glob: $(inputs.distribution_tabular_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2btools:3.0.7--py311h39195ad_3
