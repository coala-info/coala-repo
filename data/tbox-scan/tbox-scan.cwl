cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbox-scan
label: tbox-scan
doc: "Scan a fasta sequence file for T-boxes and predict specifier & T-box sequence.\n\
  \nTool homepage: https://tbdb.io/"
inputs:
  - id: covariance_model
    type:
      - 'null'
      - int
    doc: "search for T-boxes using different covariance models\n                 \
      \   1: RFAM model (RFAM00230.cm), finds mostly class I transcriptional T-boxes
      (default)\n                    2: Translational Ile (TBDB001.cm), finds mostly
      class II translational T-boxes"
    inputBinding:
      position: 101
      prefix: -m
  - id: infernal_output_file
    type:
      - 'null'
      - string
    doc: save INFERNAL output predictions to .txt file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_fasta_file
    type: File
    doc: input FASTA file
    inputBinding:
      position: 101
      prefix: -f
  - id: log_file
    type:
      - 'null'
      - string
    doc: save a .txt log file of pipeline output
    inputBinding:
      position: 101
      prefix: -l
  - id: score_cutoff
    type:
      - 'null'
      - int
    doc: score cutoff for INFERNAL model predictions
    inputBinding:
      position: 101
      prefix: -c
  - id: silence_console
    type:
      - 'null'
      - boolean
    doc: silence console output
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: save verbose output
    inputBinding:
      position: 101
      prefix: -v
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: save final results in file as .csv (default out.csv)
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: save final results in file as .csv
    outputBinding:
      glob: $(inputs.output_file_path || 'out.csv')
  - id: infernal_output
    type:
      - 'null'
      - File
    doc: INFERNAL output predictions (.txt)
    outputBinding:
      glob: $(inputs.infernal_output_file || 'INFERNAL.txt')
  - id: log_output
    type:
      - 'null'
      - File
    doc: log of pipeline output
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbox-scan:1.0.2--hdfd78af_2
